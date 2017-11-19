//VERSAO
BRPVP_versaoCliente = "V0.2B2";

//ExtDB3: CONNECTA AO MYSQL
_db = BRPVP_mapaRodando select 12;
_initDbResult = "extDB3" callExtension ("9:ADD_DATABASE:" + _db);
diag_log ("[ExtDB3 IGNITE] " + str _initDbResult);
if (_initDbResult == "[1]") then {
	diag_log "[ExtDB3 IGNITE] ExtDB3 is Running.";
	BRPVP_useExtDB3 = true;

	//ExtDB3: DEFINE NOME PROTOCOLOS
	BRPVP_Protocolo = "P" + str round random 10000000;
	BRPVP_ProtocoloRaw = "PR" + str round random 10000000;
	BRPVP_ProtocoloRawText = "PRT" + str round random 10000000;

	//ExtDB3: CRIA PROTOCOLO
	"extDB3" callExtension ("9:ADD_DATABASE_PROTOCOL:" + _db + ":SQL_CUSTOM:" + BRPVP_Protocolo + ":brpvp.ini");
	"extDB3" callExtension ("9:ADD_DATABASE_PROTOCOL:" + _db + ":SQL:" + BRPVP_ProtocoloRaw);
	"extDB3" callExtension ("9:ADD_DATABASE_PROTOCOL:" + _db + ":SQL:" + BRPVP_ProtocoloRawText);

	//ExtDB3: LOGA NOME DOS PROTOCOLOS
	diag_log ("[BRPVP PROTOCOLO] " + BRPVP_Protocolo);
	diag_log ("[BRPVP PROTOCOLO_RAW] " + BRPVP_ProtocoloRaw);
	diag_log ("[BRPVP PROTOCOLO_RAW_TEXT] " + BRPVP_ProtocoloRawText);
} else {
	diag_log "[ExtDB3 IGNITE] No ExtDB3 Running! Using No-Db Mode!";
	BRPVP_useExtDB3 = false;
	BRPVP_noExtDB3MaxPlayers = 500;
	BRPVP_mapName = BRPVP_mapaRodando select 0;
	
	//VAULT VAR TABLE
	BRPVP_noExtDB3VaultTable = profileNameSpace getVariable ("BRPVP_noExtDB3VaultTable_" + BRPVP_mapName);
	if (isNil "BRPVP_noExtDB3VaultTable") then {
		BRPVP_noExtDB3VaultTable = [];
		_maxVaultId = BRPVP_sellTerrainPlaces select 1;
		_maxVaultId pushBack 0;
		_maxVaultId sort false;
		_maxVaultId = _maxVaultId select 0;
		for "_i" from 0 to _maxVaultID do {
			BRPVP_noExtDB3VaultTable pushBack [[],[]];
		};
	};
	
	//PLAYERS VAR TABLE
	BRPVP_noExtDB3PlayersTable = profileNameSpace getVariable ("BRPVP_noExtDB3PlayersTable_" + BRPVP_mapName);
	if (isNil "BRPVP_noExtDB3PlayersTable") then {BRPVP_noExtDB3PlayersTable = [[],[],[],[],[]];};
	
	//ADD IDBD IF MISSING
	if (count BRPVP_noExtDB3PlayersTable == 3) then {
		_all_id_bd = [];
		{_all_id_bd pushBack (_x select 11);} forEach (BRPVP_noExtDB3PlayersTable select 1);
		BRPVP_noExtDB3PlayersTable pushBack _all_id_bd;
	};
	
	//ADD CONNECTION ID IF NEEDED
	if (count BRPVP_noExtDB3PlayersTable == 4) then {
		_addArray = [];
		{
			_addArray pushBack 0;
		} forEach (BRPVP_noExtDB3PlayersTable select 0);
		BRPVP_noExtDB3PlayersTable pushBack _addArray;
	};
	
	//DELETE OLD PLAYERS IF LIMIT REACHED
	_connNumberArray = BRPVP_noExtDB3PlayersTable select 4;
	_amountPlayers = count _connNumberArray;
	_playersToDel = (_amountPlayers - BRPVP_noExtDB3MaxPlayers) max 0;
	if (_playersToDel > 0) then {
		_connNumberArray sort true;
		_deleted = 0;
		{
			if (_deleted == _playersToDel) exitwith {};
			_delIndex = (BRPVP_noExtDB3PlayersTable select 4) find _x;
			if (_delIndex != -1) then {
				{
					_vaultIndex = (_x select 0) find (BRPVP_noExtDB3PlayersTable select 0 select _delIndex);
					if (_vaultIndex != -1) then {
						(BRPVP_noExtDB3VaultTable select _forEachIndex select 0) deleteAt _vaultIndex;
						(BRPVP_noExtDB3VaultTable select _forEachIndex select 1) deleteAt _vaultIndex;
					} else {
						diag_log "[no-DB ERROR] TRIED TO DELETE A VAULT WITHOUT ENTRY.";
					};
				} forEach BRPVP_noExtDB3VaultTable;
				(BRPVP_noExtDB3PlayersTable select 0) deleteAt _delIndex;
				(BRPVP_noExtDB3PlayersTable select 1) deleteAt _delIndex;
				(BRPVP_noExtDB3PlayersTable select 2) deleteAt _delIndex;
				(BRPVP_noExtDB3PlayersTable select 3) deleteAt _delIndex;
				(BRPVP_noExtDB3PlayersTable select 4) deleteAt _delIndex;
				_deleted = _deleted + 1;
			} else {
				diag_log "[no-DB ERROR] TRIED TO DELETE AN EXCEDENT PLAYER WITHOUT ENTRY.";
			};
		} forEach _connNumberArray;
	};
	
	//GET LAST CONNECTION ID
	_connNumberArray = BRPVP_noExtDB3PlayersTable select 4;
	_connNumberArray sort false;
	BRPVP_lastConnectionNumber = if (count _connNumberArray > 0) then {_connNumberArray select 0} else {0};
	
	//LOG PLAYERS DATA
	{
		diag_log ("=== NO-DB PLAYERS " + str _forEachIndex + " =========================================================");
		{
			diag_log str _x;
		} forEach _x;
	} forEach BRPVP_noExtDB3PlayersTable;
	
	//GET LAST PLAYER ID
	_playerIdBdMax = -1;
	{
		if (_x select 11 > _playerIdBdMax) then {
			_playerIdBdMax = _x select 11;
		};
	} forEach (BRPVP_noExtDB3PlayersTable select 1);
	BRPVP_noExtDB3IdBd = _playerIdBdMax + 1;
	
	//VEHICLES VAR TABLE
	BRPVP_noExtDB3VehiclesTable = profileNameSpace getVariable ("BRPVP_noExtDB3VehiclesTable_" + BRPVP_mapName);
	if (isNil "BRPVP_noExtDB3VehiclesTable") then {BRPVP_noExtDB3VehiclesTable = [[],[],[]];};
	BRPVP_noExtDB3IdBdVehicles = -1;
	{
		if (_x > BRPVP_noExtDB3IdBdVehicles) then {
			BRPVP_noExtDB3IdBdVehicles = _x;
		};
	} forEach (BRPVP_noExtDB3VehiclesTable select 0);
	BRPVP_noExtDB3IdBdVehicles = BRPVP_noExtDB3IdBdVehicles + 1;
};

