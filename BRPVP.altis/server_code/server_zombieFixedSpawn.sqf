BRPVP_zombieCitys = [];
_used = [];
{
	_x params ["_powerArray","_quantityArray","_spawnRad","_locals"];
	_allLocs = (nearestLocations [BRPVP_centroMapa,_locals,20000]) - _used;
	if (count _allLocs > 0) then {
		_index = floor random count _powerArray;
		_zType = _powerArray select _index;
		_quantity = _quantityArray select _index;
		_index = floor random count _allLocs;
		_loc = _allLocs select _index;
		_used pushBack _loc;
		_locP = locationPosition _loc;
		BRPVP_zombieCitys pushBack [_locP,"BRP_imagens\icones3d\z_power" + str (_zType min 5) + ".paa"];
		_locP set [2,0];
		_ruas = _locP nearRoads _spawnRad;
		for "_i" from 1 to _quantity do {
			_locP2 = _locP;
			_rad = _spawnRad max 25;
			if (count _ruas > 0) then {
				_rua = _ruas call BIS_fnc_selectRandom;
				_locP2 = getPosATL _rua;
				_locP2 set [2,0];
				_rad = 30;
			};
			_zombieClass = BRPVP_zombiesClasses call BIS_fnc_SelectRandom;
			_pos = [_locP2,random _rad,random 360] call BIS_fnc_relPos;
			for "_i" from 1 to 50 do {
				if !(surfaceIsWater _pos) exitWith {};
				_pos = [_locP2,(random _rad) + _i*4,random 360] call BIS_fnc_relPos;
			};
			_zombie = createAgent [_zombieClass,_pos,[],0,"NONE"];
			_zombie setVehiclePosition [ASLToAGL getPosASL _zombie,[],0,"NONE"];
			_zombie setVariable ["ifz",[_zType,true,if (random 1 < 0.5) then {floor random 2} else {-1}],true];
			_zombie call BRPVP_pelaUnidade;
			_zombie addUniform (BRPVP_zombiesUniforms call BIS_fnc_selectRandom);
			{_zombie setHit [_x,0.8];} forEach ["body","spine1","spine2","spine3"];
			{_zombie setHit [_x,0.9];} forEach ["face_hub","neck","head","arms","hands"];
			_zombie setVariable ["dmg",0,true];
			_zombie setVariable ["brpvp_impact_damage",0,true];
			_zombie forceSpeed (_zombie getSpeed "FAST");
			BRPVP_walkersObj pushBack _zombie;
		};
	};
} forEach BRPVP_fixedZombiesAmount;
BRPVP_addZombieBrainSV append BRPVP_walkersObj;
publicVariable "BRPVP_zombieCitys";