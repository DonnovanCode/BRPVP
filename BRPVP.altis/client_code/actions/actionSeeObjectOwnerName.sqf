private ["_name"];
BRPVP_actionRunning pushBack 17;
_obj = _this select 3;
if (isServer) then {
	_name = [_obj,player] call BRPVP_sendObjectOwnerNameFromDB;
} else {
	BRPVP_sendObjectOwnerNameFromDBReturn = nil;
	[[_obj,player],{_this call BRPVP_sendObjectOwnerNameFromDB;}] remoteExec ["call",2,false];
	waitUntil {!isNil "BRPVP_sendObjectOwnerNameFromDBReturn"};
	_name = BRPVP_sendObjectOwnerNameFromDBReturn;
};
[format[localize "str_object_owner_name",_name]] call BRPVP_hint;
sleep 2.5;
BRPVP_actionRunning = BRPVP_actionRunning - [17];