//SERVERTIME LADO SERVIDOR
if (hasInterface) then {
	BRPVP_serverTime = serverTime;
	0 spawn {
		while {true} do {
			BRPVP_serverTime = serverTime;
			sleep 1;
		};
	};
} else {
	_init = time;
	waitUntil {!isNil "BRPVP_serverTimeSend" || time - _init >= 30};
	if (isNil "BRPVP_serverTimeSend") then {BRPVP_serverTimeSend = 30;};
	BRPVP_serverTime = BRPVP_serverTimeSend;
	_deltaTimeToOk = (360 - BRPVP_serverTimeSend) max 0;
	_missionTimeInit = time;
	[_missionTimeInit,_deltaTimeToOk] spawn {
		params ["_missionTimeInit","_deltaTimeToOk"];
		while {true} do {
			_missionTime = time;
			if (_missionTime < _missionTimeInit + _deltaTimeToOk) then {
				BRPVP_serverTime = BRPVP_serverTimeSend + (_missionTime - _missionTimeInit);
			} else {
				BRPVP_serverTime = serverTime;
			};
			sleep 1;
		};
	};
};

//VARIAVEIS PUBLICAS
BRPVP_allMissionsItemBox = [];
publicVariable "BRPVP_allMissionsItemBox";
BRPVP_bots = [];
publicVariable "BRPVP_bots";
BRPVP_walkersObj = [];
publicVariable "BRPVP_walkersObj";
BRPVP_corruptMissIcon = [];
publicVariable "BRPVP_corruptMissIcon";
BRPVP_konvoyCompositions = [];
publicVariable "BRPVP_konvoyCompositions";
BRPVP_interferencia = 1;
publicVariable "BRPVP_interferencia";
BRPVP_terminaMissao = false;
publicVariable "BRPVP_terminaMissao";
BRPVP_noAntiAmarelou = [];
publicVariable "BRPVP_noAntiAmarelou";
BRPVP_missPrediosEm = [];
publicVariable "BRPVP_missPrediosEm";
BRPVP_missBotsEm = [];
publicVariable "BRPVP_missBotsEm";
BRPVP_lastMassSave = BRPVP_serverTime;
publicVariable "BRPVP_lastMassSave";

