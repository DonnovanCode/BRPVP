diag_log "[BRPVP FILE] sistema_menus.sqf STARTING";

//FUNCOES DAS OPCOES DE MENU
BRPVP_menuSleep = 0;
BRPVP_menuIdc = -1;
BRPVP_menuIdcSafe = 30;
BRPVP_menuCustomKeysOff = false;
BRPVP_updateFlagProtection = {
	params ["_objects","_unit","_id_bd"];
	{
		if (_x isKindOf "FlagCarrier") then {
			_flag = _x;
			if (!BRPVP_interactiveBuildingsGodMode) then {
				if (BRPVP_flagBuildingsGodMode) then {
					_dist = _flag call BRPVP_getFlagRadius;
					{
						_building = _x;
						if (_building getVariable ["own",-1] isEqualTo _id_bd) then {
							if (alive _building) then {
								_nearFlags = nearestObjects [_building,BRP_kitFlags25,25,true];
								_nearFlags append nearestObjects [_building,BRP_kitFlags50,50,true];
								_nearFlags append nearestObjects [_building,BRP_kitFlags100,100,true];
								_nearFlags append nearestObjects [_building,BRP_kitFlags200,200,true];
								_allowDamage = ({[_building,_x] call BRPVP_checaAcessoRemotoFlag} count _nearFlags) == 0;
								if (local _building) then {
									_building allowDamage _allowDamage;
								} else {
									[_building,_allowDamage] remoteExec ["allowDamage",_building,false];
								};
								_building setVariable ["brpvp_flag_protected",!_allowDamage,true];
							};
						};
					} forEach nearestObjects [_flag,["Building"],_dist,true];
				};
			};
			if (BRPVP_flagVehiclesGodModeWhenEmpty) then {
				_dist = _flag call BRPVP_getFlagRadius;
				{
					if (_x getVariable ["own",-1] isEqualTo _id_bd) then {
						if !(_x isKindOf "StaticWeapon") then {
							[_x,false,objNull] call BRPVP_setFlagProtectionOnVehicle;
						};
					};
				} forEach nearestObjects [_flag,["LandVehicle","Air","Ship"],_dist,true];
			};
		};
	} forEach _objects;
	[{call BRPVP_findMyFlags;["mastuff"] call BRPVP_atualizaIcones;}] remoteExec ["call",_unit,false];
};
BRPVP_spectateFnc = {
	if (!isNull _this && isPlayer _this && !(player getVariable ["cmb",false]) && alive player) then {
		BRPVP_menuExtraLigado = false;
		call BRPVP_atualizaDebug;
		BRPVP_spectateOn = true;
		BRPVP_spectedPlayer = _this;
		_this spawn {
			private ["_found","_vehCamTarget"];
			playSound "granted";
			showCinemaBorder false;
			_cam = "camera" camCreate [0,0,0];
			_veh = vehicle _this;
			_inVeh = _veh != _this;
			if (_inVeh) then {
				_bb = boundingBox _veh;
				_bbY = abs((_bb select 0 select 1) - (_bb select 1 select 1))/2;
				_bbZ = abs((_bb select 0 select 2) - (_bb select 1 select 2))/2;
				_offSet = [0,-_bbY,_bbZ];
				_vehCamTarget = [0,_bbY,0];
				_cam attachTo [_veh,_offSet];
			} else {
				_cam attachTo [_this,BRPVP_spectateHeadOffset,"head"];
			};
			_cam cameraEffect ["INTERNAL","BACK"];
			[localize "str_spec_to_leave",8,16,299] call BRPVP_hint;
			_originalEffect = cameraView;
			while {BRPVP_spectateOn && !isNull _this && isPlayer _this && alive player && !(player getVariable ["cmb",false]) && (_this call BRPVP_checaAcesso || BRPVP_trataseDeAdmin)} do {
				_veh = vehicle _this;
				_inVehNew = _veh != _this;
				if (!_inVeh && _inVehNew) then {
					_bb = boundingBox _veh;
					_bbY = abs((_bb select 0 select 1) - (_bb select 1 select 1))/2;
					_bbZ = abs((_bb select 0 select 2) - (_bb select 1 select 2))/2;
					_offSet = [0,-_bbY,_bbZ];
					_vehCamTarget = [0,_bbY,0];
					_cam attachTo [_veh,_offSet];
				} else {
					if (_inVeh && !_inVehNew) then {
						_cam attachTo [_this,BRPVP_spectateHeadOffset,"head"];
					};
				};
				if (_inVehNew) then {
					_cam camSetTarget (_veh modelToWorld _vehCamTarget);
				} else {
					_cam camSetTarget ASLToAGL ((AGLToASL positionCameraToWorld [0,0,0]) vectorAdd ((getCameraViewDirection _this) vectorMultiply 100));
				};
				_cam camSetFov (0.7/(_this getVariable "fov"));
				_cam camCommit 0.1;
				waitUntil {camCommitted _cam};
				_inVeh = _inVehNew;
			};
			if (isNull _this) then {
				[localize "str_spec_left",5,10,299] call BRPVP_hint;
			} else {
				if !(_this call BRPVP_checaAcesso) then {
					[localize "str_spec_exposition_end",5,10,299] call BRPVP_hint;
				} else {
					[localize "str_spec_left",5,10,299] call BRPVP_hint;
				};
			};
			_cam cameraEffect ["TERMINATE","BACK"];
			camDestroy _cam;
			player switchCamera _originalEffect;
			BRPVP_spectateOn = false;
			BRPVP_spectedPlayer = objNull;
		};
	} else {
		playSound "erro";
		BRPVP_menuExtraLigado = false;
		call BRPVP_atualizaDebug;
		if (player getVariable ["cmb",false]) then {
			[localize "str_spec_cant_cmb",5,10,299] call BRPVP_hint;
		};
	};
};
BRPVP_actualExposition = {
	_stp = _this getVariable ["stp",-1];
	_return = "erro";
	if (_stp == 1) then {
		_return = localize "str_expo_wit";
	} else {
		if (_stp == 2) then {
			_return = localize "str_expo_witr";
		} else {
			if (_stp == 3) then {
				_return = localize "str_expo_everyone";
			} else {
				if (_stp == 4) then {
					_return = localize "str_expo_om";
				};
			};
		};
	};
	_return
};
BRPVP_deixarDeConfiar = {
	params ["_id_bd","_name"];
	_meusAmigosId = player getVariable "amg";
	_meusAmigosId = _meusAmigosId - [_id_bd];
	BRPVP_amigosAtualizaServidor = [player getVariable "id_bd",_meusAmigosId];
	if (isServer) then {["",BRPVP_amigosAtualizaServidor] call BRPVP_amigosAtualizaServidorFnc;} else {publicVariableServer "BRPVP_amigosAtualizaServidor";};
	[format [localize "str_trust_you_revoke",_name],5,15] call BRPVP_hint;
	_playerAvisar = objNull;
	{
		if ((_x getVariable ["id_bd",-1]) isEqualTo _id_bd) exitWith {_playerAvisar = _x;};
	} forEach allPlayers;
	player setVariable ["amg",_meusAmigosId,true];
	BRPVP_mudouConfiancaEmVoceSV = [_playerAvisar,player,false,_meusAmigosId];
	if (isServer) then {["",BRPVP_mudouConfiancaEmVoceSV] call BRPVP_mudouConfiancaEmVoceSVFnc;} else {publicVariableServer "BRPVP_mudouConfiancaEmVoceSV";};
	call BRPVP_daUpdateNosAmigos;
	call BRPVP_atualizaMeuStuffAmg;
	BRPVP_tempoUltimaAtuAmigos = time;
	0 spawn BRPVP_menuMuda;
};
BRPVP_confiarEmAlguem = {
	params ["_id_bd","_name","_unit"];
	_meusAmigosId = player getVariable "amg";
	_meusAmigosId pushBack _id_bd;
	BRPVP_amigosAtualizaServidor = [player getVariable "id_bd",_meusAmigosId];
	if (isServer) then {["",BRPVP_amigosAtualizaServidor] call BRPVP_amigosAtualizaServidorFnc;} else {publicVariableServer "BRPVP_amigosAtualizaServidor";};
	[format [localize "str_trust_you_trust",_name],3.5,15] call BRPVP_hint;
	player setVariable ["amg",_meusAmigosId,true];
	BRPVP_mudouConfiancaEmVoceSV = [_unit,player,true,_meusAmigosId];
	if (isServer) then {["",BRPVP_mudouConfiancaEmVoceSV] call BRPVP_mudouConfiancaEmVoceSVFnc;} else {publicVariableServer "BRPVP_mudouConfiancaEmVoceSV";};
	call BRPVP_daUpdateNosAmigos;
	call BRPVP_atualizaMeuStuffAmg;
	BRPVP_tempoUltimaAtuAmigos = time;
	0 spawn BRPVP_menuMuda;
};
BRPVP_deixarDeConfiarCustom = {
	_playerChange = objNull;
	{if ((_x getVariable ["id_bd",-1]) isEqualTo _this) exitWith {_playerChange = _x;};} forEach allPlayers;
	_amg = BRPVP_stuff getVariable "amg";
	_amg set [1,(_amg select 1) - [_this]];
	BRPVP_stuff setVariable ["amg",_amg,true];
	if !(BRPVP_stuff getVariable ["slv_amg",false]) then {BRPVP_stuff setVariable ["slv_amg",true,true];};
	[[BRPVP_stuff],_playerChange,_this] call BRPVP_updateFlagProtection;
	58 spawn BRPVP_menuMuda;
};
BRPVP_confiarEmAlguemCustom = {
	params ["_unit","_id_bd"];
	_amg = BRPVP_stuff getVariable "amg";
	(_amg select 1) pushBackUnique _id_bd;
	BRPVP_stuff setVariable ["amg",_amg,true];
	if !(BRPVP_stuff getVariable ["slv_amg",false]) then {BRPVP_stuff setVariable ["slv_amg",true,true];};
	[[BRPVP_stuff],_unit,_id_bd] call BRPVP_updateFlagProtection;
	58 spawn BRPVP_menuMuda;
};

// FUNCOES DO SISTEMA DE MENU
BRPVP_criaImagemTag = {
	_typeOf = typeOf _this;
	if (isText (configFile >> "CfgVehicles" >> _typeOf >> "picture") && _this call BRPVP_IsMotorized) then {
		(" image='" + getText (configFile >> "CfgVehicles" >> _typeOf >> "picture") + "'")
	} else {
		" image='BRP_marcas\muro.paa'"
	};
};
BRPVP_arrayParaListaHtml = {
	params ["_arr","_sel","_cor"];
	_itensAcAb = 3;
	_idcFinal = (count _arr) - 1;
	_ini = 0;
	_fim = _idcFinal;
	if (count _arr > _itensAcAb * 2 + 1) then {
		_ajF = 0;
		if (_sel < _itensAcAb) then {_ajF = _itensAcAb - _sel;};
		_ajI = 0;
		if (_sel + _itensAcAb > _idcFinal) then {_ajI = (_sel + _itensAcAb) - _idcFinal;};
		_ini = ((_sel - _itensAcAb) max 0) - _ajI;
		_fim = ((_sel + _itensAcAb) min _idcFinal) + _ajF;
	};
	_txt = "";
	for "_u" from _ini to _fim do {
		_preFix = "<t size='1.15'>";
		_suFix = "</t><br/>";
		if (_u == _sel) then {_preFix = "<t size='1.15' color='" + _cor + "'>";};
		_txtAdd = " " + (_arr select _u) + " ";
		_find = -1;
		while {
			_find = _txtAdd find "&";
			_find != -1
		} do {
			_txtAdd = (_txtAdd select [0,_find]) + "+" + (_txtAdd select [_find + 1,(count _txtAdd) - (_find + 1)]);
		};
		_txt = _txt + _preFix + (_txtAdd select [1,(count _txtAdd) - 2]) + _suFix
	};
	_txt
};
BRPVP_pegaListaPlayersNear = {
	BRPVP_menuOpcoes = [];
	BRPVP_menuExecutaParam = [];
	{
		if (alive _x && _x getVariable ["sok",false]) then {
			_id_bd = _x getVariable ["id_bd",-1];
			if (_id_bd >= 0) then {
				if (_x distance player <= _this) then {
					BRPVP_menuOpcoes pushBack (str _id_bd + " - " + name _x);
					BRPVP_menuExecutaParam pushBack _x;
				};
			};
		};
	} forEach (allPlayers - [player]);
};
BRPVP_pegaListaPlayers = {
	BRPVP_menuOpcoes = [];
	BRPVP_menuExecutaParam = [];
	{
		if (alive _x && _x getVariable ["sok",false]) then {
			_id_bd = _x getVariable ["id_bd",-1];
			if (_id_bd >= 0) then {
				BRPVP_menuOpcoes pushBack (str _id_bd + " - " + name _x);
				BRPVP_menuExecutaParam pushBack _x;
			};
		};
	} forEach (allPlayers - [player]);
};
BRPVP_pegaListaPlayersAll = {
	BRPVP_menuOpcoes = [];
	BRPVP_menuExecutaParam = [];
	{
		if (_x getVariable ["sok",false]) then {
			_id_bd = _x getVariable ["id_bd",-1];
			if (_id_bd >= 0) then {
				BRPVP_menuOpcoes pushBack (str _id_bd + " - " + name _x);
				BRPVP_menuExecutaParam pushBack _x;
			};
		};
	} forEach (allPlayers - [player]);
};
BRPVP_menuMuda = {
	BRPVP_menuCustomKeysOff = true;
	_inicio = time;
	_menuIdcAntigo = if (_this != BRPVP_menuIdc) then {BRPVP_menuIdc} else {BRPVP_menuIdcSafe};
	BRPVP_menuIdc = _this;
	BRPVP_menuForceExit = {false};
	call (BRPVP_menu select _this);
	if (count BRPVP_menuOpcoes == 0) exitWith {
		playSound "erro";
		[localize "str_nothing_to_show",0] call BRPVP_hint;
		_menuIdcAntigo spawn BRPVP_menuMuda;
	};
	_mPos = BRPVP_menuPos select BRPVP_menuIdc;
	if (_mPos < (count BRPVP_menuOpcoes) - 1) then {
		BRPVP_menuOpcoesSel = _mPos;
	} else {
		BRPVP_menuOpcoesSel = (count BRPVP_menuOpcoes) - 1;
	};
	//BRPVP_menuExtraLigado = true;
	call BRPVP_atualizaDebugMenu;
	_passou = time - _inicio;
	if (_passou < BRPVP_menuSleep) then {sleep (BRPVP_menuSleep - _passou);};
	BRPVP_menuCustomKeysOff = false;
};
BRPVP_extraMenuCanBeCloseForced = false;
BRPVP_iniciaMenuExtra = {
	private ["_id","_canForcePrevious","_newCanBeForced"];
	if (typeName _this == "SCALAR") then {
		_id = _this;
		_canForcePrevious = BRPVP_extraMenuCanBeCloseForced;
		_newCanBeForced = false;
	};
	if (typeName _this == "ARRAY") then {
		_id = (_this select 0);
		_canForcePrevious = BRPVP_extraMenuCanBeCloseForced;
		_newCanBeForced = (_this select 1);
	};
	if ((!BRPVP_menuExtraLigado && !BRPVP_construindo && !BRPVP_spectateOn) || (_canForcePrevious && !BRPVP_construindo && !BRPVP_spectateOn)) then {
		if (isNull BRPVP_spectingUnit) then {
			BRPVP_menuExtraLigado = true;
			BRPVP_extraMenuCanBeCloseForced = _newCanBeForced;
			["<img align='center' size='5' image='BRP_imagens\interface\status_bar\zombie_icon.paa'/><br/><t align='center'>"+localize "str_menu_on_right"+"</t>",0,0,3,0,0,9959] spawn BIS_fnc_dynamicText;
			_id spawn BRPVP_menuMuda;
			playSound "achou_loot";
			[] spawn {
				_priority = 410;
				_handle = -1;
				while {_handle == -1} do {
					_handle = ppEffectCreate ["DynamicBlur",_priority];
					_priority = _priority + 1;
				};
				_handle ppEffectEnable true;
				_handle ppEffectAdjust [2.25];
				_handle ppEffectCommit 0;
				waitUntil {!BRPVP_menuExtraLigado};
				["",0,0,1,0,0,9959] spawn BIS_fnc_dynamicText;
				_handle ppEffectEnable false;
				ppEffectDestroy _handle;
			};		
			true
		} else {
			[localize "str_spec_must_leave",0] call BRPVP_hint;
			playSound "erro";
			false
		};
	} else {
		if (BRPVP_spectateOn) then {
			[localize "str_spec_must_leave",0] call BRPVP_hint;
			playSound "erro";
		} else {
			[localize "str_menu_must_close",0] call BRPVP_hint;
			playSound "erro";
		};
		false
	};
};
BRPVP_menuHtml = {
	_html = call (BRPVP_menuCabecalhoHtml select BRPVP_menuIdc);
	_html = _html + ([BRPVP_menuOpcoes,BRPVP_menuOpcoesSel,BRPVP_menuCorSelecao] call BRPVP_arrayParaListaHtml);
	if (BRPVP_menuTipoImagem == 1) then {_html = _html + "<br/>" + BRPVP_menuImagem;};
	if (BRPVP_menuTipoImagem == 2) then {_html = _html + "<br/>" + (BRPVP_menuImagem select BRPVP_menuOpcoesSel);};
	if (BRPVP_menuTipoImagem == 3) then {call BRPVP_menuImagem;};
	_html = _html + (call (BRPVP_menuRodapeHtml select BRPVP_menuIdc));
	_html
};

