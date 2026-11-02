// 机械还原自 PTX：synreal::kernel::update_hard_contact_duals(synreal::kernel::HardContactView)
// PTX SHA256: 23d9e52508f9a1362378886def57332db7aabe04d360cd60ff70c447867b780a
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__update_hard_contact_duals(ByVal<312, 8> param0) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62, p63, p64, p65, p66, p67, p68, p69, p70, p71, p72, p73, p74, p75, p76, p77, p78, p79, p80, p81, p82, p83, p84, p85, p86, p87, p88, p89, p90, p91, p92, p93, p94, p95, p96, p97, p98, p99, p100, p101, p102, p103, p104, p105, p106, p107, p108, p109, p110, p111, p112, p113, p114, p115, p116, p117, p118, p119, p120, p121, p122, p123, p124, p125, p126, p127, p128, p129, p130, p131, p132, p133, p134, p135, p136, p137, p138, p139, p140, p141, p142, p143, p144, p145, p146;
  unsigned short rs0, rs1, rs2, rs3, rs4;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503, f504, f505, f506, f507, f508, f509, f510, f511, f512, f513, f514, f515, f516, f517, f518, f519, f520, f521, f522, f523, f524, f525, f526, f527, f528, f529, f530, f531, f532, f533, f534, f535, f536, f537, f538, f539, f540, f541, f542, f543, f544, f545, f546, f547, f548, f549, f550, f551, f552, f553, f554, f555, f556, f557, f558, f559, f560, f561, f562, f563, f564, f565, f566, f567, f568, f569, f570, f571, f572, f573, f574, f575, f576, f577, f578, f579, f580, f581, f582, f583, f584, f585, f586, f587, f588, f589, f590, f591, f592, f593, f594, f595, f596, f597, f598, f599, f600, f601, f602, f603, f604, f605, f606, f607, f608, f609, f610, f611, f612, f613, f614, f615, f616, f617, f618, f619, f620, f621, f622, f623, f624, f625, f626, f627, f628, f629, f630, f631, f632, f633, f634, f635, f636, f637, f638, f639, f640, f641, f642, f643, f644, f645, f646, f647, f648, f649, f650, f651, f652, f653, f654, f655, f656, f657, f658, f659, f660, f661, f662, f663, f664, f665, f666, f667, f668, f669, f670, f671, f672, f673, f674, f675, f676, f677, f678, f679, f680, f681, f682, f683, f684, f685, f686, f687, f688, f689, f690, f691, f692, f693, f694, f695, f696, f697, f698, f699, f700, f701, f702, f703, f704, f705, f706, f707, f708, f709, f710, f711, f712, f713, f714, f715, f716, f717, f718, f719, f720, f721, f722, f723, f724, f725, f726, f727, f728, f729, f730, f731, f732, f733, f734, f735, f736, f737, f738, f739, f740, f741, f742, f743, f744, f745, f746, f747, f748, f749, f750, f751, f752, f753, f754, f755, f756, f757, f758, f759, f760, f761, f762, f763, f764, f765, f766, f767, f768, f769, f770, f771, f772, f773, f774, f775, f776, f777, f778, f779, f780, f781, f782, f783, f784, f785, f786, f787, f788, f789, f790, f791, f792, f793, f794, f795, f796, f797, f798, f799, f800, f801, f802, f803, f804, f805, f806, f807, f808, f809, f810, f811, f812, f813, f814, f815, f816, f817, f818, f819, f820, f821, f822, f823, f824, f825, f826, f827, f828, f829, f830, f831, f832, f833, f834, f835, f836, f837, f838, f839, f840, f841, f842, f843, f844, f845, f846, f847, f848, f849, f850, f851, f852, f853, f854, f855, f856, f857, f858, f859, f860, f861, f862, f863, f864, f865, f866, f867, f868, f869, f870, f871, f872, f873, f874, f875, f876, f877, f878, f879, f880, f881, f882, f883, f884, f885, f886, f887, f888, f889, f890, f891, f892, f893, f894, f895, f896, f897, f898, f899, f900, f901, f902, f903, f904, f905, f906, f907, f908, f909, f910, f911, f912, f913, f914, f915, f916, f917, f918, f919, f920, f921, f922, f923, f924, f925, f926, f927, f928, f929, f930, f931, f932, f933, f934, f935, f936, f937, f938, f939, f940, f941, f942, f943, f944, f945, f946, f947, f948, f949, f950, f951, f952, f953, f954, f955, f956, f957, f958, f959, f960, f961, f962, f963, f964, f965, f966, f967, f968, f969, f970, f971, f972, f973, f974, f975, f976, f977, f978, f979, f980, f981, f982, f983, f984, f985, f986, f987, f988, f989, f990, f991, f992, f993, f994, f995, f996, f997, f998, f999, f1000, f1001, f1002, f1003, f1004, f1005, f1006, f1007, f1008, f1009, f1010, f1011, f1012, f1013, f1014, f1015, f1016, f1017, f1018, f1019, f1020, f1021, f1022, f1023, f1024, f1025, f1026, f1027, f1028, f1029, f1030, f1031, f1032, f1033, f1034, f1035, f1036, f1037, f1038, f1039, f1040, f1041, f1042, f1043, f1044, f1045, f1046, f1047, f1048, f1049, f1050, f1051, f1052, f1053, f1054, f1055, f1056, f1057, f1058, f1059, f1060, f1061, f1062, f1063, f1064, f1065, f1066, f1067, f1068, f1069, f1070, f1071, f1072, f1073, f1074, f1075, f1076, f1077, f1078, f1079, f1080, f1081, f1082, f1083, f1084, f1085, f1086, f1087, f1088, f1089, f1090, f1091, f1092, f1093, f1094, f1095, f1096, f1097, f1098, f1099, f1100, f1101, f1102, f1103, f1104, f1105, f1106, f1107, f1108, f1109, f1110, f1111, f1112, f1113, f1114, f1115, f1116, f1117, f1118, f1119, f1120, f1121, f1122, f1123, f1124, f1125, f1126, f1127, f1128, f1129, f1130, f1131, f1132, f1133, f1134, f1135, f1136, f1137, f1138, f1139, f1140, f1141, f1142, f1143, f1144, f1145, f1146, f1147, f1148, f1149, f1150, f1151;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146, r147, r148, r149, r150, r151, r152, r153, r154, r155, r156, r157, r158, r159, r160, r161, r162, r163, r164, r165, r166, r167, r168, r169, r170, r171, r172, r173, r174, r175, r176, r177, r178, r179, r180, r181, r182, r183, r184, r185, r186, r187, r188, r189, r190, r191, r192, r193, r194, r195, r196, r197, r198, r199, r200, r201, r202, r203, r204, r205, r206, r207, r208, r209, r210, r211, r212, r213, r214, r215, r216, r217, r218, r219, r220, r221, r222, r223, r224, r225, r226, r227, r228, r229, r230, r231, r232, r233, r234, r235, r236, r237, r238, r239, r240, r241, r242, r243, r244, r245, r246, r247, r248, r249, r250, r251, r252, r253, r254, r255, r256, r257, r258, r259, r260, r261, r262, r263, r264, r265, r266, r267, r268, r269, r270, r271, r272, r273, r274, r275, r276, r277, r278, r279, r280, r281, r282, r283, r284, r285, r286, r287, r288, r289, r290, r291, r292, r293, r294, r295, r296, r297, r298, r299, r300, r301, r302, r303, r304, r305, r306, r307, r308, r309, r310, r311, r312, r313, r314, r315, r316, r317, r318, r319, r320, r321, r322, r323, r324, r325, r326, r327, r328, r329, r330, r331, r332, r333, r334, r335, r336, r337, r338, r339, r340, r341, r342, r343, r344, r345, r346, r347, r348, r349, r350, r351, r352, r353, r354, r355, r356, r357, r358, r359, r360, r361, r362, r363, r364, r365, r366, r367, r368, r369, r370, r371, r372, r373, r374, r375, r376, r377, r378, r379, r380, r381, r382, r383, r384, r385, r386, r387, r388, r389, r390, r391, r392, r393, r394, r395, r396, r397, r398, r399, r400, r401, r402, r403, r404, r405, r406, r407, r408, r409, r410, r411, r412, r413, r414, r415, r416, r417, r418, r419, r420, r421, r422, r423, r424, r425, r426, r427, r428, r429, r430, r431, r432, r433, r434, r435, r436, r437, r438, r439, r440, r441, r442, r443, r444, r445, r446, r447, r448, r449, r450, r451, r452, r453, r454, r455, r456, r457, r458, r459, r460, r461, r462, r463, r464, r465, r466, r467, r468, r469, r470, r471, r472, r473, r474, r475, r476, r477, r478, r479, r480, r481, r482, r483, r484, r485, r486, r487, r488, r489, r490, r491, r492, r493, r494, r495, r496, r497, r498, r499, r500, r501, r502, r503, r504, r505, r506, r507, r508, r509, r510, r511, r512, r513, r514, r515, r516, r517, r518, r519, r520, r521, r522, r523, r524, r525, r526, r527, r528, r529, r530, r531, r532, r533, r534, r535, r536, r537, r538, r539, r540, r541, r542, r543, r544, r545, r546, r547, r548, r549, r550, r551, r552, r553, r554, r555, r556, r557, r558, r559, r560, r561, r562, r563, r564, r565, r566, r567, r568, r569, r570, r571, r572, r573, r574, r575, r576, r577, r578, r579, r580, r581, r582, r583, r584, r585, r586, r587, r588, r589, r590, r591, r592, r593, r594, r595, r596, r597, r598, r599, r600, r601, r602, r603, r604, r605, r606, r607, r608, r609, r610, r611, r612, r613, r614, r615, r616, r617, r618, r619, r620, r621, r622, r623, r624, r625, r626, r627, r628, r629, r630, r631, r632, r633, r634, r635, r636, r637, r638, r639, r640, r641, r642, r643, r644, r645, r646, r647, r648, r649, r650, r651, r652, r653, r654, r655, r656, r657, r658, r659, r660;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162, rd163, rd164, rd165, rd166, rd167, rd168, rd169, rd170, rd171, rd172, rd173, rd174, rd175, rd176, rd177, rd178, rd179, rd180, rd181, rd182, rd183, rd184, rd185, rd186, rd187, rd188, rd189, rd190, rd191, rd192, rd193, rd194, rd195, rd196, rd197, rd198, rd199, rd200, rd201, rd202, rd203, rd204, rd205, rd206, rd207, rd208, rd209, rd210, rd211, rd212, rd213, rd214, rd215, rd216, rd217, rd218, rd219, rd220, rd221, rd222, rd223, rd224, rd225, rd226, rd227, rd228, rd229, rd230, rd231, rd232, rd233, rd234, rd235, rd236, rd237, rd238, rd239, rd240, rd241, rd242, rd243, rd244, rd245, rd246, rd247, rd248, rd249, rd250, rd251, rd252, rd253, rd254, rd255, rd256, rd257, rd258, rd259, rd260, rd261, rd262, rd263, rd264, rd265, rd266, rd267, rd268, rd269, rd270, rd271, rd272, rd273, rd274, rd275, rd276, rd277, rd278, rd279, rd280, rd281, rd282, rd283, rd284, rd285, rd286, rd287, rd288, rd289, rd290, rd291, rd292, rd293, rd294, rd295, rd296, rd297, rd298, rd299, rd300, rd301, rd302, rd303, rd304, rd305, rd306, rd307, rd308, rd309, rd310, rd311, rd312, rd313, rd314, rd315, rd316, rd317, rd318, rd319, rd320, rd321, rd322, rd323, rd324, rd325, rd326, rd327, rd328, rd329, rd330, rd331, rd332, rd333, rd334, rd335, rd336, rd337, rd338, rd339, rd340, rd341, rd342, rd343, rd344, rd345, rd346, rd347, rd348, rd349, rd350, rd351, rd352, rd353, rd354, rd355, rd356, rd357, rd358, rd359, rd360, rd361, rd362, rd363, rd364, rd365, rd366, rd367, rd368, rd369, rd370, rd371, rd372, rd373, rd374, rd375, rd376, rd377, rd378, rd379, rd380, rd381, rd382, rd383, rd384, rd385, rd386, rd387, rd388, rd389, rd390, rd391, rd392, rd393, rd394, rd395, rd396, rd397, rd398, rd399, rd400, rd401, rd402, rd403, rd404, rd405, rd406, rd407, rd408, rd409, rd410, rd411, rd412, rd413, rd414, rd415, rd416, rd417, rd418, rd419, rd420, rd421, rd422, rd423, rd424, rd425, rd426, rd427, rd428, rd429, rd430, rd431, rd432, rd433, rd434, rd435, rd436;
  // PTX:18 mov.b64 %rd79, _ZN7synreal6kernel25update_hard_contact_dualsENS0_15HardContactViewE_param_0
  rd79 = (unsigned long long)(uintptr_t)&param0;
  // PTX:19 mov.u32 %r304, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r304) : "r"(blockIdx.x));
  // PTX:20 mov.u32 %r305, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r305) : "r"(blockDim.x));
  // PTX:21 mul.wide.u32 %rd80, %r304, %r305
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd80) : "r"(r304), "r"(r305));
  // PTX:22 mov.u32 %r306, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r306) : "r"(threadIdx.x));
  // PTX:23 cvt.u64.u32 %rd81, %r306
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd81) : "r"(r306));
  // PTX:24 add.s64 %rd1, %rd80, %rd81
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd80), "l"(rd81));
  // PTX:25 add.s64 %rd2, %rd79, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd2) : "l"(rd79));
  // PTX:26 ld.param.u64 %rd83, [_ZN7synreal6kernel25update_hard_contact_dualsENS0_15HardContactViewE_param_0+8]
  rd83 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (8))));
  // PTX:27 setp.le.u64 %p2, %rd83, %rd1
  p2 = (((unsigned long long)(rd83)) <= ((unsigned long long)(rd1)));
  // PTX:28 ld.param.u64 %rd3, [_ZN7synreal6kernel25update_hard_contact_dualsENS0_15HardContactViewE_param_0]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:29 setp.eq.s64 %p3, %rd3, 0
  p3 = (((long long)(rd3)) == ((long long)(0)));
  // PTX:30 or.pred %p4, %p2, %p3
  p4 = ((p2) || (p3));
  // PTX:31 mov.u16 %rs4, 0
  asm("mov.u16 %0, 0;" : "=h"(rs4) : );
  // PTX:32 @%p4 bra $L__BB79_2
  if (p4) { goto L_BB79_2; }
  // PTX:34 cvta.to.global.u64 %rd84, %rd3
  rd84 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd3));
  // PTX:35 ld.global.u32 %r307, [%rd84]
  r307 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0)))));
  // PTX:36 max.s32 %r308, %r307, 0
  asm("max.s32 %0, %1, 0;" : "=r"(r308) : "r"(r307));
  // PTX:37 cvt.s64.s32 %rd85, %r308
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd85) : "r"(r308));
  // PTX:38 setp.lt.u64 %p5, %rd1, %rd85
  p5 = (((unsigned long long)(rd1)) < ((unsigned long long)(rd85)));
  // PTX:39 selp.u16 %rs4, 1, 0, %p5
  rs4 = p5 ? 1 : 0;
  // PTX:41 $L__BB79_2:
L_BB79_2:;
  // PTX:42 setp.eq.s16 %p6, %rs4, 0
  p6 = (((short)(rs4)) == ((short)(0)));
  // PTX:43 mov.f32 %f1148, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1148) : );
  // PTX:44 @%p6 bra $L__BB79_135
  if (p6) { goto L_BB79_135; }
  // PTX:46 mov.u64 %rd435, 0
  asm("mov.u64 %0, 0;" : "=l"(rd435) : );
  // PTX:47 ld.param.u64 %rd88, [%rd2+160]
  rd88 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (160))));
  // PTX:48 ld.param.u64 %rd5, [%rd2+152]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (152))));
  // PTX:49 mul.lo.s64 %rd6, %rd88, %rd5
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd6) : "l"(rd88), "l"(rd5));
  // PTX:50 ld.param.u64 %rd90, [%rd2+168]
  rd90 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (168))));
  // PTX:51 cvta.to.global.u64 %rd8, %rd90
  rd8 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd90));
  // PTX:52 ld.param.u64 %rd9, [%rd2+192]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (192))));
  // PTX:53 ld.param.u64 %rd92, [%rd2+8]
  rd92 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (8))));
  // PTX:54 cvta.to.global.u64 %rd93, %rd92
  rd93 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd92));
  // PTX:55 shl.b64 %rd94, %rd1, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd94) : "l"(rd1));
  // PTX:56 add.s64 %rd95, %rd93, %rd94
  asm("add.s64 %0, %1, %2;" : "=l"(rd95) : "l"(rd93), "l"(rd94));
  // PTX:57 ld.global.s32 %rd11, [%rd95]
  rd11 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd95) + (0)))));
  // PTX:58 setp.lt.s64 %p8, %rd11, 0
  p8 = (((long long)(rd11)) < ((long long)(0)));
  // PTX:59 mov.pred %p146, -1
  p146 = ((-1) != 0);
  // PTX:60 mov.u32 %r630, 0
  asm("mov.u32 %0, 0;" : "=r"(r630) : );
  // PTX:61 mov.u32 %r631, %r630
  asm("mov.u32 %0, %1;" : "=r"(r631) : "r"(r630));
  // PTX:62 mov.u32 %r632, %r630
  asm("mov.u32 %0, %1;" : "=r"(r632) : "r"(r630));
  // PTX:63 mov.u32 %r641, %r630
  asm("mov.u32 %0, %1;" : "=r"(r641) : "r"(r630));
  // PTX:64 mov.u32 %r642, %r630
  asm("mov.u32 %0, %1;" : "=r"(r642) : "r"(r630));
  // PTX:65 mov.u64 %rd436, %rd435
  asm("mov.u64 %0, %1;" : "=l"(rd436) : "l"(rd435));
  // PTX:66 @%p8 bra $L__BB79_122
  if (p8) { goto L_BB79_122; }
  // PTX:68 setp.gt.u64 %p9, %rd6, %rd11
  p9 = (((unsigned long long)(rd6)) > ((unsigned long long)(rd11)));
  // PTX:69 @%p9 bra $L__BB79_6
  if (p9) { goto L_BB79_6; }
  // PTX:70 bra.uni $L__BB79_5
  goto L_BB79_5;
  // PTX:72 $L__BB79_6:
L_BB79_6:;
  // PTX:73 ld.param.u64 %rd394, [%rd2+152]
  rd394 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (152))));
  // PTX:74 or.b64 %rd99, %rd11, %rd394
  asm("or.b64 %0, %1, %2;" : "=l"(rd99) : "l"(rd11), "l"(rd394));
  // PTX:75 and.b64 %rd100, %rd99, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd100) : "l"(rd99));
  // PTX:76 setp.eq.s64 %p12, %rd100, 0
  p12 = (((long long)(rd100)) == ((long long)(0)));
  // PTX:77 @%p12 bra $L__BB79_8
  if (p12) { goto L_BB79_8; }
  // PTX:79 ld.param.u64 %rd395, [%rd2+152]
  rd395 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (152))));
  // PTX:80 div.u64 %rd421, %rd11, %rd395
  asm("div.u64 %0, %1, %2;" : "=l"(rd421) : "l"(rd11), "l"(rd395));
  // PTX:81 mul.lo.s64 %rd101, %rd421, %rd395
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd101) : "l"(rd421), "l"(rd395));
  // PTX:82 sub.s64 %rd423, %rd11, %rd101
  asm("sub.s64 %0, %1, %2;" : "=l"(rd423) : "l"(rd11), "l"(rd101));
  // PTX:83 bra.uni $L__BB79_9
  goto L_BB79_9;
  // PTX:85 $L__BB79_5:
L_BB79_5:;
  // PTX:86 ld.param.u64 %rd391, [%rd2+152]
  rd391 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (152))));
  // PTX:87 mov.pred %p146, -1
  p146 = ((-1) != 0);
  // PTX:88 mov.u64 %rd435, 0
  asm("mov.u64 %0, 0;" : "=l"(rd435) : );
  // PTX:89 mov.u32 %r630, 0
  asm("mov.u32 %0, 0;" : "=r"(r630) : );
  // PTX:90 mov.f32 %f1148, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1148) : );
  // PTX:91 ld.param.u64 %rd389, [%rd2+144]
  rd389 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (144))));
  // PTX:92 sub.s64 %rd98, %rd11, %rd6
  asm("sub.s64 %0, %1, %2;" : "=l"(rd98) : "l"(rd11), "l"(rd6));
  // PTX:93 add.s64 %rd423, %rd98, %rd391
  asm("add.s64 %0, %1, %2;" : "=l"(rd423) : "l"(rd98), "l"(rd391));
  // PTX:94 setp.lt.u64 %p11, %rd423, %rd389
  p11 = (((unsigned long long)(rd423)) < ((unsigned long long)(rd389)));
  // PTX:95 mov.u32 %r523, -1
  asm("mov.u32 %0, -1;" : "=r"(r523) : );
  // PTX:96 mov.u32 %r631, %r630
  asm("mov.u32 %0, %1;" : "=r"(r631) : "r"(r630));
  // PTX:97 mov.u32 %r632, %r630
  asm("mov.u32 %0, %1;" : "=r"(r632) : "r"(r630));
  // PTX:98 mov.u32 %r641, %r630
  asm("mov.u32 %0, %1;" : "=r"(r641) : "r"(r630));
  // PTX:99 mov.u32 %r642, %r630
  asm("mov.u32 %0, %1;" : "=r"(r642) : "r"(r630));
  // PTX:100 mov.u64 %rd436, %rd435
  asm("mov.u64 %0, %1;" : "=l"(rd436) : "l"(rd435));
  // PTX:101 @%p11 bra $L__BB79_10
  if (p11) { goto L_BB79_10; }
  // PTX:102 bra.uni $L__BB79_122
  goto L_BB79_122;
  // PTX:104 $L__BB79_8:
L_BB79_8:;
  // PTX:105 ld.param.u64 %rd396, [%rd2+152]
  rd396 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (152))));
  // PTX:106 cvt.u32.u64 %r322, %rd396
  asm("cvt.u32.u64 %0, %1;" : "=r"(r322) : "l"(rd396));
  // PTX:107 cvt.u32.u64 %r323, %rd11
  asm("cvt.u32.u64 %0, %1;" : "=r"(r323) : "l"(rd11));
  // PTX:108 div.u32 %r324, %r323, %r322
  asm("div.u32 %0, %1, %2;" : "=r"(r324) : "r"(r323), "r"(r322));
  // PTX:109 mul.lo.s32 %r325, %r324, %r322
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r325) : "r"(r324), "r"(r322));
  // PTX:110 sub.s32 %r326, %r323, %r325
  asm("sub.s32 %0, %1, %2;" : "=r"(r326) : "r"(r323), "r"(r325));
  // PTX:111 cvt.u64.u32 %rd421, %r324
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd421) : "r"(r324));
  // PTX:112 cvt.u64.u32 %rd423, %r326
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd423) : "r"(r326));
  // PTX:114 $L__BB79_9:
L_BB79_9:;
  // PTX:115 cvt.u32.u64 %r523, %rd421
  asm("cvt.u32.u64 %0, %1;" : "=r"(r523) : "l"(rd421));
  // PTX:117 $L__BB79_10:
L_BB79_10:;
  // PTX:118 mov.u64 %rd436, %rd423
  asm("mov.u64 %0, %1;" : "=l"(rd436) : "l"(rd423));
  // PTX:119 ld.param.u64 %rd393, [%rd2+88]
  rd393 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (88))));
  // PTX:120 cvta.to.global.u64 %rd392, %rd393
  rd392 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd393));
  // PTX:121 shl.b64 %rd102, %rd436, 32
  asm("shl.b64 %0, %1, 32;" : "=l"(rd102) : "l"(rd436));
  // PTX:122 shr.s64 %rd103, %rd102, 30
  asm("shr.s64 %0, %1, 30;" : "=l"(rd103) : "l"(rd102));
  // PTX:123 add.s64 %rd104, %rd392, %rd103
  asm("add.s64 %0, %1, %2;" : "=l"(rd104) : "l"(rd392), "l"(rd103));
  // PTX:124 ld.global.s32 %rd21, [%rd104]
  rd21 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (0)))));
  // PTX:125 setp.lt.s64 %p13, %rd21, 0
  p13 = (((long long)(rd21)) < ((long long)(0)));
  // PTX:126 mov.u32 %r327, -1
  asm("mov.u32 %0, -1;" : "=r"(r327) : );
  // PTX:127 mov.u32 %r642, %r327
  asm("mov.u32 %0, %1;" : "=r"(r642) : "r"(r327));
  // PTX:128 @%p13 bra $L__BB79_18
  if (p13) { goto L_BB79_18; }
  // PTX:130 setp.gt.u64 %p14, %rd9, %rd21
  p14 = (((unsigned long long)(rd9)) > ((unsigned long long)(rd21)));
  // PTX:131 @%p14 bra $L__BB79_13
  if (p14) { goto L_BB79_13; }
  // PTX:132 bra.uni $L__BB79_12
  goto L_BB79_12;
  // PTX:134 $L__BB79_13:
L_BB79_13:;
  // PTX:135 cvt.u32.u64 %r329, %rd21
  asm("cvt.u32.u64 %0, %1;" : "=r"(r329) : "l"(rd21));
  // PTX:136 shl.b64 %rd105, %rd21, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd105) : "l"(rd21));
  // PTX:137 add.s64 %rd106, %rd8, %rd105
  asm("add.s64 %0, %1, %2;" : "=l"(rd106) : "l"(rd8), "l"(rd105));
  // PTX:138 ld.global.u32 %r330, [%rd106]
  r330 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))));
  // PTX:139 setp.eq.s32 %p16, %r330, %r329
  p16 = (((int)(r330)) == ((int)(r329)));
  // PTX:140 setp.eq.s64 %p17, %rd9, 0
  p17 = (((long long)(rd9)) == ((long long)(0)));
  // PTX:141 or.pred %p18, %p16, %p17
  p18 = ((p16) || (p17));
  // PTX:142 selp.b32 %r642, %r329, -1, %p16
  r642 = p16 ? r329 : -1;
  // PTX:143 @%p18 bra $L__BB79_18
  if (p18) { goto L_BB79_18; }
  // PTX:144 bra.uni $L__BB79_14
  goto L_BB79_14;
  // PTX:146 $L__BB79_12:
L_BB79_12:;
  // PTX:147 setp.eq.s64 %p15, %rd9, 0
  p15 = (((long long)(rd9)) == ((long long)(0)));
  // PTX:148 mov.u32 %r642, %r327
  asm("mov.u32 %0, %1;" : "=r"(r642) : "r"(r327));
  // PTX:149 @%p15 bra $L__BB79_18
  if (p15) { goto L_BB79_18; }
  // PTX:151 $L__BB79_14:
L_BB79_14:;
  // PTX:152 mov.u64 %rd424, 0
  asm("mov.u64 %0, 0;" : "=l"(rd424) : );
  // PTX:153 cvt.u32.u64 %r332, %rd21
  asm("cvt.u32.u64 %0, %1;" : "=r"(r332) : "l"(rd21));
  // PTX:155 $L__BB79_15:
L_BB79_15:;
  // PTX:156 shl.b64 %rd108, %rd424, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd108) : "l"(rd424));
  // PTX:157 add.s64 %rd109, %rd8, %rd108
  asm("add.s64 %0, %1, %2;" : "=l"(rd109) : "l"(rd8), "l"(rd108));
  // PTX:158 ld.global.u32 %r331, [%rd109]
  r331 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd109) + (0)))));
  // PTX:159 setp.eq.s32 %p19, %r331, %r332
  p19 = (((int)(r331)) == ((int)(r332)));
  // PTX:160 @%p19 bra $L__BB79_17
  if (p19) { goto L_BB79_17; }
  // PTX:162 add.s64 %rd424, %rd424, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd424) : "l"(rd424));
  // PTX:163 setp.lt.u64 %p20, %rd424, %rd9
  p20 = (((unsigned long long)(rd424)) < ((unsigned long long)(rd9)));
  // PTX:164 mov.u32 %r642, %r327
  asm("mov.u32 %0, %1;" : "=r"(r642) : "r"(r327));
  // PTX:165 @%p20 bra $L__BB79_15
  if (p20) { goto L_BB79_15; }
  // PTX:166 bra.uni $L__BB79_18
  goto L_BB79_18;
  // PTX:168 $L__BB79_17:
L_BB79_17:;
  // PTX:169 cvt.u32.u64 %r642, %rd424
  asm("cvt.u32.u64 %0, %1;" : "=r"(r642) : "l"(rd424));
  // PTX:171 $L__BB79_18:
L_BB79_18:;
  // PTX:172 mov.pred %p146, -1
  p146 = ((-1) != 0);
  // PTX:173 mov.f32 %f1148, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1148) : );
  // PTX:174 mov.u64 %rd435, 0
  asm("mov.u64 %0, 0;" : "=l"(rd435) : );
  // PTX:175 mov.u32 %r630, 0
  asm("mov.u32 %0, 0;" : "=r"(r630) : );
  // PTX:176 cvt.u32.u64 %r339, %rd21
  asm("cvt.u32.u64 %0, %1;" : "=r"(r339) : "l"(rd21));
  // PTX:177 setp.gt.s32 %p22, %r339, -1
  p22 = (((int)(r339)) > ((int)(-1)));
  // PTX:178 setp.lt.s32 %p23, %r642, 0
  p23 = (((int)(r642)) < ((int)(0)));
  // PTX:179 and.pred %p24, %p22, %p23
  p24 = ((p22) && (p23));
  // PTX:180 mov.u32 %r631, %r630
  asm("mov.u32 %0, %1;" : "=r"(r631) : "r"(r630));
  // PTX:181 mov.u32 %r632, %r630
  asm("mov.u32 %0, %1;" : "=r"(r632) : "r"(r630));
  // PTX:182 mov.u32 %r641, %r630
  asm("mov.u32 %0, %1;" : "=r"(r641) : "r"(r630));
  // PTX:183 @%p24 bra $L__BB79_122
  if (p24) { goto L_BB79_122; }
  // PTX:185 mov.pred %p146, -1
  p146 = ((-1) != 0);
  // PTX:186 mov.f32 %f1148, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1148) : );
  // PTX:187 mov.u64 %rd435, 0
  asm("mov.u64 %0, 0;" : "=l"(rd435) : );
  // PTX:188 mov.u32 %r630, 0
  asm("mov.u32 %0, 0;" : "=r"(r630) : );
  // PTX:189 setp.gt.s32 %p26, %r642, -1
  p26 = (((int)(r642)) > ((int)(-1)));
  // PTX:190 setp.lt.s32 %p27, %r523, 0
  p27 = (((int)(r523)) < ((int)(0)));
  // PTX:191 and.pred %p28, %p26, %p27
  p28 = ((p26) && (p27));
  // PTX:192 @%p28 bra $L__BB79_122
  if (p28) { goto L_BB79_122; }
  // PTX:194 setp.lt.s32 %p145, %r642, 0
  p145 = (((int)(r642)) < ((int)(0)));
  // PTX:195 mov.u32 %r640, 0
  asm("mov.u32 %0, 0;" : "=r"(r640) : );
  // PTX:196 mov.u32 %r639, %r640
  asm("mov.u32 %0, %1;" : "=r"(r639) : "r"(r640));
  // PTX:197 mov.u32 %r638, %r640
  asm("mov.u32 %0, %1;" : "=r"(r638) : "r"(r640));
  // PTX:198 mov.u32 %r637, %r640
  asm("mov.u32 %0, %1;" : "=r"(r637) : "r"(r640));
  // PTX:199 @%p145 bra $L__BB79_22
  if (p145) { goto L_BB79_22; }
  // PTX:201 ld.param.u32 %r513, [%rd2+200]
  r513 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd2) + (200))));
  // PTX:202 ld.param.u64 %rd374, [%rd2+176]
  rd374 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (176))));
  // PTX:203 cvta.to.global.u64 %rd373, %rd374
  rd373 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd374));
  // PTX:204 mul.wide.s32 %rd112, %r642, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd112) : "r"(r642));
  // PTX:205 add.s64 %rd113, %rd373, %rd112
  asm("add.s64 %0, %1, %2;" : "=l"(rd113) : "l"(rd373), "l"(rd112));
  // PTX:206 mul.lo.s32 %r349, %r523, %r513
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r349) : "r"(r523), "r"(r513));
  // PTX:207 ld.global.u32 %r350, [%rd113]
  r350 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd113) + (0)))));
  // PTX:208 ld.global.u32 %r351, [%rd113+4]
  r351 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd113) + (4)))));
  // PTX:209 ld.global.u32 %r352, [%rd113+8]
  r352 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd113) + (8)))));
  // PTX:210 ld.global.u32 %r353, [%rd113+12]
  r353 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd113) + (12)))));
  // PTX:211 add.s32 %r637, %r349, %r353
  asm("add.s32 %0, %1, %2;" : "=r"(r637) : "r"(r349), "r"(r353));
  // PTX:212 add.s32 %r638, %r349, %r352
  asm("add.s32 %0, %1, %2;" : "=r"(r638) : "r"(r349), "r"(r352));
  // PTX:213 add.s32 %r639, %r349, %r351
  asm("add.s32 %0, %1, %2;" : "=r"(r639) : "r"(r349), "r"(r351));
  // PTX:214 add.s32 %r640, %r349, %r350
  asm("add.s32 %0, %1, %2;" : "=r"(r640) : "r"(r349), "r"(r350));
  // PTX:216 $L__BB79_22:
L_BB79_22:;
  // PTX:217 mov.u32 %r630, 0
  asm("mov.u32 %0, 0;" : "=r"(r630) : );
  // PTX:218 mov.pred %p146, -1
  p146 = ((-1) != 0);
  // PTX:219 mov.f32 %f1148, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1148) : );
  // PTX:220 mov.u64 %rd435, 0
  asm("mov.u64 %0, 0;" : "=l"(rd435) : );
  // PTX:221 ld.param.u64 %rd115, [%rd2+16]
  rd115 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (16))));
  // PTX:222 cvta.to.global.u64 %rd116, %rd115
  rd116 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd115));
  // PTX:223 add.s64 %rd118, %rd116, %rd94
  asm("add.s64 %0, %1, %2;" : "=l"(rd118) : "l"(rd116), "l"(rd94));
  // PTX:224 ld.global.s32 %rd24, [%rd118]
  rd24 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (0)))));
  // PTX:225 setp.lt.s64 %p31, %rd24, 0
  p31 = (((long long)(rd24)) < ((long long)(0)));
  // PTX:226 mov.u32 %r631, %r630
  asm("mov.u32 %0, %1;" : "=r"(r631) : "r"(r630));
  // PTX:227 mov.u32 %r632, %r630
  asm("mov.u32 %0, %1;" : "=r"(r632) : "r"(r630));
  // PTX:228 mov.u32 %r641, %r630
  asm("mov.u32 %0, %1;" : "=r"(r641) : "r"(r630));
  // PTX:229 @%p31 bra $L__BB79_122
  if (p31) { goto L_BB79_122; }
  // PTX:231 setp.gt.u64 %p32, %rd6, %rd24
  p32 = (((unsigned long long)(rd6)) > ((unsigned long long)(rd24)));
  // PTX:232 @%p32 bra $L__BB79_25
  if (p32) { goto L_BB79_25; }
  // PTX:233 bra.uni $L__BB79_24
  goto L_BB79_24;
  // PTX:235 $L__BB79_25:
L_BB79_25:;
  // PTX:236 ld.param.u64 %rd386, [%rd2+152]
  rd386 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (152))));
  // PTX:237 or.b64 %rd121, %rd24, %rd386
  asm("or.b64 %0, %1, %2;" : "=l"(rd121) : "l"(rd24), "l"(rd386));
  // PTX:238 and.b64 %rd122, %rd121, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd122) : "l"(rd121));
  // PTX:239 setp.eq.s64 %p35, %rd122, 0
  p35 = (((long long)(rd122)) == ((long long)(0)));
  // PTX:240 @%p35 bra $L__BB79_27
  if (p35) { goto L_BB79_27; }
  // PTX:242 ld.param.u64 %rd387, [%rd2+152]
  rd387 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (152))));
  // PTX:243 div.u64 %rd425, %rd24, %rd387
  asm("div.u64 %0, %1, %2;" : "=l"(rd425) : "l"(rd24), "l"(rd387));
  // PTX:244 mul.lo.s64 %rd123, %rd425, %rd387
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd123) : "l"(rd425), "l"(rd387));
  // PTX:245 sub.s64 %rd427, %rd24, %rd123
  asm("sub.s64 %0, %1, %2;" : "=l"(rd427) : "l"(rd24), "l"(rd123));
  // PTX:246 bra.uni $L__BB79_28
  goto L_BB79_28;
  // PTX:248 $L__BB79_24:
L_BB79_24:;
  // PTX:249 mov.u32 %r630, 0
  asm("mov.u32 %0, 0;" : "=r"(r630) : );
  // PTX:250 mov.pred %p146, -1
  p146 = ((-1) != 0);
  // PTX:251 mov.f32 %f1148, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1148) : );
  // PTX:252 ld.param.u64 %rd385, [%rd2+152]
  rd385 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (152))));
  // PTX:253 mov.u64 %rd435, 0
  asm("mov.u64 %0, 0;" : "=l"(rd435) : );
  // PTX:254 ld.param.u64 %rd376, [%rd2+144]
  rd376 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (144))));
  // PTX:255 sub.s64 %rd120, %rd24, %rd6
  asm("sub.s64 %0, %1, %2;" : "=l"(rd120) : "l"(rd24), "l"(rd6));
  // PTX:256 add.s64 %rd427, %rd120, %rd385
  asm("add.s64 %0, %1, %2;" : "=l"(rd427) : "l"(rd120), "l"(rd385));
  // PTX:257 setp.lt.u64 %p34, %rd427, %rd376
  p34 = (((unsigned long long)(rd427)) < ((unsigned long long)(rd376)));
  // PTX:258 mov.u32 %r529, -1
  asm("mov.u32 %0, -1;" : "=r"(r529) : );
  // PTX:259 mov.u32 %r631, %r630
  asm("mov.u32 %0, %1;" : "=r"(r631) : "r"(r630));
  // PTX:260 mov.u32 %r632, %r630
  asm("mov.u32 %0, %1;" : "=r"(r632) : "r"(r630));
  // PTX:261 mov.u32 %r641, %r630
  asm("mov.u32 %0, %1;" : "=r"(r641) : "r"(r630));
  // PTX:262 @%p34 bra $L__BB79_29
  if (p34) { goto L_BB79_29; }
  // PTX:263 bra.uni $L__BB79_122
  goto L_BB79_122;
  // PTX:265 $L__BB79_27:
L_BB79_27:;
  // PTX:266 ld.param.u64 %rd388, [%rd2+152]
  rd388 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (152))));
  // PTX:267 cvt.u32.u64 %r365, %rd388
  asm("cvt.u32.u64 %0, %1;" : "=r"(r365) : "l"(rd388));
  // PTX:268 cvt.u32.u64 %r366, %rd24
  asm("cvt.u32.u64 %0, %1;" : "=r"(r366) : "l"(rd24));
  // PTX:269 div.u32 %r367, %r366, %r365
  asm("div.u32 %0, %1, %2;" : "=r"(r367) : "r"(r366), "r"(r365));
  // PTX:270 mul.lo.s32 %r368, %r367, %r365
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r368) : "r"(r367), "r"(r365));
  // PTX:271 sub.s32 %r369, %r366, %r368
  asm("sub.s32 %0, %1, %2;" : "=r"(r369) : "r"(r366), "r"(r368));
  // PTX:272 cvt.u64.u32 %rd425, %r367
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd425) : "r"(r367));
  // PTX:273 cvt.u64.u32 %rd427, %r369
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd427) : "r"(r369));
  // PTX:275 $L__BB79_28:
L_BB79_28:;
  // PTX:276 cvt.u32.u64 %r529, %rd425
  asm("cvt.u32.u64 %0, %1;" : "=r"(r529) : "l"(rd425));
  // PTX:278 $L__BB79_29:
L_BB79_29:;
  // PTX:279 mov.u64 %rd435, %rd427
  asm("mov.u64 %0, %1;" : "=l"(rd435) : "l"(rd427));
  // PTX:280 ld.param.u64 %rd379, [%rd2+88]
  rd379 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (88))));
  // PTX:281 cvta.to.global.u64 %rd378, %rd379
  rd378 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd379));
  // PTX:282 shl.b64 %rd124, %rd435, 32
  asm("shl.b64 %0, %1, 32;" : "=l"(rd124) : "l"(rd435));
  // PTX:283 shr.s64 %rd125, %rd124, 30
  asm("shr.s64 %0, %1, 30;" : "=l"(rd125) : "l"(rd124));
  // PTX:284 add.s64 %rd126, %rd378, %rd125
  asm("add.s64 %0, %1, %2;" : "=l"(rd126) : "l"(rd378), "l"(rd125));
  // PTX:285 ld.global.s32 %rd34, [%rd126]
  rd34 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (0)))));
  // PTX:286 setp.lt.s64 %p36, %rd34, 0
  p36 = (((long long)(rd34)) < ((long long)(0)));
  // PTX:287 mov.u32 %r370, -1
  asm("mov.u32 %0, -1;" : "=r"(r370) : );
  // PTX:288 mov.u32 %r641, %r370
  asm("mov.u32 %0, %1;" : "=r"(r641) : "r"(r370));
  // PTX:289 @%p36 bra $L__BB79_37
  if (p36) { goto L_BB79_37; }
  // PTX:291 setp.gt.u64 %p37, %rd9, %rd34
  p37 = (((unsigned long long)(rd9)) > ((unsigned long long)(rd34)));
  // PTX:292 @%p37 bra $L__BB79_32
  if (p37) { goto L_BB79_32; }
  // PTX:293 bra.uni $L__BB79_31
  goto L_BB79_31;
  // PTX:295 $L__BB79_32:
L_BB79_32:;
  // PTX:296 cvt.u32.u64 %r372, %rd34
  asm("cvt.u32.u64 %0, %1;" : "=r"(r372) : "l"(rd34));
  // PTX:297 shl.b64 %rd127, %rd34, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd127) : "l"(rd34));
  // PTX:298 add.s64 %rd128, %rd8, %rd127
  asm("add.s64 %0, %1, %2;" : "=l"(rd128) : "l"(rd8), "l"(rd127));
  // PTX:299 ld.global.u32 %r373, [%rd128]
  r373 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (0)))));
  // PTX:300 setp.eq.s32 %p39, %r373, %r372
  p39 = (((int)(r373)) == ((int)(r372)));
  // PTX:301 setp.eq.s64 %p40, %rd9, 0
  p40 = (((long long)(rd9)) == ((long long)(0)));
  // PTX:302 or.pred %p41, %p39, %p40
  p41 = ((p39) || (p40));
  // PTX:303 selp.b32 %r641, %r372, -1, %p39
  r641 = p39 ? r372 : -1;
  // PTX:304 @%p41 bra $L__BB79_37
  if (p41) { goto L_BB79_37; }
  // PTX:305 bra.uni $L__BB79_33
  goto L_BB79_33;
  // PTX:307 $L__BB79_31:
L_BB79_31:;
  // PTX:308 setp.eq.s64 %p38, %rd9, 0
  p38 = (((long long)(rd9)) == ((long long)(0)));
  // PTX:309 mov.u32 %r641, %r370
  asm("mov.u32 %0, %1;" : "=r"(r641) : "r"(r370));
  // PTX:310 @%p38 bra $L__BB79_37
  if (p38) { goto L_BB79_37; }
  // PTX:312 $L__BB79_33:
L_BB79_33:;
  // PTX:313 mov.u64 %rd428, 0
  asm("mov.u64 %0, 0;" : "=l"(rd428) : );
  // PTX:314 cvt.u32.u64 %r375, %rd34
  asm("cvt.u32.u64 %0, %1;" : "=r"(r375) : "l"(rd34));
  // PTX:316 $L__BB79_34:
L_BB79_34:;
  // PTX:317 shl.b64 %rd130, %rd428, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd130) : "l"(rd428));
  // PTX:318 add.s64 %rd131, %rd8, %rd130
  asm("add.s64 %0, %1, %2;" : "=l"(rd131) : "l"(rd8), "l"(rd130));
  // PTX:319 ld.global.u32 %r374, [%rd131]
  r374 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd131) + (0)))));
  // PTX:320 setp.eq.s32 %p42, %r374, %r375
  p42 = (((int)(r374)) == ((int)(r375)));
  // PTX:321 @%p42 bra $L__BB79_36
  if (p42) { goto L_BB79_36; }
  // PTX:323 add.s64 %rd428, %rd428, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd428) : "l"(rd428));
  // PTX:324 setp.lt.u64 %p43, %rd428, %rd9
  p43 = (((unsigned long long)(rd428)) < ((unsigned long long)(rd9)));
  // PTX:325 mov.u32 %r641, %r370
  asm("mov.u32 %0, %1;" : "=r"(r641) : "r"(r370));
  // PTX:326 @%p43 bra $L__BB79_34
  if (p43) { goto L_BB79_34; }
  // PTX:327 bra.uni $L__BB79_37
  goto L_BB79_37;
  // PTX:329 $L__BB79_36:
L_BB79_36:;
  // PTX:330 cvt.u32.u64 %r641, %rd428
  asm("cvt.u32.u64 %0, %1;" : "=r"(r641) : "l"(rd428));
  // PTX:332 $L__BB79_37:
L_BB79_37:;
  // PTX:333 mov.u32 %r630, 0
  asm("mov.u32 %0, 0;" : "=r"(r630) : );
  // PTX:334 mov.pred %p146, -1
  p146 = ((-1) != 0);
  // PTX:335 mov.f32 %f1148, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1148) : );
  // PTX:336 cvt.u32.u64 %r381, %rd34
  asm("cvt.u32.u64 %0, %1;" : "=r"(r381) : "l"(rd34));
  // PTX:337 setp.gt.s32 %p45, %r381, -1
  p45 = (((int)(r381)) > ((int)(-1)));
  // PTX:338 setp.lt.s32 %p46, %r641, 0
  p46 = (((int)(r641)) < ((int)(0)));
  // PTX:339 and.pred %p47, %p45, %p46
  p47 = ((p45) && (p46));
  // PTX:340 mov.u32 %r631, %r630
  asm("mov.u32 %0, %1;" : "=r"(r631) : "r"(r630));
  // PTX:341 mov.u32 %r632, %r630
  asm("mov.u32 %0, %1;" : "=r"(r632) : "r"(r630));
  // PTX:342 @%p47 bra $L__BB79_122
  if (p47) { goto L_BB79_122; }
  // PTX:344 mov.u32 %r630, 0
  asm("mov.u32 %0, 0;" : "=r"(r630) : );
  // PTX:345 mov.pred %p146, -1
  p146 = ((-1) != 0);
  // PTX:346 mov.f32 %f1148, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1148) : );
  // PTX:347 setp.gt.s32 %p49, %r641, -1
  p49 = (((int)(r641)) > ((int)(-1)));
  // PTX:348 setp.lt.s32 %p50, %r529, 0
  p50 = (((int)(r529)) < ((int)(0)));
  // PTX:349 and.pred %p51, %p49, %p50
  p51 = ((p49) && (p50));
  // PTX:350 @%p51 bra $L__BB79_122
  if (p51) { goto L_BB79_122; }
  // PTX:352 mov.u32 %r630, 0
  asm("mov.u32 %0, 0;" : "=r"(r630) : );
  // PTX:353 mov.u32 %r636, %r630
  asm("mov.u32 %0, %1;" : "=r"(r636) : "r"(r630));
  // PTX:354 mov.u32 %r635, %r630
  asm("mov.u32 %0, %1;" : "=r"(r635) : "r"(r630));
  // PTX:355 mov.u32 %r634, %r630
  asm("mov.u32 %0, %1;" : "=r"(r634) : "r"(r630));
  // PTX:356 mov.u32 %r633, %r630
  asm("mov.u32 %0, %1;" : "=r"(r633) : "r"(r630));
  // PTX:357 @%p46 bra $L__BB79_41
  if (p46) { goto L_BB79_41; }
  // PTX:359 ld.param.u32 %r514, [%rd2+200]
  r514 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd2) + (200))));
  // PTX:360 ld.param.u64 %rd381, [%rd2+176]
  rd381 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (176))));
  // PTX:361 cvta.to.global.u64 %rd380, %rd381
  rd380 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd381));
  // PTX:362 mul.wide.s32 %rd132, %r641, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd132) : "r"(r641));
  // PTX:363 add.s64 %rd133, %rd380, %rd132
  asm("add.s64 %0, %1, %2;" : "=l"(rd133) : "l"(rd380), "l"(rd132));
  // PTX:364 mul.lo.s32 %r390, %r529, %r514
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r390) : "r"(r529), "r"(r514));
  // PTX:365 ld.global.u32 %r391, [%rd133]
  r391 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd133) + (0)))));
  // PTX:366 ld.global.u32 %r392, [%rd133+4]
  r392 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd133) + (4)))));
  // PTX:367 ld.global.u32 %r393, [%rd133+8]
  r393 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd133) + (8)))));
  // PTX:368 ld.global.u32 %r394, [%rd133+12]
  r394 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd133) + (12)))));
  // PTX:369 add.s32 %r633, %r390, %r394
  asm("add.s32 %0, %1, %2;" : "=r"(r633) : "r"(r390), "r"(r394));
  // PTX:370 add.s32 %r634, %r390, %r393
  asm("add.s32 %0, %1, %2;" : "=r"(r634) : "r"(r390), "r"(r393));
  // PTX:371 add.s32 %r635, %r390, %r392
  asm("add.s32 %0, %1, %2;" : "=r"(r635) : "r"(r390), "r"(r392));
  // PTX:372 add.s32 %r636, %r390, %r391
  asm("add.s32 %0, %1, %2;" : "=r"(r636) : "r"(r390), "r"(r391));
  // PTX:374 $L__BB79_41:
L_BB79_41:;
  // PTX:375 mov.pred %p146, -1
  p146 = ((-1) != 0);
  // PTX:376 mov.f32 %f1148, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1148) : );
  // PTX:377 or.b32 %r399, %r529, %r523
  asm("or.b32 %0, %1, %2;" : "=r"(r399) : "r"(r529), "r"(r523));
  // PTX:378 setp.gt.s32 %p54, %r399, -1
  p54 = (((int)(r399)) > ((int)(-1)));
  // PTX:379 setp.ne.s32 %p55, %r523, %r529
  p55 = (((int)(r523)) != ((int)(r529)));
  // PTX:380 and.pred %p56, %p55, %p54
  p56 = ((p55) && (p54));
  // PTX:381 and.b32 %r400, %r641, %r642
  asm("and.b32 %0, %1, %2;" : "=r"(r400) : "r"(r641), "r"(r642));
  // PTX:382 setp.lt.s32 %p57, %r400, 0
  p57 = (((int)(r400)) < ((int)(0)));
  // PTX:383 or.pred %p58, %p56, %p57
  p58 = ((p56) || (p57));
  // PTX:384 mov.u32 %r631, %r630
  asm("mov.u32 %0, %1;" : "=r"(r631) : "r"(r630));
  // PTX:385 mov.u32 %r632, %r630
  asm("mov.u32 %0, %1;" : "=r"(r632) : "r"(r630));
  // PTX:386 @%p58 bra $L__BB79_122
  if (p58) { goto L_BB79_122; }
  // PTX:388 mov.u32 %r517, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r517) : "r"(blockDim.x));
  // PTX:389 mov.u32 %r516, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r516) : "r"(blockIdx.x));
  // PTX:390 mov.u32 %r515, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r515) : "r"(threadIdx.x));
  // PTX:391 cvt.u64.u32 %rd384, %r515
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd384) : "r"(r515));
  // PTX:392 mul.wide.u32 %rd383, %r516, %r517
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd383) : "r"(r516), "r"(r517));
  // PTX:393 add.s64 %rd382, %rd383, %rd384
  asm("add.s64 %0, %1, %2;" : "=l"(rd382) : "l"(rd383), "l"(rd384));
  // PTX:394 ld.param.u64 %rd136, [%rd2+56]
  rd136 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (56))));
  // PTX:395 cvta.to.global.u64 %rd137, %rd136
  rd137 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd136));
  // PTX:396 mul.lo.s64 %rd138, %rd382, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd138) : "l"(rd382));
  // PTX:397 add.s64 %rd139, %rd137, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd139) : "l"(rd137), "l"(rd138));
  // PTX:398 ld.global.f32 %f1, [%rd139]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd139) + (0)))));
  // PTX:399 ld.global.f32 %f2, [%rd139+4]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd139) + (4)))));
  // PTX:400 mul.f32 %f260, %f2, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f260) : "f"(f2), "f"(f2));
  // PTX:401 ld.global.f32 %f3, [%rd139+8]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd139) + (8)))));
  // PTX:402 fma.rn.f32 %f261, %f1, %f1, %f260
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f261) : "f"(f1), "f"(f1), "f"(f260));
  // PTX:403 fma.rn.f32 %f262, %f3, %f3, %f261
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f262) : "f"(f3), "f"(f3), "f"(f261));
  // PTX:404 sqrt.rn.f32 %f4, %f262
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f4) : "f"(f262));
  // PTX:405 setp.leu.f32 %p59, %f4, 0f00000000
  p59 = ((isnan(((float)(f4))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f4)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:406 mov.u32 %r535, 0
  asm("mov.u32 %0, 0;" : "=r"(r535) : );
  // PTX:407 mov.u32 %r536, %r535
  asm("mov.u32 %0, %1;" : "=r"(r536) : "r"(r535));
  // PTX:408 mov.u32 %r537, %r535
  asm("mov.u32 %0, %1;" : "=r"(r537) : "r"(r535));
  // PTX:409 @%p59 bra $L__BB79_44
  if (p59) { goto L_BB79_44; }
  // PTX:411 div.rn.f32 %f263, %f1, %f4
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f263) : "f"(f1), "f"(f4));
  // PTX:412 div.rn.f32 %f264, %f2, %f4
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f264) : "f"(f2), "f"(f4));
  // PTX:413 div.rn.f32 %f265, %f3, %f4
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f265) : "f"(f3), "f"(f4));
  // PTX:414 mov.b32 %r537, %f265
  asm("mov.b32 %0, %1;" : "=r"(r537) : "f"(f265));
  // PTX:415 mov.b32 %r536, %f264
  asm("mov.b32 %0, %1;" : "=r"(r536) : "f"(f264));
  // PTX:416 mov.b32 %r535, %f263
  asm("mov.b32 %0, %1;" : "=r"(r535) : "f"(f263));
  // PTX:418 $L__BB79_44:
L_BB79_44:;
  // PTX:419 cvt.s64.s32 %rd358, %rd435
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd358) : "l"(rd435));
  // PTX:420 cvt.s64.s32 %rd357, %rd436
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd357) : "l"(rd436));
  // PTX:421 ld.param.u64 %rd356, [%rd2+96]
  rd356 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (96))));
  // PTX:422 cvta.to.global.u64 %rd144, %rd356
  rd144 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd356));
  // PTX:423 shl.b64 %rd145, %rd357, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd145) : "l"(rd357));
  // PTX:424 add.s64 %rd146, %rd144, %rd145
  asm("add.s64 %0, %1, %2;" : "=l"(rd146) : "l"(rd144), "l"(rd145));
  // PTX:425 ld.global.u32 %r42, [%rd146]
  r42 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd146) + (0)))));
  // PTX:426 setp.eq.s32 %p60, %r42, 3
  p60 = (((int)(r42)) == ((int)(3)));
  // PTX:427 shl.b64 %rd147, %rd358, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd147) : "l"(rd358));
  // PTX:428 add.s64 %rd148, %rd144, %rd147
  asm("add.s64 %0, %1, %2;" : "=l"(rd148) : "l"(rd144), "l"(rd147));
  // PTX:429 ld.global.u32 %r43, [%rd148]
  r43 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd148) + (0)))));
  // PTX:430 @%p60 bra $L__BB79_46
  if (p60) { goto L_BB79_46; }
  // PTX:431 bra.uni $L__BB79_45
  goto L_BB79_45;
  // PTX:433 $L__BB79_46:
L_BB79_46:;
  // PTX:434 ld.param.u64 %rd400, [%rd2+104]
  rd400 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (104))));
  // PTX:435 cvta.to.global.u64 %rd399, %rd400
  rd399 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd400));
  // PTX:436 cvt.s64.s32 %rd364, %rd436
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd364) : "l"(rd436));
  // PTX:437 mul.lo.s64 %rd150, %rd364, 28
  asm("mul.lo.s64 %0, %1, 28;" : "=l"(rd150) : "l"(rd364));
  // PTX:438 add.s64 %rd431, %rd399, %rd150
  asm("add.s64 %0, %1, %2;" : "=l"(rd431) : "l"(rd399), "l"(rd150));
  // PTX:439 add.s64 %rd430, %rd431, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd430) : "l"(rd431));
  // PTX:440 add.s64 %rd429, %rd431, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd429) : "l"(rd431));
  // PTX:441 bra.uni $L__BB79_47
  goto L_BB79_47;
  // PTX:443 $L__BB79_45:
L_BB79_45:;
  // PTX:444 ld.param.u64 %rd360, [%rd2+24]
  rd360 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (24))));
  // PTX:445 cvta.to.global.u64 %rd359, %rd360
  rd359 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd360));
  // PTX:446 add.s64 %rd431, %rd359, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd431) : "l"(rd359), "l"(rd138));
  // PTX:447 add.s64 %rd430, %rd431, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd430) : "l"(rd431));
  // PTX:448 add.s64 %rd429, %rd431, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd429) : "l"(rd431));
  // PTX:450 $L__BB79_47:
L_BB79_47:;
  // PTX:451 ld.global.u32 %r629, [%rd431]
  r629 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd431) + (0)))));
  // PTX:452 ld.global.u32 %r628, [%rd430]
  r628 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd430) + (0)))));
  // PTX:453 ld.global.u32 %r627, [%rd429]
  r627 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd429) + (0)))));
  // PTX:454 setp.eq.s32 %p61, %r43, 3
  p61 = (((int)(r43)) == ((int)(3)));
  // PTX:455 @%p61 bra $L__BB79_49
  if (p61) { goto L_BB79_49; }
  // PTX:456 bra.uni $L__BB79_48
  goto L_BB79_48;
  // PTX:458 $L__BB79_49:
L_BB79_49:;
  // PTX:459 ld.param.u64 %rd398, [%rd2+104]
  rd398 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (104))));
  // PTX:460 cvta.to.global.u64 %rd397, %rd398
  rd397 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd398));
  // PTX:461 cvt.s64.s32 %rd363, %rd435
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd363) : "l"(rd435));
  // PTX:462 mul.lo.s64 %rd152, %rd363, 28
  asm("mul.lo.s64 %0, %1, 28;" : "=l"(rd152) : "l"(rd363));
  // PTX:463 add.s64 %rd434, %rd397, %rd152
  asm("add.s64 %0, %1, %2;" : "=l"(rd434) : "l"(rd397), "l"(rd152));
  // PTX:464 add.s64 %rd433, %rd434, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd433) : "l"(rd434));
  // PTX:465 add.s64 %rd432, %rd434, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd432) : "l"(rd434));
  // PTX:466 bra.uni $L__BB79_50
  goto L_BB79_50;
  // PTX:468 $L__BB79_48:
L_BB79_48:;
  // PTX:469 ld.param.u64 %rd362, [%rd2+32]
  rd362 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (32))));
  // PTX:470 cvta.to.global.u64 %rd361, %rd362
  rd361 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd362));
  // PTX:471 add.s64 %rd434, %rd361, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd434) : "l"(rd361), "l"(rd138));
  // PTX:472 add.s64 %rd433, %rd434, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd433) : "l"(rd434));
  // PTX:473 add.s64 %rd432, %rd434, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd432) : "l"(rd434));
  // PTX:475 $L__BB79_50:
L_BB79_50:;
  // PTX:476 setp.lt.s32 %p134, %r642, 0
  p134 = (((int)(r642)) < ((int)(0)));
  // PTX:477 ld.global.u32 %r626, [%rd434]
  r626 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd434) + (0)))));
  // PTX:478 ld.global.u32 %r625, [%rd433]
  r625 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd433) + (0)))));
  // PTX:479 ld.global.u32 %r624, [%rd432]
  r624 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd432) + (0)))));
  // PTX:480 mov.u32 %r538, %r627
  asm("mov.u32 %0, %1;" : "=r"(r538) : "r"(r627));
  // PTX:481 mov.u32 %r539, %r628
  asm("mov.u32 %0, %1;" : "=r"(r539) : "r"(r628));
  // PTX:482 mov.u32 %r540, %r629
  asm("mov.u32 %0, %1;" : "=r"(r540) : "r"(r629));
  // PTX:483 @%p134 bra $L__BB79_52
  if (p134) { goto L_BB79_52; }
  // PTX:485 ld.param.u64 %rd412, [%rd2+208]
  rd412 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (208))));
  // PTX:486 cvta.to.global.u64 %rd411, %rd412
  rd411 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd412));
  // PTX:487 mul.wide.s32 %rd410, %r637, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd410) : "r"(r637));
  // PTX:488 add.s64 %rd409, %rd411, %rd410
  asm("add.s64 %0, %1, %2;" : "=l"(rd409) : "l"(rd411), "l"(rd410));
  // PTX:489 mul.wide.s32 %rd408, %r639, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd408) : "r"(r639));
  // PTX:490 add.s64 %rd407, %rd411, %rd408
  asm("add.s64 %0, %1, %2;" : "=l"(rd407) : "l"(rd411), "l"(rd408));
  // PTX:491 ld.param.u64 %rd370, [%rd2+208]
  rd370 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (208))));
  // PTX:492 mul.wide.s32 %rd369, %r638, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd369) : "r"(r638));
  // PTX:493 cvta.to.global.u64 %rd368, %rd370
  rd368 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd370));
  // PTX:494 add.s64 %rd367, %rd368, %rd369
  asm("add.s64 %0, %1, %2;" : "=l"(rd367) : "l"(rd368), "l"(rd369));
  // PTX:495 ld.param.u64 %rd366, [%rd2+184]
  rd366 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (184))));
  // PTX:496 cvta.to.global.u64 %rd365, %rd366
  rd365 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd366));
  // PTX:497 mul.wide.s32 %rd156, %r642, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd156) : "r"(r642));
  // PTX:498 add.s64 %rd157, %rd365, %rd156
  asm("add.s64 %0, %1, %2;" : "=l"(rd157) : "l"(rd365), "l"(rd156));
  // PTX:499 mov.b32 %f266, %r629
  asm("mov.b32 %0, %1;" : "=f"(f266) : "r"(r629));
  // PTX:500 ld.global.f32 %f267, [%rd157]
  f267 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd157) + (0)))));
  // PTX:501 sub.f32 %f268, %f266, %f267
  asm("sub.f32 %0, %1, %2;" : "=f"(f268) : "f"(f266), "f"(f267));
  // PTX:502 mov.b32 %f269, %r628
  asm("mov.b32 %0, %1;" : "=f"(f269) : "r"(r628));
  // PTX:503 ld.global.f32 %f270, [%rd157+4]
  f270 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd157) + (4)))));
  // PTX:504 sub.f32 %f271, %f269, %f270
  asm("sub.f32 %0, %1, %2;" : "=f"(f271) : "f"(f269), "f"(f270));
  // PTX:505 mov.b32 %f272, %r627
  asm("mov.b32 %0, %1;" : "=f"(f272) : "r"(r627));
  // PTX:506 ld.global.f32 %f273, [%rd157+8]
  f273 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd157) + (8)))));
  // PTX:507 sub.f32 %f274, %f272, %f273
  asm("sub.f32 %0, %1, %2;" : "=f"(f274) : "f"(f272), "f"(f273));
  // PTX:508 mul.wide.s32 %rd158, %r640, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd158) : "r"(r640));
  // PTX:509 add.s64 %rd159, %rd368, %rd158
  asm("add.s64 %0, %1, %2;" : "=l"(rd159) : "l"(rd368), "l"(rd158));
  // PTX:510 ld.global.f32 %f275, [%rd407]
  f275 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd407) + (0)))));
  // PTX:511 ld.global.f32 %f276, [%rd407+4]
  f276 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd407) + (4)))));
  // PTX:512 ld.global.f32 %f277, [%rd407+8]
  f277 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd407) + (8)))));
  // PTX:513 ld.global.f32 %f278, [%rd159]
  f278 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd159) + (0)))));
  // PTX:514 fma.rn.f32 %f279, %f268, %f275, %f278
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f279) : "f"(f268), "f"(f275), "f"(f278));
  // PTX:515 ld.global.f32 %f280, [%rd159+4]
  f280 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd159) + (4)))));
  // PTX:516 fma.rn.f32 %f281, %f268, %f276, %f280
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f281) : "f"(f268), "f"(f276), "f"(f280));
  // PTX:517 ld.global.f32 %f282, [%rd159+8]
  f282 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd159) + (8)))));
  // PTX:518 fma.rn.f32 %f283, %f268, %f277, %f282
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f283) : "f"(f268), "f"(f277), "f"(f282));
  // PTX:519 ld.global.f32 %f284, [%rd367]
  f284 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd367) + (0)))));
  // PTX:520 ld.global.f32 %f285, [%rd367+4]
  f285 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd367) + (4)))));
  // PTX:521 ld.global.f32 %f286, [%rd367+8]
  f286 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd367) + (8)))));
  // PTX:522 fma.rn.f32 %f287, %f271, %f284, %f279
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f287) : "f"(f271), "f"(f284), "f"(f279));
  // PTX:523 fma.rn.f32 %f288, %f271, %f285, %f281
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f288) : "f"(f271), "f"(f285), "f"(f281));
  // PTX:524 fma.rn.f32 %f289, %f271, %f286, %f283
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f289) : "f"(f271), "f"(f286), "f"(f283));
  // PTX:525 ld.global.f32 %f290, [%rd409]
  f290 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd409) + (0)))));
  // PTX:526 ld.global.f32 %f291, [%rd409+4]
  f291 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd409) + (4)))));
  // PTX:527 ld.global.f32 %f292, [%rd409+8]
  f292 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd409) + (8)))));
  // PTX:528 fma.rn.f32 %f293, %f274, %f290, %f287
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f293) : "f"(f274), "f"(f290), "f"(f287));
  // PTX:529 fma.rn.f32 %f294, %f274, %f291, %f288
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f294) : "f"(f274), "f"(f291), "f"(f288));
  // PTX:530 fma.rn.f32 %f295, %f274, %f292, %f289
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f295) : "f"(f274), "f"(f292), "f"(f289));
  // PTX:531 mov.b32 %r540, %f293
  asm("mov.b32 %0, %1;" : "=r"(r540) : "f"(f293));
  // PTX:532 mov.b32 %r539, %f294
  asm("mov.b32 %0, %1;" : "=r"(r539) : "f"(f294));
  // PTX:533 mov.b32 %r538, %f295
  asm("mov.b32 %0, %1;" : "=r"(r538) : "f"(f295));
  // PTX:535 $L__BB79_52:
L_BB79_52:;
  // PTX:536 setp.lt.s32 %p135, %r641, 0
  p135 = (((int)(r641)) < ((int)(0)));
  // PTX:537 mov.u32 %r541, %r624
  asm("mov.u32 %0, %1;" : "=r"(r541) : "r"(r624));
  // PTX:538 mov.u32 %r542, %r625
  asm("mov.u32 %0, %1;" : "=r"(r542) : "r"(r625));
  // PTX:539 mov.u32 %r543, %r626
  asm("mov.u32 %0, %1;" : "=r"(r543) : "r"(r626));
  // PTX:540 @%p135 bra $L__BB79_54
  if (p135) { goto L_BB79_54; }
  // PTX:542 ld.param.u64 %rd420, [%rd2+208]
  rd420 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (208))));
  // PTX:543 cvta.to.global.u64 %rd419, %rd420
  rd419 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd420));
  // PTX:544 mul.wide.s32 %rd418, %r633, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd418) : "r"(r633));
  // PTX:545 add.s64 %rd417, %rd419, %rd418
  asm("add.s64 %0, %1, %2;" : "=l"(rd417) : "l"(rd419), "l"(rd418));
  // PTX:546 mul.wide.s32 %rd416, %r634, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd416) : "r"(r634));
  // PTX:547 add.s64 %rd415, %rd419, %rd416
  asm("add.s64 %0, %1, %2;" : "=l"(rd415) : "l"(rd419), "l"(rd416));
  // PTX:548 mul.wide.s32 %rd414, %r635, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd414) : "r"(r635));
  // PTX:549 add.s64 %rd413, %rd419, %rd414
  asm("add.s64 %0, %1, %2;" : "=l"(rd413) : "l"(rd419), "l"(rd414));
  // PTX:550 ld.param.u64 %rd406, [%rd2+208]
  rd406 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (208))));
  // PTX:551 cvta.to.global.u64 %rd405, %rd406
  rd405 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd406));
  // PTX:552 ld.param.u64 %rd333, [%rd2+184]
  rd333 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (184))));
  // PTX:553 cvta.to.global.u64 %rd332, %rd333
  rd332 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd333));
  // PTX:554 mul.wide.s32 %rd163, %r641, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd163) : "r"(r641));
  // PTX:555 add.s64 %rd164, %rd332, %rd163
  asm("add.s64 %0, %1, %2;" : "=l"(rd164) : "l"(rd332), "l"(rd163));
  // PTX:556 mov.b32 %f296, %r626
  asm("mov.b32 %0, %1;" : "=f"(f296) : "r"(r626));
  // PTX:557 ld.global.f32 %f297, [%rd164]
  f297 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd164) + (0)))));
  // PTX:558 sub.f32 %f298, %f296, %f297
  asm("sub.f32 %0, %1, %2;" : "=f"(f298) : "f"(f296), "f"(f297));
  // PTX:559 mov.b32 %f299, %r625
  asm("mov.b32 %0, %1;" : "=f"(f299) : "r"(r625));
  // PTX:560 ld.global.f32 %f300, [%rd164+4]
  f300 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd164) + (4)))));
  // PTX:561 sub.f32 %f301, %f299, %f300
  asm("sub.f32 %0, %1, %2;" : "=f"(f301) : "f"(f299), "f"(f300));
  // PTX:562 mov.b32 %f302, %r624
  asm("mov.b32 %0, %1;" : "=f"(f302) : "r"(r624));
  // PTX:563 ld.global.f32 %f303, [%rd164+8]
  f303 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd164) + (8)))));
  // PTX:564 sub.f32 %f304, %f302, %f303
  asm("sub.f32 %0, %1, %2;" : "=f"(f304) : "f"(f302), "f"(f303));
  // PTX:565 mul.wide.s32 %rd165, %r636, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd165) : "r"(r636));
  // PTX:566 add.s64 %rd166, %rd405, %rd165
  asm("add.s64 %0, %1, %2;" : "=l"(rd166) : "l"(rd405), "l"(rd165));
  // PTX:567 ld.global.f32 %f305, [%rd413]
  f305 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd413) + (0)))));
  // PTX:568 ld.global.f32 %f306, [%rd413+4]
  f306 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd413) + (4)))));
  // PTX:569 ld.global.f32 %f307, [%rd413+8]
  f307 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd413) + (8)))));
  // PTX:570 ld.global.f32 %f308, [%rd166]
  f308 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (0)))));
  // PTX:571 fma.rn.f32 %f309, %f298, %f305, %f308
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f309) : "f"(f298), "f"(f305), "f"(f308));
  // PTX:572 ld.global.f32 %f310, [%rd166+4]
  f310 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (4)))));
  // PTX:573 fma.rn.f32 %f311, %f298, %f306, %f310
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f311) : "f"(f298), "f"(f306), "f"(f310));
  // PTX:574 ld.global.f32 %f312, [%rd166+8]
  f312 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (8)))));
  // PTX:575 fma.rn.f32 %f313, %f298, %f307, %f312
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f313) : "f"(f298), "f"(f307), "f"(f312));
  // PTX:576 ld.global.f32 %f314, [%rd415]
  f314 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd415) + (0)))));
  // PTX:577 ld.global.f32 %f315, [%rd415+4]
  f315 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd415) + (4)))));
  // PTX:578 ld.global.f32 %f316, [%rd415+8]
  f316 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd415) + (8)))));
  // PTX:579 fma.rn.f32 %f317, %f301, %f314, %f309
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f317) : "f"(f301), "f"(f314), "f"(f309));
  // PTX:580 fma.rn.f32 %f318, %f301, %f315, %f311
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f318) : "f"(f301), "f"(f315), "f"(f311));
  // PTX:581 fma.rn.f32 %f319, %f301, %f316, %f313
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f319) : "f"(f301), "f"(f316), "f"(f313));
  // PTX:582 ld.global.f32 %f320, [%rd417]
  f320 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd417) + (0)))));
  // PTX:583 ld.global.f32 %f321, [%rd417+4]
  f321 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd417) + (4)))));
  // PTX:584 ld.global.f32 %f322, [%rd417+8]
  f322 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd417) + (8)))));
  // PTX:585 fma.rn.f32 %f323, %f304, %f320, %f317
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f323) : "f"(f304), "f"(f320), "f"(f317));
  // PTX:586 fma.rn.f32 %f324, %f304, %f321, %f318
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f324) : "f"(f304), "f"(f321), "f"(f318));
  // PTX:587 fma.rn.f32 %f325, %f304, %f322, %f319
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f325) : "f"(f304), "f"(f322), "f"(f319));
  // PTX:588 mov.b32 %r543, %f323
  asm("mov.b32 %0, %1;" : "=r"(r543) : "f"(f323));
  // PTX:589 mov.b32 %r542, %f324
  asm("mov.b32 %0, %1;" : "=r"(r542) : "f"(f324));
  // PTX:590 mov.b32 %r541, %f325
  asm("mov.b32 %0, %1;" : "=r"(r541) : "f"(f325));
  // PTX:592 $L__BB79_54:
L_BB79_54:;
  // PTX:593 setp.ne.s32 %p64, %r42, 3
  p64 = (((int)(r42)) != ((int)(3)));
  // PTX:594 setp.ne.s32 %p65, %r43, 3
  p65 = (((int)(r43)) != ((int)(3)));
  // PTX:595 mov.u32 %r632, 0
  asm("mov.u32 %0, 0;" : "=r"(r632) : );
  // PTX:596 or.pred %p66, %p64, %p65
  p66 = ((p64) || (p65));
  // PTX:597 mov.u32 %r631, %r632
  asm("mov.u32 %0, %1;" : "=r"(r631) : "r"(r632));
  // PTX:598 mov.u32 %r630, %r632
  asm("mov.u32 %0, %1;" : "=r"(r630) : "r"(r632));
  // PTX:599 @%p66 bra $L__BB79_57
  if (p66) { goto L_BB79_57; }
  // PTX:601 mov.b32 %f326, %r543
  asm("mov.b32 %0, %1;" : "=f"(f326) : "r"(r543));
  // PTX:602 mov.b32 %f327, %r540
  asm("mov.b32 %0, %1;" : "=f"(f327) : "r"(r540));
  // PTX:603 sub.f32 %f5, %f326, %f327
  asm("sub.f32 %0, %1, %2;" : "=f"(f5) : "f"(f326), "f"(f327));
  // PTX:604 mov.b32 %f328, %r539
  asm("mov.b32 %0, %1;" : "=f"(f328) : "r"(r539));
  // PTX:605 mov.b32 %f329, %r542
  asm("mov.b32 %0, %1;" : "=f"(f329) : "r"(r542));
  // PTX:606 sub.f32 %f6, %f329, %f328
  asm("sub.f32 %0, %1, %2;" : "=f"(f6) : "f"(f329), "f"(f328));
  // PTX:607 mov.b32 %f330, %r538
  asm("mov.b32 %0, %1;" : "=f"(f330) : "r"(r538));
  // PTX:608 mov.b32 %f331, %r541
  asm("mov.b32 %0, %1;" : "=f"(f331) : "r"(r541));
  // PTX:609 sub.f32 %f7, %f331, %f330
  asm("sub.f32 %0, %1, %2;" : "=f"(f7) : "f"(f331), "f"(f330));
  // PTX:610 mul.f32 %f332, %f6, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f332) : "f"(f6), "f"(f6));
  // PTX:611 fma.rn.f32 %f333, %f5, %f5, %f332
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f333) : "f"(f5), "f"(f5), "f"(f332));
  // PTX:612 fma.rn.f32 %f334, %f7, %f7, %f333
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f334) : "f"(f7), "f"(f7), "f"(f333));
  // PTX:613 sqrt.rn.f32 %f8, %f334
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f8) : "f"(f334));
  // PTX:614 setp.leu.f32 %p67, %f8, 0f00000000
  p67 = ((isnan(((float)(f8))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f8)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:615 mov.u32 %r632, 0
  asm("mov.u32 %0, 0;" : "=r"(r632) : );
  // PTX:616 @%p67 bra $L__BB79_57
  if (p67) { goto L_BB79_57; }
  // PTX:618 div.rn.f32 %f335, %f5, %f8
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f335) : "f"(f5), "f"(f8));
  // PTX:619 div.rn.f32 %f336, %f6, %f8
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f336) : "f"(f6), "f"(f8));
  // PTX:620 div.rn.f32 %f337, %f7, %f8
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f337) : "f"(f7), "f"(f8));
  // PTX:621 mov.b32 %r630, %f337
  asm("mov.b32 %0, %1;" : "=r"(r630) : "f"(f337));
  // PTX:622 mov.b32 %r631, %f336
  asm("mov.b32 %0, %1;" : "=r"(r631) : "f"(f336));
  // PTX:623 mov.b32 %r632, %f335
  asm("mov.b32 %0, %1;" : "=r"(r632) : "f"(f335));
  // PTX:625 $L__BB79_57:
L_BB79_57:;
  // PTX:626 mov.b32 %f1099, %r632
  asm("mov.b32 %0, %1;" : "=f"(f1099) : "r"(r632));
  // PTX:627 mov.b32 %f1098, %r631
  asm("mov.b32 %0, %1;" : "=f"(f1098) : "r"(r631));
  // PTX:628 mul.f32 %f338, %f1098, %f1098
  asm("mul.f32 %0, %1, %2;" : "=f"(f338) : "f"(f1098), "f"(f1098));
  // PTX:629 mov.b32 %f1097, %r630
  asm("mov.b32 %0, %1;" : "=f"(f1097) : "r"(r630));
  // PTX:630 fma.rn.f32 %f339, %f1099, %f1099, %f338
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f339) : "f"(f1099), "f"(f1099), "f"(f338));
  // PTX:631 fma.rn.f32 %f1096, %f1097, %f1097, %f339
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1096) : "f"(f1097), "f"(f1097), "f"(f339));
  // PTX:632 setp.ge.f32 %p68, %f1096, 0f3F000000
  p68 = (!(isnan(((float)(f1096))) || isnan(((float)(as_f32(0x3F000000u))))) && (((float)(f1096)) >= ((float)(as_f32(0x3F000000u)))));
  // PTX:633 @%p68 bra $L__BB79_59
  if (p68) { goto L_BB79_59; }
  // PTX:635 mov.b32 %f1099, %r535
  asm("mov.b32 %0, %1;" : "=f"(f1099) : "r"(r535));
  // PTX:636 mov.b32 %f1098, %r536
  asm("mov.b32 %0, %1;" : "=f"(f1098) : "r"(r536));
  // PTX:637 mul.f32 %f340, %f1098, %f1098
  asm("mul.f32 %0, %1, %2;" : "=f"(f340) : "f"(f1098), "f"(f1098));
  // PTX:638 mov.b32 %f1097, %r537
  asm("mov.b32 %0, %1;" : "=f"(f1097) : "r"(r537));
  // PTX:639 fma.rn.f32 %f341, %f1099, %f1099, %f340
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f341) : "f"(f1099), "f"(f1099), "f"(f340));
  // PTX:640 fma.rn.f32 %f1096, %f1097, %f1097, %f341
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1096) : "f"(f1097), "f"(f1097), "f"(f341));
  // PTX:641 mov.u32 %r630, %r537
  asm("mov.u32 %0, %1;" : "=r"(r630) : "r"(r537));
  // PTX:642 mov.u32 %r631, %r536
  asm("mov.u32 %0, %1;" : "=r"(r631) : "r"(r536));
  // PTX:643 mov.u32 %r632, %r535
  asm("mov.u32 %0, %1;" : "=r"(r632) : "r"(r535));
  // PTX:645 $L__BB79_59:
L_BB79_59:;
  // PTX:646 mov.pred %p146, -1
  p146 = ((-1) != 0);
  // PTX:647 mov.f32 %f1148, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1148) : );
  // PTX:648 setp.ltu.f32 %p70, %f1096, 0f3F000000
  p70 = ((isnan(((float)(f1096))) || isnan(((float)(as_f32(0x3F000000u))))) || (((float)(f1096)) < ((float)(as_f32(0x3F000000u)))));
  // PTX:649 @%p70 bra $L__BB79_122
  if (p70) { goto L_BB79_122; }
  // PTX:651 @%p64 bra $L__BB79_84
  if (p64) { goto L_BB79_84; }
  // PTX:653 ld.param.u64 %rd338, [%rd2+112]
  rd338 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (112))));
  // PTX:654 cvta.to.global.u64 %rd337, %rd338
  rd337 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd338));
  // PTX:655 cvt.s64.s32 %rd336, %rd436
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd336) : "l"(rd436));
  // PTX:656 setp.lt.s32 %p131, %r642, 0
  p131 = (((int)(r642)) < ((int)(0)));
  // PTX:657 mul.lo.s64 %rd167, %rd336, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd167) : "l"(rd336));
  // PTX:658 add.s64 %rd70, %rd337, %rd167
  asm("add.s64 %0, %1, %2;" : "=l"(rd70) : "l"(rd337), "l"(rd167));
  // PTX:659 @%p131 bra $L__BB79_83
  if (p131) { goto L_BB79_83; }
  // PTX:661 ld.param.u64 %rd347, [%rd2+208]
  rd347 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (208))));
  // PTX:662 cvta.to.global.u64 %rd346, %rd347
  rd346 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd347));
  // PTX:663 mul.wide.s32 %rd345, %r637, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd345) : "r"(r637));
  // PTX:664 add.s64 %rd344, %rd346, %rd345
  asm("add.s64 %0, %1, %2;" : "=l"(rd344) : "l"(rd346), "l"(rd345));
  // PTX:665 mul.wide.s32 %rd343, %r638, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd343) : "r"(r638));
  // PTX:666 add.s64 %rd342, %rd346, %rd343
  asm("add.s64 %0, %1, %2;" : "=l"(rd342) : "l"(rd346), "l"(rd343));
  // PTX:667 mul.wide.s32 %rd341, %r639, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd341) : "r"(r639));
  // PTX:668 add.s64 %rd340, %rd346, %rd341
  asm("add.s64 %0, %1, %2;" : "=l"(rd340) : "l"(rd346), "l"(rd341));
  // PTX:669 ld.global.f32 %f343, [%rd70]
  f343 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))));
  // PTX:670 ld.global.f32 %f24, [%rd344+8]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd344) + (8)))));
  // PTX:671 ld.global.f32 %f25, [%rd342+4]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd342) + (4)))));
  // PTX:672 mul.f32 %f344, %f25, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f344) : "f"(f25), "f"(f24));
  // PTX:673 ld.global.f32 %f26, [%rd344+4]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd344) + (4)))));
  // PTX:674 ld.global.f32 %f27, [%rd342+8]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd342) + (8)))));
  // PTX:675 mul.f32 %f345, %f27, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f345) : "f"(f27), "f"(f26));
  // PTX:676 sub.f32 %f28, %f344, %f345
  asm("sub.f32 %0, %1, %2;" : "=f"(f28) : "f"(f344), "f"(f345));
  // PTX:677 ld.global.f32 %f29, [%rd344]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd344) + (0)))));
  // PTX:678 mul.f32 %f346, %f27, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f346) : "f"(f27), "f"(f29));
  // PTX:679 ld.global.f32 %f30, [%rd342]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd342) + (0)))));
  // PTX:680 mul.f32 %f347, %f30, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f347) : "f"(f30), "f"(f24));
  // PTX:681 sub.f32 %f31, %f346, %f347
  asm("sub.f32 %0, %1, %2;" : "=f"(f31) : "f"(f346), "f"(f347));
  // PTX:682 mul.f32 %f348, %f30, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f348) : "f"(f30), "f"(f26));
  // PTX:683 mul.f32 %f349, %f25, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f349) : "f"(f25), "f"(f29));
  // PTX:684 sub.f32 %f32, %f348, %f349
  asm("sub.f32 %0, %1, %2;" : "=f"(f32) : "f"(f348), "f"(f349));
  // PTX:685 ld.global.f32 %f33, [%rd340]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd340) + (0)))));
  // PTX:686 ld.global.f32 %f34, [%rd340+4]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd340) + (4)))));
  // PTX:687 mul.f32 %f350, %f34, %f31
  asm("mul.f32 %0, %1, %2;" : "=f"(f350) : "f"(f34), "f"(f31));
  // PTX:688 ld.global.f32 %f35, [%rd340+8]
  f35 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd340) + (8)))));
  // PTX:689 fma.rn.f32 %f351, %f33, %f28, %f350
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f351) : "f"(f33), "f"(f28), "f"(f350));
  // PTX:690 fma.rn.f32 %f36, %f35, %f32, %f351
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f35), "f"(f32), "f"(f351));
  // PTX:691 abs.f32 %f352, %f36
  asm("abs.f32 %0, %1;" : "=f"(f352) : "f"(f36));
  // PTX:692 setp.leu.f32 %p73, %f352, 0f2EDBE6FF
  p73 = ((isnan(((float)(f352))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) || (((float)(f352)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:693 setp.geu.f32 %p74, %f352, 0f7F800000
  p74 = ((isnan(((float)(f352))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f352)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:694 or.pred %p75, %p73, %p74
  p75 = ((p73) || (p74));
  // PTX:695 @%p75 bra $L__BB79_64
  if (p75) { goto L_BB79_64; }
  // PTX:696 bra.uni $L__BB79_63
  goto L_BB79_63;
  // PTX:698 $L__BB79_64:
L_BB79_64:;
  // PTX:699 mul.f32 %f390, %f34, %f34
  asm("mul.f32 %0, %1, %2;" : "=f"(f390) : "f"(f34), "f"(f34));
  // PTX:700 fma.rn.f32 %f391, %f33, %f33, %f390
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f391) : "f"(f33), "f"(f33), "f"(f390));
  // PTX:701 fma.rn.f32 %f392, %f35, %f35, %f391
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f392) : "f"(f35), "f"(f35), "f"(f391));
  // PTX:702 mul.f32 %f393, %f25, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f393) : "f"(f25), "f"(f25));
  // PTX:703 fma.rn.f32 %f394, %f30, %f30, %f393
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f394) : "f"(f30), "f"(f30), "f"(f393));
  // PTX:704 fma.rn.f32 %f395, %f27, %f27, %f394
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f395) : "f"(f27), "f"(f27), "f"(f394));
  // PTX:705 add.f32 %f396, %f392, %f395
  asm("add.f32 %0, %1, %2;" : "=f"(f396) : "f"(f392), "f"(f395));
  // PTX:706 mul.f32 %f397, %f26, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f397) : "f"(f26), "f"(f26));
  // PTX:707 fma.rn.f32 %f398, %f29, %f29, %f397
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f398) : "f"(f29), "f"(f29), "f"(f397));
  // PTX:708 fma.rn.f32 %f399, %f24, %f24, %f398
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f399) : "f"(f24), "f"(f24), "f"(f398));
  // PTX:709 add.f32 %f400, %f396, %f399
  asm("add.f32 %0, %1, %2;" : "=f"(f400) : "f"(f396), "f"(f399));
  // PTX:710 div.rn.f32 %f401, %f400, 0f40400000
  asm("div.rn.f32 %0, %1, 0f40400000;" : "=f"(f401) : "f"(f400));
  // PTX:711 sqrt.rn.f32 %f37, %f401
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f37) : "f"(f401));
  // PTX:712 setp.leu.f32 %p76, %f37, 0f322BCC77
  p76 = ((isnan(((float)(f37))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f37)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:713 mov.u32 %r569, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r569) : );
  // PTX:714 mov.u32 %r570, 0
  asm("mov.u32 %0, 0;" : "=r"(r570) : );
  // PTX:715 mov.u32 %r571, %r570
  asm("mov.u32 %0, %1;" : "=r"(r571) : "r"(r570));
  // PTX:716 mov.u32 %r572, %r570
  asm("mov.u32 %0, %1;" : "=r"(r572) : "r"(r570));
  // PTX:717 mov.u32 %r573, %r569
  asm("mov.u32 %0, %1;" : "=r"(r573) : "r"(r569));
  // PTX:718 mov.u32 %r574, %r570
  asm("mov.u32 %0, %1;" : "=r"(r574) : "r"(r570));
  // PTX:719 mov.u32 %r575, %r570
  asm("mov.u32 %0, %1;" : "=r"(r575) : "r"(r570));
  // PTX:720 mov.u32 %r576, %r570
  asm("mov.u32 %0, %1;" : "=r"(r576) : "r"(r570));
  // PTX:721 mov.u32 %r577, %r569
  asm("mov.u32 %0, %1;" : "=r"(r577) : "r"(r569));
  // PTX:722 @%p76 bra $L__BB79_81
  if (p76) { goto L_BB79_81; }
  // PTX:724 abs.f32 %f402, %f37
  asm("abs.f32 %0, %1;" : "=f"(f402) : "f"(f37));
  // PTX:725 setp.geu.f32 %p77, %f402, 0f7F800000
  p77 = ((isnan(((float)(f402))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f402)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:726 @%p77 bra $L__BB79_81
  if (p77) { goto L_BB79_81; }
  // PTX:728 rcp.rn.f32 %f403, %f37
  asm("rcp.rn.f32 %0, %1;" : "=f"(f403) : "f"(f37));
  // PTX:729 mul.f32 %f1109, %f33, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f1109) : "f"(f33), "f"(f403));
  // PTX:730 mul.f32 %f1110, %f34, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f1110) : "f"(f34), "f"(f403));
  // PTX:731 mul.f32 %f1111, %f35, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f1111) : "f"(f35), "f"(f403));
  // PTX:732 mul.f32 %f1112, %f30, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f1112) : "f"(f30), "f"(f403));
  // PTX:733 mul.f32 %f1113, %f25, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f1113) : "f"(f25), "f"(f403));
  // PTX:734 mul.f32 %f1114, %f27, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f1114) : "f"(f27), "f"(f403));
  // PTX:735 mul.f32 %f1115, %f29, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f1115) : "f"(f29), "f"(f403));
  // PTX:736 mul.f32 %f1116, %f26, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f1116) : "f"(f26), "f"(f403));
  // PTX:737 mul.f32 %f1117, %f24, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f1117) : "f"(f24), "f"(f403));
  // PTX:738 mov.u32 %r553, 0
  asm("mov.u32 %0, 0;" : "=r"(r553) : );
  // PTX:740 $L__BB79_67:
L_BB79_67:;
  // PTX:741 mul.f32 %f404, %f1114, %f1116
  asm("mul.f32 %0, %1, %2;" : "=f"(f404) : "f"(f1114), "f"(f1116));
  // PTX:742 mul.f32 %f405, %f1113, %f1117
  asm("mul.f32 %0, %1, %2;" : "=f"(f405) : "f"(f1113), "f"(f1117));
  // PTX:743 sub.f32 %f56, %f405, %f404
  asm("sub.f32 %0, %1, %2;" : "=f"(f56) : "f"(f405), "f"(f404));
  // PTX:744 mul.f32 %f406, %f1112, %f1117
  asm("mul.f32 %0, %1, %2;" : "=f"(f406) : "f"(f1112), "f"(f1117));
  // PTX:745 mul.f32 %f407, %f1114, %f1115
  asm("mul.f32 %0, %1, %2;" : "=f"(f407) : "f"(f1114), "f"(f1115));
  // PTX:746 sub.f32 %f57, %f407, %f406
  asm("sub.f32 %0, %1, %2;" : "=f"(f57) : "f"(f407), "f"(f406));
  // PTX:747 mul.f32 %f408, %f1113, %f1115
  asm("mul.f32 %0, %1, %2;" : "=f"(f408) : "f"(f1113), "f"(f1115));
  // PTX:748 mul.f32 %f409, %f1112, %f1116
  asm("mul.f32 %0, %1, %2;" : "=f"(f409) : "f"(f1112), "f"(f1116));
  // PTX:749 sub.f32 %f58, %f409, %f408
  asm("sub.f32 %0, %1, %2;" : "=f"(f58) : "f"(f409), "f"(f408));
  // PTX:750 mul.f32 %f410, %f1110, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f410) : "f"(f1110), "f"(f57));
  // PTX:751 fma.rn.f32 %f411, %f1109, %f56, %f410
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f411) : "f"(f1109), "f"(f56), "f"(f410));
  // PTX:752 fma.rn.f32 %f59, %f1111, %f58, %f411
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f59) : "f"(f1111), "f"(f58), "f"(f411));
  // PTX:753 abs.f32 %f412, %f59
  asm("abs.f32 %0, %1;" : "=f"(f412) : "f"(f59));
  // PTX:754 setp.le.f32 %p78, %f412, 0f2EDBE6FF
  p78 = (!(isnan(((float)(f412))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f412)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:755 setp.geu.f32 %p79, %f412, 0f7F800000
  p79 = ((isnan(((float)(f412))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f412)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:756 or.pred %p80, %p78, %p79
  p80 = ((p78) || (p79));
  // PTX:757 @%p80 bra $L__BB79_70
  if (p80) { goto L_BB79_70; }
  // PTX:759 rcp.rn.f32 %f413, %f59
  asm("rcp.rn.f32 %0, %1;" : "=f"(f413) : "f"(f59));
  // PTX:760 mul.f32 %f414, %f1110, %f1117
  asm("mul.f32 %0, %1, %2;" : "=f"(f414) : "f"(f1110), "f"(f1117));
  // PTX:761 mul.f32 %f415, %f1111, %f1116
  asm("mul.f32 %0, %1, %2;" : "=f"(f415) : "f"(f1111), "f"(f1116));
  // PTX:762 sub.f32 %f416, %f415, %f414
  asm("sub.f32 %0, %1, %2;" : "=f"(f416) : "f"(f415), "f"(f414));
  // PTX:763 mul.f32 %f417, %f1111, %f1115
  asm("mul.f32 %0, %1, %2;" : "=f"(f417) : "f"(f1111), "f"(f1115));
  // PTX:764 mul.f32 %f418, %f1109, %f1117
  asm("mul.f32 %0, %1, %2;" : "=f"(f418) : "f"(f1109), "f"(f1117));
  // PTX:765 sub.f32 %f419, %f418, %f417
  asm("sub.f32 %0, %1, %2;" : "=f"(f419) : "f"(f418), "f"(f417));
  // PTX:766 mul.f32 %f420, %f1109, %f1116
  asm("mul.f32 %0, %1, %2;" : "=f"(f420) : "f"(f1109), "f"(f1116));
  // PTX:767 mul.f32 %f421, %f1110, %f1115
  asm("mul.f32 %0, %1, %2;" : "=f"(f421) : "f"(f1110), "f"(f1115));
  // PTX:768 sub.f32 %f422, %f421, %f420
  asm("sub.f32 %0, %1, %2;" : "=f"(f422) : "f"(f421), "f"(f420));
  // PTX:769 mul.f32 %f423, %f1111, %f1113
  asm("mul.f32 %0, %1, %2;" : "=f"(f423) : "f"(f1111), "f"(f1113));
  // PTX:770 mul.f32 %f424, %f1110, %f1114
  asm("mul.f32 %0, %1, %2;" : "=f"(f424) : "f"(f1110), "f"(f1114));
  // PTX:771 sub.f32 %f425, %f424, %f423
  asm("sub.f32 %0, %1, %2;" : "=f"(f425) : "f"(f424), "f"(f423));
  // PTX:772 mul.f32 %f426, %f1109, %f1114
  asm("mul.f32 %0, %1, %2;" : "=f"(f426) : "f"(f1109), "f"(f1114));
  // PTX:773 mul.f32 %f427, %f1111, %f1112
  asm("mul.f32 %0, %1, %2;" : "=f"(f427) : "f"(f1111), "f"(f1112));
  // PTX:774 sub.f32 %f428, %f427, %f426
  asm("sub.f32 %0, %1, %2;" : "=f"(f428) : "f"(f427), "f"(f426));
  // PTX:775 mul.f32 %f429, %f1110, %f1112
  asm("mul.f32 %0, %1, %2;" : "=f"(f429) : "f"(f1110), "f"(f1112));
  // PTX:776 mul.f32 %f430, %f1109, %f1113
  asm("mul.f32 %0, %1, %2;" : "=f"(f430) : "f"(f1109), "f"(f1113));
  // PTX:777 sub.f32 %f431, %f430, %f429
  asm("sub.f32 %0, %1, %2;" : "=f"(f431) : "f"(f430), "f"(f429));
  // PTX:778 fma.rn.f32 %f432, %f56, %f413, %f1109
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f432) : "f"(f56), "f"(f413), "f"(f1109));
  // PTX:779 fma.rn.f32 %f433, %f57, %f413, %f1110
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f433) : "f"(f57), "f"(f413), "f"(f1110));
  // PTX:780 fma.rn.f32 %f434, %f58, %f413, %f1111
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f434) : "f"(f58), "f"(f413), "f"(f1111));
  // PTX:781 fma.rn.f32 %f435, %f416, %f413, %f1112
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f435) : "f"(f416), "f"(f413), "f"(f1112));
  // PTX:782 fma.rn.f32 %f436, %f419, %f413, %f1113
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f436) : "f"(f419), "f"(f413), "f"(f1113));
  // PTX:783 fma.rn.f32 %f437, %f422, %f413, %f1114
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f437) : "f"(f422), "f"(f413), "f"(f1114));
  // PTX:784 fma.rn.f32 %f438, %f425, %f413, %f1115
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f438) : "f"(f425), "f"(f413), "f"(f1115));
  // PTX:785 fma.rn.f32 %f439, %f428, %f413, %f1116
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f439) : "f"(f428), "f"(f413), "f"(f1116));
  // PTX:786 fma.rn.f32 %f440, %f431, %f413, %f1117
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f440) : "f"(f431), "f"(f413), "f"(f1117));
  // PTX:787 mul.f32 %f1109, %f432, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1109) : "f"(f432));
  // PTX:788 mul.f32 %f1110, %f433, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1110) : "f"(f433));
  // PTX:789 mul.f32 %f1111, %f434, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1111) : "f"(f434));
  // PTX:790 mul.f32 %f1112, %f435, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1112) : "f"(f435));
  // PTX:791 mul.f32 %f1113, %f436, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1113) : "f"(f436));
  // PTX:792 mul.f32 %f1114, %f437, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1114) : "f"(f437));
  // PTX:793 mul.f32 %f1115, %f438, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1115) : "f"(f438));
  // PTX:794 mul.f32 %f1116, %f439, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1116) : "f"(f439));
  // PTX:795 mul.f32 %f1117, %f440, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1117) : "f"(f440));
  // PTX:796 mul.f32 %f441, %f1113, %f1117
  asm("mul.f32 %0, %1, %2;" : "=f"(f441) : "f"(f1113), "f"(f1117));
  // PTX:797 mul.f32 %f442, %f1114, %f1116
  asm("mul.f32 %0, %1, %2;" : "=f"(f442) : "f"(f1114), "f"(f1116));
  // PTX:798 sub.f32 %f69, %f441, %f442
  asm("sub.f32 %0, %1, %2;" : "=f"(f69) : "f"(f441), "f"(f442));
  // PTX:799 mul.f32 %f443, %f1114, %f1115
  asm("mul.f32 %0, %1, %2;" : "=f"(f443) : "f"(f1114), "f"(f1115));
  // PTX:800 mul.f32 %f444, %f1112, %f1117
  asm("mul.f32 %0, %1, %2;" : "=f"(f444) : "f"(f1112), "f"(f1117));
  // PTX:801 sub.f32 %f70, %f443, %f444
  asm("sub.f32 %0, %1, %2;" : "=f"(f70) : "f"(f443), "f"(f444));
  // PTX:802 mul.f32 %f445, %f1112, %f1116
  asm("mul.f32 %0, %1, %2;" : "=f"(f445) : "f"(f1112), "f"(f1116));
  // PTX:803 mul.f32 %f446, %f1113, %f1115
  asm("mul.f32 %0, %1, %2;" : "=f"(f446) : "f"(f1113), "f"(f1115));
  // PTX:804 sub.f32 %f71, %f445, %f446
  asm("sub.f32 %0, %1, %2;" : "=f"(f71) : "f"(f445), "f"(f446));
  // PTX:805 mul.f32 %f447, %f1110, %f70
  asm("mul.f32 %0, %1, %2;" : "=f"(f447) : "f"(f1110), "f"(f70));
  // PTX:806 fma.rn.f32 %f448, %f1109, %f69, %f447
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f448) : "f"(f1109), "f"(f69), "f"(f447));
  // PTX:807 fma.rn.f32 %f72, %f1111, %f71, %f448
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f72) : "f"(f1111), "f"(f71), "f"(f448));
  // PTX:808 abs.f32 %f449, %f72
  asm("abs.f32 %0, %1;" : "=f"(f449) : "f"(f72));
  // PTX:809 setp.le.f32 %p81, %f449, 0f2EDBE6FF
  p81 = (!(isnan(((float)(f449))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f449)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:810 setp.geu.f32 %p82, %f449, 0f7F800000
  p82 = ((isnan(((float)(f449))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f449)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:811 or.pred %p83, %p81, %p82
  p83 = ((p81) || (p82));
  // PTX:812 @%p83 bra $L__BB79_70
  if (p83) { goto L_BB79_70; }
  // PTX:814 rcp.rn.f32 %f450, %f72
  asm("rcp.rn.f32 %0, %1;" : "=f"(f450) : "f"(f72));
  // PTX:815 mul.f32 %f451, %f1110, %f1117
  asm("mul.f32 %0, %1, %2;" : "=f"(f451) : "f"(f1110), "f"(f1117));
  // PTX:816 mul.f32 %f452, %f1111, %f1116
  asm("mul.f32 %0, %1, %2;" : "=f"(f452) : "f"(f1111), "f"(f1116));
  // PTX:817 sub.f32 %f453, %f452, %f451
  asm("sub.f32 %0, %1, %2;" : "=f"(f453) : "f"(f452), "f"(f451));
  // PTX:818 mul.f32 %f454, %f1111, %f1115
  asm("mul.f32 %0, %1, %2;" : "=f"(f454) : "f"(f1111), "f"(f1115));
  // PTX:819 mul.f32 %f455, %f1109, %f1117
  asm("mul.f32 %0, %1, %2;" : "=f"(f455) : "f"(f1109), "f"(f1117));
  // PTX:820 sub.f32 %f456, %f455, %f454
  asm("sub.f32 %0, %1, %2;" : "=f"(f456) : "f"(f455), "f"(f454));
  // PTX:821 mul.f32 %f457, %f1109, %f1116
  asm("mul.f32 %0, %1, %2;" : "=f"(f457) : "f"(f1109), "f"(f1116));
  // PTX:822 mul.f32 %f458, %f1110, %f1115
  asm("mul.f32 %0, %1, %2;" : "=f"(f458) : "f"(f1110), "f"(f1115));
  // PTX:823 sub.f32 %f459, %f458, %f457
  asm("sub.f32 %0, %1, %2;" : "=f"(f459) : "f"(f458), "f"(f457));
  // PTX:824 mul.f32 %f460, %f1111, %f1113
  asm("mul.f32 %0, %1, %2;" : "=f"(f460) : "f"(f1111), "f"(f1113));
  // PTX:825 mul.f32 %f461, %f1110, %f1114
  asm("mul.f32 %0, %1, %2;" : "=f"(f461) : "f"(f1110), "f"(f1114));
  // PTX:826 sub.f32 %f462, %f461, %f460
  asm("sub.f32 %0, %1, %2;" : "=f"(f462) : "f"(f461), "f"(f460));
  // PTX:827 mul.f32 %f463, %f1109, %f1114
  asm("mul.f32 %0, %1, %2;" : "=f"(f463) : "f"(f1109), "f"(f1114));
  // PTX:828 mul.f32 %f464, %f1111, %f1112
  asm("mul.f32 %0, %1, %2;" : "=f"(f464) : "f"(f1111), "f"(f1112));
  // PTX:829 sub.f32 %f465, %f464, %f463
  asm("sub.f32 %0, %1, %2;" : "=f"(f465) : "f"(f464), "f"(f463));
  // PTX:830 mul.f32 %f466, %f1110, %f1112
  asm("mul.f32 %0, %1, %2;" : "=f"(f466) : "f"(f1110), "f"(f1112));
  // PTX:831 mul.f32 %f467, %f1109, %f1113
  asm("mul.f32 %0, %1, %2;" : "=f"(f467) : "f"(f1109), "f"(f1113));
  // PTX:832 sub.f32 %f468, %f467, %f466
  asm("sub.f32 %0, %1, %2;" : "=f"(f468) : "f"(f467), "f"(f466));
  // PTX:833 fma.rn.f32 %f469, %f69, %f450, %f1109
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f469) : "f"(f69), "f"(f450), "f"(f1109));
  // PTX:834 fma.rn.f32 %f470, %f70, %f450, %f1110
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f470) : "f"(f70), "f"(f450), "f"(f1110));
  // PTX:835 fma.rn.f32 %f471, %f71, %f450, %f1111
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f471) : "f"(f71), "f"(f450), "f"(f1111));
  // PTX:836 fma.rn.f32 %f472, %f453, %f450, %f1112
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f472) : "f"(f453), "f"(f450), "f"(f1112));
  // PTX:837 fma.rn.f32 %f473, %f456, %f450, %f1113
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f473) : "f"(f456), "f"(f450), "f"(f1113));
  // PTX:838 fma.rn.f32 %f474, %f459, %f450, %f1114
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f474) : "f"(f459), "f"(f450), "f"(f1114));
  // PTX:839 fma.rn.f32 %f475, %f462, %f450, %f1115
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f475) : "f"(f462), "f"(f450), "f"(f1115));
  // PTX:840 fma.rn.f32 %f476, %f465, %f450, %f1116
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f476) : "f"(f465), "f"(f450), "f"(f1116));
  // PTX:841 fma.rn.f32 %f477, %f468, %f450, %f1117
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f477) : "f"(f468), "f"(f450), "f"(f1117));
  // PTX:842 mul.f32 %f1109, %f469, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1109) : "f"(f469));
  // PTX:843 mul.f32 %f1110, %f470, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1110) : "f"(f470));
  // PTX:844 mul.f32 %f1111, %f471, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1111) : "f"(f471));
  // PTX:845 mul.f32 %f1112, %f472, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1112) : "f"(f472));
  // PTX:846 mul.f32 %f1113, %f473, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1113) : "f"(f473));
  // PTX:847 mul.f32 %f1114, %f474, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1114) : "f"(f474));
  // PTX:848 mul.f32 %f1115, %f475, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1115) : "f"(f475));
  // PTX:849 mul.f32 %f1116, %f476, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1116) : "f"(f476));
  // PTX:850 mul.f32 %f1117, %f477, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1117) : "f"(f477));
  // PTX:851 add.s32 %r553, %r553, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r553) : "r"(r553));
  // PTX:852 setp.lt.u32 %p84, %r553, 8
  p84 = (((unsigned)(r553)) < ((unsigned)(8)));
  // PTX:853 @%p84 bra $L__BB79_67
  if (p84) { goto L_BB79_67; }
  // PTX:855 $L__BB79_70:
L_BB79_70:;
  // PTX:856 mul.f32 %f478, %f1110, %f1110
  asm("mul.f32 %0, %1, %2;" : "=f"(f478) : "f"(f1110), "f"(f1110));
  // PTX:857 fma.rn.f32 %f479, %f1109, %f1109, %f478
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f479) : "f"(f1109), "f"(f1109), "f"(f478));
  // PTX:858 fma.rn.f32 %f480, %f1111, %f1111, %f479
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f480) : "f"(f1111), "f"(f1111), "f"(f479));
  // PTX:859 sqrt.rn.f32 %f91, %f480
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f91) : "f"(f480));
  // PTX:860 setp.leu.f32 %p85, %f91, 0f00000000
  p85 = ((isnan(((float)(f91))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f91)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:861 mov.u32 %r566, 0
  asm("mov.u32 %0, 0;" : "=r"(r566) : );
  // PTX:862 mov.u32 %r554, %r566
  asm("mov.u32 %0, %1;" : "=r"(r554) : "r"(r566));
  // PTX:863 mov.u32 %r555, %r566
  asm("mov.u32 %0, %1;" : "=r"(r555) : "r"(r566));
  // PTX:864 mov.u32 %r556, %r566
  asm("mov.u32 %0, %1;" : "=r"(r556) : "r"(r566));
  // PTX:865 @%p85 bra $L__BB79_72
  if (p85) { goto L_BB79_72; }
  // PTX:867 div.rn.f32 %f481, %f1109, %f91
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f481) : "f"(f1109), "f"(f91));
  // PTX:868 div.rn.f32 %f482, %f1110, %f91
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f482) : "f"(f1110), "f"(f91));
  // PTX:869 div.rn.f32 %f483, %f1111, %f91
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f483) : "f"(f1111), "f"(f91));
  // PTX:870 mov.b32 %r556, %f483
  asm("mov.b32 %0, %1;" : "=r"(r556) : "f"(f483));
  // PTX:871 mov.b32 %r555, %f482
  asm("mov.b32 %0, %1;" : "=r"(r555) : "f"(f482));
  // PTX:872 mov.b32 %r554, %f481
  asm("mov.b32 %0, %1;" : "=r"(r554) : "f"(f481));
  // PTX:874 $L__BB79_72:
L_BB79_72:;
  // PTX:875 mov.b32 %f92, %r554
  asm("mov.b32 %0, %1;" : "=f"(f92) : "r"(r554));
  // PTX:876 mov.b32 %f93, %r555
  asm("mov.b32 %0, %1;" : "=f"(f93) : "r"(r555));
  // PTX:877 mul.f32 %f484, %f1113, %f93
  asm("mul.f32 %0, %1, %2;" : "=f"(f484) : "f"(f1113), "f"(f93));
  // PTX:878 mov.b32 %f94, %r556
  asm("mov.b32 %0, %1;" : "=f"(f94) : "r"(r556));
  // PTX:879 fma.rn.f32 %f485, %f1112, %f92, %f484
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f485) : "f"(f1112), "f"(f92), "f"(f484));
  // PTX:880 fma.rn.f32 %f486, %f1114, %f94, %f485
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f486) : "f"(f1114), "f"(f94), "f"(f485));
  // PTX:881 mul.f32 %f487, %f486, %f92
  asm("mul.f32 %0, %1, %2;" : "=f"(f487) : "f"(f486), "f"(f92));
  // PTX:882 mul.f32 %f488, %f486, %f93
  asm("mul.f32 %0, %1, %2;" : "=f"(f488) : "f"(f486), "f"(f93));
  // PTX:883 mul.f32 %f489, %f486, %f94
  asm("mul.f32 %0, %1, %2;" : "=f"(f489) : "f"(f486), "f"(f94));
  // PTX:884 sub.f32 %f95, %f1112, %f487
  asm("sub.f32 %0, %1, %2;" : "=f"(f95) : "f"(f1112), "f"(f487));
  // PTX:885 sub.f32 %f96, %f1113, %f488
  asm("sub.f32 %0, %1, %2;" : "=f"(f96) : "f"(f1113), "f"(f488));
  // PTX:886 sub.f32 %f97, %f1114, %f489
  asm("sub.f32 %0, %1, %2;" : "=f"(f97) : "f"(f1114), "f"(f489));
  // PTX:887 mul.f32 %f490, %f96, %f96
  asm("mul.f32 %0, %1, %2;" : "=f"(f490) : "f"(f96), "f"(f96));
  // PTX:888 fma.rn.f32 %f491, %f95, %f95, %f490
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f491) : "f"(f95), "f"(f95), "f"(f490));
  // PTX:889 fma.rn.f32 %f492, %f97, %f97, %f491
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f492) : "f"(f97), "f"(f97), "f"(f491));
  // PTX:890 sqrt.rn.f32 %f98, %f492
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f98) : "f"(f492));
  // PTX:891 setp.leu.f32 %p86, %f98, 0f00000000
  p86 = ((isnan(((float)(f98))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f98)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:892 mov.u32 %r567, %r566
  asm("mov.u32 %0, %1;" : "=r"(r567) : "r"(r566));
  // PTX:893 mov.u32 %r568, %r566
  asm("mov.u32 %0, %1;" : "=r"(r568) : "r"(r566));
  // PTX:894 @%p86 bra $L__BB79_74
  if (p86) { goto L_BB79_74; }
  // PTX:896 div.rn.f32 %f493, %f95, %f98
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f493) : "f"(f95), "f"(f98));
  // PTX:897 div.rn.f32 %f494, %f96, %f98
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f494) : "f"(f96), "f"(f98));
  // PTX:898 div.rn.f32 %f495, %f97, %f98
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f495) : "f"(f97), "f"(f98));
  // PTX:899 mov.b32 %r568, %f495
  asm("mov.b32 %0, %1;" : "=r"(r568) : "f"(f495));
  // PTX:900 mov.b32 %r567, %f494
  asm("mov.b32 %0, %1;" : "=r"(r567) : "f"(f494));
  // PTX:901 mov.b32 %r566, %f493
  asm("mov.b32 %0, %1;" : "=r"(r566) : "f"(f493));
  // PTX:903 $L__BB79_74:
L_BB79_74:;
  // PTX:904 mov.u32 %r569, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r569) : );
  // PTX:905 mul.f32 %f496, %f93, %f93
  asm("mul.f32 %0, %1, %2;" : "=f"(f496) : "f"(f93), "f"(f93));
  // PTX:906 fma.rn.f32 %f497, %f92, %f92, %f496
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f497) : "f"(f92), "f"(f92), "f"(f496));
  // PTX:907 fma.rn.f32 %f498, %f94, %f94, %f497
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f498) : "f"(f94), "f"(f94), "f"(f497));
  // PTX:908 sqrt.rn.f32 %f499, %f498
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f499) : "f"(f498));
  // PTX:909 setp.le.f32 %p87, %f499, 0f322BCC77
  p87 = (!(isnan(((float)(f499))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f499)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:910 mov.u32 %r570, 0
  asm("mov.u32 %0, 0;" : "=r"(r570) : );
  // PTX:911 mov.u32 %r571, %r570
  asm("mov.u32 %0, %1;" : "=r"(r571) : "r"(r570));
  // PTX:912 mov.u32 %r572, %r570
  asm("mov.u32 %0, %1;" : "=r"(r572) : "r"(r570));
  // PTX:913 mov.u32 %r573, %r569
  asm("mov.u32 %0, %1;" : "=r"(r573) : "r"(r569));
  // PTX:914 mov.u32 %r574, %r570
  asm("mov.u32 %0, %1;" : "=r"(r574) : "r"(r570));
  // PTX:915 mov.u32 %r575, %r570
  asm("mov.u32 %0, %1;" : "=r"(r575) : "r"(r570));
  // PTX:916 mov.u32 %r576, %r570
  asm("mov.u32 %0, %1;" : "=r"(r576) : "r"(r570));
  // PTX:917 mov.u32 %r577, %r569
  asm("mov.u32 %0, %1;" : "=r"(r577) : "r"(r569));
  // PTX:918 @%p87 bra $L__BB79_81
  if (p87) { goto L_BB79_81; }
  // PTX:920 mov.u32 %r569, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r569) : );
  // PTX:921 mov.b32 %f99, %r566
  asm("mov.b32 %0, %1;" : "=f"(f99) : "r"(r566));
  // PTX:922 mov.b32 %f100, %r567
  asm("mov.b32 %0, %1;" : "=f"(f100) : "r"(r567));
  // PTX:923 mul.f32 %f500, %f100, %f100
  asm("mul.f32 %0, %1, %2;" : "=f"(f500) : "f"(f100), "f"(f100));
  // PTX:924 mov.b32 %f101, %r568
  asm("mov.b32 %0, %1;" : "=f"(f101) : "r"(r568));
  // PTX:925 fma.rn.f32 %f501, %f99, %f99, %f500
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f501) : "f"(f99), "f"(f99), "f"(f500));
  // PTX:926 fma.rn.f32 %f502, %f101, %f101, %f501
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f502) : "f"(f101), "f"(f101), "f"(f501));
  // PTX:927 sqrt.rn.f32 %f503, %f502
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f503) : "f"(f502));
  // PTX:928 setp.le.f32 %p88, %f503, 0f322BCC77
  p88 = (!(isnan(((float)(f503))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f503)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:929 @%p88 bra $L__BB79_81
  if (p88) { goto L_BB79_81; }
  // PTX:931 mul.f32 %f504, %f93, %f101
  asm("mul.f32 %0, %1, %2;" : "=f"(f504) : "f"(f93), "f"(f101));
  // PTX:932 mul.f32 %f505, %f94, %f100
  asm("mul.f32 %0, %1, %2;" : "=f"(f505) : "f"(f94), "f"(f100));
  // PTX:933 sub.f32 %f102, %f504, %f505
  asm("sub.f32 %0, %1, %2;" : "=f"(f102) : "f"(f504), "f"(f505));
  // PTX:934 mul.f32 %f506, %f92, %f101
  asm("mul.f32 %0, %1, %2;" : "=f"(f506) : "f"(f92), "f"(f101));
  // PTX:935 mul.f32 %f507, %f94, %f99
  asm("mul.f32 %0, %1, %2;" : "=f"(f507) : "f"(f94), "f"(f99));
  // PTX:936 sub.f32 %f103, %f507, %f506
  asm("sub.f32 %0, %1, %2;" : "=f"(f103) : "f"(f507), "f"(f506));
  // PTX:937 mul.f32 %f508, %f93, %f99
  asm("mul.f32 %0, %1, %2;" : "=f"(f508) : "f"(f93), "f"(f99));
  // PTX:938 mul.f32 %f509, %f92, %f100
  asm("mul.f32 %0, %1, %2;" : "=f"(f509) : "f"(f92), "f"(f100));
  // PTX:939 sub.f32 %f104, %f509, %f508
  asm("sub.f32 %0, %1, %2;" : "=f"(f104) : "f"(f509), "f"(f508));
  // PTX:940 mul.f32 %f510, %f103, %f103
  asm("mul.f32 %0, %1, %2;" : "=f"(f510) : "f"(f103), "f"(f103));
  // PTX:941 fma.rn.f32 %f511, %f102, %f102, %f510
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f511) : "f"(f102), "f"(f102), "f"(f510));
  // PTX:942 fma.rn.f32 %f512, %f104, %f104, %f511
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f512) : "f"(f104), "f"(f104), "f"(f511));
  // PTX:943 sqrt.rn.f32 %f105, %f512
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f105) : "f"(f512));
  // PTX:944 setp.leu.f32 %p89, %f105, 0f00000000
  p89 = ((isnan(((float)(f105))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f105)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:945 mov.u32 %r575, 0
  asm("mov.u32 %0, 0;" : "=r"(r575) : );
  // PTX:946 mov.u32 %r576, %r575
  asm("mov.u32 %0, %1;" : "=r"(r576) : "r"(r575));
  // PTX:947 mov.u32 %r577, %r575
  asm("mov.u32 %0, %1;" : "=r"(r577) : "r"(r575));
  // PTX:948 @%p89 bra $L__BB79_78
  if (p89) { goto L_BB79_78; }
  // PTX:950 div.rn.f32 %f513, %f102, %f105
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f513) : "f"(f102), "f"(f105));
  // PTX:951 div.rn.f32 %f514, %f103, %f105
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f514) : "f"(f103), "f"(f105));
  // PTX:952 div.rn.f32 %f515, %f104, %f105
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f515) : "f"(f104), "f"(f105));
  // PTX:953 mov.b32 %r577, %f515
  asm("mov.b32 %0, %1;" : "=r"(r577) : "f"(f515));
  // PTX:954 mov.b32 %r576, %f514
  asm("mov.b32 %0, %1;" : "=r"(r576) : "f"(f514));
  // PTX:955 mov.b32 %r575, %f513
  asm("mov.b32 %0, %1;" : "=r"(r575) : "f"(f513));
  // PTX:957 $L__BB79_78:
L_BB79_78:;
  // PTX:958 mov.b32 %f106, %r575
  asm("mov.b32 %0, %1;" : "=f"(f106) : "r"(r575));
  // PTX:959 mov.b32 %f107, %r576
  asm("mov.b32 %0, %1;" : "=f"(f107) : "r"(r576));
  // PTX:960 mul.f32 %f516, %f1116, %f107
  asm("mul.f32 %0, %1, %2;" : "=f"(f516) : "f"(f1116), "f"(f107));
  // PTX:961 mov.b32 %f108, %r577
  asm("mov.b32 %0, %1;" : "=f"(f108) : "r"(r577));
  // PTX:962 fma.rn.f32 %f517, %f1115, %f106, %f516
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f517) : "f"(f1115), "f"(f106), "f"(f516));
  // PTX:963 fma.rn.f32 %f518, %f1117, %f108, %f517
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f518) : "f"(f1117), "f"(f108), "f"(f517));
  // PTX:964 setp.geu.f32 %p90, %f518, 0f00000000
  p90 = ((isnan(((float)(f518))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f518)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:965 @%p90 bra $L__BB79_80
  if (p90) { goto L_BB79_80; }
  // PTX:967 neg.f32 %f519, %f99
  asm("neg.f32 %0, %1;" : "=f"(f519) : "f"(f99));
  // PTX:968 mov.b32 %r566, %f519
  asm("mov.b32 %0, %1;" : "=r"(r566) : "f"(f519));
  // PTX:969 neg.f32 %f520, %f100
  asm("neg.f32 %0, %1;" : "=f"(f520) : "f"(f100));
  // PTX:970 mov.b32 %r567, %f520
  asm("mov.b32 %0, %1;" : "=r"(r567) : "f"(f520));
  // PTX:971 neg.f32 %f521, %f101
  asm("neg.f32 %0, %1;" : "=f"(f521) : "f"(f101));
  // PTX:972 mov.b32 %r568, %f521
  asm("mov.b32 %0, %1;" : "=r"(r568) : "f"(f521));
  // PTX:973 neg.f32 %f522, %f106
  asm("neg.f32 %0, %1;" : "=f"(f522) : "f"(f106));
  // PTX:974 mov.b32 %r575, %f522
  asm("mov.b32 %0, %1;" : "=r"(r575) : "f"(f522));
  // PTX:975 neg.f32 %f523, %f107
  asm("neg.f32 %0, %1;" : "=f"(f523) : "f"(f107));
  // PTX:976 mov.b32 %r576, %f523
  asm("mov.b32 %0, %1;" : "=r"(r576) : "f"(f523));
  // PTX:977 neg.f32 %f524, %f108
  asm("neg.f32 %0, %1;" : "=f"(f524) : "f"(f108));
  // PTX:978 mov.b32 %r577, %f524
  asm("mov.b32 %0, %1;" : "=r"(r577) : "f"(f524));
  // PTX:980 $L__BB79_80:
L_BB79_80:;
  // PTX:981 mov.u32 %r569, %r554
  asm("mov.u32 %0, %1;" : "=r"(r569) : "r"(r554));
  // PTX:982 mov.u32 %r570, %r555
  asm("mov.u32 %0, %1;" : "=r"(r570) : "r"(r555));
  // PTX:983 mov.u32 %r571, %r556
  asm("mov.u32 %0, %1;" : "=r"(r571) : "r"(r556));
  // PTX:984 mov.u32 %r572, %r566
  asm("mov.u32 %0, %1;" : "=r"(r572) : "r"(r566));
  // PTX:985 mov.u32 %r573, %r567
  asm("mov.u32 %0, %1;" : "=r"(r573) : "r"(r567));
  // PTX:986 mov.u32 %r574, %r568
  asm("mov.u32 %0, %1;" : "=r"(r574) : "r"(r568));
  // PTX:988 $L__BB79_81:
L_BB79_81:;
  // PTX:989 mul.f32 %f1082, %f343, %f1097
  asm("mul.f32 %0, %1, %2;" : "=f"(f1082) : "f"(f343), "f"(f1097));
  // PTX:990 mul.f32 %f1081, %f343, %f1099
  asm("mul.f32 %0, %1, %2;" : "=f"(f1081) : "f"(f343), "f"(f1099));
  // PTX:991 mul.f32 %f1080, %f343, %f1098
  asm("mul.f32 %0, %1, %2;" : "=f"(f1080) : "f"(f343), "f"(f1098));
  // PTX:992 mov.b32 %f525, %r569
  asm("mov.b32 %0, %1;" : "=f"(f525) : "r"(r569));
  // PTX:993 mov.b32 %f526, %r572
  asm("mov.b32 %0, %1;" : "=f"(f526) : "r"(r572));
  // PTX:994 mov.b32 %f527, %r575
  asm("mov.b32 %0, %1;" : "=f"(f527) : "r"(r575));
  // PTX:995 mov.b32 %f528, %r570
  asm("mov.b32 %0, %1;" : "=f"(f528) : "r"(r570));
  // PTX:996 mul.f32 %f529, %f1080, %f528
  asm("mul.f32 %0, %1, %2;" : "=f"(f529) : "f"(f1080), "f"(f528));
  // PTX:997 mov.b32 %f530, %r573
  asm("mov.b32 %0, %1;" : "=f"(f530) : "r"(r573));
  // PTX:998 mul.f32 %f531, %f1080, %f530
  asm("mul.f32 %0, %1, %2;" : "=f"(f531) : "f"(f1080), "f"(f530));
  // PTX:999 mov.b32 %f532, %r576
  asm("mov.b32 %0, %1;" : "=f"(f532) : "r"(r576));
  // PTX:1000 mul.f32 %f533, %f1080, %f532
  asm("mul.f32 %0, %1, %2;" : "=f"(f533) : "f"(f1080), "f"(f532));
  // PTX:1001 fma.rn.f32 %f534, %f1081, %f525, %f529
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f534) : "f"(f1081), "f"(f525), "f"(f529));
  // PTX:1002 fma.rn.f32 %f535, %f1081, %f526, %f531
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f535) : "f"(f1081), "f"(f526), "f"(f531));
  // PTX:1003 fma.rn.f32 %f536, %f1081, %f527, %f533
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f536) : "f"(f1081), "f"(f527), "f"(f533));
  // PTX:1004 mov.b32 %f537, %r571
  asm("mov.b32 %0, %1;" : "=f"(f537) : "r"(r571));
  // PTX:1005 mov.b32 %f538, %r574
  asm("mov.b32 %0, %1;" : "=f"(f538) : "r"(r574));
  // PTX:1006 mov.b32 %f539, %r577
  asm("mov.b32 %0, %1;" : "=f"(f539) : "r"(r577));
  // PTX:1007 fma.rn.f32 %f1118, %f1082, %f537, %f534
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1118) : "f"(f1082), "f"(f537), "f"(f534));
  // PTX:1008 fma.rn.f32 %f1119, %f1082, %f538, %f535
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1119) : "f"(f1082), "f"(f538), "f"(f535));
  // PTX:1009 fma.rn.f32 %f1120, %f1082, %f539, %f536
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1120) : "f"(f1082), "f"(f539), "f"(f536));
  // PTX:1010 bra.uni $L__BB79_82
  goto L_BB79_82;
  // PTX:1012 $L__BB79_83:
L_BB79_83:;
  // PTX:1013 ld.global.f32 %f552, [%rd70]
  f552 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))));
  // PTX:1014 mov.b32 %f553, %r629
  asm("mov.b32 %0, %1;" : "=f"(f553) : "r"(r629));
  // PTX:1015 fma.rn.f32 %f554, %f552, %f1099, %f553
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f554) : "f"(f552), "f"(f1099), "f"(f553));
  // PTX:1016 mov.b32 %f555, %r628
  asm("mov.b32 %0, %1;" : "=f"(f555) : "r"(r628));
  // PTX:1017 fma.rn.f32 %f556, %f552, %f1098, %f555
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f556) : "f"(f552), "f"(f1098), "f"(f555));
  // PTX:1018 mov.b32 %f557, %r627
  asm("mov.b32 %0, %1;" : "=f"(f557) : "r"(r627));
  // PTX:1019 fma.rn.f32 %f558, %f552, %f1097, %f557
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f558) : "f"(f552), "f"(f1097), "f"(f557));
  // PTX:1020 mov.b32 %r629, %f554
  asm("mov.b32 %0, %1;" : "=r"(r629) : "f"(f554));
  // PTX:1021 mov.b32 %r628, %f556
  asm("mov.b32 %0, %1;" : "=r"(r628) : "f"(f556));
  // PTX:1022 mov.b32 %r627, %f558
  asm("mov.b32 %0, %1;" : "=r"(r627) : "f"(f558));
  // PTX:1023 bra.uni $L__BB79_84
  goto L_BB79_84;
  // PTX:1025 $L__BB79_63:
L_BB79_63:;
  // PTX:1026 mul.f32 %f1087, %f343, %f1097
  asm("mul.f32 %0, %1, %2;" : "=f"(f1087) : "f"(f343), "f"(f1097));
  // PTX:1027 mul.f32 %f1086, %f343, %f1099
  asm("mul.f32 %0, %1, %2;" : "=f"(f1086) : "f"(f343), "f"(f1099));
  // PTX:1028 mul.f32 %f1085, %f343, %f1098
  asm("mul.f32 %0, %1, %2;" : "=f"(f1085) : "f"(f343), "f"(f1098));
  // PTX:1029 rcp.rn.f32 %f353, %f36
  asm("rcp.rn.f32 %0, %1;" : "=f"(f353) : "f"(f36));
  // PTX:1030 mul.f32 %f354, %f34, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f354) : "f"(f34), "f"(f24));
  // PTX:1031 mul.f32 %f355, %f35, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f355) : "f"(f35), "f"(f26));
  // PTX:1032 sub.f32 %f356, %f355, %f354
  asm("sub.f32 %0, %1, %2;" : "=f"(f356) : "f"(f355), "f"(f354));
  // PTX:1033 mul.f32 %f357, %f35, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f357) : "f"(f35), "f"(f29));
  // PTX:1034 mul.f32 %f358, %f33, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f358) : "f"(f33), "f"(f24));
  // PTX:1035 sub.f32 %f359, %f358, %f357
  asm("sub.f32 %0, %1, %2;" : "=f"(f359) : "f"(f358), "f"(f357));
  // PTX:1036 mul.f32 %f360, %f33, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f360) : "f"(f33), "f"(f26));
  // PTX:1037 mul.f32 %f361, %f34, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f361) : "f"(f34), "f"(f29));
  // PTX:1038 sub.f32 %f362, %f361, %f360
  asm("sub.f32 %0, %1, %2;" : "=f"(f362) : "f"(f361), "f"(f360));
  // PTX:1039 mul.f32 %f363, %f35, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f363) : "f"(f35), "f"(f25));
  // PTX:1040 mul.f32 %f364, %f34, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f364) : "f"(f34), "f"(f27));
  // PTX:1041 sub.f32 %f365, %f364, %f363
  asm("sub.f32 %0, %1, %2;" : "=f"(f365) : "f"(f364), "f"(f363));
  // PTX:1042 mul.f32 %f366, %f33, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f366) : "f"(f33), "f"(f27));
  // PTX:1043 mul.f32 %f367, %f35, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f367) : "f"(f35), "f"(f30));
  // PTX:1044 sub.f32 %f368, %f367, %f366
  asm("sub.f32 %0, %1, %2;" : "=f"(f368) : "f"(f367), "f"(f366));
  // PTX:1045 mul.f32 %f369, %f34, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f369) : "f"(f34), "f"(f30));
  // PTX:1046 mul.f32 %f370, %f33, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f370) : "f"(f33), "f"(f25));
  // PTX:1047 sub.f32 %f371, %f370, %f369
  asm("sub.f32 %0, %1, %2;" : "=f"(f371) : "f"(f370), "f"(f369));
  // PTX:1048 mul.f32 %f372, %f28, %f353
  asm("mul.f32 %0, %1, %2;" : "=f"(f372) : "f"(f28), "f"(f353));
  // PTX:1049 mul.f32 %f373, %f31, %f353
  asm("mul.f32 %0, %1, %2;" : "=f"(f373) : "f"(f31), "f"(f353));
  // PTX:1050 mul.f32 %f374, %f32, %f353
  asm("mul.f32 %0, %1, %2;" : "=f"(f374) : "f"(f32), "f"(f353));
  // PTX:1051 mul.f32 %f375, %f356, %f353
  asm("mul.f32 %0, %1, %2;" : "=f"(f375) : "f"(f356), "f"(f353));
  // PTX:1052 mul.f32 %f376, %f359, %f353
  asm("mul.f32 %0, %1, %2;" : "=f"(f376) : "f"(f359), "f"(f353));
  // PTX:1053 mul.f32 %f377, %f362, %f353
  asm("mul.f32 %0, %1, %2;" : "=f"(f377) : "f"(f362), "f"(f353));
  // PTX:1054 mul.f32 %f378, %f365, %f353
  asm("mul.f32 %0, %1, %2;" : "=f"(f378) : "f"(f365), "f"(f353));
  // PTX:1055 mul.f32 %f379, %f368, %f353
  asm("mul.f32 %0, %1, %2;" : "=f"(f379) : "f"(f368), "f"(f353));
  // PTX:1056 mul.f32 %f380, %f371, %f353
  asm("mul.f32 %0, %1, %2;" : "=f"(f380) : "f"(f371), "f"(f353));
  // PTX:1057 mul.f32 %f381, %f1085, %f373
  asm("mul.f32 %0, %1, %2;" : "=f"(f381) : "f"(f1085), "f"(f373));
  // PTX:1058 mul.f32 %f382, %f1085, %f376
  asm("mul.f32 %0, %1, %2;" : "=f"(f382) : "f"(f1085), "f"(f376));
  // PTX:1059 mul.f32 %f383, %f1085, %f379
  asm("mul.f32 %0, %1, %2;" : "=f"(f383) : "f"(f1085), "f"(f379));
  // PTX:1060 fma.rn.f32 %f384, %f1086, %f372, %f381
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f384) : "f"(f1086), "f"(f372), "f"(f381));
  // PTX:1061 fma.rn.f32 %f385, %f1086, %f375, %f382
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f385) : "f"(f1086), "f"(f375), "f"(f382));
  // PTX:1062 fma.rn.f32 %f386, %f1086, %f378, %f383
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f386) : "f"(f1086), "f"(f378), "f"(f383));
  // PTX:1063 fma.rn.f32 %f1118, %f1087, %f374, %f384
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1118) : "f"(f1087), "f"(f374), "f"(f384));
  // PTX:1064 fma.rn.f32 %f1119, %f1087, %f377, %f385
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1119) : "f"(f1087), "f"(f377), "f"(f385));
  // PTX:1065 fma.rn.f32 %f1120, %f1087, %f380, %f386
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1120) : "f"(f1087), "f"(f380), "f"(f386));
  // PTX:1067 $L__BB79_82:
L_BB79_82:;
  // PTX:1068 mov.b32 %f544, %r629
  asm("mov.b32 %0, %1;" : "=f"(f544) : "r"(r629));
  // PTX:1069 add.f32 %f545, %f544, %f1118
  asm("add.f32 %0, %1, %2;" : "=f"(f545) : "f"(f544), "f"(f1118));
  // PTX:1070 mov.b32 %f547, %r628
  asm("mov.b32 %0, %1;" : "=f"(f547) : "r"(r628));
  // PTX:1071 add.f32 %f548, %f547, %f1119
  asm("add.f32 %0, %1, %2;" : "=f"(f548) : "f"(f547), "f"(f1119));
  // PTX:1072 mov.b32 %f550, %r627
  asm("mov.b32 %0, %1;" : "=f"(f550) : "r"(r627));
  // PTX:1073 add.f32 %f551, %f550, %f1120
  asm("add.f32 %0, %1, %2;" : "=f"(f551) : "f"(f550), "f"(f1120));
  // PTX:1074 mov.b32 %r629, %f545
  asm("mov.b32 %0, %1;" : "=r"(r629) : "f"(f545));
  // PTX:1075 mov.b32 %r628, %f548
  asm("mov.b32 %0, %1;" : "=r"(r628) : "f"(f548));
  // PTX:1076 mov.b32 %r627, %f551
  asm("mov.b32 %0, %1;" : "=r"(r627) : "f"(f551));
  // PTX:1078 $L__BB79_84:
L_BB79_84:;
  // PTX:1079 setp.ne.s32 %p143, %r43, 3
  p143 = (((int)(r43)) != ((int)(3)));
  // PTX:1080 @%p143 bra $L__BB79_108
  if (p143) { goto L_BB79_108; }
  // PTX:1082 setp.lt.s32 %p133, %r641, 0
  p133 = (((int)(r641)) < ((int)(0)));
  // PTX:1083 ld.param.u64 %rd331, [%rd2+112]
  rd331 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (112))));
  // PTX:1084 cvta.to.global.u64 %rd330, %rd331
  rd330 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd331));
  // PTX:1085 cvt.s64.s32 %rd329, %rd435
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd329) : "l"(rd435));
  // PTX:1086 mul.lo.s64 %rd168, %rd329, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd168) : "l"(rd329));
  // PTX:1087 add.s64 %rd71, %rd330, %rd168
  asm("add.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd330), "l"(rd168));
  // PTX:1088 @%p133 bra $L__BB79_107
  if (p133) { goto L_BB79_107; }
  // PTX:1090 ld.param.u64 %rd355, [%rd2+208]
  rd355 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (208))));
  // PTX:1091 cvta.to.global.u64 %rd354, %rd355
  rd354 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd355));
  // PTX:1092 mul.wide.s32 %rd353, %r633, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd353) : "r"(r633));
  // PTX:1093 add.s64 %rd352, %rd354, %rd353
  asm("add.s64 %0, %1, %2;" : "=l"(rd352) : "l"(rd354), "l"(rd353));
  // PTX:1094 mul.wide.s32 %rd351, %r634, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd351) : "r"(r634));
  // PTX:1095 add.s64 %rd350, %rd354, %rd351
  asm("add.s64 %0, %1, %2;" : "=l"(rd350) : "l"(rd354), "l"(rd351));
  // PTX:1096 mul.wide.s32 %rd349, %r635, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd349) : "r"(r635));
  // PTX:1097 add.s64 %rd348, %rd354, %rd349
  asm("add.s64 %0, %1, %2;" : "=l"(rd348) : "l"(rd354), "l"(rd349));
  // PTX:1098 ld.global.f32 %f559, [%rd71]
  f559 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))));
  // PTX:1099 mul.f32 %f560, %f559, %f1099
  asm("mul.f32 %0, %1, %2;" : "=f"(f560) : "f"(f559), "f"(f1099));
  // PTX:1100 neg.f32 %f109, %f560
  asm("neg.f32 %0, %1;" : "=f"(f109) : "f"(f560));
  // PTX:1101 mul.f32 %f561, %f559, %f1098
  asm("mul.f32 %0, %1, %2;" : "=f"(f561) : "f"(f559), "f"(f1098));
  // PTX:1102 neg.f32 %f110, %f561
  asm("neg.f32 %0, %1;" : "=f"(f110) : "f"(f561));
  // PTX:1103 mul.f32 %f562, %f559, %f1097
  asm("mul.f32 %0, %1, %2;" : "=f"(f562) : "f"(f559), "f"(f1097));
  // PTX:1104 neg.f32 %f111, %f562
  asm("neg.f32 %0, %1;" : "=f"(f111) : "f"(f562));
  // PTX:1105 ld.global.f32 %f112, [%rd352+8]
  f112 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd352) + (8)))));
  // PTX:1106 ld.global.f32 %f113, [%rd350+4]
  f113 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd350) + (4)))));
  // PTX:1107 mul.f32 %f563, %f113, %f112
  asm("mul.f32 %0, %1, %2;" : "=f"(f563) : "f"(f113), "f"(f112));
  // PTX:1108 ld.global.f32 %f114, [%rd352+4]
  f114 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd352) + (4)))));
  // PTX:1109 ld.global.f32 %f115, [%rd350+8]
  f115 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd350) + (8)))));
  // PTX:1110 mul.f32 %f564, %f115, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f564) : "f"(f115), "f"(f114));
  // PTX:1111 sub.f32 %f116, %f563, %f564
  asm("sub.f32 %0, %1, %2;" : "=f"(f116) : "f"(f563), "f"(f564));
  // PTX:1112 ld.global.f32 %f117, [%rd352]
  f117 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd352) + (0)))));
  // PTX:1113 mul.f32 %f565, %f115, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f565) : "f"(f115), "f"(f117));
  // PTX:1114 ld.global.f32 %f118, [%rd350]
  f118 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd350) + (0)))));
  // PTX:1115 mul.f32 %f566, %f118, %f112
  asm("mul.f32 %0, %1, %2;" : "=f"(f566) : "f"(f118), "f"(f112));
  // PTX:1116 sub.f32 %f119, %f565, %f566
  asm("sub.f32 %0, %1, %2;" : "=f"(f119) : "f"(f565), "f"(f566));
  // PTX:1117 mul.f32 %f567, %f118, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f567) : "f"(f118), "f"(f114));
  // PTX:1118 mul.f32 %f568, %f113, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f568) : "f"(f113), "f"(f117));
  // PTX:1119 sub.f32 %f120, %f567, %f568
  asm("sub.f32 %0, %1, %2;" : "=f"(f120) : "f"(f567), "f"(f568));
  // PTX:1120 ld.global.f32 %f121, [%rd348]
  f121 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd348) + (0)))));
  // PTX:1121 ld.global.f32 %f122, [%rd348+4]
  f122 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd348) + (4)))));
  // PTX:1122 mul.f32 %f569, %f122, %f119
  asm("mul.f32 %0, %1, %2;" : "=f"(f569) : "f"(f122), "f"(f119));
  // PTX:1123 ld.global.f32 %f123, [%rd348+8]
  f123 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd348) + (8)))));
  // PTX:1124 fma.rn.f32 %f570, %f121, %f116, %f569
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f570) : "f"(f121), "f"(f116), "f"(f569));
  // PTX:1125 fma.rn.f32 %f124, %f123, %f120, %f570
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f124) : "f"(f123), "f"(f120), "f"(f570));
  // PTX:1126 abs.f32 %f571, %f124
  asm("abs.f32 %0, %1;" : "=f"(f571) : "f"(f124));
  // PTX:1127 setp.leu.f32 %p93, %f571, 0f2EDBE6FF
  p93 = ((isnan(((float)(f571))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) || (((float)(f571)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:1128 setp.geu.f32 %p94, %f571, 0f7F800000
  p94 = ((isnan(((float)(f571))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f571)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1129 or.pred %p95, %p93, %p94
  p95 = ((p93) || (p94));
  // PTX:1130 @%p95 bra $L__BB79_88
  if (p95) { goto L_BB79_88; }
  // PTX:1131 bra.uni $L__BB79_87
  goto L_BB79_87;
  // PTX:1133 $L__BB79_88:
L_BB79_88:;
  // PTX:1134 mul.f32 %f609, %f122, %f122
  asm("mul.f32 %0, %1, %2;" : "=f"(f609) : "f"(f122), "f"(f122));
  // PTX:1135 fma.rn.f32 %f610, %f121, %f121, %f609
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f610) : "f"(f121), "f"(f121), "f"(f609));
  // PTX:1136 fma.rn.f32 %f611, %f123, %f123, %f610
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f611) : "f"(f123), "f"(f123), "f"(f610));
  // PTX:1137 mul.f32 %f612, %f113, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f612) : "f"(f113), "f"(f113));
  // PTX:1138 fma.rn.f32 %f613, %f118, %f118, %f612
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f613) : "f"(f118), "f"(f118), "f"(f612));
  // PTX:1139 fma.rn.f32 %f614, %f115, %f115, %f613
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f614) : "f"(f115), "f"(f115), "f"(f613));
  // PTX:1140 add.f32 %f615, %f611, %f614
  asm("add.f32 %0, %1, %2;" : "=f"(f615) : "f"(f611), "f"(f614));
  // PTX:1141 mul.f32 %f616, %f114, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f616) : "f"(f114), "f"(f114));
  // PTX:1142 fma.rn.f32 %f617, %f117, %f117, %f616
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f617) : "f"(f117), "f"(f117), "f"(f616));
  // PTX:1143 fma.rn.f32 %f618, %f112, %f112, %f617
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f618) : "f"(f112), "f"(f112), "f"(f617));
  // PTX:1144 add.f32 %f619, %f615, %f618
  asm("add.f32 %0, %1, %2;" : "=f"(f619) : "f"(f615), "f"(f618));
  // PTX:1145 div.rn.f32 %f620, %f619, 0f40400000
  asm("div.rn.f32 %0, %1, 0f40400000;" : "=f"(f620) : "f"(f619));
  // PTX:1146 sqrt.rn.f32 %f125, %f620
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f125) : "f"(f620));
  // PTX:1147 setp.leu.f32 %p96, %f125, 0f322BCC77
  p96 = ((isnan(((float)(f125))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f125)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1148 mov.u32 %r600, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r600) : );
  // PTX:1149 mov.u32 %r601, 0
  asm("mov.u32 %0, 0;" : "=r"(r601) : );
  // PTX:1150 mov.u32 %r602, %r601
  asm("mov.u32 %0, %1;" : "=r"(r602) : "r"(r601));
  // PTX:1151 mov.u32 %r603, %r601
  asm("mov.u32 %0, %1;" : "=r"(r603) : "r"(r601));
  // PTX:1152 mov.u32 %r604, %r600
  asm("mov.u32 %0, %1;" : "=r"(r604) : "r"(r600));
  // PTX:1153 mov.u32 %r605, %r601
  asm("mov.u32 %0, %1;" : "=r"(r605) : "r"(r601));
  // PTX:1154 mov.u32 %r606, %r601
  asm("mov.u32 %0, %1;" : "=r"(r606) : "r"(r601));
  // PTX:1155 mov.u32 %r607, %r601
  asm("mov.u32 %0, %1;" : "=r"(r607) : "r"(r601));
  // PTX:1156 mov.u32 %r608, %r600
  asm("mov.u32 %0, %1;" : "=r"(r608) : "r"(r600));
  // PTX:1157 @%p96 bra $L__BB79_105
  if (p96) { goto L_BB79_105; }
  // PTX:1159 abs.f32 %f621, %f125
  asm("abs.f32 %0, %1;" : "=f"(f621) : "f"(f125));
  // PTX:1160 setp.geu.f32 %p97, %f621, 0f7F800000
  p97 = ((isnan(((float)(f621))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f621)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1161 @%p97 bra $L__BB79_105
  if (p97) { goto L_BB79_105; }
  // PTX:1163 rcp.rn.f32 %f622, %f125
  asm("rcp.rn.f32 %0, %1;" : "=f"(f622) : "f"(f125));
  // PTX:1164 mul.f32 %f1130, %f121, %f622
  asm("mul.f32 %0, %1, %2;" : "=f"(f1130) : "f"(f121), "f"(f622));
  // PTX:1165 mul.f32 %f1131, %f122, %f622
  asm("mul.f32 %0, %1, %2;" : "=f"(f1131) : "f"(f122), "f"(f622));
  // PTX:1166 mul.f32 %f1132, %f123, %f622
  asm("mul.f32 %0, %1, %2;" : "=f"(f1132) : "f"(f123), "f"(f622));
  // PTX:1167 mul.f32 %f1133, %f118, %f622
  asm("mul.f32 %0, %1, %2;" : "=f"(f1133) : "f"(f118), "f"(f622));
  // PTX:1168 mul.f32 %f1134, %f113, %f622
  asm("mul.f32 %0, %1, %2;" : "=f"(f1134) : "f"(f113), "f"(f622));
  // PTX:1169 mul.f32 %f1135, %f115, %f622
  asm("mul.f32 %0, %1, %2;" : "=f"(f1135) : "f"(f115), "f"(f622));
  // PTX:1170 mul.f32 %f1136, %f117, %f622
  asm("mul.f32 %0, %1, %2;" : "=f"(f1136) : "f"(f117), "f"(f622));
  // PTX:1171 mul.f32 %f1137, %f114, %f622
  asm("mul.f32 %0, %1, %2;" : "=f"(f1137) : "f"(f114), "f"(f622));
  // PTX:1172 mul.f32 %f1138, %f112, %f622
  asm("mul.f32 %0, %1, %2;" : "=f"(f1138) : "f"(f112), "f"(f622));
  // PTX:1173 mov.u32 %r584, 0
  asm("mov.u32 %0, 0;" : "=r"(r584) : );
  // PTX:1175 $L__BB79_91:
L_BB79_91:;
  // PTX:1176 mul.f32 %f623, %f1135, %f1137
  asm("mul.f32 %0, %1, %2;" : "=f"(f623) : "f"(f1135), "f"(f1137));
  // PTX:1177 mul.f32 %f624, %f1134, %f1138
  asm("mul.f32 %0, %1, %2;" : "=f"(f624) : "f"(f1134), "f"(f1138));
  // PTX:1178 sub.f32 %f144, %f624, %f623
  asm("sub.f32 %0, %1, %2;" : "=f"(f144) : "f"(f624), "f"(f623));
  // PTX:1179 mul.f32 %f625, %f1133, %f1138
  asm("mul.f32 %0, %1, %2;" : "=f"(f625) : "f"(f1133), "f"(f1138));
  // PTX:1180 mul.f32 %f626, %f1135, %f1136
  asm("mul.f32 %0, %1, %2;" : "=f"(f626) : "f"(f1135), "f"(f1136));
  // PTX:1181 sub.f32 %f145, %f626, %f625
  asm("sub.f32 %0, %1, %2;" : "=f"(f145) : "f"(f626), "f"(f625));
  // PTX:1182 mul.f32 %f627, %f1134, %f1136
  asm("mul.f32 %0, %1, %2;" : "=f"(f627) : "f"(f1134), "f"(f1136));
  // PTX:1183 mul.f32 %f628, %f1133, %f1137
  asm("mul.f32 %0, %1, %2;" : "=f"(f628) : "f"(f1133), "f"(f1137));
  // PTX:1184 sub.f32 %f146, %f628, %f627
  asm("sub.f32 %0, %1, %2;" : "=f"(f146) : "f"(f628), "f"(f627));
  // PTX:1185 mul.f32 %f629, %f1131, %f145
  asm("mul.f32 %0, %1, %2;" : "=f"(f629) : "f"(f1131), "f"(f145));
  // PTX:1186 fma.rn.f32 %f630, %f1130, %f144, %f629
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f630) : "f"(f1130), "f"(f144), "f"(f629));
  // PTX:1187 fma.rn.f32 %f147, %f1132, %f146, %f630
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f147) : "f"(f1132), "f"(f146), "f"(f630));
  // PTX:1188 abs.f32 %f631, %f147
  asm("abs.f32 %0, %1;" : "=f"(f631) : "f"(f147));
  // PTX:1189 setp.le.f32 %p98, %f631, 0f2EDBE6FF
  p98 = (!(isnan(((float)(f631))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f631)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:1190 setp.geu.f32 %p99, %f631, 0f7F800000
  p99 = ((isnan(((float)(f631))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f631)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1191 or.pred %p100, %p98, %p99
  p100 = ((p98) || (p99));
  // PTX:1192 @%p100 bra $L__BB79_94
  if (p100) { goto L_BB79_94; }
  // PTX:1194 rcp.rn.f32 %f632, %f147
  asm("rcp.rn.f32 %0, %1;" : "=f"(f632) : "f"(f147));
  // PTX:1195 mul.f32 %f633, %f1131, %f1138
  asm("mul.f32 %0, %1, %2;" : "=f"(f633) : "f"(f1131), "f"(f1138));
  // PTX:1196 mul.f32 %f634, %f1132, %f1137
  asm("mul.f32 %0, %1, %2;" : "=f"(f634) : "f"(f1132), "f"(f1137));
  // PTX:1197 sub.f32 %f635, %f634, %f633
  asm("sub.f32 %0, %1, %2;" : "=f"(f635) : "f"(f634), "f"(f633));
  // PTX:1198 mul.f32 %f636, %f1132, %f1136
  asm("mul.f32 %0, %1, %2;" : "=f"(f636) : "f"(f1132), "f"(f1136));
  // PTX:1199 mul.f32 %f637, %f1130, %f1138
  asm("mul.f32 %0, %1, %2;" : "=f"(f637) : "f"(f1130), "f"(f1138));
  // PTX:1200 sub.f32 %f638, %f637, %f636
  asm("sub.f32 %0, %1, %2;" : "=f"(f638) : "f"(f637), "f"(f636));
  // PTX:1201 mul.f32 %f639, %f1130, %f1137
  asm("mul.f32 %0, %1, %2;" : "=f"(f639) : "f"(f1130), "f"(f1137));
  // PTX:1202 mul.f32 %f640, %f1131, %f1136
  asm("mul.f32 %0, %1, %2;" : "=f"(f640) : "f"(f1131), "f"(f1136));
  // PTX:1203 sub.f32 %f641, %f640, %f639
  asm("sub.f32 %0, %1, %2;" : "=f"(f641) : "f"(f640), "f"(f639));
  // PTX:1204 mul.f32 %f642, %f1132, %f1134
  asm("mul.f32 %0, %1, %2;" : "=f"(f642) : "f"(f1132), "f"(f1134));
  // PTX:1205 mul.f32 %f643, %f1131, %f1135
  asm("mul.f32 %0, %1, %2;" : "=f"(f643) : "f"(f1131), "f"(f1135));
  // PTX:1206 sub.f32 %f644, %f643, %f642
  asm("sub.f32 %0, %1, %2;" : "=f"(f644) : "f"(f643), "f"(f642));
  // PTX:1207 mul.f32 %f645, %f1130, %f1135
  asm("mul.f32 %0, %1, %2;" : "=f"(f645) : "f"(f1130), "f"(f1135));
  // PTX:1208 mul.f32 %f646, %f1132, %f1133
  asm("mul.f32 %0, %1, %2;" : "=f"(f646) : "f"(f1132), "f"(f1133));
  // PTX:1209 sub.f32 %f647, %f646, %f645
  asm("sub.f32 %0, %1, %2;" : "=f"(f647) : "f"(f646), "f"(f645));
  // PTX:1210 mul.f32 %f648, %f1131, %f1133
  asm("mul.f32 %0, %1, %2;" : "=f"(f648) : "f"(f1131), "f"(f1133));
  // PTX:1211 mul.f32 %f649, %f1130, %f1134
  asm("mul.f32 %0, %1, %2;" : "=f"(f649) : "f"(f1130), "f"(f1134));
  // PTX:1212 sub.f32 %f650, %f649, %f648
  asm("sub.f32 %0, %1, %2;" : "=f"(f650) : "f"(f649), "f"(f648));
  // PTX:1213 fma.rn.f32 %f651, %f144, %f632, %f1130
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f651) : "f"(f144), "f"(f632), "f"(f1130));
  // PTX:1214 fma.rn.f32 %f652, %f145, %f632, %f1131
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f652) : "f"(f145), "f"(f632), "f"(f1131));
  // PTX:1215 fma.rn.f32 %f653, %f146, %f632, %f1132
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f653) : "f"(f146), "f"(f632), "f"(f1132));
  // PTX:1216 fma.rn.f32 %f654, %f635, %f632, %f1133
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f654) : "f"(f635), "f"(f632), "f"(f1133));
  // PTX:1217 fma.rn.f32 %f655, %f638, %f632, %f1134
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f655) : "f"(f638), "f"(f632), "f"(f1134));
  // PTX:1218 fma.rn.f32 %f656, %f641, %f632, %f1135
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f656) : "f"(f641), "f"(f632), "f"(f1135));
  // PTX:1219 fma.rn.f32 %f657, %f644, %f632, %f1136
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f657) : "f"(f644), "f"(f632), "f"(f1136));
  // PTX:1220 fma.rn.f32 %f658, %f647, %f632, %f1137
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f658) : "f"(f647), "f"(f632), "f"(f1137));
  // PTX:1221 fma.rn.f32 %f659, %f650, %f632, %f1138
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f659) : "f"(f650), "f"(f632), "f"(f1138));
  // PTX:1222 mul.f32 %f1130, %f651, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1130) : "f"(f651));
  // PTX:1223 mul.f32 %f1131, %f652, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1131) : "f"(f652));
  // PTX:1224 mul.f32 %f1132, %f653, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1132) : "f"(f653));
  // PTX:1225 mul.f32 %f1133, %f654, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1133) : "f"(f654));
  // PTX:1226 mul.f32 %f1134, %f655, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1134) : "f"(f655));
  // PTX:1227 mul.f32 %f1135, %f656, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1135) : "f"(f656));
  // PTX:1228 mul.f32 %f1136, %f657, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1136) : "f"(f657));
  // PTX:1229 mul.f32 %f1137, %f658, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1137) : "f"(f658));
  // PTX:1230 mul.f32 %f1138, %f659, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1138) : "f"(f659));
  // PTX:1231 mul.f32 %f660, %f1134, %f1138
  asm("mul.f32 %0, %1, %2;" : "=f"(f660) : "f"(f1134), "f"(f1138));
  // PTX:1232 mul.f32 %f661, %f1135, %f1137
  asm("mul.f32 %0, %1, %2;" : "=f"(f661) : "f"(f1135), "f"(f1137));
  // PTX:1233 sub.f32 %f157, %f660, %f661
  asm("sub.f32 %0, %1, %2;" : "=f"(f157) : "f"(f660), "f"(f661));
  // PTX:1234 mul.f32 %f662, %f1135, %f1136
  asm("mul.f32 %0, %1, %2;" : "=f"(f662) : "f"(f1135), "f"(f1136));
  // PTX:1235 mul.f32 %f663, %f1133, %f1138
  asm("mul.f32 %0, %1, %2;" : "=f"(f663) : "f"(f1133), "f"(f1138));
  // PTX:1236 sub.f32 %f158, %f662, %f663
  asm("sub.f32 %0, %1, %2;" : "=f"(f158) : "f"(f662), "f"(f663));
  // PTX:1237 mul.f32 %f664, %f1133, %f1137
  asm("mul.f32 %0, %1, %2;" : "=f"(f664) : "f"(f1133), "f"(f1137));
  // PTX:1238 mul.f32 %f665, %f1134, %f1136
  asm("mul.f32 %0, %1, %2;" : "=f"(f665) : "f"(f1134), "f"(f1136));
  // PTX:1239 sub.f32 %f159, %f664, %f665
  asm("sub.f32 %0, %1, %2;" : "=f"(f159) : "f"(f664), "f"(f665));
  // PTX:1240 mul.f32 %f666, %f1131, %f158
  asm("mul.f32 %0, %1, %2;" : "=f"(f666) : "f"(f1131), "f"(f158));
  // PTX:1241 fma.rn.f32 %f667, %f1130, %f157, %f666
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f667) : "f"(f1130), "f"(f157), "f"(f666));
  // PTX:1242 fma.rn.f32 %f160, %f1132, %f159, %f667
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f160) : "f"(f1132), "f"(f159), "f"(f667));
  // PTX:1243 abs.f32 %f668, %f160
  asm("abs.f32 %0, %1;" : "=f"(f668) : "f"(f160));
  // PTX:1244 setp.le.f32 %p101, %f668, 0f2EDBE6FF
  p101 = (!(isnan(((float)(f668))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f668)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:1245 setp.geu.f32 %p102, %f668, 0f7F800000
  p102 = ((isnan(((float)(f668))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f668)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1246 or.pred %p103, %p101, %p102
  p103 = ((p101) || (p102));
  // PTX:1247 @%p103 bra $L__BB79_94
  if (p103) { goto L_BB79_94; }
  // PTX:1249 rcp.rn.f32 %f669, %f160
  asm("rcp.rn.f32 %0, %1;" : "=f"(f669) : "f"(f160));
  // PTX:1250 mul.f32 %f670, %f1131, %f1138
  asm("mul.f32 %0, %1, %2;" : "=f"(f670) : "f"(f1131), "f"(f1138));
  // PTX:1251 mul.f32 %f671, %f1132, %f1137
  asm("mul.f32 %0, %1, %2;" : "=f"(f671) : "f"(f1132), "f"(f1137));
  // PTX:1252 sub.f32 %f672, %f671, %f670
  asm("sub.f32 %0, %1, %2;" : "=f"(f672) : "f"(f671), "f"(f670));
  // PTX:1253 mul.f32 %f673, %f1132, %f1136
  asm("mul.f32 %0, %1, %2;" : "=f"(f673) : "f"(f1132), "f"(f1136));
  // PTX:1254 mul.f32 %f674, %f1130, %f1138
  asm("mul.f32 %0, %1, %2;" : "=f"(f674) : "f"(f1130), "f"(f1138));
  // PTX:1255 sub.f32 %f675, %f674, %f673
  asm("sub.f32 %0, %1, %2;" : "=f"(f675) : "f"(f674), "f"(f673));
  // PTX:1256 mul.f32 %f676, %f1130, %f1137
  asm("mul.f32 %0, %1, %2;" : "=f"(f676) : "f"(f1130), "f"(f1137));
  // PTX:1257 mul.f32 %f677, %f1131, %f1136
  asm("mul.f32 %0, %1, %2;" : "=f"(f677) : "f"(f1131), "f"(f1136));
  // PTX:1258 sub.f32 %f678, %f677, %f676
  asm("sub.f32 %0, %1, %2;" : "=f"(f678) : "f"(f677), "f"(f676));
  // PTX:1259 mul.f32 %f679, %f1132, %f1134
  asm("mul.f32 %0, %1, %2;" : "=f"(f679) : "f"(f1132), "f"(f1134));
  // PTX:1260 mul.f32 %f680, %f1131, %f1135
  asm("mul.f32 %0, %1, %2;" : "=f"(f680) : "f"(f1131), "f"(f1135));
  // PTX:1261 sub.f32 %f681, %f680, %f679
  asm("sub.f32 %0, %1, %2;" : "=f"(f681) : "f"(f680), "f"(f679));
  // PTX:1262 mul.f32 %f682, %f1130, %f1135
  asm("mul.f32 %0, %1, %2;" : "=f"(f682) : "f"(f1130), "f"(f1135));
  // PTX:1263 mul.f32 %f683, %f1132, %f1133
  asm("mul.f32 %0, %1, %2;" : "=f"(f683) : "f"(f1132), "f"(f1133));
  // PTX:1264 sub.f32 %f684, %f683, %f682
  asm("sub.f32 %0, %1, %2;" : "=f"(f684) : "f"(f683), "f"(f682));
  // PTX:1265 mul.f32 %f685, %f1131, %f1133
  asm("mul.f32 %0, %1, %2;" : "=f"(f685) : "f"(f1131), "f"(f1133));
  // PTX:1266 mul.f32 %f686, %f1130, %f1134
  asm("mul.f32 %0, %1, %2;" : "=f"(f686) : "f"(f1130), "f"(f1134));
  // PTX:1267 sub.f32 %f687, %f686, %f685
  asm("sub.f32 %0, %1, %2;" : "=f"(f687) : "f"(f686), "f"(f685));
  // PTX:1268 fma.rn.f32 %f688, %f157, %f669, %f1130
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f688) : "f"(f157), "f"(f669), "f"(f1130));
  // PTX:1269 fma.rn.f32 %f689, %f158, %f669, %f1131
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f689) : "f"(f158), "f"(f669), "f"(f1131));
  // PTX:1270 fma.rn.f32 %f690, %f159, %f669, %f1132
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f690) : "f"(f159), "f"(f669), "f"(f1132));
  // PTX:1271 fma.rn.f32 %f691, %f672, %f669, %f1133
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f691) : "f"(f672), "f"(f669), "f"(f1133));
  // PTX:1272 fma.rn.f32 %f692, %f675, %f669, %f1134
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f692) : "f"(f675), "f"(f669), "f"(f1134));
  // PTX:1273 fma.rn.f32 %f693, %f678, %f669, %f1135
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f693) : "f"(f678), "f"(f669), "f"(f1135));
  // PTX:1274 fma.rn.f32 %f694, %f681, %f669, %f1136
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f694) : "f"(f681), "f"(f669), "f"(f1136));
  // PTX:1275 fma.rn.f32 %f695, %f684, %f669, %f1137
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f695) : "f"(f684), "f"(f669), "f"(f1137));
  // PTX:1276 fma.rn.f32 %f696, %f687, %f669, %f1138
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f696) : "f"(f687), "f"(f669), "f"(f1138));
  // PTX:1277 mul.f32 %f1130, %f688, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1130) : "f"(f688));
  // PTX:1278 mul.f32 %f1131, %f689, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1131) : "f"(f689));
  // PTX:1279 mul.f32 %f1132, %f690, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1132) : "f"(f690));
  // PTX:1280 mul.f32 %f1133, %f691, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1133) : "f"(f691));
  // PTX:1281 mul.f32 %f1134, %f692, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1134) : "f"(f692));
  // PTX:1282 mul.f32 %f1135, %f693, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1135) : "f"(f693));
  // PTX:1283 mul.f32 %f1136, %f694, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1136) : "f"(f694));
  // PTX:1284 mul.f32 %f1137, %f695, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1137) : "f"(f695));
  // PTX:1285 mul.f32 %f1138, %f696, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1138) : "f"(f696));
  // PTX:1286 add.s32 %r584, %r584, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r584) : "r"(r584));
  // PTX:1287 setp.lt.u32 %p104, %r584, 8
  p104 = (((unsigned)(r584)) < ((unsigned)(8)));
  // PTX:1288 @%p104 bra $L__BB79_91
  if (p104) { goto L_BB79_91; }
  // PTX:1290 $L__BB79_94:
L_BB79_94:;
  // PTX:1291 mul.f32 %f697, %f1131, %f1131
  asm("mul.f32 %0, %1, %2;" : "=f"(f697) : "f"(f1131), "f"(f1131));
  // PTX:1292 fma.rn.f32 %f698, %f1130, %f1130, %f697
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f698) : "f"(f1130), "f"(f1130), "f"(f697));
  // PTX:1293 fma.rn.f32 %f699, %f1132, %f1132, %f698
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f699) : "f"(f1132), "f"(f1132), "f"(f698));
  // PTX:1294 sqrt.rn.f32 %f179, %f699
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f179) : "f"(f699));
  // PTX:1295 setp.leu.f32 %p105, %f179, 0f00000000
  p105 = ((isnan(((float)(f179))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f179)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1296 mov.u32 %r597, 0
  asm("mov.u32 %0, 0;" : "=r"(r597) : );
  // PTX:1297 mov.u32 %r585, %r597
  asm("mov.u32 %0, %1;" : "=r"(r585) : "r"(r597));
  // PTX:1298 mov.u32 %r586, %r597
  asm("mov.u32 %0, %1;" : "=r"(r586) : "r"(r597));
  // PTX:1299 mov.u32 %r587, %r597
  asm("mov.u32 %0, %1;" : "=r"(r587) : "r"(r597));
  // PTX:1300 @%p105 bra $L__BB79_96
  if (p105) { goto L_BB79_96; }
  // PTX:1302 div.rn.f32 %f700, %f1130, %f179
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f700) : "f"(f1130), "f"(f179));
  // PTX:1303 div.rn.f32 %f701, %f1131, %f179
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f701) : "f"(f1131), "f"(f179));
  // PTX:1304 div.rn.f32 %f702, %f1132, %f179
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f702) : "f"(f1132), "f"(f179));
  // PTX:1305 mov.b32 %r587, %f702
  asm("mov.b32 %0, %1;" : "=r"(r587) : "f"(f702));
  // PTX:1306 mov.b32 %r586, %f701
  asm("mov.b32 %0, %1;" : "=r"(r586) : "f"(f701));
  // PTX:1307 mov.b32 %r585, %f700
  asm("mov.b32 %0, %1;" : "=r"(r585) : "f"(f700));
  // PTX:1309 $L__BB79_96:
L_BB79_96:;
  // PTX:1310 mov.b32 %f180, %r585
  asm("mov.b32 %0, %1;" : "=f"(f180) : "r"(r585));
  // PTX:1311 mov.b32 %f181, %r586
  asm("mov.b32 %0, %1;" : "=f"(f181) : "r"(r586));
  // PTX:1312 mul.f32 %f703, %f1134, %f181
  asm("mul.f32 %0, %1, %2;" : "=f"(f703) : "f"(f1134), "f"(f181));
  // PTX:1313 mov.b32 %f182, %r587
  asm("mov.b32 %0, %1;" : "=f"(f182) : "r"(r587));
  // PTX:1314 fma.rn.f32 %f704, %f1133, %f180, %f703
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f704) : "f"(f1133), "f"(f180), "f"(f703));
  // PTX:1315 fma.rn.f32 %f705, %f1135, %f182, %f704
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f705) : "f"(f1135), "f"(f182), "f"(f704));
  // PTX:1316 mul.f32 %f706, %f705, %f180
  asm("mul.f32 %0, %1, %2;" : "=f"(f706) : "f"(f705), "f"(f180));
  // PTX:1317 mul.f32 %f707, %f705, %f181
  asm("mul.f32 %0, %1, %2;" : "=f"(f707) : "f"(f705), "f"(f181));
  // PTX:1318 mul.f32 %f708, %f705, %f182
  asm("mul.f32 %0, %1, %2;" : "=f"(f708) : "f"(f705), "f"(f182));
  // PTX:1319 sub.f32 %f183, %f1133, %f706
  asm("sub.f32 %0, %1, %2;" : "=f"(f183) : "f"(f1133), "f"(f706));
  // PTX:1320 sub.f32 %f184, %f1134, %f707
  asm("sub.f32 %0, %1, %2;" : "=f"(f184) : "f"(f1134), "f"(f707));
  // PTX:1321 sub.f32 %f185, %f1135, %f708
  asm("sub.f32 %0, %1, %2;" : "=f"(f185) : "f"(f1135), "f"(f708));
  // PTX:1322 mul.f32 %f709, %f184, %f184
  asm("mul.f32 %0, %1, %2;" : "=f"(f709) : "f"(f184), "f"(f184));
  // PTX:1323 fma.rn.f32 %f710, %f183, %f183, %f709
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f710) : "f"(f183), "f"(f183), "f"(f709));
  // PTX:1324 fma.rn.f32 %f711, %f185, %f185, %f710
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f711) : "f"(f185), "f"(f185), "f"(f710));
  // PTX:1325 sqrt.rn.f32 %f186, %f711
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f186) : "f"(f711));
  // PTX:1326 setp.leu.f32 %p106, %f186, 0f00000000
  p106 = ((isnan(((float)(f186))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f186)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1327 mov.u32 %r598, %r597
  asm("mov.u32 %0, %1;" : "=r"(r598) : "r"(r597));
  // PTX:1328 mov.u32 %r599, %r597
  asm("mov.u32 %0, %1;" : "=r"(r599) : "r"(r597));
  // PTX:1329 @%p106 bra $L__BB79_98
  if (p106) { goto L_BB79_98; }
  // PTX:1331 div.rn.f32 %f712, %f183, %f186
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f712) : "f"(f183), "f"(f186));
  // PTX:1332 div.rn.f32 %f713, %f184, %f186
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f713) : "f"(f184), "f"(f186));
  // PTX:1333 div.rn.f32 %f714, %f185, %f186
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f714) : "f"(f185), "f"(f186));
  // PTX:1334 mov.b32 %r599, %f714
  asm("mov.b32 %0, %1;" : "=r"(r599) : "f"(f714));
  // PTX:1335 mov.b32 %r598, %f713
  asm("mov.b32 %0, %1;" : "=r"(r598) : "f"(f713));
  // PTX:1336 mov.b32 %r597, %f712
  asm("mov.b32 %0, %1;" : "=r"(r597) : "f"(f712));
  // PTX:1338 $L__BB79_98:
L_BB79_98:;
  // PTX:1339 mul.f32 %f715, %f181, %f181
  asm("mul.f32 %0, %1, %2;" : "=f"(f715) : "f"(f181), "f"(f181));
  // PTX:1340 fma.rn.f32 %f716, %f180, %f180, %f715
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f716) : "f"(f180), "f"(f180), "f"(f715));
  // PTX:1341 fma.rn.f32 %f717, %f182, %f182, %f716
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f717) : "f"(f182), "f"(f182), "f"(f716));
  // PTX:1342 sqrt.rn.f32 %f718, %f717
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f718) : "f"(f717));
  // PTX:1343 setp.le.f32 %p107, %f718, 0f322BCC77
  p107 = (!(isnan(((float)(f718))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f718)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1344 mov.u32 %r601, 0
  asm("mov.u32 %0, 0;" : "=r"(r601) : );
  // PTX:1345 mov.u32 %r602, %r601
  asm("mov.u32 %0, %1;" : "=r"(r602) : "r"(r601));
  // PTX:1346 mov.u32 %r603, %r601
  asm("mov.u32 %0, %1;" : "=r"(r603) : "r"(r601));
  // PTX:1347 mov.u32 %r604, %r600
  asm("mov.u32 %0, %1;" : "=r"(r604) : "r"(r600));
  // PTX:1348 mov.u32 %r605, %r601
  asm("mov.u32 %0, %1;" : "=r"(r605) : "r"(r601));
  // PTX:1349 mov.u32 %r606, %r601
  asm("mov.u32 %0, %1;" : "=r"(r606) : "r"(r601));
  // PTX:1350 mov.u32 %r607, %r601
  asm("mov.u32 %0, %1;" : "=r"(r607) : "r"(r601));
  // PTX:1351 mov.u32 %r608, %r600
  asm("mov.u32 %0, %1;" : "=r"(r608) : "r"(r600));
  // PTX:1352 @%p107 bra $L__BB79_105
  if (p107) { goto L_BB79_105; }
  // PTX:1354 mov.b32 %f187, %r597
  asm("mov.b32 %0, %1;" : "=f"(f187) : "r"(r597));
  // PTX:1355 mov.b32 %f188, %r598
  asm("mov.b32 %0, %1;" : "=f"(f188) : "r"(r598));
  // PTX:1356 mul.f32 %f719, %f188, %f188
  asm("mul.f32 %0, %1, %2;" : "=f"(f719) : "f"(f188), "f"(f188));
  // PTX:1357 mov.b32 %f189, %r599
  asm("mov.b32 %0, %1;" : "=f"(f189) : "r"(r599));
  // PTX:1358 fma.rn.f32 %f720, %f187, %f187, %f719
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f720) : "f"(f187), "f"(f187), "f"(f719));
  // PTX:1359 fma.rn.f32 %f721, %f189, %f189, %f720
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f721) : "f"(f189), "f"(f189), "f"(f720));
  // PTX:1360 sqrt.rn.f32 %f722, %f721
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f722) : "f"(f721));
  // PTX:1361 setp.le.f32 %p108, %f722, 0f322BCC77
  p108 = (!(isnan(((float)(f722))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f722)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1362 mov.u32 %r604, %r600
  asm("mov.u32 %0, %1;" : "=r"(r604) : "r"(r600));
  // PTX:1363 mov.u32 %r608, %r600
  asm("mov.u32 %0, %1;" : "=r"(r608) : "r"(r600));
  // PTX:1364 @%p108 bra $L__BB79_105
  if (p108) { goto L_BB79_105; }
  // PTX:1366 mul.f32 %f723, %f181, %f189
  asm("mul.f32 %0, %1, %2;" : "=f"(f723) : "f"(f181), "f"(f189));
  // PTX:1367 mul.f32 %f724, %f182, %f188
  asm("mul.f32 %0, %1, %2;" : "=f"(f724) : "f"(f182), "f"(f188));
  // PTX:1368 sub.f32 %f190, %f723, %f724
  asm("sub.f32 %0, %1, %2;" : "=f"(f190) : "f"(f723), "f"(f724));
  // PTX:1369 mul.f32 %f725, %f180, %f189
  asm("mul.f32 %0, %1, %2;" : "=f"(f725) : "f"(f180), "f"(f189));
  // PTX:1370 mul.f32 %f726, %f182, %f187
  asm("mul.f32 %0, %1, %2;" : "=f"(f726) : "f"(f182), "f"(f187));
  // PTX:1371 sub.f32 %f191, %f726, %f725
  asm("sub.f32 %0, %1, %2;" : "=f"(f191) : "f"(f726), "f"(f725));
  // PTX:1372 mul.f32 %f727, %f181, %f187
  asm("mul.f32 %0, %1, %2;" : "=f"(f727) : "f"(f181), "f"(f187));
  // PTX:1373 mul.f32 %f728, %f180, %f188
  asm("mul.f32 %0, %1, %2;" : "=f"(f728) : "f"(f180), "f"(f188));
  // PTX:1374 sub.f32 %f192, %f728, %f727
  asm("sub.f32 %0, %1, %2;" : "=f"(f192) : "f"(f728), "f"(f727));
  // PTX:1375 mul.f32 %f729, %f191, %f191
  asm("mul.f32 %0, %1, %2;" : "=f"(f729) : "f"(f191), "f"(f191));
  // PTX:1376 fma.rn.f32 %f730, %f190, %f190, %f729
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f730) : "f"(f190), "f"(f190), "f"(f729));
  // PTX:1377 fma.rn.f32 %f731, %f192, %f192, %f730
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f731) : "f"(f192), "f"(f192), "f"(f730));
  // PTX:1378 sqrt.rn.f32 %f193, %f731
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f193) : "f"(f731));
  // PTX:1379 setp.leu.f32 %p109, %f193, 0f00000000
  p109 = ((isnan(((float)(f193))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f193)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1380 mov.u32 %r606, 0
  asm("mov.u32 %0, 0;" : "=r"(r606) : );
  // PTX:1381 mov.u32 %r607, %r606
  asm("mov.u32 %0, %1;" : "=r"(r607) : "r"(r606));
  // PTX:1382 mov.u32 %r608, %r606
  asm("mov.u32 %0, %1;" : "=r"(r608) : "r"(r606));
  // PTX:1383 @%p109 bra $L__BB79_102
  if (p109) { goto L_BB79_102; }
  // PTX:1385 div.rn.f32 %f732, %f190, %f193
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f732) : "f"(f190), "f"(f193));
  // PTX:1386 div.rn.f32 %f733, %f191, %f193
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f733) : "f"(f191), "f"(f193));
  // PTX:1387 div.rn.f32 %f734, %f192, %f193
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f734) : "f"(f192), "f"(f193));
  // PTX:1388 mov.b32 %r608, %f734
  asm("mov.b32 %0, %1;" : "=r"(r608) : "f"(f734));
  // PTX:1389 mov.b32 %r607, %f733
  asm("mov.b32 %0, %1;" : "=r"(r607) : "f"(f733));
  // PTX:1390 mov.b32 %r606, %f732
  asm("mov.b32 %0, %1;" : "=r"(r606) : "f"(f732));
  // PTX:1392 $L__BB79_102:
L_BB79_102:;
  // PTX:1393 mov.b32 %f194, %r606
  asm("mov.b32 %0, %1;" : "=f"(f194) : "r"(r606));
  // PTX:1394 mov.b32 %f195, %r607
  asm("mov.b32 %0, %1;" : "=f"(f195) : "r"(r607));
  // PTX:1395 mul.f32 %f735, %f1137, %f195
  asm("mul.f32 %0, %1, %2;" : "=f"(f735) : "f"(f1137), "f"(f195));
  // PTX:1396 mov.b32 %f196, %r608
  asm("mov.b32 %0, %1;" : "=f"(f196) : "r"(r608));
  // PTX:1397 fma.rn.f32 %f736, %f1136, %f194, %f735
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f736) : "f"(f1136), "f"(f194), "f"(f735));
  // PTX:1398 fma.rn.f32 %f737, %f1138, %f196, %f736
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f737) : "f"(f1138), "f"(f196), "f"(f736));
  // PTX:1399 setp.geu.f32 %p110, %f737, 0f00000000
  p110 = ((isnan(((float)(f737))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f737)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:1400 @%p110 bra $L__BB79_104
  if (p110) { goto L_BB79_104; }
  // PTX:1402 neg.f32 %f738, %f187
  asm("neg.f32 %0, %1;" : "=f"(f738) : "f"(f187));
  // PTX:1403 mov.b32 %r597, %f738
  asm("mov.b32 %0, %1;" : "=r"(r597) : "f"(f738));
  // PTX:1404 neg.f32 %f739, %f188
  asm("neg.f32 %0, %1;" : "=f"(f739) : "f"(f188));
  // PTX:1405 mov.b32 %r598, %f739
  asm("mov.b32 %0, %1;" : "=r"(r598) : "f"(f739));
  // PTX:1406 neg.f32 %f740, %f189
  asm("neg.f32 %0, %1;" : "=f"(f740) : "f"(f189));
  // PTX:1407 mov.b32 %r599, %f740
  asm("mov.b32 %0, %1;" : "=r"(r599) : "f"(f740));
  // PTX:1408 neg.f32 %f741, %f194
  asm("neg.f32 %0, %1;" : "=f"(f741) : "f"(f194));
  // PTX:1409 mov.b32 %r606, %f741
  asm("mov.b32 %0, %1;" : "=r"(r606) : "f"(f741));
  // PTX:1410 neg.f32 %f742, %f195
  asm("neg.f32 %0, %1;" : "=f"(f742) : "f"(f195));
  // PTX:1411 mov.b32 %r607, %f742
  asm("mov.b32 %0, %1;" : "=r"(r607) : "f"(f742));
  // PTX:1412 neg.f32 %f743, %f196
  asm("neg.f32 %0, %1;" : "=f"(f743) : "f"(f196));
  // PTX:1413 mov.b32 %r608, %f743
  asm("mov.b32 %0, %1;" : "=r"(r608) : "f"(f743));
  // PTX:1415 $L__BB79_104:
L_BB79_104:;
  // PTX:1416 mov.u32 %r600, %r585
  asm("mov.u32 %0, %1;" : "=r"(r600) : "r"(r585));
  // PTX:1417 mov.u32 %r601, %r586
  asm("mov.u32 %0, %1;" : "=r"(r601) : "r"(r586));
  // PTX:1418 mov.u32 %r602, %r587
  asm("mov.u32 %0, %1;" : "=r"(r602) : "r"(r587));
  // PTX:1419 mov.u32 %r603, %r597
  asm("mov.u32 %0, %1;" : "=r"(r603) : "r"(r597));
  // PTX:1420 mov.u32 %r604, %r598
  asm("mov.u32 %0, %1;" : "=r"(r604) : "r"(r598));
  // PTX:1421 mov.u32 %r605, %r599
  asm("mov.u32 %0, %1;" : "=r"(r605) : "r"(r599));
  // PTX:1423 $L__BB79_105:
L_BB79_105:;
  // PTX:1424 mov.b32 %f744, %r600
  asm("mov.b32 %0, %1;" : "=f"(f744) : "r"(r600));
  // PTX:1425 mov.b32 %f745, %r603
  asm("mov.b32 %0, %1;" : "=f"(f745) : "r"(r603));
  // PTX:1426 mov.b32 %f746, %r606
  asm("mov.b32 %0, %1;" : "=f"(f746) : "r"(r606));
  // PTX:1427 mov.b32 %f747, %r601
  asm("mov.b32 %0, %1;" : "=f"(f747) : "r"(r601));
  // PTX:1428 mul.f32 %f748, %f110, %f747
  asm("mul.f32 %0, %1, %2;" : "=f"(f748) : "f"(f110), "f"(f747));
  // PTX:1429 mov.b32 %f749, %r604
  asm("mov.b32 %0, %1;" : "=f"(f749) : "r"(r604));
  // PTX:1430 mul.f32 %f750, %f110, %f749
  asm("mul.f32 %0, %1, %2;" : "=f"(f750) : "f"(f110), "f"(f749));
  // PTX:1431 mov.b32 %f751, %r607
  asm("mov.b32 %0, %1;" : "=f"(f751) : "r"(r607));
  // PTX:1432 mul.f32 %f752, %f110, %f751
  asm("mul.f32 %0, %1, %2;" : "=f"(f752) : "f"(f110), "f"(f751));
  // PTX:1433 fma.rn.f32 %f753, %f109, %f744, %f748
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f753) : "f"(f109), "f"(f744), "f"(f748));
  // PTX:1434 fma.rn.f32 %f754, %f109, %f745, %f750
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f754) : "f"(f109), "f"(f745), "f"(f750));
  // PTX:1435 fma.rn.f32 %f755, %f109, %f746, %f752
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f755) : "f"(f109), "f"(f746), "f"(f752));
  // PTX:1436 mov.b32 %f756, %r602
  asm("mov.b32 %0, %1;" : "=f"(f756) : "r"(r602));
  // PTX:1437 mov.b32 %f757, %r605
  asm("mov.b32 %0, %1;" : "=f"(f757) : "r"(r605));
  // PTX:1438 mov.b32 %f758, %r608
  asm("mov.b32 %0, %1;" : "=f"(f758) : "r"(r608));
  // PTX:1439 fma.rn.f32 %f1139, %f111, %f756, %f753
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1139) : "f"(f111), "f"(f756), "f"(f753));
  // PTX:1440 fma.rn.f32 %f1140, %f111, %f757, %f754
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1140) : "f"(f111), "f"(f757), "f"(f754));
  // PTX:1441 fma.rn.f32 %f1141, %f111, %f758, %f755
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1141) : "f"(f111), "f"(f758), "f"(f755));
  // PTX:1442 bra.uni $L__BB79_106
  goto L_BB79_106;
  // PTX:1444 $L__BB79_107:
L_BB79_107:;
  // PTX:1445 ld.global.f32 %f771, [%rd71]
  f771 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))));
  // PTX:1446 mul.f32 %f772, %f771, %f1099
  asm("mul.f32 %0, %1, %2;" : "=f"(f772) : "f"(f771), "f"(f1099));
  // PTX:1447 mul.f32 %f773, %f771, %f1098
  asm("mul.f32 %0, %1, %2;" : "=f"(f773) : "f"(f771), "f"(f1098));
  // PTX:1448 mul.f32 %f774, %f771, %f1097
  asm("mul.f32 %0, %1, %2;" : "=f"(f774) : "f"(f771), "f"(f1097));
  // PTX:1449 mov.b32 %f775, %r626
  asm("mov.b32 %0, %1;" : "=f"(f775) : "r"(r626));
  // PTX:1450 sub.f32 %f776, %f775, %f772
  asm("sub.f32 %0, %1, %2;" : "=f"(f776) : "f"(f775), "f"(f772));
  // PTX:1451 mov.b32 %f777, %r625
  asm("mov.b32 %0, %1;" : "=f"(f777) : "r"(r625));
  // PTX:1452 sub.f32 %f778, %f777, %f773
  asm("sub.f32 %0, %1, %2;" : "=f"(f778) : "f"(f777), "f"(f773));
  // PTX:1453 mov.b32 %f779, %r624
  asm("mov.b32 %0, %1;" : "=f"(f779) : "r"(r624));
  // PTX:1454 sub.f32 %f780, %f779, %f774
  asm("sub.f32 %0, %1, %2;" : "=f"(f780) : "f"(f779), "f"(f774));
  // PTX:1455 mov.b32 %r626, %f776
  asm("mov.b32 %0, %1;" : "=r"(r626) : "f"(f776));
  // PTX:1456 mov.b32 %r625, %f778
  asm("mov.b32 %0, %1;" : "=r"(r625) : "f"(f778));
  // PTX:1457 mov.b32 %r624, %f780
  asm("mov.b32 %0, %1;" : "=r"(r624) : "f"(f780));
  // PTX:1458 bra.uni $L__BB79_108
  goto L_BB79_108;
  // PTX:1460 $L__BB79_87:
L_BB79_87:;
  // PTX:1461 rcp.rn.f32 %f572, %f124
  asm("rcp.rn.f32 %0, %1;" : "=f"(f572) : "f"(f124));
  // PTX:1462 mul.f32 %f573, %f122, %f112
  asm("mul.f32 %0, %1, %2;" : "=f"(f573) : "f"(f122), "f"(f112));
  // PTX:1463 mul.f32 %f574, %f123, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f574) : "f"(f123), "f"(f114));
  // PTX:1464 sub.f32 %f575, %f574, %f573
  asm("sub.f32 %0, %1, %2;" : "=f"(f575) : "f"(f574), "f"(f573));
  // PTX:1465 mul.f32 %f576, %f123, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f576) : "f"(f123), "f"(f117));
  // PTX:1466 mul.f32 %f577, %f121, %f112
  asm("mul.f32 %0, %1, %2;" : "=f"(f577) : "f"(f121), "f"(f112));
  // PTX:1467 sub.f32 %f578, %f577, %f576
  asm("sub.f32 %0, %1, %2;" : "=f"(f578) : "f"(f577), "f"(f576));
  // PTX:1468 mul.f32 %f579, %f121, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f579) : "f"(f121), "f"(f114));
  // PTX:1469 mul.f32 %f580, %f122, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f580) : "f"(f122), "f"(f117));
  // PTX:1470 sub.f32 %f581, %f580, %f579
  asm("sub.f32 %0, %1, %2;" : "=f"(f581) : "f"(f580), "f"(f579));
  // PTX:1471 mul.f32 %f582, %f123, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f582) : "f"(f123), "f"(f113));
  // PTX:1472 mul.f32 %f583, %f122, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f583) : "f"(f122), "f"(f115));
  // PTX:1473 sub.f32 %f584, %f583, %f582
  asm("sub.f32 %0, %1, %2;" : "=f"(f584) : "f"(f583), "f"(f582));
  // PTX:1474 mul.f32 %f585, %f121, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f585) : "f"(f121), "f"(f115));
  // PTX:1475 mul.f32 %f586, %f123, %f118
  asm("mul.f32 %0, %1, %2;" : "=f"(f586) : "f"(f123), "f"(f118));
  // PTX:1476 sub.f32 %f587, %f586, %f585
  asm("sub.f32 %0, %1, %2;" : "=f"(f587) : "f"(f586), "f"(f585));
  // PTX:1477 mul.f32 %f588, %f122, %f118
  asm("mul.f32 %0, %1, %2;" : "=f"(f588) : "f"(f122), "f"(f118));
  // PTX:1478 mul.f32 %f589, %f121, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f589) : "f"(f121), "f"(f113));
  // PTX:1479 sub.f32 %f590, %f589, %f588
  asm("sub.f32 %0, %1, %2;" : "=f"(f590) : "f"(f589), "f"(f588));
  // PTX:1480 mul.f32 %f591, %f116, %f572
  asm("mul.f32 %0, %1, %2;" : "=f"(f591) : "f"(f116), "f"(f572));
  // PTX:1481 mul.f32 %f592, %f119, %f572
  asm("mul.f32 %0, %1, %2;" : "=f"(f592) : "f"(f119), "f"(f572));
  // PTX:1482 mul.f32 %f593, %f120, %f572
  asm("mul.f32 %0, %1, %2;" : "=f"(f593) : "f"(f120), "f"(f572));
  // PTX:1483 mul.f32 %f594, %f575, %f572
  asm("mul.f32 %0, %1, %2;" : "=f"(f594) : "f"(f575), "f"(f572));
  // PTX:1484 mul.f32 %f595, %f578, %f572
  asm("mul.f32 %0, %1, %2;" : "=f"(f595) : "f"(f578), "f"(f572));
  // PTX:1485 mul.f32 %f596, %f581, %f572
  asm("mul.f32 %0, %1, %2;" : "=f"(f596) : "f"(f581), "f"(f572));
  // PTX:1486 mul.f32 %f597, %f584, %f572
  asm("mul.f32 %0, %1, %2;" : "=f"(f597) : "f"(f584), "f"(f572));
  // PTX:1487 mul.f32 %f598, %f587, %f572
  asm("mul.f32 %0, %1, %2;" : "=f"(f598) : "f"(f587), "f"(f572));
  // PTX:1488 mul.f32 %f599, %f590, %f572
  asm("mul.f32 %0, %1, %2;" : "=f"(f599) : "f"(f590), "f"(f572));
  // PTX:1489 mul.f32 %f600, %f592, %f110
  asm("mul.f32 %0, %1, %2;" : "=f"(f600) : "f"(f592), "f"(f110));
  // PTX:1490 mul.f32 %f601, %f595, %f110
  asm("mul.f32 %0, %1, %2;" : "=f"(f601) : "f"(f595), "f"(f110));
  // PTX:1491 mul.f32 %f602, %f598, %f110
  asm("mul.f32 %0, %1, %2;" : "=f"(f602) : "f"(f598), "f"(f110));
  // PTX:1492 fma.rn.f32 %f603, %f591, %f109, %f600
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f603) : "f"(f591), "f"(f109), "f"(f600));
  // PTX:1493 fma.rn.f32 %f604, %f594, %f109, %f601
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f604) : "f"(f594), "f"(f109), "f"(f601));
  // PTX:1494 fma.rn.f32 %f605, %f597, %f109, %f602
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f605) : "f"(f597), "f"(f109), "f"(f602));
  // PTX:1495 fma.rn.f32 %f1139, %f593, %f111, %f603
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1139) : "f"(f593), "f"(f111), "f"(f603));
  // PTX:1496 fma.rn.f32 %f1140, %f596, %f111, %f604
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1140) : "f"(f596), "f"(f111), "f"(f604));
  // PTX:1497 fma.rn.f32 %f1141, %f599, %f111, %f605
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1141) : "f"(f599), "f"(f111), "f"(f605));
  // PTX:1499 $L__BB79_106:
L_BB79_106:;
  // PTX:1500 mov.b32 %f763, %r626
  asm("mov.b32 %0, %1;" : "=f"(f763) : "r"(r626));
  // PTX:1501 add.f32 %f764, %f763, %f1139
  asm("add.f32 %0, %1, %2;" : "=f"(f764) : "f"(f763), "f"(f1139));
  // PTX:1502 mov.b32 %f766, %r625
  asm("mov.b32 %0, %1;" : "=f"(f766) : "r"(r625));
  // PTX:1503 add.f32 %f767, %f766, %f1140
  asm("add.f32 %0, %1, %2;" : "=f"(f767) : "f"(f766), "f"(f1140));
  // PTX:1504 mov.b32 %f769, %r624
  asm("mov.b32 %0, %1;" : "=f"(f769) : "r"(r624));
  // PTX:1505 add.f32 %f770, %f769, %f1141
  asm("add.f32 %0, %1, %2;" : "=f"(f770) : "f"(f769), "f"(f1141));
  // PTX:1506 mov.b32 %r626, %f764
  asm("mov.b32 %0, %1;" : "=r"(r626) : "f"(f764));
  // PTX:1507 mov.b32 %r625, %f767
  asm("mov.b32 %0, %1;" : "=r"(r625) : "f"(f767));
  // PTX:1508 mov.b32 %r624, %f770
  asm("mov.b32 %0, %1;" : "=r"(r624) : "f"(f770));
  // PTX:1510 $L__BB79_108:
L_BB79_108:;
  // PTX:1511 ld.param.u64 %rd315, [%rd2+40]
  rd315 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (40))));
  // PTX:1512 setp.eq.s64 %p111, %rd315, 0
  p111 = (((long long)(rd315)) == ((long long)(0)));
  // PTX:1513 @%p111 bra $L__BB79_110
  if (p111) { goto L_BB79_110; }
  // PTX:1515 ld.param.u64 %rd318, [%rd2+40]
  rd318 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (40))));
  // PTX:1516 ld.param.u64 %rd317, [%rd2+24]
  rd317 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (24))));
  // PTX:1517 cvta.to.global.u64 %rd316, %rd317
  rd316 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd317));
  // PTX:1518 add.s64 %rd170, %rd316, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd170) : "l"(rd316), "l"(rd138));
  // PTX:1519 cvta.to.global.u64 %rd171, %rd318
  rd171 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd318));
  // PTX:1520 add.s64 %rd172, %rd171, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd172) : "l"(rd171), "l"(rd138));
  // PTX:1521 ld.global.f32 %f781, [%rd172]
  f781 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (0)))));
  // PTX:1522 ld.global.f32 %f782, [%rd170]
  f782 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd170) + (0)))));
  // PTX:1523 add.f32 %f783, %f782, %f781
  asm("add.f32 %0, %1, %2;" : "=f"(f783) : "f"(f782), "f"(f781));
  // PTX:1524 ld.global.f32 %f784, [%rd172+4]
  f784 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (4)))));
  // PTX:1525 ld.global.f32 %f785, [%rd170+4]
  f785 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd170) + (4)))));
  // PTX:1526 add.f32 %f786, %f785, %f784
  asm("add.f32 %0, %1, %2;" : "=f"(f786) : "f"(f785), "f"(f784));
  // PTX:1527 ld.global.f32 %f787, [%rd172+8]
  f787 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (8)))));
  // PTX:1528 ld.global.f32 %f788, [%rd170+8]
  f788 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd170) + (8)))));
  // PTX:1529 add.f32 %f789, %f788, %f787
  asm("add.f32 %0, %1, %2;" : "=f"(f789) : "f"(f788), "f"(f787));
  // PTX:1530 mov.b32 %r629, %f783
  asm("mov.b32 %0, %1;" : "=r"(r629) : "f"(f783));
  // PTX:1531 mov.b32 %r628, %f786
  asm("mov.b32 %0, %1;" : "=r"(r628) : "f"(f786));
  // PTX:1532 mov.b32 %r627, %f789
  asm("mov.b32 %0, %1;" : "=r"(r627) : "f"(f789));
  // PTX:1534 $L__BB79_110:
L_BB79_110:;
  // PTX:1535 ld.param.u64 %rd319, [%rd2+48]
  rd319 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (48))));
  // PTX:1536 setp.eq.s64 %p112, %rd319, 0
  p112 = (((long long)(rd319)) == ((long long)(0)));
  // PTX:1537 @%p112 bra $L__BB79_112
  if (p112) { goto L_BB79_112; }
  // PTX:1539 ld.param.u64 %rd322, [%rd2+48]
  rd322 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (48))));
  // PTX:1540 ld.param.u64 %rd321, [%rd2+32]
  rd321 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (32))));
  // PTX:1541 cvta.to.global.u64 %rd320, %rd321
  rd320 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd321));
  // PTX:1542 add.s64 %rd174, %rd320, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd174) : "l"(rd320), "l"(rd138));
  // PTX:1543 cvta.to.global.u64 %rd175, %rd322
  rd175 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd322));
  // PTX:1544 add.s64 %rd176, %rd175, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd176) : "l"(rd175), "l"(rd138));
  // PTX:1545 ld.global.f32 %f790, [%rd176]
  f790 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (0)))));
  // PTX:1546 ld.global.f32 %f791, [%rd174]
  f791 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (0)))));
  // PTX:1547 add.f32 %f792, %f791, %f790
  asm("add.f32 %0, %1, %2;" : "=f"(f792) : "f"(f791), "f"(f790));
  // PTX:1548 ld.global.f32 %f793, [%rd176+4]
  f793 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (4)))));
  // PTX:1549 ld.global.f32 %f794, [%rd174+4]
  f794 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (4)))));
  // PTX:1550 add.f32 %f795, %f794, %f793
  asm("add.f32 %0, %1, %2;" : "=f"(f795) : "f"(f794), "f"(f793));
  // PTX:1551 ld.global.f32 %f796, [%rd176+8]
  f796 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (8)))));
  // PTX:1552 ld.global.f32 %f797, [%rd174+8]
  f797 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (8)))));
  // PTX:1553 add.f32 %f798, %f797, %f796
  asm("add.f32 %0, %1, %2;" : "=f"(f798) : "f"(f797), "f"(f796));
  // PTX:1554 mov.b32 %r626, %f792
  asm("mov.b32 %0, %1;" : "=r"(r626) : "f"(f792));
  // PTX:1555 mov.b32 %r625, %f795
  asm("mov.b32 %0, %1;" : "=r"(r625) : "f"(f795));
  // PTX:1556 mov.b32 %r624, %f798
  asm("mov.b32 %0, %1;" : "=r"(r624) : "f"(f798));
  // PTX:1558 $L__BB79_112:
L_BB79_112:;
  // PTX:1559 ld.param.u64 %rd177, [%rd2+56]
  rd177 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (56))));
  // PTX:1560 cvta.to.global.u64 %rd178, %rd177
  rd178 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd177));
  // PTX:1561 add.s64 %rd180, %rd178, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd180) : "l"(rd178), "l"(rd138));
  // PTX:1562 ld.global.f32 %f197, [%rd180]
  f197 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (0)))));
  // PTX:1563 ld.global.f32 %f198, [%rd180+4]
  f198 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (4)))));
  // PTX:1564 mul.f32 %f799, %f198, %f198
  asm("mul.f32 %0, %1, %2;" : "=f"(f799) : "f"(f198), "f"(f198));
  // PTX:1565 ld.global.f32 %f199, [%rd180+8]
  f199 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (8)))));
  // PTX:1566 fma.rn.f32 %f800, %f197, %f197, %f799
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f800) : "f"(f197), "f"(f197), "f"(f799));
  // PTX:1567 fma.rn.f32 %f801, %f199, %f199, %f800
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f801) : "f"(f199), "f"(f199), "f"(f800));
  // PTX:1568 sqrt.rn.f32 %f200, %f801
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f200) : "f"(f801));
  // PTX:1569 setp.leu.f32 %p113, %f200, 0f00000000
  p113 = ((isnan(((float)(f200))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f200)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1570 mov.u32 %r632, 0
  asm("mov.u32 %0, 0;" : "=r"(r632) : );
  // PTX:1571 mov.u32 %r631, %r632
  asm("mov.u32 %0, %1;" : "=r"(r631) : "r"(r632));
  // PTX:1572 mov.u32 %r630, %r632
  asm("mov.u32 %0, %1;" : "=r"(r630) : "r"(r632));
  // PTX:1573 @%p113 bra $L__BB79_114
  if (p113) { goto L_BB79_114; }
  // PTX:1575 div.rn.f32 %f802, %f197, %f200
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f802) : "f"(f197), "f"(f200));
  // PTX:1576 div.rn.f32 %f803, %f198, %f200
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f803) : "f"(f198), "f"(f200));
  // PTX:1577 div.rn.f32 %f804, %f199, %f200
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f804) : "f"(f199), "f"(f200));
  // PTX:1578 mov.b32 %r630, %f804
  asm("mov.b32 %0, %1;" : "=r"(r630) : "f"(f804));
  // PTX:1579 mov.b32 %r631, %f803
  asm("mov.b32 %0, %1;" : "=r"(r631) : "f"(f803));
  // PTX:1580 mov.b32 %r632, %f802
  asm("mov.b32 %0, %1;" : "=r"(r632) : "f"(f802));
  // PTX:1582 $L__BB79_114:
L_BB79_114:;
  // PTX:1583 mov.pred %p146, -1
  p146 = ((-1) != 0);
  // PTX:1584 mov.f32 %f1148, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1148) : );
  // PTX:1585 mov.b32 %f201, %r632
  asm("mov.b32 %0, %1;" : "=f"(f201) : "r"(r632));
  // PTX:1586 mul.f32 %f806, %f201, %f201
  asm("mul.f32 %0, %1, %2;" : "=f"(f806) : "f"(f201), "f"(f201));
  // PTX:1587 mov.b32 %f202, %r631
  asm("mov.b32 %0, %1;" : "=f"(f202) : "r"(r631));
  // PTX:1588 mov.b32 %f203, %r630
  asm("mov.b32 %0, %1;" : "=f"(f203) : "r"(r630));
  // PTX:1589 fma.rn.f32 %f807, %f202, %f202, %f806
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f807) : "f"(f202), "f"(f202), "f"(f806));
  // PTX:1590 fma.rn.f32 %f808, %f203, %f203, %f807
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f808) : "f"(f203), "f"(f203), "f"(f807));
  // PTX:1591 setp.lt.f32 %p115, %f808, 0f3F000000
  p115 = (!(isnan(((float)(f808))) || isnan(((float)(as_f32(0x3F000000u))))) && (((float)(f808)) < ((float)(as_f32(0x3F000000u)))));
  // PTX:1592 @%p115 bra $L__BB79_122
  if (p115) { goto L_BB79_122; }
  // PTX:1594 setp.lt.s32 %p129, %r642, 0
  p129 = (((int)(r642)) < ((int)(0)));
  // PTX:1595 ld.param.u64 %rd181, [%rd2+208]
  rd181 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (208))));
  // PTX:1596 cvta.to.global.u64 %rd72, %rd181
  rd72 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd181));
  // PTX:1597 ld.param.u64 %rd182, [%rd2+184]
  rd182 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (184))));
  // PTX:1598 cvta.to.global.u64 %rd73, %rd182
  rd73 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd182));
  // PTX:1599 @%p129 bra $L__BB79_117
  if (p129) { goto L_BB79_117; }
  // PTX:1601 mul.wide.s32 %rd339, %r638, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd339) : "r"(r638));
  // PTX:1602 mul.wide.s32 %rd335, %r637, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd335) : "r"(r637));
  // PTX:1603 mul.wide.s32 %rd334, %r639, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd334) : "r"(r639));
  // PTX:1604 mul.wide.s32 %rd183, %r642, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd183) : "r"(r642));
  // PTX:1605 add.s64 %rd184, %rd73, %rd183
  asm("add.s64 %0, %1, %2;" : "=l"(rd184) : "l"(rd73), "l"(rd183));
  // PTX:1606 ld.param.u64 %rd185, [%rd2+24]
  rd185 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (24))));
  // PTX:1607 cvta.to.global.u64 %rd186, %rd185
  rd186 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd185));
  // PTX:1608 add.s64 %rd188, %rd186, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd188) : "l"(rd186), "l"(rd138));
  // PTX:1609 ld.global.f32 %f809, [%rd188]
  f809 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd188) + (0)))));
  // PTX:1610 ld.global.f32 %f810, [%rd184]
  f810 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (0)))));
  // PTX:1611 sub.f32 %f811, %f809, %f810
  asm("sub.f32 %0, %1, %2;" : "=f"(f811) : "f"(f809), "f"(f810));
  // PTX:1612 ld.global.f32 %f812, [%rd188+4]
  f812 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd188) + (4)))));
  // PTX:1613 ld.global.f32 %f813, [%rd184+4]
  f813 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (4)))));
  // PTX:1614 sub.f32 %f814, %f812, %f813
  asm("sub.f32 %0, %1, %2;" : "=f"(f814) : "f"(f812), "f"(f813));
  // PTX:1615 ld.global.f32 %f815, [%rd188+8]
  f815 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd188) + (8)))));
  // PTX:1616 ld.global.f32 %f816, [%rd184+8]
  f816 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (8)))));
  // PTX:1617 sub.f32 %f817, %f815, %f816
  asm("sub.f32 %0, %1, %2;" : "=f"(f817) : "f"(f815), "f"(f816));
  // PTX:1618 mul.wide.s32 %rd189, %r640, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd189) : "r"(r640));
  // PTX:1619 add.s64 %rd190, %rd72, %rd189
  asm("add.s64 %0, %1, %2;" : "=l"(rd190) : "l"(rd72), "l"(rd189));
  // PTX:1620 add.s64 %rd192, %rd72, %rd334
  asm("add.s64 %0, %1, %2;" : "=l"(rd192) : "l"(rd72), "l"(rd334));
  // PTX:1621 ld.global.f32 %f818, [%rd192]
  f818 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd192) + (0)))));
  // PTX:1622 ld.global.f32 %f819, [%rd192+4]
  f819 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd192) + (4)))));
  // PTX:1623 ld.global.f32 %f820, [%rd192+8]
  f820 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd192) + (8)))));
  // PTX:1624 ld.global.f32 %f821, [%rd190]
  f821 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd190) + (0)))));
  // PTX:1625 fma.rn.f32 %f822, %f811, %f818, %f821
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f822) : "f"(f811), "f"(f818), "f"(f821));
  // PTX:1626 ld.global.f32 %f823, [%rd190+4]
  f823 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd190) + (4)))));
  // PTX:1627 fma.rn.f32 %f824, %f811, %f819, %f823
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f824) : "f"(f811), "f"(f819), "f"(f823));
  // PTX:1628 ld.global.f32 %f825, [%rd190+8]
  f825 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd190) + (8)))));
  // PTX:1629 fma.rn.f32 %f826, %f811, %f820, %f825
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f826) : "f"(f811), "f"(f820), "f"(f825));
  // PTX:1630 add.s64 %rd194, %rd72, %rd339
  asm("add.s64 %0, %1, %2;" : "=l"(rd194) : "l"(rd72), "l"(rd339));
  // PTX:1631 ld.global.f32 %f827, [%rd194]
  f827 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd194) + (0)))));
  // PTX:1632 ld.global.f32 %f828, [%rd194+4]
  f828 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd194) + (4)))));
  // PTX:1633 ld.global.f32 %f829, [%rd194+8]
  f829 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd194) + (8)))));
  // PTX:1634 fma.rn.f32 %f830, %f814, %f827, %f822
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f830) : "f"(f814), "f"(f827), "f"(f822));
  // PTX:1635 fma.rn.f32 %f831, %f814, %f828, %f824
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f831) : "f"(f814), "f"(f828), "f"(f824));
  // PTX:1636 fma.rn.f32 %f832, %f814, %f829, %f826
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f832) : "f"(f814), "f"(f829), "f"(f826));
  // PTX:1637 add.s64 %rd196, %rd72, %rd335
  asm("add.s64 %0, %1, %2;" : "=l"(rd196) : "l"(rd72), "l"(rd335));
  // PTX:1638 ld.global.f32 %f833, [%rd196]
  f833 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd196) + (0)))));
  // PTX:1639 ld.global.f32 %f834, [%rd196+4]
  f834 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd196) + (4)))));
  // PTX:1640 ld.global.f32 %f835, [%rd196+8]
  f835 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd196) + (8)))));
  // PTX:1641 fma.rn.f32 %f1144, %f817, %f833, %f830
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1144) : "f"(f817), "f"(f833), "f"(f830));
  // PTX:1642 fma.rn.f32 %f1143, %f817, %f834, %f831
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1143) : "f"(f817), "f"(f834), "f"(f831));
  // PTX:1643 fma.rn.f32 %f1142, %f817, %f835, %f832
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1142) : "f"(f817), "f"(f835), "f"(f832));
  // PTX:1644 bra.uni $L__BB79_118
  goto L_BB79_118;
  // PTX:1646 $L__BB79_117:
L_BB79_117:;
  // PTX:1647 ld.param.u64 %rd197, [%rd2+24]
  rd197 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (24))));
  // PTX:1648 cvta.to.global.u64 %rd198, %rd197
  rd198 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd197));
  // PTX:1649 add.s64 %rd200, %rd198, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd200) : "l"(rd198), "l"(rd138));
  // PTX:1650 ld.global.f32 %f1144, [%rd200]
  f1144 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd200) + (0)))));
  // PTX:1651 ld.global.f32 %f1143, [%rd200+4]
  f1143 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd200) + (4)))));
  // PTX:1652 ld.global.f32 %f1142, [%rd200+8]
  f1142 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd200) + (8)))));
  // PTX:1654 $L__BB79_118:
L_BB79_118:;
  // PTX:1655 setp.lt.s32 %p132, %r641, 0
  p132 = (((int)(r641)) < ((int)(0)));
  // PTX:1656 @%p132 bra $L__BB79_120
  if (p132) { goto L_BB79_120; }
  // PTX:1658 mul.wide.s32 %rd325, %r633, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd325) : "r"(r633));
  // PTX:1659 mul.wide.s32 %rd324, %r634, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd324) : "r"(r634));
  // PTX:1660 mul.wide.s32 %rd323, %r635, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd323) : "r"(r635));
  // PTX:1661 mul.wide.s32 %rd201, %r641, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd201) : "r"(r641));
  // PTX:1662 add.s64 %rd202, %rd73, %rd201
  asm("add.s64 %0, %1, %2;" : "=l"(rd202) : "l"(rd73), "l"(rd201));
  // PTX:1663 ld.param.u64 %rd203, [%rd2+32]
  rd203 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (32))));
  // PTX:1664 cvta.to.global.u64 %rd204, %rd203
  rd204 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd203));
  // PTX:1665 add.s64 %rd206, %rd204, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd206) : "l"(rd204), "l"(rd138));
  // PTX:1666 ld.global.f32 %f836, [%rd206]
  f836 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd206) + (0)))));
  // PTX:1667 ld.global.f32 %f837, [%rd202]
  f837 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (0)))));
  // PTX:1668 sub.f32 %f838, %f836, %f837
  asm("sub.f32 %0, %1, %2;" : "=f"(f838) : "f"(f836), "f"(f837));
  // PTX:1669 ld.global.f32 %f839, [%rd206+4]
  f839 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd206) + (4)))));
  // PTX:1670 ld.global.f32 %f840, [%rd202+4]
  f840 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (4)))));
  // PTX:1671 sub.f32 %f841, %f839, %f840
  asm("sub.f32 %0, %1, %2;" : "=f"(f841) : "f"(f839), "f"(f840));
  // PTX:1672 ld.global.f32 %f842, [%rd206+8]
  f842 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd206) + (8)))));
  // PTX:1673 ld.global.f32 %f843, [%rd202+8]
  f843 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (8)))));
  // PTX:1674 sub.f32 %f844, %f842, %f843
  asm("sub.f32 %0, %1, %2;" : "=f"(f844) : "f"(f842), "f"(f843));
  // PTX:1675 mul.wide.s32 %rd207, %r636, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd207) : "r"(r636));
  // PTX:1676 add.s64 %rd208, %rd72, %rd207
  asm("add.s64 %0, %1, %2;" : "=l"(rd208) : "l"(rd72), "l"(rd207));
  // PTX:1677 add.s64 %rd210, %rd72, %rd323
  asm("add.s64 %0, %1, %2;" : "=l"(rd210) : "l"(rd72), "l"(rd323));
  // PTX:1678 ld.global.f32 %f845, [%rd210]
  f845 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd210) + (0)))));
  // PTX:1679 ld.global.f32 %f846, [%rd210+4]
  f846 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd210) + (4)))));
  // PTX:1680 ld.global.f32 %f847, [%rd210+8]
  f847 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd210) + (8)))));
  // PTX:1681 ld.global.f32 %f848, [%rd208]
  f848 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd208) + (0)))));
  // PTX:1682 fma.rn.f32 %f849, %f838, %f845, %f848
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f849) : "f"(f838), "f"(f845), "f"(f848));
  // PTX:1683 ld.global.f32 %f850, [%rd208+4]
  f850 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd208) + (4)))));
  // PTX:1684 fma.rn.f32 %f851, %f838, %f846, %f850
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f851) : "f"(f838), "f"(f846), "f"(f850));
  // PTX:1685 ld.global.f32 %f852, [%rd208+8]
  f852 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd208) + (8)))));
  // PTX:1686 fma.rn.f32 %f853, %f838, %f847, %f852
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f853) : "f"(f838), "f"(f847), "f"(f852));
  // PTX:1687 add.s64 %rd212, %rd72, %rd324
  asm("add.s64 %0, %1, %2;" : "=l"(rd212) : "l"(rd72), "l"(rd324));
  // PTX:1688 ld.global.f32 %f854, [%rd212]
  f854 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd212) + (0)))));
  // PTX:1689 ld.global.f32 %f855, [%rd212+4]
  f855 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd212) + (4)))));
  // PTX:1690 ld.global.f32 %f856, [%rd212+8]
  f856 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd212) + (8)))));
  // PTX:1691 fma.rn.f32 %f857, %f841, %f854, %f849
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f857) : "f"(f841), "f"(f854), "f"(f849));
  // PTX:1692 fma.rn.f32 %f858, %f841, %f855, %f851
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f858) : "f"(f841), "f"(f855), "f"(f851));
  // PTX:1693 fma.rn.f32 %f859, %f841, %f856, %f853
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f859) : "f"(f841), "f"(f856), "f"(f853));
  // PTX:1694 add.s64 %rd214, %rd72, %rd325
  asm("add.s64 %0, %1, %2;" : "=l"(rd214) : "l"(rd72), "l"(rd325));
  // PTX:1695 ld.global.f32 %f860, [%rd214]
  f860 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd214) + (0)))));
  // PTX:1696 ld.global.f32 %f861, [%rd214+4]
  f861 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd214) + (4)))));
  // PTX:1697 ld.global.f32 %f862, [%rd214+8]
  f862 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd214) + (8)))));
  // PTX:1698 fma.rn.f32 %f1147, %f844, %f860, %f857
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1147) : "f"(f844), "f"(f860), "f"(f857));
  // PTX:1699 fma.rn.f32 %f1146, %f844, %f861, %f858
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1146) : "f"(f844), "f"(f861), "f"(f858));
  // PTX:1700 fma.rn.f32 %f1145, %f844, %f862, %f859
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1145) : "f"(f844), "f"(f862), "f"(f859));
  // PTX:1701 bra.uni $L__BB79_121
  goto L_BB79_121;
  // PTX:1703 $L__BB79_120:
L_BB79_120:;
  // PTX:1704 ld.param.u64 %rd215, [%rd2+32]
  rd215 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (32))));
  // PTX:1705 cvta.to.global.u64 %rd216, %rd215
  rd216 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd215));
  // PTX:1706 add.s64 %rd218, %rd216, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd218) : "l"(rd216), "l"(rd138));
  // PTX:1707 ld.global.f32 %f1147, [%rd218]
  f1147 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd218) + (0)))));
  // PTX:1708 ld.global.f32 %f1146, [%rd218+4]
  f1146 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd218) + (4)))));
  // PTX:1709 ld.global.f32 %f1145, [%rd218+8]
  f1145 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd218) + (8)))));
  // PTX:1711 $L__BB79_121:
L_BB79_121:;
  // PTX:1712 ld.param.u64 %rd219, [%rd2+64]
  rd219 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (64))));
  // PTX:1713 cvta.to.global.u64 %rd220, %rd219
  rd220 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd219));
  // PTX:1714 add.s64 %rd222, %rd220, %rd94
  asm("add.s64 %0, %1, %2;" : "=l"(rd222) : "l"(rd220), "l"(rd94));
  // PTX:1715 ld.param.u64 %rd223, [%rd2+72]
  rd223 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (72))));
  // PTX:1716 cvta.to.global.u64 %rd224, %rd223
  rd224 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd223));
  // PTX:1717 add.s64 %rd225, %rd224, %rd94
  asm("add.s64 %0, %1, %2;" : "=l"(rd225) : "l"(rd224), "l"(rd94));
  // PTX:1718 ld.global.f32 %f863, [%rd225]
  f863 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd225) + (0)))));
  // PTX:1719 ld.global.f32 %f864, [%rd222]
  f864 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd222) + (0)))));
  // PTX:1720 add.f32 %f865, %f864, %f863
  asm("add.f32 %0, %1, %2;" : "=f"(f865) : "f"(f864), "f"(f863));
  // PTX:1721 sub.f32 %f866, %f1147, %f1144
  asm("sub.f32 %0, %1, %2;" : "=f"(f866) : "f"(f1147), "f"(f1144));
  // PTX:1722 sub.f32 %f867, %f1146, %f1143
  asm("sub.f32 %0, %1, %2;" : "=f"(f867) : "f"(f1146), "f"(f1143));
  // PTX:1723 mul.f32 %f868, %f867, %f202
  asm("mul.f32 %0, %1, %2;" : "=f"(f868) : "f"(f867), "f"(f202));
  // PTX:1724 sub.f32 %f869, %f1145, %f1142
  asm("sub.f32 %0, %1, %2;" : "=f"(f869) : "f"(f1145), "f"(f1142));
  // PTX:1725 fma.rn.f32 %f870, %f866, %f201, %f868
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f870) : "f"(f866), "f"(f201), "f"(f868));
  // PTX:1726 fma.rn.f32 %f871, %f869, %f203, %f870
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f871) : "f"(f869), "f"(f203), "f"(f870));
  // PTX:1727 sub.f32 %f1148, %f865, %f871
  asm("sub.f32 %0, %1, %2;" : "=f"(f1148) : "f"(f865), "f"(f871));
  // PTX:1728 mov.pred %p146, 0
  p146 = ((0) != 0);
  // PTX:1730 $L__BB79_122:
L_BB79_122:;
  // PTX:1731 @%p146 bra $L__BB79_135
  if (p146) { goto L_BB79_135; }
  // PTX:1733 mov.u32 %r509, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r509) : "r"(blockDim.x));
  // PTX:1734 mov.u32 %r508, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r508) : "r"(blockIdx.x));
  // PTX:1735 mov.u32 %r507, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r507) : "r"(threadIdx.x));
  // PTX:1736 cvt.u64.u32 %rd328, %r507
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd328) : "r"(r507));
  // PTX:1737 mul.wide.u32 %rd327, %r508, %r509
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd327) : "r"(r508), "r"(r509));
  // PTX:1738 add.s64 %rd326, %rd327, %rd328
  asm("add.s64 %0, %1, %2;" : "=l"(rd326) : "l"(rd327), "l"(rd328));
  // PTX:1739 mov.b32 %f224, %r632
  asm("mov.b32 %0, %1;" : "=f"(f224) : "r"(r632));
  // PTX:1740 ld.param.u64 %rd226, [%rd2+264]
  rd226 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (264))));
  // PTX:1741 cvta.to.global.u64 %rd227, %rd226
  rd227 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd226));
  // PTX:1742 mul.lo.s64 %rd228, %rd326, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd228) : "l"(rd326));
  // PTX:1743 add.s64 %rd229, %rd227, %rd228
  asm("add.s64 %0, %1, %2;" : "=l"(rd229) : "l"(rd227), "l"(rd228));
  // PTX:1744 ld.global.f32 %f225, [%rd229]
  f225 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd229) + (0)))));
  // PTX:1745 ld.global.f32 %f226, [%rd229+4]
  f226 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd229) + (4)))));
  // PTX:1746 mov.b32 %f227, %r631
  asm("mov.b32 %0, %1;" : "=f"(f227) : "r"(r631));
  // PTX:1747 mul.f32 %f872, %f226, %f227
  asm("mul.f32 %0, %1, %2;" : "=f"(f872) : "f"(f226), "f"(f227));
  // PTX:1748 ld.global.f32 %f228, [%rd229+8]
  f228 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd229) + (8)))));
  // PTX:1749 mov.b32 %f229, %r630
  asm("mov.b32 %0, %1;" : "=f"(f229) : "r"(r630));
  // PTX:1750 fma.rn.f32 %f873, %f225, %f224, %f872
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f873) : "f"(f225), "f"(f224), "f"(f872));
  // PTX:1751 fma.rn.f32 %f230, %f228, %f229, %f873
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f230) : "f"(f228), "f"(f229), "f"(f873));
  // PTX:1752 ld.param.u64 %rd230, [%rd2+248]
  rd230 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (248))));
  // PTX:1753 cvta.to.global.u64 %rd231, %rd230
  rd231 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd230));
  // PTX:1754 add.s64 %rd233, %rd231, %rd94
  asm("add.s64 %0, %1, %2;" : "=l"(rd233) : "l"(rd231), "l"(rd94));
  // PTX:1755 ld.param.u64 %rd234, [%rd2+256]
  rd234 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (256))));
  // PTX:1756 cvta.to.global.u64 %rd235, %rd234
  rd235 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd234));
  // PTX:1757 add.s64 %rd236, %rd235, %rd228
  asm("add.s64 %0, %1, %2;" : "=l"(rd236) : "l"(rd235), "l"(rd228));
  // PTX:1758 ld.global.f32 %f231, [%rd236]
  f231 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd236) + (0)))));
  // PTX:1759 ld.global.f32 %f232, [%rd236+4]
  f232 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd236) + (4)))));
  // PTX:1760 mul.f32 %f874, %f232, %f227
  asm("mul.f32 %0, %1, %2;" : "=f"(f874) : "f"(f232), "f"(f227));
  // PTX:1761 ld.global.f32 %f233, [%rd236+8]
  f233 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd236) + (8)))));
  // PTX:1762 fma.rn.f32 %f875, %f231, %f224, %f874
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f875) : "f"(f231), "f"(f224), "f"(f874));
  // PTX:1763 fma.rn.f32 %f234, %f233, %f229, %f875
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f234) : "f"(f233), "f"(f229), "f"(f875));
  // PTX:1764 ld.param.f32 %f876, [%rd2+228]
  f876 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd2) + (228))));
  // PTX:1765 mul.f32 %f877, %f230, %f876
  asm("mul.f32 %0, %1, %2;" : "=f"(f877) : "f"(f230), "f"(f876));
  // PTX:1766 sub.f32 %f878, %f1148, %f877
  asm("sub.f32 %0, %1, %2;" : "=f"(f878) : "f"(f1148), "f"(f877));
  // PTX:1767 setp.lt.f32 %p119, %f1148, 0f00000000
  p119 = (!(isnan(((float)(f1148))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f1148)) < ((float)(as_f32(0x00000000u)))));
  // PTX:1768 mov.f32 %f879, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f879) : );
  // PTX:1769 selp.f32 %f880, %f1148, %f878, %p119
  f880 = p119 ? f1148 : f878;
  // PTX:1770 ld.global.f32 %f235, [%rd233]
  f235 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd233) + (0)))));
  // PTX:1771 fma.rn.f32 %f881, %f235, %f880, %f234
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f881) : "f"(f235), "f"(f880), "f"(f234));
  // PTX:1772 max.f32 %f236, %f881, %f879
  asm("max.f32 %0, %1, %2;" : "=f"(f236) : "f"(f881), "f"(f879));
  // PTX:1773 setp.lt.s32 %p120, %r641, 0
  p120 = (((int)(r641)) < ((int)(0)));
  // PTX:1774 mov.u32 %r643, %r626
  asm("mov.u32 %0, %1;" : "=r"(r643) : "r"(r626));
  // PTX:1775 mov.u32 %r644, %r625
  asm("mov.u32 %0, %1;" : "=r"(r644) : "r"(r625));
  // PTX:1776 mov.u32 %r645, %r624
  asm("mov.u32 %0, %1;" : "=r"(r645) : "r"(r624));
  // PTX:1777 @%p120 bra $L__BB79_125
  if (p120) { goto L_BB79_125; }
  // PTX:1779 ld.param.u64 %rd237, [%rd2+208]
  rd237 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (208))));
  // PTX:1780 cvta.to.global.u64 %rd238, %rd237
  rd238 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd237));
  // PTX:1781 ld.param.u64 %rd239, [%rd2+184]
  rd239 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (184))));
  // PTX:1782 cvta.to.global.u64 %rd240, %rd239
  rd240 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd239));
  // PTX:1783 mul.wide.s32 %rd241, %r641, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd241) : "r"(r641));
  // PTX:1784 add.s64 %rd242, %rd240, %rd241
  asm("add.s64 %0, %1, %2;" : "=l"(rd242) : "l"(rd240), "l"(rd241));
  // PTX:1785 mov.b32 %f882, %r626
  asm("mov.b32 %0, %1;" : "=f"(f882) : "r"(r626));
  // PTX:1786 ld.global.f32 %f883, [%rd242]
  f883 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd242) + (0)))));
  // PTX:1787 sub.f32 %f884, %f882, %f883
  asm("sub.f32 %0, %1, %2;" : "=f"(f884) : "f"(f882), "f"(f883));
  // PTX:1788 mov.b32 %f885, %r625
  asm("mov.b32 %0, %1;" : "=f"(f885) : "r"(r625));
  // PTX:1789 ld.global.f32 %f886, [%rd242+4]
  f886 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd242) + (4)))));
  // PTX:1790 sub.f32 %f887, %f885, %f886
  asm("sub.f32 %0, %1, %2;" : "=f"(f887) : "f"(f885), "f"(f886));
  // PTX:1791 mov.b32 %f888, %r624
  asm("mov.b32 %0, %1;" : "=f"(f888) : "r"(r624));
  // PTX:1792 ld.global.f32 %f889, [%rd242+8]
  f889 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd242) + (8)))));
  // PTX:1793 sub.f32 %f890, %f888, %f889
  asm("sub.f32 %0, %1, %2;" : "=f"(f890) : "f"(f888), "f"(f889));
  // PTX:1794 mul.wide.s32 %rd243, %r636, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd243) : "r"(r636));
  // PTX:1795 add.s64 %rd244, %rd238, %rd243
  asm("add.s64 %0, %1, %2;" : "=l"(rd244) : "l"(rd238), "l"(rd243));
  // PTX:1796 mul.wide.s32 %rd245, %r635, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd245) : "r"(r635));
  // PTX:1797 add.s64 %rd246, %rd238, %rd245
  asm("add.s64 %0, %1, %2;" : "=l"(rd246) : "l"(rd238), "l"(rd245));
  // PTX:1798 ld.global.f32 %f891, [%rd246]
  f891 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd246) + (0)))));
  // PTX:1799 ld.global.f32 %f892, [%rd246+4]
  f892 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd246) + (4)))));
  // PTX:1800 ld.global.f32 %f893, [%rd246+8]
  f893 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd246) + (8)))));
  // PTX:1801 ld.global.f32 %f894, [%rd244]
  f894 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd244) + (0)))));
  // PTX:1802 fma.rn.f32 %f895, %f884, %f891, %f894
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f895) : "f"(f884), "f"(f891), "f"(f894));
  // PTX:1803 ld.global.f32 %f896, [%rd244+4]
  f896 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd244) + (4)))));
  // PTX:1804 fma.rn.f32 %f897, %f884, %f892, %f896
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f897) : "f"(f884), "f"(f892), "f"(f896));
  // PTX:1805 ld.global.f32 %f898, [%rd244+8]
  f898 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd244) + (8)))));
  // PTX:1806 fma.rn.f32 %f899, %f884, %f893, %f898
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f899) : "f"(f884), "f"(f893), "f"(f898));
  // PTX:1807 mul.wide.s32 %rd247, %r634, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd247) : "r"(r634));
  // PTX:1808 add.s64 %rd248, %rd238, %rd247
  asm("add.s64 %0, %1, %2;" : "=l"(rd248) : "l"(rd238), "l"(rd247));
  // PTX:1809 ld.global.f32 %f900, [%rd248]
  f900 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd248) + (0)))));
  // PTX:1810 ld.global.f32 %f901, [%rd248+4]
  f901 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd248) + (4)))));
  // PTX:1811 ld.global.f32 %f902, [%rd248+8]
  f902 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd248) + (8)))));
  // PTX:1812 fma.rn.f32 %f903, %f887, %f900, %f895
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f903) : "f"(f887), "f"(f900), "f"(f895));
  // PTX:1813 fma.rn.f32 %f904, %f887, %f901, %f897
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f904) : "f"(f887), "f"(f901), "f"(f897));
  // PTX:1814 fma.rn.f32 %f905, %f887, %f902, %f899
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f905) : "f"(f887), "f"(f902), "f"(f899));
  // PTX:1815 mul.wide.s32 %rd249, %r633, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd249) : "r"(r633));
  // PTX:1816 add.s64 %rd250, %rd238, %rd249
  asm("add.s64 %0, %1, %2;" : "=l"(rd250) : "l"(rd238), "l"(rd249));
  // PTX:1817 ld.global.f32 %f906, [%rd250]
  f906 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd250) + (0)))));
  // PTX:1818 ld.global.f32 %f907, [%rd250+4]
  f907 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd250) + (4)))));
  // PTX:1819 ld.global.f32 %f908, [%rd250+8]
  f908 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd250) + (8)))));
  // PTX:1820 fma.rn.f32 %f909, %f890, %f906, %f903
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f909) : "f"(f890), "f"(f906), "f"(f903));
  // PTX:1821 fma.rn.f32 %f910, %f890, %f907, %f904
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f910) : "f"(f890), "f"(f907), "f"(f904));
  // PTX:1822 fma.rn.f32 %f911, %f890, %f908, %f905
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f911) : "f"(f890), "f"(f908), "f"(f905));
  // PTX:1823 mov.b32 %r645, %f911
  asm("mov.b32 %0, %1;" : "=r"(r645) : "f"(f911));
  // PTX:1824 mov.b32 %r644, %f910
  asm("mov.b32 %0, %1;" : "=r"(r644) : "f"(f910));
  // PTX:1825 mov.b32 %r643, %f909
  asm("mov.b32 %0, %1;" : "=r"(r643) : "f"(f909));
  // PTX:1827 $L__BB79_125:
L_BB79_125:;
  // PTX:1828 @%p120 bra $L__BB79_127
  if (p120) { goto L_BB79_127; }
  // PTX:1830 ld.param.u64 %rd251, [%rd2+216]
  rd251 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (216))));
  // PTX:1831 cvta.to.global.u64 %rd252, %rd251
  rd252 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd251));
  // PTX:1832 ld.param.u64 %rd253, [%rd2+184]
  rd253 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (184))));
  // PTX:1833 cvta.to.global.u64 %rd254, %rd253
  rd254 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd253));
  // PTX:1834 mul.wide.s32 %rd255, %r641, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd255) : "r"(r641));
  // PTX:1835 add.s64 %rd256, %rd254, %rd255
  asm("add.s64 %0, %1, %2;" : "=l"(rd256) : "l"(rd254), "l"(rd255));
  // PTX:1836 mov.b32 %f912, %r626
  asm("mov.b32 %0, %1;" : "=f"(f912) : "r"(r626));
  // PTX:1837 ld.global.f32 %f913, [%rd256]
  f913 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (0)))));
  // PTX:1838 sub.f32 %f914, %f912, %f913
  asm("sub.f32 %0, %1, %2;" : "=f"(f914) : "f"(f912), "f"(f913));
  // PTX:1839 mov.b32 %f915, %r625
  asm("mov.b32 %0, %1;" : "=f"(f915) : "r"(r625));
  // PTX:1840 ld.global.f32 %f916, [%rd256+4]
  f916 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (4)))));
  // PTX:1841 sub.f32 %f917, %f915, %f916
  asm("sub.f32 %0, %1, %2;" : "=f"(f917) : "f"(f915), "f"(f916));
  // PTX:1842 mov.b32 %f918, %r624
  asm("mov.b32 %0, %1;" : "=f"(f918) : "r"(r624));
  // PTX:1843 ld.global.f32 %f919, [%rd256+8]
  f919 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (8)))));
  // PTX:1844 sub.f32 %f920, %f918, %f919
  asm("sub.f32 %0, %1, %2;" : "=f"(f920) : "f"(f918), "f"(f919));
  // PTX:1845 mul.wide.s32 %rd257, %r636, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd257) : "r"(r636));
  // PTX:1846 add.s64 %rd258, %rd252, %rd257
  asm("add.s64 %0, %1, %2;" : "=l"(rd258) : "l"(rd252), "l"(rd257));
  // PTX:1847 mul.wide.s32 %rd259, %r635, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd259) : "r"(r635));
  // PTX:1848 add.s64 %rd260, %rd252, %rd259
  asm("add.s64 %0, %1, %2;" : "=l"(rd260) : "l"(rd252), "l"(rd259));
  // PTX:1849 ld.global.f32 %f921, [%rd260]
  f921 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd260) + (0)))));
  // PTX:1850 ld.global.f32 %f922, [%rd260+4]
  f922 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd260) + (4)))));
  // PTX:1851 ld.global.f32 %f923, [%rd260+8]
  f923 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd260) + (8)))));
  // PTX:1852 ld.global.f32 %f924, [%rd258]
  f924 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd258) + (0)))));
  // PTX:1853 fma.rn.f32 %f925, %f914, %f921, %f924
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f925) : "f"(f914), "f"(f921), "f"(f924));
  // PTX:1854 ld.global.f32 %f926, [%rd258+4]
  f926 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd258) + (4)))));
  // PTX:1855 fma.rn.f32 %f927, %f914, %f922, %f926
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f927) : "f"(f914), "f"(f922), "f"(f926));
  // PTX:1856 ld.global.f32 %f928, [%rd258+8]
  f928 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd258) + (8)))));
  // PTX:1857 fma.rn.f32 %f929, %f914, %f923, %f928
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f929) : "f"(f914), "f"(f923), "f"(f928));
  // PTX:1858 mul.wide.s32 %rd261, %r634, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd261) : "r"(r634));
  // PTX:1859 add.s64 %rd262, %rd252, %rd261
  asm("add.s64 %0, %1, %2;" : "=l"(rd262) : "l"(rd252), "l"(rd261));
  // PTX:1860 ld.global.f32 %f930, [%rd262]
  f930 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd262) + (0)))));
  // PTX:1861 ld.global.f32 %f931, [%rd262+4]
  f931 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd262) + (4)))));
  // PTX:1862 ld.global.f32 %f932, [%rd262+8]
  f932 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd262) + (8)))));
  // PTX:1863 fma.rn.f32 %f933, %f917, %f930, %f925
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f933) : "f"(f917), "f"(f930), "f"(f925));
  // PTX:1864 fma.rn.f32 %f934, %f917, %f931, %f927
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f934) : "f"(f917), "f"(f931), "f"(f927));
  // PTX:1865 fma.rn.f32 %f935, %f917, %f932, %f929
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f935) : "f"(f917), "f"(f932), "f"(f929));
  // PTX:1866 mul.wide.s32 %rd263, %r633, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd263) : "r"(r633));
  // PTX:1867 add.s64 %rd264, %rd252, %rd263
  asm("add.s64 %0, %1, %2;" : "=l"(rd264) : "l"(rd252), "l"(rd263));
  // PTX:1868 ld.global.f32 %f936, [%rd264]
  f936 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd264) + (0)))));
  // PTX:1869 ld.global.f32 %f937, [%rd264+4]
  f937 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd264) + (4)))));
  // PTX:1870 ld.global.f32 %f938, [%rd264+8]
  f938 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd264) + (8)))));
  // PTX:1871 fma.rn.f32 %f939, %f920, %f936, %f933
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f939) : "f"(f920), "f"(f936), "f"(f933));
  // PTX:1872 fma.rn.f32 %f940, %f920, %f937, %f934
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f940) : "f"(f920), "f"(f937), "f"(f934));
  // PTX:1873 fma.rn.f32 %f941, %f920, %f938, %f935
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f941) : "f"(f920), "f"(f938), "f"(f935));
  // PTX:1874 mov.b32 %r624, %f941
  asm("mov.b32 %0, %1;" : "=r"(r624) : "f"(f941));
  // PTX:1875 mov.b32 %r625, %f940
  asm("mov.b32 %0, %1;" : "=r"(r625) : "f"(f940));
  // PTX:1876 mov.b32 %r626, %f939
  asm("mov.b32 %0, %1;" : "=r"(r626) : "f"(f939));
  // PTX:1878 $L__BB79_127:
L_BB79_127:;
  // PTX:1879 setp.lt.s32 %p122, %r642, 0
  p122 = (((int)(r642)) < ((int)(0)));
  // PTX:1880 mov.u32 %r649, %r629
  asm("mov.u32 %0, %1;" : "=r"(r649) : "r"(r629));
  // PTX:1881 mov.u32 %r650, %r628
  asm("mov.u32 %0, %1;" : "=r"(r650) : "r"(r628));
  // PTX:1882 mov.u32 %r651, %r627
  asm("mov.u32 %0, %1;" : "=r"(r651) : "r"(r627));
  // PTX:1883 @%p122 bra $L__BB79_129
  if (p122) { goto L_BB79_129; }
  // PTX:1885 ld.param.u64 %rd265, [%rd2+208]
  rd265 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (208))));
  // PTX:1886 cvta.to.global.u64 %rd266, %rd265
  rd266 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd265));
  // PTX:1887 ld.param.u64 %rd267, [%rd2+184]
  rd267 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (184))));
  // PTX:1888 cvta.to.global.u64 %rd268, %rd267
  rd268 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd267));
  // PTX:1889 mul.wide.s32 %rd269, %r642, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd269) : "r"(r642));
  // PTX:1890 add.s64 %rd270, %rd268, %rd269
  asm("add.s64 %0, %1, %2;" : "=l"(rd270) : "l"(rd268), "l"(rd269));
  // PTX:1891 mov.b32 %f942, %r629
  asm("mov.b32 %0, %1;" : "=f"(f942) : "r"(r629));
  // PTX:1892 ld.global.f32 %f943, [%rd270]
  f943 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd270) + (0)))));
  // PTX:1893 sub.f32 %f944, %f942, %f943
  asm("sub.f32 %0, %1, %2;" : "=f"(f944) : "f"(f942), "f"(f943));
  // PTX:1894 mov.b32 %f945, %r628
  asm("mov.b32 %0, %1;" : "=f"(f945) : "r"(r628));
  // PTX:1895 ld.global.f32 %f946, [%rd270+4]
  f946 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd270) + (4)))));
  // PTX:1896 sub.f32 %f947, %f945, %f946
  asm("sub.f32 %0, %1, %2;" : "=f"(f947) : "f"(f945), "f"(f946));
  // PTX:1897 mov.b32 %f948, %r627
  asm("mov.b32 %0, %1;" : "=f"(f948) : "r"(r627));
  // PTX:1898 ld.global.f32 %f949, [%rd270+8]
  f949 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd270) + (8)))));
  // PTX:1899 sub.f32 %f950, %f948, %f949
  asm("sub.f32 %0, %1, %2;" : "=f"(f950) : "f"(f948), "f"(f949));
  // PTX:1900 mul.wide.s32 %rd271, %r640, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd271) : "r"(r640));
  // PTX:1901 add.s64 %rd272, %rd266, %rd271
  asm("add.s64 %0, %1, %2;" : "=l"(rd272) : "l"(rd266), "l"(rd271));
  // PTX:1902 mul.wide.s32 %rd273, %r639, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd273) : "r"(r639));
  // PTX:1903 add.s64 %rd274, %rd266, %rd273
  asm("add.s64 %0, %1, %2;" : "=l"(rd274) : "l"(rd266), "l"(rd273));
  // PTX:1904 ld.global.f32 %f951, [%rd274]
  f951 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd274) + (0)))));
  // PTX:1905 ld.global.f32 %f952, [%rd274+4]
  f952 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd274) + (4)))));
  // PTX:1906 ld.global.f32 %f953, [%rd274+8]
  f953 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd274) + (8)))));
  // PTX:1907 ld.global.f32 %f954, [%rd272]
  f954 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd272) + (0)))));
  // PTX:1908 fma.rn.f32 %f955, %f944, %f951, %f954
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f955) : "f"(f944), "f"(f951), "f"(f954));
  // PTX:1909 ld.global.f32 %f956, [%rd272+4]
  f956 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd272) + (4)))));
  // PTX:1910 fma.rn.f32 %f957, %f944, %f952, %f956
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f957) : "f"(f944), "f"(f952), "f"(f956));
  // PTX:1911 ld.global.f32 %f958, [%rd272+8]
  f958 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd272) + (8)))));
  // PTX:1912 fma.rn.f32 %f959, %f944, %f953, %f958
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f959) : "f"(f944), "f"(f953), "f"(f958));
  // PTX:1913 mul.wide.s32 %rd275, %r638, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd275) : "r"(r638));
  // PTX:1914 add.s64 %rd276, %rd266, %rd275
  asm("add.s64 %0, %1, %2;" : "=l"(rd276) : "l"(rd266), "l"(rd275));
  // PTX:1915 ld.global.f32 %f960, [%rd276]
  f960 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd276) + (0)))));
  // PTX:1916 ld.global.f32 %f961, [%rd276+4]
  f961 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd276) + (4)))));
  // PTX:1917 ld.global.f32 %f962, [%rd276+8]
  f962 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd276) + (8)))));
  // PTX:1918 fma.rn.f32 %f963, %f947, %f960, %f955
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f963) : "f"(f947), "f"(f960), "f"(f955));
  // PTX:1919 fma.rn.f32 %f964, %f947, %f961, %f957
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f964) : "f"(f947), "f"(f961), "f"(f957));
  // PTX:1920 fma.rn.f32 %f965, %f947, %f962, %f959
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f965) : "f"(f947), "f"(f962), "f"(f959));
  // PTX:1921 mul.wide.s32 %rd277, %r637, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd277) : "r"(r637));
  // PTX:1922 add.s64 %rd278, %rd266, %rd277
  asm("add.s64 %0, %1, %2;" : "=l"(rd278) : "l"(rd266), "l"(rd277));
  // PTX:1923 ld.global.f32 %f966, [%rd278]
  f966 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd278) + (0)))));
  // PTX:1924 ld.global.f32 %f967, [%rd278+4]
  f967 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd278) + (4)))));
  // PTX:1925 ld.global.f32 %f968, [%rd278+8]
  f968 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd278) + (8)))));
  // PTX:1926 fma.rn.f32 %f969, %f950, %f966, %f963
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f969) : "f"(f950), "f"(f966), "f"(f963));
  // PTX:1927 fma.rn.f32 %f970, %f950, %f967, %f964
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f970) : "f"(f950), "f"(f967), "f"(f964));
  // PTX:1928 fma.rn.f32 %f971, %f950, %f968, %f965
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f971) : "f"(f950), "f"(f968), "f"(f965));
  // PTX:1929 mov.b32 %r651, %f971
  asm("mov.b32 %0, %1;" : "=r"(r651) : "f"(f971));
  // PTX:1930 mov.b32 %r650, %f970
  asm("mov.b32 %0, %1;" : "=r"(r650) : "f"(f970));
  // PTX:1931 mov.b32 %r649, %f969
  asm("mov.b32 %0, %1;" : "=r"(r649) : "f"(f969));
  // PTX:1933 $L__BB79_129:
L_BB79_129:;
  // PTX:1934 mov.b32 %f972, %r649
  asm("mov.b32 %0, %1;" : "=f"(f972) : "r"(r649));
  // PTX:1935 mov.b32 %f973, %r643
  asm("mov.b32 %0, %1;" : "=f"(f973) : "r"(r643));
  // PTX:1936 mov.b32 %f974, %r626
  asm("mov.b32 %0, %1;" : "=f"(f974) : "r"(r626));
  // PTX:1937 sub.f32 %f975, %f973, %f974
  asm("sub.f32 %0, %1, %2;" : "=f"(f975) : "f"(f973), "f"(f974));
  // PTX:1938 sub.f32 %f237, %f975, %f972
  asm("sub.f32 %0, %1, %2;" : "=f"(f237) : "f"(f975), "f"(f972));
  // PTX:1939 mov.b32 %f976, %r650
  asm("mov.b32 %0, %1;" : "=f"(f976) : "r"(r650));
  // PTX:1940 mov.b32 %f977, %r644
  asm("mov.b32 %0, %1;" : "=f"(f977) : "r"(r644));
  // PTX:1941 mov.b32 %f978, %r625
  asm("mov.b32 %0, %1;" : "=f"(f978) : "r"(r625));
  // PTX:1942 sub.f32 %f979, %f977, %f978
  asm("sub.f32 %0, %1, %2;" : "=f"(f979) : "f"(f977), "f"(f978));
  // PTX:1943 sub.f32 %f238, %f979, %f976
  asm("sub.f32 %0, %1, %2;" : "=f"(f238) : "f"(f979), "f"(f976));
  // PTX:1944 mov.b32 %f980, %r651
  asm("mov.b32 %0, %1;" : "=f"(f980) : "r"(r651));
  // PTX:1945 mov.b32 %f981, %r645
  asm("mov.b32 %0, %1;" : "=f"(f981) : "r"(r645));
  // PTX:1946 mov.b32 %f982, %r624
  asm("mov.b32 %0, %1;" : "=f"(f982) : "r"(r624));
  // PTX:1947 sub.f32 %f983, %f981, %f982
  asm("sub.f32 %0, %1, %2;" : "=f"(f983) : "f"(f981), "f"(f982));
  // PTX:1948 sub.f32 %f239, %f983, %f980
  asm("sub.f32 %0, %1, %2;" : "=f"(f239) : "f"(f983), "f"(f980));
  // PTX:1949 @%p122 bra $L__BB79_131
  if (p122) { goto L_BB79_131; }
  // PTX:1951 ld.param.u64 %rd279, [%rd2+216]
  rd279 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (216))));
  // PTX:1952 cvta.to.global.u64 %rd280, %rd279
  rd280 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd279));
  // PTX:1953 ld.param.u64 %rd281, [%rd2+184]
  rd281 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (184))));
  // PTX:1954 cvta.to.global.u64 %rd282, %rd281
  rd282 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd281));
  // PTX:1955 mul.wide.s32 %rd283, %r642, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd283) : "r"(r642));
  // PTX:1956 add.s64 %rd284, %rd282, %rd283
  asm("add.s64 %0, %1, %2;" : "=l"(rd284) : "l"(rd282), "l"(rd283));
  // PTX:1957 mov.b32 %f984, %r629
  asm("mov.b32 %0, %1;" : "=f"(f984) : "r"(r629));
  // PTX:1958 ld.global.f32 %f985, [%rd284]
  f985 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd284) + (0)))));
  // PTX:1959 sub.f32 %f986, %f984, %f985
  asm("sub.f32 %0, %1, %2;" : "=f"(f986) : "f"(f984), "f"(f985));
  // PTX:1960 mov.b32 %f987, %r628
  asm("mov.b32 %0, %1;" : "=f"(f987) : "r"(r628));
  // PTX:1961 ld.global.f32 %f988, [%rd284+4]
  f988 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd284) + (4)))));
  // PTX:1962 sub.f32 %f989, %f987, %f988
  asm("sub.f32 %0, %1, %2;" : "=f"(f989) : "f"(f987), "f"(f988));
  // PTX:1963 mov.b32 %f990, %r627
  asm("mov.b32 %0, %1;" : "=f"(f990) : "r"(r627));
  // PTX:1964 ld.global.f32 %f991, [%rd284+8]
  f991 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd284) + (8)))));
  // PTX:1965 sub.f32 %f992, %f990, %f991
  asm("sub.f32 %0, %1, %2;" : "=f"(f992) : "f"(f990), "f"(f991));
  // PTX:1966 mul.wide.s32 %rd285, %r640, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd285) : "r"(r640));
  // PTX:1967 add.s64 %rd286, %rd280, %rd285
  asm("add.s64 %0, %1, %2;" : "=l"(rd286) : "l"(rd280), "l"(rd285));
  // PTX:1968 mul.wide.s32 %rd287, %r639, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd287) : "r"(r639));
  // PTX:1969 add.s64 %rd288, %rd280, %rd287
  asm("add.s64 %0, %1, %2;" : "=l"(rd288) : "l"(rd280), "l"(rd287));
  // PTX:1970 ld.global.f32 %f993, [%rd288]
  f993 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd288) + (0)))));
  // PTX:1971 ld.global.f32 %f994, [%rd288+4]
  f994 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd288) + (4)))));
  // PTX:1972 ld.global.f32 %f995, [%rd288+8]
  f995 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd288) + (8)))));
  // PTX:1973 ld.global.f32 %f996, [%rd286]
  f996 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd286) + (0)))));
  // PTX:1974 fma.rn.f32 %f997, %f986, %f993, %f996
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f997) : "f"(f986), "f"(f993), "f"(f996));
  // PTX:1975 ld.global.f32 %f998, [%rd286+4]
  f998 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd286) + (4)))));
  // PTX:1976 fma.rn.f32 %f999, %f986, %f994, %f998
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f999) : "f"(f986), "f"(f994), "f"(f998));
  // PTX:1977 ld.global.f32 %f1000, [%rd286+8]
  f1000 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd286) + (8)))));
  // PTX:1978 fma.rn.f32 %f1001, %f986, %f995, %f1000
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1001) : "f"(f986), "f"(f995), "f"(f1000));
  // PTX:1979 mul.wide.s32 %rd289, %r638, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd289) : "r"(r638));
  // PTX:1980 add.s64 %rd290, %rd280, %rd289
  asm("add.s64 %0, %1, %2;" : "=l"(rd290) : "l"(rd280), "l"(rd289));
  // PTX:1981 ld.global.f32 %f1002, [%rd290]
  f1002 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd290) + (0)))));
  // PTX:1982 ld.global.f32 %f1003, [%rd290+4]
  f1003 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd290) + (4)))));
  // PTX:1983 ld.global.f32 %f1004, [%rd290+8]
  f1004 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd290) + (8)))));
  // PTX:1984 fma.rn.f32 %f1005, %f989, %f1002, %f997
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1005) : "f"(f989), "f"(f1002), "f"(f997));
  // PTX:1985 fma.rn.f32 %f1006, %f989, %f1003, %f999
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1006) : "f"(f989), "f"(f1003), "f"(f999));
  // PTX:1986 fma.rn.f32 %f1007, %f989, %f1004, %f1001
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1007) : "f"(f989), "f"(f1004), "f"(f1001));
  // PTX:1987 mul.wide.s32 %rd291, %r637, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd291) : "r"(r637));
  // PTX:1988 add.s64 %rd292, %rd280, %rd291
  asm("add.s64 %0, %1, %2;" : "=l"(rd292) : "l"(rd280), "l"(rd291));
  // PTX:1989 ld.global.f32 %f1008, [%rd292]
  f1008 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd292) + (0)))));
  // PTX:1990 ld.global.f32 %f1009, [%rd292+4]
  f1009 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd292) + (4)))));
  // PTX:1991 ld.global.f32 %f1010, [%rd292+8]
  f1010 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd292) + (8)))));
  // PTX:1992 fma.rn.f32 %f1011, %f992, %f1008, %f1005
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1011) : "f"(f992), "f"(f1008), "f"(f1005));
  // PTX:1993 fma.rn.f32 %f1012, %f992, %f1009, %f1006
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1012) : "f"(f992), "f"(f1009), "f"(f1006));
  // PTX:1994 fma.rn.f32 %f1013, %f992, %f1010, %f1007
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1013) : "f"(f992), "f"(f1010), "f"(f1007));
  // PTX:1995 mov.b32 %r627, %f1013
  asm("mov.b32 %0, %1;" : "=r"(r627) : "f"(f1013));
  // PTX:1996 mov.b32 %r628, %f1012
  asm("mov.b32 %0, %1;" : "=r"(r628) : "f"(f1012));
  // PTX:1997 mov.b32 %r629, %f1011
  asm("mov.b32 %0, %1;" : "=r"(r629) : "f"(f1011));
  // PTX:1999 $L__BB79_131:
L_BB79_131:;
  // PTX:2000 mov.b32 %f1014, %r629
  asm("mov.b32 %0, %1;" : "=f"(f1014) : "r"(r629));
  // PTX:2001 add.f32 %f1015, %f237, %f1014
  asm("add.f32 %0, %1, %2;" : "=f"(f1015) : "f"(f237), "f"(f1014));
  // PTX:2002 mov.b32 %f1016, %r628
  asm("mov.b32 %0, %1;" : "=f"(f1016) : "r"(r628));
  // PTX:2003 add.f32 %f1017, %f238, %f1016
  asm("add.f32 %0, %1, %2;" : "=f"(f1017) : "f"(f238), "f"(f1016));
  // PTX:2004 mov.b32 %f1018, %r627
  asm("mov.b32 %0, %1;" : "=f"(f1018) : "r"(r627));
  // PTX:2005 add.f32 %f1019, %f239, %f1018
  asm("add.f32 %0, %1, %2;" : "=f"(f1019) : "f"(f239), "f"(f1018));
  // PTX:2006 mul.f32 %f1020, %f1017, %f227
  asm("mul.f32 %0, %1, %2;" : "=f"(f1020) : "f"(f1017), "f"(f227));
  // PTX:2007 fma.rn.f32 %f1021, %f1015, %f224, %f1020
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1021) : "f"(f1015), "f"(f224), "f"(f1020));
  // PTX:2008 fma.rn.f32 %f1022, %f1019, %f229, %f1021
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1022) : "f"(f1019), "f"(f229), "f"(f1021));
  // PTX:2009 mul.f32 %f1023, %f1022, %f224
  asm("mul.f32 %0, %1, %2;" : "=f"(f1023) : "f"(f1022), "f"(f224));
  // PTX:2010 mul.f32 %f1024, %f1022, %f227
  asm("mul.f32 %0, %1, %2;" : "=f"(f1024) : "f"(f1022), "f"(f227));
  // PTX:2011 mul.f32 %f1025, %f1022, %f229
  asm("mul.f32 %0, %1, %2;" : "=f"(f1025) : "f"(f1022), "f"(f229));
  // PTX:2012 sub.f32 %f1026, %f1023, %f1015
  asm("sub.f32 %0, %1, %2;" : "=f"(f1026) : "f"(f1023), "f"(f1015));
  // PTX:2013 sub.f32 %f1027, %f1024, %f1017
  asm("sub.f32 %0, %1, %2;" : "=f"(f1027) : "f"(f1024), "f"(f1017));
  // PTX:2014 sub.f32 %f1028, %f1025, %f1019
  asm("sub.f32 %0, %1, %2;" : "=f"(f1028) : "f"(f1025), "f"(f1019));
  // PTX:2015 ld.param.f32 %f1029, [%rd2+228]
  f1029 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd2) + (228))));
  // PTX:2016 mov.f32 %f1030, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f1030) : );
  // PTX:2017 sub.f32 %f1031, %f1030, %f1029
  asm("sub.f32 %0, %1, %2;" : "=f"(f1031) : "f"(f1030), "f"(f1029));
  // PTX:2018 mul.f32 %f1032, %f230, %f224
  asm("mul.f32 %0, %1, %2;" : "=f"(f1032) : "f"(f230), "f"(f224));
  // PTX:2019 sub.f32 %f1033, %f225, %f1032
  asm("sub.f32 %0, %1, %2;" : "=f"(f1033) : "f"(f225), "f"(f1032));
  // PTX:2020 mul.f32 %f1034, %f230, %f227
  asm("mul.f32 %0, %1, %2;" : "=f"(f1034) : "f"(f230), "f"(f227));
  // PTX:2021 sub.f32 %f1035, %f226, %f1034
  asm("sub.f32 %0, %1, %2;" : "=f"(f1035) : "f"(f226), "f"(f1034));
  // PTX:2022 mul.f32 %f1036, %f230, %f229
  asm("mul.f32 %0, %1, %2;" : "=f"(f1036) : "f"(f230), "f"(f229));
  // PTX:2023 sub.f32 %f1037, %f228, %f1036
  asm("sub.f32 %0, %1, %2;" : "=f"(f1037) : "f"(f228), "f"(f1036));
  // PTX:2024 fma.rn.f32 %f1038, %f1033, %f1031, %f1026
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1038) : "f"(f1033), "f"(f1031), "f"(f1026));
  // PTX:2025 fma.rn.f32 %f1039, %f1035, %f1031, %f1027
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1039) : "f"(f1035), "f"(f1031), "f"(f1027));
  // PTX:2026 fma.rn.f32 %f1040, %f1037, %f1031, %f1028
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1040) : "f"(f1037), "f"(f1031), "f"(f1028));
  // PTX:2027 mul.f32 %f1041, %f234, %f224
  asm("mul.f32 %0, %1, %2;" : "=f"(f1041) : "f"(f234), "f"(f224));
  // PTX:2028 sub.f32 %f1042, %f231, %f1041
  asm("sub.f32 %0, %1, %2;" : "=f"(f1042) : "f"(f231), "f"(f1041));
  // PTX:2029 mul.f32 %f1043, %f234, %f227
  asm("mul.f32 %0, %1, %2;" : "=f"(f1043) : "f"(f234), "f"(f227));
  // PTX:2030 sub.f32 %f1044, %f232, %f1043
  asm("sub.f32 %0, %1, %2;" : "=f"(f1044) : "f"(f232), "f"(f1043));
  // PTX:2031 mul.f32 %f1045, %f234, %f229
  asm("mul.f32 %0, %1, %2;" : "=f"(f1045) : "f"(f234), "f"(f229));
  // PTX:2032 sub.f32 %f1046, %f233, %f1045
  asm("sub.f32 %0, %1, %2;" : "=f"(f1046) : "f"(f233), "f"(f1045));
  // PTX:2033 fma.rn.f32 %f1151, %f235, %f1038, %f1042
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1151) : "f"(f235), "f"(f1038), "f"(f1042));
  // PTX:2034 fma.rn.f32 %f1150, %f235, %f1039, %f1044
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1150) : "f"(f235), "f"(f1039), "f"(f1044));
  // PTX:2035 fma.rn.f32 %f1149, %f235, %f1040, %f1046
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1149) : "f"(f235), "f"(f1040), "f"(f1046));
  // PTX:2036 mul.f32 %f1047, %f1150, %f1150
  asm("mul.f32 %0, %1, %2;" : "=f"(f1047) : "f"(f1150), "f"(f1150));
  // PTX:2037 fma.rn.f32 %f1048, %f1151, %f1151, %f1047
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1048) : "f"(f1151), "f"(f1151), "f"(f1047));
  // PTX:2038 fma.rn.f32 %f1049, %f1149, %f1149, %f1048
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1049) : "f"(f1149), "f"(f1149), "f"(f1048));
  // PTX:2039 sqrt.rn.f32 %f243, %f1049
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f243) : "f"(f1049));
  // PTX:2040 ld.param.u64 %rd293, [%rd2+136]
  rd293 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (136))));
  // PTX:2041 cvta.to.global.u64 %rd294, %rd293
  rd294 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd293));
  // PTX:2042 shl.b64 %rd295, %rd436, 32
  asm("shl.b64 %0, %1, 32;" : "=l"(rd295) : "l"(rd436));
  // PTX:2043 cvt.s64.s32 %rd77, %rd436
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd77) : "l"(rd436));
  // PTX:2044 shr.s64 %rd296, %rd295, 30
  asm("shr.s64 %0, %1, 30;" : "=l"(rd296) : "l"(rd295));
  // PTX:2045 add.s64 %rd297, %rd294, %rd296
  asm("add.s64 %0, %1, %2;" : "=l"(rd297) : "l"(rd294), "l"(rd296));
  // PTX:2046 shl.b64 %rd298, %rd435, 32
  asm("shl.b64 %0, %1, 32;" : "=l"(rd298) : "l"(rd435));
  // PTX:2047 cvt.s64.s32 %rd78, %rd435
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd78) : "l"(rd435));
  // PTX:2048 shr.s64 %rd299, %rd298, 30
  asm("shr.s64 %0, %1, 30;" : "=l"(rd299) : "l"(rd298));
  // PTX:2049 add.s64 %rd300, %rd294, %rd299
  asm("add.s64 %0, %1, %2;" : "=l"(rd300) : "l"(rd294), "l"(rd299));
  // PTX:2050 ld.global.f32 %f1050, [%rd300]
  f1050 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd300) + (0)))));
  // PTX:2051 ld.global.f32 %f1051, [%rd297]
  f1051 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd297) + (0)))));
  // PTX:2052 mul.f32 %f1052, %f1051, %f1050
  asm("mul.f32 %0, %1, %2;" : "=f"(f1052) : "f"(f1051), "f"(f1050));
  // PTX:2053 mov.f32 %f1053, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1053) : );
  // PTX:2054 max.f32 %f1054, %f1052, %f1053
  asm("max.f32 %0, %1, %2;" : "=f"(f1054) : "f"(f1052), "f"(f1053));
  // PTX:2055 sqrt.rn.f32 %f1055, %f1054
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f1055) : "f"(f1054));
  // PTX:2056 mul.f32 %f244, %f236, %f1055
  asm("mul.f32 %0, %1, %2;" : "=f"(f244) : "f"(f236), "f"(f1055));
  // PTX:2057 setp.leu.f32 %p124, %f243, %f244
  p124 = ((isnan(((float)(f243))) || isnan(((float)(f244)))) || (((float)(f243)) <= ((float)(f244))));
  // PTX:2058 setp.leu.f32 %p125, %f243, 0f00000000
  p125 = ((isnan(((float)(f243))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f243)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:2059 or.pred %p126, %p125, %p124
  p126 = ((p125) || (p124));
  // PTX:2060 @%p126 bra $L__BB79_133
  if (p126) { goto L_BB79_133; }
  // PTX:2062 div.rn.f32 %f1056, %f244, %f243
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f1056) : "f"(f244), "f"(f243));
  // PTX:2063 mul.f32 %f1151, %f1056, %f1151
  asm("mul.f32 %0, %1, %2;" : "=f"(f1151) : "f"(f1056), "f"(f1151));
  // PTX:2064 mul.f32 %f1150, %f1056, %f1150
  asm("mul.f32 %0, %1, %2;" : "=f"(f1150) : "f"(f1056), "f"(f1150));
  // PTX:2065 mul.f32 %f1149, %f1056, %f1149
  asm("mul.f32 %0, %1, %2;" : "=f"(f1149) : "f"(f1056), "f"(f1149));
  // PTX:2067 $L__BB79_133:
L_BB79_133:;
  // PTX:2068 fma.rn.f32 %f1057, %f236, %f224, %f1151
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1057) : "f"(f236), "f"(f224), "f"(f1151));
  // PTX:2069 fma.rn.f32 %f1058, %f236, %f227, %f1150
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1058) : "f"(f236), "f"(f227), "f"(f1150));
  // PTX:2070 fma.rn.f32 %f1059, %f236, %f229, %f1149
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1059) : "f"(f236), "f"(f229), "f"(f1149));
  // PTX:2071 ld.param.u64 %rd301, [%rd2+256]
  rd301 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (256))));
  // PTX:2072 cvta.to.global.u64 %rd302, %rd301
  rd302 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd301));
  // PTX:2073 add.s64 %rd304, %rd302, %rd228
  asm("add.s64 %0, %1, %2;" : "=l"(rd304) : "l"(rd302), "l"(rd228));
  // PTX:2074 st.global.f32 [%rd304], %f1057
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd304) + (0))))) = (float)(f1057);
  // PTX:2075 st.global.f32 [%rd304+4], %f1058
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd304) + (4))))) = (float)(f1058);
  // PTX:2076 st.global.f32 [%rd304+8], %f1059
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd304) + (8))))) = (float)(f1059);
  // PTX:2077 setp.leu.f32 %p127, %f1148, 0f00000000
  p127 = ((isnan(((float)(f1148))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f1148)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:2078 @%p127 bra $L__BB79_135
  if (p127) { goto L_BB79_135; }
  // PTX:2080 ld.param.u64 %rd305, [%rd2+120]
  rd305 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (120))));
  // PTX:2081 cvta.to.global.u64 %rd306, %rd305
  rd306 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd305));
  // PTX:2082 shl.b64 %rd307, %rd77, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd307) : "l"(rd77));
  // PTX:2083 add.s64 %rd308, %rd306, %rd307
  asm("add.s64 %0, %1, %2;" : "=l"(rd308) : "l"(rd306), "l"(rd307));
  // PTX:2084 shl.b64 %rd309, %rd78, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd309) : "l"(rd78));
  // PTX:2085 add.s64 %rd310, %rd306, %rd309
  asm("add.s64 %0, %1, %2;" : "=l"(rd310) : "l"(rd306), "l"(rd309));
  // PTX:2086 ld.global.f32 %f1060, [%rd310]
  f1060 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd310) + (0)))));
  // PTX:2087 ld.global.f32 %f1061, [%rd308]
  f1061 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd308) + (0)))));
  // PTX:2088 add.f32 %f1062, %f1061, %f1060
  asm("add.f32 %0, %1, %2;" : "=f"(f1062) : "f"(f1061), "f"(f1060));
  // PTX:2089 mul.f32 %f1063, %f1062, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1063) : "f"(f1062));
  // PTX:2090 ld.param.f32 %f1064, [%rd2+232]
  f1064 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd2) + (232))));
  // PTX:2091 fma.rn.f32 %f1065, %f1064, %f1148, %f235
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1065) : "f"(f1064), "f"(f1148), "f"(f235));
  // PTX:2092 min.f32 %f1066, %f1063, %f1065
  asm("min.f32 %0, %1, %2;" : "=f"(f1066) : "f"(f1063), "f"(f1065));
  // PTX:2093 ld.param.u64 %rd311, [%rd2+248]
  rd311 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (248))));
  // PTX:2094 cvta.to.global.u64 %rd312, %rd311
  rd312 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd311));
  // PTX:2095 add.s64 %rd314, %rd312, %rd94
  asm("add.s64 %0, %1, %2;" : "=l"(rd314) : "l"(rd312), "l"(rd94));
  // PTX:2096 st.global.f32 [%rd314], %f1066
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd314) + (0))))) = (float)(f1066);
  // PTX:2098 $L__BB79_135:
L_BB79_135:;
  // PTX:2099 ret
  return;
}