//COMPATIBILITY
BRPVP_unidBlindados = [];
publicVariable "BRPVP_unidBlindados";
BRPVP_unidBlindadosCor = [];
PublicVariable "BRPVP_unidBlindadosCor";

//SERVER CREATED ANTI ZOMBIE STRUCTURES
BRPVP_antiZombieStructuresServerCreated = [
	"Land_Calvary_01_V1_F",
	"Land_Calvary_02_V1_F",
	"Land_Calvary_02_V2_F"
];

BRPVP_buildingHaveDoorList = [
	//ORIGINAL BUILDINGS
	"Land_Net_Fence_Gate_F",
	"Land_ConcreteWall_01_m_gate_F",
	"Land_ConcreteWall_01_l_gate_F",
	"Land_City_Gate_F",
	"Land_Stone_Gate_F",
	"Land_Slum_House01_F",
	"Land_Slum_House02_F",
	"Land_Slum_House03_F",
	"Land_cmp_Shed_F",
	"Land_FuelStation_Build_F",
	"Land_Cargo_Tower_V1_F",
	"Land_Cargo_Patrol_V1_F",
	"Land_Dome_Small_F",
	"Land_Church_01_V1_F",
	"Land_Offices_01_V1_F",
	"Land_WIP_F",
	"Land_dp_mainFactory_F",
	"Land_i_Barracks_V1_F",
	//STORAGE AND FUEL OBJECTS
	"Box_NATO_AmmoVeh_F",
	"Box_East_AmmoVeh_F",
	"Box_IND_AmmoVeh_F",
	"Box_T_East_WpsSpecial_F",
	"C_T_supplyCrate_F",
	"Box_Syndicate_Ammo_F",
	"Box_Syndicate_WpsLaunch_F"	,
	"Land_fs_feed_F",
	"Land_FuelStation_Feed_F",
	//SMALL VANILLA HOUSES
	"Land_i_Addon_02_V1_F",
	"Land_i_House_Small_02_V1_F",
	"Land_i_House_Small_02_V2_F",
	"Land_i_House_Small_02_V3_F",
	"Land_GH_House_1_F",
	"Land_GH_House_2_F",
	"Land_i_House_Small_01_V1_F",
	"Land_i_House_Small_01_V2_F",
	"Land_i_Windmill01_F",
	//BIG VANILLA HOUSES
	"Land_i_House_Big_01_V1_F",
	"Land_i_House_Big_01_V2_F",
	"Land_i_House_Big_01_V3_F",
	"Land_i_House_Big_02_V1_F",
	"Land_i_House_Big_02_V2_F",
	"Land_i_House_Big_02_V3_F",
	"Land_i_Shop_01_V1_F",
	"Land_i_Shop_01_V2_F",
	"Land_i_Shop_02_V1_F",
	"Land_i_Shop_02_V2_F",
	"Land_i_Shop_02_V3_F",
	//KIT MOVEMENT
	"Land_PierLadder_F",
	//KIT LAMP
	"Land_LampStreet_small_F",
	"Land_LampStreet_F",
	"Land_LampSolar_F",
	"Land_LampDecor_F",
	"Land_LampHalogen_F",
	"Land_LampHarbour_F",
	"Land_LampStadium_F",
	"Land_LampAirport_F",
	//RELIGIOUS KIT - ANTI ZOMBIE
	"Land_BellTower_01_V1_F",
	"Land_BellTower_02_V1_F",
	"Land_BellTower_02_V2_F",
	"Land_Calvary_01_V1_F",
	"Land_Calvary_02_V1_F",
	"Land_Calvary_02_V2_F",
	"Land_Grave_obelisk_F",
	"Land_Grave_memorial_F",
	"Land_Grave_monument_F",
	//AUTO DEFENCE TURRET
	"I_HMG_01_high_F",
	"I_HMG_01_F",
	"I_GMG_01_high_F",
	"I_GMG_01_F",
	"I_static_AA_F",
	"I_static_AT_F",
	//TARGET
	"TargetP_Inf_F",
	//HELIPADS
	"Land_HelipadCircle_F",
	"Land_HelipadCivil_F",
	"Land_HelipadRescue_F",
	"Land_HelipadSquare_F",
	//CAMONETS
	"CamoNet_BLUFOR_big_F",
	"CamoNet_BLUFOR_F",
	"CamoNet_BLUFOR_open_F",
	"CamoNet_OPFOR_big_F",
	"CamoNet_OPFOR_F",
	"CamoNet_OPFOR_open_F",
	"CamoNet_INDP_big_F",
	"CamoNet_INDP_F",
	"CamoNet_INDP_open_F",
	//ADMIN
	"Land_BarGate_F",
	"Land_JumpTarget_F",
	"Land_FloodLight_F",
	"Land_Atm_01_F",
	"Land_Atm_02_F",
	"Land_PortableLight_single_F",
	"Land_PortableLight_double_F",
	"Flag_BI_F",
	"Flag_Blue_F",
	"Flag_Green_F",
	"Flag_Red_F",
	"Flag_RedCrystal_F",
	"Flag_White_F",
	//KIT LIGHT
	"Land_Razorwire_F"	
] + BRPVP_buildingHaveDoorListExtra;

