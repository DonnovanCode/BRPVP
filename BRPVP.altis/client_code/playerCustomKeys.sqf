diag_log "[BRPVP FILE] teclas_custom.sqf INITIATED";

//CODIGO DE TRATAMENTO DO MENU EXTRA
BRPVP_menuCode = {
	if (_key == 0x11 && _XXX) then {
		if (BRPVP_menuOpcoesSel >= 0) then {
			BRPVP_menuOpcoesSel = (BRPVP_menuOpcoesSel - 1) mod count BRPVP_menuOpcoes;
			if (BRPVP_menuOpcoesSel == -1) then {BRPVP_menuOpcoesSel = ((count BRPVP_menuOpcoes) - 1);};
			call BRPVP_atualizaDebugMenu;
			playSound "hint";
		};
	};
	if (_key == 0x1F && _XXX) then {
		if (BRPVP_menuOpcoesSel >= 0) then {
			BRPVP_menuOpcoesSel = (BRPVP_menuOpcoesSel + 1) mod count BRPVP_menuOpcoes;
			call BRPVP_atualizaDebugMenu;
			playSound "hint";
		};
	};
	if (_key == 0x39 && _XXX) then {
		if !(call BRPVP_menuForceExit) then {
			private ["_destino"];
			BRPVP_menuPos set [BRPVP_menuIdc,BRPVP_menuOpcoesSel];
			if (BRPVP_menuTipo == 0) then {
				call BRPVP_menuCodigo;
				if (typeName BRPVP_menuDestino == "ARRAY") then {
					_destino = BRPVP_menuDestino select BRPVP_menuOpcoesSel;
					_destino spawn BRPVP_menuMuda;
				} else {
					if (BRPVP_menuDestino >= 0) then {
						BRPVP_menuDestino spawn BRPVP_menuMuda;
					};
				};
			} else {
				if (BRPVP_menuTipo == 2) then {
					(BRPVP_menuExecutaParam select BRPVP_menuOpcoesSel) call BRPVP_menuExecutaFuncao;
				};
			};
		} else {
			playSound "erro";
			BRPVP_menuExtraLigado = false;
			call BRPVP_atualizaDebug;
		};
	};
	if (_key == 0x1E && _XXX) then {
		if (typeName BRPVP_menuVoltar == "SCALAR") then {
			BRPVP_menuVoltar spawn BRPVP_menuMuda;
		} else {
			if (typeName BRPVP_menuVoltar == "CODE") then {
				call BRPVP_menuVoltar;
			};
		};
	};
};

