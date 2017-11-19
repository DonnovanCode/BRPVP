//BASE CONSTRUCTION CONFIGURATION - DEFAULT BRPVP
BRPVP_friendBuildingsPercentageToBuild = 0;
BRPVP_interactiveBuildingsGodMode = false;
BRPVP_makeAllBuildingsInteractive = true;
BRPVP_sellFlagOnTrader = true;
BRPVP_flagBuildingsGodMode = true;
BRPVP_flagVehiclesGodModeWhenEmpty = true;
BRPVP_allowBuildingsAwayFromFlags = true;
BRPVP_buildingAwayFromFlagEasyDestroy = true;
BRPVP_flagsAreasIntersectionAllowed = 0.2;

//BASE CONSTRUCTION CONFIGURATION - EPOCH MODE
/*
BRPVP_friendBuildingsPercentageToBuild = 0;
BRPVP_interactiveBuildingsGodMode = false;
BRPVP_makeAllBuildingsInteractive = false;
BRPVP_sellFlagOnTrader = true;
BRPVP_flagBuildingsGodMode = true;
BRPVP_flagVehiclesGodModeWhenEmpty = true;
BRPVP_allowBuildingsAwayFromFlags = false;
BRPVP_buildingAwayFromFlagEasyDestroy = true;
BRPVP_flagsAreasIntersectionAllowed = 0.2;
*/

//BASE CONSTRUCTION CONFIGURATION - FREE MODE
/*
BRPVP_friendBuildingsPercentageToBuild = 0.5;
BRPVP_interactiveBuildingsGodMode = true;
BRPVP_makeAllBuildingsInteractive = false;
BRPVP_sellFlagOnTrader = false;
BRPVP_flagVehiclesGodModeWhenEmpty = false;
BRPVP_flagBuildingsGodMode = false;
BRPVP_allowBuildingsAwayFromFlags = true;
BRPVP_buildingAwayFromFlagEasyDestroy = false;
BRPVP_flagsAreasIntersectionAllowed = 0.2;
*/

