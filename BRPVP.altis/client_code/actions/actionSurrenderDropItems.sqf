player removeAction BRPVP_actionDropItems;
_attacker = player getVariable "brpvp_surrendedBy";
if (!isNull _attacker) then {
	_weaponHolder = createVehicle ["GroundWeaponHolder",ASLToAGL getPosASL player,[],0,"CAN_COLLIDE"];
	_weaponHolder addItemCargo ["ItemMap",1];
	player removeWeapon "ItemMap";
	_helipad = createVehicle ["Land_HelipadEmpty_F",ASLToAGL getPosASL player,[],0,"CAN_COLLIDE"];
	[_helipad,"backpack",50] call BRPVP_playSoundAllCli;
	[player,_weaponHolder,-2,[1,6.5],{!isNull (player getVariable "brpvp_surrendedBy")}] call BRPVP_transferUnitCargo;
	_helipad setDamage 1;
	deleteVehicle _helipad;
};
player setVariable ["brpvp_surrendedBy",objNull,true];