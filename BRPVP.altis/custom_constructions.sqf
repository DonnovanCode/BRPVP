diag_log "[BRPVP EXTRA] LOADING KEY BUILDINGS FOR ALTIS.";

//TRADERS BUILDINGS AND ATM MACHINES
{
	_pos = _x select 0 select 0;
	_vdu = _x select 0 select 1;
	_class = _x select 1;
	_simpleObject =  _x select 2;
	_obj = objNull;
	if (_simpleObject) then {
		_obj = createSimpleObject [_class,[0,0,0]];
	} else {
		_obj = createVehicle [_class,[0,0,0],[],100,"CAN_COLLIDE"];
	};
	_obj setPosWorld _pos;
	_obj setVectorDirAndUp _vdu;
	_obj allowDamage false;
} forEach [
	[[[11848.1,9483.96,18.9228],[[0.644622,0.764501,0],[0,0,1]]],"Land_Grave_obelisk_F",false],
	[[[11898.6,9455.38,16.9432],[[0.81459,0.580038,0],[0,0,1]]],"Land_JumpTarget_F",false],
	[[[9218.53,8074.26,44.9485],[[-0.395272,0.918564,0],[0,0,1]]],"Land_Grave_obelisk_F",false],
	[[[9219.46,8071.56,43.5617],[[-0.378056,0.921061,0.0933873],[-0.0406593,-0.117296,0.992264]]],"Land_TouristShelter_01_F",true],
	[[[9219.22,8068.92,42.0276],[[-0.90062,-0.430929,-0.0564336],[-0.0159101,-0.0970717,0.99515]]],"Land_GardenPavement_02_F",true],
	[[[9222.57,8070.27,42.2358],[[0.904174,0.422055,0.065869],[-0.0211998,-0.109674,0.993742]]],"Land_GardenPavement_02_F",true],
	[[[9220.32,8067.89,41.9567],[[-0.882183,-0.467939,-0.0527925],[-0.0159396,-0.0823712,0.996474]]],"Land_GardenPavement_02_F",true],
	[[[9223.57,8069.34,42.1584],[[0.917481,0.390913,0.0735869],[-0.0316677,-0.112626,0.993133]]],"Land_GardenPavement_02_F",true],
	[[[9221.41,8066.98,41.9046],[[-0.855934,-0.513615,-0.0598023],[-0.0185932,-0.085007,0.996207]]],"Land_GardenPavement_02_F",true],
	[[[9224.66,8068.34,42.0905],[[0.920325,0.387341,0.0544945],[-0.0223091,-0.0871122,0.995949]]],"Land_GardenPavement_02_F",true],
	[[[9214.81,8075.38,43.2043],[[-0.3821,0.91897,0.0974341],[-0.0333402,-0.119074,0.992326]]],"Land_Stone_8m_F",true],
	[[[9222.52,8076.8,43.704],[[-0.0270294,-0.984314,-0.174342],[-0.0500451,-0.172854,0.983675]]],"Land_Stone_8m_F",true],
	[[[9230.26,8075.25,43.69],[[0.350509,0.922425,0.162099],[-0.0152389,-0.167439,0.985765]]],"Land_Stone_8m_F",true],
	[[[11559.2,7051.81,79.546],[[0.94373,-0.330718,0],[0,0,1]]],"Land_i_Addon_03_V1_F",true],
	[[[11566.2,7049.34,79.4967],[[0.942293,-0.33479,0],[0,0,1]]],"Land_i_Addon_03mid_V1_F",true],
	[[[11572.9,7046.96,79.4076],[[-0.942,0.335612,0],[0,0,1]]],"Land_i_Addon_04_V1_F",true],
	[[[11572.8,7044.04,81.0432],[[0.93777,-0.347256,0],[0,0,1]]],"Land_WoodenShelter_01_F",true],
	[[[11580.2,7051.47,80.6216],[[0.400141,0.916454,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[11575.8,7039.61,79.8764],[[-0.978426,0.206597,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[11552.3,7047.23,81.0309],[[0.945169,-0.326581,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[11556.9,7059.44,81.7623],[[0.261148,0.965299,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[11564.9,7054.35,80.5732],[[-0.227002,0.973894,0],[0,0,1]]],"Land_PortableLight_single_F",false],
	[[[11570.4,7052.33,80.5732],[[0.892451,0.451144,0],[0,0,1]]],"Land_PortableLight_single_F",false],
	[[[11723.4,11864,22.9231],[[0.548433,0.836194,0],[0,0,1]]],"Land_JumpTarget_F",false],
	[[[11708.4,11840.2,22.8218],[[-0.838358,0.54512,0],[0,0,1]]],"Land_JumpTarget_F",false],
	[[[11709.5,11807.8,34.8747],[[-0.117312,-0.993095,0],[0,0,1]]],"Land_LampAirport_F",false],
	[[[11683.4,11857.8,35.1577],[[-0.814364,0.580355,0],[0,0,1]]],"Land_LampAirport_F",false],
	[[[11700,11886,35.2439],[[-0.843883,0.536527,0],[0,0,1]]],"Land_LampAirport_F",false],
	[[[11751.8,11877.3,35.402],[[0.754703,0.656066,0],[0,0,1]]],"Land_LampAirport_F",false],
	[[[7560.03,12180.7,35.8488],[[-0.97189,-0.235437,0],[0,0,1]]],"Land_LampHarbour_F",false],
	[[[4321.1,14508.8,55.9323],[[0.0736955,-0.997281,0],[0,0,1]]],"Land_JumpTarget_F",false],
	[[[4322.15,14486.6,52.2012],[[-0.999105,-0.0423028,0],[0,0,1]]],"Land_JumpTarget_F",false],
	[[[4597.53,10302.6,15.0452],[[-0.558391,-0.829578,0],[0,0,1]]],"Land_i_Addon_03_V1_F",true],
	[[[4593.43,10296.5,14.9799],[[-0.560698,-0.82802,0],[0,0,1]]],"Land_i_Addon_03mid_V1_F",true],
	[[[4589.5,10290.6,14.8968],[[0.552306,0.833642,0],[0,0,1]]],"Land_i_Addon_04_V1_F",true],
	[[[4586.65,10291.4,16.5263],[[-0.55124,-0.834347,0],[0,0,1]]],"Land_WoodenShelter_01_F",true],
	[[[4592.46,10282.4,15.4009],[[0.595673,0.803227,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[4581.48,10290.6,15.995],[[0.54407,0.83904,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[4595.14,10310,15.5559],[[-0.613473,-0.789715,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[4605.19,10302.8,15.5597],[[-0.525112,-0.851033,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[4598.52,10296.6,16.0563],[[0.999243,0.0389045,0],[0,0,1]]],"Land_PortableLight_single_F",false],
	[[[4595.25,10291.7,16.0563],[[0.2286,-0.97352,0],[0,0,1]]],"Land_PortableLight_single_F",false],
	[[[11388,14205.4,20.949],[[0.86243,-0.506177,0],[0,0,1]]],"Land_JumpTarget_F",false],
	[[[11398,14218.6,21.2037],[[0.78305,-0.621958,0],[0,0,1]]],"Land_JumpTarget_F",false],
	[[[8609.68,15459.2,124.595],[[-0.996989,-0.0775449,0],[0,0,1]]],"Land_TouristShelter_01_F",true],
	[[[8610.06,15466.3,126.127],[[-0.00282463,-0.999996,0],[0,0,1]]],"Land_LampHarbour_F",false],
	[[[8625.06,15512.6,123.567],[[-0.310458,-0.950587,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[8634.61,15509.5,123.793],[[-0.20904,-0.977907,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[8545.12,15647.5,106.828],[[0.960412,-0.278584,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[8541.64,15637,107.33],[[0.997982,-0.0635048,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[8431.18,15726.3,103.745],[[0.530241,-0.847847,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[8422.38,15722.2,103.856],[[0.378654,-0.925538,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[8419.31,15745.5,102.946],[[0.97849,-0.206296,0],[0,0,1]]],"ArrowDesk_R_F",true],
	[[[8423.71,15759.5,103.047],[[-0.97725,0.212091,0],[0,0,1]]],"ArrowDesk_L_F",true],
	[[[3017.28,18501.7,34.52],[[-0.751686,0.659521,0],[0,0,1]]],"Land_TouristShelter_01_F",true],
	[[[3012.85,18498.6,36.0389],[[0.807864,0.589369,0],[0,0,1]]],"Land_LampHarbour_F",false],
	[[[3068.15,18457,32.8209],[[0.997145,-0.0755039,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[3066.37,18445.9,32.2229],[[0.987265,-0.159086,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[3040,18452.7,32.1992],[[-0.977578,-0.210572,0],[0,0,1]]],"ArrowDesk_R_F",true],
	[[[3034.53,18471.3,33.3399],[[-0.984049,0.177898,0],[0,0,1]]],"ArrowMarker_R_F",true],
	[[[7288.07,13947.3,175.267],[[-0.997472,-0.0710655,0],[0,0,1]]],"Land_i_Addon_03_V1_F",true],
	[[[7280.69,13946.8,175.222],[[-0.997576,-0.0695824,0],[0,0,1]]],"Land_i_Addon_03mid_V1_F",true],
	[[[7273.57,13946.2,175.129],[[0.997503,0.0706289,0],[0,0,1]]],"Land_i_Addon_04_V1_F",true],
	[[[7272.41,13948.9,176.778],[[-0.997818,-0.0660211,0],[0,0,1]]],"Land_WoodenShelter_01_F",true],
	[[[7292.45,13940.9,175.85],[[-0.993129,-0.117023,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[7269.66,13939.7,175.568],[[0.999535,0.0304869,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[7269.09,13952.4,176.049],[[0.999105,0.0422975,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[7291.75,13953.8,176.073],[[0.997052,0.0767316,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[7283.9,13942.7,176.298],[[0.62673,-0.779236,0],[0,0,1]]],"Land_PortableLight_single_F",false],
	[[[7277.94,13942.3,176.298],[[-0.61019,-0.792255,0],[0,0,1]]],"Land_PortableLight_single_F",false],
	[[[4210.71,12822.4,23.1195],[[-0.626737,-0.779231,0],[0,0,1]]],"Land_TouristShelter_01_F",true],
	[[[4206,12825.4,24.6554],[[0.920386,-0.391012,0],[0,0,1]]],"Land_LampHarbour_F",false],
	[[[4173.51,12893.6,22.5869],[[-0.159823,0.987146,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[4159.19,12891.3,22.0397],[[-0.17321,0.984885,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[4202.49,12858.8,23.5789],[[0.722221,0.691663,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[4203.13,12858,21.7538],[[0.939549,0.342414,0],[0,0,1]]],"ArrowDesk_R_F",true],
	[[[11504.3,15634.7,54.2524],[[-0.877714,-0.479185,0],[0,0,1]]],"Land_TouristShelter_01_F",true],
	[[[11500.5,15639.1,55.911],[[0.881164,-0.47281,0],[0,0,1]]],"Land_LampHarbour_F",false],
	[[[11522.6,15662.2,54.3792],[[0.145495,0.989359,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[11533.7,15659.7,54.2945],[[0.97954,-0.201252,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[9162.14,21606.4,15.0107],[[-0.770344,-0.637629,0],[0,0,1]]],"Land_JumpTarget_F",false],
	[[[9185.51,21620.4,15.0017],[[0.850891,0.525343,0],[0,0,1]]],"Land_JumpTarget_F",false],
	[[[26807.7,24630.8,22.2257],[[0.696944,-0.717126,0],[0,0,1]]],"Land_JumpTarget_F",false],
	[[[26787.3,24605.6,23.1063],[[-0.785431,0.618949,0],[0,0,1]]],"Land_JumpTarget_F",false],
	[[[26841.3,24634.2,34.5494],[[0.745057,-0.667001,0],[0,0,1]]],"Land_LampAirport_F",false],
	[[[26815.1,24604.2,35.4343],[[-0.591287,-0.806461,0],[0,0,1]]],"Land_LampAirport_F",false],
	[[[5155.65,21050.5,241.027],[[0.949979,0.312314,0],[0,0,1]]],"Land_i_Addon_03_V1_F",true],
	[[[5162.62,21052.8,240.978],[[0.952047,0.305951,0],[0,0,1]]],"Land_i_Addon_03mid_V1_F",true],
	[[[5169.4,21055,240.898],[[-0.951832,-0.306621,0],[0,0,1]]],"Land_i_Addon_04_V1_F",true],
	[[[5171.09,21052.6,242.424],[[0.947964,0.318378,0],[0,0,1]]],"Land_WoodenShelter_01_F",true],
	[[[5149.7,21055.7,241.476],[[-0.939389,-0.342852,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[5154.03,21043,242.209],[[0.935165,0.354212,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[5175.22,21049.9,242.1],[[0.939519,0.342496,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[5171.62,21062.6,241.849],[[-0.271852,0.962339,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[5158.67,21056,242.054],[[-0.725836,0.687867,0],[0,0,1]]],"Land_PortableLight_single_F",false],
	[[[5164.22,21057.7,242.054],[[0.350409,0.936597,0],[0,0,1]]],"Land_PortableLight_single_F",false],
	[[[7118.91,18918.8,202.978],[[0.714368,0.69977,0],[0,0,1]]],"Land_TouristShelter_01_F",true],
	[[[7095.94,18931.8,206.698],[[-0.672788,0.732313,0.105233],[0.0689486,-0.0795563,0.994443]]],"Land_LampDecor_F",false],
	[[[7087.6,18923.5,206.514],[[-0.69714,0.708695,0.10839],[0.0561776,-0.096722,0.993725]]],"Land_LampDecor_F",false],
	[[[7122.5,18917.3,204.613],[[-0.992975,0.117293,0.0155855],[0.0133295,-0.0199942,0.999711]]],"Land_LampHarbour_F",false],
	[[[13543.2,20037.7,30.0057],[[-0.0293207,0.99957,0],[0,0,1]]],"Land_i_Addon_03_V1_F",true],
	[[[13543,20045.1,29.958],[[-0.0299812,0.99955,0],[0,0,1]]],"Land_i_Addon_03mid_V1_F",true],
	[[[13542.9,20052.2,29.8573],[[0.021244,-0.999774,0],[0,0,1]]],"Land_i_Addon_04_V1_F",true],
	[[[13545.6,20053.1,31.5244],[[-0.0157572,0.999876,0],[0,0,1]]],"Land_WoodenShelter_01_F",true],
	[[[13550.5,20033.7,31.265],[[-0.0409371,0.999162,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[13549.5,20056.5,31.2861],[[-0.0485466,0.998821,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[13535.4,20056.6,31.2997],[[0.0263037,-0.999654,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[13535.9,20033.6,31.0815],[[0.999721,0.0236105,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[13538.9,20041.9,31.0344],[[-0.876211,-0.481927,0],[0,0,1]]],"Land_PortableLight_single_F",false],
	[[[13538.7,20048,31.0344],[[-0.754904,0.655835,0],[0,0,1]]],"Land_PortableLight_single_F",false],
	[[[11602.3,19499.7,73.3037],[[-0.813358,0.579806,0.0476794],[0.0194361,-0.054829,0.998307]]],"Land_JumpTarget_F",false],
	[[[11617.8,19484.5,72.2971],[[-0.578815,-0.813775,0.0523768],[0.0583458,0.0227367,0.998038]]],"Land_JumpTarget_F",false],
	[[[11629.6,19508.7,74.7324],[[0.671281,-0.740488,-0.0325551],[0.023186,-0.0229221,0.999468]]],"Land_Shed_Small_F",true],
	[[[27766.2,22217.1,20.1547],[[0.0170317,-0.999855,0],[0,0,1]]],"Land_TouristShelter_01_F",true],
	[[[27760.5,22216.1,21.748],[[0.846447,0.532472,0],[0,0,1]]],"Land_LampHarbour_F",false],
	[[[27751.5,22249.5,21.2468],[[-0.354553,0.935036,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[27762.5,22252.1,21.2069],[[-0.182201,0.983261,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[23702.7,23702.9,13.9378],[[0.0194026,-0.999812,0],[0,0,1]]],"Land_i_Addon_03_V1_F",true],
	[[[23702.8,23695.5,13.8835],[[0.018268,-0.999833,0],[0,0,1]]],"Land_i_Addon_03mid_V1_F",true],
	[[[23702.9,23688.4,13.7995],[[-0.0153762,0.999882,0],[0,0,1]]],"Land_i_Addon_04_V1_F",true],
	[[[23700.2,23687.4,15.4399],[[0.0249049,-0.99969,0],[0,0,1]]],"Land_WoodenShelter_01_F",true],
	[[[23695.7,23707.2,14.1729],[[-0.0519645,0.998649,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[23709.6,23708.1,15.7709],[[0.0344074,-0.999408,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[23710.2,23684.4,15.5751],[[0.060862,-0.998146,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[23696.3,23683.7,14.3701],[[-0.0319097,0.999491,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[23706.9,23698.6,14.9599],[[0.82287,0.56823,0],[0,0,1]]],"Land_PortableLight_single_F",false],
	[[[23707.1,23692.5,14.9599],[[0.838225,-0.545324,0],[0,0,1]]],"Land_PortableLight_single_F",false],
	[[[25426.1,20339.2,9.94749],[[-0.89633,-0.443388,0],[0,0,1]]],"Land_JumpTarget_F",false],
	[[[25441.3,20318.1,9.8996],[[0.590882,-0.806758,0],[0,0,1]]],"Land_JumpTarget_F",false],
	[[[23184.2,21801.1,33.6789],[[0.193571,-0.981086,0],[0,0,1]]],"Land_LampHarbour_F",false],
	[[[23189.1,21782.1,33.3333],[[-0.608743,0.793367,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[23202.2,21787.5,34.5594],[[-0.651208,0.758899,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[25374.8,19304.4,27.5423],[[0.657743,0.753242,0],[0,0,1]]],"Land_i_Addon_04_V1_F",true],
	[[[25379.5,19309.7,27.6324],[[0.662036,0.749472,0],[0,0,1]]],"Land_i_Addon_03mid_V1_F",true],
	[[[25384.4,19315.2,27.6735],[[-0.67066,-0.741765,0],[0,0,1]]],"Land_i_Addon_03_V1_F",true],
	[[[25381.2,19322.6,28.413],[[-0.692261,-0.721647,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[25392.3,19313.4,29.1369],[[-0.641204,-0.767371,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[25377.2,19296.5,28.5185],[[-0.602828,-0.797871,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[25366.9,19305.8,28.6087],[[0.798369,-0.602169,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[25372.1,19305.5,29.1788],[[-0.652982,-0.757374,0],[0,0,1]]],"Land_WoodenShelter_01_F",true],
	[[[25384.7,19309.3,28.7088],[[0.99882,-0.0485652,0],[0,0,1]]],"Land_PortableLight_single_F",false],
	[[[25380.7,19304.8,28.7088],[[0.156087,-0.987743,0],[0,0,1]]],"Land_PortableLight_single_F",false],
	[[[22563.6,16381.7,16.1021],[[-0.438871,0.89855,0],[0,0,1]]],"Land_LampHarbour_F",false],
	[[[22536.9,16462.7,15.8401],[[-0.933954,0.357393,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[22542,16471,15.8502],[[-0.909485,0.415737,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[22584.8,16418.1,15.516],[[0.487852,-0.872927,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[20118,20038.6,18.959],[[-0.609921,0.792463,0],[0,0,1]]],"Land_JumpTarget_F",false],
	[[[20109.5,20027.4,18.7485],[[-0.972227,0.234038,0],[0,0,1]]],"Land_JumpTarget_F",false],
	[[[18455.6,16852.3,39.3737],[[-0.999097,-0.0424825,0],[0,0,1]]],"Land_i_Addon_03_V1_F",true],
	[[[18448.2,16852.1,39.3339],[[-0.999394,-0.0347964,0],[0,0,1]]],"Land_i_Addon_03mid_V1_F",true],
	[[[18441.1,16851.8,39.2454],[[0.999329,0.0366201,0],[0,0,1]]],"Land_i_Addon_04_V1_F",true],
	[[[18440.1,16854.5,40.9203],[[-0.99835,-0.0574154,0],[0,0,1]]],"Land_WoodenShelter_01_F",true],
	[[[18451.5,16847.9,40.4074],[[0.535977,-0.844233,0],[0,0,1]]],"Land_PortableLight_single_F",false],
	[[[18445.2,16847.8,40.4103],[[-0.545002,-0.838435,0],[0,0,1]]],"Land_PortableLight_single_F",false],
	[[[18459.3,16845.9,41.4557],[[-0.990615,-0.136679,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[18459.4,16859.5,39.3852],[[-0.999399,-0.0346663,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[18442.5,16852.8,34.2863],[[0.999206,0.0398346,0],[0,0,1]]],"Land_ConcreteBlock_01_F",true],
	[[[18436.1,16858.5,38.6785],[[0.994382,0.105847,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[18437.1,16844.9,40.4055],[[0.999773,0.0213046,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[20779.3,7218.44,29.2699],[[-0.902638,-0.430401,0],[0,0,1]]],"Land_JumpTarget_F",false],
	[[[20815.9,7238.54,28.9542],[[-0.47845,0.878115,0],[0,0,1]]],"Land_JumpTarget_F",false],
	[[[20780.8,7182.07,42.3833],[[0.185383,-0.982666,0],[0,0,1]]],"Land_LampAirport_F",false],
	[[[20753.4,7219.83,42.3995],[[-0.929435,0.368986,0],[0,0,1]]],"Land_LampAirport_F",false],
	[[[20844.5,7243.92,40.5462],[[0.941181,0.337903,0],[0,0,1]]],"Land_LampAirport_F",false],
	[[[21292.6,10462,8.41479],[[-0.284538,-0.958665,0],[0,0,1]]],"Land_i_Addon_03_V1_F",true],
	[[[21290.4,10455,8.36967],[[-0.292458,-0.956278,0],[0,0,1]]],"Land_i_Addon_03mid_V1_F",true],
	[[[21288.3,10448.1,8.28644],[[0.290687,0.956818,0],[0,0,1]]],"Land_i_Addon_04_V1_F",true],
	[[[21285.4,10448,9.93609],[[-0.282954,-0.959133,0],[0,0,1]]],"Land_WoodenShelter_01_F",true],
	[[[21280.4,10445.9,9.8398],[[0.964698,-0.26336,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[21293.3,10441.9,10.8493],[[0.288612,0.957446,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[21300.5,10463.6,9.25232],[[-0.93854,0.345171,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[21286.9,10467.9,9.43363],[[-0.26671,-0.963777,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[21295.4,10456.7,9.44609],[[0.979377,0.202039,0],[0,0,1]]],"Land_PortableLight_single_F",false],
	[[[21293.6,10450.6,9.44609],[[0.474599,-0.880202,0],[0,0,1]]],"Land_PortableLight_single_F",false],
	[[[20243.1,8949.83,48.6027],[[0.673714,0.738992,0],[0,0,1]]],"Land_TouristShelter_01_F",true],
	[[[20247.6,8947.37,49.9814],[[-0.998234,-0.0594003,0],[0,0,1]]],"Land_LampHarbour_F",false],
	[[[20227.3,8930.84,49.6521],[[-0.702363,-0.711819,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[20274.7,8904.73,46.4414],[[-0.756351,0.654166,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[20265.2,8895.81,46.5126],[[-0.727432,0.68618,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[17647.8,10586.8,34.1201],[[0.69398,0.719994,0],[0,0,1]]],"Land_JumpTarget_F",false],
	[[[17324.5,17440.7,73.6734],[[0.242973,0.970033,0],[0,0,1]]],"Land_TouristShelter_01_F",true],
	[[[17330.4,17441.1,75.2188],[[-0.929696,-0.368328,0],[0,0,1]]],"Land_LampHarbour_F",false],
	[[[17291.2,17429.6,72.8576],[[-0.810159,0.58621,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[17284.7,17419.3,72.5174],[[-0.89685,0.442335,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[17345.9,17427.2,73.8442],[[0.990723,0.135898,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[14338,21816.3,100.405],[[0.953717,0.300706,0],[0,0,1]]],"Land_TouristShelter_01_F",true],
	[[[14340.7,21812.1,102.474],[[-0.779615,0.626259,0],[0,0,1]]],"Land_LampHarbour_F",false],
	[[[14286.4,21737.3,96.1679],[[0.0118332,0.99993,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[14298.2,21734.4,95.6533],[[0.260932,0.965357,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[14296.9,21820.4,98.8354],[[0.82853,0.559944,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[14303.3,21811.8,99.0905],[[0.855357,0.518038,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[14327.4,21795.4,100.119],[[0.658095,0.752935,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[14316.3,21801.8,99.6754],[[0.518879,0.854848,0],[0,0,1]]],"Land_LampDecor_F",false],
	[[[14339.6,21817.8,99.9527],[[0.949736,0.313051,0],[0,0,1]]],"Land_Slums01_8m",true],
	[[[14338,21822.4,99.4689],[[-0.959831,-0.28058,0],[0,0,1]]],"Land_TinWall_01_m_4m_v1_F",true],
	[[[14341.5,21810.2,100.164],[[0.969081,0.212377,0.125608],[-0.137759,0.0433581,0.989516]]],"Land_PipeFence_02_s_8m_F",true],
	[[[14339.1,21803.8,100.021],[[0.56872,-0.818869,0.0775316],[-0.129489,0.00395086,0.991573]]],"Land_PipeFence_02_s_8m_F",true],
	[[[14324.7,21813.7,99.2886],[[0.911079,0.403554,0.0841353],[-0.0868145,-0.0116887,0.996156]]],"Land_Stone_8m_F",true],
	[[[14323,21817.8,98.9718],[[-0.971115,-0.211183,-0.111074],[-0.112612,-0.00476928,0.993628]]],"Land_Stone_pillar_F",true],
	[[[14318.9,21816.7,98.6745],[[0.239271,-0.970736,0.0205037],[-0.115223,-0.00742023,0.993312]]],"Land_Stone_8m_F",true],
	[[[14326.5,21809.7,98.904],[[-0.490681,0.871213,-0.0148471],[-0.0585588,-0.0159709,0.998156]]],"Land_Stone_pillar_F",true],
	[[[14323.9,21801.2,98.7692],[[-0.680806,-0.723289,-0.115568],[-0.0887037,-0.0752036,0.993215]]],"Land_Stone_Gate_F",false],
	[[[14324.2,21806.3,99.0633],[[-0.826873,0.560238,-0.0491321],[-0.0841737,-0.0369072,0.995767]]],"Land_Stone_8m_F",true],
	[[[14327.3,21798,99.0858],[[-0.658848,-0.739267,-0.139296],[-0.117445,-0.0818159,0.989703]]],"Land_Stone_4m_F",true],
	[[[14332.5,21799.1,99.6418],[[0.577212,-0.816109,0.0281454],[-0.106138,-0.040805,0.993514]]],"Land_Stone_8m_F",true],
	[[[14328.9,21796.6,98.8064],[[0.615533,-0.788071,0.00789572],[-0.117445,-0.0818159,0.989703]]],"Land_Stone_pillar_F",true],
	[[[14332.5,21832,99.1626],[[0.964126,0.264973,0.0158613],[-0.0173284,0.00319987,0.999845]]],"Land_PipeFence_02_s_8m_F",true],
	[[[14328,21839.6,98.7411],[[0.708205,0.70589,0.0128789],[-0.0573846,0.0393721,0.997576]]],"Land_PipeFence_02_s_8m_F",true],
	[[[14311.1,21814.8,97.8793],[[0.212522,-0.976472,0.0365713],[-0.0846558,0.0188866,0.996231]]],"Land_Stone_8m_F",true],
	[[[14305.2,21813.8,97.5095],[[0.0617499,-0.997574,0.032146],[-0.0423439,0.0295601,0.998666]]],"Land_Stone_4m_F",true],
	[[[14301.6,21816,97.2455],[[-0.834225,-0.55142,0.00238586],[-0.0170477,0.0301151,0.999401]]],"Land_Stone_Gate_F",false],
	[[[14299,21819.9,97.2909],[[0.852928,0.522026,-0.00192523],[-0.0122637,0.0237241,0.999643]]],"Land_Stone_4m_F",true],
	[[[14297.9,21821.8,96.6472],[[-0.767891,-0.640418,0.0144165],[-0.00613138,0.0298525,0.999536]]],"Land_Stone_pillar_F",true],
	[[[14300.9,21824.2,97.1387],[[0.609976,-0.792019,0.0252111],[-0.0412908,4.00251e-006,0.999147]]],"Land_Stone_8m_F",true],
	[[[14306.8,21828.7,97.4754],[[-0.604236,0.795214,-0.0503361],[-0.0802262,0.00213554,0.996774]]],"Land_Stone_8m_F",true],
	[[[14312.7,21833.2,97.9229],[[-0.603378,0.794309,-0.0707648],[-0.0936798,0.0175226,0.995448]]],"Land_Stone_8m_F",true],
	[[[14318.8,21837.9,98.4071],[[-0.595506,0.798807,-0.085316],[-0.101554,0.0304939,0.994363]]],"Land_Stone_8m_F",true],
	[[[14323.4,21841.6,98.6336],[[-0.656721,0.746544,-0.106724],[-0.0657216,0.0843244,0.994269]]],"Land_Stone_4m_F",true],
	[[[20124.7,20043.9,20.0139],[[0.839527,0.540895,0.0512434],[-0.0651931,0.00665224,0.99785]]],"Land_PortableLight_double_F",false],
	[[[20113.1,20045.6,19.5111],[[-0.559307,0.828959,-0.00149152],[-0.00266672,0,0.999996]]],"Land_PortableLight_double_F",false],
	[[[20102.5,20022.1,18.9334],[[-0.78273,-0.620902,-0.0425894],[-0.0309038,-0.0295717,0.999085]]],"Land_PortableLight_double_F",false],
	[[[20114.6,20020.9,19.3535],[[0.682072,-0.73068,0.0297459],[-0.0492638,-0.00532665,0.998772]]],"Land_PortableLight_double_F",false],
	[[[17642,10592.5,35.5696],[[-0.686305,0.726214,0.0399764],[0.0173179,-0.0386321,0.999103]]],"Land_PortableLight_double_F",false],
	[[[17653.7,10592.7,35.7893],[[0.675127,0.737031,0.0314387],[-0.0159915,-0.0279853,0.99948]]],"Land_PortableLight_double_F",false],
	[[[13540.5,20034.5,28.5739],[[-0.0954853,0.995431,0],[0,0,1]]],"Land_Atm_02_F",false],
	[[[5151.8,21052.1,239.61],[[0.950174,0.311719,0],[0,0,1]]],"Land_Atm_02_F",false],
	[[[4601.42,10303.8,13.6172],[[-0.552444,-0.83355,0],[0,0,1]]],"Land_Atm_02_F",false],
	[[[7291.39,13944.7,173.837],[[-0.997475,-0.0710137,0],[0,0,1]]],"Land_Atm_02_F",false],
	[[[11557.1,7055.46,79.4622],[[0.942945,-0.33295,0],[0,0,1]]],"Land_Atm_02_F",false],
	[[[21296,10464.3,7.38462],[[-0.295259,-0.955417,0],[0,0,1]]],"Land_Atm_02_F",false],
	[[[18458.9,16849.7,38.8571],[[-0.99923,-0.0392417,0],[0,0,1]]],"Land_Atm_02_F",false],
	[[[25388.6,19315.7,27.0783],[[-0.683846,-0.729626,0],[0,0,1]]],"Land_Atm_02_F",false],
	[[[23498.6,18403.1,5.52158],[[-0.176847,0.984238,0],[0,0,1]]],"Land_PartyTent_01_F",true],
	[[[23494.3,18398.7,3.51175],[[-0.993302,-0.115549,0],[0,0,1]]],"Land_PlasticBarrier_02_F",true],
	[[[23494,18400.9,3.51175],[[-0.99755,-0.0699616,0],[0,0,1]]],"Land_PlasticBarrier_02_F",true],
	[[[23493.4,18403.5,3.51175],[[0.986052,0.166435,0],[0,0,1]]],"Land_PlasticBarrier_02_F",true],
	[[[23493.1,18405.6,3.51175],[[0.989428,0.145022,0],[0,0,1]]],"Land_PlasticBarrier_02_F",true],
	[[[23504.2,18400.3,3.51175],[[0.983062,0.183271,0],[0,0,1]]],"Land_PlasticBarrier_02_F",true],
	[[[23503.7,18402.6,3.51175],[[0.983062,0.183271,0],[0,0,1]]],"Land_PlasticBarrier_02_F",true],
	[[[23503,18407.4,3.51175],[[0.991121,0.132964,0],[0,0,1]]],"Land_PlasticBarrier_02_F",true],
	[[[23503.1,18405.4,3.51175],[[0.991121,0.132964,0],[0,0,1]]],"Land_PlasticBarrier_02_F",true],
	[[[23502.9,18398.8,3.51175],[[0.11501,-0.993364,0],[0,0,1]]],"PlasticBarrier_02_grey_F",true],
	[[[23500.8,18398.5,3.51175],[[0.0870017,-0.996208,0],[0,0,1]]],"PlasticBarrier_02_grey_F",true],
	[[[23498,18397.9,3.51175],[[0.178981,-0.983853,0],[0,0,1]]],"PlasticBarrier_02_grey_F",true],
	[[[23496,18397.6,3.51175],[[0.142633,-0.989776,0],[0,0,1]]],"PlasticBarrier_02_grey_F",true],
	[[[23502.1,18406.3,3.38219],[[0.99665,0.0817892,0],[0,0,1]]],"Land_Bench_05_F",true],
	[[[23502.5,18401.1,3.76181],[[-0.491967,-0.870614,0],[0,0,1]]],"Land_PalletTrolley_01_yellow_F",true],
	[[[23502,18411.9,6.29354],[[0.189625,-0.981857,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[23492.3,18409.8,6.29354],[[0.178465,-0.983946,0],[0,0,1]]],"Land_LampStreet_small_F",false],
	[[[23498.8,18402.4,4.37203],[[0.121995,-0.992531,0],[0,0,1]]],"Land_Atm_01_F",false],
	[[[4198.89,12837.4,22.6654],[[-0.687742,-0.725955,0],[0,0,1]]],"Land_Atm_02_F",false],
	[[[21254.7,17119.9,27.8988],[[0.61746,-0.786602,0],[0,0,1]]],"Land_Atm_01_F",false],
	[[[19954.6,11432.7,61.5074],[[-0.581127,0.813813,0],[0,0,1]]],"Land_Atm_01_F",false],
	[[[8721.5,18552.1,170.688],[[-0.971294,0.237884,0],[0,0,1]]],"Land_TouristShelter_01_F",true],
	[[[8720.38,18552.4,170.611],[[-0.975238,0.221158,0],[0,0,1]]],"Land_Atm_01_F",false],
	[[[6051.23,16210.1,44.2876],[[0.0399054,0.999203,0],[0,0,1]]],"Land_Atm_02_F",false],
	[[[6010.54,19826.7,239.341],[[0.518769,-0.854914,0],[0,0,1]]],"Land_Atm_02_F",false],
	[[[21234.6,7092.64,24.7121],[[-0.683889,-0.729586,0],[0,0,1]]],"Land_Atm_01_F",false],
	[[[25762.6,21740.5,31.4755],[[0.718465,-0.695563,0],[0,0,1]]],"Land_Atm_01_F",false],
	[[[12657,16360.7,35.6361],[[-0.611765,-0.79104,0],[0,0,1]]],"Land_Atm_02_F",false]	
];

_reference = [13712.8,16707.7,28.4042];
BRPVP_travelingAidPlaces = [];
BRPVP_travelingAidTraders = [];
{
	_x params ["_center","_angle","_radius","_name"];
	_diference = _center vectorDiff _reference;
	_diference set [2,0];
	{
		_pos = ASLToAGL (_x select 0 select 0);
		_pos = AGLToASL (_pos vectorAdd _diference);
		_vdu = _x select 0 select 1;
		_class = _x select 1;
		_simpleObject =  _x select 2;
		_code = _x select 3;
		_obj = objNull;
		if (_simpleObject) then {
			_obj = createSimpleObject [_class,[0,0,0]];
		} else {
			_obj = createVehicle [_class,[0,0,0],[],100,"CAN_COLLIDE"];
		};
		_obj setPosWorld _pos;
		_obj setVectorDirAndUp _vdu;
		_obj allowDamage false;
		_obj call _code;
	} forEach [
		[[[13727.7,16731.3,19.3289],[[-0.540339,-0.841448,0],[0,0,1]]],"Land_SCF_01_shed_F",true,{}],
		[[[13735.7,16693.6,19.255],[[0.834798,-0.550556,0],[0,0,1]]],"Land_SCF_01_shed_F",true,{}],
		[[[13689.7,16722.6,19.3385],[[-0.854238,0.519883,0],[0,0,1]]],"Land_SCF_01_shed_F",true,{}],
		[[[13698.3,16685,20.022],[[-0.533522,-0.845786,0],[0,0,1]]],"Land_SCF_01_shed_F",true,{}],
		//[[[13712.8,16707.7,28.4042],[[-0.545174,-0.838323,0],[0,0,1]]],"Land_SCF_01_crystallizerTowers_F",true,{BRPVP_travelingAidPlaces pushBack [_center,_radius,localize "str_aid_title" + " " + _name,4]}],
		[[[13712.8,16707.7,17.4042],[[-0.545174,-0.838323,0],[0,0,1]]],"Land_SCF_01_shredder_F",true,{BRPVP_travelingAidPlaces pushBack [_center,_radius,_name,4]}],
		[[[13692.8,16701.8,26.9985],[[0.3122,0.950016,0],[0,0,1]]],"Land_LampAirport_F",false,{}],
		[[[13732.7,16712.7,27.6062],[[-0.469819,-0.882763,0],[0,0,1]]],"Land_LampAirport_F",false,{}],
		[[[13717,16683.8,17.7349],[[0.53196,0.846769,0],[0,0,1]]],"Land_PartyTent_01_F",true,{}],
		[[[13717.3,16684.3,16.6168],[[0.480373,0.877064,0],[0,0,1]]],"Land_Atm_01_F",false,{_posTrader = ASLToAGL _pos;_posTrader set [2,0];BRPVP_travelingAidTraders pushBack [[_posTrader,8,215 - 90] call BIS_fnc_relPos,215]}],
		[[[13712.4,16683.7,15.6628],[[-0.826991,0.562215,0],[0,0,1]]],"Land_Bench_04_F",true,{}],
		[[[13715.3,16688,15.7318],[[-0.860971,0.508653,0],[0,0,1]]],"Land_Bench_04_F",true,{}],
		[[[13741.2,16719.1,17.2348],[[0.789945,-0.613177,0],[0,0,1]]],"Land_BC_Basket_F",true,{}],
		[[[13760.2,16706.2,17.1083],[[-0.829149,0.559028,0],[0,0,1]]],"Land_BC_Basket_F",true,{}],
		[[[13707.6,16741.4,38.0159],[[-0.877427,0.47971,0],[0,0,1]]],"Land_TTowerBig_2_F",false,{}],
		[[[13695.5,16704.3,16.5548],[[0.860518,-0.509421,0],[0,0,1]]],"Land_Grave_obelisk_F",false,{}],
		[[[13733,16708.4,17.2663],[[-0.495917,-0.86837,0],[0,0,1]]],"Land_Grave_obelisk_F",false,{}],
		[[[13701.9,16671.1,16.8621],[[-0.813227,0.581947,0],[0,0,1]]],"Land_Grave_obelisk_F",false,{}],
		[[[13723.8,16745.5,16.2992],[[0.854409,-0.519601,0],[0,0,1]]],"Land_Grave_obelisk_F",false,{}],
		[[AGLToASL ((ASLToAGL [13568.7,20560.5,39.0748]) vectorAdd [13712.8-13623,16707.7-20571,0]),[[-0.833289,0.552838,0],[0,0,1]]],"Land_Tank_rust_F",false,{}],
		[[AGLToASL ((ASLToAGL [13629.3,20518.1,37.9136]) vectorAdd [13712.8-13623,16707.7-20571,0]),[[0.538785,0.842444,0],[0,0,1]]],"Land_LampHarbour_F",false,{}],
		[[AGLToASL ((ASLToAGL [13565.4,20555.3,40.4265]) vectorAdd [13712.8-13623,16707.7-20571,0]),[[0.548308,0.836276,0],[0,0,1]]],"Land_LampHarbour_F",false,{}],
		[[AGLToASL ((ASLToAGL [13636.0,20511.7,35.6111]) vectorAdd [13712.8-13623,16707.7-20571,0]),[[-0.863082,0.505064,0],[0,0,1]]],"WaterPump_01_sand_F",false,{}],
		[[AGLToASL ((ASLToAGL [13636.0,20520.4,37.2710]) vectorAdd [13712.8-13623,16707.7-20571,0]),[[0.840244,-0.542208,0],[0,0,1]]],"Land_FuelStation_02_workshop_F",false,{}]
	];
} forEach [
	[[13623,20571,0],000,100,"A"],
	[[27243,22063,0],045,100,"B"],
	[[10845,09267,0],090,100,"C"],
	[[07456,11298,0],135,100,"D"],
	[[02711,10042,0],180,100,"E"],
	[[19623,14918,0],225,100,"F"],
	[[21549,19132,0],270,100,"G"],
	[[20144,08200,0],315,100,"H"]
];
publicVariable "BRPVP_travelingAidPlaces";
publicVariable "BRPVP_travelingAidTraders";