if (BRPVP_makeAllBuildingsInteractive) then {
	_temp = [
		"Land_Razorwire_F",
		"Land_Net_Fence_4m_F",
		"Land_Net_Fence_8m_F",
		"Land_Net_Fence_Gate_F",
		"Land_Net_Fence_Pole_F",
		"Land_Pipe_fence_4m_F",
		"CamoNet_BLUFOR_big_F",
		"CamoNet_BLUFOR_F",
		"CamoNet_BLUFOR_open_F",
		"CamoNet_OPFOR_big_F",
		"CamoNet_OPFOR_F",
		"CamoNet_OPFOR_open_F",
		"CamoNet_INDP_big_F",
		"CamoNet_INDP_F",
		"CamoNet_INDP_open_F",
		"Land_BagFence_Long_F",
		"Land_BagFence_Short_F",
		"Land_HBarrier_1_F",
		"Land_HBarrier_3_F",
		"Land_HBarrier_5_F",
		"Land_City_4m_F",
		"Land_City2_4m_F",
		"Land_City_8m_F",
		"Land_City_8mD_F",
		"Land_City2_8m_F",
		"Land_City_Gate_F",
		"Land_City_Pillar_F",
		"Land_PipeWall_concretel_8m_F",
		"Land_Stone_4m_F",
		"Land_Stone_8m_F",
		"Land_Stone_8mD_F",
		"Land_Stone_Gate_F",
		"Land_Stone_Pillar_F",
		"Land_PipeWall_concretel_8m_F",
		"Land_Slum_House01_F",
		"Land_Slum_House02_F",
		"Land_Slum_House03_F",
		"Land_cmp_Shed_F",
		"Land_cargo_house_slum_F",
		"Land_FuelStation_Build_F",
		"Land_CncWall1_F",
		"Land_CncWall4_F",
		"Land_Concrete_SmallWall_4m_F",
		"Land_Concrete_SmallWall_8m_F",
		"Land_Wall_IndCnc_4_F",
		"Land_PipeWall_concretel_8m_F",
		"Land_ConcreteWall_01_m_gate_F",
		"Land_ConcreteWall_01_l_gate_F",
		"Land_Sea_Wall_F",
		"Land_Mound01_8m_F",
		"Land_Mound02_8m_F",
		"Land_Castle_01_church_a_ruin_F",
		"Land_Castle_01_tower_F",
		"Land_Cargo_Tower_V1_F",
		"Land_Cargo_Patrol_V1_F",
		"bandeira_x_azul",
		"bandeira_x_cinza",
		"bandeira_x_marrom",
		"bandeira_x_verde",
		"bandeira_x_roxa",
		"bandeira_x_vermelha",
		"bandeira_q_azul",
		"bandeira_q_cinza",
		"bandeira_q_marrom",
		"bandeira_q_verde",
		"bandeira_q_roxa",
		"bandeira_q_vermelha",
		"Land_Dome_Small_F",
		"Land_TentHangar_V1_F",
		"Land_Church_01_V1_F",
		"Land_Offices_01_V1_F",
		"Land_WIP_F",
		"Land_dp_mainFactory_F",
		"Land_i_Barracks_V1_F",
		"Land_WoodenTable_large_F",
		"Land_WoodenTable_small_F",
		"Land_ChairWood_F",
		"Land_Bench_F",
		"Land_Bench_01_F",
		"Land_Bench_02_F",
		"Land_CampingTable_F",
		"Land_CampingTable_small_F",
		"Land_CampingChair_V1_F",
		"Land_CampingChair_V2_F",
		"Land_Sunshade_F",
		"Land_Sunshade_01_F",
		"Land_Sunshade_02_F",
		"Land_Sunshade_03_F",
		"Land_Sunshade_04_F",
		"Land_BeachBooth_01_F",
		"Land_LifeguardTower_01_F",
		"Land_TablePlastic_01_F",
		"Land_ChairPlastic_F",
		"Land_Sun_chair_F",
		"Land_Sun_chair_green_F",
		"Land_BellTower_01_V1_F",
		"Land_BellTower_02_V1_F",
		"Land_BellTower_02_V2_F",
		"Land_Calvary_01_V1_F",
		"Land_Calvary_02_V1_F",
		"Land_Calvary_02_V2_F",
		"Land_Grave_obelisk_F",
		"Land_Grave_memorial_F",
		"Land_Grave_monument_F",
		"Land_BarrelEmpty_F",
		"Land_BarrelEmpty_grey_F",
		"Land_Bucket_F",
		"Land_Bucket_clean_F",
		"Land_Bucket_painted_F",
		"Land_BucketNavy_F",
		"Land_GarbageContainer_closed_F",
		"Land_Basket_F",
		"Land_cargo_addon02_V1_F",
		"Land_cargo_addon02_V2_F",
		"Land_GarbageBin_01_F",
		"RoadCone_F",
		"Land_GarbageBarrel_01_F",
		"Land_WoodenLog_F",
		"TargetP_Inf_F",
		"Land_LampStreet_small_F",
		"Land_LampStreet_F",
		"Land_LampSolar_F",
		"Land_LampDecor_F",
		"Land_LampHalogen_F",
		"Land_LampHarbour_F",
		"Land_LampAirport_F",
		"Land_SlideCastle_F",
		"Land_Carousel_01_F",
		"Land_Swing_01_F",
		"Land_Kiosk_redburger_F",
		"Land_Kiosk_papers_F",
		"Land_Kiosk_gyros_F",
		"Land_Kiosk_blueking_F",
		"Land_TouristShelter_01_F",
		"Land_Slide_F",
		"Land_BC_Basket_F",
		"Land_BC_Court_F",
		"Land_Goal_F",
		"Land_Tribune_F",
		"Land_Sign_WarningMilitaryArea_F",
		"Land_Sign_WarningMilAreaSmall_F",
		"Land_Sign_WarningMilitaryVehicles_F",
		"ArrowDesk_L_F",
		"ArrowDesk_R_F",
		"RoadBarrier_F",
		"TapeSign_F",
		"Box_NATO_AmmoVeh_F",
		"Box_East_AmmoVeh_F",
		"Box_IND_AmmoVeh_F",
		"Box_T_East_WpsSpecial_F",
		"C_T_supplyCrate_F",
		"Box_Syndicate_Ammo_F",
		"Box_Syndicate_WpsLaunch_F",
		"Land_fs_feed_F",
		"Land_FuelStation_Feed_F",
		"Land_Wreck_BMP2_F",
		"Land_Wreck_BRDM2_F",
		"Land_Wreck_Heli_Attack_01_F",
		"Land_Wreck_Heli_Attack_02_F",
		"Land_Wreck_HMMWV_F",
		"Land_Wreck_Hunter_F",
		"Land_Wreck_Skodovka_F",
		"Land_Wreck_Slammer_F",
		"Land_Wreck_Slammer_hull_F",
		"Land_Wreck_Slammer_turret_F",
		"Land_Wreck_T72_hull_F",
		"Land_Scrap_MRAP_01_F",
		"Land_Wreck_Ural_F",
		"Land_Wreck_UAZ_F",
		"Land_i_Addon_02_V1_F",
		"Land_i_Addon_03_V1_F",
		"Land_i_Addon_03mid_V1_F",
		"Land_i_House_Small_02_V1_F",
		"Land_i_House_Small_02_V2_F",
		"Land_i_House_Small_02_V3_F",
		"Land_GH_House_1_F",
		"Land_GH_House_2_F",
		"Land_i_House_Small_01_V1_F",
		"Land_i_House_Small_01_V2_F",
		"Land_Lighthouse_small_F",
		"Land_i_Windmill01_F",
		"Land_nav_pier_m_F",
		"Land_HBarrierTower_F",
		"Land_HBarrierWall_corridor_F",
		"Land_i_House_Big_01_V1_F",
		"Land_i_House_Big_01_V2_F",
		"Land_i_House_Big_01_V3_F",
		"Land_i_House_Big_02_V1_F",
		"Land_i_House_Big_02_V2_F",
		"Land_i_House_Big_02_V3_F",
		"Land_u_House_Big_01_V1_F",
		"Land_u_House_Big_02_V1_F",
		"Land_i_Shop_01_V1_F",
		"Land_i_Shop_01_V2_F",
		"Land_i_Shop_02_V1_F",
		"Land_i_Shop_02_V2_F",
		"Land_i_Shop_02_V3_F",
		"Land_dp_smallTank_F",
		"Land_TTowerSmall_1_F",
		"Land_TTowerSmall_2_F",
		"Land_TTowerBig_1_F",
		"Land_TTowerBig_2_F",
		"Land_PierLadder_F",
		"Land_Castle_01_step_F",
		"Land_RampConcrete_F",
		"Land_RampConcreteHigh_F",
		"Land_Obstacle_Ramp_F",
		"Land_Obstacle_RunAround_F",
		"Land_Obstacle_Climb_F",
		"Land_Obstacle_Bridge_F",
		"BlockConcrete_F",
		"Land_Razorwire_F",
		"Land_CncShelter_F",
		"Land_PhoneBooth_01_F",
		"Land_PhoneBooth_02_F",
		"Land_GarbageContainer_closed_F",
		"Land_FieldToilet_F",
		"Land_WaterBarrel_F",
		"Land_Pallets_stack_F",
		"Land_PaperBox_closed_F",
		"Land_Laptop_unfolded_F",
		"Land_Ground_sheet_folded_blue_F",
		"Land_Ground_sheet_folded_khaki_F",
		"Land_Ground_sheet_folded_yellow_F",
		"Land_Tyre_F",
		"Land_BarrelEmpty_F",
		"Land_MetalBarrel_empty_F",
		"Land_BarrelEmpty_grey_F",
		"Land_Ketchup_01_F",
		"Land_HelipadCircle_F",
		"Land_HelipadCivil_F",
		"Land_HelipadRescue_F",
		"Land_HelipadSquare_F",
		"Flag_Altis_F",
		"Flag_AltisColonial_F",
		"Flag_BI_F",
		"Flag_Blue_F",
		"Flag_Green_F",
		"Flag_Red_F",
		"Flag_RedCrystal_F",
		"Flag_White_F"
	];
	BRPVP_buildingHaveDoorList append _temp;
	BRPVP_buildingHaveDoorList arrayIntersect BRPVP_buildingHaveDoorList;
};