//CABECALHO DO MENU
BRPVP_menuCabecalhoHtml = [
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu00_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu01_tittle"+"</t><br/><br/><t size='1.15' align='center' color='#FFFFFF'>"+localize "str_menu01_subtittle0"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu02_tittle"+"</t><br/><br/><t size='1.15' align='center' color='#FFFFFF'>"+localize "str_menu02_subtittle0"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu03_tittle"+"</t><br/><br/><t size='1.15' align='center' color='#FFFFFF'>"+localize "str_menu03_subtittle0"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu04_tittle"+"</t><br/><br/><t size='1.15' align='center' color='#FFFFFF'>"+localize "str_menu04_subtittle0"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu05_tittle"+"</t><br/><br/><t size='1.15' align='center' color='#FFFFFF'>"+localize "str_menu05_subtittle0"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu06_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu07_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu08_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu00_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu00_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu00_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu12_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu00_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+(BRPVP_menuVar1 call BRPVP_identifyShopType)+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+(BRPVP_menuVar1 call BRPVP_identifyShopType)+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+(BRPVP_menuVar1 call BRPVP_identifyShopType)+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu17_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu18_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu19_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu20_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu21_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu22_tittle"+"</t><br/><img size='3.0' align='center'" + (BRPVP_stuff call BRPVP_criaImagemTag) + "/><br/><t align='center' size='1.3' color='#FFFFFF'>" + getText (configFile >> "CfgVehicles" >> (typeOf BRPVP_stuff) >> "displayName") + "</t><br/><t align='center' size='1.3' color='#CCCCCC'> "+format [localize "str_menu22_subtittle0",round ((1 - (damage BRPVP_stuff)) * 100)]+"</t><br/><br/><t align='center' size='1.3' color='#FFFFFF'>"+localize "str_menu22_subtittle1"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu23_tittle"+"</t><br/><img size='3.0' align='center'" + (BRPVP_stuff call BRPVP_criaImagemTag) + "/><br/><t align='center' size='1.3' color='#FFFFFF'>" + getText (configFile >> "CfgVehicles" >> (typeOf BRPVP_stuff) >> "displayName") + "</t><br/><br/><t align='center' size='1.3' color='#66CC66'>"+localize "str_menu23_subtittle0"+" </t><t align='center' size='1.3' color='#77FF77'>" + (BRPVP_stuff call BRPVP_compEstado) + "</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu24_tittle"+"</t><br/><img size='3.0' align='center'" + (BRPVP_stuff call BRPVP_criaImagemTag) + "/><br/><t align='center' size='1.3' color='#FFFFFF'>" + getText (configFile >> "CfgVehicles" >> (typeOf BRPVP_stuff) >> "displayName") + "</t><br/><br/><t align='center' size='1.3' color='#66CC66'>"+localize "str_menu24_subtittle0"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu25_tittle"+"</t><br/><img size='3.0' align='center'" + (BRPVP_stuff call BRPVP_criaImagemTag) + "/><br/><t align='center' size='1.3' color='#FFFFFF'>" + getText (configFile >> "CfgVehicles" >> (typeOf BRPVP_stuff) >> "displayName") + "</t><br/><br/><t align='center' size='1.3' color='#66CC66'>"+localize "str_menu25_subtittle0"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu26_tittle"+"</t><br/><img size='3.0' align='center'" + (BRPVP_stuff call BRPVP_criaImagemTag) + "/><br/><t align='center' size='1.3' color='#FFFFFF'>" + getText (configFile >> "CfgVehicles" >> (typeOf BRPVP_stuff) >> "displayName") + "</t><br/><br/><t align='center' size='1.3' color='#66CC66'>"+localize "str_menu25_subtittle0"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>INSIDE OR REALLY NEAR</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>INSIDE OR IN LESS THAN 10 M</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu29_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu30_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu31_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu32_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+format[localize "str_menu33_tittle",BRPVP_menuVar1 getVariable ["nm","no_name"]]+"</t><br/><t align='center' size='1.3' color='#FFFFFF'>"+localize "str_menu33_subtittle0"+"</t>"+(if (BRPVP_giveNoRemove) then {"<br/><t size='1.0' color='"+(if (BRPVP_transferType == "mny") then {"#FF6666"} else {"#FFFFFF"})+"'>"+localize "str_debug0_4"+" "+((BRPVP_menuVar1 getVariable ["mny",0]) call BRPVP_formatNumber)+" $</t><br/><t size='1.0' color='"+(if (BRPVP_transferType == "brpvp_mny_bank") then {"#FF6666"} else {"#FFFFFF"})+"'>"+localize "str_debug0_4_2"+" "+((BRPVP_menuVar1 getVariable ["brpvp_mny_bank",0]) call BRPVP_formatNumber)+"</t>"} else {""})+"<br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+format [localize "str_menu34_tittle",BRPVP_menuVar2 call BRPVP_formatNumber,name BRPVP_menuVar1]+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu35_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu36_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu37_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu38_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu39_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu40_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu41_tittle"+"</t><br/><t align='center' size='1.15' color='#FF0000'>"+localize "str_menu41_subtittle0"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu42_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu43_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu44_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu45_tittle"+"</t><br/><br/><t align='center' size='1.3' color='#66CC66'>"+localize "str_menu45_subtittle0"+" </t><t align='center' size='1.3' color='#77FF77'>" + (player call BRPVP_actualExposition) + "</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu46_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu47_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu48_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu49_tittle"+"</t><br/>"+localize "str_menu49_subtittle0"+"<br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu50_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu51_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu52_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu53_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu54_tittle"+"</t><br/><t align='center' size='1.2' color='#66dd66'>"+localize "str_atm_hand"+" "+((player getVariable ["mny",0]) call BRPVP_formatNumber)+" $</t><br/><t align='center' size='1.2' color='#66dd66'>"+localize "str_atm_bank"+" "+((player getVariable ["brpvp_mny_bank",0]) call BRPVP_formatNumber)+" $</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu55_tittle"+"</t><br/><t align='center' size='1.2' color='#66dd66'>"+localize "str_atm_hand"+" "+((player getVariable ["mny",0]) call BRPVP_formatNumber)+" $</t><br/><t align='center' size='1.2' color='#66dd66'>"+localize "str_atm_bank"+" "+((player getVariable ["brpvp_mny_bank",0]) call BRPVP_formatNumber)+" $</t><br/><t align='center' size='1.2' color='#eeee00'>" + (BRPVP_atmAmount call BRPVP_formatNumber) + " $</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu56_tittle"+"</t><br/><t align='center' size='1.2' color='#66dd66'>"+localize "str_atm_hand"+" "+((player getVariable ["mny",0]) call BRPVP_formatNumber)+" $</t><br/><t align='center' size='1.2' color='#66dd66'>"+localize "str_atm_bank"+" "+((player getVariable ["brpvp_mny_bank",0]) call BRPVP_formatNumber)+" $</t><br/><t align='center' size='1.2' color='#eeee00'>" + (BRPVP_atmAmount call BRPVP_formatNumber) + " $</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+BRPVP_confirmTittle+"</t><br/><t align='center' size='1.2' color='#66dd66'>"+localize "str_atm_hand"+" "+((player getVariable ["mny",0]) call BRPVP_formatNumber)+" $</t><br/><t align='center' size='1.2' color='#66dd66'>"+localize "str_atm_bank"+" "+((player getVariable ["brpvp_mny_bank",0]) call BRPVP_formatNumber)+" $</t><br/><t align='center' size='1.2' color='#eeee00'>" + (BRPVP_atmAmount call BRPVP_formatNumber) + " $</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+format[localize "str_menu58_tittle",getText (configFile >> "CfgVehicles" >> (typeOf BRPVP_stuff) >> "displayName")]+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+format[localize "str_menu59_tittle",getText (configFile >> "CfgVehicles" >> (typeOf BRPVP_stuff) >> "displayName")]+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+format[localize "str_menu60_tittle",getText (configFile >> "CfgVehicles" >> (typeOf BRPVP_stuff) >> "displayName")]+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+format[localize "str_menu61_tittle",getText (configFile >> "CfgVehicles" >> (typeOf BRPVP_stuff) >> "displayName")]+"</t><br/><br/>"}
];

