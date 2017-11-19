waitUntil {player getVariable ["sok",false] && player getVariable ["dd",false] == -1};
_init = time;
_lastZombieSpawn = 0;
_securityBreachs = 0;
_breachAnglesIndex = [];
_securityFactor = 1;
_tooMuchFactor = 1;
_dispersionCount = 0;
_BRPVP_zombieFactorPercentageLast = 0;
_antiZombieStructures = [];
_antiZombieStructure = objNull;
_hasAntiZombie = 0;
_housesNear = 0;
_BRPVP_drawLine3D = [];
_directions = 6;
_maxBreachsNoRotate = 3;
_maxBreachsNoRotateBool = 0;
_angUnit = 360/_directions;
_angUnitHalf = _angUnit/2;
_nearZombsCount = 0;

//RED TINT
BRPVP_zombiesRedIntensity = 0.25;
_lastRedFactor = 0;
_initTint = time;
_cc = -1;
_priority = 1501;
while {_cc = ppEffectCreate ["colorCorrections",_priority];_cc < 0} do {_priority = _priority + 1;};
_cc ppEffectEnable true;

waitUntil {
	_time = time;
	_deltaTime = _time - _init;
	if (_deltaTime > 0.5) then {
		_init = _time;
		if (_time - _lastZombieSpawn > BRPVP_zombieCoolDown && player getVariable ["sok",false] && !BRPVP_safeZone && !BRPVP_construindo) then {
			if (_dispersionCount == 0) then {
				_pos = getPosWorld player;
				_result = lineIntersectsSurfaces [_pos,_pos vectorAdd [0,0,50],player,objNull,false,1,"GEOM","FIRE"];
				if (count _result > 0 && {(_result select 0 select 3) isKindOf "House"}) then {
					_result = lineIntersectsSurfaces [_pos,_pos vectorAdd [0,0,-10],player,objNull,true,1,"GEOM","FIRE"];
					if (count _result > 0 && {(_result select 0 select 3) isKindOf "House"}) then {
						if (_result select 0 select 3 != BRPVP_playerBuilding) then {player setVariable ["bui",BRPVP_playerBuilding,true];};
						BRPVP_playerBuilding = _result select 0 select 3;
					} else {
						if (!isNull BRPVP_playerBuilding) then {player setVariable ["bui",objNull,true];};
						BRPVP_playerBuilding = objNull;
					};
				} else {
					if (!isNull BRPVP_playerBuilding) then {player setVariable ["bui",objNull,true];};
					BRPVP_playerBuilding = objNull;
				};
				_housesNearObjs = player nearObjects ["House",45];
				_housesNearObjs = _housesNearObjs apply {
					_isBigHouse = !(_x isKindOf "House_Small_F" || _x isKindOf "PowerLines_Wires_base_F" || _x isKindOf "PowerLines_base_F");
					_typeOf = typeOf _x;
					_haveDoors = (if (isNumber (configFile >> "CfgVehicles" >> _typeOf >> "numberOfDoors")) then {getNumber (configFile >> "CfgVehicles" >> _typeOf >> "numberOfDoors")} else {0}) > 0;
					if (_isBigHouse || _haveDoors) then {_x} else {objNull};
				};
				_housesNearObjs = _housesNearObjs - [objNull];
				_housesNear = count _housesNearObjs;
			};
			if (_dispersionCount == 1) then {
				_antiZombieStructures = nearestObjects [player,BRP_kitReligious,100];
				_minDistanceToAntiZombie = 3600;
				_hasAntiZombie = {
					if (_x getVariable ["id_bd",-1] != -1 || _x getVariable ["azs",false]) then {
						_distance = player distanceSqr _x;
						if (_distance < _minDistanceToAntiZombie) then {_antiZombieStructure = _x;};
						true
					} else {
						false
					};
				} count _antiZombieStructures;
			};
			if (_dispersionCount == 2) then {
				_nearMansArray = player nearObjects ["CaManBase",100];
				_nearPlayersCount = {isPlayer _x && {alive _x}} count _nearMansArray;
				_nearZombsCount = {!(_x getVariable ["ifz",[]] isEqualTo [])} count _nearMansArray;
				_maxZombies = (BRPVP_zombieMaxLocalPerPlayer * _nearPlayersCount) min BRPVP_zombieMaxLocal;
				_tooMuchFactor = if (_nearZombsCount > _maxZombies) then {-0.25} else {1};
			};
			if (_housesNear > 0) then {
				_stance = stance player;
				_speedFactor = if (speed player > 0) then {0.8} else {1};
				_zAxisFactor = 1 - (((ASLToAGL getPosASL player) select 2) min 5)/5;
				_zeroFactor = if (player getVariable ["dd",-1] > -1) then {-0.03} else {1};
				_antiZombieFactor = if (_hasAntiZombie > 0) then {(player distanceSqr _antiZombieStructure)/3600 -1.15} else {1};
				_proneFactor = if (_stance == "CROUCH") then {0.5} else {1};
				_proneFactor = _proneFactor min (if (_stance == "PRONE") then {-0.15} else {1});
				_eyePos = (eyePos player) vectorAdd [0,0,if (_stance != "PRONE") then {-0.15} else {0}];
				_BRPVP_drawLine3D = [];
				_securityBreachs = 0;
				_motorized = vehicle player;
				if (_motorized == player) then {
					for "_d" from 0 to (_directions - 1) do {
						_angle = _maxBreachsNoRotateBool * _angUnitHalf + _d * _angUnit;
						_destine = [_eyePos,5,_angle] call BIS_fnc_relPos;
						_result = lineIntersectsSurfaces [_eyePos,_destine,player,objNull,false,1,"FIRE","VIEW"];
						if (count _result == 0) then {
							if (isNull BRPVP_playerBuilding || {!([ASLToAGL _destine,BRPVP_playerBuilding] call PDTH_pointIsInBox)}) then {
								_securityBreachs = _securityBreachs + 1;
								_BRPVP_drawLine3D pushBack [ASLToAGL _eyePos,ASLToAGL _destine,[1,0,0,1]];
							} else {
								_destine = [_eyePos,20,_angle] call BIS_fnc_relPos;
								_result = lineIntersectsSurfaces [_eyePos,_destine,player,objNull,false,1,"FIRE","VIEW"];
								if (count _result == 0) then {
									if !([ASLToAGL _destine,BRPVP_playerBuilding] call PDTH_pointIsInBox) then {
										_securityBreachs = _securityBreachs + 1;
										_BRPVP_drawLine3D pushBack [ASLToAGL _eyePos,ASLToAGL _destine,[1,0,0,1]];
									} else {
										_BRPVP_drawLine3D pushBack [ASLToAGL _eyePos,ASLToAGL _destine,[1,1,0,1]];
									};
								} else {
									if (_result select 0 select 2 == BRPVP_playerBuilding) then {
										_BRPVP_drawLine3D pushBack [ASLToAGL _eyePos,ASLToAGL _destine,[1,1,0,1]];
									} else {
										if !([ASLToAGL (_result select 0 select 0),BRPVP_playerBuilding] call PDTH_pointIsInBox) then {
											_securityBreachs = _securityBreachs + 1;
											_BRPVP_drawLine3D pushBack [ASLToAGL _eyePos,ASLToAGL _destine,[1,0,0,1]];
										} else {
											_BRPVP_drawLine3D pushBack [ASLToAGL _eyePos,ASLToAGL _destine,[1,1,0,1]];
										};
									};
								};
							};
						} else {
							_BRPVP_drawLine3D pushBack [ASLToAGL _eyePos,ASLToAGL _destine,[1,1,0,1]];
						};
					};
				} else {
					_securityBreachs = if (isEngineOn _motorized) then {3.5} else {1.5};
				};
				BRPVP_drawLine3D = + _BRPVP_drawLine3D;
				_securityFactor = (_securityBreachs/6 - 0.5) * 2;
				if (_securityBreachs > _maxBreachsNoRotate) then {_maxBreachsNoRotateBool = 1 - _maxBreachsNoRotateBool};
				_factor = _speedFactor min _securityFactor min _zeroFactor min _antiZombieFactor min _zAxisFactor min _tooMuchFactor min _proneFactor;
				if (_factor < 0) then {_factor = _factor * 1.2;};
				BRPVP_zombieFactor = ((BRPVP_zombieFactor + _deltaTime * _factor) max 0) min BRPVP_zombieFactorLimit;
				if (BRPVP_zombieFactor >= BRPVP_zombieFactorLimit) then {
					private ["_ps1"];
					_lastZombieSpawn = time;
					_result = BRPVP_zombieSpawnTemplate call LOL_fnc_selectRandomIdx;
					_spawnTemplate = _result select 0;
					_spawnTemplateIndex = _result select 1;
					_spawnBuildings = call BRPVP_spawnZombieCalcHouses;
					_dist = 60 + random 40;
					_posSpawn = [player,_dist,random 360] call BIS_fnc_relPos;
					playSound "zombie_spawn";
					_needDustCloud = count _spawnBuildings < _spawnTemplate select 0;
					if (_needDustCloud) then {
						_smoke = _spawnTemplate select 1;
						_ps1 = "#particlesource" createVehicle _posSpawn;
						_ps1 setParticleClass _smoke;
					};
					sleep (_spawnTemplate select 3);
					BRPVP_spawnZombiesServerFromClient = [_posSpawn,_spawnTemplateIndex,_spawnBuildings,player];
					if (isServer) then {
						["",BRPVP_spawnZombiesServerFromClient] call BRPVP_spawnZombiesServerFromClientFnc;
					} else {
						publicVariableServer "BRPVP_spawnZombiesServerFromClient";
					};
					if (_needDustCloud) then {
						{deleteVehicle _x;} forEach (_ps1 nearObjects 0);
						deleteVehicle _ps1;
					};	
					sleep 2;
				};
			} else {
				BRPVP_zombieFactor = (BRPVP_zombieFactor - _deltaTime * 0.5) max 0;
			};
		} else {
			BRPVP_zombieFactor = (BRPVP_zombieFactor - _deltaTime * 0.5) max 0;
		};
		BRPVP_zombieFactorPercentage = (round((100*BRPVP_zombieFactor/BRPVP_zombieFactorLimit)/10))*10;
		if (BRPVP_vePlayers) then {
			if (BRPVP_zombieFactorPercentage > _BRPVP_zombieFactorPercentageLast) then {
				playSound "zombie_plus";
				[format["ZOMBIES: %1%2",BRPVP_zombieFactorPercentage,"%"],-2] call BRPVP_hint;
				//call BRPVP_atualizaDebug;
			};
			if (BRPVP_zombieFactorPercentage < _BRPVP_zombieFactorPercentageLast) then {
				playSound "zombie_minus";
				[format["ZOMBIES: %1%2",BRPVP_zombieFactorPercentage,"%"],-2] call BRPVP_hint;
				//call BRPVP_atualizaDebug;
			};
		};
		_BRPVP_zombieFactorPercentageLast = BRPVP_zombieFactorPercentage;

		//RED TINT
		if (_dispersionCount == 2) then {
			_redFactor = (BRPVP_zombiesRedIntensity * _nearZombsCount/BRPVP_zombieMaxLocal) min BRPVP_zombiesRedIntensity;
			if (_redFactor != _lastRedFactor) then {
				_parameters = [1,1+_redFactor,-_redFactor/3,0,0,0,0,1,0.1,0,1-_redFactor*1.5,0.299,0.587,0.114,0];
				_cc ppEffectAdjust _parameters;
				_cc ppEffectCommit 1.25;
				_lastRedFactor = _redFactor;
			};
			_dispersionCount = 0;
		} else {
			_dispersionCount = _dispersionCount + 1;
		};
	};
	false
};