BRPVP_actionRunning pushBack 8;
_price = if (BRPVP_vePlayers) then {0} else {_this select 3 select 0};
_money= player getVariable "mny";
if (_money >= _price) then {
	player setVariable ["mny",_money - _price,true];
	if (_price > 0) then {playSound "negocio";};
	_ruins = _this select 3 select 1;
	playSound3D [BRPVP_missionRoot + "BRP_sons\bulldozer.ogg",_ruins,false,getPosASL _ruins,1,1,800];
	sleep 2.6;
	{if (!isPlayer _x) then {deleteVehicle _x;};} forEach crew _ruins;
	_operator = _ruins getVariable ["brpvp_operator",objNull];
	if (!isNull _operator) then {
		BRPVP_serverRemoveTurret = [player,_operator];
		BRPVP_serverRemoveTurretAnswer = false;
		if (isServer) then {["",BRPVP_serverRemoveTurret] call BRPVP_serverRemoveTurretFnc;} else {publicVariableServer "BRPVP_serverRemoveTurret";};
		waitUntil {BRPVP_serverRemoveTurretAnswer};
		deleteVehicle _operator;
	};
	deleteVehicle _ruins;
} else {
	playSound "erro";
	[localize "str_no_money",0] call BRPVP_hint;
};
BRPVP_actionRunning = BRPVP_actionRunning - [8];