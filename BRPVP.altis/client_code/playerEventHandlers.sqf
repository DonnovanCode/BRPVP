diag_log "[BRPVP FILE] playerEH.sqf INITIATED";

//ADICIONA EVENT HANDLERS
player addEventHandler ["Respawn",{
	params ["_unit","_corpse"];
	_unit setVariable ["dd",-1,true];
	_unit setVariable ["sok",false,true];
	setPlayerRespawnTime 500;
	cutText ["","BLACK FADED",10];
	diag_log "[BRPVP RESPAWN] PLAYER RESPAWNED!";
	BRPVP_playerLastCorpse = _corpse;
	BRPVP_disabledBodyDamage = false;
	//_corpse setVariable ["stp",3,true];
	if (_corpse getVariable "dd" == 2) then {
		[] spawn {call BRPVP_nascimento_player_revive;};
	};
	if (_corpse getVariable "dd" == 1) then {
		_corpse setVariable ["hrm",serverTime,true];
		_corpse setVariable ["stp",3,true];
		//[_corpse,{_this setVariable ["hrm",time,true];}] remoteExec ["call",2,false];
		BRPVP_statusBarOnOverall = false;
		call BRPVP_atualizaDebug;
		execVM "init.sqf";
	};
}];
BRPVP_playerKilled = {
	//LOG DO SISTEMA
	diag_log "[BRPVP REVIVE] killed EH - player died while disabled!";

	//LAST BREATH
	playSound3D [BRPVP_missionRoot + "BRP_sons\nobreath.ogg",player,false,getPosASL player,1,1,50];

	//ATUALIZA ESTATISTICAS
	_matador = _this;
	if (_matador isKindof "LandVehicle" || _matador isKindof "Air") then {_matador = effectiveCommander _matador;};
	if (_matador isKindOf "CAManBase") then {
		if (isPlayer _matador) then {
			if (_matador != player) then {
				//FOI MORTO POR PLAYER: ATUALIZA ESTAT. MORTO
				[["player_matou",1]] call BRPVP_mudaExp;
				
				//FOI MORTO POR PLAYER: ATUALIZA ESTAT. MATADOR
				BRPVP_mudaExpOutroPlayer = [_matador,[["matou_player",1]]];
				if (isServer) then {["",BRPVP_mudaExpOutroPlayer] call BRPVP_mudaExpOutroPlayerFnc;} else {publicVariableServer "BRPVP_mudaExpOutroPlayer";};
			} else {
				if (!BRPVP_suicidou) then {
					//MOREU SOZINHO: QUEDA OU CHOQUE FISICO
					[["queda",1]] call BRPVP_mudaExp;
				} else {
					//MOREU SOZINHO: CONTROL + K (JA ESTATISTICOU)
					BRPVP_suicidou = false;
				};
			};
		} else {
			//FOI MORTO POR BOT
			[["bot_matou",1]] call BRPVP_mudaExp;
		};
	};
	
	//MENSAGEM DE KILL
	_pNome = player getVariable ["nm","sem_nome"];
	_tempoTiro = BRPVP_mensagemDeKillArray select 0;
	if (_tempoTiro > 0) then {
		_tempoSangra = time - _tempoTiro;
		if (_tempoSangra < 5) then {
			_KM_max = -1;
			_KM_tot = 0;
			_KM_maxIndex = -1;
			{
				_KM_tot = _KM_tot + _x;
				if (_x >= _KM_max) then {
					_KM_max = _x;
					_KM_maxIndex = _forEachIndex;
				};
			} forEach BRPVP_HDAtacantesDano;
			_KM_agres = BRPVP_HDAtacantes select _KM_maxIndex;
			_KM_agresPerc = str round ((_KM_max/_KM_tot) * 100) + "%";
			_aClass = BRPVP_mensagemDeKillArray select 2;
			_aNome = getText (configFile >> "CfgWeapons" >> _aClass >> "displayName");
			BRPVP_mensagemDeKillTxt = [
				"BRPVP_morreu_1",
				[
					_pNome, //ATACADO
					BRPVP_mensagemDeKillArray select 1, //OFENSOR
					_aNome, //ARMA USADA
					BRPVP_mensagemDeKillArray select 3, //DISTANCIA
					_KM_agres, //MOST AGRESSOR
					_KM_agresPerc //MOST AGRESSOR PERC
				]
			];
		} else {
			BRPVP_mensagemDeKillTxt = [
				"BRPVP_morreu_2",
				[_pNome,BRPVP_mensagemDeKillArray select 1,str round _tempoSangra]
			];
		};
	} else {
		BRPVP_mensagemDeKillTxt = ["BRPVP_morreu_3",[_pNome]];
	};
	BRPVP_mensagemDeKillTxt call LOL_fnc_showNotification;

	//ENVIA MENSAGEM DE KILL PARA OUTROS PLAYERS
	BRPVP_mensagemDeKillTxtSend = BRPVP_mensagemDeKillTxt;
	publicVariable "BRPVP_mensagemDeKillTxtSend";

	//DELETA QUADRICICLO SE ELE ESTIVER VAZIO
	_qdcl = player getVariable ["qdcl",objNull];
	if (!isNull _qdcl) then {
		if (count crew _qdcl == 0) then {
			deleteVehicle _qdcl;
		};
	};

	//PUT HAND MONEY IN CASE
	_mny = player getVariable ["mny",0];
	player setVariable ["mny",0,true];
	if (_mny > 0) then {
		_suitCase = "Land_Suitcase_F" createVehicle [0,0,0];
		_suitCase setVariable ["mny",_mny,true];
		_suitCase setPosWorld ((getPosWorld player) vectorAdd [0,0,1.5]);
	};

	//FECHA VAULT SE ESTIVER ABERTA
	_pSaved = false;
	_vault = player getVariable ["wh",objNull];
	if (!isNull _vault) then {
		_pSaved = true;
		call BRPVP_vaultRecolhe;
	};

	//CLOSE SELL RECEPTACLE
	_sellR = player getVariable ["sr",objNull];
	if (!isNull _sellR) then {
		if (_pSaved) then {
			false call BRPVP_actionSellClose;
		} else {
			_pSaved = true;
			true call BRPVP_actionSellClose;
		};
	};
	
	//SALVA AMIGOS, ESTATISTICAS ETC DO PLAYER NO BANCO DE DADOS PARA A PROXIMA VIDA
	if (!_pSaved) then {
		BRPVP_salvaPlayer = player call BRPVP_pegaEstadoPlayer;
		if (isServer) then {["",BRPVP_salvaPlayer] call BRPVP_salvaPlayerFnc;} else {publicVariableServer "BRPVP_salvaPlayer";};
	};
};
player addEventHandler ["Killed",{
	//REMOVE FEDIDEX ACTION
	player removeAction BRPVP_actionFedidex;
	
	//FECHA MENUS
	BRPVP_terrenosMapaLigado = false;
	BRPVP_menuExtraLigado = false;
	call BRPVP_atualizaDebug;
	
	//REMOVE FROM PLAYER IN VEHICLE ARRAY
	BRPVP_updatePlayersOnVehicleArray = [false,player];
	publicVariable "BRPVP_updatePlayersOnVehicleArray";
	[false,player] call BRPVP_playerVehiclesFnc;
	
	//LOG DAMAGE WHEN INCAPACITATED
	diag_log ("[BRPVP REVIVE] BRPVP_fallDamage = " + str BRPVP_fallDamage);
	
	//SHOUT
	playSound3D [BRPVP_missionRoot + "BRP_sons\" + (BRPVP_disabledSounds select (BRPVP_disabledSoundsIdc mod (count BRPVP_disabledSounds))),player,false,getposASL player,1,1,100];
	BRPVP_disabledSoundsIdc = BRPVP_disabledSoundsIdc + 1;

	diag_log "[BRPVP REVIVE] killed EH - player was disabled in combat!";

	player setVariable ["dd",0,true];
	BRPVP_disabledWeapon = currentWeapon player; 

	//DISABLED COUNT
	[] spawn {
		BRPVP_disabledBodyDamage = true;
		_disabledZombieDamage = 0;
		_step = 0.5/125;
		_initA = time;
		_initB = time;
		_dd = 0;
		[format [localize "str_revive_count",round (((0.5-BRPVP_disabledDamage) * 200) max 0),"%"],0] call BRPVP_hint;
		_zombieDistance = if (vehicle player == player) then {2.5} else {3.5};
		waitUntil {
			_time = time;
			if (_time - _initA >= 1) then {
				_initA = _time;
				BRPVP_disabledBleed = BRPVP_disabledBleed + _step;
				_ll = str (round (((0.5-(BRPVP_disabledDamage + BRPVP_disabledBleed + _disabledZombieDamage)) * 200) max 0));
				[format [localize "str_revive_count",_ll,"%"],0,200,0,"ciclo"] call BRPVP_hint;
				_zombies = player nearEntities [BRPVP_zombieMotherClass,_zombieDistance];
				_attackingAmount = {animationState _x == "AwopPercMstpSgthWnonDnon_end"} count _zombies;
				_disabledZombieDamage = _disabledZombieDamage + _attackingAmount * 0.025;
			};
			if (_time - _initB >= 0.5) then {
				_initB = _time;
				if (BRPVP_disabledDamage + BRPVP_disabledBleed + _disabledZombieDamage >= 0.5) then {
					player setVariable ["dd",1,true];
				};
			};
			_dd = player getVariable ["dd",0];
			_dd > 0
		};
		["",0,200,0,""] call BRPVP_hint;
		if (_dd == 1) then {
			diag_log ("[BRPVP REVIVE] BRPVP_lastOfensor = " + name BRPVP_lastOfensor);
			BRPVP_lastOfensor call BRPVP_playerKilled;
		};
		setPlayerRespawnTime 0;
	};
}];
player addEventHandler ["AnimDone",{
	_animacao = _this select 1;
	if (BRPVP_todasAnimAndando find _animacao >= 0) then {
		BRPVP_experienciaDeAndar = BRPVP_experienciaDeAndar + 1;
		if (BRPVP_experienciaDeAndar == 45) then {
			[["andou",1]] call BRPVP_mudaExp;
			BRPVP_experienciaDeAndar = 0;
		};
	};
}];
BRPVP_playerHandleDamage = {
	params ["_atacado","_parte","_dano","_ofensor","_projectile"];
	
	if (_atacado getVariable ["dd",-1] <= 0) then {
		private ["_dltDano"];

		//ADJUST DAMAGE
		_damageNow = if (_parte isEqualTo "") then {damage _atacado} else {_atacado getHit _parte};
		_dltDano = _dano - _damageNow;
		_dano = _damageNow + _dltDano * BRPVP_multiplicadorDanoAdmin/BRPVP_playerLifeMultiplier;

		//MOVE OUT VEHICLE IF DIE
		if (alive _atacado) then {
			if !(_atacado isEqualTo vehicle _atacado) then {
				_moveOut = switch (_parte) do {
					case "": {_dano >= 1};
					case "head": {_dano >= getNumber (configFile >> "CfgFirstAid" >> "CriticalHeadHit")};
					case "body": {_dano >= getNumber (configFile >> "CfgFirstAid" >> "CriticalBodyHit")};
					default {false};
				};
				if (_moveOut) then {moveOut _atacado;};
			};
		};

		if (_ofensor isKindof "LandVehicle" || _ofensor isKindof "Air") then {_ofensor = effectiveCommander _ofensor;};
		if (_ofensor isKindOf "CAManBase") then {
			if (_ofensor != _atacado) then {
				if (!BRPVP_safeZone) then {call BRPVP_ligaModoCombate;};
				if (_parte == "") then {
					_nOfensor = if (isPlayer _ofensor) then {_ofensor getVariable "nm"} else {localize "str_bots"};
					_atacIDC = BRPVP_HDAtacantes find _nOfensor;
					if (_atacIDC == -1) then {
						BRPVP_HDAtacantes append [_nOfensor];
						BRPVP_HDAtacantesDano append [_dltDano];
					} else {
						BRPVP_HDAtacantesDano set [_atacIDC,(BRPVP_HDAtacantesDano select _atacIDC) + _dltDano];
					};
					_dist = round (_atacado distance _ofensor);
					BRPVP_mensagemDeKillArray = [time,_nOfensor,currentWeapon _ofensor,str _dist];
				};
				if (_parte == "head") then {
					if (_dltDano > 0.9) then {
						if (isPlayer _ofensor) then {
							[["levou_tiro_cabeca_player",1]] call BRPVP_mudaExp;
							BRPVP_mudaExpOutroPlayer = [_ofensor,[["deu_tiro_cabeca_player",1]]];
							if (isServer) then {["",BRPVP_mudaExpOutroPlayer] call BRPVP_mudaExpOutroPlayerFnc;} else {publicVariableServer "BRPVP_mudaExpOutroPlayer";};
						} else {
							if (_ofensor isKindOf "Man") then {[["levou_tiro_cabeca_bot",1]] call BRPVP_mudaExp;};
						};
					};
				};
			};
		};
		if (_parte == "") then {
			BRPVP_lastOfensor = _ofensor;
			BRPVP_playerDamaged = true;
			if (BRPVP_disabledBodyDamage) then {
				BRPVP_disabledDamage = (_dano - BRPVP_fallDamage)/BRPVP_playerLifeMultiplier;
			} else {
				//STORE FALL DAMAGE
				BRPVP_fallDamage = _dano;
			};
		};
	};
	_dano
};
player addEventHandler ["HandleDamage",{
	_this call BRPVP_playerHandleDamage
}];
player addEventHandler ["FiredMan",{
	_weapon = _this select 1;
	_magazine = _this select 5;
	BRPVP_shotTime = time;
	if (BRPVP_earPlugs) then {
		0.2 fadeSound 0.0625;
		if (!BRPVP_earPlugsAlivio) then {
			BRPVP_earPlugsAlivio = true;
			_nulo = [] spawn {
				waitUntil {time - BRPVP_shotTime > 5 || !BRPVP_earPlugs};
				if (BRPVP_earPlugs) then {1 fadeSound 0.125;};
				BRPVP_earPlugsAlivio = false;
			};
		};
	};
	if (!BRPVP_safeZone) then {call BRPVP_ligaModoCombate;};
	_bala = _this select 6;
	_find = BRPVP_zombieDistractAmmo find (typeOf _bala);
	if (_find > -1) then {
		[_find,_bala] spawn {
			params ["_find","_smoke"];
			_init = time;
			waitUntil {
				((position _smoke) select 2 < 0.15 && vectorMagnitude velocity _smoke < 0.25) || time - _init > 10
			};
			sleep 0.5;
			_smokePos = (getPosWorld _smoke) vectorAdd [0,0,0.5];
			_smokePosAGL = ASLToAGL _smokePos;
			_uniqueZombies = 0;
			_maxPerAmmo = (BRPVP_maxZombiesPerSmokeShell select _find);
			_maxUnique = round (_maxPerAmmo * BRPVP_maxZombiesPerSmokeShellUniqueMult);
			waitUntil {
				_nearZombies = _smoke nearEntities [BRPVP_zombieMotherClass,BRPVP_zombieDistanceFromSmokeToCatchAttention];
				_smokeZombies = [];
				_zombieCount = {
					_is = alive _x && !isNull _x && _x getVariable ["brpvp_my_distract_object",objNull] == _smoke;
					if (_is) then {_smokeZombies pushBack _x};
					_is
				} count _nearZombies;
				{
					if (moveToCompleted _x) then {
						[_x,[_smokePosAGL,2,random 360] call BIS_fnc_RelPos] remoteExec ["moveTo",_x,false];
					};
				} forEach _smokeZombies;
				if (_zombieCount < _maxPerAmmo && _uniqueZombies < _maxUnique) then {
					_nearZombies = _nearZombies - _smokeZombies;
					_nearZombiesCanSee = [];
					{
						if (isNull (_x getVariable ["brpvp_my_distract_object",objNull])) then {
							if ([_x,"GEOM"] checkVisibility [eyePos _x,_smokePos] > 0) then {
								_nearZombiesCanSee pushBack _x;
							};
						};
					} forEach _nearZombies;
					_nearZombiesCanSee = _nearZombiesCanSee apply {[_x distance _smokePosAGL,_x]};
					_nearZombiesCanSee sort true;
					_nearZombiesCanSee resize ((_maxPerAmmo - _zombieCount) min (count _nearZombiesCanSee) min (_maxUnique - _uniqueZombies));
					_nearZombiesCanSee = _nearZombiesCanSee apply {_x select 1};
					{
						[_x,ASLToAGL getPosASL _x] remoteExec ["moveTo",_x,false];
						[_x,_smokePosAGL] remoteExec ["moveTo",_x,false];
						[_x,_smokePosAGL] remoteExec ["doWatch",_x,false];
						_x setVariable ["brpvp_my_distract_object",_smoke,true];
						_x setVariable ["brpvp_my_distract_object_init",time,true];
						_uniqueZombies = _uniqueZombies + 1;
					} forEach _nearZombiesCanSee;
				};
				sleep 0.5;
				isNull _smoke
			};
		};
	};
	if (BRPVP_ehNaoAtira) then {
		deleteVehicle _bala;
	} else {
		if (BRPVP_rastroBalasLigado) then {
			BRPVP_bala = _bala;
			BRPVP_rastroPosicoes = [position _bala];
		};
	};
	if (BRPVP_godMode || BRPVP_ehNaoAtira) then {
		if (_weapon isEqualTo secondaryWeapon player) then {
			player addSecondaryWeaponItem _magazine;
		} else {
			_wpn = currentWeapon player;
			player setAmmo [_wpn,(player ammo _wpn) + 1];
		};
	};
}];
BRPVP_slingEventHandlerOn = false;
player addEventHandler ["GetInMan",{
	_passenger = _this select 0;
	_veiculo = _this select 2;
	
	//SET TURRET TYPE TO ATTACK PLAYER IN VEHICLE
	if (_veiculo isKindOf "LandVehicle") then {
		_cfgVeh = configFile >> "CfgVehicles" >> (typeOf _veiculo);
		_armor = if (isNumber (_cfgVeh >> "armor")) then {getNumber (_cfgVeh >> "armor")} else {1};
		BRPVP_actualAutoTurretsDist = BRPVP_autoTurretFireRange select 1;
		if (_armor < 100) then {
			BRPVP_actualAutoTurrets = BRPVP_autoTurretOnLandVehicle;
		} else {
			if (_armor >= 100 && _armor < 200) then {
				BRPVP_actualAutoTurrets = BRPVP_autoTurretOnArmoredLandVehicle;
			} else {
				BRPVP_actualAutoTurrets = BRPVP_autoTurretOnHeavlyArmoredLandVehicle;
			};
		};
	} else {
		if (_veiculo isKindOf "Air") then {
			BRPVP_actualAutoTurrets = BRPVP_autoTurretOnAirVehicle;
			BRPVP_actualAutoTurretsDist = BRPVP_autoTurretFireRange select 2;
		};
	};
		
	if (_veiculo getVariable ["id_bd",-1] >= 0) then {
		if !(_veiculo getVariable ["slv",false]) then {_veiculo setVariable ["slv",true,true];};
	};
	_unid = _this select 0;
	if (isPlayer _unid) then {
		_ocup = _this select 1;
		if (_ocup == "DRIVER") then {
			//ADD SLING LOAD EVENT HANDLER
			_typeOf = typeOf _veiculo;
			if (isNumber (configFile >> "CfgVehicles" >> _typeOf >> "slingLoadMaxCargoMass")) then {
				_sligLimit = getNumber (configFile >> "CfgVehicles" >> _typeOf >> "slingLoadMaxCargoMass");
				if (_sligLimit > 0) then {
					BRPVP_slingEventHandlerOn = true;
					_veiculo addEventHandler ["RopeBreak",{
						params ["_heli","_rope","_cargo"];
						if (_cargo getVariable ["id_bd",-1] != -1) then {
							if !(_cargo getVariable ["slv",false]) then {_cargo setVariable ["slv",true,true];};
							[_heli,false,objNull] call BRPVP_setFlagProtectionOnVehicle;
						};
					}];
				};
			};
			
			if (BRPVP_safeZone) then {_veiculo allowDamage false;};
			//_nulo = [_veiculo,isEngineOn _veiculo] spawn BRPVP_protejeCarro;
		};
	};
	BRPVP_meuVeiculoNow = [];
	if (_veiculo call BRPVP_checaAcesso) then {
		BRPVP_assignedVehicle = _veiculo;
	} else {
		BRPVP_assignedVehicle = objNull;
	};
	
	//UPDATE VEHICLES WITH PLAYERS ARRAY
	player setVariable ["veh",_veiculo,true];
	BRPVP_updatePlayersOnVehicleArray = [true,player];
	[true,player] call BRPVP_playerVehiclesFnc;
	publicVariable "BRPVP_updatePlayersOnVehicleArray";
	
	//SHOW MESSAGE FOR NOT-DB VEHICLES
	if (_veiculo getVariable ["brpvp_fedidex",false]) then {
		[localize "str_fedidex_del_alert"] call BRPVP_hint;
	};

	//SET FLAG PROTECTION
	[_veiculo,true,_passenger] call BRPVP_setFlagProtectionOnVehicle;

	[200,0.125,1,_veiculo,5] call BRPVP_radarAdd;
	[localize "str_vehicle_radar",3.5,12] call BRPVP_hint;
}];
player addEventHandler ["GetOutMan",{
	_passenger = _this select 0;
	_vehicle = _this select 2;
	BRPVP_meuVeiculoNow = getPosATL _vehicle;
	
	//SET ATTACK TURRETS TO ANTI PERSONEL TURRETS
	BRPVP_actualAutoTurretsDist = BRPVP_autoTurretFireRange select 0;
	BRPVP_actualAutoTurrets = BRPVP_autoTurretOnMan;

	if (BRPVP_slingEventHandlerOn) then {
		_vehicle removeAllEventHandlers "RopeBreak";
		BRPVP_slingEventHandlerOn = false;
	};
	
	//UPDATE VEHICLES WITH PLAYERS ARRAY
	player setVariable ["veh",objNull,true];
	BRPVP_updatePlayersOnVehicleArray = [false,player];
	publicVariable "BRPVP_updatePlayersOnVehicleArray";
	[false,player] call BRPVP_playerVehiclesFnc;
	
	//SET FLAG PROTECTION
	[_vehicle,false] call BRPVP_setFlagProtectionOnVehicle;

	[200,0.125,1,_veiculo,5] call BRPVP_radarRemove;
}];
player addEventHandler ["SeatSwitchedMan",{
	_unid = _this select 0;
	if (isPlayer _unid) then {
		_ocup = (assignedVehicleRole _unid) select 0;
		_veiculo = _this select 2;
		if (_ocup == "DRIVER") then {
			//ADD SLING LOAD EVENT HANDLER
			_typeOf = typeOf _veiculo;
			if (isNumber (configFile >> "CfgVehicles" >> _typeOf >> "slingLoadMaxCargoMass")) then {
				_sligLimit = getNumber (configFile >> "CfgVehicles" >> _typeOf >> "slingLoadMaxCargoMass");
				if (_sligLimit > 0) then {
					BRPVP_slingEventHandlerOn = true;
					_veiculo addEventHandler ["RopeBreak",{
						params ["_heli","_rope","_cargo"];
						if (_cargo getVariable ["id_bd",-1] != -1) then {
							if !(_cargo getVariable ["slv",false]) then {_cargo setVariable ["slv",true,true];};
							[_heli,false,objNull] call BRPVP_setFlagProtectionOnVehicle;
						};
					}];
				};
			};

			if (BRPVP_safeZone) then {_veiculo allowDamage false;};
			//_nulo = [_veiculo,isEngineOn _veiculo] spawn BRPVP_protejeCarro;
		} else {
			if (BRPVP_slingEventHandlerOn) then {
				_veiculo removeAllEventHandlers "RopeBreak";
				BRPVP_slingEventHandlerOn = false;
			};
		};
	};
}];
player addEventHandler ["Put",{
	_cont = _this select 1;
	if (_cont getVariable ["id_bd",-1] >= 0) then {
		if !(_cont getVariable ["slv",false]) then {_cont setVariable ["slv",true,true];};
	};
}];
player addEventHandler ["Take",{
	_cont = _this select 1;
	_item = _this select 2;
	if (_item in ["FlareWhite_F","FlareYellow_F"]) then {
		_addMny = 1000;
		if (_item == "FlareYellow_F") then {_addMny = 2000;};
		player setVariable ["mny",(player getVariable "mny") + _addMny,true];
		playSound "negocio";
		_item spawn {
			sleep 0.001;
			player removeMagazines _this;
		};
		call BRPVP_atualizaDebug;
	};
	if (_cont getVariable ["id_bd",-1] >= 0) then {
		if !(_cont getVariable ["slv",false]) then {_cont setVariable ["slv",true,true];};
	};
	_wh_usos = _cont getVariable ["ml_takes",-1];
	if (_wh_usos >= 0) then {_cont setVariable ["ml_takes",_wh_usos + 1,true];};
}];
BRPVP_hasFlare = false;
player addEventHandler ["InventoryOpened",{
	_c = _this select 1;
	_canAccess = _c call BRPVP_checaAcesso;
	_isLockUnlock = (_c call BRPVP_isMotorized) && !(_c isKindOf "StaticWeapon") && _c getVariable ["id_bd",-1] != -1 && _c getVariable ["own",-1] != -1;
	_locked = _c getVariable ["brpvp_locked",false];
	_isWestSoldier = _c getVariable ["brpvp_loot_protected",false];
	_retorno = !((_isLockUnlock && !_locked) || {!_isLockUnlock && ((_canAccess || _c isKindOf "CAManBase") && !_isWestSoldier)});
	if (_retorno) then {
		if (_isLockUnlock) then {
			[localize "str_no_access_locked",0] call BRPVP_hint;
		} else {
			if (_isWestSoldier) then {
				[localize "str_cant_access_west_ai"] call BRPVP_hint;
			} else {
				[localize "str_no_access",0] call BRPVP_hint;
			};
		};
	} else {
		_mags = (getMagazineCargo _c) select 0;
		BRPVP_hasFlare = "FlareWhite_F" in _mags || "FlareYellow_F" in _mags;
	};
	_retorno
}];
player addEventHandler ["InventoryClosed",{
	if (BRPVP_hasFlare) then {
		BRPVP_hasFlare = false;
		[localize "str_flares_tip",6,15,989] call BRPVP_hint;
	};
}];

diag_log "[BRPVP FILE] playerEH.sqf END REACHED";