publicVariable "BRPVP_buildingHaveDoorList";
BRPVP_buildingHaveDoorListReverseDoor = [] + BRPVP_buildingHaveDoorListReverseDoorExtra;
publicVariable "BRPVP_buildingHaveDoorListReverseDoor";

//VARIAVEIS SO SERVIDOR
BRPVP_playerOwner = 2;
BRPVP_criaMissaoDePredioIdc = 1;
BRPVP_distPlayerParaDanBot = 1000;
BRPVP_distPlayerParaDanBotTimer = 5;
BRPVP_ownedHouses = [];
BRPVP_botKillRemove = ["ItemRadio"];
BRPVP_corpsesToDel = [];
BRPVP_autoDefenseTurretList = [];

diag_log ("[TEMP TEMP TEMP] BRPVP_playerOwner = " + str BRPVP_playerOwner);

//MISSION ROOT: http://killzonekid.com/arma-scripting-tutorials-mission-root/
BRPVP_missionRoot = str missionConfigFile select [0, count str missionConfigFile - 15];


//CALCULOS PESADOS
_calcTerr = isNil "BRPVP_terrenos";
_calcMerc = isNil "BRPVP_terrPosArray";

//FORMA QUADRATICA
BRPVP_distPlayerParaDanBot = BRPVP_distPlayerParaDanBot^2;

