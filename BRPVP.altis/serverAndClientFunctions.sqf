if (isServer) then {
	//SO VARIABLES
	BRPVP_variablesObjects = [];
	publicVariable "BRPVP_variablesObjects";
	BRPVP_variablesNames = [];
	publicVariable "BRPVP_variablesNames";
	BRPVP_variablesValues = [];
	publicVariable "BRPVP_variablesValues";
};
BRPVP_ItemsClassToNumberTableA = ["arifle_AK12_F","arifle_AK12_GL_F","arifle_AKM_F","arifle_AKS_F","arifle_ARX_ghex_F","arifle_ARX_hex_F","arifle_Katiba_F","arifle_Mk20_GL_F","arifle_Mk20C_F","arifle_MX_F","arifle_MX_GL_F","arifle_MX_GL_khk_F","arifle_MX_khk_F","arifle_MX_SW_F","arifle_MXC_khk_F","arifle_MXM_F","arifle_SPAR_01_blk_F","arifle_SPAR_01_GL_blk_F","arifle_SPAR_01_GL_khk_F","arifle_SPAR_01_GL_snd_F","arifle_SPAR_02_blk_F","arifle_SPAR_02_snd_F","arifle_TRG20_F","arifle_TRG21_GL_F","Binocular","hgun_ACPC2_F","hgun_P07_F","hgun_PDW2000_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","hgun_Rook40_F","launch_B_Titan_F","launch_NLAW_F","launch_RPG32_F","LMG_03_F","LMG_Mk200_F","LMG_Zafir_F","MMG_01_hex_F","Rangefinder","SMG_02_F","srifle_DMR_06_camo_F","srifle_EBR_F","srifle_LRR_camo_F","srifle_LRR_tna_F"];
BRPVP_ItemsClassToNumberTableB = ["100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag_Tracer","10Rnd_338_Mag","10Rnd_93x64_DMR_05_Mag","11Rnd_45ACP_Mag","130Rnd_338_Mag","150Rnd_556x45_Drum_Mag_F","150Rnd_556x45_Drum_Mag_Tracer_F","150Rnd_762x54_Box","150Rnd_762x54_Box_Tracer","150Rnd_93x64_Mag","16Rnd_9x21_green_Mag","16Rnd_9x21_Mag","16Rnd_9x21_red_Mag","16Rnd_9x21_yellow_Mag","1Rnd_HE_Grenade_shell","1Rnd_Smoke_Grenade_shell","1Rnd_SmokeBlue_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","200Rnd_556x45_Box_Tracer_F","200Rnd_556x45_Box_Tracer_Red_F","200Rnd_65x39_cased_Box","200Rnd_65x39_cased_Box_Tracer","20Rnd_762x51_Mag","30Rnd_545x39_Mag_F","30Rnd_545x39_Mag_Green_F","30Rnd_545x39_Mag_Tracer_F","30Rnd_545x39_Mag_Tracer_Green_F","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag_green","30Rnd_556x45_Stanag_red","30Rnd_556x45_Stanag_Tracer_Green","30Rnd_556x45_Stanag_Tracer_Red","30Rnd_556x45_Stanag_Tracer_Yellow","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green_mag_Tracer","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag_Tracer","30Rnd_762x39_Mag_F","30Rnd_762x39_Mag_Green_F","30Rnd_762x39_Mag_Tracer_F","30Rnd_762x39_Mag_Tracer_Green_F","30Rnd_9x21_Green_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Mag_SMG_02","30Rnd_9x21_Mag_SMG_02_Tracer_Green","30Rnd_9x21_Mag_SMG_02_Tracer_Yellow","30Rnd_9x21_Red_Mag","30Rnd_9x21_Yellow_Mag","6Rnd_45ACP_Cylinder","7Rnd_408_Mag","9Rnd_45ACP_Mag","APERSBoundingMine_Range_Mag","APERSMine_Range_Mag","APERSTripMine_Wire_Mag","ATMine_Range_Mag","B_IR_Grenade","Chemlight_blue","Chemlight_green","ClaymoreDirectionalMine_Remote_Mag","DemoCharge_Remote_Mag","HandGrenade","MiniGrenade","NLAW_F","RPG32_F","RPG32_HE_F","SatchelCharge_Remote_Mag","SLAMDirectionalMine_Wire_Mag","SmokeShell","SmokeShellBlue","SmokeShellGreen","SmokeShellOrange","SmokeShellPurple","Titan_AA","Titan_AP","Titan_AT","3Rnd_HE_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","5Rnd_127x108_Mag","5Rnd_127x108_APDS_Mag","10Rnd_50BW_Mag_F","1Rnd_SmokePurple_Grenade_shell"];
BRPVP_ItemsClassToNumberTableC = ["acc_flashlight","acc_pointer_IR","bipod_01_F_blk","bipod_01_F_khk","bipod_01_F_mtp","bipod_01_F_snd","bipod_02_F_blk","bipod_02_F_hex","bipod_02_F_tan","bipod_03_F_oli","FirstAidKit","G_Balaclava_TI_G_blk_F","G_Diving","H_Bandanna_surfer","H_Cap_blk","H_Cap_oli","H_Cap_red","H_Cap_surfer","H_Cap_tan","H_Hat_tan","H_HelmetIA","H_PilotHelmetFighter_O","H_PilotHelmetHeli_O","H_Shemag_olive","H_Watchcap_camo","ItemCompass","ItemGPS","ItemMap","ItemWatch","Medikit","MineDetector","muzzle_snds_338_black","muzzle_snds_338_green","muzzle_snds_338_sand","muzzle_snds_58_blk_F","muzzle_snds_58_wdm_F","muzzle_snds_65_TI_blk_F","muzzle_snds_65_TI_ghex_F","muzzle_snds_65_TI_hex_F","muzzle_snds_93mmg","muzzle_snds_93mmg_tan","muzzle_snds_acp","muzzle_snds_B","muzzle_snds_B_khk_F","muzzle_snds_B_snd_F","muzzle_snds_H","muzzle_snds_H_khk_F","muzzle_snds_H_MG","muzzle_snds_H_MG_blk_F","muzzle_snds_H_SW","muzzle_snds_L","muzzle_snds_M","muzzle_snds_m_khk_F","NVGoggles","optic_Aco","optic_ACO_grn","optic_ACO_grn_smg","optic_Aco_smg","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_Arco","optic_DMS","optic_Hamr","optic_Holosight","optic_Holosight_smg","optic_KHS_blk","optic_KHS_hex","optic_KHS_old","optic_KHS_tan","optic_LRPS","optic_MRCO","optic_MRD","optic_NVS","optic_SOS","optic_tws_mg","optic_Yorris","ToolKit","U_O_CombatUniform_ocamo","U_O_CombatUniform_oucamo","U_O_FullGhillie_ard","U_O_FullGhillie_lsh","U_O_FullGhillie_sard","U_O_GhillieSuit","U_O_OfficerUniform_ocamo","U_O_PilotCoveralls","U_O_Protagonist_VR","U_O_SpecopsUniform_blk","U_O_SpecopsUniform_ocamo","U_O_T_FullGhillie_tna_F","U_O_T_Sniper_F","U_O_V_Soldier_Viper_F","U_O_V_Soldier_Viper_hex_F","U_O_Wetsuit","V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_khk","V_BandollierB_oli","V_BandollierB_rgr","V_Chestrig_blk","V_PlateCarrier_Kerry","V_PlateCarrier1_tna_F","V_PlateCarrier2_rgr","V_PlateCarrierGL_rgr","V_PlateCarrierIA2_dgtl","V_PlateCarrierIAGL_dgtl","V_PlateCarrierSpec_rgr","V_TacVest_blk","H_Cap_blu","H_Cap_grn","V_Chestrig_oli","V_Chestrig_rgr","H_HelmetB_snakeskin","H_HelmetO_ocamo","H_HelmetLeaderO_ocamo","V_Chestrig_khk"];
BRPVP_ItemsClassToNumberTableD = ["B_AssaultPack_dgtl","B_AssaultPack_rgr","B_Bergen_dgtl_F","B_Bergen_hex_F","B_Bergen_mcamo_F","B_Bergen_tna_F","B_Carryall_khk","B_Carryall_mcamo","B_Carryall_oli","B_Carryall_oucamo","B_OutdoorPack_blk","B_OutdoorPack_tan","B_Parachute","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_ViperHarness_blk_F","B_ViperHarness_ghex_F","B_ViperHarness_oli_F","B_ViperLightHarness_hex_F","B_ViperLightHarness_khk_F","B_ViperLightHarness_oli_F","C_Bergen_blu","C_Bergen_red","G_FieldPack_LAT"];
BRP_kitFlags25 = ["Flag_BI_F"];
BRP_kitFlags50 = ["Flag_Green_F"];
BRP_kitFlags100 = ["Flag_Blue_F"];
BRP_kitFlags200 = ["Flag_White_F","Flag_Red_F"];
BRPVP_getFlagRadius = {
	_typeOf = typeOf _this;
	if (_typeOf in BRP_kitFlags25) exitWith {25};
	if (_typeOf in BRP_kitFlags50) exitWith {50};
	if (_typeOf in BRP_kitFlags100) exitWith {100};
	if (_typeOf in BRP_kitFlags200) exitWith {200};
	0
};
BRPVP_setFlagProtectionOnVehicle = {
	params ["_vehicle","_state","_passenger"];
	if (!BRPVP_safeZone) then {
		if (BRPVP_flagVehiclesGodModeWhenEmpty) then {
			if (!_state) then {
				if (alive _vehicle) then {
					_crew = crew _vehicle;
					if (count _crew isEqualTo 0 || _crew isEqualTo [_passenger]) then {
						if !(_vehicle getVariable ["own",-1] isEqualTo -1) then {
							{
								_flag = _x;
								_limit = _flag call BRPVP_getFlagRadius;
								if (_flag distance2D _vehicle <= _limit && {[_vehicle,_flag] call BRPVP_checaAcessoRemotoFlag}) exitwith {
									[_vehicle,_state] remoteExec ["allowDamage",_vehicle,false];
								};
							} forEach nearestObjects [_vehicle,["FlagCarrier"],200,true];
						};
					};
				};
			} else {
				_crew = crew _vehicle;
				if ((count _crew isEqualTo 0 && !isNull _passenger) || count _crew > 0) then {
					[_vehicle,_state] remoteExec ["allowDamage",_vehicle,false];
				};
			};
		};
	};
};
BRPVP_setFlagProtectionOnVehicleNotLast = {
	params ["_vehicle","_state"];
	if (BRPVP_flagVehiclesGodModeWhenEmpty) then {
		if (!_state) then {
			if (alive _vehicle) then {
				if !(_vehicle getVariable ["own",-1] isEqualTo -1) then {
					{
						_flag = _x;
						_limit = _flag call BRPVP_getFlagRadius;
						if (_flag distance2D _vehicle <= _limit && {[_vehicle,_flag] call BRPVP_checaAcessoRemotoFlag}) exitwith {
							[_vehicle,_state] remoteExec ["allowDamage",_vehicle,false];
						};
					} forEach nearestObjects [_vehicle,["FlagCarrier"],200,true];
				};
			};
		} else {
			[_vehicle,_state] remoteExec ["allowDamage",_vehicle,false];
		};
	};
};
BRPVP_checaAcessoRemotoFlag = {
	params ["_obj","_flag"];
	_objOwn = _obj getVariable ["own",-1];
	_flagOwn = _flag getVariable ["own",-1];
	_flagAmg = _flag getVariable ["amg",[[],[]]];
	_flagAmg = if (count _flagAmg isEqualTo 2 && {typeName (_flagAmg select 0) isEqualTo "ARRAY"}) then {_flagAmg select 1} else {[]};
	_objOwn in _flagAmg || _objOwn isEqualTo _flagOwn
};
BRPVP_checaAcessoRemoto = {
	params ["_pAccess","_pAccessed"];
	_own = _pAccess getVariable ["own",-1];
	_amg = _pAccess getVariable ["amg",[]];
	if !(count _amg == 2 && {typeName (_amg select 0) == "ARRAY"}) then {_amg = [_amg,[]];};
	_amg = (_amg select 0) + (_amg select 1);
	
	_oOwn = _pAccessed getVariable ["own",-1];
	_oAmg = _pAccessed getVariable ["amg",[]];
	if !(count _oAmg == 2 && {typeName (_oAmg select 0) == "ARRAY"}) then {_oAmg = [_oAmg,[]];};
	_oAmg = (_oAmg select 0) + (_oAmg select 1);
	_oShareT = _pAccessed getVariable ["stp",1];
	
	//FOR "MO ONE" SHARE
	if (_oShareT == 4) exitWith {false};
	
	//CHECA ACESSO
	_retorno = false;
	if (_oOwn == -1 || _own == _oOwn || _oShareT == 3) then {
		_retorno = true;
	} else {
		if (_oShareT != 0) then {
			if (_oShareT == 1) then {
				if (_own in _oAmg) then {_retorno = true;};
			} else {
				if (_oShareT == 2) then {
					if (_own in _oAmg && _oOwn in _amg) then {_retorno = true;};
				};
			};
		};
	};
	_retorno
};
//MONEY FORMAT
BRPVP_formatNumber = {_this call BIS_fnc_numberText};
/*
BRPVP_formatNumber = {
	if (_this >= 1000000) then {
		str floor (_this/1000) + " K"
	} else {
		str _this
	};
};
*/
//VEHICLE HandleDamage
BRPVP_HandleDamage = {
	_veh = _this select 0;
	_part = _this select 1;
	_damage = _this select 2;
	if (_part == "" && _damage >= 1) then {
		_whSaveLoot = createVehicle ["WeaponHolderSimulated",ASLToAGL getPosASL _veh,[],0,"CAN_COLLIDE"];
		[_veh,_whSaveLoot,-1,BRPVP_killedVehicleLootSavePercentage] call BRPVP_transferCargoCargo;
	};
};
//VEHICLES MPKilled
BRPVP_MPKilled = {
	_v = _this select 0;
	_p = _this select 1;
	if (isServer) then {
		_v call BRPVP_veiculoMorreu;
		if (_v call BRPVP_IsMotorized) then {
			_v setVariable ["bdc",true,true];
			if (count crew _v > 0) then {
				_v spawn {
					_crew = [];
					sleep 10;
					while {
						_crew = crew _this;
						count _crew > 0
					} do {
						moveOut (_crew select 0);
						sleep (1 + random 3);
					};
				};
			};
		} else {
			if (typeOf _v in BRPVP_buildingHaveDoorList) then {
				_v setVariable ["bdc",true,true];
			};
		};
		if (BRPVP_useExtDB3) then {
			private ["_okCrew"];
			_idBd = _p getVariable ["id_bd",-1];
			if (_p call BRPVP_isMotorized) then {
				_okCrew = "\nVeiculo Atacante Tipo > " + getText (configFile >> "CfgVehicles" >> (typeOf _p) >> "displayName");
				_countCargo = 0;
				{
					_role = (assignedVehicleRole _x) select 0;
					if (_role != "CARGO") then {
						_idBdUnit = _x getVariable ["id_bd",-1];
						_name = _x getVariable ["nm","Bot"];
						if (_idBdUnit != -1) then {
							_okCrew = _okCrew + "\nVeiculo Atacante " + _role + " > " + str _idBdUnit + " - " + _name;
						} else {
							_okCrew = _okCrew + "\nVeiculo Atacante " + _role + " > " + _name;
						};
					} else {
						_countCargo = _countCargo + 1;
					};
				} forEach crew _p;
				if (_countCargo > 0) then {
					_okCrew = _okCrew + "\nVeiculo Atacante CARGO > X" + str _countCargo;
				};
			} else {
				_name = _p getVariable ["nm","Bot"];
				if (_idBd != -1) then {
					_okCrew = "\nSoldado Atacante > " + str _idBd + " - " + _name;
				} else {
					_okCrew = "\nSoldado Atacante > " + _name;
				};
			};
			_typeOf = typeOf _v;
			_owner = _v getVariable ["own",-1];
			_vPrettyName = getText (configFile >> "CfgVehicles" >> _typeOf >> "displayName");
			_key = format ["1:%1:addDestructionLog:%2:%3:%4:%5:%6:%7",BRPVP_protocolo,_owner,_owner,_idBd,_okCrew,_vPrettyName,_typeOf];
			_resultado = "extDB3" callExtension _key;
		};
	};
	if (hasInterface) then {
		if (_p == player) then {
			[["matou_veiculo",1]] call BRPVP_mudaExp;
		};
		if (BRPVP_stuff == _v) then {BRPVP_stuff = objNull;};
		_index = BRPVP_myStuff find _v;
		if (_index != -1) then {
			BRPVP_myStuff deleteAt _index;
			["mastuff"] call BRPVP_atualizaIcones;
		};
	};
};
//ZOMBIE FUNCTION
BRPVP_zombieJump = {
	(_this select 0) setVariable ["jpg",true,true];
	_this spawn {
		params ["_agnt","_attacker","_explode","_h","_dist"];
		if (alive _agnt) then {
			//CALC JUMP VELOCITY VECTOR
			_velY = sqrt(2*9.8*_h);
			_t = _velY/9.8;
			_velX = _dist/(2*_t);
			_velX = _velX * 1.25;
			_vecX = (getPosWorld _attacker) vectorDiff (getPosWorld _agnt);
			_vecX set [2,0];
			_vecX = (vectorNormalized _vecX) vectorMultiply _velX;
			_vecY = [0,0,_velY];
			_vec = _vecX vectorAdd _vecY;
			
			//CHECK FREE PATH
			_vCheck = (vectorNormalized _vec) vectorMultiply 20;
			_agntWLD = getPosWorld _agnt;
			_isVisible = ([_agnt,"GEOM"] checkVisibility [_agntWLD,_agntWLD vectorAdd _vCheck]) > 0.5;
			
			if (_isVisible) then {
				//LIGHT BOLT
				_lPos = ASLToAGL getPosASL _agnt;
				_bolt = createVehicle ["Lightning_F",_lPos vectorAdd [-16.6,-3.2,0],[],0,"CAN_COLLIDE"];
				_light = createvehicle ["#lightpoint",(_lPos vectorAdd [-16.6,-3.2,20]),[],0,"CAN_COLLIDE"];
				_light setLightAttenuation [10,0,0.5,0];
				_light setLightBrightness 1.5;
				_light setLightColor [0.8,0.8,1];
				[_agnt,[["thunder_1","thunder_2"] call BIS_fnc_selectRandom,800]] remoteExec ["say3D",0,false];
				[_agnt,[["thunder_1","thunder_2"] call BIS_fnc_selectRandom,800]] remoteExec ["say3D",0,false];
				[_bolt,_light] spawn {sleep 0.35;{deletevehicle _x;} forEach _this;};

				_agnt setVelocity _vec;
				if (_explode > 0) then {
					if (_explode == 1) then {[_agnt,["jumper",500]] remoteExec ["say3D",0,false];};
					sleep _t;
					if (_explode == 2) then {[_agnt,["crazy",400]] remoteExec ["say3D",0,false];};
					if (alive _agnt && _explode == 1) then {_bomb = createVehicle ["HelicopterExploBig",getPosATL _agnt,[],0,"CAN_COLLIDE"];};
					waitUntil {(position _agnt) select 2 < 0.125};
					if (alive _agnt && _explode == 2) then {_bomb = createVehicle ["HelicopterExploBig",getPosATL _agnt,[],0,"CAN_COLLIDE"];};
				} else {
					if (alive _agnt) then {
						sleep _t;
						[_agnt,["jumper",400]] remoteExec ["say3D",0,false];
						while {(position _agnt) select 2 > 0.125} do {
							_bomb = createVehicle ["B_20mm",_agnt modeltoworld [0,0,0],[],0,"CAN_COLLIDE"];
							_bomb setVectorDirAndUp [[0,0,-1],[0,1,0]];
							_bomb setVelocity [0,0,-1000];
							sleep 0.3;
						};
					};
				};
			};
		};
		if (alive _agnt) then {
			_pos = ASLToAGL getPosASL _attacker;
			_agnt moveTo ASLToAGL getPosASL _agnt;
			_agnt moveTo _pos;
			_agnt doWatch (_pos vectorAdd [0,0,100]);
		};
		_agnt setVariable ["jpg",false,true];
	};
};
//ZOMBIE FUNCTION
BRPVP_zombieHDEH = {
	_zombie = _this select 0;
	_part = _this select 1;
	_damage = _this select 2;
	_attacker = _this select 3;
	_projectile = _this select 4;
	if (!isNull _attacker && _projectile != "") then {
		if (_part in ["body","spine1","spine2","spine3"]) then {_damage = _damage - 0.8;};
		if (_part in ["face_hub","neck","head","arms","hands"]) then {_damage = _damage - 0.9;};
		_dLimit = ((_zombie getVariable "ifz") select 0) * BRPVP_zombiesResistence;
		if (!isPlayer _attacker && _attacker isKindOf "CaManBase") then {_damage = _damage * 1.25;};
		if (alive _zombie) then {
			_newDamage = (_zombie getVariable "dmg") + _damage;
			_zombie setVariable ["dmg",_newDamage,false];
			if (_newDamage >= _dLimit) then {
				_zombie setVariable ["klr",_attacker,true];
				_zombie setDamage 1;
			} else {
				_h = ((getPosWorld _attacker) select 2) - ((getPosWorld _zombie) select 2);
				_d = _zombie distance2D _attacker;
				_canJump = !(_zombie getVariable "jpg");
				if (_canJump && _h > 15 && {_d/_h < 5}) then {
					[_zombie,_attacker,1,_h,_d*2] call BRPVP_zombieJump;
				} else {
					_dist = _zombie distance _attacker;
					if (_canJump && _dist > 30 && _zombie getVariable "knl" && random 1 < BRPVP_kneelingZombieJumpPercentage) then {
						if (_dist > 95) then {
							[_zombie,_attacker,2,_d/2,_d] call BRPVP_zombieJump;
						} else {
							[_zombie,_attacker,0,_d/2,_d] call BRPVP_zombieJump;
						};
					};
				};
			};
		};
	} else {
		if (_part == "") then {
			if !(_attacker isEqualTo vehicle _attacker) then {
				_newDamage = (_zombie getVariable "brpvp_impact_damage") + _damage;
				_zombie setVariable ["brpvp_impact_damage",_newDamage,false];
				if (_newDamage >= 1) then {
					if (random 1 < BRPVP_zombiesCaughByCarChanceToExplode) then {
						_bomb = createVehicle ["M_Titan_AP",_zombie modeltoworld [0,0,0],[],0,"CAN_COLLIDE"];
						_bomb setVectorDirAndUp [[0,0,1],[0,-1,0]];
						_bomb setVelocity [0,0,-1000];
					};
					_zombie setVariable ["klr",_attacker,true];
					_zombie setDamage 1;
				};
			};
		};
	};
	_damage = 0;
	if (_part in ["body","spine1","spine2","spine3"]) then {_damage = 0.8;};
	if (_part in ["face_hub","neck","head","arms","hands"]) then {_damage = 0.9;};
	_damage
};
BRPVP_tudoA3 = [
    //FEDIDEX EXPRESS
    ["FEDIDEX",localize "str_land_civil",localize "str_city_cars","C_Hatchback_01_F","Hatchback",20000*0.5],
    ["FEDIDEX",localize "str_land_civil",localize "str_city_cars","C_SUV_01_F","SUV",21250*0.5],
    ["FEDIDEX",localize "str_land_civil",localize "str_city_cars","C_Kart_01_F","Kart",7500*0.5],
    ["FEDIDEX",localize "str_land_civil",localize "str_city_cars","C_Van_01_fuel_F","Truck Fuel",100000*0.5],
    ["FEDIDEX",localize "str_land_civil",localize "str_offroad","C_Offroad_01_repair_F","Offroad (Services)",32500*0.5],
    ["FEDIDEX",localize "str_land_apex",localize "str_civil","C_Offroad_02_unarmed_white_F","MB 4WD (White)",18000*0.5],
    ["FEDIDEX",localize "str_land_militar",localize "str_mrap","B_MRAP_01_F","Hunter",32500*0.5],
    ["FEDIDEX",localize "str_land_militar",localize "str_mrap","O_MRAP_02_F","Ifrit",32500*0.5],
    ["FEDIDEX",localize "str_land_militar",localize "str_mrap","I_MRAP_03_F","Strider",32500*0.5],
 
    //VAN
    ["CIVIL",localize "str_land_civil",localize "str_city_cars","C_Van_01_transport_F","Truck Transport",45000],
    ["CIVIL",localize "str_land_civil",localize "str_city_cars","C_Van_01_box_F","Truck Box",75000],
    ["CIVIL",localize "str_land_civil",localize "str_city_cars","C_Van_01_fuel_F","Truck Fuel",200000],
 
    //HATCH BACK & SUV
    ["CIVIL",localize "str_land_civil",localize "str_city_cars","C_Hatchback_01_F","Hatchback",40000],
	["CIVIL",localize "str_land_civil",localize "str_city_cars","C_Hatchback_01_sport_F","Hatchback (Esporte)",60000],
    ["CIVIL",localize "str_land_civil",localize "str_city_cars","C_SUV_01_F","SUV",42500],
 
    //KART
    ["CIVIL",localize "str_land_civil",localize "str_city_cars","C_Kart_01_F","Kart",15000],
 
    //HEAVY TRUCKS
    ["CIVIL",localize "str_land_civil",localize "str_city_cars","C_Truck_02_box_F","Civil Repair Truck",65000],
 
    //OFFROAD
    ["CIVIL",localize "str_land_civil",localize "str_offroad","C_Offroad_01_F","Offroad",35000],
    ["CIVIL",localize "str_land_civil",localize "str_offroad","C_Offroad_01_repair_F","Offroad (Services)",65000],
    ["CIV-MIL",localize "str_land_civil",localize "str_offroad","I_G_Offroad_01_armed_F","I Offroad (Armed)",150000],
 
    //OFFROAD APEX
    ["CIVIL",localize "str_land_apex",localize "str_civil","C_Offroad_02_unarmed_black_F","MB 4WD (Black)",36000],
    ["CIVIL",localize "str_land_apex",localize "str_civil","C_Offroad_02_unarmed_blue_F","MB 4WD (Blue)",36000],
    ["CIVIL",localize "str_land_apex",localize "str_civil","C_Offroad_02_unarmed_green_F","MB 4WD (Green)",36000],
    ["CIVIL",localize "str_land_apex",localize "str_civil","C_Offroad_02_unarmed_orange_F","MB 4WD (Orange)",36000],
    ["CIVIL",localize "str_land_apex",localize "str_civil","C_Offroad_02_unarmed_red_F","MB 4WD (Red)",36000],
    ["CIVIL",localize "str_land_apex",localize "str_civil","C_Offroad_02_unarmed_white_F","MB 4WD (White)",36000],
 
    ["CIV-MIL",localize "str_land_apex",localize "str_militar","I_C_Van_01_transport_brown_F","Truck (Brown)",50000],
    ["CIV-MIL",localize "str_land_apex",localize "str_militar","I_C_Van_01_transport_olive_F","Truck (Olive)",50000],
 
    ["CIV-MIL",localize "str_land_apex",localize "str_militar","I_C_Offroad_02_unarmed_brown_F","MB 4WD (Brown)",37000],
    ["CIV-MIL",localize "str_land_apex",localize "str_militar","I_C_Offroad_02_unarmed_olive_F","MB 4WD (Olive)",37000],
 
    ["CIV-MIL",localize "str_land_apex",localize "str_militar","B_CTRG_LSV_01_light_F","Prowler (Light)",70000],
    ["CIV-MIL",localize "str_land_apex",localize "str_militar","B_T_LSV_01_unarmed_F","Prowler (Unarmed)",72500],
    ["CIV-MIL",localize "str_land_apex",localize "str_militar","O_T_LSV_02_unarmed_F","Qilin (Unarmed)",73000],
 
    ["MILITAR",localize "str_land_apex",localize "str_militar","B_T_LSV_01_armed_F","Prowler (Armed)",200000],
    ["MILITAR",localize "str_land_apex",localize "str_militar","O_T_LSV_02_armed_F","Qilin (Armed)",200000],
 
    //INFANTRY TRANSPORT TRUCK AND UTILITARY TRUCKS
    ["CIV-MIL",localize "str_land_militar",localize "str_default_truck","B_Truck_01_transport_F","HEMTT Transport",350000],
    ["CIV-MIL",localize "str_land_militar",localize "str_default_truck","I_Truck_02_transport_F","Zamak Transport",350000],
    ["CIV-MIL",localize "str_land_militar",localize "str_default_truck","O_Truck_03_transport_F","Tempest Transport",350000],
 
    ["MILITAR",localize "str_land_militar",localize "str_covered_truck","B_Truck_01_covered_F","HEMTT Transport (Covered)",360000],
    ["MILITAR",localize "str_land_militar",localize "str_covered_truck","I_Truck_02_covered_F","Zamak Transport (Covered)",360000],
    ["MILITAR",localize "str_land_militar",localize "str_covered_truck","O_Truck_03_covered_F","Tempest Transport (Covered)",360000],
 
    ["MILITAR",localize "str_land_militar",localize "str_fuel_truck","B_Truck_01_fuel_F","HEMTT Fuel",700000],
    ["MILITAR",localize "str_land_militar",localize "str_fuel_truck","O_Truck_02_fuel_F","Zamak Fuel",700000],
    ["MILITAR",localize "str_land_militar",localize "str_fuel_truck","O_Truck_03_fuel_F","Tempest Fuel",700000],
 
    ["MILITAR",localize "str_land_militar",localize "str_ammo_truck","B_Truck_01_ammo_F","HEMTT Ammo",1000000],
    ["MILITAR",localize "str_land_militar",localize "str_ammo_truck","I_Truck_02_ammo_F","Zamak Ammo",1000000],
    ["MILITAR",localize "str_land_militar",localize "str_ammo_truck","O_Truck_03_ammo_F","Tempest Ammo",1000000],
 
    ["MILITAR",localize "str_land_militar",localize "str_repair_truck","B_Truck_01_repair_F","HEMTT Repair",575000],
    ["MILITAR",localize "str_land_militar",localize "str_repair_truck","O_Truck_03_repair_F","Tempest Repair",575000],
   
    //MRAP
    ["CIV-MIL",localize "str_land_militar",localize "str_mrap","B_MRAP_01_F","Hunter",150000],
    ["CIV-MIL",localize "str_land_militar",localize "str_mrap","O_MRAP_02_F","Ifrit",160000],
    ["CIV-MIL",localize "str_land_militar",localize "str_mrap","I_MRAP_03_F","Strider",170000],
 
    ["MILITAR",localize "str_land_militar",localize "str_mrap_hmg","B_MRAP_01_hmg_F","Hunter HMG",600000],
    ["MILITAR",localize "str_land_militar",localize "str_mrap_hmg","O_MRAP_02_hmg_F","Ifrit HMG",625000],
    ["MILITAR",localize "str_land_militar",localize "str_mrap_hmg","I_MRAP_03_hmg_F","Strider HMG",650000],
 
    ["MILITAR",localize "str_land_militar",localize "str_mrap_gmg","B_MRAP_01_gmg_F","Hunter GMG",700000],
    ["MILITAR",localize "str_land_militar",localize "str_mrap_gmg","O_MRAP_02_gmg_F","Ifrit GMG",725000],
    ["MILITAR",localize "str_land_militar",localize "str_mrap_gmg","I_MRAP_03_gmg_F","Strider GMG",750000],
 
    //WHEELED APCS
    ["MILITAR",localize "str_land_militar",localize "str_wheeled_apc","B_APC_Wheeled_01_cannon_F","AMV-7 Marshall",300000],
    ["MILITAR",localize "str_land_militar",localize "str_wheeled_apc","O_APC_Wheeled_02_rcws_F","MSE-3 Marid",325000],
    ["MILITAR",localize "str_land_militar",localize "str_wheeled_apc","I_APC_Wheeled_03_cannon_F","AFV-4 Gorgon",350000],
 
    //AIRPORT TRADER
    ["AIRPORT",localize "str_planes",localize "str_civil","C_Plane_Civil_01_F","Caesar BTT",400000],
    ["AIRPORT",localize "str_planes",localize "str_civil","C_Plane_Civil_01_racing_F","Caesar BTT (Racing)",420000],
   
    //CIVIL HELIS
    ["AIRPORT",localize "str_helicopters",localize "str_civil","C_Heli_light_01_stripped_F","M-900 (Stripped)",700000],
    ["AIRPORT",localize "str_helicopters",localize "str_civil","C_Heli_Light_01_civil_F","M-900",800000],
    ["AIRPORT",localize "str_helicopters",localize "str_civil","B_Heli_Light_01_stripped_F","MH-9 Hummingbird (Stripped)",850000],  //MRX
    ["AIRPORT",localize "str_helicopters",localize "str_civil","B_Heli_Light_01_F","MH-9 Hummingbird",900000],
   
    //MILITAR TRANSPORT HELIS
    ["AIRPORT",localize "str_helicopters",localize "str_transport_helicopters","B_Heli_Transport_03_unarmed_F","CH-67 Huron (Unarmed)",950000],
    ["AIRPORT",localize "str_helicopters",localize "str_transport_helicopters","B_Heli_Transport_03_unarmed_green_F","CH-67 Huron Unarmed",920000],  //MRX
    ["AIRPORT",localize "str_helicopters",localize "str_transport_helicopters","B_Heli_Transport_03_F","CH-67 Huron (Green)",1000000],  //MRX
    ["AIRPORT",localize "str_helicopters",localize "str_transport_helicopters","B_Heli_Transport_01_F","UH-80 Ghost Hawk",1100000],
    ["AIRPORT",localize "str_helicopters",localize "str_transport_helicopters","B_Heli_Transport_01_camo_F","UH-80 Ghost Hawk (Camo)",1110000],
    ["AIRPORT",localize "str_helicopters",localize "str_transport_helicopters","B_CTRG_Heli_Transport_01_sand_F","UH-80 Ghost Hawk (Sand)",1110000],
    ["AIRPORT",localize "str_helicopters",localize "str_transport_helicopters","B_CTRG_Heli_Transport_01_tropic_F","UH-80 Ghost Hawk (Tropic)",1120000],
    ["AIRPORT",localize "str_helicopters",localize "str_transport_helicopters","I_Heli_Transport_02_F","CH-49 Mohawk",980000],
    ["AIRPORT",localize "str_helicopters",localize "str_transport_helicopters","O_Heli_Transport_04_covered_black_F","Mi-280 Taru (Transport, Black)",1050000],
    ["AIRPORT",localize "str_helicopters",localize "str_transport_helicopters","O_Heli_Transport_04_F","Mi-290 Taru",1080000],
 
    //MILITAR LIGHT HELIS
    ["AIRPORT",localize "str_helicopters",localize "str_light_helicopters","I_Heli_light_03_unarmed_F","WY-55 Hellcat (Unarmed)",1100000],
    ["AIRPORT",localize "str_helicopters",localize "str_light_helicopters","O_Heli_Light_02_unarmed_F","PO-30 Orca (Unarmed)",950000],
    ["AIRPORT",localize "str_helicopters",localize "str_light_helicopters","B_Heli_Light_01_armed_F","AH-9 Pawnee",1350000],
    ["AIRPORT",localize "str_helicopters",localize "str_light_helicopters","O_Heli_Light_02_F","PO-30 Orca",1550000],
    ["AIRPORT",localize "str_helicopters",localize "str_light_helicopters","I_Heli_light_03_F","WY-55 Hellcat",2000000],
   
    //MILITAR ATTACK HELIS
    ["ADMIN",localize "str_admin_heli",localize "str_attack_helis","B_Heli_Attack_01_F","AH-99 Blackfoot",1000000],
    ["ADMIN",localize "str_admin_heli",localize "str_attack_helis","O_Heli_Attack_02_F","Mi-48 Kajman",1000000],
    ["ADMIN",localize "str_admin_heli",localize "str_attack_helis","O_Heli_Attack_02_black_F","Mi-48 Kajman (Black)",1000000],
 
    //PLANES
    ["ADMIN",localize "str_admin_plane",localize "str_civil","C_Plane_Civil_01_F","Caesar BTT",1000000],
    ["ADMIN",localize "str_admin_plane",localize "str_civil","C_Plane_Civil_01_racing_F","Caesar BTT (Racing)",1000000],
    ["ADMIN",localize "str_admin_plane",localize "str_militar","B_Plane_CAS_01_F","A-164 Wipeout (CAS)",1000000],
    ["ADMIN",localize "str_admin_plane",localize "str_militar","O_Plane_CAS_02_F","To-199 Neophron (CAS)",1000000],
    ["ADMIN",localize "str_admin_plane",localize "str_militar","I_Plane_Fighter_03_CAS_F","A-143 Buzzard (CAS)",1000000],
    ["ADMIN",localize "str_admin_plane",localize "str_militar","I_Plane_Fighter_03_AA_F","A-143 Buzzard (AA)",1000000],
    ["ADMIN",localize "str_admin_plane",localize "str_militar","B_T_VTOL_01_infantry_F","V-44 X Blackfish (Infantry Transport)",1000000],
    ["ADMIN",localize "str_admin_plane",localize "str_militar","B_T_VTOL_01_vehicle_F","V-44 X Blackfish (Vehicle Transport)",1000000],
    ["ADMIN",localize "str_admin_plane",localize "str_militar","B_T_VTOL_01_armed_F","V-44 X Blackfish (Armed)",1000000],
    ["ADMIN",localize "str_admin_plane",localize "str_militar","O_T_VTOL_02_infantry_F","Y-32 Xi'an (Infantry Transport)",1000000],
    ["ADMIN",localize "str_admin_plane",localize "str_militar","O_T_VTOL_02_vehicle_F","Y-32 Xi'an (Vehicle Transport)",1000000],
 
    //APCS
    ["ADMIN",localize "str_admin_land",localize "str_apc","B_APC_Tracked_01_rcws_F","IFV-6c Panther",1000000],
    ["ADMIN",localize "str_admin_land",localize "str_apc","B_APC_Tracked_01_CRV_F","CRV-6e Bobcat",1000000],
    ["ADMIN",localize "str_admin_land",localize "str_apc","O_APC_Tracked_02_cannon_F","BTR-K Kamysh",1000000],
    ["ADMIN",localize "str_admin_land",localize "str_apc","I_APC_tracked_03_cannon_F","FV-720 Mora",1000000],
 
    //ANTI-AIR
    ["ADMIN",localize "str_admin_land",localize "str_anti_air","B_APC_Tracked_01_AA_F","IFV-6a Cheetah",1000000],
    ["ADMIN",localize "str_admin_land",localize "str_anti_air","O_APC_Tracked_02_AA_F","ZSU-39 Tigris",1000000],
 
    //ARTILLERY
    ["ADMIN",localize "str_admin_land",localize "str_arty","B_MBT_01_arty_F","M4 Scorcher",1000000],
    ["ADMIN",localize "str_admin_land",localize "str_arty","B_MBT_01_mlrs_F","M5 Sandstorm MLRS",1000000],
    ["ADMIN",localize "str_admin_land",localize "str_arty","O_MBT_02_arty_F","2S9 Sochor",1000000],
 
    //TANKS
    ["ADMIN",localize "str_admin_land",localize "str_tanks","B_MBT_01_cannon_F","M2A1 Slammer",1000000],
    ["ADMIN",localize "str_admin_land",localize "str_tanks","I_MBT_03_cannon_F","MBT-52 Kuma",1000000],
    ["ADMIN",localize "str_admin_land",localize "str_tanks","B_MBT_01_TUSK_F","M2A4 Slammer UP",1000000],
    ["ADMIN",localize "str_admin_land",localize "str_tanks","O_MBT_02_cannon_F","T-100 Varsuk",1000000]
];
for "_i" from 0 to (count BRPVP_tudoA3 - 1) do {
	(BRPVP_tudoA3 select _i) set [4,getText (configFile >> "CfgVehicles" >> (BRPVP_tudoA3 select _i select 3) >> "displayName")];
};
BRPVP_showTutorial = {
	waitUntil {!isNull findDisplay 46};
	_handleKeyboard = (findDisplay 46) displayAddEventHandler ["KeyDown",{BRPVP_tutorialPress = BRPVP_tutorialPress + 1;}];
	_handleMouse = (findDisplay 46) displayAddEventHandler ["MouseButtonDown",{BRPVP_tutorialPress = BRPVP_tutorialPress + 1;}];
	BRPVP_tutorialPress = 0;
	_id = 79866;
	findDisplay 46 ctrlCreate ["RscPictureKeepAspect",_id];
	(findDisplay 46 displayCtrl _id) ctrlSetPosition [safezoneX,safezoneY,safezoneW,safezoneH];
	(findDisplay 46 displayCtrl _id) ctrlSetText "BRP_imagens\interface\tutorial_page1.paa";
	(findDisplay 46 displayCtrl _id) ctrlCommit 0;
	_init = -10;
	waitUntil {
		if (getOxygenRemaining player < 0.4) then {player setOxygenRemaining 1;};
		if (time - _init > 2) then {_init = time;cutText ["","BLACK FADED",10];};
		BRPVP_tutorialPress > 0 || !alive player || BRPVP_menuExtraLigado
	};
	if (BRPVP_tutorialPress > 0) then {
		(findDisplay 46 displayCtrl _id) ctrlSetText "BRP_imagens\interface\tutorial_page2.paa";
		(findDisplay 46 displayCtrl _id) ctrlCommit 0;
		_init = -10;
		waitUntil {
			if (getOxygenRemaining player < 0.4) then {player setOxygenRemaining 1;};
			if (time - _init > 2) then {_init = time;cutText ["","BLACK FADED",10];};
			BRPVP_tutorialPress > 1 || !alive player || BRPVP_menuExtraLigado
		};	
	};
	if (_this) then {cutText ["","BLACK FADED",10];} else {cutText ["","PLAIN",1];};
	(findDisplay 46) displayRemoveEventHandler ["KeyDown",_handleKeyboard];
	(findDisplay 46) displayRemoveEventHandler ["MouseButtonDown",_handleMouse];
	ctrlDelete (findDisplay 46 displayCtrl _id);
};
BRPVP_veiculosC = [
	[
		"C_Quadbike_01_F","C_Quadbike_01_F","C_Quadbike_01_F","C_Quadbike_01_F","C_Quadbike_01_F","C_Quadbike_01_F",
		"C_Van_01_transport_F","C_Van_01_box_F","C_Van_01_fuel_F","C_Van_01_transport_F","C_Van_01_box_F","C_Van_01_fuel_F",
		"C_Offroad_01_F","C_Offroad_01_repair_F","C_Offroad_stripped_F","I_C_Offroad_02_unarmed_brown_F","I_C_Offroad_02_unarmed_olive_F","B_G_Offroad_01_repair_F",
		"C_Hatchback_01_F","C_SUV_01_F","C_Hatchback_01_F","C_SUV_01_F","C_Hatchback_01_F","C_SUV_01_F",
		"B_Truck_01_transport_F","O_Truck_02_transport_F","O_Truck_03_transport_F","B_Truck_01_covered_F","O_Truck_02_covered_F","O_Truck_03_covered_F",
		"C_Offroad_02_unarmed_black_F","C_Offroad_02_unarmed_blue_F","C_Offroad_02_unarmed_green_F","C_Offroad_02_unarmed_orange_F","C_Offroad_02_unarmed_red_F","C_Offroad_02_unarmed_white_F",
		"B_MRAP_01_F","O_MRAP_02_F","I_MRAP_03_F","B_MRAP_01_F","O_MRAP_02_F","I_MRAP_03_F"
	]
];
BRPVP_veiculosH = [
	[
		"C_Heli_Light_01_civil_F","C_Heli_light_01_stripped_F",
		"C_Heli_Light_01_civil_F","C_Heli_light_01_stripped_F",
		"C_Heli_Light_01_civil_F","C_Heli_light_01_stripped_F",
		"C_Heli_Light_01_civil_F","C_Heli_light_01_stripped_F",
		"C_Heli_Light_01_civil_F","C_Heli_light_01_stripped_F",
		"C_Heli_Light_01_civil_F","C_Heli_light_01_stripped_F",
		"C_Heli_Light_01_civil_F","C_Heli_light_01_stripped_F",
		"C_Heli_Light_01_civil_F","C_Heli_light_01_stripped_F",
		"C_Heli_Light_01_civil_F","C_Heli_light_01_stripped_F",
		"C_Heli_Light_01_civil_F","C_Heli_light_01_stripped_F",
		"C_Heli_Light_01_civil_F","C_Heli_light_01_stripped_F",
		"C_Heli_Light_01_civil_F","C_Heli_light_01_stripped_F",
		"C_Heli_Light_01_civil_F","C_Heli_light_01_stripped_F",
		"C_Heli_Light_01_civil_F","C_Heli_light_01_stripped_F",
		"C_Heli_Light_01_civil_F","C_Heli_light_01_stripped_F",
		"C_Heli_Light_01_civil_F","C_Heli_light_01_stripped_F",
		"C_Heli_Light_01_civil_F","C_Heli_light_01_stripped_F",
		"C_Heli_Light_01_civil_F","C_Heli_light_01_stripped_F",
		"I_Heli_light_03_unarmed_F","O_Heli_Light_02_unarmed_F",
		"B_Heli_Transport_03_unarmed_F","B_Heli_Transport_03_unarmed_green_F"
	]
];
BRPVP_experienciaZerada = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
BRPVP_playerVehiclesCounter = 0;
BRPVP_playerVehicles = [];
BRPVP_inOwnedTerrain = {
	params ["_owner","_obj"];
	_terrainsIndex = _owner getVariable "owt";
	_inside = false;
	{
		_terrain = BRPVP_terrenos select _x;
		_center = _terrain select 0;
		_side = _terrain select 1;
		_pt1 = _center vectorAdd [+_side/2,+_side/2,0];
		_pt2 = _center vectorAdd [-_side/2,-_side/2,0];
		_pos = getPosWorld _obj;
		_pox = _pos select 0;
		_poy = _pos select 1;
		_insideX = _pox < _pt1 select 0 && _pox > _pt2 select 0;
		_insideY = _poy < _pt1 select 1 && _poy > _pt2 select 1;
		if (_insideX && _insideY) exitWith {_inside = true;};		
	} forEach _terrainsIndex;
	_inside
};
BRPVP_playerVehiclesFnc = {
	if (BRPVP_playerVehiclesCounter == 50) then {
		BRPVP_playerVehiclesCounter = 0;
		_playerVehicles = [];
		{if (_x != vehicle _x) then {_playerVehicles pushBack _x;};} forEach allPlayers;
		BRPVP_playerVehicles = _playerVehicles;
	} else {
		_this params ["_action","_player"];
		if (_action) then {
			BRPVP_playerVehicles pushBackUnique _player;
		} else {
			_index = BRPVP_playerVehicles find _player;
			if (_index != -1) then {
				BRPVP_playerVehicles deleteAt _index;
			};
		};
		BRPVP_playerVehiclesCounter = BRPVP_playerVehiclesCounter + 1;
	};
};
{if (_x != vehicle _x) then {BRPVP_playerVehicles pushBack _x;};} forEach allPlayers;
"BRPVP_updatePlayersOnVehicleArray" addPublicVariableEventHandler {(_this select 1) call BRPVP_playerVehiclesFnc;};

