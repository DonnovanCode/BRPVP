BRPVP_actionRunning pushBack 13;
_reliObj = _this select 3;
_distance = 200;
_force = count (_reliObj nearEntities ["C_man_polo_1_F",_distance]) * 0.25;
if (_force == 0) then {
	[localize "str_burn_herege_fail1"] call BRPVP_hint;
} else {
	private ["_nearZombies","_zCount"];
	_force = (_force min 20) max 5;
	_reliPos = ASLToAGL getPosASL _reliObj;
	_burnOk = [];
	while {
		_nearZombies = _reliObj nearEntities ["C_man_polo_1_F",_distance];
		_nearZombies = _nearZombies - _burnOk;
		_zCount = count _nearZombies;
		_zCount > 0
	} do {
		_nearZombies = _nearZombies apply {[_x distanceSqr _reliObj,_x]};
		_nearZombies sort true;
		_nearZombies resize (_force min _zCount);
		_bolt = createVehicle ["Lightning_F",_reliPos vectorAdd [-16.6,-3.2,0],[],0,"CAN_COLLIDE"];
		_light = createvehicle ["#lightpoint",(_reliPos vectorAdd [-16.6,-3.2,20]),[],0,"CAN_COLLIDE"];
		_light setLightAttenuation [10,0,0.5,0];
		_light setLightBrightness 1.5;
		_light setLightColor [0.8,0.8,1];
		_vp2 = getPosWorld _reliObj;
		_vp2 set [2,0];
		[_reliObj,["thunder_1",800]] remoteExec ["say3D",0,false];
		[_reliObj,["thunder_2",800]] remoteExec ["say3D",0,false];
		[_bolt,_light] spawn {sleep 0.3;{deletevehicle _x;} forEach _this;};
		{
			_agnt = _x select 1;
			_burnOk pushBack _agnt;
			_vp1 = getPosWorld _agnt;
			_vp1 set [2,0];
			_velocity = (vectorNormalized ((vectorNormalized (_vp1 vectorDiff _vp2)) vectorAdd [0,0,0.7])) vectorMultiply (15 + random 5);
			[_agnt,_velocity] remoteExec ["setVelocity",_agnt,false];
			_agnt spawn {
				sleep 1;
				_init = time;
				waitUntil {(position _this) select 2 < 0.125 || time - _init > 5};
				_this setDamage 1;
			};
		} forEach _nearZombies;
		sleep 2;
	};
	[localize "str_burn_herege_ok"] call BRPVP_hint;
};
sleep 5;
BRPVP_actionRunning = BRPVP_actionRunning - [13];