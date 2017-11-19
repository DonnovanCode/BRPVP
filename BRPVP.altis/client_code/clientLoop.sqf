diag_log "[BRPVP FILE] loops.sqf INITIATED";

//DEFINE ARRAY DE POSICOES OTIMIZADO
_posicoesA = BRPVP_locaisDeCura + BRPVP_locaisImportantes + BRPVP_mercadoresPos + BRPVP_buyersPos + BRPVP_vehicleTradersPos + BRPVP_travelingAidPlaces;
BRPVP_safeZonesOtherMethod = BRPVP_mercadoresPos + BRPVP_buyersPos + BRPVP_vehicleTradersPos + BRPVP_travelingAidPlaces;
BRPVP_checksDePos = [];
{
	_maisPerto = [_x select 0,_posicoesA] call BRPVP_funcaoMinDist;
	_posMaisPerto = _posicoesA select _maisPerto select 0;
	_raioMaisPerto = _posicoesA select _maisPerto select 1;
	_dist = ((_x select 0) distance _posMaisPerto) - _raioMaisPerto;
	_overlap = _dist < (_x select 1);
	BRPVP_checksDePos pushBack (_x + [_posMaisPerto,_raioMaisPerto,_dist,_overlap]);
} forEach _posicoesA;

//DEFINE CODIGOS QUE RODAM AO ENTRAR E SAIR DE LOCAIS
BRPVP_inBuyersPlace = 0;
BRPVP_safezoneSafeLeave30 = -1;
BRPVP_safezoneSafeLeave45 = -1;
BRPVP_safezoneFixAssignedVehicle = -1;
BRPVP_safezoneRefuelAssignedVehicle = -1;
BRPVP_codigoLocais = [
	[
		{0 spawn BRPVP_curaPlayer;},
		{}
	],
	[
		{BRPVP_intoTheCity = true;},
		{BRPVP_intoTheCity = false;}
	],
	[
		{
			BRPVP_safeZone = true;
			true call BRPVP_ligaModoSeguro;
			if (BRPVP_safezoneSafeLeave30 == -1) then {
				BRPVP_safezoneSafeLeave30 = player addAction ["<t color='#0022CC'>"+localize "str_szone_safe_leave_30"+"</t>",{player setVelocity ((AGLtoASL ([player,0.65*50,getDir player] call BIS_fnc_relPos) vectorDiff getPosASL player) vectorAdd [0,0,0.65*30]);sleep 1;waitUntil {position player select 2 < 2.5};player setVelocity [0,0,0];},objNull,1.49,false,true,"","position player select 2 < 0.15 && player isEqualTo vehicle player"];
				BRPVP_safezoneSafeLeave45 = player addAction ["<t color='#0022CC'>"+localize "str_szone_safe_leave_45"+"</t>",{player setVelocity ((AGLtoASL ([player,0.65*40,getDir player] call BIS_fnc_relPos) vectorDiff getPosASL player) vectorAdd [0,0,0.65*40]);sleep 1;waitUntil {position player select 2 < 2.5};player setVelocity [0,0,0];},objNull,1.49,false,true,"","position player select 2 < 0.15 && player isEqualTo vehicle player"];
			};
			_antenna = + _this;
			_antenna set [2,35];
			[800,0.025,2.5,_antenna] call BRPVP_radarAdd;
			[localize "str_radar_local",3.5,12] call BRPVP_hint;
		},
		{
			true call BRPVP_desligaModoSeguro;
			BRPVP_safeZone = false;
			player removeAction BRPVP_safezoneSafeLeave30;
			player removeAction BRPVP_safezoneSafeLeave45;
			BRPVP_safezoneSafeLeave30 = -1;
			BRPVP_safezoneSafeLeave45 = -1;
			_antenna = + _this;
			_antenna set [2,35];
			[800,0.025,2.5,_antenna] call BRPVP_radarRemove;
		}
	],
	[
		{
			BRPVP_safeZone = true;
			true call BRPVP_ligaModoSeguro;
			if (BRPVP_safezoneSafeLeave30 == -1) then {
				BRPVP_safezoneSafeLeave30 = player addAction ["<t color='#0022CC'>"+localize "str_szone_safe_leave_30"+"</t>",{player setVelocity ((AGLtoASL ([player,0.65*50,getDir player] call BIS_fnc_relPos) vectorDiff getPosASL player) vectorAdd [0,0,0.65*30]);sleep 1;waitUntil {position player select 2 < 2.5};player setVelocity [0,0,0];},objNull,1.49,false,true,"","position player select 2 < 0.15 && player isEqualTo vehicle player"];
				BRPVP_safezoneSafeLeave45 = player addAction ["<t color='#0022CC'>"+localize "str_szone_safe_leave_45"+"</t>",{player setVelocity ((AGLtoASL ([player,0.65*40,getDir player] call BIS_fnc_relPos) vectorDiff getPosASL player) vectorAdd [0,0,0.65*40]);sleep 1;waitUntil {position player select 2 < 2.5};player setVelocity [0,0,0];},objNull,1.49,false,true,"","position player select 2 < 0.15 && player isEqualTo vehicle player"];
			};
			BRPVP_inBuyersPlace = BRPVP_inBuyersPlace + 1;
			BRPVP_inBuyersPlace spawn BRPVP_buyersPlace;
			_antenna = + _this;
			_antenna set [2,50];
			[1000,0.025,2.5,_antenna] call BRPVP_radarAdd;
			[localize "str_radar_local",3.5,12] call BRPVP_hint;
		},
		{
			true call BRPVP_desligaModoSeguro;
			BRPVP_safeZone = false;
			player removeAction BRPVP_safezoneSafeLeave30;
			player removeAction BRPVP_safezoneSafeLeave45;
			BRPVP_safezoneSafeLeave30 = -1;
			BRPVP_safezoneSafeLeave45 = -1;
			BRPVP_inBuyersPlace = BRPVP_inBuyersPlace + 1;
			_antenna = + _this;
			_antenna set [2,50];
			[1000,0.025,2.5,_antenna] call BRPVP_radarRemove;
		}
	],
	[
		{
			BRPVP_safeZone = true;
			false call BRPVP_ligaModoSeguro;
			if (BRPVP_safezoneSafeLeave30 == -1) then {
				BRPVP_safezoneSafeLeave30 = player addAction ["<t color='#0022CC'>"+localize "str_szone_safe_leave_30"+"</t>",{player setVelocity ((AGLtoASL ([player,0.65*50,getDir player] call BIS_fnc_relPos) vectorDiff getPosASL player) vectorAdd [0,0,0.65*30]);sleep 1;waitUntil {position player select 2 < 2.5};player setVelocity [0,0,0];},objNull,1.49,false,true,"","position player select 2 < 0.15 && player isEqualTo vehicle player"];
				BRPVP_safezoneSafeLeave45 = player addAction ["<t color='#0022CC'>"+localize "str_szone_safe_leave_45"+"</t>",{player setVelocity ((AGLtoASL ([player,0.65*40,getDir player] call BIS_fnc_relPos) vectorDiff getPosASL player) vectorAdd [0,0,0.65*40]);sleep 1;waitUntil {position player select 2 < 2.5};player setVelocity [0,0,0];},objNull,1.49,false,true,"","position player select 2 < 0.15 && player isEqualTo vehicle player"];
			};
			BRPVP_safezoneFixAssignedVehicle = player addAction ["<t color='#3398DC'>"+localize "str_aid_fix_veh"+"</t>",{assignedVehicle player setDamage 0;playSound "granted";assignedVehicle player setVelocity [0,0,4];sleep (0.6 + random 0.4);player say3D ["woohoo",200,0.8 + random 0.4];},objNull,1.49,false,true,"","!isNull assignedVehicle player && {(assignedVehicleRole player) select 0 == 'Driver' && {damage assignedVehicle player > 0.01 && alive assignedVehicle player && count (assignedVehicle player nearObjects['Land_FuelStation_02_workshop_F',25]) > 0 && count (player nearObjects['Land_FuelStation_02_workshop_F',6.5]) > 0}}"];
			BRPVP_safezoneRefuelAssignedVehicle = player addAction ["<t color='#3398DC'>"+localize "str_aid_refuel_veh"+"</t>",{assignedVehicle player setFuel 1;playSound "granted";assignedVehicle player setVelocity [0,0,4];sleep (0.6 + random 0.4);player say3D ["woohoo",200,0.8 + random 0.4];},objNull,1.49,false,true,"","!isNull assignedVehicle player && {(assignedVehicleRole player) select 0 == 'Driver' && {fuel assignedVehicle player < 0.99 && alive assignedVehicle player && count (assignedVehicle player nearObjects['Land_Tank_rust_F',25]) > 0 && count (player nearObjects['Land_Tank_rust_F',6.5]) > 0}}"];
			//player addAction ["<t color='#997755'>UNFIX..</t>",{assignedVehicle player setDamage 0.5;},objNull,1.49,false,true,""];
			//player addAction ["<t color='#887755'>UNREFUEL..</t>",{assignedVehicle player setFuel 0.5;},objNull,1.49,false,true,""];
			[localize "str_aid_in",-6] call BRPVP_hint;
		},
		{
			false call BRPVP_desligaModoSeguro;
			BRPVP_safeZone = false;
			player removeAction BRPVP_safezoneSafeLeave30;
			player removeAction BRPVP_safezoneSafeLeave45;
			BRPVP_safezoneSafeLeave30 = -1;
			BRPVP_safezoneSafeLeave45 = -1;
			player removeAction BRPVP_safezoneFixAssignedVehicle;
			player removeAction BRPVP_safezoneRefuelAssignedVehicle;
			[localize "str_aid_out",-6] call BRPVP_hint;
		}
	]
];

