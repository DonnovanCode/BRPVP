_price = BRPVP_dismantleRespawnPrice;
_money = player getVariable "mny";
if (_money >= _price) then {
	_obj = _this select 3;
	player setVariable ["mny",_money - _price,true];
	playSound "negocio";
	BRPVP_avisaExplosao = [_obj,[]];
	if (isServer) then {["",BRPVP_avisaExplosao] call BRPVP_avisaExplosaoFnc;} else {publicVariableServer "BRPVP_avisaExplosao";};
	waitUntil {isNull _obj};
} else {
	playSound "erro";
	[localize "str_no_money",0] call BRPVP_hint;
};
