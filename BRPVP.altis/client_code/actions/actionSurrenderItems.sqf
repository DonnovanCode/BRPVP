BRPVP_actionRunning pushBack 12;
if (isNull BRPVP_surrendedWeaponHolder) then {
	BRPVP_surrendedWeaponHolder = createVehicle ["GroundWeaponHolder",ASLToAGL getPosASL BRPVP_surrended,[],0,"CAN_COLLIDE"];
};
[BRPVP_surrended,""] call BRPVP_switchMove;
{
	if (_x != "") then {
		BRPVP_surrended action ["DropWeapon",BRPVP_surrendedWeaponHolder,_x];
	};
	waitUntil {!(_x in weapons BRPVP_surrended)};
} forEach [currentWeapon BRPVP_surrended,primaryWeapon BRPVP_surrended,secondaryWeapon BRPVP_surrended,handGunWeapon BRPVP_surrended];
[_unit,"AmovPercMstpSsurWnonDnon"] call BRPVP_switchMove;
sleep 1;
[BRPVP_surrended,BRPVP_surrendedWeaponHolder,-2,[0.5,0.5]] call BRPVP_transferUnitCargo;