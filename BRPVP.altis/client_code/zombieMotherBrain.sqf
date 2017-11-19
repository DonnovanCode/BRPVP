//=========
//VARIAVEIS
//=========
_agnts = [];
_agntsAct = [];
_agntsArg = [];
_agntsTarget = [];
_time = time;
_maxDistanceAI = 200;
_maxDistanceAILimit = 600;
_zombieSoundsScream = ["zombie_snd_1","zombie_snd_2","zombie_snd_3","zombie_snd_4","zombie_snd_5","zombie_snd_6","zombie_snd_7","zombie_snd_8","zombie_snd_9","zombie_snd_10","zombie_snd_11","zombie_snd_12","zombie_snd_13","zombie_snd_14","zombie_snd_15","zombie_snd_16","zombie_snd_17","zombie_snd_18","zombie_snd_19","zombie_snd_20","zombie_snd_21","zombie_snd_22","zombie_snd_23","zombie_snd_24"];
BRPVP_addZombieBrain = [];
BRPVP_removeZombieBrain = [];
BRPVP_changeZombieOwner = [];
BRPVP_waitZombieToFallAndContinue = [];

//========================================
//FUNCOES DE MOVIMENTO E ACAO - AUXILIARES
//========================================
BRPVP_zombieMoveTo = {
	params ["_agnt","_pos","_look"];
	if (isNull (_agnt getVariable ["brpvp_my_distract_object",objNull])) then {
		if (_agnt getVariable "brpvp_locality_nid" != 2) then {
			if (!_moveToCompleted) then {_agnt moveTo (ASLToAGL getPosASL _agnt);};
			_agnt moveTo _pos;
			if (_look) then {_agnt doWatch (_pos vectorAdd [0,0,100]);};
		} else {
			if (!_moveToCompleted) then {[_agnt,ASLToAGL getPosASL _agnt] remoteExec ["moveTo",_nid,false];};
			[_agnt,_pos] remoteExec ["moveTo",_nid,false];
			if (_look) then {[_agnt,_pos vectorAdd [0,0,100]] remoteExec ["doWatch",_nid,false];};
		};
		_agnt setVariable ["brpvp_lastMovePos",_pos,false];
	};
};
BRPVP_zombieSay = {
	params ["_agnt","_sound"];
	[_agnt,_sound] remoteExec ["say3D",-2,false];
};
BRPVP_zombieSetUnitPos = {
	params ["_agnt","_unitPos"];
	if (_agnt getVariable "brpvp_locality_nid" != 2) then {_agnt setUnitPos _unitPos;} else {_this remoteExec ["setUnitPos",_nid,false];};
};
BRPVP_zombiePlayMoveNow = {
	params ["_agnt","_move"];
	if (_agnt getVariable "brpvp_locality_nid" != 2) then {_agnt playMoveNow _move;} else {_this remoteExec ["playMoveNow",_nid,false];};
};
BRPVP_zombieDoWatch = {
	params ["_agnt","_posToWatch"];
	if (_agnt getVariable "brpvp_locality_nid" != 2) then {_agnt doWatch _posToWatch;} else {_this remoteExec ["doWatch",_nid,false];};
};
BRPVP_zombieReveal = {
	params ["_agnt","_targetToReveal"];
	if (_agnt getVariable "brpvp_locality_nid" != 2) then {_agnt reveal _targetToReveal;} else {_this remoteExec ["reveal",_nid,false];};
};
BRPVP_zombieSetDir = {
	params ["_agnt","_dir"];
	if (_agnt getVariable "brpvp_locality_nid" != 2) then {_agnt setDir _dir;} else {_this remoteExec ["setDir",_nid,false];};
};
BRPVP_zombieAllowDamage = {
	params ["_agnt","_allow"];
	if (_agnt getVariable "brpvp_locality_nid" != 2) then {_agnt allowDamage _allow;} else {_this remoteExec ["allowDamage",_nid,false];};
};
_addAgent = {
	private ["_agnt"];
	_agnt = _this;
	_setTarget = _agnt getVariable ["brpvp_targetMustBe",objNull];
	if (!isNull _setTarget) then {
		[_agnt,_setTarget] call _addAgentFinalize;
		_agnt setVariable ["brpvp_targetMustBe",objNull,true];
	} else {
		_nearMans = (player nearEntities ["CaManBase",_maxDistanceAI]) - (player nearEntities [["C_man_polo_1_F","C_man_sport_1_F_afro","C_man_p_beggar_F"],_maxDistanceAI]);
		if (count _nearMans == 0) then {
			{
				if (_x distance _agnt < _maxDistanceAI && {isPlayer _x}) then {_nearMans pushBack _x;};
			} forEach BRPVP_playerVehicles;
		};
		if (count _nearMans == 0) then {_nearMans = [player];};
		_target = _nearMans call BIS_fnc_selectRandom;
		if (isPlayer _target) then {
			if (_target isEqualTo player) then {
				[_agnt,player] call _addAgentFinalize;
			} else {
				_agnt setVariable ["brpvp_targetMustBe",_target,true];
				BRPVP_changeZombieOwner pushBack [_agnt,_target];
			};
		} else {
			[_agnt,_target] call _addAgentFinalize;
		};
	};
};
_addAgentFinalize = {
	params ["_agnt","_target"];
	if (_agnt getVariable "brpvp_locality_nid" != 2) then {
		_agnt disableAI "FSM";
		_agnt disableAI "AUTOCOMBAT";
		_agnt disableAI "AUTOTARGET";
		_agnt disableAI "TARGET";
		_agnt setBehaviour "CARELESS";
		_agnt addRating (-20000 - (rating _agnt));
		{_x reveal [_agnt,4];} forEach (_agnt nearEntities ["CaManBase",350]);
	};
	_agnt setVariable ["jpg",false,true];
	_agnt setVariable ["knl",random 1 < BRPVP_percentageOfJumpingZombies,true];
	_agnt setVariable ["brpvp_noMoveCount",0,false];
	_nid = _agnt getVariable "brpvp_locality_nid";
	if (_agnt getVariable "knl") then {
		[_agnt,"AmovPknlMrunSnonWnonDf"] call BRPVP_zombiePlayMoveNow;
		[_agnt,"MIDDLE"] call BRPVP_zombieSetUnitPos;
	} else {
		[_agnt,"AmovPercMrunSnonWnonDf"] call BRPVP_zombiePlayMoveNow;
		[_agnt,"UP"] call BRPVP_zombieSetUnitPos;
	};
	_agnts pushBack _agnt;
	_agntsAct pushBack 1;
	_agntsArg pushBack [0,_time,_time,random 1];
	if !(_target in _agntsTarget) then {_target setVariable ["brpvp_safeMovePos",_target call _findSafePos,false];};
	_agntsTarget pushBack _target;
	_target setVariable ["brpvp_zombies_on_me",(_target getVariable ["brpvp_zombies_on_me",0]) + 1,true];
	_firstMovePos = (_target getVariable "brpvp_safeMovePos") call BIS_fnc_selectRandom;
	_agnt setVariable ["brpvp_lastMovePos",_firstMovePos,false];
	_moveToCompleted = false;
	[_agnt,_firstMovePos,true] call BRPVP_zombieMoveTo;
	[_agnt,true] call BRPVP_zombieAllowDamage;
	if (!isPlayer _target) then {[_target,[_agnt,4]] call BRPVP_zombieReveal;};
};
_setZombieNewDestine = {
	params ["_newTarget","_index"];
	if (isNull _newTarget) then {
		_agnt setVariable ["hmlr",_time -5 + random 1,false];
		BRPVP_removeZombieBrain pushBack _agnt;
		BRPVP_waitZombieToFallAndContinue pushBack _agnt;
	} else {
		if (isPlayer _newTarget) then {
			if (_newTarget isEqualTo player) then {
				_agntsAct set [_index,1];
				_agntsArg set [_index,[0,_time,_time,random 1]];
				_target = _agntsTarget select _index;
				if !(_newTarget in _agntsTarget) then {_newTarget setVariable ["brpvp_safeMovePos",_newTarget call _findSafePos,false];};
				_target setVariable ["brpvp_zombies_on_me",(_target getVariable ["brpvp_zombies_on_me",0]) - 1,true];
				_agntsTarget set [_index,_newTarget];
				_newTarget setVariable ["brpvp_zombies_on_me",(_newTarget getVariable ["brpvp_zombies_on_me",0]) + 1,true];
				[_agnt,ASLToAGL getPosASL _newTarget,true] call BRPVP_zombieMoveTo;
			} else {
				_agnt setVariable ["brpvp_targetMustBe",_newTarget,true];
				BRPVP_removeZombieBrain pushBack _agnt;
				BRPVP_changeZombieOwner pushBack [_agnt,_newTarget];
			};
		} else {
			if (player distance _newTarget < _maxDistanceAI) then {
				_agntsAct set [_index,1];
				_agntsArg set [_index,[0,_time,_time,random 1]];
				_target = _agntsTarget select _index;
				if !(_newTarget in _agntsTarget) then {_newTarget setVariable ["brpvp_safeMovePos",_newTarget call _findSafePos,false];};
				_target setVariable ["brpvp_zombies_on_me",(_target getVariable ["brpvp_zombies_on_me",0]) - 1,true];
				_agntsTarget set [_index,_newTarget];
				_newTarget setVariable ["brpvp_zombies_on_me",(_newTarget getVariable ["brpvp_zombies_on_me",0]) + 1,true];
				[_newTarget,[_agnt,4]] call BRPVP_zombieReveal;
				[_agnt,ASLToAGL getPosASL _newTarget,true] call BRPVP_zombieMoveTo;
			} else {
				_host = _newTarget call _findHostForAIZombie;
				if (!isNull _host) then {
					_agnt setVariable ["brpvp_targetMustBe",_newTarget,true];
					BRPVP_removeZombieBrain pushBack _agnt;
					BRPVP_changeZombieOwner pushBack [_agnt,_host];
				} else {
					_agnt setVariable ["hmlr",time -5 + random 1,false];
					BRPVP_removeZombieBrain pushBack _agnt;
					BRPVP_waitZombieToFallAndContinue pushBack _agnt;
				};
			};
		};
	};
};
_findHostForAIZombie = {
	_allPlayers = (_this nearEntities [BRPVP_playerModel,_maxDistanceAI]) apply {if (_x getVariable "sok") then {[_x distance _this,_x]} else {-1}};
	_allPlayers = _allPlayers - [-1];
	_allPlayers sort true;
	if (count _allPlayers > 0) then {_allPlayers select 0 select 1} else {objNull};
};
_findSafePos = {
	_posTarget = ASLToAGL getPosASL _this;
	_posUnitAbove = AGLToASL (_posTarget vectorAdd [0,0,1]);
	_angle = round random 360;
	_safeMovePos = [];
	_found = 0;
	{
		_tryPos = [_posUnitAbove,1.5,_angle + _x] call BIS_fnc_relPos;
		_lis = lineIntersectsSurfaces [_posUnitAbove,_tryPos,_this,objNull,true,1,"GEOM","FIRE"];
		if (count _lis == 0) then {
			_safeMovePos pushBack ([_posTarget,1,_angle + _x] call BIS_fnc_relPos);
			_found = _found + 1;
		};
		if (_found == 6) exitWith {};
	} forEach [0,90,180,270,330,60,150,240,300,30,120,210];
	if (count _safeMovePos == 0) then {_safeMovePos pushBack _posTarget;};
	_safeMovePos
};
_searchForATarget = {
	params ["_dist","_distVehQuad","_exclude","_targetUnknow"];
	_target = objNull;
	_nearEntities = (_agnt nearEntities ["CaManBase",_dist]) - (_agnt nearEntities [["C_man_polo_1_F","C_man_sport_1_F_afro","C_man_p_beggar_F"],_dist]);
	_nearPlayers = [];
	if (count _nearEntities > 0) then {
		_nearPlayers = (_nearPlayers apply {if (isPlayer _x && !(_x getVariable "sok")) then {-1} else {_x}}) - [-1];
		_nearPlayers = _nearEntities;
	} else {
		{
			if (_x distanceSqr _agnt < _distVehQuad) then {
				_nearPlayers pushBack _x;
			};
		} forEach BRPVP_playerVehicles;
	};
	if (count _exclude > 0) then {_nearPlayers = _nearPlayers - _exclude;};
	_eyePosAbove = (eyePos _agnt) vectorAdd [0,0,0.5];
	_minDist = 100000000;
	_zombiesOn = _uTarget getVariable ["brpvp_zombies_on_me",0];
	{
		_zombiesOnDestine = _x getVariable ["brpvp_zombies_on_me",0];
		_isPlayer = isPlayer _x;
		_more = _zombiesOn - _zombiesOnDestine;
		if (_targetUnknow || {_isPlayer && _more > 1 || {!_isPlayer && _more > 1 && _zombiesOnDestine < 5}}) then {
			_dist = _x distanceSqr _agnt;
			if (_dist < _minDist) then {
				_isVisible = [vehicle _x,"VIEW"] checkVisibility [_eyePosAbove,(eyepos _x) vectorAdd [0,0,0.5]] > 0.5;
				if (_isVisible) then {
					_minDist = _dist;
					_target = _x;
				};
			};
		};
	} forEach _nearPlayers;
	_target
};
_canSeeUnitTarget = {
	_see = false;
	if (_uTarget getVariable ["dd",-1] < 1) then {
		//if (_agnt distanceSqr _uTarget < 40000) then {
		if (_dist < 40000) then {
			_isVisible = [vehicle _uTarget,"VIEW"] checkVisibility [(eyepos _agnt) vectorAdd [0,0,0.5],(eyepos _uTarget) vectorAdd [0,0,0.5]] > 0.5;
			if (_isVisible) then {_see = true;};
		};
	};
	_see
};

