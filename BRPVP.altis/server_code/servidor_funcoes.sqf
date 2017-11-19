/*
BRPVP_missionWestGroups = [];
{
	{
		_unitsCfg = "true" configClasses _x;
		_groupInfo = [];
		{
			_model = getText (_x >> "vehicle");
			_rank = getText (_x >> "rank");
			_groupInfo append [[_model,_rank]];
		} forEach _unitsCfg;
		BRPVP_missionWestGroups append [_groupInfo];
		diag_log ("INFANTRY GROUPS FOR MISSIONS" + str [_groupInfo]);
	} forEach ("true" configClasses _x);
} forEach [
	(configFile >> "CfgGroups" >> "West" >> "BLU_CTRG_F" >> "Infantry"),
	(configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry"),
	(configFile >> "CfgGroups" >> "West" >> "BLU_T_F" >> "Infantry")
];
*/
BRPVP_missionWestGroups = [
	["B_CTRG_Soldier_TL_tna_F","B_CTRG_Soldier_M_tna_F","B_CTRG_Soldier_Medic_tna_F","B_CTRG_Soldier_tna_F","B_CTRG_Soldier_LAT_tna_F","B_CTRG_Soldier_JTAC_tna_F","B_CTRG_Soldier_Exp_tna_F","B_CTRG_Soldier_AR_tna_F"],
	["B_soldier_SL_F","B_soldier_F","B_soldier_LAT_F","B_soldier_M_F","B_soldier_TL_F","B_soldier_AR_F","B_soldier_A_F","B_medic_F"],
	["B_soldier_SL_F","B_soldier_AR_F","B_soldier_GL_F","B_soldier_M_F","B_soldier_AT_F","B_soldier_AAT_F","B_soldier_A_F","B_medic_F"],
	["B_Soldier_SL_F","B_soldier_AR_F","B_HeavyGunner_F","B_soldier_AAR_F","B_soldier_M_F","B_Sharpshooter_F","B_soldier_LAT_F","B_medic_F"],
	["B_recon_TL_F","B_recon_M_F","B_recon_medic_F","B_recon_F","B_recon_LAT_F","B_recon_JTAC_F","B_recon_exp_F","B_Recon_Sharpshooter_F"],
	["B_T_soldier_SL_F","B_T_soldier_F","B_T_soldier_LAT_F","B_T_soldier_M_F","B_T_soldier_TL_F","B_T_soldier_AR_F","B_T_soldier_A_F","B_T_medic_F"],
	["B_T_soldier_SL_F","B_T_soldier_AR_F","B_T_soldier_GL_F","B_T_soldier_M_F","B_T_soldier_AT_F","B_T_soldier_AAT_F","B_T_soldier_A_F","B_T_medic_F"],
	["B_recon_TL_F","B_recon_M_F","B_recon_medic_F","B_recon_LAT_F","B_recon_JTAC_F","B_recon_exp_F","B_sniper_F","B_spotter_F"],
	["B_T_recon_TL_F","B_T_recon_M_F","B_T_recon_medic_F","B_T_recon_LAT_F","B_T_recon_JTAC_F","B_T_recon_exp_F","B_T_sniper_F","B_T_spotter_F"],
	["B_T_recon_TL_F","B_T_recon_M_F","B_T_recon_medic_F","B_T_recon_F","B_sniper_F","B_spotter_F","B_T_sniper_F","B_T_spotter_F"],
	["B_T_soldier_TL_F","B_T_soldier_AR_F","B_T_soldier_GL_F","B_T_soldier_LAT_F","B_sniper_F","B_spotter_F","B_soldier_AAA_F","B_soldier_AAT_F"],
	["B_T_soldier_TL_F","B_T_soldier_AT_F","B_T_soldier_AT_F","B_T_soldier_AAT_F","B_sniper_F","B_spotter_F","B_soldier_AAA_F","B_soldier_AAA_F"],
	["B_T_soldier_TL_F","B_T_soldier_AA_F","B_T_soldier_AA_F","B_T_soldier_AAA_F","B_sniper_F","B_spotter_F","B_soldier_AAT_F","B_soldier_AAT_F"],
	["B_Soldier_TL_F","B_Soldier_AR_F","B_soldier_GL_F","B_soldier_LAT_F","B_sniper_F","B_spotter_F","B_soldier_AAA_F","B_soldier_AAT_F"],
	["B_Soldier_TL_F","B_soldier_AT_F","B_soldier_AT_F","B_soldier_AAT_F","B_T_sniper_F","B_T_spotter_F","B_soldier_AAA_F","B_soldier_AAA_F"],
	["B_Soldier_TL_F","B_soldier_AA_F","B_soldier_AA_F","B_soldier_AAA_F","B_T_sniper_F","B_T_spotter_F","B_soldier_AAT_F","B_soldier_AAT_F"],
	["B_recon_TL_F","B_recon_M_F","B_recon_medic_F","B_recon_F","B_T_sniper_F","B_T_spotter_F","B_soldier_AAA_F","B_soldier_AAT_F"],
	["B_CTRG_Soldier_TL_tna_F","B_CTRG_Soldier_AR_tna_F","B_CTRG_Soldier_tna_F","B_CTRG_Soldier_LAT_tna_F","B_T_sniper_F","B_T_spotter_F","B_soldier_AAA_F","B_soldier_AAT_F"],
	["B_soldier_GL_F","B_soldier_F","B_CTRG_Soldier_JTAC_tna_F","B_CTRG_Soldier_tna_F","B_T_recon_M_F","B_T_recon_F","B_T_sniper_F","B_T_spotter_F"],
	["B_T_soldier_GL_F","B_T_soldier_F","B_recon_M_F","B_recon_F","B_sniper_F","B_spotter_F","B_T_sniper_F","B_T_spotter_F"]
];
BRPVP_sendObjectOwnerNameFromDB = {
	params ["_obj","_player"];
	_key = format ["0:%1:getObjectOwnerName:%2",BRPVP_protocolo,_obj getVariable "own"];
	_resultado = "extDB3" callExtension _key;
	if (_resultado == "[1,[]]") then {
		BRPVP_sendObjectOwnerNameFromDBReturn = "no_name";
	} else {
		BRPVP_sendObjectOwnerNameFromDBReturn = (call compile _resultado) select 1 select 0 select 0;
	};
	if (local _player) then {
		BRPVP_sendObjectOwnerNameFromDBReturn
	} else {
		(owner _player) publicVariableClient "BRPVP_sendObjectOwnerNameFromDBReturn";
	};
};
BRPVP_totalTurretGroups = 0;
BRPVP_turretCycleTime = 3;
BRPVP_autoTurretDied = [];
BRPVP_setTurretOperator = {
	private ["_group"];
	if (!local _this) then {_this setOwner 2;};
	_this addEventHandler ["HandleDamage",{0}];
	_typeOf = typeOf _this;

	//CREATE GROUP
	_array = BRPVP_autoDefenseTurretList apply {[_this distance _x,_x]};
	_array sort true;
	if (count _array > 0 && {_array select 0 select 0 < 70}) then {
		_group = group (_array select 0 select 1);
	} else {
		_group = createGroup [INDEPENDENT,true];
		BRPVP_totalTurretGroups = BRPVP_totalTurretGroups + 1;
		if (BRPVP_totalTurretGroups mod 5 == 0) then {
			diag_log ("[BRPVP Turret Groups] T-Groups = " + str BRPVP_totalTurretGroups);
		};
	};

	//CREATE TURRET OPERATOR
	_operator = _group createUnit ["C_man_sport_1_F_afro",BRPVP_spawnAIFirstPos,[],5,"CAN_COLLIDE"];
	_operator call BRPVP_pelaUnidade;
	_operator moveInTurret [_this,[0]];
	_operator setCaptive true;

	//DISABLE AI FEATURES
	_operator forceAddUniform "U_B_Soldier_VR";
	_operator disableAI "AUTOTARGET";
	_operator disableAI "FSM";
	_operator disableAI "SUPPRESSION";
	_operator disableAI "COVER";
	_operator disableAI "AUTOCOMBAT";
	_operator disableAI "PATH";
	_operator disableAI "TARGET";
	_operator disableAI "MOVE";
	_operator disableAI "ANIM";

	//ARM OPERATOR IN CASE THE TURRET GET DISABLED
	_weapon = BRPVP_autoTurretTypesOnFoot select (BRPVP_autoTurretTypes find _typeOf);
	_operator setVariable ["brpvp_weapon",_weapon];
	_operator addBackPack "C_Bergen_grn";
	_operator addMagazine (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0);
	_operator addWeapon _weapon;

	//HANDLE DAMAGE ON TURRET OPERATOR
	_operator setVariable ["brpvp_hurtTime",0,false];
	_operator addEventHandler ["HandleDamage",{
		_operator = _this select 0;
		if !(_operator getVariable "brpvp_dead") then {
			_attacker = _this select 6;
			if (isPlayer _attacker) then {
				_part = _this select 1;
				if (_part == "head") then {
					_damage = _this select 2;
					if (_damage > 0) then {
						_dmg = ((_operator getVariable "brpvp_damage") + _damage) min BRPVP_turretHeadDamageToDie;
						_operator setVariable ["brpvp_damage",_dmg,false];
						BRPVP_hintEmMassa = [["str_turret_brain_damage",[round (100*_dmg/BRPVP_turretHeadDamageToDie)]],0,200,0,"eletric_spark"];
						if (owner _attacker == BRPVP_playerOwner) then {["",BRPVP_hintEmMassa] call BRPVP_hintEmMassaFnc;} else {(owner _attacker) publicVariableClient "BRPVP_hintEmMassa"};
						if (_dmg == BRPVP_turretHeadDamageToDie) then {
							_operator setVariable ["brpvp_dead",true,true];
							BRPVP_autoTurretDied pushBack _operator;
						};
					};
				};
				if !(_operator getVariable "brpvp_dead") then {
					_time = time;
					if (_time - (_operator getVariable "brpvp_hurtTime") > 1) then {
						BRPVP_turretShotOn = _operator getVariable "brpvp_turret";
						(owner _attacker) publicVariableClient "BRPVP_turretShotOn";
						_operator setVariable ["brpvp_hurtTime",_time,false];
					};
				};
			};
		};
		_return = 0;
		_return
	}];

	//TURRET REARM PROCESS
	_this setVariable ["brpvp_shots",0,false];
	if (_typeOf in ["I_HMG_01_high_F","I_HMG_01_F"]) then {
		_this setVariable ["brpvp_maxshots",50,false];
	} else {
		_this setVariable ["brpvp_maxshots",4,false];
	};
	_this addEventHandler ["Fired",{
		_turret = _this select 0;
		_turretShots = _turret getVariable "brpvp_shots";
		if (_turretShots == (_turret getVariable "brpvp_maxshots") - 1) then {
			_turret setVariable ["brpvp_shots",0,false];
			_turret setVehicleAmmo 1;
		} else {
			_turret setVariable ["brpvp_shots",_turretShots + 1,false];
		};
	}];
	
	//SET OPERATORS EVENT HANDLER
	_operator addEventHandler ["Fired",{
		_operator = _this select 0;
		_weapon = _operator getVariable "brpvp_weapon";
		if (_operator ammo _weapon == 0) then {
			_operator addMagazine (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0);
		};
	}];
	_this addEventHandler ["GetOut",{
		_operator = _this select 2;
		if (_operator getVariable ["brpvp_points",-1000] != -1000) then {
			_operator enableAI "MOVE";
			_operator enableAI "ANIM";
			_operator setBehaviour "COMBAT";
			_operator setCombatMode "YELLOW";
		};
	}];

	//OPERATOR VARS
	_operator setVariable ["brpvp_init",time - random BRPVP_turretCycleTime,false];
	_operator setVariable ["brpvp_disableTime",-1,false];
	_operator setVariable ["brpvp_target",objNull,true];
	_operator setVariable ["brpvp_points",0,true];
	_operator setVariable ["brpvp_dead",false,true];
	_operator setVariable ["brpvp_damage",0,false];
	_operator setVariable ["brpvp_last_target",objNull,false];
	_operator setVariable ["brpvp_turret",_this,true];
	_this setVariable ["brpvp_operator",_operator,true];
	
	//ADD TO TURRET SERVER ARRAY
	BRPVP_autoDefenseTurretList pushBack _operator;
	
	//DISABLE SIMULATION
	_operator enableSimulationGlobal false;
	_this enableSimulationGlobal false;
};
BRPVP_zombiePlayersProximity = {
	params ["_unit","_distances"];
	_distAlive = _distances select 0;
	_distDead = _distances select 1;
	_playerNear = false;
	_dist = if (alive _unit) then {_distAlive} else {_distDead};
	{
		if (_unit distanceSqr _x < _dist) exitWith {
			_playerNear = true;
		};
	} forEach allPlayers;
	_playerNear
};
BRPVP_carroBotGetIn = {
	_unid = _this select 2;
	if (isPlayer _unid) then {
		BRPVP_hintEmMassa = [["str_temporary_vehicle",[]],0];
		if (owner _unid == BRPVP_playerOwner) then {["",BRPVP_hintEmMassa] call BRPVP_hintEmMassaFnc;} else {(owner _unid) publicVariableClient "BRPVP_hintEmMassa";};
	};
};
BRPVP_rolaMotorista = {
	_unid = _this select 0;
	_avh = assignedVehicleRole _unid;
	if (count _avh > 0) then {
		if (_avh select 0 == "DRIVER") then {
			_veiculo = assignedVehicle _unid;
			{
				_avh = assignedVehicleRole _x;
				if (count _avh > 0) then {
					_ocupacao = _avh select 0;
					if (_ocupacao == "Cargo") exitWith {_x assignAsDriver _veiculo;};
				};
			} forEach units group _unid;
		};
	};
};
BRPVP_salvarPlayerServidor = {
	_estadoPLayer = _this;
	if (BRPVP_useExtDB3) then {
		if (_this select 0 != "0") then {
			_key = format ["1:%1:savePlayer:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14:%15",BRPVP_protocolo,_estadoPLayer select 1,_estadoPLayer select 2,_estadoPLayer select 3,_estadoPLayer select 4,_estadoPLayer select 5,_estadoPLayer select 6,_estadoPLayer select 0,_estadoPLayer select 7,_estadoPLayer select 8,_estadoPLayer select 9,_estadoPLayer select 10,_estadoPlayer select 12,_estadoPlayer select 13,_estadoPlayer select 14];
			_resultado = "extDB3" callExtension _key;
			diag_log "----------------------------------------------------------------------------------";
			diag_log "---- " + (_estadoPLayer select 0);
			diag_log "---- [UPDATE PLAYER ON DB]";
			diag_log ("---- _key = " + _key + ".");
			diag_log ("---- _resultado = " + str _resultado + ".");
			diag_log "----------------------------------------------------------------------------------";
		} then {
			diag_log "----------------------------------------------------------------------------------";
			diag_log "---- " + (_estadoPLayer select 0);
			diag_log "---- [UPDATE PLAYER *FAILED*]";
			diag_log "---- NO ID!";
			diag_log "----------------------------------------------------------------------------------";
		};
	} else {
		_playerId = _estadoPLayer select 0;
		_playerIndex = (BRPVP_noExtDB3PlayersTable select 0) find _playerId;
		if (_playerIndex != -1) then {
			(BRPVP_noExtDB3PlayersTable select 1) set [_playerIndex,_estadoPLayer];
		} else {
			diag_log "[BRPVP NO-DB ERROR] TRIED TO SAVE A PLAYER WITHOUT ENTRY.";
		};
	};
};
BRPVP_salvarPlayerVaultServidor = {
	_estadoVault = _this select 0;
	_vaultIdx = _this select 1;
	if (BRPVP_useExtDB3) then {
		if (typeName (_estadoVault select 0) == "string") then {
			_key = format ["1:%1:saveVault:%2:%3:%4:%5",BRPVP_protocolo,_estadoVault select 0,_estadoVault select 1,_estadoVault select 2,_vaultIdx];
			_resultado = "extDB3" callExtension _key;
			diag_log "----------------------------------------------------------------------------------";
			diag_log "---- " + (_estadoVault select 0);
			diag_log ("---- [UPDATE VAULT ON DB IDX = " + str _vaultIdx + "]");
			diag_log ("---- _key = " + _key + ".");
			diag_log ("---- _resultado = " + str _resultado + ".");
			diag_log "----------------------------------------------------------------------------------";
		} then {
			diag_log "----------------------------------------------------------------------------------";
			diag_log "---- " + (_estadoVault select 0);
			diag_log ("---- [UPDATE VAULT *FAILED* IDX = " + str _vaultIdx + "]");
			diag_log "---- NO ID!";
			diag_log "----------------------------------------------------------------------------------";	
		};
	} else {
		_ownerIdx = (BRPVP_noExtDB3VaultTable select _vaultIdx select 0) find (_estadoVault select 0);
		if (_ownerIdx != -1) then {
			(BRPVP_noExtDB3VaultTable select _vaultIdx select 1) set [_ownerIdx,_estadoVault];
		} else {
			diag_log "[BRPVP NO-DB ERROR] TRIED TO SAVE A VAULT WITHOUT ENTRY.";
		};
	};
};
BRPVP_pegaEstadoPlayer = {
	_player = _this;
	
	//ARMAS (P,S,G)
	_armaPriNome = primaryWeapon _player;
	_armaSecNome = secondaryWeapon _player;
	_armaGunNome = handGunWeapon _player;
	
	//ARMAS ASSIGNED
	_aPI = primaryWeaponItems _player;
	_aSI = secondaryWeaponItems _player;
	_aGI = handGunItems _player;
	
	//CONTAINERS
	_backPackName = backpack _player;
	_vestName = vest _player;
	_uniformName = uniform _player;
	
	//APETRECHOS
	_capacete = headGear _player;
	_oculos = goggles _player;
	
	//SAUDE
	_hpd = getAllHitPointsDamage _player;
	
	//PLAYERS CONTAINERS
	_bpc = backpackContainer _player;
	_vtc = vestContainer _player;
	_ufc = uniformContainer _player;
	
	//PLAYERS CONTAINERS MAGAZINES AMMO
	if (!isNull _bpc) then {_bpc = magazinesAmmoCargo _bpc;} else {_bpc = [];};
	if (!isNull _vtc) then {_vtc = magazinesAmmoCargo _vtc;} else {_vtc = [];};
	if (!isNull _ufc) then {_ufc = magazinesAmmoCargo _ufc;} else {_ufc = [];};
		
	//ESTADO _player
	[
		//ID DO _player
		_player getVariable ["id","0"],
		//ARMAS E ASSIGNED ITEMS
		[
			assignedItems _player,
			[_armaPriNome,_aPI,primaryWeaponMagazine _player],
			[_armaSecNome,_aSI,secondaryWeaponMagazine _player],
			[_armaGunNome,_aGI,handGunMagazine _player],
			_player getVariable ["owt",[]]
		],
		//CONTAINERS (BACKPACK, VEST, UNIFORME)
		[
			[_backpackName,[getWeaponCargo backpackContainer _player,getItemCargo backpackContainer _player,_bpc]],
			[_vestName,[getWeaponCargo vestContainer _player,getItemCargo vestContainer _player,_vtc]],
			[_uniformName,[getWeaponCargo uniformContainer _player,getItemCargo uniformContainer _player,_ufc]]
		],
		//DIRECAO E POSICAO
		[getDir _player,getPosWorld _player],
		//SAUDE
		[[_hpd select 1,_hpd select 2],_player getVariable ["sud",[100,100]],damage _player],
		//MODELO E APETRECHOS
		[typeOf _player,_capacete,_oculos],
		//ARMA NA MAO
		currentWeapon _player,
		//AMIGOS
		_player getVariable ["amg",[]],
		//VIVO OU MORTO
		if (alive _player) then {1} else {0},
		//EXPERIENCIA
		_player getVariable ["exp",BRPVP_experienciaZerada],
		//DEFAULT SHARE TYPE
		_player getVariable ["stp",1],
		//PLAYER ID BD
		_player getVariable ["id_bd",-1],
		//PLAYER MONEY
		_player getVariable ["mny",0],
		//SPECIAL ITEMS
		_player getVariable ["sit",[]],
		//PLAYER MONEY ON BANK
		_player getVariable ["brpvp_mny_bank",0]
	]
};
BRPVP_salvaVeiculo = {
	private ["_type","_magas","_mochi","_itens","_conts","_weaponsItemsCargo"];
	_id_bd = _this getVariable ["id_bd",-1];
	_carroVivo = alive _this;
	if (_id_bd != -1 && _carroVivo) then {
		_type = typeOf _this;
		_cM = getNumber (configFile >> "CfgVehicles" >> _type >> "transportMaxMagazines") > 0;
		_cB = getNumber (configFile >> "CfgVehicles" >> _type >> "transportMaxBackpacks") > 0;
		_cW = getNumber (configFile >> "CfgVehicles" >> _type >> "transportMaxWeapons") > 0;
		_armas = [[],[]];
		if (_cM) then {_magas = magazinesAmmoCargo _this;} else {_magas = [];};
		if (_cB) then {_mochi = getBackpackCargo _this;} else {_mochi = [[],[]];};
		if (_cW) then {_itens = getItemCargo _this;} else {_itens = [[],[]];};
		if (_cB || _cW) then {_conts = everyContainer _this;} else {_conts = [];};
		if (_cW) then {_weaponsItemsCargo = weaponsItemsCargo _this;} else {_weaponsItemsCargo = [];};

		_check = [];
		_checkRemove = [];
		_conts = _conts apply {
			if (_x select 1 in _check) then {
				_checkRemove pushBack (_x select 0);
				-1
			} else {
				_check pushBack (_x select 1);
				_x
			};
		};
		_conts = _conts - [-1];
		{
			_idx = (_mochi select 0) find _x;
			if (_idx != -1) then {
				_quantity = _mochi select 1 select _idx;
				if (_quantity == 1) then {
					(_mochi select 0) deleteAt _idx;
					(_mochi select 1) deleteAt _idx;
				} else {
					(_mochi select 1) set [_idx,_quantity - 1];
				};
			};
		} forEach _checkRemove;

		{_weaponsItemsCargo append (weaponsItemsCargo (_x select 1));} forEach _conts;
		{
			_arma = _x;
			{
				if (_forEachIndex == 0) then {
					_armas = [_armas,_x call BIS_fnc_baseWeapon] call BRPVP_adicCargo;
				} else {
					if (typeName _x == "ARRAY") then {if (count _x > 0) then {_magas pushBack _x;};};
					if (typeName _x == "STRING") then {if (_x != "" && _forEachIndex != 5) then {_itens = [_itens,_x] call BRPVP_adicCargo;};};
				};
			} forEach _arma;
		} forEach _weaponsItemsCargo;
		{
			_cont = _x select 1;
			_magas append magazinesAmmoCargo _cont;
			_itensC = getItemCargo _cont;
			{
				_qt = _itensC select 1 select _forEachIndex;
				for "_i" from 1 to _qt do {_itens = [_itens,_x] call BRPVP_adicCargo;};
			} forEach (_itensC select 0);
		} forEach _conts;
		_armas set [0,(_armas select 0) apply {_i = BRPVP_ItemsClassToNumberTableA find _x; if (_i isEqualTo -1) then {_x} else {_i};}];
		_magas = _magas apply {_i = BRPVP_ItemsClassToNumberTableB find (_x select 0); if (_i isEqualTo -1) then {_x} else {[_i,_x select 1]};};
		_itens set [0,(_itens select 0) apply {_i = BRPVP_ItemsClassToNumberTableC find _x; if (_i isEqualTo -1) then {_x} else {_i};}];
		_mochi set [0,(_mochi select 0) apply {_i = BRPVP_ItemsClassToNumberTableD find _x; if (_i isEqualTo -1) then {_x} else {_i};}];
		_estadoCarro = [
			[_armas,_magas,_itens,_mochi],
			[getPosWorld _this,[vectorDir _this,vectorUp _this]],
			typeOf _this,
			_this getVariable ["own",-1],
			_this getVariable ["stp",1],
			_this getVariable ["amg",[]],
			_this getVariable ["mapa",false],
			_this getVariable ["brpvp_locked",false]
		];
		if (BRPVP_useExtDB3) then {
			_key = format ["1:%1:saveVehicle:%2:%3:%4:%5:%6:%7:%8:%9:%10",BRPVP_protocolo,_estadoCarro select 0,_estadoCarro select 1,_estadoCarro select 2,_estadoCarro select 3,_estadoCarro select 4,_estadoCarro select 5,_estadoCarro select 6,if (_estadoCarro select 7) then {1} else {0},_id_bd];
			_resultado = "extDB3" callExtension _key;
			diag_log "----------------------------------------------------------------------------------";
			diag_log ("[BRPVP] UPDATE VEHICLE: _key = " + str _key + ".");
			diag_log ("[BRPVP] UPDATE VEHICLE: _resultado = " + str _resultado + ".");
			diag_log "----------------------------------------------------------------------------------";
		} else {
			_vehicleIndex = (BRPVP_noExtDB3VehiclesTable select 0) find _id_bd;
			if (_vehicleIndex != -1) then {
				_exec = BRPVP_noExtDB3VehiclesTable select 1 select _vehicleIndex select 6;
				_mapa = _estadoCarro select 6;
				_estadoCarro set [6,_exec];
				(BRPVP_noExtDB3VehiclesTable select 1) set [_vehicleIndex,_estadoCarro];
				(BRPVP_noExtDB3VehiclesTable select 2) set [_vehicleIndex,_mapa];
			} else {
				diag_log "[BRPVP NO-DB ERROR] TRIED TO SAVE A VEHICLE THAT HAS NO ENTRY.";
			};
		};
	};
};
BRPVP_salvaVeiculoAmg = {
	_id_bd = _this getVariable ["id_bd",-1];
	_carroVivo = alive _this;
	if (_id_bd != -1 && _carroVivo) then {
		if (BRPVP_useExtDB3) then {
			_key = format ["1:%1:saveVehicleAmg:%2:%3:%4:%5",BRPVP_protocolo,_this getVariable ["own",-1],_this getVariable ["stp",1],_this getVariable ["amg",[]],_id_bd];
			_resultado = "extDB3" callExtension _key;
			diag_log "----------------------------------------------------------------------------------";
			diag_log ("[BRPVP] UPDATE VEHICLE FRIENDS: _key = " + str _key + ".");
			diag_log ("[BRPVP] UPDATE VEHICLE FRIENDS: _resultado = " + str _resultado + ".");
			diag_log "----------------------------------------------------------------------------------";
		} else {
			_vehicleIndex = (BRPVP_noExtDB3VehiclesTable select 0) find _id_bd;
			if (_vehicleIndex != -1) then {
				(BRPVP_noExtDB3VehiclesTable select 1 select _vehicleIndex) set [3,_this getVariable ["own",-1]];
				(BRPVP_noExtDB3VehiclesTable select 1 select _vehicleIndex) set [4,_this getVariable ["stp",1]];
				(BRPVP_noExtDB3VehiclesTable select 1 select _vehicleIndex) set [5,_this getVariable ["amg",[]]];
			} else {
				diag_log "[BRPVP NO-DB ERROR] TRIED TO CHANGE OWN, STP AND AMG ON A VEHICLE WITH NO ENTRY.";
			};
		};
	};
};
BRPVP_saveVehicleLock = {
	_id_bd = _this getVariable ["id_bd",-1];
	_carroVivo = alive _this;
	if (_id_bd != -1 && _carroVivo) then {
		if (BRPVP_useExtDB3) then {
			_key = format ["1:%1:saveVehicleLock:%2:%3",BRPVP_protocolo,if(_this getVariable ["brpvp_locked",false]) then {1} else {0},_id_bd];
			_resultado = "extDB3" callExtension _key;
			diag_log "----------------------------------------------------------------------------------";
			diag_log ("[BRPVP] UPDATE VEHICLE LOCK: _key = " + str _key + ".");
			diag_log ("[BRPVP] UPDATE VEHICLE LOCK: _resultado = " + str _resultado + ".");
			diag_log "----------------------------------------------------------------------------------";
		} else {
			_vehicleIndex = (BRPVP_noExtDB3VehiclesTable select 0) find _id_bd;
			if (_vehicleIndex != -1) then {
				(BRPVP_noExtDB3VehiclesTable select 1 select _vehicleIndex) set [8,_this getVariable ["brpvp_locked",false]];
			} else {
				diag_log "[BRPVP NO-DB ERROR] TRIED TO CHANGE LOCK ON A VEHICLE WITH NO ENTRY.";
			};
		};
	};
};
BRPVP_salvaVault = {
	params ["_p","_del"];
	private ["_vt","_sr","_v"];
	_vt = _p getVariable ["wh",objNull];
	_sr = _p getVariable ["sr",objNull];
	_allReceptacles = [
		[_vt,0],
		[_sr,_sr getVariable ["bidx",-1]]
	];
	{
		_v = _x select 0;
		_idx = _x select 1;
		if (!isNull _v) then {
			_armas = [[],[]];
			_magas = magazinesAmmoCargo _v;
			_mochi = getBackpackCargo _v;
			_itens = getItemCargo _v;
			_conts = everyContainer _v;

			_check = [];
			_checkRemove = [];
			_conts = _conts apply {
				if (_x select 1 in _check) then {
					_checkRemove pushBack (_x select 0);
					-1
				} else {
					_check pushBack (_x select 1);
					_x
				};
			};
			_conts = _conts - [-1];
			{
				_idx = (_mochi select 0) find _x;
				if (_idx != -1) then {
					_quantity = _mochi select 1 select _idx;
					if (_quantity == 1) then {
						(_mochi select 0) deleteAt _idx;
						(_mochi select 1) deleteAt _idx;
					} else {
						(_mochi select 1) set [_idx,_quantity - 1];
					};
				};
			} forEach _checkRemove;

			_weaponsItemsCargo = weaponsItemsCargo _v;
			{_weaponsItemsCargo append (weaponsItemsCargo (_x select 1));} forEach _conts;
			{
				_arma = _x;
				{
					if (_forEachIndex == 0) then {
						_armas = [_armas,_x call BIS_fnc_baseWeapon] call BRPVP_adicCargo;
					} else {
						if (typeName _x == "ARRAY") then {if (count _x > 0) then {_magas pushBack _x;};};
						if (typeName _x == "STRING") then {if (_x != "" && _forEachIndex != 5) then {_itens = [_itens,_x] call BRPVP_adicCargo;};};
					};
				} forEach _arma;
			} forEach _weaponsItemsCargo;
			{
				_cont = _x select 1;
				_magas append magazinesAmmoCargo _cont;
				_itensC = getItemCargo _cont;
				{
					_qt = _itensC select 1 select _forEachIndex;
					for "_i" from 1 to _qt do {_itens = [_itens,_x] call BRPVP_adicCargo;};
				} forEach (_itensC select 0);
			} forEach _conts;
			_estadoVault = [
				_p getVariable ["id","0"],
				[_armas,_magas,_mochi,_itens],
				//_p getVariable ["stp",1]
				1
			];
			[_estadoVault,_idx] call BRPVP_salvarPlayerVaultServidor;
			diag_log ("[BRPVP VAULT] VAULT MASS/LOGOFF SAVE IDX = " + str _idx + " (" + name _p + "): " + str _estadoVault);
		};
	} forEach _allReceptacles;
	if (_del) then {
		deleteVehicle _vt;
		deleteVehicle _sr;
	};
};
BRPVP_veiculoMorreu = {
	//REMOVE VEHICLE FROM DATA BASE
	_veiculoId = _this getVariable ["id_bd",-1];
	if (_veiculoId >= 0) then {
		_typeOf = typeOf _this;
		if !(_this call BRPVP_isMotorized) then {
			BRPVP_ownedHouses = BRPVP_ownedHouses - [_this];
		};
		if (BRPVP_useExtDB3) then {
			_key = format ["1:%1:deleteVehicle:%2",BRPVP_protocolo,_veiculoId];
			_resultado = "extDB3" callExtension _key;
			diag_log "----------------------------------------------------------------------------------";
			diag_log ("VEHICLE DESTROYED: " + _typeOf + ". POSICAO: " + str getPos _this + ".");
			diag_log ("[BRPVP] DELETE VEHICLE: _key = " + str _key + ".");
			diag_log ("[BRPVP] DELETE VEHICLE: _resultado = " + str _resultado + ".");
			diag_log "----------------------------------------------------------------------------------";
		} else {
			_vehicleIndex = (BRPVP_noExtDB3VehiclesTable select 0) find _veiculoId;
			if (_vehicleIndex != -1) then {
				(BRPVP_noExtDB3VehiclesTable select 0) deleteAt _vehicleIndex;
				(BRPVP_noExtDB3VehiclesTable select 1) deleteAt _vehicleIndex;
				(BRPVP_noExtDB3VehiclesTable select 2) deleteAt _vehicleIndex;
			} else {
				diag_log "[BRPVP NO-DB ERROR] TRIED TO CHANGE OWN, STP AND AMG ON A VEHICLE WITH NO ENTRY.";
			};
		};
		_this setVariable ["id_bd",-1,true];
	};
};
BRPVP_botKillLoot = {
	private ["_aI","_iI"];
	_aI = assignedItems _this;
	{
		if (_x in _aI) then {_this unassignItem _x;};
		_iI = items _this;
		if (_x in _iI) then {_this removeItems _x;};
	} forEach BRPVP_botKillRemove;
};
BRPVP_addAIonCleanProcess = [];
BRPVP_botDaExp = {
	params ["_bot","_matador"];
	_bot setVariable ["dd",1,true];
	_bot call BRPVP_botKillLoot;
	_crew = [];
	if (_matador call BRPVP_isMotorized) then {
		{if (isPlayer _x) then {_crew pushBack _x;};} forEach crew _matador;
		_matador = effectiveCommander _matador;
	} else {
		_crew = [_matador];
	};
	
	//GIVE EXPERIENCE
	if (isPlayer _matador) then {
		if (_bot getVariable ["isz",false]) then {
			diag_log ("[BRPVP ZOMBIE Killed-EH] _matador = " + name _matador);
		} else {
			diag_log ("[BRPVP AI Killed-EH] _matador = " + name _matador);
			BRPVP_mudaExpPedidoServidor = [["matou_bot",1]];
			if (owner _matador == BRPVP_playerOwner) then {["",BRPVP_mudaExpPedidoServidor] call BRPVP_mudaExpPedidoServidorFnc;} else {(owner _matador) publicVariableClient "BRPVP_mudaExpPedidoServidor";};
		};
	};
	
	//GIVE MONEY
	_countCrew = count _crew;
	if (_countCrew > 0) then {
		BRPVP_giveMoney = 400 + random 400;
		BRPVP_giveMoney = [round (BRPVP_giveMoney/(sqrt _countCrew)),"mny"];
		{if (owner _x == BRPVP_playerOwner) then {["",BRPVP_giveMoney] call BRPVP_giveMoneyFnc;} else {(owner _x) publicVariableClient "BRPVP_giveMoney";};} forEach _crew;
		_bot setVariable ["dtm",time,false];
		BRPVP_addAIonCleanProcess pushBack _bot;
	};

	//PROTECT WEAPONS
	if (_bot getVariable ["brpvp_loot_protected",false]) then {
		_holder = objNull;
		_weapPri = primaryWeapon _bot;
		_posBot = getPosASL _bot;
		_h = (((eyePos _bot) select 2) - (_posBot select 2) - 0.4) max 0;
		if (_weapPri != "") then {
			_whPos = ([(ASLToAGL _posBot),1,getDir _bot] call BIS_fnc_relPos) vectorAdd [0,0,_h];
			_holder = createVehicle ["WeaponHolderSimulated",_whPos,[],0,"CAN_COLLIDE"];
			_bot removeWeapon _weapPri;
			_holder addWeaponCargoGlobal [_weapPri,1];
			
		};
		_weapSec = secondaryWeapon _bot;
		if (_weapSec != "") then {
			_whPos = ([(ASLToAGL _posBot),-1,getDir _bot] call BIS_fnc_relPos) vectorAdd [0,0,_h];
			if (isNull _holder) then {_holder = createVehicle ["WeaponHolderSimulated",_whPos,[],0,"CAN_COLLIDE"];};
			_bot removeWeapon _weapSec;
			_holder addWeaponCargoGlobal [_weapSec,1];
		};
		if !(isNull _holder) then {
			_holder setVariable ["brpvp_loot_protected",true,true];
			_bot setVariable ["brpvp_del_on_clean",_holder,false];
		};
	};
};
BRPVP_salvaEmMassaPlayers = {
	diag_log "********************* MASS SAVE *PLAYERS* ************************";
	{
		if (alive _x) then {
			if (_x getVariable ["sok",false]) then {
				(_x call BRPVP_pegaEstadoPlayer) call BRPVP_salvarPlayerServidor;
				[_x,false] call BRPVP_salvaVault;
			};
		};
	} forEach allPlayers;
	diag_log "******************* MASS SAVE END *PLAYERS* **********************";
};
BRPVP_salvaEmMassaVeiculos = {
	diag_log "********************* MASS SAVE *VEHICLES* ***********************";
	_contaSLV = 0;
	_contaAch = 0;
	{
		_contaAch = _contaAch + 1;
		if (_x getVariable ["slv",false]) then {
			_contaSLV = _contaSLV + 1;
			_x call BRPVP_salvaVeiculo;
			if (count crew _x == 0) then {_x setVariable ["slv",false,true];};
		} else {
			if (_x getVariable ["slv_amg",false]) then {
				_x call BRPVP_salvaVeiculoAmg;
				_x setVariable ["slv_amg",false,true];
			};
			if (_x getVariable ["brpvp_slv_lck",false]) then {
				_x call BRPVP_saveVehicleLock;
				_x setVariable ["brpvp_slv_lck",false,true];
			};
		};
	} forEach (BRPVP_centroMapa nearEntities[["LandVehicle","Air","Ship"],20000]);
	{
		_contaAch = _contaAch  +1;
		if (_x getVariable ["slv",false]) then {
			_contaSLV = _contaSLV + 1;
			_x call BRPVP_salvaVeiculo;
			_x setVariable ["slv",false,true];
		} else {
			if (_x getVariable ["slv_amg",false]) then {
				_x call BRPVP_salvaVeiculoAmg;
				_x setVariable ["slv_amg",false,true];
			};
		};
	} forEach BRPVP_ownedHouses;
	diag_log ("[" + str _contaAch + " VEHICLES FOUND / " + str _contaSLV + " VEHICLES SAVED!]");
	diag_log "******************* MASS SAVE END *VEHICLES* *********************";
};
BRPVP_salvaEmMassa = {
	call BRPVP_salvaEmMassaPlayers;
	call BRPVP_salvaEmMassaVeiculos;
};
BRPVP_daComoMorto = {
	if (BRPVP_useExtDB3) then {
		if (_this select 0 != "0") then {
			_key = format ["1:%1:playerSetLife:%2:%3",BRPVP_protocolo,_this select 0,_this select 1];
			_resultado = "extDB3" callExtension _key;
			diag_log "----------------------------------------------------------------------------------";
			diag_log "---- " + (_this select 0);
			diag_log ("---- [CHANGE PLAYER LIFE STATE " + str (_this select 1) + "]");
			diag_log ("---- _key = " + _key + ".");
			diag_log ("---- _resultado = " + str _resultado + ".");
			diag_log "----------------------------------------------------------------------------------";
		} then {
			diag_log "----------------------------------------------------------------------------------";
			diag_log "---- " + (_this select 0);
			diag_log "---- [CHANGE PLAYER LIFE STATE " + str (_this select 1) + " *FAILED*]";
			diag_log "---- NO ID!";
			diag_log "----------------------------------------------------------------------------------";
		};
	} else {
		_playerId = _this select 0;
		_playerIndex = (BRPVP_noExtDB3PlayersTable select 0) find _playerId;
		if (_playerIndex != -1) then {
			(BRPVP_noExtDB3PlayersTable select 1 select _playerIndex) set [8,_this select 1];
		} else {
			diag_log "[BRPVP NO-DB ERROR] TRIED TO SET LIFE STATE ON A PLAYER WITHOUT ENTRY.";
		};
	};
};
BRPVP_botDano = {
	private ["_dano","_unid","_dist","_danoNovo","_ucdp","_minDist"];
	_dano = _this select 0;
	_unid = _this select 1;
	_ucdp = _unid getVariable ["ucdp",-BRPVP_distPlayerParaDanBotTimer];
	_danoNovo = 0;
	if (time - _ucdp > BRPVP_distPlayerParaDanBotTimer) then {
		_unid setVariable ["ucdp",time,false];
		_nearPlayers = _unid nearEntities [BRPVP_playerModel,BRPVP_distPlayerParaDanBot];
		_danoMlt = 0;
		if (count _nearPlayers > 0) then {
			_danoMlt = 1;
		} else {
			{
				if (_x distance _unid < BRPVP_distPlayerParaDanBot) exitWith {_danoMlt = 1;};
			} forEach BRPVP_playerVehicles;
		};
		_danoNovo = _dano * _danoMlt;
		_unid setVariable ["dnm",_danoMlt,false];
	} else {
		_danoNovo = _dano * (_unid getVariable "dnm");
	};
	_danoNovo
};
BRPVP_hdEh = {
	_unid = _this select 0;
	_dano = _this select 2;
	_atacante = _this select 3;
	if (_atacante call BRPVP_isMotorized) then {
		_atacante = effectiveCommander _atacante;
	};	
	if (!isPlayer _atacante) then {
		_dano = [_dano,_unid] call BRPVP_botDano;
	} else {
		if (_this select 1 == "head") then {
			_danoAntigo = _unid getHit "head";
			_delta = _dano - _danoAntigo;
			if (_danoAntigo < 0.9 && _delta >= 0.9) then {
				BRPVP_mudaExpPedidoServidor = [["deu_tiro_cabeca_bot",1]];
				if (owner _atacante == BRPVP_playerOwner) then {["",BRPVP_mudaExpPedidoServidor] call BRPVP_mudaExpPedidoServidorFnc;} else {(owner _atacante) publicVariableClient "BRPVP_mudaExpPedidoServidor";};
			};
		};
	};
	_dano
};
BRPVP_hdEhVeiculo = {
	_veiculo = _this select 0;
	_dano = 0;
	_atacante = _this select 3;
	if (isPlayer _atacante) then {
		_dano = _this select 2;
	} else {
		if (_atacante call BRPVP_isMotorized) then {
			_temPlayer = false;
			{if (isPlayer _x) exitWith {_temPlayer = true;};} forEach crew _atacante;
			if (_temPlayer) then {_dano = _this select 2;};
		};
	};
	_dano
};
BRPVP_veiculoEhReset = {
	_this addMPEventHandler ["MPKilled",{_this call BRPVP_MPKilled;}];
	if (_this call BRPVP_isMotorized) then {
		[_this,["HandleDamage",{_this call BRPVP_HandleDamage;}]] remoteExec ["addEventHandler",0,true];
	};
};
BRPVP_achaTerreno = {
	//VARIAVEIS INICIAIS
	_terr1X = [];
	_terr1XPGrd = [];
	_aI = 0;
	_bI = 0;
	_tamMapa = BRPVP_mapaDimensoes select 0;
	_tamTerr = 45;
	_gridNPts = 4;
	_gridNSeg = _tamTerr/_gridNPts;
	_agnMax = 12.5;
	_qtObjsMax = 25;
	_qtTam = floor(_tamMapa/_tamTerr);
	
	//TERRENOS UNITARIOS DE 45 X 45
	for "_a" from 1 to _qtTam do {
		for "_b" from 1 to _qtTam do {
			_posGrid = (_a-1)*_qtTam+_b;
			_posA = _aI+(_a*_tamTerr-_tamTerr/2);
			_posB = _bI+(_b*_tamTerr-_tamTerr/2);
			_angQtt = 0;
			_angSoma = 0;
			_chaoRuim = count ([_posA,_posB,0] nearroads ((_tamTerr*sqrt(2))/2)) > 0;
			if (!_chaoRuim) then {
				for "_m" from (-_tamTerr/2+_gridNSeg/2) to (_tamTerr/2-_gridNSeg/2) step _gridNSeg do {
					for "_n" from (-_tamTerr/2+_gridNSeg/2) to (_tamTerr/2-_gridNSeg/2) step _gridNSeg do {
						_posN = [_posA+_m,_posB+_n,0];
						if (surfaceIsWater _posN) exitWith {_chaoRuim = true;};
						_n = surfaceNormal _posN;
						_ang = acos (_n vectorCos [0,0,1]);
						_angSoma = _angSoma+_ang;
						_angQtt = _angQtt+1;
					};
					if (_chaoRuim) exitWith {};
				};
			};
			if !(_chaoRuim) then {
				_angMedio = _angSoma/_angQtt;
				if (_angMedio <= _agnMax) then {
					_cntr = [_posA,_posB,0];
					_builds = nearestObjects [_cntr,["Building"],_tamTerr];
					_casaPerto = false;
					{if (count (_x buildingPos -1) > 0) exitWith {_casaPerto = true;};} forEach _builds;
					if (!_casaPerto) then {
						_objs = nearestObjects [_cntr,[],_tamTerr/2];
						_qtObjs = count _objs;
						_qtIgnorar = 0;
						{
							_txt = str _x;
							if (_txt find "Bush\b_" >= 0 || _txt find "Clutter\c_" >= 0 || _txt find "Plant\p_" >= 0) then {
								_qtIgnorar = _qtIgnorar+1;
							};
						} forEach _objs;
						_qtObjs = _qtObjs-_qtIgnorar;
						if (_qtObjs <= _qtObjsMax) then {
							_terr1X pushBack [[_posA,_posB,0],_tamTerr,_angMedio,_qtObjs];
							_terr1XPGrd pushBack _posGrid;
						};
					};
				};
			};
		};
	};
	
	//TERRENOS: 90 X 90
	_excluidosBase = [];
	_multi = 2;
	_multiE2 = _multi*_multi;
	_xFix = (_multi/2-0.5)*_tamTerr;
	_yFix = _xFix;
	_tamPara = _multi*_tamTerr;
	_buscarRef = [];
	for "_m" from 0 to (_multi-1) do {
		for "_n" from 0 to (_multi-1) do {
			_buscarRef pushBack (_m*_qtTam+_n);
		};
	};
	_terrXX = [];
	{
		_posGrid = _x;
		_idcPai = _terr1XPGrd find _posGrid;
		_mod1 = _posGrid mod _qtTam;
		if !(_posGrid in _excluidosBase) then {
			_achados = 0;
			_angSoma = 0;
			_qtSoma = 0;
			_excluAgo = [];
			_idcZ = _posGrid+(_buscarRef select ((count _buscarRef)-1));
			_modZ = _idcZ mod _qtTam;
			_ok = round(((_idcZ-_modZ)-(_posGrid-_mod1))/_qtTam) == _multi-1;
			if (_ok) then {
				{
					_posGridVis = _posGrid + _x;
					_excluAgo pushBack _posGridVis;
					if !(_posGridVis in _excluidosBase) then {
						_idcG = _terr1XPGrd find _posGridVis;
						if (_idcG >= 0) then {
							_achados = _achados + 1;
							_angSoma = _angSoma + (_terr1X select _idcG select 2);
							_qtSoma = _qtSoma + (_terr1X select _idcG select 3);
						};
					};
				} forEach _buscarRef;
			};
			if (_achados == _multiE2) then {
				_pRefX = _terr1X select _idcPai select 0 select 0;
				_pRefY = _terr1X select _idcPai select 0 select 1;
				_pCentral = [_pRefX+_xFix,_pRefY+_yFix,0];
				_terrXX pushBack [_pCentral,_tamPara,_angSoma/_achados,_qtSoma/_multiE2];
				_excluidosBase append _excluAgo;
			};
		};
	} forEach _terr1XPGrd;
	{
		_idc = _terr1XPGrd find _x;
		if (_idc >= 0) then {
			_terr1X set [_idc,-1];
			_terr1XPGrd set [_idc,-1];
		};
	} forEach _excluidosBase;
	_terr1X = _terr1X - [-1];
	_terr1XPGrd = _terr1XPGrd - [-1];
	_terr2X = _terrXX;
	
	//TERRENOS: 135 X 135
	_excluidosBase = [];
	_multi = 3;
	_multiE2 = _multi*_multi;
	_xFix = (_multi/2-0.5)*_tamTerr;
	_yFix = _xFix;
	_tamPara = _multi*_tamTerr;
	_buscarRef = [];
	for "_m" from 0 to (_multi-1) do {
		for "_n" from 0 to (_multi-1) do {
			_buscarRef pushBack (_m*_qtTam+_n);
		};
	};
	_terrXX = [];
	{
		_posGrid = _x;
		_idcPai = _terr1XPGrd find _posGrid;
		_mod1 = _posGrid mod _qtTam;
		if !(_posGrid in _excluidosBase) then {
			_achados = 0;
			_angSoma = 0;
			_qtSoma = 0;
			_excluAgo = [];
			_idcZ = _posGrid+(_buscarRef select ((count _buscarRef)-1));
			_modZ = _idcZ mod _qtTam;
			_ok = round(((_idcZ-_modZ)-(_posGrid-_mod1))/_qtTam) == _multi-1;
			if (_ok) then {
				{
					_posGridVis = _posGrid + _x;
					_excluAgo pushBack _posGridVis;
					if !(_posGridVis in _excluidosBase) then {
						_idcG = _terr1XPGrd find _posGridVis;
						if (_idcG >= 0) then {
							_achados = _achados + 1;
							_angSoma = _angSoma + (_terr1X select _idcG select 2);
							_qtSoma = _qtSoma + (_terr1X select _idcG select 3);
						};
					};
				} forEach _buscarRef;
			};
			if (_achados == _multiE2) then {
				_pRefX = _terr1X select _idcPai select 0 select 0;
				_pRefY = _terr1X select _idcPai select 0 select 1;
				_pCentral = [_pRefX+_xFix,_pRefY+_yFix,0];
				_terrXX pushBack [_pCentral,_tamPara,_angSoma/_achados,_qtSoma/_multiE2];
				_excluidosBase append _excluAgo;
			};
		};
	} forEach _terr1XPGrd;
	{
		_idc = _terr1XPGrd find _x;
		if (_idc >= 0) then {
			_terr1X set [_idc,-1];
			_terr1XPGrd set [_idc,-1];
		};
	} forEach _excluidosBase;
	_terr1X = _terr1X - [-1];
	_terr1XPGrd = _terr1XPGrd - [-1];
	_terr3X = _terrXX;
	
	//MOSTRA ICONES NO MAPA
	_terrenos = [];
	_terrenos append _terr3X;
	_terrenos append _terr2X;
	_terrenos append _terr1X;
	_total = 0;
	{_total = _total+(_x select 3);} forEach _terrenos;
	_media = _total/(count _terrenos);
	_lim1 = _media*0.5;
	_lim2 = _media;
	{
		_idc1 = _forEachIndex;
		_ang = _x select 2;
		_prc1 = 3;
		if (_ang > 10 && _ang <= 15) then {_prc1 = 2;};
		if (_ang > 15 && _ang <= 20) then {_prc1 = 1;};
		_livre = _x select 3;
		_prc2 = 3;
		if (_livre > _lim1 && _livre <= _lim2) then {_prc2 = 2;};
		if (_livre > _lim2) then {_prc2 = 1;};
		_prc = _prc1*_prc2;
		_e = _x;
		_e set [count _x,_prc];
		_terrenos set [_idc1,_e];
		/*
		_cor = "ColorRed";
		if (_prc >= 3 && _prc <= 4) then {_cor = "ColorYellow";};
		if (_prc >= 6 && _prc <= 9) then {_cor = "ColorGreen";};
		_marca = createMarkerLocal ["TERR_" + str _idc1,_x select 0];
		_marca setMarkerShapeLocal "RECTANGLE";
		_marca setMarkerBrushLocal "SOLID";
		_marca setMarkerColorLocal _cor;
		_marca setMarkerSizeLocal [((_x select 1)/2)*0.925,((_x select 1)/2)*0.925];
		*/
	} forEach _terrenos;
	{diag_log str _x;} forEach _terrenos;
	BRPVP_terrenos = _terrenos;
	publicVariable "BRPVP_terrenos";
};

