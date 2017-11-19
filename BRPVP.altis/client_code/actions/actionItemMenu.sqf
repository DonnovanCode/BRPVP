BRPVP_actionRunning pushBack 7;
BRPVP_stuff = _this select 3;
_ok = [22,true] call BRPVP_iniciaMenuExtra;
if (_ok) then {
	waitUntil {!BRPVP_menuExtraLigado};
};
BRPVP_actionRunning = BRPVP_actionRunning - [7];