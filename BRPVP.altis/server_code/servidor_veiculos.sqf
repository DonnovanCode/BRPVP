//VARIAVEIS INICIAIS
_ultimoId = -1;
_resultado = "";
_contaVeiculos = 0;
BRPVP_carrosObjetos = [];
BRPVP_helisObjetos = [];

//VEICULOS DO BANCO DA DADOS PARA O JOGO
while {_resultado != "[1,[]]"} do {
	private ["_veiculo","_isSO"];
	if (BRPVP_useExtDB3) then {
		//CONSULTA PARA PEGAR VEICULO
		_key = format ["0:%1:getObjects:%2",BRPVP_protocolo,_ultimoId];
		_resultado = "extDB3" callExtension _key;
	} else {
		_resultado = [1,[]];
		{
			(_resultado select 1) pushBack [
				BRPVP_noExtDB3VehiclesTable select 0 select _forEachIndex,
				0,
				_x select 0,
				_x select 1,
				_x select 2,
				_x select 3,
				_x select 4,
				_x select 5,
				BRPVP_noExtDB3VehiclesTable select 2 select _forEachIndex,
				_x select 6
			];
		} forEach (BRPVP_noExtDB3VehiclesTable select 1);
		_resultado = str _resultado;
	};

	//BOTA VEICULO NO JOGO
	if (_resultado != "[1,[]]") then {
		//COMPILA RESULTADO
		_resultadoCompilado = call compile _resultado;
		_resultadoCompilado = _resultadoCompilado select 1;
		_idcMax = count _resultadoCompilado - 1;

		for "_i" from 0 to _idcMax do {
			//DADOS VEICULO
			_veiculoId = _resultadoCompilado select _i select 0;
			_carga = _resultadoCompilado select _i select 2;
			_posicao = _resultadoCompilado select _i select 3;
			_modelo = _resultadoCompilado select _i select 4;
			_owner = _resultadoCompilado select _i select 5;
			_comp = _resultadoCompilado select _i select 6;
			_amigos = _resultadoCompilado select _i select 7;
			_mapa = _resultadoCompilado select _i select 8;
			_exec = _resultadoCompilado select _i select 9;
			_lock = _resultadoCompilado select _i select 10;
			
			//ADICIONA ENTRADA DE LOG
			//diag_log "-----------------------------------------------------------------------";
			//diag_log ("---- Model: " + _modelo);
			//diag_log ("---- Id: " + str _veiculoId);
			//diag_log ("---- Position: " + str _posicao);
			//diag_log ("---- Cargo: " + str _carga);
			//diag_log ("---- Owner: " + str _owner);
			//diag_log ("---- Comp: " + str _comp);
			//diag_log ("---- Friends: " + str _amigos);
			//diag_log ("---- Map House: " + str _mapa);
			//diag_log ("---- Exec: " + _exec);
			//diag_log ("---- Lock: " + str _lock);
			//diag_log "-----------------------------------------------------------------------";
			
			//ID_BD DO VEICULO
			_ultimoId = _veiculoId;
			
			//POSICAO
			_vPWD = _posicao select 0;
			_vVDU = _posicao select 1;

			_isMotorized = _modelo call BRPVP_isMotorized;
			_isSO = false;
			if (_mapa) then {
				//ACHA VEICULO NO MAPA
				_veiculo = nearestObject [ASLToATL _vPWD,_modelo];
				if (!isNull _veiculo) then {
					_veiculo setVariable ["mapa",true,true];
					_veiculo allowDamage !BRPVP_interactiveBuildingsGodMode;
				} else {
					diag_log ("[BRPVP: CAN'T FIND MAP OBJECT] id = " + str _veiculoId + ".");
				};
			} else {
				//CRIA E POSICIONA VEICULO
				if (_isMotorized) then {
					_veiculo = createVehicle [_modelo,_vPWD,[],0,"CAN_COLLIDE"];
				} else {
					if (_modelo in BRPVP_buildingHaveDoorList) then {
						_veiculo = createVehicle [_modelo,[0,0,0],[],0,"CAN_COLLIDE"];
						_veiculo allowDamage !BRPVP_interactiveBuildingsGodMode;
						_state = if (_modelo in BRPVP_buildingHaveDoorListReverseDoor) then {1} else {0};
						if (_veiculo call BRPVP_isBuilding) then {
							{
								if (_veiculo animationPhase _x != _state) then {
									_veiculo animate [_x,_state];
								};
							} forEach animationNames _veiculo;
						};
					} else {
						_isSO = true;
						_veiculo = createSimpleObject [_modelo,AGLToASL [0,0,0]];
					};
				};
				_veiculo setPosWorld _vPWD;
				_veiculo setVectorDirAndUp _vVDU;
			};
			if (!isNull _veiculo) then {
				_contaVeiculos = _contaVeiculos + 1;
				_veiculo setVariable ["id_bd",_veiculoId,true];
				_veiculo setVariable ["own",_owner,true];
				if (_owner != -1) then {
					_veiculo setVariable ["stp",_comp,true];
					_veiculo setVariable ["amg",_amigos,true];
				};

				//ADICIONA VEICULO NO ARRAY DE CARROS CASO SEJA CARRO
				if (_veiculo isKindOf "LandVehicle") then {
					BRPVP_carrosObjetos pushBack _veiculo;
					if ((typeOf _veiculo) in ["B_APC_Wheeled_01_cannon_F","O_APC_Wheeled_02_rcws_F","I_APC_Wheeled_03_cannon_F"]) then {
						_veiculo animate ["HideTurret",1];
					};
					if (_veiculo isKindOf "StaticWeapon") then {
						_turretPos = getPosWorld _veiculo;
						_turretPos resize 2;
						_veiculo setVariable ["brpvp_fpsBoostPos",_turretPos,true];
					};
				};
				
				//ADICIONA VEICULO NO ARRAY DE HELIS CASO SEJA HELI
				if (_veiculo isKindOf "Air") then {
					BRPVP_helisObjetos pushBack _veiculo;
				};
				
				//ADICIONA AS CASAS
				if (!_isMotorized) then {
					BRPVP_ownedHouses pushBack _veiculo;
				};
				
				//ADICIONA CARGA DO CARRO
				clearWeaponCargoGlobal _veiculo;
				clearMagazineCargoGlobal _veiculo;
				clearItemCargoGlobal _veiculo;
				clearBackpackCargoGlobal _veiculo;
				{_veiculo addWeaponCargoGlobal [if (typeName _x == "SCALAR") then {BRPVP_ItemsClassToNumberTableA select _x} else {_x},(_carga select 0 select 1 select _forEachIndex)];} forEach (_carga select 0 select 0);
				{_veiculo addMagazineAmmoCargo [if (typeName (_x select 0) == "SCALAR") then {BRPVP_ItemsClassToNumberTableB select (_x select 0)} else {_x select 0},1,_x select 1];} forEach (_carga select 1);
				{_veiculo addItemCargoGlobal [if (typeName _x == "SCALAR") then {BRPVP_ItemsClassToNumberTableC select _x} else {_x},(_carga select 2 select 1 select _forEachIndex)];} forEach (_carga select 2 select 0);
				{_veiculo addBackpackCargoGlobal [if (typeName _x == "SCALAR") then {BRPVP_ItemsClassToNumberTableD select _x} else {_x},(_carga select 3 select 1 select _forEachIndex)];} forEach (_carga select 3 select 0);

				if (!_isSO) then {
					_veiculo call BRPVP_veiculoEhReset;
				};

				//EXEC OBJECT CODE
				if (_exec != "") then {
					_veiculo call compile _exec;
					diag_log ("EXEC: " + _exec);
				};
				
				//SET VEHICLE LOCK
				if !(_lock == 0) then {_veiculo setVariable ["brpvp_locked",!(_lock == 0),true];};
			};
		};
	};
	if (!BRPVP_useExtDB3) then {_resultado = "[1,[]]";};
};

