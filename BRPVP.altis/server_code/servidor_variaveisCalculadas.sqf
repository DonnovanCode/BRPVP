BRPVP_gruposDeInfantaria = [];
{
	{
		_unitsCfg = "true" configClasses _x;
		_groupInfo = [];
		{
			_model = getText (_x >> "vehicle");
			_rank = getText (_x >> "rank");
			_groupInfo append [[_model,_rank]];
		} forEach _unitsCfg;
		BRPVP_gruposDeInfantaria append [_groupInfo];
		diag_log ("INFANTRY GROUPS FOR PATROL " + str [_groupInfo]);
	} forEach ("true" configClasses _x);
} forEach BRPVP_patrolAIGroups;

//ACHA CIDADES, AEROPORTOS E MARINAS
_locais = [
	[200,nearestLocations [BRPVP_centroMapa,["NameVillage"],20000]],
	[200,nearestLocations [BRPVP_centroMapa,["NameCity"],20000]],
	[500,nearestLocations [BRPVP_centroMapa,["NameCityCapital"],20000]],
	[400,nearestLocations [BRPVP_centroMapa,["Airport"],20000]]
	//[250,nearestLocations [BRPVP_centroMapa,["NameMarine"],20000]]
];

//CRIA ARRAY COM OS LOCAIS
if (isNil "BRPVP_locaisImportantes") then {
	BRPVP_locaisImportantes = [];
	diag_log "BRPVP_locaisImportantes = [";
	{
		_subLocaisRaio = _x select 0;
		_subLocais = _x select 1;
		{
			_local = _x;
			_localPos = locationPosition _local;
			_localPos set [2,0];
			_localNome = text _local;
			if (_localNome == "") then {_localNome = "Aeroporto";};
			_sobrepoem = false;
			{
				if (_localPos distance (_x select 0) < (_subLocaisRaio max (_x select 1))) exitWith {_sobrepoem = true;};
			} forEach BRPVP_locaisImportantes;
			if (!_sobrepoem) then {
				BRPVP_locaisImportantes pushBack [_localPos,_subLocaisRaio,_localNome,1];
				diag_log ("	" + str [_localPos,_subLocaisRaio,_localNome,1]);
			};
		} forEach _subLocais;
	} forEach _locais;
	diag_log "];";
	BRPVP_respawnPlaces = +BRPVP_locaisImportantes;
	_locais = nil;
};

//ACHA LOCAIS DE CURA E CRIA ARRAY
BRPVP_locaisDeCura = [];
{BRPVP_locaisDeCura pushBack [getPosATL _x,16,"",0];} forEach (nearestObjects [BRPVP_centroMapa,BRPVP_mapaRodando select 1,20000]);

//ENVIA CLIENTE
publicVariable "BRPVP_locaisImportantes";
publicVariable "BRPVP_respawnPlaces";
publicVariable "BRPVP_locaisDeCura";

//CRUZAMENTOS DE RUAS
BRPVP_isecs = [];
_minDist = (BRPVP_mapaRodando select 10)^2;
{
	_rua = _x;
	if (count roadsConnectedTo _x > 2) then {
		_sozinha = true;
		{
			if (_rua distanceSqr _x < _minDist) exitWith {
				_sozinha = false;
			};
		} forEach BRPVP_isecs;
		if (_sozinha) then {BRPVP_isecs = BRPVP_isecs + [position _x];};
	};
} forEach BRPVP_ruas;