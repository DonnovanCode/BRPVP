BRPVP_actionRunning pushBack 11;
_unit = _this select 3;
_unit setVariable ["brpvp_surrendedBy",player,true];
_hey = ["hey_1.ogg","hey_2.ogg","hey_3.ogg"] call BIS_fnc_selectRandom;
playSound3D [BRPVP_missionRoot + "BRP_sons\" + _hey,player,false,getPosASL player,1,1,200];
BRPVP_surrended = _unit;
BRPVP_serverStillSurrendedCheck = [BRPVP_surrended,player];
if (isServer) then {["",BRPVP_serverStillSurrendedCheck] call BRPVP_serverStillSurrendedCheckFnc;} else {publicVariableServer "BRPVP_serverStillSurrendedCheck";};
_timeOff = 0;
_init = time;
waitUntil {
	sleep 0.1;
	_time = time;
	_delta = _time - _init;
	_init = _time;
	_dirTo = [player,BRPVP_surrended] call BIS_fnc_dirTo;
	_dirPlayer = getDir player;
	_diffDir = abs(_dirTo - _dirPlayer);
	_diffDir = _diffDir min (360 - _diffDir);
	_onAin = _diffDir <= 30;
	if !(_onAin) then {_timeOff = _timeOff + _delta;} else {_timeOff = 0;};
	currentWeapon player == "" || _timeOff > 2 || player distance _unit > 10 || isNull BRPVP_surrended || !alive BRPVP_surrended || !alive player || isNull player || !isNull (player getVariable ["brpvp_surrendedBy",objNull]) || isNull (BRPVP_surrended getVariable ["brpvp_surrendedBy",objNull])
};
BRPVP_surrended = objNull;
_unit setVariable ["brpvp_surrendedBy",objNull,true];
BRPVP_actionRunning = BRPVP_actionRunning - [11];