//CONFIGURATION
BRPVP_travelingAidPriceLevel = 0.7;
BRPVP_playerLifeMultiplier = 1.65;
BRPVP_noBuildDistInSafeZones = 500;
BRPVP_playerCurePlacesCoolDown = 600;
BRPVP_killedVehicleLootSavePercentage = [0.4,0.6,0.5,0.7]; //[mags,items,weapons,bags] PERCENTAGE OF ITEM TYPE THAT DONT GET DESTROYED WITH VEHICLES
BRPVP_atmClasses = ["Land_Atm_01_F","Land_Atm_02_F"];
BRPVP_maxDistanceToGiveHandMoney = 2.5; //IN METERS
BRPVP_maxPlayerDeadBodyCount = 3;
BRPVP_maxPlayerDeadBodyTime = 3600; //IN SECONDS
BRPVP_combatTimeLength = 30; //IN SECONDS
BRPVP_turretHeadDamageToDie = 30; //DEFAULT IS 30
BRPVP_afterDieMaxSpawnCounterInSeconds = 60;
BRPVP_binocularToIgnoreAsWeapon = ["Binocular","Rangefinder"];
BRPVP_dismantleRespawnPrice = 10000;
BRPVP_rulesList = [
	"01 - Prezamos pelo respeito mútuo de todos. Não aturamos xingamentos ou preconceitos, seja qual for, terá punição.",
	"02 - O uso de qualquer tipo de programa externo (macro/dup/xiter) para vantagem em jogo, é rigorosamente proibido.",
	"03 - É proibido VDM (atropelar), homicídio, render e roubar os players APENAS nas SafeZones. Porém, veículos são liberados para roubo.",
	"04 - PVP só será permitido 100m de distância de SafeZones.",
	"05 - A STAFF do server é desenvolvida para conceder suporte em geral e manter tudo nos conformes. Entretanto, caso veja alguma ação suspeita (com evidências). Não fique calado, denuncie aos superiores!",
	"06 - 'Griefing' - Construção sem utilidade com ação maléfica à outras construções (Ex: Interromper passagens de BR's/Bases/etc). Não é permitido e terá punição.",
	"07 - Usar de Bug's do Jogo para vantagem própria é proíbido e levará a punição.",
	"08 - Se tens conhecimento das regras e presenciar uma ação contra-regras de outro player e não denunciar, poderá se prejudicar e ser punido.",
	"09 - Entrar em um veículo antes que o proprietário tenha tempo de fechar, é proibido.",
	"10 - Falar nos canais: Side, lado e global, é proibido. Apenas escrita."
];
BRPVP_autoTurretTypes = ["I_HMG_01_high_F","I_HMG_01_F","I_static_AT_F"];
BRPVP_autoTurretTypesOnFoot = ["LMG_Mk200_F","LMG_Mk200_F","launch_I_Titan_short_F"];
BRPVP_autoTurretOnMan = ["I_HMG_01_high_F","I_HMG_01_F"];
BRPVP_autoTurretOnLandVehicle = ["I_HMG_01_high_F","I_HMG_01_F"];
BRPVP_autoTurretOnArmoredLandVehicle = ["I_HMG_01_high_F","I_HMG_01_F","I_static_AT_F"];
BRPVP_autoTurretOnHeavlyArmoredLandVehicle = ["I_static_AT_F"];
BRPVP_autoTurretOnAirVehicle = ["I_HMG_01_high_F","I_HMG_01_F"];
BRPVP_fullMoonNights = true;
BRPVP_fullMoonNightsChance = 0.5;
BRPVP_TsUrl = "ts.brpvp.com";
BRPVP_serverLastChanges = "[X] Change 1\n[X] Change 2\n[X] Change 3";
BRPVP_serverNextChanges = "[ ] Next Change 1\n[ ] Next Change 2\n[ ] Next Change 3";
BRPVP_stayOnlineMoneyRewardValor = 6000;
BRPVP_stayOnlineMoneyRewardInterval = 10800; //IN SECONDS
BRPVP_stayOnlineMoneyRewardExtraCycle = 2;
BRPVP_stayOnlineMoneyRewardExtraValor = 12000;

BRPVP_timeOnlineToCountConnection = 60; //ONLY HAVE EFFECT IN NO-DB MODE (SAVE ON PROFILENAMESPACE)
BRPVP_massSaveCycle = 60;
BRPVP_playerModel = "O_Soldier_F"; //THIS IS THE MODEL THAT PLAYERS USE. IT CANT BE USED BY AI OR NPCS.
BRPVP_survivalTimeOnDisconnect = 15;
BRPVP_terrainShowDistanceLimit = 2000;
BRPVP_sellPricesMultiplier = 0.15; //PLAYER SELL PRICES CUT
BRPVP_restartTimes = [6,12,18,24]; //RESTART HOURS IN 24H FORMAT
BRPVP_restartWarnings = [30,20,15,10,5,1]; //RESTART WARNINGS TO BE SHOW X MINUTES BEFORE RESTART (X <= 30)
BRPVP_tempoDeVeiculoTemporarioNascimento = 1200;
BRPVP_veiculoTemporarioNascimento = "C_Quadbike_01_F";
BRPVP_servidorQPS = 0;
BRPVP_lootMult = 1;
BRPVP_timeMultiplier = 24;
BRPVP_fasterNights = true;

