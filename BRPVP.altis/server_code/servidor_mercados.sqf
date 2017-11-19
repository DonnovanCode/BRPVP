//TRADER MAN CREATION
_createTraderMan = {
	private ["_m"];
	_m = createAgent ["C_man_sport_1_F_afro",_this,[],12,"CAN_COLLIDE"];
	_m setPosASL AGLToASL _this;
	_m allowDamage false;
	_m setCaptive true;
	_m disableAI "TARGET";
	_m disableAI "AUTOTARGET";
	_m disableAI "MOVE";
	_m disableAI "ANIM";
	_m disableAI "TEAMSWITCH";
	_m disableAI "FSM";
	_m disableAI "AIMINGERROR";
	_m disableAI "SUPPRESSION";
	_m disableAI "CHECKVISIBLE";
	_m disableAI "COVER";
	_m disableAI "AUTOCOMBAT";
	_m disableAI "PATH";
	_m enableSimulation false;
	_m
};

//ARRAY COM OS MERCADORES
BRPVP_mercadorObjs = [];

//INICIA COLOCACAO DOS MERCADOS E MERCADORES
_objIgnora = [];
{
	private ["_trrDaVez","_mMainObj"];
	_pos = _x select 0;
	_angle = _x select 1;

	//CRIAR O MERCADOR
	_mercador = _pos call _createTraderMan;
	_mercador setVariable ["mcdr",_forEachIndex mod 20,true];
	_mercador setDir _angle;

	//CREATE ANTIZOMBIE STRUCTURE
	_pos set [2,0];
	_azs = createVehicle [BRPVP_antiZombieStructuresServerCreated call BIS_fnc_SelectRandom,_pos,[],0,"NONE"];
	_azs setDir random 360;
	_azs setVectorUp [0,0,1];
	_azs setVariable ["azs",true,true];
	_azs allowDamage false;

	//ADICIONA MERCADOR NO ARRAY DE MERCADORES
	BRPVP_mercadorObjs pushBack _mercador;
} forEach BRPVP_terrPosArray;
publicVariable "BRPVP_mercadorObjs";

//AID TRADERS
{
	_pos = _x select 0;
	_angle = _x select 1;

	//CRIAR O MERCADOR
	_mercador = _pos call _createTraderMan;
	_mercador setVariable ["mcdr",20,true];
	_mercador setVariable ["brpvp_price_level",BRPVP_travelingAidPriceLevel,true];
	_mercador setVariable ["brpvp_item_filter",2,true];
	_mercador setDir _angle;
} forEach BRPVP_travelingAidTraders;

//LOCAIS MERCADORES
BRPVP_mercadoresPos = [];
{
	BRPVP_mercadoresPos pushBack [position _x,80,BRPVP_mercadoresEstoque select ((_x getVariable ["mcdr",-1]) mod (count BRPVP_mercadoresEstoque)) select 1,2];
} forEach BRPVP_mercadorObjs;
publicVariable "BRPVP_mercadoresPos";

//MERCADOS VEICULOS
BRPVP_vendaveObjs = [];
{
	_local = _x select 0;
	_contato =  createVehicle ["Land_PhoneBooth_01_F",_local,[],0,"CAN_COLLIDE"];
	_contato allowDamage false;
	_contato setVariable ["vndv",_x select 1,true];
	_contato setVariable ["vndv_deployType","x_on_ground",true];
	_contato setVariable ["vndv_elevator",false,true];
	BRPVP_vendaveObjs pushBack _contato;
	_local set [2,0];
	_azs = createVehicle ["Land_Calvary_01_V1_F",[_contato,6,getDir _contato] call BIS_fnc_relPos,[],0,"NONE"];
	_azs setVectorUp [0,0,1];
	_azs setVariable ["azs",true,true];
	_azs allowDamage false;
} forEach (BRPVP_mapaRodando select 16);
publicVariable "BRPVP_vendaveObjs";

//VEHICLE TRADERS POSITIONS
BRPVP_vehicleTradersPos = [];
{BRPVP_vehicleTradersPos pushBack [position _x,80,"",2];} forEach BRPVP_vendaveObjs;
publicVariable "BRPVP_vehicleTradersPos";

//LOCAL TO PLAYER SELL ITEMS
BRPVP_buyersObjs = [];
{
	_idx = BRPVP_sellTerrainPlaces select 1 select _forEachIndex;
	_pt = _x select 0;
	_ang = _x select 1;
	_t = _pt call _createTraderMan;
	_t setDir _ang;
	_t setVariable ["bbx",[[-15,-15,-15],[15,15,15]],true];
	_t setVariable ["bidx",_idx,true];
	BRPVP_buyersObjs pushBack _t;
	_pt set [2,0];
	_azs = createVehicle [BRPVP_antiZombieStructuresServerCreated call BIS_fnc_SelectRandom,_pt,[],0,"NONE"];
	_azs setDir random 360;
	_azs setVectorUp [0,0,1];
	_azs setVariable ["azs",true,true];
	_azs allowDamage false;
} forEach (BRPVP_sellTerrainPlaces select 0);
publicVariable "BRPVP_buyersObjs";

//BUYERS POSITIONS
BRPVP_buyersPos = [];
{BRPVP_buyersPos pushBack [position _x,80,"",3];} forEach BRPVP_buyersObjs;
publicVariable "BRPVP_buyersPos";