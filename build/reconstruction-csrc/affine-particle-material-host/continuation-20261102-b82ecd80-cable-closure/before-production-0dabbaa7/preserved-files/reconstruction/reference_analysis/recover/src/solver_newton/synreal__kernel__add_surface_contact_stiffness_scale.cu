// 机械还原自 PTX：synreal::kernel::add_surface_contact_stiffness_scale(synreal::kernel::SurfaceContactView, float*)
// PTX SHA256: 6a8d1df1fcf0c64d02910fb90bd3641015122e12f7ef14844a4f25b71b244ef7
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__add_surface_contact_stiffness_scale(ByVal<296, 8> param0, unsigned long long param1) {
  unsigned long long SP, SPL, rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162, rd163, rd164, rd165, rd166, rd167, rd168, rd169, rd170, rd171, rd172, rd173, rd174, rd175, rd176, rd177, rd178, rd179, rd180, rd181, rd182, rd183, rd184, rd185, rd186, rd187, rd188, rd189, rd190, rd191, rd192, rd193, rd194, rd195, rd196, rd197, rd198, rd199, rd200, rd201, rd202, rd203, rd204, rd205, rd206, rd207, rd208, rd209, rd210, rd211, rd212, rd213, rd214, rd215, rd216, rd217, rd218, rd219, rd220, rd221, rd222, rd223, rd224, rd225, rd226, rd227, rd228, rd229, rd230, rd231, rd232, rd233, rd234, rd235, rd236, rd237, rd238, rd239, rd240, rd241, rd242, rd243, rd244, rd245, rd246, rd247, rd248, rd249, rd250, rd251, rd252, rd253, rd254, rd255, rd256, rd257, rd258, rd259, rd260, rd261, rd262, rd263, rd264, rd265, rd266, rd267, rd268, rd269, rd270, rd271, rd272, rd273, rd274, rd275, rd276, rd277, rd278, rd279, rd280, rd281, rd282, rd283, rd284, rd285, rd286, rd287, rd288, rd289, rd290, rd291, rd292, rd293, rd294, rd295, rd296, rd297, rd298, rd299, rd300, rd301, rd302, rd303, rd304, rd305, rd306, rd307, rd308, rd309, rd310, rd311, rd312, rd313, rd314, rd315, rd316, rd317, rd318, rd319, rd320, rd321, rd322, rd323, rd324, rd325, rd326, rd327, rd328, rd329, rd330, rd331, rd332, rd333, rd334, rd335, rd336, rd337, rd338, rd339, rd340, rd341, rd342, rd343, rd344, rd345, rd346, rd347, rd348, rd349, rd350, rd351, rd352, rd353, rd354, rd355, rd356, rd357, rd358, rd359, rd360, rd361, rd362, rd363;
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62, p63, p64, p65, p66, p67, p68, p69, p70, p71, p72, p73, p74, p75, p76, p77, p78, p79, p80, p81, p82, p83, p84, p85, p86, p87, p88, p89, p90, p91, p92, p93, p94, p95, p96, p97, p98, p99, p100, p101, p102, p103, p104, p105, p106, p107, p108, p109, p110, p111, p112, p113, p114, p115, p116, p117, p118, p119, p120, p121, p122, p123, p124, p125, p126, p127, p128, p129, p130, p131, p132, p133, p134, p135, p136, p137, p138, p139, p140, p141, p142, p143, p144, p145, p146;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503, f504, f505, f506, f507, f508, f509, f510, f511, f512, f513, f514, f515, f516, f517, f518, f519, f520, f521, f522, f523, f524, f525, f526, f527, f528, f529, f530, f531, f532, f533, f534, f535, f536, f537, f538, f539, f540, f541, f542, f543, f544, f545, f546, f547, f548, f549, f550, f551, f552, f553, f554, f555, f556, f557, f558, f559, f560, f561, f562, f563, f564, f565, f566, f567, f568, f569, f570, f571, f572, f573, f574, f575, f576, f577, f578, f579, f580, f581, f582, f583, f584, f585, f586, f587, f588, f589, f590, f591, f592, f593, f594, f595, f596, f597, f598, f599, f600, f601, f602, f603, f604, f605, f606, f607, f608, f609, f610, f611, f612, f613, f614, f615, f616, f617, f618, f619, f620, f621, f622, f623, f624, f625, f626, f627, f628, f629, f630, f631, f632, f633, f634, f635, f636, f637, f638, f639, f640, f641, f642, f643, f644, f645, f646, f647, f648, f649, f650, f651, f652, f653, f654, f655, f656, f657, f658, f659, f660, f661, f662, f663, f664, f665, f666, f667, f668, f669, f670, f671, f672, f673, f674, f675, f676, f677, f678, f679, f680, f681, f682, f683, f684, f685, f686, f687, f688, f689, f690, f691, f692, f693, f694, f695, f696, f697, f698, f699, f700, f701, f702, f703, f704, f705, f706, f707, f708, f709, f710, f711, f712, f713, f714, f715, f716, f717, f718, f719, f720, f721, f722, f723, f724, f725, f726, f727, f728, f729, f730, f731, f732, f733, f734, f735, f736, f737, f738, f739, f740, f741, f742, f743, f744, f745, f746, f747, f748, f749, f750, f751, f752, f753, f754, f755, f756, f757, f758, f759, f760, f761, f762, f763, f764, f765, f766, f767, f768, f769, f770, f771, f772, f773, f774, f775, f776, f777, f778, f779, f780, f781, f782, f783, f784, f785, f786, f787, f788, f789, f790, f791, f792, f793, f794, f795, f796, f797, f798, f799, f800, f801, f802, f803, f804, f805, f806, f807, f808, f809, f810, f811, f812, f813, f814, f815, f816, f817, f818, f819, f820, f821, f822, f823, f824, f825, f826, f827, f828, f829, f830, f831, f832, f833, f834, f835, f836, f837, f838, f839, f840, f841, f842, f843, f844, f845, f846, f847, f848, f849, f850, f851, f852, f853, f854, f855, f856, f857, f858, f859, f860, f861, f862, f863, f864, f865, f866, f867, f868, f869, f870, f871, f872, f873, f874, f875, f876, f877, f878, f879, f880, f881, f882, f883, f884, f885, f886, f887, f888, f889, f890, f891, f892, f893, f894, f895, f896, f897, f898, f899, f900, f901, f902, f903, f904, f905, f906, f907, f908, f909, f910, f911, f912, f913, f914, f915, f916, f917, f918, f919, f920, f921, f922, f923, f924, f925, f926, f927, f928, f929, f930, f931, f932, f933, f934, f935, f936, f937, f938, f939, f940, f941, f942, f943, f944, f945, f946, f947, f948, f949, f950, f951, f952, f953, f954, f955, f956, f957, f958, f959, f960, f961, f962, f963, f964, f965, f966, f967, f968, f969, f970, f971, f972, f973, f974, f975, f976, f977, f978, f979, f980, f981, f982, f983, f984, f985, f986, f987, f988, f989, f990, f991, f992, f993, f994, f995, f996, f997, f998, f999, f1000, f1001, f1002, f1003, f1004, f1005, f1006, f1007, f1008, f1009, f1010, f1011, f1012, f1013, f1014, f1015, f1016, f1017, f1018, f1019, f1020, f1021, f1022, f1023, f1024, f1025, f1026, f1027, f1028, f1029, f1030, f1031, f1032, f1033, f1034, f1035, f1036, f1037, f1038, f1039, f1040, f1041, f1042, f1043, f1044, f1045, f1046, f1047, f1048, f1049, f1050, f1051, f1052, f1053, f1054, f1055, f1056, f1057, f1058, f1059, f1060, f1061, f1062, f1063, f1064, f1065, f1066, f1067, f1068, f1069, f1070, f1071, f1072, f1073, f1074, f1075, f1076, f1077, f1078, f1079, f1080, f1081, f1082, f1083, f1084, f1085, f1086, f1087, f1088, f1089, f1090, f1091, f1092, f1093, f1094, f1095, f1096, f1097, f1098, f1099, f1100, f1101, f1102, f1103, f1104, f1105, f1106, f1107, f1108, f1109, f1110, f1111, f1112, f1113, f1114, f1115, f1116, f1117, f1118, f1119, f1120, f1121, f1122, f1123, f1124, f1125, f1126, f1127, f1128, f1129, f1130, f1131, f1132, f1133, f1134, f1135, f1136, f1137, f1138, f1139, f1140, f1141, f1142, f1143, f1144, f1145, f1146, f1147, f1148, f1149, f1150, f1151, f1152, f1153, f1154, f1155, f1156, f1157, f1158, f1159, f1160, f1161, f1162, f1163, f1164, f1165, f1166, f1167, f1168, f1169, f1170, f1171, f1172, f1173, f1174, f1175, f1176, f1177, f1178, f1179, f1180, f1181, f1182, f1183, f1184, f1185, f1186, f1187, f1188, f1189, f1190, f1191, f1192, f1193, f1194, f1195, f1196, f1197, f1198, f1199, f1200, f1201, f1202, f1203, f1204, f1205, f1206, f1207, f1208, f1209, f1210, f1211, f1212, f1213, f1214, f1215, f1216, f1217, f1218, f1219, f1220, f1221, f1222, f1223, f1224, f1225, f1226, f1227, f1228, f1229, f1230, f1231, f1232, f1233, f1234, f1235, f1236, f1237, f1238, f1239, f1240, f1241, f1242, f1243, f1244, f1245, f1246, f1247, f1248, f1249, f1250, f1251, f1252, f1253, f1254, f1255, f1256, f1257, f1258, f1259, f1260, f1261, f1262, f1263, f1264, f1265, f1266, f1267, f1268, f1269, f1270, f1271, f1272, f1273, f1274, f1275, f1276, f1277, f1278, f1279, f1280, f1281, f1282, f1283, f1284, f1285, f1286, f1287, f1288, f1289, f1290, f1291, f1292, f1293, f1294, f1295, f1296, f1297, f1298, f1299, f1300, f1301, f1302, f1303, f1304, f1305, f1306, f1307, f1308, f1309, f1310, f1311, f1312, f1313, f1314, f1315, f1316, f1317, f1318, f1319, f1320, f1321, f1322, f1323, f1324, f1325, f1326, f1327, f1328, f1329, f1330, f1331, f1332, f1333, f1334, f1335, f1336, f1337, f1338, f1339, f1340, f1341, f1342, f1343, f1344, f1345, f1346, f1347, f1348, f1349, f1350, f1351, f1352, f1353, f1354, f1355, f1356, f1357, f1358, f1359, f1360, f1361, f1362, f1363, f1364, f1365, f1366, f1367, f1368, f1369, f1370, f1371, f1372, f1373, f1374, f1375, f1376, f1377, f1378, f1379, f1380, f1381, f1382, f1383, f1384, f1385, f1386, f1387, f1388, f1389, f1390, f1391, f1392, f1393, f1394, f1395, f1396, f1397, f1398, f1399, f1400, f1401, f1402, f1403, f1404, f1405, f1406, f1407, f1408, f1409, f1410, f1411, f1412, f1413, f1414, f1415, f1416, f1417, f1418, f1419, f1420, f1421, f1422, f1423, f1424, f1425, f1426, f1427, f1428, f1429, f1430, f1431, f1432, f1433, f1434, f1435, f1436, f1437, f1438, f1439, f1440, f1441, f1442, f1443, f1444, f1445, f1446, f1447, f1448, f1449, f1450, f1451, f1452, f1453, f1454, f1455, f1456, f1457, f1458, f1459, f1460, f1461, f1462, f1463, f1464, f1465, f1466, f1467, f1468, f1469, f1470, f1471, f1472, f1473, f1474, f1475, f1476, f1477, f1478, f1479, f1480, f1481, f1482, f1483, f1484, f1485, f1486, f1487, f1488, f1489, f1490, f1491, f1492, f1493, f1494, f1495, f1496, f1497, f1498, f1499, f1500, f1501, f1502, f1503, f1504, f1505, f1506, f1507, f1508, f1509, f1510, f1511, f1512, f1513, f1514, f1515, f1516, f1517, f1518, f1519, f1520, f1521, f1522, f1523, f1524, f1525, f1526, f1527, f1528, f1529, f1530, f1531, f1532, f1533, f1534, f1535, f1536, f1537, f1538, f1539, f1540, f1541, f1542, f1543, f1544, f1545, f1546, f1547, f1548, f1549, f1550, f1551, f1552, f1553, f1554, f1555, f1556, f1557, f1558, f1559, f1560, f1561, f1562, f1563, f1564, f1565, f1566, f1567, f1568, f1569, f1570, f1571, f1572, f1573, f1574;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146, r147, r148, r149, r150, r151, r152, r153, r154, r155, r156, r157, r158, r159, r160, r161, r162, r163, r164, r165, r166, r167, r168, r169, r170, r171, r172, r173, r174, r175, r176, r177, r178, r179, r180, r181, r182, r183, r184, r185, r186, r187, r188, r189, r190, r191, r192, r193, r194, r195, r196, r197, r198, r199, r200, r201, r202, r203, r204, r205, r206, r207, r208, r209, r210, r211, r212, r213, r214, r215, r216, r217, r218, r219, r220, r221, r222, r223, r224, r225, r226, r227, r228, r229, r230, r231, r232, r233, r234, r235, r236, r237, r238, r239, r240, r241, r242, r243, r244, r245, r246, r247, r248, r249, r250, r251, r252, r253, r254, r255, r256, r257, r258, r259, r260, r261, r262, r263, r264, r265, r266, r267, r268, r269, r270, r271, r272, r273, r274, r275, r276, r277, r278, r279, r280, r281, r282, r283, r284, r285, r286, r287, r288, r289, r290, r291, r292, r293, r294, r295, r296, r297, r298, r299, r300, r301, r302, r303, r304, r305, r306, r307, r308, r309, r310, r311, r312, r313, r314, r315, r316, r317, r318, r319, r320, r321, r322, r323, r324, r325, r326, r327, r328, r329, r330, r331, r332, r333, r334, r335, r336, r337, r338, r339, r340, r341, r342, r343, r344, r345, r346, r347, r348, r349, r350, r351, r352, r353, r354, r355, r356, r357, r358, r359, r360, r361, r362, r363, r364, r365, r366, r367, r368, r369, r370, r371, r372, r373, r374, r375, r376, r377, r378, r379, r380, r381, r382, r383, r384, r385, r386, r387, r388, r389, r390, r391, r392, r393, r394, r395, r396, r397, r398, r399, r400, r401, r402, r403, r404, r405, r406, r407, r408, r409, r410, r411, r412, r413, r414, r415, r416, r417, r418, r419, r420, r421, r422, r423, r424, r425, r426, r427, r428, r429, r430, r431, r432, r433, r434, r435, r436, r437, r438, r439, r440, r441, r442, r443, r444, r445, r446, r447, r448, r449, r450, r451, r452, r453, r454, r455, r456, r457, r458, r459, r460, r461, r462, r463, r464, r465, r466, r467, r468, r469, r470, r471, r472, r473, r474, r475, r476, r477, r478, r479, r480, r481, r482, r483, r484, r485, r486, r487, r488, r489, r490, r491, r492, r493, r494, r495, r496, r497, r498, r499, r500, r501, r502, r503, r504, r505, r506, r507, r508, r509, r510, r511, r512, r513, r514, r515, r516, r517, r518, r519, r520, r521, r522, r523, r524, r525, r526, r527, r528, r529, r530, r531, r532, r533, r534, r535, r536, r537, r538, r539, r540, r541, r542, r543, r544, r545, r546, r547, r548, r549, r550, r551, r552, r553, r554, r555, r556, r557, r558, r559, r560, r561, r562, r563, r564, r565, r566, r567, r568, r569, r570, r571, r572, r573, r574, r575, r576, r577, r578, r579, r580, r581, r582, r583, r584, r585, r586, r587, r588, r589, r590, r591, r592, r593, r594, r595, r596, r597, r598, r599, r600, r601, r602, r603, r604, r605, r606, r607, r608, r609, r610, r611, r612, r613, r614, r615, r616, r617, r618, r619, r620, r621, r622, r623, r624, r625, r626, r627, r628, r629, r630, r631, r632, r633, r634, r635, r636, r637, r638, r639, r640, r641, r642, r643, r644, r645, r646, r647, r648, r649, r650, r651, r652, r653, r654, r655, r656, r657, r658, r659, r660, r661, r662, r663, r664, r665, r666, r667, r668, r669, r670, r671, r672, r673, r674, r675, r676, r677, r678, r679, r680, r681, r682, r683, r684, r685, r686, r687, r688, r689, r690, r691, r692, r693, r694, r695, r696, r697, r698, r699, r700, r701, r702, r703, r704, r705, r706, r707, r708, r709, r710, r711, r712, r713, r714, r715, r716, r717, r718, r719, r720, r721, r722, r723, r724, r725, r726, r727, r728, r729, r730, r731, r732, r733, r734, r735, r736, r737, r738, r739, r740, r741, r742, r743, r744, r745, r746, r747, r748, r749, r750, r751, r752, r753, r754, r755, r756, r757, r758, r759, r760, r761, r762, r763, r764, r765, r766, r767, r768, r769, r770, r771, r772, r773, r774, r775, r776, r777, r778, r779, r780, r781, r782, r783, r784, r785, r786, r787, r788, r789, r790, r791, r792, r793, r794, r795, r796, r797, r798, r799, r800, r801, r802, r803, r804, r805, r806, r807, r808, r809, r810, r811, r812, r813, r814, r815, r816, r817, r818, r819, r820, r821, r822, r823, r824, r825, r826, r827, r828, r829, r830, r831, r832, r833, r834, r835, r836, r837, r838, r839, r840, r841, r842, r843, r844, r845, r846, r847, r848, r849, r850, r851, r852, r853, r854, r855, r856, r857, r858, r859, r860, r861, r862, r863, r864, r865, r866, r867, r868, r869, r870, r871, r872, r873, r874, r875, r876, r877, r878, r879, r880, r881, r882, r883, r884, r885, r886, r887, r888, r889, r890, r891, r892, r893, r894, r895, r896, r897, r898, r899, r900, r901, r902, r903, r904, r905, r906, r907, r908, r909, r910, r911, r912, r913, r914, r915, r916, r917, r918, r919, r920, r921, r922, r923, r924, r925, r926, r927, r928, r929, r930, r931, r932, r933, r934, r935, r936, r937, r938, r939, r940, r941, r942, r943, r944, r945, r946, r947, r948, r949, r950, r951, r952, r953, r954, r955, r956, r957, r958, r959, r960, r961, r962, r963, r964, r965, r966, r967, r968, r969, r970, r971, r972, r973, r974, r975, r976, r977, r978, r979, r980, r981, r982, r983, r984, r985, r986, r987, r988, r989, r990, r991, r992, r993, r994, r995, r996, r997, r998, r999, r1000, r1001, r1002, r1003, r1004, r1005, r1006, r1007, r1008, r1009, r1010, r1011, r1012, r1013, r1014, r1015, r1016, r1017, r1018, r1019, r1020, r1021, r1022, r1023, r1024, r1025, r1026, r1027, r1028, r1029, r1030, r1031, r1032, r1033, r1034, r1035, r1036, r1037, r1038, r1039, r1040, r1041, r1042, r1043, r1044, r1045, r1046, r1047, r1048, r1049, r1050, r1051, r1052, r1053, r1054, r1055, r1056, r1057, r1058, r1059, r1060, r1061, r1062, r1063, r1064, r1065, r1066, r1067, r1068, r1069, r1070, r1071, r1072, r1073, r1074, r1075, r1076, r1077, r1078, r1079, r1080, r1081, r1082, r1083, r1084, r1085, r1086, r1087, r1088, r1089, r1090, r1091, r1092, r1093, r1094, r1095, r1096, r1097, r1098, r1099, r1100, r1101, r1102, r1103, r1104, r1105, r1106, r1107, r1108, r1109, r1110, r1111, r1112, r1113, r1114, r1115, r1116, r1117, r1118, r1119, r1120, r1121, r1122, r1123, r1124, r1125, r1126, r1127, r1128, r1129, r1130, r1131, r1132, r1133, r1134, r1135, r1136, r1137, r1138, r1139, r1140, r1141, r1142, r1143, r1144, r1145, r1146, r1147, r1148, r1149, r1150, r1151, r1152, r1153, r1154, r1155, r1156, r1157, r1158, r1159, r1160, r1161, r1162, r1163, r1164, r1165, r1166, r1167, r1168, r1169, r1170, r1171, r1172, r1173, r1174, r1175, r1176, r1177, r1178, r1179, r1180, r1181, r1182, r1183, r1184, r1185, r1186, r1187, r1188, r1189, r1190, r1191, r1192, r1193, r1194, r1195, r1196, r1197, r1198, r1199, r1200, r1201, r1202, r1203, r1204, r1205, r1206, r1207, r1208, r1209, r1210, r1211, r1212, r1213, r1214, r1215, r1216, r1217, r1218, r1219, r1220, r1221, r1222, r1223, r1224, r1225, r1226, r1227, r1228, r1229, r1230, r1231, r1232, r1233, r1234, r1235, r1236, r1237, r1238, r1239, r1240, r1241, r1242, r1243, r1244, r1245, r1246, r1247, r1248, r1249, r1250, r1251, r1252, r1253, r1254, r1255, r1256, r1257, r1258, r1259, r1260, r1261, r1262, r1263, r1264, r1265, r1266, r1267, r1268, r1269, r1270, r1271, r1272, r1273, r1274, r1275, r1276, r1277, r1278, r1279, r1280, r1281, r1282, r1283, r1284, r1285, r1286, r1287, r1288, r1289, r1290, r1291, r1292, r1293, r1294, r1295, r1296, r1297, r1298, r1299, r1300, r1301, r1302, r1303, r1304, r1305, r1306, r1307, r1308, r1309, r1310, r1311, r1312, r1313, r1314, r1315, r1316, r1317, r1318, r1319, r1320, r1321, r1322, r1323, r1324, r1325, r1326, r1327, r1328, r1329, r1330, r1331, r1332, r1333, r1334, r1335, r1336, r1337, r1338, r1339, r1340, r1341, r1342, r1343, r1344, r1345, r1346, r1347, r1348, r1349, r1350, r1351, r1352, r1353, r1354, r1355, r1356, r1357, r1358, r1359, r1360, r1361, r1362, r1363, r1364, r1365, r1366, r1367, r1368, r1369, r1370, r1371, r1372, r1373, r1374, r1375, r1376, r1377, r1378, r1379, r1380, r1381, r1382, r1383, r1384, r1385, r1386, r1387, r1388, r1389, r1390, r1391, r1392, r1393, r1394, r1395, r1396, r1397, r1398, r1399, r1400, r1401, r1402, r1403, r1404, r1405, r1406, r1407, r1408, r1409, r1410, r1411, r1412, r1413, r1414, r1415, r1416, r1417, r1418, r1419, r1420, r1421, r1422, r1423, r1424, r1425, r1426, r1427, r1428, r1429, r1430, r1431, r1432, r1433, r1434, r1435, r1436, r1437, r1438, r1439, r1440, r1441, r1442, r1443, r1444, r1445, r1446, r1447, r1448, r1449, r1450, r1451, r1452, r1453, r1454, r1455, r1456, r1457, r1458, r1459, r1460, r1461, r1462, r1463, r1464, r1465, r1466, r1467, r1468, r1469, r1470, r1471, r1472, r1473, r1474, r1475, r1476, r1477, r1478, r1479, r1480, r1481, r1482, r1483, r1484, r1485, r1486, r1487, r1488, r1489, r1490, r1491, r1492, r1493, r1494, r1495, r1496, r1497, r1498, r1499, r1500, r1501, r1502, r1503, r1504, r1505, r1506, r1507, r1508, r1509, r1510, r1511, r1512, r1513, r1514, r1515, r1516, r1517, r1518, r1519, r1520, r1521, r1522, r1523, r1524, r1525, r1526, r1527, r1528, r1529, r1530, r1531, r1532, r1533, r1534, r1535, r1536, r1537, r1538, r1539, r1540, r1541, r1542, r1543, r1544, r1545, r1546, r1547, r1548, r1549, r1550, r1551, r1552, r1553, r1554, r1555, r1556, r1557, r1558, r1559, r1560, r1561, r1562, r1563, r1564, r1565, r1566, r1567, r1568, r1569, r1570, r1571, r1572, r1573, r1574, r1575, r1576, r1577, r1578, r1579, r1580, r1581, r1582, r1583, r1584, r1585, r1586, r1587, r1588, r1589, r1590, r1591, r1592, r1593, r1594, r1595, r1596, r1597, r1598, r1599, r1600, r1601, r1602, r1603, r1604, r1605, r1606, r1607, r1608, r1609, r1610, r1611, r1612, r1613, r1614, r1615, r1616, r1617, r1618, r1619, r1620, r1621, r1622, r1623, r1624, r1625, r1626, r1627, r1628, r1629, r1630, r1631, r1632, r1633, r1634, r1635, r1636, r1637, r1638, r1639, r1640, r1641, r1642, r1643, r1644, r1645, r1646, r1647, r1648, r1649, r1650, r1651, r1652, r1653, r1654, r1655, r1656, r1657, r1658, r1659, r1660, r1661, r1662, r1663, r1664, r1665, r1666, r1667, r1668, r1669, r1670, r1671, r1672, r1673, r1674, r1675, r1676, r1677, r1678, r1679, r1680, r1681, r1682, r1683, r1684, r1685, r1686, r1687, r1688, r1689, r1690, r1691, r1692, r1693, r1694, r1695, r1696, r1697, r1698, r1699, r1700, r1701, r1702, r1703, r1704, r1705, r1706, r1707, r1708, r1709, r1710, r1711, r1712, r1713, r1714, r1715, r1716, r1717, r1718, r1719, r1720, r1721, r1722, r1723, r1724, r1725, r1726, r1727, r1728, r1729, r1730, r1731, r1732, r1733, r1734, r1735, r1736, r1737, r1738, r1739, r1740, r1741, r1742, r1743, r1744, r1745, r1746, r1747, r1748, r1749, r1750, r1751, r1752, r1753, r1754, r1755, r1756, r1757, r1758, r1759, r1760, r1761, r1762, r1763, r1764, r1765, r1766, r1767, r1768, r1769, r1770, r1771, r1772, r1773, r1774, r1775, r1776, r1777, r1778, r1779, r1780, r1781, r1782, r1783, r1784, r1785, r1786, r1787, r1788, r1789, r1790, r1791, r1792, r1793, r1794, r1795, r1796, r1797, r1798, r1799, r1800, r1801, r1802, r1803, r1804, r1805, r1806, r1807, r1808, r1809, r1810, r1811, r1812, r1813, r1814, r1815, r1816, r1817, r1818, r1819, r1820, r1821, r1822, r1823, r1824, r1825, r1826, r1827, r1828, r1829, r1830, r1831, r1832, r1833, r1834, r1835, r1836, r1837, r1838, r1839, r1840, r1841, r1842, r1843, r1844, r1845, r1846, r1847, r1848, r1849, r1850, r1851, r1852, r1853, r1854, r1855, r1856, r1857, r1858, r1859, r1860, r1861, r1862, r1863, r1864, r1865, r1866, r1867, r1868, r1869, r1870, r1871, r1872, r1873, r1874;
  __align__(4) unsigned char __local_depot7[440];
  // PTX:21 mov.u64 %SPL, __local_depot7
  SPL = (unsigned long long)__cvta_generic_to_local(__local_depot7);
  // PTX:22 mov.b64 %rd104, _ZN7synreal6kernel35add_surface_contact_stiffness_scaleENS0_18SurfaceContactViewEPf_param_0
  rd104 = (unsigned long long)(uintptr_t)&param0;
  // PTX:23 ld.param.u64 %rd105, [_ZN7synreal6kernel35add_surface_contact_stiffness_scaleENS0_18SurfaceContactViewEPf_param_1]
  rd105 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:24 cvta.to.global.u64 %rd1, %rd105
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd105));
  // PTX:25 add.u64 %rd2, %SPL, 0
  asm("add.u64 %0, %1, 0;" : "=l"(rd2) : "l"(SPL));
  // PTX:26 add.u64 %rd3, %SPL, 220
  asm("add.u64 %0, %1, 220;" : "=l"(rd3) : "l"(SPL));
  // PTX:27 add.s64 %rd4, %rd104, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd4) : "l"(rd104));
  // PTX:28 ld.param.u64 %rd109, [_ZN7synreal6kernel35add_surface_contact_stiffness_scaleENS0_18SurfaceContactViewEPf_param_0]
  rd109 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:29 cvta.to.global.u64 %rd110, %rd109
  rd110 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd109));
  // PTX:30 ld.global.u32 %r452, [%rd110]
  r452 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd110) + (0)))));
  // PTX:31 max.s32 %r453, %r452, 0
  asm("max.s32 %0, %1, 0;" : "=r"(r453) : "r"(r452));
  // PTX:32 cvt.s64.s32 %rd111, %r453
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd111) : "r"(r453));
  // PTX:33 ld.param.u64 %rd112, [_ZN7synreal6kernel35add_surface_contact_stiffness_scaleENS0_18SurfaceContactViewEPf_param_0+8]
  rd112 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (8))));
  // PTX:34 min.u64 %rd5, %rd112, %rd111
  asm("min.u64 %0, %1, %2;" : "=l"(rd5) : "l"(rd112), "l"(rd111));
  // PTX:35 mov.u32 %r454, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r454) : "r"(blockIdx.x));
  // PTX:36 mov.u32 %r455, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r455) : "r"(blockDim.x));
  // PTX:37 cvt.u64.u32 %rd6, %r455
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd6) : "r"(r455));
  // PTX:38 mul.wide.u32 %rd113, %r454, %r455
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd113) : "r"(r454), "r"(r455));
  // PTX:39 mov.u32 %r456, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r456) : "r"(threadIdx.x));
  // PTX:40 cvt.u64.u32 %rd114, %r456
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd114) : "r"(r456));
  // PTX:41 add.s64 %rd352, %rd113, %rd114
  asm("add.s64 %0, %1, %2;" : "=l"(rd352) : "l"(rd113), "l"(rd114));
  // PTX:42 setp.ge.u64 %p1, %rd352, %rd5
  p1 = (((unsigned long long)(rd352)) >= ((unsigned long long)(rd5)));
  // PTX:43 @%p1 bra $L__BB7_173
  if (p1) { goto L_BB7_173; }
  // PTX:45 ld.param.u64 %rd115, [%rd4+24]
  rd115 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (24))));
  // PTX:46 cvta.to.global.u64 %rd8, %rd115
  rd8 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd115));
  // PTX:47 mov.u32 %r457, %nctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r457) : "r"(gridDim.x));
  // PTX:48 cvt.u64.u32 %rd116, %r457
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd116) : "r"(r457));
  // PTX:49 mul.lo.s64 %rd9, %rd116, %rd6
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd9) : "l"(rd116), "l"(rd6));
  // PTX:50 ld.param.u64 %rd10, [%rd4+64]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (64))));
  // PTX:51 ld.param.u64 %rd117, [%rd4+8]
  rd117 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (8))));
  // PTX:52 cvta.to.global.u64 %rd11, %rd117
  rd11 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd117));
  // PTX:53 ld.param.u64 %rd118, [%rd4+16]
  rd118 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (16))));
  // PTX:54 cvta.to.global.u64 %rd12, %rd118
  rd12 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd118));
  // PTX:55 ld.param.u64 %rd13, [%rd4+56]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (56))));
  // PTX:56 cvta.to.global.u64 %rd14, %rd13
  rd14 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:57 ld.param.u64 %rd15, [%rd4+112]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (112))));
  // PTX:58 ld.param.u64 %rd16, [%rd4+192]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (192))));
  // PTX:59 ld.param.u64 %rd17, [%rd4+200]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (200))));
  // PTX:60 ld.param.u64 %rd18, [%rd4+208]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (208))));
  // PTX:61 mul.lo.s64 %rd19, %rd18, %rd17
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd18), "l"(rd17));
  // PTX:62 ld.param.u64 %rd119, [%rd4+72]
  rd119 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (72))));
  // PTX:63 cvta.to.global.u64 %rd20, %rd119
  rd20 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd119));
  // PTX:64 ld.param.u64 %rd21, [%rd4+96]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (96))));
  // PTX:65 cvta.to.global.u64 %rd22, %rd21
  rd22 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:66 ld.param.u64 %rd120, [%rd4+264]
  rd120 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (264))));
  // PTX:67 cvta.to.global.u64 %rd23, %rd120
  rd23 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd120));
  // PTX:68 ld.param.f32 %f1, [%rd4+280]
  f1 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd4) + (280))));
  // PTX:69 ld.param.u64 %rd24, [%rd4+272]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (272))));
  // PTX:70 cvta.to.global.u64 %rd25, %rd24
  rd25 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd24));
  // PTX:71 ld.param.u64 %rd121, [%rd4+80]
  rd121 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (80))));
  // PTX:72 cvta.to.global.u64 %rd26, %rd121
  rd26 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd121));
  // PTX:73 ld.param.u64 %rd27, [%rd4+88]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (88))));
  // PTX:74 cvta.to.global.u64 %rd28, %rd27
  rd28 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd27));
  // PTX:75 ld.param.u64 %rd122, [%rd4+120]
  rd122 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (120))));
  // PTX:76 cvta.to.global.u64 %rd29, %rd122
  rd29 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd122));
  // PTX:77 ld.param.u64 %rd123, [%rd4+232]
  rd123 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (232))));
  // PTX:78 cvta.to.global.u64 %rd30, %rd123
  rd30 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd123));
  // PTX:79 ld.param.u64 %rd31, [%rd4+256]
  rd31 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (256))));
  // PTX:80 ld.param.u64 %rd124, [%rd4+32]
  rd124 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (32))));
  // PTX:81 cvta.to.global.u64 %rd32, %rd124
  rd32 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd124));
  // PTX:82 ld.param.u64 %rd125, [%rd4+128]
  rd125 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (128))));
  // PTX:83 cvta.to.global.u64 %rd33, %rd125
  rd33 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd125));
  // PTX:84 ld.param.u64 %rd126, [%rd4+48]
  rd126 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (48))));
  // PTX:85 cvta.to.global.u64 %rd34, %rd126
  rd34 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd126));
  // PTX:86 ld.param.u64 %rd127, [%rd4+240]
  rd127 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (240))));
  // PTX:87 cvta.to.global.u64 %rd35, %rd127
  rd35 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd127));
  // PTX:88 ld.param.u64 %rd36, [%rd4+104]
  rd36 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (104))));
  // PTX:89 cvt.u32.u64 %r1, %rd36
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd36));
  // PTX:90 ld.param.u64 %rd128, [%rd4+248]
  rd128 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (248))));
  // PTX:91 cvta.to.global.u64 %rd37, %rd128
  rd37 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd128));
  // PTX:92 ld.param.u64 %rd129, [%rd4+136]
  rd129 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (136))));
  // PTX:93 cvta.to.global.u64 %rd38, %rd129
  rd38 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd129));
  // PTX:94 ld.param.u64 %rd130, [%rd4+40]
  rd130 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (40))));
  // PTX:95 cvta.to.global.u64 %rd39, %rd130
  rd39 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd130));
  // PTX:96 ld.param.u64 %rd131, [%rd4+144]
  rd131 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (144))));
  // PTX:97 cvta.to.global.u64 %rd40, %rd131
  rd40 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd131));
  // PTX:98 ld.param.u64 %rd132, [%rd4+152]
  rd132 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (152))));
  // PTX:99 cvta.to.global.u64 %rd41, %rd132
  rd41 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd132));
  // PTX:100 ld.param.v2.f32 {%f401, %f402}, [%rd4+216]
  f401 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd4) + (216)))); f402 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd4) + (220))));
  // PTX:101 ld.param.u64 %rd133, [%rd4+160]
  rd133 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (160))));
  // PTX:102 cvta.to.global.u64 %rd42, %rd133
  rd42 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd133));
  // PTX:103 ld.param.u64 %rd134, [%rd4+168]
  rd134 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (168))));
  // PTX:104 cvta.to.global.u64 %rd43, %rd134
  rd43 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd134));
  // PTX:105 ld.param.v2.f32 {%f403, %f404}, [%rd4+224]
  f403 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd4) + (224)))); f404 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd4) + (228))));
  // PTX:106 ld.param.u64 %rd135, [%rd4+184]
  rd135 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (184))));
  // PTX:107 cvta.to.global.u64 %rd44, %rd135
  rd44 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd135));
  // PTX:108 ld.param.u64 %rd136, [%rd4+176]
  rd136 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (176))));
  // PTX:109 cvta.to.global.u64 %rd45, %rd136
  rd45 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd136));
  // PTX:110 bra.uni $L__BB7_2
  goto L_BB7_2;
  // PTX:112 $L__BB7_23:
L_BB7_23:;
  // PTX:113 abs.f32 %f420, %f21
  asm("abs.f32 %0, %1;" : "=f"(f420) : "f"(f21));
  // PTX:114 setp.geu.f32 %p21, %f420, 0f7F800000
  p21 = ((isnan(((float)(f420))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f420)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:115 setp.lt.f32 %p22, %f21, 0f00000000
  p22 = (!(isnan(((float)(f21))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f21)) < ((float)(as_f32(0x00000000u)))));
  // PTX:116 mov.u32 %r1835, 0
  asm("mov.u32 %0, 0;" : "=r"(r1835) : );
  // PTX:117 or.pred %p23, %p21, %p22
  p23 = ((p21) || (p22));
  // PTX:118 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:119 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:120 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:121 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:122 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:123 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:124 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:125 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:126 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:127 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:128 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:129 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:130 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:131 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:132 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:133 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:134 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:135 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:136 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:137 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:138 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:139 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:140 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:141 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:142 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:143 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:144 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:145 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:146 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:147 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:148 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:149 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:150 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:151 @%p23 bra $L__BB7_164
  if (p23) { goto L_BB7_164; }
  // PTX:153 setp.ne.s64 %p24, %rd353, %rd56
  p24 = (((long long)(rd353)) != ((long long)(rd56)));
  // PTX:154 @%p24 bra $L__BB7_164
  if (p24) { goto L_BB7_164; }
  // PTX:156 @%p11 bra $L__BB7_27
  if (p11) { goto L_BB7_27; }
  // PTX:158 rem.u64 %rd357, %rd52, %rd36
  asm("rem.u64 %0, %1, %2;" : "=l"(rd357) : "l"(rd52), "l"(rd36));
  // PTX:159 bra.uni $L__BB7_28
  goto L_BB7_28;
  // PTX:161 $L__BB7_27:
L_BB7_27:;
  // PTX:162 cvt.u32.u64 %r550, %rd52
  asm("cvt.u32.u64 %0, %1;" : "=r"(r550) : "l"(rd52));
  // PTX:163 rem.u32 %r551, %r550, %r1
  asm("rem.u32 %0, %1, %2;" : "=r"(r551) : "r"(r550), "r"(r1));
  // PTX:164 cvt.u64.u32 %rd357, %r551
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd357) : "r"(r551));
  // PTX:166 $L__BB7_28:
