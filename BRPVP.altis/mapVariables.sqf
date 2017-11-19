private ["_amountVehicles","_amountHelis","_amountHelisAirport","_amountOnFootAI","_amountRevolters","_amountBravoPoint","_lootDispersion","_amountSiege","_amountConvoy","_planeCrashCycle"];

BRPVP_distanceToRespawnWaitZero = 5000; //IN METERS
BRPVP_personalSpawnCountLimit = 3;
BRPVP_extraBuildBBSizeForLoot = 2; //EXTRA SIZE IN METERS
BRPVP_autoTurretFireRange = [100,200,300]; //MAXIMUM FIRE DISTANCES FOR ON FOOT, ON LAND VEHICLE AND ON AIR VEHICLE TARGETS
BRPVP_sellTerrainPlaces = [
	[
		[[11573.2,07043.6,2.63],292.62],
		[[04586.0,10291.4,2.31],034.74],
		[[07272.2,13948.9,2.35],087.34],
		[[05171.4,21052.5,2.19],254.17],
		[[13545.5,20053.5,2.57],178.27],
		[[25371.6,19305.6,2.20],044.07],
		[[18439.7,16854.6,3.17],087.84],
		[[21285.1,10447.6,1.13],018.80]
	],
	[1,2,3,4,5,6,7,8]
];
BRPVP_mapaDimensoes = [30720,30720];
BRPVP_centroMapa = [15360,15360,0];
BRPVP_spawnAIFirstPos = [28338,23909,0];
BRPVP_posicaoFora = [-29000,46000,0];
//MORE CONFIGURATION - FOR DEDICATED SERVER ONLY
if (isDedicated) then {
	_amountVehicles = 300;
	_amountHelis = 60;
	_amountHelisAirport = 20;
	_amountOnFootAI = 12;
	_amountRevolters = 40;
	_amountBravoPoint = 2;
	_lootDispersion = 0.5;
	_amountSiege = 2;
	_amountConvoy = 4;
	_planeCrashCycle = 45;
};
//MORE CONFIGURATION - FOR PLAYERS RUNING A LISTEM SERVER
if (isServer && hasInterface) then {
	_amountVehicles = 200;
	_amountHelis = 25;
	_amountHelisAirport = 10;
	_amountOnFootAI = 6;
	_amountRevolters = 20;
	_amountBravoPoint = 1;
	_lootDispersion = 0;
	_amountSiege = 1;
	_amountConvoy = 2;
	_planeCrashCycle = 60;
};
//ONLY FOR SERVER/LISTEM_SERVER
if (isServer) then {
	BRPVP_mapaRodando = [
		//MAP
		"altis",
		//HEAL PLACES
		["Land_Chapel_V2_F"],
		//ITEM TRADERS AMOUNT
		22,
		//PERCENTAGE OF THE CITIES WHERE THE PLAYER CAN SPAWN
		1,
		//LAND VEHICLES
		_amountVehicles,
		//HELIS
		[_amountHelis,["Land_Hangar_F","Land_TentHangar_V1_F"],_amountHelisAirport],
		//ON FOOT AI
		[true,[_amountOnFootAI,200]],
		//REVOLTERS AI
		[true,_amountRevolters],
		//FREE INDEX POSITION
		"free to use",
		//FREE INDEX POSITION
		"free to use",
		//MIN WAYPOINT DISTANCE
		650,
		//BRAVO POINT MISSIONS
		[true,["Land_MilOffices_V1_F","Land_Cargo_HQ_V1_F","Land_Cargo_HQ_V2_F","Land_Dome_Big_F","Land_Airport_left_F","Land_Airport_right_F","Land_dp_bigTank_F","Land_i_Shed_Ind_F","Land_Factory_Main_F"],[true,true,true,false,false,false,true,true,false],_amountBravoPoint,12500],
		//EXTDB3 DATABASE ENTRY (NOT THE SCHEMA NAME IN MYSQL)
		"brpvp_altis",
		//FREE INDEX POSITION
		"free to use",
		//FREE INDEX POSITION
		"free to use",
		//FREE INDEX POSITION
		"free to use",
		//LAND AND AIR VEHICLES TRADERS
		[
			[[11886.30,09464.6,0],["MILITAR","CIV-MIL","CIVIL"]],
			[[04326.63,14528.7,0],["MILITAR","CIV-MIL","CIVIL"]],
			[[11376.00,14232.0,0],["MILITAR","CIV-MIL","CIVIL"]],
			[[11631.00,19510.1,0],["MILITAR","CIV-MIL","CIVIL"]],
			[[25438.60,20346.4,0],["MILITAR","CIV-MIL","CIVIL"]],
			[[20121.60,20013.4,0],["MILITAR","CIV-MIL","CIVIL"]],
			[[17657.30,10580.7,0],["MILITAR","CIV-MIL","CIVIL"]],
			[[26780.50,24646.1,0],["AIRPORT"]],
			[[11732.30,11847.3,0],["AIRPORT"]],
			[[09158.78,21637.6,0],["AIRPORT"]],
			[[20797.50,07191.5,0],["AIRPORT"]]
		],
		//FACTIONS TO IGNORE
		[],
		//LOOT AMOUNT CONFIG
		[0.25/*WEAK LOOT*/,0.5/*AVERAGE LOOT*/,0.75/*GOOD LOOT*/,1 - _lootDispersion/*PERCENTAGE OF REUSE OF THE SAME LOOT LOCAL*/],
		//SIEGE MISSIONS
		[true,_amountSiege,10000],
		//CONVOY MISSIONS
		[
			true,
			_amountConvoy,
			[
				[0.375,[11079,11247,1709,915,23071,16080,5028,4021,11257,20514,11841]],
				[0.375,[9673,30708,10905,32125,27118,5553,22266,25590,29836,29102,27330,10113]],
				[0.250,[1830,19706,20381,15718,3901,18893,17966]]
			]
		],
		//CIVIL PLANE CRASH MISSION - FIND THE CORRUPT POLITICIAN
		[true,[[[9315,17280,0],4500],[[19850,16000,0],1500],[[18876,11163,0],1500],[[11012,8152,0],1500]],1,_planeCrashCycle,50000]
	];
};

