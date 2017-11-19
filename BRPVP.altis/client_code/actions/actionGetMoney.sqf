_obj = _this select 3;
[player,_obj getVariable ["mny",0]] call BRPVP_qjsAdicClassObjeto;
_obj setVariable ["mny",0,true];
playSound "negocio";
if (typeOf _obj in ["Land_Suitcase_F"]) then {
	deleteVehicle _obj;
};