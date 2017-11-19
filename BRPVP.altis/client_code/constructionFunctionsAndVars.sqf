diag_log "[BRPVP FILE] construcao.sqf INITIATED";

BRP_kitLight = ["Land_Razorwire_F","Land_Net_Fence_4m_F","Land_Net_Fence_8m_F","Land_Net_Fence_Gate_F","Land_Net_Fence_Pole_F","Land_Pipe_fence_4m_F"/*,"Land_Slums02_pole","Land_Slums02_4m"*/];
BRP_kitCamuflagem = ["CamoNet_BLUFOR_big_F","CamoNet_BLUFOR_F","CamoNet_BLUFOR_open_F","CamoNet_OPFOR_big_F","CamoNet_OPFOR_F","CamoNet_OPFOR_open_F","CamoNet_INDP_big_F","CamoNet_INDP_F","CamoNet_INDP_open_F"];
BRP_kitAreia = ["Land_BagFence_Long_F","Land_BagFence_Short_F","Land_HBarrier_1_F","Land_HBarrier_3_F","Land_HBarrier_5_F"];
BRP_kitCidade = ["Land_City_4m_F","Land_City2_4m_F","Land_City_8m_F","Land_City_8mD_F","Land_City2_8m_F","Land_City_Gate_F","Land_City_Pillar_F","Land_PipeWall_concretel_8m_F"];
BRP_kitStone = ["Land_Stone_4m_F","Land_Stone_8m_F","Land_Stone_8mD_F","Land_Stone_Gate_F","Land_Stone_Pillar_F","Land_PipeWall_concretel_8m_F"];
BRP_kitCasebres = ["Land_Slum_House01_F","Land_Slum_House02_F","Land_Slum_House03_F","Land_cmp_Shed_F","Land_cargo_house_slum_F","Land_FuelStation_Build_F"];
BRP_kitConcreto = ["Land_CncWall1_F","Land_CncWall4_F","Land_Concrete_SmallWall_4m_F","Land_Concrete_SmallWall_8m_F","Land_Wall_IndCnc_4_F","Land_PipeWall_concretel_8m_F","Land_ConcreteWall_01_m_gate_F","Land_ConcreteWall_01_l_gate_F"];
BRP_kitPedras = ["Land_Sea_Wall_F","Land_Mound01_8m_F","Land_Mound02_8m_F","Land_Castle_01_church_a_ruin_F"];
BRP_kitTorres = ["Land_Castle_01_tower_F","Land_Cargo_Tower_V1_F","Land_Cargo_Patrol_V1_F"];
BRP_bandeira = ["bandeira_x_azul","bandeira_x_cinza","bandeira_x_marrom","bandeira_x_verde","bandeira_x_roxa","bandeira_x_vermelha","bandeira_q_azul","bandeira_q_cinza","bandeira_q_marrom","bandeira_q_verde","bandeira_q_roxa","bandeira_q_vermelha"];
BRP_kitEspecial = ["Land_Dome_Small_F","Land_TentHangar_V1_F"];
BRP_kitAdmin = ["Land_Church_01_V1_F","Land_Offices_01_V1_F","Land_WIP_F","Land_dp_mainFactory_F","Land_i_Barracks_V1_F"];
BRP_kitTableChair = ["Land_WoodenTable_large_F","Land_WoodenTable_small_F","Land_ChairWood_F","Land_Bench_F","Land_Bench_01_F","Land_Bench_02_F","Land_CampingTable_F","Land_CampingTable_small_F","Land_CampingChair_V1_F","Land_CampingChair_V2_F"];
BRP_kitBeach = ["Land_Sunshade_F","Land_Sunshade_01_F","Land_Sunshade_02_F","Land_Sunshade_03_F","Land_Sunshade_04_F","Land_BeachBooth_01_F","Land_LifeguardTower_01_F","Land_TablePlastic_01_F","Land_ChairPlastic_F","Land_Sun_chair_F","Land_Sun_chair_green_F"];
BRP_kitReligious = ["Land_BellTower_01_V1_F","Land_BellTower_02_V1_F","Land_BellTower_02_V2_F","Land_Calvary_01_V1_F","Land_Calvary_02_V1_F","Land_Calvary_02_V2_F","Land_Grave_obelisk_F","Land_Grave_memorial_F","Land_Grave_monument_F"];
BRP_kitStuffo1 = ["Land_BarrelEmpty_F","Land_BarrelEmpty_grey_F","Land_Bucket_F","Land_Bucket_clean_F","Land_Bucket_painted_F","Land_BucketNavy_F","Land_GarbageContainer_closed_F","Land_Basket_F","Land_cargo_addon02_V1_F","Land_cargo_addon02_V2_F"];
BRP_kitStuffo2 = ["Land_GarbageBin_01_F","RoadCone_F","Land_GarbageBarrel_01_F","Land_WoodenLog_F","TargetP_Inf_F"];
BRP_kitLamp = ["Land_LampStreet_small_F","Land_LampStreet_F","Land_LampSolar_F","Land_LampDecor_F","Land_LampHalogen_F","Land_LampHarbour_F","Land_LampAirport_F"];
BRP_kitRecreation = ["Land_SlideCastle_F","Land_Carousel_01_F","Land_Swing_01_F","Land_Kiosk_redburger_F","Land_Kiosk_papers_F","Land_Kiosk_gyros_F","Land_Kiosk_blueking_F","Land_TouristShelter_01_F","Land_Slide_F","Land_BC_Basket_F","Land_BC_Court_F","Land_Goal_F","Land_Tribune_F"];
BRP_kitMilitarSign = ["Land_Sign_WarningMilitaryArea_F","Land_Sign_WarningMilAreaSmall_F","Land_Sign_WarningMilitaryVehicles_F","ArrowDesk_L_F","ArrowDesk_R_F","RoadBarrier_F","TapeSign_F"];
BRP_kitFuelStorage = ["Box_NATO_AmmoVeh_F","Box_East_AmmoVeh_F","Box_IND_AmmoVeh_F","Box_T_East_WpsSpecial_F","C_T_supplyCrate_F","Box_Syndicate_Ammo_F","Box_Syndicate_WpsLaunch_F","Land_fs_feed_F","Land_FuelStation_Feed_F"];
BRP_kitWrecks = ["Land_Wreck_BMP2_F","Land_Wreck_BRDM2_F","Land_Wreck_Heli_Attack_01_F","Land_Wreck_Heli_Attack_02_F","Land_Wreck_HMMWV_F","Land_Wreck_Hunter_F","Land_Wreck_Skodovka_F","Land_Wreck_Slammer_F","Land_Wreck_Slammer_hull_F","Land_Wreck_Slammer_turret_F","Land_Wreck_T72_hull_F","Land_Scrap_MRAP_01_F","Land_Wreck_Ural_F","Land_Wreck_UAZ_F"];
BRP_kitSmallHouse = ["Land_i_Addon_02_V1_F","Land_i_Addon_03_V1_F","Land_i_Addon_03mid_V1_F","Land_i_House_Small_02_V1_F","Land_i_House_Small_02_V2_F","Land_i_House_Small_02_V3_F","Land_GH_House_1_F","Land_GH_House_2_F","Land_i_House_Small_01_V1_F","Land_i_House_Small_01_V2_F","Land_Lighthouse_small_F","Land_i_Windmill01_F","Land_nav_pier_m_F","Land_HBarrierTower_F","Land_HBarrierWall_corridor_F"];
BRP_kitAverageHouse = ["Land_i_House_Big_01_V1_F","Land_i_House_Big_01_V2_F","Land_i_House_Big_01_V3_F","Land_i_House_Big_02_V1_F","Land_i_House_Big_02_V2_F","Land_i_House_Big_02_V3_F","Land_u_House_Big_01_V1_F","Land_u_House_Big_02_V1_F","Land_i_Shop_01_V1_F","Land_i_Shop_01_V2_F","Land_i_Shop_02_V1_F","Land_i_Shop_02_V2_F","Land_i_Shop_02_V3_F","Land_dp_smallTank_F"];
BRP_kitAntennaA = ["Land_TTowerSmall_1_F","Land_TTowerSmall_2_F"];
BRP_kitAntennaB = ["Land_TTowerBig_1_F","Land_TTowerBig_2_F"];
BRP_kitMovement = ["Land_PierLadder_F","Land_Castle_01_step_F","Land_RampConcrete_F","Land_RampConcreteHigh_F","Land_Obstacle_Ramp_F","Land_Obstacle_RunAround_F","Land_Obstacle_Climb_F","Land_Obstacle_Bridge_F","BlockConcrete_F","Land_Razorwire_F","Land_CncShelter_F"];
BRP_kitRespawnA = ["Land_PhoneBooth_01_F","Land_PhoneBooth_02_F","Land_GarbageContainer_closed_F","Land_FieldToilet_F","Land_WaterBarrel_F","Land_Pallets_stack_F","Land_PaperBox_closed_F"];
BRP_kitRespawnB = ["Land_Laptop_unfolded_F","Land_Ground_sheet_folded_blue_F","Land_Ground_sheet_folded_khaki_F","Land_Ground_sheet_folded_yellow_F","Land_Tyre_F","Land_BarrelEmpty_F","Land_MetalBarrel_empty_F","Land_BarrelEmpty_grey_F","Land_Ketchup_01_F"];
BRP_kitHelipad = ["Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadRescue_F","Land_HelipadSquare_F"];
BRP_kitAutoTurret = BRPVP_autoTurretTypes;
//FLAG KITS SET ON serverAndClientFunctions.sqf

