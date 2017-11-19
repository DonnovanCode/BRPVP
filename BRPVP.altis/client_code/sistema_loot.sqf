diag_log "[BRPVP FILE] sistema_loot.sqf INITIATED";

private ["_mtdr_loot_items","_renewTime"];

//DEFINE UNIDADES DE LOOT
_mtdr_loot_items_unidade = [
	"B_OutdoorPack_blk", //0
	"B_OutdoorPack_tan", //1
	"B_OutdoorPack_blu", //2
	"B_AssaultPack_blk", //3
	"B_AssaultPack_khk", //4
	"B_AssaultPack_rgr", //5
	"B_AssaultPack_sgg", //6
	"B_AssaultPack_dgtl", //7
	"C_Bergen_blu", //8
	"C_Bergen_grn", //9
	"C_Bergen_red", //10
	"B_TacticalPack_mcamo", //11
	"B_TacticalPack_ocamo", //12
	"B_Carryall_oli", //13
	"B_Carryall_oucamo", //14
	"B_Carryall_khk", //15
	"B_Carryall_mcamo", //16
	"B_Carryall_ocamo", //17
	"U_O_GhillieSuit", //18
	"U_O_FullGhillie_lsh", //19
	"U_O_FullGhillie_sard", //20
	"U_O_FullGhillie_ard", //21
	"U_O_T_FullGhillie_tna_F", //22
	"U_O_CombatUniform_ocamo", //23
	"U_O_PilotCoveralls", //24
	"U_O_Wetsuit", //25
	"U_O_CombatUniform_oucamo", //26
	"U_O_SpecopsUniform_ocamo", //27
	"U_O_SpecopsUniform_blk", //28
	"U_O_OfficerUniform_ocamo", //29
	"U_O_Protagonist_VR", //30
	"U_O_Soldier_VR", //31
	"U_O_T_Soldier_F", //32
	"U_O_T_Officer_F", //33
	"U_O_T_Sniper_F", //34
	"U_O_V_Soldier_Viper_F", //35
	"U_O_V_Soldier_Viper_hex_F", //36
	"H_Cap_red", //37
	"H_Cap_blu", //38
	"H_Cap_oli", //39
	"H_Cap_tan", //40
	"H_Cap_blk", //41
	"H_Cap_grn", //42
	"H_Shemag_olive", //43
	"H_Watchcap_camo", //44
	"H_PilotHelmetHeli_O", //45
	"H_PilotHelmetFighter_O", //46
	"V_TacVest_brn", //47
	"V_TacVest_khk", //48
	"V_TacVest_blk", //49
	"V_Chestrig_blk", //50
	"V_Chestrig_khk", //51
	"V_Chestrig_oli", //52
	"V_Chestrig_rgr", //53
	"V_PlateCarrier_Kerry", //54
	"V_PlateCarrier2_rgr", //55
	"V_PlateCarrierIA2_dgtl", //56
	"V_PlateCarrierGL_rgr", //57
	"V_PlateCarrierIAGL_dgtl", //58
	"V_TacVest_blk_POLICE", //59
	"V_PlateCarrierSpec_rgr", //60
	["hgun_ACPC2_F",4,3], //61
	["hgun_Pistol_heavy_01_F",4,3], //62
	["hgun_Pistol_heavy_02_F",4,3], //63
	["hgun_P07_F",4,3], //64
	["hgun_Rook40_F",4,3], //65
	["hgun_PDW2000_F",4,3], //66
	["SMG_02_F",4,3], //67
	["arifle_Katiba_F",4,3], //68
	["arifle_MX_F",4,3], //69
	["arifle_MX_SW_F",4,3], //70
	["arifle_TRG20_F",4,3], //71
	["arifle_Mk20_GL_F",4,3], //72
	["arifle_TRG21_GL_F",4,3], //73
	["arifle_MX_SW_F",4,3], //74
	["LMG_03_F",3,3], //75
	["LMG_Mk200_F",3,3], //76
	["LMG_Zafir_F",3,3], //77
	["MMG_01_hex_F",2,3], //78
	["MMG_01_tan_F",2,3], //79
	["MMG_02_camo_F",2,3], //80
	["MMG_02_black_F",2,3], //81
	["MMG_02_sand_F",2,3], //82
	["srifle_DMR_01_F",3,3], //83
	["srifle_EBR_F",3,3], //84
	["srifle_GM6_F",3,3], //85
	["srifle_LRR_F",3,3], //86
	["srifle_GM6_camo_F",3,3], //87
	["srifle_LRR_camo_F",3,3], //88
	["launch_RPG32_F",2,2], //89
	["launch_NLAW_F",2,2], //90
	["launch_Titan_F",2,2], //91
	["launch_Titan_short_F",2,2], //92
	"optic_Aco_smg", //93
	"optic_ACO_grn_smg", //94
	"optic_Holosight_smg", //95
	"optic_Aco", //96
	"optic_ACO_grn", //97
	"optic_Holosight", //98
	"optic_Yorris", //99
	"optic_MRD", //100
	"optic_AMS", //101
	"optic_AMS_khk", //102
	"optic_AMS_snd", //103
	"optic_KHS_blk", //104
	"optic_KHS_hex", //105
	"optic_KHS_old", //106
	"optic_KHS_tan", //107
	"optic_DMS", //108
	"optic_SOS", //109
	"optic_NVS", //110
	"optic_Hamr", //111
	"optic_Arco", //112
	"optic_MRCO", //113
	"optic_LRPS", //114
	"optic_tws", //115
	"optic_tws_mg", //116
	"optic_Nightstalker", //117
	"ItemMap", //118
	"Chemlight_green", //119
	"ItemWatch", //120
	"FirstAidKit", //121
	"ItemCompass", //122
	"Binocular", //123
	"NVGoggles", //124
	"ItemGPS", //125
	"Rangefinder", //126
	"ToolKit", //127
	"MediKit", //128
	"muzzle_snds_338_black", //129
	"muzzle_snds_338_green", //130
	"muzzle_snds_338_sand", //131
	"muzzle_snds_93mmg", //132
	"muzzle_snds_93mmg_tan", //133
	"muzzle_snds_acp", //134
	"muzzle_snds_B", //135
	"muzzle_snds_H", //136
	"muzzle_snds_H_MG", //137
	"muzzle_snds_H_SW", //138
	"muzzle_snds_L", //139
	"muzzle_snds_M", //140
	"bipod_01_F_mtp", //141
	"bipod_01_F_snd", //142
	"bipod_02_F_blk", //143
	"bipod_02_F_hex", //144
	"bipod_02_F_tan", //145
	"bipod_03_F_oli", //146
	"acc_flashlight", //147
	"acc_pointer_IR", //148
	"SLAMDirectionalMine_Wire_Mag", //149
	"APERSTripMine_Wire_Mag", //150
	"APERSMine_Range_Mag", //151
	"APERSBoundingMine_Range_Mag", //152
	"ATMine_Range_Mag", //153
	"DemoCharge_Remote_Mag", //154
	"ClaymoreDirectionalMine_Remote_Mag", //155
	"B_IR_Grenade", //156
	"HandGrenade", //157
	"MiniGrenade", //158
	"SmokeShell", //159
	"SmokeShellOrange", //160
	"SmokeShellGreen", //161
	"SmokeShellPurple", //162
	"SmokeShellBlue", //163
	"FlareWhite_F", //164
	"FlareYellow_F" //165
];