//COLOCA ICONES DOS LOCAIS NO MAPA
{
	_pos = _x select 0;
	_raio = _x select 1;
	_nome = _x select 2;
	_tipo = _x select 3;
	if (({_pos distance (_x select 0) < 5} count BRPVP_respawnPlaces) == 0) then {
		_marca = createMarkerLocal ["LOCAIS_" + str _forEachIndex,_pos];
		_marca setMarkerShapeLocal "ELLIPSE";
		_marca setMarkerSizeLocal [_raio,_raio];
		_marca setMarkerColorLocal (["ColorGreen","ColorWhite","ColorYellow","ColorYellow","ColorPink"] select _tipo);
		_marca setMarkerAlphaLocal 0.5;
	};
} forEach BRPVP_checksDePos;
{
	_pos = _x select 0;
	_raio = _x select 1;
	_marca = createMarkerLocal ["LOCAIS_RESPAWN_" + str _forEachIndex,_pos];
	_marca setMarkerShapeLocal "ELLIPSE";
	_marca setMarkerSizeLocal [_raio,_raio];
	_marca setMarkerColorLocal "ColorOrange";
	_marca setMarkerAlphaLocal 0.5;
} forEach BRPVP_respawnPlaces;
{
	_x params ["_center","_radius","_name","_codeIndex"];
	_marca = createMarkerLocal ["DOT_AID_AREA_" + str _forEachIndex,_center];
	_marca setMarkerShapeLocal "Icon";
	_marca setMarkerTypeLocal "mil_dot";
	_marca setMarkerColorLocal "ColorOrange";
	_marca setMarkerTextLocal ((localize "str_aid_title") + " " + _name);
} forEach BRPVP_travelingAidPlaces;

