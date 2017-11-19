_motorized = _this select 3;
if (_motorized call BRPVP_checaAcesso) then {
	BRPVP_actionRunning pushBack 18;
	_lockState = _motorized getVariable ["brpvp_locked",false];
	_motorized setVariable ["brpvp_locked",!_lockState,true];
	if (!_lockState) then {
		//[format[localize "str_vehicle_locked",getText (configFile >> "CfgVehicles" >> (typeOf _motorized) >> "displayName")],0,200,0,""] call BRPVP_hint;
		[_motorized,["lock_car",160]] remoteExec ["say3D",-2,false];
	} else {
		//[format[localize "str_vehicle_unlocked",getText (configFile >> "CfgVehicles" >> (typeOf _motorized) >> "displayName")],0,200,0,""] call BRPVP_hint;
		[_motorized,["unlock_car",160]] remoteExec ["say3D",-2,false];
	};
	if !(_motorized getVariable ["brpvp_slv_lck",false]) then {_motorized setVariable ["brpvp_slv_lck",true,true];};
	sleep 1;
	BRPVP_actionRunning = BRPVP_actionRunning - [18];
} else {
	[localize "str_vehicle_lock_no_access"] call BRPVP_hint;
};