BRPVP_actionRunning append [7,16];
_obj = _this select 3;
_pAvisa = [];
{
	if ([_x,BRPVP_stuff] call PDTH_distance2BoxQuad < 100) then {
		_pAvisa pushBack _x;
	};
} forEach allPlayers;
BRPVP_avisaExplosao = [_obj,_pAvisa];
if (isServer) then {["",BRPVP_avisaExplosao] call BRPVP_avisaExplosaoFnc;} else {publicVariableServer "BRPVP_avisaExplosao";};
waitUntil {isNull _obj || !alive _obj};
sleep 1;
BRPVP_actionRunning = BRPVP_actionRunning - [7,16];