//CORPO DO MENU
BRPVP_menu = [
	//MENU 0
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuDestino = [1,2,3,4,5];
		BRPVP_menuCodigo = {};
		BRPVP_menuVoltar = {30 spawn BRPVP_menuMuda;};
		BRPVP_menuOpcoes = [
			localize "str_menu00_opt0",
			localize "str_menu00_opt1",
			localize "str_menu00_opt2",
			localize "str_menu00_opt3",
			localize "str_menu00_opt4"
		];
	},
	
	//MENU 1
	{
		BRPVP_menuTipo = 1;
		BRPVP_menuCorSelecao = "#AAAAAA";
		_amgPlayer = player getVariable "amg";
		BRPVP_pegaNomePeloIdBd1 = [_amgPlayer,player,false];
		BRPVP_pegaNomePeloIdBd1Retorno = nil;
		if (isServer) then {["",BRPVP_pegaNomePeloIdBd1] call BRPVP_pegaNomePeloIdBd1Fnc;} else {publicVariableServer "BRPVP_pegaNomePeloIdBd1";};
		waitUntil {!isNil "BRPVP_pegaNomePeloIdBd1Retorno"};
		BRPVP_menuOpcoes = BRPVP_pegaNomePeloIdBd1Retorno;
		BRPVP_menuVoltar = {0 spawn BRPVP_menuMuda;};
	},
	
	//MENU 2
	{
		BRPVP_menuTipo = 1;
		BRPVP_menuCorSelecao = "#AAAAAA";
		BRPVP_pegaNomePeloIdBd2 = [player getVariable ["id_bd",-1],player];
		BRPVP_pegaNomePeloIdBd2Retorno = nil;
		if (isServer) then {["",BRPVP_pegaNomePeloIdBd2] call BRPVP_pegaNomePeloIdBd2Fnc;} else {publicVariableServer "BRPVP_pegaNomePeloIdBd2";};
		waitUntil {!isNil "BRPVP_pegaNomePeloIdBd2Retorno"};
		BRPVP_menuOpcoes = BRPVP_pegaNomePeloIdBd2Retorno;
		BRPVP_menuVoltar = {0 spawn BRPVP_menuMuda;};
	},
	
	//MENU 3
	{
		BRPVP_menuTipo = 1;
		BRPVP_menuCorSelecao = "#AAAAAA";
		_amgPlayer = player getVariable "amg";
		BRPVP_pegaNomePeloIdBd3 = [_amgPlayer,player getVariable "id_bd",player];
		BRPVP_pegaNomePeloIdBd3Retorno = nil;
		if (isServer) then {["",BRPVP_pegaNomePeloIdBd3] call BRPVP_pegaNomePeloIdBd3Fnc;} else {publicVariableServer "BRPVP_pegaNomePeloIdBd3";};
		waitUntil {!isNil "BRPVP_pegaNomePeloIdBd3Retorno"};
		BRPVP_menuOpcoes = BRPVP_pegaNomePeloIdBd3Retorno;
		BRPVP_menuVoltar = {0 spawn BRPVP_menuMuda;};
	},
	
	//MENU 4
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		_amgPlayer = player getVariable "amg";
		{
			_id_bd = _x getVariable ["id_bd",-1];
			if (_id_bd >= 0) then {
				if !(_id_bd in _amgPlayer) then {
					BRPVP_menuOpcoes pushBack (_x getVariable "nm");
					BRPVP_menuExecutaParam pushBack [_id_bd,_x getVariable "nm",_x];
				};
			};
		} forEach (allPlayers - [player]);
		BRPVP_menuExecutaFuncao = BRPVP_confiarEmAlguem;
		BRPVP_menuVoltar = {0 spawn BRPVP_menuMuda;};
	},
	
	//MENU 5
	{
		BRPVP_menuTipo = 2;
		_amgPlayer = player getVariable "amg";
		BRPVP_pegaNomePeloIdBd1 = [_amgPlayer,player,true];
		BRPVP_pegaNomePeloIdBd1Retorno = nil;
		if (isServer) then {["",BRPVP_pegaNomePeloIdBd1] call BRPVP_pegaNomePeloIdBd1Fnc;} else {publicVariableServer "BRPVP_pegaNomePeloIdBd1";};
		waitUntil {!isNil "BRPVP_pegaNomePeloIdBd1Retorno"};
		BRPVP_menuOpcoes = BRPVP_pegaNomePeloIdBd1Retorno select 0;
		BRPVP_menuExecutaParam = [];
		{BRPVP_menuExecutaParam pushBack [BRPVP_pegaNomePeloIdBd1Retorno select 1 select _forEachIndex,_x];} forEach BRPVP_menuOpcoes;
		BRPVP_menuExecutaFuncao = BRPVP_deixarDeConfiar;
		BRPVP_menuVoltar = {0 spawn BRPVP_menuMuda;};
	},
	
	//MENU 6
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 1;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		_experiencia = player getVariable ["exp",BRPVP_experienciaZerada];
		BRPVP_menuImagem = [];
		{BRPVP_menuImagem append ["<img size='3.0' align='center' image='BRP_imagens\interface\experiencia.paa'/><t size='2.5' align='center'>" + str _x + " </t>"];} forEach _experiencia;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuOpcoes = BRPVP_expLegenda;
		BRPVP_menuVoltar = {30 spawn BRPVP_menuMuda;};
	},
	
	//MENU 7
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuDestino = 8;
		BRPVP_menuCodigo = {
			BRPVP_menuVar1 = BRPVP_menuOpcoes select BRPVP_menuOpcoesSel;
			BRPVP_menuVar2 = BRPVP_menuOpcoesSel;
		};
		BRPVP_menuVoltar = {30 spawn BRPVP_menuMuda;};
		BRPVP_menuOpcoes = BRPVP_expLegenda;
	},
	
	//MENU 8
	{
		BRPVP_menuTipo = 1;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<t size='2.0' color='#FFFF33' align='center'>" + BRPVP_menuVar1 + "</t><br/><img size='2.0' align='center' image='BRP_imagens\interface\top_10.paa'/>";
		BRPVP_menuCorSelecao = "#AAAAAA";
		BRPVP_pegaTop10Estatistica = [BRPVP_menuVar2,player];
		BRPVP_pegaTop10EstatisticaRetorno = nil;
		if (isServer) then {["",BRPVP_pegaTop10Estatistica] call BRPVP_pegaTop10EstatisticaFnc;} else {publicVariableServer "BRPVP_pegaTop10Estatistica";};
		waitUntil {!isNil "BRPVP_pegaTop10EstatisticaRetorno"};
		BRPVP_menuOpcoes = BRPVP_pegaTop10EstatisticaRetorno;
		BRPVP_menuVoltar = {7 spawn BRPVP_menuMuda;};
	},
	
	//MENU 9
	{
		BRPVP_menuIdcSafe = 9;
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='BRP_imagens\interface\dinheiro.paa'/>";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuDestino = 10;
		BRPVP_menuOpcoes = [];
		BRPVP_menuVal = [];
		{
			BRPVP_menuOpcoes pushBack (BRPVP_mercadoNomes select _x);
			BRPVP_menuVal pushBack _x;
		} forEach BRPVP_merchantItems;
		BRPVP_menuCodigo = {
			BRPVP_mercadorIdc2 = BRPVP_menuVal select BRPVP_menuOpcoesSel;
			BRPVP_menuVar1 = BRPVP_menuOpcoes select BRPVP_menuOpcoesSel;
		};
		BRPVP_menuVoltar = {
			if (count BRPVP_compraItensTotal > 0) then {
				12 spawn BRPVP_menuMuda;
			} else {
				BRPVP_menuExtraLigado = false;
				call BRPVP_atualizaDebug;
			};
		};
		BRPVP_menuPos set [10,0];
		BRPVP_menuPos set [11,0];
		BRPVP_menuPos set [12,0];		
	},
	
	//MENU 10
	{
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		_precoBase = BRPVP_mercadoPrecos select BRPVP_mercadorIdc2;
		BRPVP_menuImagem = "<img size='3.0' align='center' image='BRP_imagens\interface\dinheiro.paa'/>";
		BRPVP_menuDestino = 11;
		BRPVP_menuCodigo = {
			BRPVP_mercadorIdc3 = BRPVP_menuOpcoesSel;
			BRPVP_menuVar2 = BRPVP_menuOpcoes select BRPVP_menuOpcoesSel;
		};
		BRPVP_menuVoltar = {9 spawn BRPVP_menuMuda;};
		BRPVP_menuOpcoes = [];
		{
			if (BRPVP_marketItemFilter in (BRPVP_mercadoNomesNomesFilter select BRPVP_mercadorIdc2 select _forEachIndex)) then {
				BRPVP_menuOpcoes pushBack _x;
			};
		} forEach (BRPVP_mercadoNomesNomes select BRPVP_mercadorIdc2);
	},
	
	//MENU 11
	{
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuOpcoes = [];
		BRPVP_menuImagem = [];
		BRPVP_menuVal = [];
		_txt = "<t size='1.3' color='#FFFF33' align='center'>Price: $ %1</t><br/><img size='3' align='center' image='%2'/>";
		{
			if (_x select 0 == BRPVP_mercadorIdc2 && _x select 1 == BRPVP_mercadorIdc3) then {
				private ["_imagem","_nomeBonito"];
				_it = _x select 3;
				_idc = BRPVP_specialItems find _it;
				if (_idc >= 0) then {
					_imagem = BRPVP_specialItemsImages select _idc;
					_nomeBonito = BRPVP_specialItemsNames select _idc;
				} else {
					_imagem = "BRP_imagens\interface\amigo_color.paa";
					_nomeBonito = "ITEM ?";
					_isM = isClass (configFile >> "CfgMagazines" >> _it);
					if (_isM) then {
						_imagem = getText (configFile >> "CfgMagazines" >> _it >> "picture");
						_nomeBonito = getText (configFile >> "CfgMagazines" >> _it >> "displayName");
					} else {
						_isW = isClass (configFile >> "CfgWeapons" >> _it);
						if (_isW) then {
							_imagem = getText (configFile >> "CfgWeapons" >> _it >> "picture");
							_nomeBonito = getText (configFile >> "CfgWeapons" >> _it >> "displayName");
						} else {
							_isV = isClass (configFile >> "CfgVehicles" >> _it);
							if (_isV) then {
								_imagem = getText (configFile >> "CfgVehicles" >> _it >> "picture");
								_nomeBonito = getText (configFile >> "CfgVehicles" >> _it >> "displayName");
							};
						};
					};
				};
				_preco = (BRPVP_mercadoPrecos select BRPVP_mercadorIdc2) * (_x select 4) * BRPVP_itemTraderDiscount;
				BRPVP_menuOpcoes pushBack _nomeBonito;
				BRPVP_menuImagem pushBack format[_txt,(round _preco) call BRPVP_formatNumber,_imagem];
				BRPVP_menuVal pushBack [_it,_preco];
			};
		} forEach BRPVP_mercadoItens;
		BRPVP_menuDestino = 11;
		BRPVP_menuCodigo = {(BRPVP_menuVal select BRPVP_menuOpcoesSel) call BRPVP_comprouItem;};
		BRPVP_menuVoltar = {10 spawn BRPVP_menuMuda;};
	},
	
	//MENU 12
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='BRP_imagens\interface\dinheiro.paa'/>";
		BRPVP_menuOpcoes = [localize "str_menu12_opt0",localize "str_menu12_opt1",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [0,1,2];
		BRPVP_menuExecutaFuncao = {
			if (_this == 0) then {
				31 spawn BRPVP_menuMuda;
			} else {
				BRPVP_menuExtraLigado = false;
				call BRPVP_atualizaDebug;
				if (_this == 1) then {
					call BRPVP_comprouItemFinaliza;
				};
			};
		};
		BRPVP_menuVoltar = {9 spawn BRPVP_menuMuda;};
	},
	
	//MENU 13
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = [];
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuDestino = 14;
		BRPVP_menuOpcoes = [];
		{
			private ["_ladoResumo"];
			_alowed = BRPVP_vendaveAtivos select 0;
			_lado = _x select 0;
			_ladoResumo = _alowed call BRPVP_identifyShopType;
			if (!(_ladoResumo in BRPVP_menuOpcoes) && _lado in _alowed) then {
				BRPVP_menuOpcoes pushBack _ladoResumo;
				BRPVP_menuImagem pushBack ("<img size='3' align='center' image='BRP_imagens\interface\vehtrader.paa'/>");
			};
		} forEach BRPVP_tudoA3;
		BRPVP_menuCodigo = {
			BRPVP_menuVar1 = BRPVP_vendaveAtivos select 0;
			BRPVP_menuVar4 = BRPVP_menuImagem select BRPVP_menuOpcoesSel;
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			call BRPVP_atualizaDebug;
		};
	},

	//MENU 14
	{
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = BRPVP_menuVar4;
		BRPVP_menuDestino = 15;
		BRPVP_menuOpcoes = [];
		{
			_lado = _x select 0;
			_fac = _x select 1;
			if (!(_fac in BRPVP_menuOpcoes) && _lado in BRPVP_menuVar1) then {
				BRPVP_menuOpcoes append [_fac];
			};
		} forEach BRPVP_tudoA3;
		BRPVP_menuCodigo = {BRPVP_menuVar2 = BRPVP_menuOpcoes select BRPVP_menuOpcoesSel;};
		BRPVP_menuVoltar = {13 spawn BRPVP_menuMuda;};
	},
	
	//MENU 15
	{
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = BRPVP_menuVar4;
		BRPVP_menuDestino = 16;
		BRPVP_menuOpcoes = [];
		{
			_lado = _x select 0;
			_fac = _x select 1;
			_tipo = _x select 2;
			if (!(_tipo in BRPVP_menuOpcoes) && _lado in BRPVP_menuVar1 && _fac == BRPVP_menuVar2) then {
				BRPVP_menuOpcoes append [_tipo];
			};
		} forEach BRPVP_tudoA3;
		BRPVP_menuCodigo = {BRPVP_menuVar3 = BRPVP_menuOpcoes select BRPVP_menuOpcoesSel;};
		BRPVP_menuVoltar = {14 spawn BRPVP_menuMuda;};
	},
	
	//MENU 16
	{
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = [];
		BRPVP_menuDestino = -1;
		BRPVP_menuOpcoes = [];
		BRPVP_menuVal = [];
		{
			_x params ["_lado","_fac","_tipo","_classe","_descr","_preco"];
			if (_lado in BRPVP_menuVar1 && _fac == BRPVP_menuVar2 && _tipo == BRPVP_menuVar3) then {
				BRPVP_menuOpcoes pushBack _descr;
				_preco = _preco * BRPVP_marketPricesMultiply;
				BRPVP_menuVal pushBack [_classe,_preco];
				_imagem = (getText (configFile >> "CfgVehicles" >> _classe >> "picture"));
				BRPVP_menuImagem append ["<t size='2.0' color='#FFFF33' align='center'>" + localize "str_price" + " $ " + (_preco call BRPVP_formatNumber) + "</t><br/><img size='3' align='center' image='" + _imagem + "'/>"];
			};
		} forEach BRPVP_tudoA3;
		BRPVP_menuCodigo = {
			_mult = BRPVP_vendaveAtivos select 1;
			_preco = (BRPVP_menuVal select BRPVP_menuOpcoesSel select 1) * _mult;
			_posS = getPosATL player;
			if (player call BRPVP_qjsValorDoPlayer >= _preco) then {
				[_posS,_mult,_preco,BRPVP_menuOpcoesSel] spawn {
					params ["_posS","_mult","_preco","_BRPVP_menuOpcoesSel"];
					private ["_allNearX"];
					_deployType = BRPVP_vendaveAtivos select 2;
					_elevatorSound = BRPVP_vendaveAtivos select 3;
					_xObj = objNull;
					_xObjObjsToRemove = [];
					if (_deployType == "x_on_ground") then {
						_allNearX = nearestObjects [_posS,["Land_JumpTarget_F"],100];
						_pointsArround = [];
						{
							for "_a" from 0 to 360 step (_x select 1) do {
								_pointsArround pushBack ([[0,0,0],_x select 0,_a] call BIS_fnc_relPos);
							};
						} forEach [[0,360],[1.5,120],[3,60],[4.5,30],[6,30]];
						{
							_xToTest = _x;
							_xToTestIndex = _forEachIndex;
							_xToTestAGL = ASLToAGL getPosASL _x;
							_xOk = true;
							{
								_objToTest = _x;
								{
									if ([_xToTestAGL vectorAdd _x,_objToTest] call PDTH_pointIsInBox) exitWith {
										_xOk = false;
										if (_xToTestIndex == 0) then {_xObjObjsToRemove pushBack _objToTest;};
									};
								} forEach _pointsArround;
								if (_xToTestIndex > 0 && !_xOk) exitWith {};
							} forEach (nearestObjects [_xToTest,["LandVehicle","Air","Ship"],50]);
							if (_xOk) exitWith {_xObj = _xToTest;};
						} forEach _allNearX;
					};
					if (_mult > 0 && _deployType == "default" && _elevatorSound) then {
						[nearestObject [player,"Land_PhoneBooth_01_F"],"elevador",400] call BRPVP_playSoundAllCli;
						sleep 10;
					};
					_leave = false;
					if (_deployType == "x_on_ground" && isNull _xObj) then {
						_removed = 0;
						_notRemoved = 0;
						_waitTime = 0;						
						{
							_limit = _x getVariable ["brpvp_parkLimit",0];
							if (serverTime > _limit) then {
								_x spawn {
									[_this,[0,0,40]] remoteExec ["setVelocity",_this,false];
									sleep 3.5;
									_this setDamage 1;
									sleep 2;
									deleteVehicle _this;
								};
								_removed = _removed + 1;
							} else {
								_waitTime = _waitTime max (_limit - serverTime);
								_notRemoved = _notRemoved + 1;
							};
						} forEach _xObjObjsToRemove;
						if (_notRemoved == 0) then {
							_xObj = _allNearX select 0;
							sleep 2;
						} else {
							_leave = true;
							playSound "erro";
							[format [localize "str_deploypad_cant",_removed,_notRemoved,round _waitTime],-10] call BRPVP_hint;
						};
					};
					if (_leave) exitWith {};
					_money = player getVariable ["mny",0];
					if (_money < _preco) exitWith {
						playSound "erro";
						[localize "str_no_money",0] call BRPVP_hint;
					};
					player setVariable ["mny",(player getVariable ["mny",0]) - _preco,true];
					playSound "negocio";
					playSound "ugranted";
					_veiculo = BRPVP_menuVal select _BRPVP_menuOpcoesSel select 0;
					if (_deployType in ["default","x_on_ground"]) then {
						private ["_posOk"];
						_raio = (sizeOf _veiculo)/2;
						_minRad = if (_mult > 0) then {20} else {2};
						if (_deployType == "default") then {
							_posOk = [_posS,[0,0,0],_minRad,0,250,0,_raio*0.25,_raio*0.25,_raio,true,5,25,["CAManBase","Building","Air","LandVehicle"],["a3\plants_f\Tree\","a3\rocks_f\"],0,false] call BRPVP_achaLocal;
						} else {
							_posOk = ASLToAGL getPosASL _xObj;
						};
						_plac = if (str _posOk == "[0,0,0]") then {"NONE"} else {"CAN_COLLIDE"};
						_placRad = if (str _posOk == "[0,0,0]") then {15} else {0};
						_vObj = createVehicle [_veiculo,_posOk,[],_placRad,_plac];
						if (_deployType == "x_on_ground") then {
							_vObj setVariable ["brpvp_parkLimit",serverTime + 180,true];
						};
						clearWeaponCargoGlobal _vObj;
						clearMagazineCargoGlobal _vObj;
						clearItemCargoGlobal _vObj;
						clearBackpackCargoGlobal _vObj;
						if (_veiculo in ["B_APC_Wheeled_01_cannon_F","O_APC_Wheeled_02_rcws_F","I_APC_Wheeled_03_cannon_F"]) then {
							_vObj animate ["HideTurret",1];
						};
						_vObj allowDamage false;
						_vObj setVariable ["own",player getVariable "id_bd",true];
						_vObj setVariable ["stp",player getVariable "dstp",true];
						_vObj setVariable ["amg",[player getVariable "amg",[]],true];
						BRPVP_myStuff pushBack _vObj;
						["mastuff"] call BRPVP_atualizaIcones;
						_vObj setVelocity [0,0,2];
						sleep 3;
						_estadoCons = [
							[[[],[]],[],[[],[]],[[],[]]],
							[getPosWorld _vObj,[vectorDir _vObj,vectorUp _vObj]],
							typeOf _vObj,
							_vObj getVariable "own",
							_vObj getVariable "stp",
							_vObj getVariable "amg",
							""
						];
						BRPVP_adicionaConstrucaoBd = [false,_vObj,_estadoCons];
						if (isServer) then {["",BRPVP_adicionaConstrucaoBd] call BRPVP_adicionaConstrucaoBdFnc;} else {publicVariableServer "BRPVP_adicionaConstrucaoBd";};
						sleep 10;
						[_vObj,true] remoteExec ["allowDamage",_vObj,false];
					};
					if (_deployType == "fedidex") then {
						_fedidexPos = AGLToASL ([player,5 + random 10,random 360] call BIS_fnc_relPos);
						_fedidexPos set [2,(_fedidexPos select 2) + 1000];
						playSound "fedidex_start";
						["<img size='4' image='BRP_imagens\interface\delivery.paa'/>",0,0,3,0,0,7757] spawn BIS_fnc_dynamicText;
						_fedidexBox = createVehicle ["Box_NATO_AmmoVeh_F",_fedidexPos,[],0,"NONE"];
						_fedidexBox setVelocity [0,0,-10];
						_initFedidex = time;
						_delta = 0;
						waitUntil {(position _fedidexBox) select 2 < vectorMagnitude velocity _fedidexBox};
						waitUntil {
							_hAGLS = (position _fedidexBox) select 2;
							_hWLD = (getPosWorld _fedidexBox) select 2;
							_hWLD < _hWLD - _hAGLS + 5
						};
						[_fedidexBox,"delivered",400] call BRPVP_playSoundAllCli;
						sleep 3;
						_spawnPos = ASLtoAGL getPosASL _fedidexBox;
						deleteVehicle _fedidexBox;
						_fedidexVeh = createVehicle [_veiculo,_spawnPos vectorAdd [0,0,1],[],0,"CAN_COLLIDE"];
						_fedidexVeh setVectorUp [0,0,1];
						_fedidexVeh allowDamage false;
						_fedidexVeh setVariable ["brpvp_fedidex",true,true];
						BRPVP_addVehicleMPKilled = _fedidexVeh;
						if (isServer) then {["",BRPVP_addVehicleMPKilled] call BRPVP_addVehicleMPKilledFnc;} else {publicVariableServer "BRPVP_addVehicleMPKilled";};
						clearWeaponCargoGlobal _fedidexVeh;
						clearMagazineCargoGlobal _fedidexVeh;
						clearItemCargoGlobal _fedidexVeh;
						clearBackpackCargoGlobal _fedidexVeh;
						if (_veiculo in ["B_APC_Wheeled_01_cannon_F","O_APC_Wheeled_02_rcws_F","I_APC_Wheeled_03_cannon_F"]) then {
							_fedidexVeh animate ["HideTurret",1];
						};
						playSound "fedidex";
						sleep 3;
						[format [localize "str_fedidex_time",round (time - _initFedidex)]] call BRPVP_hint;
						sleep 7;
						[_fedidexVeh,true] remoteExec ["allowDamage",_fedidexVeh,false];
					};
				};
			} else {
				[localize "str_no_money",0] call BRPVP_hint;
				playSound "erro";
			};
			BRPVP_menuExtraLigado = false;
			call BRPVP_atualizaDebug;
		};
		BRPVP_menuVoltar = {15 spawn BRPVP_menuMuda;};
	},

	//MENU 17
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuDestino = [18,19,20,21,43,32,32];
		BRPVP_menuCodigo = {
			if (BRPVP_menuOpcoesSel == 5) then {
				BRPVP_giveMoneyEndMenu = 17;
				BRPVP_transferType = "mny";
				BRPVP_negativeValues = true;
				BRPVP_giveNoRemove = true;
				BRPVP_maxDistanceToGiveHandMoneyTemp = 1000000;
			} else {
				if (BRPVP_menuOpcoesSel == 6) then {
					BRPVP_giveMoneyEndMenu = 17;
					BRPVP_transferType = "brpvp_mny_bank";
					BRPVP_negativeValues = true;
					BRPVP_giveNoRemove = true;
					BRPVP_maxDistanceToGiveHandMoneyTemp = 1000000;
				} else {
					BRPVP_menuVoltar = {17 spawn BRPVP_menuMuda;};
				};
			};
		};
		BRPVP_menuVoltar = {29 spawn BRPVP_menuMuda;};
		BRPVP_menuOpcoes = [
			localize "str_menu17_opt0",
			localize "str_menu17_opt1",
			localize "str_menu17_opt2",
			localize "str_menu17_opt3",
			localize "str_menu17_opt4",
			localize "str_menu17_opt5",
			localize "str_menu17_opt6"
		];
	},

	//MENU 18
	{
		BRPVP_menuTipo = 2;
		call BRPVP_pegaListaPlayers;
		BRPVP_menuExecutaFuncao = {
			if (!isNull _this && {alive _this}) then {
				_pass = false;
				_vip = false;
				_dvr = false;
				_ishigh = false;
				_pv = vehicle _this;
				_BRPVP_setPos = {
					params ["_unit"];
					_unit allowDamage false;
					if (vehicle _unit != _unit) then {
						moveOut _unit;
						sleep 0.5;
					};
					_av = vehicle player;
					if (_av != player) then {
						BRPVP_moveInServer = [];
						if (_av emptyPositions "Cargo" > 0) then {
							BRPVP_moveInServer = [_unit,_av,"Cargo"];
						} else {
							if (_av emptyPositions "Gunner" > 0) then {
								BRPVP_moveInServer = [_unit,_av,"Gunner"];
							} else {
								if (_av emptyPositions "Commander" > 0) then {
									BRPVP_moveInServer = [_unit,_av,"Commander"];
								} else {
									if (_av emptyPositions "Driver" > 0) then {
										BRPVP_moveInServer = [_unit,_av,"Driver"];
									} else {
										if (getposATL _av select 2 < 2 && speed _av < 2) then {
											_unit setVehiclePosition [ASLToAGL getPosASL player,[],5,"NONE"];
											[format [localize "str_tele_moved",_unit getVariable "nm"],5,7.5] call BRPVP_hint;
										} else {
											[localize "str_tele_no_position",5,7.5] call BRPVP_hint;
										};
									};
								};
							};
						};
						if (count BRPVP_moveInServer > 0) then {
							if (isServer) then {["",BRPVP_moveInServer] call BRPVP_moveInServerFnc;} else {publicVariableServer "BRPVP_moveInServer";};
							[format [localize "str_tele_moved",_unit getVariable "nm"],5,7.5] call BRPVP_hint;
						};
					} else {
						_unit setVehiclePosition [ASLToAGL getPosASL player,[],2.5,"NONE"];
						[format [localize "str_tele_moved",_this getVariable "nm"],5,7.5] call BRPVP_hint;
					};
					sleep 0.001;
					_unit allowDamage true;
				};
				if (_pv != _this) then {
					_vip = _pv isKindOf "B_Parachute";
					_pass = true;
					if (driver _pv == _this) then {
						_dvr = true;
						if ((getPosATL _pv select 2) > 2) then {
							_ishigh = true;
						};
					};
				};
				if (!_pass) then {
					_this spawn _BRPVP_setPos;
				} else {
					if (!_dvr) then {
						_this spawn _BRPVP_setPos;
					} else {
						if (!_ishigh || {_vip}) then {
							_this spawn _BRPVP_setPos;
						} else {
							[localize "str_tele_cant_driver",0] call BRPVP_hint;
						};
					};
				};
			} else {
				playSound "erro";
			};
			BRPVP_menuExtraLigado = false;
			call BRPVP_atualizaDebug;
		};
	},

	//MENU 19
	{
		BRPVP_menuTipo = 2;
		call BRPVP_pegaListaPlayersAll;
		BRPVP_menuExecutaFuncao = {
			if (!isNull _this && {alive _this}) then {
				BRPVP_multiplicadorDanoAdmin = 0;
				if (vehicle player != player) then {
					moveOut player;
				};
				_pv = vehicle _this;
				if (_pv != _this) then {
					if (_pv emptyPositions "Cargo" > 0) then {
						player moveInCargo _pv;
					} else {
						if (_pv emptyPositions "Gunner" > 0) then {
							player moveInGunner _pv;
						} else {
							if (_pv emptyPositions "Commander" > 0) then {
								player moveInCommander _pv;
							} else {
								if (_pv emptyPositions "Driver" > 0) then {
									player moveInDriver _pv;
								} else {
									if (getposATL _pv select 2 < 2 && speed _pv < 2) then {
										player setVehiclePosition [ASLToAGL getPosASL _this,[],5,"NONE"];
									} else {
										[format [localize "str_tele_no_pos_destine",_this getVariable "nm"],5,7.5] call BRPVP_hint;
										player setVehiclePosition [ASLToAGL getPosASL _this,[],15,"NONE"];
									};
								};
							};
						};
					};
				} else {
					player setVehiclePosition [ASLToAGL getPosASL _this,[],2.5,"NONE"];
				};
				BRPVP_multiplicadorDanoAdmin = 1;
			} else {
				playSound "erro";
			};
			BRPVP_menuExtraLigado = false;
			call BRPVP_atualizaDebug;
		};
	},

	//MENU 20
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuForceExit = {
			_true = !isNil "ACE_Medical";
			if (_true) then {["ACE Medical is on. Can't use this option.",0] call BRPVP_hint;};
			_true
		};
		call BRPVP_pegaListaPlayers;
		BRPVP_menuExecutaFuncao = {
			if (!isNull _this && {alive _this}) then {
				_this setDamage 0;
			} else {
				playSound "erro";
				BRPVP_menuExtraLigado = false;
				call BRPVP_atualizaDebug;
			};
		};
	},

	//MENU 21
	{
		BRPVP_menuTipo = 2;
		call BRPVP_pegaListaPlayers;
		BRPVP_menuExecutaFuncao = {
			if (!isNull _this && {alive _this}) then {
				_this setDamage 1;
			} else {
				playSound "erro";
				BRPVP_menuExtraLigado = false;
				call BRPVP_atualizaDebug;
			};
		};
	},

	//MENU 22
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuCodigo = {};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			call BRPVP_atualizaDebug;
		};
		_sf = if (BRPVP_stuff in BRPVP_myStuff) then {""} else {"adm"};
		if (BRPVP_stuff call BRPVP_IsMotorized) then {
			if (typeOf BRPVP_stuff in BRP_kitAutoTurret) then {
				BRPVP_menuOpcoes = [localize ("str_menu22_opt0"+_sf),localize ("str_menu22_opt4"+_sf),localize ("str_menu22_opt3"+_sf),localize ("str_menu22_opt1"+_sf)];
				BRPVP_menuDestino = [23,58,24,26];
			} else {
				BRPVP_menuOpcoes = [localize ("str_menu22_opt0"+_sf),localize ("str_menu22_opt4"+_sf),localize ("str_menu22_opt3"+_sf),localize ("str_menu22_opt2"+_sf),localize ("str_menu22_opt1"+_sf)];
				BRPVP_menuDestino = [23,58,24,25,26];
			};
		} else {
			if (BRPVP_stuff call BRPVP_isSimpleObject) then {
				BRPVP_menuOpcoes = [localize ("str_menu22_opt3"+_sf),localize ("str_menu22_opt1"+_sf)];
				BRPVP_menuDestino = [24,26];
			} else {
				if (BRPVP_stuff getVariable ["mapa",false]) then {
					BRPVP_menuOpcoes = [localize ("str_menu22_opt0"+_sf),localize ("str_menu22_opt4"+_sf),localize ("str_menu22_opt3"+_sf),localize ("str_menu22_opt2"+_sf)];
					BRPVP_menuDestino = [23,58,24,25];
				} else {
					if (BRPVP_stuff isKindOf "FlagCarrier") then {
						BRPVP_menuOpcoes = [localize ("str_menu22_opt4"+_sf),localize ("str_menu22_opt3"+_sf),localize ("str_menu22_opt1"+_sf)];
						BRPVP_menuDestino = [58,24,26];
					} else {
						BRPVP_menuOpcoes = [localize ("str_menu22_opt0"+_sf),localize ("str_menu22_opt4"+_sf),localize ("str_menu22_opt3"+_sf),localize ("str_menu22_opt1"+_sf)];
						BRPVP_menuDestino = [23,58,24,26];
					};
				};
			};
		};
		playSound "hint";
	},

	//MENU 23
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuOpcoes = [
			localize "str_menu23_opt0",
			localize "str_menu23_opt1",
			localize "str_menu23_opt2",
			localize "str_menu23_opt3",
			localize "str_menu23_opt4"
		];
		BRPVP_menuPos set [BRPVP_menuIdc,BRPVP_stuff getVariable ["stp",0]];
		BRPVP_menuExecutaParam = [0,1,2,3,4];
		BRPVP_menuExecutaFuncao = {
			BRPVP_stuff setVariable ["stp",_this,true];
			playSound "hint";
			if !(BRPVP_stuff getVariable ["slv_amg",false]) then {BRPVP_stuff setVariable ["slv_amg",true,true];};
			call BRPVP_atualizaDebugMenu;
		};
		BRPVP_menuVoltar = {22 spawn BRPVP_menuMuda;};
	},

	//MENU 24
	{
		BRPVP_menuTipo = 2;
		call BRPVP_pegaListaPlayersAll;
		BRPVP_menuExecutaFuncao = {
			if (!isNull _this) then {
				[BRPVP_stuff,_this] call BRPVP_mudaDonoPropriedade;
				playSound "ugranted";
				[format [localize "str_props_give_to",getText (configFile >> "CfgVehicles" >> (typeOf BRPVP_stuff) >> "displayName"),name _this],4,15] call BRPVP_hint;
			} else {
				playSound "erro";
			};
			[{call BRPVP_findMyFlags;["mastuff"] call BRPVP_atualizaIcones;}] remoteExec ["call",_this,false];
			call BRPVP_findMyFlags;
			["mastuff"] call BRPVP_atualizaIcones;
			BRPVP_menuExtraLigado = false;
			call BRPVP_atualizaDebug;
		};
		BRPVP_menuVoltar = {22 spawn BRPVP_menuMuda;};
	},

	//MENU 25
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuOpcoes = [localize "str_confirm",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [true,false];
		BRPVP_menuExecutaFuncao = {
			if (_this) then {
				[BRPVP_stuff,objNull] call BRPVP_mudaDonoPropriedade;
				BRPVP_menuExtraLigado = false;
				call BRPVP_atualizaDebug;
			} else {
				22 spawn BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {22 spawn BRPVP_menuMuda;};
	},
	
	//MENU 26
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuOpcoes = [localize "str_confirm",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [true,false];
		BRPVP_menuExecutaFuncao = {
			if (_this) then {
				if (BRPVP_stuff isKindOf "FlagCarrier") then {
					[BRPVP_construindoItemObj,{BRPVP_allFlags deleteAt (BRPVP_allFlags find _this);}] remoteExec ["call",0,false];
					if (!BRPVP_interactiveBuildingsGodMode) then {
						if (BRPVP_flagBuildingsGodMode) then {
							_dist = BRPVP_stuff call BRPVP_getFlagRadius;
							{
								_building = _x;
								if (_building getVariable ["id_bd",-1] != -1) then {
									if (alive _building) then {
										_nearFlags = nearestObjects [_building,BRP_kitFlags25,25,true];
										_nearFlags append nearestObjects [_building,BRP_kitFlags50,50,true];
										_nearFlags append nearestObjects [_building,BRP_kitFlags100,100,true];
										_nearFlags append nearestObjects [_building,BRP_kitFlags200,200,true];
										_nearFlags = _nearFlags - [BRPVP_stuff];
										_nearFlagsOk = ({[_building,_x] call BRPVP_checaAcessoRemotoFlag} count _nearFlags) > 0;
										if (!_nearFlagsOk) then {
											if (local _building) then {
												_building allowDamage true;
											} else {
												[_building,true] remoteExec ["allowDamage",_building,false];
											};
											_building setVariable ["brpvp_flag_protected",false,true];
										};
									};
								};
							} forEach nearestObjects [BRPVP_stuff,["Building"],_dist,true];
						};
					};
					if (BRPVP_flagVehiclesGodModeWhenEmpty) then {
						{
							if !(_x isKindOf "StaticWeapon") then {
								[_x,true,objNull] call BRPVP_setFlagProtectionOnVehicle;
							};
						} forEach nearestObjects [BRPVP_stuff,["LandVehicle","Air","Ship"],BRPVP_stuff call BRPVP_getFlagRadius,true];
					};
				};
				_tipo = localize "str_menu26_the_construction";
				if (BRPVP_stuff call BRPVP_IsMotorized) then {_tipo = localize "str_menu26_the_vehicle";};
				_pAvisa = [];
				{if ([_x,BRPVP_stuff] call PDTH_distance2BoxQuad < 100) then {_pAvisa pushBack _x;};} forEach allPlayers;
				BRPVP_avisaExplosao = [BRPVP_stuff,_pAvisa];
				if (isServer) then {["",BRPVP_avisaExplosao] call BRPVP_avisaExplosaoFnc;} else {publicVariableServer "BRPVP_avisaExplosao";};
				BRPVP_menuExtraLigado = false;
				call BRPVP_atualizaDebug;
				[BRPVP_stuff,objNull] call BRPVP_mudaDonoPropriedade;
			} else {
				22 spawn BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {22 spawn BRPVP_menuMuda;};
	},

	//MENU 27
	{
		BRPVP_menuTipo = 1;
		BRPVP_menuCorSelecao = "#AAAAAA";
		BRPVP_menuOpcoes = [];
		BRPVP_menuVoltar = {22 spawn BRPVP_menuMuda;};
	},

	//MENU 28
	{
		BRPVP_menuTipo = 1;
		BRPVP_menuCorSelecao = "#AAAAAA";
		BRPVP_menuOpcoes = [];
		BRPVP_menuVoltar = {22 spawn BRPVP_menuMuda;};
	},
	
	//MENU 29
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuOpcoes = [
			format [localize "str_menu29_opt0",if (BRPVP_godMode) then {"X"} else {"   "}],
			format [localize "str_menu29_opt1",if (BRPVP_vePlayers) then {"X"} else {"   "}],
			format [localize "str_menu29_opt2",if (BRPVP_playerIsCaptive) then {"X"} else {"   "}],
			format [localize "str_menu29_opt3",if (BRPVP_terrenosMapaLigadoAdmin) then {"X"} else {"   "}],
			format [localize "str_menu29_opt4",BRPVP_vePlayersTypesTxt select BRPVP_vePlayersTypesIndex],
			localize "str_menu29_opt5",
			localize "str_menu29_opt6",
			localize "str_menu29_opt7",
			localize "str_menu29_opt8",
			localize "str_menu29_opt9",
			localize "str_menu29_opt10",
			localize "str_menu29_opt11",
			localize "str_menu29_opt12",
			localize "str_menu29_opt13",
			localize "str_menu29_opt14",
			localize "str_menu29_opt15",
			localize "str_menu29_opt16",
			localize "str_menu29_opt17",
			format [localize "str_menu29_opt18",if (BRPVP_monitoreGroups) then {"X"} else {"   "}],
			localize "str_menu29_opt19",
			localize "str_menu29_opt20",
			localize "str_menu29_opt21"
		];
		BRPVP_menuExecutaParam = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21];
		BRPVP_menuExecutaFuncao = {
			if (_this == 0) then {
				if (isNil "ACE_Medical") then {
					if (BRPVP_godMode) then {
						BRPVP_multiplicadorDanoAdmin = 1;
						[localize "str_godmode_off",0] call BRPVP_hint;
						BRPVP_godMode = false;
						player setVariable ["god",((player getVariable "god") - 1) max 0,true];
					} else {
						BRPVP_multiplicadorDanoAdmin = 0;
						[localize "str_godmode_on",0] call BRPVP_hint;
						BRPVP_godMode = true;
						player setVariable ["god",(player getVariable "god") + 1,true];
						_curar = [player];
						_veic = vehicle player;
						if (_veic != player) then {_curar pushBack _veic;};
						{_x setDamage 0;} forEach _curar;
						_wpn = currentWeapon player;
						_amm = player ammo _wpn;
						if (_amm == 0) then {player setAmmo [_wpn,1];};
					};
					29 spawn BRPVP_menuMuda;
				} else {
					["Can't use God Mode with ACE Medical.",0] call BRPVP_hint;
				};
			};
			if (_this == 1) then {
				if (!BRPVP_vePlayers) then {
					BRPVP_vePlayers = true;
					[localize "str_allsee_on",0] call BRPVP_hint;
					[] spawn {
						BRPVP_onlyOwnedHousesAskFor = player;
						BRPVP_onlyOwnedHousesServerReturn = nil;
						if (isServer) then {["",BRPVP_onlyOwnedHousesAskFor] call BRPVP_onlyOwnedHousesAskForFnc;} else {publicVariableServer "BRPVP_onlyOwnedHousesAskFor";};
						waitUntil {!isNil "BRPVP_onlyOwnedHousesServerReturn"};
						BRPVP_ownedHousesExtra = BRPVP_onlyOwnedHousesServerReturn;
					};
				} else {
					BRPVP_vePlayers = false;
					[localize "str_allsee_off",0] call BRPVP_hint;
					BRPVP_ownedHousesExtra = [];
				};
				BRPVP_mapDrawPrecisao = -10;
				call BRPVP_daUpdateNosAmigos;
				["mastuff"] call BRPVP_atualizaIcones;
				29 spawn BRPVP_menuMuda;
			};
			if (_this == 2) then {
				if (!BRPVP_playerIsCaptive) then {
					BRPVP_playerIsCaptive = true;
					player setCaptive true;
				} else {
					BRPVP_playerIsCaptive = false;
					player setCaptive false;
					{
						if (!isPlayer _x) then {
							_x reveal [player,1.5];
						};
					} forEach (player nearEntities ["CAManBase",300]);
				};
				29 spawn BRPVP_menuMuda;
			};
			if (_this == 3) then {
				if (!BRPVP_terrenosMapaLigadoAdmin) then {
					if (!BRPVP_terrenosMapaLigado) then {
						BRPVP_terrenosMapaLigadoAdmin = true;
						[localize "str_terr_draw",0] call BRPVP_hint;
						cutText [localize "str_terr_get_info","PLAIN"];
						_addTIcons = {
							{
								_idc = _forEachIndex;
								_pos = _x select 0;
								_tam = _x select 1;
								_prc = _x select 4;
								_cor = "ColorRed";
								if (_prc >= 3 && _prc <= 4) then {_cor = "ColorYellow";};
								if (_prc >= 6 && _prc <= 9) then {_cor = "ColorGreen";};
								_marca = createMarkerLocal ["TERR_" + str _idc,_pos];
								_marca setMarkerShapeLocal "RECTANGLE";
								_marca setMarkerBrushLocal "SOLID";
								_marca setMarkerColorLocal _cor;
								_marca setMarkerSizeLocal [(_tam/2)*0.925,(_tam/2)*0.925];
								BRPVP_onMapSingleClickExtra = BRPVP_infoTerreno;
							} forEach BRPVP_terrenos;
						};
						["ADD TERRAIN ICONS",_addTIcons,false] call BRPVP_execFast;
						[] spawn {
							waitUntil {!BRPVP_terrenosMapaLigadoAdmin};
							[localize "str_terr_removed",0] call BRPVP_hint;
							_removeTIcons = {{_idc = _forEachIndex;deleteMarkerLocal ("TERR_" + str _idc);} forEach BRPVP_terrenos;};
							["REMOVE TERRAIN ICONS",_removeTIcons,false] call BRPVP_execFast;
							BRPVP_onMapSingleClickExtra = {};
							//if (BRPVP_trataseDeAdmin) then {BRPVP_onMapSingleClick = BRPVP_adminMapaClique;} else {BRPVP_onMapSingleClick = BRPVP_padMapaClique;};
						};
					} else {
						[localize "str_terr_default_to_off",6,20] call BRPVP_hint;
					};
				} else {
					BRPVP_terrenosMapaLigadoAdmin = false;
					cutText ["","PLAIN"];
				};
				29 spawn BRPVP_menuMuda;
			};
			if (_this == 4) then {
				BRPVP_vePlayersTypesIndex = (BRPVP_vePlayersTypesIndex + 1) mod count BRPVP_vePlayersTypesTxt;
				BRPVP_vePlayersTypesCodeNow = BRPVP_vePlayersTypesCode select BRPVP_vePlayersTypesIndex;
				29 spawn BRPVP_menuMuda;
			};
			if (_this == 5) then {
				BRPVP_menuExtraLigado = false;
				BRPVP_itemTraderDiscount = 1;
				[0,0,0,[player,0,0]] execVm "client_code\actions\actionTrader.sqf";
			};
			if (_this == 6) then {
				BRPVP_menuExtraLigado = false;
				_sides = ["CIVIL","MILITAR","CIV-MIL","AIRPORT","ADMIN"];
				[0,0,0,[player,_sides,0]] execVm "client_code\actions\actionVehicleTrader.sqf";
			};
			if (_this == 7) then {
				17 spawn BRPVP_menuMuda;
			};
			if (_this == 8) then {
				36 spawn BRPVP_menuMuda;
			};
			if (_this == 9) then {
				38 spawn BRPVP_menuMuda;
			};
			if (_this == 10) then {
				39 spawn BRPVP_menuMuda;
			};
			if (_this == 11) then {
				if (getTerrainGrid < 50) then {
					BRPVP_setTerrainGridServer = 50;
					[localize "str_grass_off",0,5,2334] call BRPVP_hint;
				} else {
					BRPVP_setTerrainGridServer = BRPVP_terrainGrid;
					[localize "str_grass_on",0,5,2334] call BRPVP_hint;
				};
				if (isServer) then {["",BRPVP_setTerrainGridServer] call BRPVP_setTerrainGridServerFnc;} else {publicVariableServer "BRPVP_setTerrainGridServer";};
			};
			if (_this == 12) then {
				BRPVP_bravoRun = player;
				if (isServer) then {["",BRPVP_bravoRun] call BRPVP_bravoRunFnc;} else {publicVariableServer "BRPVP_bravoRun";};
			};
			if (_this == 13) then {
				BRPVP_siegeRun = player;
				if (isServer) then {["",BRPVP_siegeRun] call BRPVP_siegeRunFnc;} else {publicVariableServer "BRPVP_siegeRun";};
			};
			if (_this == 14) then {
				BRPVP_convoyRun = player;
				if (isServer) then {["",BRPVP_convoyRun] call BRPVP_convoyRunFnc;} else {publicVariableServer "BRPVP_convoyRun";};
			};
			if (_this == 15) then {
				BRPVP_runCorruptMissSpawn = player;
				if (isServer) then {["",BRPVP_runCorruptMissSpawn] call BRPVP_runCorruptMissSpawnFnc;} else {publicVariableServer "BRPVP_runCorruptMissSpawn";};
			};
			if (_this == 16) then {
				_msg = "Overcast: " + str ((round(overcast*1000))/1000) + " / Overcast Forecast: " + str ((round(overcastForecast*1000))/1000) + "\nFog: " + str ((round(fog*1000))/1000) + " / Fog Forecast: " + str ((round(fogForecast*1000))/1000);
				[_msg,10,1] call BRPVP_hint;
			};
			if (_this == 17) then {
				47 spawn BRPVP_menuMuda;
			};
			if (_this == 18) then {
				if (BRPVP_monitoreGroups) then {
					BRPVP_monitoreGroups = false;
				} else {
					BRPVP_monitoreGroups = true;
					[] spawn {
						while {BRPVP_monitoreGroups} do {
							_sides = [];
							_sidesCount = [];
							_civSideZeroCount = 0;
							{
								_sideStr = str side _x;
								_sides pushBackUnique _sideStr;
								_idx = _sides find _sideStr;
								if (count _sidesCount >= _idx + 1) then {
									_sidesCount set [_idx,(_sidesCount select _idx) + 1];
								} else {
									_sidesCount set [_idx,1];
								};
								if (side _x == CIVILIAN) then {
									_unitsCount = count units _x;
									if (_unitsCount == 0) then {
										_civSideZeroCount = _civSideZeroCount + 1;
									};
								};
							} forEach allGroups;
							systemChat (str _sides + " | " + str _sidesCount + " | " + localize "str_menu29_opt18_txt" + " " + str _civSideZeroCount);
							sleep 1;
						};
					};
				};
				29 spawn BRPVP_menuMuda;
			};
			if (_this == 19) then {
				50 spawn BRPVP_menuMuda;
			};
			if (_this == 20) then {
				if (isObjectHidden player) then {
					[player,false] remoteExec ["hideObject",0,true];
					[localize "str_player_is_visible"] call BRPVP_hint;
				} else {
					[player,true] remoteExec ["hideObject",0,true];
					[localize "str_player_is_invisible"] call BRPVP_hint;
				};
			};
			if (_this == 21) then {
				[player,100000] call BRPVP_qjsAdicClassObjeto;
				playSound "negocio";
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			call BRPVP_atualizaDebug;
		};
	},
	
	//MENU 30
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuOpcoes = [
			localize "str_menu30_opt0",
			format [localize "str_menu30_opt1",BRPVP_indiceDebugTxt],
			format [localize "str_menu30_opt2",if (BRPVP_vaultLigada) then {"X"} else {"   "}],
			format [localize "str_menu30_opt3",if (BRPVP_earPlugs) then {"X"} else {"   "}],
			format [localize "str_menu30_opt4",if (BRPVP_terrenosMapaLigado) then {"X"} else {"   "}],
			format [localize "str_menu30_opt5_2",BRPVP_viewDist],
			//format [localize "str_menu30_opt5",if (BRPVP_rastroBalasLigado) then {"X"} else {"   "}],
			format [localize "str_menu30_opt6",if (!BRPVP_completeUpdate) then {"X"} else {"   "}],
			localize "str_menu30_opt7",
			format [localize "str_menu30_opt8",BRPVP_suicidouTrava],
			localize "str_menu30_opt9",
			localize "str_menu30_opt10",
			localize "str_menu30_opt11",
			localize "str_menu30_opt12",
			localize "str_menu30_opt13",
			localize "str_menu30_opt14",
			localize "str_menu30_opt15",
			localize "str_menu30_opt16",
			localize "str_menu30_opt17",
			localize "str_menu30_opt18",
			localize "str_menu30_opt19",
			localize "str_menu30_opt20",
			localize "str_menu30_opt21",
			localize "str_menu30_opt22",
			localize "str_menu30_opt23"
		];
		BRPVP_menuExecutaParam = [22,0,1,2,3,24/*,4*/,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,23];
		
		//REMOVE NOT POSSIBLE OPTIONS DUE TO LANGUAGE (NOT TRANSLATED TUTORIAL) OR OTHER THINGS
		_remove = [];
		if (!BRPVP_showTutorialFlag) then {_remove pushBack 0};
		_remove sort false;
		{
			BRPVP_menuOpcoes deleteAt _x;
			BRPVP_menuExecutaParam deleteAt _x;
		} forEach _remove;
		
		BRPVP_menuExecutaFuncao = {
			if (player getVariable ["sok",false] && alive player) then {
				if (_this == 22) then {
					BRPVP_menuExtraLigado = false;
					call BRPVP_atualizaDebug;
					false spawn BRPVP_showTutorial;
				};
				if (_this == 0) then {
					BRPVP_indiceDebug = (BRPVP_indiceDebug + 1) mod (count BRPVP_indiceDebugItens);
					if (BRPVP_indiceDebug == 0) then {
						BRPVP_indiceDebugTxt = localize "str_debug_type1";
					};
					if (BRPVP_indiceDebug == 1) then {
						BRPVP_indiceDebugTxt = localize "str_debug_type2";
					};
					if (BRPVP_indiceDebug == 2) then {
						BRPVP_indiceDebugTxt = localize "str_debug_type3";
					};
					30 spawn BRPVP_menuMuda;
					[localize "str_scut_ins",0] call BRPVP_hint;
				};
				if (_this == 1) then {
					_tempo = (BRPVP_vaultAcaoTempo - time) max 0;
					if (_tempo > 0) then {
						[format [localize "str_vault_scut_time",(round _tempo) max 1],0] call BRPVP_hint;
					} else {
						if (!BRPVP_vaultLigada) then {
							BRPVP_vaultLigada = true;
							BRPVP_vaultAcaoTempo = time + 10;
							call BRPVP_vaultAbre;
						} else {
							BRPVP_vaultLigada = false;
							BRPVP_vaultAcaoTempo = time + 10;
							call BRPVP_vaultRecolhe;
						};
						[localize "str_vault_scut",0] call BRPVP_hint;
					};
					30 spawn BRPVP_menuMuda;
				};
				if (_this == 2) then {
					if (!BRPVP_earPlugs) then {
						1 fadeSound 0.125;
						BRPVP_earPlugs = true;
					} else {
						1 fadeSound 1;
						BRPVP_earPlugs = false;
					};
					[localize "str_scut_ear_plugs",0] call BRPVP_hint;
					30 spawn BRPVP_menuMuda;
				};
				if (_this == 3) then {
					BRPVP_terrainShowDistanceLimit call BRPVP_showTerrains;
					30 spawn BRPVP_menuMuda;
				};
				if (_this == 24) then {
					_idx = BRPVP_viewDistList find BRPVP_viewDist;
					_newIdx = if (_idx != -1) then {(_idx + 1) mod count BRPVP_viewDistList} else {0};
					BRPVP_viewDist = BRPVP_viewDistList select _newIdx;
					BRPVP_viewObjsDist = BRPVP_viewObjsDistList select _newIdx;
					setViewDistance BRPVP_viewDist;
					setObjectViewDistance BRPVP_viewObjsDist;
					30 spawn BRPVP_menuMuda;
				};
				if (_this == 4) then {
					if (BRPVP_rastroBalasLigado) then {
						BRPVP_rastroBalasLigado = false;
						[localize "str_bpath_off",0] call BRPVP_hint;
					} else {
						BRPVP_rastroBalasLigado = true;
						[localize "str_bpath_on",0] call BRPVP_hint;
						_nulo = [] spawn BRPVP_rastroWhile;
					};
					30 spawn BRPVP_menuMuda;
				};
				if (_this == 5) then {
					if (BRPVP_completeUpdate) then {
						BRPVP_completeUpdate = false;
						[localize "str_fps_on"] call BRPVP_hint;
					} else {
						BRPVP_completeUpdate = true;
						[localize "str_fps_off"] call BRPVP_hint;
					};
					30 spawn BRPVP_menuMuda;
				};
				if (_this == 6) then {
					if (speed player < 0.1) then {
						player action ["SwitchWeapon",player,player,100];
						[localize "str_holdwep_scut",0] call BRPVP_hint;
					};
				};
				if (_this == 7) then {
					BRPVP_suicidouTrava = BRPVP_suicidouTrava - 1;
					if (BRPVP_suicidouTrava == 0) then {
						BRPVP_suicidou = true;
						[["suicidou",1]] call BRPVP_mudaExp;
						player setDamage 1;
						[] spawn {
							_ini = time;
							waitUntil {(player getVariable "dd") == 0 || (time - _ini) > 1};
							player setVariable ["dd",1,true];
						};
					};
					playSound "radarbip";
					30 spawn BRPVP_menuMuda;
				};
				if (_this == 8) then {
					45 call BRPVP_menuMuda;
				};
				if (_this == 9) then {
					35 call BRPVP_menuMuda;
					[localize "str_scut_special_items",0] call BRPVP_hint;
				};
				if (_this == 10) then {
					6 call BRPVP_menuMuda;
				};
				if (_this == 11) then {
					7 call BRPVP_menuMuda;
				};
				if (_this == 12) then {
					0 call BRPVP_menuMuda;
				};
				if (_this == 13) then {
					44 call BRPVP_menuMuda;
				};
				if (_this == 14) then {
					BRPVP_giveMoneyEndMenu = 30;
					BRPVP_transferType = "mny";
					BRPVP_negativeValues = false;
					BRPVP_giveNoRemove = false;
					BRPVP_maxDistanceToGiveHandMoneyTemp = BRPVP_maxDistanceToGiveHandMoney;
					32 call BRPVP_menuMuda;
				};
				if (_this == 15) then {
					46 spawn BRPVP_menuMuda;
				};
				if (_this == 16) then {
					[localize "str_scut_3d_marks",10,15,70] call BRPVP_hint;
					30 spawn BRPVP_menuMuda;
				};
				if (_this == 17) then {
					[localize "str_scut_parachute",5,15,70] call BRPVP_hint;
					30 spawn BRPVP_menuMuda;
				};
				if (_this == 18) then {
					[localize "str_scut_fly",10,15,70] call BRPVP_hint;
					30 spawn BRPVP_menuMuda;				
				};
				if (_this == 19) then {
					[BRPVP_serverLastChanges,-15] call BRPVP_hint;
					30 spawn BRPVP_menuMuda;				
				};
				if (_this == 20) then {
					[BRPVP_serverNextChanges,-15] call BRPVP_hint;
					30 spawn BRPVP_menuMuda;				
				};
				if (_this == 21) then {
					48 spawn BRPVP_menuMuda;				
				};
				if (_this == 23) then {
					52 call BRPVP_menuMuda;
				};
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			call BRPVP_atualizaDebug;
		};
	},

	//MENU 31
	{
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuOpcoes = [];
		BRPVP_menuImagem = [];
		BRPVP_menuVal = [];
		_txt = "<t size='2.0' color='#FFFF33' align='center'>" + localize "str_price" + " $ %1</t><br/><img size='3.0' align='center' image='%2'/>";
		{
			private ["_imagem","_nomeBonito"];
			_it = _x;
			_idc = BRPVP_specialItems find _it;
			if (_idc >= 0) then {
				_imagem = BRPVP_specialItemsImages select _idc;
				_nomeBonito = BRPVP_specialItemsNames select _idc;
			} else {
				_imagem = "BRP_imagens\interface\amigo_color.paa";
				_nomeBonito = "ITEM ?";
				_isM = isClass (configFile >> "CfgMagazines" >> _it);
				if (_isM) then {
					_imagem = getText (configFile >> "CfgMagazines" >> _it >> "picture");
					_nomeBonito = getText (configFile >> "CfgMagazines" >> _it >> "displayName");
				} else {
					_isW = isClass (configFile >> "CfgWeapons" >> _it);
					if (_isW) then {
						_imagem = getText (configFile >> "CfgWeapons" >> _it >> "picture");
						_nomeBonito = getText (configFile >> "CfgWeapons" >> _it >> "displayName");
					} else {
						_isV = isClass (configFile >> "CfgVehicles" >> _it);
						if (_isV) then {
							_imagem = getText (configFile >> "CfgVehicles" >> _it >> "picture");
							_nomeBonito = getText (configFile >> "CfgVehicles" >> _it >> "displayName");
						};
					};
				};
			};
			_preco = BRPVP_compraItensPrecos select _forEachIndex;
			BRPVP_menuOpcoes pushBack _nomeBonito;
			BRPVP_menuImagem pushBack format[_txt,round _preco,_imagem];
			BRPVP_menuVal pushBack [_forEachIndex,_preco];
		} forEach BRPVP_compraItensTotal;
		BRPVP_menuDestino = 31;
		BRPVP_menuCodigo = {
			_idc = BRPVP_menuVal select BRPVP_menuOpcoesSel select 0;
			_preco = BRPVP_menuVal select BRPVP_menuOpcoesSel select 1;
			BRPVP_compraPrecoTotal = BRPVP_compraPrecoTotal - _preco;
			BRPVP_compraItensTotal deleteAt _idc;
			BRPVP_compraItensPrecos deleteAt _idc;
			playSound "granted";
		};
		BRPVP_menuVoltar = {12 spawn BRPVP_menuMuda;};
	},
	
	//MENU 32
	{
		BRPVP_menuTipo = 0;
		BRPVP_maxDistanceToGiveHandMoneyTemp call BRPVP_pegaListaPlayersNear;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='BRP_imagens\interface\dinheiro.paa'/> <img size='3.0' align='center' image='BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuDestino = 33;
		BRPVP_menuCodigo = {
			BRPVP_menuVar1 = BRPVP_menuExecutaParam select BRPVP_menuOpcoesSel;
			BRPVP_menuVar2 = 0;
		};
		BRPVP_menuVoltar = {BRPVP_giveMoneyEndMenu spawn BRPVP_menuMuda;};
	},

	//MENU 33
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='BRP_imagens\interface\dinheiro.paa'/> <img size='3.0' align='center' image='BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuForceExit = {
			_true = isNull BRPVP_menuVar1 && {isPlayer BRPVP_menuVar1};
			if (_true) then {[localize "str_player_cant_find",0] call BRPVP_hint;};
			_true
		};
		if (BRPVP_negativeValues) then {
			BRPVP_menuOpcoes = ["+ 10 $","+ 50 $","+ 250 $","+ 1000 $","+ 5000 $","+ 10000 $","+ 50000 $","+ 100000 $","- 10 $","- 50 $","- 250 $","- 1000 $","- 5000 $","- 10000 $","- 50000 $","- 100000 $",localize "str_back_to" + " 0 $"];
			BRPVP_menuExecutaParam = [10,50,250,1000,5000,10000,50000,100000,-10,-50,-250,-1000,-5000,-10000,-50000,-100000,0];
		} else {
			BRPVP_menuOpcoes = ["+ 10 $","+ 50 $","+ 250 $","+ 1000 $","+ 5000 $","+ 10000 $","+ 50000 $","+ 100000 $",localize "str_back_to" + " 0 $"];
			BRPVP_menuExecutaParam = [10,50,250,1000,5000,10000,50000,100000,0];
		};
		BRPVP_menuExecutaFuncao = {
			if (_this == 0) then {
				BRPVP_menuVar2 = 0;
			} else {
				_money = player getVariable BRPVP_transferType;
				if (_money >= BRPVP_menuVar2 + _this || BRPVP_giveNoRemove) then {
					BRPVP_menuVar2 = BRPVP_menuVar2 + _this;
					playSound "hint";
				} else {
					playSound "erro";
				};
			};
			call BRPVP_atualizaDebugMenu;
		};
		BRPVP_menuVoltar = {
			if (BRPVP_menuVar2 == 0) then {
				32 spawn BRPVP_menuMuda;
			} else {
				34 spawn BRPVP_menuMuda;
			};
		};
	},
	
	//MENU 34
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuForceExit = {
			_true = isNull BRPVP_menuVar1 && {isPlayer BRPVP_menuVar1};
			if (_true) then {[localize "str_player_cant_find",0] call BRPVP_hint;};
			_true
		};
		BRPVP_menuOpcoes = [localize "str_menu34_opt0",localize "str_menu34_opt1"];
		BRPVP_menuExecutaParam = [0,1];
		BRPVP_menuExecutaFuncao = {
			if (_this == 0) then {
				_money = player getVariable BRPVP_transferType;
				if ((_money >= BRPVP_menuVar2 || BRPVP_giveNoRemove) && {isplayer BRPVP_menuVar1 && {BRPVP_menuVar1 getVariable "dd" == -1}}) then {
					if (!BRPVP_giveNoRemove) then {player setVariable [BRPVP_transferType,_money - BRPVP_menuVar2,true];};
					BRPVP_giveMoneySV = [BRPVP_menuVar1,BRPVP_menuVar2,BRPVP_transferType];
					if (isServer) then {["",BRPVP_giveMoneySV] call BRPVP_giveMoneySVFnc;} else {publicVariableServer "BRPVP_giveMoneySV";};
					playSound "negocio";
				} else {
					playSound "erro";
				};
			};
			32 spawn BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {33 spawn BRPVP_menuMuda;};
	},
	
	//MENU 35
	{
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = [];
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuDestino = 35;
		BRPVP_menuOpcoes = [];
		{
			_q = {_x == _forEachIndex} count (player getVariable "sit");
			BRPVP_menuOpcoes pushBack ("X" + str _q + " " + _x);
			_img = BRPVP_specialItemsImages select _forEachIndex;
			BRPVP_menuImagem pushBack ("<img size='4.5' align='center' image='" + _img + "'/>");
		} forEach BRPVP_specialItemsNames;
		BRPVP_menuCodigo = {
			_ii = BRPVP_menuOpcoesSel;
			if (_ii in (player getVariable "sit")) then {
				BRPVP_menuExtraLigado = false;
				call BRPVP_atualizaDebug;
				[call compile (BRPVP_specialItems select _ii),"",_ii] call BRPVP_construir;
			} else {
				playSound "erro";
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			call BRPVP_atualizaDebug;
		};
	},
	
	//MENU 36
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='BRP_imagens\interface\daytime.paa'/>";
		BRPVP_menuOpcoes = [
			"00:00",
			"01:00",
			"02:00",
			"03:00",
			"04:00",
			"05:00",
			"06:00",
			"07:00",
			"08:00",
			"09:00",
			"10:00",
			"11:00",
			"12:00",
			"13:00",
			"14:00",
			"15:00",
			"16:00",
			"17:00",
			"18:00",
			"19:00",
			"20:00",
			"21:00",
			"22:00",
			"23:00"
		];
		BRPVP_menuExecutaParam = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = _this;
			37 spawn BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {
			29 spawn BRPVP_menuMuda;
		};
	},
	
	//MENU 37
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuOpcoes = [
			str BRPVP_menuVar1 + ":00",
			str BRPVP_menuVar1 + ":05",
			str BRPVP_menuVar1 + ":10",
			str BRPVP_menuVar1 + ":15",
			str BRPVP_menuVar1 + ":20",
			str BRPVP_menuVar1 + ":25",
			str BRPVP_menuVar1 + ":30",
			str BRPVP_menuVar1 + ":35",
			str BRPVP_menuVar1 + ":40",
			str BRPVP_menuVar1 + ":45",
			str BRPVP_menuVar1 + ":50",
			str BRPVP_menuVar1 + ":55"
		];
		BRPVP_menuExecutaParam = [0,5,10,15,20,25,30,35,40,45,50,55];
		BRPVP_menuExecutaFuncao = {
			_date = date;
			_date set [3,BRPVP_menuVar1];
			_date set [4,_this];
			BRPVP_setDateSV = _date;
			if (isServer) then {["",BRPVP_setDateSV] call BRPVP_setDateSVFnc;} else {publicVariableServer "BRPVP_setDateSV";};
			29 spawn BRPVP_menuMuda;
		};
	},
	
	//MENU 38
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3' align='center' image='BRP_imagens\interface\timemultiplier.paa'/>";
		BRPVP_menuOpcoes = [
			localize "str_a_day_in" + " 24h",
			localize "str_a_day_in" + " 12h",
			localize "str_a_day_in" + " 08h",
			localize "str_a_day_in" + " 06h",
			localize "str_a_day_in" + " 04h",
			localize "str_a_day_in" + " 03h",
			localize "str_a_day_in" + " 02h",
			localize "str_a_day_in" + " 01h",
			localize "str_a_day_in" + " 30m"
		];
		BRPVP_menuExecutaParam = [1,2,3,4,6,8,12,24,48];
		BRPVP_menuExecutaFuncao = {
			BRPVP_setTimeMultiplierSV = _this;
			if (isServer) then {["",BRPVP_setTimeMultiplierSV] call BRPVP_setTimeMultiplierSVFnc;} else {publicVariableServer "BRPVP_setTimeMultiplierSV";};
			29 spawn BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {
			29 spawn BRPVP_menuMuda;
		};
	},
	
	//MENU 39
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3' align='center' image='BRP_imagens\interface\setweather.paa'/>";
		BRPVP_menuOpcoes = [
			localize "str_clouds" + " 0%",
			localize "str_clouds" + " 20%",
			localize "str_clouds" + " 40%",
			localize "str_clouds" + " 60% " + localize "str_can_rain",
			localize "str_clouds" + " 80% " + localize "str_can_rain",
			localize "str_clouds" + " 100% " + localize "str_can_rain"
		];
		BRPVP_menuExecutaParam = [0,0.2,0.4,0.6,0.8,1];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = [_this];
			BRPVP_menuVar2 = [];
			if (BRPVP_menuVar1 select 0 >= 0.6) then {
				40 spawn BRPVP_menuMuda;
			} else {
				BRPVP_menuVar2 pushBack 0;
				41 spawn BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {29 spawn BRPVP_menuMuda;};
	},

	//MENU 40
	{
		BRPVP_menuOpcoes = [
			localize "str_rain" + " 0%",
			localize "str_rain" + " 20%",
			localize "str_rain" + " 40%",
			localize "str_rain" + " 60%",
			localize "str_rain" + " 80%",
			localize "str_rain" + " 100%"
		];
		BRPVP_menuExecutaParam = [0,0.2,0.4,0.6,0.8,1];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar2 pushBack _this;
			41 spawn BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {39 spawn BRPVP_menuMuda;};
	},
	
	//MENU 41
	{
		BRPVP_menuOpcoes = [
			localize "str_wind" + " 0 " + localize "str_speed_ms",
			localize "str_wind" + " 1 " + localize "str_speed_ms",
			localize "str_wind" + " 3 " + localize "str_speed_ms",
			localize "str_wind" + " 5 " + localize "str_speed_ms",
			localize "str_wind" + " 7 " + localize "str_speed_ms",
			localize "str_wind" + " 10 " + localize "str_speed_ms",
			localize "str_wind" + " 15 " + localize "str_speed_ms",
			localize "str_wind" + " 20 " + localize "str_speed_ms"
		];
		BRPVP_menuExecutaParam = [0,1,3,5,7,10,15,20];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar2 pushBack [_this,getDir player];
			42 spawn BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {
			if (BRPVP_menuVar1 select 0 >= 0.6) then {
				40 spawn BRPVP_menuMuda;
			} else {
				39 spawn BRPVP_menuMuda;
			};
		};
	},
	
	//MENU 42
	{
		BRPVP_menuOpcoes = [
			localize "str_guts" + " 0%",
			localize "str_guts" + " 20%",
			localize "str_guts" + " 40%",
			localize "str_guts" + " 60%",
			localize "str_guts" + " 80%",
			localize "str_guts" + " 100%"
		];
		BRPVP_menuExecutaParam = [0,0.2,0.4,0.6,0.8,1];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 pushBack _this;
			BRPVP_setWeatherServer = [BRPVP_menuVar1,BRPVP_menuVar2];
			if (isServer) then {["",BRPVP_setWeatherServer] call BRPVP_setWeatherServerFnc;} else {publicVariableServer "BRPVP_setWeatherServer";};
			29 spawn BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {41 spawn BRPVP_menuMuda;};
	},
	
	//MENU 43
	{
		BRPVP_menuTipo = 2;
		call BRPVP_pegaListaPlayers;
		BRPVP_menuExecutaFuncao = BRPVP_spectateFnc;
	},

	//MENU 44
	{
		BRPVP_menuTipo = 2;
		call BRPVP_pegaListaPlayers;
		_delete = [];
		{
			if !(_x call BRPVP_checaAcesso) then {
				_delete pushBack _forEachIndex;
			};
		} forEach BRPVP_menuExecutaParam;
		_delete sort false;
		{
			BRPVP_menuOpcoes deleteAt _x;
			BRPVP_menuExecutaParam deleteAt _x;
		} forEach _delete;
		BRPVP_menuExecutaFuncao = BRPVP_spectateFnc;
	},

	//MENU 45
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuOpcoes = [
			localize "str_expo_wit",
			localize "str_expo_witr",
			localize "str_expo_everyone",
			localize "str_expo_om"
		];
		BRPVP_menuExecutaParam = [1,2,3,4];
		BRPVP_menuPos set [BRPVP_menuIdc,(player getVariable ["stp",0])-1];
		BRPVP_menuExecutaFuncao = {
			if (_this != player getVariable ["stp",-1]) then {
				_accessChanged = allPlayers - [player];
				_accessChanged = _accessChanged apply {[_x,[_x,player] call BRPVP_checaAcessoRemoto]};
				_needToUpdate = [];
				player setVariable ["stp",_this,true];
				{
					_x params ["_unit","_accessBefore"];
					if !(([_unit,player] call BRPVP_checaAcessoRemoto) isEqualTo _accessBefore) then {
						_needToUpdate pushBack _unit;
					};
				} forEach _accessChanged;
				BRPVP_askPlayersToUpdateFriendsServer = [_needToUpdate,player getVariable ["id","0"],_this];
				if (isServer) then {["",BRPVP_askPlayersToUpdateFriendsServer] call BRPVP_askPlayersToUpdateFriendsServerFnc;} else {publicVariableServer "BRPVP_askPlayersToUpdateFriendsServer";};
				call BRPVP_daUpdateNosAmigos;
				call BRPVP_atualizaDebugMenu;
			};
			playSound "hint";
		};
		BRPVP_menuVoltar = {30 spawn BRPVP_menuMuda;};
	},
	
	//MENU 46
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3' align='center' image='BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_askServerForDestructionLogReturn = nil;
		BRPVP_askServerForDestructionLog = [player,player getVariable "id_bd",BRPVP_vePlayers];
		if (isServer) then {["",BRPVP_askServerForDestructionLog] call BRPVP_askServerForDestructionLogFnc;} else {publicVariableServer "BRPVP_askServerForDestructionLog";};
		waitUntil {!isNil "BRPVP_askServerForDestructionLogReturn"};
		BRPVP_askServerForDestructionLogReturn = (call compile BRPVP_askServerForDestructionLogReturn) select 1;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			_row = _x;
			_vehicle = str (_forEachIndex + 1) + " - " + (_row select 4);
			BRPVP_menuOpcoes pushBack _vehicle;
			BRPVP_menuExecutaParam pushBack _forEachIndex;
		} forEach BRPVP_askServerForDestructionLogReturn;
		BRPVP_menuExecutaFuncao = {
			_row = BRPVP_askServerForDestructionLogReturn select _this;
			_owner = _row select 0;
			_ownerName = _row select 1;
			_id_bd = _row select 2;
			_okCrew = _row select 3;
			_vehicle = _row select 4;
			_class = _row select 5;
			_date = _row select 6;
			_dateTxt = str (_date select 0) + "/" + str (_date select 1) + "/" + str (_date select 2) + " " + str (_date select 3) + ":" + str (_date select 4);
			_price = -1;
			{
				if (_x select 3 == _class) exitWith {
					_price = (_x select 5) * BRPVP_marketPricesMultiply;
				};
			} forEach BRPVP_tudoA3;
			if (_price == -1) then {
				{
					_kitTxt = _x;
					_kitTxtArray = call compile _kitTxt;
					if (_class in _kitTxtArray) exitWith {
						{
							if (_x select 3 == _kitTxt) exitWith {
								_price = (_x select 4) * (BRPVP_mercadoPrecos select (_x select 0));
							};
						} forEach BRPVP_mercadoItens;
					};
				} forEach BRPVP_specialItems;
			};
			_priceTxt = "";
			if (_price != -1) then {
				_priceTxt = "\n" + (localize "str_price") + " > $ " + (_price call BRPVP_formatNumber);
			};
			_ownerData = localize "str_public";
			if (_owner != -1) then {
				_ownerData = str _owner + " - " + _ownerName;
			};
			[format [localize "str_ofenders_show",_dateTxt,_ownerData,_vehicle,_priceTxt,_okCrew],-10] call BRPVP_hint;
			playSound "comtiro";
		};
		BRPVP_menuVoltar = {30 spawn BRPVP_menuMuda;};
	},
	
	//MENU 47
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuOpcoes = [
			"+200 " + localize "str_meters",
			"+100 " + localize "str_meters",
			"+50 " + localize "str_meters",
			"-50 " + localize "str_meters",
			"-100 " + localize "str_meters",
			"-200 " + localize "str_meters"
		];
		BRPVP_menuExecutaParam = [200,100,50,-50,-100,-200];
		BRPVP_this = [0,[0,0,0]];
		BRPVP_menuExecutaFuncao = {
			BRPVP_this set [0,(((BRPVP_this select 0) + _this) max 0) min 5000];
			BRPVP_this set [1,ASLToAGL getPosASL player];
			deleteMarker "AREA_TO_CLEAN";
			_marca = createMarkerLocal ["AREA_TO_CLEAN",BRPVP_this select 1];
			_marca setMarkerShapeLocal "ELLIPSE";
			_marca setMarkerSizeLocal [BRPVP_this select 0,BRPVP_this select 0];
			_marca setMarkerColorLocal "ColorYellow";
			_marca setMarkerAlphaLocal 0.4;
			[localize "str_mapmark_done"] call BRPVP_hint;
		};
		BRPVP_menuVoltar = {
			deleteMarker "AREA_TO_CLEAN";
			BRPVP_this spawn {
				params ["_radius","_pos"];
				BRPVP_onlyOwnedHousesAskFor = player;
				BRPVP_onlyOwnedHousesServerReturn = nil;
				if (isServer) then {["",BRPVP_onlyOwnedHousesAskFor] call BRPVP_onlyOwnedHousesAskForFnc;} else {publicVariableServer "BRPVP_onlyOwnedHousesAskFor";};
				waitUntil {!isNil "BRPVP_onlyOwnedHousesServerReturn"};
				_selected = [];
				{
					if (_x distance _pos <= _radius) then {_selected pushBack _x;};
				} forEach (BRPVP_onlyOwnedHousesServerReturn + (_pos nearEntities [["LandVehicle","Air","Ship"],_radius]));
				diag_log ("[BRPVP ID List," + str _pos + "," + str _radius + " metros] INICIO");
				{diag_log str (_x getVariable "id_bd");} forEach _selected;
				diag_log ("[BRPVP ID List," + str _pos + "," + str _radius + " metros] FIM");
				[format [localize "str_mapmark_write",_radius]] call BRPVP_hint;
				deleteMarker "AREA_TO_CLEAN";
			};
			29 spawn BRPVP_menuMuda;
		};
	},

	//MENU 48
	{
		BRPVP_menuTipo = 1;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "";
		BRPVP_menuCorSelecao = "#AAAAAA";
		_BRPVP_hintHistoricShow = + BRPVP_hintHistoricShow;
		reverse _BRPVP_hintHistoricShow;
		BRPVP_menuOpcoes = _BRPVP_hintHistoricShow;
		BRPVP_menuVoltar = {30 spawn BRPVP_menuMuda;};
	},

	//MENU 49
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3' align='center' image='BRP_imagens\interface\fedidex.paa'/>";
		BRPVP_menuOpcoes = [
			localize "str_menu49_opt0",
			localize "str_menu49_opt1"
		];
		BRPVP_menuExecutaParam = [0,1];
		BRPVP_menuExecutaFuncao = {
			_pm = if (BRPVP_vePlayers) then {0} else {1};
			if (_this == 0) then {
				BRPVP_menuExtraLigado = false;
				BRPVP_itemTraderDiscount = 0.8;
				[0,0,0,[player,[0,5,3,7,15,10,11],_pm,1,"fedidex"]] execVm "client_code\actions\actionTrader.sqf";
			};
			if (_this == 1) then {
				BRPVP_menuExtraLigado = false;
				_sides = ["FEDIDEX"];
				[0,0,0,[player,_sides,_pm,"fedidex"]] execVm "client_code\actions\actionVehicleTrader.sqf";
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			call BRPVP_atualizaDebug;
		};
	},
	
	//MENU 50
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuDestino = 51;
		BRPVP_menuCodigo = {
			BRPVP_menuVar1 = BRPVP_menuOpcoes select BRPVP_menuOpcoesSel;
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			call BRPVP_atualizaDebug;
		};
		BRPVP_menuOpcoes = BRPVP_buildAdminGroups;
	},
	
	//MENU 51
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 3; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO | 3 - CODE
		BRPVP_menuImagem = {
			if (isNull findDisplay 13838) then {
				createDialog "AdmBuild";
				[] spawn {
					BRPVP_modelRotateAngle = 0;
					_init = time;
					while {!isNull findDisplay 13838} do {
						_vd1 = [sin BRPVP_modelRotateAngle,cos BRPVP_modelRotateAngle,0.5 * sin (BRPVP_modelRotateAngle + 90)];
						_vd2 = [sin (BRPVP_modelRotateAngle + 90),cos (BRPVP_modelRotateAngle + 90),0.5 * sin (BRPVP_modelRotateAngle + 180)];
						_vu = _vd2 vectorCrossProduct _vd1;
						((findDisplay 13838) displayCtrl 83831) ctrlSetModelDirAndUp [_vd1,_vu];
						_time = time;
						_delta = _time - _init;
						_init = _time;
						BRPVP_modelRotateAngle = (BRPVP_modelRotateAngle+360*_delta/4) mod 360;
						sleep 0.001;
					};
				};
			};
			_menuParam = BRPVP_menuExecutaParam select BRPVP_menuOpcoesSel;
			_newModel = getText (configFile >> "CfgVehicles" >> _menuParam >> "model");
			if (ctrlModel ((findDisplay 13838) displayCtrl 83831) != _newModel) then {
				_object = _menuParam createVehicleLocal [0,0,0];
				_bb = boundingBoxReal _object;
				_sizeOf = (_bb select 0) distance (_bb select 1);
				_sizeOf = _sizeOf max 1;
				_scale = (1/_sizeOf)^(0.9);
				deleteVehicle _object;
				((findDisplay 13838) displayCtrl 83831) ctrlSetModelScale 0.001;
				((findDisplay 13838) displayCtrl 83831) ctrlSetModel _newModel;
				((findDisplay 13838) displayCtrl 83831) ctrlSetModelScale _scale;
			};
		};
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			if ((_x select 0) isEqualTo BRPVP_menuVar1) then {
				_class = _x select 1;
				_isBuilding = _class isKindOf ["Building",configFile >> "CfgVehicles"];
				_isWall = _class isKindOf ["Wall",configFile >> "CfgVehicles"];
				_isWreck = _class isKindOf ["Wreck",configFile >> "CfgVehicles"];
				_isStatic = _class isKindOf ["Static",configFile >> "CfgVehicles"];
				_isThing = _class isKindOf ["Thing",configFile >> "CfgVehicles"];
				if (_isBuilding || _isWall || _isWreck || _isStatic || _isThing) then {
					BRPVP_menuOpcoes pushBack getText (configFile >> "CfgVehicles" >> _class >> "displayName");
					BRPVP_menuExecutaParam pushBack _class;
				};
			};
		} forEach BRPVP_buildAdminClasses;
		BRPVP_menuExecutaFuncao = {
			closeDialog 13838;
			BRPVP_menuExtraLigado = false;
			call BRPVP_atualizaDebug;
			[[_this],"",-1] call BRPVP_construir;
		};
		BRPVP_menuVoltar = {
			closeDialog 13838;
			50 spawn BRPVP_menuMuda;
		};
	},

	//MENU 52
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuDestino = 53;
		BRPVP_menuCodigo = {
			BRPVP_menuVar1 = BRPVP_specialItems select BRPVP_menuOpcoesSel;
		};
		BRPVP_menuVoltar = {30 spawn BRPVP_menuMuda;};
		BRPVP_menuOpcoes = BRPVP_specialItemsNames;
	},
	
	//MENU 53
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 3; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO | 3 - CODE
		BRPVP_menuImagem = {
			if (isNull findDisplay 13838) then {
				createDialog "AdmBuild";
				[] spawn {
					BRPVP_modelRotateAngle = 0;
					_init = time;
					while {!isNull findDisplay 13838} do {
						_vd1 = [sin BRPVP_modelRotateAngle,cos BRPVP_modelRotateAngle,0.5 * sin (BRPVP_modelRotateAngle + 90)];
						_vd2 = [sin (BRPVP_modelRotateAngle + 90),cos (BRPVP_modelRotateAngle + 90),0.5 * sin (BRPVP_modelRotateAngle + 180)];
						_vu = _vd2 vectorCrossProduct _vd1;
						((findDisplay 13838) displayCtrl 83831) ctrlSetModelDirAndUp [_vd1,_vu];
						_time = time;
						_delta = _time - _init;
						_init = _time;
						BRPVP_modelRotateAngle = (BRPVP_modelRotateAngle+360*_delta/4) mod 360;
						sleep 0.001;
					};
				};
			};
			_menuParam = BRPVP_menuExecutaParam select BRPVP_menuOpcoesSel;
			_newModel = getText (configFile >> "CfgVehicles" >> _menuParam >> "model");
			if (ctrlModel ((findDisplay 13838) displayCtrl 83831) != _newModel) then {
				_object = _menuParam createVehicleLocal [0,0,0];
				_bb = boundingBoxReal _object;
				_sizeOf = (_bb select 0) distance (_bb select 1);
				_sizeOf = _sizeOf max 1;
				_scale = (1/_sizeOf)^(0.9);
				deleteVehicle _object;
				((findDisplay 13838) displayCtrl 83831) ctrlSetModelScale 0.001;
				((findDisplay 13838) displayCtrl 83831) ctrlSetModel _newModel;
				((findDisplay 13838) displayCtrl 83831) ctrlSetModelScale _scale;
			};
		};
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			_class = _x;
			BRPVP_menuOpcoes pushBack getText (configFile >> "CfgVehicles" >> _class >> "displayName");
			BRPVP_menuExecutaParam pushBack _class;
		} forEach (call compile BRPVP_menuVar1);
		BRPVP_menuExecutaFuncao = {};
		BRPVP_menuVoltar = {
			closeDialog 13838;
			52 spawn BRPVP_menuMuda;
		};
	},
	
	//MENU 54
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='BRP_imagens\interface\dinheiro.paa'/>";
		BRPVP_atmAmount = 0;
		BRPVP_menuOpcoes = [
			localize "str_atm_deposit",
			localize "str_atm_withdraw",
			localize "str_atm_transfer"
		];
		BRPVP_menuExecutaParam = [0,1,2];
		BRPVP_menuExecutaFuncao = {
			if (player getVariable ["sok",false] && alive player) then {
				if (_this == 0) then {
					55 call BRPVP_menuMuda;
				};
				if (_this == 1) then {
					56 call BRPVP_menuMuda;
				};
				if (_this == 2) then {
					BRPVP_giveMoneyEndMenu = 54;
					BRPVP_transferType = "brpvp_mny_bank";
					BRPVP_negativeValues = false;
					BRPVP_giveNoRemove = false;
					BRPVP_maxDistanceToGiveHandMoneyTemp = 1000000;
					32 call BRPVP_menuMuda;
				};
				playSound "hint";
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			call BRPVP_atualizaDebug;
			BRPVP_actionRunning = BRPVP_actionRunning - [14];
		};
	},
	
	//MENU 55
	{
		BRPVP_menuOpcoes = [
			format [localize "str_atm_add",1],
			format [localize "str_atm_add",10],
			format [localize "str_atm_add",100],
			format [localize "str_atm_add",1000],
			format [localize "str_atm_add",10000],
			format [localize "str_atm_add",100000],
			localize "str_atm_all",
			localize "str_atm_remove",
			localize "str_atm_conclude"
		];
		BRPVP_menuExecutaParam = [1,10,100,1000,10000,100000,"all","remove","conclude"];
		BRPVP_menuExecutaFuncao = {
			if (player getVariable ["sok",false] && alive player) then {
				if (typeName _this == "SCALAR") then {
					playSound "hint";
					BRPVP_atmAmount = BRPVP_atmAmount + _this;
					55 call BRPVP_menuMuda;
				} else {
					if (_this == "all") then {
						playSound "hint";
						BRPVP_atmAmount = player getVariable ["mny",0];
					};
					if (_this == "remove") then {
						playSound "hint";
						BRPVP_atmAmount = 0;
					};
					if (_this == "conclude") then {
						BRPVP_atmAmount = (player getVariable ["mny",0]) min BRPVP_atmAmount;
						if (BRPVP_atmAmount > 0) then {
							playSound "negocio";
							player setVariable ["brpvp_mny_bank",(player getVariable ["brpvp_mny_bank",0]) + BRPVP_atmAmount,true];
							player setVariable ["mny",(player getVariable ["mny",0]) - BRPVP_atmAmount,true];
						};
						54 call BRPVP_menuMuda;
					} else {
						55 call BRPVP_menuMuda;
					};
				};
			};
		};
		BRPVP_menuVoltar = {
			playSound "hint";
			if (BRPVP_atmAmount > 0) then {
				BRPVP_confirmTittle = localize "str_atm_confirm_deposit";
				57 call BRPVP_menuMuda;
			} else {
				54 call BRPVP_menuMuda;
			};
		};
	},
	
	//MENU 56
	{
		BRPVP_menuOpcoes = [
			format [localize "str_atm_add",1],
			format [localize "str_atm_add",10],
			format [localize "str_atm_add",100],
			format [localize "str_atm_add",1000],
			format [localize "str_atm_add",10000],
			format [localize "str_atm_add",100000],
			localize "str_atm_all",
			localize "str_atm_remove",
			localize "str_atm_conclude"
		];
		BRPVP_menuExecutaParam = [1,10,100,1000,10000,100000,"all","remove","conclude"];
		BRPVP_menuExecutaFuncao = {
			if (player getVariable ["sok",false] && alive player) then {
				if (typeName _this == "SCALAR") then {
					playSound "hint";
					BRPVP_atmAmount = BRPVP_atmAmount + _this;
					56 call BRPVP_menuMuda;
				} else {
					if (_this == "all") then {
						playSound "hint";
						BRPVP_atmAmount = player getVariable ["brpvp_mny_bank",0];
					};
					if (_this == "remove") then {
						playSound "hint";
						BRPVP_atmAmount = 0;
					};
					if (_this == "conclude") then {
						BRPVP_atmAmount = (player getVariable ["brpvp_mny_bank",0]) min BRPVP_atmAmount;
						if (BRPVP_atmAmount > 0) then {
							playSound "negocio";
							player setVariable ["brpvp_mny_bank",(player getVariable ["brpvp_mny_bank",0]) - BRPVP_atmAmount,true];
							player setVariable ["mny",(player getVariable ["mny",0]) + BRPVP_atmAmount,true];
						};
						54 call BRPVP_menuMuda;
					} else {
						56 call BRPVP_menuMuda;
					};
				};
			};
		};
		BRPVP_menuVoltar = {
			playSound "hint";
			if (BRPVP_atmAmount > 0) then {
				BRPVP_confirmTittle = localize "str_atm_confirm_withdraw";
				57 call BRPVP_menuMuda;
			} else {
				54 call BRPVP_menuMuda;
			};
		};
	},
	
	//MENU 57
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuOpcoes = [localize "str_confirm",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [true,false];
		BRPVP_menuExecutaFuncao = {
			if (_this) then {
				if (BRPVP_confirmTittle == localize "str_atm_confirm_deposit") then {
					BRPVP_atmAmount = (player getVariable ["mny",0]) min BRPVP_atmAmount;
					if (BRPVP_atmAmount > 0) then {
						playSound "negocio";
						player setVariable ["brpvp_mny_bank",(player getVariable ["brpvp_mny_bank",0]) + BRPVP_atmAmount,true];
						player setVariable ["mny",(player getVariable ["mny",0]) - BRPVP_atmAmount,true];
					};
					54 call BRPVP_menuMuda;
				};
				if (BRPVP_confirmTittle == localize "str_atm_confirm_withdraw") then {
					BRPVP_atmAmount = (player getVariable ["brpvp_mny_bank",0]) min BRPVP_atmAmount;
					if (BRPVP_atmAmount > 0) then {
						playSound "negocio";
						player setVariable ["brpvp_mny_bank",(player getVariable ["brpvp_mny_bank",0]) - BRPVP_atmAmount,true];
						player setVariable ["mny",(player getVariable ["mny",0]) + BRPVP_atmAmount,true];
					};
					54 call BRPVP_menuMuda;
				};
			} else {
				playSound "hint";
				54 spawn BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {
			if (BRPVP_confirmTittle == localize "str_atm_confirm_deposit") then {55 spawn BRPVP_menuMuda;};
			if (BRPVP_confirmTittle == localize "str_atm_confirm_withdraw") then {56 spawn BRPVP_menuMuda;};
		};
	},

	//MENU 58
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuDestino = [59,60,61];
		BRPVP_menuCodigo = {};
		BRPVP_menuVoltar = {22 spawn BRPVP_menuMuda;};
		BRPVP_menuOpcoes = [
			localize "str_custom_friend_see",
			localize "str_custom_friend_add",
			localize "str_custom_friend_remove"
		];
	},
	
	//MENU 59
	{
		BRPVP_menuTipo = 1;
		BRPVP_menuCorSelecao = "#AAAAAA";
		_amgCustom = (BRPVP_stuff getVariable "amg") select 1;
		BRPVP_pegaNomePeloIdBd1 = [_amgCustom,player,false];
		BRPVP_pegaNomePeloIdBd1Retorno = nil;
		if (isServer) then {["",BRPVP_pegaNomePeloIdBd1] call BRPVP_pegaNomePeloIdBd1Fnc;} else {publicVariableServer "BRPVP_pegaNomePeloIdBd1";};
		waitUntil {!isNil "BRPVP_pegaNomePeloIdBd1Retorno"};
		BRPVP_menuOpcoes = BRPVP_pegaNomePeloIdBd1Retorno;
		BRPVP_menuVoltar = {58 spawn BRPVP_menuMuda;};
	},

	//MENU 60
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		_amgCustom = (BRPVP_stuff getVariable "amg") select 1;
		{
			_id_bd = _x getVariable ["id_bd",-1];
			if (_id_bd >= 0) then {
				if !(_id_bd in _amgCustom) then {
					BRPVP_menuOpcoes pushBack (_x getVariable "nm");
					BRPVP_menuExecutaParam pushBack [_x,_id_bd];
				};
			};
		} forEach (allPlayers - [player]);
		BRPVP_menuExecutaFuncao = BRPVP_confiarEmAlguemCustom;
		BRPVP_menuVoltar = {58 spawn BRPVP_menuMuda;};
	},
	
	//MENU 61
	{
		BRPVP_menuTipo = 2;
		_amgCustom = (BRPVP_stuff getVariable "amg") select 1;
		BRPVP_pegaNomePeloIdBd1 = [_amgCustom,player,true];
		BRPVP_pegaNomePeloIdBd1Retorno = nil;
		if (isServer) then {["",BRPVP_pegaNomePeloIdBd1] call BRPVP_pegaNomePeloIdBd1Fnc;} else {publicVariableServer "BRPVP_pegaNomePeloIdBd1";};
		waitUntil {!isNil "BRPVP_pegaNomePeloIdBd1Retorno"};
		BRPVP_menuOpcoes = BRPVP_pegaNomePeloIdBd1Retorno select 0;
		BRPVP_menuExecutaParam = [];
		{BRPVP_menuExecutaParam pushBack (BRPVP_pegaNomePeloIdBd1Retorno select 1 select _forEachIndex);} forEach BRPVP_menuOpcoes;
		BRPVP_menuExecutaFuncao = BRPVP_deixarDeConfiarCustom;
		BRPVP_menuVoltar = {58 spawn BRPVP_menuMuda;};
	}
];

