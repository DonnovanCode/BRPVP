diag_log "[BRPVP FILE] nascimento_player.sqf INITIATED";

//DISABLE DAMAGE
player allowDamage false;

//PRIVATE VARS
private ["_tempofora"];

//TELA PRETA
cutText ["","BLACK FADED",20];

//RESETA VOLUME
0 fadeSound 1;

//VERSAO
BRPVP_VB = "V0.2B2";

//CLICK MAPA
BRPVP_onMapSingleClick = BRPVP_padMapaClique;
BRPVP_onMapSingleClickExtra = {};

//ESPERA O ANTI-AMARELOU ACABAR
while {(getPlayerUID player) in BRPVP_noAntiAmarelou} do {
	cutText [localize "str_spawn_logoff_protection","BLACK FADED",10];
	sleep 1;
};
cutText ["","BLACK FADED",10];

//X SECONDS UNIT MOVEMENT CHECK
_init = time;

//ACHA CORPOS DO PLAYER
_ultimo = 0;
{
	_mId = _x getVariable ["id","0"];
	if (getPlayerUID player == _mId) then {
		BRPVP_meuAllDead pushBack _x;
		_ultimo = _ultimo max (_x getVariable ["hrm",0]);
	};
} forEach allDead;
_tempofora = serverTime - _ultimo;

//DELETA CORPOS EM EXCESSO
while {count BRPVP_meuAllDead > BRPVP_maxPlayerDeadBodyCount} do {
	_maisAntigo = 100000;
	_idcDel = 0;
	{
		_ant = _x getVariable ["hrm",100000];
		if (_ant < _maisAntigo) then {
			_maisAntigo = _ant;
			_idcDel = _forEachIndex;
		};
	} forEach BRPVP_meuAllDead;
	_corpo = BRPVP_meuAllDead select _idcDel;
	_mny = _corpo getVariable ["mny",0];
	if (_mny > 0) then {
		_suitCase = "Land_Suitcase_F" createVehicle [0,0,0];
		_suitCase setVariable ["mny",_mny,true];
		_suitCaseNewPos = getPosWorld _corpo;
		deleteVehicle _corpo;
		_suitCase setPosWorld (_suitCaseNewPos vectorAdd [0,0,1]);
	} else {
		deleteVehicle _corpo;
	};
	BRPVP_meuAllDead set [_idcDel,-1];
	BRPVP_meuAllDead = BRPVP_meuAllDead - [-1];
};

//SET CAPTIVE STATE
if (BRPVP_playerIsCaptive) then {
	player setCaptive true;
};


//CHECA ESTADO DO PLAYER NO BANCO DE DADOS
BRPVP_checaExistenciaPlayerBdRetorno = nil;
BRPVP_checaExistenciaPlayerBd = [player,BRPVP_VB];
if (isServer) then {["",BRPVP_checaExistenciaPlayerBd] call BRPVP_checaExistenciaPlayerBdFnc;} else {publicVariableServer "BRPVP_checaExistenciaPlayerBd";};
waitUntil {!isNil "BRPVP_checaExistenciaPlayerBdRetorno"};

