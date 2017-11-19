_vehicle = _this select 3;
if (isNull driver _vehicle) then {
	_mny = player getVariable "mny";
	if (!isNull _vehicle && alive _vehicle && fuel _vehicle > 0 && canMove _vehicle) then {
		if (_mny >= BRPVP_towLandVehiclePrice) then {
			BRPVP_landVehicleOnTow = _vehicle;
			BRPVP_actionRunning pushBack 10;
			player setVariable ["mny",_mny - BRPVP_towLandVehiclePrice,true];
			call BRPVP_atualizaDebug;
			playSound "negocio";
			_agnt = createAgent ["C_Driver_1_F",[0,0,0],[],20,"NONE"];
			_agnt disableAI "FSM";
			_agnt setCaptive true;
			_agnt allowDamage false;
			_agnt moveInDriver _vehicle;
			[_vehicle,true] call BRPVP_setFlagProtectionOnVehicleNotLast;
			waitUntil {driver _vehicle == _agnt};
			if (_vehicle getVariable ["id_bd",-1] != -1) then {_vehicle setVariable ["slv",true,true];};
			//[_agnt] join group player;
			_vehicle setVariable ["towner",_agnt,false];
			player setVariable ["towner",_agnt,true];
			(group player) selectLeader player;
			(group player) setFormation "COLUMN";
			_destine = ASLToAGL getPosASL player;
			_agnt moveTo ASLToAGL getPosASL _agnt;
			_playerWant = true;
			waitUntil {
				_notNull = !isNull _vehicle;
				_isAlive = alive _vehicle;
				_haveFuel = fuel _vehicle > 0;
				_canMove = canMove _vehicle;
				_isDriver = driver _vehicle isEqualTo _agnt;
				_playerWant = 10 in BRPVP_actionRunning;
				_chiefAlive = alive player;
				_distance = _vehicle distance player;
				_hasAccess = _vehicle call BRPVP_checaAcesso;
				_angle1 = [_agnt,player] call BIS_fnc_dirTo;
				_angle2 = [_agnt,_destine] call BIS_fnc_dirTo;
				_angleDiff = abs((_angle1 + 360) - (_angle2 + 360));
				if (_distance > 20) then {
					if (moveToCompleted _agnt || {_angleDiff > 15 && _destine distanceSqr player > 400}) then {
						_destine = ASLToAGL getPosASL player;
						if (!moveToCompleted _agnt) then {_agnt moveTo ASLToAGL getPosASL _agnt;};
						_agnt moveTo _destine;
					};
				} else {
					if (!moveToCompleted _agnt) then {_agnt moveTo ASLToAGL getPosASL _agnt;};
				};
				!(_notNull && _isAlive && _haveFuel && _canMove && _isDriver && _playerWant && _chiefAlive && _hasAccess && _distance < 5000)
			};
			BRPVP_landVehicleOnTow = objNull;
			if (_playerWant) then {
				[localize "str_tow_fail"] call BRPVP_hint;
				BRPVP_actionRunning = BRPVP_actionRunning - [10];
			} else {
				[localize "str_tow_ok"] call BRPVP_hint;
			};
			deleteVehicle _agnt;
			_vehicle engineOn false;
			[_vehicle,false] call BRPVP_setFlagProtectionOnVehicleNotLast;
		} else {
			[localize "str_no_money"] call BRPVP_hint;
		};
	} else {
		[localize "str_tow_cant"] call BRPVP_hint;
	};
} else {
	[localize "str_tow_driver_pos"] call BRPVP_hint;
};