//EXECUCOES SERVIDOR
["CONSTRUCOES_EXTRA","custom_constructions.sqf"] call BRPVP_execFast;
["CRIA_ARRAY_RUAS",{BRPVP_ruas = BRPVP_centroMapa nearRoads 20000;}] call BRPVP_execFast;
["VARIAVEIS_CALCULADAS","server_code\servidor_variaveisCalculadas.sqf"] call BRPVP_execFast;
["FUNCOES","server_code\servidor_funcoes.sqf"] call BRPVP_execFast;
["PVEH_SERVIDOR","server_code\servidor_PVEH.sqf"] call BRPVP_execFast;
["ARSENAL_VEICULOS","server_code\servidor_assets_a3_cup.sqf"] call BRPVP_execFast;

if (_calcTerr) then {["ACHA TERRENOS",BRPVP_achaTerreno] call BRPVP_execFast;};

call compile preprocessFileLineNumbers "client_code\itemMarketVariables.sqf";

["VEICULOS","server_code\servidor_veiculos.sqf"] call BRPVP_execFast;
call compile preprocessFileLineNumbers "server_code\servidor_mercados.sqf";
["COMPLETA_VEICULOS","server_code\servidor_completa_veiculos.sqf"] call BRPVP_execFast;
["LOOT_SERVIDOR","client_code\sistema_loot.sqf"] call BRPVP_execFast;
["BOTS_A_PE","server_code\servidor_bots_ape.sqf"] call BRPVP_execFast;
["BOTS_REVOLTOSOS","server_code\servidor_revoltosos.sqf"] call BRPVP_execFast;

