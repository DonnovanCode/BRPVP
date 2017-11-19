_lamp = _this select 3;
BRPVP_saveLightStateDb = [_lamp,false];
if (isServer) then {["",BRPVP_saveLightStateDb] call BRPVP_saveLightStateDbFnc;} else {publicVariableServer "BRPVP_saveLightStateDb";};