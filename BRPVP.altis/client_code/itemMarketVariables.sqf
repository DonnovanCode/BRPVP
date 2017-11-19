diag_log "[BRPVP FILE] variaveis_mercado.sqf INITIATED";
 
//INDICES DE VENDA
BRPVP_mercadorIdc1 = -1;
BRPVP_mercadorIdc2 = -1;
BRPVP_mercadorIdc3 = -1;
 
//DEPARTAMENTOS
BRPVP_mercadoNomes = [
    localize "str_mkt_main0",
    localize "str_mkt_main1",
    localize "str_mkt_main2",
    localize "str_mkt_main3",
    localize "str_mkt_main4",
    localize "str_mkt_main5",
    localize "str_mkt_main6",
    localize "str_mkt_main7",
    localize "str_mkt_main8",
    localize "str_mkt_main9",
    localize "str_mkt_main10",
    localize "str_mkt_main11",
    localize "str_mkt_main12",
    localize "str_mkt_main13",
    localize "str_mkt_main14",
    localize "str_mkt_main15",
    localize "str_mkt_main16",
    localize "str_mkt_main17"
];
_constructions = if (BRPVP_sellFlagOnTrader) then {
	[localize "str_mkt_sub16_0",localize "str_mkt_sub16_1",localize "str_mkt_sub16_2",localize "str_mkt_sub16_3",localize "str_mkt_sub16_4",localize "str_mkt_sub16_5",localize "str_mkt_sub16_6",localize "str_mkt_sub16_7"]
} else {
	[localize "str_mkt_sub16_0",localize "str_mkt_sub16_1",localize "str_mkt_sub16_2",localize "str_mkt_sub16_3",localize "str_mkt_sub16_4",localize "str_mkt_sub16_5",localize "str_mkt_sub16_6"]
};
BRPVP_mercadoNomesNomes = [
    [localize "str_mkt_sub0_0",localize "str_mkt_sub0_1",localize "str_mkt_sub0_2",localize "str_apex_dlc"],
    [localize "str_mkt_sub1_0",localize "str_mkt_sub1_1",localize "str_mkt_sub1_2"],
    [localize "str_mkt_sub2_0",localize "str_mkt_sub2_1",localize "str_mkt_sub2_2"],
    [localize "str_a3_vanilla",localize "str_apex_dlc"],
    [localize "str_a3_vanilla",localize "str_marksman",localize "str_apex_dlc"],
    [localize "str_a3_vanilla"],
    [localize "str_mkt_sub6_0",localize "str_mkt_sub6_1"],
    [localize "str_mkt_sub7_0"],
    [localize "str_mkt_sub8_0",localize "str_mkt_sub8_1"],
    [localize "str_a3_vanilla",localize "str_marksman"],
    [localize "str_mkt_sub10_0",localize "str_mkt_sub10_1"],
    [localize "str_mkt_sub11_0",localize "str_mkt_sub11_1"],
    [localize "str_mkt_sub12_0",localize "str_mkt_sub12_1",localize "str_apex_dlc"],
    [localize "str_mkt_sub13_0",localize "str_mkt_sub13_1"],
    [localize "str_mkt_sub14_0",localize "str_mkt_sub14_1",localize "str_mkt_sub14_2"],
    ["556 545 762 650 050"],
    _constructions + BRPVP_mercadoNomesNomesConstructionExtra,
    ["Extra Items"]
];
BRPVP_mercadoNomesNomesFilter = [
    [[0,1,2],[0,1,2],[0,2],[0]],
 	[[0,1],[0],[0]],
	[[0,1,2],[0],[0]],
    [[0,1],[0]],
    [[0],[0],[0]],
    [[0,1,2]],
    [[0],[0]],
    [[0,1,2]],
    [[0,1],[0]],
    [[0],[0]],
    [[0,1,2],[0]],
    [[0,1,2],[0,1]],
    [[0,2],[0,2],[0,2]],
    [[0],[0]],
    [[0],[0,2],[0,1,2]],
    [[0,1]],
    [[0],[0],[0],[0,2],[0],[0],[0],[0]] + BRPVP_mercadoNomesNomesConstructionExtra,
    [[]]
];
 
//LOJA PADRAO
BRPVP_mercadoresEstoque = [
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Brogda"],
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Dazos"],
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Lamaul"],
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Soros"],
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Balior"],
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Baiano's"],
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Norberg"],
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Famus"],
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Silva"],
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Bob"],
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Tarkov"],
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Ginard"],
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Mr. Butt"],
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Darjna"],
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Kerk"],
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Fantasia"],
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Millard"],
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Tortein"],
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Grazza"],
    [[0,1,2,11,5,3,6,4,7,15,8,9,13,10,12,14,16],"Sonderj"],
	[[0,2,5,7,10,11,12,14,16],"Pipo's"]
];
BRPVP_mercadoPrecos = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
BRPVP_mercadoPrecos = BRPVP_mercadoPrecos apply {_x * BRPVP_marketPricesMultiply};
 
//SPECIAL ITEMS
BRPVP_specialItems = [
    "BRP_kitLight",
    "BRP_kitCamuflagem",
    "BRP_kitAreia",
    "BRP_kitCidade",
    "BRP_kitStone",
    "BRP_kitCasebres",
    "BRP_kitConcreto",
    "BRP_kitPedras",
    "BRP_kitTorres",
    "BRP_kitEspecial",
    "BRP_kitTableChair",
    "BRP_kitBeach",
    "BRP_kitReligious",
    "BRP_kitStuffo1",
    "BRP_kitStuffo2",
    "BRP_kitLamp",
    "BRP_kitRecreation",
    "BRP_kitMilitarSign",
    "BRP_kitFuelStorage",
    "BRP_kitWrecks",
    "BRP_kitSmallHouse",
    "BRP_kitAverageHouse",
    "BRP_kitAntennaA",
    "BRP_kitAntennaB",
    "BRP_kitMovement",
    "BRP_kitRespawnA",
    "BRP_kitRespawnB",
    "BRP_kitHelipad",
    "BRP_kitAutoTurret",
	"BRP_kitFlags25",
	"BRP_kitFlags50",
	"BRP_kitFlags100",
	"BRP_kitFlags200"
] + BRPVP_specialItemsExtra;
 