//ROEDAPE DO MENU
_defaultFooter = {"<br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"};
BRPVP_menuRodapeHtml = [
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	{"<br/><br/><t size='1.15' color='#FFFF33' align='center'>" + format [localize "str_your_money",(player call BRPVP_qjsValorDoPlayer) call BRPVP_formatNumber] + "</t><br/><t size='1.15' color='#FFFF33' align='center'>"+format [localize "str_menu_foot_total_price",(round BRPVP_compraPrecoTotal) call BRPVP_formatNumber]+"</t><br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	{"<br/><br/><t size='1.15' color='#FFFF33' align='center'>" + format [localize "str_your_money",(player call BRPVP_qjsValorDoPlayer) call BRPVP_formatNumber] + "</t><br/><t size='1.15' color='#FFFF33' align='center'>"+format [localize "str_menu_foot_total_price",(round BRPVP_compraPrecoTotal) call BRPVP_formatNumber]+"</t><br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	{"<br/><br/><t size='1.15' color='#FFFF33' align='center'>" + format [localize "str_your_money",(player call BRPVP_qjsValorDoPlayer) call BRPVP_formatNumber] + "</t><br/><t size='1.15' color='#FFFF33' align='center'>"+format [localize "str_menu_foot_total_price",(round BRPVP_compraPrecoTotal) call BRPVP_formatNumber]+"</t><br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	{"<br/><br/><t size='1.15' color='#FFFF33' align='center'>" + format [localize "str_your_money",(player call BRPVP_qjsValorDoPlayer) call BRPVP_formatNumber] + "</t><br/><t size='1.15' color='#FFFF33' align='center'>"+format [localize "str_menu_foot_total_price",(round BRPVP_compraPrecoTotal) call BRPVP_formatNumber]+"</t><br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	{"<br/><t size='1.15' color='#FFFF33' align='center'>" + format [localize "str_your_money",(player call BRPVP_qjsValorDoPlayer) call BRPVP_formatNumber] + "</t><br/><t size='1.15' color='#FFFF33' align='center'>"+format [localize "str_menu_foot_total_price",round BRPVP_compraPrecoTotal]+"</t><br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	{"<br/>"+(if (!BRPVP_givenoRemove) then {"<t size='1.15' color='#FFFF33' align='center'>" + format [localize "str_your_money",(player call BRPVP_qjsValorDoPlayer) call BRPVP_formatNumber] + "</t><br/>"} else {""})+"<br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	{"<br/>"+(if (!BRPVP_givenoRemove) then {"<t size='1.15' color='#FFFF33' align='center'>" + format [localize "str_your_money",(player call BRPVP_qjsValorDoPlayer) call BRPVP_formatNumber] + "</t><br/>"} else {""})+"<t size='1.15' color='#FFFF33' align='center'>"+format [localize "str_menu_foot_to_give",(round BRPVP_menuVar2) call BRPVP_formatNumber]+"</t><br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	{"<br/>"+(if (!BRPVP_givenoRemove) then {"<t size='1.15' color='#FFFF33' align='center'>" + format [localize "str_your_money",(player call BRPVP_qjsValorDoPlayer) call BRPVP_formatNumber] + "</t><br/>"} else {""})+"<t size='1.15' color='#FFFF33' align='center'>"+format [localize "str_menu_foot_to_give",(round BRPVP_menuVar2) call BRPVP_formatNumber]+"</t><br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,	
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter
];

//POSICOES DOS MENUS
BRPVP_menuPos = [];
{BRPVP_menuPos pushBack 0;} forEach BRPVP_menu;

diag_log "[BRPVP FILE] sistema_menus.sqf END REACHED";