//TRATAMENTO DE TECLAS PARA CONSTRUCAO
BRPVP_lastConsTime = 0;
BRPVP_lastKeyCombination = [];
BRPVP_consCode = {
	_time = time;
	_keyCombination = _this select [1,4];
	if (_time - BRPVP_lastConsTime > 0.1 || !(_keyCombination isEqualTo BRPVP_lastKeyCombination)) then {
		BRPVP_lastConsTime = _time;

		//CHANGE OBJECT -1
		if (_key == 0x10 && _XXX && !(BRPVP_lastKeyCombination isEqualTo [0x12,false,false,false])) then {
			_retorno = true;
			_conta = count BRPVP_construindoItens;
			BRPVP_construindoItemIdc = BRPVP_construindoItemIdc - 1;
			if (BRPVP_construindoItemIdc == -1) then {BRPVP_construindoItemIdc = (_conta - 1);};
			BRPVP_construindoItem = BRPVP_construindoItens select BRPVP_construindoItemIdc;
			[] spawn BRPVP_consSpawnItem;
			playSound "hint";
		};

		//CHANGE OBJECT +1
		if (_key == 0x12 && _XXX && !(BRPVP_lastKeyCombination isEqualTo [0x10,false,false,false])) then {
			_retorno = true;
			_conta = count BRPVP_construindoItens;
			BRPVP_construindoItemIdc = (BRPVP_construindoItemIdc + 1) mod _conta;
			BRPVP_construindoItem = BRPVP_construindoItens select BRPVP_construindoItemIdc;
			[] spawn BRPVP_consSpawnItem;
			playSound "hint";
		};
		
		BRPVP_lastKeyCombination = _keyCombination;
		//MUDA ANG
		if (_key == 0x2D && _XXX) then {
			_retorno = true;
			_conta = count BRPVP_construindoAngsRotacao;
			BRPVP_construindoAngRotacaoIdc = (BRPVP_construindoAngRotacaoIdc + 1) mod _conta;
			BRPVP_construindoAngRotacao = BRPVP_construindoAngsRotacao select BRPVP_construindoAngRotacaoIdc;
			call BRPVP_atualizaDebugMenu;
		};

		//SET OBJECT ORIGIN
		if (_key == 0x15) then {
			_retorno = true;
			if (BRPVP_construindoPega select 0 >= 0) then {
				if (BRPVP_buildingLevelTerrain) then {
					_poWorld = getPosWorld BRPVP_construindoItemObj;
					_ho = _poWorld select 2;
					_ppWorld = getPosWorld player;
					_hp = _ppWorld select 2;
					_h = _ho - _hp;
					BRPVP_construindoHIntSet = _h;
				} else {
					_poWorld = getPosWorld BRPVP_construindoItemObj;
					_poGround = [_poWorld select 0,_poWorld select 1,0];
					_poGroundASL = AGLToASL _poGround;
					_ho = (_poWorld select 2) - (_poGroundASL select 2);
					BRPVP_construindoHIntSet = _ho;
				};
			};
			BRPVP_buildingLevelTerrain = !BRPVP_buildingLevelTerrain;
			call BRPVP_atualizaDebugMenu;
		};

		//RODA Z+ RODA Z-
		if ((_key == 0x2E || _key == 0x2C) && _XXX) then {
			_retorno = true;
			_dAng = BRPVP_construindoAngRotacao;
			if (_key == 0x2C) then {_dAng = -_dAng;};
			BRPVP_construindoAngRotacaoSet = (BRPVP_construindoAngRotacaoSet + _dAng) mod 360;
		};
		
		//SETA INTENSIDADE H
		if (_key == 0x2F && _XXX) then {
			_retorno = true;
			_conta = count BRPVP_construindoHInts;
			BRPVP_construindoHIntIdc = (BRPVP_construindoHIntIdc + 1) mod _conta;
			BRPVP_construindoHInt = BRPVP_construindoHInts select BRPVP_construindoHIntIdc;
			call BRPVP_atualizaDebugMenu;
		};
		
		//MOVE H + MOVE H -
		if ((_key == 0x13 || _key == 0x21) && _XXX) then {
			_retorno = true;
			_h = BRPVP_construindoHInt;
			if (_key == 0x21) then {_h = -_h;};
			BRPVP_construindoHIntSet = BRPVP_construindoHIntSet + _h;
		};
		
		//PEGA & SOLTA
		if (_key == 0x39 && _XXX) then {
			_retorno = true;
			if (BRPVP_construindoPega select 0 == -1) then {
				if (player distance BRPVP_construindoItemObj <= BRPVP_construindoFrente * 8) then {
					private ["_BRPVP_construindoHIntSet"];
					if (BRPVP_buildingLevelTerrain) then {
						_poWorld = getPosWorld BRPVP_construindoItemObj;
						_poGround = [_poWorld select 0,_poWorld select 1,0];
						_poGroundASL = AGLToASL _poGround;
						_ho = (_poWorld select 2) - (_poGroundASL select 2);
						_BRPVP_construindoHIntSet = _ho;
					} else {
						_pP = (getPosworld player) select 2;
						_oP = (getPosWorld BRPVP_construindoItemObj) select 2;
						_BRPVP_construindoHIntSet = _oP - _pP;
					};
					BRPVP_construindoPega = [
						player distance2D BRPVP_construindoItemObj,
						getDir player
					];
					BRPVP_construindoHIntSet = _BRPVP_construindoHIntSet;
					BRPVP_construindoDirPlyObj = [player,BRPVP_construindoItemObj] call BIS_fnc_dirTo;
				} else {
					playSound "erro";
				};
			} else {
				BRPVP_construindoPega = [-1];
				BRPVP_construindoHIntSet = 0;
			};
		};
		
		//VERTICAL ALIGMENT 
		if (_key == 0x14 && _XXX) then {
			_retorno = true;
			BRPVP_construindoAlinTerr = false;
			BRPVP_construindoItemObj setVectorUp [0,0,1];
		};
		
		//TERRAIN ALIGMENT 
		if (_key == 0x22 && _XXX) then {
			_retorno = true;
			BRPVP_construindoAlinTerr = true;
		};

		//CANCELA CONSTRUCAO
		if (_key == 0xD3 && _XXX) then {
			_retorno = true;
			call BRPVP_cancelaConstrucao;
		};
		
		//CONCLUI POSITIVO
		if (_key == 0x1C && _XXX) then {
			private ["_vComplete","_isSO","_estadoCons","_actualRespawnSpots","_flagOk"];
			_retorno = true;
			
			//CHECK IF NEAR FLAG
			_isFlag = BRPVP_construindoItemObj isKindOf "FlagCarrier";
			_flagOk = false;
			_extra = 0;			
			_mult = 1 - BRPVP_flagsAreasIntersectionAllowed;
			{
				if ([player,_x] call BRPVP_checaAcessoRemotoFlag || _isFlag) then {
						_extra = BRPVP_construindoItemObj call BRPVP_getFlagRadius;
						_extra = _extra * _mult;
						if (!_isFlag) then {_mult = 1;};
						_dist = _x call BRPVP_getFlagRadius;
						if (BRPVP_construindoItemObj distance _x <= _dist*_mult + _extra) exitWith {_flagOk = true;};
				};
			} forEach ((nearestObjects [BRPVP_construindoItemObj,["FlagCarrier"],200,true]) - [BRPVP_construindoItemObj]);
			if (_isFlag) then {_flagOk = !_flagOk;};
			if !(_flagOk || BRPVP_vePlayers || (BRPVP_allowBuildingsAwayFromFlags && !_isFlag)) exitWith {
				if (_isFlag) then {[localize "str_cons_cant_flag_2x",4,12,854,"erro"] call BRPVP_hint;} else {[localize "str_cons_cant_flag",4,12,854,"erro"] call BRPVP_hint;};
			};

			//CHECK IF IS RESPAWN SPOT AND IF CAN BUILD. EXIT IF CANT BUILD.
			_isRespawnSpot = BRPVP_construindoItemObjClass in BRP_kitRespawnA || BRPVP_construindoItemObjClass in BRP_kitRespawnB;
			if (_isRespawnSpot) then {
				_actualRespawnSpots = {
					_typeOf = typeOf _x;
					_typeOf in BRP_kitRespawnA || _typeOf in BRP_kitRespawnB
				} count BRPVP_myStuff;
			};
			if (_isRespawnSpot && {_actualRespawnSpots >= BRPVP_personalSpawnCountLimit}) exitWith {[localize "str_resp_cant_set",4,12,6374,"erro"] call BRPVP_hint;};

			//CANCEL IS THERE ARE TOO MUCH NOT-FRIENDLY CONSTRUCTIONS NEAR
			_objs = BRPVP_construindoItemObj nearObjects ["Building",100];
			_objs = _objs apply {if (_x getVariable ["id_bd",-1] != -1) then {_x} else {objNull}};
			_objs = _objs - [objNull];
			_friend = {_x call BRPVP_checaAcesso} count _objs;
			_notFriend = count _objs - _friend;
			_friendArea = (if (_notFriend == 0) then {1} else {_friend/(_friend + _notFriend + 0.001)}) >= BRPVP_friendBuildingsPercentageToBuild;
			if (!_friendArea && !BRPVP_vePlayers) exitWith {
				[localize "str_cons_cant_unfriend",4,12,854,"erro"] call BRPVP_hint;
			};

			//CANCEL IF BUILDING IN A SAFE ZONE
			_objPos = ASLToAGL getPosASL BRPVP_construindoItemObj;
			_objInSafe = ({_objPos distance (_x select 0) < (_x select 1)} count BRPVP_safeZonesOtherMethod) > 0;
			_objInSafeArround = ({_objPos distance (_x select 0) < BRPVP_noBuildDistInSafeZones} count BRPVP_safeZonesOtherMethod) > 0;
			if (_objInSafe && !BRPVP_vePlayers) exitWith {[localize "str_cons_cant_safez",4,12,854,"erro"] call BRPVP_hint;};
			if (_objInSafeArround && !BRPVP_vePlayers) exitWith {[format[localize "str_cons_cant_safez_arround",BRPVP_noBuildDistInSafeZones],4,12,854,"erro"] call BRPVP_hint;};

			_hMin = (BRPVP_buildingsHeightFixValue select (BRPVP_buildingsHeightFixClass find BRPVP_construindoItemObjClass)) * 0.5;
			if ((ASLToAGL getPosWorld BRPVP_construindoItemObj) select 2 < _hMin) exitWith {[localize "str_cons_cant_inside",4,12,6374,"erro"] call BRPVP_hint;};
				
			BRPVP_construindoItemObj removeAllEventHandlers "HandleDamage";
			_posW = getPosWorld BRPVP_construindoItemObj;
			_vdu = [vectorDir BRPVP_construindoItemObj,vectorUp BRPVP_construindoItemObj];
			if (BRPVP_construindoItemObjClass in BRPVP_buildingHaveDoorList) then {
				_vComplete = createVehicle [BRPVP_construindoItemObjClass,[0,0,0],[],0,"CAN_COLLIDE"];
				if (BRPVP_interactiveBuildingsGodMode || (BRPVP_flagBuildingsGodMode && _flagOk)) then {
					_vComplete allowDamage false;
				} else {
					_vComplete allowDamage false;
					_vComplete spawn {
						sleep 10;
						_this allowDamage true;
					};
				};
				_state = if (BRPVP_construindoItemObjClass in BRPVP_buildingHaveDoorListReverseDoor) then {1} else {0};
				if (_vComplete call BRPVP_isBuilding) then {
					{
						if (_vComplete animationPhase _x != _state) then {
							_vComplete animate [_x,_state];
						};
					} forEach animationNames _vComplete;
				};
				_isSO = false;
			} else {
				_vComplete = createSimpleObject [BRPVP_construindoItemObjClass,AGLToASL [0,0,0]];
				_isSO = true;
			};
			_vComplete setVectorDirAndUp _vdu;
			_vComplete setPosWorld _posW;
			_del = BRPVP_construindoItemObj;
			BRPVP_construindoItemObj = _vComplete;
			deleteVehicle _del;

			//SET FLAG PROTECTION IF CONSTRUCTING FLAG
			if (_isFlag) then {
				[BRPVP_construindoItemObj,{BRPVP_allFlags pushBack _this;}] remoteExec ["call",0,false];
				BRPVP_construindoItemObj setVariable ["brpvp_flag_protected",true,true];
				if (!BRPVP_interactiveBuildingsGodMode) then {
					if (BRPVP_flagBuildingsGodMode) then {
						{
							if (_x getVariable ["id_bd",-1] != -1) then {
								if (alive _x) then {
									if (_x getVariable "own" isEqualTo (player getVariable "id_bd")) then {
										if (local _x) then {
											_x allowDamage false;
										} else {
											[_x,false] remoteExec ["allowDamage",_x,false];
										};
										_x setVariable ["brpvp_flag_protected",true,true];
									};
								};
							};
						} forEach nearestObjects [BRPVP_construindoItemObj,["Building"],BRPVP_construindoItemObj call BRPVP_getFlagRadius,true];
					};
				};
			} else {
				if (_flagOk) then {
					BRPVP_construindoItemObj setVariable ["brpvp_flag_protected",true,true];
				};
			};

			//SET LAMP STATE
			_exec = "";
			if (BRPVP_construindoItemObjClass in BRP_kitLamp) then {
				BRPVP_construindoItemObj switchLight "OFF";
				_exec = "_this setDamage 0.95;";
			};

			//CREATE TURRETER FOR TURRETS
			if (BRPVP_construindoItemObjClass in BRP_kitAutoTurret) then {
				BRPVP_setAutoTurretServer = BRPVP_construindoItemObj;
				if (isServer) then {["",BRPVP_setAutoTurretServer] call BRPVP_setAutoTurretServerFnc;} else {publicVariableServer "BRPVP_setAutoTurretServer";};
				_exec = "_this call BRPVP_setTurretOperator;";
				_turretPos = getPosWorld BRPVP_construindoItemObj;
				_turretPos resize 2;
				BRPVP_construindoItemObj setVariable ["brpvp_fpsBoostPos",_turretPos,true];
			};

			BRPVP_construindo = false;
			player setVariable ["bdg",false,true];
			call BRPVP_atualizaDebugMenu;

			_dstp = if (_isFlag) then {3} else {player getVariable "dstp"};
			BRPVP_construindoItemIdc = 0;
			BRPVP_construindoItemObj setVariable ["id_bd",1,true]; //TEMP id_bd UNTIL MYSQL RETURN THE REAL id_bd
			BRPVP_construindoItemObj setVariable ["own",player getVariable "id_bd",true];
			BRPVP_construindoItemObj setVariable ["stp",_dstp,true];
			BRPVP_construindoItemObj setVariable ["amg",[player getVariable "amg",[]],true];

			BRPVP_myStuff pushBack BRPVP_construindoItemObj;
			
			BRPVP_ownedHousesAdd = BRPVP_construindoItemObj;
			if (isServer) then {["",BRPVP_ownedHousesAdd] call BRPVP_ownedHousesAddFnc;} else {publicVariableServer "BRPVP_ownedHousesAdd";};

			_estadoCons = [
				[[[],[]],[],[[],[]],[[],[]]],
				[getPosWorld BRPVP_construindoItemObj,_vdu],
				BRPVP_construindoItemObjClass,
				BRPVP_construindoItemObj getVariable "own",
				BRPVP_construindoItemObj getVariable "stp",
				BRPVP_construindoItemObj getVariable "amg",
				_exec
			];
			BRPVP_adicionaConstrucaoBd = [false,BRPVP_construindoItemObj,_estadoCons,_isSO];
			if (isServer) then {["",BRPVP_adicionaConstrucaoBd] call BRPVP_adicionaConstrucaoBdFnc;} else {publicVariableServer "BRPVP_adicionaConstrucaoBd";};

			[["itens_construidos",1]] call BRPVP_mudaExp;
			_sit = player getVariable "sit";
			_i = _sit find BRPVP_construindoItemRetira;
			if (_i >= 0) then {
				_sit deleteAt _i;
				player setVariable ["sit",_sit,true];
			};

			player setVariable ["obui",objNull,true];

			//SET NEW RESPAWN SPOT
			if (_isRespawnSpot) then {
				BRPVP_respawnSpot pushBack BRPVP_construindoItemObj;
				_pos2D = getPosWorld BRPVP_construindoItemObj;
				_pos2D resize 2;
				BRPVP_construindoItemObj setVariable ["brpvp_fpsBoostPos",_pos2D,true];
				["geral"] call BRPVP_atualizaIcones;
			};

			//REMOVE ITEMS IF BOX
			if (BRPVP_construindoItemObjClass in BRP_kitFuelStorage) then {
				clearWeaponCargoGlobal BRPVP_construindoItemObj;
				clearMagazineCargoGlobal BRPVP_construindoItemObj;
				clearItemCargoGlobal BRPVP_construindoItemObj;
				clearBackpackCargoGlobal BRPVP_construindoItemObj;
			};

			if (BRPVP_construindoItemRetira == -1) then {50 call BRPVP_iniciaMenuExtra;} else {35 call BRPVP_iniciaMenuExtra;};
			
			//UPDATE OTHER PLAYERS FLAG LIST
			if (_isFlag) then {BRPVP_myStuffOthers pushBackUnique BRPVP_construindoItemObj;};

			//SET FLAG VEHICLES PROTECTION
			if (_isFlag) then {
				if (BRPVP_flagVehiclesGodModeWhenEmpty) then {
					{
						if !(_x isKindOf "StaticWeapon") then {
							[_x,false,objNull] call BRPVP_setFlagProtectionOnVehicle;
						};
					} forEach nearestObjects [BRPVP_construindoItemObj,["LandVehicle","Air","Ship"],BRPVP_construindoItemObj call BRPVP_getFlagRadius,true];
				};
			};

			["mastuff"] call BRPVP_atualizaIcones;
		};
	};
};