//SPECIAL ITEMS NAMES
BRPVP_specialItemsNames = [
    localize "str_mkt_cons0",
    localize "str_mkt_cons1",
    localize "str_mkt_cons2",
    localize "str_mkt_cons3",
    localize "str_mkt_cons4",
    localize "str_mkt_cons5",
    localize "str_mkt_cons6",
    localize "str_mkt_cons7",
    localize "str_mkt_cons8",
    localize "str_mkt_cons9",
    localize "str_mkt_cons10",
    localize "str_mkt_cons11",
    localize "str_mkt_cons12",
    localize "str_mkt_cons13",
    localize "str_mkt_cons14",
    localize "str_mkt_cons15",
    localize "str_mkt_cons16",
    localize "str_mkt_cons17",
    localize "str_mkt_cons18",
    localize "str_mkt_cons19",
    localize "str_mkt_cons20",
    localize "str_mkt_cons21",
    localize "str_mkt_cons22",
    localize "str_mkt_cons23",
    localize "str_mkt_cons24",
    localize "str_mkt_cons25",
    localize "str_mkt_cons26",
    localize "str_mkt_cons27",
    localize "str_mkt_cons28",
	localize "str_mkt_cons29",
	localize "str_mkt_cons30",
	localize "str_mkt_cons31",
	localize "str_mkt_cons32"
] + BRPVP_specialItemsNamesExtra;
 
//SPECIAL ITEMS IMAGES
BRPVP_specialItemsImages = [
    "BRP_imagens\items\BRP_kitLight.paa",
    "BRP_imagens\items\BRP_kitCamuflagem.paa",
    "BRP_imagens\items\BRP_kitAreia.paa",
    "BRP_imagens\items\BRP_kitCidade.paa",
    "BRP_imagens\items\BRP_kitStone.paa",
    "BRP_imagens\items\BRP_kitCasebres.paa",
    "BRP_imagens\items\BRP_kitConcreto.paa",
    "BRP_imagens\items\BRP_kitPedras.paa",
    "BRP_imagens\items\BRP_kitTorres.paa",
    "BRP_imagens\items\BRP_kitEspecial.paa",
    "BRP_imagens\items\BRP_kitTableChair.paa",
    "BRP_imagens\items\BRP_kitBeach.paa",
    "BRP_imagens\items\BRP_kitReligious.paa",
    "BRP_imagens\items\BRP_kitStuffo1.paa",
    "BRP_imagens\items\BRP_kitStuffo2.paa",
    "BRP_imagens\items\BRP_kitLamp.paa",
    "BRP_imagens\items\BRP_kitRecreation.paa",
    "BRP_imagens\items\BRP_kitMilitarSign.paa",
    "BRP_imagens\items\BRP_kitFuelStorage.paa",
    "BRP_imagens\items\BRP_kitWrecks.paa",
    "BRP_imagens\items\BRP_kitSmallHouse.paa",
    "BRP_imagens\items\BRP_kitAverageHouse.paa",
    "BRP_imagens\items\BRP_kitAntennaA.paa",
    "BRP_imagens\items\BRP_kitAntennaB.paa",
    "BRP_imagens\items\BRP_kitMovement.paa",
    "BRP_imagens\items\BRP_kitRespawnA.paa",
    "BRP_imagens\items\BRP_kitRespawnB.paa",
    "BRP_imagens\items\BRP_kitHelipad.paa",
    "BRP_imagens\items\BRP_kitAutoTurret.paa",
	"BRP_imagens\items\BRP_kitFlags25.paa",
	"BRP_imagens\items\BRP_kitFlags50.paa",
	"BRP_imagens\items\BRP_kitFlags100.paa",
	"BRP_imagens\items\BRP_kitFlags200.paa"
] + BRPVP_specialItemsImagesExtra;
 
