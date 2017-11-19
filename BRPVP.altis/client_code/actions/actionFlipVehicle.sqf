BRPVP_actionRunning pushBack 3;
_car = _this select 3 select 0;
BRPVP_desviraVeiculo = _this select 3;
if (isServer) then {["",BRPVP_desviraVeiculo] call BRPVP_desviraVeiculoFnc;} else {publicVariableServer "BRPVP_desviraVeiculo";};
_init = time;
waitUntil {
	_vu = vectorUp _car;
	_angA = acos (_vu vectorCos [0,0,1]);
	_angB = acos (_vu vectorCos surfaceNormal (getPosATL _car));
	!(_angA > 60 && _angB > 20) || time - _init > 12
};
sleep 5;
if (alive _car) then {
	if !(_car getVariable ["slv",false]) then {_car setVariable ["slv",true,true]};
};
BRPVP_actionRunning deleteAt (BRPVP_actionRunning find 3);