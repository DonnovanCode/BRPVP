BRPVP_actionRunning pushBack 2;
_disabledPlayer = _this select 3;
for "_c" from 6 to 1 step -1 do {
	[format [localize "str_finalize_count",_c],0,200,0,"ciclo"] call BRPVP_hint;
	sleep 1;
	if (player distance _disabledPlayer > 2.5) exitWith {
		[localize "str_finalize_fail"] call BRPVP_hint;
		playsound "erro";
		sleep 1;
	};
	if (_disabledPlayer getVariable ["dd",0] > 0) exitWith {
		sleep 1;
	};
	if (_c == 1) exitWith {
		if (_disabledPlayer getVariable ["dd",0] == 0) then {
			_disabledPlayer setVariable ["dd",1,true];
		};
		sleep 1;
	};
};
BRPVP_actionRunning deleteAt (BRPVP_actionRunning find 2);
