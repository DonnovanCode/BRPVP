diag_log "[BRPVP FILE] playerFillAndSpawnRevive.sqf INITIATED";

//DISABLE DAMAGE
player allowDamage false;

//TELA PRETA
cutText ["","BLACK FADED",20];

//X SECONDS UNIT MOVEMENT CHECK
_init = time;

//SET CAPTIVE STATE
if (BRPVP_playerIsCaptive) then {
	player setCaptive true;
};

//GET PLAYER DATA FROM BODY (REVIVE) OR DATA BASE
cutText [localize "str_spawn_returning_life","BLACK FADED",10];

//POSICAO
playSound3D [BRPVP_missionRoot + "BRP_sons\wakeup.ogg",BRPVP_playerLastCorpse,false,getPosASL BRPVP_playerLastCorpse,1,1,100];
[player,true] call BRPVP_hideObject;
sleep 0.25;
player setPosASL ((getPosASL BRPVP_playerLastCorpse) vectorAdd [0,0,0.5]);
player setDir getDir BRPVP_playerLastCorpse;
waitUntil {time - _init >= 3};
player playActionNow "Crouch";
waitUntil {time - _init >= 5};

//============== TRANSFER ITEMS BEGIN ==============
//GET BODY GEAR
_plyDef = BRPVP_playerLastCorpse call BRPVP_pegaEstadoPlayer;
_plyOk = [];
{_plyOk pushBack (_plyDef select _x);} forEach [1,2,3,4,5,6,7,9,11,10,12,13,14];
_resultadoCompilado = [_plyOk];

//PELA PLAYER (DEIXA ELE PELADO)
false call BRPVP_escolheModaPlayer;

//MONEY
_money = _resultadoCompilado select 0 select 10;
player setVariable ["mny",_money,true];

//SPECIAL ITEMS
_sit = _resultadoCompilado select 0 select 11;
player setVariable ["sit",_sit,true];

//MONEY BANK
_moneyBank = _resultadoCompilado select 0 select 12;
player setVariable ["brpvp_mny_bank",_moneyBank,true];

//CAPACETE E OCULOS
_modelo = _resultadoCompilado select 0 select 4;
if (_modelo select 1 != "") then {player addHeadGear (_modelo select 1);};
if (_modelo select 2 != "") then {player addGoggles (_modelo select 2);};

//COMPARTILHAMENTO PADRAO
player setVariable ["stp",_resultadoCompilado select 0 select 9,true];

//ID DO BANCO DE DADOS
_id_bd = _resultadoCompilado select 0 select 8;
player setVariable ["id_bd",_id_bd,true];

//ASSIGNED PLAYER E (ARMAS + ASSIGNED)
_inventario = _resultadoCompilado select 0 select 0;

//ASSIGNED PLAYER
{player addWeapon _x;} forEach (_inventario select 0);

//ADICIONA VEST PARA RECEBER MAGAZINES DAS ARMAS
player addBackpack "B_Carryall_oli";

//ARMA PRIMARIA
_wep = _inventario select 1 select 0;
if (_wep != "") then {
	{player addMagazine _x;} forEach (_inventario select 1 select 2);
	player addWeapon _wep;
	{if (_x != "") then {player addPrimaryWeaponItem _x;};} forEach (_inventario select 1 select 1);
};

//ARMA SECUNDARIA
_wep = _inventario select 2 select 0;
if (_wep != "") then {
	{player addMagazine _x;} forEach (_inventario select 2 select 2);
	player addWeapon _wep;
	{if (_x != "") then {player addSecondaryWeaponItem _x;};} forEach (_inventario select 2 select 1);
};

//ARMA TERCIARIA
_wep = _inventario select 3 select 0;
if (_wep != "") then {
	{player addMagazine _x;} forEach (_inventario select 3 select 2);
	player addWeapon _wep;
	{if (_x != "") then {player addHandGunItem _x;};} forEach (_inventario select 3 select 1);
};

//REMOVE VEST UTILIZADA PARA RECEBER MAGAZINES DAS ARMAS
removeBackpack player;

//BACKPACK
_backpack = _resultadoCompilado select 0 select 1;
if ((_backpack select 0) select 0 != "") then {
	player addBackpack ((_backpack select 0) select 0);
	_BpObjeto = backpackContainer player;
	clearWeaponCargoGlobal _BpObjeto;
	clearItemCargoglobal _BpObjeto;
	clearMagazineCargoGlobal _BpObjeto;
	{_BpObjeto addWeaponCargoGlobal [_x,_backpack select 0 select 1 select 0 select 1 select _forEachIndex];} forEach (_backpack select 0 select 1 select 0 select 0);
	{_BpObjeto addItemCargoGlobal [_x,_backpack select 0 select 1 select 1 select 1 select _forEachIndex];} forEach (_backpack select 0 select 1 select 1 select 0);
	{_BpObjeto addMagazineAmmoCargo [_x select 0,1,_x select 1];} forEach (_backpack select 0 select 1 select 2);
};