BRPVP_construindoAngsRotacao = [45,15,5,1];
BRPVP_construindoAngRotacaoIdc = 2;
BRPVP_construindoAngRotacao = BRPVP_construindoAngsRotacao select BRPVP_construindoAngRotacaoIdc;
BRPVP_construindoHInts = [1.0,0.5,0.25,0.1,0.01];
BRPVP_construindoHIntIdc = 3;
BRPVP_construindoHInt = BRPVP_construindoHInts select BRPVP_construindoHIntIdc;
BRPVP_buildingLevelTerrain = false;
BRPVP_buildingItemName = "";
BRPVP_lindoAlinhaTerreno = {
	BRPVP_buildingItemObjBB params ["_dX","_dY"];
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
BRPVP_cancelaConstrucao = {
	player setVariable ["bdg",false,true];
	player setVariable ["obui",objNull,true];
	BRPVP_construindoItemObj removeAllEventHandlers "HandleDamage";
	deleteVehicle BRPVP_construindoItemObj;
	BRPVP_construindoItemObj = objNull;
	BRPVP_construindo = false;
	call BRPVP_atualizaDebug;
	BRPVP_construindoItemIdc = 0;
	if (BRPVP_construindoItemRetira == -1) then {50 call BRPVP_iniciaMenuExtra;} else {35 call BRPVP_iniciaMenuExtra;};
};
BRPVP_construindoItemIdc = 0;
BRPVP_construindoItens = BRP_kitLight;
BRPVP_construindoItemZero = "";
BRPVP_construindoAlinTerr = false;
BRPVP_construindoVecUp = [0,0,1];
BRPVP_construindoItemObj = objNull;
BRPVP_construindoItemObjClass = "none";
BRPVP_buildingClassWithImg = [
	"Land_TTowerSmall_1_F",
	"Land_TTowerSmall_2_F",
	"Land_TTowerBig_1_F",
	"Land_TTowerBig_2_F"
];
BRPVP_buildingClassWithImgPath = [
	"BRP_imagens\items\Land_TTowerSmall_1_F.paa",
	"BRP_imagens\items\Land_TTowerSmall_2_F.paa",
	"BRP_imagens\items\Land_TTowerBig_1_F.paa",
	"BRP_imagens\items\Land_TTowerBig_2_F.paa"
];
BRPVP_construcaoHint = {
	format [
		"<t align='center' color='#FFFFFF'>POSICIONAMENTO:</t><br/>
		<img size='%3' image='%1'/><br/>
		<t align='center' color='#FFFFFF'>%6</t><br/>
		<img align='left' size='2.0' image='BRP_imagens\interface\seta_esquerda.paa'/>
		<img align='right' size='2.0' image='BRP_imagens\interface\seta_direita.paa'/><br/><br/>
		<t align='left' color='#FFFFFF'>DECISAO:</t><br/>
		<t align='left' color='#FF3333'>Tecla [ENTER]:</t><t align='right' color='#FFFFFF'>concluir</t><br/>
		<t align='left' color='#FF3333'>Tecla [DEL]:</t><t align='right' color='#FFFFFF'>cancelar</t><br/>
		<t align='left' color='#FFFFFF'>ROTACAO: %2</t><br/>
		<t align='left' color='#FF3333'>Tecla C:</t><t align='right' color='#FFFFFF'>rodar +</t><br/>
		<t align='left' color='#FF3333'>Tecla Z:</t><t align='right' color='#FFFFFF'>rodar -</t><br/>
		<t align='left' color='#FF3333'>Tecla X:</t><t align='right' color='#FFFFFF'>intensidade</t><br/>
		<t align='left' color='#FFFFFF'>POSICAO VERTICAL: %4 cm</t><br/>
		<t align='left' color='#FF3333'>Tecla R:</t><t align='right' color='#FFFFFF'>subir objeto</t><br/>
		<t align='left' color='#FF3333'>Tecla F:</t><t align='right' color='#FFFFFF'>descer objeto</t><br/>
		<t align='left' color='#FF3333'>Tecla V:</t><t align='right' color='#FFFFFF'>intensidade</t><br/>
		<t align='left' color='#FFFFFF'>ALINHAMENTO:</t><br/>
		<t align='left' color='#FF3333'>Tecla T:</t><t align='right' color='#FFFFFF'>vertical</t><br/>
		<t align='left' color='#FF3333'>Tecla G:</t><t align='right' color='#FFFFFF'>terreno</t><br/>
		<t align='left' color='#FFFFFF'>OUTROS COMANDOS:</t><br/>
		<t align='left' color='#FF3333'>Barra de Espaco:</t><t align='right' color='#FFFFFF'>pegar/soltar</t><br/>
		<t align='left' color='#FF3333'>Tecla Y:</t><t align='right' color='#FFFFFF'>referencia Z em %5</t>",
		if (BRPVP_buildingClassWithImg find BRPVP_construindoItemObjClass == -1) then {
			if (BRPVP_construindoItemRetira != -1) then {BRPVP_specialItemsImages select BRPVP_construindoItemRetira} else {"BRP_imagens\items\BRP_kitAdmin.paa"};
		} else {
			BRPVP_buildingClassWithImgPath select (BRPVP_buildingClassWithImg find BRPVP_construindoItemObjClass)
		},
		BRPVP_construindoAngRotacao,
		8,
		BRPVP_construindoHInt * 100,
		if (BRPVP_buildingLevelTerrain) then {"terrain"} else {"player"},
		BRPVP_buildingItemName
	]
};
BRPVP_buildingsHeightFixClass = [];
BRPVP_buildingsHeightFixValue = [];
BRPVP_consSpawnItem = {
	private ["_h"];
	_objAntigo = BRPVP_construindoItemObj;
	_objeto = if (BRPVP_construindoItemZero != "") then {BRPVP_construindoItemZero} else {BRPVP_construindoItem};
	_idx = BRPVP_buildingsHeightFixClass find _objeto;
	if (_idx == -1) then {
		_temp = createVehicle [_objeto,[0,0,0],[],0,"CAN_COLLIDE"];
		_h = ((getPosWorld _temp) select 2) - ((getPosASL _temp) select 2);
		deleteVehicle _temp;
		BRPVP_buildingsHeightFixClass pushBack _objeto;
		BRPVP_buildingsHeightFixValue pushBack _h;
	} else {
		_h = BRPVP_buildingsHeightFixValue select _idx;
	};
	
	//CREATE AS NORMAL LOCAL OBJECT
	_BRPVP_construindoItemObj = _objeto createVehicleLocal [0,0,0];
	if (_objeto in BRP_kitFuelStorage) then {
		clearWeaponCargoGlobal _BRPVP_construindoItemObj;
		clearMagazineCargoGlobal _BRPVP_construindoItemObj;
		clearItemCargoGlobal _BRPVP_construindoItemObj;
		clearBackpackCargoGlobal _BRPVP_construindoItemObj;
	};
	//_BRPVP_construindoItemObj setMass [0,0];
	_state = if (_objeto in BRPVP_buildingHaveDoorListReverseDoor) then {0} else {1};
	if (_BRPVP_construindoItemObj call BRPVP_isBuilding) then {
		{
			if (_BRPVP_construindoItemObj animationPhase _x != _state) then {
				_BRPVP_construindoItemObj animate [_x,_state];
			};
		} forEach animationNames _BRPVP_construindoItemObj;
	};

	BRPVP_construindoItemObjClass = _objeto;
	_h = _h - BRPVP_buildingsHeightFixLast;
	BRPVP_buildingsHeightFixLast = _h + BRPVP_buildingsHeightFixLast;
	if (isText (configFile >> "CfgVehicles" >> (typeOf _BRPVP_construindoItemObj) >> "displayname")) then {
		BRPVP_buildingItemName = getText (configFile >> "CfgVehicles" >> (typeOf _BRPVP_construindoItemObj) >> "displayname");
	} else {
		BRPVP_buildingItemName = "";
	};
	_bb = boundingBoxReal _BRPVP_construindoItemObj;
	_bbXMax = abs ((_bb select 0 select 0) - (_bb select 1 select 0));
	_bbYMax = abs ((_bb select 0 select 1) - (_bb select 1 select 1));
	_bbMax = _bbXMax max _bbYMax;
	_yOff = (_bbMax/2) * 1.5 + 5;
	BRPVP_buildingItemObjBB = [_bbXMax * 0.4,_bbYMax * 0.4];
	BRPVP_construindoFrente = _yOff;
	_yOffDelta = _yOff - BRPVP_buildingDistSafe;
	BRPVP_buildingDistSafe = _yOff;
	if (isNull _objAntigo) then {
		BRPVP_construindoAngRotacaoSet = getDir player;
		BRPVP_construindoDirPlyObj = getDir player;
		BRPVP_construindoPega = [_yOffDelta,getDir player];
	} else {
		_BRPVP_construindoItemObj setVectorDirAndUp [vectorDir _objAntigo,vectorUp _objAntigo];
		_BRPVP_construindoItemObj setPosWorld getPosWorld _objAntigo;
		_objAntigo removeAllEventHandlers "HandleDamage";
		/*
		if (typeOf _objAntigo in BRP_kitAutoTurret) then {
			{deleteVehicle _x;} forEach crew _objAntigo;
		};
		*/
		deleteVehicle _objAntigo;
		if (BRPVP_construindoPega select 0 >= 0) then {
			BRPVP_construindoPega set [0,(BRPVP_construindoPega select 0) + _yOffDelta];
		};
	};
	BRPVP_construindoHIntSet = BRPVP_construindoHIntSet + _h;
	BRPVP_construindoItemObj = _BRPVP_construindoItemObj;
	player setVariable ["obui",BRPVP_construindoItemObj,true];
	BRPVP_construindoItemObj addEventHandler ["HandleDamage",{
		_source = _this select 3;
		if (_source isKindOf "Man") then {
			call BRPVP_cancelaConstrucao;
		};
		0
	}];
	if (BRPVP_construindoItemObjClass in BRP_kitLamp) then {
		BRPVP_construindoItemObj switchLight "OFF";
	};
	call BRPVP_atualizaDebugMenu;
};
BRPVP_construir = {
	private ["_flagOk"];
	_obj = _this select 0 select 0;
	_isFlag = _obj isKindOf ["FlagCarrier",configFile >> "CfgVehicles"];
	_flagOk = false;
	_extra = 0;
	_mult = 1 - BRPVP_flagsAreasIntersectionAllowed;
	{
		if (_x call BRPVP_checaAcesso || _isFlag) then {
			if (_obj in BRP_kitFlags25) then {_extra = 25;};
			if (_obj in BRP_kitFlags50) then {_extra = 50;};
			if (_obj in BRP_kitFlags100) then {_extra = 100;};
			if (_obj in BRP_kitFlags200) then {_extra = 200;};
			_extra = _extra * _mult;
			if (!_isFlag) then {_mult = 1;};
			_typeOf = typeOf _x;
			if (_typeOf in BRP_kitFlags25 && player distance _x <= 25*_mult + _extra) exitWith {_flagOk = true;};
			if (_typeOf in BRP_kitFlags50 && player distance _x <= 50*_mult + _extra) exitWith {_flagOk = true;};
			if (_typeOf in BRP_kitFlags100 && player distance _x <= 100*_mult + _extra) exitWith {_flagOk = true;};
			if (_typeOf in BRP_kitFlags200 && player distance _x <= 200*_mult + _extra) exitWith {_flagOk = true;};
		};
	} forEach nearestObjects [player,["FlagCarrier"],200,true];
	if (_isFlag) then {_flagOk =! _flagOk;};
	if !(_flagOk || BRPVP_vePlayers || (BRPVP_allowBuildingsAwayFromFlags && !_isFlag)) exitWith {
		if (_isFlag) then {[localize "str_cons_cant_flag_2x",4,12,854,"erro"] call BRPVP_hint;} else {[localize "str_cons_cant_flag",4,12,854,"erro"] call BRPVP_hint;};
	};
	if (player getVariable ["cmb",false] && !BRPVP_vePlayers) exitWith {[localize "str_cons_cant_combat",4,12,854,"erro"] call BRPVP_hint;};
	if (BRPVP_intoTheCity) exitWith {[localize "str_cons_cant_city",4,12,854,"erro"] call BRPVP_hint;};

	_objPos = ASLToAGL getPosASL player;
	_objInSafe = ({_objPos distance (_x select 0) < (_x select 1)} count BRPVP_safeZonesOtherMethod) > 0;
	_objInSafeArround = ({_objPos distance (_x select 0) < BRPVP_noBuildDistInSafeZones} count BRPVP_safeZonesOtherMethod) > 0;
	if (_objInSafe && !BRPVP_vePlayers) exitWith {[localize "str_cons_cant_safez",4,12,854,"erro"] call BRPVP_hint;};
	if (_objInSafeArround && !BRPVP_vePlayers) exitWith {[format[localize "str_cons_cant_safez_arround",BRPVP_noBuildDistInSafeZones],4,12,854,"erro"] call BRPVP_hint;};

	_objs = player nearObjects 100;
	_objs = _objs apply {if (_x getVariable ["id_bd",-1] != -1 && _x call BRPVP_isBuilding) then {_x} else {objNull}};
	_objs = _objs - [objNull];
	_friend = {_x call BRPVP_checaAcesso} count _objs;
	_notFriend = count _objs - _friend;
	_friendArea = (if (_notFriend == 0) then {1} else {_friend/(_friend + _notFriend)}) >= BRPVP_friendBuildingsPercentageToBuild;
	if (!_friendArea) exitWith {[localize "str_cons_cant_unfriend",4,12,854,"erro"] call BRPVP_hint;};
	(findDisplay 602) closeDisplay 1;
	BRPVP_buildingsHeightFixLast = 0;
	BRPVP_buildingDistSafe = 0;
	BRPVP_construindoHIntSet = 0;
	BRPVP_construindoPega = [-1];
	BRPVP_construindoVecUp = [0,0,1];
	BRPVP_construindoItemObj = objNull;
	BRPVP_construindoFrente = 10;
	BRPVP_construindoItens = _this select 0;
	BRPVP_construindoItemZero = _this select 1;
	BRPVP_construindoItemRetira = _this select 2;
	BRPVP_construindoAngRotacao = BRPVP_construindoAngsRotacao select BRPVP_construindoAngRotacaoIdc;
	BRPVP_construindoAngRotacaoSet = 0;
	BRPVP_construindoItemIdc = 0;
	BRPVP_construindoItem = BRPVP_construindoItens select BRPVP_construindoItemIdc;
	BRPVP_construindo = true;
	player setVariable ["bdg",true,true];
	call BRPVP_atualizaDebugMenu;
	call BRPVP_consSpawnItem;
	[] spawn {
		waitUntil {
			if (!isNull BRPVP_construindoItemObj) then {
				if (BRPVP_construindoPega select 0 >= 0) then {
					_dist = BRPVP_construindoPega select 0;
					_refP = BRPVP_construindoPega select 1;
					_dP = getDir player;
					_refDeltaP = _dP - _refP;
					BRPVP_construindoPega set [1,_dP];
					BRPVP_construindoDirPlyObj = BRPVP_construindoDirPlyObj + _refDeltaP;
					BRPVP_construindoAngRotacaoSet = BRPVP_construindoAngRotacaoSet + _refDeltaP;
					_cP = getPosWorld player;
					if (BRPVP_buildingLevelTerrain) then {
						_cP set [2,0];
						_cP = _cP vectorAdd [_dist * sin BRPVP_construindoDirPlyObj,_dist * cos BRPVP_construindoDirPlyObj,BRPVP_construindoHIntSet];
						BRPVP_construindoItemObj setPosWorld AGLToASL _cP;
					} else {
						_cP = _cP vectorAdd [_dist * sin BRPVP_construindoDirPlyObj,_dist * cos BRPVP_construindoDirPlyObj,BRPVP_construindoHIntSet];
						BRPVP_construindoItemObj setPosWorld _cP;
					};
					BRPVP_construindoItemObj setDir BRPVP_construindoAngRotacaoSet;
				} else {
					if (BRPVP_construindoHIntSet != 0) then {
						BRPVP_construindoItemObj setPosWorld ((getPosWorld BRPVP_construindoItemObj) vectorAdd [0,0,BRPVP_construindoHIntSet]);
						BRPVP_construindoHIntSet = 0;
					};
					BRPVP_construindoItemObj setDir BRPVP_construindoAngRotacaoSet;
				};
				if (BRPVP_construindoAlinTerr) then {
					BRPVP_construindoItemObj call BRPVP_lindoAlinhaTerreno;
				};
			};
			!BRPVP_construindo || !alive player || (player getVariable ["cmb",false] && !BRPVP_vePlayers) || !isNull (player getVariable ["brpvp_surrendedBy",objNull]) || BRPVP_intoTheCity
		};
		if (BRPVP_construindo) then {
			call BRPVP_cancelaConstrucao;
		};
		if (player getVariable ["cmb",false]) then {
			[localize "str_cons_cant_combat",4,12,854] call BRPVP_hint;
		} else {
			if (BRPVP_intoTheCity) then {
				[localize "str_cons_cant_city",4,12,854,"erro"] call BRPVP_hint;
			};
		};
	};
};

diag_log "[BRPVP FILE] construcao.sqf END REACHED";