diag_log "[BRPVP FILE] funcoes.sqf INITIATED";

BRPVP_identifyShopType = {
	_alowed = _this;
	_shopType = localize "str_shop_some";
	if ( ("CIVIL" in _alowed) &&  ("CIV-MIL" in _alowed) && !("MILITAR" in _alowed) && !("FEDIDEX" in _alowed) && !("AIRPORT" in _alowed)) then {_shopType = localize "str_shop_msm";};
	if (!("CIVIL" in _alowed) &&  ("CIV-MIL" in _alowed) &&  ("MILITAR" in _alowed) && !("FEDIDEX" in _alowed) && !("AIRPORT" in _alowed)) then {_shopType = localize "str_shop_sm"; };
	if ( ("CIVIL" in _alowed) && !("CIV-MIL" in _alowed) && !("MILITAR" in _alowed) && !("FEDIDEX" in _alowed) && !("AIRPORT" in _alowed)) then {_shopType = localize "str_shop_sc"; };
	if (!("CIVIL" in _alowed) &&  ("CIV-MIL" in _alowed) && !("MILITAR" in _alowed) && !("FEDIDEX" in _alowed) && !("AIRPORT" in _alowed)) then {_shopType = localize "str_shop_sc"; };
	if (!("CIVIL" in _alowed) &&  ("CIV-MIL" in _alowed) && !("MILITAR" in _alowed) && !("FEDIDEX" in _alowed) && !("AIRPORT" in _alowed)) then {_shopType = localize "str_shop_mnm";};
	if (!("CIVIL" in _alowed) && !("CIV-MIL" in _alowed) &&  ("MILITAR" in _alowed) && !("FEDIDEX" in _alowed) && !("AIRPORT" in _alowed)) then {_shopType = localize "str_shop_sma";};
	if ( ("CIVIL" in _alowed) &&  ("CIV-MIL" in _alowed) &&  ("MILITAR" in _alowed) && !("FEDIDEX" in _alowed) && !("AIRPORT" in _alowed)) then {_shopType = localize "str_shop_scp";};
	if ( ("CIVIL" in _alowed) && !("CIV-MIL" in _alowed) &&  ("MILITAR" in _alowed) && !("FEDIDEX" in _alowed) && !("AIRPORT" in _alowed)) then {_shopType = localize "str_shop_se"; };
	if (!("CIVIL" in _alowed) && !("CIV-MIL" in _alowed) && !("MILITAR" in _alowed) &&  ("FEDIDEX" in _alowed) && !("AIRPORT" in _alowed)) then {_shopType = localize "str_shop_fe"; };
	if (!("CIVIL" in _alowed) && !("CIV-MIL" in _alowed) && !("MILITAR" in _alowed) && !("FEDIDEX" in _alowed) &&  ("AIRPORT" in _alowed)) then {_shopType = localize "str_shop_air";};
	_shopType
};
BRPVP_statusBarFps = {
	_fps = "";
	_fpsRound = if (_this <= 5) then {round _this} else {(round (_this/5)) * 5};
	if (_fpsRound >= 60) then {
		_fps = "<img size='0.8' image='BRP_imagens\interface\status_bar\fps_veryhigh.paa'/><t> "+str _fpsRound+"</t>";
	} else {
		if (_fpsRound >= 45) then {
			_fps = "<img size='0.8' image='BRP_imagens\interface\status_bar\fps_high.paa'/><t> "+str _fpsRound+"</t>";
		} else {
			if (_fpsRound >= 30) then {
				_fps = "<img size='0.8' image='BRP_imagens\interface\status_bar\fps_normal.paa'/><t> "+str _fpsRound+"</t>";
			} else {
				if (_fpsRound >= 15) then {
					_fps = "<img size='0.8' image='BRP_imagens\interface\status_bar\fps_low.paa'/><t> "+str _fpsRound+"</t>";
				} else {
					if (_fpsRound >= 5) then {
						_fps = "<img size='0.8' image='BRP_imagens\interface\status_bar\fps_lowest.paa'/><t> "+str _fpsRound+"</t>";
					} else {
						_fps = "<img size='0.8' image='BRP_imagens\interface\status_bar\fps_crap.paa'/><t> "+str _fpsRound+"</t>";
					};
				};
			};
		};
	};
	_fps
};
BRPVP_statusBarHealth = {
	_health = "";
	if (_this < 0.05) then {
		_health = "<img size='0.8' image='BRP_imagens\interface\status_bar\heart_todie.paa'/> <img size='0.8' image='BRP_imagens\interface\status_bar\heart_empty.paa'/> <img size='0.8' image='BRP_imagens\interface\status_bar\heart_empty.paa'/> <img size='0.8' image='BRP_imagens\interface\status_bar\heart_empty.paa'/> <img size='0.8' image='BRP_imagens\interface\status_bar\heart_empty.paa'/>";
	} else {
		{
			if (_this >= _x select 0) then {
				_health = "<img size='0.8' image='BRP_imagens\interface\status_bar\heart_full.paa'/>" + (_x select 2) + _health;
			} else {
				if (_this >= _x select 1) then {
					_health = "<img size='0.8' image='BRP_imagens\interface\status_bar\heart_half.paa'/>" + (_x select 2) + _health;
				} else {
					_health = "<img size='0.8' image='BRP_imagens\interface\status_bar\heart_empty.paa'/>" + (_x select 2) + _health;
				};
			};
		} forEach [[1,0.9,""],[0.8,0.7," "],[0.6,0.5," "],[0.4,0.3," "],[0.2,0.1," "]];
	};
	_health
};
BRPVP_spawnZombieCalcHouses = {
	_nearBuildings = nearestObjects [player,BRPVP_loot_buildings_class,100];
	_nearBuildingsAway = [];
	{
		if (_x distanceSqr player > 2500) then {_nearBuildingsAway pushBack _x;};
	} forEach _nearBuildings;
	_nearPlayers = player nearEntities [BRPVP_playerModel,120];
	_excludedBuildings = [];
	{
		_bui = _x getVariable ["bui",objNull];
		if (!isNull _bui) then {_excludedBuildings pushBack _bui;};
	} forEach _nearPlayers;
	_nearBuildingsAway - _excludedBuildings
};
BRPVP_playerCanBuild = {
	!BRPVP_construindo && !BRPVP_menuExtraLigado && !(player getVariable ["cmb",false])
};
BRPVP_radarAdd = {
	BRPVP_radarConfigPool pushBack _this;
	BRPVP_radarConfigPool sort false;
};
BRPVP_radarRemove = {
	_index = -1;
	{
		if (_this isEqualTo _x) exitWith {_index = _forEachIndex;};
	} forEach BRPVP_radarConfigPool;
	if (_index != -1) then {
		BRPVP_radarConfigPool deleteAt _index;
	};
};
BRPVP_showTerrains = {
	if (!BRPVP_terrenosMapaLigado) then {
		if (!BRPVP_terrenosMapaLigadoAdmin) then {
			BRPVP_terrenosMapaLigado = true;
			[localize "str_terr_draw",0] call BRPVP_hint;
			cutText [localize "str_terr_click_for_info","PLAIN"];
			_addTIcons = {
				_pp = getPosATL player;
				_pp set [2,0];
				_limit = BRPVP_terrainShowDistanceLimit^2;
				BRPVP_maxTerrainShowIdc = 0;
				_myTerrains = player getVariable "owt";
				{
					_pos = _x select 0;
					if (_pos distanceSqr _pp < _limit) then {
						BRPVP_maxTerrainShowIdc = BRPVP_maxTerrainShowIdc + 1;
						_tam = _x select 1;
						_prc = _x select 4;
						_cor = "ColorRed";
						if (_prc >= 3 && _prc <= 4) then {_cor = "ColorYellow";};
						if (_prc >= 6 && _prc <= 9) then {_cor = "ColorGreen";};
						if (_forEachIndex in _myTerrains) then {_cor = "ColorBrown";};
						_marca = createMarkerLocal ["TERR_" + str BRPVP_maxTerrainShowIdc,_pos];
						_marca setMarkerShapeLocal "RECTANGLE";
						_marca setMarkerBrushLocal "SOLID";
						_marca setMarkerColorLocal _cor;
						_marca setMarkerSizeLocal [(_tam/2)*0.925,(_tam/2)*0.925];
					};
				} forEach BRPVP_terrenos;
				BRPVP_onMapSingleClickExtra = BRPVP_infoTerreno;
			};
			["ADD TERRAIN ICONS",_addTIcons,false] call BRPVP_execFast;
			[] spawn {
				waitUntil {!BRPVP_terrenosMapaLigado};
				[localize "str_terr_removed",0] call BRPVP_hint;
				_removeTIcons = {for "_i" from 1 to BRPVP_maxTerrainShowIdc do {deleteMarkerLocal ("TERR_" + str _i);};};
				["REMOVE TERRAIN ICONS",_removeTIcons,false] call BRPVP_execFast;
				BRPVP_onMapSingleClickExtra = BRPVP_infoTrader;
				if (BRPVP_trataseDeAdmin) then {BRPVP_onMapSingleClick = BRPVP_adminMapaClique;} else {BRPVP_onMapSingleClick = BRPVP_padMapaClique;};
			};
		} else {
			[localize "str_terr_must_off_admin",6,20] call BRPVP_hint;
		};
	} else {
		BRPVP_terrenosMapaLigado = false;
		cutText ["","PLAIN"];
	};
};
LOL_fnc_showNotification = {
	params ["_endType","_mess"];
	if (_endType == "BRPVP_morreu_1") then {
		_mess params ["_name","_ofensor","_wep","_dist","_most","_mperc"];
		[format [localize "str_killmsg_main",_name,_ofensor,_wep,_dist,_most,_mperc],6.5,20,1414,"radarbip"] call BRPVP_hint;
	};
	if (_endType == "BRPVP_morreu_2") then {
		_mess params ["_name","_last","_time"];
		[format [localize "str_killmsg_hurt",_name,_last,_time],5,20,1414,"radarbip"] call BRPVP_hint;
	};
	if (_endType == "BRPVP_morreu_3") then {
		_mess params ["_name"];
		[format [localize "str_killmsg_puf",_name],3.5,15,1414,"radarbip"] call BRPVP_hint;
	};
};
BRPVP_actionSellClose = {
	_sr = BRPVP_sellReceptacle;
	_srIdx = _sr getVariable "bidx";
	
	_armas = [[],[]];
	_magas = magazinesAmmoCargo _sr;
	_mochi = getBackpackCargo _sr;
	_itens = getItemCargo _sr;
	_conts = everyContainer _sr;
	
	_check = [];
	_checkRemove = [];
	_conts = _conts apply {
		if (_x select 1 in _check) then {
			_checkRemove pushBack (_x select 0);
			-1
		} else {
			_check pushBack (_x select 1);
			_x
		};
	};
	_conts = _conts - [-1];
	{
		_idx = (_mochi select 0) find _x;
		if (_idx != -1) then {
			_quantity = _mochi select 1 select _idx;
			if (_quantity == 1) then {
				(_mochi select 0) deleteAt _idx;
				(_mochi select 1) deleteAt _idx;
			} else {
				(_mochi select 1) set [_idx,_quantity - 1];
			};
		};
	} forEach _checkRemove;

	_weaponsItemsCargo = weaponsItemsCargo _sr;

	clearWeaponCargoGlobal _sr;
	clearMagazineCargoGlobal _sr;
	clearBackpackCargoGlobal _sr;
	clearItemCargoGlobal _sr;

	{_weaponsItemsCargo append (weaponsItemsCargo (_x select 1));} forEach _conts;
	{
		_arma = _x;
		{
			if (_forEachIndex == 0) then {
				_armas = [_armas,_x call BIS_fnc_baseWeapon] call BRPVP_adicCargo;
			} else {
				if (typeName _x == "ARRAY") then {if (count _x > 0) then {_magas append [_x];};};
				if (typeName _x == "STRING") then {if (_x != "" && _forEachIndex != 5) then {_itens = [_itens,_x] call BRPVP_adicCargo;};};
			};
		} forEach _arma;
	} forEach _weaponsItemsCargo;
	{
		_cont = _x select 1;
		_magas append magazinesAmmoCargo _cont;
		_itensC = getItemCargo _cont;
		{
			_qt = _itensC select 1 select _forEachIndex;
			for "_i" from 1 to _qt do {_itens = [_itens,_x] call BRPVP_adicCargo;};
		} forEach (_itensC select 0);
	} forEach _conts;

	_estadoVault = [
		getPlayerUID player,
		[_armas,_magas,_mochi,_itens],
		//_sr getVariable ["stp",1]
		1
	];

	_estadoPlayer = if (_this) then {player call BRPVP_pegaEstadoPlayer} else {[]};
	BRPVP_salvaPlayerVault = [_estadoPlayer,[_estadoVault,_srIdx]];
	if (isServer) then {["",BRPVP_salvaPlayerVault] call BRPVP_salvaPlayerVaultFnc;} else {publicVariableServer "BRPVP_salvaPlayerVault";};

	{
		detach _x;
		deleteVehicle _x;
	} forEach (attachedObjects _sr);
	deleteVehicle _sr;

	BRPVP_sellStage = 5;
};
BRPVP_buyersPlace = {
	private ["_actBuyers"];
	_no = nearestObjects [player,["C_man_sport_1_F_afro"],200];
	_hs = [];
	{if (_x getVariable ["bidx",-1] != -1) then {_hs pushBack _x;};} forEach _no;
	_h = _hs select 0;
	_actBuyers1 = -1;
	_actBuyers2 = -1;
	_srIdx = _h getVariable ["bidx",-1];
	BRPVP_sellInCourtyard = false;
	BRPVP_sellStage = 0;
	waitUntil {
		waitUntil {
			BRPVP_sellInCourtyard = [player,_h] call PDTH_pointIsInBox;
			!(BRPVP_inBuyersPlace == _this) || BRPVP_sellInCourtyard
		};
		if (BRPVP_sellInCourtyard) then {
			BRPVP_sellStage = 1;
			_v = vehicle player;
			if (_v != player && {driver _v == player && {fuel _v < 0.9 && {_v call BRPVP_checaAcesso}}}) then {
				_v setFuel 1;
				[localize "str_fuel_100",0] call BRPVP_hint;
			};
			_actBuyers1 = player addAction [("<t color='#00BB00'>"+localize "str_coll_open_receptacle"+"</t>"),"client_code\actions\actionSell.sqf",_srIdx,100,true];
			waitUntil {
				BRPVP_sellInCourtyard = [player,_h] call PDTH_pointIsInBox;
				!BRPVP_sellInCourtyard || BRPVP_sellStage == 2
			};
			player removeAction _actBuyers1;
			if (BRPVP_sellStage == 2) then {
				_actBuyers2 = player addAction [("<t color='#FF0000'>"+localize "str_coll_apply_sell"+"</t>"),"client_code\actions\actionSellApply.sqf",[],100,true];
				waitUntil {!(BRPVP_inBuyersPlace == _this) || BRPVP_sellStage in [3,4,5]};
				player removeAction _actBuyers2;
				if (BRPVP_sellStage in [3,4,5]) then {
					if (BRPVP_sellStage == 3) then {
						waitUntil {BRPVP_sellStage == 4};
						BRPVP_sellStage = 0;
					} else {
						BRPVP_sellStage = 0;
					};
				} else {
					true call BRPVP_actionSellClose;
					waitUntil {BRPVP_sellStage == 5};
					BRPVP_sellStage = 0;
				};
			} else {
				BRPVP_sellStage = 0;
			};
		};
		!(BRPVP_inBuyersPlace == _this)
	};
};
BRPVP_hideObject = {
	BRPVP_hideObjectSv = _this;
	if (isServer) then {["",BRPVP_hideObjectSv] call BRPVP_hideObjectSvFnc;} else {publicVariableServer "BRPVP_hideObjectSv";};
};
BRPVP_processSiegeIcons = {
	_BRPVP_onSiegeIcons = [];
	{
		if (_x == 2) then {
			_BRPVP_onSiegeIcons pushBack (BRPVP_locaisImportantes select _forEachIndex select 0);
		};
	} forEach _this;
	BRPVP_onSiegeIcons = _BRPVP_onSiegeIcons;
};
BRPVP_playSoundAllCli = {
	params ["_obj","_snd","_dist"];
	BRPVP_tocaSom = _this;
	publicVariable "BRPVP_tocaSom";
	_obj say3D [_snd,_dist];
};
BRPVP_mudaExp = {
	//CHECA SE EXISTE A VARIAVEL DE OBJETO exp NO PLAYER
	_atual = player getVariable "exp";
	
	//ATUALIZA ESTATISTICAS DO PLAYER
	_mudanca = + BRPVP_experienciaZerada;
	_mudou = false;
	{
		_tipo = _x select 0;
		_valor = _x select 1;
		_idc = BRPVP_expLegendaSimples find _tipo;
		if (_idc >= 0) then {
			_mudanca set [_idc,(_mudanca select _idc) + _valor];
			_mudou = true;
		};
	} forEach _this;
	if (_mudou) then {
		{_atual set [_forEachIndex,(_atual select _forEachIndex) + _x];} forEach _mudanca;
		player setVariable ["exp",_atual,true];
	};
};
BRPVP_hintHistoricShow = [];
BRPVP_hint = {
	params ["_msg",["_time",0],["_limitPlus",200],["_mshare",0],["_snd","hint"]];
	if (_snd == "hint") then {_snd = "hint2";};
	if (_time <= 0) then {
		_time = if (_time == 0) then {5} else {abs _time};
		5 cutText ["\n\n\n\n" + _msg,"PLAIN",_time/10,true];
		if (_snd != "") then {playSound _snd;};
	} else {
		_limit = time + _limitPlus;
		_time = _time/10;
		BRPVP_hintHistorico pushBack [["\n" + _msg,"PLAIN DOWN",_time,true],_snd,_limit,_mshare];
	};
};
BRPVP_hintLog = {
	_this call BRPVP_hint;
	_msg = _this select 0;
	while {_msg find "\n" != -1} do {
		_idx = _msg find "\n";
		if (_idx != 0) then {
			if (_idx != (count _msg) - 2) then {
				_part1 = _msg select [0,_idx];
				_part2 = _msg select [_idx + 2,(count _msg) - (_idx + 2)];
				_msg = _part1 + "<br/>" + _part2;
			} else {
				_msg = _msg select [0,(count _msg) - 2];
			};
		} else {
			_msg = _msg select [2,(count _msg) - 2];
		};
	};
	if (_msg != "") then {
		BRPVP_hintHistoricShow pushBack _msg;
		if (count BRPVP_hintHistoricShow > 200) then {
			BRPVP_hintHistoricShow deleteRange [0,(count BRPVP_hintHistoricShow) - 200];
			BRPVP_hintHistoricShow pushBack (localize "str_there_was_more");
		};
	};
};
BRPVP_log = {
	_msg = _this select 0;
	while {_msg find "\n" != -1} do {
		_idx = _msg find "\n";
		if (_idx != 0) then {
			if (_idx != (count _msg) - 2) then {
				_part1 = _msg select [0,_idx];
				_part2 = _msg select [_idx + 2,(count _msg) - (_idx + 2)];
				_msg = _part1 + "<br/>" + _part2;
			} else {
				_msg = _msg select [0,(count _msg) - 2];
			};
		} else {
			_msg = _msg select [2,(count _msg) - 2];
		};
	};
	while {_msg find "&" != -1} do {
		_idx = _msg find "&";
		if (_idx != 0) then {
			if (_idx != (count _msg) - 1) then {
				_part1 = _msg select [0,_idx];
				_part2 = _msg select [_idx + 1,(count _msg) - (_idx + 1)];
				_msg = _part1 + "&#38;" + _part2;
			} else {
				_msg = _msg select [0,(count _msg) - 1];
			};
		} else {
			_msg = _msg select [1,(count _msg) - 1];
		};
	};
	if (_msg != "") then {
		BRPVP_hintHistoricShow pushBack _msg;
		if (count BRPVP_hintHistoricShow > 200) then {
			BRPVP_hintHistoricShow deleteRange [0,(count BRPVP_hintHistoricShow) - 200];
			//BRPVP_hintHistoricShow pushBack (localize "str_there_was_more");
		};
	};
};
[] spawn {
	_timeLock = 0;
	_lmshare = 0;
	waitUntil {
		if (count BRPVP_hintHistorico > 0) then {
			_timeNow = time;
			_case = BRPVP_hintHistorico select 0;
			_mshare = _case select 3;
			if (_timeNow >= _timeLock || (_mshare == _lmshare && _mshare != 0)) then {
				_msg = _case select 0;
				_snd = _case select 1;
				_limit = _case select 2;
				_lmshare = _mshare;
				if (_timeNow <= _limit) then {
					_timeLock = _timeNow + (_msg select 2) * 10;
					10 cutText _msg;
					if (_snd != "") then {playSound _snd;};
				};
				BRPVP_hintHistorico deleteAt 0;
			};
		};
		false
	};
};
BRPVP_adicionaIconeLocalArea = {
	params ["_ambito","_iName","_iObj","_iColor","_raio","_alpha"];

	//CRIA ICONE
	_area = createMarkerLocal [_iName,BRPVP_posicaoFora];
	_area setMarkerShapeLocal "ELLIPSE";
	_area setMarkerSizeLocal [_raio,_raio];
	_area setMarkerColorLocal _iColor;
	_area setMarkerAlphaLocal _alpha;

	//INSERE ICONE NOS ARRAYS DE ICONES
	if (_ambito == "geral") then {
		BRPVP_iconesLocais pushBack [_iName,_iObj];
	};
	if (_ambito == "amigos") then {
		BRPVP_iconesLocaisAmigos pushBack [_iName,_iObj];
	};
	if (_ambito == "bots") then {
		BRPVP_iconesLocaisBots pushBack [_iName,_iObj];
	};
	if (_ambito == "veiculi") then {
		BRPVP_iconesLocaisVeiculi pushBack [_iName,_iObj];
	};
	if (_ambito == "mastuff") then {
		BRPVP_iconesLocaisStuff pushBack [_iName,_iObj];
	};
	if (_ambito == "sempre") then {
		BRPVP_iconesLocaisSempre pushBack [_iName,_iObj];
	};
};
BRPVP_adicionaIconeLocal = {
	params ["_ambito","_iName","_iObj","_iColor","_iText","_iType","_iRaioIdc"];
	
	//CRIA ICONE
	_icone = createMarkerLocal [_iName,BRPVP_posicaoFora];
	_icone setMarkerShapeLocal "Icon";
	_icone setMarkerTypeLocal _iType;
	_icone setMarkerColorLocal _iColor;
	_icone setMarkerTextLocal _iText;
	
	//INSERE ICONE NOS ARRAYS DE ICONES
	if (_ambito == "geral") then {
		BRPVP_iconesLocais pushBack [_iName,_iObj];
	};
	if (_ambito == "amigos") then {
		BRPVP_iconesLocaisAmigos pushBack [_iName,_iObj];
	};
	if (_ambito == "bots") then {
		BRPVP_iconesLocaisBots pushBack [_iName,_iObj];
	};
	if (_ambito == "veiculi") then {
		BRPVP_iconesLocaisVeiculi pushBack [_iName,_iObj];
	};
	if (_ambito == "mastuff") then {
		BRPVP_iconesLocaisStuff pushBack [_iName,_iObj];
	};
	if (_ambito == "sempre") then {
		BRPVP_iconesLocaisSempre pushBack [_iName,_iObj];
	};
};
BRPVP_removeTodosIconesLocais = {
	//REMOVE ICONES DE TODOS OS TIPOS
	if (_this == "geral") then {
		{deleteMarkerLocal (_x select 0);} forEach BRPVP_iconesLocais;
		BRPVP_iconesLocais = [];
	};
	if (_this == "amigos") then {
		{deleteMarkerLocal (_x select 0);} forEach BRPVP_iconesLocaisAmigos;
		BRPVP_iconesLocaisAmigos = [];
	};
	if (_this == "bots") then {
		{deleteMarkerLocal (_x select 0);} forEach BRPVP_iconesLocaisBots;
		BRPVP_iconesLocaisBots = [];
	};
	if (_this == "veiculi") then {
		{deleteMarkerLocal (_x select 0);} forEach BRPVP_iconesLocaisVeiculi;
		BRPVP_iconesLocaisVeiculi = [];
	};
	if (_this == "mastuff") then {
		{deleteMarkerLocal (_x select 0);} forEach BRPVP_iconesLocaisStuff;
		BRPVP_iconesLocaisStuff = [];
	};
	if (_this == "sempre") then {
		{deleteMarkerLocal (_x select 0);} forEach BRPVP_iconesLocaisSempre;
		BRPVP_iconesLocaisSempre = [];
	};
};	
BRPVP_escolheModaPlayer = {
	//NUDA PLAYER (TIRA TUDO DELE)
	{player removeMagazine _x;} forEach  magazines player;
	{player removeWeapon _x;} forEach weapons player;
	{player removeItem _x;} forEach items player;
	removeAllAssignedItems player;
	removeBackpackGlobal player;
	removeUniform player;
	removeVest player;
	removeHeadGear player;
	removeGoggles player;
	
	//VESTE PLAYER CASO PARAMETRO SEJA TRUE
	if (_this) then {
		//BANCO DE MODA
		_uniformes = ["U_O_CombatUniform_ocamo","U_O_CombatUniform_oucamo","U_O_SpecopsUniform_ocamo","U_O_SpecopsUniform_blk","U_O_OfficerUniform_ocamo"];
		_vestimentas = ["V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_khk","V_BandollierB_oli","V_BandollierB_rgr"];
		_caps = ["H_Bandanna_mcamo","H_Bandanna_surfer","H_Hat_blue","H_Hat_tan","H_StrawHat_dark","H_Bandanna_surfer_grn","H_Cap_surfer"];
		_oculosTipos = ["G_Squares","G_Diving"];
		
		//ESCOLHE MODA
		_moda = floor random (50 + 1);
		_uniforme = _uniformes select (_moda mod count _uniformes);
		_vestimenta = _vestimentas select (_moda mod count _vestimentas);
		_cap = _caps select (_moda mod count _caps);
		_oculos = _oculosTipos select (_moda mod count _oculosTipos);
		
		//APLICA MODA
		player forceAddUniform _uniforme;
		player addVest _vestimenta;
		if (_moda mod 5 != 0) then {player addHeadGear _cap;};
		if (_moda mod 5 == 0) then {player addGoggles _oculos;};
	};
};
BRPVP_pegaEstadoPlayer = {
	//ARMAS (P,S,G)
	_armaPriNome = primaryWeapon _this;
	_armaSecNome = secondaryWeapon _this;
	_armaGunNome = handGunWeapon _this;
	
	//ARMAS ASSIGNED
	_aPI = primaryWeaponItems _this;
	_aSI = secondaryWeaponItems _this;
	_aGI = handGunItems _this;
	
	//CONTAINERS
	_backPackName = backpack _this;
	_vestName = vest _this;
	_uniformName = uniform _this;
	
	//APETRECHOS
	_capacete = headGear _this;
	_oculos = goggles _this;
	
	//SAUDE
	_hpd = getAllHitPointsDamage _this;

	//PLAYERS CONTAINERS
	_bpc = backpackContainer _this;
	_vtc = vestContainer _this;
	_ufc = uniformContainer _this;
	
	//PLAYERS CONTAINERS MAGAZINES AMMO
	if (!isNull _bpc) then {_bpc = magazinesAmmoCargo _bpc;} else {_bpc = [];};
	if (!isNull _vtc) then {_vtc = magazinesAmmoCargo _vtc;} else {_vtc = [];};
	if (!isNull _ufc) then {_ufc = magazinesAmmoCargo _ufc;} else {_ufc = [];};
	
	//ESTADO PLAYER
	_BRPVP_salvaPlayer = [
		//ID DO PLAYER
		getPlayerUID _this,
		//ARMAS E ASSIGNED ITEMS
		[
			assignedItems _this,
			[_armaPriNome,_aPI,primaryWeaponMagazine _this],
			[_armaSecNome,_aSI,secondaryWeaponMagazine _this],
			[_armaGunNome,_aGI,handGunMagazine _this],
			_this getVariable ["owt",[]]
		],
		//CONTAINERS (BACKPACK, VEST, UNIFORME)
		[
			[_backpackName,[getWeaponCargo backpackContainer _this,getItemCargo backpackContainer _this,_bpc]],
			[_vestName,[getWeaponCargo vestContainer _this,getItemCargo vestContainer _this,_vtc]],
			[_uniformName,[getWeaponCargo uniformContainer _this,getItemCargo uniformContainer _this,_ufc]]
		],
		//DIRECAO E POSICAO
		[getDir _this,getPosWorld _this],
		//SAUDE
		[[_hpd select 1,_hpd select 2],[BRPVP_alimentacao,100],damage _this],
		//MODELO E APETRECHOS
		[typeOf _this,_capacete,_oculos],
		//ARMA NA MAO
		currentWeapon _this,
		//AMIGOS
		_this getVariable ["amg",[]],
		//VIVO OU MORTO
		if (alive _this) then {1} else {0},
		//EXPERIENCIA
		_this getVariable ["exp",BRPVP_experienciaZerada],
		//DEFAULT SHARE TYPE
		_this getVariable ["stp",1],
		//ID BD
		_this getVariable "id_bd",
		//MONEY
		_this getVariable ["mny",0],
		//SPECIAL ITEMS
		_this getVariable ["sit",[]],
		//MONEY ON BANK
		_this getVariable ["brpvp_mny_bank",0]
	];
	_BRPVP_salvaPlayer
};
BRPVP_ligaModoSeguro = {
	if (BRPVP_ligaModoSeguroQt == 0) then {
		if (_this) then {[localize "str_safezone_in",2.5,6.5,786] call BRPVP_hint;};
		BRPVP_ehNaoAtira = true;
		player allowDamage false;
		player setVariable ["god",(player getVariable "god") + 1,true];
		player setCaptive true;
		player setVariable ["umok",false,true];
		if (BRPVP_safeZone) then {
			_veiculo = vehicle player;
			if (_veiculo != player) then {if (local _veiculo) then {_veiculo allowDamage false;};};
		};
	};
	BRPVP_ligaModoSeguroQt = BRPVP_ligaModoSeguroQt + 1;
};
BRPVP_desligaModoSeguro = {
	private ["_humanos"];
	BRPVP_ligaModoSeguroQt = BRPVP_ligaModoSeguroQt - 1;
	if (BRPVP_ligaModoSeguroQt == 0) then {
		if (_this) then {[localize "str_safezone_out",2.5,6.5,786] call BRPVP_hint;};
		BRPVP_ehNaoAtira = false;
		player allowDamage true;
		player setVariable ["god",((player getVariable "god") - 1) max 0,true];
		player setCaptive false;
		player setVariable ["umok",true,true];
		if (BRPVP_safeZone) then {
			_veiculo = vehicle player;
			if (_veiculo != player) then {if (local _veiculo) then {_veiculo allowDamage true;};};
		};
		_humanos = player nearEntities ["CAManBase",150];
		{if (!isPlayer _x) then {_x reveal [player,1.5];};} forEach _humanos;
	};
};
BRPVP_funcaoMinDist = {
	private ["_raioB","_dist","_minDist","_maisPerto","_posA","_posB","_raioA"];
	_posA = _this select 0;
	_minDist = 1000000;
	{
		if !(_forEachIndex in BRPVP_dentroDe) then {
			_posB = _x select 0;
			_raioB = _x select 1;
			_dist = (_posA distance _posB) - _raioB;
			if (_dist < _minDist && _dist > 1 - _raioB) then {_minDist = _dist;_maisPerto = _forEachIndex;};
		};
	} forEach (_this select 1);
	_maisPerto
};
BRPVP_arred = {
	private ["_valor","_fator"];
	_valor = _this select 0;
	_fator = 10^(_this select 1);
	(floor(_valor*_fator))/_fator
};
BRPVP_playerCureLastTime = -BRPVP_playerCurePlacesCoolDown;
BRPVP_curaPlayer = {
	_noCoolDown = time - BRPVP_playerCureLastTime >= BRPVP_playerCurePlacesCoolDown;
	if (alive player && _noCoolDown && damage player >= 0.025) then {
		BRPVP_playerCureLastTime = time;
		player setDamage 0;
		BRPVP_alimentacao = 105;
		player setVariable ["sud",[round BRPVP_alimentacao,100],true];
		[localize "str_healed",2,6.5] call BRPVP_hint;
		playsound "heal";
	};
};
BRPVP_aceleraPara = {
	_tempo = time;
	_param = BRPVP_paraParam select 0;
	if (_this == "subir") then {_param = BRPVP_paraParam select 1;};
	waitUntil {
		_qps = diag_fps;
		_qpsFator = 15/_qps;
		_para = vehicle player;
		_vel = velocity _para;
		_velMag = vectorMagnitude _vel;
		_paraDir2D = vectorDir _para;
		_paraDir2D set [2,0];
		_paraDir2DNrm = vectorNormalized _paraDir2D;
		_vel2D = + _vel;
		_vel2D set [2,0];
		_vel2DMag = vectorMagnitude _vel2D;
		_ang = acos (_paraDir2D vectorCos [0,1,0]);
		if (_paraDir2D select 0 < 0) then {_ang = 360 - _ang;};
		_velAmigo = [_vel2DMag * sin _ang,_vel2DMag * cos _ang,_vel select 2];
		_aVecDir = _paraDir2DNrm vectorMultiply ((_param select 0) * _velMag * _qpsFator);
		_aVecZ = (vectorNormalized [0,0,_param select 1]) vectorMultiply abs((_param select 1) * _velMag * _qpsFator);
		_velNovo = (_velAmigo vectorAdd _aVecDir) vectorAdd _aVecZ;
		_para setVelocity _velNovo;
		time - _tempo > 0.25 || isNil "BRPVP_nascendoParaQuedas"
	};
	BRPVP_aceleraParaRodando = false;
};
BRPVP_infoTerreno = {
	params ["_alt","_pos","_shift"];
	if (!_shift && !_alt) then {
		{
			_cnt = _x select 0;
			_tam = _x select 1;
			if (abs((_pos select 0)-(_cnt select 0)) < _tam/2 && abs((_pos select 1)-(_cnt select 1)) < _tam/2) then {
				_ang = _x select 2;
				_livre = _x select 3;
				_qualidade = _x select 4;
				_prc = (_qualidade*(_tam/45)^2)*(20000/9); //IMPORTANTE
				_prcTxt = (str round (_prc/1000))+"K $";
				_txt = format [localize "str_terr_info0",_forEachIndex];
				_txt = _txt + "\n" + format [localize "str_terr_info1",_tam];
				_txt = _txt + "\n" + format [localize "str_terr_info2",round _ang];
				_txt = _txt + "\n" + format [localize "str_terr_info3",round _livre];
				_txt = _txt + "\n" + format [localize "str_terr_info4",_qualidade];
				//_txt = _txt + "\nPRICE: " + _prcTxt;
				cutText [_txt,"PLAIN"];
			};
		} forEach BRPVP_terrenos;
		true
	} else {
		false
	};
};
BRPVP_infoTrader = {
	params ["_alt","_pos","_shift"];
	private ["_idc","_retorno"];
	_retorno = false;
	if (!_shift && !_alt) then {
		{
			_centro = _x select 0;
			_raio = _x select 1;
			if (_pos distance2D _centro <= _raio) then {
				_mercador = BRPVP_mercadorObjs select _forEachIndex;
				_idc = _mercador getVariable ["mcdr",-1];
				if (_idc != -1) then {
					_loja = BRPVP_mercadoresEstoque select (_idc mod (count BRPVP_mercadoresEstoque)) select 0;
					_txt = "";
					{_txt = _txt + (BRPVP_mercadoNomes select _x) + "\n";} forEach _loja;
					cutText [_txt,"PLAIN",1];
					_retorno = true;
				};
			};
		} forEach BRPVP_mercadoresPos;
	};
	_retorno
};
BRPVP_padMapaClique = {
	params ["_alt","_pos","_shift"];
	if (_shift && !_alt) then {
		_pos2 = _pos apply {(round(_x * 10))/10};
		player setVariable ["pd",_pos2,true];
	};
	false
};
BRPVP_adminMapaClique = {
	params ["_alt","_pos","_shift"];
	if (_shift && !_alt) then {
		_pos2 = _pos apply {(round(_x * 10))/10};
		player setVariable ["pd",_pos2,true];
	};
	if (_alt && !_shift) exitWith {
		(vehicle player) setPos _pos;
		openMap false;
		true
	};
	false
};
BRPVP_nascMapaClique = {
	params ["_alt","_pos","_shift"];
	private ["_respawnPos"];
	if (_shift && !_alt) then {
		_pos2 = _pos apply {(round(_x * 10))/10};
		player setVariable ["pd",_pos2,true];
	};
	if (!_shift && !_alt) then {
		if ({_pos distance2D _x < 50} count BRPVP_respawnSpot > 0) then {
			_arr = BRPVP_respawnSpot apply {[_x distance2D _pos,_x]};
			_arr sort true;
			BRPVP_posicaoDeNascimento = ["ground",ASLToAGL getPosASL (_arr select 0 select 1)];
		} else {
			if (BRPVP_vePlayers) then {
				BRPVP_posicaoDeNascimento = ["ground",_pos];
			} else {
				_posOk = false;
				_liberado = false;
				{
					_bdi = _x select 0;
					_raio = _x select 1;
					_posOk = _pos distance2D _bdi < _raio;
					if (_posOk) exitWith {
						_respawnPos = _bdi;
						_liberado = time > (BRPVP_temposLocais select _forEachIndex);
					};
				} forEach BRPVP_respawnPlaces;
				cutText ["","PLAIN",1];
				if (!_posOk) then {
					playSound "erro";
					15 cutText [localize "str_spawn_not_orange","PLAIN",0.5,true];
				} else {
					if (_liberado) then {
						BRPVP_posicaoDeNascimento = ["air",_respawnPos];
					} else {
						playSound "erro";
						15 cutText [localize "str_spawn_wait_count","PLAIN",0.5,true];
					};
				};
			};
		};
	};
	false
};
BRPVP_ligaModoCombate = {
	BRPVP_ultimoCombateTempo = time;
	if !(player getVariable ["cmb",false]) then {
		player setVariable ["cmb",true,true];
		call BRPVP_atualizaDebug;
		_nil = [] spawn {
			waitUntil {
				time >= BRPVP_ultimoCombateTempo + BRPVP_combatTimeLength || !alive player
			};
			player setVariable ["cmb",false,true];
			call BRPVP_atualizaDebug;
		};
	};
};
BRPVP_atualizaIconesSpawn = {
	["geral"] call BRPVP_atualizaIcones;
	"veiculi" call BRPVP_removeTodosIconesLocais;
	"bots" call BRPVP_removeTodosIconesLocais;
};
BRPVP_atualizaIcones = {
	if ("veiculi" in _this || count _this == 0) then {
		//ICONES VEICULOS: CARROS PLAYER, HELIS PLAYER
		"veiculi" call BRPVP_removeTodosIconesLocais;
		{["veiculi","PCAR_" + str _forEachIndex,_x,"ColorGreen","L","mil_dot"] call BRPVP_adicionaIconeLocal;} forEach BRPVP_carrosObjetos;
		{["veiculi","PHEL_" + str _forEachIndex,_x,"ColorGreen","H","mil_dot"] call BRPVP_adicionaIconeLocal;} forEach BRPVP_helisObjetos;
	};
	if ("players" in _this || count _this == 0) then {
		//ICONES PLAYERS
		"players" call BRPVP_removeTodosIconesLocais;
		{["players","PLAYERS_" + str _forEachIndex,_x,"ColorRed","","mil_dot"] call BRPVP_adicionaIconeLocal;} forEach allPlayers;
	};
	if ("bots" in _this || count _this == 0) then {
		//ICONES BOTS: SOLDADOS, REVOLTOSOS, BLINDADOS, WALKERS, HELIS
		"bots" call BRPVP_removeTodosIconesLocais;
		{["bots","BOT_" + str _forEachIndex,_x,"ColorRed","","mil_dot"] call BRPVP_adicionaIconeLocal;} forEach BRPVP_bots;
		{["bots","REV_" + str _forEachIndex,_x,"ColorRed","","mil_dot"] call BRPVP_adicionaIconeLocal;} forEach BRPVP_revoltosos;
		{["bots","BUAI_" + str _forEachIndex,_x,"ColorRed","","mil_dot"] call BRPVP_adicionaIconeLocal;} forEach BRPVP_missBotsEm;
		{["bots","WKR_" + str _forEachIndex,_x,"ColorOrange","","mil_dot"] call BRPVP_adicionaIconeLocal;} forEach BRPVP_walkersObj;		
	};
	if ("mastuff" in _this || count _this == 0) then {
		private ["_idbd"];
		//ICONES DO STUFF DO PLAYER
		"mastuff" call BRPVP_removeTodosIconesLocais;
		{
			if (_x call BRPVP_isMotorized) then {
				["mastuff","STUFF_" + str _forEachIndex,_x,"ColorYellow",getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName"),"mil_box"] call BRPVP_adicionaIconeLocal;
			};
		} forEach BRPVP_myStuff;
		//ICONES DO STUFF DO PLAYER OTHERS
		_flags = if (BRPVP_trataseDeAdmin && BRPVP_vePlayers) then {BRPVP_allFlags} else {BRPVP_myStuffOthers};
		_idbd = player getVariable "id_bd";
		{
			_color = if (_idbd isEqualTo (_x getVariable "own")) then {"ColorGreen"} else {if (_idbd in ((_x getVariable "amg") select 1)) then {"ColorBlue"} else {"ColorRed"}};
			["mastuff","STUFF_OTHERS_" + str _forEachIndex,_x,_color,_x call BRPVP_getFlagRadius,0.35] call BRPVP_adicionaIconeLocalArea;
		} forEach _flags;
		{
			_color = if (_idbd isEqualTo (_x getVariable "own")) then {"ColorGreen"} else {if (_idbd in ((_x getVariable "amg") select 1)) then {"ColorBlue"} else {"ColorRed"}};
			["mastuff","STUFF_OTHERS_DOT_" + str _forEachIndex,_x,_color,localize "str_flag","mil_dot"] call BRPVP_adicionaIconeLocal;
		} forEach _flags;
	};
	if ("geral" in _this || count _this == 0) then {
		//ICONES GERAL: PLAYER, CORPO
		"geral" call BRPVP_removeTodosIconesLocais;
		{["geral","PMORTO_" + str _forEachIndex,_x,"ColorRed",localize "str_body","mil_dot"] call BRPVP_adicionaIconeLocal;} forEach BRPVP_meuAllDead;
		{["geral","LOCAL_PLAYER",_x,"ColorYellow","","mil_start"] call BRPVP_adicionaIconeLocal;} forEach [player];
		{["geral","RESPAWN_SPOT_" + str _forEachIndex,_x,"ColorOrange","","mil_end"] call BRPVP_adicionaIconeLocal;} forEach BRPVP_respawnSpot;
	};
	if ("sempre" in _this || count _this == 0) then {
		//ICONES SEMPRE: TRADERS, COLLECTORS
		"sempre" call BRPVP_removeTodosIconesLocais;
		{["sempre","MERCADORES_" + str _forEachIndex,_x,"ColorPink",BRPVP_mercadoresEstoque select ((_x getVariable ["mcdr",-1]) mod (count BRPVP_mercadoresEstoque)) select 1,"mil_triangle"] call BRPVP_adicionaIconeLocal;} forEach BRPVP_mercadorObjs;
		{["sempre","VENDAVE_" + str _forEachIndex,_x,"ColorWhite",(_x getVariable "vndv") call BRPVP_identifyShopType,"mil_triangle"] call BRPVP_adicionaIconeLocal;} forEach BRPVP_vendaveObjs;
		{["sempre","BUYERS_" + str _forEachIndex,_x,"ColorWhite",format [localize "str_coll_collectors",_forEachIndex + 1],"mil_triangle"] call BRPVP_adicionaIconeLocal;} forEach BRPVP_buyersObjs;
		{["sempre","ITEM_BOX_" + str _forEachIndex,_x,"ColorBrown","b","mil_dot"] call BRPVP_adicionaIconeLocal;} forEach BRPVP_allMissionsItemBox;
	};
	//BRPVP_fazRadarBip = true;
};
BRPVP_rastroWhile = {
	private ["_angSoma","_distSoma","_pos","_nPos","_vel","_nVel","_angDlt","_posFinal"];
	while {true} do {
		waitUntil {!isNull BRPVP_bala || !BRPVP_rastroBalasLigado};
		if (!BRPVP_rastroBalasLigado) exitWith {};
		_pos = position BRPVP_bala;
		_vel = velocity BRPVP_bala;
		_angSoma = 0;
		_distSoma = 0;
		while {!isNull BRPVP_bala} do {
			_nVel = velocity BRPVP_bala;
			_nPos = position BRPVP_bala;
			_angDlt = acos (_vel vectorCos _nVel);
			_angSoma = _angSoma + _angDlt;
			_distSoma = _distSoma + (_nPos distance _pos);
			if (_angDlt >= 2.5 || _angSoma >= 20 || _distSoma >= 100) then {
				_angSoma = 0;
				_distSoma = 0;
				if (str _nPos != "[0,0,0]") then {BRPVP_rastroPosicoes = BRPVP_rastroPosicoes + [_nPos];};
			};
			_pos = _nPos;
			_vel = _nVel;
			_posFinal = _nPos;
		};
		if (str _posFinal != "[0,0,0]") then {BRPVP_rastroPosicoes = BRPVP_rastroPosicoes + [_posFinal];};
	};
};

//ATUALIZA AMIGOS (MA TELA 3D E NO MAPA)
BRPVP_daUpdateNosAmigos = {
	[] spawn {
		sleep 1;
		_BRPVP_meusAmigosObj = [];
		_BRPVP_meusAmigosObjGroupChat = [];
		{
			if (_x getVariable ["sok",false]) then {
				if (_x call BRPVP_checaAcesso) then {
					_BRPVP_meusAmigosObj pushBack _x;
				};
			};
		} forEach (allPlayers - [player]);
		{
			if ([_x,player] call BRPVP_checaAcessoRemoto) then {
				_BRPVP_meusAmigosObjGroupChat pushBack _x;
			};
		} forEach _BRPVP_meusAmigosObj;
		if (count (BRPVP_meusAmigosObj - _BRPVP_meusAmigosObj) > 0 || count (_BRPVP_meusAmigosObj - BRPVP_meusAmigosObj) > 0) then {
			BRPVP_meusAmigosObj = +_BRPVP_meusAmigosObj;
			"amigos" call BRPVP_removeTodosIconesLocais;
			{["amigos","AMIGO_" + str _forEachIndex,_x,if ((_x getVariable ["stp",1]) isEqualTo 3) then {"ColorPink"} else {"ColorYellow"},_x getVariable "nm","mil_dot"] call BRPVP_adicionaIconeLocal;} forEach BRPVP_meusAmigosObj;
		};
		if (count (BRPVP_meusAmigosObjGroupChat - _BRPVP_meusAmigosObjGroupChat) > 0 || count (_BRPVP_meusAmigosObjGroupChat - BRPVP_meusAmigosObjGroupChat) > 0) then {
			BRPVP_meusAmigosObjGroupChat = +_BRPVP_meusAmigosObjGroupChat;
		};
	};
};

//FUNCAO PARA PROCESSAR ICONES NO MAPA
BRPVP_mapDrawPrecisao = -10;
BRPVP_iconesTotaisOnBeep = [];
BRPVP_iconesTotaisOnBeepDist = [];
BRPVP_iconesTotaisOnBeepHurt = [];
BRPVP_addAllwaysIcon = {
	params ["_marca","_objeto"];
	if (!isNull _objeto) then {
		_marca setMarkerPosLocal (if (simulationEnabled _objeto) then { getPosWorld _objeto} else {_objeto getVariable ["brpvp_fpsBoostPos",[0,0]]});
		if (_objeto == player) then {_marca setMarkerDirLocal getDir _objeto;};
	} else {
		_marca setMarkerPosLocal BRPVP_posicaoFora;
	};
};
BRPVP_addBlinkIcon = {
	params ["_marca","_objeto"];
	if (!isNull _objeto && {alive _objeto}) then {
		_pos = getPosWorld _objeto;
		_dist = _objeto distance BRPVP_radarCenter;
		if (BRPVP_vePlayers) then {
			if (_objeto call BRPVP_vePlayersTypesCodeNow) then {
				_marca setMarkerPosLocal _pos;
				_marca setMarkerAlphaLocal 1;
			} else {
				_marca setMarkerPosLocal BRPVP_posicaoFora;
			};
		} else {
			if (_dist < BRPVP_radarDist * 2 && {!(terrainIntersectASL [AGLToASL BRPVP_radarCenter,_pos])}) then {
				_show = true;
				_pO = [_pos,random (BRPVP_radarDistErr * _dist),random 360] call BIS_fnc_relPos;
				if (_objeto isKindOf "Man") then {
					_veic = vehicle _objeto;
					if (_veic != _objeto) then {
						if !(_veic in _allVeics) then {
							_allVeics pushBack _veic;
						} else {
							_pO = BRPVP_posicaoFora;
							_show = false;
						};
					};
				};
				_marca setMarkerPosLocal _pO;
				if (_show) then {
					_signalHurt1 = (selectBestPlaces [_objeto,1,"forest",1,1]) select 0 select 1;
					_nearestBuilding = nearestObject [_objeto,"Building"];
					_nearestDistance = if (!isNull _nearestBuilding) then {[_objeto,_nearestBuilding] call PDTH_distance2Box} else {100};
					_signalHurt2 = 1 - (((_nearestDistance - 5) max 0) min 20)/20;
					_signalHurt = _signalHurt1 max _signalHurt2;
					BRPVP_iconesTotaisOnBeep pushBack _this;
					BRPVP_iconesTotaisOnBeepDist pushBack _dist;
					BRPVP_iconesTotaisOnBeepHurt pushBack _signalHurt;
				};
			} else {
				_marca setMarkerPosLocal BRPVP_posicaoFora;
			};
		};
	} else {
		_marca setMarkerPosLocal BRPVP_posicaoFora;
	};
};
BRPVP_mapDraw = {
	private ["_allVeics"];
	_time = time;
	_passou = _time - BRPVP_mapDrawPrecisao;
	if (_passou >= BRPVP_radarBeepInterval || BRPVP_fazRadarBip) then {
		_radarConfig = if (BRPVP_vePlayers) then {[0,0,0.5,[0,0,0]]} else {BRPVP_radarConfigPool select 0};
		BRPVP_radarDist = _radarConfig select 0;
		BRPVP_radarDistErr = _radarConfig select 1;
		BRPVP_radarBeepInterval = _radarConfig select 2;
		BRPVP_radarCenter = _radarConfig select 3;
		if (typeName BRPVP_radarCenter == "OBJECT") then {
			BRPVP_radarCenter = getPosWorld BRPVP_radarCenter;
			BRPVP_radarCenter = ASLToAGL BRPVP_radarCenter;
			_extraH = if (count _radarConfig == 5) then {_radarConfig select 4} else {0};
			BRPVP_radarCenter set [2,2 * (BRPVP_radarCenter select 2) + _extraH];
		};
		BRPVP_fazRadarBip = false;
		BRPVP_mapDrawPrecisao = _time;
		BRPVP_iconesTotaisOnBeep = [];
		BRPVP_iconesTotaisOnBeepDist = [];
		BRPVP_iconesTotaisOnBeepHurt = [];
		if (!visibleGPS && BRPVP_radarDist > 0) then {playSound "ciclo";};
		_allVeics =[];
		{
			_unit = _x select 1;
			if !(_unit in BRPVP_meusAmigosObj || _unit == player ) then {
				_x call BRPVP_addBlinkIcon;
			};
		} forEach BRPVP_iconesLocaisBots;
		{
			_veh = _x select 1;
			_crew = crew _veh;
			if (count _crew > 0) then {
				_carWithFriend = false;
				{
					if (_x in BRPVP_meusAmigosObj || _x == player) exitWith {_carWithFriend = true;};
				} forEach _crew;
				if (!_carWithFriend) then {
					_x call BRPVP_addBlinkIcon;
				} else {
					(_x select 0) setMarkerPosLocal BRPVP_posicaoFora;
				};
			} else {
				_x call BRPVP_addBlinkIcon;
			};
		} forEach BRPVP_iconesLocaisVeiculi;
		{_x call BRPVP_addAllwaysIcon;} forEach BRPVP_iconesLocaisSempre;
	};
	{_x call BRPVP_addAllwaysIcon;} forEach BRPVP_iconesLocais;
	{_x call BRPVP_addAllwaysIcon;} forEach BRPVP_iconesLocaisStuff;
	_uOff = [];
	_vehicles = [];
	_BRPVP_iconesLocaisAmigos = +BRPVP_iconesLocaisAmigos;
	_friends = _BRPVP_iconesLocaisAmigos apply {_x select 1};
	{
		_marca = _x select 0;
		_objeto = _x select 1;
		if (!isNull _objeto && {!(_objeto in _uOff) && {_objeto getVariable ["sok",false] && _objeto getVariable ["dd",-1] <= 0}}) then {
			_veh = vehicle _objeto;
			_inVeh = _objeto != _veh;
			_checkAgain = false;
			if (_inVeh && {!(_veh in _vehicles)}) then {
				_vehicles pushBack _veh;
				_crew = (crew _veh) arrayIntersect _friends;
				_one = _crew select (BRPVP_countSecs mod count _crew);
				_uOff append (_crew - [_one]);
				_checkAgain = true;
			};
			if (!_checkAgain || {!(_objeto in _uOff)}) then {
				_marca setMarkerPosLocal getPosWorld _objeto;
			} else {
				_marca setMarkerPosLocal BRPVP_posicaoFora;
			};
		} else {
			_marca setMarkerPosLocal BRPVP_posicaoFora;
		};
	} forEach _BRPVP_iconesLocaisAmigos;
	_intPerda = 0.8 + BRPVP_radarBeepInterval * (_passou/BRPVP_radarBeepInterval)^2;
	{
		_marca = _x select 0;
		if (!BRPVP_vePlayers) then {
			_objeto = _x select 1;
			_dist = (BRPVP_iconesTotaisOnBeepDist select _forEachIndex) * _intPerda;
			_hurt = BRPVP_iconesTotaisOnBeepHurt select _forEachIndex;
			_mostra = false;
			if (BRPVP_radarDist != 0 && {random 1 < ((BRPVP_radarDist - _dist)/BRPVP_radarDist) * (1 - _hurt)}) then {
				_mostra = true;
			};
			if (_mostra) then {
				_marca setMarkerAlphaLocal 1;
			} else {
				_marca setMarkerAlphaLocal 0;
			};
		};
	} forEach BRPVP_iconesTotaisOnBeep;
};

//ATUALIZAR INFORMACOES DO DEBUG
BRPVP_atualizaDebug = {
	private ["_veiculo","_veiculoImg","_weapon","_weaponImg"];
	_vPlayer = vehicle player;
	_typeOf = typeOf _vPlayer;
	if !(player isEqualTo _vPlayer) then {
		_veiculo = getText (configFile >> "CfgVehicles" >> _typeOf >> "displayName");
		_veiculoImg = getText (configFile >> "CfgVehicles" >> _typeOf >> "picture");
	} else {
		_veiculo = localize "str_adda_no_vehicle";
		_veiculoImg = "";
	};
	_currentWeapon = currentWeapon player;
	if (_currentWeapon != "") then {
		_weapon = getText (configFile >> "CfgWeapons" >> _currentWeapon >> "displayName");;
		_weaponImg = getText (configFile >> "CfgWeapons" >> _currentWeapon >> "picture");
	} else {
		_weapon = localize "str_adda_no_weapon";
		_weaponImg = "";
	};
	_danoGeral = 1 - damage player;
	_danoPartes = (player getHit "head") + (player getHit "legs") + (player getHit "arms") + (player getHit "body");
	BRPVP_ultimoDebugDoHint = format [
		BRPVP_indiceDebugItens select BRPVP_indiceDebug, //OK
		((1 - _danoPartes * 0.25) * _danoGeral) call BRPVP_statusBarHealth, //OK
		"<img size='1.2' image='BRP_imagens\interface\status_bar\players_icon.paa'/><t> "+(str count allPlayers)+"</t>", //OK
		"%",
		"",
		if (_veiculoImg != "") then {"<img size='1' image='"+_veiculoImg+"'/><t> "+_veiculo+"</t>"} else {"<t>"+_veiculo+"</t>"}, //OK
		if (_weaponImg != "") then {"<img size='1.2' image='"+_weaponImg+"'/><t> "+_weapon+"</t>"} else {"<t>"+_weapon+"</t>"}, //OK
		diag_fps call BRPVP_statusBarFps, //OK
		BRPVP_servidorQPS,
		"",
		"<img size='1' image='BRP_imagens\interface\status_bar\wallet.paa'/><t> "+((player getVariable ["mny",0]) call BRPVP_formatNumber)+"</t><t color='#55DD55'> $</t>", //OK
		BRPVP_zombieFactorPercentage,
		"",
		"<img size='1' image='BRP_imagens\interface\status_bar\zombie_icon.paa'/><t> "+str (player getVariable ["brpvp_zombies_on_me",0])+"</t>", //OK
		"<img size='1.2' image='BRP_imagens\interface\status_bar\bank.paa'/><t> "+((player getVariable ["brpvp_mny_bank",0]) call BRPVP_formatNumber)+"</t><t color='#55DD55'> $</t>", //OK
		if (player getVariable ["cmb",false]) then {"<img size='0.85' image='BRP_imagens\interface\status_bar\combat_on.paa'/><t color='#FF0000'> "+localize "str_sbar_combat_on"+"</t>"} else {"<img size='0.85' image='BRP_imagens\interface\status_bar\combat_off.paa'/><t color='#00FF00'> "+localize "str_sbar_combat_off"+"</t>"}
	];
	if !(BRPVP_construindo || BRPVP_menuExtraLigado) then {hintSilent "";};
	if (BRPVP_statusBarOn && BRPVP_statusBarOnOverall) then {
		(findDisplay 46 displayCtrl BRPVP_barControlId) ctrlSetStructuredText parseText BRPVP_ultimoDebugDoHint;
	} else {
		(findDisplay 46 displayCtrl BRPVP_barControlId) ctrlSetStructuredText parseText "";
	};
};
BRPVP_atualizaDebugMenu = {
	if (BRPVP_construindo) then {
		hintSilent parseText call BRPVP_construcaoHint;
	} else {
		if (BRPVP_menuExtraLigado) then {
			if !(call BRPVP_menuForceExit) then {
				hintSilent parseText call BRPVP_menuHtml;
			} else {
				playSound "erro";
				BRPVP_menuExtraLigado = false;
				call BRPVP_atualizaDebug;
			};
		};
	};
};

//PLAYER COMPROU ITEM
BRPVP_comprouItem = {
	params ["_item","_preco"];
	if ((BRPVP_compraPrecoTotal + _preco) * BRPVP_marketPrecoMult <= player call BRPVP_qjsValorDoPlayer) then {
		BRPVP_compraPrecoTotal = BRPVP_compraPrecoTotal + _preco;
		BRPVP_compraItensTotal pushBack _item;
		BRPVP_compraItensPrecos pushBack _preco;
		playSound "negocio";
	} else {
		playSound "erro";
		[localize "str_cant_buy_try_remove",0] call BRPVP_hint;
	};
};
BRPVP_comprouItemFinaliza = {
	diag_log "[BRPVP TRADER] BRPVP_comprouItemFinaliza STARTED!";
	if (count BRPVP_compraItensTotal > 0) then {
		_money = player getVariable ["mny",0];
		_price = BRPVP_compraPrecoTotal * BRPVP_marketPrecoMult;
		if (_money < _price) then {
			[format [localize "str_need_more",_price - _money],4,5] call BRPVP_hint;
			playSound "erro";
		} else {
			if (BRPVP_marketDeployMode == "default") then {
				_minhasComprasWH = createVehicle ["GroundWeaponHolder",getPosATL player,[],0,"CAN_COLLIDE"];
				_minhasComprasWH setVariable ["own",player getVariable ["id_bd",-1],true];
				_minhasComprasWH setVariable ["amg",player getVariable ["amg",[]],true];
				_minhasComprasWH setVariable ["stp",1,true];
				player setVariable ["mny",(player getVariable ["mny",0]) - _price,true];
				_onGround = [player,BRPVP_compraItensTotal,_minhasComprasWH] call BRPVP_addLoot;
				if (_onGround) then {
					[localize "str_items_ground",4,15] call BRPVP_hint;
				} else {
					[localize "str_items_have_all",3,10] call BRPVP_hint;
				};
				playSound "negocio";
				playSound "ugranted";
			};
			if (BRPVP_marketDeployMode == "fedidex") then {
				_price spawn {
					_fedidexPos = AGLToASL ([player,5 + random 10,random 360] call BIS_fnc_relPos);
					_fedidexPos set [2,(_fedidexPos select 2) + 1000];
					_fedidexBox = "Box_NATO_WpsSpecial_F" createVehicle [0,0,0];
					_fedidexBox setPosASL _fedidexPos;
					_fedidexBox setVectorUp [-1 + random 2,-1 + random 2,2];
					_fedidexBox allowDamage false;
					_fedidexBox setVelocity [0,0,-12];
					_lastPos = getPosASL _fedidexBox;
					_countNoMove = 0;
					_init = time;
					playSound "fedidex_start";
					["<img size='4' image='BRP_imagens\interface\delivery.paa'/>",0,0,3,0,0,7757] spawn BIS_fnc_dynamicText;
					sleep 1;
					waitUntil {
						_newPos = getPosASL _fedidexBox;
						if (_newPos distance _lastPos < 0.1) then {_countNoMove = _countNoMove + 1;} else {_countNoMove = 0;};
						_lastPos = _newPos;
						_countNoMove >= 10
					};
					player setVariable ["mny",(player getVariable ["mny",0]) - _this,true];
					_holder = createVehicle ["GroundWeaponHolder",ASLToAGL getPosASL _fedidexBox,[],0,"CAN_COLLIDE"];
					_fedidexBox setDamage 1;
					_holder setVariable ["own",player getVariable ["id_bd",-1],true];
					_holder setVariable ["amg",player getVariable ["amg",[]],true];
					_holder setVariable ["stp",1,true];
					[_holder,"delivered",400] call BRPVP_playSoundAllCli;
					_fedidexBox setVelocity [-3 + random 6,-3 + random 6,10];
					{
						_isM = isClass (configFile >> "CfgMagazines" >> _x);
						if (_isM) then {
							_holder addMagazineCargoGlobal [_x,1];
						} else {
							_isW = isClass (configFile >> "CfgWeapons" >> _x);
							if (_isW) then {
								_isItem = _x isKindOf ["ItemCore",configFile >> "CfgWeapons"];
								_isBino = _x isKindOf ["Binocular",configFile >> "CfgWeapons"];
								if (_isItem || _isBino) then {
									_holder addItemCargoGlobal [_x,1];
								} else {
									_holder addWeaponCargoGlobal [_x,1];
								};
							} else {
								_isV = isClass (configFile >> "CfgVehicles" >> _x);
								if (_isV) then {
									_holder addBackpackCargoGlobal [_x,1];
								};
							};
						};
					} forEach BRPVP_compraItensTotal;
					[format [localize "str_fedidex_time",round (time - _init)]] call BRPVP_hint;
					playSound "negocio";
					playSound "fedidex";
				};
			};
		};
	};
};
BRPVP_vaultAbre = {
	playSound "abrevault";
	_posPlayer = getPosATL player;
	_multiplicador = 0;
	if (_posPlayer select 2 > 0.1) then {_multiplicador = 1;};
	_posPlayerZ0 = [_posPlayer select 0,_posPlayer select 1,0];
	_posPlayerASL = ATLtoASL _posPlayerZ0;
	_ang = getDir player;
	_posVault = [(_posPlayer select 0) + 2 * sin _ang,(_posPlayer select 1) + 2 * cos _ang,_posPlayer select 2];
	_posVaultZ0 = [_posVault select 0,_posVault select 1,0];
	_posVaultASL = ATLtoASL _posVaultZ0;
	_hExtra = (_posPlayerASL select 2) - (_posVaultASL select 2);
	_posVault set [2,(_posVault select 2) + _hExtra * _multiplicador];
	BRPVP_holderVault = "Box_NATO_WpsSpecial_F" createVehicle [0,0,0];
	BRPVP_holderVault setVariable ["stp",0,true];
	BRPVP_holderVault setDir getDir player;
	BRPVP_holderVault addEventHandler ["HandleDamage",{0}];
	BRPVP_holderVault setPos _posVault;
	clearWeaponCargoGlobal BRPVP_holderVault;
	clearMagazineCargoGlobal BRPVP_holderVault;
	clearBackPackCargoGlobal BRPVP_holderVault;
	clearItemCargoGlobal BRPVP_holderVault;
	BRPVP_holderVault setVariable ["own",player getVariable ["id_bd",-1],true];
	BRPVP_holderVault setVariable ["amg",player getVariable ["amg",[]],true];
	BRPVP_holderVault setPosATL _posVault;
	if (_multiplicador == 1) then {BRPVP_holderVault setVectorUp [0,0,1];};
	_posVault set [2,(_posVault select 2) + 0.5];
	BRPVP_pegaVaultPlayerBdRetorno = nil;
	BRPVP_pegaVaultPlayerBd = [player,0];
	if (isServer) then {["",BRPVP_pegaVaultPlayerBd] call BRPVP_pegaVaultPlayerBdFnc;} else {publicVariableServer "BRPVP_pegaVaultPlayerBd";};
};
BRPVP_vaultRecolhe = {
	playSound "fechavault";
	BRPVP_holderVault setPos [0,0,0];
	_armas = [[],[]];
	_magas = magazinesAmmoCargo BRPVP_holderVault;
	_mochi = getBackpackCargo BRPVP_holderVault;
	_itens = getItemCargo BRPVP_holderVault;
	_conts = everyContainer BRPVP_holderVault;

	_check = [];
	_checkRemove = [];
	_conts = _conts apply {
		if (_x select 1 in _check) then {
			_checkRemove pushBack (_x select 0);
			-1
		} else {
			_check pushBack (_x select 1);
			_x
		};
	};
	_conts = _conts - [-1];
	{
		_idx = (_mochi select 0) find _x;
		if (_idx != -1) then {
			_quantity = _mochi select 1 select _idx;
			if (_quantity == 1) then {
				(_mochi select 0) deleteAt _idx;
				(_mochi select 1) deleteAt _idx;
			} else {
				(_mochi select 1) set [_idx,_quantity - 1];
			};
		};
	} forEach _checkRemove;

	_weaponsItemsCargo = weaponsItemsCargo BRPVP_holderVault;
	{_weaponsItemsCargo append (weaponsItemsCargo (_x select 1));} forEach _conts;
	{
		_arma = _x;
		{
			if (_forEachIndex == 0) then {
				_armas = [_armas,_x call BIS_fnc_baseWeapon] call BRPVP_adicCargo;
			} else {
				if (typeName _x == "ARRAY") then {if (count _x > 0) then {_magas append [_x];};};
				if (typeName _x == "STRING") then {if (_x != "" && _forEachIndex != 5) then {_itens = [_itens,_x] call BRPVP_adicCargo;};};
			};
		} forEach _arma;
	} forEach _weaponsItemsCargo;
	{
		_cont = _x select 1;
		_magas append magazinesAmmoCargo _cont;
		_itensC = getItemCargo _cont;
		{
			_qt = _itensC select 1 select _forEachIndex;
			for "_i" from 1 to _qt do {_itens = [_itens,_x] call BRPVP_adicCargo;};
		} forEach (_itensC select 0);
	} forEach _conts;
	_estadoVault = [
		getPlayerUID player,
		[_armas,_magas,_mochi,_itens],
		//BRPVP_holderVault getVariable ["stp",1]
		1
	];
	diag_log ("[BRPVP VAULT] SAVING VAULT: " + str _estadoVault);
	_estadoPlayer = player call BRPVP_pegaEstadoPlayer;
	player setVariable ["wh",objNull,true];
	BRPVP_salvaPlayerVault = [_estadoPlayer,[_estadoVault,0]];
	if (isServer) then {["",BRPVP_salvaPlayerVault] call BRPVP_salvaPlayerVaultFnc;} else {publicVariableServer "BRPVP_salvaPlayerVault";};
	clearWeaponCargoGlobal BRPVP_holderVault;
	clearMagazineCargoGlobal BRPVP_holderVault;
	clearBackpackCargoGlobal BRPVP_holderVault;
	clearItemCargoGlobal BRPVP_holderVault;
	deleteVehicle BRPVP_holderVault;
};
BRPVP_incluiPlayerBd = {
	_hpd = getAllHitPointsDamage player;
	_estado = [
		getPlayerUID player,
		[[],["",["","","",""],[]],["",["","","",""],[]],["",["","","",""],[]],[]],
		[["",[[[],[]],[[],[]],[[],[]]]],["",[[[],[]],[[],[]],[[],[]]]],["",[[[],[]],[[],[]],[[],[]]]]],
		[0,[0,0,0]],
		[[_hpd select 1,_hpd select 2],[100,100],damage player],
		[typeOf player,"",""],
		"",
		player getVariable ["nm","sem_nome"],
		BRPVP_experienciaZerada,
		BRPVP_startingMoney,
		[],
		BRPVP_startingMoneyOnBank
	];
	BRPVP_incluiPlayerNoBd = [player,_estado];
	if (isServer) then {["",BRPVP_incluiPlayerNoBd] call BRPVP_incluiPlayerNoBdFnc;} else {publicVariableServer "BRPVP_incluiPlayerNoBd";};
};
BRPVP_protejeCarro = {
	params ["_v","_motorOn"];
	_deGeral = _v getVariable ["own",-1] == -1;
	if (_deGeral) then {
		cutText ["","PLAIN",1];
		cutText [localize "str_vehprot_public","PLAIN",0.25];
	} else {
		waitUntil {local _v};
		_gasLock = {
			_fV = fuel _v;
			if (_fV > 0) then {
				_v setVariable ["gas",_fV,true];
				_v setFuel 0;
				//[_v,"alarme_carro",1] call BRPVP_playSoundAllCli;
				playSound "erro";
			};
		};
		_releaseGasLock = {
			_gas = _v getVariable ["gas",-1];
			if (_gas >= 0) then {
				_v setFuel _gas;
				_v setVariable ["gas",-1,true];
			};
		};
		call _releaseGasLock;
		_uAtuAmg = BRPVP_tempoUltimaAtuAmigos;
		_uStp = _v getVariable ["stp",0];
		if (_motorOn) then {
			waitUntil {!isEngineOn _v || driver _v != player || !alive _v || !alive player};
		};
		if ((alive player && alive _v && !isEngineOn _v && driver _v == player) || !_motorOn) then {
			private ["_lib"];
			if (_v call BRPVP_checaAcesso) then {
				cutText ["","PLAIN",1];
				cutText [localize "str_vehprot_can_use","PLAIN",0.25];
				_lib = true;
			} else {
				cutText ["","PLAIN",1];
				cutText [localize "str_vehprot_cant_use","PLAIN",0.25];
				_lib = false;
			};
			_atento = true;
			waitUntil {
				if (_atento) then {
					_nStp = _v getVariable ["stp",0];
					if (_uAtuAmg != BRPVP_tempoUltimaAtuAmigos || _nStp != _uStp) then {
						_uAtuAmg = BRPVP_tempoUltimaAtuAmigos;
						_uStp = _nStp;
						if (_v call BRPVP_checaAcesso) then {
							if (!_lib) then {
								cutText ["","PLAIN",1];
								cutText [localize "str_vehprot_can_use","PLAIN",0.25];
								call _releaseGasLock;
								_lib = true;
							};
						} else {
							if (_lib) then {
								cutText ["","PLAIN",1];
								cutText [localize "str_vehprot_cant_use","PLAIN",0.25];
								_lib = false;
							};
						};
					};
					if (isEngineOn _v) then {
						if (_v call BRPVP_checaAcesso) then {
							_atento = false;
						} else {
							cutText ["","PLAIN",1];
							cutText [localize "str_vehprot_lock_on","PLAIN",0.25];
							call _gasLock;
						};
					};
				} else {
					if (!isEngineOn _v) then {_atento = true;};
				};
				driver _v != player || !alive _v || !alive player
			};
			cutText ["","PLAIN",1];
		};
	};
};
BRPVP_switchMove = {
	if (typeName _this == "STRING") then {
		BRPVP_switchMoveSv = [player,_this];
	} else {
		BRPVP_switchMoveSv = _this;
	};
	 if (isServer) then {["",BRPVP_switchMoveSv] call BRPVP_switchMoveSvFnc;} else {publicVariableServer "BRPVP_switchMoveSv";};
};
BRPVP_drawSetas = {
	params ["_obj","_txt"];
	{
		_count = count _x;
		if (_count > 0) then {
			if (_count == 3) then {
				BRPVP_drawIcon3DC pushBack [BRPVP_missionRoot + "BRP_imagens\icones3d\setabu" + str _forEachIndex + ".paa",[1,1,1,1],_x,0.55,0.55,0,_txt,0,0.02];
			} else {
				if (_count == 2) then {
					BRPVP_drawIcon3DC pushBack [BRPVP_missionRoot + "BRP_imagens\icones3d\setacha" + str _forEachIndex + ".paa",[1,1,1,1],_x + [0],0.55,0.55,0,_txt,0,0.02];
				};
			};
		};
	} forEach (_obj getVariable ["sts",[]]);
};
BRPVP_checaAcesso = {
	//MINHAS RELACOES
	_id_bd = player getVariable ["id_bd",-1];
	_amg = player getVariable ["amg",[]];

	//RELACOES OBJ CHECADO
	_oOwn = _this getVariable ["own",-1];
	_oAmg = _this getVariable ["amg",[]];
	if !(count _oAmg == 2 && {typeName (_oAmg select 0) == "ARRAY"}) then {_oAmg = [_oAmg,[]];};
	_oAmg = (_oAmg select 0) + (_oAmg select 1);
	_oShareT = _this getVariable ["stp",1];
	
	//FOR "MO ONE" SHARE
	if (_oShareT == 4 && !BRPVP_vePlayers) exitWith {false};
	
	//CHECA ACESSO
	_retorno = false;
	if (BRPVP_vePlayers || _oOwn == -1 || _id_bd == _oOwn || _oShareT == 3) then {
		_retorno = true;
	} else {
		if (_oShareT != 0) then {
			if (_oShareT == 1) then {
				if (_id_bd in _oAmg) then {_retorno = true;};
			} else {
				if (_oShareT == 2) then {
					if (_id_bd in _oAmg && _oOwn in _amg) then {_retorno = true;};
				};
			};
		};
	};
	_retorno
};
BRPVP_atualizaMeuStuffAmg = {
	_amgPlayer = player getVariable "amg";
	{
		if (!isNull _x) then {
			_amgObj = _x getVariable "amg";
			_amgObj set [0,_amgPlayer];
			_x setVariable ["amg",_amgObj,true];
			if !(_x getVariable ["slv_amg",false]) then {_x setVariable ["slv_amg",true,true];};
		};
	} forEach BRPVP_myStuff;
	if (!isNull BRPVP_holderVault) then {BRPVP_holderVault setVariable ["amg",player getVariable "amg"];};
	if (!isNull BRPVP_sellReceptacle) then {BRPVP_sellReceptacle setVariable ["amg",player getVariable "amg"];};
};
BRPVP_compEstado = {
	_estado = _this getVariable ["stp",-1];
	_result = "Unknow Share Type";
	if (_estado == -1) then {
		_result = "Todo mundo (Publico)";
	} else {
		if (_estado == 0) then {
			_result = "Eu";
		} else {
			if (_estado == 1) then {
				_result = "Eu + Quem eu confio";
			} else {
				if (_estado == 2) then {
					_result = "Eu + Quem eu confio reciprocamente";
				} else {
					if (_estado == 3) then {
						_result = "Todo mundo";
					} else {
						if (_estado == 4) then {
							_result = "Ninguem";
						};
					};
				};
			};
		};
	};
	_result
};
BRPVP_achaMeuStuff = {
	_id_bd = player getVariable ["id_bd",-1];
	_pAmg = player getVariable ["amg",[]];
	if (_id_bd != -1) then {
		_BRPVP_myStuff = [];
		_BRPVP_respawnSpot = [];
		_normalVarSet = BRPVP_centroMapa nearEntities [["LandVehicle","Air","Ship"],20000];
		_normalVarSet append BRPVP_ownedHouses;
		{
			if (_x getVariable ["own",-1] == _id_bd) then {
				_xAmg = _x getVariable ["amg",[[],[]]];
				if !((_xAmg select 0) isEqualTo _pAmg) then {
					_xAmg set [0,_pAmg];
					_x setVariable ["amg",_xAmg,true];
					if !(_x getVariable ["slv_amg",false]) then {_x setVariable ["slv_amg",true,true];};
				};
				_typeOf = typeOf _x;
				if (_typeOf in BRP_kitRespawnA || _typeOf in BRP_kitRespawnB) then {
					_BRPVP_respawnSpot pushBack _x;
					_pos2D = getPosWorld _x;
					_pos2D resize 2;
					_x setVariable ["brpvp_fpsBoostPos",_pos2D,true];
				};
				_BRPVP_myStuff pushBack _x;
			};
		} forEach _normalVarSet;
		BRPVP_respawnSpot = +_BRPVP_respawnSpot;
		BRPVP_myStuff = +_BRPVP_myStuff;
	};
};
BRPVP_findMyFlags = {
	_BRPVP_myStuffOthers = [];
	{
		if (_x getVariable ["id_bd",-1] != -1 && [player,_x] call BRPVP_checaAcessoRemotoFlag) then {
			_BRPVP_myStuffOthers pushBack _x;
		};
	} forEach BRPVP_allFlags;
	if !(_BRPVP_myStuffOthers isEqualTo BRPVP_myStuffOthers) then {
		BRPVP_myStuffOthers = +_BRPVP_myStuffOthers;
	};
};
BRPVP_mudaDonoPropriedade = {
	params ["_obj","_newOwner"];
	if (isNull _newOwner) then {
		_obj setVariable ["own",-1,true];
		_obj setVariable ["amg",[[],[]],true];
		_obj setVariable ["stp",1,true];
	} else {
		_obj setVariable ["own",_newOwner getVariable "id_bd",true];
		_obj setVariable ["amg",[_newOwner getVariable "amg",[]],true];
		_obj setVariable ["stp",_newOwner getVariable "dstp",true];
	};
	
	//GENERAL OBJECT UPDATES
	if !(_obj getVariable ["slv_amg",false]) then {_obj setVariable ["slv_amg",true,true];};
	_obj call BRPVP_updateObjectFlagProtection;
	
	//MY UPDATES RELATIVE TO THE OBJECT
	BRPVP_myStuff = BRPVP_myStuff - [_obj];
	if (BRPVP_stuff isEqualTo _obj) then {BRPVP_stuff = objNull;};
	["mastuff"] call BRPVP_atualizaIcones;
	
	//OBJECT RECEIVER UPDATES RELATIVE TO THE OBJECT
	[
		_obj,
		{
			[localize "str_props_received",4,15] call BRPVP_hint;
			BRPVP_myStuff pushBackUnique _this;
			["mastuff"] call BRPVP_atualizaIcones;
		}
	] remoteExec ["call",_newOwner,false];
};

diag_log "[BRPVP FILE] funcoes.sqf END REACHED";