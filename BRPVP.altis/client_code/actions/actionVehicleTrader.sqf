_position = position player;
if (_position select 2 > 1) exitWith {
	playSound "erro";
	[localize "str_trader_on_ground",0] call BRPVP_hint;
};
if (vehicle player != player) exitWith {
	playSound "erro";
	[localize "str_trader_on_foot",0] call BRPVP_hint;
};
_trader = _this select 3 select 0;
BRPVP_vendaveAtivos = [
	_this select 3 select 1,
	_this select 3 select 2,
	if (count (_this select 3) > 3) then {_this select 3 select 3} else {"default"},
	_trader getVariable ["vndv_elevator",false]
];
_menuOpenOk = 13 call BRPVP_iniciaMenuExtra;
if (_menuOpenOk) then {
	BRPVP_actionRunning pushBack 1;
	waitUntil {!alive player || player distanceSqr _trader > 400 || !BRPVP_menuExtraLigado};
	if (BRPVP_menuExtraLigado) then {
		BRPVP_menuExtraLigado = false;
		call BRPVP_atualizaDebug;
	};
	BRPVP_actionRunning deleteAt (BRPVP_actionRunning find 1);
} else {
	playSound "erro";
};