diag_log "[BRPVP FILE] PVEH.sqf STARTING";

//PVEH FUNCTIONS
BRPVP_allMissionsItemBoxFnc = {
	["sempre"] call BRPVP_atualizaIcones;
};
BRPVP_clientGraphHintPlayerFnc = {
	(_this select 1) spawn BIS_fnc_dynamicText;
};
BRPVP_clientStillSurrendedCheckFnc = {
	(_this select 1) spawn {
		BRPVP_walkDisabled = true;
		BRPVP_menuExtraLigado = false;
		if (!isNull findDisplay 602) then {closeDialog 602;};
		sleep 0.25;
		player playMove "AmovPercMstpSsurWnonDnon";
		sleep 2;
		BRPVP_actionDropItems = player addAction ["<t color='#CC0000'>"+localize "str_surr_drop_items"+"</t>","client_code\actions\actionSurrenderDropItems.sqf","",50,true];
		waitUntil {isNull _this || !isPlayer _this || isNull (player getVariable "brpvp_surrendedBy")};
		player removeAction BRPVP_actionDropItems;
		[player,""] call BRPVP_switchMove;
		BRPVP_walkDisabled = false;
	};
};
BRPVP_setTerrainGridClientFnc = {
	setTerrainGrid (_this select 1);
};
BRPVP_remoteRemoveMyStuffFnc = {
	_obj = _this select 1;
	_index = BRPVP_myStuff find _obj;
	if (_index != -1) then {
		BRPVP_myStuff deleteAt _index;
	};
	if (BRPVP_stuff isEqualTo _obj) then {
		BRPVP_stuff = objNull;
	};
};
BRPVP_askPlayersToUpdateFriendsClientFnc = {
	call BRPVP_daUpdateNosAmigos;
};
BRPVP_addWalkerIconsClientFnc = {
	BRPVP_walkersObj = BRPVP_walkersObj - [objNull];
	BRPVP_walkersObj append (_this select 1);
	["bots"] call BRPVP_atualizaIcones;
};
BRPVP_sendAgentConfigToClientFnc = {
	_agnts = _this select 1;
	{
		_agnt = _x select 0;
		_nid = _x select 1;
		if (_nid != 2) then {
			_agnt addEventHandler ["HandleDamage",{_this call BRPVP_zombieHDEH;}];
		} else {
			[_agnt,["HandleDamage",{_this call BRPVP_zombieHDEH;}]] remoteExec ["addEventHandler",2,false];
		};
	} forEach _agnts;
	BRPVP_addZombieBrain append _agnts;
};
BRPVP_newCarAddClientsFnc = {
	BRPVP_carrosObjetos pushBackUnique (_this select 1);
};
BRPVP_newHeliAddClientsFnc = {
	BRPVP_helisObjetos pushBackUnique (_this select 1);
};
BRPVP_variablesObjectsAddFnc = {
	(_this select 1) params ["_o","_n","_v",["_sv",false]];
	_idxo = BRPVP_variablesObjects find _o;
	if (_idxo == -1) then {
		BRPVP_variablesObjects pushBack _o;
		BRPVP_variablesNames pushBack [_n];
		BRPVP_variablesValues pushBack [_v];
	} else {
		_idxn = (BRPVP_variablesNames select _idxo) find _n;
		if (_idxn == -1) then {
			(BRPVP_variablesNames select _idxo) pushBack _n;
			(BRPVP_variablesValues select _idxo) pushBack _v;
		} else {
			(BRPVP_variablesValues select _idxo) set [_idxn,_v];
		};
	};
	if (_sv) then {
		diag_log ("[OBJ VARIABLE RECEIVED FROM SERVER - VAR SET ON SERVER] " + str [_o,_n,_v]);
	} else {
		diag_log ("[OBJ VARIABLE RECEIVED FROM SERVER - VAR SET ON A CLIENT] " + str [_o,_n,_v]);
	};
};
BRPVP_giveMoneyFnc = {
	[player,_this select 1 select 0,_this select 1 select 1] call BRPVP_qjsAdicClassObjeto;
	playSound "negocio";
};
BRPVP_switchMoveCliFnc = {
	(_this select 1) params ["_unit","_state"];
	_unit switchMove _state;
};
BRPVP_closedCityRunningFnc = {
	(_this select 1) call BRPVP_processSiegeIcons;
};
BRPVP_moveInClientFnc = {
	(_this select 1) params ["_unit","_vehicle","_type"];
	if (_type == "Driver") then {_unit moveInDriver _vehicle;};
	if (_type == "Commander") then {_unit moveInCommander _vehicle;};
	if (_type == "Gunner") then {_unit moveInGunner _vehicle;};
	if (_type == "Cargo") then {_unit moveInCargo _vehicle;};
};
BRPVP_ganchoDesviraAddFnc = {
	BRPVP_ganchoDesvira pushBack (_this select 1);
};
BRPVP_ganchoDesviraRemoveFnc = {
	BRPVP_ganchoDesvira = BRPVP_ganchoDesvira - [_this select 1];
};
BRPVP_pegaVaultPlayerBdRetornoFnc = {
	private ["_vault"];
	_resultadoCompilado = call compile (_this select 1);
	_resultadoCompilado = _resultadoCompilado select 1;
	_inventario = _resultadoCompilado select 0 select 0;
	_comp = _resultadoCompilado select 0 select 1;
	_idx = _resultadoCompilado select 0 select 2;
	diag_log "---------------------------------------------------------------------------------------------";
	diag_log ("---- [VAULT ACTIVATED. IDX = " + str _idx + ".VAULT ITEMS ARE:]");
	diag_log ("---- _inventario = " + str _inventario);
	diag_log "---------------------------------------------------------------------------------------------";
	if (_idx == 0) then {
		_vault = BRPVP_holderVault;
	} else {
		_vault = BRPVP_sellReceptacle;
	};
	_vault setVariable ["stp",_comp,true];
	{
		_vault addWeaponCargoGlobal [_x,_inventario select 0 select 1 select _forEachIndex];
	} forEach (_inventario select 0 select 0);
	{
		_vault addMagazineAmmoCargo [_x select 0,1,_x select 1];
	} forEach (_inventario select 1);
	{
		_vault addBackpackCargoGlobal [_x,_inventario select 2 select 1 select _forEachIndex];
	} forEach (_inventario select 2 select 0);
	{
		_vault addItemCargoGlobal [_x,_inventario select 3 select 1 select _forEachIndex];
	} forEach (_inventario select 3 select 0);
	{
		_c = _x select 1;
		clearWeaponCargoGlobal _c;
		clearMagazineCargoGlobal _c;
		clearItemCargoGlobal _c;
		clearBackpackCargoGlobal _c;
	} forEach everyContainer _vault;
	if (_idx == 0) then {
		player setVariable ["wh",_vault,true];
	} else {
		player setVariable ["sr",_vault,true];
	};
};
BRPVP_rapelRopeUnwindPVFnc = {
	if (!isNull (_this select 1 select 0)) then {
		ropeUnwind (_this select 1);
	};
};
BRPVP_svCriaVehRetornoFnc = {
	BRPVP_rapelRope = ropeCreate [_this select 1,[0,0,0],player,[0,0,1],1.5];
};
BRPVP_missBotsEmFnc = {
	["bots"] call BRPVP_atualizaIcones;
};
BRPVP_mudaExpPedidoServidorFnc = {
	(_this select 1) call BRPVP_mudaExp;
};
BRPVP_PUSVFnc = {
	call BRPVP_daUpdateNosAmigos;
};
BRPVP_tocaSomFnc = {
	(_this select 1) params ["_obj","_snd","_dist"];
	_obj say3D [_snd,_dist];
};
BRPVP_hintEmMassaFnc = {
	_input = _this select 1;
	_msg = _input select 0;
	_msg = if (typeName _msg == "ARRAY") then {_input set [0,format ([localize (_msg select 0)] + (_msg select 1))]};
	(_this select 1) call BRPVP_hint;
};
BRPVP_mudouConfiancaEmVoceFnc = {
	(_this select 1) params ["_pAction","_action"];
	if (_action) then {
		[format [localize "str_trust_new",name _pAction],4,15,857] call BRPVP_hint;
	} else {
		[format [localize "str_trust_revoked",name _pAction],4,15,857] call BRPVP_hint;
	};
	call BRPVP_daUpdateNosAmigos;
	BRPVP_tempoUltimaAtuAmigos = time;
};
BRPVP_terminaMissaoFnc = {
	endMission "END1";
};

