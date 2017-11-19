//PVEH FUNCTIONS
BRPVP_addWalkerIconsServerFnc = {
	_zombieGroup = _this select 1;
	BRPVP_walkersObj = BRPVP_walkersObj - [objNull];
	BRPVP_walkersObj append _zombieGroup;
	BRPVP_addWalkerIconsClient = _zombieGroup;
	publicVariable "BRPVP_addWalkerIconsClient";
	if (hasInterface) then {["",BRPVP_addWalkerIconsClient] call BRPVP_addWalkerIconsClientFnc;};
};
BRPVP_spawnZombiesServerFromClientFnc = {
	(_this select 1) params ["_posSpawn","_spawnTemplateIndex","_nearBuildingsAwayNoPlayers","_player"];
	_spawnTemplate = BRPVP_zombieSpawnTemplate select _spawnTemplateIndex;
	_amount = _spawnTemplate select 0;	
	_spawnRad = _spawnTemplate select 3;
	_forceArray = _spawnTemplate select 5;
	_spawnInBuildingsAmount = (count _nearBuildingsAwayNoPlayers) min _amount;
	_zombieGroup = [];
	for "_u" from 1 to _spawnInBuildingsAmount do {
		_building = _nearBuildingsAwayNoPlayers deleteAt (floor random count _nearBuildingsAwayNoPlayers);
		_buildingPosAll = _building buildingPos -1;
		if (count _buildingPosAll == 0) then {_buildingPosAll = [ASLToAGL getPosASL _building];};
		_buildingPos = _buildingPosAll call BIS_fnc_selectRandom;
		_zombieClass = BRPVP_zombiesClasses call BIS_fnc_selectRandom;
		_zombie = createAgent [_zombieClass,_buildingPos,[],0,"NONE"];
		_zombie call BRPVP_pelaUnidade;
		_zombie addUniform (BRPVP_zombiesUniforms call BIS_fnc_selectRandom);
		_zombieGroup pushBack _zombie;
	};	
	for "_i" from 1 to (_amount - _spawnInBuildingsAmount) do {
		_zombieClass = BRPVP_zombiesClasses call BIS_fnc_selectRandom;
		_zombie = createAgent [_zombieClass,BRPVP_spawnAIFirstPos,[],10,"NONE"];
		[_zombie,"AidlPpneMstpSnonWnonDnon_AI"] remoteExec ["switchMove",0,false];
		_zombie setVehiclePosition [_posSpawn,[],_spawnRad,"NONE"];
		_zombie call BRPVP_pelaUnidade;
		_zombie addUniform (BRPVP_zombiesUniforms call BIS_fnc_selectRandom);
		_zombieGroup pushBack _zombie;
	};
	BRPVP_walkersObj = BRPVP_walkersObj - [objNull];
	BRPVP_walkersObj append _zombieGroup;
	BRPVP_addWalkerIconsClient = _zombieGroup;
	publicVariable "BRPVP_addWalkerIconsClient";
	if (hasInterface) then {["",BRPVP_addWalkerIconsClient] call BRPVP_addWalkerIconsClientFnc;};
	{
		_agnt = _x;
		_agnt setVariable ["dmg",0,true];
		_agnt setVariable ["brpvp_impact_damage",0,true];
		_agnt setVariable ["ifz",[_forceArray call BIS_fnc_selectRandom,false,if (random 1 < 0.5) then {floor random 2} else {-1}],true];
		_agnt forceSpeed (_agnt getSpeed "FAST");
		{_agnt setHit [_x,0.8];} forEach ["body","spine1","spine2","spine3"];
		{_agnt setHit [_x,0.9];} forEach ["face_hub","neck","head","arms","hands"];
	} forEach _zombieGroup;
	_id_bd = _player getVariable "id_bd";
	_idx = BRPVP_zombiePlayersAttacked find _id_bd;
	if (_idx == -1) then {
		BRPVP_zombiePlayersAttacked pushBack _id_bd;
		BRPVP_zombiePlayersAttackedUnits pushBack _zombieGroup;
	} else {
		(BRPVP_zombiePlayersAttackedUnits select _idx) append _zombieGroup;
	};
	BRPVP_sendAgentConfigToClient = [];
	_owner = owner _player;
	{
		_agnt = _x;
		_localN = _player getVariable ["brpvp_local_zombie_flag",0];
		_player setVariable ["brpvp_local_zombie_flag",(_localN + 1) mod BRPVP_zombiesHostOnServerRatio,false];
		_local = _localN != 0;
		_nid = if (_local) then {_owner} else {2};
		_ok = if (_local) then {_agnt setOwner _nid} else {true};
		if (_ok) then {BRPVP_sendAgentConfigToClient pushBack [_agnt,_nid];} else {BRPVP_sendAgentConfigToClient pushBack [_agnt,2];};
		if (_nid == 2 || !_ok) then {
			_agnt disableAI "FSM";
			_agnt disableAI "AUTOCOMBAT";
			_agnt disableAI "AUTOTARGET";
			_agnt disableAI "TARGET";
			_agnt setBehaviour "CARELESS";
			_agnt addRating (-20000 - (rating _agnt));
			{_x reveal [_agnt,4];} forEach (_agnt nearEntities ["CaManBase",350]);
		};
	} forEach _zombieGroup;
	if (_player isEqualTo player) then {["",BRPVP_sendAgentConfigToClient] call BRPVP_sendAgentConfigToClientFnc;} else {_owner publicVariableClient "BRPVP_sendAgentConfigToClient";};
};
BRPVP_serverOrderAIAttackFnc = {
	(_this select 1) params ["_attacker","_target"];
	_attacker setVariable ["brpvp_target",_target,true];
	(_this select 1) spawn {
		params ["_attacker","_target"];
		_pw = primaryWeapon _attacker;
		_hgw = handgunWeapon _attacker;
		_wep = if (_pw == "") then {_hgw} else {_pw};
		_fireModeArray = getArray (configFile >> "CfgWeapons" >> _wep >> "modes");
		_fireMode = if (_fireModeArray select 0 == "this") then {_wep} else {_fireModeArray select 0};
		waitUntil {
			_targetASL = getPosASL _target;
			_attacker doWatch ASLToAGL _targetASL;
			_wVec = _attacker weaponDirection _wep;
			_pVec = (_targetASL vectorDiff (getPosASL _attacker));
			_angle = acos (_wVec vectorCos _pVec);
			if (_angle < 10) then {_attacker forceWeaponFire [_wep,_fireMode];};
			!alive _attacker || isNull _attacker || !alive _target || isNull _target || _target distanceSqr _attacker > 900
		};
	};
};
BRPVP_serverGraphHintPlayerFnc = {
	(_this select 1) params ["_player","_msg"];
	BRPVP_clientGraphHintPlayer = _msg;
	(owner _player) publicVariableClient "BRPVP_clientGraphHintPlayer";
};
BRPVP_serverStillSurrendedCheckFnc = {
	(_this select 1) params ["_surrended","_attacker"];
	BRPVP_clientStillSurrendedCheck = _attacker;
	(owner _surrended) publicVariableClient "BRPVP_clientStillSurrendedCheck";
};
BRPVP_serverRemoveTurretFnc = {
	(_this select 1) params ["_player","_operator"];
	BRPVP_autoDefenseTurretList deleteAt (BRPVP_autoDefenseTurretList find _operator);
	BRPVP_serverRemoveTurretAnswer = true;
	(owner _player) publicVariableClient "BRPVP_serverRemoveTurretAnswer";
};
BRPVP_addVehicleMPKilledFnc = {
	(_this select 1) call BRPVP_veiculoEhReset;
};
BRPVP_askServerRemoveSomeoneStuffFnc = {
	_objs = _this select 1;
	{
		_obj = _x;
		_own = _obj getVariable ["own",-1];
		if (_own > -1) then {
			_player = objNull;
			{
				if (_x getVariable ["id_bd",-1] == _own) exitWith {_player = _x;};
			} forEach allPlayers;
			if (!isNull _player) then {
				BRPVP_remoteRemoveMyStuff = _obj;
				if (owner _player == BRPVP_playerOwner) then {
					["",BRPVP_remoteRemoveMyStuff] call BRPVP_remoteRemoveMyStuffFnc;
				} then {
					(owner _player) publicVariableClient "BRPVP_remoteRemoveMyStuff";
				};
			};
		};
	} forEach _objs;
};
BRPVP_askServerForDestructionLogFnc = {
	(_this select 1) params ["_player","_id_bd","_all"];
	private ["_key"];
	if (BRPVP_useExtDB3) then {
		if (_all) then {
			_key = format ["0:%1:getDestructionLogAll",BRPVP_protocolo];
		} else {
			_key = format ["0:%1:getDestructionLog:%2",BRPVP_protocolo,_id_bd];
		};
		_resultado = "extDB3" callExtension _key;
		diag_log "----------------------------------------------------------------------------------";
		diag_log "---- [GET DESTRUCTION LOG]";
		diag_log ("---- _key = " + _key + ".");
		diag_log ("---- _resultado = " + str _resultado + ".");
		diag_log "----------------------------------------------------------------------------------";
		BRPVP_askServerForDestructionLogReturn = _resultado;
	} else {
		BRPVP_askServerForDestructionLogReturn = "[1,[]]";
	};
	(owner _player) publicVariableClient "BRPVP_askServerForDestructionLogReturn";
};
BRPVP_onlyOwnedHousesAskForFnc = {
	_p = _this select 1;
	BRPVP_onlyOwnedHousesServerReturn = BRPVP_ownedHouses;
	(owner _p) publicVariableClient "BRPVP_onlyOwnedHousesServerReturn";
};
BRPVP_setTerrainGridServerFnc = {
	BRPVP_setTerrainGridClient = _this select 1;
	setTerrainGrid BRPVP_setTerrainGridClient;
	publicVariable "BRPVP_setTerrainGridClient";
};
BRPVP_countPlayerConnectionFnc = {
	_id_bd = _this select 1;
	if (!BRPVP_useExtDB3) then {
		_playerIndex = (BRPVP_noExtDB3PlayersTable select 3) find _id_bd;
		if (_playerIndex != -1) then {
			BRPVP_lastConnectionNumber = BRPVP_lastConnectionNumber + 1;
			(BRPVP_noExtDB3PlayersTable select 4) set [_playerIndex,BRPVP_lastConnectionNumber];
		} else {
			diag_log "[no-DB ERROR] TRIED TO SAVE CONNECTION WITHOUT ENTRY.";
		};
	};
};
BRPVP_askPlayersToUpdateFriendsServerFnc = {
	(_this select 1) params ["_playersToUpdate","_playerShareChangedId","_newShareType"];
	BRPVP_askPlayersToUpdateFriendsClient = true;
	{(owner _x) publicVariableClient "BRPVP_askPlayersToUpdateFriendsClient";} forEach _playersToUpdate;
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:savePlayerComp:%2:%3",BRPVP_protocolo,_newShareType,_playerShareChangedId];
		_resultado = "extDB3" callExtension _key;
		diag_log "----------------------------------------------------------------------------------";
		diag_log "---- [UPDATE PLAYER SELF SHARE TYPE ON DB]";
		diag_log ("---- _key = " + _key + ".");
		diag_log ("---- _resultado = " + str _resultado + ".");
		diag_log "----------------------------------------------------------------------------------";
	} else {
		_index = (BRPVP_noExtDB3PlayersTable select 0) find _playerShareChangedId;
		if (_index != -1) then {
			(BRPVP_noExtDB3PlayersTable select 1 select _index) set [10,_newShareType];
		} else {
			diag_log "[BRPVP NO-DB ERROR] TRIED TO SAVE PLAYER EXPOSITION WITHOUT ENTRY.";
		};
	};
};
BRPVP_setSimulationFnc = {
	{
		_x params ["_agnt","_state"];
		_agnt enableSimulation _state;
	} forEach (_this select 1);
};
BRPVP_temp10 = 0;
BRPVP_sendAgentConfigToClientAskServerFnc = {
	(_this select 1) params ["_agnt","_player"];
	_local = local _agnt;
	if (isNull _player) then {
		if (!alive _agnt) then {_agnt hideObjectGlobal true;};
		_ok = if (!_local) then {_agnt setOwner 2} else {true};
		if (_ok) then {
			_agnt call BRPVP_zombieLocalEH;
		} else {
			_agnt spawn {
				_agnt = _this;
				for "_i" from 1 to 10 do {
					sleep 1.25;
					_ok = if (!local _agnt) then {_agnt setOwner 2} else {true};
					if (_ok) exitWith {_agnt call BRPVP_zombieLocalEH;};
				};
			};
		};
	} else {
		_idx1 = -1;
		_idx2 = -1;
		{
			_find = _x find _agnt;
			if (_find != -1) exitWith {
				_idx1 = _forEachIndex;
				_idx2 = _find;
			};
		} forEach BRPVP_zombiePlayersAttackedUnits;
		if (_idx1 != -1) then {(BRPVP_zombiePlayersAttackedUnits select _idx1) deleteAt _idx2;};
		_id_bd = _player getVariable "id_bd";
		_idx = BRPVP_zombiePlayersAttacked find _id_bd;
		if (_idx == -1) then {
			BRPVP_zombiePlayersAttacked pushBack _id_bd;
			BRPVP_zombiePlayersAttackedUnits pushBack [_agnt];
		} else {
			(BRPVP_zombiePlayersAttackedUnits select _idx) pushBack _agnt;
		};
		_localN = _player getVariable ["brpvp_local_zombie_flag",0];
		_player setVariable ["brpvp_local_zombie_flag",(_localN + 1) mod BRPVP_zombiesHostOnServerRatio,false];
		_owner = owner _player;
		_local = _localN != 0;
		_nid = if (_local) then {_owner} else {2};
		_ok = if (_local) then {_agnt setOwner _nid} else {true};
		if (_ok) then {
			BRPVP_sendAgentConfigToClient = [[_agnt,_nid]];
		} else {
			if (!_local) then {_agnt setOwner 2;};
			BRPVP_sendAgentConfigToClient = [[_agnt,2]];
		};
		if (_owner == BRPVP_playerOwner) then {["",BRPVP_sendAgentConfigToClient] call BRPVP_sendAgentConfigToClientFnc;} else {_owner publicVariableClient "BRPVP_sendAgentConfigToClient";};
	};
};
BRPVP_setAutoTurretServerFnc = {
	(_this select 1) call BRPVP_setTurretOperator;
};
BRPVP_saveLightStateDbFnc = {
	(_this select 1) params ["_lamp","_state"];
	_exec = if (_state) then {"_this setDamage 0;"} else {"_this setDamage 0.95;"};
	_lamp call compile _exec;
	_lampIdBd = _lamp getVariable ["id_bd",-1];
	if (_lampIdBd != -1) then {
		if (BRPVP_useExtDB3) then {
			_key = format ["1:%1:saveVehicleExec:%2:%3",BRPVP_protocolo,_exec,_lampIdBd];
			_resultado = "extDB3" callExtension _key;
			diag_log "---------------------------------------------------------";
			diag_log ("-- LIGHT CHANGED STATE TO: " + _exec );
			diag_log ("-- _resultado: " + str _resultado);
			diag_log "---------------------------------------------------------";
		} else {
			_vehicleIndex = (BRPVP_noExtDB3VehiclesTable select 0) find _lampIdBd;
			if (_vehicleIndex != -1) then {
				 (BRPVP_noExtDB3VehiclesTable select 1 select _vehicleIndex) set [6,_exec];
			} else {
				diag_log "[BRPVP NO-DB ERROR] TRIED TO TURN ON/OFF A LAMP WITHOUT ENTRY.";
			};
		};
	};
};
BRPVP_iAskForAllInitialVarsFnc = {
	_player = _this select 1;
	(owner _player) publicVariableClient "BRPVP_carrosObjetos";
	(owner _player) publicVariableClient "BRPVP_helisObjetos";
	(owner _player) publicVariableClient "BRPVP_walkersObj";
	(owner _player) publicVariableClient "BRPVP_allFlags";
};
BRPVP_setWeatherServerFnc = {
	BRPVP_hintemMassa = [["str_change_weather",[]],0];
	publicVariable "BRPVP_hintemMassa";
	if (hasInterface) then {["",BRPVP_hintEmMassa] call BRPVP_hintEmMassaFnc;};
	
	0 setOvercast 0;
	0 setRain 0;
	setWind [0,0,true];
	0 setGusts 0;
	forceWeatherChange;

	//_BRPVP_overcast = (_this select 1 select 0 select 0);
	//0 setOvercast _BRPVP_overcast;
	0 setOvercast (_this select 1 select 0 select 0);
	0 setRain (_this select 1 select 1 select 0);
	_wVel = _this select 1 select 1 select 1 select 0;
	_wDir = _this select 1 select 1 select 1 select 1;
	setWind [_wVel * sin _wDir,_wVel * cos _wDir,true];
	0 setGusts (_this select 1 select 0 select 1);
	forceWeatherChange;
	//BRPVP_overcast = _BRPVP_overcast;
	//publicVariable "BRPVP_overcast";
};
BRPVP_setTimeMultiplierSVFnc = {
	BRPVP_timeMultiplier = (_this select 1);
	setTimeMultiplier BRPVP_timeMultiplier;
	BRPVP_hintEmMassa = [["str_time_mult_changed",[_this select 1]],3.5,12,768];
	publicVariable "BRPVP_hintEmMassa";
	if (hasInterface) then {["",BRPVP_hintemMassa] call BRPVP_hintemMassaFnc;};
};
BRPVP_setDateSVFnc = {
	setDate (_this select 1);
	BRPVP_hintEmMassa = [["str_day_time_changed",[_this select 1 select 3,_this select 1 select 4]],0];
	publicVariable "BRPVP_hintEmMassa";
	if (hasInterface) then {["",BRPVP_hintemMassa] call BRPVP_hintemMassaFnc;};
};
BRPVP_runCorruptMissSpawnFnc = {
	_pcrashQt = _pcrashQt - 1;
	(getPosATL (_this select 1)) spawn BRPVP_corruptMissSpawn;
	BRPVP_hintEmMassa = [["str_plane_fall_started",[]]];
	if (owner (_this select 1) == BRPVP_playerOwner) then {["",BRPVP_hintEmMassa] call BRPVP_hintEmMassaFnc;} else {(owner (_this select 1)) publicVariableClient "BRPVP_hintEmMassa";};
};
BRPVP_mudouConfiancaEmVoceSVFnc = {
	(_this select 1) params ["_pToNotify","_pAction","_action","_amg"];
	if (!isNull _pToNotify) then {
		if !(local _pToNotify) then {
			BRPVP_mudouConfiancaEmVoce = [_pAction,_action];
			if (owner _pToNotify == BRPVP_playerOwner) then {["",BRPVP_mudouConfiancaEmVoce] call BRPVP_mudouConfiancaEmVoceFnc;} else {(owner _pToNotify) publicVariableClient "BRPVP_mudouConfiancaEmVoce";};
		};
	};
	if (BRPVP_useExtDB3) then {
		_id_bd = _pAction getVariable ["id_bd",-1];
		if (_id_bd != -1) then {
			_key = format ["1:%1:savePlayerAmg:%2:%3",BRPVP_protocolo,_pAction getVariable ["amg",[]],_id_bd];
			_resultado = "extDB3" callExtension _key;
			diag_log "----------------------------------------------------------------------------------";
			diag_log ("[BRPVP] UPDATED PLAYER FRIENDS: _key = " + str _key + ".");
			diag_log ("[BRPVP] UPDATED PLAYER FRIENDS: _resultado = " + str _resultado + ".");
			diag_log "----------------------------------------------------------------------------------";
		};
	} else {
		_playerIndex = (BRPVP_noExtDB3PlayersTable select 0) find (getPlayerUID _pAction);
		if (_playerIndex != -1) then {
			(BRPVP_noExtDB3PlayersTable select 1 select _playerIndex) set [7,_amg];
		} else {
			diag_log "[BRPVP NO-DB ERROR] CANT FIND PLAYER ENTRY TO SAVE FRIENDS (AMG 1).";
		};
	};
};
BRPVP_convoyRunFnc = {
	call BRPVP_convoyMission;
	BRPVP_hintEmMassa = [["str_convoy_started",[]],4,15,167];
	if (owner (_this select 1) == BRPVP_playerOwner) then {["",BRPVP_hintEmMassa] call BRPVP_hintEmMassaFnc;} else {(owner (_this select 1)) publicVariableClient "BRPVP_hintEmMassa";};
};
BRPVP_giveMoneySVFnc = {
	(_this select 1) params ["_unit","_money",["_hand_or_bank","mny"]];
	BRPVP_giveMoney = [_money,_hand_or_bank];
	if (owner _unit == BRPVP_playerOwner) then {["",BRPVP_giveMoney] call BRPVP_giveMoneyFnc;} else {(owner _unit) publicVariableClient "BRPVP_giveMoney";};
};
BRPVP_hideObjectSvFnc = {
	(_this select 1) params ["_unit","_state"];
	_unit hideObjectGlobal _state;
};
BRPVP_switchMoveSvFnc = {
	BRPVP_switchMoveCli = _this select 1;
	publicVariable "BRPVP_switchMoveCli";
	if (hasInterface) then {["",BRPVP_switchMoveCli] call BRPVP_switchMoveCliFnc;};
	
};
BRPVP_corpseToDelAddFnc = {
	_corpse = _this select 1;
	_corpse setVariable ["hrv",time,false];
	_corpse enableSimulationGlobal false;
	BRPVP_corpsesToDel pushBack _corpse;
};
BRPVP_bravoRunFnc = {
	_ply = _this select 1;
	if (BRPVP_criaMissaoDePredioEspera == BRPVP_criaMissaoDePredioIdc) then {
		[] spawn BRPVP_criaMissaoDePredio;
		BRPVP_hintEmMassa = [["str_bravo_started",[]],6.5,15,167];
	} else {
		BRPVP_hintEmMassa = [["str_bravo_cant_start",[]],6,15,167];
	};
	if (owner _ply == BRPVP_playerOwner) then {["",BRPVP_hintEmMassa] call BRPVP_hintEmMassaFnc;} else {(owner _ply) publicVariableClient "BRPVP_hintEmMassa";};
};
BRPVP_siegeRunFnc = {
	_canStart = ({_x == 1} count BRPVP_closedCityRunning) == 0;
	if (_canStart) then {
		BRPVP_hintEmMassa = [["str_siege_start",[]],6,15,167];
		[] spawn BRPVP_besiegedMission;
	} else {
		BRPVP_hintEmMassa = [["str_siege_cant_start",[]],5,15,167];
	};
	if (owner (_this select 1) == BRPVP_playerOwner) then {["",BRPVP_hintEmMassa] call BRPVP_hintEmMassaFnc;} else {(owner (_this select 1)) publicVariableClient "BRPVP_hintEmMassa";};
};
BRPVP_moveInServerFnc = {
	BRPVP_moveInClient = _this select 1;
	if (owner (_this select 1 select 0) == BRPVP_playerOwner) then {["",BRPVP_moveInClient] call BRPVP_moveInClientFnc;} else {(owner (_this select 1 select 0)) publicVariableClient "BRPVP_moveInClient";};
};
BRPVP_avisaExplosaoFnc = {
	(_this select 1) spawn {
		params ["_obj","_pAvisa"];
		_own = _obj getVariable ["own",-1];
		if (_own > -1) then {
			_player = objNull;
			{
				if (_x getVariable ["id_bd",-1] == _own) exitWith {
					_player = _x;
				};
			} forEach allPlayers;
			if (!isNull _player) then {
				BRPVP_remoteRemoveMyStuff = _obj;
				if (owner _player == BRPVP_playerOwner) then {
					["",BRPVP_remoteRemoveMyStuff] call BRPVP_remoteRemoveMyStuffFnc;
				} then {
					(owner _player) publicVariableClient "BRPVP_remoteRemoveMyStuff";
				};
			};
		};
		if (_obj call BRPVP_IsMotorized) then {
			BRPVP_hintEmMassa = [["str_run",[]],0];
			{
				if (owner _x == BRPVP_playerOwner) then {["",BRPVP_hintEmMassa] call BRPVP_hintEmMassaFnc;} else {(owner _x) publicVariableClient "BRPVP_hintEmMassa";};
			} forEach _pAvisa;
			
			//IN CASE OF TURRET
			_operator = _obj getVariable ["brpvp_operator",objNull];
			if (!isNull _operator) then {
				_operator setVariable ["brpvp_dead",true,true];
			};
			
			for "_s" from 0 to 2 do {
				BRPVP_tocaSom = [_obj,"destroy",300];
				publicVariable "BRPVP_tocaSom";
				if (hasInterface) then {["",BRPVP_tocaSom] call BRPVP_tocaSomFnc;};
				sleep 2;
			};
			sleep 1;
			_obj setDamage 1;
			_obj setVariable ["bdc",true,true];
		} else {
			_typeOf = typeOf _obj;
			_isBigHouse = _obj isKindOf "House" && !(_obj isKindOf "House_Small_F");
			_haveDoors = (if (isNumber (configFile >> "CfgVehicles" >> _typeOf >> "numberOfDoors")) then {getNumber (configFile >> "CfgVehicles" >> _typeOf >> "numberOfDoors")} else {0}) > 0;
			if (_typeOf in BRPVP_buildingHaveDoorList && (_isBigHouse || _haveDoors)) then {
				BRPVP_hintEmMassa = [["str_run",[]],0];
				{
					if (owner _x == BRPVP_playerOwner) then {["",BRPVP_hintEmMassa] call BRPVP_hintEmMassaFnc;} else {(owner _x) publicVariableClient "BRPVP_hintEmMassa";};
				} forEach _pAvisa;
				for "_s" from 0 to 2 do {
					BRPVP_tocaSom = [_obj,"destroy",300];
					publicVariable "BRPVP_tocaSom";
					if (hasInterface) then {["",BRPVP_tocaSom] call BRPVP_tocaSomFnc;};
					sleep 2;
				};
				sleep 1;
				_pw = getPosWorld _obj;
				_obj setDamage 1;
				sleep 5;
				_ruins = (ASLToAGL _pw) nearestObject "Ruins";
				_ruins setVariable ["bdc",true,true];
			} else {
				_obj call BRPVP_veiculoMorreu;
				deleteVehicle _obj;
			};
		};
	};
};
BRPVP_desviraVeiculoFnc = {
	(_this select 1) params ["_car","_alt","_gSize"];
	_hP = (getPosATL _car) vectorAdd [0,0,_alt];
	BRPVP_ganchoDesviraAdd = [_hP,_gSize];
	publicVariable "BRPVP_ganchoDesviraAdd";
	if (hasInterface) then {["",BRPVP_ganchoDesviraAdd] call BRPVP_ganchoDesviraAddFnc;};
	_gancho = createVehicle ["B_static_AA_F",_hP,[],0,"CAN_COLLIDE"];
	_gancho enableSimulation false;
	hideObjectGlobal _gancho;
	_car setOwner 2;
	_car allowDamage false;
	_offSets = [
		[0.3,0,0.5],
		[-0.3,0,0.5],
		[0,0.3,0.5],
		[0,-0.3,0.5]
	];
	_offSet = _offSets call BIS_fnc_selectRandom;
	_cP = (getCenterOfMass _car) vectorAdd _offset;
	_ropus = ropeCreate [_gancho,[0,0,0],_car,_cP,((_gancho modelToWorld [0,0,0]) distance (_car modelToWorld _cP)) + 0.5];
	_ropus allowDamage false;
	[_car,_ropus,_gancho,_hP,_gSize,_alt] spawn {
		params ["_car","_ropus","_gancho","_hP","_gSize","_alt"];
		sleep 1;

		BRPVP_rapelRopeUnwindPV = [_ropus,1,-(_alt * 0.8 + 0.5),true];
		publicVariable "BRPVP_rapelRopeUnwindPV";
		ropeUnwind BRPVP_rapelRopeUnwindPV;
		waitUntil {ropeUnwound _ropus};

		_ini = time;
		waitUntil {
			_vu = vectorUp _car;
			_ang = acos (_vu vectorCos [0,0,1]);
			_ang < 30 || time - _ini > 5
		};
		
		BRPVP_rapelRopeUnwindPV = [_ropus,1,_alt * 0.8 + 0.5,true];
		publicVariable "BRPVP_rapelRopeUnwindPV";
		ropeUnwind BRPVP_rapelRopeUnwindPV;
		waitUntil {ropeUnwound _ropus};

		_car ropeDetach _ropus;
		sleep 1;
		ropeDestroy _ropus;
		deleteVehicle _gancho;
		BRPVP_ganchoDesviraRemove = [_hP,_gSize];
		publicVariable "BRPVP_ganchoDesviraRemove";
		if (hasInterface) then {["",BRPVP_ganchoDesviraRemove] call BRPVP_ganchoDesviraRemoveFnc;};
		_car allowDamage true;
	};
};
BRPVP_rapelRopeUnwindPVFnc = {
	if (!isNull (_this select 1 select 0)) then {
		ropeUnwind (_this select 1);
	};
};
BRPVP_ownedHousesSolicitaFnc = {
	_p = _this select 1;
	(owner _p) publicVariableClient "BRPVP_variablesObjects";
	(owner _p) publicVariableClient "BRPVP_variablesNames";
	(owner _p) publicVariableClient "BRPVP_variablesValues";
	(owner _p) publicVariableClient "BRPVP_ownedHouses";
};
BRPVP_ownedHousesAddFnc = {
	BRPVP_ownedHouses pushBack (_this select 1);
};
BRPVP_svCriaVehEnvioFnc = {
	(_this select 1) params ["_p","_param"];
	_veh = createVehicle _param;
	_veh enableSimulation false;
	hideObjectGlobal _veh;
	BRPVP_svCriaVehRetorno = _veh;
	if (owner _p == BRPVP_playerOwner) then {["",BRPVP_svCriaVehRetorno] call BRPVP_svCriaVehRetornoFnc;} else {(owner _p) publicVariableClient "BRPVP_svCriaVehRetorno";};
};
BRPVP_amigosAtualizaServidorFnc = {
	_id_bd = _this select 1 select 0;
	_amigos = _this select 1 select 1;
	if (BRPVP_useExtDB3) then {
		_sql = format ["UPDATE players SET amigos = '%1' WHERE id = %2",_amigos,_id_bd];
		_key = format ["1:%1:%2",BRPVP_protocoloRaw,_sql];
		_resultado = "extDB3" callExtension _key;
		diag_log ("[BRPVP UPDATE PLAYER FRIENDS] _resultado = " + _resultado + ".");
	} else {
		_playerIndex = -1;
		{
			if (_x select 11 == _id_bd) exitWith {
				_playerIndex = _forEachIndex;
			};
		} forEach (BRPVP_noExtDB3PlayersTable select 1);
		if (_playerIndex != -1) then {
			BRPVP_noExtDB3PlayersTable select 1 select _playerIndex set [7,_amg];
		} else {
			diag_log "[BRPVP NO-DB ERROR] CANT FIND PLAYER ENTRY TO SAVE FRIENDS (AMG 2).";
		};
	};
};
BRPVP_pegaTop10EstatisticaFnc = {
	_estatistica = _this select 1 select 0;
	_solicitante = _this select 1 select 1;
	if (BRPVP_useExtDB3) then {
		_max = _estatistica + 1;
		_minChar = ",";
		if (_estatistica == 0) then {_minChar = "[";};
		_sql = format ["SELECT exp,CONCAT('""',nome,'""') FROM players ORDER BY (SUBSTRING_INDEX(SUBSTRING_INDEX(exp,',',%1),'%2',-1)*1) DESC LIMIT 10",_max,_minChar];
		_key = format ["0:%1:%2",BRPVP_protocoloRawText,_sql];
		_resultado = "extDB3" callExtension _key;
		_resultadoCompilado = call compile _resultado;
		_tabela = [];
		{_tabela pushBack (str (_x select 0 select _estatistica) + " - " + (_x select 1));} forEach (_resultadoCompilado select 1);
		BRPVP_pegaTop10EstatisticaRetorno = _tabela;
	} else {
		_table = [];
		{
			_table pushBack [_x select 9 select _estatistica,BRPVP_noExtDB3PlayersTable select 2 select _forEachIndex];
		} forEach (BRPVP_noExtDB3PlayersTable select 1);
		_table sort false;
		if (count _table > 10) then {_table deleteRange [10,(count _table) - 10];};
		BRPVP_pegaTop10EstatisticaRetorno = _table apply {str (_x select 0) + " - " + (_x select 1)};
	};
	(owner _solicitante) publicVariableClient "BRPVP_pegaTop10EstatisticaRetorno";
};
BRPVP_mudaExpOutroPlayerFnc = {
	_player = _this select 1 select 0;
	BRPVP_mudaExpPedidoServidor = _this select 1 select 1;
	if (owner _player == BRPVP_playerOwner) then {["",BRPVP_mudaExpPedidoServidor] call BRPVP_mudaExpPedidoServidorFnc;} else {(owner _player) publicVariableClient "BRPVP_mudaExpPedidoServidor";};
};
BRPVP_salvaNomePeloIdBdFnc = {
	_id_bd = _this select 1 select 0;
	_nome = _this select 1 select 1;
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:savePlayerName:%2:%3",BRPVP_protocolo,_nome,_id_bd];
		_resultado = "extDB3" callExtension _key;
	} else {
		_playerIndex = -1;
		{
			if (_x select 11 == _id_bd) exitWith {
				_playerIndex = _forEachIndex;
			};
		} forEach (BRPVP_noExtDB3PlayersTable select 1);
		if (_playerIndex != -1) then {
			(BRPVP_noExtDB3PlayersTable select 2) set [_playerIndex,_nome];
		} else {
			diag_log "[BRPVP NO-DB ERROR] CANT SAVE PLAYER NAME, ENTRY NOT FOUND.";
		};
	};
};
BRPVP_pegaNomePeloIdBd1Fnc = {
	(_this select 1) params ["_id_bd_array","_solicitante","_retorno"];
	if (BRPVP_useExtDB3) then {
		_id_bd_txt = "";
		_final = (count _id_bd_array) - 1;
		{
			_id_bd_txt = _id_bd_txt + str _x;
			if (_forEachIndex < _final) then {_id_bd_txt = _id_bd_txt + ",";};
		} forEach _id_bd_array;
		_id_bd_txt = "(" + _id_bd_txt + ")";
		_tabNome = [];
		_tabIdBd = [];
		if (_id_bd_txt != "()") then {
			_sql = format ["SELECT CONCAT('""',nome,'""'),id FROM players WHERE id IN %1 ORDER BY nome ASC",_id_bd_txt];
			_key = format ["0:%1:%2",BRPVP_ProtocoloRawText,_sql];
			_resultado = "extDB3" callExtension _key;
			diag_log ("[BRPVP NAMES1] _resultado = " + _resultado);
			_resultadoCompilado = call compile _resultado;
			diag_log ("[BRPVP NAMES1] _resultadoCompilado = " + str _resultadoCompilado);
			_tabNome = [];
			_tabIdBd = [];
			{_tabNome pushBack (_x select 0);} forEach (_resultadoCompilado select 1);
			{_tabIdBd pushBack (_x select 1);} forEach (_resultadoCompilado select 1);
		};
		if (_retorno) then {
			BRPVP_pegaNomePeloIdBd1Retorno = [_tabNome,_tabIdBd];
		} else {
			BRPVP_pegaNomePeloIdBd1Retorno = _tabNome;
		};
	} else {
		_tabNome = [];
		_tabIdBd = [];
		{
			_id_bd = _x select 11;
			if (_id_bd in _id_bd_array) then {
				_tabNome pushBack (BRPVP_noExtDB3PlayersTable select 2 select _forEachIndex);
				_tabIdBd pushBack _id_bd;
			};
		} forEach (BRPVP_noExtDB3PlayersTable select 1);
		if (_retorno) then {
			BRPVP_pegaNomePeloIdBd1Retorno = [_tabNome,_tabIdBd];
		} else {
			BRPVP_pegaNomePeloIdBd1Retorno = _tabNome;
		};
	};
	(owner _solicitante) publicVariableClient "BRPVP_pegaNomePeloIdBd1Retorno";
};
BRPVP_pegaNomePeloIdBd2Fnc = {
	_id_bd = _this select 1 select 0;
	_solicitante = _this select 1 select 1;
	if (BRPVP_useExtDB3) then {
		_sql = format ["SELECT CONCAT('""',nome,'""') FROM players WHERE amigos LIKE '[%1,%2' OR amigos LIKE '%2,%1,%2' OR amigos LIKE '%2,%1]' OR amigos LIKE '[%1]' ORDER BY nome ASC",_id_bd,"%"];
		_key = format ["0:%1:%2",BRPVP_protocoloRawText,_sql];
		_resultado = "extDB3" callExtension _key;
		_resultadoCompilado = call compile _resultado;
		_tabela = [];
		{_tabela pushBack (_x select 0);} forEach (_resultadoCompilado select 1);
		BRPVP_pegaNomePeloIdBd2Retorno = _tabela;
	} else {
		_BRPVP_pegaNomePeloIdBd2Retorno = [];
		{
			if (_id_bd in (_x select 7)) then {
				_BRPVP_pegaNomePeloIdBd2Retorno pushBack (BRPVP_noExtDB3PlayersTable select 2 select _forEachIndex);
			};
		} forEach (BRPVP_noExtDB3PlayersTable select 1);
		BRPVP_pegaNomePeloIdBd2Retorno = _BRPVP_pegaNomePeloIdBd2Retorno;
	};
	(owner _solicitante) publicVariableClient "BRPVP_pegaNomePeloIdBd2Retorno";
};
BRPVP_pegaNomePeloIdBd3Fnc = {
	(_this select 1) params ["_id_bd_array","_id_bd","_solicitante"];
	if (BRPVP_useExtDB3) then {
		_id_bd_txt = "";
		_final = (count _id_bd_array) - 1;
		{
			_id_bd_txt = _id_bd_txt + str _x;
			if (_forEachIndex < _final) then {_id_bd_txt = _id_bd_txt + ",";};
		} forEach _id_bd_array;
		_id_bd_txt = "(" + _id_bd_txt + ")";
		_tabNome = [];
		if (_id_bd_txt != "()") then {
			_sql = format ["SELECT CONCAT('""',nome,'""') FROM players WHERE (amigos LIKE '[%1,%3' OR amigos LIKE '%3,%1,%3' OR amigos LIKE '%3,%1]' OR amigos LIKE '[%1]') AND id IN %2 ORDER BY nome ASC",_id_bd,_id_bd_txt,"%"];
			_key = format ["0:%1:%2",BRPVP_protocoloRawText,_sql];
			_resultado = "extDB3" callExtension _key;
			_resultadoCompilado = call compile _resultado;
			{_tabNome = _tabNome + [_x select 0];} forEach (_resultadoCompilado select 1);
		};
		BRPVP_pegaNomePeloIdBd3Retorno = _tabNome;
	} else {
		_BRPVP_pegaNomePeloIdBd3Retorno = [];
		{
			if (_id_bd in (_x select 7) && {(_x select 11) in _id_bd_array}) then {
				_BRPVP_pegaNomePeloIdBd3Retorno pushBack (BRPVP_noExtDB3PlayersTable select 2 select _forEachIndex);
			};
		} forEach (BRPVP_noExtDB3PlayersTable select 1);
		BRPVP_pegaNomePeloIdBd3Retorno = _BRPVP_pegaNomePeloIdBd3Retorno;
	};
	(owner _solicitante) publicVariableClient "BRPVP_pegaNomePeloIdBd3Retorno";
};
BRPVP_adicionaConstrucaoBdFnc = {
	(_this select 1) params ["_mapa","_cons","_estadoCons",["_simpleObj",false]];
	private ["_cId"];
	if (BRPVP_useExtDB3) then {
		_key = format ["0:%1:createVehicle:%2:%3:%4:%5:%6:%7:%8:%9",BRPVP_protocolo,_estadoCons select 0,_estadoCons select 1,_estadoCons select 2,_estadoCons select 3,_estadoCons select 4,_estadoCons select 5,_mapa,_estadoCons select 6];
		_resultado = "extDB3" callExtension _key;
		diag_log "----------------------------------------------------------------------------------";
		diag_log "---- [INSERT: ADD CONSTRUCTION ON DB]";
		diag_log ("---- _key = " + str _key + ".");
		diag_log ("---- _resultado = " + str _resultado + ".");
		
		//PEGA ID DO OBJETO 
		_key = format ["0:%1:getConstructionIdByModelPos:%2:%3",BRPVP_protocolo,_estadoCons select 2,_estadoCons select 1];
		_resultado = "extDB3" callExtension _key;
		_resultadoCompilado = call compile _resultado;
		_cId = _resultadoCompilado select 1 select 0 select 0;
	} else {
		_cId = BRPVP_noExtDB3IdBdVehicles;
		BRPVP_noExtDB3IdBdVehicles = BRPVP_noExtDB3IdBdVehicles + 1;
		(BRPVP_noExtDB3VehiclesTable select 0) pushBack _cId;
		(BRPVP_noExtDB3VehiclesTable select 1) pushBack _estadoCons;
		(BRPVP_noExtDB3VehiclesTable select 2) pushBack _mapa;
	};
	if (_simpleObj) then {
		_cons setVariable ["id_bd",_cId,true];
	} else {
		_cons setVariable ["id_bd",_cId,true];
		_cons call BRPVP_veiculoEhReset;
		if (_mapa) then {
			_cons setVariable ["mapa",true,true];
		};
		if (_cons isKindOf "LandVehicle") then {
			BRPVP_carrosObjetos pushBack _cons;
			BRPVP_newCarAddClients = _cons;
			publicVariable "BRPVP_newCarAddClients";
		};
		if (_cons isKindOf "Air") then {
			BRPVP_helisObjetos pushBack _cons;
			BRPVP_newHeliAddClients = _cons;
			publicVariable "BRPVP_newHeliAddClients";
		};
	};
	diag_log ("---- id_bd got back from db = " + str _cId + ".");
	diag_log "----------------------------------------------------------------------------------";	
};
BRPVP_setaVidaPlayerFnc = {
	[_this select 1 select 0,_this select 1 select 1] call BRPVP_daComoMorto;
};
BRPVP_checaExistenciaPlayerBdFnc = {
	private ["_resultado","_key"];
	_player = _this select 1 select 0;
	_playerId = getPlayerUID _player;
	if (BRPVP_useExtDB3) then {
		_key = format ["0:%1:checkIfPlayerOnDb:%2",BRPVP_protocolo,_playerId];
		_resultado = "extDB3" callExtension _key;
	} else {
		_playerIndex = (BRPVP_noExtDB3PlayersTable select 0) find _playerId;
		_key = "No-BD mode";
		if (_playerIndex != -1) then {
			_resultado = "[1,[["+ str (BRPVP_noExtDB3PlayersTable select 1 select _playerIndex select 8) +"]]]";
		} else {
			_resultado = "[1,[]]";
		};
	};
	diag_log "----------------------------------------------------------------------------------";		
	diag_log "---- " + _playerId;
	diag_log "---- [SELECT: CHECK IF PLAYER IS ON DB AND IS ALIVE]";
	diag_log ("---- _key = " + str _key + ".");
	diag_log ("---- _resultado = " + str _resultado + ".");
	diag_log "----------------------------------------------------------------------------------";	
	if (_resultado == "[1,[[2]]]") then {BRPVP_checaExistenciaPlayerBdRetorno = "no_bd_e_clcmode";};
	if (_resultado == "[1,[[1]]]") then {BRPVP_checaExistenciaPlayerBdRetorno = "no_bd_e_vivo";};
	if (_resultado == "[1,[[0]]]") then {BRPVP_checaExistenciaPlayerBdRetorno = "no_bd_e_morto";};
	if (_resultado == "[1,[]]") then {BRPVP_checaExistenciaPlayerBdRetorno = "nao_ta_no_bd";};
	(owner _player) publicVariableClient "BRPVP_checaExistenciaPlayerBdRetorno";
};
BRPVP_incluiPlayerNoBdFnc = {
	_player = _this select 1 select 0;
	_estadoPLayer = _this select 1 select 1;
	_steamKey = _estadoPLayer select 0;
	if (BRPVP_useExtDB3) then {
		_key = format["0:%1:createPlayer:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14:%15",BRPVP_Protocolo,_steamKey,_estadoPLayer select 1,_estadoPLayer select 2,_estadoPLayer select 3,_estadoPLayer select 4,_estadoPLayer select 5,_estadoPLayer select 6,[],_estadoPLayer select 7,_estadoPLayer select 8,0,_estadoPLayer select 9,_estadoPLayer select 10,_estadoPLayer select 11];
		_resultado = "extDB3" callExtension _key;
		diag_log "----------------------------------------------------------------------------------";	
		diag_log "---- " + (_estadoPLayer select 0);
		diag_log "---- [INSERT A NEW PLAYER ON DB]";
		diag_log "---- PLAYER...";
		diag_log ("---- _key = " + _key + ".");
		diag_log ("---- _resultado = " + str _resultado + ".");

		_key = format ["0:%1:getIdBdBySteamKey:%2",BRPVP_Protocolo,_steamKey];
		_resultado = "extDB3" callExtension _key;
		diag_log "---- ID BD...";
		diag_log ("---- _key = " + _key + ".");
		diag_log ("---- _resultado = " + str _resultado + ".");
		diag_log "----------------------------------------------------------------------------------";
		
		_resultadoCompilado = call compile _resultado;
		BRPVP_incluiPlayerNoBdRetorno = _resultadoCompilado select 1 select 0 select 0;
	} else {
		_estadoPlayer = _player call BRPVP_pegaEstadoPlayer;
		_estadoPlayer set [0,_steamKey];
		_estadoPlayer set [3,[0,[0,0,0]]];
		_estadoPlayer set [11,BRPVP_noExtDB3IdBd];
		(BRPVP_noExtDB3PlayersTable select 0) pushBack _steamKey;
		(BRPVP_noExtDB3PlayersTable select 1) pushBack _estadoPlayer;
		(BRPVP_noExtDB3PlayersTable select 2) pushBack "";
		(BRPVP_noExtDB3PlayersTable select 3) pushBack BRPVP_noExtDB3IdBd;
		BRPVP_incluiPlayerNoBdRetorno = BRPVP_noExtDB3IdBd;
		BRPVP_noExtDB3IdBd = BRPVP_noExtDB3IdBd + 1;
	};
	(owner _player) publicVariableClient "BRPVP_incluiPlayerNoBdRetorno";
};
BRPVP_salvaPlayerFnc = {
	(_this select 1) call BRPVP_salvarPlayerServidor;
};
BRPVP_salvaPlayerVaultFnc = {
	_estadoPlayer = _this select 1 select 0;
	_estadoVault = _this select 1 select 1;
	if (count _estadoPlayer > 0) then {_estadoPlayer call BRPVP_salvarPlayerServidor;};
	_estadoVault call BRPVP_salvarPlayerVaultServidor;
};
BRPVP_pegaValoresContinuaFnc = {
	_player = _this select 1;
	if (BRPVP_useExtDB3) then {
		_key = format ["0:%1:getPlayerNextLifeVals:%2",BRPVP_protocolo,getPlayerUID _player];
		_resultado = "extDB3" callExtension _key;
		diag_log "----------------------------------------------------------------------------------";
		diag_log "---- PLAYER ON DB AND DEAD: GET VALUES TO MANTAIN";
		diag_log ("---- _key = " + _key + ".");
		diag_log ("---- _resultado = " + str _resultado + ".");
		diag_log "----------------------------------------------------------------------------------";
		BRPVP_pegaValoresContinuaRetorno = _resultado;
	} else {
		_playerId = getPlayerUID _player;
		_playerIndex = (BRPVP_noExtDB3PlayersTable select 0) find _playerId;
		if (_playerIndex != -1) then {
			_playerState = BRPVP_noExtDB3PlayersTable select 1 select _playerIndex;
			_friends = _playerState select 7;
			_experience = _playerState select 9;
			_idBd = _playerState select 11;
			_defaultShareType = _playerState select 10;
			_money = _playerState select 12;
			_sit = _playerState select 13;
			BRPVP_pegaValoresContinuaRetorno = str [1,[[_friends,_experience,_idBd,_defaultShareType,_money,_sit]]];

		} else {
			diag_log "[BRPVP NO-DB ERROR] TRIED TO GET NEXT_LIFE_VALUES FOR A PLAYER WITHOU ENTRY.";
		};
	};
	(owner _player) publicVariableClient "BRPVP_pegaValoresContinuaRetorno";
};
BRPVP_pegaPlayerBdFnc = {
	private ["_resultado"];
	_player = _this select 1;
	_pId = getPlayerUID _player;
	if (BRPVP_useExtDB3) then {
		_key = format ["0:%1:getPlayer:%2",BRPVP_protocolo,_pId];
		_resultado = "extDB3" callExtension _key;
		diag_log "----------------------------------------------------------------------------------";
		diag_log "---- " + _pId;
		diag_log "---- [GET PLAYER ON DB]";
		diag_log ("---- _key = " + str _key + ".");
		diag_log ("---- _resultado = " + str _resultado + ".");
		diag_log "----------------------------------------------------------------------------------";	
		BRPVP_pegaPlayerBdRetorno = _resultado;
	} else {
		_playerIndex = (BRPVP_noExtDB3PlayersTable select 0) find _pId;
		if (_playerIndex != -1) then {
			_playerState = BRPVP_noExtDB3PlayersTable select 1 select _playerIndex;
			_resultado = [
				_playerState select 1,
				_playerState select 2,
				_playerState select 3,
				_playerState select 4,
				_playerState select 5,
				_playerState select 6,
				_playerState select 7,
				_playerState select 9,
				_playerState select 11,
				_playerState select 10,
				_playerState select 12,
				_playerState select 13
			];
			BRPVP_pegaPlayerBdRetorno = str [1,[_resultado]];
		} else {
			diag_log "[BRPVP NO-DB ERROR] TRIED TO GET A PLAYER THAT DOES NOT HAVE AN ENTRY.";
		};
	};
	(owner _player) publicVariableClient "BRPVP_pegaPlayerBdRetorno";
};
BRPVP_pegaVaultPlayerBdFnc = {
	_player = _this select 1 select 0;
	_vaultIdx = _this select 1 select 1;
	_pId = getPlayerUID _player;
	if (BRPVP_useExtDB3) then {
		_key = format ["0:%1:getPlayerVault:%2:%3",BRPVP_protocolo,_pId,_vaultIdx];
		_resultado = "extDB3" callExtension _key;
		if (_resultado == "[1,[]]") then {
			diag_log ("[BRPVP GET VAULT] Vault with IDX = " + str _vaultIdx + " not found! _resultado = " + str _resultado + ".");
			diag_log "[BRPVP GET VAULT] Creating Vault.";

			_key = format ["0:%1:createVault:%2:%3:%4:%5:%6",BRPVP_Protocolo,_pId,[[[],[]],[],[[],[]],[[],[]]],1,[],_vaultIdx];
			_resultado = "extDB3" callExtension _key;
			diag_log ("---- CREATED VAULT OF IDX = " + str _vaultIdx + " FOR PLAYER " + name _player + ".");
			diag_log ("---- _key = " + _key + ".");
			diag_log ("---- _resultado = " + str _resultado + ".");
			
			_key = format ["0:%1:getPlayerVault:%2:%3",BRPVP_protocolo,_pId,_vaultIdx];
			_resultado = "extDB3" callExtension _key;
		};
		diag_log "----------------------------------------------------------------------------------";
		diag_log "---- " + _pId;
		diag_log ("---- [GET VAULT GEAR IDX = " + str _vaultIdx + "]");
		diag_log ("---- _key = " + str _key + ".");
		diag_log ("---- _resultado = " + str _resultado + ".");
		diag_log "----------------------------------------------------------------------------------";
		
		BRPVP_pegaVaultPlayerBdRetorno = _resultado;
	} else {
		_ownerIndex = (BRPVP_noExtDB3VaultTable select _vaultIdx select 0) find _pId;
		if (_ownerIndex != -1) then {
			_vaultState = BRPVP_noExtDB3VaultTable select _vaultIdx select 1 select _ownerIndex;
			_inventory = _vaultState select 1;
			_shareType = _vaultState select 2;
			BRPVP_pegaVaultPlayerBdRetorno = str [1,[[_inventory,_shareType,_vaultIdx]]];
		} else {
			(BRPVP_noExtDB3VaultTable select _vaultIdx select 0) pushBack _pId;
			(BRPVP_noExtDB3VaultTable select _vaultIdx select 1) pushBack [_pId,[[[],[]],[],[[],[]],[[],[]]],1];
			BRPVP_pegaVaultPlayerBdRetorno = str [1,[[[[[],[]],[],[[],[]],[[],[]]],1,_vaultIdx]]];
		};		
	};
	if (owner _player == BRPVP_playerOwner) then {["",BRPVP_pegaVaultPlayerBdRetorno] call BRPVP_pegaVaultPlayerBdRetornoFnc;} else {(owner _player) publicVariableClient "BRPVP_pegaVaultPlayerBdRetorno";};
};
BRPVP_salvaVeiculoBdFnc = {
	_carros = _this select 1;
	{
		_x call BRPVP_salvaVeiculo;
	} forEach _carros;
};