//PRODUTOS
BRPVP_mercadoItens = [
    //BAGS LEGAIS
    [0,0,0,"B_AssaultPack_blk",5200],
    [0,0,1,"B_AssaultPack_khk",5200],
    [0,0,2,"B_AssaultPack_rgr",5200],
    [0,0,3,"B_AssaultPack_sgg",5400],
    [0,0,4,"B_AssaultPack_dgtl",5400],
 
    //BAGS PRO
    [0,1,0,"C_Bergen_blu",5600],
    [0,1,1,"C_Bergen_grn",5600],
    [0,1,2,"C_Bergen_red",5600],
    [0,1,3,"B_TacticalPack_mcamo",6800],
    [0,1,4,"B_TacticalPack_ocamo",6850],
 
    //BAGS SUPER
    [0,2,0,"B_Carryall_oli",7000],
    [0,2,1,"B_Carryall_oucamo",7000],
    [0,2,2,"B_Carryall_khk",7000],
    [0,2,3,"B_Carryall_mcamo",7100],
    [0,2,4,"B_Carryall_ocamo",7150],
 
    //BAGS SUPER (APEX DLC)
    [0,3,0,"B_ViperLightHarness_blk_F",10000],
    [0,3,1,"B_ViperLightHarness_ghex_F",10000],
    [0,3,2,"B_ViperLightHarness_hex_F",10000],
    [0,3,3,"B_ViperLightHarness_khk_F",10000],
    [0,3,4,"B_ViperLightHarness_oli_F",10000],
    [0,3,5,"B_ViperHarness_blk_F",11500],
    [0,3,6,"B_ViperHarness_ghex_F",11500],
    [0,3,7,"B_ViperHarness_hex_F",11500],
    [0,3,8,"B_ViperHarness_khk_F",11500],
    [0,3,9,"B_ViperHarness_oli_F",11500],
    [0,3,10,"B_Bergen_mcamo_F",15000],
    [0,3,11,"B_Bergen_dgtl_F",15000],
    [0,3,12,"B_Bergen_hex_F",15000],
    [0,3,13,"B_Bergen_tna_F",15000],
 
    //UNIFORMES PADRAO
    [1,0,0,"U_O_CombatUniform_ocamo",3200],
    [1,0,1,"U_O_PilotCoveralls",3200],
    [1,0,2,"U_O_CombatUniform_oucamo",3200],
    [1,0,3,"U_O_SpecopsUniform_ocamo",3200],
    [1,0,4,"U_O_SpecopsUniform_blk",3200],
    [1,0,5,"U_O_OfficerUniform_ocamo",3200],
    [1,0,6,"U_O_T_Soldier_F",6200],
    [1,0,7,"U_O_T_Officer_F",6200],
    [1,0,8,"U_O_V_Soldier_Viper_F",7200],
    [1,0,9,"U_O_V_Soldier_Viper_hex_F",7200],
    [1,0,10,"U_O_Protagonist_VR",7500],

    //UNIFORMES ESPECIAIS
    [1,1,0,"U_O_Wetsuit",10000],
    [1,1,1,"U_O_T_Sniper_F",11000],
    [1,1,2,"U_O_GhillieSuit",11000],
    [1,1,3,"U_O_FullGhillie_lsh",15000],
    [1,1,4,"U_O_FullGhillie_sard",15000],
    [1,1,5,"U_O_FullGhillie_ard",15000],
    [1,1,6,"U_O_T_FullGhillie_tna_F",15500],
 
    //CAPACETES
    [1,2,0,"H_Cap_red",1000],
    [1,2,1,"H_Cap_blu",1000],
    [1,2,2,"H_Cap_oli",1000],
    [1,2,3,"H_Cap_tan",1000],
    [1,2,4,"H_Cap_blk",1000],
    [1,2,5,"H_Cap_grn",1000],
    [1,2,6,"H_Watchcap_camo",3500],
    [1,2,7,"H_PilotHelmetHeli_O",4000],
    [1,2,8,"H_Shemag_olive",4500],
    [1,2,9,"H_PilotHelmetFighter_O",10000],
    [1,2,10,"H_HelmetB_snakeskin",15000],
    [1,2,11,"H_HelmetO_ocamo",25000],
    [1,2,12,"H_HelmetLeaderO_ocamo",50000],
 
    //VESTS BOLSOS
    [2,0,0,"V_Chestrig_blk",5500],
    [2,0,1,"V_Chestrig_khk",5500],
    [2,0,2,"V_Chestrig_oli",5500],
    [2,0,3,"V_Chestrig_rgr",5500],
 
    //VESTS LIGHT ARMOR
    [2,2,0,"V_TacVest_blk_POLICE",10000],
    [2,1,1,"V_PlateCarrier_Kerry",15000],
    [2,1,2,"V_PlateCarrierIA2_dgtl",25000],
    [2,1,3,"V_PlateCarrier2_rgr",35000],

    //VESTS ULTRA HEAVY
    [2,2,0,"V_PlateCarrierGL_rgr",40000],
    [2,2,1,"V_PlateCarrierIAGL_dgtl",42000],
    [2,2,2,"V_PlateCarrierSpec_rgr",55000],

    //ASSAULT RIFLES
    [3,0,0,"arifle_Katiba_F",70000],
    [3,0,1,"arifle_MX_F",80000],
    [3,0,2,"arifle_MX_SW_F",95000],
    [3,0,3,"arifle_TRG20_F",65000],
    [3,0,4,"arifle_Mk20_GL_F",65000],
    [3,0,5,"arifle_TRG21_GL_F",75000],
 
    //ASSAULT RIFLES (APEX DLC)
    [3,1,0,"arifle_AKS_F",60000],
    [3,1,1,"arifle_AK12_F",100000],
    [3,1,2,"arifle_AK12_GL_F",110000],
    [3,1,3,"arifle_AKM_F",105000],
    [3,1,4,"arifle_AKM_FL_F",105000],
    [3,1,5,"arifle_ARX_blk_F",112500],
    [3,1,6,"arifle_ARX_hex_F",112500],
    [3,1,7,"arifle_ARX_ghex_F",112500],
    [3,1,8,"arifle_SPAR_01_blk_F",80000],
    [3,1,9,"arifle_SPAR_01_khk_F",80000],
    [3,1,10,"arifle_SPAR_01_snd_F",80000],
    [3,1,11,"arifle_SPAR_01_GL_blk_F",85000],
    [3,1,12,"arifle_SPAR_01_GL_khk_F",85000],
    [3,1,13,"arifle_SPAR_01_GL_snd_F",85000],
    [3,1,14,"arifle_SPAR_02_blk_F",95000],
    [3,1,15,"arifle_SPAR_02_khk_F",95000],
    [3,1,15,"arifle_SPAR_02_snd_F",95000],
 
    //SNIPER RIFLES
    [4,0,0,"srifle_DMR_01_F",150000],
    [4,0,1,"srifle_EBR_F",170000],
    [4,0,2,"srifle_GM6_F",200000],
    [4,0,3,"srifle_LRR_F",200000],
    [4,0,4,"srifle_GM6_camo_F",210000],
    [4,0,5,"srifle_LRR_camo_F",210000],
 
    //SNIPER RIFLES (MARSKMAN DLC)
    [4,1,0,"srifle_DMR_02_F",200000],
    [4,1,1,"srifle_DMR_02_camo_F",205000],
    [4,1,2,"srifle_DMR_02_sniper_F",205000],
    [4,1,3,"srifle_DMR_03_F",150000],
    [4,1,4,"srifle_DMR_03_khaki_F",155000],
    [4,1,5,"srifle_DMR_03_tan_F",155000],
    [4,1,6,"srifle_DMR_03_multicam_F",155000],
    [4,1,7,"srifle_DMR_03_woodland_F",155000],
    [4,1,8,"srifle_DMR_05_blk_F",190000],
    [4,1,9,"srifle_DMR_05_hex_F",195000],
    [4,1,10,"srifle_DMR_05_tan_f",195000],
    [4,1,11,"srifle_DMR_06_camo_F",140000],
    [4,1,12,"srifle_DMR_06_olive_F",140000],
 
    //SNIPER RIFLES (APEX DLC)
    [4,2,0,"srifle_DMR_07_blk_F",125000],
    [4,2,1,"srifle_DMR_07_hex_F",130000],
    [4,2,2,"srifle_DMR_07_ghex_F",130000],
    [4,2,3,"arifle_SPAR_03_blk_F",137500],
    [4,2,4,"arifle_SPAR_03_khk_F",140000],
    [4,2,5,"arifle_SPAR_03_snd_F",140000],
 
    //PISTOLAS
    [5,0,0,"hgun_ACPC2_F",22000],
    [5,0,1,"hgun_Pistol_heavy_01_F",22000],
    [5,0,2,"hgun_Pistol_heavy_02_F",22000],
 
    //MACHINE GUNS
    [6,0,0,"arifle_MX_SW_F",90000],
    [6,0,1,"LMG_03_F",150000],
    [6,0,2,"LMG_Mk200_F",170000],
    [6,0,3,"LMG_Zafir_F",200000],
    [6,1,0,"MMG_01_hex_F",185000],
    [6,1,1,"MMG_01_tan_F",185000],
    [6,1,2,"MMG_02_camo_F",170000],
    [6,1,3,"MMG_02_black_F",170000],
    [6,1,4,"MMG_02_sand_F",170000],
 
    //BASIC AMMO: 9.0 MM E .45
    [7,0,0,"16Rnd_9x21_Mag",275*0.5],
    [7,0,1,"30Rnd_9x21_Mag",500*0.5],
    [7,0,2,"6Rnd_45ACP_Cylinder",250*0.5],
    [7,0,3,"9Rnd_45ACP_Mag",200*0.5],
    [7,0,4,"11Rnd_45ACP_Mag",300*0.5],
 
    //MACHINE GUN AMMO: LIGHT MG / MEDIUM MG
    [8,0,0,"200Rnd_556x45_Box_F",3000],
    [8,0,1,"200Rnd_556x45_Box_Tracer_F",3150],
    [8,0,2,"200Rnd_65x39_cased_Box",3100],
    [8,0,3,"200Rnd_65x39_cased_Box_Tracer",3250],
    [8,0,4,"100Rnd_65x39_caseless_mag",2000],
    [8,0,5,"100Rnd_65x39_caseless_mag_Tracer",2150],
    [8,1,0,"150Rnd_762x54_Box",4000],
    [8,1,1,"150Rnd_762x54_Box_Tracer",4150],
    [8,1,2,"150Rnd_93x64_Mag",3300],
    [8,1,3,"130Rnd_338_Mag",3500],
 
    //SNIPER AMMO: PADRAO / MARKSMAN
    [9,0,0,"10Rnd_762x54_Mag",3500],
    [9,0,1,"20Rnd_762x51_Mag",3600],
    [9,0,2,"5Rnd_127x108_Mag",3750],
    [9,0,3,"5Rnd_127x108_APDS_Mag",4000],
    [9,0,4,"7Rnd_408_Mag",3800],
    [9,1,0,"20Rnd_650x39_Cased_Mag_F",3000],
    [9,1,1,"20Rnd_762x51_Mag",3200],
    [9,1,2,"10Rnd_338_Mag",2700],
    [9,1,3,"10Rnd_127x54_Mag",2700],
    [9,1,4,"10Rnd_93x64_DMR_05_Mag",2800],
 
    //OPTICS BASICO
    [10,0,0,"optic_Aco_smg",1200],
    [10,0,1,"optic_Holosight",1500],
    [10,0,2,"optic_Yorris",1250],
    [10,0,3,"optic_MRD",1250],
 
    //OPTICS M-RANGE
    [10,1,0,"optic_AMS",30000],
    [10,1,1,"optic_AMS_khk",32500],
    [10,1,2,"optic_AMS_snd",32500],
    [10,1,3,"optic_KHS_blk",25000],
    [10,1,4,"optic_KHS_hex",27500],
    [10,1,5,"optic_KHS_old",27500],
    [10,1,6,"optic_KHS_tan",27500],
    [10,1,7,"optic_DMS",35000],
    [10,1,8,"optic_SOS",30000],
    [10,1,9,"optic_NVS",32000],
    [10,1,10,"optic_Hamr",15000],
    [10,1,11,"optic_Arco",17500],
    [10,1,12,"optic_MRCO",12500],
    [10,1,13,"optic_LRPS",27000],

    //EQUIPAMENTOS
    [11,0,0,"ItemMap",250],
    [11,0,1,"Chemlight_green",300],
    [11,0,2,"ItemWatch",250],
    [11,0,3,"FirstAidKit",1750],
    [11,0,4,"ItemCompass",400],
    [11,1,0,"Binocular",1000],
    [11,1,1,"NVGoggles",2500],
    [11,1,2,"ItemGPS",1500],
    [11,1,3,"Rangefinder",3500],
    [11,1,4,"ToolKit",5000],
    [11,1,5,"MediKit",6500],
    //[11,1,6,"MineDetector",5],
 
    //ACESSORIOS ARMA SUPRESSORES
    [12,0,0,"muzzle_snds_338_black",20000],
    [12,0,1,"muzzle_snds_93mmg",18000],
    [12,0,2,"muzzle_snds_acp",15000],
    [12,0,3,"muzzle_snds_B",22000],
    [12,0,4,"muzzle_snds_H",20000],
    [12,0,5,"muzzle_snds_H_MG",20000],
    [12,0,6,"muzzle_snds_L",15000],
    [12,0,7,"muzzle_snds_M",20000],

    //ACESSORIOS ARMA OUTROS
    [12,1,0,"acc_flashlight",2500],
    [12,1,1,"acc_pointer_IR",4000],
 
    //ACESSORIOS ARMA SUPRESSORES (APEX DLC)
    [12,2,0,"muzzle_snds_H_snd_F",20000],
    [12,2,1,"muzzle_snds_58_blk_F",18000],
    [12,2,2,"muzzle_snds_m_snd_F",18000],
    [12,2,3,"muzzle_snds_B_snd_F",22000],
    [12,2,4,"muzzle_snds_58_wdm_F",20000],
    [12,2,5,"muzzle_snds_65_TI_blk_F",20000],
    [12,2,6,"muzzle_snds_H_MG_blk_F",20000],
 
    //LAUNCHERS
    [13,0,0,"launch_RPG32_F",25000],
    [13,0,1,"launch_NLAW_F",27000],
    //[13,0,2,"launch_Titan_F",40000],
    //[13,0,3,"launch_Titan_short_F",45000],
 
    //LAUNCHERS AMMO
    [13,1,0,"RPG32_F",2000],
    [13,1,1,"RPG32_HE_F",2500],
    [13,1,2,"NLAW_F",2750],
 
    //EXPLOSIVOS
    [14,0,0,"APERSTripMine_Wire_Mag",10000],
    [14,0,1,"APERSMine_Range_Mag",12200],
    [14,0,2,"ATMine_Range_Mag",20000],
    [14,0,3,"DemoCharge_Remote_Mag",10500],
    [14,0,4,"ClaymoreDirectionalMine_Remote_Mag",5500],

    //GRENADES
    [14,1,0,"B_IR_Grenade",2500],
    [14,1,1,"HandGrenade",2500],
    [14,1,2,"MiniGrenade",2000],
    [14,1,3,"SmokeShell",1500],
    [14,1,4,"SmokeShellOrange",1750],
    [14,1,5,"SmokeShellGreen",1750],
    [14,1,6,"SmokeShellPurple",1750],
    [14,1,7,"SmokeShellBlue",1750],
 
    //SLUGS
    [14,2,0,"1Rnd_HE_Grenade_shell",2000],
    [14,2,1,"3Rnd_HE_Grenade_shell",5000],
    [14,2,2,"1Rnd_Smoke_Grenade_shell",1200],
    [14,2,3,"1Rnd_SmokeOrange_Grenade_shell",1500],
    [14,2,4,"1Rnd_SmokeGreen_Grenade_shell",1500],
    [14,2,5,"1Rnd_SmokePurple_Grenade_shell",1500],
    [14,2,6,"1Rnd_SmokeBlue_Grenade_shell",1500],
 
    //ASSAULT RIFLE AMMO
    [15,0,0,"30Rnd_556x45_Stanag",1500],
    [15,0,1,"30Rnd_556x45_Stanag_Tracer_Red",1650],
    [15,0,2,"30Rnd_545x39_Mag_F",1500],
    [15,0,3,"30Rnd_545x39_Mag_Tracer_F",1650],
    [15,0,4,"30Rnd_65x39_caseless_mag",1600],
    [15,0,5,"30Rnd_65x39_caseless_mag_Tracer",1750],
    [15,0,6,"30Rnd_65x39_caseless_green",1500],
    [15,0,7,"30Rnd_65x39_caseless_green_mag_Tracer",1650],
    [15,0,8,"30Rnd_762x39_Mag_F",2000],
    [15,0,9,"30Rnd_762x39_Mag_Tracer_F",2150],
    [15,0,10,"10Rnd_50BW_Mag_F",3000],
    [15,0,11,"30Rnd_556x45_Stanag",1500],
    [15,0,12,"30Rnd_556x45_Stanag_green",1650],
    [15,0,13,"30Rnd_556x45_Stanag_Tracer_Red",105],
    [15,0,14,"150Rnd_556x45_Drum_Mag_F",3500],
    [15,0,15,"150Rnd_556x45_Drum_Mag_Tracer_F",3650],
	
    //CONSTRUCAO SIMPLES
    [16,0,0,"BRP_kitCamuflagem",7500],
    [16,0,1,"BRP_kitLight",5500],
    [16,0,2,"BRP_kitAreia",6000],
 
    //CONSTRUCAO FORTE
    [16,1,0,"BRP_kitCidade",1200],
    [16,1,1,"BRP_kitStone",1200],
    [16,1,2,"BRP_kitCasebres",15000],
    [16,1,3,"BRP_kitConcreto",1650],
 
    //CONSTRUCAO ESPECIAL
    [16,2,0,"BRP_kitPedras",10000],
    [16,2,1,"BRP_kitRespawnA",40000],
    [16,2,2,"BRP_kitRespawnB",45000],
    [16,2,3,"BRP_kitTorres",60000],
    [16,2,4,"BRP_kitAntennaA",25000],
    [16,2,5,"BRP_kitEspecial",30000],
    [16,2,6,"BRP_kitAntennaB",40000],
 
    //OBJECTS
    [16,3,0,"BRP_kitTableChair",1000],
    [16,3,1,"BRP_kitBeach",3500],
    [16,3,2,"BRP_kitStuffo1",4000],
    [16,3,3,"BRP_kitStuffo2",4500],
 
    //BASE USEFULL I
    [16,4,0,"BRP_kitMilitarSign",5500],
    [16,4,1,"BRP_kitLamp",6500],
    [16,4,2,"BRP_kitMovement",3500],
    [16,4,3,"BRP_kitFuelStorage",80500],
    [16,4,4,"BRP_kitAutoTurret",350000],
 
    //EXTRA STRUCTURES I
    [16,5,0,"BRP_kitWrecks",2500],
    [16,5,1,"BRP_kitRecreation",2500],
    [16,5,2,"BRP_kitHelipad",7000],
    [16,5,3,"BRP_kitReligious",35000],
 
    //HOUSAS
    [16,6,0,"BRP_kitSmallHouse",500000],
    [16,6,1,"BRP_kitAverageHouse",1000000], 

	//TERRAINS
	[16,7,0,"BRP_kitFlags25",250000],
	[16,7,1,"BRP_kitFlags50",500000],
	[16,7,2,"BRP_kitFlags100",1000000],
	[16,7,2,"BRP_kitFlags200",2000000],
 
    //EXTRA ITEMS
    [17,0,0,"ItemRadio",2000],
    [17,0,1,"hgun_P07_F",2500],
    [17,0,2,"SMG_02_F",4200],
    [17,0,3,"V_BandollierB_blk",3500],
    [17,0,4,"arifle_Mk20C_F",20000],
    [17,0,5,"arifle_Mk20_F",20000],
    [17,0,6,"hgun_PDW2000_F",3200],
    [17,0,7,"FlareYellow_F",3000],
    [17,0,8,"FlareWhite_F",2000],
    [17,0,9,"arifle_MXM_F",20000],
    [17,0,10,"H_HelmetIA",3200],
    [17,0,11,"V_TacVest_oli",3650],
    [17,0,12,"arifle_MXC_khk_F",20000],
    [17,0,13,"B_Kitbag_rgr_BTAA_F",3200],
    [17,0,14,"V_PlateCarrier1_tna_F",8500],
	[13,1,3,"Titan_AT",5500],
	[13,1,4,"Titan_AP",5500],
	[13,1,5,"Titan_AA",7500]
] + BRPVP_mercadoItensExtra;
 
