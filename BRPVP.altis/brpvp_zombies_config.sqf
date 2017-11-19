//BRPVP ZOMBIES
BRPVP_zombiesClasses = [
	"C_man_polo_1_F_afro",
	"C_man_polo_1_F_euro",
	"C_man_polo_1_F_asia"
];
BRPVP_zombieMotherClass = "C_man_polo_1_F";
BRPVP_zombiesUniforms = [
	"U_IG_Guerilla2_1",
	"U_IG_Guerilla2_2",
	"U_IG_Guerilla2_3",
	"U_IG_Guerilla3_1",
	"U_IG_Guerilla3_2",
	"U_IG_leader",
	"U_BG_Guerilla1_1",
	"U_I_G_resistanceLeader_F",
	"U_B_survival_uniform",
	"U_B_CTRG_2",
	"U_I_OfficerUniform",
	"U_I_CombatUniform_shortsleeve",
	"U_I_pilotCoveralls",
	"U_B_CTRG_3",
	"U_BasicBody",
	"U_OrestesBody",
	"U_I_Wetsuit",
	"U_C_Poor_1",
	"U_NikosAgedBody",
	"U_C_HunterBody_grn",
	"U_C_WorkerCoveralls",
	"U_B_GhillieSuit"
];
BRPVP_fixedZombiesAgregateProximityCheck = 40;
BRPVP_zombiesCaughByCarChanceToExplode = 0.25;
BRPVP_zombiesHostOnServerRatio = 4; //FOR EACH X ZOMBIES 1 WILL BE HOSTED ON SERVER
BRPVP_zombiesResistence = 4; //DEFAULT IS 4
BRPVP_percentageOfJumpingZombies = 0.3;
BRPVP_kneelingZombieJumpPercentage = 0.3;

//ZOMBIE DISTRACTION
BRPVP_zombieDistanceFromSmokeToCatchAttention = 25;
BRPVP_zombieDistractAmmo = [
	//SLUG
	"G_40mm_Smoke",
	"G_40mm_SmokeRed",
	"G_40mm_SmokeGreen",
	"G_40mm_SmokeYellow",
	"G_40mm_SmokePurple",
	"G_40mm_SmokeBlue",
	"G_40mm_SmokeOrange",
	//SMOKE
	"SmokeShell",
	"SmokeShellRed",
	"SmokeShellGreen",
	"SmokeShellYellow",
	"SmokeShellPurple",
	"SmokeShellBlue",
	"SmokeShellOrange",
	//GRENADE
	"GrenadeHand",
	"mini_Grenade",
	//AP MINES
	"APERSMine_Range_Ammo",
	"APERSBoundingMine_Range_Ammo",
	//"SLAMDirectionalMine_Wire_Ammo",
	"APERSTripMine_Wire_Ammo",
	"ClaymoreDirectionalMine_Remote_Ammo",
	//CHARGES
	"SatchelCharge_Remote_Ammo",
	"DemoCharge_Remote_Ammo"
	//"IEDUrbanBig_Remote_Ammo",
	//"IEDLandBig_Remote_Ammo",
	//"IEDUrbanSmall_Remote_Ammo",
	//"IEDLandSmall_Remote_Ammo",
];
BRPVP_maxZombiesPerSmokeShell = [/*SLUG*/2,2,2,2,2,2,2,/*SMOKE*/2,2,2,2,2,2,2,/*GRENADE*/2,2,/*AP MINES*/3,3,3,3,/*CHARGES*/4,4];
BRPVP_maxZombiesPerSmokeShellUniqueMult = 1.5; //UNIQUE ZOMBIES CATCH BY SMOKE IS: BRPVP_maxZombiesPerSmokeShell * BRPVP_maxZombiesPerSmokeShellUniqueMult

//ZOMBIE SPAWN
BRPVP_zombieFactorLimit = 20;
BRPVP_zombieCoolDown = 180;
BRPVP_zombieSpawnTemplate = [
	[2,"HouseDestrSmokeLongSmall",5,4,[8,8,8,2,8],[1]],
	[3,"HouseDestrSmokeLongSmall",5,4,[8,8,8,2,8],[1]],
	[3,"HouseDestrSmokeLongSmall",5,4,[8,8,8,2,8],[1]],
	[3,"HouseDestrSmokeLongSmall",5,4,[8,8,8,2,8],[1]],
	[4,"HouseDestrSmokeLongSmall",5,4,[8,8,8,2,8],[1]],
	[4,"HouseDestrSmokeLongSmall",5,4,[8,8,8,2,8],[1]]
];

//MAX ZOMBIES ARROUND
BRPVP_zombieMaxLocalPerPlayer = 5;
BRPVP_zombieMaxLocal = 15;

//FIXED ZOMBIES ON DEDICATED SERVER
if (isDedicated) then {
	BRPVP_fixedZombiesAmount = [
		[[1],[30],150,["NameCityCapital","NameCity","NameVillage"]],
		[[2],[45],200,["NameCityCapital","NameCity","NameVillage"]],
		[[3],[60],250,["NameCityCapital","NameCity","NameVillage"]],
		[[4,5],[100,150],300,["NameCityCapital","NameCity","NameVillage"]]
	];
	BRPVP_fixedZombiesReviveTime = 600; //SECONDS TO A FIXED ZOMBIE TO REVIVE, THEY ONLY REVIVE IF THERE IS NO PLAYER NEAR
};

//FIXED ZOMBIES ON LISTEN SERVER
if (isServer && hasInterface) then {
	BRPVP_fixedZombiesAmount = [
		[[2],[45],200,["NameCityCapital","NameCity","NameVillage"]]
	];
	BRPVP_fixedZombiesReviveTime = 600; //SECONDS TO A FIXED ZOMBIE TO REVIVE, THEY ONLY REVIVE IF THERE IS NO PLAYER NEAR
};