//PVEH
"BRPVP_fastRopeEnrola" addPublicVariableEventHandler {
	(_this select 1) params ["_corda","_step"];
	ropeUnwind [_corda,5,(((ropeLength _corda) + _step) max 2.5) min 50];
};
"BRPVP_switchMoveRem" addPublicVariableEventHandler {
	(_this select 1) params ["_unid","_move"];
	_unid switchMove _move;
};
"BRPVP_allMissionsItemBox" addPublicVariableEventHandler {_this call BRPVP_allMissionsItemBoxFnc;};
"BRPVP_clientGraphHintPlayer" addPublicVariableEventHandler {_this call BRPVP_clientGraphHintPlayerFnc;};
"BRPVP_clientStillSurrendedCheck" addPublicVariableEventHandler {_this call BRPVP_clientStillSurrendedCheckFnc;};
"BRPVP_setTerrainGridClient" addPublicVariableEventHandler {_this call BRPVP_setTerrainGridClientFnc;};
"BRPVP_remoteRemoveMyStuff" addPublicVariableEventHandler {_this call BRPVP_remoteRemoveMyStuffFnc;};
"BRPVP_mudaExpPedidoServidor" addPublicVariableEventHandler {_this call BRPVP_mudaExpPedidoServidorFnc;};
"BRPVP_mensagemDeKillTxtSend" addPublicVariableEventHandler {(_this select 1) call LOL_fnc_showNotification;};
"BRPVP_askPlayersToUpdateFriendsClient" addPublicVariableEventHandler {_this call BRPVP_askPlayersToUpdateFriendsClientFnc;};
"BRPVP_addWalkerIconsClient" addPublicVariableEventHandler {_this call BRPVP_addWalkerIconsClientFnc;};
"BRPVP_sendAgentConfigToClient" addPublicVariableEventHandler {_this call BRPVP_sendAgentConfigToClientFnc;};
"BRPVP_newCarAddClients" addPublicVariableEventHandler {_this call BRPVP_newCarAddClientsFnc;};
"BRPVP_newHeliAddClients" addPublicVariableEventHandler {_this call BRPVP_newHeliAddClientsFnc;};
"BRPVP_variablesObjectsAdd" addPublicVariableEventHandler {_this call BRPVP_variablesObjectsAddFnc;};
"BRPVP_giveMoney" addPublicVariableEventHandler {_this call BRPVP_giveMoneyFnc;};
"BRPVP_switchMoveCli" addPublicVariableEventHandler {_this call BRPVP_switchMoveCliFnc;};
"BRPVP_closedCityRunning" addPublicVariableEventHandler {_this call BRPVP_closedCityRunningFnc;};
"BRPVP_moveInClient" addPublicVariableEventHandler {_this call BRPVP_moveInClientFnc;};
"BRPVP_ganchoDesviraAdd" addPublicVariableEventHandler {_this call BRPVP_ganchoDesviraAddFnc;};
"BRPVP_ganchoDesviraRemove" addPublicVariableEventHandler {_this call BRPVP_ganchoDesviraRemoveFnc;};
"BRPVP_propriedadeTira" addPublicVariableEventHandler {_this call BRPVP_propriedadeTiraFnc;};
"BRPVP_pegaVaultPlayerBdRetorno" addPublicVariableEventHandler {_this call BRPVP_pegaVaultPlayerBdRetornoFnc;};
"BRPVP_rapelRopeUnwindPV" addPublicVariableEventHandler {_this call BRPVP_rapelRopeUnwindPVFnc;};
"BRPVP_svCriaVehRetorno" addPublicVariableEventHandler {_this call BRPVP_svCriaVehRetornoFnc;};
"BRPVP_missBotsEm" addPublicVariableEventHandler {_this call BRPVP_missBotsEmFnc;};
"BRPVP_PUSV" addPublicVariableEventHandler {_this call BRPVP_PUSVFnc;};
"BRPVP_tocaSom" addPublicVariableEventHandler {_this call BRPVP_tocaSomFnc;};
"BRPVP_hintEmMassa" addPublicVariableEventHandler {_this call BRPVP_hintEmMassaFnc;};
"BRPVP_mudouConfiancaEmVoce" addPublicVariableEventHandler {_this call BRPVP_mudouConfiancaEmVoceFnc;};
"BRPVP_terminaMissao" addPublicVariableEventHandler {_this call BRPVP_terminaMissaoFnc;};

diag_log "[BRPVP FILE] PVEH.sqf END REACHED";