//========================================
//FUNCOES DE MOVIMENTO E ACAO - PRINCIPAIS
//========================================

_BRPVP_walkerAcao1 = {
	_agnt = _agnts select _this;
	_uTarget = _agntsTarget select _this;
	_walked = _uTarget getVariable ["brpvp_walked",true];
	(_agntsArg select _this) params ["_ini1","_ini2","_fim"];
	if (_fim - _time < 0 && {!(_agnt getVariable "jpg")}) then {
		(_agntsArg select _this) set [2,_time + 5 + random 10 + _countAgnts * 0.1];
		[_agnt,[_zombieSoundsScream call BIS_fnc_selectRandom,300]] call BRPVP_zombieSay;
	};
	if ((_time - _ini1 > 5 || _moveToCompleted || _walked) && {!(_agnt getVariable "jpg")}) then {
		(_agntsArg select _this) set [0,_time];
		if (_uTarget getVariable ["dd",-1] < 1) then {
			_dist = _agnt distanceSqr _uTarget;
			_seeTarget = call _canSeeUnitTarget;
			if ((_dist < 6.25 || (_dist < 12.25 && _onVehTarget)) && {_seeTarget}) then {
				[_agnt,"AmovPercMrunSnonWnonDf"] call BRPVP_zombiePlayMoveNow;
				[_agnt,"UP"] call BRPVP_zombieSetUnitPos;
				_agntsAct set [_this,2];
				_agntsArg set [_this,[0,false]];
			} else {
				if (_seeTarget) then {
					_posAround = (_uTarget getVariable "brpvp_safeMovePos") call BIS_fnc_selectRandom;
					[_agnt,_posAround,true] call BRPVP_zombieMoveTo;
					(_agntsArg select _this) set [1,_time];
				} else {
					_limit = if (_onVehTarget) then {160000} else {90000};
					if (_dist < _limit) then {
						if (_moveToCompleted) then {
							if (_time - _ini2 > 30) then {
								_newTarget = [200,90000,[],true] call _searchForATarget;
								[_newTarget,_this] call _setZombieNewDestine;
							} else {
								if (_time - _ini2 > 10) then {
									_newTarget = [200,90000,[],true] call _searchForATarget;
									if (!isNull _newTarget) then {
										[_newTarget,_this] call _setZombieNewDestine;
									} else {
										_newPos = [_agnt,3.5,random 360] call BIS_fnc_relPos;
										[_agnt,_newPos,false] call BRPVP_zombieMoveTo;
									};
								} else {
									_newPos = [_agnt,3.5,random 360] call BIS_fnc_relPos;
									[_agnt,_newPos,false] call BRPVP_zombieMoveTo;
								};
							};
						} else {
							if (_time - _ini2 == _time - _ini1) then {
								(_agntsArg select _this) set [1,_time];
							};
						};
					} else {
						[_agnt,ASLToAGL getPosASL _agnt,false] call BRPVP_zombieMoveTo;
						_newTarget = [200,90000,[],true] call _searchForATarget;
						[_newTarget,_this] call _setZombieNewDestine;
					};
				};
			};
		} else {
			_newTarget = [200,90000,[],true] call _searchForATarget;
			[_newTarget,_this] call _setZombieNewDestine;
		};
	};
};
_BRPVP_walkerAcao2 = {
	_agnt = _agnts select _this;
	_uTarget = _agntsTarget select _this;
	(_agntsArg select _this) params ["_ini","_dano"];
	if (_time - _ini >= 2 && {!(_agnt getVariable "jpg")}) then {
		_dist = _uTarget distanceSqr _agnt;
		if ((_dist < 6.25 || {_dist < 12.25 && _onVehTarget}) && {call _canSeeUnitTarget}) then {
			if !([getPosWorld _agnt,getDir _agnt,60,getPosWorld _uTarget] call BIS_fnc_inAngleSector) then {
				[_agnt,[_agnt,_uTarget] call BIS_fnc_dirTo] call BRPVP_zombieSetDir;
			};
			[_agnt,"AwopPercMstpSgthWnonDnon_end"] remoteExec ["switchMove",0,false];
			[_agnt,["zombie_snd_13",300]] call BRPVP_zombieSay;
			(_agntsArg select _this) set [0,_time];
			(_agntsArg select _this) set [1,true];
		} else {
			if (_agnt getVariable "knl") then {
				[_agnt,"AmovPknlMrunSnonWnonDf"] call BRPVP_zombiePlayMoveNow;
				[_agnt,"MIDDLE"] call BRPVP_zombieSetUnitPos;
			};
			_agntsAct set [_this,1];
			_agntsArg set [_this,[0,_time,_time + random 1,random 1]];
		};
	} else {
		if (_dano) then {
			if (_time - _ini >= 0.25) then {
				[_agnt,ASLToAGL eyePos _uTarget] call BRPVP_zombieDoWatch;
				(_agntsArg select _this) set [1,false];
				_dist = _uTarget distanceSqr _agnt;
				if ((_dist < 6.25 || {_dist < 12.25 && _onVehTarget}) && {call _canSeeUnitTarget}) then {
					if !(_uTarget getVariable ["god",0] > 0 || _agnt getVariable "jpg") then {
						if (isPlayer _uTarget) then {
							_uTarget setDamage ((damage _uTarget) + (0.05 + random 0.05) * ((_agnt getVariable "ifz") select 0));
						} else {
							_uTarget setDamage ((damage _uTarget) + (0.025 + random 0.025) * ((_agnt getVariable "ifz") select 0));
						};
					};
					[_agnt,["destroy",150]] call BRPVP_zombieSay;
					if (_uTarget getVariable ["dd",-1] > 0) then {
						_newTarget = [200,90000,[],true] call _searchForATarget;
						[_newTarget,_this] call _setZombieNewDestine;
					};
				};
			};
		};
	};
};

