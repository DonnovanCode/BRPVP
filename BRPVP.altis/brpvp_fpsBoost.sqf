[] spawn {
	private ["_cycleTime","_entitiesCategory","_radiusMult","_mngLocalEnt","_mngNotLocalEnt","_init","_count"];
	BRPVP_completeUpdate = false;
	BRPVP_meusAmigosObj = [];
	BRPVP_spectedPlayer = objNull;
	_entitiesCategory = [
		[[["Air"],[],false,false],4,4,{[]}],
		[[["Ship"],[],false,false],12,4,{[]}],
		[[["LandVehicle"],["StaticWeapon"],false,false],12,0,{[]}],
		[[["CaManBase"],["C_man_sport_1_F_afro","C_man_polo_1_F"],true,false],16,4,{BRPVP_meusAmigosObj}],
		[[["C_man_polo_1_F"],[],true,false],16,4,{[]}]
	];
	_radiusMult = 1.25;
	_mngLocalEnt = {
		private ["_objectPos2D","_objectPos2DNew"];
		_objectPos2D = _this getVariable ["brpvp_fpsBoostPos",[0,0]];
		_objectPos2DNew = getPosWorld _this;
		_objectPos2DNew resize 2;
		if (_objectPos2DNew distance2D _objectPos2D > 5) then {_this setVariable ["brpvp_fpsBoostPos",_objectPos2DNew,true];};
		if !(simulationEnabled _this) then {_this enableSimulation true;};
	};
	_mngNotLocalEnt = {
		private ["_objectPos2D"];
		_objectPos2D = _this getVariable ["brpvp_fpsBoostPos",[0,0]];
		if (_objectPos2D distance2D _posPlayer2D < _radius || {(getPosWorld _this) distance2D _posPlayer2D < _radius}) then {
			if !(simulationEnabled _this) then {_this enableSimulation true;};
		} else {
			if (simulationEnabled _this) then {_this enableSimulation false;};
		};
	};
	_init = 0;
	_count = 0;
	_cycleTime = 0.25;
	_canDisable = hasInterface && !isServer;
	waitUntil {
		private ["_time","_delta"];
		_time = time;
		_delta = _time - _init;
		if (_delta >= _cycleTime) then {
			_init = _time - (_delta - _cycleTime);
			_count = _count + 1;
			if (_canDisable) then {
				private ["_posPlayer2D","_radius"];
				_radius = if (BRPVP_completeUpdate || _count mod 120 == 0) then {100000} else {viewDistance * _radiusMult};
				_posPlayer2D = if (isNull BRPVP_spectedPlayer) then {getPosWorld player} else {BRPVP_spectedPlayer getVariable ["brpvp_fpsBoostPos",[0,0]]};
				_posPlayer2D resize 2;
				{
					_x params ["_search","_cycle","_shift","_excludeCode"];
					_exclude = call _excludeCode;
					if ((_count + _shift) mod _cycle == 0) then {
						{
							if (local _x) then {_x call _mngLocalEnt;} else {_x call _mngNotLocalEnt;};
						} forEach (if (count _exclude > 0) then {(entities _search) - _exclude} else {entities _search});
						{if !(simulationEnabled _x) then {_x enableSimulation true;};} forEach _exclude;
					};
				} forEach _entitiesCategory;
			} else {
				{
					_x params ["_search","_cycle","_shift"];
					if ((_count + _shift) mod _cycle == 0) then {{if (local _x) then {_x call _mngLocalEnt;};} forEach (entities _search);};
				} forEach _entitiesCategory;
			};
		};
		false
	};
};