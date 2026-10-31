// 机械还原自 PTX：synreal::kernel::multiply_soft_contact_hessian_off_diagonal(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, float const*, float const*, float const*, unsigned long, unsigned long, unsigned long, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float, unsigned long, float, float, unsigned long, int const*, unsigned long, float const*, float const*, float, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*)
// PTX SHA256: 0d5023824061bc3d5334742eae4cd8fd457a85eff55f4480edcd57a790f8ab81
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__multiply_soft_contact_hessian_off_diagonal(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned long long param14, unsigned long long param15, unsigned long long param16, unsigned long long param17, unsigned long long param18, unsigned long long param19, unsigned long long param20, unsigned long long param21, unsigned long long param22, unsigned long long param23, unsigned long long param24, unsigned long long param25, float param26, unsigned long long param27, float param28, float param29, unsigned long long param30, unsigned long long param31, unsigned long long param32, unsigned long long param33, unsigned long long param34, float param35, float param36, unsigned long long param37, unsigned long long param38) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62, p63, p64, p65, p66, p67, p68, p69, p70, p71, p72, p73, p74, p75, p76, p77, p78, p79, p80, p81, p82, p83, p84, p85, p86, p87, p88, p89, p90, p91, p92, p93, p94, p95, p96, p97, p98, p99, p100, p101, p102, p103, p104, p105;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503, f504, f505, f506, f507, f508, f509, f510, f511, f512, f513, f514, f515, f516, f517, f518, f519, f520, f521, f522, f523, f524, f525, f526, f527, f528, f529, f530, f531, f532, f533, f534, f535, f536, f537, f538, f539, f540, f541, f542, f543, f544, f545, f546, f547, f548, f549, f550, f551, f552, f553, f554, f555, f556, f557, f558, f559, f560, f561, f562, f563, f564, f565, f566, f567, f568, f569, f570, f571, f572, f573, f574, f575, f576, f577, f578, f579, f580, f581, f582, f583, f584, f585, f586, f587, f588, f589, f590, f591, f592, f593, f594, f595, f596, f597, f598, f599, f600, f601, f602, f603, f604, f605, f606, f607, f608, f609, f610, f611, f612, f613, f614, f615, f616, f617, f618, f619, f620, f621, f622, f623, f624, f625, f626, f627, f628, f629, f630, f631, f632, f633, f634, f635, f636, f637, f638, f639, f640, f641, f642, f643, f644, f645, f646, f647, f648, f649, f650, f651, f652, f653, f654, f655, f656, f657, f658, f659, f660, f661, f662, f663, f664, f665, f666, f667, f668, f669, f670, f671, f672, f673, f674, f675, f676, f677, f678, f679, f680, f681, f682, f683, f684, f685, f686, f687, f688, f689, f690, f691, f692, f693, f694, f695, f696, f697, f698, f699, f700, f701, f702, f703, f704, f705, f706, f707, f708, f709, f710, f711, f712, f713, f714, f715, f716, f717, f718, f719, f720, f721, f722, f723, f724, f725, f726, f727, f728, f729, f730, f731, f732, f733, f734, f735, f736, f737, f738, f739, f740, f741, f742, f743, f744, f745, f746, f747, f748, f749, f750, f751, f752, f753, f754, f755, f756, f757, f758, f759, f760, f761, f762, f763, f764, f765, f766, f767, f768, f769, f770, f771, f772, f773, f774, f775, f776, f777, f778, f779, f780, f781, f782, f783, f784, f785, f786, f787, f788, f789, f790, f791, f792, f793, f794, f795, f796, f797, f798, f799, f800, f801, f802, f803, f804, f805, f806, f807, f808, f809, f810, f811, f812, f813, f814, f815, f816, f817, f818, f819, f820, f821, f822, f823, f824, f825, f826, f827, f828, f829, f830, f831, f832, f833, f834, f835, f836, f837, f838, f839, f840, f841, f842, f843, f844, f845, f846, f847, f848, f849, f850, f851, f852, f853, f854, f855, f856, f857, f858, f859, f860, f861, f862, f863, f864, f865, f866, f867, f868, f869, f870, f871, f872, f873, f874, f875, f876, f877, f878, f879, f880, f881, f882, f883, f884, f885, f886, f887, f888, f889, f890, f891, f892, f893, f894, f895, f896, f897, f898, f899, f900, f901, f902, f903, f904, f905, f906, f907, f908, f909, f910, f911, f912, f913, f914, f915, f916, f917, f918, f919, f920, f921, f922, f923, f924, f925, f926, f927, f928, f929, f930, f931, f932, f933, f934, f935, f936, f937, f938, f939, f940, f941, f942, f943, f944, f945, f946, f947, f948, f949, f950, f951, f952, f953, f954, f955, f956, f957, f958, f959, f960, f961, f962, f963, f964, f965, f966, f967, f968, f969, f970, f971, f972, f973, f974, f975, f976, f977, f978, f979, f980, f981, f982, f983, f984, f985, f986, f987, f988, f989, f990, f991, f992, f993, f994, f995, f996, f997, f998, f999, f1000, f1001, f1002, f1003, f1004, f1005, f1006, f1007, f1008, f1009, f1010, f1011, f1012, f1013, f1014, f1015, f1016, f1017, f1018, f1019, f1020, f1021, f1022, f1023, f1024, f1025, f1026, f1027, f1028, f1029, f1030, f1031, f1032, f1033, f1034, f1035, f1036, f1037, f1038, f1039, f1040, f1041, f1042, f1043, f1044, f1045, f1046, f1047, f1048, f1049, f1050, f1051, f1052, f1053, f1054, f1055, f1056, f1057, f1058, f1059, f1060, f1061, f1062, f1063, f1064, f1065, f1066, f1067, f1068, f1069, f1070, f1071, f1072, f1073, f1074, f1075, f1076, f1077, f1078, f1079, f1080, f1081, f1082, f1083, f1084, f1085, f1086, f1087, f1088, f1089, f1090, f1091, f1092, f1093, f1094, f1095, f1096, f1097, f1098, f1099, f1100, f1101, f1102, f1103, f1104, f1105, f1106, f1107, f1108, f1109, f1110, f1111, f1112, f1113, f1114, f1115, f1116, f1117, f1118, f1119, f1120, f1121, f1122, f1123, f1124, f1125, f1126, f1127, f1128, f1129, f1130, f1131, f1132, f1133, f1134, f1135, f1136, f1137, f1138, f1139, f1140, f1141, f1142, f1143, f1144, f1145, f1146, f1147, f1148, f1149, f1150, f1151, f1152, f1153, f1154, f1155, f1156, f1157, f1158, f1159, f1160, f1161, f1162, f1163, f1164, f1165, f1166, f1167, f1168, f1169, f1170, f1171, f1172, f1173, f1174, f1175, f1176, f1177, f1178, f1179, f1180, f1181, f1182, f1183, f1184, f1185, f1186, f1187, f1188, f1189, f1190, f1191, f1192, f1193, f1194, f1195, f1196, f1197, f1198, f1199, f1200, f1201, f1202, f1203, f1204, f1205, f1206, f1207, f1208, f1209, f1210, f1211, f1212, f1213, f1214, f1215, f1216, f1217, f1218, f1219, f1220, f1221, f1222, f1223, f1224, f1225, f1226, f1227, f1228, f1229, f1230, f1231, f1232, f1233, f1234, f1235, f1236, f1237, f1238, f1239, f1240, f1241, f1242, f1243, f1244, f1245, f1246, f1247, f1248, f1249, f1250, f1251, f1252, f1253, f1254, f1255, f1256, f1257, f1258, f1259, f1260, f1261, f1262, f1263, f1264, f1265, f1266, f1267, f1268, f1269, f1270, f1271, f1272, f1273, f1274, f1275, f1276, f1277, f1278, f1279, f1280, f1281, f1282, f1283, f1284, f1285, f1286, f1287, f1288, f1289, f1290, f1291, f1292, f1293, f1294, f1295, f1296, f1297, f1298, f1299, f1300, f1301, f1302, f1303, f1304, f1305, f1306, f1307, f1308, f1309, f1310, f1311, f1312, f1313, f1314, f1315, f1316, f1317, f1318, f1319, f1320, f1321, f1322, f1323, f1324, f1325, f1326, f1327, f1328, f1329, f1330, f1331, f1332, f1333, f1334, f1335, f1336, f1337, f1338, f1339, f1340, f1341, f1342, f1343, f1344, f1345, f1346, f1347, f1348, f1349, f1350, f1351, f1352, f1353, f1354, f1355, f1356, f1357, f1358, f1359, f1360, f1361, f1362, f1363, f1364, f1365, f1366, f1367, f1368, f1369, f1370, f1371, f1372, f1373, f1374, f1375, f1376, f1377, f1378, f1379, f1380, f1381, f1382, f1383, f1384, f1385, f1386, f1387, f1388, f1389, f1390, f1391, f1392, f1393, f1394, f1395, f1396;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146, r147, r148, r149, r150, r151, r152, r153, r154, r155, r156, r157, r158, r159, r160, r161, r162, r163, r164, r165, r166, r167, r168, r169, r170, r171, r172, r173, r174, r175, r176, r177, r178, r179, r180, r181, r182, r183, r184, r185, r186, r187, r188, r189, r190, r191, r192, r193, r194, r195, r196, r197, r198, r199, r200, r201, r202, r203, r204, r205, r206, r207, r208, r209, r210, r211, r212, r213, r214, r215, r216, r217, r218, r219, r220, r221, r222, r223, r224, r225, r226, r227, r228, r229, r230, r231, r232, r233, r234, r235, r236, r237, r238, r239, r240, r241, r242, r243, r244, r245, r246, r247, r248, r249, r250, r251, r252, r253, r254, r255, r256, r257;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162, rd163, rd164, rd165, rd166, rd167, rd168, rd169, rd170, rd171, rd172, rd173, rd174, rd175, rd176, rd177, rd178, rd179, rd180, rd181, rd182, rd183, rd184, rd185, rd186, rd187, rd188, rd189, rd190, rd191, rd192, rd193, rd194, rd195, rd196, rd197, rd198, rd199, rd200, rd201, rd202, rd203, rd204, rd205, rd206, rd207, rd208, rd209, rd210, rd211, rd212, rd213, rd214, rd215, rd216, rd217, rd218, rd219, rd220, rd221, rd222, rd223, rd224, rd225, rd226, rd227, rd228, rd229, rd230, rd231, rd232, rd233, rd234, rd235, rd236, rd237, rd238, rd239, rd240, rd241, rd242, rd243, rd244, rd245, rd246, rd247, rd248, rd249, rd250, rd251, rd252, rd253, rd254, rd255, rd256, rd257, rd258, rd259, rd260, rd261, rd262, rd263, rd264, rd265, rd266, rd267, rd268, rd269, rd270, rd271, rd272, rd273, rd274, rd275, rd276, rd277, rd278, rd279, rd280, rd281, rd282, rd283, rd284, rd285, rd286, rd287, rd288;
  // PTX:55 ld.param.u64 %rd62, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_0]
  rd62 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:56 ld.param.u64 %rd63, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_1]
  rd63 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:57 ld.param.u64 %rd64, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_2]
  rd64 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:58 ld.param.u64 %rd65, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_3]
  rd65 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:59 ld.param.u64 %rd66, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_4]
  rd66 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:60 ld.param.u64 %rd67, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_5]
  rd67 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:61 ld.param.u64 %rd68, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_6]
  rd68 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:62 ld.param.u64 %rd69, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_7]
  rd69 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:63 ld.param.u64 %rd70, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_8]
  rd70 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:64 ld.param.u64 %rd71, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_9]
  rd71 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:65 ld.param.u64 %rd72, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_10]
  rd72 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:66 ld.param.u64 %rd73, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_11]
  rd73 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:67 ld.param.u64 %rd74, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_12]
  rd74 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:68 ld.param.u64 %rd75, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_13]
  rd75 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:69 ld.param.u64 %rd76, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_14]
  rd76 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:70 ld.param.u64 %rd77, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_15]
  rd77 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:71 ld.param.u64 %rd79, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_17]
  rd79 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param17 + (0))));
  // PTX:72 ld.param.u64 %rd81, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_19]
  rd81 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param19 + (0))));
  // PTX:73 ld.param.u64 %rd82, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_20]
  rd82 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param20 + (0))));
  // PTX:74 ld.param.u64 %rd83, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_21]
  rd83 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param21 + (0))));
  // PTX:75 ld.param.u64 %rd84, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_22]
  rd84 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param22 + (0))));
  // PTX:76 ld.param.f32 %f488, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_26]
  f488 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param26 + (0))));
  // PTX:77 ld.param.u64 %rd88, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_27]
  rd88 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param27 + (0))));
  // PTX:78 ld.param.u64 %rd90, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_31]
  rd90 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param31 + (0))));
  // PTX:79 ld.param.u64 %rd92, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_33]
  rd92 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param33 + (0))));
  // PTX:80 ld.param.u64 %rd93, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_34]
  rd93 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param34 + (0))));
  // PTX:81 ld.param.u64 %rd94, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_37]
  rd94 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param37 + (0))));
  // PTX:82 setp.eq.s64 %p1, %rd88, 0
  p1 = (((long long)(rd88)) == ((long long)(0)));
  // PTX:83 @%p1 bra $L__BB1_159
  if (p1) { goto L_BB1_159; }
  // PTX:85 setp.eq.s64 %p2, %rd62, 0
  p2 = (((long long)(rd62)) == ((long long)(0)));
  // PTX:86 mov.u64 %rd278, 0
  asm("mov.u64 %0, 0;" : "=l"(rd278) : );
  // PTX:87 @%p2 bra $L__BB1_3
  if (p2) { goto L_BB1_3; }
  // PTX:89 cvta.to.global.u64 %rd97, %rd62
  rd97 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd62));
  // PTX:90 ld.global.u32 %r104, [%rd97]
  r104 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd97) + (0)))));
  // PTX:91 max.s32 %r105, %r104, 0
  asm("max.s32 %0, %1, 0;" : "=r"(r105) : "r"(r104));
  // PTX:92 cvt.s64.s32 %rd278, %r105
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd278) : "r"(r105));
  // PTX:94 $L__BB1_3:
L_BB1_3:;
  // PTX:95 min.u64 %rd3, %rd278, %rd63
  asm("min.u64 %0, %1, %2;" : "=l"(rd3) : "l"(rd278), "l"(rd63));
  // PTX:96 mov.u32 %r106, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r106) : "r"(blockIdx.x));
  // PTX:97 mov.u32 %r107, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r107) : "r"(blockDim.x));
  // PTX:98 mul.wide.u32 %rd98, %r106, %r107
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd98) : "r"(r106), "r"(r107));
  // PTX:99 mov.u32 %r108, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r108) : "r"(threadIdx.x));
  // PTX:100 cvt.u64.u32 %rd99, %r108
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd99) : "r"(r108));
  // PTX:101 add.s64 %rd279, %rd98, %rd99
  asm("add.s64 %0, %1, %2;" : "=l"(rd279) : "l"(rd98), "l"(rd99));
  // PTX:102 setp.ge.u64 %p3, %rd279, %rd3
  p3 = (((unsigned long long)(rd279)) >= ((unsigned long long)(rd3)));
  // PTX:103 @%p3 bra $L__BB1_159
  if (p3) { goto L_BB1_159; }
  // PTX:105 cvta.to.global.u64 %rd100, %rd64
  rd100 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd64));
  // PTX:106 cvta.to.global.u64 %rd103, %rd65
  rd103 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd65));
  // PTX:107 cvt.u32.u64 %r112, %rd88
  asm("cvt.u32.u64 %0, %1;" : "=r"(r112) : "l"(rd88));
  // PTX:108 cvta.to.global.u64 %rd107, %rd73
  rd107 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd73));
  // PTX:109 cvta.to.global.u64 %rd123, %rd69
  rd123 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd69));
  // PTX:110 cvta.to.global.u64 %rd134, %rd82
  rd134 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd82));
  // PTX:111 cvta.to.global.u64 %rd137, %rd70
  rd137 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd70));
  // PTX:112 cvta.to.global.u64 %rd140, %rd66
  rd140 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd66));
  // PTX:113 cvta.to.global.u64 %rd142, %rd71
  rd142 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd71));
  // PTX:114 cvta.to.global.u64 %rd144, %rd83
  rd144 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd83));
  // PTX:115 cvta.to.global.u64 %rd155, %rd67
  rd155 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd67));
  // PTX:116 cvta.to.global.u64 %rd160, %rd72
  rd160 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd72));
  // PTX:117 cvta.to.global.u64 %rd162, %rd68
  rd162 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd68));
  // PTX:118 cvta.to.global.u64 %rd165, %rd75
  rd165 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd75));
  // PTX:119 cvta.to.global.u64 %rd168, %rd76
  rd168 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd76));
  // PTX:120 cvta.to.global.u64 %rd171, %rd77
  rd171 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd77));
  // PTX:121 cvta.to.global.u64 %rd173, %rd94
  rd173 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd94));
  // PTX:122 cvta.to.global.u64 %rd185, %rd93
  rd185 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd93));
  // PTX:123 cvta.to.global.u64 %rd188, %rd92
  rd188 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd92));
  // PTX:125 $L__BB1_5:
L_BB1_5:;
  // PTX:126 ld.param.u64 %rd239, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_30]
  rd239 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param30 + (0))));
  // PTX:127 shl.b64 %rd101, %rd279, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd101) : "l"(rd279));
  // PTX:128 add.s64 %rd102, %rd100, %rd101
  asm("add.s64 %0, %1, %2;" : "=l"(rd102) : "l"(rd100), "l"(rd101));
  // PTX:129 add.s64 %rd104, %rd103, %rd101
  asm("add.s64 %0, %1, %2;" : "=l"(rd104) : "l"(rd103), "l"(rd101));
  // PTX:130 ld.global.u32 %r109, [%rd104]
  r109 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (0)))));
  // PTX:131 cvt.s64.s32 %rd6, %r109
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd6) : "r"(r109));
  // PTX:132 ld.global.u32 %r110, [%rd102]
  r110 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))));
  // PTX:133 cvt.s64.s32 %rd7, %r110
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd7) : "r"(r110));
  // PTX:134 setp.ge.u64 %p4, %rd7, %rd239
  p4 = (((unsigned long long)(rd7)) >= ((unsigned long long)(rd239)));
  // PTX:135 or.b32 %r111, %r109, %r110
  asm("or.b32 %0, %1, %2;" : "=r"(r111) : "r"(r109), "r"(r110));
  // PTX:136 setp.lt.s32 %p5, %r111, 0
  p5 = (((int)(r111)) < ((int)(0)));
  // PTX:137 or.pred %p6, %p4, %p5
  p6 = ((p4) || (p5));
  // PTX:138 @%p6 bra $L__BB1_158
  if (p6) { goto L_BB1_158; }
  // PTX:140 or.b64 %rd105, %rd7, %rd88
  asm("or.b64 %0, %1, %2;" : "=l"(rd105) : "l"(rd7), "l"(rd88));
  // PTX:141 and.b64 %rd106, %rd105, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd106) : "l"(rd105));
  // PTX:142 setp.eq.s64 %p7, %rd106, 0
  p7 = (((long long)(rd106)) == ((long long)(0)));
  // PTX:143 @%p7 bra $L__BB1_8
  if (p7) { goto L_BB1_8; }
  // PTX:145 rem.u64 %rd280, %rd7, %rd88
  asm("rem.u64 %0, %1, %2;" : "=l"(rd280) : "l"(rd7), "l"(rd88));
  // PTX:146 bra.uni $L__BB1_9
  goto L_BB1_9;
  // PTX:148 $L__BB1_8:
L_BB1_8:;
  // PTX:149 cvt.u32.u64 %r113, %rd7
  asm("cvt.u32.u64 %0, %1;" : "=r"(r113) : "l"(rd7));
  // PTX:150 rem.u32 %r114, %r113, %r112
  asm("rem.u32 %0, %1, %2;" : "=r"(r114) : "r"(r113), "r"(r112));
  // PTX:151 cvt.u64.u32 %rd280, %r114
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd280) : "r"(r114));
  // PTX:153 $L__BB1_9:
L_BB1_9:;
  // PTX:154 shl.b64 %rd108, %rd280, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd108) : "l"(rd280));
  // PTX:155 add.s64 %rd109, %rd107, %rd108
  asm("add.s64 %0, %1, %2;" : "=l"(rd109) : "l"(rd107), "l"(rd108));
  // PTX:156 ld.global.f32 %f1, [%rd109]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd109) + (0)))));
  // PTX:157 setp.leu.f32 %p8, %f1, 0f00000000
  p8 = ((isnan(((float)(f1))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f1)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:158 @%p8 bra $L__BB1_158
  if (p8) { goto L_BB1_158; }
  // PTX:160 setp.eq.s64 %p9, %rd74, 0
  p9 = (((long long)(rd74)) == ((long long)(0)));
  // PTX:161 @%p9 bra $L__BB1_12
  if (p9) { goto L_BB1_12; }
  // PTX:163 cvta.to.global.u64 %rd110, %rd74
  rd110 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd74));
  // PTX:164 add.s64 %rd112, %rd110, %rd108
  asm("add.s64 %0, %1, %2;" : "=l"(rd112) : "l"(rd110), "l"(rd108));
  // PTX:165 ld.global.u32 %r115, [%rd112]
  r115 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (0)))));
  // PTX:166 setp.ne.s32 %p10, %r115, 0
  p10 = (((int)(r115)) != ((int)(0)));
  // PTX:167 @%p10 bra $L__BB1_158
  if (p10) { goto L_BB1_158; }
  // PTX:169 $L__BB1_12:
L_BB1_12:;
  // PTX:170 setp.eq.s64 %p11, %rd90, 0
  p11 = (((long long)(rd90)) == ((long long)(0)));
  // PTX:171 @%p11 bra $L__BB1_15
  if (p11) { goto L_BB1_15; }
  // PTX:173 ld.param.u64 %rd240, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_32]
  rd240 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param32 + (0))));
  // PTX:174 setp.ge.u64 %p12, %rd6, %rd240
  p12 = (((unsigned long long)(rd6)) >= ((unsigned long long)(rd240)));
  // PTX:175 @%p12 bra $L__BB1_158
  if (p12) { goto L_BB1_158; }
  // PTX:177 cvt.u32.u64 %r116, %rd6
  asm("cvt.u32.u64 %0, %1;" : "=r"(r116) : "l"(rd6));
  // PTX:178 cvta.to.global.u64 %rd113, %rd90
  rd113 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd90));
  // PTX:179 shl.b64 %rd114, %rd6, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd114) : "l"(rd6));
  // PTX:180 add.s64 %rd115, %rd113, %rd114
  asm("add.s64 %0, %1, %2;" : "=l"(rd115) : "l"(rd113), "l"(rd114));
  // PTX:181 ld.global.u32 %r117, [%rd115]
  r117 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd115) + (0)))));
  // PTX:182 setp.eq.s32 %p13, %r117, 0
  p13 = (((int)(r117)) == ((int)(0)));
  // PTX:183 setp.lt.s32 %p14, %r116, 0
  p14 = (((int)(r116)) < ((int)(0)));
  // PTX:184 or.pred %p15, %p14, %p13
  p15 = ((p14) || (p13));
  // PTX:185 @%p15 bra $L__BB1_158
  if (p15) { goto L_BB1_158; }
  // PTX:186 bra.uni $L__BB1_16
  goto L_BB1_16;
  // PTX:188 $L__BB1_15:
L_BB1_15:;
  // PTX:189 cvt.u32.u64 %r118, %rd6
  asm("cvt.u32.u64 %0, %1;" : "=r"(r118) : "l"(rd6));
  // PTX:190 setp.lt.s32 %p16, %r118, 0
  p16 = (((int)(r118)) < ((int)(0)));
  // PTX:191 @%p16 bra $L__BB1_158
  if (p16) { goto L_BB1_158; }
  // PTX:193 $L__BB1_16:
L_BB1_16:;
  // PTX:194 ld.param.u64 %rd241, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_18]
  rd241 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param18 + (0))));
  // PTX:195 mul.lo.s64 %rd116, %rd241, %rd79
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd116) : "l"(rd241), "l"(rd79));
  // PTX:196 setp.gt.u64 %p17, %rd116, %rd6
  p17 = (((unsigned long long)(rd116)) > ((unsigned long long)(rd6)));
  // PTX:197 @%p17 bra $L__BB1_18
  if (p17) { goto L_BB1_18; }
  // PTX:198 bra.uni $L__BB1_17
  goto L_BB1_17;
  // PTX:200 $L__BB1_18:
L_BB1_18:;
  // PTX:201 or.b64 %rd119, %rd6, %rd79
  asm("or.b64 %0, %1, %2;" : "=l"(rd119) : "l"(rd6), "l"(rd79));
  // PTX:202 and.b64 %rd120, %rd119, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd120) : "l"(rd119));
  // PTX:203 setp.eq.s64 %p19, %rd120, 0
  p19 = (((long long)(rd120)) == ((long long)(0)));
  // PTX:204 @%p19 bra $L__BB1_20
  if (p19) { goto L_BB1_20; }
  // PTX:206 div.u64 %rd281, %rd6, %rd79
  asm("div.u64 %0, %1, %2;" : "=l"(rd281) : "l"(rd6), "l"(rd79));
  // PTX:207 mul.lo.s64 %rd121, %rd281, %rd79
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd121) : "l"(rd281), "l"(rd79));
  // PTX:208 sub.s64 %rd283, %rd6, %rd121
  asm("sub.s64 %0, %1, %2;" : "=l"(rd283) : "l"(rd6), "l"(rd121));
  // PTX:209 bra.uni $L__BB1_21
  goto L_BB1_21;
  // PTX:211 $L__BB1_17:
L_BB1_17:;
  // PTX:212 ld.param.u64 %rd242, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_16]
  rd242 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param16 + (0))));
  // PTX:213 sub.s64 %rd118, %rd6, %rd116
  asm("sub.s64 %0, %1, %2;" : "=l"(rd118) : "l"(rd6), "l"(rd116));
  // PTX:214 add.s64 %rd283, %rd118, %rd79
  asm("add.s64 %0, %1, %2;" : "=l"(rd283) : "l"(rd118), "l"(rd79));
  // PTX:215 setp.lt.u64 %p18, %rd283, %rd242
  p18 = (((unsigned long long)(rd283)) < ((unsigned long long)(rd242)));
  // PTX:216 mov.u32 %r216, -1
  asm("mov.u32 %0, -1;" : "=r"(r216) : );
  // PTX:217 @%p18 bra $L__BB1_22
  if (p18) { goto L_BB1_22; }
  // PTX:218 bra.uni $L__BB1_158
  goto L_BB1_158;
  // PTX:220 $L__BB1_20:
L_BB1_20:;
  // PTX:221 cvt.u32.u64 %r214, %rd79
  asm("cvt.u32.u64 %0, %1;" : "=r"(r214) : "l"(rd79));
  // PTX:222 cvt.u32.u64 %r121, %rd6
  asm("cvt.u32.u64 %0, %1;" : "=r"(r121) : "l"(rd6));
  // PTX:223 div.u32 %r122, %r121, %r214
  asm("div.u32 %0, %1, %2;" : "=r"(r122) : "r"(r121), "r"(r214));
  // PTX:224 mul.lo.s32 %r123, %r122, %r214
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r123) : "r"(r122), "r"(r214));
  // PTX:225 sub.s32 %r124, %r121, %r123
  asm("sub.s32 %0, %1, %2;" : "=r"(r124) : "r"(r121), "r"(r123));
  // PTX:226 cvt.u64.u32 %rd281, %r122
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd281) : "r"(r122));
  // PTX:227 cvt.u64.u32 %rd283, %r124
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd283) : "r"(r124));
  // PTX:229 $L__BB1_21:
L_BB1_21:;
  // PTX:230 cvt.u32.u64 %r216, %rd281
  asm("cvt.u32.u64 %0, %1;" : "=r"(r216) : "l"(rd281));
  // PTX:232 $L__BB1_22:
L_BB1_22:;
  // PTX:233 shl.b64 %rd122, %rd283, 32
  asm("shl.b64 %0, %1, 32;" : "=l"(rd122) : "l"(rd283));
  // PTX:234 cvt.s64.s32 %rd20, %rd283
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd20) : "l"(rd283));
  // PTX:235 shr.s64 %rd124, %rd122, 30
  asm("shr.s64 %0, %1, 30;" : "=l"(rd124) : "l"(rd122));
  // PTX:236 add.s64 %rd125, %rd123, %rd124
  asm("add.s64 %0, %1, %2;" : "=l"(rd125) : "l"(rd123), "l"(rd124));
  // PTX:237 ld.global.s32 %rd21, [%rd125]
  rd21 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd125) + (0)))));
  // PTX:238 setp.lt.s64 %p20, %rd21, 0
  p20 = (((long long)(rd21)) < ((long long)(0)));
  // PTX:239 mov.u32 %r125, -1
  asm("mov.u32 %0, -1;" : "=r"(r125) : );
  // PTX:240 mov.u32 %r217, %r125
  asm("mov.u32 %0, %1;" : "=r"(r217) : "r"(r125));
  // PTX:241 @%p20 bra $L__BB1_30
  if (p20) { goto L_BB1_30; }
  // PTX:243 setp.lt.u64 %p21, %rd21, %rd84
  p21 = (((unsigned long long)(rd21)) < ((unsigned long long)(rd84)));
  // PTX:244 @%p21 bra $L__BB1_25
  if (p21) { goto L_BB1_25; }
  // PTX:245 bra.uni $L__BB1_24
  goto L_BB1_24;
  // PTX:247 $L__BB1_25:
L_BB1_25:;
  // PTX:248 cvt.u32.u64 %r127, %rd21
  asm("cvt.u32.u64 %0, %1;" : "=r"(r127) : "l"(rd21));
  // PTX:249 cvta.to.global.u64 %rd126, %rd81
  rd126 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd81));
  // PTX:250 shl.b64 %rd127, %rd21, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd127) : "l"(rd21));
  // PTX:251 add.s64 %rd128, %rd126, %rd127
  asm("add.s64 %0, %1, %2;" : "=l"(rd128) : "l"(rd126), "l"(rd127));
  // PTX:252 ld.global.u32 %r128, [%rd128]
  r128 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (0)))));
  // PTX:253 setp.eq.s32 %p23, %r128, %r127
  p23 = (((int)(r128)) == ((int)(r127)));
  // PTX:254 setp.eq.s64 %p24, %rd84, 0
  p24 = (((long long)(rd84)) == ((long long)(0)));
  // PTX:255 or.pred %p25, %p23, %p24
  p25 = ((p23) || (p24));
  // PTX:256 selp.b32 %r217, %r127, -1, %p23
  r217 = p23 ? r127 : -1;
  // PTX:257 @%p25 bra $L__BB1_30
  if (p25) { goto L_BB1_30; }
  // PTX:258 bra.uni $L__BB1_26
  goto L_BB1_26;
  // PTX:260 $L__BB1_24:
L_BB1_24:;
  // PTX:261 setp.eq.s64 %p22, %rd84, 0
  p22 = (((long long)(rd84)) == ((long long)(0)));
  // PTX:262 mov.u32 %r217, %r125
  asm("mov.u32 %0, %1;" : "=r"(r217) : "r"(r125));
  // PTX:263 @%p22 bra $L__BB1_30
  if (p22) { goto L_BB1_30; }
  // PTX:265 $L__BB1_26:
L_BB1_26:;
  // PTX:266 cvta.to.global.u64 %rd22, %rd81
  rd22 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd81));
  // PTX:267 mov.u64 %rd284, 0
  asm("mov.u64 %0, 0;" : "=l"(rd284) : );
  // PTX:269 $L__BB1_27:
L_BB1_27:;
  // PTX:270 shl.b64 %rd130, %rd284, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd130) : "l"(rd284));
  // PTX:271 add.s64 %rd131, %rd22, %rd130
  asm("add.s64 %0, %1, %2;" : "=l"(rd131) : "l"(rd22), "l"(rd130));
  // PTX:272 ld.global.u32 %r129, [%rd131]
  r129 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd131) + (0)))));
  // PTX:273 cvt.u32.u64 %r130, %rd21
  asm("cvt.u32.u64 %0, %1;" : "=r"(r130) : "l"(rd21));
  // PTX:274 setp.eq.s32 %p26, %r129, %r130
  p26 = (((int)(r129)) == ((int)(r130)));
  // PTX:275 @%p26 bra $L__BB1_29
  if (p26) { goto L_BB1_29; }
  // PTX:277 add.s64 %rd284, %rd284, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd284) : "l"(rd284));
  // PTX:278 setp.lt.u64 %p27, %rd284, %rd84
  p27 = (((unsigned long long)(rd284)) < ((unsigned long long)(rd84)));
  // PTX:279 mov.u32 %r217, %r125
  asm("mov.u32 %0, %1;" : "=r"(r217) : "r"(r125));
  // PTX:280 @%p27 bra $L__BB1_27
  if (p27) { goto L_BB1_27; }
  // PTX:281 bra.uni $L__BB1_30
  goto L_BB1_30;
  // PTX:283 $L__BB1_29:
L_BB1_29:;
  // PTX:284 cvt.u32.u64 %r217, %rd284
  asm("cvt.u32.u64 %0, %1;" : "=r"(r217) : "l"(rd284));
  // PTX:286 $L__BB1_30:
L_BB1_30:;
  // PTX:287 setp.lt.s32 %p28, %r217, 0
  p28 = (((int)(r217)) < ((int)(0)));
  // PTX:288 @%p28 bra $L__BB1_158
  if (p28) { goto L_BB1_158; }
  // PTX:290 @%p7 bra $L__BB1_33
  if (p7) { goto L_BB1_33; }
  // PTX:292 div.u64 %rd285, %rd7, %rd88
  asm("div.u64 %0, %1, %2;" : "=l"(rd285) : "l"(rd7), "l"(rd88));
  // PTX:293 bra.uni $L__BB1_34
  goto L_BB1_34;
  // PTX:295 $L__BB1_33:
L_BB1_33:;
  // PTX:296 cvt.u32.u64 %r133, %rd7
  asm("cvt.u32.u64 %0, %1;" : "=r"(r133) : "l"(rd7));
  // PTX:297 div.u32 %r134, %r133, %r112
  asm("div.u32 %0, %1, %2;" : "=r"(r134) : "r"(r133), "r"(r112));
  // PTX:298 cvt.u64.u32 %rd285, %r134
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd285) : "r"(r134));
  // PTX:300 $L__BB1_34:
L_BB1_34:;
  // PTX:301 cvt.u32.u64 %r135, %rd285
  asm("cvt.u32.u64 %0, %1;" : "=r"(r135) : "l"(rd285));
  // PTX:302 setp.ne.s32 %p30, %r216, %r135
  p30 = (((int)(r216)) != ((int)(r135)));
  // PTX:303 setp.lt.s32 %p31, %r216, 0
  p31 = (((int)(r216)) < ((int)(0)));
  // PTX:304 or.pred %p32, %p31, %p30
  p32 = ((p31) || (p30));
  // PTX:305 @%p32 bra $L__BB1_158
  if (p32) { goto L_BB1_158; }
  // PTX:307 cvt.s64.s32 %rd28, %r217
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd28) : "r"(r217));
  // PTX:308 mul.wide.s32 %rd135, %r217, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd135) : "r"(r217));
  // PTX:309 add.s64 %rd136, %rd134, %rd135
  asm("add.s64 %0, %1, %2;" : "=l"(rd136) : "l"(rd134), "l"(rd135));
  // PTX:310 mul.lo.s32 %r137, %r216, %r112
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r137) : "r"(r216), "r"(r112));
  // PTX:311 ld.global.u32 %r138, [%rd136]
  r138 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (0)))));
  // PTX:312 add.s32 %r6, %r138, %r137
  asm("add.s32 %0, %1, %2;" : "=r"(r6) : "r"(r138), "r"(r137));
  // PTX:313 ld.global.u32 %r139, [%rd136+4]
  r139 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (4)))));
  // PTX:314 add.s32 %r7, %r139, %r137
  asm("add.s32 %0, %1, %2;" : "=r"(r7) : "r"(r139), "r"(r137));
  // PTX:315 ld.global.u32 %r140, [%rd136+8]
  r140 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (8)))));
  // PTX:316 add.s32 %r8, %r140, %r137
  asm("add.s32 %0, %1, %2;" : "=r"(r8) : "r"(r140), "r"(r137));
  // PTX:317 ld.global.u32 %r141, [%rd136+12]
  r141 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (12)))));
  // PTX:318 add.s32 %r9, %r141, %r137
  asm("add.s32 %0, %1, %2;" : "=r"(r9) : "r"(r141), "r"(r137));
  // PTX:319 shl.b64 %rd138, %rd20, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd138) : "l"(rd20));
  // PTX:320 add.s64 %rd139, %rd137, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd139) : "l"(rd137), "l"(rd138));
  // PTX:321 ld.global.u32 %r10, [%rd139]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd139) + (0)))));
  // PTX:322 setp.eq.s32 %p33, %r10, 3
  p33 = (((int)(r10)) == ((int)(3)));
  // PTX:323 @%p33 bra $L__BB1_37
  if (p33) { goto L_BB1_37; }
  // PTX:324 bra.uni $L__BB1_36
  goto L_BB1_36;
  // PTX:326 $L__BB1_37:
L_BB1_37:;
  // PTX:327 mul.lo.s64 %rd143, %rd20, 28
  asm("mul.lo.s64 %0, %1, 28;" : "=l"(rd143) : "l"(rd20));
  // PTX:328 add.s64 %rd288, %rd142, %rd143
  asm("add.s64 %0, %1, %2;" : "=l"(rd288) : "l"(rd142), "l"(rd143));
  // PTX:329 add.s64 %rd287, %rd288, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd287) : "l"(rd288));
  // PTX:330 add.s64 %rd286, %rd288, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd286) : "l"(rd288));
  // PTX:331 bra.uni $L__BB1_38
  goto L_BB1_38;
  // PTX:333 $L__BB1_36:
L_BB1_36:;
  // PTX:334 mul.lo.s64 %rd141, %rd279, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd141) : "l"(rd279));
  // PTX:335 add.s64 %rd288, %rd140, %rd141
  asm("add.s64 %0, %1, %2;" : "=l"(rd288) : "l"(rd140), "l"(rd141));
  // PTX:336 add.s64 %rd287, %rd288, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd287) : "l"(rd288));
  // PTX:337 add.s64 %rd286, %rd288, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd286) : "l"(rd288));
  // PTX:339 $L__BB1_38:
L_BB1_38:;
  // PTX:340 ld.param.u64 %rd243, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_23]
  rd243 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param23 + (0))));
  // PTX:341 mul.lo.s64 %rd145, %rd28, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd145) : "l"(rd28));
  // PTX:342 add.s64 %rd38, %rd144, %rd145
  asm("add.s64 %0, %1, %2;" : "=l"(rd38) : "l"(rd144), "l"(rd145));
  // PTX:343 ld.global.u32 %r11, [%rd288]
  r11 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd288) + (0)))));
  // PTX:344 mov.b32 %f2, %r11
  asm("mov.b32 %0, %1;" : "=f"(f2) : "r"(r11));
  // PTX:345 ld.global.f32 %f3, [%rd38]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (0)))));
  // PTX:346 sub.f32 %f4, %f2, %f3
  asm("sub.f32 %0, %1, %2;" : "=f"(f4) : "f"(f2), "f"(f3));
  // PTX:347 ld.global.u32 %r12, [%rd287]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd287) + (0)))));
  // PTX:348 mov.b32 %f5, %r12
  asm("mov.b32 %0, %1;" : "=f"(f5) : "r"(r12));
  // PTX:349 ld.global.f32 %f6, [%rd38+4]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (4)))));
  // PTX:350 sub.f32 %f7, %f5, %f6
  asm("sub.f32 %0, %1, %2;" : "=f"(f7) : "f"(f5), "f"(f6));
  // PTX:351 ld.global.u32 %r13, [%rd286]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd286) + (0)))));
  // PTX:352 mov.b32 %f8, %r13
  asm("mov.b32 %0, %1;" : "=f"(f8) : "r"(r13));
  // PTX:353 ld.global.f32 %f9, [%rd38+8]
  f9 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (8)))));
  // PTX:354 sub.f32 %f10, %f8, %f9
  asm("sub.f32 %0, %1, %2;" : "=f"(f10) : "f"(f8), "f"(f9));
  // PTX:355 cvta.to.global.u64 %rd146, %rd243
  rd146 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd243));
  // PTX:356 mul.wide.s32 %rd147, %r6, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd147) : "r"(r6));
  // PTX:357 add.s64 %rd148, %rd146, %rd147
  asm("add.s64 %0, %1, %2;" : "=l"(rd148) : "l"(rd146), "l"(rd147));
  // PTX:358 mul.wide.s32 %rd149, %r7, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd149) : "r"(r7));
  // PTX:359 add.s64 %rd150, %rd146, %rd149
  asm("add.s64 %0, %1, %2;" : "=l"(rd150) : "l"(rd146), "l"(rd149));
  // PTX:360 ld.global.f32 %f11, [%rd150]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd150) + (0)))));
  // PTX:361 ld.global.f32 %f12, [%rd150+4]
  f12 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd150) + (4)))));
  // PTX:362 ld.global.f32 %f13, [%rd150+8]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd150) + (8)))));
  // PTX:363 ld.global.f32 %f14, [%rd148]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd148) + (0)))));
  // PTX:364 fma.rn.f32 %f493, %f4, %f11, %f14
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f493) : "f"(f4), "f"(f11), "f"(f14));
  // PTX:365 ld.global.f32 %f15, [%rd148+4]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd148) + (4)))));
  // PTX:366 fma.rn.f32 %f494, %f4, %f12, %f15
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f494) : "f"(f4), "f"(f12), "f"(f15));
  // PTX:367 ld.global.f32 %f16, [%rd148+8]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd148) + (8)))));
  // PTX:368 fma.rn.f32 %f495, %f4, %f13, %f16
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f495) : "f"(f4), "f"(f13), "f"(f16));
  // PTX:369 mul.wide.s32 %rd151, %r8, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd151) : "r"(r8));
  // PTX:370 add.s64 %rd152, %rd146, %rd151
  asm("add.s64 %0, %1, %2;" : "=l"(rd152) : "l"(rd146), "l"(rd151));
  // PTX:371 ld.global.f32 %f17, [%rd152]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd152) + (0)))));
  // PTX:372 ld.global.f32 %f18, [%rd152+4]
  f18 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd152) + (4)))));
  // PTX:373 ld.global.f32 %f19, [%rd152+8]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd152) + (8)))));
  // PTX:374 fma.rn.f32 %f496, %f7, %f17, %f493
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f496) : "f"(f7), "f"(f17), "f"(f493));
  // PTX:375 fma.rn.f32 %f497, %f7, %f18, %f494
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f497) : "f"(f7), "f"(f18), "f"(f494));
  // PTX:376 fma.rn.f32 %f498, %f7, %f19, %f495
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f498) : "f"(f7), "f"(f19), "f"(f495));
  // PTX:377 mul.wide.s32 %rd153, %r9, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd153) : "r"(r9));
  // PTX:378 add.s64 %rd154, %rd146, %rd153
  asm("add.s64 %0, %1, %2;" : "=l"(rd154) : "l"(rd146), "l"(rd153));
  // PTX:379 ld.global.f32 %f20, [%rd154]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd154) + (0)))));
  // PTX:380 ld.global.f32 %f21, [%rd154+4]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd154) + (4)))));
  // PTX:381 ld.global.f32 %f22, [%rd154+8]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd154) + (8)))));
  // PTX:382 fma.rn.f32 %f1230, %f10, %f20, %f496
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1230) : "f"(f10), "f"(f20), "f"(f496));
  // PTX:383 fma.rn.f32 %f1229, %f10, %f21, %f497
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1229) : "f"(f10), "f"(f21), "f"(f497));
  // PTX:384 fma.rn.f32 %f1228, %f10, %f22, %f498
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1228) : "f"(f10), "f"(f22), "f"(f498));
  // PTX:385 mul.lo.s64 %rd156, %rd279, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd156) : "l"(rd279));
  // PTX:386 add.s64 %rd157, %rd155, %rd156
  asm("add.s64 %0, %1, %2;" : "=l"(rd157) : "l"(rd155), "l"(rd156));
  // PTX:387 ld.global.f32 %f26, [%rd157]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd157) + (0)))));
  // PTX:388 ld.global.f32 %f27, [%rd157+4]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd157) + (4)))));
  // PTX:389 mul.f32 %f499, %f27, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f499) : "f"(f27), "f"(f27));
  // PTX:390 ld.global.f32 %f28, [%rd157+8]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd157) + (8)))));
  // PTX:391 fma.rn.f32 %f500, %f26, %f26, %f499
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f500) : "f"(f26), "f"(f26), "f"(f499));
  // PTX:392 fma.rn.f32 %f501, %f28, %f28, %f500
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f501) : "f"(f28), "f"(f28), "f"(f500));
  // PTX:393 sqrt.rn.f32 %f29, %f501
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f29) : "f"(f501));
  // PTX:394 setp.leu.f32 %p34, %f29, 0f00000000
  p34 = ((isnan(((float)(f29))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f29)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:395 mov.u32 %r218, 0
  asm("mov.u32 %0, 0;" : "=r"(r218) : );
  // PTX:396 mov.u32 %r219, %r218
  asm("mov.u32 %0, %1;" : "=r"(r219) : "r"(r218));
  // PTX:397 mov.u32 %r220, %r218
  asm("mov.u32 %0, %1;" : "=r"(r220) : "r"(r218));
  // PTX:398 @%p34 bra $L__BB1_40
  if (p34) { goto L_BB1_40; }
  // PTX:400 div.rn.f32 %f502, %f26, %f29
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f502) : "f"(f26), "f"(f29));
  // PTX:401 div.rn.f32 %f503, %f27, %f29
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f503) : "f"(f27), "f"(f29));
  // PTX:402 div.rn.f32 %f504, %f28, %f29
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f504) : "f"(f28), "f"(f29));
  // PTX:403 mov.b32 %r220, %f504
  asm("mov.b32 %0, %1;" : "=r"(r220) : "f"(f504));
  // PTX:404 mov.b32 %r219, %f503
  asm("mov.b32 %0, %1;" : "=r"(r219) : "f"(f503));
  // PTX:405 mov.b32 %r218, %f502
  asm("mov.b32 %0, %1;" : "=r"(r218) : "f"(f502));
  // PTX:407 $L__BB1_40:
L_BB1_40:;
  // PTX:408 cvt.s64.s32 %rd269, %rd283
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd269) : "l"(rd283));
  // PTX:409 setp.eq.s32 %p105, %r10, 3
  p105 = (((int)(r10)) == ((int)(3)));
  // PTX:410 mul.lo.s64 %rd159, %rd7, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd159) : "l"(rd7));
  // PTX:411 add.s64 %rd43, %rd146, %rd159
  asm("add.s64 %0, %1, %2;" : "=l"(rd43) : "l"(rd146), "l"(rd159));
  // PTX:412 mul.lo.s64 %rd161, %rd269, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd161) : "l"(rd269));
  // PTX:413 add.s64 %rd44, %rd160, %rd161
  asm("add.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd160), "l"(rd161));
  // PTX:414 @%p105 bra $L__BB1_42
  if (p105) { goto L_BB1_42; }
  // PTX:415 bra.uni $L__BB1_41
  goto L_BB1_41;
  // PTX:417 $L__BB1_42:
L_BB1_42:;
  // PTX:418 ld.global.f32 %f505, [%rd43]
  f505 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))));
  // PTX:419 sub.f32 %f33, %f505, %f1230
  asm("sub.f32 %0, %1, %2;" : "=f"(f33) : "f"(f505), "f"(f1230));
  // PTX:420 ld.global.f32 %f506, [%rd43+4]
  f506 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (4)))));
  // PTX:421 sub.f32 %f34, %f506, %f1229
  asm("sub.f32 %0, %1, %2;" : "=f"(f34) : "f"(f506), "f"(f1229));
  // PTX:422 ld.global.f32 %f507, [%rd43+8]
  f507 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (8)))));
  // PTX:423 sub.f32 %f35, %f507, %f1228
  asm("sub.f32 %0, %1, %2;" : "=f"(f35) : "f"(f507), "f"(f1228));
  // PTX:424 mul.f32 %f508, %f34, %f34
  asm("mul.f32 %0, %1, %2;" : "=f"(f508) : "f"(f34), "f"(f34));
  // PTX:425 fma.rn.f32 %f509, %f33, %f33, %f508
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f509) : "f"(f33), "f"(f33), "f"(f508));
  // PTX:426 fma.rn.f32 %f510, %f35, %f35, %f509
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f510) : "f"(f35), "f"(f35), "f"(f509));
  // PTX:427 sqrt.rn.f32 %f36, %f510
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f36) : "f"(f510));
  // PTX:428 setp.leu.f32 %p36, %f36, 0f00000000
  p36 = ((isnan(((float)(f36))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f36)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:429 mov.u32 %r221, 0
  asm("mov.u32 %0, 0;" : "=r"(r221) : );
  // PTX:430 mov.u32 %r222, %r221
  asm("mov.u32 %0, %1;" : "=r"(r222) : "r"(r221));
  // PTX:431 mov.u32 %r223, %r221
  asm("mov.u32 %0, %1;" : "=r"(r223) : "r"(r221));
  // PTX:432 @%p36 bra $L__BB1_44
  if (p36) { goto L_BB1_44; }
  // PTX:434 div.rn.f32 %f511, %f33, %f36
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f511) : "f"(f33), "f"(f36));
  // PTX:435 div.rn.f32 %f512, %f34, %f36
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f512) : "f"(f34), "f"(f36));
  // PTX:436 div.rn.f32 %f513, %f35, %f36
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f513) : "f"(f35), "f"(f36));
  // PTX:437 mov.b32 %r223, %f513
  asm("mov.b32 %0, %1;" : "=r"(r223) : "f"(f513));
  // PTX:438 mov.b32 %r222, %f512
  asm("mov.b32 %0, %1;" : "=r"(r222) : "f"(f512));
  // PTX:439 mov.b32 %r221, %f511
  asm("mov.b32 %0, %1;" : "=r"(r221) : "f"(f511));
  // PTX:441 $L__BB1_44:
L_BB1_44:;
  // PTX:442 mov.b32 %f514, %r221
  asm("mov.b32 %0, %1;" : "=f"(f514) : "r"(r221));
  // PTX:443 mov.b32 %f515, %r222
  asm("mov.b32 %0, %1;" : "=f"(f515) : "r"(r222));
  // PTX:444 mul.f32 %f516, %f515, %f515
  asm("mul.f32 %0, %1, %2;" : "=f"(f516) : "f"(f515), "f"(f515));
  // PTX:445 mov.b32 %f517, %r223
  asm("mov.b32 %0, %1;" : "=f"(f517) : "r"(r223));
  // PTX:446 fma.rn.f32 %f518, %f514, %f514, %f516
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f518) : "f"(f514), "f"(f514), "f"(f516));
  // PTX:447 fma.rn.f32 %f519, %f517, %f517, %f518
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f519) : "f"(f517), "f"(f517), "f"(f518));
  // PTX:448 setp.ltu.f32 %p37, %f519, 0f3F000000
  p37 = ((isnan(((float)(f519))) || isnan(((float)(as_f32(0x3F000000u))))) || (((float)(f519)) < ((float)(as_f32(0x3F000000u)))));
  // PTX:449 selp.b32 %r148, %r220, %r223, %p37
  r148 = p37 ? r220 : r223;
  // PTX:450 selp.b32 %r149, %r219, %r222, %p37
  r149 = p37 ? r219 : r222;
  // PTX:451 selp.b32 %r150, %r218, %r221, %p37
  r150 = p37 ? r218 : r221;
  // PTX:452 mov.b32 %f1227, %r150
  asm("mov.b32 %0, %1;" : "=f"(f1227) : "r"(r150));
  // PTX:453 ld.global.f32 %f520, [%rd44]
  f520 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))));
  // PTX:454 mov.b32 %f1226, %r149
  asm("mov.b32 %0, %1;" : "=f"(f1226) : "r"(r149));
  // PTX:455 mov.b32 %f1225, %r148
  asm("mov.b32 %0, %1;" : "=f"(f1225) : "r"(r148));
  // PTX:456 fma.rn.f32 %f1230, %f520, %f1227, %f1230
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1230) : "f"(f520), "f"(f1227), "f"(f1230));
  // PTX:457 fma.rn.f32 %f1229, %f520, %f1226, %f1229
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1229) : "f"(f520), "f"(f1226), "f"(f1229));
  // PTX:458 fma.rn.f32 %f1228, %f520, %f1225, %f1228
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1228) : "f"(f520), "f"(f1225), "f"(f1228));
  // PTX:459 bra.uni $L__BB1_45
  goto L_BB1_45;
  // PTX:461 $L__BB1_41:
L_BB1_41:;
  // PTX:462 mov.b32 %f1227, %r218
  asm("mov.b32 %0, %1;" : "=f"(f1227) : "r"(r218));
  // PTX:463 mov.b32 %f1226, %r219
  asm("mov.b32 %0, %1;" : "=f"(f1226) : "r"(r219));
  // PTX:464 mov.b32 %f1225, %r220
  asm("mov.b32 %0, %1;" : "=f"(f1225) : "r"(r220));
  // PTX:466 $L__BB1_45:
