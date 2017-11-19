//REVOLTOSOS
if !(BRPVP_mapaRodando select 7 select 0) exitWith {
	BRPVP_revoltosos = [];
	publicVariable "BRPVP_revoltosos";
};
_revWeps = [
	["arifle_MX_F","30Rnd_65x39_caseless_mag_Tracer",4],
	["SMG_02_F","30Rnd_9x21_Mag",4],
	["LMG_Zafir_pointer_F","150Rnd_762x54_Box_Tracer",2],
	["srifle_EBR_ACO_F","20Rnd_762x51_Mag",3],
	["hgun_Pistol_heavy_02_F","6Rnd_45ACP_Cylinder",5]
];
_contaRev = 0;
BRPVP_revoltosos = [];
_revQT = BRPVP_mapaRodando select 7 select 1;
for "_i" from 1 to _revQT do {
	_house = objNull;
	while {isNull _house} do {
		_try = BRPVP_mtdr_lootTable_bobj call BIS_fnc_selectRandom;
		if (_try getVariable ["id_bd",-1] == -1) then {_house = _try;};
	};
	_grupo = createGroup [INDEPENDENT,true];
	_revoltoso = _grupo createUnit ["C_man_p_beggar_F",[0,0,0],[],0,"CAN_COLLIDE"];
	_revoltoso addBackpack "B_Carryall_khk";
	_revBp = unitBackpack _revoltoso;
	_revWep = _revWeps call BIS_fnc_selectRandom;
	_revBp addMagazineCargoGlobal [_revWep select 1,_revWep select 2];
	_revoltoso addWeapon (_revWep select 0);
	_revoltoso addEventHandler ["killed",{_this call BRPVP_botDaExp;}];
	_revoltoso addEventHandler ["handleDamage",{_this call BRPVP_hdeh}];
	_revoltoso setpos ((_house buildingPos -1) call BIS_fnc_selectRandom);
	//_revoltoso setUnitPos "UP";
	_revoltoso setSkill 0.3;
	_angulo = random 360;
	_revoltoso setDir _angulo;
	BRPVP_revoltosos pushBack _revoltoso;
	_contaRev = _contaRev + 1;
};
publicVariable "BRPVP_revoltosos";