//TECLAS CUSTOMIZADAS PARA TODOS OS PLAYERS
player_keydown = {
	params ["_controle","_key","_keyShift","_keyCtrl","_keyAlt"];
	_retorno = false;
	//COMBINACOES CONTROL SHIFT ALT
	_XXX = !_keyShift && !_keyCtrl && !_keyAlt;
	_SXX = _keyShift && !_keyCtrl && !_keyAlt;
	_XCX = !_keyShift && _keyCtrl && !_keyAlt;
	_XXA = !_keyShift && !_keyCtrl && _keyAlt;
	_XCA = !_keyShift && _keyCtrl && _keyAlt;
	
	if (_key in actionKeys "chat") then {
		0 spawn {
			waitUntil {!isNull findDisplay 24};
			(findDisplay 24) displayAddEventHandler ["keyDown",{(_this select 1) call BRPVP_groupChatDEH}];
			waitUntil {isNull findDisplay 24};
		};
	};
	//CONSTRUCAO VARIOS COMANDOS
	if (BRPVP_construindo) then {
		_this call BRPVP_consCode;
	} else {
		//EXTRA MENU
		if (BRPVP_menuExtraLigado) then {
			if (!BRPVP_menuCustomKeysOff) then {call BRPVP_menuCode;};
			_retorno = !(_key in BRPVP_notBlockedKeys);
		} else {
			if (BRPVP_walkDisabled) then {
				_retorno = !(_key in BRPVP_notBlockedKeys || _key in [0x39]);
			} else {
				if (player getVariable ["sok",false]) then {
					if (alive player) then {
						//LOCK UNLOCK UNLOCK
						if (_key == 0x16 && _XXX) then {
							if (!isNull BRPVP_motorizedToLockUnlock) then {
								_retorno = true;
								if !(18 in BRPVP_actionRunning) then {
									[0,0,0,BRPVP_motorizedToLockUnlock] execVM "client_code\actions\actionVehicleLockUnlock.sqf";
								};
							};
						};
						//DISABLE STATUS BAR IF MAP IS ON
						if (_key in (actionKeys "showMap") && _XXX) then {
							if (visibleMap) then {BRPVP_statusBarOn = true;} else {BRPVP_statusBarOn = false;};
							call BRPVP_atualizaDebug;
						};
						//WEAPON ON BACK
						if (_key == 0x23 && _SXX) then {
							_retorno = true;
							player action ["SwitchWeapon",player,player,100];
						};
						//SPECIAL ITEMS
						if (_key == 0x17 && _XXA) then {
							_retorno = true;
							35 call BRPVP_iniciaMenuExtra;
						};
						//PLAYER MENU
						if (_key == 0x3C && _XXX) then {
							_retorno = true;
							playSound "achou_loot";
							BRPVP_suicidouTrava = 5;
							30 call BRPVP_iniciaMenuExtra;
						};
						//VAULT
						if (_key == 0x2F && _XXA) then {
							_retorno = true;
							_tempo = (BRPVP_vaultAcaoTempo - time) max 0;
							if (_tempo > 0) then {
								[format [localize "str_vault_cant",(round _tempo) max 1],0] call BRPVP_hint;
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
							};
						};
						//SETAS PARA AMIGOS
						if (_key in [0x02,0x03,0x04] && _XCX) then {
							private ["_idc"];
							_retorno = true;
							if (_key == 0x02) then {_idc = 0;};
							if (_key == 0x03) then {_idc = 1;};
							if (_key == 0x04) then {_idc = 2;};
							_setas = player getVariable ["sts",[[],[],[]]];
							if (count (_setas select _idc) == 0) then {
								_ct = cursorObject;
								if (!isNull _ct) then {
									_bb = boundingBoxReal _ct;
									_h = abs ((_bb select 0 select 2) - (_bb select 1 select 2));
									_pASL = getPosASL _ct;
									_p3D = ASLToAGL ((lineIntersectsSurfaces [_pASL vectorAdd [0,0,_h],_pASL]) select 0 select 0);
									_setas set [_idc,_p3D];
								} else {
									_p2D = screenToWorld [0.5,0.5];
									_setas set [_idc,[_p2D select 0,_p2D select 1]];
								};
								player setVariable ["sts",_setas,true];
							} else {
								_setas set [_idc,[]];
								player setVariable ["sts",_setas,true];
							};
						};
						//INFORMACOES DO OBJETO NA MIRA
						if (_key == 0x17 && _XCA) then {
							_retorno = true;
							_obj = cursorObject;
							if (!isNull _obj) then {
								BRPVP_objetoMarcado = _obj;
								_objClass = typeOf _obj;
								_objPos = getPosATL _obj;
								_objPos = [(round((_objPos select 0)*100))/100,(round((_objPos select 1)*100))/100,(round((_objPos select 2)*100))/100];
								_objVu = vectorUp _obj;
								_objVu = [round((_objVu select 0)*100)/100,round((_objVu select 1)*100)/100,round((_objVu select 2)*100)/100];
								_objDir = (round ((getDir _obj)*100))/100;
								["ctc: " + _objClass + " | " + "ctp: " + str _objPos + "\n" + "ctd: " + str _objDir + " | " + "ctv: " + str _objVu + "\n" + "cts: " + str _obj + " | ani: " + animationState _obj,10,5,437] call BRPVP_hint;
								diag_log ("[BRPVP] ANIMATION: " + animationState _obj);
								[str ([configfile >> "CfgVehicles" >> _objClass,true] call BIS_fnc_returnParents),10,12,438] call BRPVP_hint;
							} else {
								BRPVP_objetoMarcado = objNull;
							};
						};
						//INFORMACOES DO PLAYER
						if (_key == 0x19 && _XCA) then {
							_retorno = true;
							_pos = getPosATL player;
							_pos = [(round((_pos select 0)*100))/100,(round((_pos select 1)*100))/100,(round((_pos select 2)*100))/100];
							_class = typeOf player;
							_vu = vectorUp player;
							_vu = [round((_vu select 0)*100)/100,round((_vu select 1)*100)/100,round((_vu select 2)*100)/100];
							_dir = (round ((getDir player)*100))/100;
							["plc: " + _class + " | " + "plp: " + str _pos + "\n" + "pld: " + str _dir + " | " + "plv: " + str _vu,10,2,437] call BRPVP_hint;
							diag_log ("[INFO] Position: " + str _pos + " / Direction: " + str _dir);
						};
						//DEBUG
						if (_key == 0xD2 && _XXX) then {
							_retorno = true;
							BRPVP_indiceDebug = (BRPVP_indiceDebug + 1) mod (count BRPVP_indiceDebugItens);
							if (BRPVP_indiceDebug == 0) then {
								BRPVP_indiceDebugTxt = "Debug 1";
							};
							if (BRPVP_indiceDebug == 1) then {
								BRPVP_indiceDebugTxt = "Debug 2";
							};
							if (BRPVP_indiceDebug == 2) then {
								BRPVP_indiceDebugTxt = "Debug 3";
							};
							call BRPVP_atualizaDebug;
						};
						//EAR PLUGS
						if (_key == 0x3B && _XXX) then {
							_retorno = true;
							if (!BRPVP_earPlugs) then {
								1 fadeSound 0.2;
								BRPVP_earPlugs = true;
								[localize "str_ear_on",0] call BRPVP_hint;
							} else {
								1 fadeSound 1;
								BRPVP_earPlugs = false;
								[localize "str_ear_off",0] call BRPVP_hint;
							};
						};
						//ABRE PARAQUEDAS
						if (_key == 0x39 && (_XXX || _SXX) && !BRPVP_menuExtraLigado) then {
							if (BRPVP_spectateOn) then {
								_retorno = true;
								BRPVP_spectateOn = false;
							} else {
								if (typeOf unitBackpack player == "B_parachute" && alive player) then {
									_retorno = true;
									player action ["OpenParachute",player];
								};
							};
						};
						//SKY DIVE
						if (!isNil "BRPVP_nascendoParaQuedas" && !BRPVP_aceleraParaRodando) then {
							if ((_key == 0x11 || _key == 0x1F) && _SXX) then {
								BRPVP_aceleraParaRodando = true;
								if (_key == 0x11) then {
									_retorno = BRPVP_paraParam select 2;
									_nil = "descer" spawn BRPVP_aceleraPara;
								};
								if (_key == 0x1F) then {
									_retorno = BRPVP_paraParam select 3;
									_nil = "subir" spawn BRPVP_aceleraPara;
								};
							};
						};
						if (_key in actionKeys "gear" && _XXX) then {
							_retorno = BRPVP_antiWeaponDupeBoolean;
						};
					} else {
						if (_key == 0x39 && _XXX) then {
							_retorno = true;
							if (player getVariable ["dd",-1] == 0) then {
								player setVariable ["dd",1,true];
							};
						};
						if (BRPVP_trataseDeAdmin && {_key == 0x39 && _XXA}) then {
							_retorno = true;
							if (player getVariable ["dd",-1] == 0) then {
								player setVariable ["dd",2,true];
							};
						};
					};
				} else {
					if (_key in actionKeys "gear" && _XXX) then {
						_retorno = true;
					};
				};
			};
		};
	};
	_retorno
};

