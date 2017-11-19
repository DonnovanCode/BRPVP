private ["_ttxt","_onlyMinorItems"];
BRPVP_actionRunning pushBack 5;
(_this select 3) params ["_from","_to","_fromUnit"];
if (_from call BRPVP_checaAcesso && (isNull _to || {_to call BRPVP_checaAcesso})) then {
	_to = if (isNull _to) then {
		_onlyMinorItems = true;
		_ttxt = localize "str_weapon_holder_ok_name";
		createVehicle ["GroundWeaponHolder",ASLToAGL getPosASL player,[],0,"CAN_COLLIDE"]
	} else {
		_onlyMinorItems = false;
		_ttxt = getText (configFile >> "CfgVehicles" >> (typeOf _to) >> "displayName");
		_to
	};
	if (isNull _from || {isNull _to}) then {
		[localize "str_trans_side_null",5,12,128,"erro"] call BRPVP_hint;
	} else {
		if (_from distance _to > 50) then {
			[localize "str_trans_far_destination",5,12,128,"erro"] call BRPVP_hint;
		} else {
			if (_fromUnit) then {
				[_from,_to,50,[-1,0],{true},_onlyMinorItems] call BRPVP_transferUnitCargo;
			} else {
				[_from,_to,50] call BRPVP_transferCargoCargo;
			};
			if (_from call BRPVP_isMotorized) then {
				_ftxt = getText (configFile >> "CfgVehicles" >> (typeOf _from) >> "displayName");
				[format [localize "str_trans_ok",_ftxt,_ttxt],5,12,128] call BRPVP_hint;
			} else {
				[format [localize "str_trans_ok2",_ttxt],5,12,128] call BRPVP_hint;
			};
		};
	};
} else {
	[localize "str_trans_cant",5,12,128,"erro"] call BRPVP_hint;
};
sleep 2;
BRPVP_actionRunning = BRPVP_actionRunning - [5];