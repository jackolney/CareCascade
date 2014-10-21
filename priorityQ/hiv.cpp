//
//  hiv.cpp
//  priorityQ
//
//  Created by Jack Olney on 20/10/2014.
//  Copyright (c) 2014 Jack Olney. All rights reserved.
//

#include <iostream>
#include "macro.h"
#include "hiv.h"
#include "rng.h"

extern Rng * theRng;

using namespace std;

bool Hiv(const double Age, const bool Sex, const double Time)
{
	
	double hivInc [2] [55] [17] =
	{
		{
		{0.0000000,0.0000000,0.0000000,4.16498E-06,3.43099E-06,2.33239E-06,0,0,0,0,0,0,0,0,0,0,0},
		{0.0000014,0.0000000,0.0000000,2.67575E-05,2.29942E-05,1.75054E-05,9.37113E-06,3.56311E-06,7.60075E-06,4.58579E-06,0,0,0,0,0,0,0},
		{0.0000027,0.0000000,0.0000000,2.44847E-05,2.05194E-05,1.64586E-05,8.80824E-06,3.56387E-06,7.50137E-06,4.40752E-06,0,0,0,0,0,0,0},
		{0.0000045,0.0000000,0.0000000,4.3423E-05,3.64915E-05,2.71722E-05,1.64419E-05,7.09368E-06,1.11502E-05,4.24699E-06,0,0,0,0,0,0,0},
		{0.0000081,0.0000000,0.0000000,7.52126E-05,6.30286E-05,4.782E-05,2.81039E-05,1.39465E-05,2.21684E-05,8.22829E-06,0,0,0,0,0,0,0},
		{0.0000138,0.0000000,0.0000000,0.000125159,0.000105944,8.05624E-05,4.77647E-05,2.35975E-05,3.6798E-05,1.20378E-05,0,0,0,0,0,0,0},
		{0.0000249,0.0000000,0.0000000,0.000251257,0.000212261,0.000162541,9.40251E-05,5.12876E-05,7.71557E-05,2.7565E-05,0,0,7.74647E-06,0,0,0,0},
		{0.0000413,0.0000000,0.0000000,0.000374197,0.000315765,0.000241432,0.000138821,7.52565E-05,0.000113823,3.88307E-05,4.60005E-06,0,7.56069E-06,9.7408E-06,0,0,0},
		{0.0000684,0.0000000,0.0000000,0.000615886,0.000517154,0.000395249,0.000228071,0.000120718,0.000182564,6.15176E-05,4.42862E-06,5.71755E-06,7.36838E-06,9.47867E-06,0,0,0},
		{0.0001124,0.0000000,0.0000000,0.001019918,0.000854796,0.000651503,0.000377644,0.000201429,0.000304901,0.000103127,8.57354E-06,5.48926E-06,1.43163E-05,1.84473E-05,0,0,0},
		{0.0001837,0.0000000,0.0000000,0.001685158,0.001408655,0.001074877,0.000620876,0.000332472,0.000502737,0.000171109,1.25352E-05,1.05386E-05,2.77051E-05,2.69474E-05,0,0,0},
		{0.0002979,0.0000000,0.0000000,0.002733792,0.002307819,0.001755205,0.001012409,0.000543146,0.000821015,0.000277101,2.45925E-05,2.02241E-05,4.67546E-05,5.25417E-05,0,0,0},
		{0.0004839,0.0000000,0.0000000,0.004479322,0.003792389,0.002885819,0.001661012,0.000891936,0.001347968,0.000455311,3.63644E-05,2.9117E-05,7.71203E-05,7.68594E-05,1.18548E-05,0,0},
		{0.0007844,0.0000000,0.0000000,0.007310989,0.006175169,0.004706608,0.002706765,0.001451644,0.0021991,0.000743621,5.9989E-05,4.66991E-05,0.000123464,0.000133075,1.15245E-05,0,0},
		{0.0012551,0.0000000,0.0000000,0.011780014,0.009905408,0.007562739,0.004345907,0.002327119,0.003527346,0.001209468,9.92556E-05,7.67924E-05,0.000201376,0.000209906,2.24049E-05,1.74908E-05,0},
		{0.0019660,0.0000000,0.0000000,0.018387344,0.015398552,0.011767474,0.006748794,0.003609823,0.005476554,0.001902082,0.000150032,0.000123155,0.000312411,0.00031993,3.26822E-05,1.70651E-05,0},
		{0.0029692,0.0000000,0.0000000,0.026939843,0.022623974,0.01723214,0.009839249,0.005255977,0.00798222,0.00280294,0.000220397,0.000180949,0.000451848,0.000465934,4.24066E-05,3.32005E-05,0},
		{0.0042278,0.0000000,0.0000000,0.035656482,0.030009063,0.02275926,0.012963987,0.00691959,0.010511697,0.003703525,0.000286645,0.000237387,0.000594841,0.000613732,5.15826E-05,3.22149E-05,0},
		{0.0056024,0.0000000,0.0000000,0.040775125,0.034371207,0.025971823,0.014794185,0.007893628,0.011997633,0.004220696,0.000331549,0.000268035,0.000682005,0.000699538,6.01492E-05,3.12222E-05,0},
		{0.0068856,0.0000000,0.0000000,0.039368034,0.033228943,0.025048356,0.014308658,0.007639779,0.011611255,0.004073285,0.000333437,0.000261608,0.000659173,0.000677196,6.79955E-05,3.02769E-05,0},
		{0.0079205,0.0000000,0.0000000,0.033046344,0.027901791,0.021005579,0.012058093,0.006448204,0.009791962,0.003429663,0.000289429,0.00022289,0.000556725,0.000572789,5.62741E-05,2.94001E-05,0},
		{0.0086345,0.0000000,0.0000000,0.025638328,0.021677394,0.016379578,0.009427766,0.005029058,0.007630875,0.00267383,0.000230113,0.000172867,0.000434467,0.000445239,4.51479E-05,2.85935E-05,0},
		{0.0090353,0.0000000,0.0000000,0.019600425,0.016589071,0.01257077,0.007223142,0.003859663,0.005849007,0.002051819,0.000180481,0.000135676,0.000336733,0.000345017,3.4712E-05,1.39138E-05,0},
		{0.0091400,0.0000000,0.0000000,0.015545208,0.013162697,0.009988199,0.005714677,0.003066281,0.004644663,0.001627846,0.000141213,0.000106346,0.000265451,0.00027551,2.49869E-05,1.35272E-05,0},
		{0.0090498,0.0000000,0.0000000,0.013017995,0.011020847,0.008360661,0.00476152,0.002568884,0.003890192,0.001361902,0.00011784,8.85216E-05,0.000223191,0.000228345,2.39638E-05,1.31142E-05,0},
		{0.0089295,0.0000000,0.0000000,0.01332606,0.011266855,0.008528769,0.004838807,0.002625303,0.003973956,0.001385989,0.000119283,8.57733E-05,0.000230858,0.000232974,2.29829E-05,1.26693E-05,0},
		{0.0086497,0.0000000,0.0000000,0.012174615,0.010282007,0.007792154,0.004445287,0.002402407,0.003628075,0.001260305,0.000109978,7.81485E-05,0.000208163,0.000212778,2.20371E-05,1.22058E-05,0},
		{0.0082667,0.0000000,0.0000000,0.011240757,0.009483334,0.007200877,0.004124021,0.002213785,0.003349843,0.001160845,0.00010147,7.37878E-05,0.000194708,0.000194236,2.11421E-05,1.17411E-05,0},
		{0.0078087,0.0000000,0.0000000,0.010499469,0.008847653,0.006736086,0.003864091,0.002062959,0.003130282,0.001082216,9.37583E-05,6.92918E-05,0.000180535,0.000182031,2.03474E-05,1.12825E-05,0},
		{0.0072487,0.0000000,0.0000000,0.009862918,0.008295082,0.006331853,0.003629467,0.001937091,0.002937922,0.001015927,8.90714E-05,6.50763E-05,0.000168975,0.00017067,1.31303E-05,1.08327E-05,0},
		{0.0065120,0.0000000,0.0000000,0.00935364,0.007848535,0.006002087,0.003429712,0.001840847,0.002784204,0.000961597,8.28105E-05,6.13053E-05,0.000159555,0.000164825,1.27979E-05,1.03958E-05,0},
		{0.0058459,0.0000000,0.0000000,0.009120078,0.007636879,0.005844952,0.003345086,0.001798219,0.002708461,0.000934481,7.93084E-05,5.7898E-05,0.000156329,0.000159506,1.25494E-05,9.9692E-06,0},
		{0.0052996,0.0000000,0.0000000,0.009134832,0.00763978,0.005846693,0.003355748,0.001798239,0.00271524,0.00093397,8.02009E-05,5.99652E-05,0.000155217,0.000159401,1.23609E-05,9.56206E-06,0},
		{0.0044227,0.0000000,0.0000000,0.009166593,0.007662248,0.005859587,0.003374603,0.001799281,0.002727186,0.000937231,7.93248E-05,5.92819E-05,0.000156444,0.000158581,1.2223E-05,9.19701E-06,0},
		{0.0040936,0.0000000,0.0000000,0.008377514,0.007004077,0.005353529,0.003094438,0.001644343,0.002494207,0.000856238,7.31326E-05,5.39702E-05,0.000143556,0.000146175,1.21251E-05,8.8945E-06,0},
		{0.0033061,0.0000000,0.0000000,0.007641715,0.006391754,0.004883965,0.002830665,0.001505246,0.002271602,0.000781995,6.56025E-05,4.92098E-05,0.000128881,0.000132059,1.20537E-05,8.66048E-06,0},
		{0.0023755,0.0000000,0.0000000,0.007144509,0.005976244,0.004566262,0.002649352,0.00140898,0.002123592,0.000741188,6.19952E-05,4.71009E-05,0.000121621,0.000125892,1.20154E-05,8.4809E-06,0},
		{0.0022691,0.0000000,0.0000000,0.006173429,0.005162848,0.003945951,0.002288948,0.00121944,0.001838063,0.000638517,5.36032E-05,4.11534E-05,0.000106482,0.00011024,1.19893E-05,8.33861E-06,0},
		{0.0016054,0.0000000,0.0000000,0.005663277,0.004733802,0.003618102,0.002095809,0.001118378,0.001690021,0.000579608,4.89395E-05,3.77121E-05,9.54644E-05,9.94111E-05,1.19047E-05,8.22862E-06,0},
		{0.0013650,0.0000000,0.0000000,0.005383738,0.004501528,0.003438451,0.001989169,0.001063169,0.001609479,0.000544262,4.61137E-05,3.64752E-05,9.31134E-05,9.69538E-05,1.16793E-05,8.14644E-06,0},
		{0.0011802,0.0000000,0.0000000,0.005244879,0.004392233,0.003350371,0.00193552,0.001036592,0.001566814,0.000524352,4.49772E-05,3.53458E-05,8.86818E-05,9.11842E-05,1.12792E-05,8.08362E-06,0},
		{0.0011802,0.0000000,0.0000000,0.005244879,0.004392233,0.003350371,0.00193552,0.001036592,0.001566814,0.000524352,4.49772E-05,3.53458E-05,8.86818E-05,9.11842E-05,1.12792E-05,8.08362E-06,0},
		{0.0011802,0.0000000,0.0000000,0.005244879,0.004392233,0.003350371,0.00193552,0.001036592,0.001566814,0.000524352,4.49772E-05,3.53458E-05,8.86818E-05,9.11842E-05,1.12792E-05,8.08362E-06,0},
		{0.0011802,0.0000000,0.0000000,0.005244879,0.004392233,0.003350371,0.00193552,0.001036592,0.001566814,0.000524352,4.49772E-05,3.53458E-05,8.86818E-05,9.11842E-05,1.12792E-05,8.08362E-06,0},
		{0.0011802,0.0000000,0.0000000,0.005244879,0.004392233,0.003350371,0.00193552,0.001036592,0.001566814,0.000524352,4.49772E-05,3.53458E-05,8.86818E-05,9.11842E-05,1.12792E-05,8.08362E-06,0},
		{0.0011802,0.0000000,0.0000000,0.005244879,0.004392233,0.003350371,0.00193552,0.001036592,0.001566814,0.000524352,4.49772E-05,3.53458E-05,8.86818E-05,9.11842E-05,1.12792E-05,8.08362E-06,0},
		{0.0011802,0.0000000,0.0000000,0.005244879,0.004392233,0.003350371,0.00193552,0.001036592,0.001566814,0.000524352,4.49772E-05,3.53458E-05,8.86818E-05,9.11842E-05,1.12792E-05,8.08362E-06,0},
		{0.0011802,0.0000000,0.0000000,0.005244879,0.004392233,0.003350371,0.00193552,0.001036592,0.001566814,0.000524352,4.49772E-05,3.53458E-05,8.86818E-05,9.11842E-05,1.12792E-05,8.08362E-06,0},
		{0.0011802,0.0000000,0.0000000,0.005244879,0.004392233,0.003350371,0.00193552,0.001036592,0.001566814,0.000524352,4.49772E-05,3.53458E-05,8.86818E-05,9.11842E-05,1.12792E-05,8.08362E-06,0},
		{0.0011802,0.0000000,0.0000000,0.005244879,0.004392233,0.003350371,0.00193552,0.001036592,0.001566814,0.000524352,4.49772E-05,3.53458E-05,8.86818E-05,9.11842E-05,1.12792E-05,8.08362E-06,0},
		{0.0011802,0.0000000,0.0000000,0.005244879,0.004392233,0.003350371,0.00193552,0.001036592,0.001566814,0.000524352,4.49772E-05,3.53458E-05,8.86818E-05,9.11842E-05,1.12792E-05,8.08362E-06,0},
		{0.0011802,0.0000000,0.0000000,0.005244879,0.004392233,0.003350371,0.00193552,0.001036592,0.001566814,0.000524352,4.49772E-05,3.53458E-05,8.86818E-05,9.11842E-05,1.12792E-05,8.08362E-06,0},
		{0.0011802,0.0000000,0.0000000,0.005244879,0.004392233,0.003350371,0.00193552,0.001036592,0.001566814,0.000524352,4.49772E-05,3.53458E-05,8.86818E-05,9.11842E-05,1.12792E-05,8.08362E-06,0},
		{0.0011802,0.0000000,0.0000000,0.005244879,0.004392233,0.003350371,0.00193552,0.001036592,0.001566814,0.000524352,4.49772E-05,3.53458E-05,8.86818E-05,9.11842E-05,1.12792E-05,8.08362E-06,0},
		{0.0011802,0.0000000,0.0000000,0.005244879,0.004392233,0.003350371,0.00193552,0.001036592,0.001566814,0.000524352,4.49772E-05,3.53458E-05,8.86818E-05,9.11842E-05,1.12792E-05,8.08362E-06,0}
		},

		{
		{0.0000000,0.0000000,0.0000000,8.42946E-06,1.2259E-05,1.42859E-05,1.00915E-05,7.37452E-06,3.90556E-06,0,5.70038E-06,0,0,0,0,0,0},
		{0.0000014,0.0000000,0.0000000,4.33232E-05,6.70763E-05,7.83494E-05,5.43993E-05,3.69117E-05,2.31921E-05,4.53225E-06,3.88649E-05,6.82035E-06,0,0,0,0,0},
		{0.0000027,0.0000000,0.0000000,3.13032E-05,4.83214E-05,5.69512E-05,3.90962E-05,2.95316E-05,1.53733E-05,4.39306E-06,2.7026E-05,6.6676E-06,0,0,0,0,0},
		{0.0000045,0.0000000,0.0000000,4.52136E-05,6.97658E-05,8.17433E-05,5.61653E-05,4.03562E-05,2.30071E-05,4.26583E-06,4.20654E-05,6.50601E-06,0,0,0,0,0},
		{0.0000080,0.0000000,0.0000000,6.64657E-05,0.000101555,0.000121079,8.38755E-05,5.76026E-05,3.06599E-05,4.16264E-06,6.13077E-05,6.33866E-06,0,0,0,0,0},
		{0.0000136,0.0000000,0.0000000,9.87491E-05,0.00015105,0.000178458,0.000125153,8.6903E-05,4.97953E-05,8.17782E-06,8.92419E-05,1.23362E-05,0,0,0,0,0},
		{0.0000251,0.0000000,0.0000000,0.000173689,0.000268782,0.000317327,0.000221267,0.000155238,8.42586E-05,1.2125E-05,0.000158514,2.39935E-05,7.59521E-06,9.78953E-06,0,0,0},
		{0.0000418,0.0000000,0.0000000,0.000237179,0.000365568,0.000432094,0.000299482,0.000213989,0.000114786,1.60551E-05,0.000213916,2.91552E-05,7.4107E-06,9.61409E-06,0,0,0},
		{0.0000695,0.0000000,0.0000000,0.000359596,0.000552297,0.000653112,0.000453104,0.000324113,0.000174755,2.79993E-05,0.000324778,4.5315E-05,1.44347E-05,1.88677E-05,0,0,0},
		{0.0001139,0.0000000,0.0000000,0.000553453,0.000844178,0.000999042,0.000692495,0.000494083,0.000271942,3.99361E-05,0.000496996,7.146E-05,2.10584E-05,1.8488E-05,0,0,0},
		{0.0001854,0.0000000,0.0000000,0.00085979,0.001304258,0.001544367,0.001068021,0.000760891,0.000424268,6.38129E-05,0.000768732,0.000111926,3.41055E-05,3.6169E-05,0,0,0},
		{0.0003011,0.0000000,0.0000000,0.001322407,0.002021916,0.002398667,0.001656952,0.001183089,0.000662808,9.96401E-05,0.001191183,0.00017032,5.30107E-05,5.29712E-05,0,0,0},
		{0.0004892,0.0000000,0.0000000,0.002060648,0.003172328,0.003765113,0.002598783,0.001852487,0.001043295,0.000155241,0.001867113,0.000269819,7.7241E-05,8.6057E-05,1.21087E-05,0,0},
		{0.0007931,0.0000000,0.0000000,0.003206936,0.004962521,0.005883395,0.004059361,0.002892637,0.001628254,0.000240996,0.002913699,0.00041698,0.00012498,0.000134003,1.18693E-05,0,0},
		{0.0012687,0.0000000,0.0000000,0.004986797,0.007734517,0.009157299,0.006309319,0.004489662,0.002524,0.000367703,0.004525558,0.000633869,0.000193896,0.000203465,2.32318E-05,0,0},
		{0.0019875,0.0000000,0.0000000,0.007599181,0.011786375,0.013932178,0.009584793,0.006809042,0.003818519,0.000544666,0.006872488,0.000948396,0.000293386,0.000308059,3.40267E-05,0,0},
		{0.0030010,0.0000000,0.0000000,0.010834127,0.016791056,0.019916895,0.013675028,0.009695363,0.005427943,0.000746763,0.009793522,0.001330148,0.000419801,0.000436718,4.41974E-05,1.76044E-05,0},
		{0.0042728,0.0000000,0.0000000,0.014063617,0.021792322,0.02594699,0.017767079,0.012576686,0.007025289,0.000946143,0.012704166,0.001710029,0.000542662,0.000564598,5.37103E-05,1.72067E-05,0},
		{0.0056618,0.0000000,0.0000000,0.015808329,0.024498886,0.029235717,0.019992048,0.014140835,0.007884653,0.001053718,0.014260212,0.001914521,0.000610569,0.000633568,6.25632E-05,1.68064E-05,0},
		{0.0069582,0.0000000,0.0000000,0.015182228,0.023532357,0.028067688,0.019209486,0.013589049,0.00756319,0.001020319,0.013677252,0.001832373,0.000589824,0.000606631,6.06833E-05,1.63999E-05,0},
		{0.0080042,0.0000000,0.0000000,0.012726316,0.019729108,0.023445179,0.016094865,0.011392945,0.006331248,0.000864033,0.011453535,0.001537733,0.000498122,0.00051291,4.90345E-05,1.59844E-05,0},
		{0.0087265,0.0000000,0.0000000,0.009874119,0.01527731,0.018145355,0.012512625,0.00883827,0.00490382,0.000677618,0.008890888,0.001197319,0.000387603,0.000398032,3.80463E-05,1.55606E-05,0},
		{0.0091315,0.0000000,0.0000000,0.007600813,0.011737586,0.013946912,0.009616089,0.00679928,0.003771333,0.000525828,0.006851903,0.000929835,0.000301166,0.000309131,2.76857E-05,0,0},
		{0.0092376,0.0000000,0.0000000,0.006061729,0.009341077,0.011110076,0.007640032,0.00541765,0.003005345,0.000421975,0.005465279,0.000761348,0.000241603,0.000244636,2.68557E-05,0,0},
		{0.0091466,0.0000000,0.0000000,0.005095563,0.007835131,0.009322975,0.006394276,0.004547809,0.002522084,0.000357082,0.004590322,0.000662527,0.000202617,0.00020279,1.73527E-05,0,0},
		{0.0090254,0.0000000,0.0000000,0.005223292,0.008015583,0.009529002,0.00652516,0.004651681,0.002579467,0.000366887,0.004696691,0.000705945,0.000204111,0.0002111,1.6806E-05,0,0},
		{0.0087433,0.0000000,0.0000000,0.00477738,0.00731821,0.008697235,0.005986361,0.00425832,0.002354027,0.000337559,0.004289372,0.000657663,0.000190176,0.000191766,1.6259E-05,0,0},
		{0.0083563,0.0000000,0.0000000,0.004410788,0.006750651,0.008020221,0.005539476,0.003928935,0.002171984,0.000314896,0.003955326,0.000609864,0.000175494,0.000173914,1.57296E-05,0,0},
		{0.0078943,0.0000000,0.0000000,0.004116497,0.006298613,0.007479871,0.005175606,0.003659388,0.002025317,0.0002941,0.003690613,0.000567129,0.000159165,0.000162861,1.52634E-05,0,0},
		{0.0073292,0.0000000,0.0000000,0.00386126,0.00590352,0.007007331,0.004847832,0.00342066,0.001898274,0.000276594,0.003461004,0.000525678,0.000150731,0.000152306,1.49042E-05,0,0},
		{0.0065839,0.0000000,0.0000000,0.003654434,0.005580227,0.006619397,0.004572212,0.003222122,0.001794546,0.000260053,0.003270642,0.000490379,0.000139888,0.000147641,1.46707E-05,0,0},
		{0.0059098,0.0000000,0.0000000,0.003552803,0.005417229,0.006422053,0.004437062,0.003138157,0.001750937,0.000253395,0.003174128,0.000472044,0.000132046,0.000142883,1.45533E-05,0,0},
		{0.0053570,0.0000000,0.0000000,0.003544652,0.005397901,0.006396623,0.004420908,0.003136113,0.001747089,0.000252434,0.003160671,0.000467553,0.000131841,0.000137622,1.45299E-05,0,0},
		{0.0044695,0.0000000,0.0000000,0.00353848,0.005385947,0.006380283,0.004411559,0.003134782,0.001736869,0.000253205,0.003153153,0.000464319,0.000134558,0.0001429,1.4583E-05,0,0},
		{0.0041373,0.0000000,0.0000000,0.003215977,0.004898008,0.005799987,0.004012725,0.002852119,0.00156929,0.000230348,0.002867522,0.00041867,0.000121836,0.000128127,1.46835E-05,0,0},
		{0.0033411,0.0000000,0.0000000,0.002917046,0.004451571,0.005267249,0.00364485,0.00258598,0.001412548,0.000208261,0.0026052,0.000377656,0.000110871,0.000117281,7.39645E-06,0,0},
		{0.0024014,0.0000000,0.0000000,0.002712492,0.004148547,0.00490372,0.003393425,0.002409378,0.00132741,0.00019193,0.002426256,0.000347684,0.00010462,0.000110526,7.44729E-06,0,0},
		{0.0022953,0.0000000,0.0000000,0.002333831,0.00357364,0.004220161,0.002920682,0.002074519,0.001154596,0.000164256,0.002090099,0.000299634,8.98297E-05,9.32291E-05,7.47094E-06,0,0},
		{0.0016226,0.0000000,0.0000000,0.002133352,0.003266816,0.003856735,0.002668068,0.001897497,0.001062611,0.000149312,0.00191022,0.000272754,8.25267E-05,8.66022E-05,7.41642E-06,0,0},
		{0.0013798,0.0000000,0.0000000,0.002022871,0.003097069,0.003656262,0.002527199,0.001798649,0.001008876,0.000142914,0.00181082,0.000258339,7.88806E-05,8.0677E-05,7.23531E-06,0,0},
		{0.0011932,0.0000000,0.0000000,0.001966544,0.003012884,0.003557814,0.002457261,0.001751179,0.000975944,0.000147276,0.001762514,0.000250951,7.57264E-05,7.96023E-05,6.92046E-06,0,0},
		{0.0011932,0.0000000,0.0000000,0.001966544,0.003012884,0.003557814,0.002457261,0.001751179,0.000975944,0.000147276,0.001762514,0.000250951,7.57264E-05,7.96023E-05,6.92046E-06,0,0},
		{0.0011932,0.0000000,0.0000000,0.001966544,0.003012884,0.003557814,0.002457261,0.001751179,0.000975944,0.000147276,0.001762514,0.000250951,7.57264E-05,7.96023E-05,6.92046E-06,0,0},
		{0.0011932,0.0000000,0.0000000,0.001966544,0.003012884,0.003557814,0.002457261,0.001751179,0.000975944,0.000147276,0.001762514,0.000250951,7.57264E-05,7.96023E-05,6.92046E-06,0,0},
		{0.0011932,0.0000000,0.0000000,0.001966544,0.003012884,0.003557814,0.002457261,0.001751179,0.000975944,0.000147276,0.001762514,0.000250951,7.57264E-05,7.96023E-05,6.92046E-06,0,0},
		{0.0011932,0.0000000,0.0000000,0.001966544,0.003012884,0.003557814,0.002457261,0.001751179,0.000975944,0.000147276,0.001762514,0.000250951,7.57264E-05,7.96023E-05,6.92046E-06,0,0},
		{0.0011932,0.0000000,0.0000000,0.001966544,0.003012884,0.003557814,0.002457261,0.001751179,0.000975944,0.000147276,0.001762514,0.000250951,7.57264E-05,7.96023E-05,6.92046E-06,0,0},
		{0.0011932,0.0000000,0.0000000,0.001966544,0.003012884,0.003557814,0.002457261,0.001751179,0.000975944,0.000147276,0.001762514,0.000250951,7.57264E-05,7.96023E-05,6.92046E-06,0,0},
		{0.0011932,0.0000000,0.0000000,0.001966544,0.003012884,0.003557814,0.002457261,0.001751179,0.000975944,0.000147276,0.001762514,0.000250951,7.57264E-05,7.96023E-05,6.92046E-06,0,0},
		{0.0011932,0.0000000,0.0000000,0.001966544,0.003012884,0.003557814,0.002457261,0.001751179,0.000975944,0.000147276,0.001762514,0.000250951,7.57264E-05,7.96023E-05,6.92046E-06,0,0},
		{0.0011932,0.0000000,0.0000000,0.001966544,0.003012884,0.003557814,0.002457261,0.001751179,0.000975944,0.000147276,0.001762514,0.000250951,7.57264E-05,7.96023E-05,6.92046E-06,0,0},
		{0.0011932,0.0000000,0.0000000,0.001966544,0.003012884,0.003557814,0.002457261,0.001751179,0.000975944,0.000147276,0.001762514,0.000250951,7.57264E-05,7.96023E-05,6.92046E-06,0,0},
		{0.0011932,0.0000000,0.0000000,0.001966544,0.003012884,0.003557814,0.002457261,0.001751179,0.000975944,0.000147276,0.001762514,0.000250951,7.57264E-05,7.96023E-05,6.92046E-06,0,0},
		{0.0011932,0.0000000,0.0000000,0.001966544,0.003012884,0.003557814,0.002457261,0.001751179,0.000975944,0.000147276,0.001762514,0.000250951,7.57264E-05,7.96023E-05,6.92046E-06,0,0},
		{0.0011932,0.0000000,0.0000000,0.001966544,0.003012884,0.003557814,0.002457261,0.001751179,0.000975944,0.000147276,0.001762514,0.000250951,7.57264E-05,7.96023E-05,6.92046E-06,0,0}
		}
	};
	
	//Find i for currentYear (room for improvement?)
	unsigned int yr [55];
	
	for(size_t i = 0; i < 55; i++)
		yr[i] = (5+i) * 365.25;
	
	int i = 0;
	
	while(yr[i] < Time)
		i++;
	
	//Find j for age
	int j = 0;
	unsigned int ageCatMax [16] = {5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80};

	while ( (Age / 365.25) > ageCatMax[j] )
		j++;
	
	//Determine SerStatus
	bool serum = false;
	
	serum = theRng->Sample( hivInc [Sex] [i-5] [j] );

	D(cout << "Serum is: " << serum << endl;)
	
	return serum;
}