//EXECUTA SE O PLAYER E ANTIGO E ESTA VIVO NO BANCO DE DADOS OU EM CASO DE REANIMACAO
if (BRPVP_checaExistenciaPlayerBdRetorno == "no_bd_e_vivo") then {
	private ["_resultadoCompilado","_armaNaMao"];
	
	//MOSTRA ICONES PERTINENTES
	call BRPVP_atualizaIconesSpawn;

	//GET PLAYER DATA FROM BODY (REVIVE) OR DATA BASE
	cutText [localize "str_please_wait","BLACK FADED",10];
	
	//PEGA PLAYER NO BD
	BRPVP_pegaPlayerBdRetorno = nil;
	BRPVP_pegaPlayerBd = player;
	if (isServer) then {["",BRPVP_pegaPlayerBd] call BRPVP_pegaPlayerBdFnc;} else {publicVariableServer "BRPVP_pegaPlayerBd";};
	waitUntil {!isNil "BRPVP_pegaPlayerBdRetorno"};

	//COMPILA INFORMACOES DO PLAYER VIVO
	_resultadoCompilado = call compile BRPVP_pegaPlayerBdRetorno;
	_resultadoCompilado = _resultadoCompilado select 1;
	
	//PELA PLAYER (DEIXA ELE PELADO)
	false call BRPVP_escolheModaPlayer;
	
	//MONEY
	_money = _resultadoCompilado select 0 select 10;
	player setVariable ["mny",_money,true];

	//SPECIAL ITEMS
	_sit = _resultadoCompilado select 0 select 11;
	player setVariable ["sit",_sit,true];

	//MONEY BANK
	_moneyBank = _resultadoCompilado select 0 select 12;
	player setVariable ["brpvp_mny_bank",_moneyBank,true];
	
	//CAPACETE E OCULOS
	_modelo = _resultadoCompilado select 0 select 4;
	if (_modelo select 1 != "") then {player addHeadGear (_modelo select 1);};
	if (_modelo select 2 != "") then {player addGoggles (_modelo select 2);};
	
	//COMPARTILHAMENTO PADRAO
	player setVariable ["stp",_resultadoCompilado select 0 select 9,true];
	
	//ID DO BANCO DE DADOS
	_id_bd = _resultadoCompilado select 0 select 8;
	player setVariable ["id_bd",_id_bd,true];
	BRPVP_salvaNomePeloIdBd = [_id_bd,player getVariable "nm"];
	if (isServer) then {["",BRPVP_salvaNomePeloIdBd] call BRPVP_salvaNomePeloIdBdFnc;} else {publicVariableServer "BRPVP_salvaNomePeloIdBd";};
	
	//ASSIGNED PLAYER E (ARMAS + ASSIGNED)
	_inventario = _resultadoCompilado select 0 select 0;
	
	//ASSIGNED PLAYER
	{player addWeapon _x;} forEach (_inventario select 0);
	
	//ADICIONA VEST PARA RECEBER MAGAZINES DAS ARMAS
	player addBackpack "B_Carryall_oli";
	
	//ARMA PRIMARIA
	_wep = _inventario select 1 select 0;
	if (_wep != "") then {
		{player addMagazine _x;} forEach (_inventario select 1 select 2);
		player addWeapon _wep;
		{if (_x != "") then {player addPrimaryWeaponItem _x;};} forEach (_inventario select 1 select 1);
	};
	
	//ARMA SECUNDARIA
	_wep = _inventario select 2 select 0;
	if (_wep != "") then {
		{player addMagazine _x;} forEach (_inventario select 2 select 2);
		player addWeapon _wep;
		{if (_x != "") then {player addSecondaryWeaponItem _x;};} forEach (_inventario select 2 select 1);
	};
	
	//ARMA TERCIARIA
	_wep = _inventario select 3 select 0;
	if (_wep != "") then {
		{player addMagazine _x;} forEach (_inventario select 3 select 2);
		player addWeapon _wep;
		{if (_x != "") then {player addHandGunItem _x;};} forEach (_inventario select 3 select 1);
	};
	
	//REMOVE VEST UTILIZADA PARA RECEBER MAGAZINES DAS ARMAS
	removeBackpack player;

	//PLAYER TERRAINS
	if (count _inventario > 4) then {player setVariable ["owt",_inventario select 4,true];};

	//BACKPACK
	_backpack = _resultadoCompilado select 0 select 1;
	if ((_backpack select 0) select 0 != "") then {
		player addBackpack ((_backpack select 0) select 0);
		_BpObjeto = backpackContainer player;
		clearWeaponCargoGlobal _BpObjeto;
		clearItemCargoglobal _BpObjeto;
		clearMagazineCargoGlobal _BpObjeto;
		{_BpObjeto addWeaponCargoGlobal [_x,_backpack select 0 select 1 select 0 select 1 select _forEachIndex];} forEach (_backpack select 0 select 1 select 0 select 0);
		{_BpObjeto addItemCargoGlobal [_x,_backpack select 0 select 1 select 1 select 1 select _forEachIndex];} forEach (_backpack select 0 select 1 select 1 select 0);
		
		//TEMPORARIO
		_c = _backpack select 0 select 1 select 2;
		_antigo = false;
		if (count _c == 2) then {
			if (count (_c select 1) == 0) then {
				_antigo = true;
			} else {
				if (typeName (_c select 1 select 0) == "SCALAR") then {
					_antigo = true;
				};
			};
		};
		if (!_antigo) then {
			{_BpObjeto addMagazineAmmoCargo [_x select 0,1,_x select 1];} forEach (_backpack select 0 select 1 select 2);
		} else {
			{_BpObjeto addMagazineCargoGlobal [_x,_backpack select 0 select 1 select 2 select 1 select _forEachIndex];} forEach (_backpack select 0 select 1 select 2 select 0);
		};
	};
	
	//VEST
	if ((_backpack select 1) select 0 != "") then {
		player addVest ((_backpack select 1) select 0);
		_BpObjeto = vestContainer player;
		clearWeaponCargoGlobal _BpObjeto;
		clearItemCargoglobal _BpObjeto;
		clearMagazineCargoGlobal _BpObjeto;
		{_BpObjeto addWeaponCargoGlobal [_x,_backpack select 1 select 1 select 0 select 1 select _forEachIndex];} forEach (_backpack select 1 select 1 select 0 select 0);
		{_BpObjeto addItemCargoGlobal [_x,_backpack select 1 select 1 select 1 select 1 select _forEachIndex];} forEach (_backpack select 1 select 1 select 1 select 0);

		//TEMPORARIO
		_c = _backpack select 1 select 1 select 2;
		_antigo = false;
		if (count _c == 2) then {
			if (count (_c select 1) == 0) then {
				_antigo = true;
			} else {
				if (typeName (_c select 1 select 0) == "SCALAR") then {
					_antigo = true;
				};
			};
		};
		if (!_antigo) then {
			{_BpObjeto addMagazineAmmoCargo [_x select 0,1,_x select 1];} forEach (_backpack select 1 select 1 select 2);
		} else {
			{_BpObjeto addMagazineCargoGlobal [_x,_backpack select 1 select 1 select 2 select 1 select _forEachIndex];} forEach (_backpack select 1 select 1 select 2 select 0);
		};
	};
	
	//UNIFORME
	if ((_backpack select 2) select 0 != "") then {
		player forceAddUniform ((_backpack select 2) select 0); //TESTE TESTE TESTE
		_BpObjeto = uniformContainer player;
		clearWeaponCargoGlobal _BpObjeto;
		clearItemCargoglobal _BpObjeto;
		clearMagazineCargoGlobal _BpObjeto;
		{_BpObjeto addWeaponCargoGlobal [_x,_backpack select 2 select 1 select 0 select 1 select _forEachIndex];} forEach (_backpack select 2 select 1 select 0 select 0);
		{_BpObjeto addItemCargoGlobal [_x,_backpack select 2 select 1 select 1 select 1 select _forEachIndex];} forEach (_backpack select 2 select 1 select 1 select 0);

		//TEMPORARIO
		_c = _backpack select 2 select 1 select 2;
		_antigo = false;
		if (count _c == 2) then {
			if (count (_c select 1) == 0) then {
				_antigo = true;
			} else {
				if (typeName (_c select 1 select 0) == "SCALAR") then {
					_antigo = true;
				};
			};
		};
		if (!_antigo) then {
			{_BpObjeto addMagazineAmmoCargo [_x select 0,1,_x select 1];} forEach (_backpack select 2 select 1 select 2);
		} else {
			{_BpObjeto addMagazineCargoGlobal [_x,_backpack select 2 select 1 select 2 select 1 select _forEachIndex];} forEach (_backpack select 2 select 1 select 2 select 0);
		};
	};

	//ARMA NA MAO
	_armaNaMao = _resultadoCompilado select 0 select 5;

	//POSICAO
	_posicao = _resultadoCompilado select 0 select 2;
	_posS = _posicao select 1;
	player setDir (_posicao select 0);
	waitUntil {time - _init >= 3};
	_objs = nearestObjects [player,["LandVehicle","Air","Ship"],15];
	_obj = objNull;
	{
		if ([ASLToAGL _posS,_x] call PDTH_pointIsInBox) exitWith {_obj = _x;};
	} forEach _objs;
	if (isNull _obj) then {
		player setPosWorld _posS;			
	} else {
		player setVehiclePosition [_posS,[],0,"NONE"];
	};

	//SAUDE
	_saude = _resultadoCompilado select 0 select 3;
	
	//AMIGOS
	_amigos = _resultadoCompilado select 0 select 6;
	player setVariable ["amg",_amigos,true];

	//PEGA MEU STUFF
	if (!BRPVP_achaMeuStuffRodou) then {
		BRPVP_achaMeuStuffRodou = true;
		["FIND MY STUFF",BRPVP_achaMeuStuff] call BRPVP_execFast;
	};

	//EXPERIENCIA
	_experiencia = _resultadoCompilado select 0 select 7;
	player setVariable ["exp",_experiencia,true];

	//REVELA AO PLAYER OBJETOS POR PERTO
	{player reveal _x;} forEach (player nearObjects 35);

	//DAMAGE
	player setDamage (_saude select 2);
	player allowDamage true;
	{player setHitIndex [_forEachIndex,_x,false];} forEach (_saude select 0 select 1);
	player allowDamage false;
	BRPVP_alimentacao = _saude select 1 select 0;
	player setVariable ["sud",[round BRPVP_alimentacao,100],true];

	//LOGA INFORMACOES DO PLAYER
	diag_log "--------------------------------------------------------------------------------------------";
	diag_log "---- [SPAWN: PLAYER ON DB AND ALIVE]";
	diag_log ("---- model = " + str _modelo);
	diag_log ("---- gear = " + str _inventario);
	diag_log ("---- backpack = " + str _backpack);
	diag_log ("---- health = " + str _saude);
	diag_log ("---- weapon in hand = " + str _armaNaMao);
	diag_log ("---- trust = " + str _amigos);
	diag_log ("---- experience = " + str _experiencia);
	diag_log "--------------------------------------------------------------------------------------------";

	//INICIA CONTAGEM DOS UM MINUTO DE GAMEPLAY
	_nulo = [] spawn {
		_ini = time;
		waitUntil {time - _ini > 60 || !alive player};
		if (alive player) then {player setVariable ["umok",true,true];};
	};

	playSound "ugranted";

	//MENSAGEM ABOUT PLAYER MENU
	cutText ["","PLAIN",1];
	[localize "str_player_menu",5] call BRPVP_hint;

	//LIGA MODO ADMIN CASO SEJA UM ADMIN
	if (BRPVP_trataseDeAdmin) then {BRPVP_onMapSingleClick = BRPVP_adminMapaClique;} else {BRPVP_onMapSingleClick = BRPVP_padMapaClique;};
};

