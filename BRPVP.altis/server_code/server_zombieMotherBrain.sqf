//=========
//VARIAVEIS
//=========
_agnts = [];
_agntsAct = [];
_agntsArg = [];
_time = time;
BRPVP_addZombieBrainSV = [];
BRPVP_removeZombieBrainSV = [];
BRPVP_changeZombieOwnerSV = [];
BRPVP_cleanZombieCorpseSV = [];
BRPVP_zombieToServerFailed = [];
BRPVP_zombiePlayersAttacked = [];
BRPVP_zombiePlayersAttackedUnits = [];
BRPVP_zombieLocalEH = {
	_agnt = _this;
	_idx1 = -1;
	_idx2 = -1;
	{
		_found = _x find _agnt;
		if (_found != -1) exitWith {
			_idx1 = _forEachIndex;
			_idx2 = _found;
		};
	} forEach BRPVP_zombiePlayersAttackedUnits;
	if (_idx1 != -1) then {(BRPVP_zombiePlayersAttackedUnits select _idx1) deleteAt _idx2;};
	if (!alive _agnt) then {
		if ((_agnt getVariable "ifz") select 1) then {
			BRPVP_addZombieBrainSV pushBack _agnt;
		} else {
			deleteVehicle _agnt;
		};
	} else {
		_nearPlayers = _agnt nearEntities [BRPVP_playerModel,150];
		{
			if (_x distance _agnt < 200) then {
				_nearPlayers pushBack _x;
			};
		} forEach BRPVP_playerVehicles;
		for "_i" from ((count _nearPlayers) - 1) to 0 step -1 do {
			if (!isPlayer (_nearPlayers select _i)) then {
				_nearPlayers deleteAt _i;
			};
		};
		if (count _nearPlayers == 0) then {
			if ((_agnt getVariable "ifz") select 1) then {
				_agnt spawn {
					sleep random 1;
					BRPVP_addZombieBrainSV pushBack _this;
				};
			} else {
				_agnt spawn {
					sleep random 1;
					/*
					_bomb = createVehicle ["B_20mm",_this modeltoworld [0,0,0],[],0,"CAN_COLLIDE"];
					_bomb setVectorDirAndUp [[0,0,-1],[0,1,0]];
					_bomb setVelocity [0,0,-1000];
					*/
					deleteVehicle _this;
				};
			};
		} else {
			_nearPlayers = _nearPlayers apply {[_x distanceSqr _agnt,_x]};
			_nearPlayers sort true;
			BRPVP_changeZombieOwnerSV pushBack [_agnt,_nearPlayers select 0 select 1];
		};
	};
};
BRPVP_fixedZombiesAgregateProximityCheck = BRPVP_fixedZombiesAgregateProximityCheck^2;

//========================================
//FUNCOES DE MOVIMENTO E ACAO - AUXILIARES
//========================================
_addAgent = {
	private ["_agnt"];
	_agnt = _this;
	_agnt addRating (20000 - (rating _agnt));
	if (alive _agnt) then {
		_agnt allowDamage false;
		_pos = getPosASL _agnt;
		_agnt moveTo ASLToAGL getPosASL _agnt;
		_agnt hideObjectGlobal true;
		_agnt enableSimulationGlobal false;
		/*
		_bomb = createVehicle ["B_20mm",_agnt modeltoworld [0,0,0],[],0,"CAN_COLLIDE"];
		_bomb setVectorDirAndUp [[0,0,-1],[0,1,0]];
		_bomb setVelocity [0,0,-1000];
		*/
		/*
		_pole = createSimpleObject ["Land_Slums01_pole",_pos];
		_pole setDir random 360;
		_surfaceNormal = vectorNormalized ((surfaceNormal _pos) vectorAdd ([[0,0,0],random 0.2,random 360] call BIS_fnc_relPos));
		_pole setVectorUp _surfaceNormal;
		_skull = createSimpleObject ["Land_HumanSkull_F",[0,0,0]];
		_skull setDir random 360;
		_skull setVectorUp _surfaceNormal;
		_skull setPosWorld ((getPosWorld _pole) vectorAdd (_surfaceNormal vectorMultiply (0.5 + random 0.5)));
		_agnt setVariable ["brpvp_pole",[_pole,_skull],false];
		*/
		_nearPal = objNull;
		{if (_agnt distanceSqr _x <= BRPVP_fixedZombiesAgregateProximityCheck) exitWith {_nearPal = _x;};} forEach _agnts;
		if (isNull _nearPal) then {
			_agnt setVariable ["brpvp_agregate",[],false];
			_agnt setVariable ["brpvp_distCheck",100 + random 100,false];
			_agnts pushBack _agnt;
			_agntsAct pushBack 1;
			_agntsArg pushBack [_time,15 + random 30,_time,eyePos _agnt,ASLToAGL getPosASL _agnt,3];
		} else {
			_newAgregate = _nearPal getVariable ["brpvp_agregate",[]];
			_newAgregate pushBack _agnt;
			_nearPal setVariable ["brpvp_agregate",_newAgregate,false];
		};
	} else {
		BRPVP_cleanZombieCorpseSV pushBack [_time,ASLtoAGL getPosASL _agnt,uniform _agnt,_agnt getVariable "ifz",typeOf _agnt];
		deleteVehicle _agnt;
	};
};
_thereIsPlayerNear = {
	params ["_dist","_distVehQuad"];
	_return = false;
	_nearEntities = _posAtl nearEntities [BRPVP_playerModel,_dist];
	if (count _nearEntities > 0) then {
		_return = {_x getVariable "sok"} count _nearEntities > 0;
	} else {
		{
			if (_posAtl distanceSqr _x < _distVehQuad && {isPlayer _x}) exitWith {
				_return = true;
			};
		} forEach BRPVP_playerVehicles;
	};
	_return
};
_searchForATarget = {
	params ["_dist","_distVeh"];
	_nearPlayers = _agnt nearEntities [BRPVP_playerModel,_dist];
	{if (_x distance _agnt < _distVeh) then {_nearPlayers pushBack _x;};} forEach BRPVP_playerVehicles;
	_nearPlayersSOK = [];
	{
		if (_x getVariable "sok") then {_nearPlayersSOK pushBack _x;};
	} forEach _nearPlayers;
	if (count _nearPlayersSOK == 0) then {objNull} else {_nearPlayersSOK call BIS_fnc_selectRandom};
};
_reviveZombie = {
	private ["_agnt"];
	_agnt = createAgent [_this select 4,_this select 1,[],0,"CAN_COLLIDE"];
	_agnt call BRPVP_pelaUnidade;
	_agnt addUniform (_this select 2);
	_agnt setVariable ["ifz",_this select 3,true];
	{_agnt setHit [_x,0.8];} forEach ["body","spine1","spine2","spine3"];
	{_agnt setHit [_x,0.9];} forEach ["face_hub","neck","head","arms","hands"];
	_agnt setVariable ["dmg",0,true];
	_agnt setVariable ["brpvp_impact_damage",0,true];
	_agnt forceSpeed (_agnt getSpeed "FAST");
	_agnt
};

