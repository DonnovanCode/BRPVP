if !(BRPVP_mapaRodando select 6 select 0) exitWith {};
BRPVP_botViajemMinima = 1600;
BRPVP_botViajemMaxima = 5000;
BRPVP_botDistUltimoDestino = 2000;
BRPVP_botQuantiaDestinos = 2;
BRPVP_fazRotaAPe = {
	params ["_origin","_group","_speed"];
	private ["_origin","_group","_speed","_posBefore","_posNow","_wp","_posNext"];
	_posBefore = _origin;
	_posNow = _origin;
	_wp = _group addWaypoint [_posNow,0,0];
	_wp setWaypointCompletionRadius 15;
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed _speed;
	_posNext = [0,0,0];
	for "_c" from 1 to BRPVP_botQuantiaDestinos do {
		private ["_distToBefore","_distToNext","_found"];
		_distToBefore = 0;
		_distToNext = 0;
		_found = false;
		for "_x" from 1 to 200 do {
			private ["_otherIsland"];
			_posNext = BRPVP_isecs call BIS_fnc_selectRandom;
			_distToNext = _posNow distance _posNext;
			_distToBefore = _posNext distance _posBefore;
			_otherIsland = false;
			if (_distToNext > BRPVP_botViajemMinima && _distToNext < BRPVP_botViajemMaxima && _distToBefore > BRPVP_botDistUltimoDestino) then {
				private ["_otherIsland","_distUnits","_dltX","_dltY"];
				_found = true;
				_distUnits = _distToNext/20;
				_dltX = ((_posNext select 0) - (_posNow select 0))/_distUnits;
				_dltY = ((_posNext select 1) - (_posNow select 1))/_distUnits;
				for "_i" from 1 to _distUnits do {
					private ["_travelPos"];
					_travelPos = [(_posNow select 0)+_i*_dltX,(_posNow select 1)+_i*_dltX];
					if (surfaceIsWater _travelPos) exitWith {_found = false;};
				};
			};
			if (_found) exitWith {};
		};
		if (!_found) then {_posNext = BRPVP_isecs call BIS_fnc_selectRandom;};
		_wp = _group addWaypoint [_posNext,0,_c];
		_wp setWaypointCompletionRadius 15;
		_wp setWaypointType "MOVE";
		_wp setWaypointSpeed _speed;
		_posNow = _posNext;
	};
	_wp = _group addWaypoint [_origin,0,BRPVP_botQuantiaDestinos + 1];
	_wp setWaypointCompletionRadius 15;
	_wp setWaypointType "CYCLE";
	_wp setWaypointSpeed _speed;
};
_amount = BRPVP_mapaRodando select 6 select 1 select 0;
_aiLimit = BRPVP_mapaRodando select 6 select 1 select 1;
for "_i" from 1 to _amount do {
	private ["_rua","_grupo"];
	
	if (count BRPVP_bots >= _AILimit) exitWith {};
	
	_rua = [BRPVP_ruas,["Building"],[],300,-1,5,false] call BRPVP_achaCentroPrincipal;
	_posicaoBot = position _rua;
	
	//SET CHOOPER START AND END POSITION
	_xm = (BRPVP_mapaDimensoes select 0)/1.5;
	_ym = (BRPVP_mapaDimensoes select 1)/1.5;
	_angle = (_i - 1) * (360/_amount);
	_start = [[_xm,_ym,500],_xm min _ym,_angle] call BIS_fnc_relPos;
	_end = [[_xm,_ym,500],_xm min _ym,_angle] call BIS_fnc_relPos;
	diag_log ("[BRPVP AI ON FOOT HELI] _start = " + str _start);
	
	//CREATE PILOT
	_grpP = createGroup [WEST,true];
	_pilot = _grpP createUnit ["B_T_Helipilot_F",BRPVP_spawnAIFirstPos,[],5,"NONE"];
	_pilot setSkill 0.3;
	BRPVP_bots pushBack _pilot;
	
	//CREATE CHOPPER
	_dir = [_start,_posicaoBot] call BIS_fnc_dirTo;
	_heli = createVehicle ["B_Heli_Transport_03_F",_start,[],0,"FLY"];

	_heli setVariable ["iii",_i,false];
	_heli addEventHandler ["Killed",{diag_log ("[*****] HELI KILLED " + str ((_this select 0) getVariable "iii") + " !");}];

	_heli setPos _start;
	_heli setDir _dir;
	_heli flyInHeight 200;
	_pilot moveInDriver _heli;
	_pilot assignAsDriver _heli;
	
	_grupo = createGroup [WEST,true];
	_grupoInfant = [];
	while {count _grupoInfant == 0} do {
		_tenta = BRPVP_gruposDeInfantaria call BIS_fnc_selectRandom;
		_unid = _tenta select 0 select 0;
		if (_unid find "B_" == 0) then {_grupoInfant = _tenta;};
	};
	{
		_unidade = _grupo createUnit [_x select 0,BRPVP_spawnAIFirstPos,[],0,"FORM"];
		[_unidade] call BRPVP_fillUnitWeapons;
		_unidade addEventHandler ["killed",{_this call BRPVP_botDaExp;}];
		_unidade addEventHandler ["handleDamage",{_this call BRPVP_hdeh}];
		_unidade setUnitRank (_x select 1);
		_unidade setSkill 0.3;
		BRPVP_bots pushBack _unidade;
		_unidade moveInCargo _heli;
	} forEach _grupoInfant;
	[_posicaoBot,_grpP,_grupo,_end,_pilot,_heli] spawn {
		params ["_posicaoBot","_grpP","_grupo","_end","_pilot","_heli"];
		
		//CHOOPER PATH: INSERTION
		_wp = _grpP addWayPoint [_posicaoBot vectorAdd [0,0,150],0];
		_wp setWayPointType "MOVE";
		_wp setWayPointSpeed "FULL";

		waitUntil {currentWayPoint _grpP == 2};
		_wp = _grpP addWayPoint [_posicaoBot,0];
		_wp setWayPointType "TR UNLOAD";
		_wp setWayPointSpeed "FULL";

		waitUntil {currentWayPoint _grpP == 3};
		_wp = _grpP addWayPoint [_end,0];
		_wp setWayPointType "MOVE";
		_wp setWayPointSpeed "FULL";
		
		_grupo setBehaviour "SAFE";
		[_posicaoBot,_grupo,"LIMITED"] call BRPVP_fazRotaAPe;
		
		waitUntil {currentWayPoint _grpP == 4 || !alive _heli || !alive _pilot};
		if (alive _pilot && alive _heli) then {
			deleteVehicle _heli;
			deleteVehicle _pilot;
		};
	};
};
publicVariable "BRPVP_bots";