//GOOD LOOT
BRPVP_lootBuildingsGood = [
	"Land_MilOffices_V1_F",
	"Land_Cargo_HQ_V1_F",
	"Land_Cargo_HQ_V2_F",
	"Land_Dome_Big_F",
	"Land_Airport_left_F",
	"Land_Airport_right_F",
	"Land_dp_bigTank_F",
	"Land_i_Shed_Ind_F",
	"Land_Factory_Main_F"
];

//AVERAGE LOOT
BRPVP_lootBuildingsAverage = [
	"Land_u_Shop_02_V1_F", //140
	"Land_i_House_Big_02_V2_F", //128
	"Land_i_House_Big_01_V1_F", //125
	"Land_i_House_Big_01_V3_F", //122
	"Land_i_Stone_HouseBig_V1_F", //113
	"Land_i_Stone_HouseBig_V2_F", //110
	"Land_i_Stone_HouseBig_V3_F", //110
	"Land_Chapel_Small_V1_F", //116
	"Land_Unfinished_Building_01_F" //?
];

//WEAK LOOT
BRPVP_lootBuildingsWeak = [
	"Land_i_Stone_Shed_V1_F", //613
	"Land_u_Addon_02_V1_F", //612
	"Land_i_Stone_Shed_V3_F", //560
	"Land_i_Stone_Shed_V2_F", //567
	"Land_Metal_Shed_F", //442
	"Land_Slum_House01_F", //393
	"Land_Slum_House03_F", //390
	"Land_Slum_House02_F", //388
	"Land_u_Addon_01_V1_F", //258
	"Land_i_Addon_03_V1_F", //249
	"Land_i_House_Big_02_V1_F", //245
	"Land_d_Stone_Shed_V1_F", //238
	"Land_i_House_Big_01_V2_F", //238
	"Land_i_Addon_02_V1_F", //233
	"Land_u_House_Big_01_V1_F", //218
	"Land_Stone_Shed_V1_ruins_F", //203
	"Land_u_House_Big_02_V1_F", //198
	"Land_u_House_Small_02_V1_F", //197
	"Land_u_House_Small_01_V1_F", //192
	"Land_i_House_Small_01_V3_F", //173
	"Land_i_House_Small_02_V2_F", //169
	"Land_i_Garage_V1_F", //167
	"Land_Unfinished_Building_01_F", //165
	"Land_i_House_Big_02_V3_F", //162
	"Land_i_Stone_HouseSmall_V2_F", //157
	"Land_i_House_Small_02_V3_F", //155
	"Land_i_House_Small_01_V2_F", //154
	"Land_i_Stone_HouseSmall_V1_F", //152
	"Land_i_Stone_HouseSmall_V3_F", //151
	"Land_i_Garage_V2_F", //147
	"Land_i_Addon_04_V1_F", //144
	"Land_i_House_Small_01_V1_F", //141
	"Land_Cargo_House_V1_F", //129
	"Land_i_Shed_Ind_F", //128
	"Land_i_House_Small_02_V1_F", //115
	"Land_i_House_Small_03_V1_F" //107
];

//MAP EXTRA BUILDINGS
BRP_kitExtraBuildingsI = [];
BRPVP_specialItemsExtra = [];
BRPVP_specialItemsNamesExtra = [];
BRPVP_specialItemsImagesExtra = [];
BRPVP_mercadoItensExtra = [];
BRPVP_mercadoNomesNomesConstructionExtra = [];
BRPVP_buildingHaveDoorListExtra = [];
BRPVP_buildingHaveDoorListReverseDoorExtra = [];