//PVEH
"BRPVP_spawnZombiesServerFromClient" addPublicVariableEventHandler {_this call BRPVP_spawnZombiesServerFromClientFnc;};
"BRPVP_serverOrderAIAttack" addPublicVariableEventHandler {_this call BRPVP_serverOrderAIAttackFnc;};
"BRPVP_serverGraphHintPlayer" addPublicVariableEventHandler {_this call BRPVP_serverGraphHintPlayerFnc;};
"BRPVP_serverStillSurrendedCheck" addPublicVariableEventHandler {_this call BRPVP_serverStillSurrendedCheckFnc;};
"BRPVP_serverRemoveTurret" addPublicVariableEventHandler {_this call BRPVP_serverRemoveTurretFnc;};
"BRPVP_addVehicleMPKilled" addPublicVariableEventHandler {_this call BRPVP_addVehicleMPKilledFnc;};
"BRPVP_askServerRemoveSomeoneStuff" addPublicVariableEventHandler {_this call BRPVP_askServerRemoveSomeoneStuffFnc;};
"BRPVP_askServerForDestructionLog" addPublicVariableEventHandler {_this call BRPVP_askServerForDestructionLogFnc;};
"BRPVP_onlyOwnedHousesAskFor" addPublicVariableEventHandler {_this call BRPVP_onlyOwnedHousesAskForFnc;};
"BRPVP_setTerrainGridServer" addPublicVariableEventHandler {_this call BRPVP_setTerrainGridServerFnc;};
"BRPVP_countPlayerConnection" addPublicVariableEventHandler {_this call BRPVP_countPlayerConnectionFnc;};
"BRPVP_askPlayersToUpdateFriendsServer" addPublicVariableEventHandler {_this call BRPVP_askPlayersToUpdateFriendsServerFnc;};
"BRPVP_addWalkerIconsServer" addPublicVariableEventHandler {_this call BRPVP_addWalkerIconsServerFnc;};
"BRPVP_setSimulation" addPublicVariableEventHandler {_this call BRPVP_setSimulationFnc;};
"BRPVP_sendAgentConfigToClientAskServer" addPublicVariableEventHandler {_this call BRPVP_sendAgentConfigToClientAskServerFnc;};
"BRPVP_setAutoTurretServer" addPublicVariableEventHandler {_this call BRPVP_setAutoTurretServerFnc;};
"BRPVP_saveLightStateDb" addPublicVariableEventHandler {_this call BRPVP_saveLightStateDbFnc;};
"BRPVP_iAskForAllInitialVars" addPublicVariableEventHandler {_this call BRPVP_iAskForAllInitialVarsFnc;};
"BRPVP_setWeatherServer" addPublicVariableEventHandler {_this call BRPVP_setWeatherServerFnc;};
"BRPVP_setTimeMultiplierSV" addPublicVariableEventHandler {_this call BRPVP_setTimeMultiplierSVFnc;};
"BRPVP_setDateSV" addPublicVariableEventHandler {_this call BRPVP_setDateSVFnc;};
"BRPVP_runCorruptMissSpawn" addPublicVariableEventHandler {_this call BRPVP_runCorruptMissSpawnFnc;};
"BRPVP_mudouConfiancaEmVoceSV" addPublicVariableEventHandler {_this call BRPVP_mudouConfiancaEmVoceSVFnc;};
"BRPVP_convoyRun" addPublicVariableEventHandler {_this call BRPVP_convoyRunFnc;};
"BRPVP_giveMoneySV" addPublicVariableEventHandler {_this call BRPVP_giveMoneySVFnc;};
"BRPVP_hideObjectSv" addPublicVariableEventHandler {_this call BRPVP_hideObjectSvFnc;};
"BRPVP_switchMoveSv" addPublicVariableEventHandler {_this call BRPVP_switchMoveSvFnc;};
"BRPVP_corpseToDelAdd" addPublicVariableEventHandler {_this call BRPVP_corpseToDelAddFnc;};
"BRPVP_bravoRun" addPublicVariableEventHandler {_this call BRPVP_bravoRunFnc;};
"BRPVP_siegeRun" addPublicVariableEventHandler {_this call BRPVP_siegeRunFnc;};
"BRPVP_moveInServer" addPublicVariableEventHandler {_this call BRPVP_moveInServerFnc;};
"BRPVP_avisaExplosao" addPublicVariableEventHandler {_this call BRPVP_avisaExplosaoFnc;};
"BRPVP_desviraVeiculo" addPublicVariableEventHandler {_this call BRPVP_desviraVeiculoFnc;};
"BRPVP_rapelRopeUnwindPV" addPublicVariableEventHandler {_this call BRPVP_rapelRopeUnwindPVFnc;};
"BRPVP_ownedHousesSolicita" addPublicVariableEventHandler {_this call BRPVP_ownedHousesSolicitaFnc;};
"BRPVP_ownedHousesAdd" addPublicVariableEventHandler {_this call BRPVP_ownedHousesAddFnc;};
"BRPVP_svCriaVehEnvio" addPublicVariableEventHandler {_this call BRPVP_svCriaVehEnvioFnc;};
"BRPVP_amigosAtualizaServidor" addPublicVariableEventHandler {_this call BRPVP_amigosAtualizaServidorFnc;};
"BRPVP_pegaTop10Estatistica" addPublicVariableEventHandler {_this call BRPVP_pegaTop10EstatisticaFnc;};
"BRPVP_mudaExpOutroPlayer" addPublicVariableEventHandler {_this call BRPVP_mudaExpOutroPlayerFnc;};
"BRPVP_salvaNomePeloIdBd" addPublicVariableEventHandler {_this call BRPVP_salvaNomePeloIdBdFnc;};
"BRPVP_pegaNomePeloIdBd1" addPublicVariableEventHandler {_this call BRPVP_pegaNomePeloIdBd1Fnc;};
"BRPVP_pegaNomePeloIdBd2" addPublicVariableEventHandler {_this call BRPVP_pegaNomePeloIdBd2Fnc;};
"BRPVP_pegaNomePeloIdBd3" addPublicVariableEventHandler {_this call BRPVP_pegaNomePeloIdBd3Fnc;};
"BRPVP_adicionaConstrucaoBd" addPublicVariableEventHandler {_this call BRPVP_adicionaConstrucaoBdFnc;};
"BRPVP_setaVidaPlayer" addPublicVariableEventHandler {_this call BRPVP_setaVidaPlayerFnc;};
"BRPVP_checaExistenciaPlayerBd" addPublicVariableEventHandler {_this call BRPVP_checaExistenciaPlayerBdFnc;};
"BRPVP_incluiPlayerNoBd" addPublicVariableEventHandler {_this call BRPVP_incluiPlayerNoBdFnc;};
"BRPVP_salvaPlayer" addPublicVariableEventHandler {_this call BRPVP_salvaPlayerFnc;};
"BRPVP_salvaPlayerVault" addPublicVariableEventHandler {_this call BRPVP_salvaPlayerVaultFnc;};
"BRPVP_pegaValoresContinua" addPublicVariableEventHandler {_this call BRPVP_pegaValoresContinuaFnc;};
"BRPVP_pegaPlayerBd" addPublicVariableEventHandler {_this call BRPVP_pegaPlayerBdFnc;};
"BRPVP_pegaVaultPlayerBd" addPublicVariableEventHandler {_this call BRPVP_pegaVaultPlayerBdFnc;};
"BRPVP_salvaVeiculoBd" addPublicVariableEventHandler {_this call BRPVP_salvaVeiculoBdFnc;};