//VEST
if ((_backpack select 1) select 0 != "") then {
	player addVest ((_backpack select 1) select 0);
	_BpObjeto = vestContainer player;
	clearWeaponCargoGlobal _BpObjeto;
	clearItemCargoglobal _BpObjeto;
	clearMagazineCargoGlobal _BpObjeto;
	{_BpObjeto addWeaponCargoGlobal [_x,_backpack select 1 select 1 select 0 select 1 select _forEachIndex];} forEach (_backpack select 1 select 1 select 0 select 0);
	{_BpObjeto addItemCargoGlobal [_x,_backpack select 1 select 1 select 1 select 1 select _forEachIndex];} forEach (_backpack select 1 select 1 select 1 select 0);
	{_BpObjeto addMagazineAmmoCargo [_x select 0,1,_x select 1];} forEach (_backpack select 1 select 1 select 2);
};

//UNIFORME
if ((_backpack select 2) select 0 != "") then {
	player forceAddUniform ((_backpack select 2) select 0); //TESTE TESTE TESTE
	_BpObjeto = uniformContainer player;
	clearWeaponCargoGlobal _BpObjeto;
	clearItemCargoglobal _BpObjeto;
	clearMagazineCargoGlobal _BpObjeto;
	{_BpObjeto addWeaponCargoGlobal [_x,_backpack select 2 select 1 select 0 select 1 select _forEachIndex];} forEach (_backpack select 2 select 1 select 0 select 0);
	{_BpObjeto addItemCargoGlobal [_x,_backpack select 2 select 1 select 1 select 1 select _forEachIndex];} forEach (_backpack select 2 select 1 select 1 select 0);
	{_BpObjeto addMagazineAmmoCargo [_x select 0,1,_x select 1];} forEach (_backpack select 2 select 1 select 2);
};
//============== TRANSFER ITEMS END ==============

[player,false] call BRPVP_hideObject;
if (BRPVP_disabledWeapon != "") then {
	BRPVP_playerLastCorpse setPos [-10000,-10000,0];
	[BRPVP_playerLastCorpse,true] call BRPVP_hideObject;
	BRPVP_corpseToDelAdd = BRPVP_playerLastCorpse;
	if (isServer) then {["",BRPVP_corpseToDelAdd] call BRPVP_corpseToDelAddFnc;} else {publicVariableServer "BRPVP_corpseToDelAdd";};
} else {
	deleteVehicle BRPVP_playerLastCorpse;
};
BRPVP_playerLastCorpse = objNull;
playSound3D [BRPVP_missionRoot + "BRP_sons\revive.ogg",player,false,getPosASL player,1,1,80];

//SAUDE
_saude = _resultadoCompilado select 0 select 3;

//DAMAGE
diag_log ("[BRPVP REVIVE-SPAWN DMG] Come Back Damage (max of 0.5) = " + str (BRPVP_disabledDamage + BRPVP_disabledBleed));
_damage = (BRPVP_disabledDamage + BRPVP_disabledBleed) min 0.5;
_damage = _damage * 2;
_damage = (_damage max 0.2) min 0.9;
_damage = (-2 + sqrt(4 - 4 * _damage))/(-2);
player setDamage _damage;
player allowDamage true;
{player setHitIndex [_forEachIndex,_damage,false];} forEach (_saude select 0 select 0);
player allowDamage false;
call BRPVP_atualizaDebug;
cutText ["","PLAIN",1];

//SET PLAYER AS OWNER OF HINSELF
player setVariable ["own",player getVariable "id_bd",true];

//UPDATE PLAYER ICON ON MAP
["geral"] call BRPVP_atualizaIcones;

//SPAWN OK
player setVariable ["sok",true,true];

//UPDATE AMIGOS
call BRPVP_daUpdateNosAmigos;
BRPVP_PUSV = true;
publicVariable "BRPVP_PUSV";

//UNBLOCK KEYBOARD
BRPVP_keyBlocked = false;

BRPVP_disabledDamage = 0;
BRPVP_disabledBleed = 0;

player enableStamina false;

//TIMER TO UPDATE CONNECTION ID
if (isNil "BRPVP_updateConnectionID") then {
	BRPVP_updateConnectionID = 1;
	0 spawn {
		sleep BRPVP_timeOnlineToCountConnection;
		BRPVP_countPlayerConnection = player getVariable ["id_bd",-1];
		if (isServer) then {["",BRPVP_countPlayerConnection] call BRPVP_countPlayerConnectionFnc;} then {publicVariableServer "BRPVP_countPlayerConnection";};
	};
};

//PLAYER TRAITS
player setUnitTrait ["engineer",true];
player setUnitTrait ["explosiveSpecialist",true];
player setUnitTrait ["medic",true];

//TURN OFF PLAYER GOD MODE
player allowDamage true;

//PLAYER RATING
player addRating 1000000;

//REDUCE SWAY
player setCustomAimCoef 0.25;

//FEDIDEX MENU
BRPVP_actionFedidex = player addAction ["<t color='#AAAAFF'>Fedidex Express</t>",{49 call BRPVP_iniciaMenuExtra;},"",1.5,false];

player setVariable ["brpvp_zombies_on_me",0,true];

BRPVP_statusBarOnOverall = true;
call BRPVP_atualizaDebug;

diag_log "[BRPVP FILE] playerFillAndSpawnRevive.sqf END REACHED";