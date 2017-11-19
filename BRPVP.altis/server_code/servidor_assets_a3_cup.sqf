if (isNil "BRPVP_tudoA3") then {
	//ARMA 3
	_veicSpawnCivCars = [];
	_veicSpawnCivHelis = [];
	_veicSpawnMilCarsArm = [];
	_veicSpawnMilCarsDes = [];
	_veicSpawnMilHelisArm = [];
	_veicSpawnMilHelisDes = [];
	_veicSpawnMilApcsArm = [];
	_veicSpawnMilApcsDes = [];
	_veicSpawnMilTanksArm = [];
	_veicSpawnMilTanksDes = [];

	BRPVP_tudoA3 = [];
	_allDescr = [];
	_facExcluida = BRPVP_mapaRodando select 17;
	{
		_lado = "";
		_fac = "";
		_cat = "";
		if (isNumber (_x >> "side")) then {
			_ladoN = getNumber (_x >> "side");
			switch _ladoN do {
				case 0 : {_lado = "COMUNISM";};
				case 1 : {_lado = "CAPTALISM";};
				case 2 : {_lado = "GUERRILLA";};
				case 3 : {_lado = "CIVIL";};
			};
		};
		if (isText (_x >> "faction")) then {
			_facC = getText (_x >> "faction");
			_fac = getText (configFile >> "CfgFactionClasses" >> _facC >> "displayName");
		};
		if (isText (_x >> "editorSubcategory")) then {
			_catC = getText (_x >> "editorSubcategory");
			_cat = getText (configFile >> "CfgEditorSubcategories" >> _catC >> "displayName");
		};
		if (_lado == "CIVIL") then {
			if !(_fac in ["Civilians","Civilians (Chenarus)","Civilians (Takistan)","Civilians (Russian)"]) then {_fac = "";};
		} else {
			if (_fac in ["Others","Other","Civilians"]) then {_fac = "";};
		};
		if (_cat in ["Turrets","Targets","Storage","Drones","Submersibles","Boats"]) then {_cat = "";};
		if (_lado != "" && (_fac != "" && !(_fac in _facExcluida)) && _cat != "") then {
			_classe = configName _x;
			_passa = ({_classe find _x >= 0} count ["_base","_Base","_BASE"]) == 0;
			if (_passa) then {
				if !(_classe isKindOf "Man") then {
					if (isText (_x >> "displayName")) then {
						_descr = getText (_x >> "displayName");
						if ({_descr find _x >= 0} count ["parachute","PARACHUTE","Parachute","&"] == 0 && _descr != "") then {
							if !(_descr in _allDescr) then {
								_allDescr pushBack _descr;
								_valor = -1;
								if (isNumber (_x >> "cost")) then {_valor = getNumber (_x >> "cost");};
								BRPVP_tudoA3 pushBack [_lado,_fac,_cat,_classe,_descr,_valor];
								if (_lado == "CIVIL") then {
									if (_cat == "Cars") exitWith {_veicSpawnCivCars pushBack _classe;};
									if (_cat == "Helicopters") exitWith {_veicSpawnCivHelis pushBack _classe;};
								} else {
									_armado = {_classe find _x >= 0 || _descr find _x >= 0} count ["unarmed","Unarmed","UNARMED"] == 0;
									if (_cat == "Cars") exitWith {
										if (_armado) then {
											_veicSpawnMilCarsArm pushBack _classe;
										} else {
											_veicSpawnMilCarsDes pushBack _classe;
										};
									};
									if (_cat == "Helicopters") exitWith {
										if (_armado) then {
											_veicSpawnMilHelisArm pushBack _classe;
										} else {
											_veicSpawnMilHelisDes pushBack _classe;
										};
									};
									if (_cat == "APCs") exitWith {
										if (_armado) then {
											_veicSpawnMilApcsArm pushBack _classe;
										} else {
											_veicSpawnMilApcsDes pushBack _classe;
										};
									};
									if (_cat == "Tanks") exitWith {
										if ({_descr find _x >= 0} count ["unarmed","Unarmed","UNARMED"] == 0) then {
											_veicSpawnMilTanksArm pushBack _classe;
										} else {
											_veicSpawnMilTanksDes pushBack _classe;
										};
									};
								};
							};
						};
					};
				};
			};
		};
	} forEach ("true" configClasses (configFile >> "CfgVehicles"));
	publicVariable "BRPVP_tudoA3";

	diag_log "===============================================================";
	diag_log "== BRPVP_tudoA3 BEGIN =========================================";
	{diag_log str _x;} forEach BRPVP_tudoA3;
	diag_log "== BRPVP_tudoA3 END ===========================================";
	diag_log "===============================================================";

	//VEICULOS PERMITIDOS
	BRPVP_veiculosC = [_veicSpawnCivCars,_veicSpawnMilCarsDes,_veicSpawnMilApcsDes,_veicSpawnMilTanksDes,_veicSpawnMilCarsArm,_veicSpawnMilApcsArm,_veicSpawnMilTanksArm];
	BRPVP_veiculosH = [_veicSpawnCivHelis,_veicSpawnMilHelisDes,_veicSpawnMilHelisArm];

	diag_log "===============================================================";
	diag_log "== BRPVP_veiculosC BEGIN ======================================";
	{diag_log str _x;} forEach BRPVP_veiculosC;
	diag_log "== BRPVP_veiculosC END ========================================";
	diag_log "===============================================================";

	diag_log "===============================================================";
	diag_log "== BRPVP_veiculosH BEGIN ======================================";
	{diag_log str _x;} forEach BRPVP_veiculosH;
	diag_log "== BRPVP_veiculosH END ========================================";
	diag_log "===============================================================";

	//DEL NULL LAND VEHICLES CAT.
	_delIndex = [];
	{
		if (count _x == 0) then {
			_delIndex pushBack _forEachIndex;
		};
	} forEach BRPVP_veiculosC;
	_delIndex sort false;
	{
		BRPVP_veiculosC deleteAt _x;
	} forEach _delIndex;

	//DEL NULL HELIS CAT.
	_delIndex = [];
	{
		if (count _x == 0) then {
			_delIndex pushBack _forEachIndex;
		};
	} forEach BRPVP_veiculosH;
	_delIndex sort false;
	{
		BRPVP_veiculosH deleteAt _x;
	} forEach _delIndex;
};