//MONITORA ENTRADA E SAIDA DOS LOCAIS
BRPVP_dentroDeMudou = 0;
[] spawn {
	waitUntil {player getVariable ["sok",false]};
	waitUntil {
		_vehiclePlayer = vehicle player;
		_pos = ASLToAGL getPosASL _vehiclePlayer;
		_maisPerto = [_pos,BRPVP_checksDePos] call BRPVP_funcaoMinDist;
		_centro = BRPVP_checksDePos select _maisPerto select 0;
		_raio = BRPVP_checksDePos select _maisPerto select 1;
		_nome = BRPVP_checksDePos select _maisPerto select 2;
		_overlap = BRPVP_checksDePos select _maisPerto select 7;
		_inSafe = BRPVP_safeZone || {{_vehiclePlayer distance (_x select 0) <= (_x select 1)} count BRPVP_safeZonesOtherMethod > 0};
		_inside = _pos distance _centro <= _raio;
		_canEnter = !(_inSafe && {_x getVariable ["cmb",false]} count crew _vehiclePlayer > 0);
		if (_inside && _canEnter) then {
			_centro call (BRPVP_codigoLocais select (BRPVP_checksDePos select _maisPerto select 3) select 0);
			if (!_overlap) then {
				_check1 = _raio^2;
				if (_inSafe) then {
					waitUntil {vehicle player distanceSqr _centro > _check1 || {_x getVariable ["cmb",false]} count crew vehicle player > 0};
				} else {
					waitUntil {vehicle player distanceSqr _centro > _check1};
				};
				_centro call (BRPVP_codigoLocais select (BRPVP_checksDePos select _maisPerto select 3) select 1);
			} else {
				BRPVP_dentroDe set [count BRPVP_dentroDe,_maisPerto];
			};
		} else {
			if (_inside && !_canEnter) then {
				if (BRPVP_safeZone) then {
					if (player getVariable ["cmb",false] && !(vehicle player isEqualTo player)) then {moveOut player;};
				} else {
					_isElegibleToCancelEnter = false;
					{
						if (_x getVariable ["cmb",false] && isPlayer _x) exitWith {
							_isElegibleToCancelEnter = _x isEqualTo player;
						};
					} forEach crew _vehiclePlayer > 0;
					if (_isElegibleToCancelEnter) then {
						_velocity = velocity _vehiclePlayer;
						if (vectorMagnitude _velocity < 0.1 || {acos ((_pos vectorDiff _centro) vectorCos _velocity) > 90}) then {
							[format [localize "str_szone_cant_enter",round (BRPVP_ultimoCombateTempo + BRPVP_combatTimeLength - time)],-6] call BRPVP_hint;
							_vehiclePlayer setPosworld getPosWorld _vehiclePlayer;
							if (local _vehiclePlayer) then {
								_vehiclePlayer setVelocity ((vectorNormalized (_pos vectorDiff _centro) vectorMultiply 10) vectorAdd [0,0,5]);
							} else {
								[_vehiclePlayer,(vectorNormalized (_pos vectorDiff _centro) vectorMultiply 10) vectorAdd [0,0,5]] remoteExec ["setVelocity",_vehiclePlayer,false];
							};
							[player,["shazam",100]] remoteExec ["say3D",-2,false];
						};
					} else {
						[localize "str_szone_cant_enter_agreged",-6] call BRPVP_hint;
					};
				};
			} else {
				_centroMaisPerto = BRPVP_checksDePos select _maisPerto select 4;
				_raioMaisPerto = BRPVP_checksDePos select _maisPerto select 5;
				_distMax = BRPVP_checksDePos select _maisPerto select 6;
				_dist = _pos distance _centro;
				if (_dist > _raio && _dist < _distMax) then {
					_check1 = _raio^2;
					_check2 = _distMax^2;
					waitUntil {_dist = vehicle player distanceSqr _centro;_dist <= _check1 || _dist >= _check2};
				} else {
					_distMax = _dist - _raio;
					_check1 = _distMax^2;
					waitUntil {vehicle player distanceSqr _pos >= _check1 || BRPVP_dentroDeMudou > 0};
					BRPVP_dentroDeMudou = (BRPVP_dentroDeMudou - 1) max 0;
				};
			};
		};
		false
	};
};

