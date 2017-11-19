_turretsLast = [];
_alarmLastTime = 0;
_lastDangeLevel = 0;
_init = time;
BRPVP_turretShotOn = objNull;
waitUntil {
	_time = time;
	_delta = _time - _init;
	if (_delta > 1) then {
		_init = _time;
		_maxDist = BRPVP_actualAutoTurretsDist;
		_turrets = player nearEntities [BRPVP_actualAutoTurrets,BRPVP_actualAutoTurretsDist];
		_maxIdx = (count _turrets) - 1;
		for "_i" from _maxIdx to 0 step -1 do {
			_turret = _turrets select _i;
			_operator = _turret getVariable ["brpvp_operator",objNull];
			_notElegible = isNull _operator || {_operator getVariable "brpvp_dead" || _turret call BRPVP_checaAcesso || BRPVP_safeZone || !alive player};
			if (_notElegible) then {_turrets deleteAt _i;};
		};
		{
			_operator = _x getVariable "brpvp_operator";
			if (_operator getVariable "brpvp_target" isEqualTo player) then {
				_operator setVariable ["brpvp_target",objNull,true];
				_operator setVariable ["brpvp_points",0,true];
				_operator setVariable ["brpvp_missing",0,false];
			};
		} forEach (_turretsLast - _turrets);
		_onMe = 0;
		{
			_operator = _x getVariable "brpvp_operator";
			_eyePosGunner = eyePos _operator;
			_eyePosPlayer = eyePos player;
			_vis = [_x,"VIEW",vehicle player] checkVisibility [_eyePosGunner,_eyePosPlayer];
			_turretAinVec = if (isNull gunner _x) then {vectorDir _operator} else {_x weaponDirection ((weapons _x) select 0)};
			_turretToTargetVec = _eyePosPlayer vectorDiff _eyePosGunner;
			_angle = (acos (_turretAinVec vectorCos _turretToTargetVec))/180;
			_dist = ((_x distance player)/_maxDist) min 1;
			_points = (_vis * 3 + (1 - _angle) * 2 + (1 - _dist))/6;
			_actualPoints = _operator getVariable "brpvp_points";
			_target = _operator getVariable "brpvp_target";
			if (_target isEqualTo player) then {
				_onMe = _onMe + 1;
				if (abs (1 - _points/_actualPoints) >= 0.1) then {
					_operator setVariable ["brpvp_points",_points,true];
				};
				if (_vis < 0.35 || _angle > 0.5) then {
					_mis = _operator getVariable ["brpvp_missing",0];
					_newMis = _mis + _delta;
					if (_newMis > 30) then {
						_onMe = _onMe - 1;
						_operator setVariable ["brpvp_target",objNull,true];
						_operator setVariable ["brpvp_points",0,true];
						_operator setVariable ["brpvp_missing",0,false];
					} else {
						_operator setVariable ["brpvp_missing",_newMis,false];
					};
				} else {
					_operator setVariable ["brpvp_missing",0,false];
				};
			} else {
				_shotOn = BRPVP_turretShotOn isEqualTo _x;
				if (_shotOn) then {BRPVP_turretShotOn = objNull;};
				if ((_angle <= 0.5 && _vis > 0.7) || _shotOn && {_actualPoints == 0 || {_points/_actualPoints >= 1.1}}) then {
					_onMe = _onMe + 1;
					_operator setVariable ["brpvp_target",player,true];
					_operator setVariable ["brpvp_points",_points,true];
					_operator setVariable ["brpvp_missing",0,false];
				};
			};
		} forEach _turrets;
		_turretsLast = + _turrets;

		//SET DANGER LEVEL
		if (count _turrets > 0) then {
			if (_onMe > 0) then {
				BRPVP_autoTurretDangerLevel = 2;
			} else {
				BRPVP_autoTurretDangerLevel = 1;
			};
		} else {
			BRPVP_autoTurretDangerLevel = 0;
		};
		if (BRPVP_autoTurretDangerLevel != _lastDangeLevel) then {
			_lastDangeLevel = BRPVP_autoTurretDangerLevel;
			_alarmLastTime = 0;
			if (BRPVP_autoTurretDangerLevel == 0) then {
				["<img size='3' image='BRP_imagens\interface\turret_warning_0.paa'/>",0,0,2,0,0,7757] spawn BIS_fnc_dynamicText;
			};
		};

		//SHOW DANGER MESSAGE
		if (BRPVP_autoTurretDangerLevel == 1) then {
			if (_time - _alarmLastTime > 10) then {
				_alarmLastTime = _time;
				["<img size='3' image='BRP_imagens\interface\turret_warning_1.paa'/>",0,0,1.5,0,0,7757] spawn BIS_fnc_dynamicText;
			};
		} else {
			if (BRPVP_autoTurretDangerLevel == 2) then {
				if (_time - _alarmLastTime > 5) then {
					_alarmLastTime = _time;
					["<img size='3' image='BRP_imagens\interface\turret_warning_2.paa'/>",0,0,1,0,0,7757] spawn BIS_fnc_dynamicText;
					playSound "turret_alert";
				};
			} else {
				_alarmLastTime = 0;
			};
		};
	};
	false
};