//SIEGE MISSION
BRPVP_closedCityWalls = [];
BRPVP_closedCityRunning = [];
BRPVP_closedCityObjs = [];
BRPVP_closedCityAI = [];
BRPVP_closedCityTime = [];
{
	BRPVP_closedCityWalls pushBack [];
	BRPVP_closedCityRunning pushBack 0;
	BRPVP_closedCityObjs pushBack [];
	BRPVP_closedCityAI pushBack [];
	BRPVP_closedCityTime pushBack -600;
} forEach BRPVP_locaisImportantes;
BRPVP_towas = ["Land_Cargo_Patrol_V2_F","Land_Cargo_Patrol_V3_F","Land_Cargo_Tower_V2_F"];
publicVariable "BRPVP_closedCityRunning";
publicVariable "BRPVP_closedCityWalls";
publicVariable "BRPVP_closedCityObjs";

call compile preprocessFileLineNumbers "server_code\servidor_loop.sqf";

//AUTO DEFENSE TURRETS
execVM "server_code\server_autoDefenseTurret.sqf";

//ZOMBIES
BRPVP_serverCanContinue = false;
execVM "server_code\server_zombieMotherBrain.sqf";
waitUntil {BRPVP_serverCanContinue};

//MONEY MACHINES
BRPVP_moneyMachines = BRPVP_centroMapa nearObjects ["Land_Atm_01_F",100000];
BRPVP_moneyMachines append (BRPVP_centroMapa nearObjects ["Land_Atm_02_F",100000]);
publicVariable "BRPVP_moneyMachines";