//ACHA MUNICAO DAS ARMAS
{
	if (typeName _x == "array") then {
		_class = _x select 0;
		_qt1 = _x select 1;
		_qt2 = _x select 2;
		_combinacao = [_class];
		_mags = getArray (configFile >> "CfgWeapons" >> _class >> "magazines");
		_mag = floor random (count _mags);
		for "_i" from 1 to _qt1 do {_combinacao pushBack (_mags select _mag);};
		_muzzles = getArray(configfile >> "CfgWeapons" >> _class >> "muzzles");
		{
			if (_x != "this") exitWith {
				_mags = getArray(configfile >> "CfgWeapons" >> _class >> _x >> "magazines");
				_mag = floor random (count _mags);
				for "_i" from 1 to _qt2 do {_combinacao pushBack (_mags select _mag);};
			};
		} forEach _muzzles;
		_mtdr_loot_items_unidade set [_forEachIndex,_combinacao];
		diag_log ("[BRPVP LOOT WEAPON AMMO GRENADE] " + str _combinacao);
	};
} forEach _mtdr_loot_items_unidade;	

//CODIGO EXCLUSIVO SERVIDOR
if (isServer) then {
	private ["_mtdr_loot_buildings_objs","_mtdr_lootTable_bobj","_mtdr_lootTable_item","_mtdr_lootActive","_MTDR_fnc_selectRandom"];
	if (isNil "BRPVP_loot_buildings_class") then {
		BRPVP_loot_buildings_class = [];
		BRPVP_loot_buildings_spawnPos = [];
		
		//ACHA CONSTRUCOES COM POSICOES INTERNAS
		{
			_object = _x;
			_class = typeOf _x;
			if !(_class in BRPVP_loot_buildings_class) then {
				_qt = count (_object buildingPos -1) - 1;
				BRPVP_loot_buildings_class pushBack _class;
				if (_qt >= 0) then {
					BRPVP_loot_buildings_spawnPos pushBack (floor random (_qt + 1));
				} else {
					BRPVP_loot_buildings_spawnPos pushBack -1;
				};
			};
		} forEach (BRPVP_centroMapa nearObjects ["Building",20000]);
		{if (_x == -1) then {BRPVP_loot_buildings_class set [_forEachIndex,-1];};} forEach BRPVP_loot_buildings_spawnPos;
		BRPVP_loot_buildings_class = BRPVP_loot_buildings_class - [-1];
		BRPVP_loot_buildings_spawnPos = BRPVP_loot_buildings_spawnPos - [-1];
		diag_log "======================================================";
		{diag_log _x;} forEach BRPVP_loot_buildings_class;
		diag_log "======================================================";
		{diag_log _x;} forEach BRPVP_loot_buildings_spawnPos;
		diag_log "======================================================";

		//ENVIA CONSTRUCOES E POSICOES NAS CONSTRUCOES PARA OS CLIENTES
		publicVariable "BRPVP_loot_buildings_class";
		publicVariable "BRPVP_loot_buildings_spawnPos";
	};
	diag_log ("[BRPVP] CHECK ARRAYS SIZE: BRPVP_loot_buildings_class - " + str count BRPVP_loot_buildings_class + " / BRPVP_loot_buildings_spawnPos - " + str count BRPVP_loot_buildings_spawnPos + ".");
	
	//DEFINE CONSTRUCOES PARA LOOT BOM, NORMAL E RUIM
	_lootBomN = [];
	_lootRuimN = [];
	_lootNormalN = [];
	{_lootBomN pushBack (BRPVP_loot_buildings_class find _x);} forEach BRPVP_lootBuildingsGood;
	{_lootRuimN pushBack (BRPVP_loot_buildings_class find _x);} forEach BRPVP_lootBuildingsWeak;
	{_lootNormalN pushBack (BRPVP_loot_buildings_class find _x);} forEach BRPVP_lootBuildingsAverage;
	_lootBomN = _lootBomN - [-1];
	_lootRuimN = _lootRuimN - [-1];
	_lootNormalN = _lootNormalN - [-1];

	//BACKPACKS
	_lst_b_weak = [[0.5,0.3,0.2,0],[0,1,2],[3,4,5,6,7],[8,9,10,11,12],[13,14,15,16,17]];
	_lst_b_normal = [[0.4,0.25,0.25,0.1],[0,1,2],[3,4,5,6,7],[8,9,10,11,12],[13,14,15,16,17]];
	_lst_b_good = [[0.15,0.25,0.3,0.3],[0,1,2],[3,4,5,6,7],[8,9,10,11,12],[13,14,15,16,17]];

	//UNIFORMES
	_lst_u_weak = [[1,0],[18,19,20,21,22],[23,24,25,26,27,28,29,30,/*31,*/32,33,34,35,36]];
	_lst_u_normal = [[0.8,0.2],[18,19,20,21,22],[23,24,25,26,27,28,29,30,/*31,*/32,33,34,35,36]];
	_lst_u_good = [[0.6,0.4],[18,19,20,21,22],[23,24,25,26,27,28,29,30,/*31,*/32,33,34,35,36]];

	//HELMETS
	_lst_h_weak = [[1,0],[37,38,39,40,41,42,43],[44,45,46]];
	_lst_h_normal = [[0.8,0.2],[37,38,39,40,41,42,43],[44,45,46]];
	_lst_h_good = [[0.6,0.4],[37,38,39,40,41,42,43],[44,45,46]];

	//VESTS
	_lst_v_weak = [[0.6,0.3,0.1,0],[47,48,49],[50,51,52,53],[54,55,56],[57,58,59,60]];
	_lst_v_normal = [[0.5,0.25,0.15,0.1],[47,48,49],[50,51,52,53],[54,55,56],[57,58,59,60]];
	_lst_v_good = [[0.35,0.25,0.25,0.15],[47,48,49],[50,51,52,53],[54,55,56],[57,58,59,60]];

	//WEAPONS
	_lst_w_weak = [[1,0,0,0,0],[61,62,63,64,65,66,67],[68,69,70,71,72,73],[74,75,76,77,78,79,80,81,82],[83,84,85,86,86,88],[89,90,91,92]];
	_lst_w_normal = [[0.8,0.2,0,0,0],[61,62,63,64,65,66,67],[68,69,70,71,72,73],[74,75,76,77,78,79,80,81,82],[83,84,85,86,86,88],[89,90,91,92]];
	_lst_w_good = [[0.6,0.3,0.05,0.03,0.02],[61,62,63,64,65,66,67],[68,69,70,71,72,73],[74,75,76,77,78,79,80,81,82],[83,84,85,86,86,88],[89,90,91,92]];

	//OPTICS
	_lst_o_weak = [[1,0,0],[93,94,95,96,97,98,99,100],[101,102,103,104,105,106,107,108,109,110,111,112,113],[114,115,116,117]];
	_lst_o_normal = [[0.7,0.3,0],[93,94,95,96,97,98,99,100],[101,102,103,104,105,106,107,108,109,110,111,112,113],[114,115,116,117]];
	_lst_o_good = [[0.6,0.38,0.02],[93,94,95,96,97,98,99,100],[101,102,103,104,105,106,107,108,109,110,111,112,113],[114,115,116,117]];

	//EQUIPAMENTOS
	_lst_eq_weak = [[0.8,0.2,0,0],[118,119,120,121],[122,123,124],[125,126],[127,128]];
	_lst_eq_normal = [[0.6,0.3,0.1,0],[118,119,120,121],[122,123,124],[125,126],[127,128]];
	_lst_eq_good = [[0.5,0.25,0.15,0.1],[118,119,120,121],[122,123,124],[125,126],[127,128]];

	//WEAPON ITEMS
	_lst_i_weak = [[0.7,0.2,0.1],[129,130,131,132,133,134,135,136,137,138,139,140],[141,142,143,144,145,146],[147,148]];
	_lst_i_normal = [[0.5,0.3,0.2],[129,130,131,132,133,134,135,136,137,138,139,140],[141,142,143,144,145,146],[147,148]];
	_lst_i_good = [[0.4,0.4,0.2],[129,130,131,132,133,134,135,136,137,138,139,140],[141,142,143,144,145,146],[147,148]];

	//EXPLOSIVOS
	_lst_ex_weak = [[0.8,0.2,0],[149,150],[151,152,153],[154,155]];
	_lst_ex_normal = [[0.6,0.3,0.1],[149,150],[151,152,153],[154,155]];
	_lst_ex_good = [[0.5,0.3,0.2],[149,150],[151,152,153],[154,155]];

	//GRENADES
	_lst_g_weak = [[0.6,0.4],[156,157,158],[159,160,161,162,163]];
	_lst_g_normal = [[0.5,0.5],[156,157,158],[159,160,161,162,163]];
	_lst_g_good = [[0.4,0.6],[156,157,158],[159,160,161,162,163]];

	//FLARES
	_lst_f_weak = [[0.6,0.4],[164],[165]];
	_lst_f_normal = [[0.5,0.5],[164],[165]];
	_lst_f_good = [[0.4,0.6],[164],[165]];

	//DEFINE FATOR DE CORRECAO DO LOOT (1.0 = SEM CORRECAO)
	_xfator = BRPVP_lootMult;
	
	//DEFINE DISTRIBUICAO DO LOOT
	_pRuim = BRPVP_mapaRodando select 18 select 0;
	_pMedio = BRPVP_mapaRodando select 18 select 1;
	_pBom = BRPVP_mapaRodando select 18 select 2;
	_pUsado =  BRPVP_mapaRodando select 18 select 3;
	_mtdr_loot_items = [
		//LOOT RUIM
		[_lst_b_weak,0.4*_pRuim,_lootRuimN,[],false,1],
		[_lst_u_weak,0.4*_pRuim,_lootRuimN,[],false,1],
		[_lst_h_weak,0.4*_pRuim,_lootRuimN,[],false,1],
		[_lst_v_weak,0.4*_pRuim,_lootRuimN,[],false,1],
		[_lst_w_weak,0.4*_pRuim,_lootRuimN,[],false,1],
		[_lst_o_weak,0.4*_pRuim,_lootRuimN,[],false,1],
		[_lst_i_weak,0.4*_pRuim,_lootRuimN,[],false,1],
		[_lst_g_weak,0.4*_pRuim,_lootRuimN,[],false,1],
		[_lst_f_weak,0.4*_pRuim,_lootRuimN,[],false,1],
		[_lst_eq_weak,0.4*_pRuim,_lootRuimN,[],false,1],
		[_lst_ex_weak,0.4*_pRuim,_lootRuimN,[],false,1],

		//LOOT NORMAL
		[_lst_b_normal,0.5*_pMedio,_lootNormalN,[],false,1],
		[_lst_u_normal,0.5*_pMedio,_lootNormalN,[],false,1],
		[_lst_h_normal,0.5*_pMedio,_lootNormalN,[],false,1],
		[_lst_v_normal,0.5*_pMedio,_lootNormalN,[],false,1],
		[_lst_w_normal,0.5*_pMedio,_lootNormalN,[],false,1],
		[_lst_o_normal,0.5*_pMedio,_lootNormalN,[],false,1],
		[_lst_i_normal,0.5*_pMedio,_lootNormalN,[],false,1],
		[_lst_g_normal,0.5*_pMedio,_lootNormalN,[],false,1],
		[_lst_f_normal,0.5*_pMedio,_lootNormalN,[],false,1],
		[_lst_eq_normal,0.5*_pMedio,_lootNormalN,[],false,1],
		[_lst_ex_normal,0.5*_pMedio,_lootNormalN,[],false,1],

		//LOOT BOM
		[_lst_b_good,0.6*_pBom,_lootBomN,[],false,1],
		[_lst_u_good,0.6*_pBom,_lootBomN,[],false,1],
		[_lst_h_good,0.6*_pBom,_lootBomN,[],false,1],
		[_lst_v_good,0.6*_pBom,_lootBomN,[],false,1],
		[_lst_w_good,0.6*_pBom,_lootBomN,[],false,1],
		[_lst_o_good,0.6*_pBom,_lootBomN,[],false,1],
		[_lst_i_good,0.6*_pBom,_lootBomN,[],false,1],
		[_lst_g_good,0.6*_pBom,_lootBomN,[],false,1],
		[_lst_f_good,0.6*_pBom,_lootBomN,[],false,1],
		[_lst_eq_good,0.6*_pBom,_lootBomN,[],false,1],
		[_lst_ex_good,0.6*_pBom,_lootBomN,[],false,1]
	];

	_qtLoot = 0;
	if (isNil "BRPVP_mtdr_lootTable_bobj") then {
		//MAPEIA TODAS AS CASAS DE LOOT
		_mtdr_loot_buildings_objs = [];
		_mtdr_loot_buildings_objs_count = [];
		_mtdr_loot_buildings_objs_useds = [];
		_numCas = 0;
		{
			_class = _x;
			_objs = BRPVP_centroMapa nearObjects [_class,20000];
			{if (typeOf _x != _class) then {_objs set [_forEachIndex,-1];};} forEach _objs;
			_objs = _objs - [-1];
			_mtdr_loot_buildings_objs pushBack _objs;
			_mtdr_loot_buildings_objs_useds pushBack [];
			_qtt = count _objs;
			diag_log (_class + " - " + str _qtt);
			_mtdr_loot_buildings_objs_count pushBack _qtt;
			_numCas = _numCas + 1;
		} forEach BRPVP_loot_buildings_class;

		//DISTRIBUI LOOT PELAS CASAS E GERA VARIAVEIS
		BRPVP_mtdr_lootTable_bobj = [];
		BRPVP_mtdr_lootTable_item = [];
		_mtdr_lootTable_qtt = [];
		_MTDR_fnc_selectRandom = {_index = round (random count _this - 0.5);_index};
		{
			private ["_total","_totalB","_item"];
			for "_k" from 0 to ((count _mtdr_lootTable_qtt) - 1) do {_mtdr_lootTable_qtt set [_k,0];};
			_bExclude = [];
			for "_k" from 0 to ((count BRPVP_loot_buildings_class) - 1) do {_bExclude pushBack [];};
			_buildRepeat = _x select 5;
			_prefArray = _x select 3;
			_noPreference = count _prefArray == 0;
			if (_noPreference) then {{_prefArray pushBack 1;} forEach (_x select 2);};
			_total = 0;
			_totalB = 0;
			{
				_total = _total + (_mtdr_loot_buildings_objs_count select _x) * (_prefArray select _forEachIndex);
				_totalB = _totalB + (_mtdr_loot_buildings_objs_count select _x);
			} forEach (_x select 2);
			if (_noPreference) then {
				_prefArray = _prefArray apply {100};
			} else {
				{
					_qttB = (_mtdr_loot_buildings_objs_count select _x) * (_prefArray select _forEachIndex);
					_prefArray set [_forEachIndex,(_qttB/_total) * 100];
				} forEach (_x select 2);
			};
			_qtt = (_x select 1) * _xfator;
			if !(_x select 4) then {_qtt = _qtt * _totalB;};
			_lastChance = _qtt - floor _qtt;
			if (random 1 < _lastChance) then {_qtt = floor _qtt + 1;} else {_qtt = floor _qtt;};
			for "_i" from 1 to _qtt do {
				_bTypeIndex = 0;
				while {true} do {
					_idx = (_x select 2) call _MTDR_fnc_selectRandom;
					if (random 100 < _prefArray select _idx) exitWith {
						_bTypeIndex = (_x select 2) select _idx;
					};
				};
				if (typeName (_x select 0 select 0) == "SCALAR") then {
					_item = (_x select 0) call BIS_fnc_selectRandom;
				} else {
					_percs = _x select 0 select 0;
					_piaoDoBau = random 1;
					_acum = 0;
					_idc = 1;
					{
						if (_piaoDoBau >= _acum && _piaoDoBau < _acum + _x) exitWith {
							_idc = _forEachIndex + 1;
						};
						_acum = _acum + _x;
					} forEach _percs;
					_item = (_x select 0 select _idc) call BIS_fnc_selectRandom;
				};
				_bOptions = (_mtdr_loot_buildings_objs select _bTypeIndex) - (_bExclude select _bTypeIndex);
				_bOptionsUsed = (_mtdr_loot_buildings_objs_useds select _bTypeIndex) - (_bExclude select _bTypeIndex);
				_bOptionsCount = count _bOptions;
				for "_y" from 1 to _bOptionsCount do {
					private ["_buildObj"];
					_ok = false;
					if (random 1 > _pUsado || count _bOptionsUsed == 0) then {
						_buildObj = _bOptions call BIS_fnc_selectRandom;
					} else {
						_buildObj = _bOptionsUsed call BIS_fnc_selectRandom;
					};
					_bIndex = BRPVP_mtdr_lootTable_bobj find _buildObj;
					if (_bIndex == -1) then {
						BRPVP_mtdr_lootTable_bobj pushBack _buildObj;
						BRPVP_mtdr_lootTable_item pushBack _item;
						_mtdr_lootTable_qtt pushBack 1;
						(_mtdr_loot_buildings_objs_useds select _bTypeIndex) pushBack _buildObj;
						_ok = true;
						_qtLoot = _qtLoot + 1;
					} else {
						_items = BRPVP_mtdr_lootTable_item select _bIndex;
						if (typeName _items != "Array") then {_items = [_items];};
						if (_buildRepeat == 0 || (_mtdr_lootTable_qtt select _bIndex < _buildRepeat)) then {
							_newPile = _items + [_item];
							BRPVP_mtdr_lootTable_item set [_bIndex,_newPile];
							_mtdr_lootTable_qtt set [_bIndex,(_mtdr_lootTable_qtt select _bIndex) + 1];
							_ok = true;
						};
					};
					if (_ok) exitWith {};
					_bExcludeNow = _bExclude select _bTypeIndex;
					_bExclude set [_bTypeIndex,_bExcludeNow + [_buildObj]];
					_bOptions = _bOptions - [_buildObj];
					_bOptionsUsed = _bOptionsUsed - [_buildObj];
				};
			};
		} forEach _mtdr_loot_items;
		
		//MAKE LOG FOR PRECALCULATED SQF
		diag_log "======================================================";
		{diag_log (ASLToAGL getPosWorld _x);} forEach BRPVP_mtdr_lootTable_bobj;
		diag_log "======================================================";
		{diag_log _x;} forEach BRPVP_mtdr_lootTable_item;
		diag_log "======================================================";

		//ENVIA LOOT TABLE PARA CLIENTES
		mtdr_lootSystemMain = [BRPVP_mtdr_lootTable_bobj,BRPVP_mtdr_lootTable_item];
		publicVariable "mtdr_lootSystemMain";
	} else {
		_qtLoot = 50 * round ((count BRPVP_mtdr_lootTable_bobj)/50);
	};
	
	diag_log ("[BRPVP LOOT] BUILDINGS WITH LOOT: " + str count BRPVP_mtdr_lootTable_bobj + ".");
	
	//RECEBE INFORMACAO DO LOOT ATIVADO PELOS CLIENTES
	mtdr_lootActive = [];
	mtdr_lootActiveAddFnc = {mtdr_lootActive pushBack (_this select 1);};
	"mtdr_lootActiveAdd" addPublicVariableEventHandler {_this call mtdr_lootActiveAddFnc;};
	
	//DELETA LOOT ABANDONADO
	[] spawn {
		private ["_time"];
		_tmpX = 60;
		_ini = time;
		waitUntil {
			_time = time;
			if (_time - _ini >= _tmpX) then {
				_ini = _time;
				diag_log ("[BRPVP ACTIVE LOOT] count mtdr_lootActive = " + str count mtdr_lootActive + ".");
				_mtdr_lootActive_remove = [];
				{
					_build = _x;
					_time = _build getVariable ["ml_used",0];
					if (BRPVP_serverTime > _time) then {
						_bPos = getPosATL _build;
						_nearP = false;
						{if (_bPos distanceSqr _x < 14400) exitWith {_nearP = true;};} forEach allPlayers;
						_waited = _build getVariable ["ml_wtd",false];
						if (!_nearP || _waited) then {
							_holder = objNull;
							_takes = 0;
							{
								_takes = _x getVariable ["ml_takes",-1];
								if (_takes >= 0) exitWith {_holder = _x;};
							} forEach ((_build buildingPos (BRPVP_loot_buildings_spawnPos select (BRPVP_loot_buildings_class find typeOf _build))) nearObjects ["groundWeaponHolder",1]);
							if ((_takes > 0 || isNull _holder) && !_waited) then {
								if (!isNull _holder) then {deleteVehicle _holder;};
								_build setVariable ["ml_used",BRPVP_serverTime + 300 - _tmpX/2,true];
								_build setVariable ["ml_wtd",true,false];
							} else {
								if (!isNull _holder) then {deleteVehicle _holder;};
								_mtdr_lootActive_remove pushBack _forEachIndex;
								_build setVariable ["ml_used",-1,true];
								_build setVariable ["ml_wtd",false,false];
							};
						};
					};
				} forEach mtdr_lootActive;
				{mtdr_lootActive deleteAt _x;} forEach _mtdr_lootActive_remove;
			};
			false
		};
	};
};
	