//http://killzonekid.com/arma-scripting-tutorials-get-zoom/
KK_fnc_trueZoom = {
	3*([0.5,0.5] distance2D worldToScreen positionCameraToWorld [0,3,4])*(getResolution select 5)/2
};
BRPVP_qjsAdicClassObjeto = {
	params ["_receptor","_val",["_hand_or_bank","mny"]];
	_receptor setVariable [_hand_or_bank,(_receptor getVariable [_hand_or_bank,0]) + _val,true];
	if (hasInterface) then {call BRPVP_atualizaDebug;};
};
BRPVP_qjsAdicClassObjetoServer = {
	params ["_receptor","_val"];
	_receptor setVariable ["mny",(_receptor getVariable ["mny",0]) + _val,true];
};
BRPVP_qjsValorDoPlayer = {
	_this getVariable ["mny",0]
};
BRPVP_alignObjToTerrain = {
	_bb = boundingBoxReal _this;
	_bbXMax = abs ((_bb select 0 select 0) - (_bb select 1 select 0));
	_bbYMax = abs ((_bb select 0 select 1) - (_bb select 1 select 1));
	_dX = _bbXMax * 0.4;
	_dY = _bbYMax * 0.4;
	_cP = getPosWorld _this;
	_pt0 = [_cP select 0,_cP select 1,0];
	_pt1 = [(_cP select 0) + _dX,(_cP select 1) + _dY,0];
	_pt2 = [(_cP select 0) - _dX,(_cP select 1) + _dY,0];
	_pt3 = [(_cP select 0) + _dX,(_cP select 1) - _dY,0];
	_pt4 = [(_cP select 0) - _dX,(_cP select 1) - _dY,0];
	_sn0 = surfaceNormal _pt0;
	_sn1 = surfaceNormal _pt1;
	_sn2 = surfaceNormal _pt2;
	_sn3 = surfaceNormal _pt3;
	_sn4 = surfaceNormal _pt4;
	_sn = vectorNormalized ((((_sn0 vectorAdd _sn1) vectorAdd _sn2) vectorAdd _sn3) vectorAdd _sn4);
	_this setVectorUp _sn;
};
BRPVP_isSimpleObject = {
	_isMoto = _this call BRPVP_isMotorized;
	_isDoor = (typeOf _this) in BRPVP_buildingHaveDoorList;
	_isMap = _this getVariable ["mapa",false];
	!(_isMoto || _isDoor || _isMap)
};
BRPVP_transferUnitCargo = {
	params ["_from","_cargo",["_token",-2],["_wait",[-1,0]],["_check",{true}],["_onlyMinorItems",false]];
	private ["_wh"];
	_waitChance = _wait select 0;
	_waitTime = (_wait select 1)/6;
	
	//GET UNIT GEAR INFO
	_weaponItems = weaponsItems _from;
	_mags = magazinesAmmo _from;
	_itemsAssigned = assignedItems _from;

	//GROUND HOLDER
	_wh = objNull;
	_whs = nearestObjects [_cargo,["GroundWeaponHolder"],30];
	{
		if (_x getVariable ["tuc",-1] == _token) then {
			if (_x distanceSqr _cargo < 100) then {
				_wh = _x;
			};
		};
		if (!isNull _wh) exitWith {};
	} forEach _whs;
	_createHolder = {
		_wh = createVehicle ["GroundWeaponHolder",getPosATL _cargo,[],0,"NONE"];
		_wh setVariable ["tuc",_token,true];
	};

	//TRANSFER WEAPONS WITH WEAPON ITEMS AND WEAPON MAGS
	_magsW = [];
	_itemsW = [];
	if (!_onlyMinorItems) then {
		_ac = count _weaponItems;
		if (random 1 < _waitChance && _ac > 0) then {sleep _waitTime;};
		if !(call _check) exitWith {};
		{
			if !((_x select 0) in BRPVP_binocularToIgnoreAsWeapon) then {
				//GET ITEMS AND MAGS
				{
					if (_forEachIndex > 0) then {
						if (typeName _x == "ARRAY" && {count _x > 0}) then {_magsW pushBack _x;};
						if (typeName _x == "STRING" && {_x != ""}) then {_itemsW pushBack _x;};
					};
				} forEach _x;
				
				//WEAPON
				_from removeWeaponGlobal (_x select 0);
				_from removeItem (_x select 0);
				_weapon = (_x select 0) call BIS_fnc_baseWeapon;
				if (_cargo canAdd _weapon) then {
					_cargo addWeaponCargoGlobal [_weapon,1];
				} else {
					if (isNull _wh) then {call _createHolder;};
					_wh addWeaponCargoGlobal [_weapon,1];
				};
			};
		} forEach _weaponItems;
	};
	_items = items _from;

	//TRANSFER WEAPONS MAGS
	{
		_class = _x select 0;
		_count = _x select 1;
		_from removeMagazineGlobal _class;
		if (_cargo canAdd _class) then {
			_cargo addMagazineAmmoCargo [_class,1,_count];
		} else {
			if (isNull _wh) then {call _createHolder;};
			_wh addMagazineAmmoCargo [_class,1,_count];
		};
	} forEach _magsW;

	//TRANSFER WEAPONS ITEMS
	{
		_from removeItem _x;
		if (_cargo canAdd _x) then {
			_cargo addItemCargoGlobal [_x,1];
		} else {
			if (isNull _wh) then {call _createHolder;};
			_wh addItemCargoGlobal [_x,1];
		};
	} forEach _itemsW;

	//TRANSFER UNIT MAGS
	_ac = count _mags;
	if (random 1 < _waitChance && _ac > 0) then {sleep _waitTime;};
	if !(call _check) exitWith {};
	{
		_class = _x select 0;
		_count = _x select 1;
		_from removeMagazineGlobal _class;
		if (_cargo canAdd _class) then {
			_cargo addMagazineAmmoCargo [_class,1,_count];
		} else {
			if (isNull _wh) then {call _createHolder;};
			_wh addMagazineAmmoCargo [_class,1,_count];
		};
	} forEach _mags;

	//TRANSFER UNIT ASSIGNED ITEMS
	if (!_onlyMinorItems) then {
		_ac = count _itemsAssigned;
		if (random 1 < _waitChance && _ac > 0) then {sleep _waitTime;};
		if !(call _check) exitWith {};
		{
			if (_x in BRPVP_binocularToIgnoreAsWeapon) then {
				_from removeWeapon _x;
			} else {
				_from unlinkItem _x;
			};
			if (_cargo canAdd _x) then {
				_cargo addItemCargoGlobal [_x,1];
			} else {
				if (isNull _wh) then {call _createHolder;};
				_wh addItemCargoGlobal [_x,1];
			};
		} forEach _itemsAssigned;
	};
	
	//TRANSFER UNIT ITEMS
	_ac = count _items;
	if (random 1 < _waitChance && _ac > 0) then {sleep _waitTime;};
	if !(call _check) exitWith {};
	{
		_from removeItem _x;
		if (_cargo canAdd _x) then {
			_cargo addItemCargoGlobal [_x,1];
		} else {
			if (isNull _wh) then {call _createHolder;};
			_wh addItemCargoGlobal [_x,1];
		};
	} forEach _items;

	//TRANSFER CONTAINERS
	if (!_onlyMinorItems) then {
		_v = vest _from;
		if (random 1 < _waitChance && _v != "") then {sleep _waitTime;};
		if !(call _check) exitWith {};
		if (_v != "") then {
			if (_cargo canAdd _v) then {
				_cargo addItemCargoGlobal [_v,1];
			} else {
				if (isNull _wh) then {call _createHolder;};
				_wh addItemCargoGlobal [_v,1];
			};
			removeVest _from;
		};
		_b = backpack _from;
		if (random 1 < _waitChance && _b != "") then {sleep _waitTime;};
		if !(call _check) exitWith {};
		if (_b != "") then {
			if (_cargo canAdd _b) then {
				_cargo addBackpackCargoGlobal [_b,1];
			} else {
				if (isNull _wh) then {call _createHolder;};
				_wh addBackpackCargoGlobal [_b,1];
			};
			removeBackpackGlobal _from;
		};
	};

	//SET CARGO TO SAVE
	if !(_cargo getVariable ["slv",false]) then {_cargo setVariable ["slv",true,true];};
};
BRPVP_transferCargoCargo = {
	params ["_from","_cargo",["_token",-1],["_savePerc",[1,1,1,1]]];
	private ["_wh"];
	//GET GEAR INFO
	_weaponItems = weaponsItemsCargo _from;
	_mags = magazinesAmmoCargo _from;
	_bags = backpackCargo _from;
	_items = getItemCargo _from;
	_everyContainer = everyContainer _from;
	_check = [];
	_checkRemove = [];
	_everyContainer = _everyContainer apply {
		if (_x select 1 in _check) then {
			_checkRemove pushBack (_x select 0);
			-1
		} else {
			_check pushBack (_x select 1);
			_x
		};
	};
	_everyContainer = _everyContainer - [-1];
	{
		_idx = _bags find _x;
		if (_idx != -1) then {_bags deleteAt _idx;};
	} forEach _checkRemove;
	{
		_c = _x select 1;
		_weaponItems append weaponsItemsCargo _c;
		_mags append magazinesAmmoCargo _c;
		_is = getItemCargo _c;
		if (count (_is select 0) > 0) then {_items = [(_items select 0) + (_is select 0),(_items select 1) + (_is select 1)];};
	} forEach _everyContainer;
	clearWeaponCargoGlobal _from;
	clearMagazineCargoGlobal _from;
	clearItemCargoGlobal _from;
	clearBackpackCargoGlobal _from;
	
	//GROUND HOLDER
	_wh = objNull;
	_whs = nearestObjects [_cargo,["GroundWeaponHolder"],30];
	{
		if (_x getVariable ["tuc",-1] == _token && {_x != _from}) then {
			if (_x distanceSqr _cargo < 144) then {
				_wh = _x;
			};
		};
		if (!isNull _wh) exitWith {};
	} forEach _whs;
	_createHolder = {
		_wh = createVehicle ["GroundWeaponHolder",getPosATL _cargo,[],0,"NONE"];
		_wh setVariable ["tuc",_token,true];
	};

	//GET ITEMS AND MAGS FROM THE WEAPONS
	{
		_weaponDetails = _x;
		{
			if (_forEachIndex > 0) then {
				if (typeName _x == "ARRAY" && {count _x > 0}) then {_mags pushBack _x;};
				if (typeName _x == "STRING" && {_x != ""}) then {_items pushBack _x;};
			};
		} forEach _weaponDetails;
	} forEach _weaponItems;

	//TRANSFER MAGS
	_savePercThis = _savePerc select 0;
	{
		_class = _x select 0;
		_count = _x select 1;
		if (random 1 < _savePercThis) then {
			if (_cargo canAdd _class) then {
				_cargo addMagazineAmmoCargo [_class,1,_count];
			} else {
				if (isNull _wh) then {call _createHolder;};
				_wh addMagazineAmmoCargo [_class,1,_count];
			};
		};
	} forEach _mags;

	//TRANSFER ITEMS
	_savePercThis = _savePerc select 1;
	{
		for "_q" from 1 to (_items select 1 select _forEachIndex) do {
			if (random 1 < _savePercThis) then {
				if (_cargo canAdd _x) then {
					_cargo addItemCargoGlobal [_x,1];
				} else {
					if (isNull _wh) then {call _createHolder;};
					_wh addItemCargoGlobal [_x,1];
				};
			};
		};
	} forEach (_items select 0);
	
	//TRANSFER WEAPONS
	_savePercThis = _savePerc select 2;
	{
		if (random 1 < _savePercThis) then {
			_weapon = (_x select 0) call BIS_fnc_baseWeapon;
			if !(_weapon in BRPVP_binocularToIgnoreAsWeapon) then {
				if (_cargo canAdd _weapon) then {
					_cargo addWeaponCargoGlobal [_weapon,1];
				} else {
					if (isNull _wh) then {call _createHolder;};
					_wh addWeaponCargoGlobal [_weapon,1];
				};
			};
		};
	} forEach _weaponItems;
	
	//TRANSFER BAGS
	_savePercThis = _savePerc select 3;
	{
		if (random 1 < _savePercThis) then {
			if (_cargo canAdd _x) then {
				_cargo addBackpackCargoGlobal [_x,1];
			} else {
				if (isNull _wh) then {call _createHolder;};
				_wh addBackpackCargoGlobal [_x,1];
			};
		};
	} forEach _bags;

	//SET CARGOS TO SAVE
	if !(typeOf _from in ["GroundWeaponHolder","WeaponHolderSimulated"]) then {
		if !(_from getVariable ["slv",false]) then {_from setVariable ["slv",true,true];};
	};
	if !(_cargo getVariable ["slv",false]) then {_cargo setVariable ["slv",true,true];};
};
BRPVP_isCfgSimilar = {
	private ["_i1","_i2","_i1c","_i2c","_i1p","_i2p","_idxi1","_return"];
	_i1 = _this;
	_return = [];
	_idxi1 = BRPVP_mercadoItensClass find _i1;
	if (_idxi1 >= 0) then {
		_return = BRPVP_mercadoItens select _idxi1;
	} else {
		if (isClass (configFile >> "CfgMagazines" >> _i1)) then {
			_i1c = 0;
			_i1p = [configfile >> "CfgMagazines" >> _i1,true] call BIS_fnc_returnParents;
		} else {
			if (isClass (configFile >> "CfgWeapons" >> _i1)) then {
				_i1c = 1;
				_i1p = [configfile >> "CfgWeapons" >> _i1,true] call BIS_fnc_returnParents;
			} else {
				if (isClass (configFile >> "CfgVehicles" >> _i1)) then {
					_i1c = 2;
					_i1p = [configfile >> "CfgVehicles" >> _i1,true] call BIS_fnc_returnParents;
				};
			};
		};
		{
			_i2 = _x;
			_i2c = BRPVP_mercadoItensParents select _forEachIndex select 1;
			_i2p = BRPVP_mercadoItensParents select _forEachIndex select 2;
			if (_i2c == _i1c && {_i1 in _i2p || {_i2 in _i1p}}) exitWith {
				_return = BRPVP_mercadoItens select _forEachIndex;
			};
		} forEach BRPVP_mercadoItensClass;
	};
	_return
};
LOL_fnc_selectRandom = {
	_this select (floor random count _this)
};
LOL_fnc_selectRandomIdx = {
	private _idx = floor random count _this;
	[_this select _idx,_idx] 
};
LOL_fnc_selectRandomFator = {
	params ["_array","_factor"];
	_array select floor ((random ((count _array)^(1/_factor)))^(_factor))
};
LOL_fnc_selectRandomFactorIdx = {
	params ["_array","_factor"];
	private _idc = floor ((random ((count _array)^(1/_factor)))^(_factor));
	[_array select _idc,_idc]
};
LOL_fnc_selectRandomN = {
	params ["_array","_n",["_unique",true]];
	private _return = [];
	_ca = count _array;
	for "_i" from 1 to (_n min _ca) do {
		_cs = _array call LOL_fnc_selectRandomIdx;
		_idx = _cs select 1;
		if (_unique) then {
			_return pushBack (_array deleteAt _idx);
		} else {
			_return pushBack (_array select _idx);
		};
	};
	_return
};
BRPVP_execFast = {
	params ["_nome","_script",["_wait",true]];
	BRPVP_fsmTerminou = false;
	BRPVP_paralelContinue = false;
	[_nome,_script] execFSM "execucaoPrioritaria.fsm";
	if (_wait) then {
		waitUntil {BRPVP_fsmTerminou};
	};
};
BRPVP_tempoPorExtenso = {
	private ["_txt","_horas","_horasFloor","_minutos","_minutosFloor","_segundosFloor"];
	_horas = _this/3600;
	_horasFloor = floor _horas;
	_minutos = (_horas - _horasFloor) * 60;
	_minutosFloor = floor _minutos;
	_segundosFloor = floor ((_minutos - _minutosFloor) * 60);
	if (_horasFloor > 0) then {
		_txt = str _horasFloor + "h " + str _minutosFloor + "m " + str _segundosFloor + "s";
	} else {
		if (_minutosFloor > 0) then {
			_txt = str _minutosFloor + "m " + str _segundosFloor + "s";
		} else {
			_txt = str _segundosFloor + "s";
		};
	};
	_txt
};
BRPVP_adicCargo = {
	params ["_cargo","_classe"];
	_nomArr = _cargo select 0;
	_qttArr = _cargo select 1;
	_idc = _nomArr find _classe;
	if (_idc >= 0) then {
		_qttArr set [_idc,(_qttArr select _idc) + 1];
		_cargo set [1,_qttArr];
	} else {
		_nomArr = _nomArr + [_classe];
		_qttArr = _qttArr + [1];
		_cargo = [_nomArr,_qttArr];
	};
	_cargo
};
BRPVP_addLoot = {
	params ["_holder","_itemsAll",["_failHolder",objNull]];
	_failedItems = [];
	if (_holder == player) then {
		{
			_idc = BRPVP_specialItems find _x;
			if (_idc >= 0) then {
				_sit = _holder getVariable ["sit",[]];
				_sit pushBack _idc;
				_holder setVariable ["sit",_sit,true];
			} else {
				if (isClass (configFile >> "CfgVehicles" >> _x)) then {
					if (isNull backPackContainer player) then {player addBackpack _x;} else {_failedItems pushBack _x;};
				} else {
					if (isClass (configFile >> "CfgWeapons" >> _x)) then {
						_isItem = _x iskindOf ["ItemCore",configFile >> "CfgWeapons"];
						_isBino = _x iskindOf ["Binocular",configFile >> "CfgWeapons"];
						if (_x find "U_" == 0 || _x find "V_" == 0 || _x find "Item" == 0 || _isItem || _isBino) then {
							if (_x find "U_" == 0) then {
								if (isNull uniformContainer player) then {
									player forceAddUniform _x;
								} else {
									if (player canAdd _x) then {player addItem _x;} else {_failedItems pushBack _x;};
								};
							} else {
								if (_x find "V_" == 0) then {
									if (isNull vestContainer player) then {
										player addVest _x;
									} else {
										if (player canAdd _x) then {player addItem _x;} else {_failedItems pushBack _x;};
									};
								} else {
									if (_isItem) then {
										if (!(_x in assignedItems player) && _x find "Item" == 0) then {
											player linkItem _x;
										} else {
											if (player canAdd _x) then {player addItem _x;} else {_failedItems pushBack _x;};
										};
									} else {
										if (_isBino) then {
											_isNVG = _x isKindOf ["NVGoggles",configFile >> "CfgWeapons"];
											_hasNVG = hmd player != "";
											_hasVEC = binocular player != "";
											if ((_isNVG && _hasNVG) || (!_isNVG && _hasVEC)) then {
												if (player canAdd _x) then {player addItem _x;} else {_failedItems pushBack _x;};
											} else {
												player addWeapon _x;
											};
										};
									};
								};
							};
						} else {
							_type = getNumber (configFile >> "CfgWeapons" >> _x >> "Type");
							if (_type == 1) then {
								if (primaryWeapon player == "") then {player addWeapon _x;} else {_failedItems pushBack _x;};
							};
							if (_type == 2) then {
								if (handGunWeapon player == "") then {player addWeapon _x;} else {_failedItems pushBack _x;};
							};
							if (_type == 4) then {
								if (secondaryWeapon player == "") then {player addWeapon _x;} else {_failedItems pushBack _x;};
							};
							if !(_type in [1,2,4]) then {_failedItems pushBack _x;};
						};
					} else {
						if (isClass (configFile >> "CfgMagazines" >> _x)) then {
							if (player canAdd _x) then {player addMagazine _x;} else {_failedItems pushBack _x;};
						};
					};
				};
			};
		} forEach _itemsAll;
		_holder = _failHolder;
		_itemsAll = _failedItems;
	};
	if (!isNull _holder) then {
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
		} forEach _itemsAll;
	};
	if (count _itemsAll == 0 && !isNull _failHolder) then {deleteVehicle _failHolder;};
	(count _failedItems > 0)
};
BRPVP_pegaSegsBBChao = {
	_bb = boundingBoxReal _this;
	_p1 = _bb select 0;
	_p2 = _bb select 1;
	_p1x = _p1 select 0;
	_p2x = _p2 select 0;
	_p1y = _p1 select 1;
	_p2y = _p2 select 1;
	_segs = [
		//FLOOR
		[[_p1x,_p1y,0],[_p2x,_p1y,0]],
		[[_p2x,_p1y,0],[_p2x,_p2y,0]],
		[[_p2x,_p2y,0],[_p1x,_p2y,0]],
		[[_p1x,_p2y,0],[_p1x,_p1y,0]]
	];
	_segs
};
BRPVP_emVoltaBB = {
	params ["_obj","_extra"];
	_segs = _obj call BRPVP_pegaSegsBBChao;
	_seg = _segs call BIS_fnc_selectRandom;
	_p1 = _seg select 0;
	_p2 = _seg select 1;
	_p3 = _p1 vectorAdd ((_p2 vectorDiff _p1) vectorMultiply random 1);
	_p3 set [2,0];
	_dist = _p3 distance [0,0,0];
	_mult = (_dist + _extra)/_dist;
	_p4 = _p3 vectorMultiply _mult;
	_retorno = _obj modelToWorld _p4;
	_retorno set [2,0];
	_retorno
};
BRPVP_emVoltaBBManual = {
	params ["_obj","_extra","_lado","_fator"];
	_segs = _obj call BRPVP_pegaSegsBBChao;
	_seg = _segs select _lado;
	_p1 = _seg select 0;
	_p2 = _seg select 1;
	_p3 = _p1 vectorAdd ((_p2 vectorDiff _p1) vectorMultiply _fator);
	_p3 set [2,0];
	_dist = _p3 distance [0,0,0];
	_mult = (_dist + _extra)/_dist;
	_p4 = _p3 vectorMultiply _mult;
	_retorno = _obj modelToWorld _p4;
	_retorno set [2,0];
	_retorno
};
BRPVP_isInsideBuilding = {
	params ["_unit","_building",["_h",50]];
	private ["_p1","_p2","_p3","_objects","_tstA""_tstB"];
	_p1 = getPosASL _unit;
	_p2 = [_p1 select 0,_p1 select 1,(_p1 select 2) - 1];
	_objects = lineIntersectsWith [_p1,_p2];
	_tstA = _building in _objects;
	if (!_tstA) then {
		_p3 = [_p1 select 0,_p1 select 1,(_p1 select 2) + _h];
		_objects = lineIntersectsWith [_p1,_p3];
		_building in _objects
	} else {
		true
	};
};
BRPVP_achaCentroPrincipal = {
	params [
		"_objetos",				//LISTA DE OBJETOS QUE PODEM SER CENTRO PRINCIPAL
		"_tipoPertoClass",		//ARRAY DE CLASSES QUE DEVEM SER VERIFICADOS NAS REDONDEZAS DO CENTRO PRINCIPAL
		"_tipoPertoModel",		//ARRAY COM SUBSTRING DO NOME DOS MODELOS A SEREM PROCURADOS NAS REDONDEZAS
		"_tipoPertoRaio",		//RAIO DA REDONDEZA
		"_polaridade",			//PARA QUANTO MAIS MELHOR USE 1, PARA QUANTO MENOS MELHOR USE -1
		"_insiste",				//NUMERO DE INSISTENCIA EM OBJETOS MELHOR POSICIONADOS
		["_ruasSeNada",true],	//CONTA RUAS NAS REDONDEZAS SE NADA DEFINIDO PARA CONTAR
		["_ladoAmigo",""],		//LADO AMIGO para dar preferencia a proximidade
		["_ladoInimigo",""]		//LADO INIMIGO para dar preferencia a nao-proximidade
	];
	private ["_ladoContar","_pos","_codContaLado","_codContaModel","_codContaClass","_objDaVez","_qtPerto","_codConta","_objDaVezTenta","_qtTop","_distTop","_qtPerto","_distSoma","_qtPertoCod","_distSomaCod"];

	//FUNCOES CONTAR
	_codContaClass = {
		{
			_qtPerto = _qtPerto + count (_objDaVezTenta nearobjects [_x,_tipoPertoRaio]);
		} forEach _tipoPertoClass;
	};
	_codContaModel = {
		{
			private ["_txt"];
			_txt = str _x;
			{
				if (_txt find _x >= 0) exitWith {
					_qtPerto = _qtPerto + 1;
				};
			} forEach _tipoPertoModel;
		} forEach (nearestobjects [_objDaVezTenta,[],_tipoPertoRaio]);
	};
	_codContaLado = {
		{
			private ["_lado","_lider","_dist"];
			_lado = side _x;
			if (_lado isEqualTo _ladoContar) then {
				_lider = leader _x;
				_dist = _pos distance2D _lider;
				_distSoma = _distSoma + (_dist/100)^2;
			};
		} forEach allGroups;
	};
	
	//CONTAGEM DE AMIGOS INIMIGOS
	if (typeName _ladoAmigo != "STRING") then {
		private ["_qa"];
		_qa = {(side _x) isEqualTo _ladoAmigo} count allGroups;
		if (_qa > 0) then {
			_distTop = 1000000;
			_ladoContar = _ladoAmigo;
			_distSomaCod = {_distSoma < _distTop};	
		} else {
			if (typeName _ladoInimigo != "STRING") then {
				private ["_qi"];
				_qi = {(side _x) isEqualTo _ladoInimigo} count allGroups;
				if (_qi > 0) then {
					_distTop = 0;
					_ladoContar = _ladoInimigo;
					_distSomaCod = {_distSoma > _distTop};
				} else {
					_codContaLado = {};
					_distSomaCod = {true};
				};
			} else {
				_codContaLado = {};
				_distSomaCod = {true};
			};
		};
	} else {
		if (typeName _ladoInimigo != "STRING") then {
			private ["_qi"];
			_qi = {(side _x) isEqualTo _ladoInimigo} count allGroups;
			if (_qi > 0) then {
				_distTop = 0;
				_ladoContar = _ladoInimigo;
				_distSomaCod = {_distSoma > _distTop};
			} else {
				_codContaLado = {};
				_distSomaCod = {true};
			};
		} else {
			_codContaLado = {};
			_distSomaCod = {true};
		};
	};
	
	//FUNCOES CONTAR COMBINADAS
	if (count _tipoPertoClass > 0 && count _tipoPertoModel > 0) then {
		_codConta = {
			call _codContaClass;
			call _codContaModel;
		};
	};
	if (count _tipoPertoClass > 0 && count _tipoPertoModel == 0) then {
		_codConta = {call _codContaClass};
	};
	if (count _tipoPertoClass == 0 && count _tipoPertoModel > 0) then {
		_codConta = {call _codContaModel;};
	};
	if (count _tipoPertoClass == 0 && count _tipoPertoModel == 0) then {
		if (_ruasSeNada) then {
			_codConta = {_qtPerto = count ((position _objDaVezTenta) nearRoads _tipoPertoRaio);};
		} else {
			_codConta = {};
		};
	};
	if (_codConta isEqualTo {}) then {
		_qtPertoCod = {true};
	} else {
		if (_polaridade == 1) then {
			_qtTop = 0;
			_qtPertoCod = {_qtPerto > _qtTop};
		};
		if (_polaridade == -1) then {
			_qtTop = 1000000;
			_qtPertoCod = {_qtPerto < _qtTop};
		};
	};
	
	//PROCURA CENTRO
	_objDaVez = objNull;
	for "_k" from 1 to _insiste do {
		_objDaVezTenta = _objetos call BIS_fnc_selectRandom;
		_qtPerto = 0;
		_distSoma = 0;
		_pos = getPosASL _objDaVezTenta;
		call _codConta;
		call _codContaLado;
		if (call _qtPertoCod) then {
			if (call _distSomaCod) then {
				_qtTop = _qtPerto;
				_distTop = _distSoma;
				_objDaVez = _objDaVezTenta;
			};
		};
	};
	_objDaVez
};
BRPVP_achaLocal = {
	params [
		"_centro",			//1.0 - CENTRO PRIMARIO
		"_resPadrao",		//1.0 - RESULTADO PADRAO CASO NAO ACHE
		"_raioMin",			//2.1 - CENTRO SECUNDARIO: RAIO MINIMO A PARTIR DO CENTRO PRIMARIO
		"_raioMinRand",		//2.1 - CENTRO SECUNDARIO: ADICIONAL RANDOMICO AO RAIO MINIMO (PODE SER 0)
		"_raioMax",			//2.2 - CENTRO SECUNDARIO: RAIO MAXIMO A PARTIR DO CENTRO PRIMARIO
		"_raioMaxRand",		//2.2 - CENTRO SECUNDARIO: ADICIONAL RANDOMICO AO RAIO MAXIMO (PODE SER 0)
		"_stepHor",			//3.0 - MOVIMENTO HORIZONTAL DO CENTRO SECUNDARIO
		"_stepVer",			//3.0 - MOVIMENTO VERTICAL DO CENTRO SECUNDARIO
		"_raioAtrCheck",	//4.0 - RAIO DE CHECK DE ATRIBUTOS (RUA E ELEVACAO) AO REDOR DO CENTRO SECUNDARIO
		"_podeRua",			//4.1 - PERMITIDO RUA NO RAIO _raioAtrCheck? TRUE/FALSE.
		"_stepAtr",			//4.1 - STEP DE CHECK DE RUAS (<= _raioAtrCheck)
		"_maxElev",			//4.2 - MAXIMA ELEVACAO MEDIA PERMITIDA
		"_objClass",		//4.3 - ARRAY DE OBJETOS A SEREM PROCURADOS
		"_objModel",		//4.3 - SUBSTRING DO NOME DO MODELO DO OBJETO A SER PROCURADO
		"_objMaxQt",		//4.3 - QUANTIA MAXIMA DE OBJETOS PERMITIDOS
		"_podeAgua"			//4.4 - PERMITIDO AGUA NO RAIO _raioAtrCheck? TRUE/FALSE.
	];
	private ["_imput","_result","_minDist","_maxDist","_blackList"];
	_origin = if (typeName _centro == "OBJECT") then {position _centro} else {_centro};
	_minDist = _raioMin + random _raioMinRand;
	_maxDist = _raioMax + random _raioMaxRand;
	_step = 15;
	_donutsQt = (_maxDist - _minDist)/_step;
	_blackList = [];
	{
		_pos = getPos _x;
		_so = sizeOf typeOf _x;
		_so = _so/1.65;
		_pTL = _pos vectorAdd [-_so,_so,0];
		_pBR = _pos vectorAdd [_so,-_so,0];
		_pTL resize 2;
		_pBR resize 2;
		_blackList pushBack [_pTL,_pBR];
	} forEach nearestObjects [_origin,["LandVehicle","Air","Man","Ship","Building","House"],_maxDist];
	_imput = [
		_origin,
		0,
		0,
		_raioAtrCheck,
		if (_podeAgua) then {1} else {0},
		tan _maxElev,
		0,
		_blackList,
		[_resPadrao,_resPadrao]
	];
	for "_i" from 1 to (ceil _donutsQt) do {
		_imput set [1,_minDist + (_i - 1) * _step];
		_imput set [2,if (_i < _donutsQt) then {_minDist + _i * _step} else {_maxDist}];
		_result = _imput call BIS_fnc_findSafePos;
		if !(_result isEqualTo _resPadrao) exitWith {};
	};
	_result
};
BRPVP_achaLocalWIP = {
	params [
		"_centro",			//1.0 - CENTRO PRIMARIO
		"_resPadrao",		//1.0 - RESULTADO PADRAO CASO NAO ACHE
		"_raioMin",			//2.1 - CENTRO SECUNDARIO: RAIO MINIMO A PARTIR DO CENTRO PRIMARIO
		"_raioMinRand",		//2.1 - CENTRO SECUNDARIO: ADICIONAL RANDOMICO AO RAIO MINIMO (PODE SER 0)
		"_raioMax",			//2.2 - CENTRO SECUNDARIO: RAIO MAXIMO A PARTIR DO CENTRO PRIMARIO
		"_raioMaxRand",		//2.2 - CENTRO SECUNDARIO: ADICIONAL RANDOMICO AO RAIO MAXIMO (PODE SER 0)
		"_stepHor",			//3.0 - MOVIMENTO HORIZONTAL DO CENTRO SECUNDARIO
		"_stepVer",			//3.0 - MOVIMENTO VERTICAL DO CENTRO SECUNDARIO
		"_raioAtrCheck",	//4.0 - RAIO DE CHECK DE ATRIBUTOS (RUA E ELEVACAO) AO REDOR DO CENTRO SECUNDARIO
		"_podeRua",			//4.1 - PERMITIDO RUA NO RAIO _raioAtrCheck? TRUE/FALSE.
		"_stepAtr",			//4.1 - STEP DE CHECK DE RUAS (<= _raioAtrCheck)
		"_maxElev",			//4.2 - MAXIMA ELEVACAO MEDIA PERMITIDA
		"_objClass",		//4.3 - ARRAY DE OBJETOS A SEREM PROCURADOS
		"_objModel",		//4.3 - SUBSTRING DO NOME DO MODELO DO OBJETO A SER PROCURADO
		"_objMaxQt",		//4.3 - QUANTIA MAXIMA DE OBJETOS PERMITIDOS
		"_podeAgua"			//4.4 - PERMITIDO AGUA NO RAIO _raioAtrCheck? TRUE/FALSE.
	];
	private ["_checaAtr","_tiraPorAtr","_raio","_angInic","_ang","_pos","_posCheck","_qt","_angAdic","_posCheckAtr","_elevSoma","_elevSomaQt"];
	if (typeName _centro == "OBJECT") then {_centro = position _centro;};
	_raio = _raioMin + random _raioMinRand;
	_raioMax = _raio + _raioMax + random _raioMaxRand;
	_angInic = random 360;
	_ang = _angInic;
	_pos = _resPadrao;
	if (!_podeRua && !_podeAgua) then {
		_checaAtr = {surfaceIsWater _posCheckAtr || isOnRoad _posCheckAtr};
	} else {
		if (_podeRua && !_podeAgua) then {
			_checaAtr = {surfaceIsWater _posCheckAtr};
		} else {
			if (!_podeRua && _podeAgua) then {
				_checaAtr = {isOnRoad _posCheckAtr};
			} else {
				if (_podeRua && _podeAgua) then {
					_checaAtr = {false};
				};
			};
		};
	};
	_procuraModels = {};
	if (count _objModel > 0) then {
		_procuraModels = {
			{
				_txt = str _x;
				{if (_txt find _x >= 0) exitWith {_qt = _qt + 1;};} forEach _objModel;
			} forEach (nearestObjects [_posCheck,[],_raioAtrCheck]);
		};
	};
	diag_log "======= [PROCURA LOCAL DETALHE] ======================================";
	while {_raio < _raioMax} do {
		_posCheck = [(_centro select 0) + _raio * sin _ang,(_centro select 1) + _raio * cos _ang,0];
		_qt = 0;
		{_qt = _qt + count (_posCheck nearobjects [_x,_raioAtrCheck]);} forEach _objClass;
		call _procuraModels;
		_tiraPorAtr = false;
		_elevSoma = 0;
		_elevSomaQt = 0;
		for "_a" from 0 to (floor ((_raioAtrCheck/_stepAtr)+0.001)) do {
			{
				_posCheckAtr = [
					(_posCheck select 0)+(_x select 0)*_a*_stepAtr,
					(_posCheck select 1)+(_x select 1)*_a*_stepAtr,
					_posCheck select 2
				];
				_elevSoma = _elevSoma + acos ((surfaceNormal _posCheckAtr) vectorCos [0,0,1]);
				_elevSomaQt = _elevSomaQt + 1;
				if (call _checaAtr) exitWith {_tiraPorAtr = true;};
			} forEach [[1,0],[-1,0],[0,1],[0,-1],[0.7,0.7],[-0.7,-0.7],[0.7,-0.7],[-0.7,0.7]];
			if (_tiraPorAtr) exitWith {};
		};
		diag_log ("REFINAMENTO: qt_classes = " + str _qt + "/" + str _objMaxQt + " | elevacao = " + str _elevSoma + "/" + str _maxElev + " | off_por_atrib = " + str _tiraPorAtr + ".");
		if (_qt <= _objMaxQt && _elevSoma/_elevSomaQt <= _maxElev && !_tiraPorAtr) exitWith {
			_pos = _posCheck;
		};
		_angAdic = (360 * _stepHor)/(2 * pi * _raio);
		if (_ang + _angAdic - _angInic > 360) then {
			_ang = _angInic;
			_raio = _raio + _stepVer;
		} else {
			_ang = _ang + _angAdic;
		};
	};
	diag_log "======= [PROCURA LOCAL DETALHE FIM] ==================================";
	_pos
};
BRPVP_pelaUnidade = {
	{_this removeMagazine _x;} forEach  magazines _this;
	{_this removeWeapon _x;} forEach weapons _this;
	{_this removeItem _x;} forEach items _this;
	removeAllAssignedItems _this;
	removeBackpackGlobal _this;
	removeUniform _this;
	removeVest _this;
	removeHeadGear _this;
	removeGoggles _this;
};
BRPVP_leaveJustUniform = {
	{_this removeMagazine _x;} forEach  magazines _this;
	{_this removeWeapon _x;} forEach weapons _this;
	{_this removeItem _x;} forEach items _this;
	removeAllAssignedItems _this;
	removeBackpackGlobal _this;
	removeVest _this;
	removeHeadGear _this;
	removeGoggles _this;
};
BRPVP_leaveJustUniformAndHeadGear = {
	{_this removeMagazine _x;} forEach  magazines _this;
	{_this removeWeapon _x;} forEach weapons _this;
	{_this removeItem _x;} forEach items _this;
	removeAllAssignedItems _this;
	removeBackpackGlobal _this;
	removeVest _this;
};
BRPVP_getBBMult = {
	params ["_obj","_extraSize"];
	_oBox = boundingBoxReal _obj;
	_p1 = _oBox select 0;
	_p2 = _oBox select 1;
	_p12 = + _p1;
	_p21 = + _p2;
	_p12 set [2,_p2 select 2];
	_p21 set [2,_p1 select 2];
	_pf1 = _p1 vectorAdd ((vectorNormalized (_p1 vectorDiff _p21)) vectorMultiply _extraSize);
	_pf2 = _p2 vectorAdd ((vectorNormalized (_p2 vectorDiff _p12)) vectorMultiply _extraSize);
	[_pf1,_pf2]
};
//Author: pedeathtrian
//Original: https://forums.bistudio.com/topic/191898-distance-to-bounding-box/#entry3050642
PDTH_pointIsInBoxHelper = {
	params ["_pt0","_pt1"];
	(_pt0 select 0 <= _pt1 select 0) && (_pt0 select 1 <= _pt1 select 1) && (_pt0 select 2 <= _pt1 select 2)
};
PDTH_pointIsInBox = {
	params ["_unit","_obj"];
	_posUnit = if (typeName _unit == "OBJECT") then {ASLToAGL getPosASL _unit} else {_unit};
	_uPos = _obj worldToModel _posUnit;
	_ovb = _obj getVariable ["bbx",[]];
	_oBox = if (count _ovb == 0) then {boundingBoxReal _obj} else {_ovb};
	([_oBox select 0,_uPos] call PDTH_pointIsInBoxHelper) && ([_uPos, _oBox select 1] call PDTH_pointIsInBoxHelper)
};
//Author: pedeathtrian
//https://forums.bistudio.com/topic/191898-distance-to-bounding-box/#entry3050642
PDTH_distance2Box = {
	params ["_unit","_obj"];
	_uPos = _obj worldToModel (ASLToAGL getPosASL _unit);
	_oBox = boundingBoxReal _obj;
	_pt = [0,0,0];
	{
		if (_x < (_oBox select 0 select _forEachIndex)) then {
			_pt set [_forEachIndex,(_oBox select 0 select _forEachIndex) - _x];
		} else {
			if ((_oBox select 1 select _forEachIndex) < _x) then {
				_pt set [_forEachIndex,_x - (_oBox select 1 select _forEachIndex)];
			};
		};
	} forEach _uPos;
	_pt distance [0,0,0]
};
PDTH_distance2BoxQuad = {
	params ["_unit","_obj"];
	_uPos = _obj worldToModel (ASLToAGL getPosASL _unit);
	_oBox = boundingBoxReal _obj;
	_pt = [0,0,0];
	{
		if (_x < (_oBox select 0 select _forEachIndex)) then {
			_pt set [_forEachIndex,(_oBox select 0 select _forEachIndex) - _x];
		} else {
			if ((_oBox select 1 select _forEachIndex) < _x) then {
				_pt set [_forEachIndex,_x - (_oBox select 1 select _forEachIndex)];
			};
		};
	} forEach _uPos;
	_pt distanceSqr [0,0,0]
};
BRPVP_IsMotorized = {
	private ["_typeOf"];
	if (typeName _this == "STRING") then {
		_typeOf = _this;
		_cfgV = configFile >> "CfgVehicles";
		_typeOf isKindOf ["LandVehicle",_cfgV] || {_typeOf isKindOf ["Air",_cfgV] || {_typeOf isKindOf ["Ship",_cfgV]}}
	} else {
		_this isKindOf "LandVehicle" || {_this isKindOf "Air" || {_this isKindOf "Ship"}}
	}	
};
BRPVP_IsMotorizedNoTurret = {
	private ["_typeOf"];
	if (typeName _this == "STRING") then {
		_typeOf = _this;
		_cfgV = configFile >> "CfgVehicles";
		(_typeOf isKindOf ["LandVehicle",_cfgV] && !(_typeOf isKindOf ["StaticWeapon",_cfgV])) || {_typeOf isKindOf ["Air",_cfgV] || {_typeOf isKindOf ["Ship",_cfgV]}}
	} else {
		(_this isKindOf "LandVehicle" && !(_this isKindOf "StaticWeapon")) || {_this isKindOf "Air" || {_this isKindOf "Ship"}}
	}	
};
BRPVP_isBuilding = {
	private ["_typeOf"];
	if (typeName _this == "STRING") then {
		_typeOf = _this;
		_cfgV = configFile >> "CfgVehicles";
		_typeOf isKindOf ["Building",_cfgV]
	} else {
		_this isKindOf "Building"
	};
};
BRPVP_fillUnitWeapons = {
	params ["_unidade",["_qttWeps",[4,4,4]]];
	_mags = magazines _unidade;
	{
		_wep = _x;
		_qtt = _qttWeps select _forEachIndex;
		if (_wep != "") then {
			_magsWep = 0;
			_magsCfg = getArray (configFile >> "CfgWeapons" >> _wep >> "magazines");
			{
				if (_x in _magsCfg) then {_magsWep = _magsWep + 1;};
			} forEach _mags;
			if (_magsWep < _qtt) then {
				_mag = _magsCfg call BIS_fnc_selectRandom;
				for "_m" from 1 to (_qtt - _magsWep) do {
					if (_unidade canAdd _mag) then {
						_unidade addMagazine _mag;
					};
				};
			};
		};
	} forEach [primaryWeapon _unidade,secondaryWeapon _unidade,handGunWeapon _unidade];
};