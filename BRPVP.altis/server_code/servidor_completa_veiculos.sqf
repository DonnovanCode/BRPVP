//PEGA CONFIGURACOES DO MAPA
_quantiaCarrosParaNascer = (BRPVP_mapaRodando select 4) - count BRPVP_carrosObjetos;
_contaTudo = 0;

//COMPLETA A QUANTIA DE CARROS
if (_quantiaCarrosParaNascer > 0) then {
	for "_i" from 1 to _quantiaCarrosParaNascer do {
		private ["_vId"];
		
		//ESCOLHE RUA DE SPAWN
		_ruaDaVez = [BRPVP_ruas,[],[],150,-1,2] call BRPVP_achaCentroPrincipal;

		//SORTEIA CARRO
		_quais = [BRPVP_veiculosC,2.5] call LOL_fnc_selectRandomFator;
		_qual = _quais call BIS_fnc_selectRandom;
		_so = sizeOf _qual;
		
		//ACHA POSICAO DO CARRO
		_dir = ((getDir _ruaDaVez) + 90) - 10 + (random 20) + ((round random 1)* 180);
		_posRua = getPos _ruaDaVez;
		_pos = [_posRua,_posRua,3,5,20,30,4,4,_so/2,true,3,15,["Building","Air","LandVehicle"],["a3\plants_f\Tree\","a3\rocks_f\"],0,false] call BRPVP_achaLocal;
		
		//CRIA CARRO
		_veiculo = createVehicle [_qual,_pos,[],0,"NONE"];
		_veiculo setDir _dir;
		_veiculo setVectorUp surfaceNormal position _veiculo;
		_veiculo setVelocity [0,0,2];
		_contaTudo = _contaTudo + 1;
		
		//ESVAZIA VEICULO
		clearWeaponCargoGlobal _veiculo;
		clearMagazineCargoGlobal _veiculo;
		clearItemCargoGlobal _veiculo;
		clearBackpackCargoGlobal _veiculo;
		
		//REMOVE TURRET ON WHEELED APCS
		if ((typeOf _veiculo) in ["B_APC_Wheeled_01_cannon_F","O_APC_Wheeled_02_rcws_F","I_APC_Wheeled_03_cannon_F"]) then {
			_veiculo animate ["HideTurret",1];
		};

		//DINHEIRO CARRO
		//[_veiculo,150 + random 150] call BRPVP_qjsAdicClassObjetoServer;
		
		//ESTADO INICIAL DO CARRO
		_estadoCarro = [
			[[[],[]],[],[[],[]],[[],[]]],
			[getPosWorld _veiculo,[vectorDir _veiculo,vectorUp _veiculo]],
			_qual,
			-1,
			1,
			[[],[]],
			""
		];
		
		if (BRPVP_useExtDB3) then {
			//SALVA CARRO NO BANCO DE DADOS
			_key = format ["0:%1:createVehicle:%2:%3:%4:%5:%6:%7:%8:%9",BRPVP_protocolo,_estadoCarro select 0,_estadoCarro select 1,_estadoCarro select 2,_estadoCarro select 3,_estadoCarro select 4,_estadoCarro select 5,false,_estadoCarro select 6];
			_resultado = "extDB3" callExtension _key;
			
			//PEGA ID_BD DO CARRO E COLOCA NELE
			_key = format ["0:%1:getMaxIdBd",BRPVP_protocolo];
			_resultado = "extDB3" callExtension _key;
			_vId = call compile _resultado;
		} else {
			_vId = ["",[[BRPVP_noExtDB3IdBdVehicles]]];
			BRPVP_noExtDB3IdBdVehicles = BRPVP_noExtDB3IdBdVehicles + 1;
			(BRPVP_noExtDB3VehiclesTable select 0) pushBack BRPVP_noExtDB3IdBdVehicles;
			(BRPVP_noExtDB3VehiclesTable select 1) pushBack _estadoCarro;
			(BRPVP_noExtDB3VehiclesTable select 2) pushBack false;
		};
		_vId = _vId select 1 select 0 select 0;
		_veiculo setVariable ["id_bd",_vId,false];
		
		//COLOCA EH NO CARRO E BOTA ELE NO ARRAY DE CARROS
		_veiculo call BRPVP_veiculoEhReset;
		BRPVP_carrosObjetos pushBack _veiculo;
	};
};

//VARIAVEIS DO MAPA PARA SPAWN DE HELI
_quantiaHelisParaNascer = (BRPVP_mapaRodando select 5 select 0) - count BRPVP_helisObjetos;

//COMPLETA A QUANTIA DE HELICOPTEROS
if (_quantiaHelisParaNascer > 0) then {
	private ["_hId"];
	
	//ACHA HANGARES OU CONSTRUCOES PARA HELI
	_consHeli = BRPVP_mapaRodando select 5 select 1;
	_consHeliQttMeta = BRPVP_mapaRodando select 5 select 2;
	_consHeliObjs = nearestObjects [BRPVP_centroMapa,_consHeli,20000];
	
	//VARIAVEIS INICIAIS
	_pos = [0,0,0];
	_dir = 0;
	
	//ACHA HELIS QUE JA ESTAO NAS CONSTRUCOES DE HELI
	_aeropHelis = [];
	_aeroHelisRuas = [];
	{
		_achados = _x nearObjects ["Air",350];
		_achadosRuas = _x nearRoads 350;
		_aeropHelis = _aeropHelis - _achados;
		_aeropHelis append _achados;
		_aeroHelisRuas = _aeroHelisRuas - _achadosRuas;
		_aeroHelisRuas append _achadosRuas;
	} forEach _consHeliObjs;
	_ruasHelisPadrao = BRPVP_ruas - _aeroHelisRuas;
	
	//CALCULA QUANTOS HELIS ADICIONAR NAS CONSTRUCOES DE HELI (NORMALMENTE HANGARES)
	_consHeliQttAgora = count _aeropHelis;
	_adicAerop = (_consHeliQttMeta - _consHeliQttAgora) max 0;

	//SPAWNA HELIS
	for "_i" from 1 to _quantiaHelisParaNascer do {
		//SORTEIA HELI
		_quais = [BRPVP_veiculosH,3] call LOL_fnc_selectRandomFator;
		_qual = _quais call BIS_fnc_selectRandom;
		_so = sizeOf _qual;

		//PEGA POSICAO PERTO DA CONSTRUCAO DE HELIS (NORMALMENTE HANGARES)
		_pos = [0,0,0];
		_ocorrido = "nada";
		if (_adicAerop > 0) then {
			_adicAerop = _adicAerop - 1;
			if (count _consHeliObjs > 0) then {
				_centro = getPosATL (_consHeliObjs call BIS_fnc_selectRandom);
				_pos = [_centro,[0,0,0],35,15,135,200,10,10,_so/2,true,999,12,["Building","Air","LandVehicle"],["a3\plants_f\Tree\","a3\rocks_f\"],0,false] call BRPVP_achaLocal;
				_dir = random 360;
				if (str _pos == "[0,0,0]") then {
					diag_log "[BRPVP ALERT] NOT ABLE TO SPAWN HELI ON AIRPORT!";
				} else {
					_ocorrido = "spawn_aero";
				};
			} else {
				_ocorrido = "fail";
			};
		};
		
		//ACHA POSICAO MODELO PADRAO
		if (_ocorrido == "nada") then {
			_ocorrido = "spawn_normal";
			
			//ESCOLHE RUA DE SPAWN
			_ruaDaVez = [_ruasHelisPadrao,[],[],150,-1,5] call BRPVP_achaCentroPrincipal;
			
			//ACHA POSICAO DO HELI
			_dir = (getDir _ruaDaVez + 90) - 10 + (random 20) + ((round random 1)* 180);
			_posRua = getPos _ruaDaVez;
			_pos = [_posRua,_posRua,15,50,150,150,10,10,_so/2,false,999,12,["Building","Air","LandVehicle"],["a3\plants_f\Tree\","a3\rocks_f\"],0,false] call BRPVP_achaLocal;
			_pos set [2,0];
		};
		
		//CRIA HELI E SALVA NO BD
		if (_ocorrido != "fail") then {
			//CRIA HELI
			_heli = createVehicle [_qual,_pos,[],0,"NONE"];
			_heli setDir _dir;
			_contaTudo = _contaTudo + 1;
			
			//ESVAZIA VEICULO
			clearWeaponCargoGlobal _heli;
			clearMagazineCargoGlobal _heli;
			clearItemCargoGlobal _heli;
			clearBackpackCargoGlobal _heli;

			//DINHEIRO HELI
			//[_heli,75 + random 150] call BRPVP_qjsAdicClassObjetoServer;
			
			//ESTADO INICIAL DO HELI
			_estadoHeli = [
				[[[],[]],[],[[],[]],[[],[]]],
				[getPosWorld _heli,[vectorDir _heli,vectorUp _heli]],
				_qual,
				-1,
				1,
				[[],[]],
				""
			];
			
			if (BRPVP_useExtDB3) then {
				//SALVA HELI NO BANCO DE DADOS
				_key = format ["0:%1:createVehicle:%2:%3:%4:%5:%6:%7:%8:%9",BRPVP_protocolo,_estadoHeli select 0,_estadoHeli select 1,_estadoHeli select 2,_estadoHeli select 3,_estadoHeli select 4,_estadoHeli select 5,false,_estadoHeli select 6];
				_resultado = "extDB3" callExtension _key;
				
				//PEGA ID_BD DO HELI E SALVA NELE
				_key = format ["0:%1:getMaxIdBd",BRPVP_protocolo];
				_resultado = "extDB3" callExtension _key;
				_hId = call compile _resultado;
			} else {
				_hId = ["",[[BRPVP_noExtDB3IdBdVehicles]]];
				BRPVP_noExtDB3IdBdVehicles = BRPVP_noExtDB3IdBdVehicles + 1;
				(BRPVP_noExtDB3VehiclesTable select 0) pushBack BRPVP_noExtDB3IdBdVehicles;
				(BRPVP_noExtDB3VehiclesTable select 1) pushBack _estadoHeli;
				(BRPVP_noExtDB3VehiclesTable select 2) pushBack false;
			};
			_hId = _hId select 1 select 0 select 0;
			_heli setVariable ["id_bd",_hId,false];

			//CRIA EH DO HELI E BOTA ELE NO ARRAY DE HELIS
			_heli call BRPVP_veiculoEhReset;
			BRPVP_helisObjetos pushBack _heli;
		};
	};
};

//MANDA ARRAY DE HELIS E CARROS PARA OS CLIENTES
//publicVariable "BRPVP_carrosObjetos";
//publicVariable "BRPVP_helisObjetos";