//CODIGO EXCLUSIVO CLIENTE
if (hasInterface) then {
	//RECEBE CONSTRUCOES E POSICOENS NAS CONSTRUCOES (RECEBE DO SERVIDOR)
	waitUntil {
		diag_log "[BRPVP LOOT] WAITING FOR PVAR...";
		!isNil "BRPVP_loot_buildings_class" && !isNil "BRPVP_loot_buildings_spawnPos"
	};

	//LOOP LOOT PLAYER
	_mtdr_loot_items_unidade spawn {
		private ["_mtdr_lootTable_bobj","_mtdr_lootTable_item","_mtdr_lootTable_bobj_local_size","_mtdr_lootTable_item_local","_time"];
		_mtdr_loot_items_unidade = _this;
		
		//PEGA CASAS COM LOOT E ITENS DE CADA CASA
		if (!isNil "BRPVP_mtdr_lootTable_bobj") then {
			_mtdr_lootTable_bobj = BRPVP_mtdr_lootTable_bobj;
			_mtdr_lootTable_item = BRPVP_mtdr_lootTable_item;
		} else {
			_mtdr_lootTable_bobj = mtdr_lootSystemMain select 0;
			_mtdr_lootTable_item = mtdr_lootSystemMain select 1;
		};
		_mtdr_pPosMain = getPosATL player;
		
		//SIZE DOS BUILDINGS COM LOOT
		_mtdr_lootTable_bobj_size = [];
		{
			_tam2 = ((sizeOf typeOf _x)/2 + BRPVP_extraBuildBBSizeForLoot)^2;
			_mtdr_lootTable_bobj_size pushBack _tam2;
			_x setVariable ["bbx",[_x,BRPVP_extraBuildBBSizeForLoot] call BRPVP_getBBMult,false];
		} forEach _mtdr_lootTable_bobj;
		
		//FUNCAO: ACHA CONSTRUCOES EM VOLTA
		_mtdr_calc_newBuilds = {
			BRPVP_mtdr_lootTable_bobj_local = [];
			_mtdr_lootTable_item_local = [];
			_mtdr_lootTable_bobj_local_size = [];
			{
				_dist = _mtdr_pPosMain distanceSqr _x;
				_items = _mtdr_lootTable_item select _forEachIndex;
				if (_dist < 15625) then {
					BRPVP_mtdr_lootTable_bobj_local pushBack _x;
					_mtdr_lootTable_bobj_local_size pushBack (_mtdr_lootTable_bobj_size select _forEachIndex);
					_mtdr_lootTable_item_local pushBack _items;
				};
			} forEach _mtdr_lootTable_bobj;
		};

		//FUNCAO: SPAWNA LOOT
		_mtdr_spawnLoot = {
			_obj = _this select 0;
			_items = _this select 1;
			if (typeName _items != "Array") then {_items = [_items];};
			_idx1 = BRPVP_loot_buildings_class find typeOf _obj;
			_spawnPosIdx = 0;
			if (_idx1 >= 0) then {
				_spawnPosIdx = BRPVP_loot_buildings_spawnPos select _idx1;
			} else {
				diag_log ("[BRPVP LOOT] House not found in BRPVP_loot_buildings_class. _idx1 == -1.");
			};
			_spawnPos = _obj buildingPos _spawnPosIdx;
			//_spawnPos set [2,(_spawnPos select 2) + 0.35];
			_holder = createVehicle ["groundWeaponHolder",_spawnPos,[],0,"CAN_COLLIDE"];
			_holder setPosATL _spawnPos;
			_holder setVariable ["ml_takes",0,true];
			{
				_itemsAll = _mtdr_loot_items_unidade select _x;
				if (typeName _itemsAll == "String") then {_itemsAll = [_itemsAll];};
				[_holder,_itemsAll] call BRPVP_addLoot;
			} forEach _items;
			mtdr_lootActiveAdd = _obj;
			if (isServer) then {["",mtdr_lootActiveAdd] call mtdr_lootActiveAddFnc;} else {publicVariableServer "mtdr_lootActiveAdd";};
		};

		//INICIA CALCULANDO CONSTRUCOES DE LOOT PROXIMAS
		call _mtdr_calc_newBuilds;
		
		//MONITORA MOVIMENTO DO PLAYER PARA SPAWNAR LOOT
		_ini = time;
		waitUntil {
			_time = time;
			if (_time - _ini > 1.25) then {
				_ini = _time;
				_pOnFoot = vehicle player == player;
				if (_pOnFoot) then {
					_pPos = getPosATL player;
					_walked = _mtdr_pPosMain distanceSqr _pPos;
					if (_walked > 10000) then {
						_mtdr_pPosMain = _pPos;
						call _mtdr_calc_newBuilds;
						_walked = 0;
					};
					{
						_dist = (_pPos distanceSqr _x) - (_mtdr_lootTable_bobj_local_size select _forEachIndex);
						if (_dist <= 0) then {
							if ([player,_x] call PDTH_pointIsInBox) then {
								_bUsed = _x getVariable ["ml_used",-1];
								if (_bUsed == -1) then {
									_x setVariable ["ml_used",serverTime,true];
									_items = _mtdr_lootTable_item_local select _forEachIndex;
									[_x,_items] call _mtdr_spawnLoot;
								};
							};
						};
					} forEach BRPVP_mtdr_lootTable_bobj_local;
				};
			};
			false
		};
	};
};

diag_log "[BRPVP FILE] sistema_loot.sqf END REACHED";