//PARA NOVAS VIDAS, COLOCA PLAYER CAINDO DE PARAQUEDAS
if (BRPVP_checaExistenciaPlayerBdRetorno in ["nao_ta_no_bd","no_bd_e_morto"]) then {
	private ["_id_bd"];
	
	//ALGUMAS VARIAVEIS
	_experiencia = + BRPVP_experienciaZerada;
	_amigos = [];
	
	//EXECUTA SE O PLAYER JA ESTA NO BANCO DE DADOS MAS ESTA MORTO
	if (BRPVP_checaExistenciaPlayerBdRetorno == "no_bd_e_morto") then {
		BRPVP_pegaValoresContinuaRetorno = nil;
		BRPVP_pegaValoresContinua = player;
		if (isServer) then {["",BRPVP_pegaValoresContinua] call BRPVP_pegaValoresContinuaFnc;} else {publicVariableServer "BRPVP_pegaValoresContinua";};
		waitUntil {!isNil "BRPVP_pegaValoresContinuaRetorno"};
		_resultadoCompilado = call compile BRPVP_pegaValoresContinuaRetorno;
		_resultadoCompilado = _resultadoCompilado select 1;
		_amigos = _resultadoCompilado select 0 select 0;
		_experiencia = _resultadoCompilado select 0 select 1;
		_id_bd = _resultadoCompilado select 0 select 2;
		player setVariable ["stp",_resultadoCompilado select 0 select 3,true];
		player setVariable ["sit",_resultadoCompilado select 0 select 5,true];
		player setVariable ["brpvp_mny_bank",_resultadoCompilado select 0 select 6,true];
		player setVariable ["mny",0,true];
		diag_log "--------------------------------------------------------------------------------------------";
		diag_log "---- [SPAWN: PLAYER ON DB AND DEAD]";
		diag_log ("---- VALUES TO MANTAIN: " + str _resultadoCompilado + ".");
		diag_log "--------------------------------------------------------------------------------------------";
	};
	
	//EXECUTA SE E A PRIMEIRA VEZ DO PLAYER
	if (BRPVP_checaExistenciaPlayerBdRetorno == "nao_ta_no_bd") then {
		BRPVP_incluiPlayerNoBdRetorno = nil;
		call BRPVP_incluiPlayerBd;
		diag_log "--------------------------------------------------------------------------------------------";
		diag_log "---- [SPAWN: PLAYER NOT IN DB]";
		diag_log ("---- CREATING PLAYER ON DB");
		diag_log "--------------------------------------------------------------------------------------------";
		waitUntil {!isNil "BRPVP_incluiPlayerNoBdRetorno"};
		_id_bd = BRPVP_incluiPlayerNoBdRetorno;
		player setVariable ["mny",BRPVP_startingMoney,true];
		player setVariable ["brpvp_mny_bank",BRPVP_startingMoneyOnBank,true];
		player setVariable ["sit",[],true];
		player setVariable ["stp",1,true];
		if (BRPVP_showTutorialFlag) then {true call BRPVP_showTutorial;};
	};
	
	//ID DO BANCO DE DADOS
	player setVariable ["id_bd",_id_bd,true];
	BRPVP_salvaNomePeloIdBd = [_id_bd,player getVariable "nm"];
	if (isServer) then {["",BRPVP_salvaNomePeloIdBd] call BRPVP_salvaNomePeloIdBdFnc;} else {publicVariableServer "BRPVP_salvaNomePeloIdBd";};
			
	//ESCOLHE VESTIMENTA DO PLAYER
	true call BRPVP_escolheModaPlayer;
	
	//ALIMENTACAO E HIDRATACAO
	BRPVP_alimentacao = 105;
	player setVariable ["sud",[round BRPVP_alimentacao,100],true];
	
	//EXPERIENCIA
	player setVariable ["exp",_experiencia,true];

	//AMIGOS
	player setVariable ["amg",_amigos,true];
	
	//PEGA MEU STUFF
	if (!BRPVP_achaMeuStuffRodou) then {
		BRPVP_achaMeuStuffRodou = true;
		["FIND MY STUFF",BRPVP_achaMeuStuff] call BRPVP_execFast;
	};
	call BRPVP_atualizaIconesSpawn;
	
	//SET UM MINUTO DE GAMEPLAY OK PORQUE A VIDA E NOVA
	player setVariable ["umok",true,true];
	
	//ESCOLHE LOCAL DE SPAWN PARTE 1
	cutText [localize "str_spawn_generating","BLACK FADED",10];
	sleep 3;
	_tipSom = ASLToAGL [0,0,0] nearestObject "#soundonvehicle";
	[localize "str_select_spawn",10] call BRPVP_hint;
	
	//ESCOLHE LOCAL DE SPAWN PARTE 2
	BRPVP_posicaoDeNascimento = nil;
	BRPVP_onMapSingleClick = BRPVP_nascMapaClique;
	BRPVP_temposLocais = [];
	{
		_cnt = _x select 0;
		_raio = _x select 1;
		_iName = "CNTG_NSC_" + str _forEachIndex;
		_iType = "mil_dot";
		_iColor = "ColorRed";
		_iText = "";
		_icone = createMarkerLocal [_iName,_cnt];
		_icone setMarkerShapeLocal "Icon";
		_icone setMarkerTypeLocal _iType;
		_icone setMarkerColorLocal _iColor;
		_icone setMarkerTextLocal _iText;
		_distMin = 1000000;
		{
			_deadTime = time - (_x getVariable ["hrm",time]);
			_oldBodyFactor = (_deadTime min 600)/1200;
			_dist = _x distance2D _cnt;
			_distMin = _distMin min (_dist + _oldBodyFactor * BRPVP_distanceToRespawnWaitZero);
		} forEach BRPVP_meuAllDead;
		if (_distMin == 1000000) then {_distMin = 0;};
		BRPVP_temposLocais pushBack _distMin;
	} forEach BRPVP_respawnPlaces;
	diag_log ("[BRPVP time away] = " + str _tempofora + ".");
	{
		BRPVP_temposLocais set [_forEachIndex,time + (1 - (_x min BRPVP_distanceToRespawnWaitZero)/BRPVP_distanceToRespawnWaitZero) * ((BRPVP_afterDieMaxSpawnCounterInSeconds - _tempofora) max 0)];
	} forEach BRPVP_temposLocais;

	//ESCOLHE LOCAL DE SPAWN PARTE 3
	_ini = time - 2;
	"LOCAL_PLAYER" setMarkerAlphaLocal 0;
	player addWeapon "ItemMap";
	cutText ["","PLAIN"];
	openMap true;
	waitUntil {
		if (!visibleMap) then {
			cutText [localize "str_spawn_closed_map_msg","BLACK FADED"];
		} else {
			cutText ["","PLAIN"];
		};
		if (time - _ini >= 1) then {
			_ini = time;
			{
				_icone = "CNTG_NSC_" + str _forEachIndex;
				_cntg = (round (_x - _ini)) max 0;
				if (_cntg > 0) then {
					_iText = str _cntg;
					_icone setMarkerTextLocal _iText;
				} else {
					_icone setMarkerPosLocal BRPVP_posicaoFora;
				};
			} forEach BRPVP_temposLocais;
		};
		if (getOxygenRemaining player < 0.4) then {player setOxygenRemaining 1;};
		!isNil "BRPVP_posicaoDeNascimento"
	};
	{deleteMarkerLocal ("CNTG_NSC_" + str _forEachIndex);} forEach BRPVP_temposLocais;
	deleteVehicle _tipSom;
	
	//CRIA VAR COM POSICAO DE NASCIMENTO ESCOLHIDA
	_posType = BRPVP_posicaoDeNascimento select 0;
	
	if (_posType == "air") then {
		_posNasc = BRPVP_posicaoDeNascimento select 1;
		_posNasc = [(_posNasc select 0) - 100 + random 200,(_posNasc select 1) - 100 + random 200,1100];
		
		//INICIA SALTO DE PARAQUEDAS
		BRPVP_onMapSingleClick = BRPVP_padMapaClique;
		player addBackpack "B_Parachute";
		player setPos _posNasc;
		_pd = player getVariable ["pd",BRPVP_centroMapa];
		player setDir ([player,_pd] call BIS_fnc_dirTo);
		"LOCAL_PLAYER" setMarkerAlphaLocal 1;
		openMap false;
		
		//INICIA VIDA
		playSound "tema";
		if (isNil "BRPVP_jaNasceuUma") then {
			BRPVP_jaNasceuUma = true;
		};
		
		//LIGA MODO ADMIN CASO SEJA UM ADMIN
		if (BRPVP_trataseDeAdmin) then {BRPVP_onMapSingleClick = BRPVP_adminMapaClique;} else {BRPVP_onMapSingleClick = BRPVP_padMapaClique;};
		
		//MONITORA QUEDA E SPAWNA QUADRICICLO
		[] spawn {
			[localize "str_spawn_tips",10] call BRPVP_hint;
			
			//INICIA SKY DIVER
			BRPVP_paraParam = [[+0.025,-0.006],[+0.005,+0.020],false,false];
			BRPVP_nascendoParaQuedas = true;

			//ESPERA CHEGAR NO CHAO OU MORRER NA QUEDA
			waitUntil {((getPos player select 2) min (getPosATL player select 2)) < 1 || vehicle player != player || !alive player};
			BRPVP_nascendoParaQuedas = nil;
			waitUntil {((getPos player select 2) min (getPosATL player select 2)) < 1 || !alive player};
			moveOut player;
			cutText ["","PLAIN"];

			if (alive player) then {
				//ADD INITIAL LOOT
				_aP = ["hgun_PDW2000_F","SMG_02_F"] call BIS_fnc_selectRandom;
				_mP = getArray (configfile >> "cfgWeapons" >> _aP >> "magazines") call BIS_fnc_selectRandom;
				player addWeapon _aP;
				player addMagazine _mP;
				player addMagazine _mP;
				player addMagazine _mP;
				player addMagazine _mP;
				player addWeapon "NVGoggles";
				player addWeapon "Binocular";
				
				//SPAWNA QUADRICICLO
				_pos = getPosATL player;
				_pos set [0,(_pos select 0) + 2 + (random 5)];
				_pos set [1,(_pos select 1) + 2 + (random 5)];
				_pos set [2,0];
				_bicicleta = createVehicle [BRPVP_veiculoTemporarioNascimento,_pos,[],0,"NONE"];
								
				//TIRA ITENS DO QUADRICICLO
				clearWeaponCargoGlobal _bicicleta;
				clearMagazineCargoGlobal _bicicleta;
				clearITemCargoGlobal _bicicleta;
				clearBackpackCargoGlobal _bicicleta;
				
				//MAIS QUADRICICLO
				player reveal _bicicleta;
				player setVariable ["qdcl",_bicicleta];
				_bicicleta setVariable ["tmp",serverTime,true];
				[format [localize "str_quad_time",BRPVP_tempoDeVeiculoTemporarioNascimento],5] call BRPVP_hint;

				//MENSAGEM DO 'INSERT'
				[localize "str_player_menu",5] call BRPVP_hint;
			};
		};
	};
	if (_posType == "ground") then {
		_posNasc = BRPVP_posicaoDeNascimento select 1;
		BRPVP_onMapSingleClick = BRPVP_padMapaClique;
		player setPos ([_posNasc,2.5,random 360] call BIS_fnc_relpos);
		_pd = player getVariable ["pd",BRPVP_centroMapa];
		player setDir ([player,_pd] call BIS_fnc_dirTo);
		"LOCAL_PLAYER" setMarkerAlphaLocal 1;
		openMap false;
		
		//INICIA VIDA
		playSound "tema";
		if (isNil "BRPVP_jaNasceuUma") then {
			BRPVP_jaNasceuUma = true;
		};
		
		//LIGA MODO ADMIN CASO SEJA UM ADMIN
		if (BRPVP_trataseDeAdmin) then {BRPVP_onMapSingleClick = BRPVP_adminMapaClique;} else {BRPVP_onMapSingleClick = BRPVP_padMapaClique;};
		
		//ADD INITIAL LOOT
		_aP = ["hgun_PDW2000_F","SMG_02_F"] call BIS_fnc_selectRandom;
		_mP = getArray (configfile >> "cfgWeapons" >> _aP >> "magazines") call BIS_fnc_selectRandom;
		player addWeapon _aP;
		player addMagazine _mP;
		player addMagazine _mP;
		player addMagazine _mP;
		player addMagazine _mP;
		player addWeapon "NVGoggles";
		player addWeapon "Binocular";
		
		//MENSAGEM DO 'INSERT'
		[localize "str_player_menu",5] call BRPVP_hint;
	};
};