//AI GROUPS
BRPVP_patrolAIGroups = [
	(configFile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry"),
	(configFile >> "CfgGroups" >> "West" >> "Guerilla" >> "Support"),
	(configFile >> "CfgGroups" >> "Indep" >> "IND_C_F" >> "Infantry")
];

//MORE CONFIGURATION - FOR DEDICATED SERVER ONLY
if (isDedicated) then {
	BRPVP_rulesRequireAccept = true;
	BRPVP_startingMoney = 10000;
	BRPVP_startingMoneyOnBank = 200000;
	BRPVP_towLandVehiclePrice = 1000;
	BRPVP_marketPricesMultiply = 1;
	BRPVP_moneyForMissionBoxContentMultiply = 2;
	BRPVP_missionLootChanceOfRareItemsPerBox = [0.01,0.02];
	BRPVP_viewDist = 1500;
	BRPVP_viewObjsDist = 1500;
	BRPVP_viewDistList = [650,750,1000,1250,1500,2000,2500,3000,4000,5000];
	BRPVP_viewObjsDistList = [650,750,1000,1250,1500,1700,1900,2100,2400,2700];
	BRPVP_terrainGrid = 25;
	publicVariable "BRPVP_rulesRequireAccept";
	publicVariable "BRPVP_startingMoney";
	publicVariable "BRPVP_startingMoneyOnBank";
	publicVariable "BRPVP_towLandVehiclePrice";
	publicVariable "BRPVP_marketPricesMultiply";
	publicVariable "BRPVP_viewDist";
	publicVariable "BRPVP_viewObjsDist";
	publicVariable "BRPVP_viewDistList";
	publicVariable "BRPVP_viewObjsDistList";
	publicVariable "BRPVP_terrainGrid";
};

//MORE CONFIGURATION - FOR PLAYERS RUNING A LISTEM SERVER
if (isServer && hasInterface) then {
	BRPVP_rulesRequireAccept = false;
	BRPVP_startingMoney = 20000;
	BRPVP_startingMoneyOnBank = 200000;
	BRPVP_towLandVehiclePrice = 500;
	BRPVP_marketPricesMultiply = 0.5;
	BRPVP_moneyForMissionBoxContentMultiply = 2;
	BRPVP_missionLootChanceOfRareItemsPerBox = [0.05,0.1];
	BRPVP_viewDist = 1000;
	BRPVP_viewObjsDist = 1000;
	BRPVP_viewDistList = [650,750,1000,1250,1500,2000,2500,3000,4000,5000];
	BRPVP_viewObjsDistList = [650,750,1000,1250,1500,1700,1900,2100,2400,2700];
	BRPVP_terrainGrid = 50;
	publicVariable "BRPVP_rulesRequireAccept";
	publicVariable "BRPVP_startingMoney";
	publicVariable "BRPVP_startingMoneyOnBank";
	publicVariable "BRPVP_towLandVehiclePrice";
	publicVariable "BRPVP_marketPricesMultiply";
	publicVariable "BRPVP_viewDist";
	publicVariable "BRPVP_viewObjsDist";
	publicVariable "BRPVP_viewDistList";
	publicVariable "BRPVP_viewObjsDistList";
	publicVariable "BRPVP_terrainGrid";
};

//NORMAL PLAYERS WAIT FOR SERVER/LISTEM_SERVER TO DEFINE ALL VARS
if (!isServer && hasInterface) then {
	waitUntil {!isNil "BRPVP_terrainGrid"};
};

//RADAR SPOTS
_antennasVanilla = ["Land_TTowerSmall_1_F","Land_TTowerSmall_2_F","Land_TTowerBig_1_F","Land_TTowerBig_2_F"];
_antennasVanillaForce = [[1200,0.1,5],[800,0.025,2],[2250,0.1,5],[1500,0.025,2]];
_antennasCustom = [];
_antennasCustomForce = [];
BRPVP_antennasObjs = _antennasVanilla + _antennasCustom;
BRPVP_antennasObjsForce = _antennasVanillaForce + _antennasCustomForce;

//SHOW PORTUGUESE IMAGES ONLY IF LANGUAGE IS PORTUGUESE
if (localize "str_language_is_portuguese" == "true") then {
	BRPVP_mapLegendSize = 1.15;
	BRPVP_showTutorialFlag = true;
} else {
	BRPVP_mapLegendSize = 0;
	BRPVP_showTutorialFlag = false;
};