//TECLAS CUSTOMIZADAS PARA ADMINS
admin_keydown = {
	params ["_controle","_key","_keyShift","_keyCtrl","_keyAlt"];
	_retorno = false;
	if (alive player) then {
		//COMBINACOES CONTROL SHIFT ALT
		_XXA = !_keyShift && !_keyCtrl && _keyAlt;
		_XXX = !_keyShift && !_keyCtrl && !_keyAlt;
		_XCX = !_keyShift && _keyCtrl && !_keyAlt;

		//ADMIN MENU
		if (_key == 0x3D && _XXX) then {
			_retorno = true;
			29 call BRPVP_iniciaMenuExtra;
		};
		
		if (player getVariable ["sok",false]) then {
			//PULO A FRENTE
			if (_key == 0x06 && _XXX) then {
				_retorno = true;
				_dir = getDir vehicle player;
				_pAGL = getPos vehicle player;
				_hAGL = _pAGL select 2;
				if (_hAGL < 0.5) then {
					vehicle player setVehiclePosition [[(_pAGL select 0) + 5 * (sin _dir),(_pAGL select 1) + 5 * (cos _dir),0],[],0,"NONE"];
					player setDir _dir;
				} else {
					_pASL = getPosASL vehicle player;
					_pxASL = [(_pASL select 0) + 5 * (sin _dir),(_pASL select 1) + 5 * (cos _dir),_pASL select 2];
					_pxATL = ASLToATL _pxASL;
					_hOk = (_pxATL select 2) > 0;
					if (_hOk) then {vehicle player setPosASL _pxASL;} else {vehicle player setPosATL _pxATL;};
				};
			};
			
			//SUBIR NO EIXO Z
			if (_key == 0x05 && _XXX) then {
				_retorno = true;
				_vel = velocity vehicle player;
				_add = 1;
				if (_vel select 2 < 0) then {_add = 1 - (_vel select 2);};
				_velNew = [_vel select 0,_vel select 1,((_vel select 2) + _add) min 20];
				vehicle player setVelocity _velNew;
			};
		};
	};
	_retorno
};