//SET PLAYER AS OWNER OF HINSELF
player setVariable ["own",player getVariable "id_bd",true];

//LIGA DEBUG
call BRPVP_atualizaDebug;

//MOSTRA ICONES
call BRPVP_findMyFlags;
[] call BRPVP_atualizaIcones;

//ATUALIZA DISTANCIA DE VISAO
if (viewDistance != BRPVP_viewDist) then {setViewDistance BRPVP_viewDist;};
if (getObjectViewDistance select 0 != BRPVP_viewObjsDist) then {setObjectViewDistance BRPVP_viewObjsDist;};

//SPAWN OK
player setVariable ["sok",true,true];

//UPDATE AMIGOS
call BRPVP_daUpdateNosAmigos;
BRPVP_PUSV = true;
publicVariable "BRPVP_PUSV";

//UNBLOCK KEYBOARD
BRPVP_keyBlocked = false;

BRPVP_disabledDamage = 0;
BRPVP_disabledBleed = 0;

player enableStamina false;

//TIMER TO UPDATE CONNECTION ID
if (isNil "BRPVP_updateConnectionID") then {
	BRPVP_updateConnectionID = 1;
	0 spawn {
		sleep BRPVP_timeOnlineToCountConnection;
		BRPVP_countPlayerConnection = player getVariable ["id_bd",-1];
		if (isServer) then {["",BRPVP_countPlayerConnection] call BRPVP_countPlayerConnectionFnc;} then {publicVariableServer "BRPVP_countPlayerConnection";};
	};
};

//PLAYER TRAITS
player setUnitTrait ["engineer",true];
player setUnitTrait ["explosiveSpecialist",true];
player setUnitTrait ["medic",true];

//TURN OFF PLAYER GOD MODE
player allowDamage true;

//PLAYER RATING
player addRating 1000000;

//REDUCE SWAY
player setCustomAimCoef 0.25;

//FEDIDEX MENU
BRPVP_actionFedidex = player addAction ["<t color='#AAAAFF'>Fedidex Express</t>",{49 call BRPVP_iniciaMenuExtra;},"",1.5,false];

player setVariable ["brpvp_zombies_on_me",0,true];

BRPVP_statusBarOnOverall = true;
call BRPVP_atualizaDebug;

diag_log "[BRPVP FILE] nascimento_player.sqf END REACHED";