L_BB7_28:;
  // PTX:167 setp.eq.s64 %p26, %rd21, 0
  p26 = (((long long)(rd21)) == ((long long)(0)));
  // PTX:168 @%p26 bra $L__BB7_30
  if (p26) { goto L_BB7_30; }
  // PTX:170 shl.b64 %rd151, %rd357, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd151) : "l"(rd357));
  // PTX:171 add.s64 %rd152, %rd22, %rd151
  asm("add.s64 %0, %1, %2;" : "=l"(rd152) : "l"(rd22), "l"(rd151));
  // PTX:172 ld.global.u32 %r592, [%rd152]
  r592 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd152) + (0)))));
  // PTX:173 setp.ne.s32 %p27, %r592, 0
  p27 = (((int)(r592)) != ((int)(0)));
  // PTX:174 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:175 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:176 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:177 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:178 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:179 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:180 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:181 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:182 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:183 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:184 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:185 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:186 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:187 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:188 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:189 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:190 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:191 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:192 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:193 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:194 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:195 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:196 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:197 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:198 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:199 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:200 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:201 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:202 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:203 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:204 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:205 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:206 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:207 @%p27 bra $L__BB7_164
  if (p27) { goto L_BB7_164; }
  // PTX:209 $L__BB7_30:
L_BB7_30:;
  // PTX:210 shl.b64 %rd154, %rd357, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd154) : "l"(rd357));
  // PTX:211 add.s64 %rd155, %rd20, %rd154
  asm("add.s64 %0, %1, %2;" : "=l"(rd155) : "l"(rd20), "l"(rd154));
  // PTX:212 ld.global.f32 %f459, [%rd155]
  f459 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd155) + (0)))));
  // PTX:213 mov.u64 %rd358, 0
  asm("mov.u64 %0, 0;" : "=l"(rd358) : );
  // PTX:214 mov.f32 %f1503, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1503) : );
  // PTX:215 max.f32 %f1502, %f1503, %f459
  asm("max.f32 %0, %1, %2;" : "=f"(f1502) : "f"(f1503), "f"(f459));
  // PTX:216 setp.eq.f32 %p28, %f21, 0f00000000
  p28 = (!(isnan(((float)(f21))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f21)) == ((float)(as_f32(0x00000000u)))));
  // PTX:217 mov.f32 %f1496, %f1503
  asm("mov.f32 %0, %1;" : "=f"(f1496) : "f"(f1503));
  // PTX:218 mov.f32 %f1497, %f1503
  asm("mov.f32 %0, %1;" : "=f"(f1497) : "f"(f1503));
  // PTX:219 mov.f32 %f1498, %f1503
  asm("mov.f32 %0, %1;" : "=f"(f1498) : "f"(f1503));
  // PTX:220 mov.f32 %f1499, %f1503
  asm("mov.f32 %0, %1;" : "=f"(f1499) : "f"(f1503));
  // PTX:221 mov.f32 %f1500, %f1503
  asm("mov.f32 %0, %1;" : "=f"(f1500) : "f"(f1503));
  // PTX:222 mov.f32 %f1501, %f1503
  asm("mov.f32 %0, %1;" : "=f"(f1501) : "f"(f1503));
  // PTX:223 mov.f32 %f1504, %f1503
  asm("mov.f32 %0, %1;" : "=f"(f1504) : "f"(f1503));
  // PTX:224 @%p28 bra $L__BB7_35
  if (p28) { goto L_BB7_35; }
  // PTX:226 st.local.u32 [%rd2], %r44
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (0))))) = (unsigned)(r44);
  // PTX:227 mov.u32 %r593, 1
  asm("mov.u32 %0, 1;" : "=r"(r593) : );
  // PTX:228 st.local.u32 [%rd2+56], %r593
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56))))) = (unsigned)(r593);
  // PTX:229 st.local.f32 [%rd2+28], %f21
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (28))))) = (float)(f21);
  // PTX:230 st.local.u32 [%rd2+60], %r44
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (60))))) = (unsigned)(r44);
  // PTX:231 st.local.u32 [%rd2+116], %r593
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116))))) = (unsigned)(r593);
  // PTX:232 st.local.f32 [%rd2+88], %f21
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (88))))) = (float)(f21);
  // PTX:233 add.f32 %f1504, %f21, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1504) : "f"(f21));
  // PTX:234 mul.lo.s64 %rd157, %rd52, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd157) : "l"(rd52));
  // PTX:235 add.s64 %rd158, %rd23, %rd157
  asm("add.s64 %0, %1, %2;" : "=l"(rd158) : "l"(rd23), "l"(rd157));
  // PTX:236 ld.global.f32 %f461, [%rd158]
  f461 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd158) + (0)))));
  // PTX:237 ld.global.f32 %f462, [%rd158+4]
  f462 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd158) + (4)))));
  // PTX:238 ld.global.f32 %f463, [%rd158+8]
  f463 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd158) + (8)))));
  // PTX:239 fma.rn.f32 %f1499, %f21, %f461, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f1499) : "f"(f21), "f"(f461));
  // PTX:240 fma.rn.f32 %f1500, %f21, %f462, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f1500) : "f"(f21), "f"(f462));
  // PTX:241 fma.rn.f32 %f1501, %f21, %f463, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f1501) : "f"(f21), "f"(f463));
  // PTX:242 add.s64 %rd159, %rd25, %rd157
  asm("add.s64 %0, %1, %2;" : "=l"(rd159) : "l"(rd25), "l"(rd157));
  // PTX:243 ld.global.f32 %f464, [%rd159]
  f464 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd159) + (0)))));
  // PTX:244 sub.f32 %f465, %f461, %f464
  asm("sub.f32 %0, %1, %2;" : "=f"(f465) : "f"(f461), "f"(f464));
  // PTX:245 ld.global.f32 %f466, [%rd159+4]
  f466 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd159) + (4)))));
  // PTX:246 sub.f32 %f467, %f462, %f466
  asm("sub.f32 %0, %1, %2;" : "=f"(f467) : "f"(f462), "f"(f466));
  // PTX:247 ld.global.f32 %f468, [%rd159+8]
  f468 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd159) + (8)))));
  // PTX:248 sub.f32 %f469, %f463, %f468
  asm("sub.f32 %0, %1, %2;" : "=f"(f469) : "f"(f463), "f"(f468));
  // PTX:249 mul.f32 %f470, %f21, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f470) : "f"(f21), "f"(f1));
  // PTX:250 fma.rn.f32 %f1496, %f470, %f465, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f1496) : "f"(f470), "f"(f465));
  // PTX:251 fma.rn.f32 %f1497, %f470, %f467, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f1497) : "f"(f470), "f"(f467));
  // PTX:252 fma.rn.f32 %f1498, %f470, %f469, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f1498) : "f"(f470), "f"(f469));
  // PTX:253 add.s64 %rd161, %rd26, %rd154
  asm("add.s64 %0, %1, %2;" : "=l"(rd161) : "l"(rd26), "l"(rd154));
  // PTX:254 ld.global.f32 %f47, [%rd161]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd161) + (0)))));
  // PTX:255 setp.leu.f32 %p29, %f47, 0f00000000
  p29 = ((isnan(((float)(f47))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f47)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:256 mov.u64 %rd358, 1
  asm("mov.u64 %0, 1;" : "=l"(rd358) : );
  // PTX:257 @%p29 bra $L__BB7_35
  if (p29) { goto L_BB7_35; }
  // PTX:259 setp.eq.s64 %p30, %rd27, 0
  p30 = (((long long)(rd27)) == ((long long)(0)));
  // PTX:260 @%p30 bra $L__BB7_34
  if (p30) { goto L_BB7_34; }
  // PTX:262 add.s64 %rd164, %rd28, %rd154
  asm("add.s64 %0, %1, %2;" : "=l"(rd164) : "l"(rd28), "l"(rd154));
  // PTX:263 ld.global.u32 %r594, [%rd164]
  r594 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd164) + (0)))));
  // PTX:264 and.b32 %r595, %r594, 1
  asm("and.b32 %0, %1, 1;" : "=r"(r595) : "r"(r594));
  // PTX:265 setp.eq.b32 %p31, %r595, 1
  p31 = (((unsigned)(r595)) == ((unsigned)(1)));
  // PTX:266 mov.pred %p32, 0
  p32 = ((0) != 0);
  // PTX:267 xor.pred %p33, %p31, %p32
  p33 = ((p31) != (p32));
  // PTX:268 not.pred %p34, %p33
  p34 = !(p33);
  // PTX:269 @%p34 bra $L__BB7_35
  if (p34) { goto L_BB7_35; }
  // PTX:271 $L__BB7_34:
L_BB7_34:;
  // PTX:272 mul.f32 %f472, %f21, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f472) : "f"(f21), "f"(f21));
  // PTX:273 div.rn.f32 %f473, %f472, %f47
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f473) : "f"(f472), "f"(f47));
  // PTX:274 add.f32 %f1503, %f473, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1503) : "f"(f473));
  // PTX:276 $L__BB7_35:
L_BB7_35:;
  // PTX:277 setp.lt.s32 %p35, %r42, 0
  p35 = (((int)(r42)) < ((int)(0)));
  // PTX:278 @%p35 bra $L__BB7_52
  if (p35) { goto L_BB7_52; }
  // PTX:280 abs.f32 %f489, %f22
  asm("abs.f32 %0, %1;" : "=f"(f489) : "f"(f22));
  // PTX:281 setp.geu.f32 %p36, %f489, 0f7F800000
  p36 = ((isnan(((float)(f489))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f489)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:282 setp.lt.f32 %p37, %f22, 0f00000000
  p37 = (!(isnan(((float)(f22))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f22)) < ((float)(as_f32(0x00000000u)))));
  // PTX:283 or.pred %p38, %p37, %p36
  p38 = ((p37) || (p36));
  // PTX:284 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:285 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:286 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:287 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:288 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:289 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:290 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:291 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:292 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:293 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:294 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:295 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:296 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:297 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:298 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:299 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:300 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:301 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:302 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:303 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:304 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:305 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:306 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:307 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:308 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:309 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:310 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:311 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:312 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:313 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:314 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:315 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:316 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:317 @%p38 bra $L__BB7_164
  if (p38) { goto L_BB7_164; }
  // PTX:319 setp.le.u64 %p39, %rd15, %rd50
  p39 = (((unsigned long long)(rd15)) <= ((unsigned long long)(rd50)));
  // PTX:320 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:321 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:322 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:323 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:324 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:325 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:326 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:327 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:328 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:329 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:330 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:331 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:332 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:333 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:334 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:335 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:336 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:337 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:338 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:339 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:340 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:341 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:342 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:343 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:344 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:345 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:346 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:347 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:348 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:349 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:350 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:351 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:352 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:353 @%p39 bra $L__BB7_164
  if (p39) { goto L_BB7_164; }
  // PTX:355 or.b64 %rd166, %rd50, %rd36
  asm("or.b64 %0, %1, %2;" : "=l"(rd166) : "l"(rd50), "l"(rd36));
  // PTX:356 and.b64 %rd167, %rd166, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd167) : "l"(rd166));
  // PTX:357 setp.eq.s64 %p40, %rd167, 0
  p40 = (((long long)(rd167)) == ((long long)(0)));
  // PTX:358 @%p40 bra $L__BB7_40
  if (p40) { goto L_BB7_40; }
  // PTX:360 div.u64 %rd359, %rd50, %rd36
  asm("div.u64 %0, %1, %2;" : "=l"(rd359) : "l"(rd50), "l"(rd36));
  // PTX:361 bra.uni $L__BB7_41
  goto L_BB7_41;
  // PTX:363 $L__BB7_40:
L_BB7_40:;
  // PTX:364 cvt.u32.u64 %r677, %rd50
  asm("cvt.u32.u64 %0, %1;" : "=r"(r677) : "l"(rd50));
  // PTX:365 div.u32 %r678, %r677, %r1
  asm("div.u32 %0, %1, %2;" : "=r"(r678) : "r"(r677), "r"(r1));
  // PTX:366 cvt.u64.u32 %rd359, %r678
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd359) : "r"(r678));
  // PTX:368 $L__BB7_41:
L_BB7_41:;
  // PTX:369 setp.ne.s64 %p41, %rd359, %rd353
  p41 = (((long long)(rd359)) != ((long long)(rd353)));
  // PTX:370 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:371 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:372 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:373 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:374 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:375 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:376 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:377 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:378 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:379 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:380 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:381 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:382 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:383 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:384 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:385 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:386 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:387 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:388 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:389 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:390 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:391 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:392 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:393 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:394 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:395 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:396 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:397 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:398 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:399 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:400 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:401 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:402 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:403 @%p41 bra $L__BB7_164
  if (p41) { goto L_BB7_164; }
  // PTX:405 @%p40 bra $L__BB7_44
  if (p40) { goto L_BB7_44; }
  // PTX:407 rem.u64 %rd360, %rd50, %rd36
  asm("rem.u64 %0, %1, %2;" : "=l"(rd360) : "l"(rd50), "l"(rd36));
  // PTX:408 bra.uni $L__BB7_45
  goto L_BB7_45;
  // PTX:410 $L__BB7_44:
L_BB7_44:;
  // PTX:411 cvt.u32.u64 %r720, %rd50
  asm("cvt.u32.u64 %0, %1;" : "=r"(r720) : "l"(rd50));
  // PTX:412 rem.u32 %r721, %r720, %r1
  asm("rem.u32 %0, %1, %2;" : "=r"(r721) : "r"(r720), "r"(r1));
  // PTX:413 cvt.u64.u32 %rd360, %r721
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd360) : "r"(r721));
  // PTX:415 $L__BB7_45:
L_BB7_45:;
  // PTX:416 @%p26 bra $L__BB7_47
  if (p26) { goto L_BB7_47; }
  // PTX:418 shl.b64 %rd170, %rd360, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd170) : "l"(rd360));
  // PTX:419 add.s64 %rd171, %rd22, %rd170
  asm("add.s64 %0, %1, %2;" : "=l"(rd171) : "l"(rd22), "l"(rd170));
  // PTX:420 ld.global.u32 %r762, [%rd171]
  r762 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd171) + (0)))));
  // PTX:421 setp.ne.s32 %p44, %r762, 0
  p44 = (((int)(r762)) != ((int)(0)));
  // PTX:422 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:423 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:424 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:425 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:426 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:427 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:428 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:429 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:430 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:431 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:432 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:433 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:434 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:435 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:436 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:437 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:438 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:439 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:440 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:441 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:442 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:443 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:444 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:445 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:446 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:447 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:448 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:449 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:450 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:451 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:452 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:453 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:454 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:455 @%p44 bra $L__BB7_164
  if (p44) { goto L_BB7_164; }
  // PTX:457 $L__BB7_47:
L_BB7_47:;
  // PTX:458 shl.b64 %rd172, %rd360, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd172) : "l"(rd360));
  // PTX:459 add.s64 %rd173, %rd20, %rd172
  asm("add.s64 %0, %1, %2;" : "=l"(rd173) : "l"(rd20), "l"(rd172));
  // PTX:460 ld.global.f32 %f535, [%rd173]
  f535 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd173) + (0)))));
  // PTX:461 max.f32 %f1502, %f1502, %f535
  asm("max.f32 %0, %1, %2;" : "=f"(f1502) : "f"(f1502), "f"(f535));
  // PTX:462 setp.eq.f32 %p45, %f22, 0f00000000
  p45 = (!(isnan(((float)(f22))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f22)) == ((float)(as_f32(0x00000000u)))));
  // PTX:463 @%p45 bra $L__BB7_52
  if (p45) { goto L_BB7_52; }
  // PTX:465 shl.b64 %rd174, %rd358, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd174) : "l"(rd358));
  // PTX:466 add.s64 %rd175, %rd2, %rd174
  asm("add.s64 %0, %1, %2;" : "=l"(rd175) : "l"(rd2), "l"(rd174));
  // PTX:467 st.local.u32 [%rd175], %r42
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd175) + (0))))) = (unsigned)(r42);
  // PTX:468 ld.local.u32 %r763, [%rd2+56]
  r763 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:469 add.s32 %r764, %r763, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r764) : "r"(r763));
  // PTX:470 st.local.u32 [%rd2+56], %r764
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56))))) = (unsigned)(r764);
  // PTX:471 mul.wide.s32 %rd176, %r763, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd176) : "r"(r763));
  // PTX:472 add.s64 %rd177, %rd2, %rd176
  asm("add.s64 %0, %1, %2;" : "=l"(rd177) : "l"(rd2), "l"(rd176));
  // PTX:473 st.local.f32 [%rd177+28], %f22
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd177) + (28))))) = (float)(f22);
  // PTX:474 ld.local.u32 %r765, [%rd2+116]
  r765 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:475 mul.wide.s32 %rd178, %r765, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd178) : "r"(r765));
  // PTX:476 add.s64 %rd179, %rd2, %rd178
  asm("add.s64 %0, %1, %2;" : "=l"(rd179) : "l"(rd2), "l"(rd178));
  // PTX:477 st.local.u32 [%rd179+60], %r42
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd179) + (60))))) = (unsigned)(r42);
  // PTX:478 ld.local.u32 %r766, [%rd2+116]
  r766 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:479 add.s32 %r767, %r766, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r767) : "r"(r766));
  // PTX:480 st.local.u32 [%rd2+116], %r767
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116))))) = (unsigned)(r767);
  // PTX:481 mul.wide.s32 %rd180, %r766, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd180) : "r"(r766));
  // PTX:482 add.s64 %rd181, %rd2, %rd180
  asm("add.s64 %0, %1, %2;" : "=l"(rd181) : "l"(rd2), "l"(rd180));
  // PTX:483 st.local.f32 [%rd181+88], %f22
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd181) + (88))))) = (float)(f22);
  // PTX:484 add.f32 %f1504, %f1504, %f22
  asm("add.f32 %0, %1, %2;" : "=f"(f1504) : "f"(f1504), "f"(f22));
  // PTX:485 mul.lo.s64 %rd182, %rd50, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd182) : "l"(rd50));
  // PTX:486 add.s64 %rd183, %rd23, %rd182
  asm("add.s64 %0, %1, %2;" : "=l"(rd183) : "l"(rd23), "l"(rd182));
  // PTX:487 ld.global.f32 %f536, [%rd183]
  f536 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (0)))));
  // PTX:488 ld.global.f32 %f537, [%rd183+4]
  f537 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (4)))));
  // PTX:489 ld.global.f32 %f538, [%rd183+8]
  f538 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (8)))));
  // PTX:490 fma.rn.f32 %f1499, %f22, %f536, %f1499
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1499) : "f"(f22), "f"(f536), "f"(f1499));
  // PTX:491 fma.rn.f32 %f1500, %f22, %f537, %f1500
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1500) : "f"(f22), "f"(f537), "f"(f1500));
  // PTX:492 fma.rn.f32 %f1501, %f22, %f538, %f1501
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1501) : "f"(f22), "f"(f538), "f"(f1501));
  // PTX:493 add.s64 %rd184, %rd25, %rd182
  asm("add.s64 %0, %1, %2;" : "=l"(rd184) : "l"(rd25), "l"(rd182));
  // PTX:494 ld.global.f32 %f539, [%rd184]
  f539 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (0)))));
  // PTX:495 sub.f32 %f540, %f536, %f539
  asm("sub.f32 %0, %1, %2;" : "=f"(f540) : "f"(f536), "f"(f539));
  // PTX:496 ld.global.f32 %f541, [%rd184+4]
  f541 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (4)))));
  // PTX:497 sub.f32 %f542, %f537, %f541
  asm("sub.f32 %0, %1, %2;" : "=f"(f542) : "f"(f537), "f"(f541));
  // PTX:498 ld.global.f32 %f543, [%rd184+8]
  f543 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (8)))));
  // PTX:499 sub.f32 %f544, %f538, %f543
  asm("sub.f32 %0, %1, %2;" : "=f"(f544) : "f"(f538), "f"(f543));
  // PTX:500 mul.f32 %f545, %f22, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f545) : "f"(f22), "f"(f1));
  // PTX:501 fma.rn.f32 %f1496, %f545, %f540, %f1496
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1496) : "f"(f545), "f"(f540), "f"(f1496));
  // PTX:502 fma.rn.f32 %f1497, %f545, %f542, %f1497
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1497) : "f"(f545), "f"(f542), "f"(f1497));
  // PTX:503 fma.rn.f32 %f1498, %f545, %f544, %f1498
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1498) : "f"(f545), "f"(f544), "f"(f1498));
  // PTX:504 add.s64 %rd186, %rd26, %rd172
  asm("add.s64 %0, %1, %2;" : "=l"(rd186) : "l"(rd26), "l"(rd172));
  // PTX:505 ld.global.f32 %f65, [%rd186]
  f65 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd186) + (0)))));
  // PTX:506 setp.leu.f32 %p46, %f65, 0f00000000
  p46 = ((isnan(((float)(f65))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f65)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:507 @%p46 bra $L__BB7_52
  if (p46) { goto L_BB7_52; }
  // PTX:509 setp.eq.s64 %p47, %rd27, 0
  p47 = (((long long)(rd27)) == ((long long)(0)));
  // PTX:510 @%p47 bra $L__BB7_51
  if (p47) { goto L_BB7_51; }
  // PTX:512 add.s64 %rd188, %rd28, %rd172
  asm("add.s64 %0, %1, %2;" : "=l"(rd188) : "l"(rd28), "l"(rd172));
  // PTX:513 ld.global.u32 %r768, [%rd188]
  r768 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd188) + (0)))));
  // PTX:514 and.b32 %r769, %r768, 1
  asm("and.b32 %0, %1, 1;" : "=r"(r769) : "r"(r768));
  // PTX:515 setp.eq.b32 %p48, %r769, 1
  p48 = (((unsigned)(r769)) == ((unsigned)(1)));
  // PTX:516 mov.pred %p49, 0
  p49 = ((0) != 0);
  // PTX:517 xor.pred %p50, %p48, %p49
  p50 = ((p48) != (p49));
  // PTX:518 not.pred %p51, %p50
  p51 = !(p50);
  // PTX:519 @%p51 bra $L__BB7_52
  if (p51) { goto L_BB7_52; }
  // PTX:521 $L__BB7_51:
L_BB7_51:;
  // PTX:522 mul.f32 %f546, %f22, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f546) : "f"(f22), "f"(f22));
  // PTX:523 div.rn.f32 %f547, %f546, %f65
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f547) : "f"(f546), "f"(f65));
  // PTX:524 add.f32 %f1503, %f1503, %f547
  asm("add.f32 %0, %1, %2;" : "=f"(f1503) : "f"(f1503), "f"(f547));
  // PTX:526 $L__BB7_52:
L_BB7_52:;
  // PTX:527 setp.lt.s32 %p52, %r43, 0
  p52 = (((int)(r43)) < ((int)(0)));
  // PTX:528 @%p52 bra $L__BB7_69
  if (p52) { goto L_BB7_69; }
  // PTX:530 abs.f32 %f563, %f23
  asm("abs.f32 %0, %1;" : "=f"(f563) : "f"(f23));
  // PTX:531 setp.geu.f32 %p53, %f563, 0f7F800000
  p53 = ((isnan(((float)(f563))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f563)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:532 setp.lt.f32 %p54, %f23, 0f00000000
  p54 = (!(isnan(((float)(f23))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f23)) < ((float)(as_f32(0x00000000u)))));
  // PTX:533 or.pred %p55, %p54, %p53
  p55 = ((p54) || (p53));
  // PTX:534 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:535 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:536 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:537 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:538 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:539 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:540 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:541 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:542 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:543 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:544 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:545 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:546 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:547 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:548 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:549 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:550 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:551 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:552 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:553 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:554 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:555 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:556 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:557 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:558 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:559 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:560 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:561 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:562 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:563 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:564 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:565 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:566 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:567 @%p55 bra $L__BB7_164
  if (p55) { goto L_BB7_164; }
  // PTX:569 setp.le.u64 %p56, %rd15, %rd51
  p56 = (((unsigned long long)(rd15)) <= ((unsigned long long)(rd51)));
  // PTX:570 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:571 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:572 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:573 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:574 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:575 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:576 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:577 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:578 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:579 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:580 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:581 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:582 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:583 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:584 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:585 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:586 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:587 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:588 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:589 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:590 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:591 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:592 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:593 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:594 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:595 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:596 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:597 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:598 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:599 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:600 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:601 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:602 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:603 @%p56 bra $L__BB7_164
  if (p56) { goto L_BB7_164; }
  // PTX:605 or.b64 %rd189, %rd51, %rd36
  asm("or.b64 %0, %1, %2;" : "=l"(rd189) : "l"(rd51), "l"(rd36));
  // PTX:606 and.b64 %rd190, %rd189, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd190) : "l"(rd189));
  // PTX:607 setp.eq.s64 %p57, %rd190, 0
  p57 = (((long long)(rd190)) == ((long long)(0)));
  // PTX:608 @%p57 bra $L__BB7_57
  if (p57) { goto L_BB7_57; }
  // PTX:610 div.u64 %rd361, %rd51, %rd36
  asm("div.u64 %0, %1, %2;" : "=l"(rd361) : "l"(rd51), "l"(rd36));
  // PTX:611 bra.uni $L__BB7_58
  goto L_BB7_58;
  // PTX:613 $L__BB7_57:
L_BB7_57:;
  // PTX:614 cvt.u32.u64 %r851, %rd51
  asm("cvt.u32.u64 %0, %1;" : "=r"(r851) : "l"(rd51));
  // PTX:615 div.u32 %r852, %r851, %r1
  asm("div.u32 %0, %1, %2;" : "=r"(r852) : "r"(r851), "r"(r1));
  // PTX:616 cvt.u64.u32 %rd361, %r852
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd361) : "r"(r852));
  // PTX:618 $L__BB7_58:
L_BB7_58:;
  // PTX:619 setp.ne.s64 %p58, %rd361, %rd353
  p58 = (((long long)(rd361)) != ((long long)(rd353)));
  // PTX:620 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:621 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:622 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:623 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:624 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:625 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:626 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:627 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:628 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:629 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:630 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:631 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:632 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:633 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:634 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:635 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:636 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:637 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:638 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:639 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:640 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:641 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:642 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:643 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:644 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:645 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:646 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:647 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:648 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:649 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:650 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:651 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:652 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:653 @%p58 bra $L__BB7_164
  if (p58) { goto L_BB7_164; }
  // PTX:655 @%p57 bra $L__BB7_61
  if (p57) { goto L_BB7_61; }
  // PTX:657 rem.u64 %rd362, %rd51, %rd36
  asm("rem.u64 %0, %1, %2;" : "=l"(rd362) : "l"(rd51), "l"(rd36));
  // PTX:658 bra.uni $L__BB7_62
  goto L_BB7_62;
  // PTX:660 $L__BB7_61:
L_BB7_61:;
  // PTX:661 cvt.u32.u64 %r894, %rd51
  asm("cvt.u32.u64 %0, %1;" : "=r"(r894) : "l"(rd51));
  // PTX:662 rem.u32 %r895, %r894, %r1
  asm("rem.u32 %0, %1, %2;" : "=r"(r895) : "r"(r894), "r"(r1));
  // PTX:663 cvt.u64.u32 %rd362, %r895
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd362) : "r"(r895));
  // PTX:665 $L__BB7_62:
L_BB7_62:;
  // PTX:666 @%p26 bra $L__BB7_64
  if (p26) { goto L_BB7_64; }
  // PTX:668 shl.b64 %rd193, %rd362, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd193) : "l"(rd362));
  // PTX:669 add.s64 %rd194, %rd22, %rd193
  asm("add.s64 %0, %1, %2;" : "=l"(rd194) : "l"(rd22), "l"(rd193));
  // PTX:670 ld.global.u32 %r936, [%rd194]
  r936 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd194) + (0)))));
  // PTX:671 setp.ne.s32 %p61, %r936, 0
  p61 = (((int)(r936)) != ((int)(0)));
  // PTX:672 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:673 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:674 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:675 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:676 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:677 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:678 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:679 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:680 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:681 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:682 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:683 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:684 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:685 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:686 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:687 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:688 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:689 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:690 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:691 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:692 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:693 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:694 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:695 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:696 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:697 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:698 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:699 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:700 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:701 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:702 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:703 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:704 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:705 @%p61 bra $L__BB7_164
  if (p61) { goto L_BB7_164; }
  // PTX:707 $L__BB7_64:
L_BB7_64:;
  // PTX:708 shl.b64 %rd195, %rd362, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd195) : "l"(rd362));
  // PTX:709 add.s64 %rd196, %rd20, %rd195
  asm("add.s64 %0, %1, %2;" : "=l"(rd196) : "l"(rd20), "l"(rd195));
  // PTX:710 ld.global.f32 %f609, [%rd196]
  f609 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd196) + (0)))));
  // PTX:711 max.f32 %f1502, %f1502, %f609
  asm("max.f32 %0, %1, %2;" : "=f"(f1502) : "f"(f1502), "f"(f609));
  // PTX:712 setp.eq.f32 %p62, %f23, 0f00000000
  p62 = (!(isnan(((float)(f23))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f23)) == ((float)(as_f32(0x00000000u)))));
  // PTX:713 @%p62 bra $L__BB7_69
  if (p62) { goto L_BB7_69; }
  // PTX:715 ld.local.u32 %r937, [%rd2+56]
  r937 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:716 mul.wide.s32 %rd197, %r937, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd197) : "r"(r937));
  // PTX:717 add.s64 %rd198, %rd2, %rd197
  asm("add.s64 %0, %1, %2;" : "=l"(rd198) : "l"(rd2), "l"(rd197));
  // PTX:718 st.local.u32 [%rd198], %r43
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd198) + (0))))) = (unsigned)(r43);
  // PTX:719 ld.local.u32 %r938, [%rd2+56]
  r938 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:720 add.s32 %r939, %r938, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r939) : "r"(r938));
  // PTX:721 st.local.u32 [%rd2+56], %r939
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56))))) = (unsigned)(r939);
  // PTX:722 mul.wide.s32 %rd199, %r938, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd199) : "r"(r938));
  // PTX:723 add.s64 %rd200, %rd2, %rd199
  asm("add.s64 %0, %1, %2;" : "=l"(rd200) : "l"(rd2), "l"(rd199));
  // PTX:724 st.local.f32 [%rd200+28], %f23
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd200) + (28))))) = (float)(f23);
  // PTX:725 ld.local.u32 %r940, [%rd2+116]
  r940 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:726 mul.wide.s32 %rd201, %r940, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd201) : "r"(r940));
  // PTX:727 add.s64 %rd202, %rd2, %rd201
  asm("add.s64 %0, %1, %2;" : "=l"(rd202) : "l"(rd2), "l"(rd201));
  // PTX:728 st.local.u32 [%rd202+60], %r43
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd202) + (60))))) = (unsigned)(r43);
  // PTX:729 ld.local.u32 %r941, [%rd2+116]
  r941 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:730 add.s32 %r942, %r941, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r942) : "r"(r941));
  // PTX:731 st.local.u32 [%rd2+116], %r942
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116))))) = (unsigned)(r942);
  // PTX:732 mul.wide.s32 %rd203, %r941, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd203) : "r"(r941));
  // PTX:733 add.s64 %rd204, %rd2, %rd203
  asm("add.s64 %0, %1, %2;" : "=l"(rd204) : "l"(rd2), "l"(rd203));
  // PTX:734 st.local.f32 [%rd204+88], %f23
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd204) + (88))))) = (float)(f23);
  // PTX:735 add.f32 %f1504, %f1504, %f23
  asm("add.f32 %0, %1, %2;" : "=f"(f1504) : "f"(f1504), "f"(f23));
  // PTX:736 mul.lo.s64 %rd205, %rd51, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd205) : "l"(rd51));
  // PTX:737 add.s64 %rd206, %rd23, %rd205
  asm("add.s64 %0, %1, %2;" : "=l"(rd206) : "l"(rd23), "l"(rd205));
  // PTX:738 ld.global.f32 %f610, [%rd206]
  f610 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd206) + (0)))));
  // PTX:739 ld.global.f32 %f611, [%rd206+4]
  f611 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd206) + (4)))));
  // PTX:740 ld.global.f32 %f612, [%rd206+8]
  f612 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd206) + (8)))));
  // PTX:741 fma.rn.f32 %f1499, %f23, %f610, %f1499
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1499) : "f"(f23), "f"(f610), "f"(f1499));
  // PTX:742 fma.rn.f32 %f1500, %f23, %f611, %f1500
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1500) : "f"(f23), "f"(f611), "f"(f1500));
  // PTX:743 fma.rn.f32 %f1501, %f23, %f612, %f1501
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1501) : "f"(f23), "f"(f612), "f"(f1501));
  // PTX:744 add.s64 %rd207, %rd25, %rd205
  asm("add.s64 %0, %1, %2;" : "=l"(rd207) : "l"(rd25), "l"(rd205));
  // PTX:745 ld.global.f32 %f613, [%rd207]
  f613 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd207) + (0)))));
  // PTX:746 sub.f32 %f614, %f610, %f613
  asm("sub.f32 %0, %1, %2;" : "=f"(f614) : "f"(f610), "f"(f613));
  // PTX:747 ld.global.f32 %f615, [%rd207+4]
  f615 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd207) + (4)))));
  // PTX:748 sub.f32 %f616, %f611, %f615
  asm("sub.f32 %0, %1, %2;" : "=f"(f616) : "f"(f611), "f"(f615));
  // PTX:749 ld.global.f32 %f617, [%rd207+8]
  f617 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd207) + (8)))));
  // PTX:750 sub.f32 %f618, %f612, %f617
  asm("sub.f32 %0, %1, %2;" : "=f"(f618) : "f"(f612), "f"(f617));
  // PTX:751 mul.f32 %f619, %f23, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f619) : "f"(f23), "f"(f1));
  // PTX:752 fma.rn.f32 %f1496, %f619, %f614, %f1496
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1496) : "f"(f619), "f"(f614), "f"(f1496));
  // PTX:753 fma.rn.f32 %f1497, %f619, %f616, %f1497
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1497) : "f"(f619), "f"(f616), "f"(f1497));
  // PTX:754 fma.rn.f32 %f1498, %f619, %f618, %f1498
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1498) : "f"(f619), "f"(f618), "f"(f1498));
  // PTX:755 add.s64 %rd209, %rd26, %rd195
  asm("add.s64 %0, %1, %2;" : "=l"(rd209) : "l"(rd26), "l"(rd195));
  // PTX:756 ld.global.f32 %f84, [%rd209]
  f84 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd209) + (0)))));
  // PTX:757 setp.leu.f32 %p63, %f84, 0f00000000
  p63 = ((isnan(((float)(f84))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f84)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:758 @%p63 bra $L__BB7_69
  if (p63) { goto L_BB7_69; }
  // PTX:760 setp.eq.s64 %p64, %rd27, 0
  p64 = (((long long)(rd27)) == ((long long)(0)));
  // PTX:761 @%p64 bra $L__BB7_68
  if (p64) { goto L_BB7_68; }
  // PTX:763 add.s64 %rd211, %rd28, %rd195
  asm("add.s64 %0, %1, %2;" : "=l"(rd211) : "l"(rd28), "l"(rd195));
  // PTX:764 ld.global.u32 %r943, [%rd211]
  r943 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd211) + (0)))));
  // PTX:765 and.b32 %r944, %r943, 1
  asm("and.b32 %0, %1, 1;" : "=r"(r944) : "r"(r943));
  // PTX:766 setp.eq.b32 %p65, %r944, 1
  p65 = (((unsigned)(r944)) == ((unsigned)(1)));
  // PTX:767 mov.pred %p66, 0
  p66 = ((0) != 0);
  // PTX:768 xor.pred %p67, %p65, %p66
  p67 = ((p65) != (p66));
  // PTX:769 not.pred %p68, %p67
  p68 = !(p67);
  // PTX:770 @%p68 bra $L__BB7_69
  if (p68) { goto L_BB7_69; }
  // PTX:772 $L__BB7_68:
L_BB7_68:;
  // PTX:773 mul.f32 %f620, %f23, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f620) : "f"(f23), "f"(f23));
  // PTX:774 div.rn.f32 %f621, %f620, %f84
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f621) : "f"(f620), "f"(f84));
  // PTX:775 add.f32 %f1503, %f1503, %f621
  asm("add.f32 %0, %1, %2;" : "=f"(f1503) : "f"(f1503), "f"(f621));
  // PTX:777 $L__BB7_69:
L_BB7_69:;
  // PTX:778 abs.f32 %f637, %f1502
  asm("abs.f32 %0, %1;" : "=f"(f637) : "f"(f1502));
  // PTX:779 setp.geu.f32 %p69, %f637, 0f7F800000
  p69 = ((isnan(((float)(f637))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f637)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:780 ld.local.u32 %r88, [%rd2+56]
  r88 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:781 setp.eq.s32 %p70, %r88, 0
  p70 = (((int)(r88)) == ((int)(0)));
  // PTX:782 or.pred %p71, %p69, %p70
  p71 = ((p69) || (p70));
  // PTX:783 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:784 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:785 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:786 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:787 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:788 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:789 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:790 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:791 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:792 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:793 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:794 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:795 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:796 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:797 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:798 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:799 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:800 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:801 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:802 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:803 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:804 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:805 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:806 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:807 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:808 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:809 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:810 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:811 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:812 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:813 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:814 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:815 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:816 @%p71 bra $L__BB7_164
  if (p71) { goto L_BB7_164; }
  // PTX:818 add.f32 %f653, %f1504, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f653) : "f"(f1504));
  // PTX:819 abs.f32 %f654, %f653
  asm("abs.f32 %0, %1;" : "=f"(f654) : "f"(f653));
  // PTX:820 setp.gt.f32 %p72, %f654, 0f38D1B717
  p72 = (!(isnan(((float)(f654))) || isnan(((float)(as_f32(0x38D1B717u))))) && (((float)(f654)) > ((float)(as_f32(0x38D1B717u)))));
  // PTX:821 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:822 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:823 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:824 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:825 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:826 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:827 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:828 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:829 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:830 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:831 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:832 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:833 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:834 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:835 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:836 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:837 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:838 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:839 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:840 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:841 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:842 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:843 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:844 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:845 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:846 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:847 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:848 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:849 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:850 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:851 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:852 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:853 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:854 @%p72 bra $L__BB7_164
  if (p72) { goto L_BB7_164; }
  // PTX:856 shl.b64 %rd212, %rd356, 32
  asm("shl.b64 %0, %1, 32;" : "=l"(rd212) : "l"(rd356));
  // PTX:857 cvt.s64.s32 %rd82, %rd356
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd82) : "l"(rd356));
  // PTX:858 shr.s64 %rd213, %rd212, 30
  asm("shr.s64 %0, %1, 30;" : "=l"(rd213) : "l"(rd212));
  // PTX:859 add.s64 %rd214, %rd29, %rd213
  asm("add.s64 %0, %1, %2;" : "=l"(rd214) : "l"(rd29), "l"(rd213));
  // PTX:860 ld.global.s32 %rd83, [%rd214]
  rd83 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd214) + (0)))));
  // PTX:861 setp.lt.s64 %p73, %rd83, 0
  p73 = (((long long)(rd83)) < ((long long)(0)));
  // PTX:862 mov.u32 %r1025, -1
  asm("mov.u32 %0, -1;" : "=r"(r1025) : );
  // PTX:863 mov.u32 %r1772, %r1025
  asm("mov.u32 %0, %1;" : "=r"(r1772) : "r"(r1025));
  // PTX:864 @%p73 bra $L__BB7_79
  if (p73) { goto L_BB7_79; }
  // PTX:866 setp.gt.u64 %p74, %rd31, %rd83
  p74 = (((unsigned long long)(rd31)) > ((unsigned long long)(rd83)));
  // PTX:867 @%p74 bra $L__BB7_74
  if (p74) { goto L_BB7_74; }
  // PTX:868 bra.uni $L__BB7_73
  goto L_BB7_73;
  // PTX:870 $L__BB7_74:
L_BB7_74:;
  // PTX:871 cvt.u32.u64 %r1027, %rd83
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1027) : "l"(rd83));
  // PTX:872 shl.b64 %rd215, %rd83, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd215) : "l"(rd83));
  // PTX:873 add.s64 %rd216, %rd30, %rd215
  asm("add.s64 %0, %1, %2;" : "=l"(rd216) : "l"(rd30), "l"(rd215));
  // PTX:874 ld.global.u32 %r1028, [%rd216]
  r1028 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd216) + (0)))));
  // PTX:875 setp.eq.s32 %p76, %r1028, %r1027
  p76 = (((int)(r1028)) == ((int)(r1027)));
  // PTX:876 setp.eq.s64 %p77, %rd31, 0
  p77 = (((long long)(rd31)) == ((long long)(0)));
  // PTX:877 or.pred %p78, %p76, %p77
  p78 = ((p76) || (p77));
  // PTX:878 selp.b32 %r1772, %r1027, -1, %p76
  r1772 = p76 ? r1027 : -1;
  // PTX:879 @%p78 bra $L__BB7_79
  if (p78) { goto L_BB7_79; }
  // PTX:880 bra.uni $L__BB7_75
  goto L_BB7_75;
  // PTX:882 $L__BB7_73:
L_BB7_73:;
  // PTX:883 setp.eq.s64 %p75, %rd31, 0
  p75 = (((long long)(rd31)) == ((long long)(0)));
  // PTX:884 mov.u32 %r1772, %r1025
  asm("mov.u32 %0, %1;" : "=r"(r1772) : "r"(r1025));
  // PTX:885 @%p75 bra $L__BB7_79
  if (p75) { goto L_BB7_79; }
  // PTX:887 $L__BB7_75:
L_BB7_75:;
  // PTX:888 mov.u64 %rd363, 0
  asm("mov.u64 %0, 0;" : "=l"(rd363) : );
  // PTX:890 $L__BB7_76:
L_BB7_76:;
  // PTX:891 shl.b64 %rd218, %rd363, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd218) : "l"(rd363));
  // PTX:892 add.s64 %rd219, %rd30, %rd218
  asm("add.s64 %0, %1, %2;" : "=l"(rd219) : "l"(rd30), "l"(rd218));
  // PTX:893 ld.global.u32 %r1029, [%rd219]
  r1029 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd219) + (0)))));
  // PTX:894 cvt.u32.u64 %r1030, %rd83
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1030) : "l"(rd83));
  // PTX:895 setp.eq.s32 %p79, %r1029, %r1030
  p79 = (((int)(r1029)) == ((int)(r1030)));
  // PTX:896 @%p79 bra $L__BB7_78
  if (p79) { goto L_BB7_78; }
  // PTX:898 add.s64 %rd363, %rd363, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd363) : "l"(rd363));
  // PTX:899 setp.lt.u64 %p80, %rd363, %rd31
  p80 = (((unsigned long long)(rd363)) < ((unsigned long long)(rd31)));
  // PTX:900 mov.u32 %r1772, %r1025
  asm("mov.u32 %0, %1;" : "=r"(r1772) : "r"(r1025));
  // PTX:901 @%p80 bra $L__BB7_76
  if (p80) { goto L_BB7_76; }
  // PTX:902 bra.uni $L__BB7_79
  goto L_BB7_79;
  // PTX:904 $L__BB7_78:
L_BB7_78:;
  // PTX:905 cvt.u32.u64 %r1772, %rd363
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1772) : "l"(rd363));
  // PTX:907 $L__BB7_79:
L_BB7_79:;
  // PTX:908 cvt.u32.u64 %r1072, %rd83
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1072) : "l"(rd83));
  // PTX:909 setp.gt.s32 %p81, %r1072, -1
  p81 = (((int)(r1072)) > ((int)(-1)));
  // PTX:910 setp.lt.s32 %p82, %r1772, 0
  p82 = (((int)(r1772)) < ((int)(0)));
  // PTX:911 and.pred %p83, %p81, %p82
  p83 = ((p81) && (p82));
  // PTX:912 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:913 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:914 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:915 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:916 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:917 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:918 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:919 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:920 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:921 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:922 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:923 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:924 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:925 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:926 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:927 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:928 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:929 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:930 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:931 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:932 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:933 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:934 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:935 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:936 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:937 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:938 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:939 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:940 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:941 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:942 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:943 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:944 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:945 @%p83 bra $L__BB7_164
  if (p83) { goto L_BB7_164; }
  // PTX:947 setp.gt.s32 %p84, %r1772, -1
  p84 = (((int)(r1772)) > ((int)(-1)));
  // PTX:948 setp.lt.s32 %p85, %r1771, 0
  p85 = (((int)(r1771)) < ((int)(0)));
  // PTX:949 and.pred %p86, %p85, %p84
  p86 = ((p85) && (p84));
  // PTX:950 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:951 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:952 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:953 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:954 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:955 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:956 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:957 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:958 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:959 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:960 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:961 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:962 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:963 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:964 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:965 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:966 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:967 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:968 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:969 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:970 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:971 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:972 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:973 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:974 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:975 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:976 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:977 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:978 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:979 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:980 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:981 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:982 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:983 @%p86 bra $L__BB7_164
  if (p86) { goto L_BB7_164; }
  // PTX:985 mov.u32 %r1777, 0
  asm("mov.u32 %0, 0;" : "=r"(r1777) : );
  // PTX:986 add.s64 %rd221, %rd32, %rd140
  asm("add.s64 %0, %1, %2;" : "=l"(rd221) : "l"(rd32), "l"(rd140));
  // PTX:987 ld.global.u32 %r1823, [%rd221]
  r1823 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd221) + (0)))));
  // PTX:988 ld.global.u32 %r1824, [%rd221+4]
  r1824 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd221) + (4)))));
  // PTX:989 ld.global.u32 %r1825, [%rd221+8]
  r1825 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd221) + (8)))));
  // PTX:990 shl.b64 %rd222, %rd82, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd222) : "l"(rd82));
  // PTX:991 add.s64 %rd223, %rd33, %rd222
  asm("add.s64 %0, %1, %2;" : "=l"(rd223) : "l"(rd33), "l"(rd222));
  // PTX:992 ld.global.u32 %r95, [%rd223]
  r95 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd223) + (0)))));
  // PTX:993 mov.u32 %r1773, %r1777
  asm("mov.u32 %0, %1;" : "=r"(r1773) : "r"(r1777));
  // PTX:994 mov.u32 %r1774, %r1777
  asm("mov.u32 %0, %1;" : "=r"(r1774) : "r"(r1777));
  // PTX:995 mov.u32 %r1775, %r1777
  asm("mov.u32 %0, %1;" : "=r"(r1775) : "r"(r1777));
  // PTX:996 mov.u32 %r1776, %r1777
  asm("mov.u32 %0, %1;" : "=r"(r1776) : "r"(r1777));
  // PTX:997 @%p82 bra $L__BB7_83
  if (p82) { goto L_BB7_83; }
  // PTX:999 mul.wide.s32 %rd224, %r1772, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd224) : "r"(r1772));
  // PTX:1000 add.s64 %rd225, %rd35, %rd224
  asm("add.s64 %0, %1, %2;" : "=l"(rd225) : "l"(rd35), "l"(rd224));
  // PTX:1001 mul.lo.s32 %r1117, %r1, %r85
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r1117) : "r"(r1), "r"(r85));
  // PTX:1002 ld.global.u32 %r1118, [%rd225]
  r1118 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd225) + (0)))));
  // PTX:1003 add.s32 %r1776, %r1117, %r1118
  asm("add.s32 %0, %1, %2;" : "=r"(r1776) : "r"(r1117), "r"(r1118));
  // PTX:1004 ld.global.u32 %r1119, [%rd225+4]
  r1119 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd225) + (4)))));
  // PTX:1005 add.s32 %r1775, %r1117, %r1119
  asm("add.s32 %0, %1, %2;" : "=r"(r1775) : "r"(r1117), "r"(r1119));
  // PTX:1006 ld.global.u32 %r1120, [%rd225+8]
  r1120 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd225) + (8)))));
  // PTX:1007 add.s32 %r1774, %r1117, %r1120
  asm("add.s32 %0, %1, %2;" : "=r"(r1774) : "r"(r1117), "r"(r1120));
  // PTX:1008 ld.global.u32 %r1121, [%rd225+12]
  r1121 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd225) + (12)))));
  // PTX:1009 add.s32 %r1773, %r1117, %r1121
  asm("add.s32 %0, %1, %2;" : "=r"(r1773) : "r"(r1117), "r"(r1121));
  // PTX:1011 $L__BB7_83:
L_BB7_83:;
  // PTX:1012 add.s64 %rd227, %rd34, %rd140
  asm("add.s64 %0, %1, %2;" : "=l"(rd227) : "l"(rd34), "l"(rd140));
  // PTX:1013 ld.global.f32 %f95, [%rd227]
  f95 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd227) + (0)))));
  // PTX:1014 ld.global.f32 %f96, [%rd227+4]
  f96 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd227) + (4)))));
  // PTX:1015 mul.f32 %f685, %f96, %f96
  asm("mul.f32 %0, %1, %2;" : "=f"(f685) : "f"(f96), "f"(f96));
  // PTX:1016 ld.global.f32 %f97, [%rd227+8]
  f97 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd227) + (8)))));
  // PTX:1017 fma.rn.f32 %f686, %f95, %f95, %f685
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f686) : "f"(f95), "f"(f95), "f"(f685));
  // PTX:1018 fma.rn.f32 %f687, %f97, %f97, %f686
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f687) : "f"(f97), "f"(f97), "f"(f686));
  // PTX:1019 sqrt.rn.f32 %f98, %f687
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f98) : "f"(f687));
  // PTX:1020 setp.leu.f32 %p88, %f98, 0f00000000
  p88 = ((isnan(((float)(f98))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f98)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1021 mov.u32 %r1778, %r1777
  asm("mov.u32 %0, %1;" : "=r"(r1778) : "r"(r1777));
  // PTX:1022 mov.u32 %r1779, %r1777
  asm("mov.u32 %0, %1;" : "=r"(r1779) : "r"(r1777));
  // PTX:1023 @%p88 bra $L__BB7_85
  if (p88) { goto L_BB7_85; }
  // PTX:1025 div.rn.f32 %f688, %f95, %f98
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f688) : "f"(f95), "f"(f98));
  // PTX:1026 div.rn.f32 %f689, %f96, %f98
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f689) : "f"(f96), "f"(f98));
  // PTX:1027 div.rn.f32 %f690, %f97, %f98
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f690) : "f"(f97), "f"(f98));
  // PTX:1028 mov.b32 %r1779, %f690
  asm("mov.b32 %0, %1;" : "=r"(r1779) : "f"(f690));
  // PTX:1029 mov.b32 %r1778, %f689
  asm("mov.b32 %0, %1;" : "=r"(r1778) : "f"(f689));
  // PTX:1030 mov.b32 %r1777, %f688
  asm("mov.b32 %0, %1;" : "=r"(r1777) : "f"(f688));
  // PTX:1032 $L__BB7_85:
L_BB7_85:;
  // PTX:1033 mov.u32 %r1820, %r1823
  asm("mov.u32 %0, %1;" : "=r"(r1820) : "r"(r1823));
  // PTX:1034 mov.u32 %r1821, %r1824
  asm("mov.u32 %0, %1;" : "=r"(r1821) : "r"(r1824));
  // PTX:1035 mov.u32 %r1822, %r1825
  asm("mov.u32 %0, %1;" : "=r"(r1822) : "r"(r1825));
  // PTX:1036 @%p82 bra $L__BB7_87
  if (p82) { goto L_BB7_87; }
  // PTX:1038 mul.wide.s32 %rd228, %r1772, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd228) : "r"(r1772));
  // PTX:1039 add.s64 %rd229, %rd37, %rd228
  asm("add.s64 %0, %1, %2;" : "=l"(rd229) : "l"(rd37), "l"(rd228));
  // PTX:1040 mov.b32 %f691, %r1823
  asm("mov.b32 %0, %1;" : "=f"(f691) : "r"(r1823));
  // PTX:1041 ld.global.f32 %f692, [%rd229]
  f692 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd229) + (0)))));
  // PTX:1042 sub.f32 %f693, %f691, %f692
  asm("sub.f32 %0, %1, %2;" : "=f"(f693) : "f"(f691), "f"(f692));
  // PTX:1043 mov.b32 %f694, %r1824
  asm("mov.b32 %0, %1;" : "=f"(f694) : "r"(r1824));
  // PTX:1044 ld.global.f32 %f695, [%rd229+4]
  f695 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd229) + (4)))));
  // PTX:1045 sub.f32 %f696, %f694, %f695
  asm("sub.f32 %0, %1, %2;" : "=f"(f696) : "f"(f694), "f"(f695));
  // PTX:1046 mov.b32 %f697, %r1825
  asm("mov.b32 %0, %1;" : "=f"(f697) : "r"(r1825));
  // PTX:1047 ld.global.f32 %f698, [%rd229+8]
  f698 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd229) + (8)))));
  // PTX:1048 sub.f32 %f699, %f697, %f698
  asm("sub.f32 %0, %1, %2;" : "=f"(f699) : "f"(f697), "f"(f698));
  // PTX:1049 mul.wide.s32 %rd230, %r1776, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd230) : "r"(r1776));
  // PTX:1050 add.s64 %rd231, %rd23, %rd230
  asm("add.s64 %0, %1, %2;" : "=l"(rd231) : "l"(rd23), "l"(rd230));
  // PTX:1051 mul.wide.s32 %rd232, %r1775, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd232) : "r"(r1775));
  // PTX:1052 add.s64 %rd233, %rd23, %rd232
  asm("add.s64 %0, %1, %2;" : "=l"(rd233) : "l"(rd23), "l"(rd232));
  // PTX:1053 ld.global.f32 %f700, [%rd233]
  f700 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd233) + (0)))));
  // PTX:1054 ld.global.f32 %f701, [%rd233+4]
  f701 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd233) + (4)))));
  // PTX:1055 ld.global.f32 %f702, [%rd233+8]
  f702 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd233) + (8)))));
  // PTX:1056 ld.global.f32 %f703, [%rd231]
  f703 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd231) + (0)))));
  // PTX:1057 fma.rn.f32 %f704, %f693, %f700, %f703
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f704) : "f"(f693), "f"(f700), "f"(f703));
  // PTX:1058 ld.global.f32 %f705, [%rd231+4]
  f705 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd231) + (4)))));
  // PTX:1059 fma.rn.f32 %f706, %f693, %f701, %f705
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f706) : "f"(f693), "f"(f701), "f"(f705));
  // PTX:1060 ld.global.f32 %f707, [%rd231+8]
  f707 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd231) + (8)))));
  // PTX:1061 fma.rn.f32 %f708, %f693, %f702, %f707
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f708) : "f"(f693), "f"(f702), "f"(f707));
  // PTX:1062 mul.wide.s32 %rd234, %r1774, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd234) : "r"(r1774));
  // PTX:1063 add.s64 %rd235, %rd23, %rd234
  asm("add.s64 %0, %1, %2;" : "=l"(rd235) : "l"(rd23), "l"(rd234));
  // PTX:1064 ld.global.f32 %f709, [%rd235]
  f709 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd235) + (0)))));
  // PTX:1065 ld.global.f32 %f710, [%rd235+4]
  f710 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd235) + (4)))));
  // PTX:1066 ld.global.f32 %f711, [%rd235+8]
  f711 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd235) + (8)))));
  // PTX:1067 fma.rn.f32 %f712, %f696, %f709, %f704
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f712) : "f"(f696), "f"(f709), "f"(f704));
  // PTX:1068 fma.rn.f32 %f713, %f696, %f710, %f706
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f713) : "f"(f696), "f"(f710), "f"(f706));
  // PTX:1069 fma.rn.f32 %f714, %f696, %f711, %f708
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f714) : "f"(f696), "f"(f711), "f"(f708));
  // PTX:1070 mul.wide.s32 %rd236, %r1773, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd236) : "r"(r1773));
  // PTX:1071 add.s64 %rd237, %rd23, %rd236
  asm("add.s64 %0, %1, %2;" : "=l"(rd237) : "l"(rd23), "l"(rd236));
  // PTX:1072 ld.global.f32 %f715, [%rd237]
  f715 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd237) + (0)))));
  // PTX:1073 ld.global.f32 %f716, [%rd237+4]
  f716 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd237) + (4)))));
  // PTX:1074 ld.global.f32 %f717, [%rd237+8]
  f717 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd237) + (8)))));
  // PTX:1075 fma.rn.f32 %f718, %f699, %f715, %f712
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f718) : "f"(f699), "f"(f715), "f"(f712));
  // PTX:1076 fma.rn.f32 %f719, %f699, %f716, %f713
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f719) : "f"(f699), "f"(f716), "f"(f713));
  // PTX:1077 fma.rn.f32 %f720, %f699, %f717, %f714
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f720) : "f"(f699), "f"(f717), "f"(f714));
  // PTX:1078 mov.b32 %r1820, %f718
  asm("mov.b32 %0, %1;" : "=r"(r1820) : "f"(f718));
  // PTX:1079 mov.b32 %r1821, %f719
  asm("mov.b32 %0, %1;" : "=r"(r1821) : "f"(f719));
  // PTX:1080 mov.b32 %r1822, %f720
  asm("mov.b32 %0, %1;" : "=r"(r1822) : "f"(f720));
  // PTX:1082 $L__BB7_87:
L_BB7_87:;
  // PTX:1083 setp.eq.s32 %p90, %r95, 3
  p90 = (((int)(r95)) == ((int)(3)));
  // PTX:1084 @%p90 bra $L__BB7_89
  if (p90) { goto L_BB7_89; }
  // PTX:1085 bra.uni $L__BB7_88
  goto L_BB7_88;
  // PTX:1087 $L__BB7_89:
L_BB7_89:;
  // PTX:1088 mul.lo.s64 %rd238, %rd82, 28
  asm("mul.lo.s64 %0, %1, 28;" : "=l"(rd238) : "l"(rd82));
  // PTX:1089 add.s64 %rd239, %rd38, %rd238
  asm("add.s64 %0, %1, %2;" : "=l"(rd239) : "l"(rd38), "l"(rd238));
  // PTX:1090 ld.global.u32 %r1826, [%rd239]
  r1826 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd239) + (0)))));
  // PTX:1091 ld.global.u32 %r1827, [%rd239+4]
  r1827 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd239) + (4)))));
  // PTX:1092 ld.global.u32 %r1828, [%rd239+8]
  r1828 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd239) + (8)))));
  // PTX:1093 mov.u32 %r1783, %r1828
  asm("mov.u32 %0, %1;" : "=r"(r1783) : "r"(r1828));
  // PTX:1094 mov.u32 %r1784, %r1827
  asm("mov.u32 %0, %1;" : "=r"(r1784) : "r"(r1827));
  // PTX:1095 mov.u32 %r1785, %r1826
  asm("mov.u32 %0, %1;" : "=r"(r1785) : "r"(r1826));
  // PTX:1096 @%p82 bra $L__BB7_91
  if (p82) { goto L_BB7_91; }
  // PTX:1098 mul.wide.s32 %rd240, %r1772, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd240) : "r"(r1772));
  // PTX:1099 add.s64 %rd241, %rd37, %rd240
  asm("add.s64 %0, %1, %2;" : "=l"(rd241) : "l"(rd37), "l"(rd240));
  // PTX:1100 mov.b32 %f721, %r1826
  asm("mov.b32 %0, %1;" : "=f"(f721) : "r"(r1826));
  // PTX:1101 ld.global.f32 %f722, [%rd241]
  f722 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd241) + (0)))));
  // PTX:1102 sub.f32 %f723, %f721, %f722
  asm("sub.f32 %0, %1, %2;" : "=f"(f723) : "f"(f721), "f"(f722));
  // PTX:1103 mov.b32 %f724, %r1827
  asm("mov.b32 %0, %1;" : "=f"(f724) : "r"(r1827));
  // PTX:1104 ld.global.f32 %f725, [%rd241+4]
  f725 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd241) + (4)))));
  // PTX:1105 sub.f32 %f726, %f724, %f725
  asm("sub.f32 %0, %1, %2;" : "=f"(f726) : "f"(f724), "f"(f725));
  // PTX:1106 mov.b32 %f727, %r1828
  asm("mov.b32 %0, %1;" : "=f"(f727) : "r"(r1828));
  // PTX:1107 ld.global.f32 %f728, [%rd241+8]
  f728 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd241) + (8)))));
  // PTX:1108 sub.f32 %f729, %f727, %f728
  asm("sub.f32 %0, %1, %2;" : "=f"(f729) : "f"(f727), "f"(f728));
  // PTX:1109 mul.wide.s32 %rd242, %r1776, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd242) : "r"(r1776));
  // PTX:1110 add.s64 %rd243, %rd23, %rd242
  asm("add.s64 %0, %1, %2;" : "=l"(rd243) : "l"(rd23), "l"(rd242));
  // PTX:1111 mul.wide.s32 %rd244, %r1775, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd244) : "r"(r1775));
  // PTX:1112 add.s64 %rd245, %rd23, %rd244
  asm("add.s64 %0, %1, %2;" : "=l"(rd245) : "l"(rd23), "l"(rd244));
  // PTX:1113 ld.global.f32 %f730, [%rd245]
  f730 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd245) + (0)))));
  // PTX:1114 ld.global.f32 %f731, [%rd245+4]
  f731 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd245) + (4)))));
  // PTX:1115 ld.global.f32 %f732, [%rd245+8]
  f732 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd245) + (8)))));
  // PTX:1116 ld.global.f32 %f733, [%rd243]
  f733 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd243) + (0)))));
  // PTX:1117 fma.rn.f32 %f734, %f723, %f730, %f733
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f734) : "f"(f723), "f"(f730), "f"(f733));
  // PTX:1118 ld.global.f32 %f735, [%rd243+4]
  f735 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd243) + (4)))));
  // PTX:1119 fma.rn.f32 %f736, %f723, %f731, %f735
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f736) : "f"(f723), "f"(f731), "f"(f735));
  // PTX:1120 ld.global.f32 %f737, [%rd243+8]
  f737 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd243) + (8)))));
  // PTX:1121 fma.rn.f32 %f738, %f723, %f732, %f737
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f738) : "f"(f723), "f"(f732), "f"(f737));
  // PTX:1122 mul.wide.s32 %rd246, %r1774, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd246) : "r"(r1774));
  // PTX:1123 add.s64 %rd247, %rd23, %rd246
  asm("add.s64 %0, %1, %2;" : "=l"(rd247) : "l"(rd23), "l"(rd246));
  // PTX:1124 ld.global.f32 %f739, [%rd247]
  f739 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd247) + (0)))));
  // PTX:1125 ld.global.f32 %f740, [%rd247+4]
  f740 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd247) + (4)))));
  // PTX:1126 ld.global.f32 %f741, [%rd247+8]
  f741 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd247) + (8)))));
  // PTX:1127 fma.rn.f32 %f742, %f726, %f739, %f734
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f742) : "f"(f726), "f"(f739), "f"(f734));
  // PTX:1128 fma.rn.f32 %f743, %f726, %f740, %f736
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f743) : "f"(f726), "f"(f740), "f"(f736));
  // PTX:1129 fma.rn.f32 %f744, %f726, %f741, %f738
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f744) : "f"(f726), "f"(f741), "f"(f738));
  // PTX:1130 mul.wide.s32 %rd248, %r1773, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd248) : "r"(r1773));
  // PTX:1131 add.s64 %rd249, %rd23, %rd248
  asm("add.s64 %0, %1, %2;" : "=l"(rd249) : "l"(rd23), "l"(rd248));
  // PTX:1132 ld.global.f32 %f745, [%rd249]
  f745 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd249) + (0)))));
  // PTX:1133 ld.global.f32 %f746, [%rd249+4]
  f746 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd249) + (4)))));
  // PTX:1134 ld.global.f32 %f747, [%rd249+8]
  f747 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd249) + (8)))));
  // PTX:1135 fma.rn.f32 %f748, %f729, %f745, %f742
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f748) : "f"(f729), "f"(f745), "f"(f742));
  // PTX:1136 fma.rn.f32 %f749, %f729, %f746, %f743
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f749) : "f"(f729), "f"(f746), "f"(f743));
  // PTX:1137 fma.rn.f32 %f750, %f729, %f747, %f744
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f750) : "f"(f729), "f"(f747), "f"(f744));
  // PTX:1138 mov.b32 %r1785, %f748
  asm("mov.b32 %0, %1;" : "=r"(r1785) : "f"(f748));
  // PTX:1139 mov.b32 %r1784, %f749
  asm("mov.b32 %0, %1;" : "=r"(r1784) : "f"(f749));
  // PTX:1140 mov.b32 %r1783, %f750
  asm("mov.b32 %0, %1;" : "=r"(r1783) : "f"(f750));
  // PTX:1142 $L__BB7_91:
L_BB7_91:;
  // PTX:1143 mov.b32 %f102, %r1785
  asm("mov.b32 %0, %1;" : "=f"(f102) : "r"(r1785));
  // PTX:1144 sub.f32 %f103, %f1499, %f102
  asm("sub.f32 %0, %1, %2;" : "=f"(f103) : "f"(f1499), "f"(f102));
  // PTX:1145 mov.b32 %f104, %r1784
  asm("mov.b32 %0, %1;" : "=f"(f104) : "r"(r1784));
  // PTX:1146 sub.f32 %f105, %f1500, %f104
  asm("sub.f32 %0, %1, %2;" : "=f"(f105) : "f"(f1500), "f"(f104));
  // PTX:1147 mov.b32 %f106, %r1783
  asm("mov.b32 %0, %1;" : "=f"(f106) : "r"(r1783));
  // PTX:1148 sub.f32 %f107, %f1501, %f106
  asm("sub.f32 %0, %1, %2;" : "=f"(f107) : "f"(f1501), "f"(f106));
  // PTX:1149 mul.f32 %f751, %f103, %f103
  asm("mul.f32 %0, %1, %2;" : "=f"(f751) : "f"(f103), "f"(f103));
  // PTX:1150 fma.rn.f32 %f752, %f105, %f105, %f751
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f752) : "f"(f105), "f"(f105), "f"(f751));
  // PTX:1151 fma.rn.f32 %f753, %f107, %f107, %f752
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f753) : "f"(f107), "f"(f107), "f"(f752));
  // PTX:1152 sqrt.rn.f32 %f108, %f753
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f108) : "f"(f753));
  // PTX:1153 setp.leu.f32 %p92, %f108, 0f00000000
  p92 = ((isnan(((float)(f108))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f108)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1154 mov.u32 %r1786, 0
  asm("mov.u32 %0, 0;" : "=r"(r1786) : );
  // PTX:1155 mov.u32 %r1787, %r1786
  asm("mov.u32 %0, %1;" : "=r"(r1787) : "r"(r1786));
  // PTX:1156 mov.u32 %r1788, %r1786
  asm("mov.u32 %0, %1;" : "=r"(r1788) : "r"(r1786));
  // PTX:1157 @%p92 bra $L__BB7_93
  if (p92) { goto L_BB7_93; }
  // PTX:1159 div.rn.f32 %f754, %f103, %f108
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f754) : "f"(f103), "f"(f108));
  // PTX:1160 div.rn.f32 %f755, %f105, %f108
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f755) : "f"(f105), "f"(f108));
  // PTX:1161 div.rn.f32 %f756, %f107, %f108
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f756) : "f"(f107), "f"(f108));
  // PTX:1162 mov.b32 %r1788, %f756
  asm("mov.b32 %0, %1;" : "=r"(r1788) : "f"(f756));
  // PTX:1163 mov.b32 %r1787, %f755
  asm("mov.b32 %0, %1;" : "=r"(r1787) : "f"(f755));
  // PTX:1164 mov.b32 %r1786, %f754
  asm("mov.b32 %0, %1;" : "=r"(r1786) : "f"(f754));
  // PTX:1166 $L__BB7_93:
L_BB7_93:;
  // PTX:1167 mov.b32 %f757, %r1786
  asm("mov.b32 %0, %1;" : "=f"(f757) : "r"(r1786));
  // PTX:1168 mov.b32 %f758, %r1787
  asm("mov.b32 %0, %1;" : "=f"(f758) : "r"(r1787));
  // PTX:1169 mul.f32 %f759, %f758, %f758
  asm("mul.f32 %0, %1, %2;" : "=f"(f759) : "f"(f758), "f"(f758));
  // PTX:1170 mov.b32 %f760, %r1788
  asm("mov.b32 %0, %1;" : "=f"(f760) : "r"(r1788));
  // PTX:1171 fma.rn.f32 %f761, %f757, %f757, %f759
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f761) : "f"(f757), "f"(f757), "f"(f759));
  // PTX:1172 fma.rn.f32 %f762, %f760, %f760, %f761
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f762) : "f"(f760), "f"(f760), "f"(f761));
  // PTX:1173 setp.ltu.f32 %p93, %f762, 0f3F000000
  p93 = ((isnan(((float)(f762))) || isnan(((float)(as_f32(0x3F000000u))))) || (((float)(f762)) < ((float)(as_f32(0x3F000000u)))));
  // PTX:1174 selp.b32 %r134, %r1779, %r1788, %p93
  r134 = p93 ? r1779 : r1788;
  // PTX:1175 selp.b32 %r135, %r1778, %r1787, %p93
  r135 = p93 ? r1778 : r1787;
  // PTX:1176 selp.b32 %r1128, %r1777, %r1786, %p93
  r1128 = p93 ? r1777 : r1786;
  // PTX:1177 mul.lo.s64 %rd250, %rd82, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd250) : "l"(rd82));
  // PTX:1178 add.s64 %rd251, %rd40, %rd250
  asm("add.s64 %0, %1, %2;" : "=l"(rd251) : "l"(rd40), "l"(rd250));
  // PTX:1179 ld.global.f32 %f109, [%rd251]
  f109 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd251) + (0)))));
  // PTX:1180 mov.b32 %f1533, %r1128
  asm("mov.b32 %0, %1;" : "=f"(f1533) : "r"(r1128));
  // PTX:1181 @%p82 bra $L__BB7_115
  if (p82) { goto L_BB7_115; }
  // PTX:1183 mov.b32 %f1532, %r135
  asm("mov.b32 %0, %1;" : "=f"(f1532) : "r"(r135));
  // PTX:1184 mul.f32 %f1530, %f109, %f1533
  asm("mul.f32 %0, %1, %2;" : "=f"(f1530) : "f"(f109), "f"(f1533));
  // PTX:1185 mul.f32 %f1528, %f109, %f1532
  asm("mul.f32 %0, %1, %2;" : "=f"(f1528) : "f"(f109), "f"(f1532));
  // PTX:1186 mov.b32 %f1531, %r134
  asm("mov.b32 %0, %1;" : "=f"(f1531) : "r"(r134));
  // PTX:1187 mul.f32 %f1526, %f109, %f1531
  asm("mul.f32 %0, %1, %2;" : "=f"(f1526) : "f"(f109), "f"(f1531));
  // PTX:1188 mul.wide.s32 %rd252, %r1775, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd252) : "r"(r1775));
  // PTX:1189 add.s64 %rd253, %rd23, %rd252
  asm("add.s64 %0, %1, %2;" : "=l"(rd253) : "l"(rd23), "l"(rd252));
  // PTX:1190 mul.wide.s32 %rd254, %r1774, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd254) : "r"(r1774));
  // PTX:1191 add.s64 %rd255, %rd23, %rd254
  asm("add.s64 %0, %1, %2;" : "=l"(rd255) : "l"(rd23), "l"(rd254));
  // PTX:1192 mul.wide.s32 %rd256, %r1773, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd256) : "r"(r1773));
  // PTX:1193 add.s64 %rd257, %rd23, %rd256
  asm("add.s64 %0, %1, %2;" : "=l"(rd257) : "l"(rd23), "l"(rd256));
  // PTX:1194 ld.global.f32 %f116, [%rd257+8]
  f116 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd257) + (8)))));
  // PTX:1195 ld.global.f32 %f117, [%rd255+4]
  f117 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd255) + (4)))));
  // PTX:1196 mul.f32 %f763, %f117, %f116
  asm("mul.f32 %0, %1, %2;" : "=f"(f763) : "f"(f117), "f"(f116));
  // PTX:1197 ld.global.f32 %f118, [%rd257+4]
  f118 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd257) + (4)))));
  // PTX:1198 ld.global.f32 %f119, [%rd255+8]
  f119 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd255) + (8)))));
  // PTX:1199 mul.f32 %f764, %f119, %f118
  asm("mul.f32 %0, %1, %2;" : "=f"(f764) : "f"(f119), "f"(f118));
  // PTX:1200 sub.f32 %f120, %f763, %f764
  asm("sub.f32 %0, %1, %2;" : "=f"(f120) : "f"(f763), "f"(f764));
  // PTX:1201 ld.global.f32 %f121, [%rd257]
  f121 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd257) + (0)))));
  // PTX:1202 mul.f32 %f765, %f119, %f121
  asm("mul.f32 %0, %1, %2;" : "=f"(f765) : "f"(f119), "f"(f121));
  // PTX:1203 ld.global.f32 %f122, [%rd255]
  f122 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd255) + (0)))));
  // PTX:1204 mul.f32 %f766, %f122, %f116
  asm("mul.f32 %0, %1, %2;" : "=f"(f766) : "f"(f122), "f"(f116));
  // PTX:1205 sub.f32 %f123, %f765, %f766
  asm("sub.f32 %0, %1, %2;" : "=f"(f123) : "f"(f765), "f"(f766));
  // PTX:1206 mul.f32 %f767, %f122, %f118
  asm("mul.f32 %0, %1, %2;" : "=f"(f767) : "f"(f122), "f"(f118));
  // PTX:1207 mul.f32 %f768, %f117, %f121
  asm("mul.f32 %0, %1, %2;" : "=f"(f768) : "f"(f117), "f"(f121));
  // PTX:1208 sub.f32 %f124, %f767, %f768
  asm("sub.f32 %0, %1, %2;" : "=f"(f124) : "f"(f767), "f"(f768));
  // PTX:1209 ld.global.f32 %f125, [%rd253]
  f125 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd253) + (0)))));
  // PTX:1210 ld.global.f32 %f126, [%rd253+4]
  f126 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd253) + (4)))));
  // PTX:1211 mul.f32 %f769, %f126, %f123
  asm("mul.f32 %0, %1, %2;" : "=f"(f769) : "f"(f126), "f"(f123));
  // PTX:1212 ld.global.f32 %f127, [%rd253+8]
  f127 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd253) + (8)))));
  // PTX:1213 fma.rn.f32 %f770, %f125, %f120, %f769
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f770) : "f"(f125), "f"(f120), "f"(f769));
  // PTX:1214 fma.rn.f32 %f128, %f127, %f124, %f770
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f128) : "f"(f127), "f"(f124), "f"(f770));
  // PTX:1215 abs.f32 %f771, %f128
  asm("abs.f32 %0, %1;" : "=f"(f771) : "f"(f128));
  // PTX:1216 setp.leu.f32 %p95, %f771, 0f2EDBE6FF
  p95 = ((isnan(((float)(f771))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) || (((float)(f771)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:1217 setp.geu.f32 %p96, %f771, 0f7F800000
  p96 = ((isnan(((float)(f771))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f771)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1218 or.pred %p97, %p95, %p96
  p97 = ((p95) || (p96));
  // PTX:1219 @%p97 bra $L__BB7_96
  if (p97) { goto L_BB7_96; }
  // PTX:1220 bra.uni $L__BB7_95
  goto L_BB7_95;
  // PTX:1222 $L__BB7_96:
L_BB7_96:;
  // PTX:1223 mul.f32 %f809, %f126, %f126
  asm("mul.f32 %0, %1, %2;" : "=f"(f809) : "f"(f126), "f"(f126));
  // PTX:1224 fma.rn.f32 %f810, %f125, %f125, %f809
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f810) : "f"(f125), "f"(f125), "f"(f809));
  // PTX:1225 fma.rn.f32 %f811, %f127, %f127, %f810
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f811) : "f"(f127), "f"(f127), "f"(f810));
  // PTX:1226 mul.f32 %f812, %f117, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f812) : "f"(f117), "f"(f117));
  // PTX:1227 fma.rn.f32 %f813, %f122, %f122, %f812
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f813) : "f"(f122), "f"(f122), "f"(f812));
  // PTX:1228 fma.rn.f32 %f814, %f119, %f119, %f813
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f814) : "f"(f119), "f"(f119), "f"(f813));
  // PTX:1229 add.f32 %f815, %f811, %f814
  asm("add.f32 %0, %1, %2;" : "=f"(f815) : "f"(f811), "f"(f814));
  // PTX:1230 mul.f32 %f816, %f118, %f118
  asm("mul.f32 %0, %1, %2;" : "=f"(f816) : "f"(f118), "f"(f118));
  // PTX:1231 fma.rn.f32 %f817, %f121, %f121, %f816
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f817) : "f"(f121), "f"(f121), "f"(f816));
  // PTX:1232 fma.rn.f32 %f818, %f116, %f116, %f817
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f818) : "f"(f116), "f"(f116), "f"(f817));
  // PTX:1233 add.f32 %f819, %f815, %f818
  asm("add.f32 %0, %1, %2;" : "=f"(f819) : "f"(f815), "f"(f818));
  // PTX:1234 div.rn.f32 %f820, %f819, 0f40400000
  asm("div.rn.f32 %0, %1, 0f40400000;" : "=f"(f820) : "f"(f819));
  // PTX:1235 sqrt.rn.f32 %f129, %f820
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f129) : "f"(f820));
  // PTX:1236 setp.leu.f32 %p98, %f129, 0f322BCC77
  p98 = ((isnan(((float)(f129))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f129)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1237 mov.u32 %r1805, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r1805) : );
  // PTX:1238 mov.u32 %r1806, 0
  asm("mov.u32 %0, 0;" : "=r"(r1806) : );
  // PTX:1239 mov.u32 %r1807, %r1806
  asm("mov.u32 %0, %1;" : "=r"(r1807) : "r"(r1806));
  // PTX:1240 mov.u32 %r1808, %r1806
  asm("mov.u32 %0, %1;" : "=r"(r1808) : "r"(r1806));
  // PTX:1241 mov.u32 %r1809, %r1805
  asm("mov.u32 %0, %1;" : "=r"(r1809) : "r"(r1805));
  // PTX:1242 mov.u32 %r1810, %r1806
  asm("mov.u32 %0, %1;" : "=r"(r1810) : "r"(r1806));
  // PTX:1243 mov.u32 %r1811, %r1806
  asm("mov.u32 %0, %1;" : "=r"(r1811) : "r"(r1806));
  // PTX:1244 mov.u32 %r1812, %r1806
  asm("mov.u32 %0, %1;" : "=r"(r1812) : "r"(r1806));
  // PTX:1245 mov.u32 %r1813, %r1805
  asm("mov.u32 %0, %1;" : "=r"(r1813) : "r"(r1805));
  // PTX:1246 @%p98 bra $L__BB7_113
  if (p98) { goto L_BB7_113; }
  // PTX:1248 abs.f32 %f821, %f129
  asm("abs.f32 %0, %1;" : "=f"(f821) : "f"(f129));
  // PTX:1249 setp.geu.f32 %p99, %f821, 0f7F800000
  p99 = ((isnan(((float)(f821))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f821)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1250 @%p99 bra $L__BB7_113
  if (p99) { goto L_BB7_113; }
  // PTX:1252 rcp.rn.f32 %f822, %f129
  asm("rcp.rn.f32 %0, %1;" : "=f"(f822) : "f"(f129));
  // PTX:1253 mul.f32 %f1514, %f125, %f822
  asm("mul.f32 %0, %1, %2;" : "=f"(f1514) : "f"(f125), "f"(f822));
  // PTX:1254 mul.f32 %f1515, %f126, %f822
  asm("mul.f32 %0, %1, %2;" : "=f"(f1515) : "f"(f126), "f"(f822));
  // PTX:1255 mul.f32 %f1516, %f127, %f822
  asm("mul.f32 %0, %1, %2;" : "=f"(f1516) : "f"(f127), "f"(f822));
  // PTX:1256 mul.f32 %f1517, %f122, %f822
  asm("mul.f32 %0, %1, %2;" : "=f"(f1517) : "f"(f122), "f"(f822));
  // PTX:1257 mul.f32 %f1518, %f117, %f822
  asm("mul.f32 %0, %1, %2;" : "=f"(f1518) : "f"(f117), "f"(f822));
  // PTX:1258 mul.f32 %f1519, %f119, %f822
  asm("mul.f32 %0, %1, %2;" : "=f"(f1519) : "f"(f119), "f"(f822));
  // PTX:1259 mul.f32 %f1520, %f121, %f822
  asm("mul.f32 %0, %1, %2;" : "=f"(f1520) : "f"(f121), "f"(f822));
  // PTX:1260 mul.f32 %f1521, %f118, %f822
  asm("mul.f32 %0, %1, %2;" : "=f"(f1521) : "f"(f118), "f"(f822));
  // PTX:1261 mul.f32 %f1522, %f116, %f822
  asm("mul.f32 %0, %1, %2;" : "=f"(f1522) : "f"(f116), "f"(f822));
  // PTX:1262 mov.u32 %r1789, 0
  asm("mov.u32 %0, 0;" : "=r"(r1789) : );
  // PTX:1264 $L__BB7_99:
L_BB7_99:;
  // PTX:1265 mul.f32 %f823, %f1519, %f1521
  asm("mul.f32 %0, %1, %2;" : "=f"(f823) : "f"(f1519), "f"(f1521));
  // PTX:1266 mul.f32 %f824, %f1518, %f1522
  asm("mul.f32 %0, %1, %2;" : "=f"(f824) : "f"(f1518), "f"(f1522));
  // PTX:1267 sub.f32 %f148, %f824, %f823
  asm("sub.f32 %0, %1, %2;" : "=f"(f148) : "f"(f824), "f"(f823));
  // PTX:1268 mul.f32 %f825, %f1517, %f1522
  asm("mul.f32 %0, %1, %2;" : "=f"(f825) : "f"(f1517), "f"(f1522));
  // PTX:1269 mul.f32 %f826, %f1519, %f1520
  asm("mul.f32 %0, %1, %2;" : "=f"(f826) : "f"(f1519), "f"(f1520));
  // PTX:1270 sub.f32 %f149, %f826, %f825
  asm("sub.f32 %0, %1, %2;" : "=f"(f149) : "f"(f826), "f"(f825));
  // PTX:1271 mul.f32 %f827, %f1518, %f1520
  asm("mul.f32 %0, %1, %2;" : "=f"(f827) : "f"(f1518), "f"(f1520));
  // PTX:1272 mul.f32 %f828, %f1517, %f1521
  asm("mul.f32 %0, %1, %2;" : "=f"(f828) : "f"(f1517), "f"(f1521));
  // PTX:1273 sub.f32 %f150, %f828, %f827
  asm("sub.f32 %0, %1, %2;" : "=f"(f150) : "f"(f828), "f"(f827));
  // PTX:1274 mul.f32 %f829, %f1515, %f149
  asm("mul.f32 %0, %1, %2;" : "=f"(f829) : "f"(f1515), "f"(f149));
  // PTX:1275 fma.rn.f32 %f830, %f1514, %f148, %f829
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f830) : "f"(f1514), "f"(f148), "f"(f829));
  // PTX:1276 fma.rn.f32 %f151, %f1516, %f150, %f830
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f151) : "f"(f1516), "f"(f150), "f"(f830));
  // PTX:1277 abs.f32 %f831, %f151
  asm("abs.f32 %0, %1;" : "=f"(f831) : "f"(f151));
  // PTX:1278 setp.le.f32 %p100, %f831, 0f2EDBE6FF
  p100 = (!(isnan(((float)(f831))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f831)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:1279 setp.geu.f32 %p101, %f831, 0f7F800000
  p101 = ((isnan(((float)(f831))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f831)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1280 or.pred %p102, %p100, %p101
  p102 = ((p100) || (p101));
  // PTX:1281 @%p102 bra $L__BB7_102
  if (p102) { goto L_BB7_102; }
  // PTX:1283 rcp.rn.f32 %f832, %f151
  asm("rcp.rn.f32 %0, %1;" : "=f"(f832) : "f"(f151));
  // PTX:1284 mul.f32 %f833, %f1515, %f1522
  asm("mul.f32 %0, %1, %2;" : "=f"(f833) : "f"(f1515), "f"(f1522));
  // PTX:1285 mul.f32 %f834, %f1516, %f1521
  asm("mul.f32 %0, %1, %2;" : "=f"(f834) : "f"(f1516), "f"(f1521));
  // PTX:1286 sub.f32 %f835, %f834, %f833
  asm("sub.f32 %0, %1, %2;" : "=f"(f835) : "f"(f834), "f"(f833));
  // PTX:1287 mul.f32 %f836, %f1516, %f1520
  asm("mul.f32 %0, %1, %2;" : "=f"(f836) : "f"(f1516), "f"(f1520));
  // PTX:1288 mul.f32 %f837, %f1514, %f1522
  asm("mul.f32 %0, %1, %2;" : "=f"(f837) : "f"(f1514), "f"(f1522));
  // PTX:1289 sub.f32 %f838, %f837, %f836
  asm("sub.f32 %0, %1, %2;" : "=f"(f838) : "f"(f837), "f"(f836));
  // PTX:1290 mul.f32 %f839, %f1514, %f1521
  asm("mul.f32 %0, %1, %2;" : "=f"(f839) : "f"(f1514), "f"(f1521));
  // PTX:1291 mul.f32 %f840, %f1515, %f1520
  asm("mul.f32 %0, %1, %2;" : "=f"(f840) : "f"(f1515), "f"(f1520));
  // PTX:1292 sub.f32 %f841, %f840, %f839
  asm("sub.f32 %0, %1, %2;" : "=f"(f841) : "f"(f840), "f"(f839));
  // PTX:1293 mul.f32 %f842, %f1516, %f1518
  asm("mul.f32 %0, %1, %2;" : "=f"(f842) : "f"(f1516), "f"(f1518));
  // PTX:1294 mul.f32 %f843, %f1515, %f1519
  asm("mul.f32 %0, %1, %2;" : "=f"(f843) : "f"(f1515), "f"(f1519));
  // PTX:1295 sub.f32 %f844, %f843, %f842
  asm("sub.f32 %0, %1, %2;" : "=f"(f844) : "f"(f843), "f"(f842));
  // PTX:1296 mul.f32 %f845, %f1514, %f1519
  asm("mul.f32 %0, %1, %2;" : "=f"(f845) : "f"(f1514), "f"(f1519));
  // PTX:1297 mul.f32 %f846, %f1516, %f1517
  asm("mul.f32 %0, %1, %2;" : "=f"(f846) : "f"(f1516), "f"(f1517));
  // PTX:1298 sub.f32 %f847, %f846, %f845
  asm("sub.f32 %0, %1, %2;" : "=f"(f847) : "f"(f846), "f"(f845));
  // PTX:1299 mul.f32 %f848, %f1515, %f1517
  asm("mul.f32 %0, %1, %2;" : "=f"(f848) : "f"(f1515), "f"(f1517));
  // PTX:1300 mul.f32 %f849, %f1514, %f1518
  asm("mul.f32 %0, %1, %2;" : "=f"(f849) : "f"(f1514), "f"(f1518));
  // PTX:1301 sub.f32 %f850, %f849, %f848
  asm("sub.f32 %0, %1, %2;" : "=f"(f850) : "f"(f849), "f"(f848));
  // PTX:1302 fma.rn.f32 %f851, %f148, %f832, %f1514
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f851) : "f"(f148), "f"(f832), "f"(f1514));
  // PTX:1303 fma.rn.f32 %f852, %f149, %f832, %f1515
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f852) : "f"(f149), "f"(f832), "f"(f1515));
  // PTX:1304 fma.rn.f32 %f853, %f150, %f832, %f1516
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f853) : "f"(f150), "f"(f832), "f"(f1516));
  // PTX:1305 fma.rn.f32 %f854, %f835, %f832, %f1517
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f854) : "f"(f835), "f"(f832), "f"(f1517));
  // PTX:1306 fma.rn.f32 %f855, %f838, %f832, %f1518
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f855) : "f"(f838), "f"(f832), "f"(f1518));
  // PTX:1307 fma.rn.f32 %f856, %f841, %f832, %f1519
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f856) : "f"(f841), "f"(f832), "f"(f1519));
  // PTX:1308 fma.rn.f32 %f857, %f844, %f832, %f1520
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f857) : "f"(f844), "f"(f832), "f"(f1520));
  // PTX:1309 fma.rn.f32 %f858, %f847, %f832, %f1521
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f858) : "f"(f847), "f"(f832), "f"(f1521));
  // PTX:1310 fma.rn.f32 %f859, %f850, %f832, %f1522
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f859) : "f"(f850), "f"(f832), "f"(f1522));
  // PTX:1311 mul.f32 %f1514, %f851, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1514) : "f"(f851));
  // PTX:1312 mul.f32 %f1515, %f852, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1515) : "f"(f852));
  // PTX:1313 mul.f32 %f1516, %f853, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1516) : "f"(f853));
  // PTX:1314 mul.f32 %f1517, %f854, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1517) : "f"(f854));
  // PTX:1315 mul.f32 %f1518, %f855, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1518) : "f"(f855));
  // PTX:1316 mul.f32 %f1519, %f856, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1519) : "f"(f856));
  // PTX:1317 mul.f32 %f1520, %f857, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1520) : "f"(f857));
  // PTX:1318 mul.f32 %f1521, %f858, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1521) : "f"(f858));
  // PTX:1319 mul.f32 %f1522, %f859, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1522) : "f"(f859));
  // PTX:1320 mul.f32 %f860, %f1518, %f1522
  asm("mul.f32 %0, %1, %2;" : "=f"(f860) : "f"(f1518), "f"(f1522));
  // PTX:1321 mul.f32 %f861, %f1519, %f1521
  asm("mul.f32 %0, %1, %2;" : "=f"(f861) : "f"(f1519), "f"(f1521));
  // PTX:1322 sub.f32 %f161, %f860, %f861
  asm("sub.f32 %0, %1, %2;" : "=f"(f161) : "f"(f860), "f"(f861));
  // PTX:1323 mul.f32 %f862, %f1519, %f1520
  asm("mul.f32 %0, %1, %2;" : "=f"(f862) : "f"(f1519), "f"(f1520));
  // PTX:1324 mul.f32 %f863, %f1517, %f1522
  asm("mul.f32 %0, %1, %2;" : "=f"(f863) : "f"(f1517), "f"(f1522));
  // PTX:1325 sub.f32 %f162, %f862, %f863
  asm("sub.f32 %0, %1, %2;" : "=f"(f162) : "f"(f862), "f"(f863));
  // PTX:1326 mul.f32 %f864, %f1517, %f1521
  asm("mul.f32 %0, %1, %2;" : "=f"(f864) : "f"(f1517), "f"(f1521));
  // PTX:1327 mul.f32 %f865, %f1518, %f1520
  asm("mul.f32 %0, %1, %2;" : "=f"(f865) : "f"(f1518), "f"(f1520));
  // PTX:1328 sub.f32 %f163, %f864, %f865
  asm("sub.f32 %0, %1, %2;" : "=f"(f163) : "f"(f864), "f"(f865));
  // PTX:1329 mul.f32 %f866, %f1515, %f162
  asm("mul.f32 %0, %1, %2;" : "=f"(f866) : "f"(f1515), "f"(f162));
  // PTX:1330 fma.rn.f32 %f867, %f1514, %f161, %f866
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f867) : "f"(f1514), "f"(f161), "f"(f866));
  // PTX:1331 fma.rn.f32 %f164, %f1516, %f163, %f867
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f164) : "f"(f1516), "f"(f163), "f"(f867));
  // PTX:1332 abs.f32 %f868, %f164
  asm("abs.f32 %0, %1;" : "=f"(f868) : "f"(f164));
  // PTX:1333 setp.le.f32 %p103, %f868, 0f2EDBE6FF
  p103 = (!(isnan(((float)(f868))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f868)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:1334 setp.geu.f32 %p104, %f868, 0f7F800000
  p104 = ((isnan(((float)(f868))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f868)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1335 or.pred %p105, %p103, %p104
  p105 = ((p103) || (p104));
  // PTX:1336 @%p105 bra $L__BB7_102
  if (p105) { goto L_BB7_102; }
  // PTX:1338 rcp.rn.f32 %f869, %f164
  asm("rcp.rn.f32 %0, %1;" : "=f"(f869) : "f"(f164));
  // PTX:1339 mul.f32 %f870, %f1515, %f1522
  asm("mul.f32 %0, %1, %2;" : "=f"(f870) : "f"(f1515), "f"(f1522));
  // PTX:1340 mul.f32 %f871, %f1516, %f1521
  asm("mul.f32 %0, %1, %2;" : "=f"(f871) : "f"(f1516), "f"(f1521));
  // PTX:1341 sub.f32 %f872, %f871, %f870
  asm("sub.f32 %0, %1, %2;" : "=f"(f872) : "f"(f871), "f"(f870));
  // PTX:1342 mul.f32 %f873, %f1516, %f1520
  asm("mul.f32 %0, %1, %2;" : "=f"(f873) : "f"(f1516), "f"(f1520));
  // PTX:1343 mul.f32 %f874, %f1514, %f1522
  asm("mul.f32 %0, %1, %2;" : "=f"(f874) : "f"(f1514), "f"(f1522));
  // PTX:1344 sub.f32 %f875, %f874, %f873
  asm("sub.f32 %0, %1, %2;" : "=f"(f875) : "f"(f874), "f"(f873));
  // PTX:1345 mul.f32 %f876, %f1514, %f1521
  asm("mul.f32 %0, %1, %2;" : "=f"(f876) : "f"(f1514), "f"(f1521));
  // PTX:1346 mul.f32 %f877, %f1515, %f1520
  asm("mul.f32 %0, %1, %2;" : "=f"(f877) : "f"(f1515), "f"(f1520));
  // PTX:1347 sub.f32 %f878, %f877, %f876
  asm("sub.f32 %0, %1, %2;" : "=f"(f878) : "f"(f877), "f"(f876));
  // PTX:1348 mul.f32 %f879, %f1516, %f1518
  asm("mul.f32 %0, %1, %2;" : "=f"(f879) : "f"(f1516), "f"(f1518));
  // PTX:1349 mul.f32 %f880, %f1515, %f1519
  asm("mul.f32 %0, %1, %2;" : "=f"(f880) : "f"(f1515), "f"(f1519));
  // PTX:1350 sub.f32 %f881, %f880, %f879
  asm("sub.f32 %0, %1, %2;" : "=f"(f881) : "f"(f880), "f"(f879));
  // PTX:1351 mul.f32 %f882, %f1514, %f1519
  asm("mul.f32 %0, %1, %2;" : "=f"(f882) : "f"(f1514), "f"(f1519));
  // PTX:1352 mul.f32 %f883, %f1516, %f1517
  asm("mul.f32 %0, %1, %2;" : "=f"(f883) : "f"(f1516), "f"(f1517));
  // PTX:1353 sub.f32 %f884, %f883, %f882
  asm("sub.f32 %0, %1, %2;" : "=f"(f884) : "f"(f883), "f"(f882));
  // PTX:1354 mul.f32 %f885, %f1515, %f1517
  asm("mul.f32 %0, %1, %2;" : "=f"(f885) : "f"(f1515), "f"(f1517));
  // PTX:1355 mul.f32 %f886, %f1514, %f1518
  asm("mul.f32 %0, %1, %2;" : "=f"(f886) : "f"(f1514), "f"(f1518));
  // PTX:1356 sub.f32 %f887, %f886, %f885
  asm("sub.f32 %0, %1, %2;" : "=f"(f887) : "f"(f886), "f"(f885));
  // PTX:1357 fma.rn.f32 %f888, %f161, %f869, %f1514
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f888) : "f"(f161), "f"(f869), "f"(f1514));
  // PTX:1358 fma.rn.f32 %f889, %f162, %f869, %f1515
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f889) : "f"(f162), "f"(f869), "f"(f1515));
  // PTX:1359 fma.rn.f32 %f890, %f163, %f869, %f1516
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f890) : "f"(f163), "f"(f869), "f"(f1516));
  // PTX:1360 fma.rn.f32 %f891, %f872, %f869, %f1517
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f891) : "f"(f872), "f"(f869), "f"(f1517));
  // PTX:1361 fma.rn.f32 %f892, %f875, %f869, %f1518
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f892) : "f"(f875), "f"(f869), "f"(f1518));
  // PTX:1362 fma.rn.f32 %f893, %f878, %f869, %f1519
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f893) : "f"(f878), "f"(f869), "f"(f1519));
  // PTX:1363 fma.rn.f32 %f894, %f881, %f869, %f1520
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f894) : "f"(f881), "f"(f869), "f"(f1520));
  // PTX:1364 fma.rn.f32 %f895, %f884, %f869, %f1521
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f895) : "f"(f884), "f"(f869), "f"(f1521));
  // PTX:1365 fma.rn.f32 %f896, %f887, %f869, %f1522
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f896) : "f"(f887), "f"(f869), "f"(f1522));
  // PTX:1366 mul.f32 %f1514, %f888, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1514) : "f"(f888));
  // PTX:1367 mul.f32 %f1515, %f889, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1515) : "f"(f889));
  // PTX:1368 mul.f32 %f1516, %f890, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1516) : "f"(f890));
  // PTX:1369 mul.f32 %f1517, %f891, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1517) : "f"(f891));
  // PTX:1370 mul.f32 %f1518, %f892, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1518) : "f"(f892));
  // PTX:1371 mul.f32 %f1519, %f893, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1519) : "f"(f893));
  // PTX:1372 mul.f32 %f1520, %f894, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1520) : "f"(f894));
  // PTX:1373 mul.f32 %f1521, %f895, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1521) : "f"(f895));
  // PTX:1374 mul.f32 %f1522, %f896, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1522) : "f"(f896));
  // PTX:1375 add.s32 %r1789, %r1789, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r1789) : "r"(r1789));
  // PTX:1376 setp.lt.u32 %p106, %r1789, 8
  p106 = (((unsigned)(r1789)) < ((unsigned)(8)));
  // PTX:1377 @%p106 bra $L__BB7_99
  if (p106) { goto L_BB7_99; }
  // PTX:1379 $L__BB7_102:
L_BB7_102:;
  // PTX:1380 mul.f32 %f897, %f1515, %f1515
  asm("mul.f32 %0, %1, %2;" : "=f"(f897) : "f"(f1515), "f"(f1515));
  // PTX:1381 fma.rn.f32 %f898, %f1514, %f1514, %f897
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f898) : "f"(f1514), "f"(f1514), "f"(f897));
  // PTX:1382 fma.rn.f32 %f899, %f1516, %f1516, %f898
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f899) : "f"(f1516), "f"(f1516), "f"(f898));
  // PTX:1383 sqrt.rn.f32 %f183, %f899
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f183) : "f"(f899));
  // PTX:1384 setp.leu.f32 %p107, %f183, 0f00000000
  p107 = ((isnan(((float)(f183))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f183)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1385 mov.u32 %r1802, 0
  asm("mov.u32 %0, 0;" : "=r"(r1802) : );
  // PTX:1386 mov.u32 %r1790, %r1802
  asm("mov.u32 %0, %1;" : "=r"(r1790) : "r"(r1802));
  // PTX:1387 mov.u32 %r1791, %r1802
  asm("mov.u32 %0, %1;" : "=r"(r1791) : "r"(r1802));
  // PTX:1388 mov.u32 %r1792, %r1802
  asm("mov.u32 %0, %1;" : "=r"(r1792) : "r"(r1802));
  // PTX:1389 @%p107 bra $L__BB7_104
  if (p107) { goto L_BB7_104; }
  // PTX:1391 div.rn.f32 %f900, %f1514, %f183
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f900) : "f"(f1514), "f"(f183));
  // PTX:1392 div.rn.f32 %f901, %f1515, %f183
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f901) : "f"(f1515), "f"(f183));
  // PTX:1393 div.rn.f32 %f902, %f1516, %f183
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f902) : "f"(f1516), "f"(f183));
  // PTX:1394 mov.b32 %r1792, %f902
  asm("mov.b32 %0, %1;" : "=r"(r1792) : "f"(f902));
  // PTX:1395 mov.b32 %r1791, %f901
  asm("mov.b32 %0, %1;" : "=r"(r1791) : "f"(f901));
  // PTX:1396 mov.b32 %r1790, %f900
  asm("mov.b32 %0, %1;" : "=r"(r1790) : "f"(f900));
  // PTX:1398 $L__BB7_104:
L_BB7_104:;
  // PTX:1399 mov.b32 %f184, %r1790
  asm("mov.b32 %0, %1;" : "=f"(f184) : "r"(r1790));
  // PTX:1400 mov.b32 %f185, %r1791
  asm("mov.b32 %0, %1;" : "=f"(f185) : "r"(r1791));
  // PTX:1401 mul.f32 %f903, %f1518, %f185
  asm("mul.f32 %0, %1, %2;" : "=f"(f903) : "f"(f1518), "f"(f185));
  // PTX:1402 mov.b32 %f186, %r1792
  asm("mov.b32 %0, %1;" : "=f"(f186) : "r"(r1792));
  // PTX:1403 fma.rn.f32 %f904, %f1517, %f184, %f903
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f904) : "f"(f1517), "f"(f184), "f"(f903));
  // PTX:1404 fma.rn.f32 %f905, %f1519, %f186, %f904
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f905) : "f"(f1519), "f"(f186), "f"(f904));
  // PTX:1405 mul.f32 %f906, %f905, %f184
  asm("mul.f32 %0, %1, %2;" : "=f"(f906) : "f"(f905), "f"(f184));
  // PTX:1406 mul.f32 %f907, %f905, %f185
  asm("mul.f32 %0, %1, %2;" : "=f"(f907) : "f"(f905), "f"(f185));
  // PTX:1407 mul.f32 %f908, %f905, %f186
  asm("mul.f32 %0, %1, %2;" : "=f"(f908) : "f"(f905), "f"(f186));
  // PTX:1408 sub.f32 %f187, %f1517, %f906
  asm("sub.f32 %0, %1, %2;" : "=f"(f187) : "f"(f1517), "f"(f906));
  // PTX:1409 sub.f32 %f188, %f1518, %f907
  asm("sub.f32 %0, %1, %2;" : "=f"(f188) : "f"(f1518), "f"(f907));
  // PTX:1410 sub.f32 %f189, %f1519, %f908
  asm("sub.f32 %0, %1, %2;" : "=f"(f189) : "f"(f1519), "f"(f908));
  // PTX:1411 mul.f32 %f909, %f188, %f188
  asm("mul.f32 %0, %1, %2;" : "=f"(f909) : "f"(f188), "f"(f188));
  // PTX:1412 fma.rn.f32 %f910, %f187, %f187, %f909
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f910) : "f"(f187), "f"(f187), "f"(f909));
  // PTX:1413 fma.rn.f32 %f911, %f189, %f189, %f910
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f911) : "f"(f189), "f"(f189), "f"(f910));
  // PTX:1414 sqrt.rn.f32 %f190, %f911
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f190) : "f"(f911));
  // PTX:1415 setp.leu.f32 %p108, %f190, 0f00000000
  p108 = ((isnan(((float)(f190))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f190)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1416 mov.u32 %r1803, %r1802
  asm("mov.u32 %0, %1;" : "=r"(r1803) : "r"(r1802));
  // PTX:1417 mov.u32 %r1804, %r1802
  asm("mov.u32 %0, %1;" : "=r"(r1804) : "r"(r1802));
  // PTX:1418 @%p108 bra $L__BB7_106
  if (p108) { goto L_BB7_106; }
  // PTX:1420 div.rn.f32 %f912, %f187, %f190
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f912) : "f"(f187), "f"(f190));
  // PTX:1421 div.rn.f32 %f913, %f188, %f190
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f913) : "f"(f188), "f"(f190));
  // PTX:1422 div.rn.f32 %f914, %f189, %f190
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f914) : "f"(f189), "f"(f190));
  // PTX:1423 mov.b32 %r1804, %f914
  asm("mov.b32 %0, %1;" : "=r"(r1804) : "f"(f914));
  // PTX:1424 mov.b32 %r1803, %f913
  asm("mov.b32 %0, %1;" : "=r"(r1803) : "f"(f913));
  // PTX:1425 mov.b32 %r1802, %f912
  asm("mov.b32 %0, %1;" : "=r"(r1802) : "f"(f912));
  // PTX:1427 $L__BB7_106:
L_BB7_106:;
  // PTX:1428 mov.b32 %f1472, %r1792
  asm("mov.b32 %0, %1;" : "=f"(f1472) : "r"(r1792));
  // PTX:1429 mov.b32 %f1471, %r1790
  asm("mov.b32 %0, %1;" : "=f"(f1471) : "r"(r1790));
  // PTX:1430 mov.b32 %f1470, %r1791
  asm("mov.b32 %0, %1;" : "=f"(f1470) : "r"(r1791));
  // PTX:1431 mov.u32 %r1805, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r1805) : );
  // PTX:1432 mul.f32 %f915, %f1470, %f1470
  asm("mul.f32 %0, %1, %2;" : "=f"(f915) : "f"(f1470), "f"(f1470));
  // PTX:1433 fma.rn.f32 %f916, %f1471, %f1471, %f915
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f916) : "f"(f1471), "f"(f1471), "f"(f915));
  // PTX:1434 fma.rn.f32 %f917, %f1472, %f1472, %f916
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f917) : "f"(f1472), "f"(f1472), "f"(f916));
  // PTX:1435 sqrt.rn.f32 %f918, %f917
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f918) : "f"(f917));
  // PTX:1436 setp.le.f32 %p109, %f918, 0f322BCC77
  p109 = (!(isnan(((float)(f918))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f918)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1437 mov.u32 %r1806, 0
  asm("mov.u32 %0, 0;" : "=r"(r1806) : );
  // PTX:1438 mov.u32 %r1807, %r1806
  asm("mov.u32 %0, %1;" : "=r"(r1807) : "r"(r1806));
  // PTX:1439 mov.u32 %r1808, %r1806
  asm("mov.u32 %0, %1;" : "=r"(r1808) : "r"(r1806));
  // PTX:1440 mov.u32 %r1809, %r1805
  asm("mov.u32 %0, %1;" : "=r"(r1809) : "r"(r1805));
  // PTX:1441 mov.u32 %r1810, %r1806
  asm("mov.u32 %0, %1;" : "=r"(r1810) : "r"(r1806));
  // PTX:1442 mov.u32 %r1811, %r1806
  asm("mov.u32 %0, %1;" : "=r"(r1811) : "r"(r1806));
  // PTX:1443 mov.u32 %r1812, %r1806
  asm("mov.u32 %0, %1;" : "=r"(r1812) : "r"(r1806));
  // PTX:1444 mov.u32 %r1813, %r1805
  asm("mov.u32 %0, %1;" : "=r"(r1813) : "r"(r1805));
  // PTX:1445 @%p109 bra $L__BB7_113
  if (p109) { goto L_BB7_113; }
  // PTX:1447 mov.u32 %r1805, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r1805) : );
  // PTX:1448 mov.b32 %f191, %r1802
  asm("mov.b32 %0, %1;" : "=f"(f191) : "r"(r1802));
  // PTX:1449 mov.b32 %f192, %r1803
  asm("mov.b32 %0, %1;" : "=f"(f192) : "r"(r1803));
  // PTX:1450 mul.f32 %f919, %f192, %f192
  asm("mul.f32 %0, %1, %2;" : "=f"(f919) : "f"(f192), "f"(f192));
  // PTX:1451 mov.b32 %f193, %r1804
  asm("mov.b32 %0, %1;" : "=f"(f193) : "r"(r1804));
  // PTX:1452 fma.rn.f32 %f920, %f191, %f191, %f919
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f920) : "f"(f191), "f"(f191), "f"(f919));
  // PTX:1453 fma.rn.f32 %f921, %f193, %f193, %f920
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f921) : "f"(f193), "f"(f193), "f"(f920));
  // PTX:1454 sqrt.rn.f32 %f922, %f921
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f922) : "f"(f921));
  // PTX:1455 setp.le.f32 %p110, %f922, 0f322BCC77
  p110 = (!(isnan(((float)(f922))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f922)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1456 @%p110 bra $L__BB7_113
  if (p110) { goto L_BB7_113; }
  // PTX:1458 mov.b32 %f1475, %r1792
  asm("mov.b32 %0, %1;" : "=f"(f1475) : "r"(r1792));
  // PTX:1459 mov.b32 %f1474, %r1790
  asm("mov.b32 %0, %1;" : "=f"(f1474) : "r"(r1790));
  // PTX:1460 mov.b32 %f1473, %r1791
  asm("mov.b32 %0, %1;" : "=f"(f1473) : "r"(r1791));
  // PTX:1461 mul.f32 %f923, %f1473, %f193
  asm("mul.f32 %0, %1, %2;" : "=f"(f923) : "f"(f1473), "f"(f193));
  // PTX:1462 mul.f32 %f924, %f1475, %f192
  asm("mul.f32 %0, %1, %2;" : "=f"(f924) : "f"(f1475), "f"(f192));
  // PTX:1463 sub.f32 %f194, %f923, %f924
  asm("sub.f32 %0, %1, %2;" : "=f"(f194) : "f"(f923), "f"(f924));
  // PTX:1464 mul.f32 %f925, %f1474, %f193
  asm("mul.f32 %0, %1, %2;" : "=f"(f925) : "f"(f1474), "f"(f193));
  // PTX:1465 mul.f32 %f926, %f1475, %f191
  asm("mul.f32 %0, %1, %2;" : "=f"(f926) : "f"(f1475), "f"(f191));
  // PTX:1466 sub.f32 %f195, %f926, %f925
  asm("sub.f32 %0, %1, %2;" : "=f"(f195) : "f"(f926), "f"(f925));
  // PTX:1467 mul.f32 %f927, %f1473, %f191
  asm("mul.f32 %0, %1, %2;" : "=f"(f927) : "f"(f1473), "f"(f191));
  // PTX:1468 mul.f32 %f928, %f1474, %f192
  asm("mul.f32 %0, %1, %2;" : "=f"(f928) : "f"(f1474), "f"(f192));
  // PTX:1469 sub.f32 %f196, %f928, %f927
  asm("sub.f32 %0, %1, %2;" : "=f"(f196) : "f"(f928), "f"(f927));
  // PTX:1470 mul.f32 %f929, %f195, %f195
  asm("mul.f32 %0, %1, %2;" : "=f"(f929) : "f"(f195), "f"(f195));
  // PTX:1471 fma.rn.f32 %f930, %f194, %f194, %f929
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f930) : "f"(f194), "f"(f194), "f"(f929));
  // PTX:1472 fma.rn.f32 %f931, %f196, %f196, %f930
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f931) : "f"(f196), "f"(f196), "f"(f930));
  // PTX:1473 sqrt.rn.f32 %f197, %f931
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f197) : "f"(f931));
  // PTX:1474 setp.leu.f32 %p111, %f197, 0f00000000
  p111 = ((isnan(((float)(f197))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f197)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1475 mov.u32 %r1811, 0
  asm("mov.u32 %0, 0;" : "=r"(r1811) : );
  // PTX:1476 mov.u32 %r1812, %r1811
  asm("mov.u32 %0, %1;" : "=r"(r1812) : "r"(r1811));
  // PTX:1477 mov.u32 %r1813, %r1811
  asm("mov.u32 %0, %1;" : "=r"(r1813) : "r"(r1811));
  // PTX:1478 @%p111 bra $L__BB7_110
  if (p111) { goto L_BB7_110; }
  // PTX:1480 div.rn.f32 %f932, %f194, %f197
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f932) : "f"(f194), "f"(f197));
  // PTX:1481 div.rn.f32 %f933, %f195, %f197
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f933) : "f"(f195), "f"(f197));
  // PTX:1482 div.rn.f32 %f934, %f196, %f197
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f934) : "f"(f196), "f"(f197));
  // PTX:1483 mov.b32 %r1813, %f934
  asm("mov.b32 %0, %1;" : "=r"(r1813) : "f"(f934));
  // PTX:1484 mov.b32 %r1812, %f933
  asm("mov.b32 %0, %1;" : "=r"(r1812) : "f"(f933));
  // PTX:1485 mov.b32 %r1811, %f932
  asm("mov.b32 %0, %1;" : "=r"(r1811) : "f"(f932));
  // PTX:1487 $L__BB7_110:
L_BB7_110:;
  // PTX:1488 mov.b32 %f198, %r1811
  asm("mov.b32 %0, %1;" : "=f"(f198) : "r"(r1811));
  // PTX:1489 mov.b32 %f199, %r1812
  asm("mov.b32 %0, %1;" : "=f"(f199) : "r"(r1812));
  // PTX:1490 mul.f32 %f935, %f1521, %f199
  asm("mul.f32 %0, %1, %2;" : "=f"(f935) : "f"(f1521), "f"(f199));
  // PTX:1491 mov.b32 %f200, %r1813
  asm("mov.b32 %0, %1;" : "=f"(f200) : "r"(r1813));
  // PTX:1492 fma.rn.f32 %f936, %f1520, %f198, %f935
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f936) : "f"(f1520), "f"(f198), "f"(f935));
  // PTX:1493 fma.rn.f32 %f937, %f1522, %f200, %f936
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f937) : "f"(f1522), "f"(f200), "f"(f936));
  // PTX:1494 setp.geu.f32 %p112, %f937, 0f00000000
  p112 = ((isnan(((float)(f937))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f937)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:1495 @%p112 bra $L__BB7_112
  if (p112) { goto L_BB7_112; }
  // PTX:1497 mov.b32 %f1478, %r1802
  asm("mov.b32 %0, %1;" : "=f"(f1478) : "r"(r1802));
  // PTX:1498 mov.b32 %f1477, %r1803
  asm("mov.b32 %0, %1;" : "=f"(f1477) : "r"(r1803));
  // PTX:1499 mov.b32 %f1476, %r1804
  asm("mov.b32 %0, %1;" : "=f"(f1476) : "r"(r1804));
  // PTX:1500 neg.f32 %f938, %f1478
  asm("neg.f32 %0, %1;" : "=f"(f938) : "f"(f1478));
  // PTX:1501 mov.b32 %r1802, %f938
  asm("mov.b32 %0, %1;" : "=r"(r1802) : "f"(f938));
  // PTX:1502 neg.f32 %f939, %f1477
  asm("neg.f32 %0, %1;" : "=f"(f939) : "f"(f1477));
  // PTX:1503 mov.b32 %r1803, %f939
  asm("mov.b32 %0, %1;" : "=r"(r1803) : "f"(f939));
  // PTX:1504 neg.f32 %f940, %f1476
  asm("neg.f32 %0, %1;" : "=f"(f940) : "f"(f1476));
  // PTX:1505 mov.b32 %r1804, %f940
  asm("mov.b32 %0, %1;" : "=r"(r1804) : "f"(f940));
  // PTX:1506 neg.f32 %f941, %f198
  asm("neg.f32 %0, %1;" : "=f"(f941) : "f"(f198));
  // PTX:1507 mov.b32 %r1811, %f941
  asm("mov.b32 %0, %1;" : "=r"(r1811) : "f"(f941));
  // PTX:1508 neg.f32 %f942, %f199
  asm("neg.f32 %0, %1;" : "=f"(f942) : "f"(f199));
  // PTX:1509 mov.b32 %r1812, %f942
  asm("mov.b32 %0, %1;" : "=r"(r1812) : "f"(f942));
  // PTX:1510 neg.f32 %f943, %f200
  asm("neg.f32 %0, %1;" : "=f"(f943) : "f"(f200));
  // PTX:1511 mov.b32 %r1813, %f943
  asm("mov.b32 %0, %1;" : "=r"(r1813) : "f"(f943));
  // PTX:1513 $L__BB7_112:
L_BB7_112:;
  // PTX:1514 mov.u32 %r1805, %r1790
  asm("mov.u32 %0, %1;" : "=r"(r1805) : "r"(r1790));
  // PTX:1515 mov.u32 %r1806, %r1791
  asm("mov.u32 %0, %1;" : "=r"(r1806) : "r"(r1791));
  // PTX:1516 mov.u32 %r1807, %r1792
  asm("mov.u32 %0, %1;" : "=r"(r1807) : "r"(r1792));
  // PTX:1517 mov.u32 %r1808, %r1802
  asm("mov.u32 %0, %1;" : "=r"(r1808) : "r"(r1802));
  // PTX:1518 mov.u32 %r1809, %r1803
  asm("mov.u32 %0, %1;" : "=r"(r1809) : "r"(r1803));
  // PTX:1519 mov.u32 %r1810, %r1804
  asm("mov.u32 %0, %1;" : "=r"(r1810) : "r"(r1804));
  // PTX:1521 $L__BB7_113:
L_BB7_113:;
  // PTX:1522 mov.b32 %f944, %r1805
  asm("mov.b32 %0, %1;" : "=f"(f944) : "r"(r1805));
  // PTX:1523 mov.b32 %f945, %r1808
  asm("mov.b32 %0, %1;" : "=f"(f945) : "r"(r1808));
  // PTX:1524 mov.b32 %f946, %r1811
  asm("mov.b32 %0, %1;" : "=f"(f946) : "r"(r1811));
  // PTX:1525 mov.b32 %f947, %r1806
  asm("mov.b32 %0, %1;" : "=f"(f947) : "r"(r1806));
  // PTX:1526 mul.f32 %f948, %f1528, %f947
  asm("mul.f32 %0, %1, %2;" : "=f"(f948) : "f"(f1528), "f"(f947));
  // PTX:1527 mov.b32 %f949, %r1809
  asm("mov.b32 %0, %1;" : "=f"(f949) : "r"(r1809));
  // PTX:1528 mul.f32 %f950, %f1528, %f949
  asm("mul.f32 %0, %1, %2;" : "=f"(f950) : "f"(f1528), "f"(f949));
  // PTX:1529 mov.b32 %f951, %r1812
  asm("mov.b32 %0, %1;" : "=f"(f951) : "r"(r1812));
  // PTX:1530 mul.f32 %f952, %f1528, %f951
  asm("mul.f32 %0, %1, %2;" : "=f"(f952) : "f"(f1528), "f"(f951));
  // PTX:1531 fma.rn.f32 %f953, %f1530, %f944, %f948
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f953) : "f"(f1530), "f"(f944), "f"(f948));
  // PTX:1532 fma.rn.f32 %f954, %f1530, %f945, %f950
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f954) : "f"(f1530), "f"(f945), "f"(f950));
  // PTX:1533 fma.rn.f32 %f955, %f1530, %f946, %f952
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f955) : "f"(f1530), "f"(f946), "f"(f952));
  // PTX:1534 mov.b32 %f956, %r1807
  asm("mov.b32 %0, %1;" : "=f"(f956) : "r"(r1807));
  // PTX:1535 mov.b32 %f957, %r1810
  asm("mov.b32 %0, %1;" : "=f"(f957) : "r"(r1810));
  // PTX:1536 mov.b32 %f958, %r1813
  asm("mov.b32 %0, %1;" : "=f"(f958) : "r"(r1813));
  // PTX:1537 fma.rn.f32 %f1523, %f1526, %f956, %f953
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1523) : "f"(f1526), "f"(f956), "f"(f953));
  // PTX:1538 fma.rn.f32 %f1524, %f1526, %f957, %f954
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1524) : "f"(f1526), "f"(f957), "f"(f954));
  // PTX:1539 fma.rn.f32 %f1525, %f1526, %f958, %f955
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1525) : "f"(f1526), "f"(f958), "f"(f955));
  // PTX:1540 bra.uni $L__BB7_114
  goto L_BB7_114;
  // PTX:1542 $L__BB7_88:
L_BB7_88:;
  // PTX:1543 mov.b32 %f1533, %r1777
  asm("mov.b32 %0, %1;" : "=f"(f1533) : "r"(r1777));
  // PTX:1544 mov.b32 %f1532, %r1778
  asm("mov.b32 %0, %1;" : "=f"(f1532) : "r"(r1778));
  // PTX:1545 mov.b32 %f1531, %r1779
  asm("mov.b32 %0, %1;" : "=f"(f1531) : "r"(r1779));
  // PTX:1546 mov.u32 %r1826, %r1823
  asm("mov.u32 %0, %1;" : "=r"(r1826) : "r"(r1823));
  // PTX:1547 mov.u32 %r1827, %r1824
  asm("mov.u32 %0, %1;" : "=r"(r1827) : "r"(r1824));
  // PTX:1548 mov.u32 %r1828, %r1825
  asm("mov.u32 %0, %1;" : "=r"(r1828) : "r"(r1825));
  // PTX:1549 bra.uni $L__BB7_117
  goto L_BB7_117;
  // PTX:1551 $L__BB7_115:
L_BB7_115:;
  // PTX:1552 mul.f32 %f1530, %f109, %f1533
  asm("mul.f32 %0, %1, %2;" : "=f"(f1530) : "f"(f109), "f"(f1533));
  // PTX:1553 mov.b32 %f1532, %r135
  asm("mov.b32 %0, %1;" : "=f"(f1532) : "r"(r135));
  // PTX:1554 mul.f32 %f1528, %f109, %f1532
  asm("mul.f32 %0, %1, %2;" : "=f"(f1528) : "f"(f109), "f"(f1532));
  // PTX:1555 mov.b32 %f1531, %r134
  asm("mov.b32 %0, %1;" : "=f"(f1531) : "r"(r134));
  // PTX:1556 mul.f32 %f1526, %f109, %f1531
  asm("mul.f32 %0, %1, %2;" : "=f"(f1526) : "f"(f109), "f"(f1531));
  // PTX:1557 mov.b32 %f971, %r1826
  asm("mov.b32 %0, %1;" : "=f"(f971) : "r"(r1826));
  // PTX:1558 add.f32 %f972, %f1530, %f971
  asm("add.f32 %0, %1, %2;" : "=f"(f972) : "f"(f1530), "f"(f971));
  // PTX:1559 mov.b32 %f973, %r1827
  asm("mov.b32 %0, %1;" : "=f"(f973) : "r"(r1827));
  // PTX:1560 add.f32 %f974, %f1528, %f973
  asm("add.f32 %0, %1, %2;" : "=f"(f974) : "f"(f1528), "f"(f973));
  // PTX:1561 mov.b32 %f975, %r1828
  asm("mov.b32 %0, %1;" : "=f"(f975) : "r"(r1828));
  // PTX:1562 add.f32 %f976, %f1526, %f975
  asm("add.f32 %0, %1, %2;" : "=f"(f976) : "f"(f1526), "f"(f975));
  // PTX:1563 mov.b32 %r1823, %f972
  asm("mov.b32 %0, %1;" : "=r"(r1823) : "f"(f972));
  // PTX:1564 mov.b32 %r1825, %f976
  asm("mov.b32 %0, %1;" : "=r"(r1825) : "f"(f976));
  // PTX:1565 mov.b32 %r1824, %f974
  asm("mov.b32 %0, %1;" : "=r"(r1824) : "f"(f974));
  // PTX:1566 bra.uni $L__BB7_116
  goto L_BB7_116;
  // PTX:1568 $L__BB7_95:
L_BB7_95:;
  // PTX:1569 rcp.rn.f32 %f772, %f128
  asm("rcp.rn.f32 %0, %1;" : "=f"(f772) : "f"(f128));
  // PTX:1570 mul.f32 %f773, %f126, %f116
  asm("mul.f32 %0, %1, %2;" : "=f"(f773) : "f"(f126), "f"(f116));
  // PTX:1571 mul.f32 %f774, %f127, %f118
  asm("mul.f32 %0, %1, %2;" : "=f"(f774) : "f"(f127), "f"(f118));
  // PTX:1572 sub.f32 %f775, %f774, %f773
  asm("sub.f32 %0, %1, %2;" : "=f"(f775) : "f"(f774), "f"(f773));
  // PTX:1573 mul.f32 %f776, %f127, %f121
  asm("mul.f32 %0, %1, %2;" : "=f"(f776) : "f"(f127), "f"(f121));
  // PTX:1574 mul.f32 %f777, %f125, %f116
  asm("mul.f32 %0, %1, %2;" : "=f"(f777) : "f"(f125), "f"(f116));
  // PTX:1575 sub.f32 %f778, %f777, %f776
  asm("sub.f32 %0, %1, %2;" : "=f"(f778) : "f"(f777), "f"(f776));
  // PTX:1576 mul.f32 %f779, %f125, %f118
  asm("mul.f32 %0, %1, %2;" : "=f"(f779) : "f"(f125), "f"(f118));
  // PTX:1577 mul.f32 %f780, %f126, %f121
  asm("mul.f32 %0, %1, %2;" : "=f"(f780) : "f"(f126), "f"(f121));
  // PTX:1578 sub.f32 %f781, %f780, %f779
  asm("sub.f32 %0, %1, %2;" : "=f"(f781) : "f"(f780), "f"(f779));
  // PTX:1579 mul.f32 %f782, %f127, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f782) : "f"(f127), "f"(f117));
  // PTX:1580 mul.f32 %f783, %f126, %f119
  asm("mul.f32 %0, %1, %2;" : "=f"(f783) : "f"(f126), "f"(f119));
  // PTX:1581 sub.f32 %f784, %f783, %f782
  asm("sub.f32 %0, %1, %2;" : "=f"(f784) : "f"(f783), "f"(f782));
  // PTX:1582 mul.f32 %f785, %f125, %f119
  asm("mul.f32 %0, %1, %2;" : "=f"(f785) : "f"(f125), "f"(f119));
  // PTX:1583 mul.f32 %f786, %f127, %f122
  asm("mul.f32 %0, %1, %2;" : "=f"(f786) : "f"(f127), "f"(f122));
  // PTX:1584 sub.f32 %f787, %f786, %f785
  asm("sub.f32 %0, %1, %2;" : "=f"(f787) : "f"(f786), "f"(f785));
  // PTX:1585 mul.f32 %f788, %f126, %f122
  asm("mul.f32 %0, %1, %2;" : "=f"(f788) : "f"(f126), "f"(f122));
  // PTX:1586 mul.f32 %f789, %f125, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f789) : "f"(f125), "f"(f117));
  // PTX:1587 sub.f32 %f790, %f789, %f788
  asm("sub.f32 %0, %1, %2;" : "=f"(f790) : "f"(f789), "f"(f788));
  // PTX:1588 mul.f32 %f791, %f120, %f772
  asm("mul.f32 %0, %1, %2;" : "=f"(f791) : "f"(f120), "f"(f772));
  // PTX:1589 mul.f32 %f792, %f123, %f772
  asm("mul.f32 %0, %1, %2;" : "=f"(f792) : "f"(f123), "f"(f772));
  // PTX:1590 mul.f32 %f793, %f124, %f772
  asm("mul.f32 %0, %1, %2;" : "=f"(f793) : "f"(f124), "f"(f772));
  // PTX:1591 mul.f32 %f794, %f775, %f772
  asm("mul.f32 %0, %1, %2;" : "=f"(f794) : "f"(f775), "f"(f772));
  // PTX:1592 mul.f32 %f795, %f778, %f772
  asm("mul.f32 %0, %1, %2;" : "=f"(f795) : "f"(f778), "f"(f772));
  // PTX:1593 mul.f32 %f796, %f781, %f772
  asm("mul.f32 %0, %1, %2;" : "=f"(f796) : "f"(f781), "f"(f772));
  // PTX:1594 mul.f32 %f797, %f784, %f772
  asm("mul.f32 %0, %1, %2;" : "=f"(f797) : "f"(f784), "f"(f772));
  // PTX:1595 mul.f32 %f798, %f787, %f772
  asm("mul.f32 %0, %1, %2;" : "=f"(f798) : "f"(f787), "f"(f772));
  // PTX:1596 mul.f32 %f799, %f790, %f772
  asm("mul.f32 %0, %1, %2;" : "=f"(f799) : "f"(f790), "f"(f772));
  // PTX:1597 mul.f32 %f800, %f1528, %f792
  asm("mul.f32 %0, %1, %2;" : "=f"(f800) : "f"(f1528), "f"(f792));
  // PTX:1598 mul.f32 %f801, %f1528, %f795
  asm("mul.f32 %0, %1, %2;" : "=f"(f801) : "f"(f1528), "f"(f795));
  // PTX:1599 mul.f32 %f802, %f1528, %f798
  asm("mul.f32 %0, %1, %2;" : "=f"(f802) : "f"(f1528), "f"(f798));
  // PTX:1600 fma.rn.f32 %f803, %f1530, %f791, %f800
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f803) : "f"(f1530), "f"(f791), "f"(f800));
  // PTX:1601 fma.rn.f32 %f804, %f1530, %f794, %f801
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f804) : "f"(f1530), "f"(f794), "f"(f801));
  // PTX:1602 fma.rn.f32 %f805, %f1530, %f797, %f802
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f805) : "f"(f1530), "f"(f797), "f"(f802));
  // PTX:1603 fma.rn.f32 %f1523, %f1526, %f793, %f803
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1523) : "f"(f1526), "f"(f793), "f"(f803));
  // PTX:1604 fma.rn.f32 %f1524, %f1526, %f796, %f804
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1524) : "f"(f1526), "f"(f796), "f"(f804));
  // PTX:1605 fma.rn.f32 %f1525, %f1526, %f799, %f805
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1525) : "f"(f1526), "f"(f799), "f"(f805));
  // PTX:1607 $L__BB7_114:
L_BB7_114:;
  // PTX:1608 mov.b32 %f963, %r1826
  asm("mov.b32 %0, %1;" : "=f"(f963) : "r"(r1826));
  // PTX:1609 add.f32 %f964, %f963, %f1523
  asm("add.f32 %0, %1, %2;" : "=f"(f964) : "f"(f963), "f"(f1523));
  // PTX:1610 mov.b32 %f966, %r1827
  asm("mov.b32 %0, %1;" : "=f"(f966) : "r"(r1827));
  // PTX:1611 add.f32 %f967, %f966, %f1524
  asm("add.f32 %0, %1, %2;" : "=f"(f967) : "f"(f966), "f"(f1524));
  // PTX:1612 mov.b32 %f969, %r1828
  asm("mov.b32 %0, %1;" : "=f"(f969) : "r"(r1828));
  // PTX:1613 add.f32 %f970, %f969, %f1525
  asm("add.f32 %0, %1, %2;" : "=f"(f970) : "f"(f969), "f"(f1525));
  // PTX:1614 mov.b32 %r1823, %f964
  asm("mov.b32 %0, %1;" : "=r"(r1823) : "f"(f964));
  // PTX:1615 mov.b32 %r1824, %f967
  asm("mov.b32 %0, %1;" : "=r"(r1824) : "f"(f967));
  // PTX:1616 mov.b32 %r1825, %f970
  asm("mov.b32 %0, %1;" : "=r"(r1825) : "f"(f970));
  // PTX:1618 $L__BB7_116:
L_BB7_116:;
  // PTX:1619 add.f32 %f977, %f1530, %f102
  asm("add.f32 %0, %1, %2;" : "=f"(f977) : "f"(f1530), "f"(f102));
  // PTX:1620 mov.b32 %r1820, %f977
  asm("mov.b32 %0, %1;" : "=r"(r1820) : "f"(f977));
  // PTX:1621 add.f32 %f978, %f1528, %f104
  asm("add.f32 %0, %1, %2;" : "=f"(f978) : "f"(f1528), "f"(f104));
  // PTX:1622 mov.b32 %r1821, %f978
  asm("mov.b32 %0, %1;" : "=r"(r1821) : "f"(f978));
  // PTX:1623 add.f32 %f979, %f1526, %f106
  asm("add.f32 %0, %1, %2;" : "=f"(f979) : "f"(f1526), "f"(f106));
  // PTX:1624 mov.b32 %r1822, %f979
  asm("mov.b32 %0, %1;" : "=r"(r1822) : "f"(f979));
  // PTX:1626 $L__BB7_117:
L_BB7_117:;
  // PTX:1627 mul.f32 %f214, %f1532, %f1532
  asm("mul.f32 %0, %1, %2;" : "=f"(f214) : "f"(f1532), "f"(f1532));
  // PTX:1628 mul.f32 %f215, %f1533, %f1533
  asm("mul.f32 %0, %1, %2;" : "=f"(f215) : "f"(f1533), "f"(f1533));
  // PTX:1629 add.f32 %f995, %f214, %f215
  asm("add.f32 %0, %1, %2;" : "=f"(f995) : "f"(f214), "f"(f215));
  // PTX:1630 mul.f32 %f216, %f1531, %f1531
  asm("mul.f32 %0, %1, %2;" : "=f"(f216) : "f"(f1531), "f"(f1531));
  // PTX:1631 add.f32 %f996, %f216, %f995
  asm("add.f32 %0, %1, %2;" : "=f"(f996) : "f"(f216), "f"(f995));
  // PTX:1632 setp.ltu.f32 %p113, %f996, 0f3F000000
  p113 = ((isnan(((float)(f996))) || isnan(((float)(as_f32(0x3F000000u))))) || (((float)(f996)) < ((float)(as_f32(0x3F000000u)))));
  // PTX:1633 mov.u32 %r1835, 0
  asm("mov.u32 %0, 0;" : "=r"(r1835) : );
  // PTX:1634 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:1635 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:1636 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:1637 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:1638 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:1639 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:1640 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:1641 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:1642 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:1643 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:1644 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:1645 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:1646 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:1647 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:1648 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:1649 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:1650 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:1651 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:1652 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:1653 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:1654 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:1655 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:1656 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:1657 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:1658 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:1659 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:1660 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:1661 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:1662 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:1663 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:1664 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:1665 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:1666 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:1667 @%p113 bra $L__BB7_164
  if (p113) { goto L_BB7_164; }
  // PTX:1669 add.s64 %rd259, %rd39, %rd140
  asm("add.s64 %0, %1, %2;" : "=l"(rd259) : "l"(rd39), "l"(rd140));
  // PTX:1670 ld.global.u32 %r1831, [%rd259]
  r1831 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd259) + (0)))));
  // PTX:1671 ld.global.u32 %r1830, [%rd259+4]
  r1830 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd259) + (4)))));
  // PTX:1672 ld.global.u32 %r1829, [%rd259+8]
  r1829 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd259) + (8)))));
  // PTX:1673 mov.u32 %r1832, %r1829
  asm("mov.u32 %0, %1;" : "=r"(r1832) : "r"(r1829));
  // PTX:1674 mov.u32 %r1833, %r1830
  asm("mov.u32 %0, %1;" : "=r"(r1833) : "r"(r1830));
  // PTX:1675 mov.u32 %r1834, %r1831
  asm("mov.u32 %0, %1;" : "=r"(r1834) : "r"(r1831));
  // PTX:1676 @%p82 bra $L__BB7_144
  if (p82) { goto L_BB7_144; }
  // PTX:1678 setp.eq.s64 %p115, %rd24, 0
  p115 = (((long long)(rd24)) == ((long long)(0)));
  // PTX:1679 mul.wide.s32 %rd260, %r1772, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd260) : "r"(r1772));
  // PTX:1680 add.s64 %rd92, %rd37, %rd260
  asm("add.s64 %0, %1, %2;" : "=l"(rd92) : "l"(rd37), "l"(rd260));
  // PTX:1681 ld.global.f32 %f997, [%rd92]
  f997 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0)))));
  // PTX:1682 mov.b32 %f998, %r1826
  asm("mov.b32 %0, %1;" : "=f"(f998) : "r"(r1826));
  // PTX:1683 sub.f32 %f999, %f998, %f997
  asm("sub.f32 %0, %1, %2;" : "=f"(f999) : "f"(f998), "f"(f997));
  // PTX:1684 ld.global.f32 %f1000, [%rd92+4]
  f1000 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (4)))));
  // PTX:1685 mov.b32 %f1001, %r1827
  asm("mov.b32 %0, %1;" : "=f"(f1001) : "r"(r1827));
  // PTX:1686 sub.f32 %f1002, %f1001, %f1000
  asm("sub.f32 %0, %1, %2;" : "=f"(f1002) : "f"(f1001), "f"(f1000));
  // PTX:1687 ld.global.f32 %f1003, [%rd92+8]
  f1003 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (8)))));
  // PTX:1688 mov.b32 %f1004, %r1828
  asm("mov.b32 %0, %1;" : "=f"(f1004) : "r"(r1828));
  // PTX:1689 sub.f32 %f1005, %f1004, %f1003
  asm("sub.f32 %0, %1, %2;" : "=f"(f1005) : "f"(f1004), "f"(f1003));
  // PTX:1690 mov.b32 %f217, %r1823
  asm("mov.b32 %0, %1;" : "=f"(f217) : "r"(r1823));
  // PTX:1691 sub.f32 %f1006, %f217, %f997
  asm("sub.f32 %0, %1, %2;" : "=f"(f1006) : "f"(f217), "f"(f997));
  // PTX:1692 mov.b32 %f218, %r1824
  asm("mov.b32 %0, %1;" : "=f"(f218) : "r"(r1824));
  // PTX:1693 sub.f32 %f1007, %f218, %f1000
  asm("sub.f32 %0, %1, %2;" : "=f"(f1007) : "f"(f218), "f"(f1000));
  // PTX:1694 mov.b32 %f219, %r1825
  asm("mov.b32 %0, %1;" : "=f"(f219) : "r"(r1825));
  // PTX:1695 sub.f32 %f1008, %f219, %f1003
  asm("sub.f32 %0, %1, %2;" : "=f"(f1008) : "f"(f219), "f"(f1003));
  // PTX:1696 mul.wide.s32 %rd261, %r88, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd261) : "r"(r88));
  // PTX:1697 add.s64 %rd262, %rd2, %rd261
  asm("add.s64 %0, %1, %2;" : "=l"(rd262) : "l"(rd2), "l"(rd261));
  // PTX:1698 st.local.u32 [%rd262], %r1776
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd262) + (0))))) = (unsigned)(r1776);
  // PTX:1699 ld.local.u32 %r1215, [%rd2+56]
  r1215 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:1700 add.s32 %r1216, %r1215, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r1216) : "r"(r1215));
  // PTX:1701 st.local.u32 [%rd2+56], %r1216
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56))))) = (unsigned)(r1216);
  // PTX:1702 add.s64 %rd263, %rd2, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd263) : "l"(rd2));
  // PTX:1703 mul.wide.s32 %rd264, %r1215, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd264) : "r"(r1215));
  // PTX:1704 add.s64 %rd265, %rd263, %rd264
  asm("add.s64 %0, %1, %2;" : "=l"(rd265) : "l"(rd263), "l"(rd264));
  // PTX:1705 mov.u32 %r1217, -1082130432
  asm("mov.u32 %0, -1082130432;" : "=r"(r1217) : );
  // PTX:1706 st.local.u32 [%rd265], %r1217
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd265) + (0))))) = (unsigned)(r1217);
  // PTX:1707 ld.local.u32 %r1218, [%rd2+116]
  r1218 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:1708 add.s64 %rd266, %rd2, 60
  asm("add.s64 %0, %1, 60;" : "=l"(rd266) : "l"(rd2));
  // PTX:1709 mul.wide.s32 %rd267, %r1218, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd267) : "r"(r1218));
  // PTX:1710 add.s64 %rd268, %rd266, %rd267
  asm("add.s64 %0, %1, %2;" : "=l"(rd268) : "l"(rd266), "l"(rd267));
  // PTX:1711 st.local.u32 [%rd268], %r1776
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd268) + (0))))) = (unsigned)(r1776);
  // PTX:1712 ld.local.u32 %r1219, [%rd2+116]
  r1219 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:1713 add.s32 %r1220, %r1219, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r1220) : "r"(r1219));
  // PTX:1714 st.local.u32 [%rd2+116], %r1220
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116))))) = (unsigned)(r1220);
  // PTX:1715 add.s64 %rd269, %rd2, 88
  asm("add.s64 %0, %1, 88;" : "=l"(rd269) : "l"(rd2));
  // PTX:1716 mul.wide.s32 %rd270, %r1219, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd270) : "r"(r1219));
  // PTX:1717 add.s64 %rd271, %rd269, %rd270
  asm("add.s64 %0, %1, %2;" : "=l"(rd271) : "l"(rd269), "l"(rd270));
  // PTX:1718 st.local.u32 [%rd271], %r1217
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd271) + (0))))) = (unsigned)(r1217);
  // PTX:1719 ld.local.u32 %r1221, [%rd2+56]
  r1221 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:1720 mul.wide.s32 %rd272, %r1221, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd272) : "r"(r1221));
  // PTX:1721 add.s64 %rd273, %rd2, %rd272
  asm("add.s64 %0, %1, %2;" : "=l"(rd273) : "l"(rd2), "l"(rd272));
  // PTX:1722 st.local.u32 [%rd273], %r1775
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd273) + (0))))) = (unsigned)(r1775);
  // PTX:1723 neg.f32 %f1009, %f999
  asm("neg.f32 %0, %1;" : "=f"(f1009) : "f"(f999));
  // PTX:1724 ld.local.u32 %r1222, [%rd2+56]
  r1222 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:1725 add.s32 %r1223, %r1222, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r1223) : "r"(r1222));
  // PTX:1726 st.local.u32 [%rd2+56], %r1223
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56))))) = (unsigned)(r1223);
  // PTX:1727 mul.wide.s32 %rd274, %r1222, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd274) : "r"(r1222));
  // PTX:1728 add.s64 %rd275, %rd263, %rd274
  asm("add.s64 %0, %1, %2;" : "=l"(rd275) : "l"(rd263), "l"(rd274));
  // PTX:1729 st.local.f32 [%rd275], %f1009
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd275) + (0))))) = (float)(f1009);
  // PTX:1730 ld.local.u32 %r1224, [%rd2+116]
  r1224 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:1731 mul.wide.s32 %rd276, %r1224, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd276) : "r"(r1224));
  // PTX:1732 add.s64 %rd277, %rd266, %rd276
  asm("add.s64 %0, %1, %2;" : "=l"(rd277) : "l"(rd266), "l"(rd276));
  // PTX:1733 st.local.u32 [%rd277], %r1775
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd277) + (0))))) = (unsigned)(r1775);
  // PTX:1734 neg.f32 %f1010, %f1006
  asm("neg.f32 %0, %1;" : "=f"(f1010) : "f"(f1006));
  // PTX:1735 ld.local.u32 %r1225, [%rd2+116]
  r1225 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:1736 add.s32 %r1226, %r1225, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r1226) : "r"(r1225));
  // PTX:1737 st.local.u32 [%rd2+116], %r1226
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116))))) = (unsigned)(r1226);
  // PTX:1738 mul.wide.s32 %rd278, %r1225, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd278) : "r"(r1225));
  // PTX:1739 add.s64 %rd279, %rd269, %rd278
  asm("add.s64 %0, %1, %2;" : "=l"(rd279) : "l"(rd269), "l"(rd278));
  // PTX:1740 st.local.f32 [%rd279], %f1010
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd279) + (0))))) = (float)(f1010);
  // PTX:1741 ld.local.u32 %r1227, [%rd2+56]
  r1227 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:1742 mul.wide.s32 %rd280, %r1227, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd280) : "r"(r1227));
  // PTX:1743 add.s64 %rd281, %rd2, %rd280
  asm("add.s64 %0, %1, %2;" : "=l"(rd281) : "l"(rd2), "l"(rd280));
  // PTX:1744 st.local.u32 [%rd281], %r1774
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd281) + (0))))) = (unsigned)(r1774);
  // PTX:1745 neg.f32 %f1011, %f1002
  asm("neg.f32 %0, %1;" : "=f"(f1011) : "f"(f1002));
  // PTX:1746 ld.local.u32 %r1228, [%rd2+56]
  r1228 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:1747 add.s32 %r1229, %r1228, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r1229) : "r"(r1228));
  // PTX:1748 st.local.u32 [%rd2+56], %r1229
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56))))) = (unsigned)(r1229);
  // PTX:1749 mul.wide.s32 %rd282, %r1228, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd282) : "r"(r1228));
  // PTX:1750 add.s64 %rd283, %rd263, %rd282
  asm("add.s64 %0, %1, %2;" : "=l"(rd283) : "l"(rd263), "l"(rd282));
  // PTX:1751 st.local.f32 [%rd283], %f1011
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd283) + (0))))) = (float)(f1011);
  // PTX:1752 ld.local.u32 %r1230, [%rd2+116]
  r1230 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:1753 mul.wide.s32 %rd284, %r1230, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd284) : "r"(r1230));
  // PTX:1754 add.s64 %rd285, %rd266, %rd284
  asm("add.s64 %0, %1, %2;" : "=l"(rd285) : "l"(rd266), "l"(rd284));
  // PTX:1755 st.local.u32 [%rd285], %r1774
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd285) + (0))))) = (unsigned)(r1774);
  // PTX:1756 neg.f32 %f1012, %f1007
  asm("neg.f32 %0, %1;" : "=f"(f1012) : "f"(f1007));
  // PTX:1757 ld.local.u32 %r1231, [%rd2+116]
  r1231 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:1758 add.s32 %r1232, %r1231, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r1232) : "r"(r1231));
  // PTX:1759 st.local.u32 [%rd2+116], %r1232
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116))))) = (unsigned)(r1232);
  // PTX:1760 mul.wide.s32 %rd286, %r1231, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd286) : "r"(r1231));
  // PTX:1761 add.s64 %rd287, %rd269, %rd286
  asm("add.s64 %0, %1, %2;" : "=l"(rd287) : "l"(rd269), "l"(rd286));
  // PTX:1762 st.local.f32 [%rd287], %f1012
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd287) + (0))))) = (float)(f1012);
  // PTX:1763 ld.local.u32 %r1233, [%rd2+56]
  r1233 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:1764 mul.wide.s32 %rd288, %r1233, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd288) : "r"(r1233));
  // PTX:1765 add.s64 %rd289, %rd2, %rd288
  asm("add.s64 %0, %1, %2;" : "=l"(rd289) : "l"(rd2), "l"(rd288));
  // PTX:1766 st.local.u32 [%rd289], %r1773
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd289) + (0))))) = (unsigned)(r1773);
  // PTX:1767 neg.f32 %f1013, %f1005
  asm("neg.f32 %0, %1;" : "=f"(f1013) : "f"(f1005));
  // PTX:1768 ld.local.u32 %r1234, [%rd2+56]
  r1234 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:1769 add.s32 %r1235, %r1234, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r1235) : "r"(r1234));
  // PTX:1770 st.local.u32 [%rd2+56], %r1235
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56))))) = (unsigned)(r1235);
  // PTX:1771 mul.wide.s32 %rd290, %r1234, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd290) : "r"(r1234));
  // PTX:1772 add.s64 %rd291, %rd263, %rd290
  asm("add.s64 %0, %1, %2;" : "=l"(rd291) : "l"(rd263), "l"(rd290));
  // PTX:1773 st.local.f32 [%rd291], %f1013
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd291) + (0))))) = (float)(f1013);
  // PTX:1774 ld.local.u32 %r1236, [%rd2+116]
  r1236 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:1775 mul.wide.s32 %rd292, %r1236, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd292) : "r"(r1236));
  // PTX:1776 add.s64 %rd293, %rd266, %rd292
  asm("add.s64 %0, %1, %2;" : "=l"(rd293) : "l"(rd266), "l"(rd292));
  // PTX:1777 st.local.u32 [%rd293], %r1773
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd293) + (0))))) = (unsigned)(r1773);
  // PTX:1778 neg.f32 %f1014, %f1008
  asm("neg.f32 %0, %1;" : "=f"(f1014) : "f"(f1008));
  // PTX:1779 ld.local.u32 %r1237, [%rd2+116]
  r1237 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:1780 add.s32 %r1238, %r1237, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r1238) : "r"(r1237));
  // PTX:1781 st.local.u32 [%rd2+116], %r1238
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116))))) = (unsigned)(r1238);
  // PTX:1782 mul.wide.s32 %rd294, %r1237, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd294) : "r"(r1237));
  // PTX:1783 add.s64 %rd295, %rd269, %rd294
  asm("add.s64 %0, %1, %2;" : "=l"(rd295) : "l"(rd269), "l"(rd294));
  // PTX:1784 st.local.f32 [%rd295], %f1014
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd295) + (0))))) = (float)(f1014);
  // PTX:1785 mul.wide.s32 %rd296, %r1775, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd296) : "r"(r1775));
  // PTX:1786 add.s64 %rd87, %rd23, %rd296
  asm("add.s64 %0, %1, %2;" : "=l"(rd87) : "l"(rd23), "l"(rd296));
  // PTX:1787 ld.global.f32 %f1015, [%rd87]
  f1015 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (0)))));
  // PTX:1788 mov.b32 %f1016, %r1831
  asm("mov.b32 %0, %1;" : "=f"(f1016) : "r"(r1831));
  // PTX:1789 ld.global.f32 %f1017, [%rd87+4]
  f1017 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (4)))));
  // PTX:1790 ld.global.f32 %f1018, [%rd87+8]
  f1018 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (8)))));
  // PTX:1791 mul.wide.s32 %rd297, %r1774, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd297) : "r"(r1774));
  // PTX:1792 add.s64 %rd89, %rd23, %rd297
  asm("add.s64 %0, %1, %2;" : "=l"(rd89) : "l"(rd23), "l"(rd297));
  // PTX:1793 ld.global.f32 %f1019, [%rd89]
  f1019 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (0)))));
  // PTX:1794 mov.b32 %f1020, %r1830
  asm("mov.b32 %0, %1;" : "=f"(f1020) : "r"(r1830));
  // PTX:1795 mul.f32 %f1021, %f1019, %f1020
  asm("mul.f32 %0, %1, %2;" : "=f"(f1021) : "f"(f1019), "f"(f1020));
  // PTX:1796 ld.global.f32 %f1022, [%rd89+4]
  f1022 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (4)))));
  // PTX:1797 mul.f32 %f1023, %f1022, %f1020
  asm("mul.f32 %0, %1, %2;" : "=f"(f1023) : "f"(f1022), "f"(f1020));
  // PTX:1798 ld.global.f32 %f1024, [%rd89+8]
  f1024 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (8)))));
  // PTX:1799 mul.f32 %f1025, %f1024, %f1020
  asm("mul.f32 %0, %1, %2;" : "=f"(f1025) : "f"(f1024), "f"(f1020));
  // PTX:1800 fma.rn.f32 %f1026, %f1015, %f1016, %f1021
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1026) : "f"(f1015), "f"(f1016), "f"(f1021));
  // PTX:1801 fma.rn.f32 %f1027, %f1017, %f1016, %f1023
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1027) : "f"(f1017), "f"(f1016), "f"(f1023));
  // PTX:1802 fma.rn.f32 %f1028, %f1018, %f1016, %f1025
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1028) : "f"(f1018), "f"(f1016), "f"(f1025));
  // PTX:1803 mul.wide.s32 %rd298, %r1773, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd298) : "r"(r1773));
  // PTX:1804 add.s64 %rd91, %rd23, %rd298
  asm("add.s64 %0, %1, %2;" : "=l"(rd91) : "l"(rd23), "l"(rd298));
  // PTX:1805 ld.global.f32 %f1029, [%rd91]
  f1029 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (0)))));
  // PTX:1806 mov.b32 %f1030, %r1829
  asm("mov.b32 %0, %1;" : "=f"(f1030) : "r"(r1829));
  // PTX:1807 ld.global.f32 %f1031, [%rd91+4]
  f1031 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (4)))));
  // PTX:1808 ld.global.f32 %f1032, [%rd91+8]
  f1032 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (8)))));
  // PTX:1809 fma.rn.f32 %f220, %f1029, %f1030, %f1026
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f220) : "f"(f1029), "f"(f1030), "f"(f1026));
  // PTX:1810 fma.rn.f32 %f221, %f1031, %f1030, %f1027
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f221) : "f"(f1031), "f"(f1030), "f"(f1027));
  // PTX:1811 fma.rn.f32 %f222, %f1032, %f1030, %f1028
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f222) : "f"(f1032), "f"(f1030), "f"(f1028));
  // PTX:1812 ld.global.f32 %f1033, [%rd92]
  f1033 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0)))));
  // PTX:1813 sub.f32 %f223, %f998, %f1033
  asm("sub.f32 %0, %1, %2;" : "=f"(f223) : "f"(f998), "f"(f1033));
  // PTX:1814 ld.global.f32 %f1034, [%rd92+4]
  f1034 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (4)))));
  // PTX:1815 sub.f32 %f224, %f1001, %f1034
  asm("sub.f32 %0, %1, %2;" : "=f"(f224) : "f"(f1001), "f"(f1034));
  // PTX:1816 ld.global.f32 %f1035, [%rd92+8]
  f1035 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (8)))));
  // PTX:1817 sub.f32 %f225, %f1004, %f1035
  asm("sub.f32 %0, %1, %2;" : "=f"(f225) : "f"(f1004), "f"(f1035));
  // PTX:1818 mul.wide.s32 %rd95, %r1776, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd95) : "r"(r1776));
  // PTX:1819 @%p115 bra $L__BB7_121
  if (p115) { goto L_BB7_121; }
  // PTX:1821 mul.wide.s32 %rd344, %r1776, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd344) : "r"(r1776));
  // PTX:1822 add.s64 %rd343, %rd25, %rd344
  asm("add.s64 %0, %1, %2;" : "=l"(rd343) : "l"(rd25), "l"(rd344));
  // PTX:1823 cvt.s64.s32 %rd342, %r1776
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd342) : "r"(r1776));
  // PTX:1824 mul.lo.s64 %rd299, %rd342, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd299) : "l"(rd342));
  // PTX:1825 add.s64 %rd300, %rd23, %rd299
  asm("add.s64 %0, %1, %2;" : "=l"(rd300) : "l"(rd23), "l"(rd299));
  // PTX:1826 ld.global.f32 %f1036, [%rd343]
  f1036 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd343) + (0)))));
  // PTX:1827 ld.global.f32 %f1037, [%rd300]
  f1037 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd300) + (0)))));
  // PTX:1828 sub.f32 %f1038, %f1037, %f1036
  asm("sub.f32 %0, %1, %2;" : "=f"(f1038) : "f"(f1037), "f"(f1036));
  // PTX:1829 ld.global.f32 %f1039, [%rd343+4]
  f1039 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd343) + (4)))));
  // PTX:1830 ld.global.f32 %f1040, [%rd300+4]
  f1040 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd300) + (4)))));
  // PTX:1831 sub.f32 %f1041, %f1040, %f1039
  asm("sub.f32 %0, %1, %2;" : "=f"(f1041) : "f"(f1040), "f"(f1039));
  // PTX:1832 ld.global.f32 %f1042, [%rd343+8]
  f1042 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd343) + (8)))));
  // PTX:1833 ld.global.f32 %f1043, [%rd300+8]
  f1043 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd300) + (8)))));
  // PTX:1834 sub.f32 %f1044, %f1043, %f1042
  asm("sub.f32 %0, %1, %2;" : "=f"(f1044) : "f"(f1043), "f"(f1042));
  // PTX:1835 mul.f32 %f1534, %f1, %f1038
  asm("mul.f32 %0, %1, %2;" : "=f"(f1534) : "f"(f1), "f"(f1038));
  // PTX:1836 mul.f32 %f1535, %f1, %f1041
  asm("mul.f32 %0, %1, %2;" : "=f"(f1535) : "f"(f1), "f"(f1041));
  // PTX:1837 mul.f32 %f1536, %f1, %f1044
  asm("mul.f32 %0, %1, %2;" : "=f"(f1536) : "f"(f1), "f"(f1044));
  // PTX:1838 bra.uni $L__BB7_122
  goto L_BB7_122;
  // PTX:1840 $L__BB7_121:
L_BB7_121:;
  // PTX:1841 ld.f32 %f1534, [%rd95]
  f1534 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd95) + (0))));
  // PTX:1842 ld.f32 %f1535, [%rd95+4]
  f1535 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd95) + (4))));
  // PTX:1843 ld.f32 %f1536, [%rd95+8]
  f1536 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd95) + (8))));
  // PTX:1845 $L__BB7_122:
L_BB7_122:;
  // PTX:1846 cvt.s64.s32 %rd345, %r1775
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd345) : "r"(r1775));
  // PTX:1847 mul.lo.s64 %rd97, %rd345, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd97) : "l"(rd345));
  // PTX:1848 add.s64 %rd96, %rd25, %rd97
  asm("add.s64 %0, %1, %2;" : "=l"(rd96) : "l"(rd25), "l"(rd97));
  // PTX:1849 @%p115 bra $L__BB7_124
  if (p115) { goto L_BB7_124; }
  // PTX:1851 mul.wide.s32 %rd347, %r1775, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd347) : "r"(r1775));
  // PTX:1852 add.s64 %rd346, %rd23, %rd347
  asm("add.s64 %0, %1, %2;" : "=l"(rd346) : "l"(rd23), "l"(rd347));
  // PTX:1853 ld.global.f32 %f1045, [%rd96]
  f1045 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))));
  // PTX:1854 ld.global.f32 %f1046, [%rd346]
  f1046 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd346) + (0)))));
  // PTX:1855 sub.f32 %f1047, %f1046, %f1045
  asm("sub.f32 %0, %1, %2;" : "=f"(f1047) : "f"(f1046), "f"(f1045));
  // PTX:1856 ld.global.f32 %f1048, [%rd96+4]
  f1048 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (4)))));
  // PTX:1857 ld.global.f32 %f1049, [%rd346+4]
  f1049 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd346) + (4)))));
  // PTX:1858 sub.f32 %f1050, %f1049, %f1048
  asm("sub.f32 %0, %1, %2;" : "=f"(f1050) : "f"(f1049), "f"(f1048));
  // PTX:1859 ld.global.f32 %f1051, [%rd96+8]
  f1051 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (8)))));
  // PTX:1860 ld.global.f32 %f1052, [%rd346+8]
  f1052 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd346) + (8)))));
  // PTX:1861 sub.f32 %f1053, %f1052, %f1051
  asm("sub.f32 %0, %1, %2;" : "=f"(f1053) : "f"(f1052), "f"(f1051));
  // PTX:1862 mul.f32 %f1537, %f1, %f1047
  asm("mul.f32 %0, %1, %2;" : "=f"(f1537) : "f"(f1), "f"(f1047));
  // PTX:1863 mul.f32 %f1538, %f1, %f1050
  asm("mul.f32 %0, %1, %2;" : "=f"(f1538) : "f"(f1), "f"(f1050));
  // PTX:1864 mul.f32 %f1539, %f1, %f1053
  asm("mul.f32 %0, %1, %2;" : "=f"(f1539) : "f"(f1), "f"(f1053));
  // PTX:1865 bra.uni $L__BB7_125
  goto L_BB7_125;
  // PTX:1867 $L__BB7_124:
L_BB7_124:;
  // PTX:1868 ld.f32 %f1537, [%rd97]
  f1537 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd97) + (0))));
  // PTX:1869 ld.f32 %f1538, [%rd97+4]
  f1538 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd97) + (4))));
  // PTX:1870 ld.f32 %f1539, [%rd97+8]
  f1539 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd97) + (8))));
  // PTX:1872 $L__BB7_125:
L_BB7_125:;
  // PTX:1873 cvt.s64.s32 %rd348, %r1774
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd348) : "r"(r1774));
  // PTX:1874 mul.lo.s64 %rd99, %rd348, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd99) : "l"(rd348));
  // PTX:1875 add.s64 %rd98, %rd25, %rd99
  asm("add.s64 %0, %1, %2;" : "=l"(rd98) : "l"(rd25), "l"(rd99));
  // PTX:1876 @%p115 bra $L__BB7_127
  if (p115) { goto L_BB7_127; }
  // PTX:1878 mul.wide.s32 %rd350, %r1774, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd350) : "r"(r1774));
  // PTX:1879 add.s64 %rd349, %rd23, %rd350
  asm("add.s64 %0, %1, %2;" : "=l"(rd349) : "l"(rd23), "l"(rd350));
  // PTX:1880 ld.global.f32 %f1054, [%rd98]
  f1054 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))));
  // PTX:1881 ld.global.f32 %f1055, [%rd349]
  f1055 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd349) + (0)))));
  // PTX:1882 sub.f32 %f1056, %f1055, %f1054
  asm("sub.f32 %0, %1, %2;" : "=f"(f1056) : "f"(f1055), "f"(f1054));
  // PTX:1883 ld.global.f32 %f1057, [%rd98+4]
  f1057 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (4)))));
  // PTX:1884 ld.global.f32 %f1058, [%rd349+4]
  f1058 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd349) + (4)))));
  // PTX:1885 sub.f32 %f1059, %f1058, %f1057
  asm("sub.f32 %0, %1, %2;" : "=f"(f1059) : "f"(f1058), "f"(f1057));
  // PTX:1886 ld.global.f32 %f1060, [%rd98+8]
  f1060 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (8)))));
  // PTX:1887 ld.global.f32 %f1061, [%rd349+8]
  f1061 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd349) + (8)))));
  // PTX:1888 sub.f32 %f1062, %f1061, %f1060
  asm("sub.f32 %0, %1, %2;" : "=f"(f1062) : "f"(f1061), "f"(f1060));
  // PTX:1889 mul.f32 %f1540, %f1, %f1056
  asm("mul.f32 %0, %1, %2;" : "=f"(f1540) : "f"(f1), "f"(f1056));
  // PTX:1890 mul.f32 %f1541, %f1, %f1059
  asm("mul.f32 %0, %1, %2;" : "=f"(f1541) : "f"(f1), "f"(f1059));
  // PTX:1891 mul.f32 %f1542, %f1, %f1062
  asm("mul.f32 %0, %1, %2;" : "=f"(f1542) : "f"(f1), "f"(f1062));
  // PTX:1892 bra.uni $L__BB7_128
  goto L_BB7_128;
  // PTX:1894 $L__BB7_127:
L_BB7_127:;
  // PTX:1895 ld.f32 %f1540, [%rd99]
  f1540 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd99) + (0))));
  // PTX:1896 ld.f32 %f1541, [%rd99+4]
  f1541 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd99) + (4))));
  // PTX:1897 ld.f32 %f1542, [%rd99+8]
  f1542 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd99) + (8))));
  // PTX:1899 $L__BB7_128:
L_BB7_128:;
  // PTX:1900 cvt.s64.s32 %rd351, %r1773
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd351) : "r"(r1773));
  // PTX:1901 mul.lo.s64 %rd101, %rd351, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd101) : "l"(rd351));
  // PTX:1902 add.s64 %rd100, %rd25, %rd101
  asm("add.s64 %0, %1, %2;" : "=l"(rd100) : "l"(rd25), "l"(rd101));
  // PTX:1903 @%p115 bra $L__BB7_130
  if (p115) { goto L_BB7_130; }
  // PTX:1905 mul.wide.s32 %rd331, %r1773, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd331) : "r"(r1773));
  // PTX:1906 add.s64 %rd330, %rd23, %rd331
  asm("add.s64 %0, %1, %2;" : "=l"(rd330) : "l"(rd23), "l"(rd331));
  // PTX:1907 ld.global.f32 %f1063, [%rd100]
  f1063 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))));
  // PTX:1908 ld.global.f32 %f1064, [%rd330]
  f1064 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd330) + (0)))));
  // PTX:1909 sub.f32 %f1065, %f1064, %f1063
  asm("sub.f32 %0, %1, %2;" : "=f"(f1065) : "f"(f1064), "f"(f1063));
  // PTX:1910 ld.global.f32 %f1066, [%rd100+4]
  f1066 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (4)))));
  // PTX:1911 ld.global.f32 %f1067, [%rd330+4]
  f1067 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd330) + (4)))));
  // PTX:1912 sub.f32 %f1068, %f1067, %f1066
  asm("sub.f32 %0, %1, %2;" : "=f"(f1068) : "f"(f1067), "f"(f1066));
  // PTX:1913 ld.global.f32 %f1069, [%rd100+8]
  f1069 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (8)))));
  // PTX:1914 ld.global.f32 %f1070, [%rd330+8]
  f1070 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd330) + (8)))));
  // PTX:1915 sub.f32 %f1071, %f1070, %f1069
  asm("sub.f32 %0, %1, %2;" : "=f"(f1071) : "f"(f1070), "f"(f1069));
  // PTX:1916 mul.f32 %f1543, %f1, %f1065
  asm("mul.f32 %0, %1, %2;" : "=f"(f1543) : "f"(f1), "f"(f1065));
  // PTX:1917 mul.f32 %f1544, %f1, %f1068
  asm("mul.f32 %0, %1, %2;" : "=f"(f1544) : "f"(f1), "f"(f1068));
  // PTX:1918 mul.f32 %f1545, %f1, %f1071
  asm("mul.f32 %0, %1, %2;" : "=f"(f1545) : "f"(f1), "f"(f1071));
  // PTX:1919 bra.uni $L__BB7_131
  goto L_BB7_131;
  // PTX:1921 $L__BB7_130:
L_BB7_130:;
  // PTX:1922 ld.f32 %f1543, [%rd101]
  f1543 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd101) + (0))));
  // PTX:1923 ld.f32 %f1544, [%rd101+4]
  f1544 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd101) + (4))));
  // PTX:1924 ld.f32 %f1545, [%rd101+8]
  f1545 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd101) + (8))));
  // PTX:1926 $L__BB7_131:
L_BB7_131:;
  // PTX:1927 fma.rn.f32 %f1072, %f223, %f1537, %f1534
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1072) : "f"(f223), "f"(f1537), "f"(f1534));
  // PTX:1928 fma.rn.f32 %f1073, %f223, %f1538, %f1535
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1073) : "f"(f223), "f"(f1538), "f"(f1535));
  // PTX:1929 fma.rn.f32 %f1074, %f223, %f1539, %f1536
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1074) : "f"(f223), "f"(f1539), "f"(f1536));
  // PTX:1930 fma.rn.f32 %f1075, %f224, %f1540, %f1072
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1075) : "f"(f224), "f"(f1540), "f"(f1072));
  // PTX:1931 fma.rn.f32 %f1076, %f224, %f1541, %f1073
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1076) : "f"(f224), "f"(f1541), "f"(f1073));
  // PTX:1932 fma.rn.f32 %f1077, %f224, %f1542, %f1074
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1077) : "f"(f224), "f"(f1542), "f"(f1074));
  // PTX:1933 fma.rn.f32 %f1078, %f225, %f1543, %f1075
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1078) : "f"(f225), "f"(f1543), "f"(f1075));
  // PTX:1934 fma.rn.f32 %f1079, %f225, %f1544, %f1076
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1079) : "f"(f225), "f"(f1544), "f"(f1076));
  // PTX:1935 fma.rn.f32 %f1080, %f225, %f1545, %f1077
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1080) : "f"(f225), "f"(f1545), "f"(f1077));
  // PTX:1936 add.f32 %f1081, %f220, %f1078
  asm("add.f32 %0, %1, %2;" : "=f"(f1081) : "f"(f220), "f"(f1078));
  // PTX:1937 add.f32 %f1082, %f221, %f1079
  asm("add.f32 %0, %1, %2;" : "=f"(f1082) : "f"(f221), "f"(f1079));
  // PTX:1938 add.f32 %f1083, %f222, %f1080
  asm("add.f32 %0, %1, %2;" : "=f"(f1083) : "f"(f222), "f"(f1080));
  // PTX:1939 mov.b32 %r1831, %f1081
  asm("mov.b32 %0, %1;" : "=r"(r1831) : "f"(f1081));
  // PTX:1940 mov.b32 %r1830, %f1082
  asm("mov.b32 %0, %1;" : "=r"(r1830) : "f"(f1082));
  // PTX:1941 mov.b32 %r1829, %f1083
  asm("mov.b32 %0, %1;" : "=r"(r1829) : "f"(f1083));
  // PTX:1942 ld.global.f32 %f1084, [%rd92]
  f1084 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0)))));
  // PTX:1943 sub.f32 %f262, %f217, %f1084
  asm("sub.f32 %0, %1, %2;" : "=f"(f262) : "f"(f217), "f"(f1084));
  // PTX:1944 ld.global.f32 %f1085, [%rd92+4]
  f1085 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (4)))));
  // PTX:1945 sub.f32 %f263, %f218, %f1085
  asm("sub.f32 %0, %1, %2;" : "=f"(f263) : "f"(f218), "f"(f1085));
  // PTX:1946 ld.global.f32 %f1086, [%rd92+8]
  f1086 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (8)))));
  // PTX:1947 sub.f32 %f264, %f219, %f1086
  asm("sub.f32 %0, %1, %2;" : "=f"(f264) : "f"(f219), "f"(f1086));
  // PTX:1948 @%p115 bra $L__BB7_133
  if (p115) { goto L_BB7_133; }
  // PTX:1950 mul.wide.s32 %rd334, %r1776, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd334) : "r"(r1776));
  // PTX:1951 add.s64 %rd333, %rd25, %rd334
  asm("add.s64 %0, %1, %2;" : "=l"(rd333) : "l"(rd25), "l"(rd334));
  // PTX:1952 cvt.s64.s32 %rd332, %r1776
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd332) : "r"(r1776));
  // PTX:1953 mul.lo.s64 %rd301, %rd332, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd301) : "l"(rd332));
  // PTX:1954 add.s64 %rd302, %rd23, %rd301
  asm("add.s64 %0, %1, %2;" : "=l"(rd302) : "l"(rd23), "l"(rd301));
  // PTX:1955 ld.global.f32 %f1087, [%rd333]
  f1087 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd333) + (0)))));
  // PTX:1956 ld.global.f32 %f1088, [%rd302]
  f1088 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd302) + (0)))));
  // PTX:1957 sub.f32 %f1089, %f1088, %f1087
  asm("sub.f32 %0, %1, %2;" : "=f"(f1089) : "f"(f1088), "f"(f1087));
  // PTX:1958 ld.global.f32 %f1090, [%rd333+4]
  f1090 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd333) + (4)))));
  // PTX:1959 ld.global.f32 %f1091, [%rd302+4]
  f1091 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd302) + (4)))));
  // PTX:1960 sub.f32 %f1092, %f1091, %f1090
  asm("sub.f32 %0, %1, %2;" : "=f"(f1092) : "f"(f1091), "f"(f1090));
  // PTX:1961 ld.global.f32 %f1093, [%rd333+8]
  f1093 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd333) + (8)))));
  // PTX:1962 ld.global.f32 %f1094, [%rd302+8]
  f1094 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd302) + (8)))));
  // PTX:1963 sub.f32 %f1095, %f1094, %f1093
  asm("sub.f32 %0, %1, %2;" : "=f"(f1095) : "f"(f1094), "f"(f1093));
  // PTX:1964 mul.f32 %f1546, %f1, %f1089
  asm("mul.f32 %0, %1, %2;" : "=f"(f1546) : "f"(f1), "f"(f1089));
  // PTX:1965 mul.f32 %f1547, %f1, %f1092
  asm("mul.f32 %0, %1, %2;" : "=f"(f1547) : "f"(f1), "f"(f1092));
  // PTX:1966 mul.f32 %f1548, %f1, %f1095
  asm("mul.f32 %0, %1, %2;" : "=f"(f1548) : "f"(f1), "f"(f1095));
  // PTX:1967 bra.uni $L__BB7_134
  goto L_BB7_134;
  // PTX:1969 $L__BB7_133:
L_BB7_133:;
  // PTX:1970 mul.wide.s32 %rd341, %r1776, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd341) : "r"(r1776));
  // PTX:1971 ld.f32 %f1546, [%rd341]
  f1546 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd341) + (0))));
  // PTX:1972 ld.f32 %f1547, [%rd341+4]
  f1547 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd341) + (4))));
  // PTX:1973 ld.f32 %f1548, [%rd341+8]
  f1548 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd341) + (8))));
  // PTX:1975 $L__BB7_134:
L_BB7_134:;
  // PTX:1976 @%p115 bra $L__BB7_136
  if (p115) { goto L_BB7_136; }
  // PTX:1978 mul.wide.s32 %rd336, %r1775, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd336) : "r"(r1775));
  // PTX:1979 add.s64 %rd335, %rd23, %rd336
  asm("add.s64 %0, %1, %2;" : "=l"(rd335) : "l"(rd23), "l"(rd336));
  // PTX:1980 ld.global.f32 %f1096, [%rd96]
  f1096 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))));
  // PTX:1981 ld.global.f32 %f1097, [%rd335]
  f1097 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd335) + (0)))));
  // PTX:1982 sub.f32 %f1098, %f1097, %f1096
  asm("sub.f32 %0, %1, %2;" : "=f"(f1098) : "f"(f1097), "f"(f1096));
  // PTX:1983 ld.global.f32 %f1099, [%rd96+4]
  f1099 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (4)))));
  // PTX:1984 ld.global.f32 %f1100, [%rd335+4]
  f1100 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd335) + (4)))));
  // PTX:1985 sub.f32 %f1101, %f1100, %f1099
  asm("sub.f32 %0, %1, %2;" : "=f"(f1101) : "f"(f1100), "f"(f1099));
  // PTX:1986 ld.global.f32 %f1102, [%rd96+8]
  f1102 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (8)))));
  // PTX:1987 ld.global.f32 %f1103, [%rd335+8]
  f1103 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd335) + (8)))));
  // PTX:1988 sub.f32 %f1104, %f1103, %f1102
  asm("sub.f32 %0, %1, %2;" : "=f"(f1104) : "f"(f1103), "f"(f1102));
  // PTX:1989 mul.f32 %f1549, %f1, %f1098
  asm("mul.f32 %0, %1, %2;" : "=f"(f1549) : "f"(f1), "f"(f1098));
  // PTX:1990 mul.f32 %f1550, %f1, %f1101
  asm("mul.f32 %0, %1, %2;" : "=f"(f1550) : "f"(f1), "f"(f1101));
  // PTX:1991 mul.f32 %f1551, %f1, %f1104
  asm("mul.f32 %0, %1, %2;" : "=f"(f1551) : "f"(f1), "f"(f1104));
  // PTX:1992 bra.uni $L__BB7_137
  goto L_BB7_137;
  // PTX:1994 $L__BB7_136:
L_BB7_136:;
  // PTX:1995 ld.f32 %f1549, [%rd97]
  f1549 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd97) + (0))));
  // PTX:1996 ld.f32 %f1550, [%rd97+4]
  f1550 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd97) + (4))));
  // PTX:1997 ld.f32 %f1551, [%rd97+8]
  f1551 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd97) + (8))));
  // PTX:1999 $L__BB7_137:
L_BB7_137:;
  // PTX:2000 @%p115 bra $L__BB7_139
  if (p115) { goto L_BB7_139; }
  // PTX:2002 mul.wide.s32 %rd338, %r1774, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd338) : "r"(r1774));
  // PTX:2003 add.s64 %rd337, %rd23, %rd338
  asm("add.s64 %0, %1, %2;" : "=l"(rd337) : "l"(rd23), "l"(rd338));
  // PTX:2004 ld.global.f32 %f1105, [%rd98]
  f1105 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))));
  // PTX:2005 ld.global.f32 %f1106, [%rd337]
  f1106 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd337) + (0)))));
  // PTX:2006 sub.f32 %f1107, %f1106, %f1105
  asm("sub.f32 %0, %1, %2;" : "=f"(f1107) : "f"(f1106), "f"(f1105));
  // PTX:2007 ld.global.f32 %f1108, [%rd98+4]
  f1108 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (4)))));
  // PTX:2008 ld.global.f32 %f1109, [%rd337+4]
  f1109 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd337) + (4)))));
  // PTX:2009 sub.f32 %f1110, %f1109, %f1108
  asm("sub.f32 %0, %1, %2;" : "=f"(f1110) : "f"(f1109), "f"(f1108));
  // PTX:2010 ld.global.f32 %f1111, [%rd98+8]
  f1111 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (8)))));
  // PTX:2011 ld.global.f32 %f1112, [%rd337+8]
  f1112 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd337) + (8)))));
  // PTX:2012 sub.f32 %f1113, %f1112, %f1111
  asm("sub.f32 %0, %1, %2;" : "=f"(f1113) : "f"(f1112), "f"(f1111));
  // PTX:2013 mul.f32 %f1552, %f1, %f1107
  asm("mul.f32 %0, %1, %2;" : "=f"(f1552) : "f"(f1), "f"(f1107));
  // PTX:2014 mul.f32 %f1553, %f1, %f1110
  asm("mul.f32 %0, %1, %2;" : "=f"(f1553) : "f"(f1), "f"(f1110));
  // PTX:2015 mul.f32 %f1554, %f1, %f1113
  asm("mul.f32 %0, %1, %2;" : "=f"(f1554) : "f"(f1), "f"(f1113));
  // PTX:2016 bra.uni $L__BB7_140
  goto L_BB7_140;
  // PTX:2018 $L__BB7_139:
L_BB7_139:;
  // PTX:2019 ld.f32 %f1552, [%rd99]
  f1552 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd99) + (0))));
  // PTX:2020 ld.f32 %f1553, [%rd99+4]
  f1553 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd99) + (4))));
  // PTX:2021 ld.f32 %f1554, [%rd99+8]
  f1554 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd99) + (8))));
  // PTX:2023 $L__BB7_140:
L_BB7_140:;
  // PTX:2024 @%p115 bra $L__BB7_142
  if (p115) { goto L_BB7_142; }
  // PTX:2026 mul.wide.s32 %rd340, %r1773, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd340) : "r"(r1773));
  // PTX:2027 add.s64 %rd339, %rd23, %rd340
  asm("add.s64 %0, %1, %2;" : "=l"(rd339) : "l"(rd23), "l"(rd340));
  // PTX:2028 ld.global.f32 %f1114, [%rd100]
  f1114 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))));
  // PTX:2029 ld.global.f32 %f1115, [%rd339]
  f1115 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd339) + (0)))));
  // PTX:2030 sub.f32 %f1116, %f1115, %f1114
  asm("sub.f32 %0, %1, %2;" : "=f"(f1116) : "f"(f1115), "f"(f1114));
  // PTX:2031 ld.global.f32 %f1117, [%rd100+4]
  f1117 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (4)))));
  // PTX:2032 ld.global.f32 %f1118, [%rd339+4]
  f1118 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd339) + (4)))));
  // PTX:2033 sub.f32 %f1119, %f1118, %f1117
  asm("sub.f32 %0, %1, %2;" : "=f"(f1119) : "f"(f1118), "f"(f1117));
  // PTX:2034 ld.global.f32 %f1120, [%rd100+8]
  f1120 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (8)))));
  // PTX:2035 ld.global.f32 %f1121, [%rd339+8]
  f1121 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd339) + (8)))));
  // PTX:2036 sub.f32 %f1122, %f1121, %f1120
  asm("sub.f32 %0, %1, %2;" : "=f"(f1122) : "f"(f1121), "f"(f1120));
  // PTX:2037 mul.f32 %f1555, %f1, %f1116
  asm("mul.f32 %0, %1, %2;" : "=f"(f1555) : "f"(f1), "f"(f1116));
  // PTX:2038 mul.f32 %f1556, %f1, %f1119
  asm("mul.f32 %0, %1, %2;" : "=f"(f1556) : "f"(f1), "f"(f1119));
  // PTX:2039 mul.f32 %f1557, %f1, %f1122
  asm("mul.f32 %0, %1, %2;" : "=f"(f1557) : "f"(f1), "f"(f1122));
  // PTX:2040 bra.uni $L__BB7_143
  goto L_BB7_143;
  // PTX:2042 $L__BB7_142:
L_BB7_142:;
  // PTX:2043 ld.f32 %f1555, [%rd101]
  f1555 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd101) + (0))));
  // PTX:2044 ld.f32 %f1556, [%rd101+4]
  f1556 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd101) + (4))));
  // PTX:2045 ld.f32 %f1557, [%rd101+8]
  f1557 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd101) + (8))));
  // PTX:2047 $L__BB7_143:
L_BB7_143:;
  // PTX:2048 fma.rn.f32 %f1123, %f262, %f1549, %f1546
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1123) : "f"(f262), "f"(f1549), "f"(f1546));
  // PTX:2049 fma.rn.f32 %f1124, %f262, %f1550, %f1547
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1124) : "f"(f262), "f"(f1550), "f"(f1547));
  // PTX:2050 fma.rn.f32 %f1125, %f262, %f1551, %f1548
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1125) : "f"(f262), "f"(f1551), "f"(f1548));
  // PTX:2051 fma.rn.f32 %f1126, %f263, %f1552, %f1123
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1126) : "f"(f263), "f"(f1552), "f"(f1123));
  // PTX:2052 fma.rn.f32 %f1127, %f263, %f1553, %f1124
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1127) : "f"(f263), "f"(f1553), "f"(f1124));
  // PTX:2053 fma.rn.f32 %f1128, %f263, %f1554, %f1125
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1128) : "f"(f263), "f"(f1554), "f"(f1125));
  // PTX:2054 fma.rn.f32 %f1129, %f264, %f1555, %f1126
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1129) : "f"(f264), "f"(f1555), "f"(f1126));
  // PTX:2055 fma.rn.f32 %f1130, %f264, %f1556, %f1127
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1130) : "f"(f264), "f"(f1556), "f"(f1127));
  // PTX:2056 fma.rn.f32 %f1131, %f264, %f1557, %f1128
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1131) : "f"(f264), "f"(f1557), "f"(f1128));
  // PTX:2057 add.f32 %f1132, %f220, %f1129
  asm("add.f32 %0, %1, %2;" : "=f"(f1132) : "f"(f220), "f"(f1129));
  // PTX:2058 add.f32 %f1133, %f221, %f1130
  asm("add.f32 %0, %1, %2;" : "=f"(f1133) : "f"(f221), "f"(f1130));
  // PTX:2059 add.f32 %f1134, %f222, %f1131
  asm("add.f32 %0, %1, %2;" : "=f"(f1134) : "f"(f222), "f"(f1131));
  // PTX:2060 mov.b32 %r1834, %f1132
  asm("mov.b32 %0, %1;" : "=r"(r1834) : "f"(f1132));
  // PTX:2061 mov.b32 %r1833, %f1133
  asm("mov.b32 %0, %1;" : "=r"(r1833) : "f"(f1133));
  // PTX:2062 mov.b32 %r1832, %f1134
  asm("mov.b32 %0, %1;" : "=r"(r1832) : "f"(f1134));
  // PTX:2064 $L__BB7_144:
L_BB7_144:;
  // PTX:2065 mov.b32 %f1150, %r1820
  asm("mov.b32 %0, %1;" : "=f"(f1150) : "r"(r1820));
  // PTX:2066 sub.f32 %f301, %f1499, %f1150
  asm("sub.f32 %0, %1, %2;" : "=f"(f301) : "f"(f1499), "f"(f1150));
  // PTX:2067 mov.b32 %f1151, %r1821
  asm("mov.b32 %0, %1;" : "=f"(f1151) : "r"(r1821));
  // PTX:2068 sub.f32 %f302, %f1500, %f1151
  asm("sub.f32 %0, %1, %2;" : "=f"(f302) : "f"(f1500), "f"(f1151));
  // PTX:2069 mov.b32 %f1152, %r1822
  asm("mov.b32 %0, %1;" : "=f"(f1152) : "r"(r1822));
  // PTX:2070 sub.f32 %f303, %f1501, %f1152
  asm("sub.f32 %0, %1, %2;" : "=f"(f303) : "f"(f1501), "f"(f1152));
  // PTX:2071 mov.b32 %f1153, %r1831
  asm("mov.b32 %0, %1;" : "=f"(f1153) : "r"(r1831));
  // PTX:2072 sub.f32 %f304, %f1496, %f1153
  asm("sub.f32 %0, %1, %2;" : "=f"(f304) : "f"(f1496), "f"(f1153));
  // PTX:2073 mov.b32 %f1154, %r1830
  asm("mov.b32 %0, %1;" : "=f"(f1154) : "r"(r1830));
  // PTX:2074 sub.f32 %f305, %f1497, %f1154
  asm("sub.f32 %0, %1, %2;" : "=f"(f305) : "f"(f1497), "f"(f1154));
  // PTX:2075 mov.b32 %f1155, %r1829
  asm("mov.b32 %0, %1;" : "=f"(f1155) : "r"(r1829));
  // PTX:2076 sub.f32 %f306, %f1498, %f1155
  asm("sub.f32 %0, %1, %2;" : "=f"(f306) : "f"(f1498), "f"(f1155));
  // PTX:2077 mov.b32 %f1156, %r1834
  asm("mov.b32 %0, %1;" : "=f"(f1156) : "r"(r1834));
  // PTX:2078 sub.f32 %f307, %f1496, %f1156
  asm("sub.f32 %0, %1, %2;" : "=f"(f307) : "f"(f1496), "f"(f1156));
  // PTX:2079 mov.b32 %f1157, %r1833
  asm("mov.b32 %0, %1;" : "=f"(f1157) : "r"(r1833));
  // PTX:2080 sub.f32 %f308, %f1497, %f1157
  asm("sub.f32 %0, %1, %2;" : "=f"(f308) : "f"(f1497), "f"(f1157));
  // PTX:2081 mov.b32 %f1158, %r1832
  asm("mov.b32 %0, %1;" : "=f"(f1158) : "r"(r1832));
  // PTX:2082 sub.f32 %f309, %f1498, %f1158
  asm("sub.f32 %0, %1, %2;" : "=f"(f309) : "f"(f1498), "f"(f1158));
  // PTX:2083 abs.f32 %f1159, %f301
  asm("abs.f32 %0, %1;" : "=f"(f1159) : "f"(f301));
  // PTX:2084 setp.geu.f32 %p123, %f1159, 0f7F800000
  p123 = ((isnan(((float)(f1159))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1159)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2085 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:2086 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:2087 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:2088 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:2089 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:2090 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:2091 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:2092 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:2093 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:2094 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:2095 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:2096 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:2097 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:2098 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:2099 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:2100 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:2101 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:2102 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:2103 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:2104 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:2105 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:2106 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:2107 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:2108 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:2109 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:2110 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:2111 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:2112 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:2113 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:2114 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:2115 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:2116 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:2117 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:2118 @%p123 bra $L__BB7_164
  if (p123) { goto L_BB7_164; }
  // PTX:2120 abs.f32 %f1175, %f302
  asm("abs.f32 %0, %1;" : "=f"(f1175) : "f"(f302));
  // PTX:2121 setp.geu.f32 %p124, %f1175, 0f7F800000
  p124 = ((isnan(((float)(f1175))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1175)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2122 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:2123 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:2124 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:2125 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:2126 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:2127 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:2128 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:2129 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:2130 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:2131 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:2132 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:2133 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:2134 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:2135 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:2136 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:2137 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:2138 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:2139 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:2140 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:2141 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:2142 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:2143 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:2144 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:2145 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:2146 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:2147 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:2148 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:2149 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:2150 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:2151 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:2152 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:2153 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:2154 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:2155 @%p124 bra $L__BB7_164
  if (p124) { goto L_BB7_164; }
  // PTX:2157 abs.f32 %f1191, %f303
  asm("abs.f32 %0, %1;" : "=f"(f1191) : "f"(f303));
  // PTX:2158 setp.geu.f32 %p125, %f1191, 0f7F800000
  p125 = ((isnan(((float)(f1191))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1191)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2159 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:2160 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:2161 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:2162 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:2163 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:2164 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:2165 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:2166 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:2167 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:2168 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:2169 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:2170 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:2171 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:2172 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:2173 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:2174 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:2175 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:2176 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:2177 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:2178 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:2179 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:2180 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:2181 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:2182 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:2183 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:2184 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:2185 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:2186 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:2187 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:2188 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:2189 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:2190 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:2191 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:2192 @%p125 bra $L__BB7_164
  if (p125) { goto L_BB7_164; }
  // PTX:2194 abs.f32 %f1207, %f304
  asm("abs.f32 %0, %1;" : "=f"(f1207) : "f"(f304));
  // PTX:2195 setp.geu.f32 %p126, %f1207, 0f7F800000
  p126 = ((isnan(((float)(f1207))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1207)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2196 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:2197 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:2198 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:2199 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:2200 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:2201 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:2202 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:2203 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:2204 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:2205 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:2206 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:2207 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:2208 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:2209 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:2210 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:2211 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:2212 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:2213 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:2214 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:2215 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:2216 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:2217 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:2218 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:2219 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:2220 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:2221 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:2222 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:2223 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:2224 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:2225 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:2226 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:2227 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:2228 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:2229 @%p126 bra $L__BB7_164
  if (p126) { goto L_BB7_164; }
  // PTX:2231 abs.f32 %f1223, %f305
  asm("abs.f32 %0, %1;" : "=f"(f1223) : "f"(f305));
  // PTX:2232 setp.geu.f32 %p127, %f1223, 0f7F800000
  p127 = ((isnan(((float)(f1223))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1223)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2233 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:2234 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:2235 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:2236 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:2237 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:2238 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:2239 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:2240 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:2241 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:2242 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:2243 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:2244 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:2245 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:2246 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:2247 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:2248 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:2249 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:2250 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:2251 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:2252 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:2253 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:2254 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:2255 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:2256 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:2257 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:2258 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:2259 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:2260 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:2261 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:2262 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:2263 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:2264 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:2265 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:2266 @%p127 bra $L__BB7_164
  if (p127) { goto L_BB7_164; }
  // PTX:2268 abs.f32 %f1239, %f306
  asm("abs.f32 %0, %1;" : "=f"(f1239) : "f"(f306));
  // PTX:2269 setp.geu.f32 %p128, %f1239, 0f7F800000
  p128 = ((isnan(((float)(f1239))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1239)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2270 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:2271 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:2272 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:2273 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:2274 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:2275 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:2276 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:2277 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:2278 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:2279 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:2280 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:2281 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:2282 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:2283 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:2284 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:2285 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:2286 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:2287 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:2288 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:2289 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:2290 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:2291 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:2292 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:2293 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:2294 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:2295 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:2296 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:2297 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:2298 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:2299 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:2300 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:2301 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:2302 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:2303 @%p128 bra $L__BB7_164
  if (p128) { goto L_BB7_164; }
  // PTX:2305 abs.f32 %f1255, %f307
  asm("abs.f32 %0, %1;" : "=f"(f1255) : "f"(f307));
  // PTX:2306 setp.geu.f32 %p129, %f1255, 0f7F800000
  p129 = ((isnan(((float)(f1255))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1255)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2307 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:2308 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:2309 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:2310 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:2311 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:2312 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:2313 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:2314 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:2315 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:2316 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:2317 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:2318 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:2319 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:2320 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:2321 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:2322 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:2323 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:2324 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:2325 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:2326 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:2327 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:2328 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:2329 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:2330 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:2331 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:2332 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:2333 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:2334 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:2335 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:2336 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:2337 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:2338 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:2339 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:2340 @%p129 bra $L__BB7_164
  if (p129) { goto L_BB7_164; }
  // PTX:2342 abs.f32 %f1271, %f308
  asm("abs.f32 %0, %1;" : "=f"(f1271) : "f"(f308));
  // PTX:2343 setp.geu.f32 %p130, %f1271, 0f7F800000
  p130 = ((isnan(((float)(f1271))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1271)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2344 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:2345 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:2346 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:2347 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:2348 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:2349 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:2350 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:2351 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:2352 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:2353 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:2354 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:2355 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:2356 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:2357 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:2358 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:2359 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:2360 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:2361 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:2362 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:2363 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:2364 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:2365 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:2366 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:2367 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:2368 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:2369 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:2370 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:2371 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:2372 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:2373 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:2374 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:2375 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:2376 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:2377 @%p130 bra $L__BB7_164
  if (p130) { goto L_BB7_164; }
  // PTX:2379 abs.f32 %f1287, %f309
  asm("abs.f32 %0, %1;" : "=f"(f1287) : "f"(f309));
  // PTX:2380 setp.geu.f32 %p131, %f1287, 0f7F800000
  p131 = ((isnan(((float)(f1287))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1287)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2381 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:2382 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:2383 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:2384 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:2385 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:2386 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:2387 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:2388 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:2389 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:2390 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:2391 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:2392 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:2393 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:2394 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:2395 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:2396 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:2397 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:2398 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:2399 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:2400 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:2401 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:2402 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:2403 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:2404 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:2405 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:2406 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:2407 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:2408 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:2409 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:2410 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:2411 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:2412 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:2413 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:2414 @%p131 bra $L__BB7_164
  if (p131) { goto L_BB7_164; }
  // PTX:2416 add.s64 %rd304, %rd41, %rd222
  asm("add.s64 %0, %1, %2;" : "=l"(rd304) : "l"(rd41), "l"(rd222));
  // PTX:2417 ld.global.f32 %f1303, [%rd304]
  f1303 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd304) + (0)))));
  // PTX:2418 add.f32 %f1304, %f1502, %f1303
  asm("add.f32 %0, %1, %2;" : "=f"(f1304) : "f"(f1502), "f"(f1303));
  // PTX:2419 mul.f32 %f1305, %f302, %f1532
  asm("mul.f32 %0, %1, %2;" : "=f"(f1305) : "f"(f302), "f"(f1532));
  // PTX:2420 fma.rn.f32 %f1306, %f301, %f1533, %f1305
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1306) : "f"(f301), "f"(f1533), "f"(f1305));
  // PTX:2421 fma.rn.f32 %f1307, %f303, %f1531, %f1306
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1307) : "f"(f303), "f"(f1531), "f"(f1306));
  // PTX:2422 sub.f32 %f310, %f1304, %f1307
  asm("sub.f32 %0, %1, %2;" : "=f"(f310) : "f"(f1304), "f"(f1307));
  // PTX:2423 abs.f32 %f1308, %f310
  asm("abs.f32 %0, %1;" : "=f"(f1308) : "f"(f310));
  // PTX:2424 setp.geu.f32 %p132, %f1308, 0f7F800000
  p132 = ((isnan(((float)(f1308))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1308)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2425 setp.le.f32 %p133, %f310, 0f00000000
  p133 = (!(isnan(((float)(f310))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f310)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:2426 or.pred %p134, %p132, %p133
  p134 = ((p132) || (p133));
  // PTX:2427 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:2428 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:2429 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:2430 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:2431 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:2432 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:2433 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:2434 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:2435 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:2436 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:2437 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:2438 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:2439 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:2440 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:2441 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:2442 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:2443 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:2444 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:2445 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:2446 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:2447 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:2448 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:2449 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:2450 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:2451 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:2452 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:2453 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:2454 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:2455 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:2456 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:2457 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:2458 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:2459 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:2460 @%p134 bra $L__BB7_164
  if (p134) { goto L_BB7_164; }
  // PTX:2462 add.s64 %rd306, %rd42, %rd222
  asm("add.s64 %0, %1, %2;" : "=l"(rd306) : "l"(rd42), "l"(rd222));
  // PTX:2463 ld.global.f32 %f1309, [%rd306]
  f1309 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd306) + (0)))));
  // PTX:2464 min.f32 %f311, %f401, %f1309
  asm("min.f32 %0, %1, %2;" : "=f"(f311) : "f"(f401), "f"(f1309));
  // PTX:2465 add.s64 %rd307, %rd43, %rd222
  asm("add.s64 %0, %1, %2;" : "=l"(rd307) : "l"(rd43), "l"(rd222));
  // PTX:2466 ld.global.f32 %f1310, [%rd307]
  f1310 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd307) + (0)))));
  // PTX:2467 min.f32 %f1558, %f402, %f1310
  asm("min.f32 %0, %1, %2;" : "=f"(f1558) : "f"(f402), "f"(f1310));
  // PTX:2468 setp.leu.f32 %p135, %f1503, 0f00000000
  p135 = ((isnan(((float)(f1503))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f1503)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:2469 @%p135 bra $L__BB7_156
  if (p135) { goto L_BB7_156; }
  // PTX:2471 div.rn.f32 %f1311, %f311, %f1503
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f1311) : "f"(f311), "f"(f1503));
  // PTX:2472 sqrt.rn.f32 %f1312, %f1311
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f1312) : "f"(f1311));
  // PTX:2473 add.f32 %f1313, %f1312, %f1312
  asm("add.f32 %0, %1, %2;" : "=f"(f1313) : "f"(f1312), "f"(f1312));
  // PTX:2474 min.f32 %f1558, %f1558, %f1313
  asm("min.f32 %0, %1, %2;" : "=f"(f1558) : "f"(f1558), "f"(f1313));
  // PTX:2476 $L__BB7_156:
L_BB7_156:;
  // PTX:2477 mul.f32 %f1329, %f304, %f1533
  asm("mul.f32 %0, %1, %2;" : "=f"(f1329) : "f"(f304), "f"(f1533));
  // PTX:2478 fma.rn.f32 %f1330, %f305, %f1532, %f1329
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1330) : "f"(f305), "f"(f1532), "f"(f1329));
  // PTX:2479 fma.rn.f32 %f315, %f306, %f1531, %f1330
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f315) : "f"(f306), "f"(f1531), "f"(f1330));
  // PTX:2480 abs.f32 %f1331, %f315
  asm("abs.f32 %0, %1;" : "=f"(f1331) : "f"(f315));
  // PTX:2481 setp.geu.f32 %p136, %f1331, 0f7F800000
  p136 = ((isnan(((float)(f1331))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1331)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2482 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:2483 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:2484 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:2485 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:2486 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:2487 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:2488 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:2489 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:2490 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:2491 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:2492 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:2493 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:2494 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:2495 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:2496 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:2497 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:2498 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:2499 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:2500 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:2501 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:2502 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:2503 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:2504 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:2505 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:2506 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:2507 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:2508 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:2509 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:2510 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:2511 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:2512 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:2513 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:2514 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:2515 @%p136 bra $L__BB7_164
  if (p136) { goto L_BB7_164; }
  // PTX:2517 div.rn.f32 %f1347, %f315, %f1
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f1347) : "f"(f315), "f"(f1));
  // PTX:2518 add.f32 %f1348, %f310, %f1347
  asm("add.f32 %0, %1, %2;" : "=f"(f1348) : "f"(f310), "f"(f1347));
  // PTX:2519 mov.f32 %f1346, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1346) : );
  // PTX:2520 max.f32 %f1349, %f1348, %f1346
  asm("max.f32 %0, %1, %2;" : "=f"(f1349) : "f"(f1348), "f"(f1346));
  // PTX:2521 sub.f32 %f1350, %f310, %f1349
  asm("sub.f32 %0, %1, %2;" : "=f"(f1350) : "f"(f310), "f"(f1349));
  // PTX:2522 mul.f32 %f316, %f1558, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f316) : "f"(f1558), "f"(f1));
  // PTX:2523 mul.f32 %f1351, %f316, %f1350
  asm("mul.f32 %0, %1, %2;" : "=f"(f1351) : "f"(f316), "f"(f1350));
  // PTX:2524 fma.rn.f32 %f1352, %f310, %f311, %f1351
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1352) : "f"(f310), "f"(f311), "f"(f1351));
  // PTX:2525 max.f32 %f317, %f1352, %f1346
  asm("max.f32 %0, %1, %2;" : "=f"(f317) : "f"(f1352), "f"(f1346));
  // PTX:2526 setp.le.f32 %p137, %f317, 0f00000000
  p137 = (!(isnan(((float)(f317))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f317)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:2527 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:2528 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:2529 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:2530 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:2531 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:2532 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:2533 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:2534 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:2535 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:2536 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:2537 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:2538 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:2539 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:2540 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:2541 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:2542 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:2543 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:2544 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:2545 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:2546 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:2547 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:2548 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:2549 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:2550 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:2551 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:2552 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:2553 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:2554 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:2555 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:2556 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:2557 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:2558 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:2559 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:2560 @%p137 bra $L__BB7_164
  if (p137) { goto L_BB7_164; }
  // PTX:2562 mul.f32 %f1368, %f307, %f1533
  asm("mul.f32 %0, %1, %2;" : "=f"(f1368) : "f"(f307), "f"(f1533));
  // PTX:2563 fma.rn.f32 %f1369, %f308, %f1532, %f1368
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1369) : "f"(f308), "f"(f1532), "f"(f1368));
  // PTX:2564 fma.rn.f32 %f1370, %f309, %f1531, %f1369
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1370) : "f"(f309), "f"(f1531), "f"(f1369));
  // PTX:2565 mul.f32 %f1371, %f1370, %f1533
  asm("mul.f32 %0, %1, %2;" : "=f"(f1371) : "f"(f1370), "f"(f1533));
  // PTX:2566 mul.f32 %f1372, %f1370, %f1532
  asm("mul.f32 %0, %1, %2;" : "=f"(f1372) : "f"(f1370), "f"(f1532));
  // PTX:2567 mul.f32 %f1373, %f1370, %f1531
  asm("mul.f32 %0, %1, %2;" : "=f"(f1373) : "f"(f1370), "f"(f1531));
  // PTX:2568 sub.f32 %f318, %f307, %f1371
  asm("sub.f32 %0, %1, %2;" : "=f"(f318) : "f"(f307), "f"(f1371));
  // PTX:2569 sub.f32 %f319, %f308, %f1372
  asm("sub.f32 %0, %1, %2;" : "=f"(f319) : "f"(f308), "f"(f1372));
  // PTX:2570 sub.f32 %f320, %f309, %f1373
  asm("sub.f32 %0, %1, %2;" : "=f"(f320) : "f"(f309), "f"(f1373));
  // PTX:2571 mul.f32 %f1374, %f319, %f319
  asm("mul.f32 %0, %1, %2;" : "=f"(f1374) : "f"(f319), "f"(f319));
  // PTX:2572 fma.rn.f32 %f1375, %f318, %f318, %f1374
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1375) : "f"(f318), "f"(f318), "f"(f1374));
  // PTX:2573 fma.rn.f32 %f1376, %f320, %f320, %f1375
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1376) : "f"(f320), "f"(f320), "f"(f1375));
  // PTX:2574 sqrt.rn.f32 %f321, %f1376
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f321) : "f"(f1376));
  // PTX:2575 abs.f32 %f1377, %f321
  asm("abs.f32 %0, %1;" : "=f"(f1377) : "f"(f321));
  // PTX:2576 setp.geu.f32 %p138, %f1377, 0f7F800000
  p138 = ((isnan(((float)(f1377))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1377)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2577 mov.u32 %r1836, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1836) : "r"(r1835));
  // PTX:2578 mov.u32 %r1837, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1837) : "r"(r1835));
  // PTX:2579 mov.u32 %r1838, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1835));
  // PTX:2580 mov.u32 %r1839, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1835));
  // PTX:2581 mov.u32 %r1840, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1835));
  // PTX:2582 mov.u32 %r1841, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1841) : "r"(r1835));
  // PTX:2583 mov.u32 %r1842, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1842) : "r"(r1835));
  // PTX:2584 mov.u32 %r1843, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1843) : "r"(r1835));
  // PTX:2585 mov.u32 %r1844, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1835));
  // PTX:2586 mov.u32 %r1845, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1835));
  // PTX:2587 mov.u32 %r1846, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1835));
  // PTX:2588 mov.u32 %r1847, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1847) : "r"(r1835));
  // PTX:2589 mov.u32 %r1848, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1848) : "r"(r1835));
  // PTX:2590 mov.u32 %r1849, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1849) : "r"(r1835));
  // PTX:2591 mov.u32 %r1850, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1835));
  // PTX:2592 mov.u32 %r1851, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1835));
  // PTX:2593 mov.u32 %r1852, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1835));
  // PTX:2594 mov.u32 %r1853, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1835));
  // PTX:2595 mov.u32 %r1854, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1835));
  // PTX:2596 mov.u32 %r1855, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1835));
  // PTX:2597 mov.u32 %r1856, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1835));
  // PTX:2598 mov.u32 %r1857, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1835));
  // PTX:2599 mov.u32 %r1858, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1835));
  // PTX:2600 mov.u32 %r1859, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1835));
  // PTX:2601 mov.u32 %r1860, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1835));
  // PTX:2602 mov.u32 %r1861, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1835));
  // PTX:2603 mov.u32 %r1862, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1835));
  // PTX:2604 mov.u32 %r1863, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1835));
  // PTX:2605 mov.u32 %r1864, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1835));
  // PTX:2606 mov.u32 %r1865, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1835));
  // PTX:2607 mov.u32 %r1866, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1835));
  // PTX:2608 mov.u32 %r1867, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1835));
  // PTX:2609 mov.u32 %r1868, %r1835
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1835));
  // PTX:2610 @%p138 bra $L__BB7_164
  if (p138) { goto L_BB7_164; }
  // PTX:2612 add.s64 %rd309, %rd44, %rd222
  asm("add.s64 %0, %1, %2;" : "=l"(rd309) : "l"(rd44), "l"(rd222));
  // PTX:2613 ld.global.f32 %f1379, [%rd309]
  f1379 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd309) + (0)))));
  // PTX:2614 min.f32 %f1380, %f404, %f1379
  asm("min.f32 %0, %1, %2;" : "=f"(f1380) : "f"(f404), "f"(f1379));
  // PTX:2615 mul.f32 %f322, %f317, %f1380
  asm("mul.f32 %0, %1, %2;" : "=f"(f322) : "f"(f317), "f"(f1380));
  // PTX:2616 setp.leu.f32 %p139, %f322, 0f00000000
  p139 = ((isnan(((float)(f322))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f322)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:2617 mov.f32 %f1378, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1378) : );
  // PTX:2618 mov.f32 %f1559, %f1378
  asm("mov.f32 %0, %1;" : "=f"(f1559) : "f"(f1378));
  // PTX:2619 @%p139 bra $L__BB7_161
  if (p139) { goto L_BB7_161; }
  // PTX:2621 add.s64 %rd311, %rd45, %rd222
  asm("add.s64 %0, %1, %2;" : "=l"(rd311) : "l"(rd45), "l"(rd222));
  // PTX:2622 ld.global.f32 %f1381, [%rd311]
  f1381 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd311) + (0)))));
  // PTX:2623 mov.f32 %f1382, 0f322BCC77
  asm("mov.f32 %0, 0f322BCC77;" : "=f"(f1382) : );
  // PTX:2624 max.f32 %f1383, %f321, %f1382
  asm("max.f32 %0, %1, %2;" : "=f"(f1383) : "f"(f321), "f"(f1382));
  // PTX:2625 div.rn.f32 %f1384, %f322, %f1383
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f1384) : "f"(f322), "f"(f1383));
  // PTX:2626 min.f32 %f1385, %f403, %f1381
  asm("min.f32 %0, %1, %2;" : "=f"(f1385) : "f"(f403), "f"(f1381));
  // PTX:2627 min.f32 %f1559, %f1385, %f1384
  asm("min.f32 %0, %1, %2;" : "=f"(f1559) : "f"(f1385), "f"(f1384));
  // PTX:2629 $L__BB7_161:
L_BB7_161:;
  // PTX:2630 mul.f32 %f1469, %f1531, %f1531
  asm("mul.f32 %0, %1, %2;" : "=f"(f1469) : "f"(f1531), "f"(f1531));
  // PTX:2631 mul.f32 %f1468, %f1532, %f1532
  asm("mul.f32 %0, %1, %2;" : "=f"(f1468) : "f"(f1532), "f"(f1532));
  // PTX:2632 mul.f32 %f1467, %f1533, %f1533
  asm("mul.f32 %0, %1, %2;" : "=f"(f1467) : "f"(f1533), "f"(f1533));
  // PTX:2633 mul.f32 %f1386, %f1532, %f1533
  asm("mul.f32 %0, %1, %2;" : "=f"(f1386) : "f"(f1532), "f"(f1533));
  // PTX:2634 mul.f32 %f1387, %f1531, %f1533
  asm("mul.f32 %0, %1, %2;" : "=f"(f1387) : "f"(f1531), "f"(f1533));
  // PTX:2635 mul.f32 %f1388, %f1531, %f1532
  asm("mul.f32 %0, %1, %2;" : "=f"(f1388) : "f"(f1531), "f"(f1532));
  // PTX:2636 mul.f32 %f1389, %f317, %f1533
  asm("mul.f32 %0, %1, %2;" : "=f"(f1389) : "f"(f317), "f"(f1533));
  // PTX:2637 st.local.f32 [%rd2+120], %f1389
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (120))))) = (float)(f1389);
  // PTX:2638 mul.f32 %f1390, %f317, %f1532
  asm("mul.f32 %0, %1, %2;" : "=f"(f1390) : "f"(f317), "f"(f1532));
  // PTX:2639 st.local.f32 [%rd2+124], %f1390
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (124))))) = (float)(f1390);
  // PTX:2640 mul.f32 %f1391, %f317, %f1531
  asm("mul.f32 %0, %1, %2;" : "=f"(f1391) : "f"(f317), "f"(f1531));
  // PTX:2641 st.local.f32 [%rd2+128], %f1391
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (128))))) = (float)(f1391);
  // PTX:2642 neg.f32 %f1392, %f1559
  asm("neg.f32 %0, %1;" : "=f"(f1392) : "f"(f1559));
  // PTX:2643 mul.f32 %f1393, %f318, %f1392
  asm("mul.f32 %0, %1, %2;" : "=f"(f1393) : "f"(f318), "f"(f1392));
  // PTX:2644 mul.f32 %f1394, %f319, %f1392
  asm("mul.f32 %0, %1, %2;" : "=f"(f1394) : "f"(f319), "f"(f1392));
  // PTX:2645 mul.f32 %f1395, %f320, %f1392
  asm("mul.f32 %0, %1, %2;" : "=f"(f1395) : "f"(f320), "f"(f1392));
  // PTX:2646 st.local.f32 [%rd2+132], %f1393
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (132))))) = (float)(f1393);
  // PTX:2647 st.local.f32 [%rd2+136], %f1394
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (136))))) = (float)(f1394);
  // PTX:2648 st.local.f32 [%rd2+140], %f1395
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (140))))) = (float)(f1395);
  // PTX:2649 add.f32 %f1574, %f311, %f316
  asm("add.f32 %0, %1, %2;" : "=f"(f1574) : "f"(f311), "f"(f316));
  // PTX:2650 st.local.f32 [%rd2+216], %f1574
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (216))))) = (float)(f1574);
  // PTX:2651 mul.f32 %f1396, %f1574, %f1467
  asm("mul.f32 %0, %1, %2;" : "=f"(f1396) : "f"(f1574), "f"(f1467));
  // PTX:2652 mul.f32 %f1397, %f1574, %f1386
  asm("mul.f32 %0, %1, %2;" : "=f"(f1397) : "f"(f1574), "f"(f1386));
  // PTX:2653 mul.f32 %f1398, %f1574, %f1387
  asm("mul.f32 %0, %1, %2;" : "=f"(f1398) : "f"(f1574), "f"(f1387));
  // PTX:2654 mul.f32 %f1399, %f1574, %f1468
  asm("mul.f32 %0, %1, %2;" : "=f"(f1399) : "f"(f1574), "f"(f1468));
  // PTX:2655 mul.f32 %f1400, %f1574, %f1388
  asm("mul.f32 %0, %1, %2;" : "=f"(f1400) : "f"(f1574), "f"(f1388));
  // PTX:2656 mul.f32 %f1401, %f1574, %f1469
  asm("mul.f32 %0, %1, %2;" : "=f"(f1401) : "f"(f1574), "f"(f1469));
  // PTX:2657 st.local.f32 [%rd2+144], %f1396
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (144))))) = (float)(f1396);
  // PTX:2658 st.local.f32 [%rd2+148], %f1397
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (148))))) = (float)(f1397);
  // PTX:2659 st.local.f32 [%rd2+152], %f1398
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (152))))) = (float)(f1398);
  // PTX:2660 st.local.f32 [%rd2+156], %f1397
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (156))))) = (float)(f1397);
  // PTX:2661 st.local.f32 [%rd2+160], %f1399
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (160))))) = (float)(f1399);
  // PTX:2662 st.local.f32 [%rd2+164], %f1400
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (164))))) = (float)(f1400);
  // PTX:2663 st.local.f32 [%rd2+168], %f1398
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (168))))) = (float)(f1398);
  // PTX:2664 st.local.f32 [%rd2+172], %f1400
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (172))))) = (float)(f1400);
  // PTX:2665 st.local.f32 [%rd2+176], %f1401
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (176))))) = (float)(f1401);
  // PTX:2666 mul.f32 %f1402, %f1559, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f1402) : "f"(f1559), "f"(f1));
  // PTX:2667 mov.f32 %f1403, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f1403) : );
  // PTX:2668 sub.f32 %f1404, %f1403, %f1467
  asm("sub.f32 %0, %1, %2;" : "=f"(f1404) : "f"(f1403), "f"(f1467));
  // PTX:2669 mul.f32 %f1405, %f1404, %f1402
  asm("mul.f32 %0, %1, %2;" : "=f"(f1405) : "f"(f1404), "f"(f1402));
  // PTX:2670 sub.f32 %f1407, %f1378, %f1386
  asm("sub.f32 %0, %1, %2;" : "=f"(f1407) : "f"(f1378), "f"(f1386));
  // PTX:2671 mul.f32 %f1408, %f1407, %f1402
  asm("mul.f32 %0, %1, %2;" : "=f"(f1408) : "f"(f1407), "f"(f1402));
  // PTX:2672 sub.f32 %f1409, %f1378, %f1387
  asm("sub.f32 %0, %1, %2;" : "=f"(f1409) : "f"(f1378), "f"(f1387));
  // PTX:2673 mul.f32 %f1410, %f1409, %f1402
  asm("mul.f32 %0, %1, %2;" : "=f"(f1410) : "f"(f1409), "f"(f1402));
  // PTX:2674 sub.f32 %f1411, %f1403, %f1468
  asm("sub.f32 %0, %1, %2;" : "=f"(f1411) : "f"(f1403), "f"(f1468));
  // PTX:2675 mul.f32 %f1412, %f1411, %f1402
  asm("mul.f32 %0, %1, %2;" : "=f"(f1412) : "f"(f1411), "f"(f1402));
  // PTX:2676 sub.f32 %f1413, %f1378, %f1388
  asm("sub.f32 %0, %1, %2;" : "=f"(f1413) : "f"(f1378), "f"(f1388));
  // PTX:2677 mul.f32 %f1414, %f1413, %f1402
  asm("mul.f32 %0, %1, %2;" : "=f"(f1414) : "f"(f1413), "f"(f1402));
  // PTX:2678 sub.f32 %f1415, %f1403, %f1469
  asm("sub.f32 %0, %1, %2;" : "=f"(f1415) : "f"(f1403), "f"(f1469));
  // PTX:2679 mul.f32 %f1416, %f1415, %f1402
  asm("mul.f32 %0, %1, %2;" : "=f"(f1416) : "f"(f1415), "f"(f1402));
  // PTX:2680 st.local.f32 [%rd2+180], %f1405
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (180))))) = (float)(f1405);
  // PTX:2681 st.local.f32 [%rd2+184], %f1408
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (184))))) = (float)(f1408);
  // PTX:2682 st.local.f32 [%rd2+188], %f1410
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (188))))) = (float)(f1410);
  // PTX:2683 st.local.f32 [%rd2+192], %f1408
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (192))))) = (float)(f1408);
  // PTX:2684 st.local.f32 [%rd2+196], %f1412
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (196))))) = (float)(f1412);
  // PTX:2685 st.local.f32 [%rd2+200], %f1414
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (200))))) = (float)(f1414);
  // PTX:2686 st.local.f32 [%rd2+204], %f1410
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (204))))) = (float)(f1410);
  // PTX:2687 st.local.f32 [%rd2+208], %f1414
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (208))))) = (float)(f1414);
  // PTX:2688 st.local.f32 [%rd2+212], %f1416
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (212))))) = (float)(f1416);
  // PTX:2689 mov.b32 %r1868, %f1416
  asm("mov.b32 %0, %1;" : "=r"(r1868) : "f"(f1416));
  // PTX:2690 mov.b32 %r1866, %f1412
  asm("mov.b32 %0, %1;" : "=r"(r1866) : "f"(f1412));
  // PTX:2691 mov.b32 %r1863, %f1405
  asm("mov.b32 %0, %1;" : "=r"(r1863) : "f"(f1405));
  // PTX:2692 mov.b32 %r1861, %f1400
  asm("mov.b32 %0, %1;" : "=r"(r1861) : "f"(f1400));
  // PTX:2693 mov.b32 %r1859, %f1398
  asm("mov.b32 %0, %1;" : "=r"(r1859) : "f"(f1398));
  // PTX:2694 mov.b32 %r1858, %f1397
  asm("mov.b32 %0, %1;" : "=r"(r1858) : "f"(f1397));
  // PTX:2695 mov.b32 %r1867, %f1414
  asm("mov.b32 %0, %1;" : "=r"(r1867) : "f"(f1414));
  // PTX:2696 mov.b32 %r1865, %f1410
  asm("mov.b32 %0, %1;" : "=r"(r1865) : "f"(f1410));
  // PTX:2697 mov.b32 %r1864, %f1408
  asm("mov.b32 %0, %1;" : "=r"(r1864) : "f"(f1408));
  // PTX:2698 mov.b32 %r1853, %f1391
  asm("mov.b32 %0, %1;" : "=r"(r1853) : "f"(f1391));
  // PTX:2699 mov.b32 %r1852, %f1390
  asm("mov.b32 %0, %1;" : "=r"(r1852) : "f"(f1390));
  // PTX:2700 mov.b32 %r1851, %f1389
  asm("mov.b32 %0, %1;" : "=r"(r1851) : "f"(f1389));
  // PTX:2701 mov.b32 %r1862, %f1401
  asm("mov.b32 %0, %1;" : "=r"(r1862) : "f"(f1401));
  // PTX:2702 mov.b32 %r1860, %f1399
  asm("mov.b32 %0, %1;" : "=r"(r1860) : "f"(f1399));
  // PTX:2703 mov.b32 %r1857, %f1396
  asm("mov.b32 %0, %1;" : "=r"(r1857) : "f"(f1396));
  // PTX:2704 mov.b32 %r1856, %f1395
  asm("mov.b32 %0, %1;" : "=r"(r1856) : "f"(f1395));
  // PTX:2705 mov.b32 %r1855, %f1394
  asm("mov.b32 %0, %1;" : "=r"(r1855) : "f"(f1394));
  // PTX:2706 mov.b32 %r1854, %f1393
  asm("mov.b32 %0, %1;" : "=r"(r1854) : "f"(f1393));
  // PTX:2707 ld.local.u32 %r1850, [%rd2+116]
  r1850 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:2708 ld.local.f32 %f1573, [%rd2+112]
  f1573 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (112)))));
  // PTX:2709 ld.local.f32 %f1572, [%rd2+108]
  f1572 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (108)))));
  // PTX:2710 ld.local.f32 %f1571, [%rd2+104]
  f1571 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (104)))));
  // PTX:2711 ld.local.f32 %f1570, [%rd2+100]
  f1570 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (100)))));
  // PTX:2712 ld.local.f32 %f1569, [%rd2+96]
  f1569 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (96)))));
  // PTX:2713 ld.local.f32 %f1568, [%rd2+92]
  f1568 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (92)))));
  // PTX:2714 ld.local.f32 %f1567, [%rd2+88]
  f1567 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (88)))));
  // PTX:2715 ld.local.u32 %r1849, [%rd2+84]
  r1849 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (84)))));
  // PTX:2716 ld.local.u32 %r1848, [%rd2+80]
  r1848 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (80)))));
  // PTX:2717 ld.local.u32 %r1847, [%rd2+76]
  r1847 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (76)))));
  // PTX:2718 ld.local.u32 %r1846, [%rd2+72]
  r1846 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (72)))));
  // PTX:2719 ld.local.u32 %r1845, [%rd2+68]
  r1845 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (68)))));
  // PTX:2720 ld.local.u32 %r1844, [%rd2+64]
  r1844 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (64)))));
  // PTX:2721 ld.local.u32 %r1843, [%rd2+60]
  r1843 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (60)))));
  // PTX:2722 ld.local.u32 %r1842, [%rd2+56]
  r1842 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:2723 ld.local.f32 %f1566, [%rd2+52]
  f1566 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (52)))));
  // PTX:2724 ld.local.f32 %f1565, [%rd2+48]
  f1565 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (48)))));
  // PTX:2725 ld.local.f32 %f1564, [%rd2+44]
  f1564 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (44)))));
  // PTX:2726 ld.local.f32 %f1563, [%rd2+40]
  f1563 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (40)))));
  // PTX:2727 ld.local.f32 %f1562, [%rd2+36]
  f1562 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (36)))));
  // PTX:2728 ld.local.f32 %f1561, [%rd2+32]
  f1561 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (32)))));
  // PTX:2729 ld.local.f32 %f1560, [%rd2+28]
  f1560 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (28)))));
  // PTX:2730 ld.local.u32 %r1841, [%rd2+24]
  r1841 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (24)))));
  // PTX:2731 ld.local.u32 %r1840, [%rd2+20]
  r1840 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (20)))));
  // PTX:2732 ld.local.u32 %r1839, [%rd2+16]
  r1839 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (16)))));
  // PTX:2733 ld.local.u32 %r1838, [%rd2+12]
  r1838 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (12)))));
  // PTX:2734 ld.local.u32 %r1837, [%rd2+8]
  r1837 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (8)))));
  // PTX:2735 ld.local.u32 %r1836, [%rd2+4]
  r1836 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (4)))));
  // PTX:2736 ld.local.u32 %r1835, [%rd2]
  r1835 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (0)))));
  // PTX:2737 bra.uni $L__BB7_164
  goto L_BB7_164;
  // PTX:2739 $L__BB7_2:
L_BB7_2:;
  // PTX:2740 mov.u32 %r1842, 0
  asm("mov.u32 %0, 0;" : "=r"(r1842) : );
  // PTX:2741 st.local.u32 [%rd2+56], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56))))) = (unsigned)(r1842);
  // PTX:2742 st.local.u32 [%rd2+116], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116))))) = (unsigned)(r1842);
  // PTX:2743 st.local.u32 [%rd2+120], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (120))))) = (unsigned)(r1842);
  // PTX:2744 st.local.u32 [%rd2+124], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (124))))) = (unsigned)(r1842);
  // PTX:2745 st.local.u32 [%rd2+128], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (128))))) = (unsigned)(r1842);
  // PTX:2746 st.local.u32 [%rd2+132], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (132))))) = (unsigned)(r1842);
  // PTX:2747 st.local.u32 [%rd2+136], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (136))))) = (unsigned)(r1842);
  // PTX:2748 st.local.u32 [%rd2+140], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (140))))) = (unsigned)(r1842);
  // PTX:2749 st.local.u32 [%rd2+144], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (144))))) = (unsigned)(r1842);
  // PTX:2750 st.local.u32 [%rd2+148], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (148))))) = (unsigned)(r1842);
  // PTX:2751 st.local.u32 [%rd2+152], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (152))))) = (unsigned)(r1842);
  // PTX:2752 st.local.u32 [%rd2+156], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (156))))) = (unsigned)(r1842);
  // PTX:2753 st.local.u32 [%rd2+160], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (160))))) = (unsigned)(r1842);
  // PTX:2754 st.local.u32 [%rd2+164], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (164))))) = (unsigned)(r1842);
  // PTX:2755 st.local.u32 [%rd2+168], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (168))))) = (unsigned)(r1842);
  // PTX:2756 st.local.u32 [%rd2+172], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (172))))) = (unsigned)(r1842);
  // PTX:2757 st.local.u32 [%rd2+176], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (176))))) = (unsigned)(r1842);
  // PTX:2758 st.local.u32 [%rd2+180], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (180))))) = (unsigned)(r1842);
  // PTX:2759 st.local.u32 [%rd2+184], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (184))))) = (unsigned)(r1842);
  // PTX:2760 st.local.u32 [%rd2+188], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (188))))) = (unsigned)(r1842);
  // PTX:2761 st.local.u32 [%rd2+192], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (192))))) = (unsigned)(r1842);
  // PTX:2762 st.local.u32 [%rd2+196], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (196))))) = (unsigned)(r1842);
  // PTX:2763 st.local.u32 [%rd2+200], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (200))))) = (unsigned)(r1842);
  // PTX:2764 st.local.u32 [%rd2+204], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (204))))) = (unsigned)(r1842);
  // PTX:2765 st.local.u32 [%rd2+208], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (208))))) = (unsigned)(r1842);
  // PTX:2766 st.local.u32 [%rd2+212], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (212))))) = (unsigned)(r1842);
  // PTX:2767 st.local.u32 [%rd2+216], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (216))))) = (unsigned)(r1842);
  // PTX:2768 setp.eq.s64 %p2, %rd36, 0
  p2 = (((long long)(rd36)) == ((long long)(0)));
  // PTX:2769 mov.f32 %f1574, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1574) : );
  // PTX:2770 @%p2 bra $L__BB7_163
  if (p2) { goto L_BB7_163; }
  // PTX:2772 setp.eq.s64 %p3, %rd13, 0
  p3 = (((long long)(rd13)) == ((long long)(0)));
  // PTX:2773 shl.b64 %rd137, %rd352, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd137) : "l"(rd352));
  // PTX:2774 add.s64 %rd48, %rd8, %rd137
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd8), "l"(rd137));
  // PTX:2775 ld.global.s32 %rd49, [%rd48]
  rd49 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:2776 setp.lt.s64 %p4, %rd49, 0
  p4 = (((long long)(rd49)) < ((long long)(0)));
  // PTX:2777 or.pred %p5, %p4, %p3
  p5 = ((p4) || (p3));
  // PTX:2778 @%p5 bra $L__BB7_7
  if (p5) { goto L_BB7_7; }
  // PTX:2780 setp.le.u64 %p6, %rd10, %rd49
  p6 = (((unsigned long long)(rd10)) <= ((unsigned long long)(rd49)));
  // PTX:2781 @%p6 bra $L__BB7_7
  if (p6) { goto L_BB7_7; }
  // PTX:2783 shl.b64 %rd138, %rd49, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd138) : "l"(rd49));
  // PTX:2784 add.s64 %rd139, %rd14, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd139) : "l"(rd14), "l"(rd138));
  // PTX:2785 ld.global.u32 %r459, [%rd139]
  r459 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd139) + (0)))));
  // PTX:2786 setp.eq.s32 %p7, %r459, 0
  p7 = (((int)(r459)) == ((int)(0)));
  // PTX:2787 @%p7 bra $L__BB7_7
  if (p7) { goto L_BB7_7; }
  // PTX:2789 ld.local.f32 %f1573, [%rd2+112]
  f1573 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (112)))));
  // PTX:2790 ld.local.f32 %f1572, [%rd2+108]
  f1572 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (108)))));
  // PTX:2791 ld.local.f32 %f1571, [%rd2+104]
  f1571 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (104)))));
  // PTX:2792 ld.local.f32 %f1570, [%rd2+100]
  f1570 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (100)))));
  // PTX:2793 ld.local.f32 %f1569, [%rd2+96]
  f1569 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (96)))));
  // PTX:2794 ld.local.f32 %f1568, [%rd2+92]
  f1568 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (92)))));
  // PTX:2795 ld.local.f32 %f1567, [%rd2+88]
  f1567 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (88)))));
  // PTX:2796 ld.local.u32 %r1849, [%rd2+84]
  r1849 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (84)))));
  // PTX:2797 ld.local.u32 %r1848, [%rd2+80]
  r1848 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (80)))));
  // PTX:2798 ld.local.u32 %r1847, [%rd2+76]
  r1847 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (76)))));
  // PTX:2799 ld.local.u32 %r1846, [%rd2+72]
  r1846 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (72)))));
  // PTX:2800 ld.local.u32 %r1845, [%rd2+68]
  r1845 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (68)))));
  // PTX:2801 ld.local.u32 %r1844, [%rd2+64]
  r1844 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (64)))));
  // PTX:2802 ld.local.u32 %r1843, [%rd2+60]
  r1843 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (60)))));
  // PTX:2803 ld.local.f32 %f1566, [%rd2+52]
  f1566 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (52)))));
  // PTX:2804 ld.local.f32 %f1565, [%rd2+48]
  f1565 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (48)))));
  // PTX:2805 ld.local.f32 %f1564, [%rd2+44]
  f1564 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (44)))));
  // PTX:2806 ld.local.f32 %f1563, [%rd2+40]
  f1563 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (40)))));
  // PTX:2807 ld.local.f32 %f1562, [%rd2+36]
  f1562 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (36)))));
  // PTX:2808 ld.local.f32 %f1561, [%rd2+32]
  f1561 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (32)))));
  // PTX:2809 ld.local.f32 %f1560, [%rd2+28]
  f1560 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (28)))));
  // PTX:2810 ld.local.u32 %r1841, [%rd2+24]
  r1841 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (24)))));
  // PTX:2811 ld.local.u32 %r1840, [%rd2+20]
  r1840 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (20)))));
  // PTX:2812 ld.local.u32 %r1839, [%rd2+16]
  r1839 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (16)))));
  // PTX:2813 ld.local.u32 %r1838, [%rd2+12]
  r1838 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (12)))));
  // PTX:2814 ld.local.u32 %r1837, [%rd2+8]
  r1837 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (8)))));
  // PTX:2815 ld.local.u32 %r1836, [%rd2+4]
  r1836 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (4)))));
  // PTX:2816 mov.u32 %r1850, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1842));
  // PTX:2817 mov.u32 %r1851, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1842));
  // PTX:2818 mov.u32 %r1852, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1842));
  // PTX:2819 mov.u32 %r1853, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1842));
  // PTX:2820 mov.u32 %r1854, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1842));
  // PTX:2821 mov.u32 %r1855, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1842));
  // PTX:2822 mov.u32 %r1856, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1842));
  // PTX:2823 mov.u32 %r1857, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1842));
  // PTX:2824 mov.u32 %r1858, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1842));
  // PTX:2825 mov.u32 %r1859, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1842));
  // PTX:2826 mov.u32 %r1860, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1842));
  // PTX:2827 mov.u32 %r1861, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1842));
  // PTX:2828 mov.u32 %r1862, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1842));
  // PTX:2829 mov.u32 %r1863, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1842));
  // PTX:2830 mov.u32 %r1864, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1842));
  // PTX:2831 mov.u32 %r1865, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1842));
  // PTX:2832 mov.u32 %r1866, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1842));
  // PTX:2833 mov.u32 %r1867, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1842));
  // PTX:2834 mov.u32 %r1868, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1842));
  // PTX:2835 bra.uni $L__BB7_164
  goto L_BB7_164;
  // PTX:2837 $L__BB7_7:
L_BB7_7:;
  // PTX:2838 mul.lo.s64 %rd140, %rd352, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd140) : "l"(rd352));
  // PTX:2839 add.s64 %rd141, %rd11, %rd140
  asm("add.s64 %0, %1, %2;" : "=l"(rd141) : "l"(rd11), "l"(rd140));
  // PTX:2840 ld.global.u32 %r42, [%rd141+4]
  r42 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (4)))));
  // PTX:2841 cvt.s64.s32 %rd50, %r42
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd50) : "r"(r42));
  // PTX:2842 ld.global.u32 %r43, [%rd141+8]
  r43 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (8)))));
  // PTX:2843 cvt.s64.s32 %rd51, %r43
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd51) : "r"(r43));
  // PTX:2844 add.s64 %rd142, %rd12, %rd140
  asm("add.s64 %0, %1, %2;" : "=l"(rd142) : "l"(rd12), "l"(rd140));
  // PTX:2845 ld.global.f32 %f21, [%rd142]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd142) + (0)))));
  // PTX:2846 ld.global.f32 %f22, [%rd142+4]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd142) + (4)))));
  // PTX:2847 ld.global.f32 %f23, [%rd142+8]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd142) + (8)))));
  // PTX:2848 ld.global.u32 %r44, [%rd141]
  r44 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd141) + (0)))));
  // PTX:2849 setp.gt.s32 %p8, %r44, -1
  p8 = (((int)(r44)) > ((int)(-1)));
  // PTX:2850 cvt.s64.s32 %rd52, %r44
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd52) : "r"(r44));
  // PTX:2851 setp.gt.u64 %p9, %rd15, %rd52
  p9 = (((unsigned long long)(rd15)) > ((unsigned long long)(rd52)));
  // PTX:2852 and.pred %p10, %p8, %p9
  p10 = ((p8) && (p9));
  // PTX:2853 @%p10 bra $L__BB7_9
  if (p10) { goto L_BB7_9; }
  // PTX:2854 bra.uni $L__BB7_8
  goto L_BB7_8;
  // PTX:2856 $L__BB7_9:
L_BB7_9:;
  // PTX:2857 or.b64 %rd143, %rd52, %rd36
  asm("or.b64 %0, %1, %2;" : "=l"(rd143) : "l"(rd52), "l"(rd36));
  // PTX:2858 and.b64 %rd144, %rd143, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd144) : "l"(rd143));
  // PTX:2859 setp.eq.s64 %p11, %rd144, 0
  p11 = (((long long)(rd144)) == ((long long)(0)));
  // PTX:2860 @%p11 bra $L__BB7_11
  if (p11) { goto L_BB7_11; }
  // PTX:2862 div.u64 %rd353, %rd52, %rd36
  asm("div.u64 %0, %1, %2;" : "=l"(rd353) : "l"(rd52), "l"(rd36));
  // PTX:2863 bra.uni $L__BB7_12
  goto L_BB7_12;
  // PTX:2865 $L__BB7_163:
L_BB7_163:;
  // PTX:2866 ld.local.f32 %f1573, [%rd2+112]
  f1573 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (112)))));
  // PTX:2867 ld.local.f32 %f1572, [%rd2+108]
  f1572 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (108)))));
  // PTX:2868 ld.local.f32 %f1571, [%rd2+104]
  f1571 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (104)))));
  // PTX:2869 ld.local.f32 %f1570, [%rd2+100]
  f1570 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (100)))));
  // PTX:2870 ld.local.f32 %f1569, [%rd2+96]
  f1569 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (96)))));
  // PTX:2871 ld.local.f32 %f1568, [%rd2+92]
  f1568 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (92)))));
  // PTX:2872 ld.local.f32 %f1567, [%rd2+88]
  f1567 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (88)))));
  // PTX:2873 ld.local.u32 %r1849, [%rd2+84]
  r1849 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (84)))));
  // PTX:2874 ld.local.u32 %r1848, [%rd2+80]
  r1848 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (80)))));
  // PTX:2875 ld.local.u32 %r1847, [%rd2+76]
  r1847 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (76)))));
  // PTX:2876 ld.local.u32 %r1846, [%rd2+72]
  r1846 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (72)))));
  // PTX:2877 ld.local.u32 %r1845, [%rd2+68]
  r1845 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (68)))));
  // PTX:2878 ld.local.u32 %r1844, [%rd2+64]
  r1844 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (64)))));
  // PTX:2879 ld.local.u32 %r1843, [%rd2+60]
  r1843 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (60)))));
  // PTX:2880 ld.local.f32 %f1566, [%rd2+52]
  f1566 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (52)))));
  // PTX:2881 ld.local.f32 %f1565, [%rd2+48]
  f1565 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (48)))));
  // PTX:2882 ld.local.f32 %f1564, [%rd2+44]
  f1564 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (44)))));
  // PTX:2883 ld.local.f32 %f1563, [%rd2+40]
  f1563 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (40)))));
  // PTX:2884 ld.local.f32 %f1562, [%rd2+36]
  f1562 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (36)))));
  // PTX:2885 ld.local.f32 %f1561, [%rd2+32]
  f1561 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (32)))));
  // PTX:2886 ld.local.f32 %f1560, [%rd2+28]
  f1560 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (28)))));
  // PTX:2887 ld.local.u32 %r1841, [%rd2+24]
  r1841 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (24)))));
  // PTX:2888 ld.local.u32 %r1840, [%rd2+20]
  r1840 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (20)))));
  // PTX:2889 ld.local.u32 %r1839, [%rd2+16]
  r1839 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (16)))));
  // PTX:2890 ld.local.u32 %r1838, [%rd2+12]
  r1838 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (12)))));
  // PTX:2891 ld.local.u32 %r1837, [%rd2+8]
  r1837 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (8)))));
  // PTX:2892 ld.local.u32 %r1836, [%rd2+4]
  r1836 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (4)))));
  // PTX:2893 mov.u32 %r1850, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1842));
  // PTX:2894 mov.u32 %r1851, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1842));
  // PTX:2895 mov.u32 %r1852, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1842));
  // PTX:2896 mov.u32 %r1853, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1842));
  // PTX:2897 mov.u32 %r1854, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1842));
  // PTX:2898 mov.u32 %r1855, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1842));
  // PTX:2899 mov.u32 %r1856, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1842));
  // PTX:2900 mov.u32 %r1857, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1842));
  // PTX:2901 mov.u32 %r1858, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1842));
  // PTX:2902 mov.u32 %r1859, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1842));
  // PTX:2903 mov.u32 %r1860, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1842));
  // PTX:2904 mov.u32 %r1861, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1842));
  // PTX:2905 mov.u32 %r1862, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1842));
  // PTX:2906 mov.u32 %r1863, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1842));
  // PTX:2907 mov.u32 %r1864, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1842));
  // PTX:2908 mov.u32 %r1865, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1842));
  // PTX:2909 mov.u32 %r1866, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1842));
  // PTX:2910 mov.u32 %r1867, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1842));
  // PTX:2911 mov.u32 %r1868, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1842));
  // PTX:2912 bra.uni $L__BB7_164
  goto L_BB7_164;
  // PTX:2914 $L__BB7_8:
L_BB7_8:;
  // PTX:2915 ld.local.f32 %f1573, [%rd2+112]
  f1573 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (112)))));
  // PTX:2916 ld.local.f32 %f1572, [%rd2+108]
  f1572 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (108)))));
  // PTX:2917 ld.local.f32 %f1571, [%rd2+104]
  f1571 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (104)))));
  // PTX:2918 ld.local.f32 %f1570, [%rd2+100]
  f1570 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (100)))));
  // PTX:2919 ld.local.f32 %f1569, [%rd2+96]
  f1569 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (96)))));
  // PTX:2920 ld.local.f32 %f1568, [%rd2+92]
  f1568 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (92)))));
  // PTX:2921 ld.local.f32 %f1567, [%rd2+88]
  f1567 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (88)))));
  // PTX:2922 ld.local.u32 %r1849, [%rd2+84]
  r1849 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (84)))));
  // PTX:2923 ld.local.u32 %r1848, [%rd2+80]
  r1848 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (80)))));
  // PTX:2924 ld.local.u32 %r1847, [%rd2+76]
  r1847 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (76)))));
  // PTX:2925 ld.local.u32 %r1846, [%rd2+72]
  r1846 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (72)))));
  // PTX:2926 ld.local.u32 %r1845, [%rd2+68]
  r1845 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (68)))));
  // PTX:2927 ld.local.u32 %r1844, [%rd2+64]
  r1844 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (64)))));
  // PTX:2928 ld.local.u32 %r1843, [%rd2+60]
  r1843 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (60)))));
  // PTX:2929 ld.local.f32 %f1566, [%rd2+52]
  f1566 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (52)))));
  // PTX:2930 ld.local.f32 %f1565, [%rd2+48]
  f1565 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (48)))));
  // PTX:2931 ld.local.f32 %f1564, [%rd2+44]
  f1564 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (44)))));
  // PTX:2932 ld.local.f32 %f1563, [%rd2+40]
  f1563 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (40)))));
  // PTX:2933 ld.local.f32 %f1562, [%rd2+36]
  f1562 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (36)))));
  // PTX:2934 ld.local.f32 %f1561, [%rd2+32]
  f1561 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (32)))));
  // PTX:2935 ld.local.f32 %f1560, [%rd2+28]
  f1560 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (28)))));
  // PTX:2936 ld.local.u32 %r1841, [%rd2+24]
  r1841 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (24)))));
  // PTX:2937 ld.local.u32 %r1840, [%rd2+20]
  r1840 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (20)))));
  // PTX:2938 ld.local.u32 %r1839, [%rd2+16]
  r1839 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (16)))));
  // PTX:2939 ld.local.u32 %r1838, [%rd2+12]
  r1838 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (12)))));
  // PTX:2940 ld.local.u32 %r1837, [%rd2+8]
  r1837 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (8)))));
  // PTX:2941 ld.local.u32 %r1836, [%rd2+4]
  r1836 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (4)))));
  // PTX:2942 mov.u32 %r1850, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1842));
  // PTX:2943 mov.u32 %r1851, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1842));
  // PTX:2944 mov.u32 %r1852, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1842));
  // PTX:2945 mov.u32 %r1853, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1842));
  // PTX:2946 mov.u32 %r1854, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1842));
  // PTX:2947 mov.u32 %r1855, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1842));
  // PTX:2948 mov.u32 %r1856, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1842));
  // PTX:2949 mov.u32 %r1857, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1842));
  // PTX:2950 mov.u32 %r1858, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1842));
  // PTX:2951 mov.u32 %r1859, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1842));
  // PTX:2952 mov.u32 %r1860, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1842));
  // PTX:2953 mov.u32 %r1861, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1842));
  // PTX:2954 mov.u32 %r1862, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1842));
  // PTX:2955 mov.u32 %r1863, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1842));
  // PTX:2956 mov.u32 %r1864, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1842));
  // PTX:2957 mov.u32 %r1865, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1842));
  // PTX:2958 mov.u32 %r1866, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1842));
  // PTX:2959 mov.u32 %r1867, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1842));
  // PTX:2960 mov.u32 %r1868, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1842));
  // PTX:2961 bra.uni $L__BB7_164
  goto L_BB7_164;
  // PTX:2963 $L__BB7_11:
L_BB7_11:;
  // PTX:2964 cvt.u32.u64 %r461, %rd52
  asm("cvt.u32.u64 %0, %1;" : "=r"(r461) : "l"(rd52));
  // PTX:2965 div.u32 %r462, %r461, %r1
  asm("div.u32 %0, %1, %2;" : "=r"(r462) : "r"(r461), "r"(r1));
  // PTX:2966 cvt.u64.u32 %rd353, %r462
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd353) : "r"(r462));
  // PTX:2968 $L__BB7_12:
L_BB7_12:;
  // PTX:2969 cvt.u32.u64 %r85, %rd353
  asm("cvt.u32.u64 %0, %1;" : "=r"(r85) : "l"(rd353));
  // PTX:2970 setp.lt.s32 %p12, %r85, 0
  p12 = (((int)(r85)) < ((int)(0)));
  // PTX:2971 @%p12 bra $L__BB7_162
  if (p12) { goto L_BB7_162; }
  // PTX:2973 cvt.s64.s32 %rd56, %rd353
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd56) : "l"(rd353));
  // PTX:2974 setp.ge.u64 %p13, %rd56, %rd18
  p13 = (((unsigned long long)(rd56)) >= ((unsigned long long)(rd18)));
  // PTX:2975 @%p13 bra $L__BB7_162
  if (p13) { goto L_BB7_162; }
  // PTX:2977 ld.global.s32 %rd57, [%rd48]
  rd57 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:2978 setp.lt.s64 %p14, %rd57, 0
  p14 = (((long long)(rd57)) < ((long long)(0)));
  // PTX:2979 @%p14 bra $L__BB7_17
  if (p14) { goto L_BB7_17; }
  // PTX:2981 setp.gt.u64 %p15, %rd19, %rd57
  p15 = (((unsigned long long)(rd19)) > ((unsigned long long)(rd57)));
  // PTX:2982 @%p15 bra $L__BB7_18
  if (p15) { goto L_BB7_18; }
  // PTX:2983 bra.uni $L__BB7_16
  goto L_BB7_16;
  // PTX:2985 $L__BB7_18:
L_BB7_18:;
  // PTX:2986 or.b64 %rd146, %rd57, %rd17
  asm("or.b64 %0, %1, %2;" : "=l"(rd146) : "l"(rd57), "l"(rd17));
  // PTX:2987 and.b64 %rd147, %rd146, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd147) : "l"(rd146));
  // PTX:2988 setp.eq.s64 %p17, %rd147, 0
  p17 = (((long long)(rd147)) == ((long long)(0)));
  // PTX:2989 @%p17 bra $L__BB7_20
  if (p17) { goto L_BB7_20; }
  // PTX:2991 div.u64 %rd354, %rd57, %rd17
  asm("div.u64 %0, %1, %2;" : "=l"(rd354) : "l"(rd57), "l"(rd17));
  // PTX:2992 mul.lo.s64 %rd148, %rd354, %rd17
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd148) : "l"(rd354), "l"(rd17));
  // PTX:2993 sub.s64 %rd356, %rd57, %rd148
  asm("sub.s64 %0, %1, %2;" : "=l"(rd356) : "l"(rd57), "l"(rd148));
  // PTX:2994 bra.uni $L__BB7_21
  goto L_BB7_21;
  // PTX:2996 $L__BB7_162:
L_BB7_162:;
  // PTX:2997 ld.local.f32 %f1573, [%rd2+112]
  f1573 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (112)))));
  // PTX:2998 ld.local.f32 %f1572, [%rd2+108]
  f1572 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (108)))));
  // PTX:2999 ld.local.f32 %f1571, [%rd2+104]
  f1571 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (104)))));
  // PTX:3000 ld.local.f32 %f1570, [%rd2+100]
  f1570 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (100)))));
  // PTX:3001 ld.local.f32 %f1569, [%rd2+96]
  f1569 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (96)))));
  // PTX:3002 ld.local.f32 %f1568, [%rd2+92]
  f1568 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (92)))));
  // PTX:3003 ld.local.f32 %f1567, [%rd2+88]
  f1567 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (88)))));
  // PTX:3004 ld.local.u32 %r1849, [%rd2+84]
  r1849 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (84)))));
  // PTX:3005 ld.local.u32 %r1848, [%rd2+80]
  r1848 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (80)))));
  // PTX:3006 ld.local.u32 %r1847, [%rd2+76]
  r1847 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (76)))));
  // PTX:3007 ld.local.u32 %r1846, [%rd2+72]
  r1846 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (72)))));
  // PTX:3008 ld.local.u32 %r1845, [%rd2+68]
  r1845 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (68)))));
  // PTX:3009 ld.local.u32 %r1844, [%rd2+64]
  r1844 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (64)))));
  // PTX:3010 ld.local.u32 %r1843, [%rd2+60]
  r1843 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (60)))));
  // PTX:3011 ld.local.f32 %f1566, [%rd2+52]
  f1566 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (52)))));
  // PTX:3012 ld.local.f32 %f1565, [%rd2+48]
  f1565 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (48)))));
  // PTX:3013 ld.local.f32 %f1564, [%rd2+44]
  f1564 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (44)))));
  // PTX:3014 ld.local.f32 %f1563, [%rd2+40]
  f1563 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (40)))));
  // PTX:3015 ld.local.f32 %f1562, [%rd2+36]
  f1562 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (36)))));
  // PTX:3016 ld.local.f32 %f1561, [%rd2+32]
  f1561 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (32)))));
  // PTX:3017 ld.local.f32 %f1560, [%rd2+28]
  f1560 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (28)))));
  // PTX:3018 ld.local.u32 %r1841, [%rd2+24]
  r1841 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (24)))));
  // PTX:3019 ld.local.u32 %r1840, [%rd2+20]
  r1840 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (20)))));
  // PTX:3020 ld.local.u32 %r1839, [%rd2+16]
  r1839 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (16)))));
  // PTX:3021 ld.local.u32 %r1838, [%rd2+12]
  r1838 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (12)))));
  // PTX:3022 ld.local.u32 %r1837, [%rd2+8]
  r1837 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (8)))));
  // PTX:3023 ld.local.u32 %r1836, [%rd2+4]
  r1836 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (4)))));
  // PTX:3024 mov.u32 %r1850, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1842));
  // PTX:3025 mov.u32 %r1851, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1842));
  // PTX:3026 mov.u32 %r1852, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1842));
  // PTX:3027 mov.u32 %r1853, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1842));
  // PTX:3028 mov.u32 %r1854, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1842));
  // PTX:3029 mov.u32 %r1855, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1842));
  // PTX:3030 mov.u32 %r1856, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1842));
  // PTX:3031 mov.u32 %r1857, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1842));
  // PTX:3032 mov.u32 %r1858, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1842));
  // PTX:3033 mov.u32 %r1859, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1842));
  // PTX:3034 mov.u32 %r1860, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1842));
  // PTX:3035 mov.u32 %r1861, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1842));
  // PTX:3036 mov.u32 %r1862, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1842));
  // PTX:3037 mov.u32 %r1863, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1842));
  // PTX:3038 mov.u32 %r1864, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1842));
  // PTX:3039 mov.u32 %r1865, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1842));
  // PTX:3040 mov.u32 %r1866, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1842));
  // PTX:3041 mov.u32 %r1867, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1842));
  // PTX:3042 mov.u32 %r1868, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1842));
  // PTX:3043 bra.uni $L__BB7_164
  goto L_BB7_164;
  // PTX:3045 $L__BB7_16:
L_BB7_16:;
  // PTX:3046 sub.s64 %rd145, %rd57, %rd19
  asm("sub.s64 %0, %1, %2;" : "=l"(rd145) : "l"(rd57), "l"(rd19));
  // PTX:3047 add.s64 %rd356, %rd145, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd356) : "l"(rd145), "l"(rd17));
  // PTX:3048 setp.lt.u64 %p16, %rd356, %rd16
  p16 = (((unsigned long long)(rd356)) < ((unsigned long long)(rd16)));
  // PTX:3049 mov.u32 %r1771, -1
  asm("mov.u32 %0, -1;" : "=r"(r1771) : );
  // PTX:3050 @%p16 bra $L__BB7_22
  if (p16) { goto L_BB7_22; }
  // PTX:3051 bra.uni $L__BB7_17
  goto L_BB7_17;
  // PTX:3053 $L__BB7_20:
L_BB7_20:;
  // PTX:3054 cvt.u32.u64 %r464, %rd17
  asm("cvt.u32.u64 %0, %1;" : "=r"(r464) : "l"(rd17));
  // PTX:3055 cvt.u32.u64 %r465, %rd57
  asm("cvt.u32.u64 %0, %1;" : "=r"(r465) : "l"(rd57));
  // PTX:3056 div.u32 %r466, %r465, %r464
  asm("div.u32 %0, %1, %2;" : "=r"(r466) : "r"(r465), "r"(r464));
  // PTX:3057 mul.lo.s32 %r467, %r466, %r464
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r467) : "r"(r466), "r"(r464));
  // PTX:3058 sub.s32 %r468, %r465, %r467
  asm("sub.s32 %0, %1, %2;" : "=r"(r468) : "r"(r465), "r"(r467));
  // PTX:3059 cvt.u64.u32 %rd354, %r466
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd354) : "r"(r466));
  // PTX:3060 cvt.u64.u32 %rd356, %r468
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd356) : "r"(r468));
  // PTX:3062 $L__BB7_21:
L_BB7_21:;
  // PTX:3063 cvt.u32.u64 %r1771, %rd354
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1771) : "l"(rd354));
  // PTX:3065 $L__BB7_22:
L_BB7_22:;
  // PTX:3066 setp.ne.s32 %p18, %r1771, %r85
  p18 = (((int)(r1771)) != ((int)(r85)));
  // PTX:3067 setp.gt.s32 %p19, %r1771, -1
  p19 = (((int)(r1771)) > ((int)(-1)));
  // PTX:3068 and.pred %p20, %p19, %p18
  p20 = ((p19) && (p18));
  // PTX:3069 mov.f32 %f1560, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1560) : );
  // PTX:3070 mov.f32 %f1561, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1561) : );
  // PTX:3071 mov.f32 %f1562, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1562) : );
  // PTX:3072 mov.f32 %f1563, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1563) : );
  // PTX:3073 mov.f32 %f1564, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1564) : );
  // PTX:3074 mov.f32 %f1565, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1565) : );
  // PTX:3075 mov.f32 %f1566, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1566) : );
  // PTX:3076 mov.f32 %f1567, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1567) : );
  // PTX:3077 mov.f32 %f1568, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1568) : );
  // PTX:3078 mov.f32 %f1569, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1569) : );
  // PTX:3079 mov.f32 %f1570, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1570) : );
  // PTX:3080 mov.f32 %f1571, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1571) : );
  // PTX:3081 mov.f32 %f1572, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1572) : );
  // PTX:3082 mov.f32 %f1573, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1573) : );
  // PTX:3083 @%p20 bra $L__BB7_17
  if (p20) { goto L_BB7_17; }
  // PTX:3084 bra.uni $L__BB7_23
  goto L_BB7_23;
  // PTX:3086 $L__BB7_17:
L_BB7_17:;
  // PTX:3087 ld.local.f32 %f1573, [%rd2+112]
  f1573 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (112)))));
  // PTX:3088 ld.local.f32 %f1572, [%rd2+108]
  f1572 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (108)))));
  // PTX:3089 ld.local.f32 %f1571, [%rd2+104]
  f1571 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (104)))));
  // PTX:3090 ld.local.f32 %f1570, [%rd2+100]
  f1570 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (100)))));
  // PTX:3091 ld.local.f32 %f1569, [%rd2+96]
  f1569 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (96)))));
  // PTX:3092 ld.local.f32 %f1568, [%rd2+92]
  f1568 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (92)))));
  // PTX:3093 ld.local.f32 %f1567, [%rd2+88]
  f1567 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (88)))));
  // PTX:3094 ld.local.u32 %r1849, [%rd2+84]
  r1849 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (84)))));
  // PTX:3095 ld.local.u32 %r1848, [%rd2+80]
  r1848 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (80)))));
  // PTX:3096 ld.local.u32 %r1847, [%rd2+76]
  r1847 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (76)))));
  // PTX:3097 ld.local.u32 %r1846, [%rd2+72]
  r1846 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (72)))));
  // PTX:3098 ld.local.u32 %r1845, [%rd2+68]
  r1845 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (68)))));
  // PTX:3099 ld.local.u32 %r1844, [%rd2+64]
  r1844 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (64)))));
  // PTX:3100 ld.local.u32 %r1843, [%rd2+60]
  r1843 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (60)))));
  // PTX:3101 ld.local.f32 %f1566, [%rd2+52]
  f1566 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (52)))));
  // PTX:3102 ld.local.f32 %f1565, [%rd2+48]
  f1565 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (48)))));
  // PTX:3103 ld.local.f32 %f1564, [%rd2+44]
  f1564 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (44)))));
  // PTX:3104 ld.local.f32 %f1563, [%rd2+40]
  f1563 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (40)))));
  // PTX:3105 ld.local.f32 %f1562, [%rd2+36]
  f1562 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (36)))));
  // PTX:3106 ld.local.f32 %f1561, [%rd2+32]
  f1561 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (32)))));
  // PTX:3107 ld.local.f32 %f1560, [%rd2+28]
  f1560 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (28)))));
  // PTX:3108 ld.local.u32 %r1841, [%rd2+24]
  r1841 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (24)))));
  // PTX:3109 ld.local.u32 %r1840, [%rd2+20]
  r1840 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (20)))));
  // PTX:3110 ld.local.u32 %r1839, [%rd2+16]
  r1839 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (16)))));
  // PTX:3111 ld.local.u32 %r1838, [%rd2+12]
  r1838 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (12)))));
  // PTX:3112 ld.local.u32 %r1837, [%rd2+8]
  r1837 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (8)))));
  // PTX:3113 ld.local.u32 %r1836, [%rd2+4]
  r1836 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (4)))));
  // PTX:3114 mov.u32 %r1850, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1842));
  // PTX:3115 mov.u32 %r1851, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1842));
  // PTX:3116 mov.u32 %r1852, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1842));
  // PTX:3117 mov.u32 %r1853, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1853) : "r"(r1842));
  // PTX:3118 mov.u32 %r1854, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1842));
  // PTX:3119 mov.u32 %r1855, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1842));
  // PTX:3120 mov.u32 %r1856, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1842));
  // PTX:3121 mov.u32 %r1857, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1842));
  // PTX:3122 mov.u32 %r1858, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1842));
  // PTX:3123 mov.u32 %r1859, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1842));
  // PTX:3124 mov.u32 %r1860, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1842));
  // PTX:3125 mov.u32 %r1861, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1842));
  // PTX:3126 mov.u32 %r1862, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1842));
  // PTX:3127 mov.u32 %r1863, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1842));
  // PTX:3128 mov.u32 %r1864, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1842));
  // PTX:3129 mov.u32 %r1865, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1842));
  // PTX:3130 mov.u32 %r1866, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1842));
  // PTX:3131 mov.u32 %r1867, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1842));
  // PTX:3132 mov.u32 %r1868, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1842));
  // PTX:3134 $L__BB7_164:
L_BB7_164:;
  // PTX:3135 st.local.u32 [%rd3], %r1835
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (0))))) = (unsigned)(r1835);
  // PTX:3136 st.local.u32 [%rd3+4], %r1836
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (4))))) = (unsigned)(r1836);
  // PTX:3137 st.local.u32 [%rd3+8], %r1837
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (8))))) = (unsigned)(r1837);
  // PTX:3138 st.local.u32 [%rd3+12], %r1838
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (12))))) = (unsigned)(r1838);
  // PTX:3139 st.local.u32 [%rd3+16], %r1839
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (16))))) = (unsigned)(r1839);
  // PTX:3140 st.local.u32 [%rd3+20], %r1840
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (20))))) = (unsigned)(r1840);
  // PTX:3141 st.local.u32 [%rd3+24], %r1841
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (24))))) = (unsigned)(r1841);
  // PTX:3142 st.local.f32 [%rd3+28], %f1560
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (28))))) = (float)(f1560);
  // PTX:3143 st.local.f32 [%rd3+32], %f1561
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (32))))) = (float)(f1561);
  // PTX:3144 st.local.f32 [%rd3+36], %f1562
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (36))))) = (float)(f1562);
  // PTX:3145 st.local.f32 [%rd3+40], %f1563
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (40))))) = (float)(f1563);
  // PTX:3146 st.local.f32 [%rd3+44], %f1564
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (44))))) = (float)(f1564);
  // PTX:3147 st.local.f32 [%rd3+48], %f1565
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (48))))) = (float)(f1565);
  // PTX:3148 st.local.f32 [%rd3+52], %f1566
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (52))))) = (float)(f1566);
  // PTX:3149 st.local.u32 [%rd3+56], %r1842
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (56))))) = (unsigned)(r1842);
  // PTX:3150 st.local.u32 [%rd3+60], %r1843
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (60))))) = (unsigned)(r1843);
  // PTX:3151 st.local.u32 [%rd3+64], %r1844
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (64))))) = (unsigned)(r1844);
  // PTX:3152 st.local.u32 [%rd3+68], %r1845
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (68))))) = (unsigned)(r1845);
  // PTX:3153 st.local.u32 [%rd3+72], %r1846
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (72))))) = (unsigned)(r1846);
  // PTX:3154 st.local.u32 [%rd3+76], %r1847
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (76))))) = (unsigned)(r1847);
  // PTX:3155 st.local.u32 [%rd3+80], %r1848
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (80))))) = (unsigned)(r1848);
  // PTX:3156 st.local.u32 [%rd3+84], %r1849
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (84))))) = (unsigned)(r1849);
  // PTX:3157 st.local.f32 [%rd3+88], %f1567
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (88))))) = (float)(f1567);
  // PTX:3158 st.local.f32 [%rd3+92], %f1568
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (92))))) = (float)(f1568);
  // PTX:3159 st.local.f32 [%rd3+96], %f1569
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (96))))) = (float)(f1569);
  // PTX:3160 st.local.f32 [%rd3+100], %f1570
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (100))))) = (float)(f1570);
  // PTX:3161 st.local.f32 [%rd3+104], %f1571
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (104))))) = (float)(f1571);
  // PTX:3162 st.local.f32 [%rd3+108], %f1572
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (108))))) = (float)(f1572);
  // PTX:3163 st.local.f32 [%rd3+112], %f1573
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (112))))) = (float)(f1573);
  // PTX:3164 st.local.u32 [%rd3+116], %r1850
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (116))))) = (unsigned)(r1850);
  // PTX:3165 st.local.u32 [%rd3+120], %r1851
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (120))))) = (unsigned)(r1851);
  // PTX:3166 st.local.u32 [%rd3+124], %r1852
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (124))))) = (unsigned)(r1852);
  // PTX:3167 st.local.u32 [%rd3+128], %r1853
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (128))))) = (unsigned)(r1853);
  // PTX:3168 st.local.u32 [%rd3+132], %r1854
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (132))))) = (unsigned)(r1854);
  // PTX:3169 st.local.u32 [%rd3+136], %r1855
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (136))))) = (unsigned)(r1855);
  // PTX:3170 st.local.u32 [%rd3+140], %r1856
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (140))))) = (unsigned)(r1856);
  // PTX:3171 st.local.u32 [%rd3+144], %r1857
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (144))))) = (unsigned)(r1857);
  // PTX:3172 st.local.u32 [%rd3+148], %r1858
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (148))))) = (unsigned)(r1858);
  // PTX:3173 st.local.u32 [%rd3+152], %r1859
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (152))))) = (unsigned)(r1859);
  // PTX:3174 st.local.u32 [%rd3+156], %r1858
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (156))))) = (unsigned)(r1858);
  // PTX:3175 st.local.u32 [%rd3+160], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (160))))) = (unsigned)(r1860);
  // PTX:3176 st.local.u32 [%rd3+164], %r1861
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (164))))) = (unsigned)(r1861);
  // PTX:3177 st.local.u32 [%rd3+168], %r1859
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (168))))) = (unsigned)(r1859);
  // PTX:3178 st.local.u32 [%rd3+172], %r1861
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (172))))) = (unsigned)(r1861);
  // PTX:3179 st.local.u32 [%rd3+176], %r1862
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (176))))) = (unsigned)(r1862);
  // PTX:3180 st.local.u32 [%rd3+180], %r1863
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (180))))) = (unsigned)(r1863);
  // PTX:3181 st.local.u32 [%rd3+184], %r1864
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (184))))) = (unsigned)(r1864);
  // PTX:3182 st.local.u32 [%rd3+188], %r1865
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (188))))) = (unsigned)(r1865);
  // PTX:3183 st.local.u32 [%rd3+192], %r1864
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (192))))) = (unsigned)(r1864);
  // PTX:3184 st.local.u32 [%rd3+196], %r1866
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (196))))) = (unsigned)(r1866);
  // PTX:3185 st.local.u32 [%rd3+200], %r1867
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (200))))) = (unsigned)(r1867);
  // PTX:3186 st.local.u32 [%rd3+204], %r1865
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (204))))) = (unsigned)(r1865);
  // PTX:3187 st.local.u32 [%rd3+208], %r1867
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (208))))) = (unsigned)(r1867);
  // PTX:3188 st.local.u32 [%rd3+212], %r1868
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (212))))) = (unsigned)(r1868);
  // PTX:3189 st.local.f32 [%rd3+216], %f1574
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (216))))) = (float)(f1574);
  // PTX:3190 setp.lt.s32 %p140, %r1842, 1
  p140 = (((int)(r1842)) < ((int)(1)));
  // PTX:3191 @%p140 bra $L__BB7_172
  if (p140) { goto L_BB7_172; }
  // PTX:3193 max.s32 %r444, %r1842, 1
  asm("max.s32 %0, %1, 1;" : "=r"(r444) : "r"(r1842));
  // PTX:3194 add.s32 %r1760, %r444, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r1760) : "r"(r444));
  // PTX:3195 and.b32 %r445, %r444, 3
  asm("and.b32 %0, %1, 3;" : "=r"(r445) : "r"(r444));
  // PTX:3196 setp.lt.u32 %p141, %r1760, 3
  p141 = (((unsigned)(r1760)) < ((unsigned)(3)));
  // PTX:3197 mov.u32 %r1871, 0
  asm("mov.u32 %0, 0;" : "=r"(r1871) : );
  // PTX:3198 @%p141 bra $L__BB7_168
  if (p141) { goto L_BB7_168; }
  // PTX:3200 sub.s32 %r1870, %r444, %r445
  asm("sub.s32 %0, %1, %2;" : "=r"(r1870) : "r"(r444), "r"(r445));
  // PTX:3201 mov.u32 %r1871, 0
  asm("mov.u32 %0, 0;" : "=r"(r1871) : );
  // PTX:3203 $L__BB7_167:
L_BB7_167:;
  // PTX:3204 mul.wide.s32 %rd312, %r1871, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd312) : "r"(r1871));
  // PTX:3205 add.s64 %rd313, %rd3, %rd312
  asm("add.s64 %0, %1, %2;" : "=l"(rd313) : "l"(rd3), "l"(rd312));
  // PTX:3206 ld.local.u32 %r1762, [%rd313]
  r1762 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd313) + (0)))));
  // PTX:3207 mul.wide.s32 %rd314, %r1762, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd314) : "r"(r1762));
  // PTX:3208 add.s64 %rd315, %rd1, %rd314
  asm("add.s64 %0, %1, %2;" : "=l"(rd315) : "l"(rd1), "l"(rd314));
  // PTX:3209 ld.local.f32 %f1417, [%rd313+28]
  f1417 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd313) + (28)))));
  // PTX:3210 mul.f32 %f1418, %f1417, %f1417
  asm("mul.f32 %0, %1, %2;" : "=f"(f1418) : "f"(f1417), "f"(f1417));
  // PTX:3211 mul.f32 %f1419, %f1418, %f1574
  asm("mul.f32 %0, %1, %2;" : "=f"(f1419) : "f"(f1418), "f"(f1574));
  // PTX:3212 red.global.add.f32 [%rd315], %f1419
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd315) + (0)))), (float)(f1419));
  // PTX:3213 ld.local.u32 %r1763, [%rd313+4]
  r1763 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd313) + (4)))));
  // PTX:3214 mul.wide.s32 %rd316, %r1763, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd316) : "r"(r1763));
  // PTX:3215 add.s64 %rd317, %rd1, %rd316
  asm("add.s64 %0, %1, %2;" : "=l"(rd317) : "l"(rd1), "l"(rd316));
  // PTX:3216 ld.local.f32 %f1421, [%rd313+32]
  f1421 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd313) + (32)))));
  // PTX:3217 mul.f32 %f1422, %f1421, %f1421
  asm("mul.f32 %0, %1, %2;" : "=f"(f1422) : "f"(f1421), "f"(f1421));
  // PTX:3218 mul.f32 %f1423, %f1422, %f1574
  asm("mul.f32 %0, %1, %2;" : "=f"(f1423) : "f"(f1422), "f"(f1574));
  // PTX:3219 red.global.add.f32 [%rd317], %f1423
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd317) + (0)))), (float)(f1423));
  // PTX:3220 ld.local.u32 %r1764, [%rd313+8]
  r1764 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd313) + (8)))));
  // PTX:3221 mul.wide.s32 %rd318, %r1764, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd318) : "r"(r1764));
  // PTX:3222 add.s64 %rd319, %rd1, %rd318
  asm("add.s64 %0, %1, %2;" : "=l"(rd319) : "l"(rd1), "l"(rd318));
  // PTX:3223 ld.local.f32 %f1425, [%rd313+36]
  f1425 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd313) + (36)))));
  // PTX:3224 mul.f32 %f1426, %f1425, %f1425
  asm("mul.f32 %0, %1, %2;" : "=f"(f1426) : "f"(f1425), "f"(f1425));
  // PTX:3225 mul.f32 %f1427, %f1426, %f1574
  asm("mul.f32 %0, %1, %2;" : "=f"(f1427) : "f"(f1426), "f"(f1574));
  // PTX:3226 red.global.add.f32 [%rd319], %f1427
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd319) + (0)))), (float)(f1427));
  // PTX:3227 ld.local.u32 %r1765, [%rd313+12]
  r1765 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd313) + (12)))));
  // PTX:3228 mul.wide.s32 %rd320, %r1765, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd320) : "r"(r1765));
  // PTX:3229 add.s64 %rd321, %rd1, %rd320
  asm("add.s64 %0, %1, %2;" : "=l"(rd321) : "l"(rd1), "l"(rd320));
  // PTX:3230 ld.local.f32 %f1429, [%rd313+40]
  f1429 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd313) + (40)))));
  // PTX:3231 mul.f32 %f1430, %f1429, %f1429
  asm("mul.f32 %0, %1, %2;" : "=f"(f1430) : "f"(f1429), "f"(f1429));
  // PTX:3232 mul.f32 %f1431, %f1430, %f1574
  asm("mul.f32 %0, %1, %2;" : "=f"(f1431) : "f"(f1430), "f"(f1574));
  // PTX:3233 red.global.add.f32 [%rd321], %f1431
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd321) + (0)))), (float)(f1431));
  // PTX:3234 add.s32 %r1871, %r1871, 4
  asm("add.s32 %0, %1, 4;" : "=r"(r1871) : "r"(r1871));
  // PTX:3235 add.s32 %r1870, %r1870, -4
  asm("add.s32 %0, %1, -4;" : "=r"(r1870) : "r"(r1870));
  // PTX:3236 setp.ne.s32 %p142, %r1870, 0
  p142 = (((int)(r1870)) != ((int)(0)));
  // PTX:3237 @%p142 bra $L__BB7_167
  if (p142) { goto L_BB7_167; }
  // PTX:3239 $L__BB7_168:
L_BB7_168:;
  // PTX:3240 setp.eq.s32 %p143, %r445, 0
  p143 = (((int)(r445)) == ((int)(0)));
  // PTX:3241 @%p143 bra $L__BB7_172
  if (p143) { goto L_BB7_172; }
  // PTX:3243 mul.wide.s32 %rd322, %r1871, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd322) : "r"(r1871));
  // PTX:3244 add.s64 %rd323, %rd3, %rd322
  asm("add.s64 %0, %1, %2;" : "=l"(rd323) : "l"(rd3), "l"(rd322));
  // PTX:3245 add.s64 %rd102, %rd323, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd102) : "l"(rd323));
  // PTX:3246 ld.local.u32 %r1766, [%rd323]
  r1766 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd323) + (0)))));
  // PTX:3247 mul.wide.s32 %rd324, %r1766, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd324) : "r"(r1766));
  // PTX:3248 add.s64 %rd325, %rd1, %rd324
  asm("add.s64 %0, %1, %2;" : "=l"(rd325) : "l"(rd1), "l"(rd324));
  // PTX:3249 ld.local.f32 %f1433, [%rd323+28]
  f1433 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd323) + (28)))));
  // PTX:3250 mul.f32 %f1434, %f1433, %f1433
  asm("mul.f32 %0, %1, %2;" : "=f"(f1434) : "f"(f1433), "f"(f1433));
  // PTX:3251 mul.f32 %f1435, %f1434, %f1574
  asm("mul.f32 %0, %1, %2;" : "=f"(f1435) : "f"(f1434), "f"(f1574));
  // PTX:3252 red.global.add.f32 [%rd325], %f1435
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd325) + (0)))), (float)(f1435));
  // PTX:3253 setp.eq.s32 %p144, %r445, 1
  p144 = (((int)(r445)) == ((int)(1)));
  // PTX:3254 @%p144 bra $L__BB7_172
  if (p144) { goto L_BB7_172; }
  // PTX:3256 ld.local.u32 %r1767, [%rd102+-24]
  r1767 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd102) + (-24)))));
  // PTX:3257 mul.wide.s32 %rd326, %r1767, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd326) : "r"(r1767));
  // PTX:3258 add.s64 %rd327, %rd1, %rd326
  asm("add.s64 %0, %1, %2;" : "=l"(rd327) : "l"(rd1), "l"(rd326));
  // PTX:3259 ld.local.f32 %f1437, [%rd102+4]
  f1437 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd102) + (4)))));
  // PTX:3260 mul.f32 %f1438, %f1437, %f1437
  asm("mul.f32 %0, %1, %2;" : "=f"(f1438) : "f"(f1437), "f"(f1437));
  // PTX:3261 mul.f32 %f1439, %f1438, %f1574
  asm("mul.f32 %0, %1, %2;" : "=f"(f1439) : "f"(f1438), "f"(f1574));
  // PTX:3262 red.global.add.f32 [%rd327], %f1439
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd327) + (0)))), (float)(f1439));
  // PTX:3263 setp.eq.s32 %p145, %r445, 2
  p145 = (((int)(r445)) == ((int)(2)));
  // PTX:3264 @%p145 bra $L__BB7_172
  if (p145) { goto L_BB7_172; }
  // PTX:3266 ld.local.u32 %r1768, [%rd102+-20]
  r1768 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd102) + (-20)))));
  // PTX:3267 mul.wide.s32 %rd328, %r1768, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd328) : "r"(r1768));
  // PTX:3268 add.s64 %rd329, %rd1, %rd328
  asm("add.s64 %0, %1, %2;" : "=l"(rd329) : "l"(rd1), "l"(rd328));
  // PTX:3269 ld.local.f32 %f1441, [%rd102+8]
  f1441 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd102) + (8)))));
  // PTX:3270 mul.f32 %f1442, %f1441, %f1441
  asm("mul.f32 %0, %1, %2;" : "=f"(f1442) : "f"(f1441), "f"(f1441));
  // PTX:3271 mul.f32 %f1443, %f1442, %f1574
  asm("mul.f32 %0, %1, %2;" : "=f"(f1443) : "f"(f1442), "f"(f1574));
  // PTX:3272 red.global.add.f32 [%rd329], %f1443
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd329) + (0)))), (float)(f1443));
  // PTX:3274 $L__BB7_172:
L_BB7_172:;
  // PTX:3275 add.s64 %rd352, %rd352, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd352) : "l"(rd352), "l"(rd9));
  // PTX:3276 setp.lt.u64 %p146, %rd352, %rd5
  p146 = (((unsigned long long)(rd352)) < ((unsigned long long)(rd5)));
  // PTX:3277 @%p146 bra $L__BB7_2
  if (p146) { goto L_BB7_2; }
  // PTX:3279 $L__BB7_173:
L_BB7_173:;
  // PTX:3280 ret
  return;
}