//========================================
//FUNCOES DE MOVIMENTO E ACAO - PRINCIPAIS
//========================================
_BRPVP_walkerAcao1 = {
	_agnt = _agnts select _this;
	(_agntsArg select _this) params ["_ini1","_wait1","_ini2","_eyePos","_posATL","_mult"];
	if (_time - _ini1 > _wait1) then {
		_pTarget = [(_agnt getVariable "brpvp_distCheck")*_mult,200*_mult] call _searchForATarget;
		if (isNull _pTarget) then {
			(_agntsArg select _this) set [0,_time];
			(_agntsArg select _this) set [1,(3 + random 3) * _mult];
		} else {
			if (_mult == 1) then {
				BRPVP_removeZombieBrainSV pushBack _agnt;
				_agreg = _agnt getVariable ["brpvp_agregate",[]];
				_agreg pushBack _agnt;
				[_agreg,_pTarget] spawn {
					params ["_agreg","_pTarget"];
					_agreg = _agreg apply {[_x distanceSqr _pTarget,_x]};
					_agreg sort true;
					_max = count _agreg;
					{
						_agnt = _x select 1;
						sleep (0.1 - 0.1 * (_forEachIndex + 1)/_max + random 0.35 - 0.25 * (_forEachIndex + 1)/_max);
						_bomb = createVehicle ["B_20mm",_agnt modeltoworld [0,0,0],[],0,"CAN_COLLIDE"];
						_bomb setVectorDirAndUp [[0,0,-1],[0,1,0]];
						_bomb setVelocity [0,0,-1000];
						//{deleteVehicle _x;} forEach (_agnt getVariable "brpvp_pole");
						_agnt hideObjectGlobal false;
						_agnt enableSimulationGlobal true;
						BRPVP_changeZombieOwnerSV pushBack [_agnt,_pTarget];
					} forEach _agreg;
				};
			} else {
				(_agntsArg select _this) set [5,(_mult - 1) max 1];
			};
		};
	} else {
		if (_time - _ini2 > 10) then {
			(_agntsArg select _this) set [2,_time];
			(_agntsArg select _this) set [5,(_mult + 1) min 3];
		};
	};
};

//=============
//FIXED ZOMBIES
//=============
call compile preprocessFileLineNumbers "server_code\server_zombieFixedSpawn.sqf";
BRPVP_serverCanContinue = true;