//MISSOENS BRAVO POINT
BRPVP_criaMissaoDePredioEspera = BRPVP_criaMissaoDePredioIdc;
BRPVP_criaMissaoDePredio = {
	if (BRPVP_criaMissaoDePredioEspera != BRPVP_criaMissaoDePredioIdc) exitWith {};
	BRPVP_criaMissaoDePredioEspera = BRPVP_criaMissaoDePredioIdc + 1;
	
	//CLASSE DOS PREDIOS ONDE PODE TER MISSAO
	_class = BRPVP_mapaRodando select 11 select 1;

	//SETA TIPO DE SPAWN DO PREDIO
	_cSDentro = BRPVP_mapaRodando select 11 select 2;
	
	//NOMES MISSAO
	_missNomes = [
		"Fargus",
		"Liberty",
		"Cascade",
		"Mancha",
		"Bravo Point",
		"Nazare",
		"Fango",
		"Dictail"
	];

	//PEGA PREDIOS NO MAPA
	if (isNil "BRPVP_bravoMissObjs") then {
		BRPVP_bravoMissObjs = [];
		{
			_buClass = _x;
			_objs = BRPVP_centroMapa nearObjects [_buClass,20000];
			{
				if (typeOf _x == _buClass) then {
					BRPVP_bravoMissObjs pushBack _x;
				};
			} forEach _objs;
		} forEach _class;
	};
		
	//ESCOLHE PREDIO E PEGA POSICOES INTERNAS
	_opcoes = [];
	_siegeLocals = [];
	{
		if (_x in [1,2]) then {
			_siegeLocals pushBack (BRPVP_locaisImportantes select _forEachIndex);
		};
	} forEach BRPVP_closedCityRunning;
	{
		_bu = _x;
		if (_bu getVariable ["msi",-1] == -1) then {
			if !(_bu getVariable ["mapa",false]) then {
				_onSiege = false;
				{
					_pos = _x select 0;
					_rad = _x select 1;
					if (_pos distance _bu < _rad * 1.125) exitWith {_onSiege = true;};
				} forEach _siegeLocals;
				if (!_onSiege) then {
					_opcoes pushBack _bu;
				};
			};
		};
	} forEach BRPVP_bravoMissObjs;
	_opcoes = _opcoes - BRPVP_missPrediosEm;
	_opcoes = _opcoes - [objNull];
	if (count _opcoes == 0) exitWith {diag_log "[BRPVP MISSBU] NO FREE BUILDINGS FOR MISSION!";};
	diag_log "[BRPVP MISSBU] FOUND BUILDING FOR MISSION!";
	_missBu = objNull;
	_tempClass = + _class;
	while {isNull _missBu} do {
		_classWanted = _tempClass call BIS_fnc_selectRandom;
		_tempClass = _tempClass - [_classWanted];
		_tempArr = [];
		{
			if (typeOf _x == _classWanted) then {_tempArr pushBack _x;};
		} forEach _opcoes;
		if (count _tempArr > 0) then {
			_missBu = _tempArr call BIS_fnc_selectRandom;
		};
	};
	_missBu setVariable ["msi",BRPVP_criaMissaoDePredioIdc,true];
	_missBu allowDamage false;
	_sirene = nearestObject [_missBu,"Land_Loudspeakers_F"];
	if (isNull _sirene) then {_sirene = _missBu;};
	if (!isNull _sirene) then {
		BRPVP_tocaSom = [_sirene,"sirene",1250];
		publicVariable "BRPVP_tocaSom";
		if (hasInterface) then {["",BRPVP_tocaSom] call BRPVP_tocaSomFnc;};
	};
	sleep 35;
	_buAllPos = _missBu buildingPos -1;

	//CRIA PREMIO
	_qp = 1 + (floor random 4);
	_dp = ((BRPVP_mapaRodando select 11 select 4)*BRPVP_moneyForMissionBoxContentMultiply)/_qp;
	_caixas = [];
	_interno = _cSDentro select (_class find typeOf _missBu);
	_limTM = 2^(1 + (floor random 2));
	for "_i" from 1 to _qp do {
		private ["_lootPos","_caixa"];
		//CRIA CAIXA
		if (_interno) then {
			_lootPos = _buAllPos call BIS_fnc_selectRandom;
			_caixa = createVehicle ["Box_IND_Wps_F",_lootPos,[],0,"CAN_COLLIDE"];
			_caixa allowDamage false;
		} else {
			_caixa = createVehicle ["Box_IND_Wps_F",[_missBu,5] call BRPVP_emVoltaBB,[],0,"NONE"];
			_caixa allowDamage false;
		};
		_caixas pushBack _caixa;
		_caixa setDir random 360;
		
		//ESVAZIA CAIXA
		clearMagazineCargoGlobal _caixa;
		clearWeaponCargoGlobal _caixa;
		clearItemCargoGlobal _caixa;
		clearBackpackCargoGlobal _caixa;
		
		//COLOCA PREMIO NA CAIXA
		_dpx = _dp * (0.85 + random 0.3);
		if (random 1 < 0.25) then {
			//[_caixa,_dpx] call BRPVP_qjsAdicClassObjetoServer;
			_caixa addMagazineCargoGlobal ["FlareWhite_F",round (_dpx/1000)]; //MISS
		} else {
			private ["_itensOk"];
			_itensAll = [];
			while {
				_itensOk = [];
				{
					_prc = (_x select 4) * (BRPVP_mercadoPrecosTemp select (_x select 0));
					if (_prc <= _dpx) then {
						_itensOk pushBack [_forEachIndex,_prc];
					};
				} forEach BRPVP_mercadoItensTemp;
				count _itensOk > 0
			} do {
				_escolhe = _itensOk call BIS_fnc_selectRandom;
				_itemIdc = _escolhe select 0;
				_itemPrc = _escolhe select 1;
				for "_p" from 2 to _limTM do {
					_escolhe = _itensOk call BIS_fnc_selectRandom;
					_itemXIdc = _escolhe select 0;
					_itemXPrc = _escolhe select 1;
					if (_itemXPrc > _itemPrc) then {
						_itemIdc = _itemXIdc;
						_itemPrc = _itemXPrc;
					};
				};
				_itensAll pushBack (BRPVP_mercadoItensTemp select _itemIdc select 3);
				_dpx = _dpx - _itemPrc;
			};
			[_caixa,_itensAll] call BRPVP_addLoot;
		};
		
		//PUT RARE ITEM
		_random = random 1;
		{
			if (_random < _x) exitWith {
				_item = selectRandom (BRPVP_ultraItems select _forEachIndex);
				_caixa addWeaponCargoGlobal [_item,1];
			};
		} forEach BRPVP_missionLootChanceOfRareItemsPerBox;
	};

	//PEGA ARMAS NO PREMIO
	_armas = [];
	_aQ = 0;
	{
		_gwc = getWeaponCargo _x;
		_aCx = _gwc select 0;
		_armas = _armas - _aCx;
		_armas append _aCx;
		{_aQ = _aQ + _x;} forEach (_gwc select 1);
	} forEach _caixas;

	//CRIA CAIXA EXTRA
	if (count _armas > 0) then {
		//CRIA
		_lootPos = _buAllPos call BIS_fnc_selectRandom;
		_caixa = objNull;
		if (_interno) then {
			_caixa = createVehicle ["Land_Box_AmmoOld_F",_lootPos,[],0,"CAN_COLLIDE"];
			_caixa allowDamage false;
		} else {
			_caixa = createVehicle ["Land_Box_AmmoOld_F",[_missBu,2] call BRPVP_emVoltaBB,[],0,"NONE"];
			_caixa allowDamage false;
		};
		_caixas pushBack _caixa;
		_caixa setDir random 360;

		//ESVAZIA
		clearMagazineCargoGlobal _caixa;
		clearWeaponCargoGlobal _caixa;
		clearItemCargoGlobal _caixa;
		clearBackpackCargoGlobal _caixa;
		
		//COLOCA MUNICAO
		_uf = round (_aQ * 3);
		for "_u" from 1 to _uf do {
			_arma = _armas call BIS_fnc_selectRandom;
			if (isArray (configFile >> "CfgWeapons" >> _arma >> "magazines")) then {
				_mags = getArray (configFile >> "CfgWeapons" >> _arma >> "magazines");
				if (count _mags > 0) then {
					_mag = _mags call BIS_fnc_selectRandom;
					_caixa addMagazineCargoGlobal [_mag,1];
				};
			};
		};
	};

	//COLOCA BOTS
	_caras = [BRPVP_missionWestGroups,BRPVP_missionWestGroups];
	_side = [WEST,WEST];
	_sIdc = 1 - (round random 1);
	_grp = createGroup [(_side select _sIdc),true];
	_uLado = (_caras select _sIdc) call BIS_fnc_SelectRandom;
	_BRPVP_missBotsEm = [];
	for "_j" from 0 to 8 do {
		private ["_unidade"];
		_esp = _uLado select (_j mod (count _uLado));
		if (_interno) then {
			_soPos = _buAllPos call BIS_fnc_selectRandom;
			_unidade = _grp createUnit [_esp,_soPos,[],0,"CAN_COLLIDE"];
		} else {
			_unidade = _grp createUnit [_esp,[_missBu,3] call BRPVP_emVoltaBB,[],0,"NONE"];
		};
		BRPVP_missBotsEm pushBack _unidade;
		_BRPVP_missBotsEm pushBack _unidade;
		[_unidade] joinSilent _grp;
		_unidade setSkill 0.4;
		_unidade addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
		_unidade addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
		_unidade setVariable ["brpvp_loot_protected",true,true];
	};
	_missBu setVariable ["msbs",_BRPVP_missBotsEm,false];
	publicVariable "BRPVP_missBotsEm";
	if (hasInterface) then {["",BRPVP_missBotsEm] call BRPVP_missBotsEmFnc;};
	BRPVP_missPrediosEm pushBack _missBu;
	publicVariable "BRPVP_missPrediosEm";
	BRPVP_criaMissaoDePredioIdc = BRPVP_criaMissaoDePredioIdc + 1;
	
	//CRIA WAYPOINT PARA BOT PERMANECER NO LOCAL
	_wp = _grp addWaypoint [_missBu,0];
	_wp setWaypointCompletionRadius 65;
	_wp setWayPointType "LOITER";
	
	//ADD ITEM BOX ICON ON CLIENTS
	BRPVP_allMissionsItemBox = BRPVP_allMissionsItemBox - [objNull];
	BRPVP_allMissionsItemBox append _caixas;
	publicVariable "BRPVP_allMissionsItemBox";
	if (hasInterface) then {["",BRPVP_allMissionsItemBox] call BRPVP_allMissionsItemBoxFnc;};
};

