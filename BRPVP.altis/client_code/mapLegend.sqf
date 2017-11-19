disableSerialization;
waitUntil {!isNull findDisplay 12};

/*
_ar = 4/3;
_vsz = 0.05*BRPVP_mapLegendSize;
_legn = 9;
_ctrl = (findDisplay 12) ctrlCreate ["RscText",-1];
_ctrl ctrlSetPosition [safezoneX + safezoneW - (_vsz*8/_ar+0.012/_ar),safezoneY + safezoneH - (_vsz*_legn*1.1+0.012),_vsz*8/_ar+0.012/_ar,_vsz*_legn*1.1+0.012];
_ctrl ctrlSetBackgroundColor [1,1,1,0.45];
_ctrl ctrlCommit 0;
for "_i" from 1 to _legn do {
	_ctrl = (findDisplay 12) ctrlCreate ["RscPicture",-1];
	_ctrl ctrlSetPosition [safezoneX + safezoneW - _vsz*8/_ar,safezoneY + safezoneH - _vsz*_i*1.1,_vsz*8/_ar,_vsz];
	_ctrl ctrlSetText (localize "str_legend_path" + str _i + ".paa");
	_ctrl ctrlCommit 0;
};
*/
_ar = 4/3;
_vsz = 0.4*BRPVP_mapLegendSize;
_ctrl = (findDisplay 12) ctrlCreate ["RscPicture",-1];
_ctrl ctrlSetPosition [safezoneX + safezoneW - _vsz/_ar,safezoneY + safezoneH - _vsz*2,_vsz/_ar,_vsz*2];
_ctrl ctrlSetText (localize "str_legend_path" + "0.paa");
_ctrl ctrlCommit 0;