//ONLY ITEM CLASSES
BRPVP_mercadoItensClass = [];
{
    BRPVP_mercadoItensClass pushBack (_x select 3);
} forEach BRPVP_mercadoItens;
diag_log ("[BRPVP MARKET] BRPVP_mercadoItensClass = " + str BRPVP_mercadoItensClass + ".");
 
//ITEMS CFG TYPE AND PARENTS
BRPVP_mercadoItensParents = [];
{
    private ["_item","_ic","_ip"];
    _item = _x select 3;
    if (_item in BRPVP_specialItems) then {
        _ic = 0;
        _ip = [];
    } else {
        if (isClass (configFile >> "CfgMagazines" >> _item)) then {
            _ic = 0;
            _ip = [configfile >> "CfgMagazines" >> _item,true] call BIS_fnc_returnParents;
        } else {
            if (isClass (configFile >> "CfgWeapons" >> _item)) then {
                _ic = 1;
                _ip = [configfile >> "CfgWeapons" >> _item,true] call BIS_fnc_returnParents;
            } else {
                if (isClass (configFile >> "CfgVehicles" >> _item)) then {
                    _ic = 2;
                    _ip = [configfile >> "CfgVehicles" >> _item,true] call BIS_fnc_returnParents;
                };
            };
        };
    };
    BRPVP_mercadoItensParents pushBack [_item,_ic,_ip];
} forEach BRPVP_mercadoItens;
diag_log ("[BRPVP MARKET] BRPVP_mercadoItensParents = " + str BRPVP_mercadoItensParents + ".");
 