L_BB1_45:;
  // PTX:467 mul.f32 %f49, %f1226, %f1226
  asm("mul.f32 %0, %1, %2;" : "=f"(f49) : "f"(f1226), "f"(f1226));
  // PTX:468 mul.f32 %f50, %f1227, %f1227
  asm("mul.f32 %0, %1, %2;" : "=f"(f50) : "f"(f1227), "f"(f1227));
  // PTX:469 add.f32 %f521, %f49, %f50
  asm("add.f32 %0, %1, %2;" : "=f"(f521) : "f"(f49), "f"(f50));
  // PTX:470 mul.f32 %f51, %f1225, %f1225
  asm("mul.f32 %0, %1, %2;" : "=f"(f51) : "f"(f1225), "f"(f1225));
  // PTX:471 add.f32 %f522, %f51, %f521
  asm("add.f32 %0, %1, %2;" : "=f"(f522) : "f"(f51), "f"(f521));
  // PTX:472 setp.leu.f32 %p38, %f522, 0f00000000
  p38 = ((isnan(((float)(f522))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f522)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:473 @%p38 bra $L__BB1_158
  if (p38) { goto L_BB1_158; }
  // PTX:475 cvt.s64.s32 %rd271, %rd283
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd271) : "l"(rd283));
  // PTX:476 shl.b64 %rd270, %rd271, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd270) : "l"(rd271));
  // PTX:477 mov.b32 %f1209, %r13
  asm("mov.b32 %0, %1;" : "=f"(f1209) : "r"(r13));
  // PTX:478 sub.f32 %f1208, %f1209, %f9
  asm("sub.f32 %0, %1, %2;" : "=f"(f1208) : "f"(f1209), "f"(f9));
  // PTX:479 mov.b32 %f1207, %r12
  asm("mov.b32 %0, %1;" : "=f"(f1207) : "r"(r12));
  // PTX:480 sub.f32 %f1206, %f1207, %f6
  asm("sub.f32 %0, %1, %2;" : "=f"(f1206) : "f"(f1207), "f"(f6));
  // PTX:481 mov.b32 %f1205, %r11
  asm("mov.b32 %0, %1;" : "=f"(f1205) : "r"(r11));
  // PTX:482 sub.f32 %f1204, %f1205, %f3
  asm("sub.f32 %0, %1, %2;" : "=f"(f1204) : "f"(f1205), "f"(f3));
  // PTX:483 neg.f32 %f52, %f1204
  asm("neg.f32 %0, %1;" : "=f"(f52) : "f"(f1204));
  // PTX:484 neg.f32 %f53, %f1206
  asm("neg.f32 %0, %1;" : "=f"(f53) : "f"(f1206));
  // PTX:485 neg.f32 %f54, %f1208
  asm("neg.f32 %0, %1;" : "=f"(f54) : "f"(f1208));
  // PTX:486 add.s64 %rd164, %rd162, %rd108
  asm("add.s64 %0, %1, %2;" : "=l"(rd164) : "l"(rd162), "l"(rd108));
  // PTX:487 add.s64 %rd167, %rd165, %rd270
  asm("add.s64 %0, %1, %2;" : "=l"(rd167) : "l"(rd165), "l"(rd270));
  // PTX:488 ld.global.f32 %f523, [%rd167]
  f523 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd167) + (0)))));
  // PTX:489 ld.global.f32 %f524, [%rd164]
  f524 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd164) + (0)))));
  // PTX:490 add.f32 %f525, %f524, %f523
  asm("add.f32 %0, %1, %2;" : "=f"(f525) : "f"(f524), "f"(f523));
  // PTX:491 ld.global.f32 %f55, [%rd43]
  f55 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))));
  // PTX:492 sub.f32 %f526, %f55, %f1230
  asm("sub.f32 %0, %1, %2;" : "=f"(f526) : "f"(f55), "f"(f1230));
  // PTX:493 ld.global.f32 %f56, [%rd43+4]
  f56 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (4)))));
  // PTX:494 sub.f32 %f527, %f56, %f1229
  asm("sub.f32 %0, %1, %2;" : "=f"(f527) : "f"(f56), "f"(f1229));
  // PTX:495 ld.global.f32 %f57, [%rd43+8]
  f57 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (8)))));
  // PTX:496 sub.f32 %f528, %f57, %f1228
  asm("sub.f32 %0, %1, %2;" : "=f"(f528) : "f"(f57), "f"(f1228));
  // PTX:497 mul.f32 %f529, %f527, %f1226
  asm("mul.f32 %0, %1, %2;" : "=f"(f529) : "f"(f527), "f"(f1226));
  // PTX:498 fma.rn.f32 %f530, %f526, %f1227, %f529
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f530) : "f"(f526), "f"(f1227), "f"(f529));
  // PTX:499 fma.rn.f32 %f531, %f528, %f1225, %f530
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f531) : "f"(f528), "f"(f1225), "f"(f530));
  // PTX:500 sub.f32 %f58, %f525, %f531
  asm("sub.f32 %0, %1, %2;" : "=f"(f58) : "f"(f525), "f"(f531));
  // PTX:501 setp.le.f32 %p39, %f58, 0f00000000
  p39 = (!(isnan(((float)(f58))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f58)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:502 @%p39 bra $L__BB1_158
  if (p39) { goto L_BB1_158; }
  // PTX:504 cvt.s64.s32 %rd273, %rd283
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd273) : "l"(rd283));
  // PTX:505 shl.b64 %rd272, %rd273, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd272) : "l"(rd273));
  // PTX:506 ld.param.f32 %f1211, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_28]
  f1211 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param28 + (0))));
  // PTX:507 ld.param.f32 %f1210, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_29]
  f1210 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param29 + (0))));
  // PTX:508 setp.ne.s32 %p40, %r10, 3
  p40 = (((int)(r10)) != ((int)(3)));
  // PTX:509 add.s64 %rd170, %rd168, %rd272
  asm("add.s64 %0, %1, %2;" : "=l"(rd170) : "l"(rd168), "l"(rd272));
  // PTX:510 ld.global.f32 %f532, [%rd170]
  f532 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd170) + (0)))));
  // PTX:511 min.f32 %f59, %f1211, %f532
  asm("min.f32 %0, %1, %2;" : "=f"(f59) : "f"(f1211), "f"(f532));
  // PTX:512 add.s64 %rd172, %rd171, %rd272
  asm("add.s64 %0, %1, %2;" : "=l"(rd172) : "l"(rd171), "l"(rd272));
  // PTX:513 ld.global.f32 %f533, [%rd172]
  f533 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (0)))));
  // PTX:514 min.f32 %f534, %f1210, %f533
  asm("min.f32 %0, %1, %2;" : "=f"(f534) : "f"(f1210), "f"(f533));
  // PTX:515 mul.f32 %f535, %f59, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f535) : "f"(f59), "f"(f1));
  // PTX:516 sqrt.rn.f32 %f536, %f535
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f536) : "f"(f535));
  // PTX:517 add.f32 %f537, %f536, %f536
  asm("add.f32 %0, %1, %2;" : "=f"(f537) : "f"(f536), "f"(f536));
  // PTX:518 min.f32 %f60, %f534, %f537
  asm("min.f32 %0, %1, %2;" : "=f"(f60) : "f"(f534), "f"(f537));
  // PTX:519 mov.u32 %r252, %r13
  asm("mov.u32 %0, %1;" : "=r"(r252) : "r"(r13));
  // PTX:520 mov.u32 %r253, %r12
  asm("mov.u32 %0, %1;" : "=r"(r253) : "r"(r12));
  // PTX:521 mov.u32 %r254, %r11
  asm("mov.u32 %0, %1;" : "=r"(r254) : "r"(r11));
  // PTX:522 @%p40 bra $L__BB1_69
  if (p40) { goto L_BB1_69; }
  // PTX:524 ld.global.f32 %f538, [%rd44]
  f538 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))));
  // PTX:525 mul.f32 %f539, %f19, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f539) : "f"(f19), "f"(f21));
  // PTX:526 mul.f32 %f540, %f18, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f540) : "f"(f18), "f"(f22));
  // PTX:527 sub.f32 %f65, %f540, %f539
  asm("sub.f32 %0, %1, %2;" : "=f"(f65) : "f"(f540), "f"(f539));
  // PTX:528 mul.f32 %f541, %f17, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f541) : "f"(f17), "f"(f22));
  // PTX:529 mul.f32 %f542, %f19, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f542) : "f"(f19), "f"(f20));
  // PTX:530 sub.f32 %f66, %f542, %f541
  asm("sub.f32 %0, %1, %2;" : "=f"(f66) : "f"(f542), "f"(f541));
  // PTX:531 mul.f32 %f543, %f18, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f543) : "f"(f18), "f"(f20));
  // PTX:532 mul.f32 %f544, %f17, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f544) : "f"(f17), "f"(f21));
  // PTX:533 sub.f32 %f67, %f544, %f543
  asm("sub.f32 %0, %1, %2;" : "=f"(f67) : "f"(f544), "f"(f543));
  // PTX:534 mul.f32 %f545, %f12, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f545) : "f"(f12), "f"(f66));
  // PTX:535 fma.rn.f32 %f546, %f11, %f65, %f545
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f546) : "f"(f11), "f"(f65), "f"(f545));
  // PTX:536 fma.rn.f32 %f68, %f13, %f67, %f546
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f68) : "f"(f13), "f"(f67), "f"(f546));
  // PTX:537 abs.f32 %f547, %f68
  asm("abs.f32 %0, %1;" : "=f"(f547) : "f"(f68));
  // PTX:538 setp.leu.f32 %p41, %f547, 0f2EDBE6FF
  p41 = ((isnan(((float)(f547))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) || (((float)(f547)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:539 setp.geu.f32 %p42, %f547, 0f7F800000
  p42 = ((isnan(((float)(f547))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f547)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:540 or.pred %p43, %p41, %p42
  p43 = ((p41) || (p42));
  // PTX:541 @%p43 bra $L__BB1_50
  if (p43) { goto L_BB1_50; }
  // PTX:542 bra.uni $L__BB1_49
  goto L_BB1_49;
  // PTX:544 $L__BB1_50:
L_BB1_50:;
  // PTX:545 mul.f32 %f585, %f12, %f12
  asm("mul.f32 %0, %1, %2;" : "=f"(f585) : "f"(f12), "f"(f12));
  // PTX:546 fma.rn.f32 %f586, %f11, %f11, %f585
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f586) : "f"(f11), "f"(f11), "f"(f585));
  // PTX:547 fma.rn.f32 %f587, %f13, %f13, %f586
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f587) : "f"(f13), "f"(f13), "f"(f586));
  // PTX:548 mul.f32 %f588, %f18, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f588) : "f"(f18), "f"(f18));
  // PTX:549 fma.rn.f32 %f589, %f17, %f17, %f588
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f589) : "f"(f17), "f"(f17), "f"(f588));
  // PTX:550 fma.rn.f32 %f590, %f19, %f19, %f589
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f590) : "f"(f19), "f"(f19), "f"(f589));
  // PTX:551 add.f32 %f591, %f587, %f590
  asm("add.f32 %0, %1, %2;" : "=f"(f591) : "f"(f587), "f"(f590));
  // PTX:552 mul.f32 %f592, %f21, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f592) : "f"(f21), "f"(f21));
  // PTX:553 fma.rn.f32 %f593, %f20, %f20, %f592
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f593) : "f"(f20), "f"(f20), "f"(f592));
  // PTX:554 fma.rn.f32 %f594, %f22, %f22, %f593
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f594) : "f"(f22), "f"(f22), "f"(f593));
  // PTX:555 add.f32 %f595, %f591, %f594
  asm("add.f32 %0, %1, %2;" : "=f"(f595) : "f"(f591), "f"(f594));
  // PTX:556 div.rn.f32 %f596, %f595, 0f40400000
  asm("div.rn.f32 %0, %1, 0f40400000;" : "=f"(f596) : "f"(f595));
  // PTX:557 sqrt.rn.f32 %f69, %f596
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f69) : "f"(f596));
  // PTX:558 setp.leu.f32 %p44, %f69, 0f322BCC77
  p44 = ((isnan(((float)(f69))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f69)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:559 mov.u32 %r240, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r240) : );
  // PTX:560 mov.u32 %r241, 0
  asm("mov.u32 %0, 0;" : "=r"(r241) : );
  // PTX:561 mov.u32 %r242, %r241
  asm("mov.u32 %0, %1;" : "=r"(r242) : "r"(r241));
  // PTX:562 mov.u32 %r243, %r241
  asm("mov.u32 %0, %1;" : "=r"(r243) : "r"(r241));
  // PTX:563 mov.u32 %r244, %r240
  asm("mov.u32 %0, %1;" : "=r"(r244) : "r"(r240));
  // PTX:564 mov.u32 %r245, %r241
  asm("mov.u32 %0, %1;" : "=r"(r245) : "r"(r241));
  // PTX:565 mov.u32 %r246, %r241
  asm("mov.u32 %0, %1;" : "=r"(r246) : "r"(r241));
  // PTX:566 mov.u32 %r247, %r241
  asm("mov.u32 %0, %1;" : "=r"(r247) : "r"(r241));
  // PTX:567 mov.u32 %r248, %r240
  asm("mov.u32 %0, %1;" : "=r"(r248) : "r"(r240));
  // PTX:568 @%p44 bra $L__BB1_67
  if (p44) { goto L_BB1_67; }
  // PTX:570 mov.u32 %r240, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r240) : );
  // PTX:571 abs.f32 %f597, %f69
  asm("abs.f32 %0, %1;" : "=f"(f597) : "f"(f69));
  // PTX:572 setp.geu.f32 %p45, %f597, 0f7F800000
  p45 = ((isnan(((float)(f597))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f597)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:573 @%p45 bra $L__BB1_67
  if (p45) { goto L_BB1_67; }
  // PTX:575 rcp.rn.f32 %f598, %f69
  asm("rcp.rn.f32 %0, %1;" : "=f"(f598) : "f"(f69));
  // PTX:576 mul.f32 %f1240, %f11, %f598
  asm("mul.f32 %0, %1, %2;" : "=f"(f1240) : "f"(f11), "f"(f598));
  // PTX:577 mul.f32 %f1241, %f12, %f598
  asm("mul.f32 %0, %1, %2;" : "=f"(f1241) : "f"(f12), "f"(f598));
  // PTX:578 mul.f32 %f1242, %f13, %f598
  asm("mul.f32 %0, %1, %2;" : "=f"(f1242) : "f"(f13), "f"(f598));
  // PTX:579 mul.f32 %f1243, %f17, %f598
  asm("mul.f32 %0, %1, %2;" : "=f"(f1243) : "f"(f17), "f"(f598));
  // PTX:580 mul.f32 %f1244, %f18, %f598
  asm("mul.f32 %0, %1, %2;" : "=f"(f1244) : "f"(f18), "f"(f598));
  // PTX:581 mul.f32 %f1245, %f19, %f598
  asm("mul.f32 %0, %1, %2;" : "=f"(f1245) : "f"(f19), "f"(f598));
  // PTX:582 mul.f32 %f1246, %f20, %f598
  asm("mul.f32 %0, %1, %2;" : "=f"(f1246) : "f"(f20), "f"(f598));
  // PTX:583 mul.f32 %f1247, %f21, %f598
  asm("mul.f32 %0, %1, %2;" : "=f"(f1247) : "f"(f21), "f"(f598));
  // PTX:584 mul.f32 %f1248, %f22, %f598
  asm("mul.f32 %0, %1, %2;" : "=f"(f1248) : "f"(f22), "f"(f598));
  // PTX:585 mov.u32 %r224, 0
  asm("mov.u32 %0, 0;" : "=r"(r224) : );
  // PTX:587 $L__BB1_53:
L_BB1_53:;
  // PTX:588 mul.f32 %f599, %f1245, %f1247
  asm("mul.f32 %0, %1, %2;" : "=f"(f599) : "f"(f1245), "f"(f1247));
  // PTX:589 mul.f32 %f600, %f1244, %f1248
  asm("mul.f32 %0, %1, %2;" : "=f"(f600) : "f"(f1244), "f"(f1248));
  // PTX:590 sub.f32 %f88, %f600, %f599
  asm("sub.f32 %0, %1, %2;" : "=f"(f88) : "f"(f600), "f"(f599));
  // PTX:591 mul.f32 %f601, %f1243, %f1248
  asm("mul.f32 %0, %1, %2;" : "=f"(f601) : "f"(f1243), "f"(f1248));
  // PTX:592 mul.f32 %f602, %f1245, %f1246
  asm("mul.f32 %0, %1, %2;" : "=f"(f602) : "f"(f1245), "f"(f1246));
  // PTX:593 sub.f32 %f89, %f602, %f601
  asm("sub.f32 %0, %1, %2;" : "=f"(f89) : "f"(f602), "f"(f601));
  // PTX:594 mul.f32 %f603, %f1244, %f1246
  asm("mul.f32 %0, %1, %2;" : "=f"(f603) : "f"(f1244), "f"(f1246));
  // PTX:595 mul.f32 %f604, %f1243, %f1247
  asm("mul.f32 %0, %1, %2;" : "=f"(f604) : "f"(f1243), "f"(f1247));
  // PTX:596 sub.f32 %f90, %f604, %f603
  asm("sub.f32 %0, %1, %2;" : "=f"(f90) : "f"(f604), "f"(f603));
  // PTX:597 mul.f32 %f605, %f1241, %f89
  asm("mul.f32 %0, %1, %2;" : "=f"(f605) : "f"(f1241), "f"(f89));
  // PTX:598 fma.rn.f32 %f606, %f1240, %f88, %f605
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f606) : "f"(f1240), "f"(f88), "f"(f605));
  // PTX:599 fma.rn.f32 %f91, %f1242, %f90, %f606
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f91) : "f"(f1242), "f"(f90), "f"(f606));
  // PTX:600 abs.f32 %f607, %f91
  asm("abs.f32 %0, %1;" : "=f"(f607) : "f"(f91));
  // PTX:601 setp.le.f32 %p46, %f607, 0f2EDBE6FF
  p46 = (!(isnan(((float)(f607))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f607)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:602 setp.geu.f32 %p47, %f607, 0f7F800000
  p47 = ((isnan(((float)(f607))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f607)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:603 or.pred %p48, %p46, %p47
  p48 = ((p46) || (p47));
  // PTX:604 @%p48 bra $L__BB1_56
  if (p48) { goto L_BB1_56; }
  // PTX:606 rcp.rn.f32 %f608, %f91
  asm("rcp.rn.f32 %0, %1;" : "=f"(f608) : "f"(f91));
  // PTX:607 mul.f32 %f609, %f1241, %f1248
  asm("mul.f32 %0, %1, %2;" : "=f"(f609) : "f"(f1241), "f"(f1248));
  // PTX:608 mul.f32 %f610, %f1242, %f1247
  asm("mul.f32 %0, %1, %2;" : "=f"(f610) : "f"(f1242), "f"(f1247));
  // PTX:609 sub.f32 %f611, %f610, %f609
  asm("sub.f32 %0, %1, %2;" : "=f"(f611) : "f"(f610), "f"(f609));
  // PTX:610 mul.f32 %f612, %f1242, %f1246
  asm("mul.f32 %0, %1, %2;" : "=f"(f612) : "f"(f1242), "f"(f1246));
  // PTX:611 mul.f32 %f613, %f1240, %f1248
  asm("mul.f32 %0, %1, %2;" : "=f"(f613) : "f"(f1240), "f"(f1248));
  // PTX:612 sub.f32 %f614, %f613, %f612
  asm("sub.f32 %0, %1, %2;" : "=f"(f614) : "f"(f613), "f"(f612));
  // PTX:613 mul.f32 %f615, %f1240, %f1247
  asm("mul.f32 %0, %1, %2;" : "=f"(f615) : "f"(f1240), "f"(f1247));
  // PTX:614 mul.f32 %f616, %f1241, %f1246
  asm("mul.f32 %0, %1, %2;" : "=f"(f616) : "f"(f1241), "f"(f1246));
  // PTX:615 sub.f32 %f617, %f616, %f615
  asm("sub.f32 %0, %1, %2;" : "=f"(f617) : "f"(f616), "f"(f615));
  // PTX:616 mul.f32 %f618, %f1242, %f1244
  asm("mul.f32 %0, %1, %2;" : "=f"(f618) : "f"(f1242), "f"(f1244));
  // PTX:617 mul.f32 %f619, %f1241, %f1245
  asm("mul.f32 %0, %1, %2;" : "=f"(f619) : "f"(f1241), "f"(f1245));
  // PTX:618 sub.f32 %f620, %f619, %f618
  asm("sub.f32 %0, %1, %2;" : "=f"(f620) : "f"(f619), "f"(f618));
  // PTX:619 mul.f32 %f621, %f1240, %f1245
  asm("mul.f32 %0, %1, %2;" : "=f"(f621) : "f"(f1240), "f"(f1245));
  // PTX:620 mul.f32 %f622, %f1242, %f1243
  asm("mul.f32 %0, %1, %2;" : "=f"(f622) : "f"(f1242), "f"(f1243));
  // PTX:621 sub.f32 %f623, %f622, %f621
  asm("sub.f32 %0, %1, %2;" : "=f"(f623) : "f"(f622), "f"(f621));
  // PTX:622 mul.f32 %f624, %f1241, %f1243
  asm("mul.f32 %0, %1, %2;" : "=f"(f624) : "f"(f1241), "f"(f1243));
  // PTX:623 mul.f32 %f625, %f1240, %f1244
  asm("mul.f32 %0, %1, %2;" : "=f"(f625) : "f"(f1240), "f"(f1244));
  // PTX:624 sub.f32 %f626, %f625, %f624
  asm("sub.f32 %0, %1, %2;" : "=f"(f626) : "f"(f625), "f"(f624));
  // PTX:625 fma.rn.f32 %f627, %f88, %f608, %f1240
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f627) : "f"(f88), "f"(f608), "f"(f1240));
  // PTX:626 fma.rn.f32 %f628, %f89, %f608, %f1241
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f628) : "f"(f89), "f"(f608), "f"(f1241));
  // PTX:627 fma.rn.f32 %f629, %f90, %f608, %f1242
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f629) : "f"(f90), "f"(f608), "f"(f1242));
  // PTX:628 fma.rn.f32 %f630, %f611, %f608, %f1243
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f630) : "f"(f611), "f"(f608), "f"(f1243));
  // PTX:629 fma.rn.f32 %f631, %f614, %f608, %f1244
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f631) : "f"(f614), "f"(f608), "f"(f1244));
  // PTX:630 fma.rn.f32 %f632, %f617, %f608, %f1245
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f632) : "f"(f617), "f"(f608), "f"(f1245));
  // PTX:631 fma.rn.f32 %f633, %f620, %f608, %f1246
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f633) : "f"(f620), "f"(f608), "f"(f1246));
  // PTX:632 fma.rn.f32 %f634, %f623, %f608, %f1247
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f634) : "f"(f623), "f"(f608), "f"(f1247));
  // PTX:633 fma.rn.f32 %f635, %f626, %f608, %f1248
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f635) : "f"(f626), "f"(f608), "f"(f1248));
  // PTX:634 mul.f32 %f1240, %f627, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1240) : "f"(f627));
  // PTX:635 mul.f32 %f1241, %f628, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1241) : "f"(f628));
  // PTX:636 mul.f32 %f1242, %f629, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1242) : "f"(f629));
  // PTX:637 mul.f32 %f1243, %f630, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1243) : "f"(f630));
  // PTX:638 mul.f32 %f1244, %f631, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1244) : "f"(f631));
  // PTX:639 mul.f32 %f1245, %f632, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1245) : "f"(f632));
  // PTX:640 mul.f32 %f1246, %f633, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1246) : "f"(f633));
  // PTX:641 mul.f32 %f1247, %f634, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1247) : "f"(f634));
  // PTX:642 mul.f32 %f1248, %f635, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1248) : "f"(f635));
  // PTX:643 mul.f32 %f636, %f1244, %f1248
  asm("mul.f32 %0, %1, %2;" : "=f"(f636) : "f"(f1244), "f"(f1248));
  // PTX:644 mul.f32 %f637, %f1245, %f1247
  asm("mul.f32 %0, %1, %2;" : "=f"(f637) : "f"(f1245), "f"(f1247));
  // PTX:645 sub.f32 %f101, %f636, %f637
  asm("sub.f32 %0, %1, %2;" : "=f"(f101) : "f"(f636), "f"(f637));
  // PTX:646 mul.f32 %f638, %f1245, %f1246
  asm("mul.f32 %0, %1, %2;" : "=f"(f638) : "f"(f1245), "f"(f1246));
  // PTX:647 mul.f32 %f639, %f1243, %f1248
  asm("mul.f32 %0, %1, %2;" : "=f"(f639) : "f"(f1243), "f"(f1248));
  // PTX:648 sub.f32 %f102, %f638, %f639
  asm("sub.f32 %0, %1, %2;" : "=f"(f102) : "f"(f638), "f"(f639));
  // PTX:649 mul.f32 %f640, %f1243, %f1247
  asm("mul.f32 %0, %1, %2;" : "=f"(f640) : "f"(f1243), "f"(f1247));
  // PTX:650 mul.f32 %f641, %f1244, %f1246
  asm("mul.f32 %0, %1, %2;" : "=f"(f641) : "f"(f1244), "f"(f1246));
  // PTX:651 sub.f32 %f103, %f640, %f641
  asm("sub.f32 %0, %1, %2;" : "=f"(f103) : "f"(f640), "f"(f641));
  // PTX:652 mul.f32 %f642, %f1241, %f102
  asm("mul.f32 %0, %1, %2;" : "=f"(f642) : "f"(f1241), "f"(f102));
  // PTX:653 fma.rn.f32 %f643, %f1240, %f101, %f642
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f643) : "f"(f1240), "f"(f101), "f"(f642));
  // PTX:654 fma.rn.f32 %f104, %f1242, %f103, %f643
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f104) : "f"(f1242), "f"(f103), "f"(f643));
  // PTX:655 abs.f32 %f644, %f104
  asm("abs.f32 %0, %1;" : "=f"(f644) : "f"(f104));
  // PTX:656 setp.le.f32 %p49, %f644, 0f2EDBE6FF
  p49 = (!(isnan(((float)(f644))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f644)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:657 setp.geu.f32 %p50, %f644, 0f7F800000
  p50 = ((isnan(((float)(f644))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f644)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:658 or.pred %p51, %p49, %p50
  p51 = ((p49) || (p50));
  // PTX:659 @%p51 bra $L__BB1_56
  if (p51) { goto L_BB1_56; }
  // PTX:661 rcp.rn.f32 %f645, %f104
  asm("rcp.rn.f32 %0, %1;" : "=f"(f645) : "f"(f104));
  // PTX:662 mul.f32 %f646, %f1241, %f1248
  asm("mul.f32 %0, %1, %2;" : "=f"(f646) : "f"(f1241), "f"(f1248));
  // PTX:663 mul.f32 %f647, %f1242, %f1247
  asm("mul.f32 %0, %1, %2;" : "=f"(f647) : "f"(f1242), "f"(f1247));
  // PTX:664 sub.f32 %f648, %f647, %f646
  asm("sub.f32 %0, %1, %2;" : "=f"(f648) : "f"(f647), "f"(f646));
  // PTX:665 mul.f32 %f649, %f1242, %f1246
  asm("mul.f32 %0, %1, %2;" : "=f"(f649) : "f"(f1242), "f"(f1246));
  // PTX:666 mul.f32 %f650, %f1240, %f1248
  asm("mul.f32 %0, %1, %2;" : "=f"(f650) : "f"(f1240), "f"(f1248));
  // PTX:667 sub.f32 %f651, %f650, %f649
  asm("sub.f32 %0, %1, %2;" : "=f"(f651) : "f"(f650), "f"(f649));
  // PTX:668 mul.f32 %f652, %f1240, %f1247
  asm("mul.f32 %0, %1, %2;" : "=f"(f652) : "f"(f1240), "f"(f1247));
  // PTX:669 mul.f32 %f653, %f1241, %f1246
  asm("mul.f32 %0, %1, %2;" : "=f"(f653) : "f"(f1241), "f"(f1246));
  // PTX:670 sub.f32 %f654, %f653, %f652
  asm("sub.f32 %0, %1, %2;" : "=f"(f654) : "f"(f653), "f"(f652));
  // PTX:671 mul.f32 %f655, %f1242, %f1244
  asm("mul.f32 %0, %1, %2;" : "=f"(f655) : "f"(f1242), "f"(f1244));
  // PTX:672 mul.f32 %f656, %f1241, %f1245
  asm("mul.f32 %0, %1, %2;" : "=f"(f656) : "f"(f1241), "f"(f1245));
  // PTX:673 sub.f32 %f657, %f656, %f655
  asm("sub.f32 %0, %1, %2;" : "=f"(f657) : "f"(f656), "f"(f655));
  // PTX:674 mul.f32 %f658, %f1240, %f1245
  asm("mul.f32 %0, %1, %2;" : "=f"(f658) : "f"(f1240), "f"(f1245));
  // PTX:675 mul.f32 %f659, %f1242, %f1243
  asm("mul.f32 %0, %1, %2;" : "=f"(f659) : "f"(f1242), "f"(f1243));
  // PTX:676 sub.f32 %f660, %f659, %f658
  asm("sub.f32 %0, %1, %2;" : "=f"(f660) : "f"(f659), "f"(f658));
  // PTX:677 mul.f32 %f661, %f1241, %f1243
  asm("mul.f32 %0, %1, %2;" : "=f"(f661) : "f"(f1241), "f"(f1243));
  // PTX:678 mul.f32 %f662, %f1240, %f1244
  asm("mul.f32 %0, %1, %2;" : "=f"(f662) : "f"(f1240), "f"(f1244));
  // PTX:679 sub.f32 %f663, %f662, %f661
  asm("sub.f32 %0, %1, %2;" : "=f"(f663) : "f"(f662), "f"(f661));
  // PTX:680 fma.rn.f32 %f664, %f101, %f645, %f1240
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f664) : "f"(f101), "f"(f645), "f"(f1240));
  // PTX:681 fma.rn.f32 %f665, %f102, %f645, %f1241
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f665) : "f"(f102), "f"(f645), "f"(f1241));
  // PTX:682 fma.rn.f32 %f666, %f103, %f645, %f1242
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f666) : "f"(f103), "f"(f645), "f"(f1242));
  // PTX:683 fma.rn.f32 %f667, %f648, %f645, %f1243
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f667) : "f"(f648), "f"(f645), "f"(f1243));
  // PTX:684 fma.rn.f32 %f668, %f651, %f645, %f1244
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f668) : "f"(f651), "f"(f645), "f"(f1244));
  // PTX:685 fma.rn.f32 %f669, %f654, %f645, %f1245
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f669) : "f"(f654), "f"(f645), "f"(f1245));
  // PTX:686 fma.rn.f32 %f670, %f657, %f645, %f1246
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f670) : "f"(f657), "f"(f645), "f"(f1246));
  // PTX:687 fma.rn.f32 %f671, %f660, %f645, %f1247
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f671) : "f"(f660), "f"(f645), "f"(f1247));
  // PTX:688 fma.rn.f32 %f672, %f663, %f645, %f1248
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f672) : "f"(f663), "f"(f645), "f"(f1248));
  // PTX:689 mul.f32 %f1240, %f664, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1240) : "f"(f664));
  // PTX:690 mul.f32 %f1241, %f665, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1241) : "f"(f665));
  // PTX:691 mul.f32 %f1242, %f666, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1242) : "f"(f666));
  // PTX:692 mul.f32 %f1243, %f667, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1243) : "f"(f667));
  // PTX:693 mul.f32 %f1244, %f668, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1244) : "f"(f668));
  // PTX:694 mul.f32 %f1245, %f669, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1245) : "f"(f669));
  // PTX:695 mul.f32 %f1246, %f670, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1246) : "f"(f670));
  // PTX:696 mul.f32 %f1247, %f671, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1247) : "f"(f671));
  // PTX:697 mul.f32 %f1248, %f672, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1248) : "f"(f672));
  // PTX:698 add.s32 %r224, %r224, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r224) : "r"(r224));
  // PTX:699 setp.lt.u32 %p52, %r224, 8
  p52 = (((unsigned)(r224)) < ((unsigned)(8)));
  // PTX:700 @%p52 bra $L__BB1_53
  if (p52) { goto L_BB1_53; }
  // PTX:702 $L__BB1_56:
L_BB1_56:;
  // PTX:703 mul.f32 %f673, %f1241, %f1241
  asm("mul.f32 %0, %1, %2;" : "=f"(f673) : "f"(f1241), "f"(f1241));
  // PTX:704 fma.rn.f32 %f674, %f1240, %f1240, %f673
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f674) : "f"(f1240), "f"(f1240), "f"(f673));
  // PTX:705 fma.rn.f32 %f675, %f1242, %f1242, %f674
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f675) : "f"(f1242), "f"(f1242), "f"(f674));
  // PTX:706 sqrt.rn.f32 %f123, %f675
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f123) : "f"(f675));
  // PTX:707 setp.leu.f32 %p53, %f123, 0f00000000
  p53 = ((isnan(((float)(f123))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f123)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:708 mov.u32 %r237, 0
  asm("mov.u32 %0, 0;" : "=r"(r237) : );
  // PTX:709 mov.u32 %r225, %r237
  asm("mov.u32 %0, %1;" : "=r"(r225) : "r"(r237));
  // PTX:710 mov.u32 %r226, %r237
  asm("mov.u32 %0, %1;" : "=r"(r226) : "r"(r237));
  // PTX:711 mov.u32 %r227, %r237
  asm("mov.u32 %0, %1;" : "=r"(r227) : "r"(r237));
  // PTX:712 @%p53 bra $L__BB1_58
  if (p53) { goto L_BB1_58; }
  // PTX:714 div.rn.f32 %f676, %f1240, %f123
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f676) : "f"(f1240), "f"(f123));
  // PTX:715 div.rn.f32 %f677, %f1241, %f123
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f677) : "f"(f1241), "f"(f123));
  // PTX:716 div.rn.f32 %f678, %f1242, %f123
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f678) : "f"(f1242), "f"(f123));
  // PTX:717 mov.b32 %r227, %f678
  asm("mov.b32 %0, %1;" : "=r"(r227) : "f"(f678));
  // PTX:718 mov.b32 %r226, %f677
  asm("mov.b32 %0, %1;" : "=r"(r226) : "f"(f677));
  // PTX:719 mov.b32 %r225, %f676
  asm("mov.b32 %0, %1;" : "=r"(r225) : "f"(f676));
  // PTX:721 $L__BB1_58:
L_BB1_58:;
  // PTX:722 mov.b32 %f124, %r225
  asm("mov.b32 %0, %1;" : "=f"(f124) : "r"(r225));
  // PTX:723 mov.b32 %f125, %r226
  asm("mov.b32 %0, %1;" : "=f"(f125) : "r"(r226));
  // PTX:724 mul.f32 %f679, %f1244, %f125
  asm("mul.f32 %0, %1, %2;" : "=f"(f679) : "f"(f1244), "f"(f125));
  // PTX:725 mov.b32 %f126, %r227
  asm("mov.b32 %0, %1;" : "=f"(f126) : "r"(r227));
  // PTX:726 fma.rn.f32 %f680, %f1243, %f124, %f679
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f680) : "f"(f1243), "f"(f124), "f"(f679));
  // PTX:727 fma.rn.f32 %f681, %f1245, %f126, %f680
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f681) : "f"(f1245), "f"(f126), "f"(f680));
  // PTX:728 mul.f32 %f682, %f681, %f124
  asm("mul.f32 %0, %1, %2;" : "=f"(f682) : "f"(f681), "f"(f124));
  // PTX:729 mul.f32 %f683, %f681, %f125
  asm("mul.f32 %0, %1, %2;" : "=f"(f683) : "f"(f681), "f"(f125));
  // PTX:730 mul.f32 %f684, %f681, %f126
  asm("mul.f32 %0, %1, %2;" : "=f"(f684) : "f"(f681), "f"(f126));
  // PTX:731 sub.f32 %f127, %f1243, %f682
  asm("sub.f32 %0, %1, %2;" : "=f"(f127) : "f"(f1243), "f"(f682));
  // PTX:732 sub.f32 %f128, %f1244, %f683
  asm("sub.f32 %0, %1, %2;" : "=f"(f128) : "f"(f1244), "f"(f683));
  // PTX:733 sub.f32 %f129, %f1245, %f684
  asm("sub.f32 %0, %1, %2;" : "=f"(f129) : "f"(f1245), "f"(f684));
  // PTX:734 mul.f32 %f685, %f128, %f128
  asm("mul.f32 %0, %1, %2;" : "=f"(f685) : "f"(f128), "f"(f128));
  // PTX:735 fma.rn.f32 %f686, %f127, %f127, %f685
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f686) : "f"(f127), "f"(f127), "f"(f685));
  // PTX:736 fma.rn.f32 %f687, %f129, %f129, %f686
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f687) : "f"(f129), "f"(f129), "f"(f686));
  // PTX:737 sqrt.rn.f32 %f130, %f687
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f130) : "f"(f687));
  // PTX:738 setp.leu.f32 %p54, %f130, 0f00000000
  p54 = ((isnan(((float)(f130))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f130)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:739 mov.u32 %r238, %r237
  asm("mov.u32 %0, %1;" : "=r"(r238) : "r"(r237));
  // PTX:740 mov.u32 %r239, %r237
  asm("mov.u32 %0, %1;" : "=r"(r239) : "r"(r237));
  // PTX:741 @%p54 bra $L__BB1_60
  if (p54) { goto L_BB1_60; }
  // PTX:743 div.rn.f32 %f688, %f127, %f130
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f688) : "f"(f127), "f"(f130));
  // PTX:744 div.rn.f32 %f689, %f128, %f130
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f689) : "f"(f128), "f"(f130));
  // PTX:745 div.rn.f32 %f690, %f129, %f130
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f690) : "f"(f129), "f"(f130));
  // PTX:746 mov.b32 %r239, %f690
  asm("mov.b32 %0, %1;" : "=r"(r239) : "f"(f690));
  // PTX:747 mov.b32 %r238, %f689
  asm("mov.b32 %0, %1;" : "=r"(r238) : "f"(f689));
  // PTX:748 mov.b32 %r237, %f688
  asm("mov.b32 %0, %1;" : "=r"(r237) : "f"(f688));
  // PTX:750 $L__BB1_60:
L_BB1_60:;
  // PTX:751 mov.b32 %f1218, %r227
  asm("mov.b32 %0, %1;" : "=f"(f1218) : "r"(r227));
  // PTX:752 mov.b32 %f1217, %r225
  asm("mov.b32 %0, %1;" : "=f"(f1217) : "r"(r225));
  // PTX:753 mov.b32 %f1216, %r226
  asm("mov.b32 %0, %1;" : "=f"(f1216) : "r"(r226));
  // PTX:754 mov.u32 %r240, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r240) : );
  // PTX:755 mul.f32 %f691, %f1216, %f1216
  asm("mul.f32 %0, %1, %2;" : "=f"(f691) : "f"(f1216), "f"(f1216));
  // PTX:756 fma.rn.f32 %f692, %f1217, %f1217, %f691
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f692) : "f"(f1217), "f"(f1217), "f"(f691));
  // PTX:757 fma.rn.f32 %f693, %f1218, %f1218, %f692
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f693) : "f"(f1218), "f"(f1218), "f"(f692));
  // PTX:758 sqrt.rn.f32 %f694, %f693
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f694) : "f"(f693));
  // PTX:759 setp.le.f32 %p55, %f694, 0f322BCC77
  p55 = (!(isnan(((float)(f694))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f694)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:760 mov.u32 %r241, 0
  asm("mov.u32 %0, 0;" : "=r"(r241) : );
  // PTX:761 mov.u32 %r242, %r241
  asm("mov.u32 %0, %1;" : "=r"(r242) : "r"(r241));
  // PTX:762 mov.u32 %r243, %r241
  asm("mov.u32 %0, %1;" : "=r"(r243) : "r"(r241));
  // PTX:763 mov.u32 %r244, %r240
  asm("mov.u32 %0, %1;" : "=r"(r244) : "r"(r240));
  // PTX:764 mov.u32 %r245, %r241
  asm("mov.u32 %0, %1;" : "=r"(r245) : "r"(r241));
  // PTX:765 mov.u32 %r246, %r241
  asm("mov.u32 %0, %1;" : "=r"(r246) : "r"(r241));
  // PTX:766 mov.u32 %r247, %r241
  asm("mov.u32 %0, %1;" : "=r"(r247) : "r"(r241));
  // PTX:767 mov.u32 %r248, %r240
  asm("mov.u32 %0, %1;" : "=r"(r248) : "r"(r240));
  // PTX:768 @%p55 bra $L__BB1_67
  if (p55) { goto L_BB1_67; }
  // PTX:770 mov.u32 %r240, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r240) : );
  // PTX:771 mov.b32 %f131, %r237
  asm("mov.b32 %0, %1;" : "=f"(f131) : "r"(r237));
  // PTX:772 mov.b32 %f132, %r238
  asm("mov.b32 %0, %1;" : "=f"(f132) : "r"(r238));
  // PTX:773 mul.f32 %f695, %f132, %f132
  asm("mul.f32 %0, %1, %2;" : "=f"(f695) : "f"(f132), "f"(f132));
  // PTX:774 mov.b32 %f133, %r239
  asm("mov.b32 %0, %1;" : "=f"(f133) : "r"(r239));
  // PTX:775 fma.rn.f32 %f696, %f131, %f131, %f695
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f696) : "f"(f131), "f"(f131), "f"(f695));
  // PTX:776 fma.rn.f32 %f697, %f133, %f133, %f696
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f697) : "f"(f133), "f"(f133), "f"(f696));
  // PTX:777 sqrt.rn.f32 %f698, %f697
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f698) : "f"(f697));
  // PTX:778 setp.le.f32 %p56, %f698, 0f322BCC77
  p56 = (!(isnan(((float)(f698))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f698)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:779 @%p56 bra $L__BB1_67
  if (p56) { goto L_BB1_67; }
  // PTX:781 mov.b32 %f1221, %r227
  asm("mov.b32 %0, %1;" : "=f"(f1221) : "r"(r227));
  // PTX:782 mov.b32 %f1220, %r225
  asm("mov.b32 %0, %1;" : "=f"(f1220) : "r"(r225));
  // PTX:783 mov.b32 %f1219, %r226
  asm("mov.b32 %0, %1;" : "=f"(f1219) : "r"(r226));
  // PTX:784 mul.f32 %f699, %f1219, %f133
  asm("mul.f32 %0, %1, %2;" : "=f"(f699) : "f"(f1219), "f"(f133));
  // PTX:785 mul.f32 %f700, %f1221, %f132
  asm("mul.f32 %0, %1, %2;" : "=f"(f700) : "f"(f1221), "f"(f132));
  // PTX:786 sub.f32 %f134, %f699, %f700
  asm("sub.f32 %0, %1, %2;" : "=f"(f134) : "f"(f699), "f"(f700));
  // PTX:787 mul.f32 %f701, %f1220, %f133
  asm("mul.f32 %0, %1, %2;" : "=f"(f701) : "f"(f1220), "f"(f133));
  // PTX:788 mul.f32 %f702, %f1221, %f131
  asm("mul.f32 %0, %1, %2;" : "=f"(f702) : "f"(f1221), "f"(f131));
  // PTX:789 sub.f32 %f135, %f702, %f701
  asm("sub.f32 %0, %1, %2;" : "=f"(f135) : "f"(f702), "f"(f701));
  // PTX:790 mul.f32 %f703, %f1219, %f131
  asm("mul.f32 %0, %1, %2;" : "=f"(f703) : "f"(f1219), "f"(f131));
  // PTX:791 mul.f32 %f704, %f1220, %f132
  asm("mul.f32 %0, %1, %2;" : "=f"(f704) : "f"(f1220), "f"(f132));
  // PTX:792 sub.f32 %f136, %f704, %f703
  asm("sub.f32 %0, %1, %2;" : "=f"(f136) : "f"(f704), "f"(f703));
  // PTX:793 mul.f32 %f705, %f135, %f135
  asm("mul.f32 %0, %1, %2;" : "=f"(f705) : "f"(f135), "f"(f135));
  // PTX:794 fma.rn.f32 %f706, %f134, %f134, %f705
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f706) : "f"(f134), "f"(f134), "f"(f705));
  // PTX:795 fma.rn.f32 %f707, %f136, %f136, %f706
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f707) : "f"(f136), "f"(f136), "f"(f706));
  // PTX:796 sqrt.rn.f32 %f137, %f707
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f137) : "f"(f707));
  // PTX:797 setp.leu.f32 %p57, %f137, 0f00000000
  p57 = ((isnan(((float)(f137))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f137)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:798 mov.u32 %r246, 0
  asm("mov.u32 %0, 0;" : "=r"(r246) : );
  // PTX:799 mov.u32 %r247, %r246
  asm("mov.u32 %0, %1;" : "=r"(r247) : "r"(r246));
  // PTX:800 mov.u32 %r248, %r246
  asm("mov.u32 %0, %1;" : "=r"(r248) : "r"(r246));
  // PTX:801 @%p57 bra $L__BB1_64
  if (p57) { goto L_BB1_64; }
  // PTX:803 div.rn.f32 %f708, %f134, %f137
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f708) : "f"(f134), "f"(f137));
  // PTX:804 div.rn.f32 %f709, %f135, %f137
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f709) : "f"(f135), "f"(f137));
  // PTX:805 div.rn.f32 %f710, %f136, %f137
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f710) : "f"(f136), "f"(f137));
  // PTX:806 mov.b32 %r248, %f710
  asm("mov.b32 %0, %1;" : "=r"(r248) : "f"(f710));
  // PTX:807 mov.b32 %r247, %f709
  asm("mov.b32 %0, %1;" : "=r"(r247) : "f"(f709));
  // PTX:808 mov.b32 %r246, %f708
  asm("mov.b32 %0, %1;" : "=r"(r246) : "f"(f708));
  // PTX:810 $L__BB1_64:
L_BB1_64:;
  // PTX:811 mov.b32 %f138, %r246
  asm("mov.b32 %0, %1;" : "=f"(f138) : "r"(r246));
  // PTX:812 mov.b32 %f139, %r247
  asm("mov.b32 %0, %1;" : "=f"(f139) : "r"(r247));
  // PTX:813 mul.f32 %f711, %f1247, %f139
  asm("mul.f32 %0, %1, %2;" : "=f"(f711) : "f"(f1247), "f"(f139));
  // PTX:814 mov.b32 %f140, %r248
  asm("mov.b32 %0, %1;" : "=f"(f140) : "r"(r248));
  // PTX:815 fma.rn.f32 %f712, %f1246, %f138, %f711
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f712) : "f"(f1246), "f"(f138), "f"(f711));
  // PTX:816 fma.rn.f32 %f713, %f1248, %f140, %f712
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f713) : "f"(f1248), "f"(f140), "f"(f712));
  // PTX:817 setp.geu.f32 %p58, %f713, 0f00000000
  p58 = ((isnan(((float)(f713))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f713)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:818 @%p58 bra $L__BB1_66
  if (p58) { goto L_BB1_66; }
  // PTX:820 mov.b32 %f1224, %r237
  asm("mov.b32 %0, %1;" : "=f"(f1224) : "r"(r237));
  // PTX:821 mov.b32 %f1223, %r238
  asm("mov.b32 %0, %1;" : "=f"(f1223) : "r"(r238));
  // PTX:822 mov.b32 %f1222, %r239
  asm("mov.b32 %0, %1;" : "=f"(f1222) : "r"(r239));
  // PTX:823 neg.f32 %f714, %f1224
  asm("neg.f32 %0, %1;" : "=f"(f714) : "f"(f1224));
  // PTX:824 mov.b32 %r237, %f714
  asm("mov.b32 %0, %1;" : "=r"(r237) : "f"(f714));
  // PTX:825 neg.f32 %f715, %f1223
  asm("neg.f32 %0, %1;" : "=f"(f715) : "f"(f1223));
  // PTX:826 mov.b32 %r238, %f715
  asm("mov.b32 %0, %1;" : "=r"(r238) : "f"(f715));
  // PTX:827 neg.f32 %f716, %f1222
  asm("neg.f32 %0, %1;" : "=f"(f716) : "f"(f1222));
  // PTX:828 mov.b32 %r239, %f716
  asm("mov.b32 %0, %1;" : "=r"(r239) : "f"(f716));
  // PTX:829 neg.f32 %f717, %f138
  asm("neg.f32 %0, %1;" : "=f"(f717) : "f"(f138));
  // PTX:830 mov.b32 %r246, %f717
  asm("mov.b32 %0, %1;" : "=r"(r246) : "f"(f717));
  // PTX:831 neg.f32 %f718, %f139
  asm("neg.f32 %0, %1;" : "=f"(f718) : "f"(f139));
  // PTX:832 mov.b32 %r247, %f718
  asm("mov.b32 %0, %1;" : "=r"(r247) : "f"(f718));
  // PTX:833 neg.f32 %f719, %f140
  asm("neg.f32 %0, %1;" : "=f"(f719) : "f"(f140));
  // PTX:834 mov.b32 %r248, %f719
  asm("mov.b32 %0, %1;" : "=r"(r248) : "f"(f719));
  // PTX:836 $L__BB1_66:
L_BB1_66:;
  // PTX:837 mov.u32 %r240, %r225
  asm("mov.u32 %0, %1;" : "=r"(r240) : "r"(r225));
  // PTX:838 mov.u32 %r241, %r226
  asm("mov.u32 %0, %1;" : "=r"(r241) : "r"(r226));
  // PTX:839 mov.u32 %r242, %r227
  asm("mov.u32 %0, %1;" : "=r"(r242) : "r"(r227));
  // PTX:840 mov.u32 %r243, %r237
  asm("mov.u32 %0, %1;" : "=r"(r243) : "r"(r237));
  // PTX:841 mov.u32 %r244, %r238
  asm("mov.u32 %0, %1;" : "=r"(r244) : "r"(r238));
  // PTX:842 mov.u32 %r245, %r239
  asm("mov.u32 %0, %1;" : "=r"(r245) : "r"(r239));
  // PTX:844 $L__BB1_67:
L_BB1_67:;
  // PTX:845 mul.f32 %f1182, %f538, %f1225
  asm("mul.f32 %0, %1, %2;" : "=f"(f1182) : "f"(f538), "f"(f1225));
  // PTX:846 mul.f32 %f1181, %f538, %f1227
  asm("mul.f32 %0, %1, %2;" : "=f"(f1181) : "f"(f538), "f"(f1227));
  // PTX:847 mul.f32 %f1180, %f538, %f1226
  asm("mul.f32 %0, %1, %2;" : "=f"(f1180) : "f"(f538), "f"(f1226));
  // PTX:848 mov.b32 %f720, %r240
  asm("mov.b32 %0, %1;" : "=f"(f720) : "r"(r240));
  // PTX:849 mov.b32 %f721, %r243
  asm("mov.b32 %0, %1;" : "=f"(f721) : "r"(r243));
  // PTX:850 mov.b32 %f722, %r246
  asm("mov.b32 %0, %1;" : "=f"(f722) : "r"(r246));
  // PTX:851 mov.b32 %f723, %r241
  asm("mov.b32 %0, %1;" : "=f"(f723) : "r"(r241));
  // PTX:852 mov.b32 %f724, %r244
  asm("mov.b32 %0, %1;" : "=f"(f724) : "r"(r244));
  // PTX:853 mov.b32 %f725, %r247
  asm("mov.b32 %0, %1;" : "=f"(f725) : "r"(r247));
  // PTX:854 mov.b32 %f726, %r242
  asm("mov.b32 %0, %1;" : "=f"(f726) : "r"(r242));
  // PTX:855 mov.b32 %f727, %r245
  asm("mov.b32 %0, %1;" : "=f"(f727) : "r"(r245));
  // PTX:856 mov.b32 %f728, %r248
  asm("mov.b32 %0, %1;" : "=f"(f728) : "r"(r248));
  // PTX:857 mul.f32 %f729, %f1180, %f723
  asm("mul.f32 %0, %1, %2;" : "=f"(f729) : "f"(f1180), "f"(f723));
  // PTX:858 mul.f32 %f730, %f1180, %f724
  asm("mul.f32 %0, %1, %2;" : "=f"(f730) : "f"(f1180), "f"(f724));
  // PTX:859 mul.f32 %f731, %f1180, %f725
  asm("mul.f32 %0, %1, %2;" : "=f"(f731) : "f"(f1180), "f"(f725));
  // PTX:860 fma.rn.f32 %f732, %f1181, %f720, %f729
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f732) : "f"(f1181), "f"(f720), "f"(f729));
  // PTX:861 fma.rn.f32 %f733, %f1181, %f721, %f730
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f733) : "f"(f1181), "f"(f721), "f"(f730));
  // PTX:862 fma.rn.f32 %f734, %f1181, %f722, %f731
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f734) : "f"(f1181), "f"(f722), "f"(f731));
  // PTX:863 fma.rn.f32 %f1249, %f1182, %f726, %f732
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1249) : "f"(f1182), "f"(f726), "f"(f732));
  // PTX:864 fma.rn.f32 %f1250, %f1182, %f727, %f733
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1250) : "f"(f1182), "f"(f727), "f"(f733));
  // PTX:865 fma.rn.f32 %f1251, %f1182, %f728, %f734
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1251) : "f"(f1182), "f"(f728), "f"(f734));
  // PTX:866 bra.uni $L__BB1_68
  goto L_BB1_68;
  // PTX:868 $L__BB1_49:
L_BB1_49:;
  // PTX:869 mul.f32 %f1214, %f538, %f1225
  asm("mul.f32 %0, %1, %2;" : "=f"(f1214) : "f"(f538), "f"(f1225));
  // PTX:870 mul.f32 %f1213, %f538, %f1227
  asm("mul.f32 %0, %1, %2;" : "=f"(f1213) : "f"(f538), "f"(f1227));
  // PTX:871 mul.f32 %f1212, %f538, %f1226
  asm("mul.f32 %0, %1, %2;" : "=f"(f1212) : "f"(f538), "f"(f1226));
  // PTX:872 rcp.rn.f32 %f548, %f68
  asm("rcp.rn.f32 %0, %1;" : "=f"(f548) : "f"(f68));
  // PTX:873 mul.f32 %f549, %f12, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f549) : "f"(f12), "f"(f22));
  // PTX:874 mul.f32 %f550, %f13, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f550) : "f"(f13), "f"(f21));
  // PTX:875 sub.f32 %f551, %f550, %f549
  asm("sub.f32 %0, %1, %2;" : "=f"(f551) : "f"(f550), "f"(f549));
  // PTX:876 mul.f32 %f552, %f13, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f552) : "f"(f13), "f"(f20));
  // PTX:877 mul.f32 %f553, %f11, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f553) : "f"(f11), "f"(f22));
  // PTX:878 sub.f32 %f554, %f553, %f552
  asm("sub.f32 %0, %1, %2;" : "=f"(f554) : "f"(f553), "f"(f552));
  // PTX:879 mul.f32 %f555, %f11, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f555) : "f"(f11), "f"(f21));
  // PTX:880 mul.f32 %f556, %f12, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f556) : "f"(f12), "f"(f20));
  // PTX:881 sub.f32 %f557, %f556, %f555
  asm("sub.f32 %0, %1, %2;" : "=f"(f557) : "f"(f556), "f"(f555));
  // PTX:882 mul.f32 %f558, %f13, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f558) : "f"(f13), "f"(f18));
  // PTX:883 mul.f32 %f559, %f12, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f559) : "f"(f12), "f"(f19));
  // PTX:884 sub.f32 %f560, %f559, %f558
  asm("sub.f32 %0, %1, %2;" : "=f"(f560) : "f"(f559), "f"(f558));
  // PTX:885 mul.f32 %f561, %f11, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f561) : "f"(f11), "f"(f19));
  // PTX:886 mul.f32 %f562, %f13, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f562) : "f"(f13), "f"(f17));
  // PTX:887 sub.f32 %f563, %f562, %f561
  asm("sub.f32 %0, %1, %2;" : "=f"(f563) : "f"(f562), "f"(f561));
  // PTX:888 mul.f32 %f564, %f12, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f564) : "f"(f12), "f"(f17));
  // PTX:889 mul.f32 %f565, %f11, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f565) : "f"(f11), "f"(f18));
  // PTX:890 sub.f32 %f566, %f565, %f564
  asm("sub.f32 %0, %1, %2;" : "=f"(f566) : "f"(f565), "f"(f564));
  // PTX:891 mul.f32 %f567, %f65, %f548
  asm("mul.f32 %0, %1, %2;" : "=f"(f567) : "f"(f65), "f"(f548));
  // PTX:892 mul.f32 %f568, %f66, %f548
  asm("mul.f32 %0, %1, %2;" : "=f"(f568) : "f"(f66), "f"(f548));
  // PTX:893 mul.f32 %f569, %f67, %f548
  asm("mul.f32 %0, %1, %2;" : "=f"(f569) : "f"(f67), "f"(f548));
  // PTX:894 mul.f32 %f570, %f551, %f548
  asm("mul.f32 %0, %1, %2;" : "=f"(f570) : "f"(f551), "f"(f548));
  // PTX:895 mul.f32 %f571, %f554, %f548
  asm("mul.f32 %0, %1, %2;" : "=f"(f571) : "f"(f554), "f"(f548));
  // PTX:896 mul.f32 %f572, %f557, %f548
  asm("mul.f32 %0, %1, %2;" : "=f"(f572) : "f"(f557), "f"(f548));
  // PTX:897 mul.f32 %f573, %f560, %f548
  asm("mul.f32 %0, %1, %2;" : "=f"(f573) : "f"(f560), "f"(f548));
  // PTX:898 mul.f32 %f574, %f563, %f548
  asm("mul.f32 %0, %1, %2;" : "=f"(f574) : "f"(f563), "f"(f548));
  // PTX:899 mul.f32 %f575, %f566, %f548
  asm("mul.f32 %0, %1, %2;" : "=f"(f575) : "f"(f566), "f"(f548));
  // PTX:900 mul.f32 %f576, %f1212, %f568
  asm("mul.f32 %0, %1, %2;" : "=f"(f576) : "f"(f1212), "f"(f568));
  // PTX:901 mul.f32 %f577, %f1212, %f571
  asm("mul.f32 %0, %1, %2;" : "=f"(f577) : "f"(f1212), "f"(f571));
  // PTX:902 mul.f32 %f578, %f1212, %f574
  asm("mul.f32 %0, %1, %2;" : "=f"(f578) : "f"(f1212), "f"(f574));
  // PTX:903 fma.rn.f32 %f579, %f1213, %f567, %f576
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f579) : "f"(f1213), "f"(f567), "f"(f576));
  // PTX:904 fma.rn.f32 %f580, %f1213, %f570, %f577
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f580) : "f"(f1213), "f"(f570), "f"(f577));
  // PTX:905 fma.rn.f32 %f581, %f1213, %f573, %f578
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f581) : "f"(f1213), "f"(f573), "f"(f578));
  // PTX:906 fma.rn.f32 %f1249, %f1214, %f569, %f579
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1249) : "f"(f1214), "f"(f569), "f"(f579));
  // PTX:907 fma.rn.f32 %f1250, %f1214, %f572, %f580
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1250) : "f"(f1214), "f"(f572), "f"(f580));
  // PTX:908 fma.rn.f32 %f1251, %f1214, %f575, %f581
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1251) : "f"(f1214), "f"(f575), "f"(f581));
  // PTX:910 $L__BB1_68:
L_BB1_68:;
  // PTX:911 mov.b32 %f1185, %r13
  asm("mov.b32 %0, %1;" : "=f"(f1185) : "r"(r13));
  // PTX:912 mov.b32 %f1184, %r12
  asm("mov.b32 %0, %1;" : "=f"(f1184) : "r"(r12));
  // PTX:913 mov.b32 %f1183, %r11
  asm("mov.b32 %0, %1;" : "=f"(f1183) : "r"(r11));
  // PTX:914 add.f32 %f739, %f1183, %f1249
  asm("add.f32 %0, %1, %2;" : "=f"(f739) : "f"(f1183), "f"(f1249));
  // PTX:915 add.f32 %f741, %f1184, %f1250
  asm("add.f32 %0, %1, %2;" : "=f"(f741) : "f"(f1184), "f"(f1250));
  // PTX:916 add.f32 %f743, %f1185, %f1251
  asm("add.f32 %0, %1, %2;" : "=f"(f743) : "f"(f1185), "f"(f1251));
  // PTX:917 mov.b32 %r254, %f739
  asm("mov.b32 %0, %1;" : "=r"(r254) : "f"(f739));
  // PTX:918 mov.b32 %r253, %f741
  asm("mov.b32 %0, %1;" : "=r"(r253) : "f"(f741));
  // PTX:919 mov.b32 %r252, %f743
  asm("mov.b32 %0, %1;" : "=r"(r252) : "f"(f743));
  // PTX:921 $L__BB1_69:
L_BB1_69:;
  // PTX:922 cvt.s64.s32 %rd236, %r9
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd236) : "r"(r9));
  // PTX:923 cvt.s64.s32 %rd235, %r8
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd235) : "r"(r8));
  // PTX:924 cvt.s64.s32 %rd234, %r7
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd234) : "r"(r7));
  // PTX:925 cvt.s64.s32 %rd233, %r6
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd233) : "r"(r6));
  // PTX:926 ld.param.u64 %rd232, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_38]
  rd232 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param38 + (0))));
  // PTX:927 mul.lo.s64 %rd231, %rd279, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd231) : "l"(rd279));
  // PTX:928 add.s64 %rd175, %rd173, %rd231
  asm("add.s64 %0, %1, %2;" : "=l"(rd175) : "l"(rd173), "l"(rd231));
  // PTX:929 ld.global.f32 %f744, [%rd175]
  f744 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd175) + (0)))));
  // PTX:930 ld.global.f32 %f745, [%rd175+4]
  f745 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd175) + (4)))));
  // PTX:931 mul.f32 %f746, %f745, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f746) : "f"(f745), "f"(f17));
  // PTX:932 mul.f32 %f747, %f745, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f747) : "f"(f745), "f"(f18));
  // PTX:933 mul.f32 %f748, %f745, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f748) : "f"(f745), "f"(f19));
  // PTX:934 fma.rn.f32 %f749, %f744, %f11, %f746
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f749) : "f"(f744), "f"(f11), "f"(f746));
  // PTX:935 fma.rn.f32 %f750, %f744, %f12, %f747
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f750) : "f"(f744), "f"(f12), "f"(f747));
  // PTX:936 fma.rn.f32 %f751, %f744, %f13, %f748
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f751) : "f"(f744), "f"(f13), "f"(f748));
  // PTX:937 ld.global.f32 %f752, [%rd175+8]
  f752 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd175) + (8)))));
  // PTX:938 fma.rn.f32 %f141, %f752, %f20, %f749
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f141) : "f"(f752), "f"(f20), "f"(f749));
  // PTX:939 fma.rn.f32 %f142, %f752, %f21, %f750
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f142) : "f"(f752), "f"(f21), "f"(f750));
  // PTX:940 fma.rn.f32 %f143, %f752, %f22, %f751
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f143) : "f"(f752), "f"(f22), "f"(f751));
  // PTX:941 cvta.to.global.u64 %rd176, %rd232
  rd176 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd232));
  // PTX:942 add.s64 %rd178, %rd176, %rd159
  asm("add.s64 %0, %1, %2;" : "=l"(rd178) : "l"(rd176), "l"(rd159));
  // PTX:943 ld.global.f32 %f753, [%rd178]
  f753 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (0)))));
  // PTX:944 sub.f32 %f144, %f55, %f753
  asm("sub.f32 %0, %1, %2;" : "=f"(f144) : "f"(f55), "f"(f753));
  // PTX:945 ld.global.f32 %f754, [%rd178+4]
  f754 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (4)))));
  // PTX:946 sub.f32 %f145, %f56, %f754
  asm("sub.f32 %0, %1, %2;" : "=f"(f145) : "f"(f56), "f"(f754));
  // PTX:947 ld.global.f32 %f755, [%rd178+8]
  f755 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (8)))));
  // PTX:948 sub.f32 %f146, %f57, %f755
  asm("sub.f32 %0, %1, %2;" : "=f"(f146) : "f"(f57), "f"(f755));
  // PTX:949 mul.lo.s64 %rd49, %rd233, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd49) : "l"(rd233));
  // PTX:950 add.s64 %rd45, %rd176, %rd49
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd176), "l"(rd49));
  // PTX:951 mul.lo.s64 %rd50, %rd234, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd50) : "l"(rd234));
  // PTX:952 add.s64 %rd46, %rd176, %rd50
  asm("add.s64 %0, %1, %2;" : "=l"(rd46) : "l"(rd176), "l"(rd50));
  // PTX:953 mul.lo.s64 %rd179, %rd235, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd179) : "l"(rd235));
  // PTX:954 add.s64 %rd47, %rd176, %rd179
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd176), "l"(rd179));
  // PTX:955 mul.lo.s64 %rd180, %rd236, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd180) : "l"(rd236));
  // PTX:956 add.s64 %rd48, %rd176, %rd180
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd176), "l"(rd180));
  // PTX:957 setp.eq.s64 %p59, %rd232, 0
  p59 = (((long long)(rd232)) == ((long long)(0)));
  // PTX:958 @%p59 bra $L__BB1_71
  if (p59) { goto L_BB1_71; }
  // PTX:960 ld.global.f32 %f756, [%rd45]
  f756 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:961 sub.f32 %f757, %f14, %f756
  asm("sub.f32 %0, %1, %2;" : "=f"(f757) : "f"(f14), "f"(f756));
  // PTX:962 ld.global.f32 %f758, [%rd45+4]
  f758 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (4)))));
  // PTX:963 sub.f32 %f759, %f15, %f758
  asm("sub.f32 %0, %1, %2;" : "=f"(f759) : "f"(f15), "f"(f758));
  // PTX:964 ld.global.f32 %f760, [%rd45+8]
  f760 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (8)))));
  // PTX:965 sub.f32 %f761, %f16, %f760
  asm("sub.f32 %0, %1, %2;" : "=f"(f761) : "f"(f16), "f"(f760));
  // PTX:966 mul.f32 %f1257, %f757, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1257) : "f"(f757), "f"(f488));
  // PTX:967 mul.f32 %f1256, %f759, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1256) : "f"(f759), "f"(f488));
  // PTX:968 mul.f32 %f1255, %f761, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1255) : "f"(f761), "f"(f488));
  // PTX:969 ld.global.f32 %f762, [%rd46]
  f762 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))));
  // PTX:970 sub.f32 %f763, %f11, %f762
  asm("sub.f32 %0, %1, %2;" : "=f"(f763) : "f"(f11), "f"(f762));
  // PTX:971 ld.global.f32 %f764, [%rd46+4]
  f764 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (4)))));
  // PTX:972 sub.f32 %f765, %f12, %f764
  asm("sub.f32 %0, %1, %2;" : "=f"(f765) : "f"(f12), "f"(f764));
  // PTX:973 ld.global.f32 %f766, [%rd46+8]
  f766 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (8)))));
  // PTX:974 sub.f32 %f767, %f13, %f766
  asm("sub.f32 %0, %1, %2;" : "=f"(f767) : "f"(f13), "f"(f766));
  // PTX:975 mul.f32 %f1258, %f763, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1258) : "f"(f763), "f"(f488));
  // PTX:976 mul.f32 %f1259, %f765, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1259) : "f"(f765), "f"(f488));
  // PTX:977 mul.f32 %f1260, %f767, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1260) : "f"(f767), "f"(f488));
  // PTX:978 ld.global.f32 %f768, [%rd47]
  f768 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))));
  // PTX:979 sub.f32 %f769, %f17, %f768
  asm("sub.f32 %0, %1, %2;" : "=f"(f769) : "f"(f17), "f"(f768));
  // PTX:980 ld.global.f32 %f770, [%rd47+4]
  f770 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (4)))));
  // PTX:981 sub.f32 %f771, %f18, %f770
  asm("sub.f32 %0, %1, %2;" : "=f"(f771) : "f"(f18), "f"(f770));
  // PTX:982 ld.global.f32 %f772, [%rd47+8]
  f772 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (8)))));
  // PTX:983 sub.f32 %f773, %f19, %f772
  asm("sub.f32 %0, %1, %2;" : "=f"(f773) : "f"(f19), "f"(f772));
  // PTX:984 mul.f32 %f1254, %f769, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1254) : "f"(f769), "f"(f488));
  // PTX:985 mul.f32 %f1253, %f771, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1253) : "f"(f771), "f"(f488));
  // PTX:986 mul.f32 %f1252, %f773, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1252) : "f"(f773), "f"(f488));
  // PTX:987 ld.global.f32 %f774, [%rd48]
  f774 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:988 sub.f32 %f775, %f20, %f774
  asm("sub.f32 %0, %1, %2;" : "=f"(f775) : "f"(f20), "f"(f774));
  // PTX:989 ld.global.f32 %f776, [%rd48+4]
  f776 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (4)))));
  // PTX:990 sub.f32 %f777, %f21, %f776
  asm("sub.f32 %0, %1, %2;" : "=f"(f777) : "f"(f21), "f"(f776));
  // PTX:991 ld.global.f32 %f778, [%rd48+8]
  f778 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (8)))));
  // PTX:992 sub.f32 %f779, %f22, %f778
  asm("sub.f32 %0, %1, %2;" : "=f"(f779) : "f"(f22), "f"(f778));
  // PTX:993 mul.f32 %f1261, %f775, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1261) : "f"(f775), "f"(f488));
  // PTX:994 mul.f32 %f1262, %f777, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1262) : "f"(f777), "f"(f488));
  // PTX:995 mul.f32 %f1263, %f779, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1263) : "f"(f779), "f"(f488));
  // PTX:996 bra.uni $L__BB1_72
  goto L_BB1_72;
  // PTX:998 $L__BB1_71:
L_BB1_71:;
  // PTX:999 ld.f32 %f1257, [%rd49]
  f1257 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd49) + (0))));
  // PTX:1000 ld.f32 %f1256, [%rd49+4]
  f1256 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd49) + (4))));
  // PTX:1001 ld.f32 %f1255, [%rd49+8]
  f1255 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd49) + (8))));
  // PTX:1002 ld.f32 %f1258, [%rd50]
  f1258 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd50) + (0))));
  // PTX:1003 ld.f32 %f1259, [%rd50+4]
  f1259 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd50) + (4))));
  // PTX:1004 ld.f32 %f1260, [%rd50+8]
  f1260 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd50) + (8))));
  // PTX:1005 ld.f32 %f1254, [%rd179]
  f1254 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd179) + (0))));
  // PTX:1006 ld.f32 %f1253, [%rd179+4]
  f1253 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd179) + (4))));
  // PTX:1007 ld.f32 %f1252, [%rd179+8]
  f1252 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd179) + (8))));
  // PTX:1008 ld.f32 %f1261, [%rd180]
  f1261 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd180) + (0))));
  // PTX:1009 ld.f32 %f1262, [%rd180+4]
  f1262 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd180) + (4))));
  // PTX:1010 ld.f32 %f1263, [%rd180+8]
  f1263 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd180) + (8))));
  // PTX:1012 $L__BB1_72:
L_BB1_72:;
  // PTX:1013 ld.param.u64 %rd244, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_38]
  rd244 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param38 + (0))));
  // PTX:1014 setp.eq.s64 %p104, %rd244, 0
  p104 = (((long long)(rd244)) == ((long long)(0)));
  // PTX:1015 mov.b32 %f1191, %r13
  asm("mov.b32 %0, %1;" : "=f"(f1191) : "r"(r13));
  // PTX:1016 sub.f32 %f1190, %f1191, %f9
  asm("sub.f32 %0, %1, %2;" : "=f"(f1190) : "f"(f1191), "f"(f9));
  // PTX:1017 mov.b32 %f1189, %r12
  asm("mov.b32 %0, %1;" : "=f"(f1189) : "r"(r12));
  // PTX:1018 sub.f32 %f1188, %f1189, %f6
  asm("sub.f32 %0, %1, %2;" : "=f"(f1188) : "f"(f1189), "f"(f6));
  // PTX:1019 mov.b32 %f1187, %r11
  asm("mov.b32 %0, %1;" : "=f"(f1187) : "r"(r11));
  // PTX:1020 sub.f32 %f1186, %f1187, %f3
  asm("sub.f32 %0, %1, %2;" : "=f"(f1186) : "f"(f1187), "f"(f3));
  // PTX:1021 fma.rn.f32 %f780, %f1186, %f1258, %f1257
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f780) : "f"(f1186), "f"(f1258), "f"(f1257));
  // PTX:1022 fma.rn.f32 %f781, %f1186, %f1259, %f1256
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f781) : "f"(f1186), "f"(f1259), "f"(f1256));
  // PTX:1023 fma.rn.f32 %f782, %f1186, %f1260, %f1255
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f782) : "f"(f1186), "f"(f1260), "f"(f1255));
  // PTX:1024 fma.rn.f32 %f783, %f1188, %f1254, %f780
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f783) : "f"(f1188), "f"(f1254), "f"(f780));
  // PTX:1025 fma.rn.f32 %f784, %f1188, %f1253, %f781
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f784) : "f"(f1188), "f"(f1253), "f"(f781));
  // PTX:1026 fma.rn.f32 %f785, %f1188, %f1252, %f782
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f785) : "f"(f1188), "f"(f1252), "f"(f782));
  // PTX:1027 fma.rn.f32 %f183, %f1190, %f1261, %f783
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f183) : "f"(f1190), "f"(f1261), "f"(f783));
  // PTX:1028 fma.rn.f32 %f184, %f1190, %f1262, %f784
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f184) : "f"(f1190), "f"(f1262), "f"(f784));
  // PTX:1029 fma.rn.f32 %f185, %f1190, %f1263, %f785
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f185) : "f"(f1190), "f"(f1263), "f"(f785));
  // PTX:1030 mov.b32 %f186, %r254
  asm("mov.b32 %0, %1;" : "=f"(f186) : "r"(r254));
  // PTX:1031 mov.b32 %f187, %r253
  asm("mov.b32 %0, %1;" : "=f"(f187) : "r"(r253));
  // PTX:1032 mov.b32 %f188, %r252
  asm("mov.b32 %0, %1;" : "=f"(f188) : "r"(r252));
  // PTX:1033 @%p104 bra $L__BB1_74
  if (p104) { goto L_BB1_74; }
  // PTX:1035 ld.global.f32 %f786, [%rd45]
  f786 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:1036 sub.f32 %f787, %f14, %f786
  asm("sub.f32 %0, %1, %2;" : "=f"(f787) : "f"(f14), "f"(f786));
  // PTX:1037 ld.global.f32 %f788, [%rd45+4]
  f788 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (4)))));
  // PTX:1038 sub.f32 %f789, %f15, %f788
  asm("sub.f32 %0, %1, %2;" : "=f"(f789) : "f"(f15), "f"(f788));
  // PTX:1039 ld.global.f32 %f790, [%rd45+8]
  f790 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (8)))));
  // PTX:1040 sub.f32 %f791, %f16, %f790
  asm("sub.f32 %0, %1, %2;" : "=f"(f791) : "f"(f16), "f"(f790));
  // PTX:1041 mul.f32 %f1269, %f787, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1269) : "f"(f787), "f"(f488));
  // PTX:1042 mul.f32 %f1268, %f789, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1268) : "f"(f789), "f"(f488));
  // PTX:1043 mul.f32 %f1267, %f791, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1267) : "f"(f791), "f"(f488));
  // PTX:1044 ld.global.f32 %f792, [%rd46]
  f792 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (0)))));
  // PTX:1045 sub.f32 %f793, %f11, %f792
  asm("sub.f32 %0, %1, %2;" : "=f"(f793) : "f"(f11), "f"(f792));
  // PTX:1046 ld.global.f32 %f794, [%rd46+4]
  f794 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (4)))));
  // PTX:1047 sub.f32 %f795, %f12, %f794
  asm("sub.f32 %0, %1, %2;" : "=f"(f795) : "f"(f12), "f"(f794));
  // PTX:1048 ld.global.f32 %f796, [%rd46+8]
  f796 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd46) + (8)))));
  // PTX:1049 sub.f32 %f797, %f13, %f796
  asm("sub.f32 %0, %1, %2;" : "=f"(f797) : "f"(f13), "f"(f796));
  // PTX:1050 mul.f32 %f1270, %f793, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1270) : "f"(f793), "f"(f488));
  // PTX:1051 mul.f32 %f1271, %f795, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1271) : "f"(f795), "f"(f488));
  // PTX:1052 mul.f32 %f1272, %f797, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1272) : "f"(f797), "f"(f488));
  // PTX:1053 ld.global.f32 %f798, [%rd47]
  f798 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))));
  // PTX:1054 sub.f32 %f799, %f17, %f798
  asm("sub.f32 %0, %1, %2;" : "=f"(f799) : "f"(f17), "f"(f798));
  // PTX:1055 ld.global.f32 %f800, [%rd47+4]
  f800 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (4)))));
  // PTX:1056 sub.f32 %f801, %f18, %f800
  asm("sub.f32 %0, %1, %2;" : "=f"(f801) : "f"(f18), "f"(f800));
  // PTX:1057 ld.global.f32 %f802, [%rd47+8]
  f802 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (8)))));
  // PTX:1058 sub.f32 %f803, %f19, %f802
  asm("sub.f32 %0, %1, %2;" : "=f"(f803) : "f"(f19), "f"(f802));
  // PTX:1059 mul.f32 %f1266, %f799, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1266) : "f"(f799), "f"(f488));
  // PTX:1060 mul.f32 %f1265, %f801, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1265) : "f"(f801), "f"(f488));
  // PTX:1061 mul.f32 %f1264, %f803, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1264) : "f"(f803), "f"(f488));
  // PTX:1062 ld.global.f32 %f804, [%rd48]
  f804 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:1063 sub.f32 %f805, %f20, %f804
  asm("sub.f32 %0, %1, %2;" : "=f"(f805) : "f"(f20), "f"(f804));
  // PTX:1064 ld.global.f32 %f806, [%rd48+4]
  f806 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (4)))));
  // PTX:1065 sub.f32 %f807, %f21, %f806
  asm("sub.f32 %0, %1, %2;" : "=f"(f807) : "f"(f21), "f"(f806));
  // PTX:1066 ld.global.f32 %f808, [%rd48+8]
  f808 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (8)))));
  // PTX:1067 sub.f32 %f809, %f22, %f808
  asm("sub.f32 %0, %1, %2;" : "=f"(f809) : "f"(f22), "f"(f808));
  // PTX:1068 mul.f32 %f1273, %f805, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1273) : "f"(f805), "f"(f488));
  // PTX:1069 mul.f32 %f1274, %f807, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1274) : "f"(f807), "f"(f488));
  // PTX:1070 mul.f32 %f1275, %f809, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1275) : "f"(f809), "f"(f488));
  // PTX:1071 bra.uni $L__BB1_75
  goto L_BB1_75;
  // PTX:1073 $L__BB1_74:
L_BB1_74:;
  // PTX:1074 ld.f32 %f1269, [%rd49]
  f1269 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd49) + (0))));
  // PTX:1075 ld.f32 %f1268, [%rd49+4]
  f1268 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd49) + (4))));
  // PTX:1076 ld.f32 %f1267, [%rd49+8]
  f1267 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd49) + (8))));
  // PTX:1077 ld.f32 %f1270, [%rd50]
  f1270 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd50) + (0))));
  // PTX:1078 ld.f32 %f1271, [%rd50+4]
  f1271 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd50) + (4))));
  // PTX:1079 ld.f32 %f1272, [%rd50+8]
  f1272 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd50) + (8))));
  // PTX:1080 ld.f32 %f1266, [%rd179]
  f1266 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd179) + (0))));
  // PTX:1081 ld.f32 %f1265, [%rd179+4]
  f1265 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd179) + (4))));
  // PTX:1082 ld.f32 %f1264, [%rd179+8]
  f1264 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd179) + (8))));
  // PTX:1083 ld.f32 %f1273, [%rd180]
  f1273 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd180) + (0))));
  // PTX:1084 ld.f32 %f1274, [%rd180+4]
  f1274 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd180) + (4))));
  // PTX:1085 ld.f32 %f1275, [%rd180+8]
  f1275 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd180) + (8))));
  // PTX:1087 $L__BB1_75:
L_BB1_75:;
  // PTX:1088 cvt.s64.s32 %rd275, %rd283
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd275) : "l"(rd283));
  // PTX:1089 shl.b64 %rd274, %rd275, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd274) : "l"(rd275));
  // PTX:1090 ld.param.f32 %f1194, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_28]
  f1194 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param28 + (0))));
  // PTX:1091 min.f32 %f1193, %f1194, %f532
  asm("min.f32 %0, %1, %2;" : "=f"(f1193) : "f"(f1194), "f"(f532));
  // PTX:1092 ld.param.f32 %f1192, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_36]
  f1192 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param36 + (0))));
  // PTX:1093 mul.f32 %f811, %f144, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f811) : "f"(f144), "f"(f488));
  // PTX:1094 mul.f32 %f812, %f145, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f812) : "f"(f145), "f"(f488));
  // PTX:1095 mul.f32 %f813, %f146, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f813) : "f"(f146), "f"(f488));
  // PTX:1096 sub.f32 %f814, %f186, %f3
  asm("sub.f32 %0, %1, %2;" : "=f"(f814) : "f"(f186), "f"(f3));
  // PTX:1097 sub.f32 %f815, %f187, %f6
  asm("sub.f32 %0, %1, %2;" : "=f"(f815) : "f"(f187), "f"(f6));
  // PTX:1098 sub.f32 %f816, %f188, %f9
  asm("sub.f32 %0, %1, %2;" : "=f"(f816) : "f"(f188), "f"(f9));
  // PTX:1099 fma.rn.f32 %f817, %f814, %f1270, %f1269
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f817) : "f"(f814), "f"(f1270), "f"(f1269));
  // PTX:1100 fma.rn.f32 %f818, %f814, %f1271, %f1268
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f818) : "f"(f814), "f"(f1271), "f"(f1268));
  // PTX:1101 fma.rn.f32 %f819, %f814, %f1272, %f1267
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f819) : "f"(f814), "f"(f1272), "f"(f1267));
  // PTX:1102 fma.rn.f32 %f820, %f815, %f1266, %f817
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f820) : "f"(f815), "f"(f1266), "f"(f817));
  // PTX:1103 fma.rn.f32 %f821, %f815, %f1265, %f818
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f821) : "f"(f815), "f"(f1265), "f"(f818));
  // PTX:1104 fma.rn.f32 %f822, %f815, %f1264, %f819
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f822) : "f"(f815), "f"(f1264), "f"(f819));
  // PTX:1105 fma.rn.f32 %f823, %f816, %f1273, %f820
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f823) : "f"(f816), "f"(f1273), "f"(f820));
  // PTX:1106 fma.rn.f32 %f824, %f816, %f1274, %f821
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f824) : "f"(f816), "f"(f1274), "f"(f821));
  // PTX:1107 fma.rn.f32 %f825, %f816, %f1275, %f822
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f825) : "f"(f816), "f"(f1275), "f"(f822));
  // PTX:1108 add.f32 %f826, %f141, %f823
  asm("add.f32 %0, %1, %2;" : "=f"(f826) : "f"(f141), "f"(f823));
  // PTX:1109 add.f32 %f827, %f142, %f824
  asm("add.f32 %0, %1, %2;" : "=f"(f827) : "f"(f142), "f"(f824));
  // PTX:1110 add.f32 %f828, %f143, %f825
  asm("add.f32 %0, %1, %2;" : "=f"(f828) : "f"(f143), "f"(f825));
  // PTX:1111 add.f32 %f829, %f141, %f183
  asm("add.f32 %0, %1, %2;" : "=f"(f829) : "f"(f141), "f"(f183));
  // PTX:1112 sub.f32 %f830, %f811, %f829
  asm("sub.f32 %0, %1, %2;" : "=f"(f830) : "f"(f811), "f"(f829));
  // PTX:1113 add.f32 %f831, %f142, %f184
  asm("add.f32 %0, %1, %2;" : "=f"(f831) : "f"(f142), "f"(f184));
  // PTX:1114 sub.f32 %f832, %f812, %f831
  asm("sub.f32 %0, %1, %2;" : "=f"(f832) : "f"(f812), "f"(f831));
  // PTX:1115 mul.f32 %f833, %f832, %f1226
  asm("mul.f32 %0, %1, %2;" : "=f"(f833) : "f"(f832), "f"(f1226));
  // PTX:1116 add.f32 %f834, %f143, %f185
  asm("add.f32 %0, %1, %2;" : "=f"(f834) : "f"(f143), "f"(f185));
  // PTX:1117 sub.f32 %f835, %f813, %f834
  asm("sub.f32 %0, %1, %2;" : "=f"(f835) : "f"(f813), "f"(f834));
  // PTX:1118 fma.rn.f32 %f836, %f830, %f1227, %f833
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f836) : "f"(f830), "f"(f1227), "f"(f833));
  // PTX:1119 fma.rn.f32 %f837, %f835, %f1225, %f836
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f837) : "f"(f835), "f"(f1225), "f"(f836));
  // PTX:1120 mul.f32 %f838, %f60, %f837
  asm("mul.f32 %0, %1, %2;" : "=f"(f838) : "f"(f60), "f"(f837));
  // PTX:1121 mul.f32 %f839, %f58, %f1193
  asm("mul.f32 %0, %1, %2;" : "=f"(f839) : "f"(f58), "f"(f1193));
  // PTX:1122 sub.f32 %f840, %f839, %f838
  asm("sub.f32 %0, %1, %2;" : "=f"(f840) : "f"(f839), "f"(f838));
  // PTX:1123 mov.f32 %f1280, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1280) : );
  // PTX:1124 max.f32 %f225, %f840, %f1280
  asm("max.f32 %0, %1, %2;" : "=f"(f225) : "f"(f840), "f"(f1280));
  // PTX:1125 sub.f32 %f841, %f811, %f826
  asm("sub.f32 %0, %1, %2;" : "=f"(f841) : "f"(f811), "f"(f826));
  // PTX:1126 sub.f32 %f842, %f812, %f827
  asm("sub.f32 %0, %1, %2;" : "=f"(f842) : "f"(f812), "f"(f827));
  // PTX:1127 sub.f32 %f843, %f813, %f828
  asm("sub.f32 %0, %1, %2;" : "=f"(f843) : "f"(f813), "f"(f828));
  // PTX:1128 mul.f32 %f844, %f842, %f1226
  asm("mul.f32 %0, %1, %2;" : "=f"(f844) : "f"(f842), "f"(f1226));
  // PTX:1129 fma.rn.f32 %f845, %f841, %f1227, %f844
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f845) : "f"(f841), "f"(f1227), "f"(f844));
  // PTX:1130 fma.rn.f32 %f846, %f843, %f1225, %f845
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f846) : "f"(f843), "f"(f1225), "f"(f845));
  // PTX:1131 mul.f32 %f847, %f846, %f1227
  asm("mul.f32 %0, %1, %2;" : "=f"(f847) : "f"(f846), "f"(f1227));
  // PTX:1132 mul.f32 %f848, %f846, %f1226
  asm("mul.f32 %0, %1, %2;" : "=f"(f848) : "f"(f846), "f"(f1226));
  // PTX:1133 mul.f32 %f849, %f846, %f1225
  asm("mul.f32 %0, %1, %2;" : "=f"(f849) : "f"(f846), "f"(f1225));
  // PTX:1134 sub.f32 %f850, %f841, %f847
  asm("sub.f32 %0, %1, %2;" : "=f"(f850) : "f"(f841), "f"(f847));
  // PTX:1135 sub.f32 %f851, %f842, %f848
  asm("sub.f32 %0, %1, %2;" : "=f"(f851) : "f"(f842), "f"(f848));
  // PTX:1136 sub.f32 %f852, %f843, %f849
  asm("sub.f32 %0, %1, %2;" : "=f"(f852) : "f"(f843), "f"(f849));
  // PTX:1137 add.s64 %rd187, %rd185, %rd274
  asm("add.s64 %0, %1, %2;" : "=l"(rd187) : "l"(rd185), "l"(rd274));
  // PTX:1138 ld.global.f32 %f853, [%rd187]
  f853 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (0)))));
  // PTX:1139 min.f32 %f854, %f1192, %f853
  asm("min.f32 %0, %1, %2;" : "=f"(f854) : "f"(f1192), "f"(f853));
  // PTX:1140 mul.f32 %f226, %f225, %f854
  asm("mul.f32 %0, %1, %2;" : "=f"(f226) : "f"(f225), "f"(f854));
  // PTX:1141 mul.f32 %f855, %f851, %f851
  asm("mul.f32 %0, %1, %2;" : "=f"(f855) : "f"(f851), "f"(f851));
  // PTX:1142 fma.rn.f32 %f856, %f850, %f850, %f855
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f856) : "f"(f850), "f"(f850), "f"(f855));
  // PTX:1143 fma.rn.f32 %f227, %f852, %f852, %f856
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f227) : "f"(f852), "f"(f852), "f"(f856));
  // PTX:1144 setp.leu.f32 %p61, %f226, 0f00000000
  p61 = ((isnan(((float)(f226))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f226)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1145 mov.f32 %f1276, %f1280
  asm("mov.f32 %0, %1;" : "=f"(f1276) : "f"(f1280));
  // PTX:1146 @%p61 bra $L__BB1_77
  if (p61) { goto L_BB1_77; }
  // PTX:1148 cvt.s64.s32 %rd277, %rd283
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd277) : "l"(rd283));
  // PTX:1149 shl.b64 %rd276, %rd277, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd276) : "l"(rd277));
  // PTX:1150 ld.param.f32 %f1215, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_35]
  f1215 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param35 + (0))));
  // PTX:1151 add.s64 %rd190, %rd188, %rd276
  asm("add.s64 %0, %1, %2;" : "=l"(rd190) : "l"(rd188), "l"(rd276));
  // PTX:1152 ld.global.f32 %f857, [%rd190]
  f857 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd190) + (0)))));
  // PTX:1153 sqrt.rn.f32 %f858, %f227
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f858) : "f"(f227));
  // PTX:1154 mov.f32 %f859, 0f322BCC77
  asm("mov.f32 %0, 0f322BCC77;" : "=f"(f859) : );
  // PTX:1155 max.f32 %f860, %f858, %f859
  asm("max.f32 %0, %1, %2;" : "=f"(f860) : "f"(f858), "f"(f859));
  // PTX:1156 div.rn.f32 %f861, %f226, %f860
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f861) : "f"(f226), "f"(f860));
  // PTX:1157 min.f32 %f862, %f1215, %f857
  asm("min.f32 %0, %1, %2;" : "=f"(f862) : "f"(f1215), "f"(f857));
  // PTX:1158 min.f32 %f1276, %f862, %f861
  asm("min.f32 %0, %1, %2;" : "=f"(f1276) : "f"(f862), "f"(f861));
  // PTX:1160 $L__BB1_77:
L_BB1_77:;
  // PTX:1161 ld.param.f32 %f1200, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_28]
  f1200 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param28 + (0))));
  // PTX:1162 min.f32 %f1199, %f1200, %f532
  asm("min.f32 %0, %1, %2;" : "=f"(f1199) : "f"(f1200), "f"(f532));
  // PTX:1163 fma.rn.f32 %f1198, %f60, %f488, %f1199
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1198) : "f"(f60), "f"(f488), "f"(f1199));
  // PTX:1164 ld.param.u64 %rd237, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_24]
  rd237 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param24 + (0))));
  // PTX:1165 mul.f32 %f1197, %f1225, %f1225
  asm("mul.f32 %0, %1, %2;" : "=f"(f1197) : "f"(f1225), "f"(f1225));
  // PTX:1166 mul.f32 %f1196, %f1226, %f1226
  asm("mul.f32 %0, %1, %2;" : "=f"(f1196) : "f"(f1226), "f"(f1226));
  // PTX:1167 mul.f32 %f1195, %f1227, %f1227
  asm("mul.f32 %0, %1, %2;" : "=f"(f1195) : "f"(f1227), "f"(f1227));
  // PTX:1168 setp.gt.f32 %p62, %f225, 0f00000000
  p62 = (!(isnan(((float)(f225))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f225)) > ((float)(as_f32(0x00000000u)))));
  // PTX:1169 selp.f32 %f866, %f1198, 0f00000000, %p62
  f866 = p62 ? f1198 : as_f32(0x00000000u);
  // PTX:1170 mul.f32 %f230, %f866, %f1195
  asm("mul.f32 %0, %1, %2;" : "=f"(f230) : "f"(f866), "f"(f1195));
  // PTX:1171 mul.f32 %f231, %f1226, %f1227
  asm("mul.f32 %0, %1, %2;" : "=f"(f231) : "f"(f1226), "f"(f1227));
  // PTX:1172 mul.f32 %f232, %f866, %f231
  asm("mul.f32 %0, %1, %2;" : "=f"(f232) : "f"(f866), "f"(f231));
  // PTX:1173 mul.f32 %f233, %f1225, %f1227
  asm("mul.f32 %0, %1, %2;" : "=f"(f233) : "f"(f1225), "f"(f1227));
  // PTX:1174 mul.f32 %f234, %f866, %f233
  asm("mul.f32 %0, %1, %2;" : "=f"(f234) : "f"(f866), "f"(f233));
  // PTX:1175 mul.f32 %f235, %f866, %f1196
  asm("mul.f32 %0, %1, %2;" : "=f"(f235) : "f"(f866), "f"(f1196));
  // PTX:1176 mul.f32 %f236, %f1225, %f1226
  asm("mul.f32 %0, %1, %2;" : "=f"(f236) : "f"(f1225), "f"(f1226));
  // PTX:1177 mul.f32 %f237, %f866, %f236
  asm("mul.f32 %0, %1, %2;" : "=f"(f237) : "f"(f866), "f"(f236));
  // PTX:1178 mul.f32 %f238, %f866, %f1197
  asm("mul.f32 %0, %1, %2;" : "=f"(f238) : "f"(f866), "f"(f1197));
  // PTX:1179 cvt.u32.u64 %r103, %rd7
  asm("cvt.u32.u64 %0, %1;" : "=r"(r103) : "l"(rd7));
  // PTX:1180 setp.eq.s32 %p63, %r6, %r103
  p63 = (((int)(r6)) == ((int)(r103)));
  // PTX:1181 cvta.to.global.u64 %rd191, %rd237
  rd191 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd237));
  // PTX:1182 add.s64 %rd51, %rd191, %rd49
  asm("add.s64 %0, %1, %2;" : "=l"(rd51) : "l"(rd191), "l"(rd49));
  // PTX:1183 mov.f32 %f1281, %f1280
  asm("mov.f32 %0, %1;" : "=f"(f1281) : "f"(f1280));
  // PTX:1184 mov.f32 %f1282, %f1280
  asm("mov.f32 %0, %1;" : "=f"(f1282) : "f"(f1280));
  // PTX:1185 @%p63 bra $L__BB1_79
  if (p63) { goto L_BB1_79; }
  // PTX:1187 ld.global.f32 %f867, [%rd51]
  f867 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))));
  // PTX:1188 mov.f32 %f868, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f868) : );
  // PTX:1189 sub.f32 %f1280, %f868, %f867
  asm("sub.f32 %0, %1, %2;" : "=f"(f1280) : "f"(f868), "f"(f867));
  // PTX:1190 ld.global.f32 %f869, [%rd51+4]
  f869 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (4)))));
  // PTX:1191 sub.f32 %f1281, %f868, %f869
  asm("sub.f32 %0, %1, %2;" : "=f"(f1281) : "f"(f868), "f"(f869));
  // PTX:1192 ld.global.f32 %f870, [%rd51+8]
  f870 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (8)))));
  // PTX:1193 sub.f32 %f1282, %f868, %f870
  asm("sub.f32 %0, %1, %2;" : "=f"(f1282) : "f"(f868), "f"(f870));
  // PTX:1195 $L__BB1_79:
L_BB1_79:;
  // PTX:1196 setp.eq.s32 %p64, %r7, %r103
  p64 = (((int)(r7)) == ((int)(r103)));
  // PTX:1197 add.s64 %rd52, %rd191, %rd50
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd191), "l"(rd50));
  // PTX:1198 @%p64 bra $L__BB1_81
  if (p64) { goto L_BB1_81; }
  // PTX:1200 ld.global.f32 %f871, [%rd52]
  f871 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:1201 ld.global.f32 %f872, [%rd52+4]
  f872 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:1202 ld.global.f32 %f873, [%rd52+8]
  f873 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:1203 fma.rn.f32 %f1280, %f871, %f52, %f1280
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1280) : "f"(f871), "f"(f52), "f"(f1280));
  // PTX:1204 fma.rn.f32 %f1281, %f872, %f52, %f1281
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1281) : "f"(f872), "f"(f52), "f"(f1281));
  // PTX:1205 fma.rn.f32 %f1282, %f873, %f52, %f1282
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1282) : "f"(f873), "f"(f52), "f"(f1282));
  // PTX:1207 $L__BB1_81:
L_BB1_81:;
  // PTX:1208 setp.eq.s32 %p65, %r8, %r103
  p65 = (((int)(r8)) == ((int)(r103)));
  // PTX:1209 add.s64 %rd53, %rd191, %rd179
  asm("add.s64 %0, %1, %2;" : "=l"(rd53) : "l"(rd191), "l"(rd179));
  // PTX:1210 @%p65 bra $L__BB1_83
  if (p65) { goto L_BB1_83; }
  // PTX:1212 ld.global.f32 %f874, [%rd53]
  f874 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:1213 ld.global.f32 %f875, [%rd53+4]
  f875 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (4)))));
  // PTX:1214 ld.global.f32 %f876, [%rd53+8]
  f876 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (8)))));
  // PTX:1215 fma.rn.f32 %f1280, %f874, %f53, %f1280
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1280) : "f"(f874), "f"(f53), "f"(f1280));
  // PTX:1216 fma.rn.f32 %f1281, %f875, %f53, %f1281
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1281) : "f"(f875), "f"(f53), "f"(f1281));
  // PTX:1217 fma.rn.f32 %f1282, %f876, %f53, %f1282
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1282) : "f"(f876), "f"(f53), "f"(f1282));
  // PTX:1219 $L__BB1_83:
L_BB1_83:;
  // PTX:1220 setp.eq.s32 %p66, %r9, %r103
  p66 = (((int)(r9)) == ((int)(r103)));
  // PTX:1221 add.s64 %rd54, %rd191, %rd180
  asm("add.s64 %0, %1, %2;" : "=l"(rd54) : "l"(rd191), "l"(rd180));
  // PTX:1222 @%p66 bra $L__BB1_85
  if (p66) { goto L_BB1_85; }
  // PTX:1224 ld.global.f32 %f877, [%rd54]
  f877 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:1225 ld.global.f32 %f878, [%rd54+4]
  f878 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (4)))));
  // PTX:1226 ld.global.f32 %f879, [%rd54+8]
  f879 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (8)))));
  // PTX:1227 fma.rn.f32 %f1280, %f877, %f54, %f1280
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1280) : "f"(f877), "f"(f54), "f"(f1280));
  // PTX:1228 fma.rn.f32 %f1281, %f878, %f54, %f1281
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1281) : "f"(f878), "f"(f54), "f"(f1281));
  // PTX:1229 fma.rn.f32 %f1282, %f879, %f54, %f1282
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1282) : "f"(f879), "f"(f54), "f"(f1282));
  // PTX:1231 $L__BB1_85:
L_BB1_85:;
  // PTX:1232 ld.param.u64 %rd238, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_25]
  rd238 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param25 + (0))));
  // PTX:1233 mul.f32 %f883, %f232, %f1281
  asm("mul.f32 %0, %1, %2;" : "=f"(f883) : "f"(f232), "f"(f1281));
  // PTX:1234 fma.rn.f32 %f884, %f230, %f1280, %f883
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f884) : "f"(f230), "f"(f1280), "f"(f883));
  // PTX:1235 fma.rn.f32 %f885, %f234, %f1282, %f884
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f885) : "f"(f234), "f"(f1282), "f"(f884));
  // PTX:1236 mul.f32 %f886, %f235, %f1281
  asm("mul.f32 %0, %1, %2;" : "=f"(f886) : "f"(f235), "f"(f1281));
  // PTX:1237 fma.rn.f32 %f887, %f232, %f1280, %f886
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f887) : "f"(f232), "f"(f1280), "f"(f886));
  // PTX:1238 fma.rn.f32 %f888, %f237, %f1282, %f887
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f888) : "f"(f237), "f"(f1282), "f"(f887));
  // PTX:1239 mul.f32 %f889, %f237, %f1281
  asm("mul.f32 %0, %1, %2;" : "=f"(f889) : "f"(f237), "f"(f1281));
  // PTX:1240 fma.rn.f32 %f890, %f234, %f1280, %f889
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f890) : "f"(f234), "f"(f1280), "f"(f889));
  // PTX:1241 fma.rn.f32 %f891, %f238, %f1282, %f890
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f891) : "f"(f238), "f"(f1282), "f"(f890));
  // PTX:1242 cvta.to.global.u64 %rd199, %rd238
  rd199 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd238));
  // PTX:1243 add.s64 %rd55, %rd199, %rd159
  asm("add.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd199), "l"(rd159));
  // PTX:1244 red.global.add.f32 [%rd55], %f885
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))), (float)(f885));
  // PTX:1245 add.s64 %rd201, %rd55, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd201) : "l"(rd55));
  // PTX:1246 red.global.add.f32 [%rd201], %f888
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (0)))), (float)(f888));
  // PTX:1247 add.s64 %rd202, %rd55, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd202) : "l"(rd55));
  // PTX:1248 red.global.add.f32 [%rd202], %f891
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (0)))), (float)(f891));
  // PTX:1249 add.s64 %rd56, %rd191, %rd159
  asm("add.s64 %0, %1, %2;" : "=l"(rd56) : "l"(rd191), "l"(rd159));
  // PTX:1250 mov.f32 %f1292, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1292) : );
  // PTX:1251 mov.f32 %f1293, %f1292
  asm("mov.f32 %0, %1;" : "=f"(f1293) : "f"(f1292));
  // PTX:1252 mov.f32 %f1294, %f1292
  asm("mov.f32 %0, %1;" : "=f"(f1294) : "f"(f1292));
  // PTX:1253 @%p63 bra $L__BB1_87
  if (p63) { goto L_BB1_87; }
  // PTX:1255 ld.global.f32 %f895, [%rd56]
  f895 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))));
  // PTX:1256 add.f32 %f1292, %f895, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1292) : "f"(f895));
  // PTX:1257 ld.global.f32 %f896, [%rd56+4]
  f896 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (4)))));
  // PTX:1258 add.f32 %f1293, %f896, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1293) : "f"(f896));
  // PTX:1259 ld.global.f32 %f897, [%rd56+8]
  f897 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (8)))));
  // PTX:1260 add.f32 %f1294, %f897, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1294) : "f"(f897));
  // PTX:1262 $L__BB1_87:
L_BB1_87:;
  // PTX:1263 setp.eq.s32 %p68, %r7, %r6
  p68 = (((int)(r7)) == ((int)(r6)));
  // PTX:1264 @%p68 bra $L__BB1_89
  if (p68) { goto L_BB1_89; }
  // PTX:1266 ld.global.f32 %f898, [%rd52]
  f898 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:1267 ld.global.f32 %f899, [%rd52+4]
  f899 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:1268 ld.global.f32 %f900, [%rd52+8]
  f900 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:1269 fma.rn.f32 %f1292, %f898, %f52, %f1292
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1292) : "f"(f898), "f"(f52), "f"(f1292));
  // PTX:1270 fma.rn.f32 %f1293, %f899, %f52, %f1293
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1293) : "f"(f899), "f"(f52), "f"(f1293));
  // PTX:1271 fma.rn.f32 %f1294, %f900, %f52, %f1294
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1294) : "f"(f900), "f"(f52), "f"(f1294));
  // PTX:1273 $L__BB1_89:
L_BB1_89:;
  // PTX:1274 setp.eq.s32 %p69, %r8, %r6
  p69 = (((int)(r8)) == ((int)(r6)));
  // PTX:1275 @%p69 bra $L__BB1_91
  if (p69) { goto L_BB1_91; }
  // PTX:1277 ld.global.f32 %f901, [%rd53]
  f901 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:1278 ld.global.f32 %f902, [%rd53+4]
  f902 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (4)))));
  // PTX:1279 ld.global.f32 %f903, [%rd53+8]
  f903 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (8)))));
  // PTX:1280 fma.rn.f32 %f1292, %f901, %f53, %f1292
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1292) : "f"(f901), "f"(f53), "f"(f1292));
  // PTX:1281 fma.rn.f32 %f1293, %f902, %f53, %f1293
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1293) : "f"(f902), "f"(f53), "f"(f1293));
  // PTX:1282 fma.rn.f32 %f1294, %f903, %f53, %f1294
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1294) : "f"(f903), "f"(f53), "f"(f1294));
  // PTX:1284 $L__BB1_91:
L_BB1_91:;
  // PTX:1285 setp.eq.s32 %p70, %r9, %r6
  p70 = (((int)(r9)) == ((int)(r6)));
  // PTX:1286 @%p70 bra $L__BB1_93
  if (p70) { goto L_BB1_93; }
  // PTX:1288 ld.global.f32 %f904, [%rd54]
  f904 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:1289 ld.global.f32 %f905, [%rd54+4]
  f905 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (4)))));
  // PTX:1290 ld.global.f32 %f906, [%rd54+8]
  f906 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (8)))));
  // PTX:1291 fma.rn.f32 %f1292, %f904, %f54, %f1292
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1292) : "f"(f904), "f"(f54), "f"(f1292));
  // PTX:1292 fma.rn.f32 %f1293, %f905, %f54, %f1293
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1293) : "f"(f905), "f"(f54), "f"(f1293));
  // PTX:1293 fma.rn.f32 %f1294, %f906, %f54, %f1294
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1294) : "f"(f906), "f"(f54), "f"(f1294));
  // PTX:1295 $L__BB1_93:
L_BB1_93:;
  // PTX:1296 mul.f32 %f910, %f232, %f1293
  asm("mul.f32 %0, %1, %2;" : "=f"(f910) : "f"(f232), "f"(f1293));
  // PTX:1297 fma.rn.f32 %f911, %f230, %f1292, %f910
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f911) : "f"(f230), "f"(f1292), "f"(f910));
  // PTX:1298 fma.rn.f32 %f912, %f234, %f1294, %f911
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f912) : "f"(f234), "f"(f1294), "f"(f911));
  // PTX:1299 mul.f32 %f913, %f235, %f1293
  asm("mul.f32 %0, %1, %2;" : "=f"(f913) : "f"(f235), "f"(f1293));
  // PTX:1300 fma.rn.f32 %f914, %f232, %f1292, %f913
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f914) : "f"(f232), "f"(f1292), "f"(f913));
  // PTX:1301 fma.rn.f32 %f915, %f237, %f1294, %f914
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f915) : "f"(f237), "f"(f1294), "f"(f914));
  // PTX:1302 mul.f32 %f916, %f237, %f1293
  asm("mul.f32 %0, %1, %2;" : "=f"(f916) : "f"(f237), "f"(f1293));
  // PTX:1303 fma.rn.f32 %f917, %f234, %f1292, %f916
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f917) : "f"(f234), "f"(f1292), "f"(f916));
  // PTX:1304 fma.rn.f32 %f918, %f238, %f1294, %f917
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f918) : "f"(f238), "f"(f1294), "f"(f917));
  // PTX:1305 neg.f32 %f919, %f912
  asm("neg.f32 %0, %1;" : "=f"(f919) : "f"(f912));
  // PTX:1306 neg.f32 %f920, %f915
  asm("neg.f32 %0, %1;" : "=f"(f920) : "f"(f915));
  // PTX:1307 neg.f32 %f921, %f918
  asm("neg.f32 %0, %1;" : "=f"(f921) : "f"(f918));
  // PTX:1308 add.s64 %rd57, %rd199, %rd49
  asm("add.s64 %0, %1, %2;" : "=l"(rd57) : "l"(rd199), "l"(rd49));
  // PTX:1309 red.global.add.f32 [%rd57], %f919
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd57) + (0)))), (float)(f919));
  // PTX:1310 add.s64 %rd206, %rd57, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd206) : "l"(rd57));
  // PTX:1311 red.global.add.f32 [%rd206], %f920
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd206) + (0)))), (float)(f920));
  // PTX:1312 add.s64 %rd207, %rd57, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd207) : "l"(rd57));
  // PTX:1313 red.global.add.f32 [%rd207], %f921
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd207) + (0)))), (float)(f921));
  // PTX:1314 mov.f32 %f1304, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1304) : );
  // PTX:1315 mov.f32 %f1305, %f1304
  asm("mov.f32 %0, %1;" : "=f"(f1305) : "f"(f1304));
  // PTX:1316 mov.f32 %f1306, %f1304
  asm("mov.f32 %0, %1;" : "=f"(f1306) : "f"(f1304));
  // PTX:1317 @%p64 bra $L__BB1_95
  if (p64) { goto L_BB1_95; }
  // PTX:1319 ld.global.f32 %f925, [%rd56]
  f925 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))));
  // PTX:1320 add.f32 %f1304, %f925, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1304) : "f"(f925));
  // PTX:1321 ld.global.f32 %f926, [%rd56+4]
  f926 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (4)))));
  // PTX:1322 add.f32 %f1305, %f926, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1305) : "f"(f926));
  // PTX:1323 ld.global.f32 %f927, [%rd56+8]
  f927 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (8)))));
  // PTX:1324 add.f32 %f1306, %f927, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1306) : "f"(f927));
  // PTX:1326 $L__BB1_95:
L_BB1_95:;
  // PTX:1327 @%p68 bra $L__BB1_97
  if (p68) { goto L_BB1_97; }
  // PTX:1329 ld.global.f32 %f928, [%rd51]
  f928 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))));
  // PTX:1330 sub.f32 %f1304, %f1304, %f928
  asm("sub.f32 %0, %1, %2;" : "=f"(f1304) : "f"(f1304), "f"(f928));
  // PTX:1331 ld.global.f32 %f929, [%rd51+4]
  f929 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (4)))));
  // PTX:1332 sub.f32 %f1305, %f1305, %f929
  asm("sub.f32 %0, %1, %2;" : "=f"(f1305) : "f"(f1305), "f"(f929));
  // PTX:1333 ld.global.f32 %f930, [%rd51+8]
  f930 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (8)))));
  // PTX:1334 sub.f32 %f1306, %f1306, %f930
  asm("sub.f32 %0, %1, %2;" : "=f"(f1306) : "f"(f1306), "f"(f930));
  // PTX:1336 $L__BB1_97:
L_BB1_97:;
  // PTX:1337 setp.eq.s32 %p73, %r8, %r7
  p73 = (((int)(r8)) == ((int)(r7)));
  // PTX:1338 @%p73 bra $L__BB1_99
  if (p73) { goto L_BB1_99; }
  // PTX:1340 ld.global.f32 %f931, [%rd53]
  f931 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:1341 ld.global.f32 %f932, [%rd53+4]
  f932 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (4)))));
  // PTX:1342 ld.global.f32 %f933, [%rd53+8]
  f933 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (8)))));
  // PTX:1343 fma.rn.f32 %f1304, %f931, %f53, %f1304
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1304) : "f"(f931), "f"(f53), "f"(f1304));
  // PTX:1344 fma.rn.f32 %f1305, %f932, %f53, %f1305
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1305) : "f"(f932), "f"(f53), "f"(f1305));
  // PTX:1345 fma.rn.f32 %f1306, %f933, %f53, %f1306
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1306) : "f"(f933), "f"(f53), "f"(f1306));
  // PTX:1347 $L__BB1_99:
L_BB1_99:;
  // PTX:1348 setp.eq.s32 %p74, %r9, %r7
  p74 = (((int)(r9)) == ((int)(r7)));
  // PTX:1349 @%p74 bra $L__BB1_101
  if (p74) { goto L_BB1_101; }
  // PTX:1351 ld.global.f32 %f934, [%rd54]
  f934 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:1352 ld.global.f32 %f935, [%rd54+4]
  f935 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (4)))));
  // PTX:1353 ld.global.f32 %f936, [%rd54+8]
  f936 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (8)))));
  // PTX:1354 fma.rn.f32 %f1304, %f934, %f54, %f1304
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1304) : "f"(f934), "f"(f54), "f"(f1304));
  // PTX:1355 fma.rn.f32 %f1305, %f935, %f54, %f1305
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1305) : "f"(f935), "f"(f54), "f"(f1305));
  // PTX:1356 fma.rn.f32 %f1306, %f936, %f54, %f1306
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1306) : "f"(f936), "f"(f54), "f"(f1306));
  // PTX:1358 $L__BB1_101:
L_BB1_101:;
  // PTX:1359 mul.f32 %f940, %f232, %f1305
  asm("mul.f32 %0, %1, %2;" : "=f"(f940) : "f"(f232), "f"(f1305));
  // PTX:1360 fma.rn.f32 %f941, %f230, %f1304, %f940
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f941) : "f"(f230), "f"(f1304), "f"(f940));
  // PTX:1361 fma.rn.f32 %f942, %f234, %f1306, %f941
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f942) : "f"(f234), "f"(f1306), "f"(f941));
  // PTX:1362 mul.f32 %f943, %f235, %f1305
  asm("mul.f32 %0, %1, %2;" : "=f"(f943) : "f"(f235), "f"(f1305));
  // PTX:1363 fma.rn.f32 %f944, %f232, %f1304, %f943
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f944) : "f"(f232), "f"(f1304), "f"(f943));
  // PTX:1364 fma.rn.f32 %f945, %f237, %f1306, %f944
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f945) : "f"(f237), "f"(f1306), "f"(f944));
  // PTX:1365 mul.f32 %f946, %f237, %f1305
  asm("mul.f32 %0, %1, %2;" : "=f"(f946) : "f"(f237), "f"(f1305));
  // PTX:1366 fma.rn.f32 %f947, %f234, %f1304, %f946
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f947) : "f"(f234), "f"(f1304), "f"(f946));
  // PTX:1367 fma.rn.f32 %f948, %f238, %f1306, %f947
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f948) : "f"(f238), "f"(f1306), "f"(f947));
  // PTX:1368 mul.f32 %f949, %f942, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f949) : "f"(f942), "f"(f52));
  // PTX:1369 mul.f32 %f950, %f945, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f950) : "f"(f945), "f"(f52));
  // PTX:1370 mul.f32 %f951, %f948, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f951) : "f"(f948), "f"(f52));
  // PTX:1371 add.s64 %rd58, %rd199, %rd50
  asm("add.s64 %0, %1, %2;" : "=l"(rd58) : "l"(rd199), "l"(rd50));
  // PTX:1372 red.global.add.f32 [%rd58], %f949
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))), (float)(f949));
  // PTX:1373 add.s64 %rd210, %rd58, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd210) : "l"(rd58));
  // PTX:1374 red.global.add.f32 [%rd210], %f950
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd210) + (0)))), (float)(f950));
  // PTX:1375 add.s64 %rd211, %rd58, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd211) : "l"(rd58));
  // PTX:1376 red.global.add.f32 [%rd211], %f951
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd211) + (0)))), (float)(f951));
  // PTX:1377 mov.f32 %f1316, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1316) : );
  // PTX:1378 mov.f32 %f1317, %f1316
  asm("mov.f32 %0, %1;" : "=f"(f1317) : "f"(f1316));
  // PTX:1379 mov.f32 %f1318, %f1316
  asm("mov.f32 %0, %1;" : "=f"(f1318) : "f"(f1316));
  // PTX:1380 @%p65 bra $L__BB1_103
  if (p65) { goto L_BB1_103; }
  // PTX:1382 ld.global.f32 %f955, [%rd56]
  f955 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))));
  // PTX:1383 add.f32 %f1316, %f955, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1316) : "f"(f955));
  // PTX:1384 ld.global.f32 %f956, [%rd56+4]
  f956 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (4)))));
  // PTX:1385 add.f32 %f1317, %f956, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1317) : "f"(f956));
  // PTX:1386 ld.global.f32 %f957, [%rd56+8]
  f957 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (8)))));
  // PTX:1387 add.f32 %f1318, %f957, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1318) : "f"(f957));
  // PTX:1389 $L__BB1_103:
L_BB1_103:;
  // PTX:1390 @%p69 bra $L__BB1_105
  if (p69) { goto L_BB1_105; }
  // PTX:1392 ld.global.f32 %f958, [%rd51]
  f958 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))));
  // PTX:1393 sub.f32 %f1316, %f1316, %f958
  asm("sub.f32 %0, %1, %2;" : "=f"(f1316) : "f"(f1316), "f"(f958));
  // PTX:1394 ld.global.f32 %f959, [%rd51+4]
  f959 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (4)))));
  // PTX:1395 sub.f32 %f1317, %f1317, %f959
  asm("sub.f32 %0, %1, %2;" : "=f"(f1317) : "f"(f1317), "f"(f959));
  // PTX:1396 ld.global.f32 %f960, [%rd51+8]
  f960 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (8)))));
  // PTX:1397 sub.f32 %f1318, %f1318, %f960
  asm("sub.f32 %0, %1, %2;" : "=f"(f1318) : "f"(f1318), "f"(f960));
  // PTX:1399 $L__BB1_105:
L_BB1_105:;
  // PTX:1400 @%p73 bra $L__BB1_107
  if (p73) { goto L_BB1_107; }
  // PTX:1402 ld.global.f32 %f961, [%rd52]
  f961 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:1403 ld.global.f32 %f962, [%rd52+4]
  f962 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:1404 ld.global.f32 %f963, [%rd52+8]
  f963 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:1405 fma.rn.f32 %f1316, %f961, %f52, %f1316
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1316) : "f"(f961), "f"(f52), "f"(f1316));
  // PTX:1406 fma.rn.f32 %f1317, %f962, %f52, %f1317
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1317) : "f"(f962), "f"(f52), "f"(f1317));
  // PTX:1407 fma.rn.f32 %f1318, %f963, %f52, %f1318
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1318) : "f"(f963), "f"(f52), "f"(f1318));
  // PTX:1409 $L__BB1_107:
L_BB1_107:;
  // PTX:1410 setp.eq.s32 %p78, %r9, %r8
  p78 = (((int)(r9)) == ((int)(r8)));
  // PTX:1411 @%p78 bra $L__BB1_109
  if (p78) { goto L_BB1_109; }
  // PTX:1413 ld.global.f32 %f964, [%rd54]
  f964 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:1414 ld.global.f32 %f965, [%rd54+4]
  f965 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (4)))));
  // PTX:1415 ld.global.f32 %f966, [%rd54+8]
  f966 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (8)))));
  // PTX:1416 fma.rn.f32 %f1316, %f964, %f54, %f1316
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1316) : "f"(f964), "f"(f54), "f"(f1316));
  // PTX:1417 fma.rn.f32 %f1317, %f965, %f54, %f1317
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1317) : "f"(f965), "f"(f54), "f"(f1317));
  // PTX:1418 fma.rn.f32 %f1318, %f966, %f54, %f1318
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1318) : "f"(f966), "f"(f54), "f"(f1318));
  // PTX:1420 $L__BB1_109:
L_BB1_109:;
  // PTX:1421 mul.f32 %f970, %f232, %f1317
  asm("mul.f32 %0, %1, %2;" : "=f"(f970) : "f"(f232), "f"(f1317));
  // PTX:1422 fma.rn.f32 %f971, %f230, %f1316, %f970
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f971) : "f"(f230), "f"(f1316), "f"(f970));
  // PTX:1423 fma.rn.f32 %f972, %f234, %f1318, %f971
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f972) : "f"(f234), "f"(f1318), "f"(f971));
  // PTX:1424 mul.f32 %f973, %f235, %f1317
  asm("mul.f32 %0, %1, %2;" : "=f"(f973) : "f"(f235), "f"(f1317));
  // PTX:1425 fma.rn.f32 %f974, %f232, %f1316, %f973
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f974) : "f"(f232), "f"(f1316), "f"(f973));
  // PTX:1426 fma.rn.f32 %f975, %f237, %f1318, %f974
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f975) : "f"(f237), "f"(f1318), "f"(f974));
  // PTX:1427 mul.f32 %f976, %f237, %f1317
  asm("mul.f32 %0, %1, %2;" : "=f"(f976) : "f"(f237), "f"(f1317));
  // PTX:1428 fma.rn.f32 %f977, %f234, %f1316, %f976
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f977) : "f"(f234), "f"(f1316), "f"(f976));
  // PTX:1429 fma.rn.f32 %f978, %f238, %f1318, %f977
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f978) : "f"(f238), "f"(f1318), "f"(f977));
  // PTX:1430 mul.f32 %f979, %f972, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f979) : "f"(f972), "f"(f53));
  // PTX:1431 mul.f32 %f980, %f975, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f980) : "f"(f975), "f"(f53));
  // PTX:1432 mul.f32 %f981, %f978, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f981) : "f"(f978), "f"(f53));
  // PTX:1433 add.s64 %rd59, %rd199, %rd179
  asm("add.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd199), "l"(rd179));
  // PTX:1434 red.global.add.f32 [%rd59], %f979
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))), (float)(f979));
  // PTX:1435 add.s64 %rd214, %rd59, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd214) : "l"(rd59));
  // PTX:1436 red.global.add.f32 [%rd214], %f980
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd214) + (0)))), (float)(f980));
  // PTX:1437 add.s64 %rd215, %rd59, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd215) : "l"(rd59));
  // PTX:1438 red.global.add.f32 [%rd215], %f981
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd215) + (0)))), (float)(f981));
  // PTX:1439 mov.f32 %f1328, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1328) : );
  // PTX:1440 mov.f32 %f1329, %f1328
  asm("mov.f32 %0, %1;" : "=f"(f1329) : "f"(f1328));
  // PTX:1441 mov.f32 %f1330, %f1328
  asm("mov.f32 %0, %1;" : "=f"(f1330) : "f"(f1328));
  // PTX:1442 @%p66 bra $L__BB1_111
  if (p66) { goto L_BB1_111; }
  // PTX:1444 ld.global.f32 %f985, [%rd56]
  f985 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))));
  // PTX:1445 add.f32 %f1328, %f985, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1328) : "f"(f985));
  // PTX:1446 ld.global.f32 %f986, [%rd56+4]
  f986 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (4)))));
  // PTX:1447 add.f32 %f1329, %f986, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1329) : "f"(f986));
  // PTX:1448 ld.global.f32 %f987, [%rd56+8]
  f987 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (8)))));
  // PTX:1449 add.f32 %f1330, %f987, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1330) : "f"(f987));
  // PTX:1451 $L__BB1_111:
L_BB1_111:;
  // PTX:1452 @%p70 bra $L__BB1_113
  if (p70) { goto L_BB1_113; }
  // PTX:1454 ld.global.f32 %f988, [%rd51]
  f988 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))));
  // PTX:1455 sub.f32 %f1328, %f1328, %f988
  asm("sub.f32 %0, %1, %2;" : "=f"(f1328) : "f"(f1328), "f"(f988));
  // PTX:1456 ld.global.f32 %f989, [%rd51+4]
  f989 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (4)))));
  // PTX:1457 sub.f32 %f1329, %f1329, %f989
  asm("sub.f32 %0, %1, %2;" : "=f"(f1329) : "f"(f1329), "f"(f989));
  // PTX:1458 ld.global.f32 %f990, [%rd51+8]
  f990 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (8)))));
  // PTX:1459 sub.f32 %f1330, %f1330, %f990
  asm("sub.f32 %0, %1, %2;" : "=f"(f1330) : "f"(f1330), "f"(f990));
  // PTX:1461 $L__BB1_113:
L_BB1_113:;
  // PTX:1462 @%p74 bra $L__BB1_115
  if (p74) { goto L_BB1_115; }
  // PTX:1464 ld.global.f32 %f991, [%rd52]
  f991 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:1465 ld.global.f32 %f992, [%rd52+4]
  f992 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:1466 ld.global.f32 %f993, [%rd52+8]
  f993 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:1467 fma.rn.f32 %f1328, %f991, %f52, %f1328
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1328) : "f"(f991), "f"(f52), "f"(f1328));
  // PTX:1468 fma.rn.f32 %f1329, %f992, %f52, %f1329
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1329) : "f"(f992), "f"(f52), "f"(f1329));
  // PTX:1469 fma.rn.f32 %f1330, %f993, %f52, %f1330
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1330) : "f"(f993), "f"(f52), "f"(f1330));
  // PTX:1471 $L__BB1_115:
L_BB1_115:;
  // PTX:1472 @%p78 bra $L__BB1_117
  if (p78) { goto L_BB1_117; }
  // PTX:1474 ld.global.f32 %f994, [%rd53]
  f994 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:1475 ld.global.f32 %f995, [%rd53+4]
  f995 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (4)))));
  // PTX:1476 ld.global.f32 %f996, [%rd53+8]
  f996 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (8)))));
  // PTX:1477 fma.rn.f32 %f1328, %f994, %f53, %f1328
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1328) : "f"(f994), "f"(f53), "f"(f1328));
  // PTX:1478 fma.rn.f32 %f1329, %f995, %f53, %f1329
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1329) : "f"(f995), "f"(f53), "f"(f1329));
  // PTX:1479 fma.rn.f32 %f1330, %f996, %f53, %f1330
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1330) : "f"(f996), "f"(f53), "f"(f1330));
  // PTX:1481 $L__BB1_117:
L_BB1_117:;
  // PTX:1482 mul.f32 %f1203, %f1225, %f1225
  asm("mul.f32 %0, %1, %2;" : "=f"(f1203) : "f"(f1225), "f"(f1225));
  // PTX:1483 mul.f32 %f1202, %f1226, %f1226
  asm("mul.f32 %0, %1, %2;" : "=f"(f1202) : "f"(f1226), "f"(f1226));
  // PTX:1484 mul.f32 %f1201, %f1227, %f1227
  asm("mul.f32 %0, %1, %2;" : "=f"(f1201) : "f"(f1227), "f"(f1227));
  // PTX:1485 mul.f32 %f1000, %f232, %f1329
  asm("mul.f32 %0, %1, %2;" : "=f"(f1000) : "f"(f232), "f"(f1329));
  // PTX:1486 fma.rn.f32 %f1001, %f230, %f1328, %f1000
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1001) : "f"(f230), "f"(f1328), "f"(f1000));
  // PTX:1487 fma.rn.f32 %f1002, %f234, %f1330, %f1001
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1002) : "f"(f234), "f"(f1330), "f"(f1001));
  // PTX:1488 mul.f32 %f1003, %f235, %f1329
  asm("mul.f32 %0, %1, %2;" : "=f"(f1003) : "f"(f235), "f"(f1329));
  // PTX:1489 fma.rn.f32 %f1004, %f232, %f1328, %f1003
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1004) : "f"(f232), "f"(f1328), "f"(f1003));
  // PTX:1490 fma.rn.f32 %f1005, %f237, %f1330, %f1004
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1005) : "f"(f237), "f"(f1330), "f"(f1004));
  // PTX:1491 mul.f32 %f1006, %f237, %f1329
  asm("mul.f32 %0, %1, %2;" : "=f"(f1006) : "f"(f237), "f"(f1329));
  // PTX:1492 fma.rn.f32 %f1007, %f234, %f1328, %f1006
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1007) : "f"(f234), "f"(f1328), "f"(f1006));
  // PTX:1493 fma.rn.f32 %f1008, %f238, %f1330, %f1007
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1008) : "f"(f238), "f"(f1330), "f"(f1007));
  // PTX:1494 mul.f32 %f1009, %f1002, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f1009) : "f"(f1002), "f"(f54));
  // PTX:1495 mul.f32 %f1010, %f1005, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f1010) : "f"(f1005), "f"(f54));
  // PTX:1496 mul.f32 %f1011, %f1008, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f1011) : "f"(f1008), "f"(f54));
  // PTX:1497 add.s64 %rd60, %rd199, %rd180
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd199), "l"(rd180));
  // PTX:1498 red.global.add.f32 [%rd60], %f1009
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))), (float)(f1009));
  // PTX:1499 add.s64 %rd218, %rd60, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd218) : "l"(rd60));
  // PTX:1500 red.global.add.f32 [%rd218], %f1010
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd218) + (0)))), (float)(f1010));
  // PTX:1501 add.s64 %rd219, %rd60, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd219) : "l"(rd60));
  // PTX:1502 red.global.add.f32 [%rd219], %f1011
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd219) + (0)))), (float)(f1011));
  // PTX:1503 ld.global.f32 %f1015, [%rd38]
  f1015 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (0)))));
  // PTX:1504 sub.f32 %f1016, %f186, %f1015
  asm("sub.f32 %0, %1, %2;" : "=f"(f1016) : "f"(f186), "f"(f1015));
  // PTX:1505 ld.global.f32 %f1017, [%rd38+4]
  f1017 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (4)))));
  // PTX:1506 sub.f32 %f1018, %f187, %f1017
  asm("sub.f32 %0, %1, %2;" : "=f"(f1018) : "f"(f187), "f"(f1017));
  // PTX:1507 ld.global.f32 %f1019, [%rd38+8]
  f1019 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd38) + (8)))));
  // PTX:1508 sub.f32 %f1020, %f188, %f1019
  asm("sub.f32 %0, %1, %2;" : "=f"(f1020) : "f"(f188), "f"(f1019));
  // PTX:1509 neg.f32 %f359, %f1016
  asm("neg.f32 %0, %1;" : "=f"(f359) : "f"(f1016));
  // PTX:1510 neg.f32 %f360, %f1018
  asm("neg.f32 %0, %1;" : "=f"(f360) : "f"(f1018));
  // PTX:1511 neg.f32 %f361, %f1020
  asm("neg.f32 %0, %1;" : "=f"(f361) : "f"(f1020));
  // PTX:1512 mov.f32 %f1021, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f1021) : );
  // PTX:1513 sub.f32 %f1022, %f1021, %f1201
  asm("sub.f32 %0, %1, %2;" : "=f"(f1022) : "f"(f1021), "f"(f1201));
  // PTX:1514 mul.f32 %f1023, %f1276, %f488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1023) : "f"(f1276), "f"(f488));
  // PTX:1515 mul.f32 %f362, %f1023, %f1022
  asm("mul.f32 %0, %1, %2;" : "=f"(f362) : "f"(f1023), "f"(f1022));
  // PTX:1516 mov.f32 %f1340, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1340) : );
  // PTX:1517 sub.f32 %f1024, %f1340, %f231
  asm("sub.f32 %0, %1, %2;" : "=f"(f1024) : "f"(f1340), "f"(f231));
  // PTX:1518 mul.f32 %f363, %f1023, %f1024
  asm("mul.f32 %0, %1, %2;" : "=f"(f363) : "f"(f1023), "f"(f1024));
  // PTX:1519 sub.f32 %f1025, %f1340, %f233
  asm("sub.f32 %0, %1, %2;" : "=f"(f1025) : "f"(f1340), "f"(f233));
  // PTX:1520 mul.f32 %f364, %f1023, %f1025
  asm("mul.f32 %0, %1, %2;" : "=f"(f364) : "f"(f1023), "f"(f1025));
  // PTX:1521 sub.f32 %f1026, %f1021, %f1202
  asm("sub.f32 %0, %1, %2;" : "=f"(f1026) : "f"(f1021), "f"(f1202));
  // PTX:1522 mul.f32 %f365, %f1023, %f1026
  asm("mul.f32 %0, %1, %2;" : "=f"(f365) : "f"(f1023), "f"(f1026));
  // PTX:1523 sub.f32 %f1027, %f1340, %f236
  asm("sub.f32 %0, %1, %2;" : "=f"(f1027) : "f"(f1340), "f"(f236));
  // PTX:1524 mul.f32 %f366, %f1023, %f1027
  asm("mul.f32 %0, %1, %2;" : "=f"(f366) : "f"(f1023), "f"(f1027));
  // PTX:1525 sub.f32 %f1028, %f1021, %f1203
  asm("sub.f32 %0, %1, %2;" : "=f"(f1028) : "f"(f1021), "f"(f1203));
  // PTX:1526 mul.f32 %f367, %f1023, %f1028
  asm("mul.f32 %0, %1, %2;" : "=f"(f367) : "f"(f1023), "f"(f1028));
  // PTX:1527 mov.f32 %f1341, %f1340
  asm("mov.f32 %0, %1;" : "=f"(f1341) : "f"(f1340));
  // PTX:1528 mov.f32 %f1342, %f1340
  asm("mov.f32 %0, %1;" : "=f"(f1342) : "f"(f1340));
  // PTX:1529 @%p63 bra $L__BB1_119
  if (p63) { goto L_BB1_119; }
  // PTX:1531 ld.global.f32 %f1029, [%rd51]
  f1029 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))));
  // PTX:1532 mov.f32 %f1030, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1030) : );
  // PTX:1533 sub.f32 %f1340, %f1030, %f1029
  asm("sub.f32 %0, %1, %2;" : "=f"(f1340) : "f"(f1030), "f"(f1029));
  // PTX:1534 ld.global.f32 %f1031, [%rd51+4]
  f1031 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (4)))));
  // PTX:1535 sub.f32 %f1341, %f1030, %f1031
  asm("sub.f32 %0, %1, %2;" : "=f"(f1341) : "f"(f1030), "f"(f1031));
  // PTX:1536 ld.global.f32 %f1032, [%rd51+8]
  f1032 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (8)))));
  // PTX:1537 sub.f32 %f1342, %f1030, %f1032
  asm("sub.f32 %0, %1, %2;" : "=f"(f1342) : "f"(f1030), "f"(f1032));
  // PTX:1539 $L__BB1_119:
L_BB1_119:;
  // PTX:1540 @%p64 bra $L__BB1_121
  if (p64) { goto L_BB1_121; }
  // PTX:1542 ld.global.f32 %f1033, [%rd52]
  f1033 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:1543 ld.global.f32 %f1034, [%rd52+4]
  f1034 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:1544 ld.global.f32 %f1035, [%rd52+8]
  f1035 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:1545 fma.rn.f32 %f1340, %f1033, %f359, %f1340
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1340) : "f"(f1033), "f"(f359), "f"(f1340));
  // PTX:1546 fma.rn.f32 %f1341, %f1034, %f359, %f1341
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1341) : "f"(f1034), "f"(f359), "f"(f1341));
  // PTX:1547 fma.rn.f32 %f1342, %f1035, %f359, %f1342
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1342) : "f"(f1035), "f"(f359), "f"(f1342));
  // PTX:1549 $L__BB1_121:
L_BB1_121:;
  // PTX:1550 @%p65 bra $L__BB1_123
  if (p65) { goto L_BB1_123; }
  // PTX:1552 ld.global.f32 %f1036, [%rd53]
  f1036 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:1553 ld.global.f32 %f1037, [%rd53+4]
  f1037 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (4)))));
  // PTX:1554 ld.global.f32 %f1038, [%rd53+8]
  f1038 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (8)))));
  // PTX:1555 fma.rn.f32 %f1340, %f1036, %f360, %f1340
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1340) : "f"(f1036), "f"(f360), "f"(f1340));
  // PTX:1556 fma.rn.f32 %f1341, %f1037, %f360, %f1341
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1341) : "f"(f1037), "f"(f360), "f"(f1341));
  // PTX:1557 fma.rn.f32 %f1342, %f1038, %f360, %f1342
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1342) : "f"(f1038), "f"(f360), "f"(f1342));
  // PTX:1559 $L__BB1_123:
L_BB1_123:;
  // PTX:1560 @%p66 bra $L__BB1_125
  if (p66) { goto L_BB1_125; }
  // PTX:1562 ld.global.f32 %f1039, [%rd54]
  f1039 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:1563 ld.global.f32 %f1040, [%rd54+4]
  f1040 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (4)))));
  // PTX:1564 ld.global.f32 %f1041, [%rd54+8]
  f1041 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (8)))));
  // PTX:1565 fma.rn.f32 %f1340, %f1039, %f361, %f1340
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1340) : "f"(f1039), "f"(f361), "f"(f1340));
  // PTX:1566 fma.rn.f32 %f1341, %f1040, %f361, %f1341
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1341) : "f"(f1040), "f"(f361), "f"(f1341));
  // PTX:1567 fma.rn.f32 %f1342, %f1041, %f361, %f1342
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1342) : "f"(f1041), "f"(f361), "f"(f1342));
  // PTX:1569 $L__BB1_125:
L_BB1_125:;
  // PTX:1570 mul.f32 %f1045, %f363, %f1341
  asm("mul.f32 %0, %1, %2;" : "=f"(f1045) : "f"(f363), "f"(f1341));
  // PTX:1571 fma.rn.f32 %f1046, %f362, %f1340, %f1045
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1046) : "f"(f362), "f"(f1340), "f"(f1045));
  // PTX:1572 fma.rn.f32 %f1047, %f364, %f1342, %f1046
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1047) : "f"(f364), "f"(f1342), "f"(f1046));
  // PTX:1573 mul.f32 %f1048, %f365, %f1341
  asm("mul.f32 %0, %1, %2;" : "=f"(f1048) : "f"(f365), "f"(f1341));
  // PTX:1574 fma.rn.f32 %f1049, %f363, %f1340, %f1048
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1049) : "f"(f363), "f"(f1340), "f"(f1048));
  // PTX:1575 fma.rn.f32 %f1050, %f366, %f1342, %f1049
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1050) : "f"(f366), "f"(f1342), "f"(f1049));
  // PTX:1576 mul.f32 %f1051, %f366, %f1341
  asm("mul.f32 %0, %1, %2;" : "=f"(f1051) : "f"(f366), "f"(f1341));
  // PTX:1577 fma.rn.f32 %f1052, %f364, %f1340, %f1051
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1052) : "f"(f364), "f"(f1340), "f"(f1051));
  // PTX:1578 fma.rn.f32 %f1053, %f367, %f1342, %f1052
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1053) : "f"(f367), "f"(f1342), "f"(f1052));
  // PTX:1579 red.global.add.f32 [%rd55], %f1047
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))), (float)(f1047));
  // PTX:1580 red.global.add.f32 [%rd201], %f1050
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (0)))), (float)(f1050));
  // PTX:1581 red.global.add.f32 [%rd202], %f1053
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (0)))), (float)(f1053));
  // PTX:1582 mov.f32 %f1352, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1352) : );
  // PTX:1583 mov.f32 %f1353, %f1352
  asm("mov.f32 %0, %1;" : "=f"(f1353) : "f"(f1352));
  // PTX:1584 mov.f32 %f1354, %f1352
  asm("mov.f32 %0, %1;" : "=f"(f1354) : "f"(f1352));
  // PTX:1585 @%p63 bra $L__BB1_127
  if (p63) { goto L_BB1_127; }
  // PTX:1587 ld.global.f32 %f1057, [%rd56]
  f1057 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))));
  // PTX:1588 add.f32 %f1352, %f1057, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1352) : "f"(f1057));
  // PTX:1589 ld.global.f32 %f1058, [%rd56+4]
  f1058 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (4)))));
  // PTX:1590 add.f32 %f1353, %f1058, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1353) : "f"(f1058));
  // PTX:1591 ld.global.f32 %f1059, [%rd56+8]
  f1059 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (8)))));
  // PTX:1592 add.f32 %f1354, %f1059, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1354) : "f"(f1059));
  // PTX:1594 $L__BB1_127:
L_BB1_127:;
  // PTX:1595 @%p68 bra $L__BB1_129
  if (p68) { goto L_BB1_129; }
  // PTX:1597 ld.global.f32 %f1060, [%rd52]
  f1060 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:1598 ld.global.f32 %f1061, [%rd52+4]
  f1061 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:1599 ld.global.f32 %f1062, [%rd52+8]
  f1062 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:1600 fma.rn.f32 %f1352, %f1060, %f359, %f1352
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1352) : "f"(f1060), "f"(f359), "f"(f1352));
  // PTX:1601 fma.rn.f32 %f1353, %f1061, %f359, %f1353
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1353) : "f"(f1061), "f"(f359), "f"(f1353));
  // PTX:1602 fma.rn.f32 %f1354, %f1062, %f359, %f1354
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1354) : "f"(f1062), "f"(f359), "f"(f1354));
  // PTX:1604 $L__BB1_129:
L_BB1_129:;
  // PTX:1605 @%p69 bra $L__BB1_131
  if (p69) { goto L_BB1_131; }
  // PTX:1607 ld.global.f32 %f1063, [%rd53]
  f1063 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:1608 ld.global.f32 %f1064, [%rd53+4]
  f1064 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (4)))));
  // PTX:1609 ld.global.f32 %f1065, [%rd53+8]
  f1065 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (8)))));
  // PTX:1610 fma.rn.f32 %f1352, %f1063, %f360, %f1352
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1352) : "f"(f1063), "f"(f360), "f"(f1352));
  // PTX:1611 fma.rn.f32 %f1353, %f1064, %f360, %f1353
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1353) : "f"(f1064), "f"(f360), "f"(f1353));
  // PTX:1612 fma.rn.f32 %f1354, %f1065, %f360, %f1354
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1354) : "f"(f1065), "f"(f360), "f"(f1354));
  // PTX:1614 $L__BB1_131:
L_BB1_131:;
  // PTX:1615 @%p70 bra $L__BB1_133
  if (p70) { goto L_BB1_133; }
  // PTX:1617 ld.global.f32 %f1066, [%rd54]
  f1066 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:1618 ld.global.f32 %f1067, [%rd54+4]
  f1067 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (4)))));
  // PTX:1619 ld.global.f32 %f1068, [%rd54+8]
  f1068 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (8)))));
  // PTX:1620 fma.rn.f32 %f1352, %f1066, %f361, %f1352
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1352) : "f"(f1066), "f"(f361), "f"(f1352));
  // PTX:1621 fma.rn.f32 %f1353, %f1067, %f361, %f1353
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1353) : "f"(f1067), "f"(f361), "f"(f1353));
  // PTX:1622 fma.rn.f32 %f1354, %f1068, %f361, %f1354
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1354) : "f"(f1068), "f"(f361), "f"(f1354));
  // PTX:1624 $L__BB1_133:
L_BB1_133:;
  // PTX:1625 ld.param.u64 %rd250, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_25]
  rd250 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param25 + (0))));
  // PTX:1626 mul.lo.s64 %rd249, %rd233, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd249) : "l"(rd233));
  // PTX:1627 cvta.to.global.u64 %rd248, %rd250
  rd248 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd250));
  // PTX:1628 add.s64 %rd247, %rd248, %rd249
  asm("add.s64 %0, %1, %2;" : "=l"(rd247) : "l"(rd248), "l"(rd249));
  // PTX:1629 add.s64 %rd246, %rd247, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd246) : "l"(rd247));
  // PTX:1630 add.s64 %rd245, %rd247, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd245) : "l"(rd247));
  // PTX:1631 mul.f32 %f1072, %f363, %f1353
  asm("mul.f32 %0, %1, %2;" : "=f"(f1072) : "f"(f363), "f"(f1353));
  // PTX:1632 fma.rn.f32 %f1073, %f362, %f1352, %f1072
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1073) : "f"(f362), "f"(f1352), "f"(f1072));
  // PTX:1633 fma.rn.f32 %f1074, %f364, %f1354, %f1073
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1074) : "f"(f364), "f"(f1354), "f"(f1073));
  // PTX:1634 mul.f32 %f1075, %f365, %f1353
  asm("mul.f32 %0, %1, %2;" : "=f"(f1075) : "f"(f365), "f"(f1353));
  // PTX:1635 fma.rn.f32 %f1076, %f363, %f1352, %f1075
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1076) : "f"(f363), "f"(f1352), "f"(f1075));
  // PTX:1636 fma.rn.f32 %f1077, %f366, %f1354, %f1076
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1077) : "f"(f366), "f"(f1354), "f"(f1076));
  // PTX:1637 mul.f32 %f1078, %f366, %f1353
  asm("mul.f32 %0, %1, %2;" : "=f"(f1078) : "f"(f366), "f"(f1353));
  // PTX:1638 fma.rn.f32 %f1079, %f364, %f1352, %f1078
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1079) : "f"(f364), "f"(f1352), "f"(f1078));
  // PTX:1639 fma.rn.f32 %f1080, %f367, %f1354, %f1079
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1080) : "f"(f367), "f"(f1354), "f"(f1079));
  // PTX:1640 neg.f32 %f1081, %f1074
  asm("neg.f32 %0, %1;" : "=f"(f1081) : "f"(f1074));
  // PTX:1641 neg.f32 %f1082, %f1077
  asm("neg.f32 %0, %1;" : "=f"(f1082) : "f"(f1077));
  // PTX:1642 neg.f32 %f1083, %f1080
  asm("neg.f32 %0, %1;" : "=f"(f1083) : "f"(f1080));
  // PTX:1643 red.global.add.f32 [%rd247], %f1081
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd247) + (0)))), (float)(f1081));
  // PTX:1644 red.global.add.f32 [%rd245], %f1082
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd245) + (0)))), (float)(f1082));
  // PTX:1645 red.global.add.f32 [%rd246], %f1083
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd246) + (0)))), (float)(f1083));
  // PTX:1646 mov.f32 %f1364, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1364) : );
  // PTX:1647 mov.f32 %f1365, %f1364
  asm("mov.f32 %0, %1;" : "=f"(f1365) : "f"(f1364));
  // PTX:1648 mov.f32 %f1366, %f1364
  asm("mov.f32 %0, %1;" : "=f"(f1366) : "f"(f1364));
  // PTX:1649 @%p64 bra $L__BB1_135
  if (p64) { goto L_BB1_135; }
  // PTX:1651 ld.global.f32 %f1087, [%rd56]
  f1087 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))));
  // PTX:1652 add.f32 %f1364, %f1087, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1364) : "f"(f1087));
  // PTX:1653 ld.global.f32 %f1088, [%rd56+4]
  f1088 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (4)))));
  // PTX:1654 add.f32 %f1365, %f1088, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1365) : "f"(f1088));
  // PTX:1655 ld.global.f32 %f1089, [%rd56+8]
  f1089 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (8)))));
  // PTX:1656 add.f32 %f1366, %f1089, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1366) : "f"(f1089));
  // PTX:1658 $L__BB1_135:
L_BB1_135:;
  // PTX:1659 @%p68 bra $L__BB1_137
  if (p68) { goto L_BB1_137; }
  // PTX:1661 ld.global.f32 %f1090, [%rd51]
  f1090 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))));
  // PTX:1662 sub.f32 %f1364, %f1364, %f1090
  asm("sub.f32 %0, %1, %2;" : "=f"(f1364) : "f"(f1364), "f"(f1090));
  // PTX:1663 ld.global.f32 %f1091, [%rd51+4]
  f1091 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (4)))));
  // PTX:1664 sub.f32 %f1365, %f1365, %f1091
  asm("sub.f32 %0, %1, %2;" : "=f"(f1365) : "f"(f1365), "f"(f1091));
  // PTX:1665 ld.global.f32 %f1092, [%rd51+8]
  f1092 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (8)))));
  // PTX:1666 sub.f32 %f1366, %f1366, %f1092
  asm("sub.f32 %0, %1, %2;" : "=f"(f1366) : "f"(f1366), "f"(f1092));
  // PTX:1668 $L__BB1_137:
L_BB1_137:;
  // PTX:1669 @%p73 bra $L__BB1_139
  if (p73) { goto L_BB1_139; }
  // PTX:1671 ld.global.f32 %f1093, [%rd53]
  f1093 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:1672 ld.global.f32 %f1094, [%rd53+4]
  f1094 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (4)))));
  // PTX:1673 ld.global.f32 %f1095, [%rd53+8]
  f1095 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (8)))));
  // PTX:1674 fma.rn.f32 %f1364, %f1093, %f360, %f1364
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1364) : "f"(f1093), "f"(f360), "f"(f1364));
  // PTX:1675 fma.rn.f32 %f1365, %f1094, %f360, %f1365
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1365) : "f"(f1094), "f"(f360), "f"(f1365));
  // PTX:1676 fma.rn.f32 %f1366, %f1095, %f360, %f1366
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1366) : "f"(f1095), "f"(f360), "f"(f1366));
  // PTX:1678 $L__BB1_139:
L_BB1_139:;
  // PTX:1679 @%p74 bra $L__BB1_141
  if (p74) { goto L_BB1_141; }
  // PTX:1681 ld.global.f32 %f1096, [%rd54]
  f1096 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:1682 ld.global.f32 %f1097, [%rd54+4]
  f1097 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (4)))));
  // PTX:1683 ld.global.f32 %f1098, [%rd54+8]
  f1098 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (8)))));
  // PTX:1684 fma.rn.f32 %f1364, %f1096, %f361, %f1364
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1364) : "f"(f1096), "f"(f361), "f"(f1364));
  // PTX:1685 fma.rn.f32 %f1365, %f1097, %f361, %f1365
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1365) : "f"(f1097), "f"(f361), "f"(f1365));
  // PTX:1686 fma.rn.f32 %f1366, %f1098, %f361, %f1366
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1366) : "f"(f1098), "f"(f361), "f"(f1366));
  // PTX:1688 $L__BB1_141:
L_BB1_141:;
  // PTX:1689 ld.param.u64 %rd256, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_25]
  rd256 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param25 + (0))));
  // PTX:1690 mul.lo.s64 %rd255, %rd234, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd255) : "l"(rd234));
  // PTX:1691 cvta.to.global.u64 %rd254, %rd256
  rd254 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd256));
  // PTX:1692 add.s64 %rd253, %rd254, %rd255
  asm("add.s64 %0, %1, %2;" : "=l"(rd253) : "l"(rd254), "l"(rd255));
  // PTX:1693 add.s64 %rd252, %rd253, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd252) : "l"(rd253));
  // PTX:1694 add.s64 %rd251, %rd253, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd251) : "l"(rd253));
  // PTX:1695 mul.f32 %f1102, %f363, %f1365
  asm("mul.f32 %0, %1, %2;" : "=f"(f1102) : "f"(f363), "f"(f1365));
  // PTX:1696 fma.rn.f32 %f1103, %f362, %f1364, %f1102
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1103) : "f"(f362), "f"(f1364), "f"(f1102));
  // PTX:1697 fma.rn.f32 %f1104, %f364, %f1366, %f1103
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1104) : "f"(f364), "f"(f1366), "f"(f1103));
  // PTX:1698 mul.f32 %f1105, %f365, %f1365
  asm("mul.f32 %0, %1, %2;" : "=f"(f1105) : "f"(f365), "f"(f1365));
  // PTX:1699 fma.rn.f32 %f1106, %f363, %f1364, %f1105
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1106) : "f"(f363), "f"(f1364), "f"(f1105));
  // PTX:1700 fma.rn.f32 %f1107, %f366, %f1366, %f1106
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1107) : "f"(f366), "f"(f1366), "f"(f1106));
  // PTX:1701 mul.f32 %f1108, %f366, %f1365
  asm("mul.f32 %0, %1, %2;" : "=f"(f1108) : "f"(f366), "f"(f1365));
  // PTX:1702 fma.rn.f32 %f1109, %f364, %f1364, %f1108
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1109) : "f"(f364), "f"(f1364), "f"(f1108));
  // PTX:1703 fma.rn.f32 %f1110, %f367, %f1366, %f1109
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1110) : "f"(f367), "f"(f1366), "f"(f1109));
  // PTX:1704 mul.f32 %f1111, %f1104, %f359
  asm("mul.f32 %0, %1, %2;" : "=f"(f1111) : "f"(f1104), "f"(f359));
  // PTX:1705 mul.f32 %f1112, %f1107, %f359
  asm("mul.f32 %0, %1, %2;" : "=f"(f1112) : "f"(f1107), "f"(f359));
  // PTX:1706 mul.f32 %f1113, %f1110, %f359
  asm("mul.f32 %0, %1, %2;" : "=f"(f1113) : "f"(f1110), "f"(f359));
  // PTX:1707 red.global.add.f32 [%rd253], %f1111
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd253) + (0)))), (float)(f1111));
  // PTX:1708 red.global.add.f32 [%rd251], %f1112
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd251) + (0)))), (float)(f1112));
  // PTX:1709 red.global.add.f32 [%rd252], %f1113
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd252) + (0)))), (float)(f1113));
  // PTX:1710 mov.f32 %f1376, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1376) : );
  // PTX:1711 mov.f32 %f1377, %f1376
  asm("mov.f32 %0, %1;" : "=f"(f1377) : "f"(f1376));
  // PTX:1712 mov.f32 %f1378, %f1376
  asm("mov.f32 %0, %1;" : "=f"(f1378) : "f"(f1376));
  // PTX:1713 @%p65 bra $L__BB1_143
  if (p65) { goto L_BB1_143; }
  // PTX:1715 ld.global.f32 %f1117, [%rd56]
  f1117 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))));
  // PTX:1716 add.f32 %f1376, %f1117, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1376) : "f"(f1117));
  // PTX:1717 ld.global.f32 %f1118, [%rd56+4]
  f1118 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (4)))));
  // PTX:1718 add.f32 %f1377, %f1118, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1377) : "f"(f1118));
  // PTX:1719 ld.global.f32 %f1119, [%rd56+8]
  f1119 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (8)))));
  // PTX:1720 add.f32 %f1378, %f1119, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1378) : "f"(f1119));
  // PTX:1722 $L__BB1_143:
L_BB1_143:;
  // PTX:1723 @%p69 bra $L__BB1_145
  if (p69) { goto L_BB1_145; }
  // PTX:1725 ld.global.f32 %f1120, [%rd51]
  f1120 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))));
  // PTX:1726 sub.f32 %f1376, %f1376, %f1120
  asm("sub.f32 %0, %1, %2;" : "=f"(f1376) : "f"(f1376), "f"(f1120));
  // PTX:1727 ld.global.f32 %f1121, [%rd51+4]
  f1121 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (4)))));
  // PTX:1728 sub.f32 %f1377, %f1377, %f1121
  asm("sub.f32 %0, %1, %2;" : "=f"(f1377) : "f"(f1377), "f"(f1121));
  // PTX:1729 ld.global.f32 %f1122, [%rd51+8]
  f1122 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (8)))));
  // PTX:1730 sub.f32 %f1378, %f1378, %f1122
  asm("sub.f32 %0, %1, %2;" : "=f"(f1378) : "f"(f1378), "f"(f1122));
  // PTX:1732 $L__BB1_145:
L_BB1_145:;
  // PTX:1733 @%p73 bra $L__BB1_147
  if (p73) { goto L_BB1_147; }
  // PTX:1735 ld.global.f32 %f1123, [%rd52]
  f1123 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:1736 ld.global.f32 %f1124, [%rd52+4]
  f1124 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:1737 ld.global.f32 %f1125, [%rd52+8]
  f1125 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:1738 fma.rn.f32 %f1376, %f1123, %f359, %f1376
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1376) : "f"(f1123), "f"(f359), "f"(f1376));
  // PTX:1739 fma.rn.f32 %f1377, %f1124, %f359, %f1377
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1377) : "f"(f1124), "f"(f359), "f"(f1377));
  // PTX:1740 fma.rn.f32 %f1378, %f1125, %f359, %f1378
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1378) : "f"(f1125), "f"(f359), "f"(f1378));
  // PTX:1742 $L__BB1_147:
L_BB1_147:;
  // PTX:1743 @%p78 bra $L__BB1_149
  if (p78) { goto L_BB1_149; }
  // PTX:1745 ld.global.f32 %f1126, [%rd54]
  f1126 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:1746 ld.global.f32 %f1127, [%rd54+4]
  f1127 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (4)))));
  // PTX:1747 ld.global.f32 %f1128, [%rd54+8]
  f1128 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (8)))));
  // PTX:1748 fma.rn.f32 %f1376, %f1126, %f361, %f1376
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1376) : "f"(f1126), "f"(f361), "f"(f1376));
  // PTX:1749 fma.rn.f32 %f1377, %f1127, %f361, %f1377
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1377) : "f"(f1127), "f"(f361), "f"(f1377));
  // PTX:1750 fma.rn.f32 %f1378, %f1128, %f361, %f1378
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1378) : "f"(f1128), "f"(f361), "f"(f1378));
  // PTX:1752 $L__BB1_149:
L_BB1_149:;
  // PTX:1753 ld.param.u64 %rd262, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_25]
  rd262 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param25 + (0))));
  // PTX:1754 mul.lo.s64 %rd261, %rd235, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd261) : "l"(rd235));
  // PTX:1755 cvta.to.global.u64 %rd260, %rd262
  rd260 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd262));
  // PTX:1756 add.s64 %rd259, %rd260, %rd261
  asm("add.s64 %0, %1, %2;" : "=l"(rd259) : "l"(rd260), "l"(rd261));
  // PTX:1757 add.s64 %rd258, %rd259, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd258) : "l"(rd259));
  // PTX:1758 add.s64 %rd257, %rd259, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd257) : "l"(rd259));
  // PTX:1759 mul.f32 %f1132, %f363, %f1377
  asm("mul.f32 %0, %1, %2;" : "=f"(f1132) : "f"(f363), "f"(f1377));
  // PTX:1760 fma.rn.f32 %f1133, %f362, %f1376, %f1132
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1133) : "f"(f362), "f"(f1376), "f"(f1132));
  // PTX:1761 fma.rn.f32 %f1134, %f364, %f1378, %f1133
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1134) : "f"(f364), "f"(f1378), "f"(f1133));
  // PTX:1762 mul.f32 %f1135, %f365, %f1377
  asm("mul.f32 %0, %1, %2;" : "=f"(f1135) : "f"(f365), "f"(f1377));
  // PTX:1763 fma.rn.f32 %f1136, %f363, %f1376, %f1135
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1136) : "f"(f363), "f"(f1376), "f"(f1135));
  // PTX:1764 fma.rn.f32 %f1137, %f366, %f1378, %f1136
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1137) : "f"(f366), "f"(f1378), "f"(f1136));
  // PTX:1765 mul.f32 %f1138, %f366, %f1377
  asm("mul.f32 %0, %1, %2;" : "=f"(f1138) : "f"(f366), "f"(f1377));
  // PTX:1766 fma.rn.f32 %f1139, %f364, %f1376, %f1138
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1139) : "f"(f364), "f"(f1376), "f"(f1138));
  // PTX:1767 fma.rn.f32 %f1140, %f367, %f1378, %f1139
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1140) : "f"(f367), "f"(f1378), "f"(f1139));
  // PTX:1768 mul.f32 %f1141, %f1134, %f360
  asm("mul.f32 %0, %1, %2;" : "=f"(f1141) : "f"(f1134), "f"(f360));
  // PTX:1769 mul.f32 %f1142, %f1137, %f360
  asm("mul.f32 %0, %1, %2;" : "=f"(f1142) : "f"(f1137), "f"(f360));
  // PTX:1770 mul.f32 %f1143, %f1140, %f360
  asm("mul.f32 %0, %1, %2;" : "=f"(f1143) : "f"(f1140), "f"(f360));
  // PTX:1771 red.global.add.f32 [%rd259], %f1141
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd259) + (0)))), (float)(f1141));
  // PTX:1772 red.global.add.f32 [%rd257], %f1142
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd257) + (0)))), (float)(f1142));
  // PTX:1773 red.global.add.f32 [%rd258], %f1143
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd258) + (0)))), (float)(f1143));
  // PTX:1774 mov.f32 %f1388, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1388) : );
  // PTX:1775 mov.f32 %f1389, %f1388
  asm("mov.f32 %0, %1;" : "=f"(f1389) : "f"(f1388));
  // PTX:1776 mov.f32 %f1390, %f1388
  asm("mov.f32 %0, %1;" : "=f"(f1390) : "f"(f1388));
  // PTX:1777 @%p66 bra $L__BB1_151
  if (p66) { goto L_BB1_151; }
  // PTX:1779 ld.global.f32 %f1147, [%rd56]
  f1147 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))));
  // PTX:1780 add.f32 %f1388, %f1147, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1388) : "f"(f1147));
  // PTX:1781 ld.global.f32 %f1148, [%rd56+4]
  f1148 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (4)))));
  // PTX:1782 add.f32 %f1389, %f1148, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1389) : "f"(f1148));
  // PTX:1783 ld.global.f32 %f1149, [%rd56+8]
  f1149 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (8)))));
  // PTX:1784 add.f32 %f1390, %f1149, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1390) : "f"(f1149));
  // PTX:1786 $L__BB1_151:
L_BB1_151:;
  // PTX:1787 @%p70 bra $L__BB1_153
  if (p70) { goto L_BB1_153; }
  // PTX:1789 ld.global.f32 %f1150, [%rd51]
  f1150 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))));
  // PTX:1790 sub.f32 %f1388, %f1388, %f1150
  asm("sub.f32 %0, %1, %2;" : "=f"(f1388) : "f"(f1388), "f"(f1150));
  // PTX:1791 ld.global.f32 %f1151, [%rd51+4]
  f1151 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (4)))));
  // PTX:1792 sub.f32 %f1389, %f1389, %f1151
  asm("sub.f32 %0, %1, %2;" : "=f"(f1389) : "f"(f1389), "f"(f1151));
  // PTX:1793 ld.global.f32 %f1152, [%rd51+8]
  f1152 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (8)))));
  // PTX:1794 sub.f32 %f1390, %f1390, %f1152
  asm("sub.f32 %0, %1, %2;" : "=f"(f1390) : "f"(f1390), "f"(f1152));
  // PTX:1796 $L__BB1_153:
L_BB1_153:;
  // PTX:1797 @%p74 bra $L__BB1_155
  if (p74) { goto L_BB1_155; }
  // PTX:1799 ld.global.f32 %f1153, [%rd52]
  f1153 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:1800 ld.global.f32 %f1154, [%rd52+4]
  f1154 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:1801 ld.global.f32 %f1155, [%rd52+8]
  f1155 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:1802 fma.rn.f32 %f1388, %f1153, %f359, %f1388
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1388) : "f"(f1153), "f"(f359), "f"(f1388));
  // PTX:1803 fma.rn.f32 %f1389, %f1154, %f359, %f1389
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1389) : "f"(f1154), "f"(f359), "f"(f1389));
  // PTX:1804 fma.rn.f32 %f1390, %f1155, %f359, %f1390
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1390) : "f"(f1155), "f"(f359), "f"(f1390));
  // PTX:1806 $L__BB1_155:
L_BB1_155:;
  // PTX:1807 @%p78 bra $L__BB1_157
  if (p78) { goto L_BB1_157; }
  // PTX:1809 ld.global.f32 %f1156, [%rd53]
  f1156 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:1810 ld.global.f32 %f1157, [%rd53+4]
  f1157 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (4)))));
  // PTX:1811 ld.global.f32 %f1158, [%rd53+8]
  f1158 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (8)))));
  // PTX:1812 fma.rn.f32 %f1388, %f1156, %f360, %f1388
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1388) : "f"(f1156), "f"(f360), "f"(f1388));
  // PTX:1813 fma.rn.f32 %f1389, %f1157, %f360, %f1389
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1389) : "f"(f1157), "f"(f360), "f"(f1389));
  // PTX:1814 fma.rn.f32 %f1390, %f1158, %f360, %f1390
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1390) : "f"(f1158), "f"(f360), "f"(f1390));
  // PTX:1816 $L__BB1_157:
L_BB1_157:;
  // PTX:1817 ld.param.u64 %rd268, [_ZN7synreal6kernel42multiply_soft_contact_hessian_off_diagonalEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PKfS2_S2_PKNS_9TransformES8_SA_S2_SA_SA_SA_mmmS2_PKNS4_ILi4EiLS5_0EEES8_mS8_S8_PS6_fmffmS2_mSA_SA_ffS8_S8__param_25]
  rd268 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param25 + (0))));
  // PTX:1818 mul.lo.s64 %rd267, %rd236, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd267) : "l"(rd236));
  // PTX:1819 cvta.to.global.u64 %rd266, %rd268
  rd266 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd268));
  // PTX:1820 add.s64 %rd265, %rd266, %rd267
  asm("add.s64 %0, %1, %2;" : "=l"(rd265) : "l"(rd266), "l"(rd267));
  // PTX:1821 add.s64 %rd264, %rd265, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd264) : "l"(rd265));
  // PTX:1822 add.s64 %rd263, %rd265, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd263) : "l"(rd265));
  // PTX:1823 mul.f32 %f1159, %f363, %f1389
  asm("mul.f32 %0, %1, %2;" : "=f"(f1159) : "f"(f363), "f"(f1389));
  // PTX:1824 fma.rn.f32 %f1160, %f362, %f1388, %f1159
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1160) : "f"(f362), "f"(f1388), "f"(f1159));
  // PTX:1825 fma.rn.f32 %f1161, %f364, %f1390, %f1160
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1161) : "f"(f364), "f"(f1390), "f"(f1160));
  // PTX:1826 mul.f32 %f1162, %f365, %f1389
  asm("mul.f32 %0, %1, %2;" : "=f"(f1162) : "f"(f365), "f"(f1389));
  // PTX:1827 fma.rn.f32 %f1163, %f363, %f1388, %f1162
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1163) : "f"(f363), "f"(f1388), "f"(f1162));
  // PTX:1828 fma.rn.f32 %f1164, %f366, %f1390, %f1163
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1164) : "f"(f366), "f"(f1390), "f"(f1163));
  // PTX:1829 mul.f32 %f1165, %f366, %f1389
  asm("mul.f32 %0, %1, %2;" : "=f"(f1165) : "f"(f366), "f"(f1389));
  // PTX:1830 fma.rn.f32 %f1166, %f364, %f1388, %f1165
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1166) : "f"(f364), "f"(f1388), "f"(f1165));
  // PTX:1831 fma.rn.f32 %f1167, %f367, %f1390, %f1166
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1167) : "f"(f367), "f"(f1390), "f"(f1166));
  // PTX:1832 mul.f32 %f1168, %f1161, %f361
  asm("mul.f32 %0, %1, %2;" : "=f"(f1168) : "f"(f1161), "f"(f361));
  // PTX:1833 mul.f32 %f1169, %f1164, %f361
  asm("mul.f32 %0, %1, %2;" : "=f"(f1169) : "f"(f1164), "f"(f361));
  // PTX:1834 mul.f32 %f1170, %f1167, %f361
  asm("mul.f32 %0, %1, %2;" : "=f"(f1170) : "f"(f1167), "f"(f361));
  // PTX:1835 red.global.add.f32 [%rd265], %f1168
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd265) + (0)))), (float)(f1168));
  // PTX:1836 red.global.add.f32 [%rd263], %f1169
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd263) + (0)))), (float)(f1169));
  // PTX:1837 red.global.add.f32 [%rd264], %f1170
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd264) + (0)))), (float)(f1170));
  // PTX:1839 $L__BB1_158:
L_BB1_158:;
  // PTX:1840 mov.u32 %r212, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r212) : "r"(blockDim.x));
  // PTX:1841 mov.u32 %r209, %nctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r209) : "r"(gridDim.x));
  // PTX:1842 mul.wide.u32 %rd230, %r209, %r212
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd230) : "r"(r209), "r"(r212));
  // PTX:1843 add.s64 %rd279, %rd279, %rd230
  asm("add.s64 %0, %1, %2;" : "=l"(rd279) : "l"(rd279), "l"(rd230));
  // PTX:1844 setp.lt.u64 %p103, %rd279, %rd3
  p103 = (((unsigned long long)(rd279)) < ((unsigned long long)(rd3)));
  // PTX:1845 @%p103 bra $L__BB1_5
  if (p103) { goto L_BB1_5; }
  // PTX:1847 $L__BB1_159:
L_BB1_159:;
  // PTX:1848 ret
  return;
}