//SALVA PLAYER NA SAIDA + ANTI-AMARELOU
addMissionEventHandler ["HandleDisconnect",{
	_p = _this select 0;
	_uid = _this select 2;
	if (_p getVariable ["sok",false]) then {
		_p setVariable ["sok",false,true];

		//RETURN ZOMBIES TO SERVER
		_id_bd = _p getVariable "id_bd";
		_idx = BRPVP_zombiePlayersAttacked find _id_bd;
		//diag_log ("desconectado EH _idx: " + str _idx);
		//diag_log ("desconectado EH select _idx: " + str (BRPVP_zombiePlayersAttackedUnits select _idx));
		//diag_log ("desconectado EH select _idx #: " + str count (BRPVP_zombiePlayersAttackedUnits select _idx));
		_countZ = 0;
		if (_idx != -1) then {
			{
				//diag_log ("desconectado EH select loop contagem #: " + str (_forEachIndex + 1));
				if (!isNull _x) then {
					_countZ = _countZ + 1;
					//diag_log ("desconectado EH select loop contagem !isNull #: " + str _countZ);
					_x call BRPVP_zombieLocalEH;
				};
			} forEach + (BRPVP_zombiePlayersAttackedUnits select _idx);
		};
		
		//SAVE VAULT AND SELL RECEPTACLE
		[_p,true] call BRPVP_salvaVault;

		//DELETE TOWNER UNIT IF EXISTS
		_towner = _p getVariable ["towner",objNull];
		if (!isNull _towner) then {deleteVehicle _towner;};
		
		//CANCEL CONSTRUCTION IF IN CONSTRUCTION
		_obui = _p getVariable ["obui",objNull];
		if (!isNull _obui) then {deleteVehicle _obui;};
		
		if (BRPVP_terminaMissao) then {
			if (alive _p) then {
				_playerState = _p call BRPVP_pegaEstadoPlayer;
				_playerState set [0,_uid];
				_playerState call BRPVP_salvarPlayerServidor;
			} else {
				[_uid,0] call BRPVP_daComoMorto;
			};		
		} else {
			if (alive _p) then {
				//SALVA PLAYER
				_playerState = _p call BRPVP_pegaEstadoPlayer;
				_playerState set [0,_uid];
				_playerState call BRPVP_salvarPlayerServidor;
				
				//LIGA ANTI-AMARELOU NO USUARIO E NO SLOT
				diag_log ( "[BRPVP AA] player state = " + str _playerState);
				BRPVP_noAntiAmarelou pushBack _uid;
				publicVariable "BRPVP_noAntiAmarelou";
				
				//DISABLE AI
				_p disableAI "TARGET";
				_p disableAI "AUTOTARGET";
				_p disableAI "MOVE";
				_p disableAI "ANIM";
				_p disableAI "TEAMSWITCH";
				_p disableAI "FSM";
				_p disableAI "AIMINGERROR";
				_p disableAI "SUPPRESSION";
				_p disableAI "CHECKVISIBLE";
				_p disableAI "COVER";
				_p disableAI "AUTOCOMBAT";
				_p disableAI "PATH";
				
				[_p,_uid] spawn {
					params ["_p","_uid"];
					
					//REMOVE DO SLOT
					_grpAntigo = group _p;
					_grpNovo = createGroup [OPFOR,true];
					[_p] joinSilent _grpNovo;
					deleteGroup _grpAntigo;
					
					//ESPERA MORTE DO PLAYER E FINALIZA
					_ini = time;
					_pass = 0;
					waitUntil {_pass = time - _ini;_pass >= BRPVP_survivalTimeOnDisconnect - 0.25 || !alive _p || BRPVP_terminaMissao};
					if (alive _p) then {
						_playerState = _p call BRPVP_pegaEstadoPlayer;
						_playerState set [0,_uid];
						_playerState call BRPVP_salvarPlayerServidor;
						deleteVehicle _p;
						deleteGroup _grpNovo;
					} else {
						[_uid,0] call BRPVP_daComoMorto;
						_p setVariable ["hrm",time,true];
					};
											
					//RETIRA PLAYER DO ANTI-AMARELOU
					_p setVariable ["AA",false,true];
					BRPVP_noAntiAmarelou = BRPVP_noAntiAmarelou - [_uid];
					publicVariable "BRPVP_noAntiAmarelou";
					
					//FAZ ATUALIZAR LISTA AMIGOS
					BRPVP_PUSV = true;
					publicVariable "BRPVP_PUSV";
					if (hasInterface) then {["",BRPVP_PUSV] call BRPVP_PUSVFnc;};
				};
				true
			} else {
				[_uid,0] call BRPVP_daComoMorto;
				_p setVariable ["hrm",time,true];
				_p setVariable ["dd",1,true];
				BRPVP_PUSV = true;
				publicVariable "BRPVP_PUSV";
				if (hasInterface) then {["",BRPVP_PUSV] call BRPVP_PUSVFnc;};
			};
		};
	};
}];