diag_log "[BRPVP FILE] variaveis_mercado.sqf END REACHED";

//TEMP TEMP TRANSITION
BRPVP_mercadoPrecosTemp = [2,2,2,4+2,6+3,2,4+2,1.5,1.5,1.5,4,2,2,2+2,3,1.5,1,2];
BRPVP_mercadoItensTemp = [
	//BAGS LEGAIS
	[0,0,0,"B_AssaultPack_blk",165],
	[0,0,1,"B_AssaultPack_khk",165],
	[0,0,2,"B_AssaultPack_rgr",165],
	[0,0,3,"B_AssaultPack_sgg",200],
	[0,0,4,"B_AssaultPack_dgtl",200],

	//BAGS PRO
	[0,1,0,"C_Bergen_blu",330],
	[0,1,1,"C_Bergen_grn",330],
	[0,1,2,"C_Bergen_red",330],
	[0,1,3,"B_TacticalPack_mcamo",360],
	[0,1,4,"B_TacticalPack_ocamo",360],

	//BAGS SUPER
	[0,2,0,"B_Carryall_oli",500],
	[0,2,1,"B_Carryall_oucamo",500],
	[0,2,2,"B_Carryall_khk",500],
	[0,2,3,"B_Carryall_mcamo",530],
	[0,2,4,"B_Carryall_ocamo",530],

	//BAGS SUPER (APEX DLC)
	[0,3,0,"B_Bergen_mcamo_F",600],
	[0,3,1,"B_Bergen_dgtl_F",600],
	[0,3,2,"B_Bergen_hex_F",600],
	[0,3,3,"B_Bergen_tna_F",600],
	[0,3,4,"B_ViperHarness_blk_F",400],
	[0,3,5,"B_ViperHarness_ghex_F",400],
	[0,3,6,"B_ViperHarness_hex_F",400],
	[0,3,7,"B_ViperHarness_khk_F",400],
	[0,3,8,"B_ViperHarness_oli_F",400],
	[0,3,9,"B_ViperLightHarness_blk_F",300],
	[0,3,10,"B_ViperLightHarness_ghex_F",300],
	[0,3,11,"B_ViperLightHarness_hex_F",300],
	[0,3,12,"B_ViperLightHarness_khk_F",300],
	[0,3,13,"B_ViperLightHarness_oli_F",300],

	//UNIFORMES PADRAO
	[1,0,0,"U_O_CombatUniform_ocamo",150],
	[1,0,1,"U_O_PilotCoveralls",150],
	[1,0,2,"U_O_Wetsuit",150],
	[1,0,3,"U_O_CombatUniform_oucamo",150],
	[1,0,4,"U_O_SpecopsUniform_ocamo",150],
	[1,0,5,"U_O_SpecopsUniform_blk",150],
	[1,0,6,"U_O_OfficerUniform_ocamo",150],
	[1,0,9,"U_O_T_Soldier_F",150],
	[1,0,10,"U_O_T_Officer_F",150],
	[1,0,11,"U_O_T_Sniper_F",150],
	[1,0,12,"U_O_V_Soldier_Viper_F",150],
	[1,0,13,"U_O_V_Soldier_Viper_hex_F",150],

	//UNIFORMES ESPECIAIS
	[1,1,0,"U_O_GhillieSuit",800],
	[1,1,1,"U_O_FullGhillie_lsh",800],
	[1,1,2,"U_O_FullGhillie_sard",800],
	[1,1,3,"U_O_FullGhillie_ard",800],
	[1,1,4,"U_O_T_FullGhillie_tna_F",1000],

	//CAPACETES
	[1,2,0,"H_Cap_red",125],
	[1,2,1,"H_Cap_blu",125],
	[1,2,2,"H_Cap_oli",125],
	[1,2,3,"H_Cap_tan",125],
	[1,2,4,"H_Cap_blk",125],
	[1,2,5,"H_Cap_grn",125],
	[1,2,6,"H_Shemag_olive",220],
	[1,2,7,"H_Watchcap_camo",220],
	[1,2,8,"H_PilotHelmetHeli_O",300],
	[1,2,9,"H_PilotHelmetFighter_O",450],

	//VESTS BOLSOS
	[2,0,0,"V_Chestrig_blk",180],
	[2,0,1,"V_Chestrig_khk",180],
	[2,0,2,"V_Chestrig_oli",180],
	[2,0,3,"V_Chestrig_rgr",180],

	//VESTS LIGHT ARMOR
	[2,1,0,"V_PlateCarrier_Kerry",400],
	[2,1,1,"V_PlateCarrier2_rgr",400],
	[2,1,2,"V_PlateCarrierIA2_dgtl",440],

	//VESTS ULTRA HEAVY
	[2,2,0,"V_PlateCarrierGL_rgr",800],
	[2,2,1,"V_PlateCarrierIAGL_dgtl",800],
	[2,2,2,"V_TacVest_blk_POLICE",800],
	[2,2,3,"V_PlateCarrierSpec_rgr",1000],

	//ASSAULT RIFLES
	[3,0,0,"arifle_Katiba_F",600],
	[3,0,1,"arifle_MX_F",600],
	[3,0,2,"arifle_MX_SW_F",600],
	[3,0,3,"arifle_TRG20_F",600],
	[3,0,4,"arifle_Mk20_GL_F",600],
	[3,0,5,"arifle_TRG21_GL_F",600],

	//ASSAULT RIFLES (APEX DLC)
	[3,1,0,"arifle_AKS_F",600],
	[3,1,1,"arifle_AK12_F",660],
	[3,1,2,"arifle_AK12_GL_F",720],
	[3,1,3,"arifle_AKM_F",660],
	[3,1,4,"arifle_AKM_FL_F",720],
	[3,1,5,"arifle_ARX_blk_F",735],
	[3,1,6,"arifle_ARX_hex_F",735],
	[3,1,7,"arifle_ARX_ghex_F",735],
	[3,1,8,"arifle_SPAR_01_blk_F",600],
	[3,1,9,"arifle_SPAR_01_khk_F",600],
	[3,1,10,"arifle_SPAR_01_snd_F",600],
	[3,1,11,"arifle_SPAR_01_GL_blk_F",660],
	[3,1,12,"arifle_SPAR_01_GL_khk_F",660],
	[3,1,13,"arifle_SPAR_01_GL_snd_F",660],
	[3,1,14,"arifle_SPAR_02_blk_F",600],
	[3,1,15,"arifle_SPAR_02_khk_F",600],
	[3,1,15,"arifle_SPAR_02_snd_F",600],

	//PISTOLAS
	[5,0,0,"hgun_ACPC2_F",300],
	[5,0,1,"hgun_Pistol_heavy_01_F",360],
	[5,0,2,"hgun_Pistol_heavy_02_F",360],

	//MACHINE GUNS
	[6,0,0,"arifle_MX_SW_F",700],
	[6,0,1,"LMG_03_F",850],
	[6,0,2,"LMG_Mk200_F",1000],
	[6,0,3,"LMG_Zafir_F",1200],

	//BASIC AMMO: 9.0 MM E .45
	[7,0,0,"16Rnd_9x21_Mag",40],
	[7,0,1,"30Rnd_9x21_Mag",60],
	[7,0,2,"6Rnd_45ACP_Cylinder",40],
	[7,0,3,"9Rnd_45ACP_Mag",40],
	[7,0,4,"11Rnd_45ACP_Mag",50],

	//MACHINE GUN AMMO: LIGHT MG / MEDIUM MG
	[8,0,0,"200Rnd_556x45_Box_F",150],
	[8,0,1,"200Rnd_556x45_Box_Tracer_F",150],
	[8,0,2,"200Rnd_65x39_cased_Box",180],
	[8,0,3,"200Rnd_65x39_cased_Box_Tracer",200],
	[8,0,4,"100Rnd_65x39_caseless_mag",150],
	[8,0,5,"100Rnd_65x39_caseless_mag_Tracer",160],
	[8,1,0,"150Rnd_762x54_Box",215],
	[8,1,1,"150Rnd_762x54_Box_Tracer",230],
	[8,1,2,"150Rnd_93x64_Mag",250],
	[8,1,3,"130Rnd_338_Mag",250],

	//SNIPER AMMO: PADRAO / MARKSMAN
	[9,0,0,"10Rnd_762x54_Mag",100],
	[9,0,1,"20Rnd_762x51_Mag",130],
	[9,0,2,"5Rnd_127x108_Mag",250],
	[9,0,3,"5Rnd_127x108_APDS_Mag",260],
	[9,0,4,"7Rnd_408_Mag",260],
	[9,1,0,"20Rnd_650x39_Cased_Mag_F",120],
	[9,1,1,"20Rnd_762x51_Mag",140],
	[9,1,2,"10Rnd_338_Mag",250],
	[9,1,3,"10Rnd_127x54_Mag",250],
	[9,1,4,"10Rnd_93x64_DMR_05_Mag",250],

	//OPTICS BASICO
	[10,0,0,"optic_Aco_smg",125],
	[10,0,1,"optic_ACO_grn_smg",125],
	[10,0,2,"optic_Holosight_smg",125],
	[10,0,3,"optic_Aco",125],
	[10,0,4,"optic_ACO_grn",125],
	[10,0,5,"optic_Holosight",125],
	[10,0,6,"optic_Yorris",125],
	[10,0,7,"optic_MRD",125],

	//OPTICS M-RANGE
	[10,1,0,"optic_AMS",600],
	[10,1,1,"optic_AMS_khk",600],
	[10,1,2,"optic_AMS_snd",600],
	[10,1,3,"optic_KHS_blk",600],
	[10,1,4,"optic_KHS_hex",600],
	[10,1,5,"optic_KHS_old",600],
	[10,1,6,"optic_KHS_tan",600],
	[10,1,7,"optic_DMS",600],
	[10,1,8,"optic_SOS",600],
	[10,1,9,"optic_NVS",600],
	[10,1,10,"optic_Hamr",600],
	[10,1,11,"optic_Arco",600],
	[10,1,12,"optic_MRCO",600],
	[10,1,13,"optic_LRPS",800],

	//EQUIPAMENTOS
	[11,0,0,"ItemMap",50],
	[11,0,1,"Chemlight_green",65],
	[11,0,2,"ItemWatch",100],
	[11,0,3,"FirstAidKit",100],
	[11,0,4,"ItemCompass",200],
	[11,1,0,"Binocular",300],
	[11,1,1,"NVGoggles",300],
	[11,1,2,"ItemGPS",500],
	[11,1,3,"Rangefinder",500],
	[11,1,4,"ToolKit",1500],
	[11,1,5,"MediKit",1500],
	//[11,1,6,"MineDetector",5],

	//ACESSORIOS ARMA SUPRESSORES
	[12,0,0,"muzzle_snds_338_black",250],
	[12,0,1,"muzzle_snds_338_green",250],
	[12,0,2,"muzzle_snds_338_sand",250],
	[12,0,3,"muzzle_snds_93mmg",250],
	[12,0,4,"muzzle_snds_93mmg_tan",250],
	[12,0,5,"muzzle_snds_acp",250],
	[12,0,6,"muzzle_snds_B",250],
	[12,0,7,"muzzle_snds_H",250],
	[12,0,8,"muzzle_snds_H_MG",250],
	[12,0,9,"muzzle_snds_H_SW",250],
	[12,0,10,"muzzle_snds_L",250],
	[12,0,11,"muzzle_snds_M",250],

	//ACESSORIOS ARMA OUTROS
	[12,1,0,"acc_flashlight",300],
	[12,1,1,"acc_pointer_IR",300],

	//ACESSORIOS ARMA SUPRESSORES (APEX DLC)
	[12,2,0,"muzzle_snds_H_khk_F",250],
	[12,2,1,"muzzle_snds_H_snd_F",250],
	[12,2,2,"muzzle_snds_58_blk_F",250],
	[12,2,3,"muzzle_snds_m_khk_F",250],
	[12,2,4,"muzzle_snds_m_snd_F",250],
	[12,2,5,"muzzle_snds_B_khk_F",250],
	[12,2,6,"muzzle_snds_B_snd_F",250],
	[12,2,7,"muzzle_snds_58_wdm_F",250],
	[12,2,8,"muzzle_snds_65_TI_blk_F",250],
	[12,2,9,"muzzle_snds_65_TI_hex_F",250],
	[12,2,10,"muzzle_snds_65_TI_ghex_F",250],
	[12,2,11,"muzzle_snds_H_MG_blk_F",250],
	[12,2,12,"muzzle_snds_H_MG_khk_F",250],

	//LAUNCHERS AMMO
	[13,1,0,"RPG32_F",150],
	[13,1,1,"RPG32_HE_F",200],
	[13,1,2,"NLAW_F",200],
	[13,1,3,"Titan_AT",300],
	[13,1,4,"Titan_AP",300],
	[13,1,5,"Titan_AA",500],

	//EXPLOSIVOS
	[14,0,0,"SLAMDirectionalMine_Wire_Mag",280],
	[14,0,1,"APERSTripMine_Wire_Mag",280],
	[14,0,2,"APERSMine_Range_Mag",400],
	[14,0,3,"APERSBoundingMine_Range_Mag",400],
	[14,0,4,"ATMine_Range_Mag",400],
	[14,0,5,"DemoCharge_Remote_Mag",520],
	[14,0,6,"ClaymoreDirectionalMine_Remote_Mag",520],

	//GRENADES
	[14,1,0,"B_IR_Grenade",90],
	[14,1,1,"HandGrenade",90],
	[14,1,2,"MiniGrenade",90],
	[14,1,3,"SmokeShell",80],
	[14,1,4,"SmokeShellOrange",80],
	[14,1,5,"SmokeShellGreen",80],
	[14,1,6,"SmokeShellPurple",80],
	[14,1,7,"SmokeShellBlue",80],

	//SLUGS
	[14,2,0,"1Rnd_HE_Grenade_shell",90],
	[14,2,1,"3Rnd_HE_Grenade_shell",100],
	[14,2,2,"1Rnd_Smoke_Grenade_shell",80],
	[14,2,3,"1Rnd_SmokeOrange_Grenade_shell",80],
	[14,2,4,"1Rnd_SmokeGreen_Grenade_shell",80],
	[14,2,5,"1Rnd_SmokePurple_Grenade_shell",80],
	[14,2,6,"1Rnd_SmokeBlue_Grenade_shell",80],

	//ASSAULT RIFLE AMMO
	[15,0,0,"30Rnd_556x45_Stanag",100],
	[15,0,1,"30Rnd_556x45_Stanag_Tracer_Red",105],
	[15,0,2,"30Rnd_556x45_Stanag_Tracer_Green",105],
	[15,0,3,"30Rnd_556x45_Stanag_Tracer_Yellow",105],
	[15,0,4,"30Rnd_545x39_Mag_F",90],
	[15,0,5,"30Rnd_545x39_Mag_Tracer_F",90],
	[15,0,6,"30Rnd_65x39_caseless_mag",105],
	[15,0,7,"30Rnd_65x39_caseless_mag_Tracer",105],
	[15,0,8,"30Rnd_65x39_caseless_green",105],
	[15,0,9,"30Rnd_65x39_caseless_green_mag_Tracer",105],
	[15,0,10,"30Rnd_762x39_Mag_F",90],
	[15,0,11,"30Rnd_762x39_Mag_Tracer_F",90],
	[15,0,12,"10Rnd_50BW_Mag_F",125],
	[15,0,13,"30Rnd_556x45_Stanag",100],
	[15,0,14,"30Rnd_556x45_Stanag_green",100],
	[15,0,15,"30Rnd_556x45_Stanag_red",100],
	[15,0,16,"30Rnd_556x45_Stanag_Tracer_Red",105],
	[15,0,17,"30Rnd_556x45_Stanag_Tracer_Green",105],
	[15,0,18,"30Rnd_556x45_Stanag_Tracer_Yellow",105],
	[15,0,19,"150Rnd_556x45_Drum_Mag_F",225],
	[15,0,20,"150Rnd_556x45_Drum_Mag_Tracer_F",225],
	
	//EXTRA ITEMS
	[17,0,0,"ItemRadio",100],
	[17,0,1,"hgun_P07_F",120],
	[17,0,2,"SMG_02_F",220],
	[17,0,3,"V_BandollierB_blk",150],
	[17,0,4,"arifle_Mk20C_F",300],
	[17,0,5,"arifle_Mk20_F",300],
	[17,0,6,"hgun_PDW2000_F",120],
	[17,0,9,"arifle_MXM_F",300],
	[17,0,10,"H_HelmetIA",220],
	[17,0,11,"V_TacVest_oli",165],
	[17,0,12,"arifle_MXC_khk_F",300],
	[17,0,13,"B_Kitbag_rgr_BTAA_F",120],
	[17,0,14,"V_PlateCarrier1_tna_F",450]
];

