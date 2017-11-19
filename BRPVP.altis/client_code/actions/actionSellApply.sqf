BRPVP_sellStage = 3;

_box = BRPVP_sellReceptacle;
_boxIndex = _box getVariable "bidx";

_weapons = [[],[]];
_magazines = magazinesAmmoCargo _box;
_backpack = getBackpackCargo _box;
_items = getItemCargo _box;
_containers = everyContainer _box;

_check = [];
_checkRemove = [];
_containers = _containers apply {
	if (_x select 1 in _check) then {
		_checkRemove pushBack (_x select 0);
		-1
	} else {
		_check pushBack (_x select 1);
		_x
	};
};
_containers = _containers - [-1];
{
	_idx = (_backpack select 0) find _x;
	if (_idx != -1) then {
		_quantity = _backpack select 1 select _idx;
		if (_quantity == 1) then {
			(_backpack select 0) deleteAt _idx;
			(_backpack select 1) deleteAt _idx;
		} else {
			(_backpack select 1) set [_idx,_quantity - 1];
		};
	};
} forEach _checkRemove;

_weaponsItemsCargo = weaponsItemsCargo _box;

clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearItemCargoGlobal _box;

{_weaponsItemsCargo = _weaponsItemsCargo + (weaponsItemsCargo (_x select 1));} forEach _containers;
{
	_weapon = _x;
	{
		if (_forEachIndex == 0) then {
			_weapons = [_weapons,_x call BIS_fnc_baseWeapon] call BRPVP_adicCargo;
		} else {
			if (typeName _x == "ARRAY") then {if (count _x > 0) then {_magazines append [_x];};};
			if (typeName _x == "STRING") then {if (_x != "") then {_items = [_items,_x] call BRPVP_adicCargo;};};
		};
	} forEach _weapon;
} forEach _weaponsItemsCargo;
{
	_container = _x select 1;
	_magazines append magazinesAmmoCargo _container;
	_itemsCargo = getItemCargo _container;
	{
		_amount = _itemsCargo select 1 select _forEachIndex;
		for "_i" from 1 to _amount do {_items = [_items,_x] call BRPVP_adicCargo;};
	} forEach (_itemsCargo select 0);
} forEach _containers;

_gear = [_weapons,[[],[]],_backpack,_items];
_zeroAt = [[],[],[],[]];
_totalPrice = 0;
{
	_groupOfItems = _x;
	_groupOfItemsIndex = _forEachIndex;
	{
		_item = _x;
		_price = 0;
		_iData = _item call BRPVP_isCfgSimilar;
		if (count _iData > 0) then {
			_base = BRPVP_mercadoPrecos select (_iData select 0);
			_multiplier = _iData select 4;
			_price = _base * _multiplier * BRPVP_sellPricesMultiplier;
			(_zeroAt select _groupOfItemsIndex) pushBack _forEachIndex;
			_amount = _groupOfItems select 1 select _forEachIndex;
			_totalPrice = _totalPrice + _amount * _price;
		};
	} forEach (_groupOfItems select 0);
} forEach _gear;
{
	_toDel = _x;
	_toDel sort false;
	_classes = _gear select _forEachIndex select 0;
	_amounts = _gear select _forEachIndex select 1;
	{
		_classes deleteAt _x;
		_amounts deleteAt _x;
	} forEach _toDel;
	_gear set [_forEachIndex,[_classes,_amounts]];
} forEach _zeroAt;

_delAt = [];
{
	_item = _x select 0;
	_index = _forEachIndex;
	_price = 0;
	_iData = _item call BRPVP_isCfgSimilar;
	if (count _iData > 0) then {
		_base = BRPVP_mercadoPrecos select (_iData select 0);
		_multiplier = _iData select 4;
		_price = _base * _multiplier * BRPVP_sellPricesMultiplier;
		_delAt pushBack _index;
		_totalPrice = _totalPrice + _price;
	};
} forEach _magazines;
_delAt sort false;
{_magazines deleteAt _x;} forEach _delAt;
_gear set [1,_magazines];

_remain = 0;
{_remain = _remain + (_gear select 0 select 1 select _forEachIndex);} forEach (_gear select 0 select 0);
{_remain = _remain + (_gear select 2 select 1 select _forEachIndex);} forEach (_gear select 2 select 0);
{_remain = _remain + (_gear select 3 select 1 select _forEachIndex);} forEach (_gear select 3 select 0);
{_remain = _remain + 1;} forEach (_gear select 1);
_remainTxt = if (_remain > 0) then {format [localize "str_coll_remain",_remain]} else {""};

_totalPrice = round _totalPrice;
[format [localize "str_coll_sell_ok",_totalPrice,_remainTxt],(3.5 + _remain * 10) min 10,20,155] call BRPVP_hint;
[player,_totalPrice] call BRPVP_qjsAdicClassObjeto;

_boxDatabaseInfo = [
	getPlayerUID player,
	_gear,
	//_box getVariable ["stp",1]
	1
];

_playerDatabaseInfo = player call BRPVP_pegaEstadoPlayer;
player setVariable ["sr",objNull,true];
BRPVP_salvaPlayerVault = [_playerDatabaseInfo,[_boxDatabaseInfo,_boxIndex]];
if (isServer) then {["",BRPVP_salvaPlayerVault] call BRPVP_salvaPlayerVaultFnc;} else {publicVariableServer "BRPVP_salvaPlayerVault";};

{
	detach _x;
	deleteVehicle _x;
} forEach (attachedObjects _box);
deleteVehicle _box;

BRPVP_sellStage = 4;