//TECLAS CUSTOM
[] spawn {
	waitUntil {!isNull findDisplay 46};
	BRPVP_checkMapStatusBar = {
		if (!visibleMap) then {
			if (!BRPVP_statusBarOn) then {
				BRPVP_statusBarOn = true;
				call BRPVP_atualizaDebug;
			};
		} else {
			if (BRPVP_statusBarOn) then {
				BRPVP_statusBarOn = false;
				call BRPVP_atualizaDebug;
			};
		};
	};
	if (BRPVP_trataseDeAdmin) then {
		//DISPLAY EVENT HANDLER PARA ADMINS: TECLAS CUSTOM
		(findDisplay 46) displayAddEventHandler ["keyDown",{_this call admin_keydown || _this call player_keydown || (BRPVP_keyBlocked && !((_this select 1) in BRPVP_notBlockedKeys))}];
		BRPVP_sideDown = {
			if (!isNull findDisplay 63) then {
				BRPVP_statusBarOn = false;
				call BRPVP_atualizaDebug;
			};
			false
		};
		(findDisplay 46) displayAddEventHandler ["keyUp",{call BRPVP_checkMapStatusBar}];
	} else {
		//DISPLAY EVENT HANDLER PARA PLAYERS: TECLAS CUSTOM
		(findDisplay 46) displayAddEventHandler ["keyDown",{_this call player_keydown || (BRPVP_keyBlocked && !((_this select 1) in BRPVP_notBlockedKeys))}];

		//ANTI SIDE ABUSE
		//THANKS TO KillzoneKid: http://killzonekid.com/arma-scripting-tutorials-whos-talking/
		BRPVP_sideOnArray = [0];
		BRPVP_sideOn = false;
		BRPVP_sideDown = {
			if (!BRPVP_sideOn) then {
				BRPVP_sideOn = true;
				if (!isNull findDisplay 63) then {
					BRPVP_statusBarOn = false;
					call BRPVP_atualizaDebug;
					if (!isNull findDisplay 55) then {
						if (ctrlText (findDisplay 63 displayCtrl 101) == localize "str_channel_side") then {
							BRPVP_sideOnArray pushBack time;
							_totalTry = (count BRPVP_sideOnArray) - 1;
							_insistence = {time - _x < 10} count BRPVP_sideOnArray;
							_tooMany = _totalTry >= 30;
							_doubleClick = time - (BRPVP_sideOnArray select (_totalTry - 2)) < 0.75;
							if (_insistence >= 3 || _doubleClick || _tooMany) exitWith {
								[] spawn {
									[localize "str_side_dont_talk",0,200,0,"jumper"] call BRPVP_hint;
									sleep 2;
									endMission "END1";
								};
							};
							[localize "str_side_dont_talk",0,200,0,"achou_loot"] call BRPVP_hint;
							[time,_insistence] spawn {
								params ["_time","_insistence"];
								_breakRule = false;
								waitUntil {
									_breakRule = time - _time >= 4 - _insistence;
									_breakRule || !BRPVP_sideOn
								};
								if (_breakRule) then {
									[localize "str_side_dont_talk",0,200,0,"jumper"] call BRPVP_hint;
									sleep 2;
									endMission "END1";
								};
							};
						};
					};
				};
			};
			false
		};
		(findDisplay 46) displayAddEventHandler ["keyUp",{
			BRPVP_sideOn = false;
			call BRPVP_checkMapStatusBar;
		}];
	};
	(findDisplay 46) displayAddEventHandler ["keyDown",{0 spawn BRPVP_sideDown}];
	(findDisplay 46) displayAddEventHandler ["mouseButtonDown",{0 spawn BRPVP_sideDown}];
	(findDisplay 46) displayAddEventHandler ["joystickButton",{0 spawn BRPVP_sideDown}];

	//GROUP CHAT
	BRPVP_groupChatDEH = {
		if (ctrlText (findDisplay 63 displayCtrl 101) == localize "str_channel_group") then {
			if (_this in [0x1C,0x9C]) then {
				_groupMsg = ctrlText (findDisplay 24 displayCtrl 101);
				if (_groupMsg != "") then {
					_groupMsg = localize "str_radio" + " " + (player getVariable ["nm","?????"]) + ": " + _groupMsg;
					[_groupMsg] call BRPVP_log;
					{
						[_groupMsg,{systemChat _this;[_this] call BRPVP_log;playSound "radio_beep";}] remoteExec ["call",_x,false];
					} forEach BRPVP_meusAmigosObjGroupChat;
				};
			};
		};
		false
	};

	//NEXT
	(findDisplay 46) displayAddEventHandler ["keyUp",{BRPVP_keyBlocked}];
	
	//STATUS BAR
	(findDisplay 46) ctrlCreate ["RscStructuredText",BRPVP_barControlId];
	(findDisplay 46 displayCtrl BRPVP_barControlId) ctrlSetPosition [safeZoneX,safeZoneY+safeZoneH-0.043,safeZoneW,0.043];
	(findDisplay 46 displayCtrl BRPVP_barControlId) ctrlSetBackgroundColor [1,1,1,0];
	(findDisplay 46 displayCtrl BRPVP_barControlId) ctrlCommit 0;	
};

diag_log "[BRPVP FILE] teclas_custom.sqf END REACHED";