//MONITOR CENTRAL
[] spawn {
	private ["_agora","_tempo60","_tempo10","_tempo1","_saiu","_temSaiu","_safePos"];
	BRPVP_fpsRecord = diag_fps;
	BRPVP_surrended = objNull;
	BRPVP_surrendedWeaponHolder = objNull;
	BRPVP_actionRunning = [];
	BRPVP_actionRadarCut = -1;
	_actionOnScreen = false;
	_inicioMNY = time;
	_inicio60 = time;
	_inicio10 = time;
	_inicio1 = time;
	_hAntes = 0;
	_bin1 = true;
	_bin2 = true;
	_cycleMNY = 0;
	
	//RAPEL DE ENCOSTAS VARS E FUNCS
	_safePos = [0,0,0];
	BRPVP_rapelRapelling = false;
	BRPVP_rapelRope = objNull;
	BRPVP_rapelStopRapel = {
		ropeDestroy BRPVP_rapelRope;
		deleteVehicle BRPVP_svCriaVehRetorno;
		(findDisplay 46) displayRemoveEventHandler ["KeyUp",BRPVP_rapelKeyUpEH];
		BRPVP_rapelRapelling = false;
	};
	BRPVP_rapelRopeUnwind = {
		if (!isNull (_this select 0)) then {
			ropeUnwind _this;
			BRPVP_rapelRopeUnwindPV = _this;
			publicVariable "BRPVP_rapelRopeUnwindPV";
		};
	};
	BRPVP_svCriaVeh = {
		BRPVP_svCriaVehEnvio = _this;
		if (isServer) then {["",BRPVP_svCriaVehEnvio] call BRPVP_svCriaVehEnvioFnc;} else {publicVariableServer "BRPVP_svCriaVehEnvio";};
	};
	BRPVP_rapelOnDanger = {
		params ["_pP","_rapelHSafe"];
		_h = _pP select 2;
		if (_h > _rapelHSafe) then {[true]} else {[false,_h]};
	};

	//MINITORA EVENTOS
	_noCrosshairDetection = BRP_kitHelipad + BRP_kitCamuflagem + [BRPVP_playerModel,"Land_JumpTarget_F","I_HMG_01_high_F","I_HMG_01_F","I_GMG_01_high_F","I_GMG_01_F","I_static_AT_F","I_static_AA_F","Land_Suitcase_F","Land_Razorwire_F"];
	_allActionsVars = ["brpvp_act_0","brpvp_act_1","brpvp_act_2_1","brpvp_act_2_2","brpvp_act_3_1","brpvp_act_3_2","brpvp_act_3_3",/*"brpvp_act_4_1","brpvp_act_4_2",*/"brpvp_act_5_1","brpvp_act_5_2","brpvp_act_5_3","brpvp_act_5_4","brpvp_act_6","brpvp_act_7","brpvp_act_8","brpvp_act_9","brpvp_act_10","brpvp_act_11","brpvp_act_12","brpvp_act_13","brpvp_act_14","brpvp_act_15","brpvp_act_16","brpvp_act_17","brpvp_act_18","brpvp_act_19","brpvp_act_20","brpvp_act_21","brpvp_act_22_1","brpvp_act_22_2"];
	_objsLast = [];
	_objsActionsCheckNullA = [];
	_objsActionsCheckNullB = [];
	waitUntil {
		//VARIAVEIS DE EVENTOS
		_agora = time;
		_tempoMNY = _agora - _inicioMNY > BRPVP_stayOnlineMoneyRewardInterval;
		_tempo60 = _agora - _inicio60 > 60;
		_tempo10 = _agora - _inicio10 > 10;
		_tempo1 = _agora - _inicio1 > 1;
		_saiu = [];
		_temSaiu = false;
		{
			if (vehicle player distance (BRPVP_checksDePos select _x select 0) > (BRPVP_checksDePos select _x select 1)) then {
				_saiu pushBack _x;
				_temSaiu = true;
			};
		} count BRPVP_dentroDe;
	
		//RENOVA TRIGGERS DE TEMPO
		if (_tempo1) then {
			_inicio1 = _agora;
			if (BRPVP_countSecs == 2520) then {
				BRPVP_countSecs = 0;
			} else {
				BRPVP_countSecs = BRPVP_countSecs + 1;
			};
			BRPVP_fpsRecord = (BRPVP_fpsRecord + diag_fps * 9)/10;
		};
		if (_tempo10) then {_inicio10 = _agora;};
		if (_tempo60) then {_inicio60 = _agora;};
		if (_tempoMNY) then {
			_inicioMNY = _agora;
			if (player getVariable "sok") then {
				_cycleMNY = _cycleMNY + 1;
				if (_cycleMNY == BRPVP_stayOnlineMoneyRewardExtraCycle) then {
					_cycleMNY = 0;
					player setVariable ["mny",(player getVariable "mny") + BRPVP_stayOnlineMoneyRewardExtraValor,true];
					[format [localize "str_fidelity_prize2",BRPVP_stayOnlineMoneyRewardExtraValor],0] call BRPVP_hint;
					playSound "granted";
				} else {
					player setVariable ["mny",(player getVariable "mny") + BRPVP_stayOnlineMoneyRewardValor,true];
					[format [localize "str_fidelity_prize1",BRPVP_stayOnlineMoneyRewardValor],0] call BRPVP_hint;
					playSound "negocio";
				};
				call BRPVP_atualizaDebug;
			};
		};

		//PLAYER SAIU DE ALGUMA AREA IMPORTANTE (AREAS IMPORTANTES PODEM TER INTERSECAO)
		if (_temSaiu) then {
			{(BRPVP_checksDePos select _x select 0) call (BRPVP_codigoLocais select (BRPVP_checksDePos select _x select 3) select 1);} forEach _saiu;
			BRPVP_dentroDe = BRPVP_dentroDe - _saiu;
			BRPVP_dentroDeMudou = BRPVP_dentroDeMudou + 1;
		};
		
		//PLAYER DAMAGED
		if (BRPVP_playerDamaged) then {
			call BRPVP_atualizaDebug;
			BRPVP_playerDamaged = false;
		};
		
		//UPDATE MENU TO AVOID IT DISSAPEARS
		if (_tempo10) then {
			if ((BRPVP_menuExtraLigado && !BRPVP_menuCustomKeysOff) || BRPVP_construindo) then {
				call BRPVP_atualizaDebugMenu;
			};
			player setVariable ["brpvp_fps",BRPVP_fpsRecord,true];
		};
		
		//CONHECIDO FN_SELFACTIONS
		if (!_bin1 && !_bin2) then {
			_objs = [];
			if (!BRPVP_construindo && alive player) then {
				_veh = vehicle player;
				if (_veh isEqualTo player) then {
					_objs = nearestObjects [player,_noCrosshairDetection,4,false];
					_objs deleteAt 0; //DELETE PLAYER OBJ BECAUSE PLAYER MODEL CLASS IS IN _noCrosshairDetection
					_vec = (getCameraViewDirection player) vectorMultiply 6;
					_posCam = AGLToASL (positionCameraToWorld [0,0,0]);
					_lis = lineIntersectsSurfaces [_posCam,_posCam vectorAdd _vec,player,objNull,true,3,"VIEW","FIRE"];
					{
						_typeOf = typeOf (_x select 2);
						if (_typeOf != "") exitWith {if !(_typeOf in _noCrosshairDetection) then {_objs pushBackUnique (_x select 2);};};
					} forEach _lis;
				} else {
					_objs pushBack _veh;
				};
			};
			//REMOVE ACTIONS FROM OBJECTS THAT BECAME NULL
			_remove = [];
			{
				if (isNull _x) then {
					{
						player removeAction _x;
					} forEach (_objsActionsCheckNullB select _forEachIndex);
					_remove pushBack _forEachIndex;
				};
			} forEach _objsActionsCheckNullA;
			_remove sort true;
			{
				_objsActionsCheckNullA deleteAt _x;
				_objsActionsCheckNullB deleteAt _x;
			} forEach _remove;
			//ADD AND REMOVE INTERACTIONS ON CURRENT OBJECTS
			if !(BRPVP_motorizedToLockUnlock in _objs) then {BRPVP_motorizedToLockUnlock = objNull;};
			{
				_object = _x;
				if (!isNull _object) then {
					_objectTypeOf = typeOf _object;
					_objectDisplayName = getText (configFile >> "CfgVehicles" >> _objectTypeOf >> "displayName");
					_bdc = _object getVariable ["bdc",false];
					_objectHaveAccess = _object call BRPVP_checaAcesso;
					_objectDistance = _object distance player;
					_inVeh = player != vehicle player;
					_isMan = _object isKindOf "CAManBase";
					_isWest = _object getVariable ["brpvp_loot_protected",false];
					_objectIsMotorized = _object call BRPVP_isMotorized;
					_objectIsStaticWeapon = _object isKindOf "StaticWeapon";
					_objectIsMotorizedNotStatic = _objectIsMotorized && !_objectIsStaticWeapon;
					_isMine = _object in BRPVP_myStuff;
					_isAlive = alive _object;
					_isDb = _object getVariable ["id_bd",-1] != -1;
					_checkIfNull = false;
					
					//VENDEDORES ITENS
					_actionVar = "brpvp_act_0";
					_actionId = _object getVariable [_actionVar,-1];
					_mcdrId = _object getVariable ["mcdr",-1];
					if (_mcdrId >= 0 && {!(0 in BRPVP_actionRunning)}) then {
						BRPVP_itemTraderDiscount = _object getVariable ["brpvp_price_level",1];
						_itemFilter = _object getVariable ["brpvp_item_filter",0];
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction [localize "str_adda_merchant","client_code\actions\actionTrader.sqf",[_object,_mcdrId,1,_itemFilter]],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//VENDEDORES VEICULOS
					_actionVar = "brpvp_act_1";
					_actionId = _object getVariable [_actionVar,-1];
					_vndv = _object getVariable ["vndv",[]];
					if (count _vndv > 0 && {!(1 in BRPVP_actionRunning)}) then {
						if (_actionId isEqualTo -1) then {
							_deployType = _object getVariable ["vndv_deployType","default"];
							_object setVariable [_actionVar,player addAction [localize "str_adda_call_sub","client_code\actions\actionVehicleTrader.sqf",[_object,_vndv,1,_deployType]],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//REVIVE OR SUFOCATE PLAYER
					_actionId_1 = _object getVariable ["brpvp_act_2_1",-1];
					_actionId_2 = _object getVariable ["brpvp_act_2_2",-1];
					if (_object getVariable ["dd",-1] == 0 && {vehicle _object == _object && !(2 in BRPVP_actionRunning)}) then {
						if (_actionId_1 isEqualTo -1) then {
							_object setVariable ["brpvp_act_2_1",player addAction ["<t color='#00BB00'>"+format [localize "str_adda_revive",_object getVariable ["nm","this player"]]+"</t>","client_code\actions\actionRevive.sqf",_object],false];
							_object setVariable ["brpvp_act_2_2",player addAction ["<t color='#BB0000'>"+format [localize "str_adda_kill",_object getVariable ["nm","this player"]]+"</t>","client_code\actions\actionFinalize.sqf",_object],false];
						};
					} else {
						if !(_actionId_1 isEqualTo -1) then {
							player removeAction _actionId_1;
							player removeAction _actionId_2;
							_object setVariable ["brpvp_act_2_1",-1,false];
							_object setVariable ["brpvp_act_2_2",-1,false];
						};
					};
					//USE CRANE ON VEHICLE
					_actionId_1 = _object getVariable ["brpvp_act_3_1",-1];
					_actionId_2 = _object getVariable ["brpvp_act_3_2",-1];
					_actionId_3 = _object getVariable ["brpvp_act_3_3",-1];
					if (_objectIsMotorized && _isAlive && !(3 in BRPVP_actionRunning)) then {
						if (_actionId_1 isEqualTo -1) then {
							_vu = vectorUp _object;
							_angA = acos (_vu vectorCos [0,0,1]);
							_angB = acos (_vu vectorCos surfaceNormal (getPosATL _object));
							if (_angA > 60 && _angB > 20) then {
								_object setVariable ["brpvp_act_3_1",player addAction [localize "str_adda_crane0","client_code\actions\actionFlipVehicle.sqf",[_object,1.5,1]],false];
								_object setVariable ["brpvp_act_3_2",player addAction [localize "str_adda_crane1","client_code\actions\actionFlipVehicle.sqf",[_object,3,2]],false];
								_object setVariable ["brpvp_act_3_3",player addAction [localize "str_adda_crane2","client_code\actions\actionFlipVehicle.sqf",[_object,8,3]],false];
							};
						};
					} else {
						if !(_actionId_1 isEqualTo -1) then {
							player removeAction _actionId_1;
							player removeAction _actionId_2;
							player removeAction _actionId_3;
							_object setVariable ["brpvp_act_3_1",-1,false];
							_object setVariable ["brpvp_act_3_2",-1,false];
							_object setVariable ["brpvp_act_3_3",-1,false];
						};
					};
					//TRANSFER ITEMS: UNIT TO CARGO, CARGO TO CARGO - FROM
					_fromUnit = !_isAlive && {_isMan && {!isPlayer _object} && !_isWest};
					_fromUnitWest = !_isAlive && {_isMan && {!isPlayer _object} && _isWest};
					_fromHolder = (_object isKindOf "GroundWeaponHolder" || _object isKindOf "WeaponHolderSimulated") && _objectHaveAccess && !_isWest;
					_fromVehicle = (_objectIsMotorizedNotStatic || {_objectTypeOf find "Box_" == 0 || _objectTypeOf find "Land_Box_" == 0}) && _objectHaveAccess && _isAlive;
					_haveFrom = _fromUnit || _fromHolder || _fromVehicle;
					//TRANSFER ITEMS: UNIT TO CARGO, CARGO TO CARGO - RECEPTACLE
					_actionVar = "brpvp_act_5_1";
					_actionId = _object getVariable [_actionVar,-1];
					if (_haveFrom && {!(5 in BRPVP_actionRunning) && !isNull BRPVP_sellReceptacle && _object != BRPVP_sellReceptacle}) then {
						if (_fromHolder) then {_checkIfNull = true;};
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction [("<t color='#FFFF00'>"+localize "str_adda_trans_to_recep"+"</t>"),"client_code\actions\actionTransfer.sqf",[_object,BRPVP_sellReceptacle,_fromUnit],1.49,false],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//TRANSFER ITEMS: UNIT TO CARGO, CARGO TO CARGO - VAULT
					_actionVar = "brpvp_act_5_2";
					_actionId = _object getVariable [_actionVar,-1];
					if (_haveFrom && {!(5 in BRPVP_actionRunning) && !isNull BRPVP_holderVault && _object != BRPVP_holderVault}) then {
						if (_fromHolder) then {_checkIfNull = true;};
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction [("<t color='#FFFF00'>"+localize "str_adda_trans_to_vault"+"</t>"),"client_code\actions\actionTransfer.sqf",[_object,BRPVP_holderVault,_fromUnit],1.48,false],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//TRANSFER ITEMS: UNIT TO CARGO, CARGO TO CARGO - ASSIGNED VEHICLE
					_actionVar = "brpvp_act_5_3";
					_actionId = _object getVariable [_actionVar,-1];
					if (_haveFrom && {!(5 in BRPVP_actionRunning) && !isNull BRPVP_assignedVehicle && alive BRPVP_assignedVehicle && _object != BRPVP_assignedVehicle}) then {
						if (_fromHolder) then {_checkIfNull = true;};
						if (_actionId isEqualTo -1) then {
							_txt = getText (configFile >> "CfgVehicles" >> (typeOf BRPVP_assignedVehicle) >> "displayName");
							_object setVariable [_actionVar,player addAction [("<t color='#FFFF00'>"+format [localize "str_adda_trans_to_obj",_txt]+"</t>"),"client_code\actions\actionTransfer.sqf",[_object,BRPVP_assignedVehicle,_fromUnit],1.47,false],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//TRANSFER ITEMS: UNIT TO CARGO, CARGO TO CARGO - WEAPONHOLDER
					_actionVar = "brpvp_act_5_4";
					_actionId = _object getVariable [_actionVar,-1];
					if (_fromUnitWest && {!(5 in BRPVP_actionRunning)}) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction [("<t color='#FFFF00'>"+localize "str_adda_trans_from_west"+"</t>"),"client_code\actions\actionTransfer.sqf",[_object,objNull,_fromUnitWest],1.46,false],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//GET MONEY FROM BRIEF CASE
					_actionVar = "brpvp_act_6";
					_actionId = _object getVariable [_actionVar,-1];
					_mny = _object getVariable ["mny",0];
					if (_mny > 0 && {_objectTypeOf == "Land_Suitcase_F" || (_isDb && _isMan && _object getVariable ["dd",-1] == 1)}) then {
						_checkIfNull = true;
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction [("<t color='#FFDD00'>"+format [localize "str_adda_get_money",_mny call BRPVP_formatNumber]+"</t>"),"client_code\actions\actionGetMoney.sqf",_object,1.45,true],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//MY STUFF MENU
					_actionVar = "brpvp_act_7";
					_actionId = _object getVariable [_actionVar,-1];
					if (!(7 in BRPVP_actionRunning) && _isAlive && (_isMine || (BRPVP_vePlayers && _isDb && !_isMan))) then {
						_checkIfNull = true;
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#FFCC55'>"+format[localize "str_adda_item_menu",_objectDisplayName]+"</t>","client_code\actions\actionItemMenu.sqf",_object,1.44,false],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//BULLDOZER
					_actionVar = "brpvp_act_8";
					_actionId = _object getVariable [_actionVar,-1];
					if (_bdc && {!(8 in BRPVP_actionRunning)}) then {
						_checkIfNull = true;
						if (_actionId isEqualTo -1) then {
							_price = 100;
							_object setVariable [_actionVar,player addAction ["<t color='#666666'>"+format [localize "str_adda_clean_ruin",_price]+"</t>","client_code\actions\actionBulldozer.sqf",[_price,_object]],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//RADAR SPOTS
					_actionVar = "brpvp_act_9";
					_actionId = _object getVariable [_actionVar,-1];
					_antennaIndex = BRPVP_antennasObjs find _objectTypeOf;
					if (_antennaIndex != -1 && {!(9 in BRPVP_actionRunning)}) then {
						_checkIfNull = true;
						if (_actionId isEqualTo -1) then {
							_force = BRPVP_antennasObjsForce select _antennaIndex;
							_object setVariable [_actionVar,player addAction ["<t color='#4040FF'>"+localize "str_adda_radar_on"+"</t>","client_code\actions\actionRadarSpot.sqf",[_object,_force]],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//DISMANTLE OTHERS RESPAWN
					_actionVar = "brpvp_act_10";
					_actionId = _object getVariable [_actionVar,-1];
					if (_objectTypeOf in (BRP_kitRespawnA + BRP_kitRespawnB) && {!_isMine && _isDb}) then {
						_checkIfNull = true;
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#9050FF'>"+format [localize "str_adda_respawn_destroy",BRPVP_dismantleRespawnPrice]+"</t>","client_code\actions\actionDismantleRespawn.sqf",_object],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//TURN LIGHT OFF
					_actionVar = "brpvp_act_11";
					_actionId = _object getVariable [_actionVar,-1];
					_accessLamp = _objectTypeOf in BRP_kitLamp && _objectHaveAccess;
					if (_accessLamp) then {
						_checkIfNull = true;
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#BBFF00'>"+localize "str_adda_light_on"+"</t>","client_code\actions\actionLightOn.sqf",_object],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//TURN LIGHT OFF
					_actionVar = "brpvp_act_12";
					_actionId = _object getVariable [_actionVar,-1];
					if (_accessLamp) then {
						_checkIfNull = true;
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#AAEE00'>"+localize "str_adda_light_off"+"</t>","client_code\actions\actionLightOff.sqf",_object],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//LAND VEHICLE TOW
					_actionVar = "brpvp_act_13";
					_actionId = _object getVariable [_actionVar,-1];
					if (!_inVeh && _isAlive && _objectHaveAccess && {_object isKindOf "LandVehicle" && !_objectIsStaticWeapon && {!(10 in BRPVP_actionRunning) && isNull (_object getVariable ["towner",objNull])}}) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#FF88FF'>"+format [localize "str_adda_tow_land",BRPVP_towLandVehiclePrice]+"</t>","client_code\actions\actionTowLandVehicle.sqf",_object],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//LAND VEHICLE TOW CANCEL
					_actionVar = "brpvp_act_14";
					_actionId = _object getVariable [_actionVar,-1];
					if (!_inVeh && _isAlive && 10 in BRPVP_actionRunning && {_object == BRPVP_landVehicleOnTow}) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#FF88FF'>"+localize "str_adda_tow_end"+"</t>","client_code\actions\actionTowLandVehicleEnd.sqf",_object],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//SURRENDER A PLAYER
					_actionVar = "brpvp_act_15";
					_actionId = _object getVariable [_actionVar,-1];
					_canSurrender = false;
					if (_objectDistance < 3) then {
						if (isPlayer _object && {_isMan && _object isEqualTo vehicle _object && !(_object isEqualTo player) && _isAlive}) then {
							if (isNull (_object getVariable ["brpvp_surrendedBy",objNull])) then {
								if (isNull (player getVariable ["brpvp_surrendedBy",objNull])) then {
									if (currentWeapon player != "") then {
										_dirTo = [player,_object] call BIS_fnc_dirTo;
										_dirUnit = getDir _object;
										_diffDir = abs(_dirTo - _dirUnit);
										_diffDir = _diffDir min (360 - _diffDir);
										_fromBehind = _diffDir <= 25;
										_canSurrender = _fromBehind;
									};
								};
							};
						};
					};
					if (_canSurrender) then {
						if !(11 in BRPVP_actionRunning) then {
							if (_actionId isEqualTo -1) then {
								_object setVariable [_actionVar,player addAction ["<t color='#CC0000'>"+localize "str_surr_surrender"+"</t>","client_code\actions\actionSurrender.sqf",_object,1.43,true],false];
							};
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//SURRENDER: REMOVE ITEMS
					_actionVar = "brpvp_act_16";
					_actionId = _object getVariable [_actionVar,-1];
					if (11 in BRPVP_actionRunning && !(12 in BRPVP_actionRunning)) then {
						_checkIfNull = true;
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#CCCC00'>"+localize "str_surr_ask_drop"+"</t>","client_code\actions\actionSurrenderAskDrop.sqf","",1.43,true],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//BURN THE HEREGE
					_actionVar = "brpvp_act_17";
					_actionId = _object getVariable [_actionVar,-1];
					if (_objectTypeOf in BRP_kitReligious) then {
						if !(13 in BRPVP_actionRunning) then {
							if (_actionId isEqualTo -1) then {
								_object setVariable [_actionVar,player addAction ["<t color='#884400'>"+localize "str_burn_herege"+" </t><img image='BRP_imagens\interface\cross.paa'/>","client_code\actions\actionBurnTheHerege.sqf",_object],false];
							};
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//ATM MONEY MACHINE
					_actionVar = "brpvp_act_18";
					_actionId = _object getVariable [_actionVar,-1];
					if (_objectTypeOf in BRPVP_atmClasses && !(14 in BRPVP_actionRunning)) then {
						if (_actionId isEqualTo -1) then {
							_code = {BRPVP_actionRunning pushBack 14;54 call BRPVP_iniciaMenuExtra;};
							_object setVariable [_actionVar,player addAction ["<t color='#FF88FF'>"+localize "str_adda_atm_acs"+" </t></t><img image='BRP_imagens\interface\atm.paa'/>",_code],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//EASILY REMOVED STUFF OUT OF FLAG AREAS
					if (BRPVP_buildingAwayFromFlagEasyDestroy) then {
						_actionVar = "brpvp_act_20";
						_actionId = _object getVariable [_actionVar,-1];
						_objectIsBuilding = _object call BRPVP_isBuilding;
						if (_objectIsBuilding && {!(_object getVariable ["brpvp_flag_protected",false]) && !(16 in BRPVP_actionRunning) && _isAlive && _isDb}) then {
							_checkIfNull = true;
							if (_actionId isEqualTo -1) then {
								_object setVariable [_actionVar,player addAction ["<t color='#FF55CC'>"+format[localize "str_adda_destroy_unprotected",_objectDisplayName]+"</t>","client_code\actions\actionDestroyUnprotectedBuilding.sqf",_object,1.1],false];
							};
						} else {
							if !(_actionId isEqualTo -1) then {
								player removeAction _actionId;
								_object setVariable [_actionVar,-1,false];
							};
						};
					};
					//SEE OBJECT OWNER
					_actionVar = "brpvp_act_21";
					_actionId = _object getVariable [_actionVar,-1];
					if (!(17 in BRPVP_actionRunning) && _object getVariable ["own",-1] >= 0  && !_isMan) then {
						_checkIfNull = true;
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#55FFCC'>"+format[localize "str_adda_see_owner",_objectDisplayName]+"</t>","client_code\actions\actionSeeObjectOwnerName.sqf",_object,1.42,false],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//LOCK MOTORIZED
					_elegibleToLockUnlock = !(18 in BRPVP_actionRunning) && _isDb && _objectIsMotorizedNotStatic && _object getVariable ["own",-1] != -1;
					_locked = _object getVariable ["brpvp_locked",false];
					_actionVar = "brpvp_act_22_1";
					_actionId = _object getVariable [_actionVar,-1];
					if (_elegibleToLockUnlock && !_locked) then {
						_checkIfNull = true;
						if (_actionId isEqualTo -1) then {
							BRPVP_motorizedToLockUnlock = _object;
							_object setVariable [_actionVar,player addAction ["<t color='#CC33FF'>"+format[localize "str_adda_vehicle_lock",_objectDisplayName]+"</t>","client_code\actions\actionVehicleLockUnlock.sqf",_object,1.41,false],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//UNLOCK MOTORIZED
					_actionVar = "brpvp_act_22_2";
					_actionId = _object getVariable [_actionVar,-1];
					if (_elegibleToLockUnlock && _locked) then {
						_checkIfNull = true;
						if (_actionId isEqualTo -1) then {
							BRPVP_motorizedToLockUnlock = _object;
							_object setVariable [_actionVar,player addAction ["<t color='#CC33FF'>"+format[localize "str_adda_vehicle_unlock",_objectDisplayName]+"</t>","client_code\actions\actionVehicleLockUnlock.sqf",_object,1.41,false],false];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1,false];
						};
					};
					//REMOVE ACTIONS FOR OBJECTS THAT CAN TURN NULL
					_idx = _objsActionsCheckNullA find _object;
					if (_idx == -1 && _checkIfNull) then {
						_objsActionsCheckNullA pushBack _object;
						_idx = count _objsActionsCheckNullA - 1;
					};
					if (_checkIfNull) then {
						_actions = [];
						{
							_actions pushBack (_object getVariable [_x,-1]);
						} forEach _allActionsVars;
						_objsActionsCheckNullB set [_idx,_actions];
					} else {
						if (_idx != -1) then {
							_objsActionsCheckNullA deleteAt _idx;
							_objsActionsCheckNullB deleteAt _idx;
						};
					};
				};
			} forEach _objs;

			//REMOVE ACTIONS ON LOST OBJECTS
			{
				_obj = _x;
				{
					_actionId = _obj getVariable [_x,-1];
					if (_actionId != -1) then {
						player removeAction _actionId;
						_obj setVariable [_x,-1,false];
					};
				} forEach _allActionsVars;
				_idx = _objsActionsCheckNullA find _obj;
				if (_idx != -1) then {
					_objsActionsCheckNullA deleteAt _idx;
					_objsActionsCheckNullB deleteAt _idx;
				};
			} forEach (_objsLast - _objs);

			//SET NEW ARRAY OF LAST OBJECTS
			_objsLast = _objs;
			
			//CUT CONNECTION
			if (9 in BRPVP_actionRunning) then {
				if (BRPVP_actionRadarCut < 0) then {
					BRPVP_actionRadarCut = player addAction ["<t color='#8040FF'>"+localize "str_adda_radar_cut"+"</t>",{BRPVP_connectionOn = false;},[]];
				};
			} else {
				if (BRPVP_actionRadarCut != -1) then {
					player removeAction BRPVP_actionRadarCut;
					BRPVP_actionRadarCut = -1;
				};
			};
		};
		
		//ATUALIZA DEBUG DE 1 EM 1 SEGUNDO
		if (_tempo1) then {call BRPVP_atualizaDebug;};
		
		//AJUSTA VISAO DOS OBJETOS
		if (_tempo10) then {
			if (viewDistance != BRPVP_viewDist) then {setViewDistance BRPVP_viewDist;};
			if (getObjectViewDistance select 0 != BRPVP_viewObjsDist) then {setObjectViewDistance BRPVP_viewObjsDist;};
		};

		_bin1 = !_bin1;
		if (_bin1) then {
			_bin2 = !_bin2;
			
			//RECORD CAMERA TYPE
			_cameraView = cameraView;
			if (_cameraView != player getVariable "cmv") then {
				player setVariable ["cmv",_cameraView,true];
			};			
		};
		false
	};
};

diag_log "[BRPVP FILE] loops.sqf END REACHED";