//GET FLAGS
BRPVP_allFlags = [];
{
	if (_x isKindOf "FlagCarrier") then {
		_x setVariable ["brpvp_flag_protected",true,true];
		BRPVP_allFlags pushBack _x;
	};
} forEach BRPVP_ownedHouses;
publicVariable "BRPVP_allFlags";

//THREAT FLAG NEAR OBJECTS
if (!BRPVP_interactiveBuildingsGodMode) then {
	if (BRPVP_flagBuildingsGodMode) then {
		{
			_flag = _x;
			_dist = _flag call BRPVP_getFlagRadius;
			{
				if (_x distance2D _flag <= _dist) then {
					if ([_x,_flag] call BRPVP_checaAcessoRemotoFlag) then {
						_x allowDamage false;
						_x setVariable ["brpvp_flag_protected",true,true];
					};
				};
			} forEach BRPVP_ownedHouses;
		} forEach BRPVP_allFlags;
	};
};

//SET GOD MOD ON EMPTY VEHICLES IN FRIENDLY FLAG AREAS
if (BRPVP_flagVehiclesGodModeWhenEmpty) then {
	{
		_flag = _x;
		_dist = _flag call BRPVP_getFlagRadius;
		{
			if !(_x getVariable ["own",-1] isEqualTo -1) then {
				if ([_x,_flag] call BRPVP_checaAcessoRemotoFlag) then {
					if !(_x isKindOf "StaticWeapon") then {
						_x allowDamage false;
					};
				};
			};
		} forEach nearestObjects [_flag,["LandVehicle","Air","Ship"],_dist,true];
	} forEach BRPVP_allFlags;
};

//SET GODMODE ON VEHICLES INSIDE TRAVELING AID AREAS
{
	_x params ["_center","_radius"];
	{_x allowDamage false;} forEach nearestObjects [_center,["landVehicle","Air","Ship"],_radius,true];
} forEach BRPVP_travelingAidPlaces;

publicVariable "BRPVP_ownedHouses";