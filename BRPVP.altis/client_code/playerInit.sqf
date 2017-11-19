diag_log "[BRPVP FILE] playerInit.sqf INITIATED";

//CODIGO A SER RODADO APENAS UMA VEZ
if (isNil "BRPVP_primeiraRodadaOk") then {
	if (!isServer) then {
		//GET INITIAL SERVER VARS
		BRPVP_iAskForAllInitialVars = player;
		publicVariableServer "BRPVP_iAskForAllInitialVars";
		waitUntil {!isNil "BRPVP_helisObjetos"};
	};

	//DEFINE VARIAVEIS
	BRPVP_variavies = compileFinal preprocessFileLineNumbers "client_code\perSpawnVariables.sqf";
	call BRPVP_variavies;

	//IMPEDE QUE O CODIGO RODE DE NOVO
	BRPVP_primeiraRodadaOk = 1;
	
	//VARIAVEIS ONE TIME SET
	BRPVP_vePlayersTypesTxt = [localize "str_mapshow_all",localize "str_mapshow_veh",localize "str_mapshow_car",localize "str_mapshow_heli",localize "str_mapshow_plane",localize "str_mapshow_turr",localize "str_mapshow_ai",localize "str_mapshow_bases"];
	BRPVP_vePlayersTypesCode = [
		{true},
		{_this isKindOf "LandVehicle" || {_this isKindOf "Air" || {_this isKindOf "Ship"}}},
		{_this isKindOf "LandVehicle"},
		{_this isKindOf "Helicopter"},
		{_this isKindOf "Plane"},
		{_this isKindOf "StaticWeapon"},
		{_this isKindOf "CaManBase"},
		{false}
	];
	BRPVP_statusBarOn = true;
	BRPVP_statusBarOnOverall = false;
	BRPVP_barControlId = 552793;
	BRPVP_motorizedToLockUnlock = objNull;
	BRPVP_myStuffOthers = [];
	BRPVP_antiWeaponDupeBoolean = false;
	BRPVP_monitoreGroups = false;
	BRPVP_spectateHeadOffset = [0,-0.65,0.45];
	BRPVP_completeUpdate = false;
	BRPVP_vePlayersTypesIndex = 0;
	BRPVP_vePlayersTypesIndexBases = 7;
	BRPVP_vePlayersTypesCodeNow = BRPVP_vePlayersTypesCode select BRPVP_vePlayersTypesIndex;
	BRPVP_safeZonesOtherMethod = [];
	BRPVP_actualAutoTurrets = BRPVP_autoTurretOnMan;
	BRPVP_actualAutoTurretsDist = BRPVP_autoTurretFireRange select 0;
	BRPVP_autoTurretDangerLevel = 0;
	BRPVP_landVehicleOnTow = objNull;
	BRPVP_spectateOn = false;
	BRPVP_connectionOn = false;
	BRPVP_respawnSpot = [];
	BRPVP_radarDist = 0;
	BRPVP_radarDistErr = 0;
	BRPVP_radarBeepInterval = 5;
	BRPVP_radarCenter = [0,0,0];
	BRPVP_notBlockedKeys = (actionKeys "Chat") + (actionKeys "ShowMap") + (actionKeys "HideMap") + (actionKeys "NextChannel") + (actionKeys "PrevChannel") + (actionKeys "PushToTalk") + (actionKeys "PushToTalkAll") + (actionKeys "PushToTalkCommand") + (actionKeys "PushToTalkDirect") + (actionKeys "PushToTalkGroup") + (actionKeys "PushToTalkSide") + (actionKeys "PushToTalkVehicle") + [0x32,0x01,0xD2];
	BRPVP_assignedVehicle = objNull;
	BRPVP_sellReceptacle = objNull;
	BRPVP_disabledWeapon = "";
	BRPVP_disabledDamage = 0;
	BRPVP_disabledBleed = 0;
	BRPVP_playerLastCorpse = objNull;
	BRPVP_onSiegeIcons = [];
	BRPVP_playerIsCaptive = false;
	BRPVP_indiceDebugTxt = localize "str_debug_type1";
	BRPVP_mtdr_lootTable_bobj_local = [];
	BRPVP_playerDamaged = false;
	BRPVP_fazRadarBip = false;
	BRPVP_ganchoDesvira = [];
	BRPVP_tempoUltimaAtuAmigos = 0;
	BRPVP_achaMeuStuffRodou = false;
	BRPVP_objetoMarcado = objNull;
	BRPVP_meuVeiculoNow = [];
	BRPVP_idcIconesAntes = -1;
	BRPVP_idcIcones = 0;
	BRPVP_iconesLocais = [];
	BRPVP_iconesLocaisAmigos = [];
	BRPVP_iconesLocaisBots = [];
	BRPVP_iconesLocaisVeiculi = [];
	BRPVP_iconesLocaisStuff = [];
	BRPVP_iconesLocaisSempre = [];
	BRPVP_expLegenda = [localize "str_explist_0",localize "str_explist_1",localize "str_explist_2",localize "str_explist_3",localize "str_explist_4",localize "str_explist_5",localize "str_explist_6",localize "str_explist_7",localize "str_explist_8",localize "str_explist_9",localize "str_explist_10",localize "str_explist_11",localize "str_explist_12",localize "str_explist_13"];
	BRPVP_expLegendaSimples = ["matou_player","player_matou","matou_bot","bot_matou","andou","comeu","levou_tiro_cabeca_player","deu_tiro_cabeca_player","levou_tiro_cabeca_bot","deu_tiro_cabeca_bot","itens_construidos","queda","suicidou","matou_veiculo"];
	BRPVP_acoesClick = [];
	//4 FIRST IDS ARE FROM BRPVP TEAM
	BRPVP_admins = ["76561197975554637","76561198365540020","76561198329297470"];
	if (isServer) then {BRPVP_admins pushBack getPlayerUID player;};
	BRPVP_trataseDeAdmin = (getPlayerUID player) in BRPVP_admins;
	_sep = "<t> <img size='0.8' image='BRP_imagens\interface\status_bar\separator.paa'/> </t>";
	BRPVP_indiceDebugItens = [
		"<t align='center'>%2"+_sep+"%7"+_sep+"%1"+_sep+"%5"+_sep+"%6"+_sep+"%15"+_sep+"%10"+_sep+"%14"+_sep+"%13"+_sep+"<img size='0.8' image='BRP_imagens\interface\status_bar\ts3.paa'/><t> "+BRPVP_TsUrl+"</t>"+_sep+"<img size='0.95' image='BRP_imagens\interface\status_bar\F2.paa'/><t> "+localize "str_sbar_f2"+"</t>"+(if (BRPVP_trataseDeAdmin) then {_sep+"<img size='0.95' image='BRP_imagens\interface\status_bar\F3.paa'/><t> "+localize "str_sbar_f3"+"</t>"} else {""})+"</t>",
		"<t align='center'>%1</t>",
		""
	];
	BRPVP_todasAnimAndando = ["amovpercmrunsnonwnondf","amovpercmrunsraswrfldf","amovpercmrunsraswpstdf","amovpercmwlksnonwnondf","amovpercmwlksraswrfldf","amovpercmwlksraswpstdf","amovpercmevasnonwnondf","amovpercmevasraswrfldf","amovpercmevasraswpstdf"];
	player setVariable ["nm",name player,true];
	player setVariable ["dd",-1,true];
	player setVariable ["id",getPlayerUID player,true];
	player setVariable ["fov",call KK_fnc_trueZoom,true];
	player setVariable ["cmv",if (cameraView == "EXTERNAL") then {"EXTERNAL"} else {"INTERNAL"},true];
	setPlayerRespawnTime 500;
	BRPVP_myStuff = [];
	BRPVP_stuff = objNull;

	//MISSION ROOT: http://killzonekid.com/arma-scripting-tutorials-mission-root/
	BRPVP_missionRoot = str missionConfigFile select [0, count str missionConfigFile - 15];

	//DISABLED SOUNDS
	BRPVP_disabledSoundsIdc = 0;
	BRPVP_disabledSounds = ["disabled1.ogg","disabled2.ogg","disabled3.ogg","disabled4.ogg","disabled5.ogg","disabled6.ogg","disabled7.ogg","disabled8.ogg","disabled9.ogg","disabled10.ogg","disabled11.ogg"];
	BRPVP_disabledSounds = BRPVP_disabledSounds apply {[random 1000,_x]};
	BRPVP_disabledSounds sort true;
	BRPVP_disabledSounds = BRPVP_disabledSounds apply {_x select 1};

	//GET LAST BRPVP_ownedHouses AND BRPVP SIMPLE OBJECTS VARIABLES
	if (!isServer) then {
		BRPVP_ownedHouses = nil;
		BRPVP_ownedHousesSolicita = player;
		publicVariableServer "BRPVP_ownedHousesSolicita";
		waitUntil {!isNil "BRPVP_ownedHouses"};
		diag_log ("[BRPVP OH] BRPVP_ownedHouses = " + str BRPVP_ownedHouses + ".");
	};
	
	//SCRIPTS
	call compile preprocessFileLineNumbers "client_code\itemMarketVariables.sqf";
	call compile preprocessFileLineNumbers "client_code\constructionFunctionsAndVars.sqf";
	call compile preprocessFileLineNumbers "client_code\clientOnlyFunctions.sqf";
	if (!isServer) then {
		call compile preprocessFileLineNumbers "client_code\sistema_loot.sqf";
	};
	call compile preprocessFileLineNumbers "client_code\clientPublicVariableEventHandler.sqf";
	call compile preprocessFileLineNumbers "client_code\playerCustomKeys.sqf";
	call compile preprocessFileLineNumbers "client_code\playerMenuSystem.sqf";
	call compile preprocessFileLineNumbers "client_code\clientLoop.sqf";
	call compile preprocessFileLineNumbers "client_code\playerEventHandlers.sqf";
	execVM "client_code\zombieMotherBrain.sqf";
	execVM "client_code\A3ZombiesLoop.sqf";
	execVM "client_code\autoTurretHelp.sqf";

	//RULES
	if (BRPVP_rulesRequireAccept) then {
		BRPVP_rulesOk = nil;
		_BRPVP_rulesList = BRPVP_rulesList select [0,(count BRPVP_rulesList) min 20];
		_lines = count _BRPVP_rulesList;
		forceMap true;
		waitUntil {openMap true;visibleMap};
		{
			_id = 79866 + _forEachIndex;
			findDisplay 12 ctrlCreate ["RscStructuredText",_id];
			(findDisplay 12 displayCtrl _id) ctrlSetPosition [0,_forEachIndex * 1/_lines,1,((0.8/_lines) min 0.08) max 0.05];
			(findDisplay 12 displayCtrl _id) ctrlSetBackgroundColor ([[0.6,0.375,0,0.85],[0,0.5,0.5,0.85]] select (_forEachIndex mod 2));
			(findDisplay 12 displayCtrl _id) ctrlSetText _x;
			(findDisplay 12 displayCtrl _id) ctrlCommit 0;

		} forEach _BRPVP_rulesList;
		_id1 = 79866 + _lines;
		_id2 = _id1 + 1;
		findDisplay 12 ctrlCreate ["RscButton",_id1];
		(findDisplay 12 displayCtrl _id1) ctrlSetPosition [0,1,0.3,0.1];
		(findDisplay 12 displayCtrl _id1) ctrlSetText localize "str_rules_accept";
		(findDisplay 12 displayCtrl _id1) ctrlCommit 0;
		(findDisplay 12 displayCtrl _id1) ctrlAddEventHandler ["ButtonClick",{BRPVP_rulesOk = true;}];
		findDisplay 12 ctrlCreate ["RscButton",_id2];
		(findDisplay 12 displayCtrl _id2) ctrlSetPosition [0.7,1,0.3,0.1];
		(findDisplay 12 displayCtrl _id2) ctrlSetText localize "str_rules_not_accept";
		(findDisplay 12 displayCtrl _id2) ctrlCommit 0;
		(findDisplay 12 displayCtrl _id2) ctrlAddEventHandler ["ButtonClick",{BRPVP_rulesOk = false;}];
		cutText ["","PLAIN"];
		while {isNil "BRPVP_rulesOk"} do {
			if (!visibleMap) then {openMap true;};
			if (getOxygenRemaining player < 0.4) then {player setOxygenRemaining 1;};
		};
		for "_i" from 79866 to _id2 do {ctrlDelete (findDisplay 12 displayCtrl _i);};
		if (!BRPVP_rulesOk) then {endMission "END1";} else {cutText ["","BLACK FADED",10];};
		sleep 0.001;
		openMap false;
		forceMap false;
	};
	
	//MAP LEGEND
	execVM "client_code\mapLegend.sqf";

	//NASCIMENTO
	BRPVP_nascimento_player = compileFinal preprocessFileLineNumbers "client_code\playerFillAndSpawnInit.sqf";
	BRPVP_nascimento_player_revive = compileFinal preprocessFileLineNumbers "client_code\playerFillAndSpawnRevive.sqf";
	
	//SIEGE ICONS
	BRPVP_closedCityRunning call BRPVP_processSiegeIcons;

	//MapSingleClick MISSION EH
	BRPVP_onMapSingleClick = BRPVP_padMapaClique;
	BRPVP_onMapSingleClickExtra = {};
	addMissionEventHandler ["MapSingleClick",{
		params ["_units","_pos","_alt","_shift"];
		_comPadrao = [_alt,_pos,_shift] call BRPVP_onMapSingleClick;
		if !(_comPadrao) then {
			_comPadrao = [_alt,_pos,_shift] call BRPVP_onMapSingleClickExtra;
		};
		_comPadrao
	}];
	
	BRPVP_onAction = {
		_object = _this select 0;
		_action = _this select 3;
		if (_action == "TakeWeapon") then {
			0 spawn {
				BRPVP_antiWeaponDupeBoolean = true;
				sleep 1.5;
				BRPVP_antiWeaponDupeBoolean = false;
			};
		};
		_canAccess = _object call BRPVP_checaAcesso;
		_isLockUnlock = (_object call BRPVP_isMotorized) && !(_object isKindOf "StaticWeapon") && _object getVariable ["own",-1] != -1 && _object getVariable ["id_bd",-1] != -1;
		_locked = _object getVariable ["brpvp_locked",false];
		_isWestSoldier = _object getVariable ["brpvp_loot_protected",false];
		if ((_isLockUnlock && !_locked) || (!_isLockUnlock && ((_canAccess && !_isWestSoldier) || _object == player)) || _action == "RepairVehicle") then {
			_typeOf = typeOf _object;
			_isWheeledAPCTurret = _action in ["GetInTurret","MoveToTurret"] && _typeOf in ["B_APC_Wheeled_01_cannon_F","O_APC_Wheeled_02_rcws_F","I_APC_Wheeled_03_cannon_F"];
			if (_isWheeledAPCTurret) then {
				[localize "str_apc_turret_off",3,10,677] call BRPVP_hint;
				true
			} else {
				false
			};
		} else {
			if (_isLockUnlock) then {
				[localize "str_no_access_locked",3,10,677] call BRPVP_hint;
			} else {
				if (_isWestSoldier) then {
					[localize "str_cant_access_west_ai"] call BRPVP_hint;
				} else {
					[localize "str_no_access",3,10,677] call BRPVP_hint;
				};
			};
			true
		};
	};
	inGameUISetEventHandler ["Action","_this call BRPVP_onAction"];

	BRPVP_buildAdminGroups = [
		"MRX - All",
		"Fences - City",
		"Fences - Industrial",
		"Fences - Military",
		"Fences - Sport and Recreation",
		"Structures - Airport",
		"Structures - Beach",
		"Structures - Cemetery",
		"Structures - City",
		"Structures - Construction Sites",
		"Structures - Historical",
		"Structures - Industrial",
		"Structures - Lamps",
		"Structures - Market",
		"Structures - Military",
		"Structures - Obstacles",
		"Structures - Railways",
		"Structures - Religious",
		"Structures - Seaport",
		"Structures - Services",
		"Structures - Sport and Recreation",
		"Structures - Storage",
		"Structures - Transportation",
		"Structures - Utilities",
		"Structures - Village",
		"Walls - City",
		"Walls - Historical",
		"Walls - Industrial",
		"Walls - Military",
		"Walls - Obstacles",
		"Walls - Shoot House",
		"Walls - Transportation",
		"Walls - Village"
	];
	BRPVP_buildAdminClasses = [
		["MRX - All","Land_BarGate_F"],
		["MRX - All","Land_JumpTarget_F"],
		["MRX - All","ArrowDesk_L_F"],
		["MRX - All","ArrowDesk_R_F"],
		["MRX - All","ArrowMarker_R_F"],
		["MRX - All","ArrowMarker_L_F"],
		["MRX - All","RoadBarrier_F"],
		["MRX - All","Land_PartyTent_01_F"],
		["MRX - All","Land_GymBench_01_F"],
		["MRX - All","Land_GymRack_01_F"],
		["MRX - All","Land_GymRack_02_F"],
		["MRX - All","Land_GymRack_03_F"],
		["MRX - All","Land_PlasticBarrier_01_F"],
		["MRX - All","Land_PlasticBarrier_01_line_x2_F"],
		["MRX - All","Land_PlasticBarrier_01_line_x4_F"],
		["MRX - All","Land_PlasticBarrier_01_line_x6_F"],
		["MRX - All","Land_PlasticBarrier_02_F"],
		["MRX - All","PlasticBarrier_02_grey_F"],
		["MRX - All","PlasticBarrier_02_yellow_F"],
		["MRX - All","Land_PlasticBarrier_03_F"],
		["MRX - All","PlasticBarrier_03_blue_F"],
		["MRX - All","Land_PalletTrolley_01_khaki_F"],
		["MRX - All","Land_PalletTrolley_01_yellow_F"],
		["MRX - All","Land_EngineCrane_01_F"],
		["MRX - All","WaterPump_01_sand_F"],
		["MRX - All","WaterPump_01_forest_F"],
		["MRX - All","Land_FloodLight_F"],
		["MRX - All","Land_PortableLight_single_F"],
		["MRX - All","Land_PortableLight_double_F"],
		["MRX - All","Land_Tyre_01_line_x5_F"],
		["MRX - All","Land_Bench_03_F"],
		["MRX - All","Land_Bench_04_F"],
		["MRX - All","Land_Bench_05_F"],
		["MRX - All","Land_CinderBlocks_01_F"],
		["MRX - All","Land_GarbageHeap_01_F"],
		["MRX - All","Land_GarbageHeap_02_F"],
		["MRX - All","Land_GarbageHeap_03_F"],
		["MRX - All","Land_GarbageHeap_04_F"],
		["MRX - All","Land_Volleyball_01_F"],
		["Fences - City","Land_Net_Fence_4m_F"],
		["Fences - City","Land_Net_Fence_8m_F"],
		["Fences - City","Land_Net_Fence_Gate_F"],
		["Fences - City","Land_Net_Fence_pole_F"],
		["Fences - City","Land_Net_FenceD_8m_F"],
		["Fences - City","Land_Pipe_fence_4m_F"],
		["Fences - City","Land_Pipe_fence_4mNoLC_F"],
		["Fences - City","Land_PipeWall_concretel_8m_F"],
		["Fences - City","Land_BackAlley_01_l_1m_F"],
		["Fences - City","Land_BackAlley_01_l_gap_F"],
		["Fences - City","Land_BackAlley_01_l_gate_F"],
		["Fences - City","Land_BackAlley_02_l_1m_F"],
		["Fences - Industrial","Land_IndFnc_3_D_F"],
		["Fences - Industrial","Land_IndFnc_3_F"],
		["Fences - Industrial","Land_IndFnc_3_Hole_F"],
		["Fences - Industrial","Land_IndFnc_9_F"],
		["Fences - Industrial","Land_IndFnc_Corner_F"],
		["Fences - Industrial","Land_IndFnc_Pole_F"],
		["Fences - Industrial","Land_NetFence_01_m_4m_F"],
		["Fences - Industrial","Land_NetFence_01_m_4m_noLC_F"],
		["Fences - Industrial","Land_NetFence_01_m_8m_F"],
		["Fences - Industrial","Land_NetFence_01_m_8m_noLC_F"],
		["Fences - Industrial","Land_NetFence_01_m_d_F"],
		["Fences - Industrial","Land_NetFence_01_m_d_noLC_F"],
		["Fences - Industrial","Land_NetFence_01_m_gate_F"],
		["Fences - Industrial","Land_NetFence_01_m_pole_F"],
		["Fences - Industrial","Land_VineyardFence_01_F"],
		["Fences - Military","Land_BagFence_Corner_F"],
		["Fences - Military","Land_BagFence_End_F"],
		["Fences - Military","Land_BagFence_Long_F"],
		["Fences - Military","Land_BagFence_Round_F"],
		["Fences - Military","Land_BagFence_Short_F"],
		["Fences - Military","Land_Razorwire_F"],
		["Fences - Military","Land_Mil_WiredFence_F"],
		["Fences - Military","Land_Mil_WiredFence_Gate_F"],
		["Fences - Military","Land_Mil_WiredFenceD_F"],
		["Fences - Military","Land_New_WiredFence_5m_F"],
		["Fences - Military","Land_New_WiredFence_10m_Dam_F"],
		["Fences - Military","Land_New_WiredFence_10m_F"],
		["Fences - Military","Land_New_WiredFence_pole_F"],
		["Fences - Military","Land_Wired_Fence_4m_F"],
		["Fences - Military","Land_Wired_Fence_4mD_F"],
		["Fences - Military","Land_Wired_Fence_8m_F"],
		["Fences - Military","Land_Wired_Fence_8mD_F"],
		["Fences - Sport and Recreation","Land_SportGround_fence_F"],
		["Fences - Sport and Recreation","Land_SportGround_fence_noLC_F"],
		["Structures - Airport","Land_NavigLight"],
		["Structures - Airport","Land_NavigLight_3_F"],
		["Structures - Airport","Land_Flush_Light_green_F"],
		["Structures - Airport","Land_Flush_Light_red_F"],
		["Structures - Airport","Land_Flush_Light_yellow_F"],
		["Structures - Airport","Land_runway_edgelight"],
		["Structures - Airport","Land_runway_edgelight_blue_F"],
		["Structures - Airport","Land_Runway_PAPI"],
		["Structures - Airport","Land_Runway_PAPI_2"],
		["Structures - Airport","Land_Runway_PAPI_3"],
		["Structures - Airport","Land_Runway_PAPI_4"],
		["Structures - Airport","Land_Airport_center_F"],
		["Structures - Airport","Land_Airport_left_F"],
		["Structures - Airport","Land_Airport_right_F"],
		["Structures - Airport","Land_Airport_Tower_F"],
		["Structures - Airport","Land_Airport_Tower_dam_F"],
		["Structures - Airport","Land_Hangar_F"],
		["Structures - Airport","Land_Radar_F"],
		["Structures - Airport","Land_Radar_Small_F"],
		["Structures - Airport","Land_TentHangar_V1_F"],
		["Structures - Airport","Land_TentHangar_V1_dam_F"],
		["Structures - Airport","Windsock_01_F"],
		["Structures - Airport","Land_Airport_01_controlTower_F"],
		["Structures - Airport","Land_Airport_01_hangar_F"],
		["Structures - Airport","Land_Airport_01_terminal_F"],
		["Structures - Airport","Land_Airport_02_controlTower_F"],
		["Structures - Airport","Land_Airport_02_hangar_left_F"],
		["Structures - Airport","Land_Airport_02_hangar_right_F"],
		["Structures - Airport","Land_Airport_02_terminal_F"],
		["Structures - Airport","Land_Airport_02_sign_aeroport_F"],
		["Structures - Airport","Land_Airport_02_sign_arrivees_F"],
		["Structures - Airport","Land_Airport_02_sign_de_F"],
		["Structures - Airport","Land_Airport_02_sign_departs_F"],
		["Structures - Airport","Land_Airport_02_sign_tanoa_F"],
		["Structures - Airport","Land_AirstripPlatform_01_F"],
		["Structures - Airport","Land_AirstripPlatform_01_footer_F"],
		["Structures - Airport","Land_NavigLight_3_short_F"],
		["Structures - Beach","Land_BeachBooth_01_F"],
		["Structures - Beach","Land_LifeguardTower_01_F"],
		["Structures - Cemetery","Land_Grave_memorial_F"],
		["Structures - Cemetery","Land_Grave_monument_F"],
		["Structures - Cemetery","Land_Grave_obelisk_F"],
		["Structures - Cemetery","Land_Grave_soldier_F"],
		["Structures - Cemetery","Land_Grave_V1_F"],
		["Structures - Cemetery","Land_Grave_V2_F"],
		["Structures - Cemetery","Land_Grave_V3_F"],
		["Structures - Cemetery","Land_Grave_dirt_F"],
		["Structures - Cemetery","Land_Grave_forest_F"],
		["Structures - Cemetery","Land_Grave_rocks_F"],
		["Structures - Cemetery","Land_Grave_01_F"],
		["Structures - Cemetery","Land_Grave_02_F"],
		["Structures - Cemetery","Land_Grave_03_F"],
		["Structures - Cemetery","Land_Grave_04_F"],
		["Structures - Cemetery","Land_Grave_05_F"],
		["Structures - Cemetery","Land_Grave_06_F"],
		["Structures - Cemetery","Land_Grave_07_F"],
		["Structures - Cemetery","Land_Tomb_01_F"],
		["Structures - Cemetery","Land_Tombstone_01_F"],
		["Structures - Cemetery","Land_Tombstone_02_F"],
		["Structures - Cemetery","Land_Tombstone_03_F"],
		["Structures - City","Land_TreeBin_F"],
		["Structures - City","Land_Water_source_F"],
		["Structures - City","Land_Offices_01_V1_F"],
		["Structures - City","Land_WIP_F"],
		["Structures - City","Land_i_House_Big_01_V1_F"],
		["Structures - City","Land_i_House_Big_01_V1_dam_F"],
		["Structures - City","Land_i_House_Big_01_V2_F"],
		["Structures - City","Land_i_House_Big_01_V2_dam_F"],
		["Structures - City","Land_i_House_Big_01_V3_F"],
		["Structures - City","Land_i_House_Big_01_V3_dam_F"],
		["Structures - City","Land_u_House_Big_01_V1_F"],
		["Structures - City","Land_u_House_Big_01_V1_dam_F"],
		["Structures - City","Land_d_House_Big_01_V1_F"],
		["Structures - City","Land_i_House_Big_02_V1_F"],
		["Structures - City","Land_i_House_Big_02_V1_dam_F"],
		["Structures - City","Land_i_House_Big_02_V2_F"],
		["Structures - City","Land_i_House_Big_02_V2_dam_F"],
		["Structures - City","Land_i_House_Big_02_V3_F"],
		["Structures - City","Land_i_House_Big_02_V3_dam_F"],
		["Structures - City","Land_u_House_Big_02_V1_F"],
		["Structures - City","Land_u_House_Big_02_V1_dam_F"],
		["Structures - City","Land_d_House_Big_02_V1_F"],
		["Structures - City","Land_i_Shop_01_V1_F"],
		["Structures - City","Land_i_Shop_01_V1_dam_F"],
		["Structures - City","Land_i_Shop_01_V2_F"],
		["Structures - City","Land_i_Shop_01_V2_dam_F"],
		["Structures - City","Land_i_Shop_01_V3_F"],
		["Structures - City","Land_i_Shop_01_V3_dam_F"],
		["Structures - City","Land_u_Shop_01_V1_F"],
		["Structures - City","Land_u_Shop_01_V1_dam_F"],
		["Structures - City","Land_d_Shop_01_V1_F"],
		["Structures - City","Land_i_Shop_02_V1_F"],
		["Structures - City","Land_i_Shop_02_V1_dam_F"],
		["Structures - City","Land_i_Shop_02_V2_F"],
		["Structures - City","Land_i_Shop_02_V2_dam_F"],
		["Structures - City","Land_i_Shop_02_V3_F"],
		["Structures - City","Land_i_Shop_02_V3_dam_F"],
		["Structures - City","Land_u_Shop_02_V1_F"],
		["Structures - City","Land_u_Shop_02_V1_dam_F"],
		["Structures - City","Land_d_Shop_02_V1_F"],
		["Structures - City","Land_i_House_Small_03_V1_F"],
		["Structures - City","Land_i_House_Small_03_V1_dam_F"],
		["Structures - City","Land_Unfinished_Building_01_F"],
		["Structures - City","Land_Unfinished_Building_02_F"],
		["Structures - City","Land_FireEscape_01_short_F"],
		["Structures - City","Land_FireEscape_01_tall_F"],
		["Structures - City","Land_Pot_01_F"],
		["Structures - City","Land_Pot_02_F"],
		["Structures - City","Land_House_Big_03_F"],
		["Structures - City","Land_House_Big_04_F"],
		["Structures - City","Land_House_Big_05_F"],
		["Structures - City","Land_House_Small_04_F"],
		["Structures - City","Land_House_Small_05_F"],
		["Structures - City","Land_School_01_F"],
		["Structures - City","Land_Addon_01_F"],
		["Structures - City","Land_Addon_02_F"],
		["Structures - City","Land_Addon_03_F"],
		["Structures - City","Land_Addon_04_F"],
		["Structures - City","Land_Addon_05_F"],
		["Structures - City","Land_SignMonolith_01_F"],
		["Structures - City","Land_MultistoryBuilding_01_F"],
		["Structures - City","Land_MultistoryBuilding_03_F"],
		["Structures - City","Land_MultistoryBuilding_04_F"],
		["Structures - City","Land_Shop_City_01_F"],
		["Structures - City","Land_Shop_City_02_F"],
		["Structures - City","Land_Shop_City_03_F"],
		["Structures - City","Land_Shop_City_04_F"],
		["Structures - City","Land_Shop_City_05_F"],
		["Structures - City","Land_Shop_City_06_F"],
		["Structures - City","Land_Shop_City_07_F"],
		["Structures - Construction Sites","Land_Timbers_F"],
		["Structures - Construction Sites","Land_Bricks_V1_F"],
		["Structures - Construction Sites","Land_Bricks_V2_F"],
		["Structures - Construction Sites","Land_Bricks_V3_F"],
		["Structures - Construction Sites","Land_Bricks_V4_F"],
		["Structures - Construction Sites","Land_CinderBlocks_F"],
		["Structures - Construction Sites","Land_Coil_F"],
		["Structures - Construction Sites","Land_ConcretePipe_F"],
		["Structures - Construction Sites","Land_Pallet_F"],
		["Structures - Construction Sites","Land_Pallet_vertical_F"],
		["Structures - Construction Sites","Land_Pipes_large_F"],
		["Structures - Construction Sites","Land_Pipes_small_F"],
		["Structures - Construction Sites","Land_WorkStand_F"],
		["Structures - Construction Sites","Land_Crane_F"],
		["Structures - Construction Sites","Land_MobileCrane_01_F"],
		["Structures - Construction Sites","Land_MobileCrane_01_hook_F"],
		["Structures - Historical","Land_AncientPillar_F"],
		["Structures - Historical","Land_AncientPillar_damaged_F"],
		["Structures - Historical","Land_AncientPillar_fallen_F"],
		["Structures - Historical","Land_Maroula_base_F"],
		["Structures - Historical","Land_Maroula_F"],
		["Structures - Historical","Land_MolonLabe_F"],
		["Structures - Historical","Land_Amphitheater_F"],
		["Structures - Historical","Land_Castle_01_wall_01_F"],
		["Structures - Historical","Land_Castle_01_wall_02_F"],
		["Structures - Historical","Land_Castle_01_wall_03_F"],
		["Structures - Historical","Land_Castle_01_wall_04_F"],
		["Structures - Historical","Land_Castle_01_wall_05_F"],
		["Structures - Historical","Land_Castle_01_wall_06_F"],
		["Structures - Historical","Land_Castle_01_wall_07_F"],
		["Structures - Historical","Land_Castle_01_wall_08_F"],
		["Structures - Historical","Land_Castle_01_wall_09_F"],
		["Structures - Historical","Land_Castle_01_wall_10_F"],
		["Structures - Historical","Land_Castle_01_wall_11_F"],
		["Structures - Historical","Land_Castle_01_wall_12_F"],
		["Structures - Historical","Land_Castle_01_wall_13_F"],
		["Structures - Historical","Land_Castle_01_wall_14_F"],
		["Structures - Historical","Land_Castle_01_wall_15_F"],
		["Structures - Historical","Land_Castle_01_wall_16_F"],
		["Structures - Historical","Land_Castle_01_house_ruin_F"],
		["Structures - Historical","Land_Castle_01_church_a_ruin_F"],
		["Structures - Historical","Land_Castle_01_church_b_ruin_F"],
		["Structures - Historical","Land_Castle_01_church_ruin_F"],
		["Structures - Historical","Land_Castle_01_step_F"],
		["Structures - Historical","Land_Castle_01_tower_F"],
		["Structures - Historical","Land_d_Windmill01_F"],
		["Structures - Historical","Land_i_Windmill01_F"],
		["Structures - Historical","Land_House_Native_01_F"],
		["Structures - Historical","Land_House_Native_02_F"],
		["Structures - Historical","Land_AncientHead_01_F"],
		["Structures - Historical","Land_AncientStatue_01_F"],
		["Structures - Historical","Land_AncientStatue_02_F"],
		["Structures - Historical","Land_PetroglyphWall_01_F"],
		["Structures - Historical","Land_PetroglyphWall_02_F"],
		["Structures - Historical","Land_RaiStone_01_F"],
		["Structures - Historical","Land_StoneTanoa_01_F"],
		["Structures - Historical","Land_BasaltKerb_01_2m_F"],
		["Structures - Historical","Land_BasaltKerb_01_2m_d_F"],
		["Structures - Historical","Land_BasaltKerb_01_4m_F"],
		["Structures - Historical","Land_BasaltKerb_01_pile_F"],
		["Structures - Historical","Land_BasaltKerb_01_platform_F"],
		["Structures - Historical","Land_BasaltWall_01_4m_F"],
		["Structures - Historical","Land_BasaltWall_01_8m_F"],
		["Structures - Historical","Land_BasaltWall_01_d_left_F"],
		["Structures - Historical","Land_BasaltWall_01_d_right_F"],
		["Structures - Historical","Land_BasaltWall_01_gate_F"],
		["Structures - Historical","Land_Fortress_01_5m_F"],
		["Structures - Historical","Land_Fortress_01_10m_F"],
		["Structures - Historical","Land_Fortress_01_bricks_v1_F"],
		["Structures - Historical","Land_Fortress_01_bricks_v2_F"],
		["Structures - Historical","Land_Fortress_01_cannon_F"],
		["Structures - Historical","Land_Fortress_01_d_L_F"],
		["Structures - Historical","Land_Fortress_01_d_R_F"],
		["Structures - Historical","Land_Fortress_01_innerCorner_70_F"],
		["Structures - Historical","Land_Fortress_01_innerCorner_90_F"],
		["Structures - Historical","Land_Fortress_01_innerCorner_110_F"],
		["Structures - Historical","Land_Fortress_01_outterCorner_50_F"],
		["Structures - Historical","Land_Fortress_01_outterCorner_80_F"],
		["Structures - Historical","Land_Fortress_01_outterCorner_90_F"],
		["Structures - Historical","Land_Temple_Native_01_F"],
		["Structures - Historical","Land_EmplacementGun_01_mossy_F"],
		["Structures - Historical","Land_EmplacementGun_01_rusty_F"],
		["Structures - Historical","Land_EmplacementGun_01_d_mossy_F"],
		["Structures - Historical","Land_EmplacementGun_01_d_rusty_F"],
		["Structures - Industrial","Land_cmp_Hopper_F"],
		["Structures - Industrial","Land_cmp_Shed_F"],
		["Structures - Industrial","Land_cmp_Shed_dam_F"],
		["Structures - Industrial","Land_cmp_Tower_F"],
		["Structures - Industrial","Land_dp_bigTank_F"],
		["Structures - Industrial","Land_dp_mainFactory_F"],
		["Structures - Industrial","Land_dp_smallFactory_F"],
		["Structures - Industrial","Land_dp_smallTank_F"],
		["Structures - Industrial","Land_dp_transformer_F"],
		["Structures - Industrial","Land_Factory_Conv1_10_F"],
		["Structures - Industrial","Land_Factory_Conv1_End_F"],
		["Structures - Industrial","Land_Factory_Conv1_Main_F"],
		["Structures - Industrial","Land_Factory_Conv2_F"],
		["Structures - Industrial","Land_Factory_Hopper_F"],
		["Structures - Industrial","Land_Factory_Main_F"],
		["Structures - Industrial","Land_Factory_Tunnel_F"],
		["Structures - Industrial","Land_Shed_Big_F"],
		["Structures - Industrial","Land_Shed_Small_F"],
		["Structures - Industrial","Land_i_Shed_Ind_F"],
		["Structures - Industrial","Land_u_Shed_Ind_F"],
		["Structures - Industrial","Land_Tank_rust_F"],
		["Structures - Industrial","Land_Warehouse_03_F"],
		["Structures - Industrial","Land_DPP_01_mainFactory_F"],
		["Structures - Industrial","Land_DPP_01_smallFactory_F"],
		["Structures - Industrial","Land_DPP_01_transformer_F"],
		["Structures - Industrial","Land_DPP_01_waterCooler_F"],
		["Structures - Industrial","Land_DPP_01_waterCooler_ladder_F"],
		["Structures - Industrial","Land_Walkover_01_F"],
		["Structures - Industrial","Land_SY_01_block_F"],
		["Structures - Industrial","Land_SY_01_conveyor_end_F"],
		["Structures - Industrial","Land_SY_01_conveyor_chute_F"],
		["Structures - Industrial","Land_SY_01_conveyor_junction_F"],
		["Structures - Industrial","Land_SY_01_conveyor_long_F"],
		["Structures - Industrial","Land_SY_01_conveyor_reclaimer_F"],
		["Structures - Industrial","Land_SY_01_conveyor_short_F"],
		["Structures - Industrial","Land_SY_01_conveyor_slope_F"],
		["Structures - Industrial","Land_SY_01_crusher_F"],
		["Structures - Industrial","Land_SY_01_reclaimer_F"],
		["Structures - Industrial","Land_SY_01_shiploader_arm_F"],
		["Structures - Industrial","Land_SY_01_shiploader_F"],
		["Structures - Industrial","Land_SY_01_stockpile_01_F"],
		["Structures - Industrial","Land_SY_01_stockpile_02_F"],
		["Structures - Industrial","Land_SY_01_tripper_F"],
		["Structures - Industrial","Land_SCF_01_boilerBuilding_F"],
		["Structures - Industrial","Land_SCF_01_clarifier_F"],
		["Structures - Industrial","Land_SCF_01_condenser_F"],
		["Structures - Industrial","Land_SCF_01_conveyor_8m_high_F"],
		["Structures - Industrial","Land_SCF_01_conveyor_16m_high_F"],
		["Structures - Industrial","Land_SCF_01_conveyor_16m_slope_F"],
		["Structures - Industrial","Land_SCF_01_conveyor_columnBase_F"],
		["Structures - Industrial","Land_SCF_01_conveyor_end_high_F"],
		["Structures - Industrial","Land_SCF_01_conveyor_hole_F"],
		["Structures - Industrial","Land_SCF_01_crystallizer_F"],
		["Structures - Industrial","Land_SCF_01_crystallizerTowers_F"],
		["Structures - Industrial","Land_SCF_01_diffuser_F"],
		["Structures - Industrial","Land_SCF_01_feeder_F"],
		["Structures - Industrial","Land_SCF_01_generalBuilding_F"],
		["Structures - Industrial","Land_SCF_01_heap_bagasse_F"],
		["Structures - Industrial","Land_SCF_01_heap_sugarcane_F"],
		["Structures - Industrial","Land_SCF_01_chimney_F"],
		["Structures - Industrial","Land_SCF_01_pipe_24m_high_F"],
		["Structures - Industrial","Land_SCF_01_pipe_24m_F"],
		["Structures - Industrial","Land_SCF_01_pipe_8m_high_F"],
		["Structures - Industrial","Land_SCF_01_pipe_8m_F"],
		["Structures - Industrial","Land_SCF_01_pipe_curve_high_F"],
		["Structures - Industrial","Land_SCF_01_pipe_curve_F"],
		["Structures - Industrial","Land_SCF_01_pipe_end_F"],
		["Structures - Industrial","Land_SCF_01_pipe_up_F"],
		["Structures - Industrial","Land_SCF_01_shed_F"],
		["Structures - Industrial","Land_SCF_01_shredder_F"],
		["Structures - Industrial","Land_SCF_01_storageBin_big_F"],
		["Structures - Industrial","Land_SCF_01_storageBin_medium_F"],
		["Structures - Industrial","Land_SCF_01_storageBin_small_F"],
		["Structures - Industrial","Land_SCF_01_warehouse_F"],
		["Structures - Industrial","Land_SCF_01_washer_F"],
		["Structures - Industrial","Land_SM_01_shed_F"],
		["Structures - Industrial","Land_SM_01_shed_unfinished_F"],
		["Structures - Industrial","Land_SM_01_shelter_narrow_F"],
		["Structures - Industrial","Land_SM_01_shelter_wide_F"],
		["Structures - Lamps","Land_LampAirport_F"],
		["Structures - Lamps","Land_LampDecor_F"],
		["Structures - Lamps","Land_LampHalogen_F"],
		["Structures - Lamps","Land_LampHarbour_F"],
		["Structures - Lamps","Land_LampShabby_F"],
		["Structures - Lamps","Land_LampSolar_F"],
		["Structures - Lamps","Land_LampStadium_F"],
		["Structures - Lamps","Land_LampStreet_F"],
		["Structures - Lamps","Land_LampStreet_small_F"],
		["Structures - Market","Land_WheelCart_F"],
		["Structures - Market","Land_MarketShelter_F"],
		["Structures - Market","Land_StallWater_F"],
		["Structures - Market","Land_ClothShelter_01_F"],
		["Structures - Market","Land_ClothShelter_02_F"],
		["Structures - Market","Land_MetalShelter_01_F"],
		["Structures - Market","Land_MetalShelter_02_F"],
		["Structures - Market","Land_WoodenShelter_01_F"],
		["Structures - Military","Land_BagBunker_Large_F"],
		["Structures - Military","Land_BagBunker_Small_F"],
		["Structures - Military","Land_BagBunker_Tower_F"],
		["Structures - Military","Land_i_Barracks_V1_F"],
		["Structures - Military","Land_i_Barracks_V1_dam_F"],
		["Structures - Military","Land_i_Barracks_V2_F"],
		["Structures - Military","Land_i_Barracks_V2_dam_F"],
		["Structures - Military","Land_u_Barracks_V2_F"],
		["Structures - Military","Land_Bunker_F"],
		["Structures - Military","Land_Cargo_House_V1_F"],
		["Structures - Military","Land_Cargo_House_V2_F"],
		["Structures - Military","Land_Cargo_House_V3_F"],
		["Structures - Military","Land_Cargo_HQ_V1_F"],
		["Structures - Military","Land_Cargo_HQ_V2_F"],
		["Structures - Military","Land_Cargo_HQ_V3_F"],
		["Structures - Military","Land_Cargo_Patrol_V1_F"],
		["Structures - Military","Land_Cargo_Patrol_V2_F"],
		["Structures - Military","Land_Cargo_Patrol_V3_F"],
		["Structures - Military","Land_Cargo_Tower_V1_F"],
		["Structures - Military","Land_Cargo_Tower_V1_No1_F"],
		["Structures - Military","Land_Cargo_Tower_V1_No2_F"],
		["Structures - Military","Land_Cargo_Tower_V1_No3_F"],
		["Structures - Military","Land_Cargo_Tower_V1_No4_F"],
		["Structures - Military","Land_Cargo_Tower_V1_No5_F"],
		["Structures - Military","Land_Cargo_Tower_V1_No6_F"],
		["Structures - Military","Land_Cargo_Tower_V1_No7_F"],
		["Structures - Military","Land_Cargo_Tower_V2_F"],
		["Structures - Military","Land_Cargo_Tower_V3_F"],
		["Structures - Military","Land_Medevac_house_V1_F"],
		["Structures - Military","Land_Medevac_HQ_V1_F"],
		["Structures - Military","Land_MilOffices_V1_F"],
		["Structures - Military","CamoNet_BLUFOR_F"],
		["Structures - Military","CamoNet_OPFOR_F"],
		["Structures - Military","CamoNet_INDP_F"],
		["Structures - Military","CamoNet_BLUFOR_open_F"],
		["Structures - Military","CamoNet_OPFOR_open_F"],
		["Structures - Military","CamoNet_INDP_open_F"],
		["Structures - Military","CamoNet_BLUFOR_big_F"],
		["Structures - Military","CamoNet_OPFOR_big_F"],
		["Structures - Military","CamoNet_INDP_big_F"],
		["Structures - Military","CamoNet_BLUFOR_Curator_F"],
		["Structures - Military","CamoNet_OPFOR_Curator_F"],
		["Structures - Military","CamoNet_INDP_Curator_F"],
		["Structures - Military","CamoNet_BLUFOR_open_Curator_F"],
		["Structures - Military","CamoNet_OPFOR_open_Curator_F"],
		["Structures - Military","CamoNet_INDP_open_Curator_F"],
		["Structures - Military","CamoNet_BLUFOR_big_Curator_F"],
		["Structures - Military","CamoNet_OPFOR_big_Curator_F"],
		["Structures - Military","CamoNet_INDP_big_Curator_F"],
		["Structures - Military","Land_Dome_Big_F"],
		["Structures - Military","Land_Dome_Small_F"],
		["Structures - Military","Land_Research_house_V1_F"],
		["Structures - Military","Land_Research_HQ_F"],
		["Structures - Military","ShootingPos_F"],
		["Structures - Military","Land_ShootingPos_F"],
		["Structures - Military","Bomb"],
		["Structures - Military","Land_StorageBladder_01_F"],
		["Structures - Military","StorageBladder_01_fuel_forest_F"],
		["Structures - Military","StorageBladder_01_fuel_sand_F"],
		["Structures - Military","Land_StorageBladder_02_F"],
		["Structures - Military","StorageBladder_02_water_forest_F"],
		["Structures - Military","StorageBladder_02_water_sand_F"],
		["Structures - Military","Land_ContainmentArea_01_F"],
		["Structures - Military","ContainmentArea_01_forest_F"],
		["Structures - Military","ContainmentArea_01_sand_F"],
		["Structures - Military","Land_ContainmentArea_02_F"],
		["Structures - Military","ContainmentArea_02_forest_F"],
		["Structures - Military","ContainmentArea_02_sand_F"],
		["Structures - Military","Land_IRMaskingCover_01_F"],
		["Structures - Military","Land_IRMaskingCover_02_F"],
		["Structures - Military","Land_Barracks_01_camo_F"],
		["Structures - Military","Land_Barracks_01_grey_F"],
		["Structures - Military","Land_Barracks_01_dilapidated_F"],
		["Structures - Military","CamoNet_ghex_F"],
		["Structures - Military","CamoNet_ghex_open_F"],
		["Structures - Military","CamoNet_ghex_big_F"],
		["Structures - Military","CamoNet_ghex_Curator_F"],
		["Structures - Military","CamoNet_ghex_open_Curator_F"],
		["Structures - Military","CamoNet_ghex_big_Curator_F"],
		["Structures - Military","Land_Cargo_House_V4_F"],
		["Structures - Military","Land_Cargo_HQ_V4_F"],
		["Structures - Military","Land_Cargo_Patrol_V4_F"],
		["Structures - Military","Land_Cargo_Tower_V4_F"],
		["Structures - Military","Land_BagBunker_01_large_green_F"],
		["Structures - Military","Land_BagBunker_01_small_green_F"],
		["Structures - Military","Land_BagFence_01_corner_green_F"],
		["Structures - Military","Land_BagFence_01_end_green_F"],
		["Structures - Military","Land_BagFence_01_long_green_F"],
		["Structures - Military","Land_BagFence_01_round_green_F"],
		["Structures - Military","Land_BagFence_01_short_green_F"],
		["Structures - Military","Land_HBarrier_01_big_4_green_F"],
		["Structures - Military","Land_HBarrier_01_big_tower_green_F"],
		["Structures - Military","Land_HBarrier_01_line_1_green_F"],
		["Structures - Military","Land_HBarrier_01_line_3_green_F"],
		["Structures - Military","Land_HBarrier_01_line_5_green_F"],
		["Structures - Military","Land_HBarrier_01_tower_green_F"],
		["Structures - Military","Land_HBarrier_01_wall_4_green_F"],
		["Structures - Military","Land_HBarrier_01_wall_6_green_F"],
		["Structures - Military","Land_HBarrier_01_wall_corner_green_F"],
		["Structures - Military","Land_HBarrier_01_wall_corridor_green_F"],
		["Structures - Military","Land_PillboxBunker_01_big_F"],
		["Structures - Military","Land_PillboxBunker_01_hex_F"],
		["Structures - Military","Land_PillboxBunker_01_rectangle_F"],
		["Structures - Military","Land_PillboxWall_01_3m_F"],
		["Structures - Military","Land_PillboxWall_01_3m_round_F"],
		["Structures - Military","Land_PillboxWall_01_6m_F"],
		["Structures - Military","Land_PillboxWall_01_6m_round_F"],
		["Structures - Military","Land_TrenchFrame_01_F"],
		["Structures - Military","Land_Trench_01_forest_F"],
		["Structures - Military","Land_Trench_01_grass_F"],
		["Structures - Military","Land_Mil_WallBig_debris_F"],
		["Structures - Obstacles","BlockConcrete_F"],
		["Structures - Obstacles","Dirthump_1_F"],
		["Structures - Obstacles","Dirthump_2_F"],
		["Structures - Obstacles","Dirthump_3_F"],
		["Structures - Obstacles","Dirthump_4_F"],
		["Structures - Obstacles","Land_Obstacle_Bridge_F"],
		["Structures - Obstacles","Land_Obstacle_Climb_F"],
		["Structures - Obstacles","Land_Obstacle_Crawl_F"],
		["Structures - Obstacles","Land_Obstacle_Cross_F"],
		["Structures - Obstacles","Land_Obstacle_Pass_F"],
		["Structures - Obstacles","Land_Obstacle_Ramp_F"],
		["Structures - Obstacles","Land_Obstacle_RunAround_F"],
		["Structures - Obstacles","Land_Obstacle_Saddle_F"],
		["Structures - Obstacles","Land_RampConcrete_F"],
		["Structures - Obstacles","Land_RampConcreteHigh_F"],
		["Structures - Obstacles","Land_CncShelter_F"],
		["Structures - Railways","Land_Track_01_3m_F"],
		["Structures - Railways","Land_Track_01_7deg_F"],
		["Structures - Railways","Land_Track_01_10m_F"],
		["Structures - Railways","Land_Track_01_15deg_F"],
		["Structures - Railways","Land_Track_01_20m_F"],
		["Structures - Railways","Land_Track_01_30deg_F"],
		["Structures - Railways","Land_Track_01_bridge_F"],
		["Structures - Railways","Land_Track_01_bumper_F"],
		["Structures - Railways","Land_Track_01_crossing_F"],
		["Structures - Railways","Land_Track_01_switch_F"],
		["Structures - Railways","Land_Track_01_turnout_left_F"],
		["Structures - Railways","Land_Track_01_turnout_right_F"],
		["Structures - Religious","Land_BellTower_01_V1_F"],
		["Structures - Religious","Land_BellTower_01_V2_F"],
		["Structures - Religious","Land_BellTower_02_V1_F"],
		["Structures - Religious","Land_BellTower_02_V2_F"],
		["Structures - Religious","Land_Calvary_01_V1_F"],
		["Structures - Religious","Land_Calvary_02_V1_F"],
		["Structures - Religious","Land_Calvary_02_V2_F"],
		["Structures - Religious","Land_Chapel_V1_F"],
		["Structures - Religious","Land_Chapel_V2_F"],
		["Structures - Religious","Land_Chapel_Small_V1_F"],
		["Structures - Religious","Land_Chapel_Small_V2_F"],
		["Structures - Religious","Land_Church_01_V1_F"],
		["Structures - Religious","Land_Cathedral_01_F"],
		["Structures - Religious","Land_Mausoleum_01_F"],
		["Structures - Religious","Land_Church_01_F"],
		["Structures - Religious","Land_Church_02_F"],
		["Structures - Religious","Land_Church_03_F"],
		["Structures - Seaport","Land_LightHouse_F"],
		["Structures - Seaport","Land_Lighthouse_small_F"],
		["Structures - Seaport","Land_BuoyBig_F"],
		["Structures - Seaport","Land_nav_pier_m_F"],
		["Structures - Seaport","Land_Pier_addon"],
		["Structures - Seaport","Land_Pier_Box_F"],
		["Structures - Seaport","Land_Pier_F"],
		["Structures - Seaport","Land_Pier_small_F"],
		["Structures - Seaport","Land_Pier_wall_F"],
		["Structures - Seaport","Land_PierLadder_F"],
		["Structures - Seaport","Land_Pillar_Pier_F"],
		["Structures - Seaport","Land_Sea_Wall_F"],
		["Structures - Seaport","C_Boat_Civil_04_F"],
		["Structures - Seaport","Submarine_01_F"],
		["Structures - Seaport","Land_ContainerCrane_01_F"],
		["Structures - Seaport","Land_ContainerCrane_01_arm_F"],
		["Structures - Seaport","Land_ContainerCrane_01_arm_lowered_F"],
		["Structures - Seaport","Land_CraneRail_01_F"],
		["Structures - Seaport","Land_DryDock_01_end_F"],
		["Structures - Seaport","Land_DryDock_01_middle_F"],
		["Structures - Seaport","Land_GantryCrane_01_F"],
		["Structures - Seaport","Land_GuardHouse_01_F"],
		["Structures - Seaport","Land_Canal_Dutch_01_15m_F"],
		["Structures - Seaport","Land_Canal_Dutch_01_bridge_F"],
		["Structures - Seaport","Land_Canal_Dutch_01_corner_F"],
		["Structures - Seaport","Land_Canal_Dutch_01_plate_F"],
		["Structures - Seaport","Land_Canal_Dutch_01_stairs_F"],
		["Structures - Seaport","Land_Breakwater_01_F"],
		["Structures - Seaport","Land_Breakwater_02_F"],
		["Structures - Seaport","Land_QuayConcrete_01_5m_ladder_F"],
		["Structures - Seaport","Land_QuayConcrete_01_20m_F"],
		["Structures - Seaport","Land_QuayConcrete_01_20m_wall_F"],
		["Structures - Seaport","Land_QuayConcrete_01_innerCorner_F"],
		["Structures - Seaport","Land_QuayConcrete_01_outterCorner_F"],
		["Structures - Seaport","Land_QuayConcrete_01_pier_F"],
		["Structures - Seaport","Land_PierConcrete_01_4m_ladders_F"],
		["Structures - Seaport","Land_PierConcrete_01_16m_F"],
		["Structures - Seaport","Land_PierConcrete_01_30deg_F"],
		["Structures - Seaport","Land_PierConcrete_01_end_F"],
		["Structures - Seaport","Land_PierConcrete_01_steps_F"],
		["Structures - Seaport","Land_PierWooden_01_10m_noRails_F"],
		["Structures - Seaport","Land_PierWooden_01_16m_F"],
		["Structures - Seaport","Land_PierWooden_01_dock_F"],
		["Structures - Seaport","Land_PierWooden_01_hut_F"],
		["Structures - Seaport","Land_PierWooden_01_ladder_F"],
		["Structures - Seaport","Land_PierWooden_01_platform_F"],
		["Structures - Seaport","Land_PierWooden_02_16m_F"],
		["Structures - Seaport","Land_PierWooden_02_30deg_F"],
		["Structures - Seaport","Land_PierWooden_02_barrel_F"],
		["Structures - Seaport","Land_PierWooden_02_hut_F"],
		["Structures - Seaport","Land_PierWooden_02_ladder_F"],
		["Structures - Seaport","Land_PierWooden_03_F"],
		["Structures - Services","Land_Hospital_main_F"],
		["Structures - Services","Land_Hospital_side1_F"],
		["Structures - Services","Land_Hospital_side2_F"],
		["Structures - Services","Land_CarService_F"],
		["Structures - Services","Land_FuelStation_Build_F"],
		["Structures - Services","Land_FuelStation_Feed_F"],
		["Structures - Services","Land_FuelStation_Shed_F"],
		["Structures - Services","Land_FuelStation_Sign_F"],
		["Structures - Services","Land_fs_feed_F"],
		["Structures - Services","Land_fs_price_F"],
		["Structures - Services","Land_fs_roof_F"],
		["Structures - Services","Land_fs_sign_F"],
		["Structures - Services","Land_PhoneBooth_01_F"],
		["Structures - Services","Land_PhoneBooth_02_F"],
		["Structures - Services","Land_Atm_01_F"],
		["Structures - Services","Land_Atm_02_F"],
		["Structures - Services","Land_Kiosk_blueking_F"],
		["Structures - Services","Land_Kiosk_gyros_F"],
		["Structures - Services","Land_Kiosk_papers_F"],
		["Structures - Services","Land_Kiosk_redburger_F"],
		["Structures - Services","Land_TouristShelter_01_F"],
		["Structures - Services","Land_GH_Gazebo_F"],
		["Structures - Services","Land_GH_House_1_F"],
		["Structures - Services","Land_GH_House_2_F"],
		["Structures - Services","Land_GH_MainBuilding_entry_F"],
		["Structures - Services","Land_GH_MainBuilding_left_F"],
		["Structures - Services","Land_GH_MainBuilding_middle_F"],
		["Structures - Services","Land_GH_MainBuilding_right_F"],
		["Structures - Services","Land_GH_Platform_F"],
		["Structures - Services","Land_GH_Pool_F"],
		["Structures - Services","Land_GH_Stairs_F"],
		["Structures - Services","Land_GarbageBin_02_F"],
		["Structures - Services","Land_FuelStation_01_arrow_F"],
		["Structures - Services","Land_FuelStation_01_prices_F"],
		["Structures - Services","Land_FuelStation_01_pump_F"],
		["Structures - Services","Land_FuelStation_01_roof_F"],
		["Structures - Services","Land_FuelStation_01_shop_F"],
		["Structures - Services","Land_FuelStation_01_workshop_F"],
		["Structures - Services","Land_FuelStation_02_prices_F"],
		["Structures - Services","Land_FuelStation_02_pump_F"],
		["Structures - Services","Land_FuelStation_02_roof_F"],
		["Structures - Services","Land_FuelStation_02_sign_F"],
		["Structures - Services","Land_FuelStation_02_workshop_F"],
		["Structures - Services","Land_Hotel_01_F"],
		["Structures - Services","Land_Hotel_02_F"],
		["Structures - Services","Land_Supermarket_01_F"],
		["Structures - Sport and Recreation","Land_Slide_F"],
		["Structures - Sport and Recreation","Land_BC_Basket_F"],
		["Structures - Sport and Recreation","Land_BC_Court_F"],
		["Structures - Sport and Recreation","Land_Goal_F"],
		["Structures - Sport and Recreation","Land_Tribune_F"],
		["Structures - Sport and Recreation","Land_SlideCastle_F"],
		["Structures - Sport and Recreation","Land_Carousel_01_F"],
		["Structures - Sport and Recreation","Land_Swing_01_F"],
		["Structures - Sport and Recreation","Land_Stadium_p1_F"],
		["Structures - Sport and Recreation","Land_Stadium_p2_F"],
		["Structures - Sport and Recreation","Land_Stadium_p3_F"],
		["Structures - Sport and Recreation","Land_Stadium_p4_F"],
		["Structures - Sport and Recreation","Land_Stadium_p5_F"],
		["Structures - Sport and Recreation","Land_Stadium_p6_F"],
		["Structures - Sport and Recreation","Land_Stadium_p7_F"],
		["Structures - Sport and Recreation","Land_Stadium_p8_F"],
		["Structures - Sport and Recreation","Land_Stadium_p9_F"],
		["Structures - Sport and Recreation","Land_FinishGate_01_narrow_F"],
		["Structures - Sport and Recreation","Land_FinishGate_01_wide_F"],
		["Structures - Sport and Recreation","Land_TyreBarrier_01_F"],
		["Structures - Sport and Recreation","TyreBarrier_01_black_F"],
		["Structures - Sport and Recreation","TyreBarrier_01_white_F"],
		["Structures - Sport and Recreation","Land_TyreBarrier_01_line_x4_F"],
		["Structures - Sport and Recreation","Land_TyreBarrier_01_line_x6_F"],
		["Structures - Sport and Recreation","Land_WinnersPodium_01_F"],
		["Structures - Sport and Recreation","Land_RugbyGoal_01_F"],
		["Structures - Storage","Land_WoodenBox_F"],
		["Structures - Storage","Land_ContainerLine_01_F"],
		["Structures - Storage","Land_ContainerLine_02_F"],
		["Structures - Storage","Land_ContainerLine_03_F"],
		["Structures - Storage","Land_StorageTank_01_large_F"],
		["Structures - Storage","Land_StorageTank_01_small_F"],
		["Structures - Storage","Land_Warehouse_01_F"],
		["Structures - Storage","Land_Warehouse_01_ladder_F"],
		["Structures - Storage","Land_Warehouse_02_F"],
		["Structures - Storage","Land_Warehouse_02_ladder_F"],
		["Structures - Storage","Land_WarehouseShelter_01_F"],
		["Structures - Transportation","Land_BridgeSea_01_pillar_F"],
		["Structures - Transportation","Land_BridgeWooden_01_pillar_F"],
		["Structures - Transportation","Land_ConcreteKerb_01_2m_F"],
		["Structures - Transportation","Land_ConcreteKerb_01_4m_F"],
		["Structures - Transportation","Land_ConcreteKerb_01_8m_F"],
		["Structures - Transportation","Land_ConcreteKerb_02_1m_F"],
		["Structures - Transportation","Land_ConcreteKerb_02_2m_F"],
		["Structures - Transportation","Land_ConcreteKerb_02_4m_F"],
		["Structures - Transportation","Land_ConcreteKerb_02_8m_F"],
		["Structures - Transportation","Land_ConcreteKerb_03_BW_long_F"],
		["Structures - Transportation","Land_ConcreteKerb_03_BW_short_F"],
		["Structures - Transportation","Land_ConcreteKerb_03_BY_long_F"],
		["Structures - Transportation","Land_ConcreteKerb_03_BY_short_F"],
		["Structures - Transportation","Land_GardenPavement_01_F"],
		["Structures - Transportation","Land_GardenPavement_02_F"],
		["Structures - Transportation","Land_KerbIsland_01_start_F"],
		["Structures - Transportation","Land_KerbIsland_01_end_F"],
		["Structures - Transportation","Land_Sidewalk_01_4m_F"],
		["Structures - Transportation","Land_Sidewalk_01_8m_F"],
		["Structures - Transportation","Land_Sidewalk_01_corner_F"],
		["Structures - Transportation","Land_Sidewalk_01_narrow_2m_F"],
		["Structures - Transportation","Land_Sidewalk_01_narrow_4m_F"],
		["Structures - Transportation","Land_Sidewalk_01_narrow_8m_F"],
		["Structures - Transportation","Land_Sidewalk_02_4m_F"],
		["Structures - Transportation","Land_Sidewalk_02_8m_F"],
		["Structures - Transportation","Land_Sidewalk_02_corner_F"],
		["Structures - Transportation","Land_Sidewalk_02_narrow_2m_F"],
		["Structures - Transportation","Land_Sidewalk_02_narrow_4m_F"],
		["Structures - Transportation","Land_Sidewalk_02_narrow_8m_F"],
		["Structures - Utilities","Land_Loudspeakers_F"],
		["Structures - Utilities","Land_IndPipe1_20m_F"],
		["Structures - Utilities","Land_IndPipe1_90degL_F"],
		["Structures - Utilities","Land_IndPipe1_90degR_F"],
		["Structures - Utilities","Land_IndPipe1_ground_F"],
		["Structures - Utilities","Land_IndPipe1_Uup_F"],
		["Structures - Utilities","Land_IndPipe1_valve_F"],
		["Structures - Utilities","Land_IndPipe2_big_9_F"],
		["Structures - Utilities","Land_IndPipe2_big_18_F"],
		["Structures - Utilities","Land_IndPipe2_big_18ladder_F"],
		["Structures - Utilities","Land_IndPipe2_big_ground1_F"],
		["Structures - Utilities","Land_IndPipe2_big_ground2_F"],
		["Structures - Utilities","Land_IndPipe2_big_support_F"],
		["Structures - Utilities","Land_IndPipe2_bigL_L_F"],
		["Structures - Utilities","Land_IndPipe2_bigL_R_F"],
		["Structures - Utilities","Land_IndPipe2_Small_9_F"],
		["Structures - Utilities","Land_IndPipe2_Small_ground1_F"],
		["Structures - Utilities","Land_IndPipe2_Small_ground2_F"],
		["Structures - Utilities","Land_IndPipe2_SmallL_L_F"],
		["Structures - Utilities","Land_IndPipe2_SmallL_R_F"],
		["Structures - Utilities","Land_HighVoltageColumn_F"],
		["Structures - Utilities","Land_HighVoltageColumnWire_F"],
		["Structures - Utilities","Land_HighVoltageEnd_F"],
		["Structures - Utilities","Land_HighVoltageTower_dam_F"],
		["Structures - Utilities","Land_HighVoltageTower_F"],
		["Structures - Utilities","Land_HighVoltageTower_large_F"],
		["Structures - Utilities","Land_HighVoltageTower_largeCorner_F"],
		["Structures - Utilities","Land_PowerCable_submarine_F"],
		["Structures - Utilities","Land_PowerLine_distributor_F"],
		["Structures - Utilities","Land_PowerLine_part_F"],
		["Structures - Utilities","Land_PowerPoleConcrete_F"],
		["Structures - Utilities","Land_PowerPoleWooden_F"],
		["Structures - Utilities","Land_PowerPoleWooden_L_off_F"],
		["Structures - Utilities","Land_PowerPoleWooden_L_F"],
		["Structures - Utilities","Land_PowerPoleWooden_small_F"],
		["Structures - Utilities","Land_PowerWireBig_direct_F"],
		["Structures - Utilities","Land_PowerWireBig_direct_short_F"],
		["Structures - Utilities","Land_PowerWireBig_end_F"],
		["Structures - Utilities","Land_PowerWireBig_left_F"],
		["Structures - Utilities","Land_PowerWireBig_right_F"],
		["Structures - Utilities","Land_PowerWireSmall_damaged_F"],
		["Structures - Utilities","Land_PowerWireSmall_direct_F"],
		["Structures - Utilities","Land_PowerWireSmall_Left_F"],
		["Structures - Utilities","Land_PowerWireSmall_Right_F"],
		["Structures - Utilities","Land_PowLines_Transformer_F"],
		["Structures - Utilities","Land_ReservoirTank_Airport_F"],
		["Structures - Utilities","Land_ReservoirTank_Rust_F"],
		["Structures - Utilities","Land_ReservoirTank_V1_F"],
		["Structures - Utilities","Land_ReservoirTower_F"],
		["Structures - Utilities","Land_SolarPanel_1_F"],
		["Structures - Utilities","Land_SolarPanel_2_F"],
		["Structures - Utilities","Land_SolarPanel_3_F"],
		["Structures - Utilities","Land_spp_Mirror_Broken_F"],
		["Structures - Utilities","Land_spp_Mirror_F"],
		["Structures - Utilities","Land_spp_Panel_Broken_F"],
		["Structures - Utilities","Land_spp_Panel_F"],
		["Structures - Utilities","Land_spp_Tower_F"],
		["Structures - Utilities","Land_spp_Tower_dam_F"],
		["Structures - Utilities","Land_spp_Transformer_F"],
		["Structures - Utilities","Land_Communication_anchor_F"],
		["Structures - Utilities","Land_Communication_F"],
		["Structures - Utilities","Land_TBox_F"],
		["Structures - Utilities","Land_TTowerBig_1_F"],
		["Structures - Utilities","Land_TTowerBig_2_F"],
		["Structures - Utilities","Land_TTowerSmall_1_F"],
		["Structures - Utilities","Land_TTowerSmall_2_F"],
		["Structures - Utilities","Land_WavePowerPlant_F"],
		["Structures - Utilities","Land_WavePowerPlantBroken_F"],
		["Structures - Utilities","Land_PowerGenerator_F"],
		["Structures - Utilities","Land_wpp_Turbine_V1_F"],
		["Structures - Utilities","Land_wpp_Turbine_V2_F"],
		["Structures - Utilities","Land_ConcreteWell_01_F"],
		["Structures - Utilities","Land_SM_01_reservoirTower_F"],
		["Structures - Utilities","Land_PowerLine_01_pole_end_v1_F"],
		["Structures - Utilities","Land_PowerLine_01_pole_end_v2_F"],
		["Structures - Utilities","Land_PowerLine_01_pole_junction_F"],
		["Structures - Utilities","Land_PowerLine_01_pole_lamp_F"],
		["Structures - Utilities","Land_PowerLine_01_pole_lamp_off_F"],
		["Structures - Utilities","Land_PowerLine_01_pole_small_F"],
		["Structures - Utilities","Land_PowerLine_01_pole_tall_F"],
		["Structures - Utilities","Land_PowerLine_01_pole_transformer_F"],
		["Structures - Utilities","Land_PowerLine_01_wire_50m_F"],
		["Structures - Utilities","Land_PowerLine_01_wire_50m_main_F"],
		["Structures - Utilities","Land_SewerCover_01_F"],
		["Structures - Utilities","Land_SewerCover_02_F"],
		["Structures - Utilities","Land_SewerCover_03_F"],
		["Structures - Utilities","Land_WaterTank_01_F"],
		["Structures - Utilities","Land_WaterTank_02_F"],
		["Structures - Utilities","Land_WaterTank_03_F"],
		["Structures - Utilities","Land_WaterTank_04_F"],
		["Structures - Utilities","Land_WaterTower_01_F"],
		["Structures - Utilities","Land_WindmillPump_01_F"],
		["Structures - Village","Land_Pavement_narrow_corner_F"],
		["Structures - Village","Land_Pavement_narrow_F"],
		["Structures - Village","Land_Pavement_wide_corner_F"],
		["Structures - Village","Land_Pavement_wide_F"],
		["Structures - Village","Land_u_Addon_01_V1_F"],
		["Structures - Village","Land_u_Addon_01_V1_dam_F"],
		["Structures - Village","Land_d_Addon_02_V1_F"],
		["Structures - Village","Land_u_Addon_02_V1_F"],
		["Structures - Village","Land_i_Addon_02_V1_F"],
		["Structures - Village","Land_i_Addon_03_V1_F"],
		["Structures - Village","Land_i_Addon_03mid_V1_F"],
		["Structures - Village","Land_i_Addon_04_V1_F"],
		["Structures - Village","Land_i_Garage_V1_F"],
		["Structures - Village","Land_i_Garage_V1_dam_F"],
		["Structures - Village","Land_i_Garage_V2_F"],
		["Structures - Village","Land_i_Garage_V2_dam_F"],
		["Structures - Village","Land_Metal_Shed_F"],
		["Structures - Village","Land_i_House_Small_01_V1_F"],
		["Structures - Village","Land_i_House_Small_01_V1_dam_F"],
		["Structures - Village","Land_i_House_Small_01_V2_F"],
		["Structures - Village","Land_i_House_Small_01_V2_dam_F"],
		["Structures - Village","Land_i_House_Small_01_V3_F"],
		["Structures - Village","Land_i_House_Small_01_V3_dam_F"],
		["Structures - Village","Land_u_House_Small_01_V1_F"],
		["Structures - Village","Land_u_House_Small_01_V1_dam_F"],
		["Structures - Village","Land_d_House_Small_01_V1_F"],
		["Structures - Village","Land_i_House_Small_02_V1_F"],
		["Structures - Village","Land_i_House_Small_02_V1_dam_F"],
		["Structures - Village","Land_i_House_Small_02_V2_F"],
		["Structures - Village","Land_i_House_Small_02_V2_dam_F"],
		["Structures - Village","Land_i_House_Small_02_V3_F"],
		["Structures - Village","Land_i_House_Small_02_V3_dam_F"],
		["Structures - Village","Land_u_House_Small_02_V1_F"],
		["Structures - Village","Land_u_House_Small_02_V1_dam_F"],
		["Structures - Village","Land_d_House_Small_02_V1_F"],
		["Structures - Village","Land_cargo_addon01_V1_F"],
		["Structures - Village","Land_cargo_addon01_V2_F"],
		["Structures - Village","Land_cargo_addon02_V1_F"],
		["Structures - Village","Land_cargo_addon02_V2_F"],
		["Structures - Village","Land_cargo_house_slum_F"],
		["Structures - Village","Land_Slum_House01_F"],
		["Structures - Village","Land_Slum_House02_F"],
		["Structures - Village","Land_Slum_House03_F"],
		["Structures - Village","Land_i_Stone_HouseBig_V1_F"],
		["Structures - Village","Land_i_Stone_HouseBig_V1_dam_F"],
		["Structures - Village","Land_i_Stone_HouseBig_V2_F"],
		["Structures - Village","Land_i_Stone_HouseBig_V2_dam_F"],
		["Structures - Village","Land_i_Stone_HouseBig_V3_F"],
		["Structures - Village","Land_i_Stone_HouseBig_V3_dam_F"],
		["Structures - Village","Land_d_Stone_HouseBig_V1_F"],
		["Structures - Village","Land_i_Stone_Shed_V1_F"],
		["Structures - Village","Land_i_Stone_Shed_V1_dam_F"],
		["Structures - Village","Land_i_Stone_Shed_V2_F"],
		["Structures - Village","Land_i_Stone_Shed_V2_dam_F"],
		["Structures - Village","Land_i_Stone_Shed_V3_F"],
		["Structures - Village","Land_i_Stone_Shed_V3_dam_F"],
		["Structures - Village","Land_d_Stone_Shed_V1_F"],
		["Structures - Village","Land_i_Stone_HouseSmall_V1_F"],
		["Structures - Village","Land_i_Stone_HouseSmall_V1_dam_F"],
		["Structures - Village","Land_i_Stone_HouseSmall_V2_F"],
		["Structures - Village","Land_i_Stone_HouseSmall_V2_dam_F"],
		["Structures - Village","Land_i_Stone_HouseSmall_V3_F"],
		["Structures - Village","Land_i_Stone_HouseSmall_V3_dam_F"],
		["Structures - Village","Land_d_Stone_HouseSmall_V1_F"],
		["Structures - Village","Land_Boat_03_abandoned_cover_F"],
		["Structures - Village","Land_ClothesLine_01_F"],
		["Structures - Village","Land_ClothesLine_01_full_F"],
		["Structures - Village","Land_ClothesLine_01_short_F"],
		["Structures - Village","Land_ConcreteBlock_01_F"],
		["Structures - Village","Land_PicnicTable_01_F"],
		["Structures - Village","Land_GarageShelter_01_F"],
		["Structures - Village","Land_House_Big_01_F"],
		["Structures - Village","Land_House_Big_02_F"],
		["Structures - Village","Land_House_Small_01_F"],
		["Structures - Village","Land_House_Small_02_F"],
		["Structures - Village","Land_House_Small_03_F"],
		["Structures - Village","Land_House_Small_06_F"],
		["Structures - Village","Land_Shed_01_F"],
		["Structures - Village","Land_Shed_02_F"],
		["Structures - Village","Land_Shed_03_F"],
		["Structures - Village","Land_Shed_04_F"],
		["Structures - Village","Land_Shed_05_F"],
		["Structures - Village","Land_Shed_06_F"],
		["Structures - Village","Land_Shed_07_F"],
		["Structures - Village","Land_Slum_01_F"],
		["Structures - Village","Land_Slum_02_F"],
		["Structures - Village","Land_Slum_03_F"],
		["Structures - Village","Land_Slum_04_F"],
		["Structures - Village","Land_Slum_05_F"],
		["Structures - Village","Land_Shop_Town_01_F"],
		["Structures - Village","Land_Shop_Town_02_F"],
		["Structures - Village","Land_Shop_Town_03_F"],
		["Structures - Village","Land_Shop_Town_04_F"],
		["Structures - Village","Land_Shop_Town_05_F"],
		["Structures - Village","Land_Shop_Town_05_addon_F"],
		["Walls - City","Land_Canal_Wall_10m_F"],
		["Walls - City","Land_Canal_Wall_D_center_F"],
		["Walls - City","Land_Canal_Wall_D_left_F"],
		["Walls - City","Land_Canal_Wall_D_right_F"],
		["Walls - City","Land_Canal_Wall_Stairs_F"],
		["Walls - City","Land_Canal_WallSmall_10m_F"],
		["Walls - City","Land_City_4m_F"],
		["Walls - City","Land_City_8m_F"],
		["Walls - City","Land_City_8mD_F"],
		["Walls - City","Land_City_Gate_F"],
		["Walls - City","Land_City_Pillar_F"],
		["Walls - City","Land_City2_4m_F"],
		["Walls - City","Land_City2_8m_F"],
		["Walls - City","Land_City2_8mD_F"],
		["Walls - City","Land_City2_PillarD_F"],
		["Walls - City","Land_Mil_ConcreteWall_F"],
		["Walls - City","Land_ConcreteWall_01_l_4m_F"],
		["Walls - City","Land_ConcreteWall_01_l_8m_F"],
		["Walls - City","Land_ConcreteWall_01_l_d_F"],
		["Walls - City","Land_ConcreteWall_01_l_gate_F"],
		["Walls - City","Land_ConcreteWall_01_l_pole_F"],
		["Walls - City","Land_ConcreteWall_01_m_4m_F"],
		["Walls - City","Land_ConcreteWall_01_m_8m_F"],
		["Walls - City","Land_ConcreteWall_01_m_d_F"],
		["Walls - City","Land_ConcreteWall_01_m_gate_F"],
		["Walls - City","Land_ConcreteWall_01_m_pole_F"],
		["Walls - City","Land_ConcreteWall_02_m_2m_F"],
		["Walls - City","Land_ConcreteWall_02_m_4m_F"],
		["Walls - City","Land_ConcreteWall_02_m_8m_F"],
		["Walls - City","Land_ConcreteWall_02_m_d_F"],
		["Walls - City","Land_ConcreteWall_02_m_gate_F"],
		["Walls - City","Land_ConcreteWall_02_m_pole_F"],
		["Walls - City","Land_Hedge_01_s_2m_F"],
		["Walls - City","Land_Hedge_01_s_4m_F"],
		["Walls - City","Land_NetFence_02_m_2m_F"],
		["Walls - City","Land_NetFence_02_m_4m_F"],
		["Walls - City","Land_NetFence_02_m_8m_F"],
		["Walls - City","Land_NetFence_02_m_d_F"],
		["Walls - City","Land_NetFence_02_m_gate_v1_F"],
		["Walls - City","Land_NetFence_02_m_gate_v2_F"],
		["Walls - City","Land_NetFence_02_m_pole_F"],
		["Walls - City","Land_PipeFence_01_m_2m_F"],
		["Walls - City","Land_PipeFence_01_m_4m_F"],
		["Walls - City","Land_PipeFence_01_m_8m_F"],
		["Walls - City","Land_PipeFence_01_m_d_F"],
		["Walls - City","Land_PipeFence_01_m_gate_v1_F"],
		["Walls - City","Land_PipeFence_01_m_gate_v2_F"],
		["Walls - City","Land_PipeFence_01_m_pole_F"],
		["Walls - City","Land_WallCity_01_4m_blue_F"],
		["Walls - City","Land_WallCity_01_4m_grey_F"],
		["Walls - City","Land_WallCity_01_4m_pink_F"],
		["Walls - City","Land_WallCity_01_4m_whiteblue_F"],
		["Walls - City","Land_WallCity_01_4m_yellow_F"],
		["Walls - City","Land_WallCity_01_4m_plain_blue_F"],
		["Walls - City","Land_WallCity_01_4m_plain_grey_F"],
		["Walls - City","Land_WallCity_01_4m_plain_pink_F"],
		["Walls - City","Land_WallCity_01_4m_plain_whiteblue_F"],
		["Walls - City","Land_WallCity_01_4m_plain_yellow_F"],
		["Walls - City","Land_WallCity_01_4m_plain_dmg_blue_F"],
		["Walls - City","Land_WallCity_01_4m_plain_dmg_grey_F"],
		["Walls - City","Land_WallCity_01_4m_plain_dmg_pink_F"],
		["Walls - City","Land_WallCity_01_4m_plain_dmg_whiteblue_F"],
		["Walls - City","Land_WallCity_01_4m_plain_dmg_yellow_F"],
		["Walls - City","Land_WallCity_01_8m_blue_F"],
		["Walls - City","Land_WallCity_01_8m_grey_F"],
		["Walls - City","Land_WallCity_01_8m_pink_F"],
		["Walls - City","Land_WallCity_01_8m_whiteblue_F"],
		["Walls - City","Land_WallCity_01_8m_yellow_F"],
		["Walls - City","Land_WallCity_01_8m_dmg_blue_F"],
		["Walls - City","Land_WallCity_01_8m_dmg_grey_F"],
		["Walls - City","Land_WallCity_01_8m_dmg_pink_F"],
		["Walls - City","Land_WallCity_01_8m_dmg_whiteblue_F"],
		["Walls - City","Land_WallCity_01_8m_dmg_yellow_F"],
		["Walls - City","Land_WallCity_01_8m_plain_blue_F"],
		["Walls - City","Land_WallCity_01_8m_plain_grey_F"],
		["Walls - City","Land_WallCity_01_8m_plain_pink_F"],
		["Walls - City","Land_WallCity_01_8m_plain_whiteblue_F"],
		["Walls - City","Land_WallCity_01_8m_plain_yellow_F"],
		["Walls - City","Land_WallCity_01_gate_blue_F"],
		["Walls - City","Land_WallCity_01_gate_grey_F"],
		["Walls - City","Land_WallCity_01_gate_pink_F"],
		["Walls - City","Land_WallCity_01_gate_whiteblue_F"],
		["Walls - City","Land_WallCity_01_gate_yellow_F"],
		["Walls - City","Land_WallCity_01_pillar_blue_F"],
		["Walls - City","Land_WallCity_01_pillar_grey_F"],
		["Walls - City","Land_WallCity_01_pillar_pink_F"],
		["Walls - City","Land_WallCity_01_pillar_whiteblue_F"],
		["Walls - City","Land_WallCity_01_pillar_yellow_F"],
		["Walls - City","Land_WallCity_01_pillar_plain_dmg_blue_F"],
		["Walls - City","Land_WallCity_01_pillar_plain_dmg_grey_F"],
		["Walls - City","Land_WallCity_01_pillar_plain_dmg_pink_F"],
		["Walls - City","Land_WallCity_01_pillar_plain_dmg_whiteblue_F"],
		["Walls - City","Land_WallCity_01_pillar_plain_dmg_yellow_F"],
		["Walls - City","Land_ConcreteWall_01_l_gate_closed_F"],
		["Walls - City","Land_ConcreteWall_01_m_gate_closed_F"],
		["Walls - City","Land_NetFence_02_m_gate_v1_closed_F"],
		["Walls - City","Land_NetFence_02_m_gate_v2_closed_F"],
		["Walls - City","Land_PipeFence_01_m_gate_v1_closed_F"],
		["Walls - City","Land_PipeFence_01_m_gate_v2_closed_F"],
		["Walls - Historical","Land_Ancient_Wall_4m_F"],
		["Walls - Historical","Land_Ancient_Wall_8m_F"],
		["Walls - Industrial","Land_Wall_IndCnc_2deco_F"],
		["Walls - Industrial","Land_Wall_IndCnc_4_D_F"],
		["Walls - Industrial","Land_Wall_IndCnc_4_F"],
		["Walls - Industrial","Land_Wall_IndCnc_End_2_F"],
		["Walls - Industrial","Land_Wall_IndCnc_Pole_F"],
		["Walls - Industrial","Land_Wall_Tin_4"],
		["Walls - Industrial","Land_Wall_Tin_4_2"],
		["Walls - Industrial","Land_Wall_Tin_Pole"],
		["Walls - Industrial","Land_TinWall_02_l_4m_F"],
		["Walls - Industrial","Land_TinWall_02_l_8m_F"],
		["Walls - Industrial","Land_TinWall_02_l_pole_F"],
		["Walls - Industrial","Land_WiredFence_01_4m_F"],
		["Walls - Industrial","Land_WiredFence_01_8m_d_F"],
		["Walls - Industrial","Land_WiredFence_01_8m_F"],
		["Walls - Industrial","Land_WiredFence_01_16m_F"],
		["Walls - Industrial","Land_WiredFence_01_gate_F"],
		["Walls - Industrial","Land_WiredFence_01_pole_45_F"],
		["Walls - Industrial","Land_WiredFence_01_pole_F"],
		["Walls - Military","Land_HBarrier_1_F"],
		["Walls - Military","Land_HBarrier_3_F"],
		["Walls - Military","Land_HBarrier_5_F"],
		["Walls - Military","Land_HBarrierBig_F"],
		["Walls - Military","Land_HBarrier_Big_F"],
		["Walls - Military","Land_HBarrierTower_F"],
		["Walls - Military","Land_HBarrierWall_corner_F"],
		["Walls - Military","Land_HBarrierWall_corridor_F"],
		["Walls - Military","Land_HBarrierWall4_F"],
		["Walls - Military","Land_HBarrierWall6_F"],
		["Walls - Military","Land_BarGate_F"],
		["Walls - Military","Land_Mil_WallBig_4m_F"],
		["Walls - Military","Land_Mil_WallBig_Corner_F"],
		["Walls - Military","Land_Mil_WallBig_Gate_F"],
		["Walls - Military","Land_BarGate_01_open_F"],
		["Walls - Military","Land_Mil_WallBig_4m_battered_F"],
		["Walls - Military","Land_Mil_WallBig_corner_battered_F"],
		["Walls - Military","Land_Mil_WallBig_4m_damaged_center_F"],
		["Walls - Military","Land_Mil_WallBig_4m_damaged_left_F"],
		["Walls - Military","Land_Mil_WallBig_4m_damaged_right_F"],
		["Walls - Obstacles","Land_CncBarrier_F"],
		["Walls - Obstacles","Land_CncBarrier_stripes_F"],
		["Walls - Obstacles","Land_CncBarrierMedium_F"],
		["Walls - Obstacles","Land_CncBarrierMedium4_F"],
		["Walls - Obstacles","Land_CncWall1_F"],
		["Walls - Obstacles","Land_CncWall4_F"],
		["Walls - Obstacles","Land_Concrete_SmallWall_4m_F"],
		["Walls - Obstacles","Land_Concrete_SmallWall_8m_F"],
		["Walls - Obstacles","Land_Rampart_F"],
		["Walls - Shoot House","Land_Shoot_House_Wall_F"],
		["Walls - Shoot House","Land_Shoot_House_Wall_Stand_F"],
		["Walls - Shoot House","Land_Shoot_House_Wall_Crouch_F"],
		["Walls - Shoot House","Land_Shoot_House_Wall_Prone_F"],
		["Walls - Shoot House","Land_Shoot_House_Wall_Long_F"],
		["Walls - Shoot House","Land_Shoot_House_Wall_Long_Stand_F"],
		["Walls - Shoot House","Land_Shoot_House_Wall_Long_Crouch_F"],
		["Walls - Shoot House","Land_Shoot_House_Wall_Long_Prone_F"],
		["Walls - Shoot House","Land_Shoot_House_Corner_F"],
		["Walls - Shoot House","Land_Shoot_House_Corner_Stand_F"],
		["Walls - Shoot House","Land_Shoot_House_Corner_Crouch_F"],
		["Walls - Shoot House","Land_Shoot_House_Corner_Prone_F"],
		["Walls - Shoot House","Land_Shoot_House_Panels_F"],
		["Walls - Shoot House","Land_Shoot_House_Panels_Crouch_F"],
		["Walls - Shoot House","Land_Shoot_House_Panels_Prone_F"],
		["Walls - Shoot House","Land_Shoot_House_Panels_Vault_F"],
		["Walls - Shoot House","Land_Shoot_House_Panels_Window_F"],
		["Walls - Shoot House","Land_Shoot_House_Panels_Windows_F"],
		["Walls - Shoot House","Land_Shoot_House_Tunnel_F"],
		["Walls - Shoot House","Land_Shoot_House_Tunnel_Stand_F"],
		["Walls - Shoot House","Land_Shoot_House_Tunnel_Crouch_F"],
		["Walls - Shoot House","Land_Shoot_House_Tunnel_Prone_F"],
		["Walls - Transportation","Land_Crash_barrier_F"],
		["Walls - Transportation","Land_CrashBarrier_01_end_L_F"],
		["Walls - Transportation","Land_CrashBarrier_01_end_R_F"],
		["Walls - Transportation","Land_CrashBarrier_01_4m_F"],
		["Walls - Transportation","Land_CrashBarrier_01_8m_F"],
		["Walls - Transportation","Land_PipeFence_02_s_4m_F"],
		["Walls - Transportation","Land_PipeFence_02_s_4m_noLC_F"],
		["Walls - Transportation","Land_PipeFence_02_s_8m_F"],
		["Walls - Transportation","Land_PipeFence_02_s_8m_noLC_F"],
		["Walls - Transportation","Land_GuardRailing_01_F"],
		["Walls - Village","Land_Mound01_8m_F"],
		["Walls - Village","Land_Mound02_8m_F"],
		["Walls - Village","Land_Slums01_8m"],
		["Walls - Village","Land_Slums01_pole"],
		["Walls - Village","Land_Slums02_4m"],
		["Walls - Village","Land_Slums02_pole"],
		["Walls - Village","Land_Stone_4m_F"],
		["Walls - Village","Land_Stone_8m_F"],
		["Walls - Village","Land_Stone_8mD_F"],
		["Walls - Village","Land_Stone_Gate_F"],
		["Walls - Village","Land_Stone_pillar_F"],
		["Walls - Village","Land_BambooFence_01_s_4m_F"],
		["Walls - Village","Land_BambooFence_01_s_8m_F"],
		["Walls - Village","Land_BambooFence_01_s_d_F"],
		["Walls - Village","Land_BambooFence_01_s_pole_F"],
		["Walls - Village","Land_PoleWall_01_pole_F"],
		["Walls - Village","Land_PoleWall_01_3m_F"],
		["Walls - Village","Land_PoleWall_01_6m_F"],
		["Walls - Village","Land_SlumWall_01_s_2m_F"],
		["Walls - Village","Land_SlumWall_01_s_4m_F"],
		["Walls - Village","Land_StoneWall_01_s_10m_F"],
		["Walls - Village","Land_StoneWall_01_s_d_F"],
		["Walls - Village","Land_TinWall_01_m_4m_v1_F"],
		["Walls - Village","Land_TinWall_01_m_4m_v2_F"],
		["Walls - Village","Land_TinWall_01_m_gate_v1_F"],
		["Walls - Village","Land_TinWall_01_m_gate_v2_F"],
		["Walls - Village","Land_TinWall_01_m_pole_F"],
		["Walls - Village","Land_WoodenWall_01_m_4m_F"],
		["Walls - Village","Land_WoodenWall_01_m_8m_F"],
		["Walls - Village","Land_WoodenWall_01_m_d_F"],
		["Walls - Village","Land_WoodenWall_01_m_pole_F"],
		["Walls - Village","Land_WoodenWall_02_s_2m_F"],
		["Walls - Village","Land_WoodenWall_02_s_4m_F"],
		["Walls - Village","Land_WoodenWall_02_s_8m_F"],
		["Walls - Village","Land_WoodenWall_02_s_d_F"],
		["Walls - Village","Land_WoodenWall_02_s_gate_F"],
		["Walls - Village","Land_WoodenWall_02_s_pole_F"],
		["Walls - Village","Land_TinWall_01_m_gate_v1_closed_F"],
		["Walls - Village","Land_TinWall_01_m_gate_v2_closed_F"],
		["Walls - Village","Land_WoodenWall_02_s_gate_closed_F"]
	];
	
	//MOSTRA ICONES
	[] call BRPVP_atualizaIcones;

	//EachFrame MISSION EH
	BRPVP_draw3DCount = 1;
	BRPVP_friendsIconCache = [];
	BRPVP_drawIcon3DMark = [];
	BRPVP_drawAll = true;
	BRPVP_changedZoom = false;
	BRPVP_zoomCount = 0;
	//BRPVP_drawLine3D = [];
	addMissionEventHandler ["EachFrame",{
		if (visibleMap) then {
			call BRPVP_mapDraw;
			BRPVP_drawAll = true;
		} else {
			//{drawLine3D _x;} forEach BRPVP_drawLine3D;
			if (visibleGPS) then {
				if (BRPVP_draw3DCount in [2,6] || BRPVP_drawAll) then {
					call BRPVP_mapDraw;
				};
			};
			_drawIcon3D = [];
			_img = "";

			//TOW VEHICLE 3D ICON
			if (!isNull BRPVP_landVehicleOnTow) then {
				_posTowVeh = (ASLToAGL (getPosASLVisual BRPVP_landVehicleOnTow)) vectorAdd [0,0,1.5];
				_dist = player distance BRPVP_landVehicleOnTow;
				_div = 1;
				_decimal = 1;
				_unid = "m";
				if (_dist > 1000) then {
					_div = 1000;
					_decimal = 10;
					_unid = "km";
				};
				_param = ["",[1,0.5,1,1],_posTowVeh,0,0,0,format [localize "str_tow_land_tow_bob",str (round (_decimal*_dist/_div)/_decimal) + " " + _unid]];
				drawIcon3D _param;
			};

			//FOV & ANTI ZOOM
			_fov = player getVariable "fov";
			_fovNew = call KK_fnc_trueZoom;
			_antiZoom = 1/_fovNew;
			if (!isNull (player getVariable "veh")) then {_fovNew = 1;};
			if (abs((_fovNew - _fov)/_fov) > 0.001) then {
				player setVariable ["fov",_fovNew,false];
				BRPVP_changedZoom = true;
			} else {
				if (BRPVP_changedZoom) then {
					player setVariable ["fov",_fovNew,true];
					BRPVP_zoomCount = BRPVP_zoomCount + 1;
					diag_log ("[BRPVP ZOOM COUNT] " + str BRPVP_zoomCount);
					BRPVP_changedZoom = false;
				};
			};

			if (BRPVP_draw3DCount == 4 || BRPVP_drawAll) then {
				_antiZoomQuad = _antiZoom^2;
				
				//ICONES DE AMIGOS NA TELA 3D CALC
				_BRPVP_meusAmigosObjMarks = [];
				_BRPVP_ignoreM = [];
				_ignore = [];
				BRPVP_friendsIconCacheSingle = [];
				BRPVP_friendsIconCacheGroup = [];
				_plyPosWld = getPosWorld player;
				{
					_unit = _x;
					if (_unit getVariable ["sok",false] && {_unit getVariable ["dd",-1] <= 0}) then {
						_pd = _unit getVariable ["pd",[]];
						_BRPVP_meusAmigosObjMarks pushBack _pd;
						if (count _pd == 0) then {_BRPVP_ignoreM pushBack _forEachIndex;};
						if !(_unit in _ignore) then {
							_pos = getPosWorld _unit;
							_dist = player distanceSqr _unit;
							_nearLimit = 0.04 * _dist * _antiZoomQuad;
							_grp = [_unit];
							{
								if (_unit distanceSqr _x < _nearLimit) then {
									_grp pushBack _x;
									_pos = _pos vectorAdd (getPosASL _x);
								};
							} forEach (BRPVP_meusAmigosObj - (_ignore + [_unit]));
							_ignore append _grp;
							_gCnt = count _grp;
							_inCombat = {_x getVariable ["cmb",false]} count _grp;
							_rgba = [1,1 - 0.8 * _inCombat/_gCnt,0.2,1];
							_pos = _pos vectorMultiply (1/_gCnt);
							_dist = player distance ASLToAGL _pos;
							_div = 1;
							_decimal = 1;
							_unid = "m";
							if (_dist > 1000) then {
								_div = 1000;
								_decimal = 10;
								_unid = "km";
							};
							_3dDist = str (round (_decimal*_dist/_div)/_decimal) + " " + _unid;
							_v1 = _pos vectorDiff _plyPosWld;
							_v2 = [0,0,10];
							_v3 = _v1 vectorCrossProduct _v2;
							_v4 = _v3 vectorCrossProduct _v1;
							_adjust = (vectorNormalized _v4) vectorMultiply (0.0315 * (_dist min BRPVP_viewDist));
							if (_gCnt == 1) then {
								_img = if (_unit getVariable ["bdg",false]) then {BRPVP_missionRoot + "BRP_imagens\icones3d\working.paa"} else {""};
								BRPVP_friendsIconCacheSingle pushback [_unit,_unit getVariable "nm",_3dDist,_img,_rgba,_adjust];
							} else {
								BRPVP_friendsIconCacheGroup pushback [_grp,_gCnt,_3dDist,_rgba,_adjust];
							};
						};
					} else {
						_ignore pushBack _unit;
						_BRPVP_meusAmigosObjMarks pushBack [];
						_BRPVP_ignoreM pushBack _forEachIndex;
					};
				} forEach BRPVP_meusAmigosObj;
				
				//FRIENDS 3D MARKS
				BRPVP_drawIcon3DMark = [];
				{
					if !(_forEachIndex in _BRPVP_ignoreM) then {
						_fei = _forEachIndex;
						_pdi = _x;
						_pd = ATLToASL _x;
						_dist = player distanceSqr _x;
						_nearLimit = 0.04 * _dist * _antiZoomQuad;
						_grp = [_fei];
						{
							if !(_forEachIndex in _BRPVP_ignoreM || _forEachIndex == _fei) then {
								if (_pdi distanceSqr _x < _nearLimit) then {
									_grp pushBack _forEachIndex;
									_pd = _pd vectorAdd (ATLToASL _x);
								};
							};
						} forEach _BRPVP_meusAmigosObjMarks;
						_BRPVP_ignoreM append _grp;
						_gCnt = count _grp;
						_ni = BRPVP_countSecs mod _gCnt;
						_name = (BRPVP_meusAmigosObj select (_grp select _ni)) getVariable "nm";
						_pd = _pd vectorMultiply (1/_gCnt);
						_pd = ASLToATL _pd;
						_dist = player distance _pd;
						_div = 1;
						_decimal = 1;
						_unid = "m";
						if (_dist > 1000) then {
							_div = 1000;
							_decimal = 10;
							_unid = "km";
						};
						_3dDist = str (round (_decimal*_dist/_div)/_decimal) + " " + _unid;
						_txt = if (_gCnt == 1) then {_name + " | " + _3dDist} else {"x" + str (_cntNear + 1) + " | " + _name + " | " + _3dDist};
						BRPVP_drawIcon3DMark pushBack [BRPVP_missionRoot + "BRP_imagens\icones3d\marca_dest_amigo.paa",[1,1,1,1],_pd ,0.525,0.525,0,_txt,0,0.021];
					};
				} forEach _BRPVP_meusAmigosObjMarks;
			};
			if (BRPVP_draw3DCount == 8 || BRPVP_drawAll) then {
				BRPVP_drawIcon3DC = [];
				
				//RASTRO DE BALA
				if (BRPVP_rastroBalasLigado) then {
					_linhaIni = BRPVP_rastroPosicoes select 0;
					_distTotal = 0;
					{
						_distTotal = _distTotal + (_linhaIni distance _x);
						_txt = str round (_distTotal/100);
						_tamanho = (1/(1 + (_x distance player)/250)) max 0.15;
						_img = "BRP_imagens\icones3d\rastro.paa";
						if (terrainIntersect [ASLToAGL eyePos player,_x]) then {_img = "BRP_imagens\icones3d\rastro_pb.paa";};
						BRPVP_drawIcon3DC pushBack [BRPVP_missionRoot + _img,[1,1,1,1],_x,_tamanho/2,_tamanho/2,0,_txt,0,0.021];
						_linhaIni = _x;
					} forEach BRPVP_rastroPosicoes;
					reverse BRPVP_drawIcon3DC;
				};
			
				//SETAS PARA AMIGOS
				{[_x,_x getVariable "nm"] call BRPVP_drawSetas;} forEach BRPVP_meusAmigosObj;
				[player,player getVariable "nm"] call BRPVP_drawSetas;

				//MY 3D MARK
				_pd = player getVariable ["pd",[]];
				if (count _pd > 0) then {
					_dist = player distance _pd;
					_div = 1;
					_decimal = 1;
					_unid = "m";
					if (_dist > 1000) then {
						_div = 1000;
						_decimal = 10;
						_unid = "km";
					};
					_3dDist = str (round (_decimal*_dist/_div)/_decimal) + " " + _unid;
					_texto = (player getVariable "nm") + " | " + _3dDist;
					BRPVP_drawIcon3DC pushBack [BRPVP_missionRoot + "BRP_imagens\icones3d\marca_dest.paa",[1,1,1,1],_pd ,0.625,0.625,0,_texto,0,0.021];
				};
			};

			//FRIENDS 3D ICON - GROUP
			{
				_x params ["_grp","_gCnt","_3dDist","_rgba","_adjust"];
				_u = _grp select (BRPVP_countSecs mod _gCnt);
				_img = if (_u getVariable ["bdg",false]) then {BRPVP_missionRoot + "BRP_imagens\icones3d\working.paa"} else {""};
				_name = _u getVariable "nm";
				_pos = [0,0,0];
				{_pos = _pos vectorAdd (getPosASLVisual _x);} forEach _grp;
				_pos = _pos vectorMultiply (1/_gCnt);
				_txt = "x" + str _gCnt + " | " + _name + " | " + _3dDist;
				_pos = _pos vectorAdd [0,0,2.25] vectorAdd (_adjust vectorMultiply _antiZoom);
				_pos = ASLToAGL _pos;
				_drawIcon3D pushBack [_img,_rgba,_pos,0.625,0.625,0,_txt,0,0.021];
			} forEach BRPVP_friendsIconCacheGroup;

			//FRIENDS 3D ICON - SINGLE
			{
				_x params ["_unit","_name","_3dDist","_img","_rgba","_adjust"];
				_pos = (getPosASLVisual _unit) vectorAdd [0,0,2.25] vectorAdd (_adjust vectorMultiply _antiZoom);
				_pos = ASLToAGL _pos;
				_txt = _name + " | " + _3dDist;
				_drawIcon3D pushBack [_img,_rgba,_pos,0.625,0.625,0,_txt,0,0.021];
			} forEach BRPVP_friendsIconCacheSingle;
			
			//GANCHO DESVIRA VEICULO
			{
				_pos = (_x select 0) vectorAdd [0,0,1];
				_dist = player distance _pos;
				if (_dist < 2500) then {
					_size = (40/_dist min 2) * (_x select 1);
					_drawIcon3D pushBack [BRPVP_missionRoot + "BRP_imagens\icones3d\gancho.paa",[1,1,1,1],_pos,2 * _size,_size,0,""];
				};
			} forEach BRPVP_ganchoDesvira;

			{drawIcon3D _x;} forEach BRPVP_drawIcon3DC;
			{drawIcon3D _x;} forEach BRPVP_drawIcon3DMark;
			{drawIcon3D _x;} forEach _drawIcon3D;
			
			if (BRPVP_drawAll) then {
				BRPVP_drawAll = false;
				BRPVP_draw3DCount = 1;
			} else {
				BRPVP_draw3DCount = BRPVP_draw3DCount + 1;
				if (BRPVP_draw3DCount == 9) then {
					BRPVP_draw3DCount = 1;
				};
			};
		};
	}];

	[] spawn {
		waitUntil {!isNull (findDisplay 12 displayCtrl 51)};
		(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw",{
			_scale = ctrlMapScale (_this select 0);
			_allStuff = BRPVP_myStuff + BRPVP_ownedHousesExtra;
			if (BRPVP_vePlayersTypesIndex == BRPVP_vePlayersTypesIndexBases) then {
				{
					_fmr = _x getVariable ["fmr",[]];
					if (count _fmr > 0) then {(_this select 0) drawRectangle (_fmr select 1);};
				} forEach _allStuff;
				{
					private ["_rectangle"];
					_showOnMap = _x getVariable ["brpvp_showOnMap",-1];
					if (_showOnMap isEqualTo -1) then {_x setVariable ["brpvp_showOnMap",!(_x call BRPVP_IsMotorized) || _x isKindOf "StaticWeapon",false];};
					if (_x getVariable "brpvp_showOnMap") then {
						_fmr = _x getVariable ["fmr",[]];
						if (count _fmr > 0) then {
							(_this select 0) drawRectangle (_fmr select 0);
						} else {
							_color = "#(rgb,8,8,3)color(0,1,0,0.6)";
							if (_x getVariable ["mapa",false]) then {_color = "#(rgb,8,8,3)color(1,0,0,0.6)";};
							_bBox = boundingBoxReal _x;
							_xHSide = abs((_bBox select 0 select 0) - (_bBox select 1 select 0))/2;
							_yHSide = abs((_bBox select 0 select 1) - (_bBox select 1 select 1))/2;
							_rectangle = [getPosWorld _x,_xHSide,_yHSide,getDir _x,[1,1,1,1],_color];
							_rectangleExtra = [getPosWorld _x,_xHSide * 10,_yHSide * 10,getDir _x,[1,1,1,1],"#(rgb,8,8,3)color(0,0.8,0.8,0.3)"];
							_x setVariable ["fmr",[_rectangle,_rectangleExtra],false];
						};
					};
				} forEach _allStuff;
			};				
			if (BRPVP_countSecs mod 2 == 0) then {
				{
					_param = [BRPVP_missionRoot + (_x select 1),[1,1,1,1],_x select 0,30,30,0,"",false,0.05,"puristaMedium","right"];
					(_this select 0) drawIcon _param;
				} forEach BRPVP_zombieCitys;
			};
			{
				_param = [BRPVP_missionRoot + "BRP_imagens\icones3D\missao1.paa",[1,1,1,1],getPosASL _x,20,20,0,"",false,0.05,"puristaMedium","right"];
				(_this select 0) drawIcon _param;
			} forEach BRPVP_missPrediosEm;
			{
				_param = [BRPVP_missionRoot + "BRP_imagens\icones3d\siege.paa",[1,1,1,1],_x,30,30,0,"",false,0.05,"puristaMedium","right"];
				(_this select 0) drawIcon _param;
			} forEach BRPVP_onSiegeIcons;			
			{
				if (!isNull _x) then {
					_param = [BRPVP_missionRoot + "BRP_imagens\icones3d\corrupt.paa",[1,1,1,1],_x getVariable ["brpvp_fpsBoostPos",[0,0]],35,35,_x getVariable ["dir",0],"",false,0.05,"puristaMedium","right"];
					(_this select 0) drawIcon _param;
				};
			} forEach BRPVP_corruptMissIcon;
			if (BRPVP_countSecs mod 2 == 1) then {
				{
					_param = [BRPVP_missionRoot + (_x select 1),[1,1,1,1],_x select 0,30,30,0,"",false,0.05,"puristaMedium","right"];
					(_this select 0) drawIcon _param;
				} forEach BRPVP_zombieCitys;
			};
			{
				_param = [BRPVP_missionRoot + "BRP_imagens\interface\atm.paa",[1,1,1,1],getPosWorld _x,20,20,0,"",false,0.05,"puristaMedium","right"];
				(_this select 0) drawIcon _param;
			} forEach BRPVP_moneyMachines;
			{
				_composition = _x select 0;
				_crew = _x select 1;
				_kPaa = _x select 2;
				_color = _x select 3;
				_compositionOk = [];
				{if (canMove _x) then {_compositionOk pushBack _x;};} forEach _composition;
				_center = [0,0,0];
				{
					_pos = + (_x getVariable ["brpvp_fpsBoostPos",[0,0]]);
					_pos pushBack 0;
					_center = _center vectorAdd _pos;
				} forEach _compositionOk;
				_cntC = count _compositionOk;
				if (_cntC > 0) then {_center = _center vectorMultiply (1/_cntC);};
				if (_scale < 0.15) then {
					{
						_pos = + (_x getVariable ["brpvp_fpsBoostPos",[0,0]]);
						_pos pushBack 0;
						(_this select 0) drawline [_center,_pos,[1,0,0,1]];
						_param = [BRPVP_missionRoot + "BRP_imagens\icones3d\kveh.paa",[1,1,1,1],_pos,20,20,0,"",false,0.05,"puristaMedium","right"];
						(_this select 0) drawIcon _param;
					} forEach _compositionOk;
				};
				if (_cntC == 0) then {
					_cUts = 0;
					{
						if (_x == vehicle _x && {alive _x}) then {
							_pu = + (_x getVariable ["brpvp_fpsBoostPos",[0,0]]);
							_pu pushBack 0;
							_cUts = _cUts + 1;
							_center = _center vectorAdd _pu;
						};
					} forEach _crew;
					if (_cUts > 0) then {_center = _center vectorMultiply (1/_cUts);};
				};
				if (_scale < 0.025) then {
					{
						if (_x == vehicle _x && {alive _x}) then {
							_pu = + (_x getVariable ["brpvp_fpsBoostPos",[0,0]]);
							_pu pushBack 0;
							_assignedVehicle = assignedVehicle _x;
							if (!isNull _assignedVehicle && {canMove _assignedVehicle}) then {
								_posAssigned = + (_assignedVehicle getVariable ["brpvp_fpsBoostPos",[0,0]]);
								_posAssigned pushBack 0;
								(_this select 0) drawline [_posAssigned,_pu,[1,0.65,0,1]];
							} else {
								(_this select 0) drawline [_center,_pu,[1,0.65,0,1]];
							};
							_param = [BRPVP_missionRoot + "BRP_marcas\bot.paa",_color,_pu,20,20,0,"",false,0.05,"puristaMedium","right"];
							(_this select 0) drawIcon _param;
						};
					} forEach _crew;
				};
				if (_center distanceSqr [0,0,0] != 0) then {
					_param = [BRPVP_missionRoot + "BRP_imagens\icones3d\" + _kPaa,[1,1,1,1],_center,25,25,0,"Destroy",false,0.05,"puristaMedium","right"];
					(_this select 0) drawIcon _param;
				};
			} forEach BRPVP_konvoyCompositions;
		}];
	};
} else {
	//REDEFINE VARIAVEIS	
	call BRPVP_variavies;
};

//INICIA PROCESSO DE NASCIMENTO/SPAWN DO PLAYER
call BRPVP_nascimento_player;

//LISTEN SERVER CLIENT OK
if (isServer) then {BRPVP_listenServerCliOk = true;};

diag_log "[BRPVP FILE] playerInit.sqf END REACHED";