//==========
//LOOP GERAL
//==========
_initA = 0;
_initC = 0;
_cycleCount = 0;
_idc = 0;
_agnt = objNull;
_newTarget = objNull;
waitUntil {
	_time = time;
	if (_time - _initC > 0.25) then {
		_initC = _time;
		if (_time - _initA > 1) then {
			_initA = _time;
			_uniqueTargets = _agntsTarget arrayIntersect _agntsTarget;
			{
				_x setVariable ["brpvp_safeMovePos",_x call _findSafePos,false];
				_newPos = ASLToAGL getPosWorld _x;
				_walked = ((_x getVariable ["brpvp_target_last_pos",[0,0,0]]) distanceSqr _newPos) > 100;
				_x setVariable ["brpvp_walked",_walked,false];
				if (_walked) then {_x setVariable ["brpvp_target_last_pos",_newPos,false];};				
			} forEach _uniqueTargets;
		};
		_countAgnts = count _agnts;
		_cycleCountMod = if (_countAgnts == 0) then {-1} else {_cycleCount mod (_countAgnts + 1)};
		{
			_idc = _forEachIndex;
			_agnt = _x;
			_nid = _agnt getVariable "brpvp_locality_nid";
			if (alive _agnt) then {
				_uTarget = _agntsTarget select _idc;

				//READY?
				_noMoveCount = _agnt getVariable "brpvp_noMoveCount";
				if (speed _agnt == 0) then {
					_noMoveCount = _noMoveCount + 1;
					_agnt setVariable ["brpvp_noMoveCount",_noMoveCount,false];
				} else {
					_noMoveCount = 0;
					_agnt setVariable ["brpvp_noMoveCount",0,false];
				};
				_moveToCompleted = moveToCompleted _agnt || moveToFailed _agnt || _noMoveCount >= 10;
				
				if (isNull _uTarget) then {
					_newTarget = [200,90000,[],true] call _searchForATarget;
					[_newTarget,_idc] call _setZombieNewDestine;
				} else {
					if (_idc == _cycleCountMod) then {
						_targetOverload = _uTarget getVariable ["brpvp_zombies_on_me",0] > BRPVP_zombieMaxLocalPerPlayer;
						_targetTooFar =	!(_uTarget isEqualTo player) && {_uTarget distance player > _maxDistanceAILimit};
						if (_targetOverload || _targetTooFar) then {
							if (_targetTooFar) then {
								_newTarget = [200,90000,[_uTarget],true] call _searchForATarget;
							} else {
								_newTarget = [200,90000,[_uTarget],false] call _searchForATarget;
							};
							if (!isNull _newTarget) then {
								[_newTarget,_idc] call _setZombieNewDestine;
							};
						} else {
							_acao = _agntsAct select _idc;
							_onVehTarget = vehicle _uTarget != _uTarget;
							if (_acao == 1) then {_idc call _BRPVP_walkerAcao1;};
							if (_acao == 2) then {_idc call _BRPVP_walkerAcao2;};
						};
					} else {
						_acao = _agntsAct select _idc;
						_onVehTarget = vehicle _uTarget != _uTarget;
						if (_acao == 1) then {_idc call _BRPVP_walkerAcao1;};
						if (_acao == 2) then {_idc call _BRPVP_walkerAcao2;};
					};
				};
			} else {
				_mult = (_agnt getVariable "ifz") select 0;
				_killer = _agnt getVariable ["klr",objNull];
				
				//GIVE MONEY FOR DEAD ZOMBIE
				if (isPlayer _killer) then {
					if (_killer == player) then {
						[player,150 * _mult] call BRPVP_qjsAdicClassObjeto;
						playSound "negocio";
					} else {
						BRPVP_giveMoneySV = [_killer,100 * _mult];
						if (isServer) then {["",BRPVP_giveMoneySV] call BRPVP_giveMoneySVFnc;} else {publicVariableServer "BRPVP_giveMoneySV";};
					};
				};
				
				//BODY DESTINE
				_agnt setVariable ["hmlr",time -5 + 10,false];
				BRPVP_removeZombieBrain pushBack _agnt;
				BRPVP_waitZombieToFallAndContinue pushBack _agnt;
			};
		} forEach _agnts;
		
		//ADD AGENT TO THIS CLIENT BRAIN
		if (count BRPVP_addZombieBrain > 0) then {
			_added = [];
			{
				_x params ["_agnt","_locality"];
				_agnt setVariable ["brpvp_locality_nid",_locality,false];
				_agnt call _addAgent;
				_added pushBack _forEachIndex;
			} forEach BRPVP_addZombieBrain;
			_added sort false;
			{BRPVP_addZombieBrain deleteAt _x;} forEach _added;
		};
		
		//REMOVE AGENT FROM THIS CLIENT BRAIN
		if (count BRPVP_removeZombieBrain > 0) then {
			{
				_index = _agnts find _x;
				_agnts deleteAt _index;
				_agntsAct deleteAt _index;
				_agntsArg deleteAt _index;
				_target = _agntsTarget select _index;
				_target setVariable ["brpvp_zombies_on_me",(_target getVariable ["brpvp_zombies_on_me",0]) - 1,true];
				_agntsTarget deleteAt _index;
			} forEach BRPVP_removeZombieBrain;
			BRPVP_removeZombieBrain = [];
		};
		
		//WAIT ZOMBIE TO FALL AND CONTINUE
		_deleteFromWaitFall = [];
		{
			_agnt = _x;
			if (_time - (_agnt getVariable "hmlr") > 5) then {
				_deleteFromWaitFall pushBack _forEachIndex;
				if ((position _agnt) select 2 > 0.3) then {
					_agnt spawn {
						_agnt = _this;
						_init = time;
						waitUntil {(position _agnt) select 2 < 0.2 || time - _init > 10};
						/*
						if (!alive _agnt) then {
							_bomb = createVehicle ["B_20mm",_agnt modeltoworld [0,0,0],[],0,"CAN_COLLIDE"];
							_bomb setVectorDirAndUp [[0,0,-1],[0,1,0]];
							_bomb setVelocity [0,0,-1000];
						};
						*/
						BRPVP_changeZombieOwner pushBack [_agnt,objNull];
					};
				} else {
					/*
					if (!alive _agnt) then {
						_bomb = createVehicle ["B_20mm",_agnt modeltoworld [0,0,0],[],0,"CAN_COLLIDE"];
						_bomb setVectorDirAndUp [[0,0,-1],[0,1,0]];
						_bomb setVelocity [0,0,-1000];
					};
					*/
					BRPVP_changeZombieOwner pushBack [_agnt,objNull];
				};			
			};
		} forEach BRPVP_waitZombieToFallAndContinue;
		_deleteFromWaitFall sort false;
		{BRPVP_waitZombieToFallAndContinue deleteAt _x;} forEach _deleteFromWaitFall;
		
		//SET AGENT OWNER TO ANOTHER CLIENT OR TO THE SERVER
		if (count BRPVP_changeZombieOwner > 0) then {
			{
				_x params ["_agnt","_player"];
				_agnt setVariable ["dmg",_agnt getVariable "dmg",true];
				if (_agnt getVariable "brpvp_locality_nid" != 2) then {
					_agnt removeAllEventHandlers "HandleDamage";
				} else {
					[_agnt,"HandleDamage"] remoteExec ["removeAllEventHandlers",2,false];
				};
				BRPVP_sendAgentConfigToClientAskServer = _x;
				if (isServer) then {["",BRPVP_sendAgentConfigToClientAskServer] call BRPVP_sendAgentConfigToClientAskServerFnc;} else {publicVariableServer "BRPVP_sendAgentConfigToClientAskServer";};
			} forEach BRPVP_changeZombieOwner;
			BRPVP_changeZombieOwner = [];
		};
	};
	_cycleCount = _cycleCount + 1;
	
	false
};