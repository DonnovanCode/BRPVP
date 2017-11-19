(_this select 3) params ["_merchant","_merchantIndex","_precoMult",["_itemFilter",0],["_deployMode","default"]];
_position = position player;
if (_position select 2 > 1) exitWith {
	playSound "erro";
	[localize "str_trader_on_ground",0] call BRPVP_hint;
};
if (vehicle player != player) exitWith {
	playSound "erro";
	[localize "str_trader_on_foot",0] call BRPVP_hint;
};
if (typeName _merchantIndex == "SCALAR") then {
	_merchantTypesAmount = count BRPVP_mercadoresEstoque;
	_merchantIndex = _merchantIndex mod _merchantTypesAmount;
	BRPVP_merchantItems = BRPVP_mercadoresEstoque select _merchantIndex select 0;
} else {
	BRPVP_merchantItems = _merchantIndex;
};
BRPVP_marketPrecoMult = _precoMult;
BRPVP_marketItemFilter = _itemFilter;
BRPVP_marketDeployMode = _deployMode;
BRPVP_compraPrecoTotal = 0;
BRPVP_compraItensTotal = [];
BRPVP_compraItensPrecos = [];
_menuOpenOk = 9 call BRPVP_iniciaMenuExtra;
if (_menuOpenOk) then {
	BRPVP_actionRunning pushBack 0;
	waitUntil {!alive player || player distanceSqr _merchant > 400 || !BRPVP_menuExtraLigado};
	if (BRPVP_menuExtraLigado) then {
		BRPVP_menuExtraLigado = false;
		call BRPVP_atualizaDebug;
	};
	BRPVP_actionRunning deleteAt (BRPVP_actionRunning find 0);
} else {
	playSound "erro";
};