//SIEGE MISSION FUNCTION
BRPVP_besiegedMission = {
	//SELECT SIEGE PLACE
	_lArr = [];
	{
		if (BRPVP_closedCityRunning select _forEachIndex == 0) then {
			_lPos = _x select 0;
			_lRad = (((_x select 1) * 0.8) max 200) min 275;
			_safeZoneOverlap = ({(_x select 0) distance _lPos < (_lRad + (_x select 1)) * 1.15} count BRPVP_mercadoresPos) > 0;
			if (!_safeZoneOverlap) then {
				_hasbravo = {_lPos distance _x < _lRad * 1.15} count BRPVP_missPrediosEm > 0;
				if (!_hasBravo) then {
					_pts = 0;
					{_pts = _pts + sqrt(_lPos distance _x);} forEach allPlayers;
					_lArr pushBack [_pts^2,_lPos,_lRad,_forEachIndex];
				};
			};
		};
	} forEach BRPVP_locaisImportantes;
	if (count _lArr == 0) exitWith {};
	_lArr sort true;
	_local = [_lArr,3] call LOL_fnc_selectRandomFator;
	_lPos = _local select 1;
	_lRad = _local select 2;
	_localIdc = _local select 3;
	BRPVP_closedCityRunning set [_localIdc,1];
	BRPVP_closedCityTime set [_localIdc,time];
	
	//SIEGE BUILDINGS WITH INTERIOR
	_bs = nearestObjects [_lPos,BRPVP_loot_buildings_class,_lRad];
	_bsDel = [];
	{
		if (_x getVariable ["mapa",false]) then {
			_bsDel pushBack _forEachIndex;
		};
	} forEach _bs;
	_bsDel sort false;
	{_bs deleteAt _x;} forEach _bsDel;

	//GET ROADS AND CROSSROADS
	_rs = _lPos nearRoads _lRad;
	_rsc = [];
	_rsi = [];
	_rcta = [];
	{
		_rct = roadsConnectedTo _x;
		if (count _rct > 2) then {
			if (acos((surfaceNormal getPosATL _x) vectorCos [0,0,1]) < 6) then {
				_rcta append _rct;
				_rsc pushBack _x;
				_rsi pushBack _forEachIndex;
			};
		};
		if (count _rsc == 3) exitWith {};
	} forEach _rs;
	_rsi sort false;
	{_rs deleteAt _x;} forEach _rsi;
	_rs = _rs - _rcta;

	//PARA INSERT
	_s = 2 * _lRad/10;
	_onW = 0;
	_onA = 0;
	for "_l" from -5 to 5 do {
		for "_r" from -5 to 5 do {
			_pL = _lPos vectorAdd [_l * _s,_r * _s,0];
			if (_pL distance _lPos <= _lRad) then {
				_onA = _onA + 1;
				if (surfaceIsWater _pL) then {
					_onW = _onW + 1;
				};
			};
		};
	};
	_insPara = _onW/_onA < 0.1;
	_hH = if (_insPara) then {250} else {150};
	
	//SET CHOOPER START AND END POSITION
	_xm = BRPVP_mapaDimensoes select 0;
	_ym = BRPVP_mapaDimensoes select 1;
	_borders = [[0,0,_hH],[_xm/2,0,_hH],[_xm,0,_hH],[_xm,_ym/2,_hH],[_xm,_ym,_hH],[_xm/2,_ym,_hH],[0,_ym,_hH],[0,_ym/2,_hH]];
	_borders = _borders apply {[_x distance _lPos,_x]};
	_borders sort true;
	_start = _borders select 0 select 1;
	_end = _borders select 7 select 1;
	
	//CREATE PILOT
	_grpP = createGroup [WEST,true];
	_pilot = _grpP createUnit [BRPVP_missionWestGroups select 0 select 0,BRPVP_spawnAIFirstPos,[],0,"NONE"];
	_pilot setSkill 0.3;
	_pilot disableAI "TARGET";
	_pilot disableAI "AUTOTARGET";
	_pilot disableAI "AUTOCOMBAT";
	_pilot setVariable ["brpvp_loot_protected",true,true];

	//CREATE CHOPPER
	_dir = [_start,_lPos] call BIS_fnc_dirTo;
	_heli = createVehicle ["B_Heli_Transport_03_F",_start,[],100,"FLY"];
	_heli setPos _start;
	_heli setDir _dir;
	_heli flyInHeight _hH;
	_pilot moveInDriver _heli;
	_pilot assignAsDriver _heli;
	
	//PUT SIEGE SOLDIERS IN CHOOPER CARGO AND SET THEIR OBJECTIVE
	_qp = 3;
	_soldiers = [];
	_grps = [];
	_invsAI = [];
	for "_i" from 1 to _qp do {
		_grp = createGroup [WEST,true];
		_caras = BRPVP_missionWestGroups call BIS_fnc_selectRandom;
		for "_j" from 1 to 5 do {
			_unidade = _grp createUnit [_caras select (_j - 1),BRPVP_spawnAIFirstPos,[],0,"NONE"];
			[_unidade] call BRPVP_fillUnitWeapons;
			if (_insPara) then {
				_invsAI pushBack [backPack _unidade,backpackItems _unidade];
				removeBackpack _unidade;
			};
			_unidade assignAsCargo _heli;
			_unidade moveInCargo _heli;
			_unidade setSkill 0.5;
			_unidade addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
			_unidade addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
			_unidade setVariable ["brpvp_loot_protected",true,true];
			_soldiers pushBack _unidade;
			(BRPVP_closedCityAI select _localIdc) pushBack _unidade;
		};
		_grps pushBack _grp;
	};
	
	//CHOOPER PATH: INSERTION
	_wp = _grpP addWayPoint [_lpos vectorAdd [0,0,_hH],0];
	_wp setWayPointType "MOVE";
	_wp setWayPointSpeed "FULL";

	waitUntil {_heli distance2D _lPos < 1000 || !canMove _heli};
	if (!canMove _heli) exitWith {BRPVP_closedCityRunning set [_localIdc,3];};
	BRPVP_missBotsEm pushBack _pilot;
	BRPVP_missBotsEm append _soldiers;	
	publicVariable "BRPVP_missBotsEm";
	if (hasInterface) then {["",BRPVP_missBotsEm] call BRPVP_missBotsEmFnc;};
	BRPVP_tocaSom = [_bs select 0,"sirene",1250];
	publicVariable "BRPVP_tocaSom";
	if (hasInterface) then {["",BRPVP_tocaSom] call BRPVP_tocaSomFnc;};
	
	waitUntil {currentWayPoint _grpP == 2 || !canMove _heli};
	if (!canMove _heli) exitWith {BRPVP_closedCityRunning set [_localIdc,3];};
	if (_insPara) then {
		_h = [];
		{_h pushBack (100 + (_forEachIndex * 10) mod 110);} forEach _soldiers;
		[_soldiers,_h,_invsAI] spawn {
			params ["_soldiers","_h","_invsAI"];
			_cnt = count _soldiers;
			_okPara = [];
			_okGround = [];
			waitUntil {
				{
					_unit = _x;
					if !(_unit in _okPara) then {
						if ((getPosATL _unit) select 2 <= _h select _forEachIndex) then {
							_unit addBackpack "B_Parachute";
							_okPara pushBack _unit;
						};
					};
					if !(_unit in _okGround) then {
						if (vehicle _unit == _unit) then {
							_okGround pushBack _unit;
						};
					};
				} forEach _soldiers;
				count _okPara == _cnt && count _okGround == _cnt
			};
			{
				_backPack = _invsAI select _forEachIndex select 0;
				if (_backPack != "" && alive _x) then {
					_items = _invsAI select _forEachIndex select 1;
					_x addBackPack _backPack;
					[backPackContainer _x,_items] call BRPVP_addLoot;
				};
			} forEach _soldiers;
		};
		{
			unassignVehicle _x;
			moveOut _x;
			[_x] allowGetIn false;
			_x setDir ([_x,_heli] call BIS_fnc_dirTo);
			sleep (0.3 + random 0.2);
			if (!canMove _heli) exitWith {};
		} forEach _soldiers;
		if (!canMove _heli) exitWith {};
		sleep 2.5;
		
		_wp = _grpP addWayPoint [_end,0];
		_wp setWayPointType "MOVE";
		_wp setWayPointSpeed "FULL";
	} else {
		_wp = _grpP addWayPoint [_lpos,0];
		_wp setWayPointType "TR UNLOAD";
		_wp setWayPointSpeed "FULL";

		waitUntil {currentWayPoint _grpP == 3 || !canMove _heli};
		if (!canMove _heli) exitWith {};
		_wp = _grpP addWayPoint [_end,0];
		_wp setWayPointType "MOVE";
		_wp setWayPointSpeed "FULL";
	};
	if (!canMove _heli) exitWith {BRPVP_closedCityRunning set [_localIdc,3];};
	
	//TOWERS
	_ar = pi * _lRad^2;
	_twq = (floor (_ar/100^2)) min (count _rsc);
	_towers = [];
	{
		_rp = getPosATL _x;
		_objs = nearestObjects [_rp,["LandVehicle","Air","Ship","Building","House","Wall"],10];
		_oPly = {if (_x getVariable ["id_bd",-1] != -1) then {true} else {false};} count _objs;
		if (_oPly == 0) then {
			_tw = createVehicle [BRPVP_towas call BIS_fnc_selectRandom,_rp,[],0.5,"CAN_COLLIDE"];
			_tw setDir ([getPosASL _x,getPosASL ((roadsConnectedTo _x) select 0)] call BIS_fnc_dirTo);
			(BRPVP_closedCityObjs select _localIdc) pushBack _tw;
			_towers pushBack _tw;
		};
		if (count _towers == _twq) exitWith {};
	} forEach _rsc;

	//SELECT PROTECTED BUILDINGS
	_buAllPosN = [];
	_bus = [];
	for "_i" from 1 to _qp do {
		private ["_buAllPos","_bu"];
		_inTower = count _towers > 0;
		if (_inTower) then {
			_twi = (_i - 1) mod count _towers;
			_bu = _towers select _twi;
			_towers deleteAt _twi;
			_buAllPos = _bu buildingPos -1;
		} else {
			if (count _bs > 0) then {
				_bu = _bs select (((_i - 1) + floor random 3) mod count _bs);
				_buAllPos = _bu buildingPos -1;
			} else {
				_fkPos = _lPos vectorAdd [-10 + random 20,-10 + random 20,0];
				_bu = createVehicle ["Land_cargo_house_slum_F",_fkPos,[],0,"NONE"];
				(BRPVP_closedCityObjs select _localIdc) pushBack _bu;
				_buAllPos = [_lPos vectorAdd [-10 + random 20,-10 + random 20,0]];
			};
		};
		_buAllPosN pushBack _buAllPos;
		_bus pushBack _bu;
	};

	//INSERTED SOLDIERS TO POSITION
	{
		_wp = (_grps select _forEachIndex) addWaypoint [ASLToAGL getPosASL _x,0];
		_wp setWaypointCompletionRadius 25;
		_wp setWayPointType "LOITER";
		_wp setWayPointLoiterRadius 25;
		_wp setWaypointLoiterType "CIRCLE";
	} forEach _bus;

	//SIEGE START MESSAGE
	//waitUntil {count crew _heli == 1};
	_qtS = count _soldiers;
	_lRadSqr = (_lRad^2) * 0.95;
	_init = time;
	_aliveQt = 0;
	waitUntil {
		_qt = {_x distanceSqr _lPos < _lRadSqr} count _soldiers;
		_aliveQt = {alive _x} count _soldiers;
		_qt >= round (_qtS * 0.8) || time - _init > 240 || _aliveQt < round (_qtS * 0.5)
	};
	_wOpenPerc = if (time - _init > 240) then {0.6} else {0.9};
	if (_aliveQt < round (_qtS * 0.5)) exitWith {BRPVP_closedCityRunning set [_localIdc,3];};
	_lName = BRPVP_locaisImportantes select _localIdc select 2;
	BRPVP_hintEmMassa = [["str_is_on_siege",[_lName]],5,15,0,"batida"];
	publicVariable "BRPVP_hintEmMassa";
	if (hasInterface) then {["",BRPVP_hintEmMassa] call BRPVP_hintEmMassaFnc;};

	//SET CAPTIVE OFF FOR SOLDIERS
	//{_x setCaptive false;} forEach _soldiers;
	
	//SIEGE WALLS
	_step = 360/((2 * pi * _lRad)/5.7);
	_an = random 360;
	_qs = ceil (0.065 * 360/_step);
	_ae = _an + 360;
	_cnt = 0;
	_ini = time;
	_woa = [];
	_vua = [0,0,1];
	_wp0 = _lPos vectorAdd [_lRad * sin(_an - _step * 0.99),_lRad * cos(_an - _step * 0.99),0];
	_wp1 = _lPos vectorAdd [_lRad * sin(_an),_lRad * cos(_an),0];
	_vu0 = surfaceNormal _wp0;
	_vu1 = surfaceNormal _wp1;
	_err = _step * ((random 0.02) - 0.01);
	_fail = 0;
	_turrs = [];
	_w = objNull;
	BRPVP_tocaSom = [_w,"constructing",800];
	publicVariable "BRPVP_tocaSom";
	if (hasInterface) then {["",BRPVP_tocaSom] call BRPVP_tocaSomFnc;};
	while {_an <= _ae} do {
		_wp2 = _lPos vectorAdd [_lRad * sin(_an + _step + _err),_lRad * cos(_an + _step + _err),0];
		if (_err >= 0) then {
			_err = _err - random (_step * 0.01 + _err);
		} else {
			_err = random (_step * 0.01 - _err) - _err;
		};
		_vu2 = surfaceNormal _wp2;
		_onWater = surfaceIsWater _wp1;
		if (!_onWater) then {
			_i1 = lineIntersectsSurfaces [(ATLToASL _wp0) vectorAdd [0,0,0.5],(ATLToASL _wp2) vectorAdd [0,0,0.5],_w,objNull,true,1,"GEOM","NONE"];
			_i2 = lineIntersectsSurfaces [(ATLToASL _wp2) vectorAdd [0,0,1.5],(ATLToASL _wp0) vectorAdd [0,0,1.5],_w,objNull,true,1,"GEOM","NONE"];
			_i1 append _i2;
			_inportant = false;
			if (count _i1 > 0) then {
				{
					_o = _x select 2;
					if (typeName _o == "OBJECT") then {
						if (_o call BRPVP_isMotorized || _o call BRPVP_isBuilding) exitWith {
							_inportant = true;
						};
					};
					if (_inportant) exitWith {};
				} forEach _i1;
			};
			_onRoad = isOnRoad _wp1;
			if (count _i1 == 0 || (count _i1 > 0 && !_inportant)) then {
				if (!_onRoad) then {
					if (random 1 < _wOpenPerc) then {
						_wd = [_wp1,_lPos] call BIS_fnc_dirTo;
						_vu = vectorNormalized ((_vu0 vectorAdd _vu1) vectorAdd _vu2);
						_w = createSimpleObject ["A3\Structures_F\Walls\CncWall4_F.p3d",AGLToASL [0,0,0]];
						_w setDir (_wd - 2.5 + random 5);
						_w setPosATL (_wp1 vectorAdd [0,0,0]);
						_w setVectorUp _vu;
						_woa pushBack _w;
					} else {
						_fail = _fail + 1;
					};
				} else {
					if (!isOnRoad _wp0 && !isOnRoad _wp2) then {
						//_turrs pushBack _wp1;
					};
				};
			} else {
				_fail = _fail + 1;
			};
		};
		if (!_onWater) then {
			sleep ((1.5/_qs) * ((_cnt/_qs) * 2));
		};
		if (_cnt == _qs) then {
			_cnt = 0;
			BRPVP_tocaSom = [_w,"constructing",800];
			publicVariable "BRPVP_tocaSom";
			if (hasInterface) then {["",BRPVP_tocaSom] call BRPVP_tocaSomFnc;};
		};
		if (!_onWater) then {_cnt = _cnt + 1;};
		_an = _an + _step;
		_wp0 = _wp1;
		_wp1 = _wp2;
		_vu0 = _vu1;
		_vu1 = _vu2;	
	};
	_cntT = 4;
	_wallTurreters = [];
	while {count _turrs > 0 && _cntT > 0} do {
		_it = floor random count _turrs;
		_tp = _turrs deleteAt _it;
		_turr = createVehicle ["T_TURR_F",_tp,[],0.5,"CAN_COLLIDE"];
		_turr setDir ([_lPos,_tp] call BIS_fnc_dirTo);
		_grpt = createGroup [WEST,true];
		_unidade = _grpt createUnit [_caras call BIS_fnc_selectRandom,BRPVP_spawnAIFirstPos,[],0,"NONE"];
		_unidade setSkill 0.4;
		_unidade setVariable ["brpvp_loot_protected",true,true];
		_unidade assignAsGunner _turr;
		_unidade moveInGunner _turr;
		_wallTurreters pushBack _unidade;
		_cntT = _cntT - 1;
	};
	//BRPVP_missBotsEm append _wallTurreters;
	//publicVariable "BRPVP_missBotsEm";
	//if (hasInterface) then {["",BRPVP_missBotsEm] call BRPVP_missBotsEmFnc;};
	if !(_cnt mod _qs == 0) then {
		BRPVP_tocaSom = [_w,"constructing",800];
		publicVariable "BRPVP_tocaSom";
		if (hasInterface) then {["",BRPVP_tocaSom] call BRPVP_tocaSomFnc;};
	};
	/*
	if (_fail < 10) then {
		for "_k" from _fail to 10 do {
			_w = _woa deleteAt (floor random count _woa);
			deleteVehicle _w;
		};
	};
	*/
	BRPVP_closedCityWalls set [_localIdc,_woa];
	
	//ROAD OBJECTS
	_objsAll = [
		"Land_HBarrierTower_F",
		"Land_HBarrierWall_corner_F",
		"Land_HBarrierWall_corridor_F",
		"Land_HBarrierWall4_F",
		"Land_Wreck_HMMWV_F",
		"Land_Wreck_BRDM2_F",
		"Land_BagFence_Long_F",
		"Land_BagFence_Long_F",
		"Land_BagFence_Long_F",
		"Land_BagFence_Long_F",
		"Land_BagBunker_Tower_F",
		"Land_ConcretePipe_F"
	];
	_cnt = 0;
	while {_cnt < _twq * 3 && count _rs > 0} do {
		(_rs call LOL_fnc_selectRandomIdx) params ["_r","_i"];
		_rs deleteAt _i;
		_rp = getPosASL _r;
		_objs = nearestObjects [ASLToAGL _rp,["LandVehicle","Air","Ship","Building","House","Wall"],10];
		_oPly = {if (_x getVariable ["id_bd",-1] != -1) then {true} else {false};} count _objs;
		if (_oPly == 0) then {
			_rs = _rs - (roadsConnectedTo _r);
			_ob = createSimpleObject [_objsAll select (floor random count _objsAll),_rp];
			_ob setDir ([getPosASL _r,getPosASL ((roadsConnectedTo _r) select 0)] call BIS_fnc_dirTo);
			_ob setVectorUp surfaceNormal getPosATL _ob;
			(BRPVP_closedCityObjs select _localIdc) pushBack _ob;
			_cnt = _cnt + 1;
		};
	};
	publicVariable "BRPVP_closedCityObjs";
	publicVariable "BRPVP_closedCityWalls";

	//ITEM BOX
	_dp = (BRPVP_mapaRodando select 19 select 2)*BRPVP_moneyForMissionBoxContentMultiply;
	_allBox = [];
	for "_i" from 1 to _qp do {
		private ["_lootPos","_caixa"];
		_limTM = 2^(1 + (floor random 2));
		_buAllPos = _buAllPosN select (_i - 1);
		//_lootPos = _buAllPos call BIS_fnc_selectRandom;
		_lootPos = ASLToAGL getPosASL (_bus select (_i - 1));
		_caixa = createVehicle ["Box_IND_Wps_F",[_lootPos,5,random 360] call BIS_fnc_relPos,[],0,"NONE"];
		_caixa allowDamage false;
		_caixa setDir random 360;
		_allBox pushBack _caixa;
		clearMagazineCargoGlobal _caixa;
		clearWeaponCargoGlobal _caixa;
		clearItemCargoGlobal _caixa;
		clearBackpackCargoGlobal _caixa;
		
		_dpx = _dp * (0.9 + random 0.2);
		if (random 1 < 1/3) then {
			_caixa addMagazineCargoGlobal ["FlareWhite_F",round (_dpx/2000)]; //MISS
		} else {
			private ["_itensOk"];
			_itensAll = [];
			while {
				_itensOk = [];
				{
					_prc = (_x select 4) * (BRPVP_mercadoPrecosTemp select (_x select 0));
					if (_prc <= _dpx) then {
						_itensOk pushBack [_forEachIndex,_prc];
					};
				} forEach BRPVP_mercadoItensTemp;
				count _itensOk > 0
			} do {
				_escolhe = _itensOk call BIS_fnc_selectRandom;
				_itemIdc = _escolhe select 0;
				_itemPrc = _escolhe select 1;
				for "_p" from 2 to _limTM do {
					_escolhe = _itensOk call BIS_fnc_selectRandom;
					_itemXIdc = _escolhe select 0;
					_itemXPrc = _escolhe select 1;
					if (_itemXPrc > _itemPrc) then {
						_itemIdc = _itemXIdc;
						_itemPrc = _itemXPrc;
					};
				};
				_itensAll pushBack (BRPVP_mercadoItensTemp select _itemIdc select 3);
				_dpx = _dpx - _itemPrc;
			};
			[_caixa,_itensAll] call BRPVP_addLoot;
		};

		//PUT RARE ITEM
		_random = random 1;
		{
			if (_random < _x) exitWith {
				_item = selectRandom (BRPVP_ultraItems select _forEachIndex);
				_caixa addWeaponCargoGlobal [_item,1];
			};
		} forEach BRPVP_missionLootChanceOfRareItemsPerBox;

		_gwc = getWeaponCargo _caixa;
		_weapons = _gwc select 0;
		_weaponsQt = _gwc select 1;
		if (count _weapons > 0) then {
			//_lootPos = _buAllPos call BIS_fnc_selectRandom;
			_caixa = objNull;
			_caixa = createVehicle ["Land_Box_AmmoOld_F",[_lootPos,5,random 360] call BIS_fnc_relPos,[],0,"NONE"];
			_caixa allowDamage false;
			_caixa setDir random 360;
			_allBox pushBack _caixa;
			clearMagazineCargoGlobal _caixa;
			clearWeaponCargoGlobal _caixa;
			clearItemCargoGlobal _caixa;
			clearBackpackCargoGlobal _caixa;
			{
				if (isArray (configFile >> "CfgWeapons" >> _x >> "magazines")) then {
					_mags = getArray (configFile >> "CfgWeapons" >> _x >> "magazines");
					if (count _mags > 0) then {
						for "_u" from 1 to (_weaponsQt select _forEachIndex) do {
							_mag = _mags call BIS_fnc_selectRandom;
							_caixa addMagazineCargoGlobal [_mag,round (3.25 + random 1.25)];
						};
					};
				};
			} forEach _weapons;
		};
	};
	
	//SET SIEGE STATE TO COMPLETED
	BRPVP_closedCityRunning set [_localIdc,2];
	publicVariable "BRPVP_closedCityRunning";
	if (hasInterface) then {["",BRPVP_closedCityRunning] call BRPVP_closedCityRunningFnc;};

	//ADD ITEM BOX ICON ON CLIENTS
	BRPVP_allMissionsItemBox = BRPVP_allMissionsItemBox - [objNull];
	BRPVP_allMissionsItemBox append _allBox;
	publicVariable "BRPVP_allMissionsItemBox";
	if (hasInterface) then {["",BRPVP_allMissionsItemBox] call BRPVP_allMissionsItemBoxFnc;};

	//DELETE RETURNED CHOOPER AND PILOT
	_wif = if (_insPara) then {3} else {4};
	waitUntil {currentWayPoint _grpP == _wif || !alive _heli || !alive _pilot};
	if (alive _pilot && alive _heli) then {
		deleteVehicle _heli;
		deleteVehicle _pilot;
	};

	diag_log ("[BRPVP SIEGE] City " + str _localIdc + " siege start script finished!");
};
BRPVP_convoyMissionIdc = 0;
BRPVP_kvyKilledCount = 0;
BRPVP_kvyKilled = {
	_veh = _this select 0;
	_veh removeAllEventHandlers "HandleDamage";
	_veh removeAllEventHandlers "GetIn";
	_veh spawn {
		_money = _this getVariable "mmny";
		_init = time;
		sleep 6.5;
		_allBoxClass = ["Box_NATO_WpsSpecial_F","Box_NATO_AmmoOrd_F","Box_NATO_Grenades_F","Box_NATO_Support_F"];
		_pos = getPosATL _this;
		_pos = [_pos,7 + random 3,random 360] call BIS_fnc_relPos;
		_allBox = [];
		if (true) then {
			_box1 = createVehicle [_allBoxClass select (BRPVP_kvyKilledCount mod 4),_pos,[],0,"NONE"];
			clearWeaponCargoGlobal _box1;
			clearMagazineCargoGlobal _box1;
			clearItemCargoGlobal _box1;
			clearBackpackCargoGlobal _box1;
			_box1 allowDamage false;
			_allBox pushBack _box1;
			BRPVP_kvyKilledCount = BRPVP_kvyKilledCount + 1;
			_box1 addMagazineCargoGlobal ["FlareYellow_F",round (_money/2000)];
		} else {
			if (random 1 < 0.5) then {
				_box1 = createVehicle [_allBoxClass select (BRPVP_kvyKilledCount mod 4),_pos,[],0,"NONE"];
				_box1 allowDamage false;
				_allBox pushBack _box1;
				BRPVP_kvyKilledCount = BRPVP_kvyKilledCount + 1;
				_box1 addMagazineCargoGlobal ["FlareYellow_F",round (_money/2000)];
			} else {
				_box1 = createVehicle [_allBoxClass select (BRPVP_kvyKilledCount mod 4),_pos,[],0,"NONE"];
				_box1 allowDamage false;
				_allBox pushBack _box1;
				BRPVP_kvyKilledCount = BRPVP_kvyKilledCount + 1;
				_box2 = createVehicle [_allBoxClass select (BRPVP_kvyKilledCount mod 4),_pos,[],0,"NONE"];
				_box2 allowDamage false;
				_allBox pushBack _box2;
				BRPVP_kvyKilledCount = BRPVP_kvyKilledCount + 1;
				_box2 addMagazineCargoGlobal ["FlareYellow_F",round (_money/3000)];
			};
		};

		//ADD ITEM BOX ICON ON CLIENTS
		BRPVP_allMissionsItemBox = BRPVP_allMissionsItemBox - [objNull];
		BRPVP_allMissionsItemBox append _allBox;
		publicVariable "BRPVP_allMissionsItemBox";
		if (hasInterface) then {["",BRPVP_allMissionsItemBox] call BRPVP_allMissionsItemBoxFnc;};
	};
};
BRPVP_convoyMission = {
	if (BRPVP_convoyMissionIdc == -1) exitWith {};
	_BRPVP_convoyMissionIdc = BRPVP_convoyMissionIdc;
	BRPVP_convoyMissionIdc = -1;
	for "_t" from 0 to 30 do {
		_islands = BRPVP_mapaRodando select 20 select 2;
		_island = [];
		_rnd = random 1;
		_num = 0;
		{
			_add = _x select 0;
			if (_rnd >= _num && _rnd < _num + _add) exitWith {
				_island = _x select 1;
			};
			_num = _num + _add;
		} forEach _islands;
		if (count _island == 0) then {
			diag_log "[BRPVP ERROR] Convoy Islands percentual must sum 1. Choosing island randonly!";
			_island = _islands call BIS_fnc_selectRandom;
		};
		
		_msPlaces = [];
		{
			_p = BRPVP_terrenos select _x select 0;
			_ms = _p nearEntities ["Man",500];
			_msPlaces pushBack [{isPlayer _x} count _ms,_x];
		} forEach _island;
		_msPlaces sort true;
		_msPlace = [_msPlaces,2.5 - _t * 0.05 ] call LOL_fnc_selectRandomFator;
		_p1 = BRPVP_terrenos select (_msPlace select 1) select 0;
		_d1 = BRPVP_terrenos select (_msPlace select 1) select 1;
		_d1 = _d1 * 2;

		_convoys = [
			//2 VEHICLES
			[["I_G_Offroad_01_armed_F","I_Heli_light_03_F"]		,INDEPENDENT,[1,0,0,1],[2,3],"LIMITED",[15000,15000],3,10],
			[["I_G_Offroad_01_armed_F","I_G_Offroad_01_armed_F"],INDEPENDENT,[1,0,0,1],[2,2],"LIMITED",[15000,10000],3,10],
			[["I_MRAP_03_F","I_Heli_light_03_F"]				,INDEPENDENT,[1,0,0,1],[2,3],"LIMITED",[17000,18000],3,10],
			[["I_APC_Wheeled_03_cannon_F","I_Heli_light_03_F"]	,INDEPENDENT,[1,0,0,1],[2,3],"LIMITED",[20000,20000],3,10],
			[["I_APC_tracked_03_cannon_F","I_Heli_light_03_F"]	,INDEPENDENT,[1,0,0,1],[2,3],"LIMITED",[25000,20000],3,10],
			[["I_Heli_light_03_F","I_Heli_light_03_F"]			,INDEPENDENT,[1,0,0,1],[3,3],"LIMITED",[30000,25000],5,20],
			//1 VEHICLE
			[["I_APC_tracked_03_cannon_F"]	,INDEPENDENT,[1,0,0,1],[3],"LIMITED",[20000],2,10],
			[["I_APC_Wheeled_03_cannon_F"]	,INDEPENDENT,[1,0,0,1],[3],"LIMITED",[25000],3,10],
			[["I_G_Offroad_01_armed_F"]		,INDEPENDENT,[1,0,0,1],[2],"LIMITED",[17000],3,10]
		];
		_convoy = _convoys call BIS_fnc_selectRandom;

		_arr = [];
		{
			_dist = _p1 distance (BRPVP_terrenos select _x select 0);
			if (_dist > 1000) then {
				_arr pushBack [_dist,_x];
			};
		} forEach _island;
		_arr sort false;
		_arrSel = [_arr,_convoy select 6] call LOL_fnc_selectRandomFator;
		_p2 = BRPVP_terrenos select (_arrSel select 1) select 0;
		_d2 = BRPVP_terrenos select (_arrSel select 1) select 1;
		_d2 = _d2 * 2;

		_blackList = [];
		_grp = createGroup [(_convoy select 1),true];
		_crewCvy = [];
		_composition = [];
		{
			_pos = getPos _x;
			_so = sizeOf typeOf _x;
			_so = _so/1.65;
			_pTL = _pos vectorAdd [-_so,_so,0];
			_pBR = _pos vectorAdd [_so,-_so,0];
			_pTL resize 2;
			_pBR resize 2;
			_blackList pushBack [_pTL,_pBR];
		} forEach (nearestObjects [_p1,["LandVehicle","Air","Man","Ship"],_d1]);
		_rst = [_p1,0,_d1 * 2,20,0,0.5,0,_blackList,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
		_ok = false;
		if (_rst distance [0,0,0] > 0) then {
			_ok = true;
			BRPVP_convoyMissionIdc = _BRPVP_convoyMissionIdc + 1;
			{
				_return = [_rst,180,_x,_grp] call BIS_fnc_spawnVehicle;
				_veh = _return select 0;
				_veh allowDamage false;
				_veh setVehiclePosition [_rst,[],20,"NONE"];
				_veh setVariable ["mmny",_convoy select 5 select _forEachIndex,false];
				_veh call BRPVP_veiculoEhReset;
				_veh addEventHandler ["GetIn",{_this call BRPVP_carroBotGetIn;}];
				_veh addEventHandler ["HandleDamage",{_this call BRPVP_hdEhVeiculo}];
				_veh addEventHandler ["Killed",{_this call BRPVP_kvyKilled;}];
				_composition pushBack _veh;
				_crew = _return select 1;
				_cgq = _convoy select 3 select _forEachIndex;
				_ep = _veh emptyPositions "Cargo";
				for "_i" from 1 to (_ep min _cgq) do {
					_unit = _grp createUnit [typeOf (_crew call BIS_fnc_selectRandom),[0,0,0],[],0,"FORM"];
					_unit assignAsCargo _veh;
					_unit moveInCargo _veh;
					_crew pushBack _unit;
				};
				_crewCvy append _crew;
			} forEach (_convoy select 0);
			{
				_x setSkill 0.4;
				_x setVariable ["brpvp_loot_protected",true,true];
			} forEach _crewCvy;
			
			_composition spawn {
				sleep 5;
				{_x allowDamage true;} forEach _this;
			};
			
			_kPaa = ["konvoyRed.paa","konvoyYellow.paa","konvoyBlue.paa"] select (BRPVP_convoyMissionIdc mod 3);
			BRPVP_konvoyCompositions pushBack [_composition,_crewCvy,_kPaa,_convoy select 2];
			publicVariable "BRPVP_konvoyCompositions";
			
			{
				_x addEventHandler ["Killed",{_this call BRPVP_botDaExp;_this call BRPVP_rolaMotorista;}];
				_x addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
				[_x] call BRPVP_fillUnitWeapons;
			} forEach _crewCvy;
			
			_speed = _convoy select 4;
			_pw1 = _rst;
			_pw2 = [_p2,0,_d2 * 2,12,0,0.5,0,[],[_p2,_p2]] call BIS_fnc_findSafePos;

			for "_w" from 1 to (_convoy select 7) do {
				_wp = _grp addWayPoint [_pw2,0];
				_wp setWayPointType "MOVE";
				_wp setWayPointSpeed _speed;
				_wp setWayPointCompletionRadius 125;

				_wp = _grp addWayPoint [_pw1,0];
				_wp setWayPointType "MOVE";
				_wp setWayPointSpeed _speed;
				_wp setWayPointCompletionRadius 125;
			};
		};
		if (_ok) exitWith {};
	};
};
BRPVP_corruptMissObjs = [];
BRPVP_corruptMissSpawn = {
	_rnd = (BRPVP_mapaRodando select 21 select 1) call BIS_fnc_selectRandom;
	_center = _rnd select 0;
	_radius = _rnd select 1;
	if (count _this == 3) then {
		_center = _this;
		_radius = 10;
	};
	_clues = [
		"Land_HandyCam_F",
		"Land_Compass_F",
		"Land_Photos_V1_F",
		"Land_Map_unfolded_F",
		"Land_File2_F",
		"Land_MobilePhone_smart_F",
		"Land_BottlePlastic_V1_F",
		"Land_Can_Dented_F",
		"Land_Notepad_F",
		"Land_Can_V2_F"
	];
	_spwPosAll = [
		[0,0,0],
		[(BRPVP_mapaDimensoes select 0)/2,0,0],
		[BRPVP_mapaDimensoes select 0,0,0],
		[0,(BRPVP_mapaDimensoes select 1)/2,0],
		[0,BRPVP_mapaDimensoes select 1,0],
		BRPVP_mapaDimensoes + [0],
		[BRPVP_mapaDimensoes select 0,(BRPVP_mapaDimensoes select 1)/2,0],
		[(BRPVP_mapaDimensoes select 0)/2,BRPVP_mapaDimensoes select 1,0]
	];
	_spwPosAll = _spwPosAll apply {
		_v1 = vectorNormalized (_x vectorDiff _center);
		_onLand = 0;
		for "_i" from 0 to 19 do {
			_p = _center vectorAdd (_v1 vectorMultiply (_i * 50));
			_onLand = _onLand + (if (!surfaceIsWater _p) then {1} else {0});
		};
		[_onLand,_x]
	};
	_spwPosAll sort false;
	_spwPos = ([_spwPosAll,3.5] call LOL_fnc_selectRandomFator) select 1;
	_clueIdc = 0;
	_grp = createGroup [CIVILIAN,true];
	_plane = createVehicle ["C_Plane_Civil_01_F",_spwPos vectorAdd [0,0,1250],[],100,"FLY"];
	_bMan = _grp createUnit ["C_Nikos_aged",[0,0,0],[],0,"NONE"];
	_bMan addRating -20000;
	{_bMan removeMagazine _x;} forEach  magazines _bMan;
	{_bMan removeWeapon _x;} forEach weapons _bMan;
	{_bMan removeItem _x;} forEach items _bMan;
	removeAllAssignedItems _bMan;
	removeBackpackGlobal _bMan;
	_bMan setDamage 0.9;
	_bMan setSkill 0.3;
	_bMan moveInDriver _plane;
	_bMan addWeapon "hgun_ACPC2_F";
	_bMan addMagazine "9Rnd_45ACP_Mag";
	_bMan addMagazine "9Rnd_45ACP_Mag";
	_bMan addBackpack "B_Parachute";
	_bMan addEventHandler ["HandleDamage",{
		params ["_unit","_part","_damage","_ofensor"];
		if (_ofensor == _unit) then {
			_damage = 0;
		};
		_damage
	}];
	_bMan addEventHandler ["Killed",{
		params ["_unit","_ofensor"];
		_suitCase = createVehicle ["Land_Suitcase_F",getPos _unit,[],1.75,"NONE"];
		_suitCase setVariable ["mny",BRPVP_mapaRodando select 21 select 4,true];
		_unit setVariable ["sc",_suitCase,false];
		_unit setVariable ["dd",1,true];
	}];
	_bMan setVariable ["sc",0,false];
	BRPVP_missBotsEm pushBack _bMan; //REMOVE AFTER TEST  REMOVE AFTER TEST  REMOVE AFTER TEST
	publicVariable "BRPVP_missBotsEm";
	if (hasInterface) then {["",BRPVP_missBotsEm] call BRPVP_missBotsEmFnc;};
	_paraPos = [_center vectorAdd [0,0,50],_radius * 0.5 + random (_radius * 0.5),random 360] call BIS_fnc_relPos;
	_wp = _grp addWayPoint [_paraPos,0];
	_wp setWayPointCompletionRadius 100;
	waitUntil {_plane distanceSqr _paraPos < 1000000};
	_plane setDamage 0.5;
	waitUntil {currentWayPoint _grp == 2 || !canMove _plane};
	_bMan allowDamage false;
	moveOut _bMan;
	sleep 0.25;
	if (damage _plane < 1) then {
		_plane setDamage 1;
	};
	sleep 0.75;
	_bMan allowDamage true;
	_plane setVariable ["dir",getDir _plane,true];
	_plane setVariable ["bm",_bMan,false];
	BRPVP_corruptMissIcon pushBack _plane;
	publicVariable "BRPVP_corruptMissIcon";
	BRPVP_corruptMissObjs pushBack [];
	_idc = (count BRPVP_corruptMissIcon) - 1;
	BRPVP_hintEmMassa = [["str_plane_fall",[]],8,25];
	publicVariable "BRPVP_hintEmMassa";
	if (hasInterface) then {["",BRPVP_hintEmMassa] call BRPVP_hintEmMassaFnc;};
	diag_log "[BRPVP MISS PLANE] Civil Plane Crash mission started!";
	_grp allowFleeing 0.5;
	waitUntil {vehicle _bMan == _bMan};
	_bMan enableAI "TARGET";
	_bMan enableAI "AUTOTARGET";
	_bMan enableAI "AUTOCOMBAT";
	_plane setVariable ["dir",[_bMan,_plane] call BIS_fnc_dirTo,true];
	_pos = getPos _bMan;
	(BRPVP_corruptMissObjs select _idc) pushBack createVehicle [_clues call BIS_fnc_selectRandom,_pos,[],0,"CAN_COLLIDE"];
	_clueIdc = _clueIdc + 1;
	_posN = [0,0,0];
	waitUntil {
		_distOk = false;
		_toWlk = 100 + random 50;
		waitUntil {
			_posN = getPos _bMan;
			_distOk = _posN distance _pos >= _toWlk;
			_distOk || !alive _bMan
		};
		if (_distOk) then {
			_pos = _posN;
			(BRPVP_corruptMissObjs select _idc) pushBack createVehicle [_clues call BIS_fnc_selectRandom,_pos,[],0,"CAN_COLLIDE"];
			_clueIdc = _clueIdc + 1;
		};
		!alive _bMan || _clueIdc > 19
	};
	if (alive _bMan) then {_bMan setDamage 1;};
};