BRPVP_ultraItems = [
	[
		//LAUNCHERS II
		"launch_RPG32_F",
		"launch_NLAW_F",
		//"launch_Titan_F",
		//"launch_Titan_short_F",
		//SNIPER RIFLES
		"srifle_DMR_01_F",
		"srifle_EBR_F",
		"srifle_GM6_F",
		"srifle_LRR_F",
		"srifle_GM6_camo_F",
		"srifle_LRR_camo_F",
		//SNIPER RIFLES (MARSKMAN DLC)
		"srifle_DMR_02_F",
		"srifle_DMR_02_camo_F",
		"srifle_DMR_02_sniper_F",
		"srifle_DMR_03_F",
		"srifle_DMR_03_khaki_F",
		"srifle_DMR_03_tan_F",
		"srifle_DMR_03_multicam_F",
		"srifle_DMR_03_woodland_F",
		"srifle_DMR_04_F",
		"srifle_DMR_04_Tan_F",
		"srifle_DMR_05_blk_F",
		"srifle_DMR_05_hex_F",
		"srifle_DMR_05_tan_f",
		"srifle_DMR_06_camo_F",
		"srifle_DMR_06_olive_F",
		//SNIPER RIFLES (APEX DLC)
		"srifle_DMR_07_blk_F",
		"srifle_DMR_07_hex_F",
		"srifle_DMR_07_ghex_F",
		"arifle_SPAR_03_blk_F",
		"arifle_SPAR_03_khk_F",
		"arifle_SPAR_03_snd_F"
	],
	[
		//MEDIUM MACHINE GUNS I
		"MMG_01_hex_F",
		"MMG_01_tan_F",
		"MMG_02_camo_F",
		"MMG_02_black_F",
		"MMG_02_sand_F"
	]
];