//==========
//LOOP GERAL
//==========
_init = time;
_initA = time;
if (hasInterface) then {waitUntil {!isNil "BRPVP_listenServerCliOk"};};
waitUntil {
	_time = time;
	if (_time - _init > 0.5) then {
		{
			_agnt = _x;
			if (alive _agnt) then {
				_idc = _forEachIndex;
				_acao = _agntsAct select _idc;
				if (_acao == 1) then {_idc call _BRPVP_walkerAcao1;};
			} else {
				BRPVP_removeZombieBrainSV pushBack _agnt;
				BRPVP_cleanZombieCorpseSV pushBack [_time,ASLtoAGL getPosASL _agnt,uniform _agnt,_agnt getVariable "ifz",typeOf _agnt];
				//{deleteVehicle _x;} forEach (_x getVariable ["brpvp_pole",[objNull,objNull]]);
				deleteVehicle _agnt;
			};
		} forEach _agnts;

		//ADD ZOMBIE BRAIN
		_added = [];
		{
			_x call _addAgent;
			_added pushBack _forEachIndex;
		} forEach BRPVP_addZombieBrainSV;
		_added sort false;
		{BRPVP_addZombieBrainSV deleteAt _x;} forEach _added;
		
		//REMOVE ZOMBIE BRAIN
		{
			_index = _agnts find _x;
			_agnts deleteAt _index;
			_agntsAct deleteAt _index;
			_agntsArg deleteAt _index;
		} forEach BRPVP_removeZombieBrainSV;
		BRPVP_removeZombieBrainSV = [];

		//CHANGE ZOMBIE LOCALITY
		_transfered = [];
		{
			_x params ["_agnt","_player"];
			_localN = _player getVariable ["brpvp_local_zombie_flag",0];
			_player setVariable ["brpvp_local_zombie_flag",(_localN + 1) mod BRPVP_zombiesHostOnServerRatio,false];
			_owner = owner _player;
			_local = _localN != 0;
			_nid = if (_local) then {_owner} else {2};
			
			//TEST TEST TEST
			_agnt allowDamage true;
			
			_ok = if (_local) then {_agnt setOwner _nid} else {true};
			_id_bd = _player getVariable "id_bd";
			_idx = BRPVP_zombiePlayersAttacked find _id_bd;
			if (_idx == -1) then {
				BRPVP_zombiePlayersAttacked pushBack _id_bd;
				BRPVP_zombiePlayersAttackedUnits pushBack [_agnt];
			} else {
				(BRPVP_zombiePlayersAttackedUnits select _idx) pushBack _agnt;
			};
			_agnt setVariable ["brpvp_targetMustBe",_player,true];
			if (_ok) then {BRPVP_sendAgentConfigToClient = [[_agnt,_nid]];} else {BRPVP_sendAgentConfigToClient = [[_agnt,2]];};
			if (_nid == 2 || !_ok) then {
				_agnt disableAI "FSM";
				_agnt disableAI "AUTOCOMBAT";
				_agnt disableAI "AUTOTARGET";
				_agnt disableAI "TARGET";
				_agnt setBehaviour "CARELESS";
				_agnt addRating (-20000 - (rating _agnt));
				{_x reveal [_agnt,4];} forEach (_agnt nearEntities ["CaManBase",350]);
			};
			if (_player isEqualTo player) then {["",BRPVP_sendAgentConfigToClient] call BRPVP_sendAgentConfigToClientFnc;} else {_owner publicVariableClient "BRPVP_sendAgentConfigToClient";};
			_transfered pushBack _forEachIndex;
		} forEach BRPVP_changeZombieOwnerSV;
		_transfered sort false;
		{BRPVP_changeZombieOwnerSV deleteAt _x;} forEach _transfered;	

		//CLEAN AI AND REVIVE FIXED ZOMBIES
		if (_time - _initA > 30) then {
			_initA = _time;
			
			//REVIVE FIXED ZOMBIES
			_zombiesRevived = [];
			_zombiesRevivedIndex = [];
			{
				if (_time - (_x select 0) > BRPVP_fixedZombiesReviveTime) then {
					_posAtl = (_x select 1);
					_noPlayerNear = !([500,250000] call _thereIsplayerNear);
					if (_noPlayerNear) then {
						_zombiesRevived pushBack (_x call _reviveZombie);
						_zombiesRevivedIndex pushBack _forEachIndex;
					};
				};
			} forEach BRPVP_cleanZombieCorpseSV;
			if (count _zombiesRevived > 0) then {
				["",_zombiesRevived] call BRPVP_addWalkerIconsServerFnc;
				BRPVP_addZombieBrainSV append _zombiesRevived;
				_zombiesRevivedIndex sort false;
				{BRPVP_cleanZombieCorpseSV deleteAt _x;} forEach _zombiesRevivedIndex;
			};

			//CLEAN AI
			_AIToDelete = [];
			{
				_posAtl = ASLToAGL getPosASL _x;
				_noPlayerNear = !([1500,2250000] call _thereIsplayerNear);
				if (_noPlayerNear) then {
					_AIToDelete pushBack _x;
				};
			} forEach BRPVP_addAIonCleanProcess;
			BRPVP_addAIonCleanProcess = BRPVP_addAIonCleanProcess - _AIToDelete;
			{
				_toDel = _x getVariable ["brpvp_del_on_clean",objNull];
				if (!isNull _toDel) then {deleteVehicle _toDel;};
				deleteVehicle _x;
			} forEach _AIToDelete;
		};
	};

	false
};