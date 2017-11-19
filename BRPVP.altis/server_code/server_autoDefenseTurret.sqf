_turretDisableSimulation = [];
_init = time;
waitUntil {
	_time = time;
	if (_time - _init > 0.5) then {
		_init = _time;
		{
			_initTurret = _x getVariable "brpvp_init";
			if (_time - _initTurret >= BRPVP_turretCycleTime) then {
				_x setVariable ["brpvp_init",_time,false];
				_player = _x getVariable "brpvp_target";
				if !(_player isEqualTo (_x getVariable "brpvp_last_target")) then {
					_x setVariable ["brpvp_last_target",_player,false];
					if (isNull _player) then {
						_t = _x getVariable "brpvp_turret";
						_x doWatch objNull;
						_x doWatch ([_t,10,getDir _t] call BIS_fnc_relPos);
						_turretDisableSimulation pushBack _x;
						_x setVariable ["brpvp_disableTime",_time + 5,false];
					} else {
						_disableTime = _x getVariable "brpvp_disableTime";
						if (_disableTime != -1) then {
							_x setVariable ["brpvp_disableTime",-1,false];
						} else {
							_t = _x getVariable "brpvp_turret";
							_t enableSimulationGlobal true;
							_x enableSimulationGlobal true;
							_x forceAddUniform "U_I_Soldier_VR";
						};
						_x doWatch eyePos _player;
						_x doTarget vehicle _player;
					};
				} else {
					if (!isNull _player) then {
						_x doTarget vehicle _player;
					};
				};
			};
		} forEach BRPVP_autoDefenseTurretList;
		if (count BRPVP_autoTurretDied > 0) then {
			{
				_disableTime = _x getVariable "brpvp_disableTime";
				if (_disableTime != -1) then {_x setVariable ["brpvp_disableTime",-1,false];};
				_x forceAddUniform "U_O_Soldier_VR";
				_x doWatch objNull;
				_t = _x getVariable "brpvp_turret";
				sleep 0.001;
				_x enableSimulationGlobal false;
				_t enableSimulationGlobal false;
				BRPVP_autoDefenseTurretList deleteAt (BRPVP_autoDefenseTurretList find _x);
			} forEach BRPVP_autoTurretDied;
			BRPVP_autoTurretDied = [];
		};
		if (count _turretDisableSimulation > 0) then {
			_delIndex = [];
			{
				_disableTime = _x getVariable "brpvp_disableTime";
				if (_disableTime != -1) then {
					if (_time >= _disableTime) then {
						_x forceAddUniform "U_B_Soldier_VR";
						_x setVariable ["brpvp_disableTime",-1,false];
						_delIndex pushBack _forEachIndex;
						_t = _x getVariable "brpvp_turret";
						sleep 0.001;
						_x enableSimulationGlobal false;
						_t enableSimulationGlobal false;
					};
				} else {
					_delIndex pushBack _forEachIndex;
				};
			} forEach _turretDisableSimulation;
			if (count _delIndex > 0) then {
				_delIndex sort false;
				{_turretDisableSimulation deleteAt _x;} forEach _delIndex;
			};
		};
	};
	false
};