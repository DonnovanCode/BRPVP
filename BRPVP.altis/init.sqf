cutText ["","BLACK FADED",10];
if (isNil "BRPVP_primeiraRodadaOk") then {
	call compile preprocessFileLineNumbers "mapVariables.sqf";
	call compile preprocessFileLineNumbers "generalVariables.sqf";
	call compile preprocessFileLineNumbers "brpvp_zombies_config.sqf";
	call compile preprocessFileLineNumbers "serverAndClientFunctions.sqf";
	call compile preprocessFileLineNumbers "precalculated.sqf";
	call compile preprocessFileLineNumbers "brpvp_fpsBoost.sqf";
};
if (isNil "BRPVP_setTerrainGridClient") then {
	setTerrainGrid BRPVP_terrainGrid;
} else {
	setTerrainGrid BRPVP_setTerrainGridClient;
};
if (isNil "BRPVP_primeiraRodadaOk") then {
	0 spawn {
		if (isServer) then {
			sleep 0.001;
			if (isDedicated) then {BRPVP_serverIsDedicated = true;} else {BRPVP_serverIsDedicated = false;};
			publicVariable "BRPVP_serverIsDedicated";
			EAST setFriend [EAST,1];
			EAST setFriend [CIVILIAN,1];
			EAST setFriend [WEST,0];
			EAST setFriend [INDEPENDENT,0];
			WEST setFriend [WEST,1];
			WEST setFriend [CIVILIAN,0];
			WEST setFriend [EAST,0];
			WEST setFriend [INDEPENDENT,0];
			INDEPENDENT setFriend [INDEPENDENT,1];
			INDEPENDENT setFriend [CIVILIAN,0];
			INDEPENDENT setFriend [EAST,0];
			INDEPENDENT setFriend [WEST,0];
			CIVILIAN setFriend [INDEPENDENT,0];
			CIVILIAN setFriend [CIVILIAN,1];
			CIVILIAN setFriend [EAST,1];
			CIVILIAN setFriend [WEST,0];
			BRPVP_timeMultiplier = (BRPVP_timeMultiplier max 1) min 48;
			if (BRPVP_timeMultiplier != 1) then {setTimeMultiplier BRPVP_timeMultiplier;};
			setViewDistance BRPVP_viewDist;
			setObjectViewDistance BRPVP_viewObjsDist;
			call compile preProcessFileLineNumbers "server_code\servidor_init.sqf";
			sleep 0.001;
			BRPVP_serverBelezinha = true;
			publicVariable "BRPVP_serverBelezinha";
			diag_log "[BRPVP] SERVER STUFF LOADED! NOW STARTING CLIENTS...";
		};
	};
};
if (hasInterface) then {
	waitUntil {!isNull player};
	player setVariable ["god",0,true];
	player setVariable ["cmb",false,true];
	player setVariable ["sok",false,true];
	player setVariable ["veh",objNull,true];
	player setVariable ["cmv",cameraView,true];
	player setVariable ["dstp",1,true];
	player setVariable ["bui",objNull,true];
	player setVariable ["owt",[],true];
	player setVariable ["brpvp_fps",diag_fps,true];
	player allowDamage false;
	player call BRPVP_pelaUnidade;
	if (isNil "BRPVP_primeiraRodadaOk") then {
		BRPVP_serverTimeSend = serverTime;
		publicVariableServer "BRPVP_serverTimeSend";
		enableRadio false;
		enableSentences false;
	};
	player setVariable ["umok",false,true];
	player addWeapon "ItemMap";
	if (!isNil "BRPVP_terminaMissao" && {BRPVP_terminaMissao}) then {
		sleep 10;
		endMission "END1";
	};
	if (isNil "BRPVP_serverBelezinha") then {
		sleep 1;
		_txt = "<img size='8.0' align='center' image='BRP_imagens\interface\status_bar\zombie_icon.paa'/><br/><t size='2' align='center' color='#FFFF00'>"+(localize "str_populating")+"</tr><br/><t size='2' align='center' color='#FFFF00'>"+(localize "str_server")+"</tr><br/>";
		hint parseText _txt;
		_count = 1;
		waitUntil {
			hintSilent parseText (_txt + "<t size='2' align='center' color='#FF7700'>" + str _count + "</tr>");
			_count = _count + 1;
			cutText ["","BLACK FADED",10];
			if (getOxygenRemaining player < 0.6) then {player setOxygenRemaining 1;};
			sleep 1;
			!isNil "BRPVP_serverBelezinha"
		};
		hint parseText (_txt + "<t size='2' align='center' color='#FF7700'>" + str _count + "</tr><br/><t color='#FF0000' size='2'>"+(localize "str_deploying")+"</tr>");
	};
	call compile preprocessFileLineNumbers "client_code\playerInit.sqf";
};