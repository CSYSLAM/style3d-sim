// 机械还原自 PTX：synreal::kernel::evaluate_contact_force(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float const*, float const*, float, unsigned long, unsigned long, unsigned long, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, float*)
// PTX SHA256: 96e784a883a56a3161d64b14e8f6791705b2799a228ce385dba95fb08701c986
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_contact_force(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned long long param14, unsigned long long param15, unsigned long long param16, unsigned long long param17, unsigned long long param18, float param19, unsigned long long param20, unsigned long long param21, unsigned long long param22, unsigned long long param23, unsigned long long param24, unsigned long long param25, unsigned long long param26, unsigned long long param27, unsigned long long param28, unsigned long long param29, unsigned long long param30, float param31, unsigned long long param32, unsigned long long param33) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62, p63, p64, p65, p66, p67, p68, p69, p70, p71, p72, p73, p74, p75, p76, p77, p78, p79, p80, p81, p82, p83, p84, p85, p86, p87, p88, p89, p90, p91, p92, p93, p94, p95, p96, p97, p98, p99, p100, p101, p102, p103, p104, p105, p106, p107, p108, p109, p110, p111, p112, p113, p114, p115, p116, p117, p118, p119, p120, p121, p122, p123, p124, p125, p126, p127, p128, p129, p130, p131, p132, p133, p134, p135, p136, p137, p138, p139, p140, p141, p142, p143, p144, p145, p146, p147, p148, p149, p150, p151, p152, p153, p154, p155, p156, p157, p158, p159, p160, p161, p162, p163, p164, p165, p166, p167, p168;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503, f504, f505, f506, f507, f508, f509, f510, f511, f512, f513, f514, f515, f516, f517, f518, f519, f520, f521, f522, f523, f524, f525, f526, f527, f528, f529, f530, f531, f532, f533, f534, f535, f536, f537, f538, f539, f540, f541, f542, f543, f544, f545, f546, f547, f548, f549, f550, f551, f552, f553, f554, f555, f556, f557, f558, f559, f560, f561, f562, f563, f564, f565, f566, f567, f568, f569, f570, f571, f572, f573, f574, f575, f576, f577, f578, f579, f580, f581, f582, f583, f584, f585, f586, f587, f588, f589, f590, f591, f592, f593, f594, f595, f596, f597, f598, f599, f600, f601, f602, f603, f604, f605, f606, f607, f608, f609, f610, f611, f612, f613, f614, f615, f616, f617, f618, f619, f620, f621, f622, f623, f624, f625, f626, f627, f628, f629, f630, f631, f632, f633, f634, f635, f636, f637, f638, f639, f640, f641, f642, f643, f644, f645, f646, f647, f648, f649, f650, f651, f652, f653, f654, f655, f656, f657, f658, f659, f660, f661, f662, f663, f664, f665, f666, f667, f668, f669, f670, f671, f672, f673, f674, f675, f676, f677, f678, f679, f680, f681, f682, f683, f684, f685, f686, f687, f688, f689, f690, f691, f692, f693, f694, f695, f696, f697, f698, f699, f700, f701, f702, f703, f704, f705, f706, f707, f708, f709, f710, f711, f712, f713, f714, f715, f716, f717, f718, f719, f720, f721, f722, f723, f724, f725, f726, f727, f728, f729, f730, f731, f732, f733, f734, f735, f736, f737, f738, f739, f740, f741, f742, f743, f744, f745, f746, f747, f748, f749, f750, f751, f752, f753, f754, f755, f756, f757, f758, f759, f760, f761, f762, f763, f764, f765, f766, f767, f768, f769, f770, f771, f772, f773, f774, f775, f776, f777, f778, f779, f780, f781, f782, f783, f784, f785, f786, f787, f788, f789, f790, f791, f792, f793, f794, f795, f796, f797, f798, f799, f800, f801, f802, f803, f804, f805, f806, f807, f808, f809, f810, f811, f812, f813, f814, f815, f816, f817, f818, f819, f820, f821, f822, f823, f824, f825, f826, f827, f828, f829, f830, f831, f832, f833, f834, f835, f836, f837, f838, f839, f840, f841, f842, f843, f844, f845, f846, f847, f848, f849, f850, f851, f852, f853, f854, f855, f856, f857, f858, f859, f860, f861, f862, f863, f864, f865, f866, f867, f868, f869, f870, f871, f872, f873, f874, f875, f876, f877, f878, f879, f880, f881, f882, f883, f884, f885, f886, f887, f888, f889, f890, f891, f892, f893, f894, f895, f896, f897, f898, f899, f900, f901, f902, f903, f904, f905, f906, f907, f908, f909, f910, f911, f912, f913, f914, f915, f916, f917, f918, f919, f920, f921, f922, f923, f924, f925, f926, f927, f928, f929, f930, f931, f932, f933, f934, f935, f936, f937, f938, f939, f940, f941, f942, f943, f944, f945, f946, f947, f948, f949, f950, f951, f952, f953, f954, f955, f956, f957, f958, f959, f960, f961, f962, f963, f964, f965, f966, f967, f968, f969, f970, f971, f972, f973, f974, f975, f976, f977, f978, f979, f980, f981, f982, f983, f984, f985, f986, f987, f988, f989, f990, f991, f992, f993, f994, f995, f996, f997, f998, f999, f1000, f1001, f1002, f1003, f1004, f1005, f1006, f1007, f1008, f1009, f1010, f1011, f1012, f1013, f1014, f1015, f1016, f1017, f1018, f1019, f1020, f1021, f1022, f1023, f1024, f1025, f1026, f1027, f1028, f1029, f1030, f1031, f1032, f1033, f1034, f1035, f1036, f1037, f1038, f1039, f1040, f1041, f1042, f1043, f1044, f1045, f1046, f1047, f1048, f1049, f1050, f1051, f1052, f1053, f1054, f1055, f1056, f1057, f1058, f1059, f1060, f1061, f1062, f1063, f1064, f1065, f1066, f1067, f1068, f1069, f1070, f1071, f1072, f1073, f1074, f1075, f1076, f1077, f1078, f1079, f1080, f1081, f1082, f1083, f1084, f1085, f1086, f1087, f1088, f1089, f1090, f1091, f1092, f1093, f1094, f1095, f1096, f1097, f1098, f1099, f1100, f1101, f1102, f1103, f1104, f1105, f1106, f1107, f1108, f1109, f1110, f1111, f1112, f1113, f1114, f1115, f1116, f1117, f1118, f1119, f1120, f1121, f1122, f1123, f1124, f1125, f1126, f1127, f1128, f1129, f1130, f1131, f1132, f1133, f1134, f1135, f1136, f1137, f1138, f1139, f1140, f1141, f1142, f1143, f1144, f1145, f1146, f1147, f1148, f1149, f1150, f1151, f1152, f1153, f1154, f1155, f1156, f1157, f1158, f1159, f1160, f1161, f1162, f1163, f1164, f1165, f1166, f1167, f1168, f1169, f1170, f1171, f1172, f1173, f1174, f1175, f1176, f1177, f1178, f1179, f1180, f1181, f1182, f1183, f1184, f1185, f1186, f1187, f1188, f1189, f1190, f1191, f1192, f1193, f1194, f1195, f1196, f1197, f1198, f1199, f1200, f1201, f1202, f1203, f1204, f1205, f1206, f1207, f1208, f1209, f1210, f1211, f1212, f1213, f1214, f1215, f1216, f1217, f1218, f1219, f1220, f1221, f1222, f1223, f1224, f1225, f1226, f1227, f1228, f1229, f1230, f1231, f1232, f1233, f1234, f1235, f1236, f1237, f1238, f1239, f1240, f1241, f1242, f1243, f1244, f1245, f1246, f1247, f1248, f1249, f1250, f1251, f1252, f1253, f1254, f1255, f1256, f1257, f1258, f1259, f1260, f1261, f1262, f1263, f1264, f1265, f1266, f1267, f1268, f1269, f1270, f1271, f1272, f1273, f1274, f1275, f1276, f1277, f1278, f1279, f1280, f1281, f1282, f1283, f1284, f1285, f1286, f1287, f1288, f1289, f1290, f1291, f1292, f1293, f1294, f1295, f1296, f1297, f1298, f1299, f1300, f1301, f1302, f1303, f1304, f1305, f1306, f1307, f1308, f1309, f1310, f1311, f1312, f1313, f1314, f1315, f1316, f1317, f1318, f1319, f1320, f1321, f1322, f1323, f1324, f1325, f1326, f1327, f1328, f1329, f1330, f1331, f1332, f1333, f1334, f1335, f1336, f1337, f1338, f1339, f1340, f1341, f1342, f1343, f1344, f1345, f1346, f1347, f1348, f1349, f1350, f1351, f1352, f1353, f1354, f1355, f1356, f1357, f1358, f1359, f1360, f1361, f1362, f1363, f1364, f1365, f1366, f1367, f1368, f1369, f1370, f1371, f1372, f1373, f1374, f1375, f1376, f1377, f1378, f1379, f1380, f1381, f1382, f1383, f1384, f1385, f1386, f1387, f1388, f1389, f1390, f1391, f1392, f1393, f1394, f1395, f1396, f1397, f1398, f1399, f1400, f1401, f1402, f1403, f1404, f1405, f1406, f1407, f1408, f1409, f1410, f1411, f1412, f1413, f1414, f1415, f1416, f1417, f1418, f1419, f1420, f1421, f1422, f1423, f1424, f1425, f1426, f1427, f1428, f1429, f1430, f1431, f1432, f1433, f1434, f1435, f1436, f1437, f1438, f1439, f1440, f1441, f1442, f1443, f1444, f1445, f1446, f1447, f1448, f1449, f1450, f1451, f1452, f1453, f1454, f1455, f1456, f1457, f1458, f1459, f1460, f1461, f1462, f1463, f1464, f1465, f1466, f1467, f1468, f1469, f1470, f1471, f1472, f1473, f1474, f1475, f1476, f1477, f1478, f1479, f1480, f1481, f1482, f1483, f1484, f1485, f1486, f1487, f1488, f1489, f1490, f1491, f1492, f1493, f1494, f1495, f1496, f1497, f1498, f1499, f1500, f1501, f1502, f1503, f1504, f1505, f1506, f1507, f1508, f1509, f1510, f1511, f1512, f1513, f1514, f1515, f1516, f1517, f1518, f1519, f1520, f1521, f1522, f1523, f1524, f1525, f1526, f1527, f1528, f1529, f1530, f1531, f1532, f1533, f1534, f1535, f1536, f1537, f1538, f1539, f1540, f1541, f1542, f1543, f1544, f1545, f1546, f1547, f1548, f1549, f1550, f1551, f1552, f1553, f1554, f1555, f1556, f1557, f1558, f1559, f1560, f1561, f1562, f1563, f1564, f1565, f1566, f1567, f1568, f1569, f1570, f1571, f1572, f1573, f1574, f1575, f1576, f1577, f1578, f1579, f1580, f1581, f1582, f1583, f1584, f1585, f1586, f1587, f1588, f1589, f1590, f1591, f1592, f1593, f1594, f1595, f1596, f1597, f1598, f1599, f1600, f1601, f1602, f1603, f1604, f1605, f1606, f1607, f1608, f1609, f1610, f1611, f1612, f1613, f1614, f1615, f1616, f1617, f1618, f1619, f1620, f1621, f1622, f1623, f1624, f1625, f1626, f1627, f1628, f1629, f1630, f1631, f1632, f1633, f1634, f1635, f1636, f1637, f1638, f1639, f1640, f1641, f1642, f1643, f1644, f1645, f1646, f1647, f1648, f1649, f1650, f1651, f1652, f1653, f1654, f1655, f1656, f1657, f1658, f1659, f1660, f1661, f1662, f1663, f1664, f1665;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146, r147, r148, r149, r150, r151, r152, r153, r154, r155, r156, r157, r158, r159, r160, r161, r162, r163, r164, r165, r166, r167, r168, r169, r170, r171, r172, r173, r174, r175, r176, r177, r178, r179, r180, r181, r182, r183, r184, r185, r186, r187, r188, r189, r190, r191, r192, r193, r194, r195, r196, r197, r198, r199, r200, r201, r202, r203, r204, r205, r206, r207, r208, r209, r210, r211, r212, r213, r214, r215, r216, r217, r218, r219, r220, r221, r222, r223, r224, r225, r226, r227, r228, r229, r230, r231, r232, r233, r234, r235, r236, r237, r238, r239, r240, r241, r242, r243, r244, r245, r246, r247, r248, r249, r250, r251, r252, r253, r254, r255, r256, r257, r258, r259, r260, r261, r262, r263, r264, r265, r266, r267, r268, r269, r270, r271, r272, r273, r274, r275, r276, r277, r278, r279, r280, r281, r282, r283, r284, r285, r286, r287, r288, r289, r290, r291, r292, r293, r294, r295, r296, r297, r298, r299, r300, r301, r302, r303, r304, r305, r306, r307, r308, r309, r310, r311, r312, r313, r314, r315, r316, r317, r318, r319, r320, r321, r322, r323, r324, r325, r326, r327, r328, r329, r330, r331, r332, r333, r334, r335, r336, r337, r338, r339, r340, r341, r342, r343, r344, r345, r346, r347, r348, r349, r350, r351, r352, r353, r354, r355, r356, r357, r358, r359, r360, r361, r362, r363, r364, r365, r366, r367, r368, r369, r370, r371, r372, r373, r374, r375, r376, r377, r378, r379, r380, r381, r382, r383, r384, r385, r386, r387, r388, r389, r390, r391, r392, r393, r394, r395, r396, r397, r398, r399, r400, r401, r402, r403, r404, r405, r406, r407, r408, r409, r410, r411, r412, r413, r414, r415, r416, r417, r418, r419, r420, r421, r422, r423, r424, r425, r426, r427, r428, r429, r430, r431, r432, r433, r434, r435, r436, r437, r438, r439, r440, r441, r442, r443, r444, r445, r446, r447, r448, r449, r450, r451, r452, r453, r454, r455, r456, r457, r458, r459, r460, r461, r462, r463, r464, r465, r466, r467, r468, r469, r470, r471, r472, r473, r474, r475, r476, r477, r478, r479, r480, r481, r482, r483, r484, r485, r486, r487, r488, r489, r490, r491;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162, rd163, rd164, rd165, rd166, rd167, rd168, rd169, rd170, rd171, rd172, rd173, rd174, rd175, rd176, rd177, rd178, rd179, rd180, rd181, rd182, rd183, rd184, rd185, rd186, rd187, rd188, rd189, rd190, rd191, rd192, rd193, rd194, rd195, rd196, rd197, rd198, rd199, rd200, rd201, rd202, rd203, rd204, rd205, rd206, rd207, rd208, rd209, rd210, rd211, rd212, rd213, rd214, rd215, rd216, rd217, rd218, rd219, rd220, rd221, rd222, rd223, rd224, rd225, rd226, rd227, rd228, rd229, rd230, rd231, rd232, rd233, rd234, rd235, rd236, rd237, rd238, rd239, rd240, rd241, rd242, rd243, rd244, rd245, rd246, rd247, rd248, rd249, rd250, rd251, rd252, rd253, rd254, rd255, rd256, rd257, rd258, rd259, rd260, rd261, rd262, rd263, rd264, rd265, rd266, rd267, rd268, rd269, rd270, rd271, rd272, rd273, rd274, rd275, rd276, rd277, rd278, rd279, rd280, rd281, rd282, rd283, rd284, rd285, rd286, rd287, rd288, rd289, rd290, rd291, rd292, rd293, rd294, rd295, rd296, rd297, rd298, rd299, rd300, rd301, rd302, rd303, rd304, rd305, rd306, rd307, rd308, rd309, rd310, rd311, rd312, rd313, rd314, rd315, rd316, rd317, rd318, rd319, rd320, rd321, rd322, rd323, rd324, rd325, rd326, rd327, rd328, rd329, rd330, rd331, rd332, rd333, rd334, rd335, rd336, rd337, rd338, rd339, rd340, rd341, rd342, rd343, rd344, rd345, rd346, rd347, rd348, rd349, rd350, rd351, rd352, rd353, rd354, rd355, rd356, rd357, rd358, rd359, rd360, rd361, rd362, rd363, rd364, rd365, rd366, rd367, rd368, rd369, rd370, rd371, rd372, rd373, rd374, rd375, rd376, rd377, rd378, rd379, rd380, rd381, rd382, rd383, rd384, rd385, rd386, rd387, rd388, rd389, rd390, rd391, rd392, rd393, rd394, rd395, rd396, rd397, rd398, rd399, rd400, rd401, rd402, rd403, rd404, rd405, rd406, rd407, rd408, rd409, rd410, rd411, rd412, rd413, rd414, rd415, rd416, rd417, rd418, rd419, rd420, rd421, rd422, rd423, rd424, rd425, rd426, rd427, rd428, rd429, rd430, rd431, rd432, rd433, rd434, rd435, rd436, rd437, rd438, rd439, rd440, rd441, rd442, rd443, rd444, rd445, rd446, rd447, rd448, rd449, rd450, rd451, rd452, rd453, rd454, rd455, rd456, rd457, rd458, rd459, rd460, rd461, rd462, rd463, rd464, rd465, rd466, rd467, rd468, rd469, rd470, rd471, rd472, rd473, rd474, rd475, rd476, rd477, rd478, rd479, rd480, rd481, rd482, rd483, rd484, rd485, rd486, rd487, rd488, rd489, rd490, rd491, rd492, rd493, rd494, rd495, rd496, rd497, rd498, rd499, rd500, rd501, rd502;
  // PTX:50 ld.param.u64 %rd87, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_0]
  rd87 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:51 ld.param.u64 %rd114, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_23]
  rd114 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param23 + (0))));
  // PTX:52 ld.param.u64 %rd105, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_26]
  rd105 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param26 + (0))));
  // PTX:53 ld.param.u64 %rd117, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_28]
  rd117 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param28 + (0))));
  // PTX:54 ld.param.u64 %rd118, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_29]
  rd118 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param29 + (0))));
  // PTX:55 ld.param.u64 %rd107, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_30]
  rd107 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param30 + (0))));
  // PTX:56 ld.param.f32 %f414, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_31]
  f414 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param31 + (0))));
  // PTX:57 ld.param.u64 %rd108, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_32]
  rd108 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param32 + (0))));
  // PTX:58 ld.param.u64 %rd109, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_33]
  rd109 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param33 + (0))));
  // PTX:59 cvta.to.global.u64 %rd1, %rd108
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd108));
  // PTX:60 cvta.to.global.u64 %rd2, %rd109
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd109));
  // PTX:61 cvta.to.global.u64 %rd3, %rd118
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd118));
  // PTX:62 cvta.to.global.u64 %rd4, %rd107
  rd4 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd107));
  // PTX:63 cvta.to.global.u64 %rd6, %rd117
  rd6 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd117));
  // PTX:64 cvta.to.global.u64 %rd12, %rd114
  rd12 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd114));
  // PTX:65 mov.u32 %r234, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r234) : "r"(blockIdx.x));
  // PTX:66 mov.u32 %r235, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r235) : "r"(blockDim.x));
  // PTX:67 mul.wide.u32 %rd119, %r234, %r235
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd119) : "r"(r234), "r"(r235));
  // PTX:68 mov.u32 %r236, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r236) : "r"(threadIdx.x));
  // PTX:69 cvt.u64.u32 %rd120, %r236
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd120) : "r"(r236));
  // PTX:70 add.s64 %rd13, %rd119, %rd120
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd119), "l"(rd120));
  // PTX:71 setp.eq.s64 %p2, %rd87, 0
  p2 = (((long long)(rd87)) == ((long long)(0)));
  // PTX:72 mov.u32 %r390, 0
  asm("mov.u32 %0, 0;" : "=r"(r390) : );
  // PTX:73 @%p2 bra $L__BB2_2
  if (p2) { goto L_BB2_2; }
  // PTX:75 cvta.to.global.u64 %rd121, %rd87
  rd121 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd87));
  // PTX:76 ld.global.u32 %r237, [%rd121]
  r237 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd121) + (0)))));
  // PTX:77 max.s32 %r390, %r237, 0
  asm("max.s32 %0, %1, 0;" : "=r"(r390) : "r"(r237));
  // PTX:79 $L__BB2_2:
L_BB2_2:;
  // PTX:80 ld.param.u64 %rd484, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_1]
  rd484 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:81 cvt.u64.u32 %rd122, %r390
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd122) : "r"(r390));
  // PTX:82 setp.ge.u64 %p3, %rd13, %rd122
  p3 = (((unsigned long long)(rd13)) >= ((unsigned long long)(rd122)));
  // PTX:83 setp.ge.u64 %p4, %rd13, %rd484
  p4 = (((unsigned long long)(rd13)) >= ((unsigned long long)(rd484)));
  // PTX:84 or.pred %p5, %p4, %p3
  p5 = ((p4) || (p3));
  // PTX:85 @%p5 bra $L__BB2_203
  if (p5) { goto L_BB2_203; }
  // PTX:87 ld.param.u64 %rd485, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_2]
  rd485 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:88 cvta.to.global.u64 %rd123, %rd485
  rd123 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd485));
  // PTX:89 shl.b64 %rd124, %rd13, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd124) : "l"(rd13));
  // PTX:90 add.s64 %rd125, %rd123, %rd124
  asm("add.s64 %0, %1, %2;" : "=l"(rd125) : "l"(rd123), "l"(rd124));
  // PTX:91 ld.global.s32 %rd14, [%rd125]
  rd14 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd125) + (0)))));
  // PTX:92 setp.lt.s64 %p6, %rd14, 0
  p6 = (((long long)(rd14)) < ((long long)(0)));
  // PTX:93 @%p6 bra $L__BB2_203
  if (p6) { goto L_BB2_203; }
  // PTX:95 ld.param.u64 %rd486, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_21]
  rd486 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param21 + (0))));
  // PTX:96 ld.param.u64 %rd425, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_22]
  rd425 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param22 + (0))));
  // PTX:97 mul.lo.s64 %rd15, %rd425, %rd486
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd425), "l"(rd486));
  // PTX:98 setp.gt.u64 %p7, %rd15, %rd14
  p7 = (((unsigned long long)(rd15)) > ((unsigned long long)(rd14)));
  // PTX:99 @%p7 bra $L__BB2_6
  if (p7) { goto L_BB2_6; }
  // PTX:100 bra.uni $L__BB2_5
  goto L_BB2_5;
  // PTX:102 $L__BB2_6:
L_BB2_6:;
  // PTX:103 ld.param.u64 %rd488, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_21]
  rd488 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param21 + (0))));
  // PTX:104 or.b64 %rd127, %rd14, %rd488
  asm("or.b64 %0, %1, %2;" : "=l"(rd127) : "l"(rd14), "l"(rd488));
  // PTX:105 and.b64 %rd128, %rd127, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd128) : "l"(rd127));
  // PTX:106 setp.eq.s64 %p9, %rd128, 0
  p9 = (((long long)(rd128)) == ((long long)(0)));
  // PTX:107 @%p9 bra $L__BB2_8
  if (p9) { goto L_BB2_8; }
  // PTX:109 ld.param.u64 %rd464, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_21]
  rd464 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param21 + (0))));
  // PTX:110 div.u64 %rd489, %rd14, %rd464
  asm("div.u64 %0, %1, %2;" : "=l"(rd489) : "l"(rd14), "l"(rd464));
  // PTX:111 mul.lo.s64 %rd129, %rd489, %rd464
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd129) : "l"(rd489), "l"(rd464));
  // PTX:112 sub.s64 %rd491, %rd14, %rd129
  asm("sub.s64 %0, %1, %2;" : "=l"(rd491) : "l"(rd14), "l"(rd129));
  // PTX:113 bra.uni $L__BB2_9
  goto L_BB2_9;
  // PTX:115 $L__BB2_5:
L_BB2_5:;
  // PTX:116 ld.param.u64 %rd487, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_21]
  rd487 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param21 + (0))));
  // PTX:117 ld.param.u64 %rd434, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_20]
  rd434 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param20 + (0))));
  // PTX:118 sub.s64 %rd126, %rd14, %rd15
  asm("sub.s64 %0, %1, %2;" : "=l"(rd126) : "l"(rd14), "l"(rd15));
  // PTX:119 add.s64 %rd491, %rd126, %rd487
  asm("add.s64 %0, %1, %2;" : "=l"(rd491) : "l"(rd126), "l"(rd487));
  // PTX:120 setp.lt.u64 %p8, %rd491, %rd434
  p8 = (((unsigned long long)(rd491)) < ((unsigned long long)(rd434)));
  // PTX:121 mov.u32 %r391, -1
  asm("mov.u32 %0, -1;" : "=r"(r391) : );
  // PTX:122 @%p8 bra $L__BB2_10
  if (p8) { goto L_BB2_10; }
  // PTX:123 bra.uni $L__BB2_203
  goto L_BB2_203;
  // PTX:125 $L__BB2_8:
L_BB2_8:;
  // PTX:126 ld.param.u64 %rd465, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_21]
  rd465 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param21 + (0))));
  // PTX:127 cvt.u32.u64 %r239, %rd465
  asm("cvt.u32.u64 %0, %1;" : "=r"(r239) : "l"(rd465));
  // PTX:128 cvt.u32.u64 %r240, %rd14
  asm("cvt.u32.u64 %0, %1;" : "=r"(r240) : "l"(rd14));
  // PTX:129 div.u32 %r241, %r240, %r239
  asm("div.u32 %0, %1, %2;" : "=r"(r241) : "r"(r240), "r"(r239));
  // PTX:130 mul.lo.s32 %r242, %r241, %r239
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r242) : "r"(r241), "r"(r239));
  // PTX:131 sub.s32 %r243, %r240, %r242
  asm("sub.s32 %0, %1, %2;" : "=r"(r243) : "r"(r240), "r"(r242));
  // PTX:132 cvt.u64.u32 %rd489, %r241
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd489) : "r"(r241));
  // PTX:133 cvt.u64.u32 %rd491, %r243
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd491) : "r"(r243));
  // PTX:135 $L__BB2_9:
L_BB2_9:;
  // PTX:136 cvt.u32.u64 %r391, %rd489
  asm("cvt.u32.u64 %0, %1;" : "=r"(r391) : "l"(rd489));
  // PTX:138 $L__BB2_10:
L_BB2_10:;
  // PTX:139 ld.param.u64 %rd426, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_3]
  rd426 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:140 cvta.to.global.u64 %rd130, %rd426
  rd130 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd426));
  // PTX:141 add.s64 %rd132, %rd130, %rd124
  asm("add.s64 %0, %1, %2;" : "=l"(rd132) : "l"(rd130), "l"(rd124));
  // PTX:142 ld.global.s32 %rd24, [%rd132]
  rd24 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd132) + (0)))));
  // PTX:143 setp.lt.s64 %p10, %rd24, 0
  p10 = (((long long)(rd24)) < ((long long)(0)));
  // PTX:144 @%p10 bra $L__BB2_203
  if (p10) { goto L_BB2_203; }
  // PTX:146 setp.gt.u64 %p11, %rd15, %rd24
  p11 = (((unsigned long long)(rd15)) > ((unsigned long long)(rd24)));
  // PTX:147 @%p11 bra $L__BB2_13
  if (p11) { goto L_BB2_13; }
  // PTX:148 bra.uni $L__BB2_12
  goto L_BB2_12;
  // PTX:150 $L__BB2_13:
L_BB2_13:;
  // PTX:151 ld.param.u64 %rd461, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_21]
  rd461 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param21 + (0))));
  // PTX:152 or.b64 %rd134, %rd24, %rd461
  asm("or.b64 %0, %1, %2;" : "=l"(rd134) : "l"(rd24), "l"(rd461));
  // PTX:153 and.b64 %rd135, %rd134, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd135) : "l"(rd134));
  // PTX:154 setp.eq.s64 %p13, %rd135, 0
  p13 = (((long long)(rd135)) == ((long long)(0)));
  // PTX:155 @%p13 bra $L__BB2_15
  if (p13) { goto L_BB2_15; }
  // PTX:157 ld.param.u64 %rd462, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_21]
  rd462 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param21 + (0))));
  // PTX:158 div.u64 %rd492, %rd24, %rd462
  asm("div.u64 %0, %1, %2;" : "=l"(rd492) : "l"(rd24), "l"(rd462));
  // PTX:159 mul.lo.s64 %rd136, %rd492, %rd462
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd136) : "l"(rd492), "l"(rd462));
  // PTX:160 sub.s64 %rd494, %rd24, %rd136
  asm("sub.s64 %0, %1, %2;" : "=l"(rd494) : "l"(rd24), "l"(rd136));
  // PTX:161 bra.uni $L__BB2_16
  goto L_BB2_16;
  // PTX:163 $L__BB2_12:
L_BB2_12:;
  // PTX:164 ld.param.u64 %rd456, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_21]
  rd456 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param21 + (0))));
  // PTX:165 ld.param.u64 %rd435, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_20]
  rd435 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param20 + (0))));
  // PTX:166 sub.s64 %rd133, %rd24, %rd15
  asm("sub.s64 %0, %1, %2;" : "=l"(rd133) : "l"(rd24), "l"(rd15));
  // PTX:167 add.s64 %rd494, %rd133, %rd456
  asm("add.s64 %0, %1, %2;" : "=l"(rd494) : "l"(rd133), "l"(rd456));
  // PTX:168 setp.lt.u64 %p12, %rd494, %rd435
  p12 = (((unsigned long long)(rd494)) < ((unsigned long long)(rd435)));
  // PTX:169 mov.u32 %r392, -1
  asm("mov.u32 %0, -1;" : "=r"(r392) : );
  // PTX:170 @%p12 bra $L__BB2_17
  if (p12) { goto L_BB2_17; }
  // PTX:171 bra.uni $L__BB2_203
  goto L_BB2_203;
  // PTX:173 $L__BB2_15:
L_BB2_15:;
  // PTX:174 ld.param.u64 %rd463, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_21]
  rd463 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param21 + (0))));
  // PTX:175 cvt.u32.u64 %r245, %rd463
  asm("cvt.u32.u64 %0, %1;" : "=r"(r245) : "l"(rd463));
  // PTX:176 cvt.u32.u64 %r246, %rd24
  asm("cvt.u32.u64 %0, %1;" : "=r"(r246) : "l"(rd24));
  // PTX:177 div.u32 %r247, %r246, %r245
  asm("div.u32 %0, %1, %2;" : "=r"(r247) : "r"(r246), "r"(r245));
  // PTX:178 mul.lo.s32 %r248, %r247, %r245
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r248) : "r"(r247), "r"(r245));
  // PTX:179 sub.s32 %r249, %r246, %r248
  asm("sub.s32 %0, %1, %2;" : "=r"(r249) : "r"(r246), "r"(r248));
  // PTX:180 cvt.u64.u32 %rd492, %r247
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd492) : "r"(r247));
  // PTX:181 cvt.u64.u32 %rd494, %r249
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd494) : "r"(r249));
  // PTX:183 $L__BB2_16:
L_BB2_16:;
  // PTX:184 cvt.u32.u64 %r392, %rd492
  asm("cvt.u32.u64 %0, %1;" : "=r"(r392) : "l"(rd492));
  // PTX:186 $L__BB2_17:
L_BB2_17:;
  // PTX:187 ld.param.u64 %rd427, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_11]
  rd427 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:188 cvta.to.global.u64 %rd137, %rd427
  rd137 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd427));
  // PTX:189 shl.b64 %rd138, %rd491, 32
  asm("shl.b64 %0, %1, 32;" : "=l"(rd138) : "l"(rd491));
  // PTX:190 cvt.s64.s32 %rd33, %rd491
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd33) : "l"(rd491));
  // PTX:191 shr.s64 %rd139, %rd138, 30
  asm("shr.s64 %0, %1, 30;" : "=l"(rd139) : "l"(rd138));
  // PTX:192 add.s64 %rd140, %rd137, %rd139
  asm("add.s64 %0, %1, %2;" : "=l"(rd140) : "l"(rd137), "l"(rd139));
  // PTX:193 ld.global.u32 %r7, [%rd140]
  r7 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd140) + (0)))));
  // PTX:194 cvt.s64.s32 %rd34, %r7
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd34) : "r"(r7));
  // PTX:195 shl.b64 %rd141, %rd494, 32
  asm("shl.b64 %0, %1, 32;" : "=l"(rd141) : "l"(rd494));
  // PTX:196 cvt.s64.s32 %rd35, %rd494
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd35) : "l"(rd494));
  // PTX:197 shr.s64 %rd142, %rd141, 30
  asm("shr.s64 %0, %1, 30;" : "=l"(rd142) : "l"(rd141));
  // PTX:198 add.s64 %rd143, %rd137, %rd142
  asm("add.s64 %0, %1, %2;" : "=l"(rd143) : "l"(rd137), "l"(rd142));
  // PTX:199 ld.global.u32 %r8, [%rd143]
  r8 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd143) + (0)))));
  // PTX:200 cvt.s64.s32 %rd36, %r8
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd36) : "r"(r8));
  // PTX:201 setp.lt.s32 %p14, %r7, 0
  p14 = (((int)(r7)) < ((int)(0)));
  // PTX:202 mov.u32 %r250, -1
  asm("mov.u32 %0, -1;" : "=r"(r250) : );
  // PTX:203 mov.u32 %r393, %r250
  asm("mov.u32 %0, %1;" : "=r"(r393) : "r"(r250));
  // PTX:204 @%p14 bra $L__BB2_25
  if (p14) { goto L_BB2_25; }
  // PTX:206 setp.ge.u64 %p15, %rd34, %rd105
  p15 = (((unsigned long long)(rd34)) >= ((unsigned long long)(rd105)));
  // PTX:207 @%p15 bra $L__BB2_20
  if (p15) { goto L_BB2_20; }
  // PTX:209 shl.b64 %rd144, %rd34, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd144) : "l"(rd34));
  // PTX:210 add.s64 %rd145, %rd12, %rd144
  asm("add.s64 %0, %1, %2;" : "=l"(rd145) : "l"(rd12), "l"(rd144));
  // PTX:211 ld.global.u32 %r251, [%rd145]
  r251 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd145) + (0)))));
  // PTX:212 setp.eq.s32 %p16, %r251, %r7
  p16 = (((int)(r251)) == ((int)(r7)));
  // PTX:213 mov.u32 %r393, %r7
  asm("mov.u32 %0, %1;" : "=r"(r393) : "r"(r7));
  // PTX:214 @%p16 bra $L__BB2_25
  if (p16) { goto L_BB2_25; }
  // PTX:216 $L__BB2_20:
L_BB2_20:;
  // PTX:217 setp.eq.s64 %p17, %rd105, 0
  p17 = (((long long)(rd105)) == ((long long)(0)));
  // PTX:218 mov.u32 %r393, %r250
  asm("mov.u32 %0, %1;" : "=r"(r393) : "r"(r250));
  // PTX:219 @%p17 bra $L__BB2_25
  if (p17) { goto L_BB2_25; }
  // PTX:221 mov.u64 %rd495, 0
  asm("mov.u64 %0, 0;" : "=l"(rd495) : );
  // PTX:223 $L__BB2_22:
L_BB2_22:;
  // PTX:224 shl.b64 %rd147, %rd495, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd147) : "l"(rd495));
  // PTX:225 add.s64 %rd148, %rd12, %rd147
  asm("add.s64 %0, %1, %2;" : "=l"(rd148) : "l"(rd12), "l"(rd147));
  // PTX:226 ld.global.u32 %r253, [%rd148]
  r253 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd148) + (0)))));
  // PTX:227 setp.eq.s32 %p18, %r253, %r7
  p18 = (((int)(r253)) == ((int)(r7)));
  // PTX:228 @%p18 bra $L__BB2_24
  if (p18) { goto L_BB2_24; }
  // PTX:230 add.s64 %rd495, %rd495, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd495) : "l"(rd495));
  // PTX:231 setp.lt.u64 %p19, %rd495, %rd105
  p19 = (((unsigned long long)(rd495)) < ((unsigned long long)(rd105)));
  // PTX:232 mov.u32 %r393, %r250
  asm("mov.u32 %0, %1;" : "=r"(r393) : "r"(r250));
  // PTX:233 @%p19 bra $L__BB2_22
  if (p19) { goto L_BB2_22; }
  // PTX:234 bra.uni $L__BB2_25
  goto L_BB2_25;
  // PTX:236 $L__BB2_24:
L_BB2_24:;
  // PTX:237 cvt.u32.u64 %r393, %rd495
  asm("cvt.u32.u64 %0, %1;" : "=r"(r393) : "l"(rd495));
  // PTX:239 $L__BB2_25:
L_BB2_25:;
  // PTX:240 setp.lt.s32 %p20, %r8, 0
  p20 = (((int)(r8)) < ((int)(0)));
  // PTX:241 mov.u32 %r394, %r250
  asm("mov.u32 %0, %1;" : "=r"(r394) : "r"(r250));
  // PTX:242 @%p20 bra $L__BB2_33
  if (p20) { goto L_BB2_33; }
  // PTX:244 setp.ge.u64 %p21, %rd36, %rd105
  p21 = (((unsigned long long)(rd36)) >= ((unsigned long long)(rd105)));
  // PTX:245 @%p21 bra $L__BB2_28
  if (p21) { goto L_BB2_28; }
  // PTX:247 shl.b64 %rd149, %rd36, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd149) : "l"(rd36));
  // PTX:248 add.s64 %rd150, %rd12, %rd149
  asm("add.s64 %0, %1, %2;" : "=l"(rd150) : "l"(rd12), "l"(rd149));
  // PTX:249 ld.global.u32 %r256, [%rd150]
  r256 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd150) + (0)))));
  // PTX:250 setp.eq.s32 %p22, %r256, %r8
  p22 = (((int)(r256)) == ((int)(r8)));
  // PTX:251 mov.u32 %r394, %r8
  asm("mov.u32 %0, %1;" : "=r"(r394) : "r"(r8));
  // PTX:252 @%p22 bra $L__BB2_33
  if (p22) { goto L_BB2_33; }
  // PTX:254 $L__BB2_28:
L_BB2_28:;
  // PTX:255 setp.eq.s64 %p23, %rd105, 0
  p23 = (((long long)(rd105)) == ((long long)(0)));
  // PTX:256 mov.u32 %r394, %r250
  asm("mov.u32 %0, %1;" : "=r"(r394) : "r"(r250));
  // PTX:257 @%p23 bra $L__BB2_33
  if (p23) { goto L_BB2_33; }
  // PTX:259 mov.u64 %rd496, 0
  asm("mov.u64 %0, 0;" : "=l"(rd496) : );
  // PTX:261 $L__BB2_30:
L_BB2_30:;
  // PTX:262 shl.b64 %rd152, %rd496, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd152) : "l"(rd496));
  // PTX:263 add.s64 %rd153, %rd12, %rd152
  asm("add.s64 %0, %1, %2;" : "=l"(rd153) : "l"(rd12), "l"(rd152));
  // PTX:264 ld.global.u32 %r258, [%rd153]
  r258 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd153) + (0)))));
  // PTX:265 setp.eq.s32 %p24, %r258, %r8
  p24 = (((int)(r258)) == ((int)(r8)));
  // PTX:266 @%p24 bra $L__BB2_32
  if (p24) { goto L_BB2_32; }
  // PTX:268 add.s64 %rd496, %rd496, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd496) : "l"(rd496));
  // PTX:269 setp.lt.u64 %p25, %rd496, %rd105
  p25 = (((unsigned long long)(rd496)) < ((unsigned long long)(rd105)));
  // PTX:270 mov.u32 %r394, %r250
  asm("mov.u32 %0, %1;" : "=r"(r394) : "r"(r250));
  // PTX:271 @%p25 bra $L__BB2_30
  if (p25) { goto L_BB2_30; }
  // PTX:272 bra.uni $L__BB2_33
  goto L_BB2_33;
  // PTX:274 $L__BB2_32:
L_BB2_32:;
  // PTX:275 cvt.u32.u64 %r394, %rd496
  asm("cvt.u32.u64 %0, %1;" : "=r"(r394) : "l"(rd496));
  // PTX:277 $L__BB2_33:
L_BB2_33:;
  // PTX:278 setp.lt.s32 %p26, %r393, 0
  p26 = (((int)(r393)) < ((int)(0)));
  // PTX:279 setp.gt.s32 %p27, %r7, -1
  p27 = (((int)(r7)) > ((int)(-1)));
  // PTX:280 and.pred %p28, %p27, %p26
  p28 = ((p27) && (p26));
  // PTX:281 setp.lt.s32 %p29, %r394, 0
  p29 = (((int)(r394)) < ((int)(0)));
  // PTX:282 setp.gt.s32 %p30, %r8, -1
  p30 = (((int)(r8)) > ((int)(-1)));
  // PTX:283 and.pred %p31, %p30, %p29
  p31 = ((p30) && (p29));
  // PTX:284 or.pred %p32, %p28, %p31
  p32 = ((p28) || (p31));
  // PTX:285 @%p32 bra $L__BB2_203
  if (p32) { goto L_BB2_203; }
  // PTX:287 setp.gt.s32 %p33, %r393, -1
  p33 = (((int)(r393)) > ((int)(-1)));
  // PTX:288 setp.lt.s32 %p34, %r391, 0
  p34 = (((int)(r391)) < ((int)(0)));
  // PTX:289 and.pred %p35, %p34, %p33
  p35 = ((p34) && (p33));
  // PTX:290 setp.lt.s32 %p36, %r392, 0
  p36 = (((int)(r392)) < ((int)(0)));
  // PTX:291 setp.gt.s32 %p37, %r394, -1
  p37 = (((int)(r394)) > ((int)(-1)));
  // PTX:292 and.pred %p38, %p36, %p37
  p38 = ((p36) && (p37));
  // PTX:293 or.pred %p39, %p35, %p38
  p39 = ((p35) || (p38));
  // PTX:294 and.b32 %r260, %r394, %r393
  asm("and.b32 %0, %1, %2;" : "=r"(r260) : "r"(r394), "r"(r393));
  // PTX:295 setp.lt.s32 %p40, %r260, 0
  p40 = (((int)(r260)) < ((int)(0)));
  // PTX:296 or.pred %p41, %p40, %p39
  p41 = ((p40) || (p39));
  // PTX:297 @%p41 bra $L__BB2_203
  if (p41) { goto L_BB2_203; }
  // PTX:299 or.b32 %r261, %r392, %r391
  asm("or.b32 %0, %1, %2;" : "=r"(r261) : "r"(r392), "r"(r391));
  // PTX:300 setp.gt.s32 %p42, %r261, -1
  p42 = (((int)(r261)) > ((int)(-1)));
  // PTX:301 setp.ne.s32 %p43, %r391, %r392
  p43 = (((int)(r391)) != ((int)(r392)));
  // PTX:302 and.pred %p44, %p43, %p42
  p44 = ((p43) && (p42));
  // PTX:303 @%p44 bra $L__BB2_203
  if (p44) { goto L_BB2_203; }
  // PTX:305 mov.u32 %r399, 0
  asm("mov.u32 %0, 0;" : "=r"(r399) : );
  // PTX:306 mov.u32 %r395, %r399
  asm("mov.u32 %0, %1;" : "=r"(r395) : "r"(r399));
  // PTX:307 mov.u32 %r396, %r399
  asm("mov.u32 %0, %1;" : "=r"(r396) : "r"(r399));
  // PTX:308 mov.u32 %r397, %r399
  asm("mov.u32 %0, %1;" : "=r"(r397) : "r"(r399));
  // PTX:309 mov.u32 %r398, %r399
  asm("mov.u32 %0, %1;" : "=r"(r398) : "r"(r399));
  // PTX:310 @%p26 bra $L__BB2_38
  if (p26) { goto L_BB2_38; }
  // PTX:312 ld.param.u64 %rd438, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_27]
  rd438 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param27 + (0))));
  // PTX:313 ld.param.u64 %rd437, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_24]
  rd437 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param24 + (0))));
  // PTX:314 cvta.to.global.u64 %rd436, %rd437
  rd436 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd437));
  // PTX:315 mul.wide.s32 %rd154, %r393, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd154) : "r"(r393));
  // PTX:316 add.s64 %rd155, %rd436, %rd154
  asm("add.s64 %0, %1, %2;" : "=l"(rd155) : "l"(rd436), "l"(rd154));
  // PTX:317 cvt.u32.u64 %r266, %rd438
  asm("cvt.u32.u64 %0, %1;" : "=r"(r266) : "l"(rd438));
  // PTX:318 mul.lo.s32 %r267, %r391, %r266
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r267) : "r"(r391), "r"(r266));
  // PTX:319 ld.global.u32 %r268, [%rd155]
  r268 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd155) + (0)))));
  // PTX:320 ld.global.u32 %r269, [%rd155+4]
  r269 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd155) + (4)))));
  // PTX:321 ld.global.u32 %r270, [%rd155+8]
  r270 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd155) + (8)))));
  // PTX:322 ld.global.u32 %r271, [%rd155+12]
  r271 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd155) + (12)))));
  // PTX:323 add.s32 %r398, %r271, %r267
  asm("add.s32 %0, %1, %2;" : "=r"(r398) : "r"(r271), "r"(r267));
  // PTX:324 add.s32 %r397, %r270, %r267
  asm("add.s32 %0, %1, %2;" : "=r"(r397) : "r"(r270), "r"(r267));
  // PTX:325 add.s32 %r396, %r269, %r267
  asm("add.s32 %0, %1, %2;" : "=r"(r396) : "r"(r269), "r"(r267));
  // PTX:326 add.s32 %r395, %r268, %r267
  asm("add.s32 %0, %1, %2;" : "=r"(r395) : "r"(r268), "r"(r267));
  // PTX:328 $L__BB2_38:
L_BB2_38:;
  // PTX:329 mov.u32 %r400, %r399
  asm("mov.u32 %0, %1;" : "=r"(r400) : "r"(r399));
  // PTX:330 mov.u32 %r401, %r399
  asm("mov.u32 %0, %1;" : "=r"(r401) : "r"(r399));
  // PTX:331 mov.u32 %r402, %r399
  asm("mov.u32 %0, %1;" : "=r"(r402) : "r"(r399));
  // PTX:332 @%p29 bra $L__BB2_40
  if (p29) { goto L_BB2_40; }
  // PTX:334 ld.param.u64 %rd441, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_27]
  rd441 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param27 + (0))));
  // PTX:335 ld.param.u64 %rd440, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_24]
  rd440 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param24 + (0))));
  // PTX:336 cvta.to.global.u64 %rd439, %rd440
  rd439 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd440));
  // PTX:337 mul.wide.s32 %rd156, %r394, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd156) : "r"(r394));
  // PTX:338 add.s64 %rd157, %rd439, %rd156
  asm("add.s64 %0, %1, %2;" : "=l"(rd157) : "l"(rd439), "l"(rd156));
  // PTX:339 cvt.u32.u64 %r276, %rd441
  asm("cvt.u32.u64 %0, %1;" : "=r"(r276) : "l"(rd441));
  // PTX:340 mul.lo.s32 %r277, %r392, %r276
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r277) : "r"(r392), "r"(r276));
  // PTX:341 ld.global.u32 %r278, [%rd157]
  r278 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd157) + (0)))));
  // PTX:342 ld.global.u32 %r279, [%rd157+4]
  r279 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd157) + (4)))));
  // PTX:343 ld.global.u32 %r280, [%rd157+8]
  r280 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd157) + (8)))));
  // PTX:344 ld.global.u32 %r281, [%rd157+12]
  r281 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd157) + (12)))));
  // PTX:345 add.s32 %r402, %r281, %r277
  asm("add.s32 %0, %1, %2;" : "=r"(r402) : "r"(r281), "r"(r277));
  // PTX:346 add.s32 %r401, %r280, %r277
  asm("add.s32 %0, %1, %2;" : "=r"(r401) : "r"(r280), "r"(r277));
  // PTX:347 add.s32 %r400, %r279, %r277
  asm("add.s32 %0, %1, %2;" : "=r"(r400) : "r"(r279), "r"(r277));
  // PTX:348 add.s32 %r399, %r278, %r277
  asm("add.s32 %0, %1, %2;" : "=r"(r399) : "r"(r278), "r"(r277));
  // PTX:350 $L__BB2_40:
L_BB2_40:;
  // PTX:351 ld.param.u64 %rd428, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_8]
  rd428 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:352 cvta.to.global.u64 %rd158, %rd428
  rd158 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd428));
  // PTX:353 mul.lo.s64 %rd159, %rd13, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd159) : "l"(rd13));
  // PTX:354 add.s64 %rd160, %rd158, %rd159
  asm("add.s64 %0, %1, %2;" : "=l"(rd160) : "l"(rd158), "l"(rd159));
  // PTX:355 ld.global.f32 %f1, [%rd160]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd160) + (0)))));
  // PTX:356 ld.global.f32 %f2, [%rd160+4]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd160) + (4)))));
  // PTX:357 mul.f32 %f415, %f2, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f415) : "f"(f2), "f"(f2));
  // PTX:358 ld.global.f32 %f3, [%rd160+8]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd160) + (8)))));
  // PTX:359 fma.rn.f32 %f416, %f1, %f1, %f415
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f416) : "f"(f1), "f"(f1), "f"(f415));
  // PTX:360 fma.rn.f32 %f417, %f3, %f3, %f416
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f417) : "f"(f3), "f"(f3), "f"(f416));
  // PTX:361 sqrt.rn.f32 %f4, %f417
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f4) : "f"(f417));
  // PTX:362 setp.leu.f32 %p47, %f4, 0f00000000
  p47 = ((isnan(((float)(f4))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f4)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:363 mov.u32 %r403, 0
  asm("mov.u32 %0, 0;" : "=r"(r403) : );
  // PTX:364 mov.u32 %r404, %r403
  asm("mov.u32 %0, %1;" : "=r"(r404) : "r"(r403));
  // PTX:365 mov.u32 %r405, %r403
  asm("mov.u32 %0, %1;" : "=r"(r405) : "r"(r403));
  // PTX:366 @%p47 bra $L__BB2_42
  if (p47) { goto L_BB2_42; }
  // PTX:368 div.rn.f32 %f418, %f1, %f4
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f418) : "f"(f1), "f"(f4));
  // PTX:369 div.rn.f32 %f419, %f2, %f4
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f419) : "f"(f2), "f"(f4));
  // PTX:370 div.rn.f32 %f420, %f3, %f4
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f420) : "f"(f3), "f"(f4));
  // PTX:371 mov.b32 %r405, %f420
  asm("mov.b32 %0, %1;" : "=r"(r405) : "f"(f420));
  // PTX:372 mov.b32 %r404, %f419
  asm("mov.b32 %0, %1;" : "=r"(r404) : "f"(f419));
  // PTX:373 mov.b32 %r403, %f418
  asm("mov.b32 %0, %1;" : "=r"(r403) : "f"(f418));
  // PTX:375 $L__BB2_42:
L_BB2_42:;
  // PTX:376 ld.param.u64 %rd429, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_12]
  rd429 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:377 cvta.to.global.u64 %rd161, %rd429
  rd161 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd429));
  // PTX:378 shl.b64 %rd162, %rd33, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd162) : "l"(rd33));
  // PTX:379 add.s64 %rd163, %rd161, %rd162
  asm("add.s64 %0, %1, %2;" : "=l"(rd163) : "l"(rd161), "l"(rd162));
  // PTX:380 ld.global.u32 %r35, [%rd163]
  r35 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd163) + (0)))));
  // PTX:381 setp.eq.s32 %p48, %r35, 3
  p48 = (((int)(r35)) == ((int)(3)));
  // PTX:382 shl.b64 %rd164, %rd35, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd164) : "l"(rd35));
  // PTX:383 add.s64 %rd165, %rd161, %rd164
  asm("add.s64 %0, %1, %2;" : "=l"(rd165) : "l"(rd161), "l"(rd164));
  // PTX:384 ld.global.u32 %r36, [%rd165]
  r36 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd165) + (0)))));
  // PTX:385 @%p48 bra $L__BB2_44
  if (p48) { goto L_BB2_44; }
  // PTX:386 bra.uni $L__BB2_43
  goto L_BB2_43;
  // PTX:388 $L__BB2_44:
L_BB2_44:;
  // PTX:389 cvt.s64.s32 %rd483, %rd491
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd483) : "l"(rd491));
  // PTX:390 ld.param.u64 %rd455, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_13]
  rd455 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:391 cvta.to.global.u64 %rd454, %rd455
  rd454 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd455));
  // PTX:392 mul.lo.s64 %rd167, %rd483, 28
  asm("mul.lo.s64 %0, %1, 28;" : "=l"(rd167) : "l"(rd483));
  // PTX:393 add.s64 %rd499, %rd454, %rd167
  asm("add.s64 %0, %1, %2;" : "=l"(rd499) : "l"(rd454), "l"(rd167));
  // PTX:394 add.s64 %rd498, %rd499, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd498) : "l"(rd499));
  // PTX:395 add.s64 %rd497, %rd499, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd497) : "l"(rd499));
  // PTX:396 bra.uni $L__BB2_45
  goto L_BB2_45;
  // PTX:398 $L__BB2_43:
L_BB2_43:;
  // PTX:399 ld.param.u64 %rd431, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_4]
  rd431 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:400 cvta.to.global.u64 %rd430, %rd431
  rd430 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd431));
  // PTX:401 add.s64 %rd499, %rd430, %rd159
  asm("add.s64 %0, %1, %2;" : "=l"(rd499) : "l"(rd430), "l"(rd159));
  // PTX:402 add.s64 %rd498, %rd499, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd498) : "l"(rd499));
  // PTX:403 add.s64 %rd497, %rd499, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd497) : "l"(rd499));
  // PTX:405 $L__BB2_45:
L_BB2_45:;
  // PTX:406 ld.global.u32 %r37, [%rd499]
  r37 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd499) + (0)))));
  // PTX:407 ld.global.u32 %r38, [%rd498]
  r38 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd498) + (0)))));
  // PTX:408 ld.global.u32 %r39, [%rd497]
  r39 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd497) + (0)))));
  // PTX:409 setp.eq.s32 %p49, %r36, 3
  p49 = (((int)(r36)) == ((int)(3)));
  // PTX:410 @%p49 bra $L__BB2_47
  if (p49) { goto L_BB2_47; }
  // PTX:411 bra.uni $L__BB2_46
  goto L_BB2_46;
  // PTX:413 $L__BB2_47:
L_BB2_47:;
  // PTX:414 cvt.s64.s32 %rd482, %rd494
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd482) : "l"(rd494));
  // PTX:415 ld.param.u64 %rd453, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_13]
  rd453 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:416 cvta.to.global.u64 %rd452, %rd453
  rd452 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd453));
  // PTX:417 mul.lo.s64 %rd169, %rd482, 28
  asm("mul.lo.s64 %0, %1, 28;" : "=l"(rd169) : "l"(rd482));
  // PTX:418 add.s64 %rd502, %rd452, %rd169
  asm("add.s64 %0, %1, %2;" : "=l"(rd502) : "l"(rd452), "l"(rd169));
  // PTX:419 add.s64 %rd501, %rd502, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd501) : "l"(rd502));
  // PTX:420 add.s64 %rd500, %rd502, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd500) : "l"(rd502));
  // PTX:421 bra.uni $L__BB2_48
  goto L_BB2_48;
  // PTX:423 $L__BB2_46:
L_BB2_46:;
  // PTX:424 ld.param.u64 %rd433, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_5]
  rd433 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:425 cvta.to.global.u64 %rd432, %rd433
  rd432 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd433));
  // PTX:426 add.s64 %rd502, %rd432, %rd159
  asm("add.s64 %0, %1, %2;" : "=l"(rd502) : "l"(rd432), "l"(rd159));
  // PTX:427 add.s64 %rd501, %rd502, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd501) : "l"(rd502));
  // PTX:428 add.s64 %rd500, %rd502, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd500) : "l"(rd502));
  // PTX:430 $L__BB2_48:
L_BB2_48:;
  // PTX:431 ld.param.u64 %rd443, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_25]
  rd443 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param25 + (0))));
  // PTX:432 cvta.to.global.u64 %rd442, %rd443
  rd442 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd443));
  // PTX:433 ld.global.u32 %r40, [%rd502]
  r40 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd502) + (0)))));
  // PTX:434 ld.global.u32 %r41, [%rd501]
  r41 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd501) + (0)))));
  // PTX:435 ld.global.u32 %r42, [%rd500]
  r42 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd500) + (0)))));
  // PTX:436 mul.wide.s32 %rd170, %r393, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd170) : "r"(r393));
  // PTX:437 add.s64 %rd59, %rd442, %rd170
  asm("add.s64 %0, %1, %2;" : "=l"(rd59) : "l"(rd442), "l"(rd170));
  // PTX:438 mov.u32 %r406, %r39
  asm("mov.u32 %0, %1;" : "=r"(r406) : "r"(r39));
  // PTX:439 mov.u32 %r407, %r38
  asm("mov.u32 %0, %1;" : "=r"(r407) : "r"(r38));
  // PTX:440 mov.u32 %r408, %r37
  asm("mov.u32 %0, %1;" : "=r"(r408) : "r"(r37));
  // PTX:441 @%p26 bra $L__BB2_50
  if (p26) { goto L_BB2_50; }
  // PTX:443 ld.global.f32 %f421, [%rd59]
  f421 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:444 mov.b32 %f422, %r37
  asm("mov.b32 %0, %1;" : "=f"(f422) : "r"(r37));
  // PTX:445 sub.f32 %f423, %f422, %f421
  asm("sub.f32 %0, %1, %2;" : "=f"(f423) : "f"(f422), "f"(f421));
  // PTX:446 mov.b32 %f424, %r38
  asm("mov.b32 %0, %1;" : "=f"(f424) : "r"(r38));
  // PTX:447 ld.global.f32 %f425, [%rd59+4]
  f425 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4)))));
  // PTX:448 sub.f32 %f426, %f424, %f425
  asm("sub.f32 %0, %1, %2;" : "=f"(f426) : "f"(f424), "f"(f425));
  // PTX:449 mov.b32 %f427, %r39
  asm("mov.b32 %0, %1;" : "=f"(f427) : "r"(r39));
  // PTX:450 ld.global.f32 %f428, [%rd59+8]
  f428 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8)))));
  // PTX:451 sub.f32 %f429, %f427, %f428
  asm("sub.f32 %0, %1, %2;" : "=f"(f429) : "f"(f427), "f"(f428));
  // PTX:452 mul.wide.s32 %rd171, %r395, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd171) : "r"(r395));
  // PTX:453 add.s64 %rd172, %rd6, %rd171
  asm("add.s64 %0, %1, %2;" : "=l"(rd172) : "l"(rd6), "l"(rd171));
  // PTX:454 mul.wide.s32 %rd173, %r396, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd173) : "r"(r396));
  // PTX:455 add.s64 %rd174, %rd6, %rd173
  asm("add.s64 %0, %1, %2;" : "=l"(rd174) : "l"(rd6), "l"(rd173));
  // PTX:456 ld.global.f32 %f430, [%rd174]
  f430 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (0)))));
  // PTX:457 ld.global.f32 %f431, [%rd174+4]
  f431 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (4)))));
  // PTX:458 ld.global.f32 %f432, [%rd174+8]
  f432 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (8)))));
  // PTX:459 ld.global.f32 %f433, [%rd172]
  f433 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (0)))));
  // PTX:460 fma.rn.f32 %f434, %f423, %f430, %f433
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f434) : "f"(f423), "f"(f430), "f"(f433));
  // PTX:461 ld.global.f32 %f435, [%rd172+4]
  f435 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (4)))));
  // PTX:462 fma.rn.f32 %f436, %f423, %f431, %f435
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f436) : "f"(f423), "f"(f431), "f"(f435));
  // PTX:463 ld.global.f32 %f437, [%rd172+8]
  f437 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (8)))));
  // PTX:464 fma.rn.f32 %f438, %f423, %f432, %f437
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f438) : "f"(f423), "f"(f432), "f"(f437));
  // PTX:465 mul.wide.s32 %rd175, %r397, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd175) : "r"(r397));
  // PTX:466 add.s64 %rd176, %rd6, %rd175
  asm("add.s64 %0, %1, %2;" : "=l"(rd176) : "l"(rd6), "l"(rd175));
  // PTX:467 ld.global.f32 %f439, [%rd176]
  f439 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (0)))));
  // PTX:468 ld.global.f32 %f440, [%rd176+4]
  f440 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (4)))));
  // PTX:469 ld.global.f32 %f441, [%rd176+8]
  f441 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (8)))));
  // PTX:470 fma.rn.f32 %f442, %f426, %f439, %f434
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f442) : "f"(f426), "f"(f439), "f"(f434));
  // PTX:471 fma.rn.f32 %f443, %f426, %f440, %f436
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f443) : "f"(f426), "f"(f440), "f"(f436));
  // PTX:472 fma.rn.f32 %f444, %f426, %f441, %f438
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f444) : "f"(f426), "f"(f441), "f"(f438));
  // PTX:473 mul.wide.s32 %rd177, %r398, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd177) : "r"(r398));
  // PTX:474 add.s64 %rd178, %rd6, %rd177
  asm("add.s64 %0, %1, %2;" : "=l"(rd178) : "l"(rd6), "l"(rd177));
  // PTX:475 ld.global.f32 %f445, [%rd178]
  f445 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (0)))));
  // PTX:476 ld.global.f32 %f446, [%rd178+4]
  f446 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (4)))));
  // PTX:477 ld.global.f32 %f447, [%rd178+8]
  f447 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd178) + (8)))));
  // PTX:478 fma.rn.f32 %f448, %f429, %f445, %f442
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f448) : "f"(f429), "f"(f445), "f"(f442));
  // PTX:479 fma.rn.f32 %f449, %f429, %f446, %f443
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f449) : "f"(f429), "f"(f446), "f"(f443));
  // PTX:480 fma.rn.f32 %f450, %f429, %f447, %f444
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f450) : "f"(f429), "f"(f447), "f"(f444));
  // PTX:481 mov.b32 %r408, %f448
  asm("mov.b32 %0, %1;" : "=r"(r408) : "f"(f448));
  // PTX:482 mov.b32 %r407, %f449
  asm("mov.b32 %0, %1;" : "=r"(r407) : "f"(f449));
  // PTX:483 mov.b32 %r406, %f450
  asm("mov.b32 %0, %1;" : "=r"(r406) : "f"(f450));
  // PTX:485 $L__BB2_50:
L_BB2_50:;
  // PTX:486 ld.param.u64 %rd445, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_25]
  rd445 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param25 + (0))));
  // PTX:487 cvta.to.global.u64 %rd444, %rd445
  rd444 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd445));
  // PTX:488 mul.wide.s32 %rd179, %r394, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd179) : "r"(r394));
  // PTX:489 add.s64 %rd60, %rd444, %rd179
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd444), "l"(rd179));
  // PTX:490 mov.u32 %r409, %r42
  asm("mov.u32 %0, %1;" : "=r"(r409) : "r"(r42));
  // PTX:491 mov.u32 %r410, %r41
  asm("mov.u32 %0, %1;" : "=r"(r410) : "r"(r41));
  // PTX:492 mov.u32 %r411, %r40
  asm("mov.u32 %0, %1;" : "=r"(r411) : "r"(r40));
  // PTX:493 @%p29 bra $L__BB2_52
  if (p29) { goto L_BB2_52; }
  // PTX:495 ld.global.f32 %f451, [%rd60]
  f451 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:496 mov.b32 %f452, %r40
  asm("mov.b32 %0, %1;" : "=f"(f452) : "r"(r40));
  // PTX:497 sub.f32 %f453, %f452, %f451
  asm("sub.f32 %0, %1, %2;" : "=f"(f453) : "f"(f452), "f"(f451));
  // PTX:498 mov.b32 %f454, %r41
  asm("mov.b32 %0, %1;" : "=f"(f454) : "r"(r41));
  // PTX:499 ld.global.f32 %f455, [%rd60+4]
  f455 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:500 sub.f32 %f456, %f454, %f455
  asm("sub.f32 %0, %1, %2;" : "=f"(f456) : "f"(f454), "f"(f455));
  // PTX:501 mov.b32 %f457, %r42
  asm("mov.b32 %0, %1;" : "=f"(f457) : "r"(r42));
  // PTX:502 ld.global.f32 %f458, [%rd60+8]
  f458 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:503 sub.f32 %f459, %f457, %f458
  asm("sub.f32 %0, %1, %2;" : "=f"(f459) : "f"(f457), "f"(f458));
  // PTX:504 mul.wide.s32 %rd180, %r399, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd180) : "r"(r399));
  // PTX:505 add.s64 %rd181, %rd6, %rd180
  asm("add.s64 %0, %1, %2;" : "=l"(rd181) : "l"(rd6), "l"(rd180));
  // PTX:506 mul.wide.s32 %rd182, %r400, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd182) : "r"(r400));
  // PTX:507 add.s64 %rd183, %rd6, %rd182
  asm("add.s64 %0, %1, %2;" : "=l"(rd183) : "l"(rd6), "l"(rd182));
  // PTX:508 ld.global.f32 %f460, [%rd183]
  f460 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (0)))));
  // PTX:509 ld.global.f32 %f461, [%rd183+4]
  f461 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (4)))));
  // PTX:510 ld.global.f32 %f462, [%rd183+8]
  f462 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd183) + (8)))));
  // PTX:511 ld.global.f32 %f463, [%rd181]
  f463 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd181) + (0)))));
  // PTX:512 fma.rn.f32 %f464, %f453, %f460, %f463
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f464) : "f"(f453), "f"(f460), "f"(f463));
  // PTX:513 ld.global.f32 %f465, [%rd181+4]
  f465 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd181) + (4)))));
  // PTX:514 fma.rn.f32 %f466, %f453, %f461, %f465
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f466) : "f"(f453), "f"(f461), "f"(f465));
  // PTX:515 ld.global.f32 %f467, [%rd181+8]
  f467 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd181) + (8)))));
  // PTX:516 fma.rn.f32 %f468, %f453, %f462, %f467
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f468) : "f"(f453), "f"(f462), "f"(f467));
  // PTX:517 mul.wide.s32 %rd184, %r401, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd184) : "r"(r401));
  // PTX:518 add.s64 %rd185, %rd6, %rd184
  asm("add.s64 %0, %1, %2;" : "=l"(rd185) : "l"(rd6), "l"(rd184));
  // PTX:519 ld.global.f32 %f469, [%rd185]
  f469 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (0)))));
  // PTX:520 ld.global.f32 %f470, [%rd185+4]
  f470 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (4)))));
  // PTX:521 ld.global.f32 %f471, [%rd185+8]
  f471 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (8)))));
  // PTX:522 fma.rn.f32 %f472, %f456, %f469, %f464
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f472) : "f"(f456), "f"(f469), "f"(f464));
  // PTX:523 fma.rn.f32 %f473, %f456, %f470, %f466
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f473) : "f"(f456), "f"(f470), "f"(f466));
  // PTX:524 fma.rn.f32 %f474, %f456, %f471, %f468
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f474) : "f"(f456), "f"(f471), "f"(f468));
  // PTX:525 mul.wide.s32 %rd186, %r402, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd186) : "r"(r402));
  // PTX:526 add.s64 %rd187, %rd6, %rd186
  asm("add.s64 %0, %1, %2;" : "=l"(rd187) : "l"(rd6), "l"(rd186));
  // PTX:527 ld.global.f32 %f475, [%rd187]
  f475 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (0)))));
  // PTX:528 ld.global.f32 %f476, [%rd187+4]
  f476 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (4)))));
  // PTX:529 ld.global.f32 %f477, [%rd187+8]
  f477 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (8)))));
  // PTX:530 fma.rn.f32 %f478, %f459, %f475, %f472
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f478) : "f"(f459), "f"(f475), "f"(f472));
  // PTX:531 fma.rn.f32 %f479, %f459, %f476, %f473
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f479) : "f"(f459), "f"(f476), "f"(f473));
  // PTX:532 fma.rn.f32 %f480, %f459, %f477, %f474
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f480) : "f"(f459), "f"(f477), "f"(f474));
  // PTX:533 mov.b32 %r411, %f478
  asm("mov.b32 %0, %1;" : "=r"(r411) : "f"(f478));
  // PTX:534 mov.b32 %r410, %f479
  asm("mov.b32 %0, %1;" : "=r"(r410) : "f"(f479));
  // PTX:535 mov.b32 %r409, %f480
  asm("mov.b32 %0, %1;" : "=r"(r409) : "f"(f480));
  // PTX:537 $L__BB2_52:
L_BB2_52:;
  // PTX:538 setp.ne.s32 %p52, %r35, 3
  p52 = (((int)(r35)) != ((int)(3)));
  // PTX:539 setp.ne.s32 %p53, %r36, 3
  p53 = (((int)(r36)) != ((int)(3)));
  // PTX:540 mov.u32 %r415, 0
  asm("mov.u32 %0, 0;" : "=r"(r415) : );
  // PTX:541 or.pred %p54, %p52, %p53
  p54 = ((p52) || (p53));
  // PTX:542 mov.u32 %r416, %r415
  asm("mov.u32 %0, %1;" : "=r"(r416) : "r"(r415));
  // PTX:543 mov.u32 %r417, %r415
  asm("mov.u32 %0, %1;" : "=r"(r417) : "r"(r415));
  // PTX:544 @%p54 bra $L__BB2_55
  if (p54) { goto L_BB2_55; }
  // PTX:546 mov.b32 %f481, %r411
  asm("mov.b32 %0, %1;" : "=f"(f481) : "r"(r411));
  // PTX:547 mov.b32 %f482, %r408
  asm("mov.b32 %0, %1;" : "=f"(f482) : "r"(r408));
  // PTX:548 sub.f32 %f5, %f481, %f482
  asm("sub.f32 %0, %1, %2;" : "=f"(f5) : "f"(f481), "f"(f482));
  // PTX:549 mov.b32 %f483, %r407
  asm("mov.b32 %0, %1;" : "=f"(f483) : "r"(r407));
  // PTX:550 mov.b32 %f484, %r410
  asm("mov.b32 %0, %1;" : "=f"(f484) : "r"(r410));
  // PTX:551 sub.f32 %f6, %f484, %f483
  asm("sub.f32 %0, %1, %2;" : "=f"(f6) : "f"(f484), "f"(f483));
  // PTX:552 mov.b32 %f485, %r406
  asm("mov.b32 %0, %1;" : "=f"(f485) : "r"(r406));
  // PTX:553 mov.b32 %f486, %r409
  asm("mov.b32 %0, %1;" : "=f"(f486) : "r"(r409));
  // PTX:554 sub.f32 %f7, %f486, %f485
  asm("sub.f32 %0, %1, %2;" : "=f"(f7) : "f"(f486), "f"(f485));
  // PTX:555 mul.f32 %f487, %f5, %f5
  asm("mul.f32 %0, %1, %2;" : "=f"(f487) : "f"(f5), "f"(f5));
  // PTX:556 fma.rn.f32 %f488, %f6, %f6, %f487
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f488) : "f"(f6), "f"(f6), "f"(f487));
  // PTX:557 fma.rn.f32 %f489, %f7, %f7, %f488
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f489) : "f"(f7), "f"(f7), "f"(f488));
  // PTX:558 sqrt.rn.f32 %f8, %f489
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f8) : "f"(f489));
  // PTX:559 setp.leu.f32 %p55, %f8, 0f00000000
  p55 = ((isnan(((float)(f8))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f8)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:560 mov.u32 %r415, 0
  asm("mov.u32 %0, 0;" : "=r"(r415) : );
  // PTX:561 @%p55 bra $L__BB2_55
  if (p55) { goto L_BB2_55; }
  // PTX:563 div.rn.f32 %f490, %f5, %f8
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f490) : "f"(f5), "f"(f8));
  // PTX:564 div.rn.f32 %f491, %f6, %f8
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f491) : "f"(f6), "f"(f8));
  // PTX:565 div.rn.f32 %f492, %f7, %f8
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f492) : "f"(f7), "f"(f8));
  // PTX:566 mov.b32 %r417, %f492
  asm("mov.b32 %0, %1;" : "=r"(r417) : "f"(f492));
  // PTX:567 mov.b32 %r416, %f491
  asm("mov.b32 %0, %1;" : "=r"(r416) : "f"(f491));
  // PTX:568 mov.b32 %r415, %f490
  asm("mov.b32 %0, %1;" : "=r"(r415) : "f"(f490));
  // PTX:570 $L__BB2_55:
L_BB2_55:;
  // PTX:571 mov.b32 %f493, %r415
  asm("mov.b32 %0, %1;" : "=f"(f493) : "r"(r415));
  // PTX:572 mov.b32 %f494, %r416
  asm("mov.b32 %0, %1;" : "=f"(f494) : "r"(r416));
  // PTX:573 mul.f32 %f495, %f494, %f494
  asm("mul.f32 %0, %1, %2;" : "=f"(f495) : "f"(f494), "f"(f494));
  // PTX:574 mov.b32 %f496, %r417
  asm("mov.b32 %0, %1;" : "=f"(f496) : "r"(r417));
  // PTX:575 fma.rn.f32 %f497, %f493, %f493, %f495
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f497) : "f"(f493), "f"(f493), "f"(f495));
  // PTX:576 fma.rn.f32 %f498, %f496, %f496, %f497
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f498) : "f"(f496), "f"(f496), "f"(f497));
  // PTX:577 setp.ltu.f32 %p56, %f498, 0f3F000000
  p56 = ((isnan(((float)(f498))) || isnan(((float)(as_f32(0x3F000000u))))) || (((float)(f498)) < ((float)(as_f32(0x3F000000u)))));
  // PTX:578 selp.b32 %r291, %r405, %r417, %p56
  r291 = p56 ? r405 : r417;
  // PTX:579 selp.b32 %r292, %r404, %r416, %p56
  r292 = p56 ? r404 : r416;
  // PTX:580 selp.b32 %r293, %r403, %r415, %p56
  r293 = p56 ? r403 : r415;
  // PTX:581 mov.b32 %f9, %r293
  asm("mov.b32 %0, %1;" : "=f"(f9) : "r"(r293));
  // PTX:582 mov.b32 %f10, %r292
  asm("mov.b32 %0, %1;" : "=f"(f10) : "r"(r292));
  // PTX:583 mul.f32 %f499, %f10, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f499) : "f"(f10), "f"(f10));
  // PTX:584 mov.b32 %f11, %r291
  asm("mov.b32 %0, %1;" : "=f"(f11) : "r"(r291));
  // PTX:585 fma.rn.f32 %f500, %f9, %f9, %f499
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f500) : "f"(f9), "f"(f9), "f"(f499));
  // PTX:586 fma.rn.f32 %f501, %f11, %f11, %f500
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f501) : "f"(f11), "f"(f11), "f"(f500));
  // PTX:587 setp.ltu.f32 %p57, %f501, 0f3F000000
  p57 = ((isnan(((float)(f501))) || isnan(((float)(as_f32(0x3F000000u))))) || (((float)(f501)) < ((float)(as_f32(0x3F000000u)))));
  // PTX:588 @%p57 bra $L__BB2_203
  if (p57) { goto L_BB2_203; }
  // PTX:590 setp.ne.s32 %p167, %r35, 3
  p167 = (((int)(r35)) != ((int)(3)));
  // PTX:591 mov.u32 %r446, %r39
  asm("mov.u32 %0, %1;" : "=r"(r446) : "r"(r39));
  // PTX:592 mov.u32 %r447, %r38
  asm("mov.u32 %0, %1;" : "=r"(r447) : "r"(r38));
  // PTX:593 mov.u32 %r448, %r37
  asm("mov.u32 %0, %1;" : "=r"(r448) : "r"(r37));
  // PTX:594 @%p167 bra $L__BB2_80
  if (p167) { goto L_BB2_80; }
  // PTX:596 cvt.s64.s32 %rd424, %rd491
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd424) : "l"(rd491));
  // PTX:597 ld.param.u64 %rd423, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_14]
  rd423 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:598 cvta.to.global.u64 %rd422, %rd423
  rd422 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd423));
  // PTX:599 mul.lo.s64 %rd188, %rd424, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd188) : "l"(rd424));
  // PTX:600 add.s64 %rd189, %rd422, %rd188
  asm("add.s64 %0, %1, %2;" : "=l"(rd189) : "l"(rd422), "l"(rd188));
  // PTX:601 ld.global.f32 %f502, [%rd189]
  f502 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd189) + (0)))));
  // PTX:602 mul.f32 %f12, %f502, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f12) : "f"(f502), "f"(f9));
  // PTX:603 mul.f32 %f13, %f502, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f13) : "f"(f502), "f"(f10));
  // PTX:604 mul.f32 %f14, %f502, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f14) : "f"(f502), "f"(f11));
  // PTX:605 @%p26 bra $L__BB2_79
  if (p26) { goto L_BB2_79; }
  // PTX:607 mul.wide.s32 %rd190, %r396, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd190) : "r"(r396));
  // PTX:608 add.s64 %rd191, %rd6, %rd190
  asm("add.s64 %0, %1, %2;" : "=l"(rd191) : "l"(rd6), "l"(rd190));
  // PTX:609 mul.wide.s32 %rd192, %r397, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd192) : "r"(r397));
  // PTX:610 add.s64 %rd193, %rd6, %rd192
  asm("add.s64 %0, %1, %2;" : "=l"(rd193) : "l"(rd6), "l"(rd192));
  // PTX:611 mul.wide.s32 %rd194, %r398, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd194) : "r"(r398));
  // PTX:612 add.s64 %rd195, %rd6, %rd194
  asm("add.s64 %0, %1, %2;" : "=l"(rd195) : "l"(rd6), "l"(rd194));
  // PTX:613 ld.global.f32 %f15, [%rd195+8]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd195) + (8)))));
  // PTX:614 ld.global.f32 %f16, [%rd193+4]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd193) + (4)))));
  // PTX:615 mul.f32 %f503, %f16, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f503) : "f"(f16), "f"(f15));
  // PTX:616 ld.global.f32 %f17, [%rd195+4]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd195) + (4)))));
  // PTX:617 ld.global.f32 %f18, [%rd193+8]
  f18 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd193) + (8)))));
  // PTX:618 mul.f32 %f504, %f18, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f504) : "f"(f18), "f"(f17));
  // PTX:619 sub.f32 %f19, %f503, %f504
  asm("sub.f32 %0, %1, %2;" : "=f"(f19) : "f"(f503), "f"(f504));
  // PTX:620 ld.global.f32 %f20, [%rd195]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd195) + (0)))));
  // PTX:621 mul.f32 %f505, %f18, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f505) : "f"(f18), "f"(f20));
  // PTX:622 ld.global.f32 %f21, [%rd193]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd193) + (0)))));
  // PTX:623 mul.f32 %f506, %f21, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f506) : "f"(f21), "f"(f15));
  // PTX:624 sub.f32 %f22, %f505, %f506
  asm("sub.f32 %0, %1, %2;" : "=f"(f22) : "f"(f505), "f"(f506));
  // PTX:625 mul.f32 %f507, %f21, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f507) : "f"(f21), "f"(f17));
  // PTX:626 mul.f32 %f508, %f16, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f508) : "f"(f16), "f"(f20));
  // PTX:627 sub.f32 %f23, %f507, %f508
  asm("sub.f32 %0, %1, %2;" : "=f"(f23) : "f"(f507), "f"(f508));
  // PTX:628 ld.global.f32 %f24, [%rd191]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd191) + (0)))));
  // PTX:629 ld.global.f32 %f25, [%rd191+4]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd191) + (4)))));
  // PTX:630 mul.f32 %f509, %f25, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f509) : "f"(f25), "f"(f22));
  // PTX:631 ld.global.f32 %f26, [%rd191+8]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd191) + (8)))));
  // PTX:632 fma.rn.f32 %f510, %f24, %f19, %f509
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f510) : "f"(f24), "f"(f19), "f"(f509));
  // PTX:633 fma.rn.f32 %f27, %f26, %f23, %f510
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f27) : "f"(f26), "f"(f23), "f"(f510));
  // PTX:634 abs.f32 %f511, %f27
  asm("abs.f32 %0, %1;" : "=f"(f511) : "f"(f27));
  // PTX:635 setp.leu.f32 %p60, %f511, 0f2EDBE6FF
  p60 = ((isnan(((float)(f511))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) || (((float)(f511)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:636 setp.geu.f32 %p61, %f511, 0f7F800000
  p61 = ((isnan(((float)(f511))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f511)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:637 or.pred %p62, %p60, %p61
  p62 = ((p60) || (p61));
  // PTX:638 @%p62 bra $L__BB2_60
  if (p62) { goto L_BB2_60; }
  // PTX:639 bra.uni $L__BB2_59
  goto L_BB2_59;
  // PTX:641 $L__BB2_60:
L_BB2_60:;
  // PTX:642 mul.f32 %f549, %f25, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f549) : "f"(f25), "f"(f25));
  // PTX:643 fma.rn.f32 %f550, %f24, %f24, %f549
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f550) : "f"(f24), "f"(f24), "f"(f549));
  // PTX:644 fma.rn.f32 %f551, %f26, %f26, %f550
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f551) : "f"(f26), "f"(f26), "f"(f550));
  // PTX:645 mul.f32 %f552, %f16, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f552) : "f"(f16), "f"(f16));
  // PTX:646 fma.rn.f32 %f553, %f21, %f21, %f552
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f553) : "f"(f21), "f"(f21), "f"(f552));
  // PTX:647 fma.rn.f32 %f554, %f18, %f18, %f553
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f554) : "f"(f18), "f"(f18), "f"(f553));
  // PTX:648 add.f32 %f555, %f551, %f554
  asm("add.f32 %0, %1, %2;" : "=f"(f555) : "f"(f551), "f"(f554));
  // PTX:649 mul.f32 %f556, %f17, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f556) : "f"(f17), "f"(f17));
  // PTX:650 fma.rn.f32 %f557, %f20, %f20, %f556
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f557) : "f"(f20), "f"(f20), "f"(f556));
  // PTX:651 fma.rn.f32 %f558, %f15, %f15, %f557
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f558) : "f"(f15), "f"(f15), "f"(f557));
  // PTX:652 add.f32 %f559, %f555, %f558
  asm("add.f32 %0, %1, %2;" : "=f"(f559) : "f"(f555), "f"(f558));
  // PTX:653 div.rn.f32 %f560, %f559, 0f40400000
  asm("div.rn.f32 %0, %1, 0f40400000;" : "=f"(f560) : "f"(f559));
  // PTX:654 sqrt.rn.f32 %f28, %f560
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f28) : "f"(f560));
  // PTX:655 setp.leu.f32 %p63, %f28, 0f322BCC77
  p63 = ((isnan(((float)(f28))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f28)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:656 mov.u32 %r434, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r434) : );
  // PTX:657 mov.u32 %r435, 0
  asm("mov.u32 %0, 0;" : "=r"(r435) : );
  // PTX:658 mov.u32 %r436, %r435
  asm("mov.u32 %0, %1;" : "=r"(r436) : "r"(r435));
  // PTX:659 mov.u32 %r437, %r435
  asm("mov.u32 %0, %1;" : "=r"(r437) : "r"(r435));
  // PTX:660 mov.u32 %r438, %r434
  asm("mov.u32 %0, %1;" : "=r"(r438) : "r"(r434));
  // PTX:661 mov.u32 %r439, %r435
  asm("mov.u32 %0, %1;" : "=r"(r439) : "r"(r435));
  // PTX:662 mov.u32 %r440, %r435
  asm("mov.u32 %0, %1;" : "=r"(r440) : "r"(r435));
  // PTX:663 mov.u32 %r441, %r435
  asm("mov.u32 %0, %1;" : "=r"(r441) : "r"(r435));
  // PTX:664 mov.u32 %r442, %r434
  asm("mov.u32 %0, %1;" : "=r"(r442) : "r"(r434));
  // PTX:665 @%p63 bra $L__BB2_77
  if (p63) { goto L_BB2_77; }
  // PTX:667 abs.f32 %f561, %f28
  asm("abs.f32 %0, %1;" : "=f"(f561) : "f"(f28));
  // PTX:668 setp.geu.f32 %p64, %f561, 0f7F800000
  p64 = ((isnan(((float)(f561))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f561)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:669 @%p64 bra $L__BB2_77
  if (p64) { goto L_BB2_77; }
  // PTX:671 rcp.rn.f32 %f562, %f28
  asm("rcp.rn.f32 %0, %1;" : "=f"(f562) : "f"(f28));
  // PTX:672 mul.f32 %f1568, %f24, %f562
  asm("mul.f32 %0, %1, %2;" : "=f"(f1568) : "f"(f24), "f"(f562));
  // PTX:673 mul.f32 %f1569, %f25, %f562
  asm("mul.f32 %0, %1, %2;" : "=f"(f1569) : "f"(f25), "f"(f562));
  // PTX:674 mul.f32 %f1570, %f26, %f562
  asm("mul.f32 %0, %1, %2;" : "=f"(f1570) : "f"(f26), "f"(f562));
  // PTX:675 mul.f32 %f1571, %f21, %f562
  asm("mul.f32 %0, %1, %2;" : "=f"(f1571) : "f"(f21), "f"(f562));
  // PTX:676 mul.f32 %f1572, %f16, %f562
  asm("mul.f32 %0, %1, %2;" : "=f"(f1572) : "f"(f16), "f"(f562));
  // PTX:677 mul.f32 %f1573, %f18, %f562
  asm("mul.f32 %0, %1, %2;" : "=f"(f1573) : "f"(f18), "f"(f562));
  // PTX:678 mul.f32 %f1574, %f20, %f562
  asm("mul.f32 %0, %1, %2;" : "=f"(f1574) : "f"(f20), "f"(f562));
  // PTX:679 mul.f32 %f1575, %f17, %f562
  asm("mul.f32 %0, %1, %2;" : "=f"(f1575) : "f"(f17), "f"(f562));
  // PTX:680 mul.f32 %f1576, %f15, %f562
  asm("mul.f32 %0, %1, %2;" : "=f"(f1576) : "f"(f15), "f"(f562));
  // PTX:681 mov.u32 %r418, 0
  asm("mov.u32 %0, 0;" : "=r"(r418) : );
  // PTX:683 $L__BB2_63:
L_BB2_63:;
  // PTX:684 mul.f32 %f563, %f1573, %f1575
  asm("mul.f32 %0, %1, %2;" : "=f"(f563) : "f"(f1573), "f"(f1575));
  // PTX:685 mul.f32 %f564, %f1572, %f1576
  asm("mul.f32 %0, %1, %2;" : "=f"(f564) : "f"(f1572), "f"(f1576));
  // PTX:686 sub.f32 %f47, %f564, %f563
  asm("sub.f32 %0, %1, %2;" : "=f"(f47) : "f"(f564), "f"(f563));
  // PTX:687 mul.f32 %f565, %f1571, %f1576
  asm("mul.f32 %0, %1, %2;" : "=f"(f565) : "f"(f1571), "f"(f1576));
  // PTX:688 mul.f32 %f566, %f1573, %f1574
  asm("mul.f32 %0, %1, %2;" : "=f"(f566) : "f"(f1573), "f"(f1574));
  // PTX:689 sub.f32 %f48, %f566, %f565
  asm("sub.f32 %0, %1, %2;" : "=f"(f48) : "f"(f566), "f"(f565));
  // PTX:690 mul.f32 %f567, %f1572, %f1574
  asm("mul.f32 %0, %1, %2;" : "=f"(f567) : "f"(f1572), "f"(f1574));
  // PTX:691 mul.f32 %f568, %f1571, %f1575
  asm("mul.f32 %0, %1, %2;" : "=f"(f568) : "f"(f1571), "f"(f1575));
  // PTX:692 sub.f32 %f49, %f568, %f567
  asm("sub.f32 %0, %1, %2;" : "=f"(f49) : "f"(f568), "f"(f567));
  // PTX:693 mul.f32 %f569, %f1569, %f48
  asm("mul.f32 %0, %1, %2;" : "=f"(f569) : "f"(f1569), "f"(f48));
  // PTX:694 fma.rn.f32 %f570, %f1568, %f47, %f569
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f570) : "f"(f1568), "f"(f47), "f"(f569));
  // PTX:695 fma.rn.f32 %f50, %f1570, %f49, %f570
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f50) : "f"(f1570), "f"(f49), "f"(f570));
  // PTX:696 abs.f32 %f571, %f50
  asm("abs.f32 %0, %1;" : "=f"(f571) : "f"(f50));
  // PTX:697 setp.le.f32 %p65, %f571, 0f2EDBE6FF
  p65 = (!(isnan(((float)(f571))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f571)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:698 setp.geu.f32 %p66, %f571, 0f7F800000
  p66 = ((isnan(((float)(f571))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f571)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:699 or.pred %p67, %p65, %p66
  p67 = ((p65) || (p66));
  // PTX:700 @%p67 bra $L__BB2_66
  if (p67) { goto L_BB2_66; }
  // PTX:702 rcp.rn.f32 %f572, %f50
  asm("rcp.rn.f32 %0, %1;" : "=f"(f572) : "f"(f50));
  // PTX:703 mul.f32 %f573, %f1569, %f1576
  asm("mul.f32 %0, %1, %2;" : "=f"(f573) : "f"(f1569), "f"(f1576));
  // PTX:704 mul.f32 %f574, %f1570, %f1575
  asm("mul.f32 %0, %1, %2;" : "=f"(f574) : "f"(f1570), "f"(f1575));
  // PTX:705 sub.f32 %f575, %f574, %f573
  asm("sub.f32 %0, %1, %2;" : "=f"(f575) : "f"(f574), "f"(f573));
  // PTX:706 mul.f32 %f576, %f1570, %f1574
  asm("mul.f32 %0, %1, %2;" : "=f"(f576) : "f"(f1570), "f"(f1574));
  // PTX:707 mul.f32 %f577, %f1568, %f1576
  asm("mul.f32 %0, %1, %2;" : "=f"(f577) : "f"(f1568), "f"(f1576));
  // PTX:708 sub.f32 %f578, %f577, %f576
  asm("sub.f32 %0, %1, %2;" : "=f"(f578) : "f"(f577), "f"(f576));
  // PTX:709 mul.f32 %f579, %f1568, %f1575
  asm("mul.f32 %0, %1, %2;" : "=f"(f579) : "f"(f1568), "f"(f1575));
  // PTX:710 mul.f32 %f580, %f1569, %f1574
  asm("mul.f32 %0, %1, %2;" : "=f"(f580) : "f"(f1569), "f"(f1574));
  // PTX:711 sub.f32 %f581, %f580, %f579
  asm("sub.f32 %0, %1, %2;" : "=f"(f581) : "f"(f580), "f"(f579));
  // PTX:712 mul.f32 %f582, %f1570, %f1572
  asm("mul.f32 %0, %1, %2;" : "=f"(f582) : "f"(f1570), "f"(f1572));
  // PTX:713 mul.f32 %f583, %f1569, %f1573
  asm("mul.f32 %0, %1, %2;" : "=f"(f583) : "f"(f1569), "f"(f1573));
  // PTX:714 sub.f32 %f584, %f583, %f582
  asm("sub.f32 %0, %1, %2;" : "=f"(f584) : "f"(f583), "f"(f582));
  // PTX:715 mul.f32 %f585, %f1568, %f1573
  asm("mul.f32 %0, %1, %2;" : "=f"(f585) : "f"(f1568), "f"(f1573));
  // PTX:716 mul.f32 %f586, %f1570, %f1571
  asm("mul.f32 %0, %1, %2;" : "=f"(f586) : "f"(f1570), "f"(f1571));
  // PTX:717 sub.f32 %f587, %f586, %f585
  asm("sub.f32 %0, %1, %2;" : "=f"(f587) : "f"(f586), "f"(f585));
  // PTX:718 mul.f32 %f588, %f1569, %f1571
  asm("mul.f32 %0, %1, %2;" : "=f"(f588) : "f"(f1569), "f"(f1571));
  // PTX:719 mul.f32 %f589, %f1568, %f1572
  asm("mul.f32 %0, %1, %2;" : "=f"(f589) : "f"(f1568), "f"(f1572));
  // PTX:720 sub.f32 %f590, %f589, %f588
  asm("sub.f32 %0, %1, %2;" : "=f"(f590) : "f"(f589), "f"(f588));
  // PTX:721 fma.rn.f32 %f591, %f47, %f572, %f1568
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f591) : "f"(f47), "f"(f572), "f"(f1568));
  // PTX:722 fma.rn.f32 %f592, %f48, %f572, %f1569
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f592) : "f"(f48), "f"(f572), "f"(f1569));
  // PTX:723 fma.rn.f32 %f593, %f49, %f572, %f1570
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f593) : "f"(f49), "f"(f572), "f"(f1570));
  // PTX:724 fma.rn.f32 %f594, %f575, %f572, %f1571
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f594) : "f"(f575), "f"(f572), "f"(f1571));
  // PTX:725 fma.rn.f32 %f595, %f578, %f572, %f1572
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f595) : "f"(f578), "f"(f572), "f"(f1572));
  // PTX:726 fma.rn.f32 %f596, %f581, %f572, %f1573
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f596) : "f"(f581), "f"(f572), "f"(f1573));
  // PTX:727 fma.rn.f32 %f597, %f584, %f572, %f1574
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f597) : "f"(f584), "f"(f572), "f"(f1574));
  // PTX:728 fma.rn.f32 %f598, %f587, %f572, %f1575
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f598) : "f"(f587), "f"(f572), "f"(f1575));
  // PTX:729 fma.rn.f32 %f599, %f590, %f572, %f1576
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f599) : "f"(f590), "f"(f572), "f"(f1576));
  // PTX:730 mul.f32 %f1568, %f591, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1568) : "f"(f591));
  // PTX:731 mul.f32 %f1569, %f592, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1569) : "f"(f592));
  // PTX:732 mul.f32 %f1570, %f593, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1570) : "f"(f593));
  // PTX:733 mul.f32 %f1571, %f594, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1571) : "f"(f594));
  // PTX:734 mul.f32 %f1572, %f595, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1572) : "f"(f595));
  // PTX:735 mul.f32 %f1573, %f596, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1573) : "f"(f596));
  // PTX:736 mul.f32 %f1574, %f597, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1574) : "f"(f597));
  // PTX:737 mul.f32 %f1575, %f598, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1575) : "f"(f598));
  // PTX:738 mul.f32 %f1576, %f599, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1576) : "f"(f599));
  // PTX:739 mul.f32 %f600, %f1572, %f1576
  asm("mul.f32 %0, %1, %2;" : "=f"(f600) : "f"(f1572), "f"(f1576));
  // PTX:740 mul.f32 %f601, %f1573, %f1575
  asm("mul.f32 %0, %1, %2;" : "=f"(f601) : "f"(f1573), "f"(f1575));
  // PTX:741 sub.f32 %f60, %f600, %f601
  asm("sub.f32 %0, %1, %2;" : "=f"(f60) : "f"(f600), "f"(f601));
  // PTX:742 mul.f32 %f602, %f1573, %f1574
  asm("mul.f32 %0, %1, %2;" : "=f"(f602) : "f"(f1573), "f"(f1574));
  // PTX:743 mul.f32 %f603, %f1571, %f1576
  asm("mul.f32 %0, %1, %2;" : "=f"(f603) : "f"(f1571), "f"(f1576));
  // PTX:744 sub.f32 %f61, %f602, %f603
  asm("sub.f32 %0, %1, %2;" : "=f"(f61) : "f"(f602), "f"(f603));
  // PTX:745 mul.f32 %f604, %f1571, %f1575
  asm("mul.f32 %0, %1, %2;" : "=f"(f604) : "f"(f1571), "f"(f1575));
  // PTX:746 mul.f32 %f605, %f1572, %f1574
  asm("mul.f32 %0, %1, %2;" : "=f"(f605) : "f"(f1572), "f"(f1574));
  // PTX:747 sub.f32 %f62, %f604, %f605
  asm("sub.f32 %0, %1, %2;" : "=f"(f62) : "f"(f604), "f"(f605));
  // PTX:748 mul.f32 %f606, %f1569, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f606) : "f"(f1569), "f"(f61));
  // PTX:749 fma.rn.f32 %f607, %f1568, %f60, %f606
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f607) : "f"(f1568), "f"(f60), "f"(f606));
  // PTX:750 fma.rn.f32 %f63, %f1570, %f62, %f607
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f63) : "f"(f1570), "f"(f62), "f"(f607));
  // PTX:751 abs.f32 %f608, %f63
  asm("abs.f32 %0, %1;" : "=f"(f608) : "f"(f63));
  // PTX:752 setp.le.f32 %p68, %f608, 0f2EDBE6FF
  p68 = (!(isnan(((float)(f608))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f608)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:753 setp.geu.f32 %p69, %f608, 0f7F800000
  p69 = ((isnan(((float)(f608))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f608)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:754 or.pred %p70, %p68, %p69
  p70 = ((p68) || (p69));
  // PTX:755 @%p70 bra $L__BB2_66
  if (p70) { goto L_BB2_66; }
  // PTX:757 rcp.rn.f32 %f609, %f63
  asm("rcp.rn.f32 %0, %1;" : "=f"(f609) : "f"(f63));
  // PTX:758 mul.f32 %f610, %f1569, %f1576
  asm("mul.f32 %0, %1, %2;" : "=f"(f610) : "f"(f1569), "f"(f1576));
  // PTX:759 mul.f32 %f611, %f1570, %f1575
  asm("mul.f32 %0, %1, %2;" : "=f"(f611) : "f"(f1570), "f"(f1575));
  // PTX:760 sub.f32 %f612, %f611, %f610
  asm("sub.f32 %0, %1, %2;" : "=f"(f612) : "f"(f611), "f"(f610));
  // PTX:761 mul.f32 %f613, %f1570, %f1574
  asm("mul.f32 %0, %1, %2;" : "=f"(f613) : "f"(f1570), "f"(f1574));
  // PTX:762 mul.f32 %f614, %f1568, %f1576
  asm("mul.f32 %0, %1, %2;" : "=f"(f614) : "f"(f1568), "f"(f1576));
  // PTX:763 sub.f32 %f615, %f614, %f613
  asm("sub.f32 %0, %1, %2;" : "=f"(f615) : "f"(f614), "f"(f613));
  // PTX:764 mul.f32 %f616, %f1568, %f1575
  asm("mul.f32 %0, %1, %2;" : "=f"(f616) : "f"(f1568), "f"(f1575));
  // PTX:765 mul.f32 %f617, %f1569, %f1574
  asm("mul.f32 %0, %1, %2;" : "=f"(f617) : "f"(f1569), "f"(f1574));
  // PTX:766 sub.f32 %f618, %f617, %f616
  asm("sub.f32 %0, %1, %2;" : "=f"(f618) : "f"(f617), "f"(f616));
  // PTX:767 mul.f32 %f619, %f1570, %f1572
  asm("mul.f32 %0, %1, %2;" : "=f"(f619) : "f"(f1570), "f"(f1572));
  // PTX:768 mul.f32 %f620, %f1569, %f1573
  asm("mul.f32 %0, %1, %2;" : "=f"(f620) : "f"(f1569), "f"(f1573));
  // PTX:769 sub.f32 %f621, %f620, %f619
  asm("sub.f32 %0, %1, %2;" : "=f"(f621) : "f"(f620), "f"(f619));
  // PTX:770 mul.f32 %f622, %f1568, %f1573
  asm("mul.f32 %0, %1, %2;" : "=f"(f622) : "f"(f1568), "f"(f1573));
  // PTX:771 mul.f32 %f623, %f1570, %f1571
  asm("mul.f32 %0, %1, %2;" : "=f"(f623) : "f"(f1570), "f"(f1571));
  // PTX:772 sub.f32 %f624, %f623, %f622
  asm("sub.f32 %0, %1, %2;" : "=f"(f624) : "f"(f623), "f"(f622));
  // PTX:773 mul.f32 %f625, %f1569, %f1571
  asm("mul.f32 %0, %1, %2;" : "=f"(f625) : "f"(f1569), "f"(f1571));
  // PTX:774 mul.f32 %f626, %f1568, %f1572
  asm("mul.f32 %0, %1, %2;" : "=f"(f626) : "f"(f1568), "f"(f1572));
  // PTX:775 sub.f32 %f627, %f626, %f625
  asm("sub.f32 %0, %1, %2;" : "=f"(f627) : "f"(f626), "f"(f625));
  // PTX:776 fma.rn.f32 %f628, %f60, %f609, %f1568
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f628) : "f"(f60), "f"(f609), "f"(f1568));
  // PTX:777 fma.rn.f32 %f629, %f61, %f609, %f1569
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f629) : "f"(f61), "f"(f609), "f"(f1569));
  // PTX:778 fma.rn.f32 %f630, %f62, %f609, %f1570
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f630) : "f"(f62), "f"(f609), "f"(f1570));
  // PTX:779 fma.rn.f32 %f631, %f612, %f609, %f1571
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f631) : "f"(f612), "f"(f609), "f"(f1571));
  // PTX:780 fma.rn.f32 %f632, %f615, %f609, %f1572
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f632) : "f"(f615), "f"(f609), "f"(f1572));
  // PTX:781 fma.rn.f32 %f633, %f618, %f609, %f1573
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f633) : "f"(f618), "f"(f609), "f"(f1573));
  // PTX:782 fma.rn.f32 %f634, %f621, %f609, %f1574
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f634) : "f"(f621), "f"(f609), "f"(f1574));
  // PTX:783 fma.rn.f32 %f635, %f624, %f609, %f1575
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f635) : "f"(f624), "f"(f609), "f"(f1575));
  // PTX:784 fma.rn.f32 %f636, %f627, %f609, %f1576
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f636) : "f"(f627), "f"(f609), "f"(f1576));
  // PTX:785 mul.f32 %f1568, %f628, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1568) : "f"(f628));
  // PTX:786 mul.f32 %f1569, %f629, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1569) : "f"(f629));
  // PTX:787 mul.f32 %f1570, %f630, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1570) : "f"(f630));
  // PTX:788 mul.f32 %f1571, %f631, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1571) : "f"(f631));
  // PTX:789 mul.f32 %f1572, %f632, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1572) : "f"(f632));
  // PTX:790 mul.f32 %f1573, %f633, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1573) : "f"(f633));
  // PTX:791 mul.f32 %f1574, %f634, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1574) : "f"(f634));
  // PTX:792 mul.f32 %f1575, %f635, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1575) : "f"(f635));
  // PTX:793 mul.f32 %f1576, %f636, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1576) : "f"(f636));
  // PTX:794 add.s32 %r418, %r418, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r418) : "r"(r418));
  // PTX:795 setp.lt.u32 %p71, %r418, 8
  p71 = (((unsigned)(r418)) < ((unsigned)(8)));
  // PTX:796 @%p71 bra $L__BB2_63
  if (p71) { goto L_BB2_63; }
  // PTX:798 $L__BB2_66:
L_BB2_66:;
  // PTX:799 mul.f32 %f637, %f1569, %f1569
  asm("mul.f32 %0, %1, %2;" : "=f"(f637) : "f"(f1569), "f"(f1569));
  // PTX:800 fma.rn.f32 %f638, %f1568, %f1568, %f637
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f638) : "f"(f1568), "f"(f1568), "f"(f637));
  // PTX:801 fma.rn.f32 %f639, %f1570, %f1570, %f638
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f639) : "f"(f1570), "f"(f1570), "f"(f638));
  // PTX:802 sqrt.rn.f32 %f82, %f639
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f82) : "f"(f639));
  // PTX:803 setp.leu.f32 %p72, %f82, 0f00000000
  p72 = ((isnan(((float)(f82))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f82)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:804 mov.u32 %r431, 0
  asm("mov.u32 %0, 0;" : "=r"(r431) : );
  // PTX:805 mov.u32 %r419, %r431
  asm("mov.u32 %0, %1;" : "=r"(r419) : "r"(r431));
  // PTX:806 mov.u32 %r420, %r431
  asm("mov.u32 %0, %1;" : "=r"(r420) : "r"(r431));
  // PTX:807 mov.u32 %r421, %r431
  asm("mov.u32 %0, %1;" : "=r"(r421) : "r"(r431));
  // PTX:808 @%p72 bra $L__BB2_68
  if (p72) { goto L_BB2_68; }
  // PTX:810 div.rn.f32 %f640, %f1568, %f82
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f640) : "f"(f1568), "f"(f82));
  // PTX:811 div.rn.f32 %f641, %f1569, %f82
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f641) : "f"(f1569), "f"(f82));
  // PTX:812 div.rn.f32 %f642, %f1570, %f82
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f642) : "f"(f1570), "f"(f82));
  // PTX:813 mov.b32 %r421, %f642
  asm("mov.b32 %0, %1;" : "=r"(r421) : "f"(f642));
  // PTX:814 mov.b32 %r420, %f641
  asm("mov.b32 %0, %1;" : "=r"(r420) : "f"(f641));
  // PTX:815 mov.b32 %r419, %f640
  asm("mov.b32 %0, %1;" : "=r"(r419) : "f"(f640));
  // PTX:817 $L__BB2_68:
L_BB2_68:;
  // PTX:818 mov.b32 %f83, %r419
  asm("mov.b32 %0, %1;" : "=f"(f83) : "r"(r419));
  // PTX:819 mov.b32 %f84, %r420
  asm("mov.b32 %0, %1;" : "=f"(f84) : "r"(r420));
  // PTX:820 mul.f32 %f643, %f1572, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f643) : "f"(f1572), "f"(f84));
  // PTX:821 mov.b32 %f85, %r421
  asm("mov.b32 %0, %1;" : "=f"(f85) : "r"(r421));
  // PTX:822 fma.rn.f32 %f644, %f1571, %f83, %f643
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f644) : "f"(f1571), "f"(f83), "f"(f643));
  // PTX:823 fma.rn.f32 %f645, %f1573, %f85, %f644
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f645) : "f"(f1573), "f"(f85), "f"(f644));
  // PTX:824 mul.f32 %f646, %f645, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f646) : "f"(f645), "f"(f83));
  // PTX:825 mul.f32 %f647, %f645, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f647) : "f"(f645), "f"(f84));
  // PTX:826 mul.f32 %f648, %f645, %f85
  asm("mul.f32 %0, %1, %2;" : "=f"(f648) : "f"(f645), "f"(f85));
  // PTX:827 sub.f32 %f86, %f1571, %f646
  asm("sub.f32 %0, %1, %2;" : "=f"(f86) : "f"(f1571), "f"(f646));
  // PTX:828 sub.f32 %f87, %f1572, %f647
  asm("sub.f32 %0, %1, %2;" : "=f"(f87) : "f"(f1572), "f"(f647));
  // PTX:829 sub.f32 %f88, %f1573, %f648
  asm("sub.f32 %0, %1, %2;" : "=f"(f88) : "f"(f1573), "f"(f648));
  // PTX:830 mul.f32 %f649, %f87, %f87
  asm("mul.f32 %0, %1, %2;" : "=f"(f649) : "f"(f87), "f"(f87));
  // PTX:831 fma.rn.f32 %f650, %f86, %f86, %f649
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f650) : "f"(f86), "f"(f86), "f"(f649));
  // PTX:832 fma.rn.f32 %f651, %f88, %f88, %f650
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f651) : "f"(f88), "f"(f88), "f"(f650));
  // PTX:833 sqrt.rn.f32 %f89, %f651
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f89) : "f"(f651));
  // PTX:834 setp.leu.f32 %p73, %f89, 0f00000000
  p73 = ((isnan(((float)(f89))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f89)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:835 mov.u32 %r432, %r431
  asm("mov.u32 %0, %1;" : "=r"(r432) : "r"(r431));
  // PTX:836 mov.u32 %r433, %r431
  asm("mov.u32 %0, %1;" : "=r"(r433) : "r"(r431));
  // PTX:837 @%p73 bra $L__BB2_70
  if (p73) { goto L_BB2_70; }
  // PTX:839 div.rn.f32 %f652, %f86, %f89
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f652) : "f"(f86), "f"(f89));
  // PTX:840 div.rn.f32 %f653, %f87, %f89
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f653) : "f"(f87), "f"(f89));
  // PTX:841 div.rn.f32 %f654, %f88, %f89
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f654) : "f"(f88), "f"(f89));
  // PTX:842 mov.b32 %r433, %f654
  asm("mov.b32 %0, %1;" : "=r"(r433) : "f"(f654));
  // PTX:843 mov.b32 %r432, %f653
  asm("mov.b32 %0, %1;" : "=r"(r432) : "f"(f653));
  // PTX:844 mov.b32 %r431, %f652
  asm("mov.b32 %0, %1;" : "=r"(r431) : "f"(f652));
  // PTX:846 $L__BB2_70:
L_BB2_70:;
  // PTX:847 mov.u32 %r434, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r434) : );
  // PTX:848 mul.f32 %f655, %f84, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f655) : "f"(f84), "f"(f84));
  // PTX:849 fma.rn.f32 %f656, %f83, %f83, %f655
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f656) : "f"(f83), "f"(f83), "f"(f655));
  // PTX:850 fma.rn.f32 %f657, %f85, %f85, %f656
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f657) : "f"(f85), "f"(f85), "f"(f656));
  // PTX:851 sqrt.rn.f32 %f658, %f657
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f658) : "f"(f657));
  // PTX:852 setp.le.f32 %p74, %f658, 0f322BCC77
  p74 = (!(isnan(((float)(f658))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f658)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:853 mov.u32 %r435, 0
  asm("mov.u32 %0, 0;" : "=r"(r435) : );
  // PTX:854 mov.u32 %r436, %r435
  asm("mov.u32 %0, %1;" : "=r"(r436) : "r"(r435));
  // PTX:855 mov.u32 %r437, %r435
  asm("mov.u32 %0, %1;" : "=r"(r437) : "r"(r435));
  // PTX:856 mov.u32 %r438, %r434
  asm("mov.u32 %0, %1;" : "=r"(r438) : "r"(r434));
  // PTX:857 mov.u32 %r439, %r435
  asm("mov.u32 %0, %1;" : "=r"(r439) : "r"(r435));
  // PTX:858 mov.u32 %r440, %r435
  asm("mov.u32 %0, %1;" : "=r"(r440) : "r"(r435));
  // PTX:859 mov.u32 %r441, %r435
  asm("mov.u32 %0, %1;" : "=r"(r441) : "r"(r435));
  // PTX:860 mov.u32 %r442, %r434
  asm("mov.u32 %0, %1;" : "=r"(r442) : "r"(r434));
  // PTX:861 @%p74 bra $L__BB2_77
  if (p74) { goto L_BB2_77; }
  // PTX:863 mov.u32 %r434, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r434) : );
  // PTX:864 mov.b32 %f90, %r431
  asm("mov.b32 %0, %1;" : "=f"(f90) : "r"(r431));
  // PTX:865 mov.b32 %f91, %r432
  asm("mov.b32 %0, %1;" : "=f"(f91) : "r"(r432));
  // PTX:866 mul.f32 %f659, %f91, %f91
  asm("mul.f32 %0, %1, %2;" : "=f"(f659) : "f"(f91), "f"(f91));
  // PTX:867 mov.b32 %f92, %r433
  asm("mov.b32 %0, %1;" : "=f"(f92) : "r"(r433));
  // PTX:868 fma.rn.f32 %f660, %f90, %f90, %f659
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f660) : "f"(f90), "f"(f90), "f"(f659));
  // PTX:869 fma.rn.f32 %f661, %f92, %f92, %f660
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f661) : "f"(f92), "f"(f92), "f"(f660));
  // PTX:870 sqrt.rn.f32 %f662, %f661
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f662) : "f"(f661));
  // PTX:871 setp.le.f32 %p75, %f662, 0f322BCC77
  p75 = (!(isnan(((float)(f662))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f662)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:872 @%p75 bra $L__BB2_77
  if (p75) { goto L_BB2_77; }
  // PTX:874 mul.f32 %f663, %f84, %f92
  asm("mul.f32 %0, %1, %2;" : "=f"(f663) : "f"(f84), "f"(f92));
  // PTX:875 mul.f32 %f664, %f85, %f91
  asm("mul.f32 %0, %1, %2;" : "=f"(f664) : "f"(f85), "f"(f91));
  // PTX:876 sub.f32 %f93, %f663, %f664
  asm("sub.f32 %0, %1, %2;" : "=f"(f93) : "f"(f663), "f"(f664));
  // PTX:877 mul.f32 %f665, %f83, %f92
  asm("mul.f32 %0, %1, %2;" : "=f"(f665) : "f"(f83), "f"(f92));
  // PTX:878 mul.f32 %f666, %f85, %f90
  asm("mul.f32 %0, %1, %2;" : "=f"(f666) : "f"(f85), "f"(f90));
  // PTX:879 sub.f32 %f94, %f666, %f665
  asm("sub.f32 %0, %1, %2;" : "=f"(f94) : "f"(f666), "f"(f665));
  // PTX:880 mul.f32 %f667, %f84, %f90
  asm("mul.f32 %0, %1, %2;" : "=f"(f667) : "f"(f84), "f"(f90));
  // PTX:881 mul.f32 %f668, %f83, %f91
  asm("mul.f32 %0, %1, %2;" : "=f"(f668) : "f"(f83), "f"(f91));
  // PTX:882 sub.f32 %f95, %f668, %f667
  asm("sub.f32 %0, %1, %2;" : "=f"(f95) : "f"(f668), "f"(f667));
  // PTX:883 mul.f32 %f669, %f94, %f94
  asm("mul.f32 %0, %1, %2;" : "=f"(f669) : "f"(f94), "f"(f94));
  // PTX:884 fma.rn.f32 %f670, %f93, %f93, %f669
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f670) : "f"(f93), "f"(f93), "f"(f669));
  // PTX:885 fma.rn.f32 %f671, %f95, %f95, %f670
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f671) : "f"(f95), "f"(f95), "f"(f670));
  // PTX:886 sqrt.rn.f32 %f96, %f671
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f96) : "f"(f671));
  // PTX:887 setp.leu.f32 %p76, %f96, 0f00000000
  p76 = ((isnan(((float)(f96))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f96)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:888 mov.u32 %r440, 0
  asm("mov.u32 %0, 0;" : "=r"(r440) : );
  // PTX:889 mov.u32 %r441, %r440
  asm("mov.u32 %0, %1;" : "=r"(r441) : "r"(r440));
  // PTX:890 mov.u32 %r442, %r440
  asm("mov.u32 %0, %1;" : "=r"(r442) : "r"(r440));
  // PTX:891 @%p76 bra $L__BB2_74
  if (p76) { goto L_BB2_74; }
  // PTX:893 div.rn.f32 %f672, %f93, %f96
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f672) : "f"(f93), "f"(f96));
  // PTX:894 div.rn.f32 %f673, %f94, %f96
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f673) : "f"(f94), "f"(f96));
  // PTX:895 div.rn.f32 %f674, %f95, %f96
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f674) : "f"(f95), "f"(f96));
  // PTX:896 mov.b32 %r442, %f674
  asm("mov.b32 %0, %1;" : "=r"(r442) : "f"(f674));
  // PTX:897 mov.b32 %r441, %f673
  asm("mov.b32 %0, %1;" : "=r"(r441) : "f"(f673));
  // PTX:898 mov.b32 %r440, %f672
  asm("mov.b32 %0, %1;" : "=r"(r440) : "f"(f672));
  // PTX:900 $L__BB2_74:
L_BB2_74:;
  // PTX:901 mov.b32 %f97, %r440
  asm("mov.b32 %0, %1;" : "=f"(f97) : "r"(r440));
  // PTX:902 mov.b32 %f98, %r441
  asm("mov.b32 %0, %1;" : "=f"(f98) : "r"(r441));
  // PTX:903 mul.f32 %f675, %f1575, %f98
  asm("mul.f32 %0, %1, %2;" : "=f"(f675) : "f"(f1575), "f"(f98));
  // PTX:904 mov.b32 %f99, %r442
  asm("mov.b32 %0, %1;" : "=f"(f99) : "r"(r442));
  // PTX:905 fma.rn.f32 %f676, %f1574, %f97, %f675
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f676) : "f"(f1574), "f"(f97), "f"(f675));
  // PTX:906 fma.rn.f32 %f677, %f1576, %f99, %f676
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f677) : "f"(f1576), "f"(f99), "f"(f676));
  // PTX:907 setp.geu.f32 %p77, %f677, 0f00000000
  p77 = ((isnan(((float)(f677))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f677)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:908 @%p77 bra $L__BB2_76
  if (p77) { goto L_BB2_76; }
  // PTX:910 neg.f32 %f678, %f90
  asm("neg.f32 %0, %1;" : "=f"(f678) : "f"(f90));
  // PTX:911 mov.b32 %r431, %f678
  asm("mov.b32 %0, %1;" : "=r"(r431) : "f"(f678));
  // PTX:912 neg.f32 %f679, %f91
  asm("neg.f32 %0, %1;" : "=f"(f679) : "f"(f91));
  // PTX:913 mov.b32 %r432, %f679
  asm("mov.b32 %0, %1;" : "=r"(r432) : "f"(f679));
  // PTX:914 neg.f32 %f680, %f92
  asm("neg.f32 %0, %1;" : "=f"(f680) : "f"(f92));
  // PTX:915 mov.b32 %r433, %f680
  asm("mov.b32 %0, %1;" : "=r"(r433) : "f"(f680));
  // PTX:916 neg.f32 %f681, %f97
  asm("neg.f32 %0, %1;" : "=f"(f681) : "f"(f97));
  // PTX:917 mov.b32 %r440, %f681
  asm("mov.b32 %0, %1;" : "=r"(r440) : "f"(f681));
  // PTX:918 neg.f32 %f682, %f98
  asm("neg.f32 %0, %1;" : "=f"(f682) : "f"(f98));
  // PTX:919 mov.b32 %r441, %f682
  asm("mov.b32 %0, %1;" : "=r"(r441) : "f"(f682));
  // PTX:920 neg.f32 %f683, %f99
  asm("neg.f32 %0, %1;" : "=f"(f683) : "f"(f99));
  // PTX:921 mov.b32 %r442, %f683
  asm("mov.b32 %0, %1;" : "=r"(r442) : "f"(f683));
  // PTX:923 $L__BB2_76:
L_BB2_76:;
  // PTX:924 mov.u32 %r434, %r419
  asm("mov.u32 %0, %1;" : "=r"(r434) : "r"(r419));
  // PTX:925 mov.u32 %r435, %r420
  asm("mov.u32 %0, %1;" : "=r"(r435) : "r"(r420));
  // PTX:926 mov.u32 %r436, %r421
  asm("mov.u32 %0, %1;" : "=r"(r436) : "r"(r421));
  // PTX:927 mov.u32 %r437, %r431
  asm("mov.u32 %0, %1;" : "=r"(r437) : "r"(r431));
  // PTX:928 mov.u32 %r438, %r432
  asm("mov.u32 %0, %1;" : "=r"(r438) : "r"(r432));
  // PTX:929 mov.u32 %r439, %r433
  asm("mov.u32 %0, %1;" : "=r"(r439) : "r"(r433));
  // PTX:931 $L__BB2_77:
L_BB2_77:;
  // PTX:932 mov.b32 %f684, %r434
  asm("mov.b32 %0, %1;" : "=f"(f684) : "r"(r434));
  // PTX:933 mov.b32 %f685, %r437
  asm("mov.b32 %0, %1;" : "=f"(f685) : "r"(r437));
  // PTX:934 mov.b32 %f686, %r440
  asm("mov.b32 %0, %1;" : "=f"(f686) : "r"(r440));
  // PTX:935 mov.b32 %f687, %r435
  asm("mov.b32 %0, %1;" : "=f"(f687) : "r"(r435));
  // PTX:936 mul.f32 %f688, %f13, %f687
  asm("mul.f32 %0, %1, %2;" : "=f"(f688) : "f"(f13), "f"(f687));
  // PTX:937 mov.b32 %f689, %r438
  asm("mov.b32 %0, %1;" : "=f"(f689) : "r"(r438));
  // PTX:938 mul.f32 %f690, %f13, %f689
  asm("mul.f32 %0, %1, %2;" : "=f"(f690) : "f"(f13), "f"(f689));
  // PTX:939 mov.b32 %f691, %r441
  asm("mov.b32 %0, %1;" : "=f"(f691) : "r"(r441));
  // PTX:940 mul.f32 %f692, %f13, %f691
  asm("mul.f32 %0, %1, %2;" : "=f"(f692) : "f"(f13), "f"(f691));
  // PTX:941 fma.rn.f32 %f693, %f12, %f684, %f688
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f693) : "f"(f12), "f"(f684), "f"(f688));
  // PTX:942 fma.rn.f32 %f694, %f12, %f685, %f690
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f694) : "f"(f12), "f"(f685), "f"(f690));
  // PTX:943 fma.rn.f32 %f695, %f12, %f686, %f692
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f695) : "f"(f12), "f"(f686), "f"(f692));
  // PTX:944 mov.b32 %f696, %r436
  asm("mov.b32 %0, %1;" : "=f"(f696) : "r"(r436));
  // PTX:945 mov.b32 %f697, %r439
  asm("mov.b32 %0, %1;" : "=f"(f697) : "r"(r439));
  // PTX:946 mov.b32 %f698, %r442
  asm("mov.b32 %0, %1;" : "=f"(f698) : "r"(r442));
  // PTX:947 fma.rn.f32 %f1577, %f14, %f696, %f693
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1577) : "f"(f14), "f"(f696), "f"(f693));
  // PTX:948 fma.rn.f32 %f1578, %f14, %f697, %f694
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1578) : "f"(f14), "f"(f697), "f"(f694));
  // PTX:949 fma.rn.f32 %f1579, %f14, %f698, %f695
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1579) : "f"(f14), "f"(f698), "f"(f695));
  // PTX:950 bra.uni $L__BB2_78
  goto L_BB2_78;
  // PTX:952 $L__BB2_79:
L_BB2_79:;
  // PTX:953 mov.b32 %f711, %r37
  asm("mov.b32 %0, %1;" : "=f"(f711) : "r"(r37));
  // PTX:954 add.f32 %f712, %f12, %f711
  asm("add.f32 %0, %1, %2;" : "=f"(f712) : "f"(f12), "f"(f711));
  // PTX:955 mov.b32 %f713, %r38
  asm("mov.b32 %0, %1;" : "=f"(f713) : "r"(r38));
  // PTX:956 add.f32 %f714, %f13, %f713
  asm("add.f32 %0, %1, %2;" : "=f"(f714) : "f"(f13), "f"(f713));
  // PTX:957 mov.b32 %f715, %r39
  asm("mov.b32 %0, %1;" : "=f"(f715) : "r"(r39));
  // PTX:958 add.f32 %f716, %f14, %f715
  asm("add.f32 %0, %1, %2;" : "=f"(f716) : "f"(f14), "f"(f715));
  // PTX:959 mov.b32 %r448, %f712
  asm("mov.b32 %0, %1;" : "=r"(r448) : "f"(f712));
  // PTX:960 mov.b32 %r447, %f714
  asm("mov.b32 %0, %1;" : "=r"(r447) : "f"(f714));
  // PTX:961 mov.b32 %r446, %f716
  asm("mov.b32 %0, %1;" : "=r"(r446) : "f"(f716));
  // PTX:962 bra.uni $L__BB2_80
  goto L_BB2_80;
  // PTX:964 $L__BB2_59:
L_BB2_59:;
  // PTX:965 rcp.rn.f32 %f512, %f27
  asm("rcp.rn.f32 %0, %1;" : "=f"(f512) : "f"(f27));
  // PTX:966 mul.f32 %f513, %f25, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f513) : "f"(f25), "f"(f15));
  // PTX:967 mul.f32 %f514, %f26, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f514) : "f"(f26), "f"(f17));
  // PTX:968 sub.f32 %f515, %f514, %f513
  asm("sub.f32 %0, %1, %2;" : "=f"(f515) : "f"(f514), "f"(f513));
  // PTX:969 mul.f32 %f516, %f26, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f516) : "f"(f26), "f"(f20));
  // PTX:970 mul.f32 %f517, %f24, %f15
  asm("mul.f32 %0, %1, %2;" : "=f"(f517) : "f"(f24), "f"(f15));
  // PTX:971 sub.f32 %f518, %f517, %f516
  asm("sub.f32 %0, %1, %2;" : "=f"(f518) : "f"(f517), "f"(f516));
  // PTX:972 mul.f32 %f519, %f24, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f519) : "f"(f24), "f"(f17));
  // PTX:973 mul.f32 %f520, %f25, %f20
  asm("mul.f32 %0, %1, %2;" : "=f"(f520) : "f"(f25), "f"(f20));
  // PTX:974 sub.f32 %f521, %f520, %f519
  asm("sub.f32 %0, %1, %2;" : "=f"(f521) : "f"(f520), "f"(f519));
  // PTX:975 mul.f32 %f522, %f26, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f522) : "f"(f26), "f"(f16));
  // PTX:976 mul.f32 %f523, %f25, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f523) : "f"(f25), "f"(f18));
  // PTX:977 sub.f32 %f524, %f523, %f522
  asm("sub.f32 %0, %1, %2;" : "=f"(f524) : "f"(f523), "f"(f522));
  // PTX:978 mul.f32 %f525, %f24, %f18
  asm("mul.f32 %0, %1, %2;" : "=f"(f525) : "f"(f24), "f"(f18));
  // PTX:979 mul.f32 %f526, %f26, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f526) : "f"(f26), "f"(f21));
  // PTX:980 sub.f32 %f527, %f526, %f525
  asm("sub.f32 %0, %1, %2;" : "=f"(f527) : "f"(f526), "f"(f525));
  // PTX:981 mul.f32 %f528, %f25, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f528) : "f"(f25), "f"(f21));
  // PTX:982 mul.f32 %f529, %f24, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f529) : "f"(f24), "f"(f16));
  // PTX:983 sub.f32 %f530, %f529, %f528
  asm("sub.f32 %0, %1, %2;" : "=f"(f530) : "f"(f529), "f"(f528));
  // PTX:984 mul.f32 %f531, %f19, %f512
  asm("mul.f32 %0, %1, %2;" : "=f"(f531) : "f"(f19), "f"(f512));
  // PTX:985 mul.f32 %f532, %f22, %f512
  asm("mul.f32 %0, %1, %2;" : "=f"(f532) : "f"(f22), "f"(f512));
  // PTX:986 mul.f32 %f533, %f23, %f512
  asm("mul.f32 %0, %1, %2;" : "=f"(f533) : "f"(f23), "f"(f512));
  // PTX:987 mul.f32 %f534, %f515, %f512
  asm("mul.f32 %0, %1, %2;" : "=f"(f534) : "f"(f515), "f"(f512));
  // PTX:988 mul.f32 %f535, %f518, %f512
  asm("mul.f32 %0, %1, %2;" : "=f"(f535) : "f"(f518), "f"(f512));
  // PTX:989 mul.f32 %f536, %f521, %f512
  asm("mul.f32 %0, %1, %2;" : "=f"(f536) : "f"(f521), "f"(f512));
  // PTX:990 mul.f32 %f537, %f524, %f512
  asm("mul.f32 %0, %1, %2;" : "=f"(f537) : "f"(f524), "f"(f512));
  // PTX:991 mul.f32 %f538, %f527, %f512
  asm("mul.f32 %0, %1, %2;" : "=f"(f538) : "f"(f527), "f"(f512));
  // PTX:992 mul.f32 %f539, %f530, %f512
  asm("mul.f32 %0, %1, %2;" : "=f"(f539) : "f"(f530), "f"(f512));
  // PTX:993 mul.f32 %f540, %f13, %f532
  asm("mul.f32 %0, %1, %2;" : "=f"(f540) : "f"(f13), "f"(f532));
  // PTX:994 mul.f32 %f541, %f13, %f535
  asm("mul.f32 %0, %1, %2;" : "=f"(f541) : "f"(f13), "f"(f535));
  // PTX:995 mul.f32 %f542, %f13, %f538
  asm("mul.f32 %0, %1, %2;" : "=f"(f542) : "f"(f13), "f"(f538));
  // PTX:996 fma.rn.f32 %f543, %f12, %f531, %f540
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f543) : "f"(f12), "f"(f531), "f"(f540));
  // PTX:997 fma.rn.f32 %f544, %f12, %f534, %f541
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f544) : "f"(f12), "f"(f534), "f"(f541));
  // PTX:998 fma.rn.f32 %f545, %f12, %f537, %f542
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f545) : "f"(f12), "f"(f537), "f"(f542));
  // PTX:999 fma.rn.f32 %f1577, %f14, %f533, %f543
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1577) : "f"(f14), "f"(f533), "f"(f543));
  // PTX:1000 fma.rn.f32 %f1578, %f14, %f536, %f544
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1578) : "f"(f14), "f"(f536), "f"(f544));
  // PTX:1001 fma.rn.f32 %f1579, %f14, %f539, %f545
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1579) : "f"(f14), "f"(f539), "f"(f545));
  // PTX:1003 $L__BB2_78:
L_BB2_78:;
  // PTX:1004 mov.b32 %f703, %r37
  asm("mov.b32 %0, %1;" : "=f"(f703) : "r"(r37));
  // PTX:1005 add.f32 %f704, %f703, %f1577
  asm("add.f32 %0, %1, %2;" : "=f"(f704) : "f"(f703), "f"(f1577));
  // PTX:1006 mov.b32 %f706, %r38
  asm("mov.b32 %0, %1;" : "=f"(f706) : "r"(r38));
  // PTX:1007 add.f32 %f707, %f706, %f1578
  asm("add.f32 %0, %1, %2;" : "=f"(f707) : "f"(f706), "f"(f1578));
  // PTX:1008 mov.b32 %f709, %r39
  asm("mov.b32 %0, %1;" : "=f"(f709) : "r"(r39));
  // PTX:1009 add.f32 %f710, %f709, %f1579
  asm("add.f32 %0, %1, %2;" : "=f"(f710) : "f"(f709), "f"(f1579));
  // PTX:1010 mov.b32 %r448, %f704
  asm("mov.b32 %0, %1;" : "=r"(r448) : "f"(f704));
  // PTX:1011 mov.b32 %r447, %f707
  asm("mov.b32 %0, %1;" : "=r"(r447) : "f"(f707));
  // PTX:1012 mov.b32 %r446, %f710
  asm("mov.b32 %0, %1;" : "=r"(r446) : "f"(f710));
  // PTX:1014 $L__BB2_80:
L_BB2_80:;
  // PTX:1015 setp.ne.s32 %p165, %r36, 3
  p165 = (((int)(r36)) != ((int)(3)));
  // PTX:1016 mov.u32 %r477, %r42
  asm("mov.u32 %0, %1;" : "=r"(r477) : "r"(r42));
  // PTX:1017 mov.u32 %r478, %r41
  asm("mov.u32 %0, %1;" : "=r"(r478) : "r"(r41));
  // PTX:1018 mov.u32 %r479, %r40
  asm("mov.u32 %0, %1;" : "=r"(r479) : "r"(r40));
  // PTX:1019 @%p165 bra $L__BB2_104
  if (p165) { goto L_BB2_104; }
  // PTX:1021 cvt.s64.s32 %rd421, %rd494
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd421) : "l"(rd494));
  // PTX:1022 ld.param.u64 %rd420, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_14]
  rd420 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:1023 cvta.to.global.u64 %rd419, %rd420
  rd419 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd420));
  // PTX:1024 mul.lo.s64 %rd196, %rd421, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd196) : "l"(rd421));
  // PTX:1025 add.s64 %rd197, %rd419, %rd196
  asm("add.s64 %0, %1, %2;" : "=l"(rd197) : "l"(rd419), "l"(rd196));
  // PTX:1026 ld.global.f32 %f100, [%rd197]
  f100 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd197) + (0)))));
  // PTX:1027 mul.f32 %f101, %f100, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f101) : "f"(f100), "f"(f9));
  // PTX:1028 @%p29 bra $L__BB2_103
  if (p29) { goto L_BB2_103; }
  // PTX:1030 neg.f32 %f102, %f101
  asm("neg.f32 %0, %1;" : "=f"(f102) : "f"(f101));
  // PTX:1031 mul.f32 %f717, %f100, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f717) : "f"(f100), "f"(f10));
  // PTX:1032 neg.f32 %f103, %f717
  asm("neg.f32 %0, %1;" : "=f"(f103) : "f"(f717));
  // PTX:1033 mul.f32 %f718, %f100, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f718) : "f"(f100), "f"(f11));
  // PTX:1034 neg.f32 %f104, %f718
  asm("neg.f32 %0, %1;" : "=f"(f104) : "f"(f718));
  // PTX:1035 mul.wide.s32 %rd198, %r400, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd198) : "r"(r400));
  // PTX:1036 add.s64 %rd199, %rd6, %rd198
  asm("add.s64 %0, %1, %2;" : "=l"(rd199) : "l"(rd6), "l"(rd198));
  // PTX:1037 mul.wide.s32 %rd200, %r401, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd200) : "r"(r401));
  // PTX:1038 add.s64 %rd201, %rd6, %rd200
  asm("add.s64 %0, %1, %2;" : "=l"(rd201) : "l"(rd6), "l"(rd200));
  // PTX:1039 mul.wide.s32 %rd202, %r402, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd202) : "r"(r402));
  // PTX:1040 add.s64 %rd203, %rd6, %rd202
  asm("add.s64 %0, %1, %2;" : "=l"(rd203) : "l"(rd6), "l"(rd202));
  // PTX:1041 ld.global.f32 %f105, [%rd203+8]
  f105 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd203) + (8)))));
  // PTX:1042 ld.global.f32 %f106, [%rd201+4]
  f106 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (4)))));
  // PTX:1043 mul.f32 %f719, %f106, %f105
  asm("mul.f32 %0, %1, %2;" : "=f"(f719) : "f"(f106), "f"(f105));
  // PTX:1044 ld.global.f32 %f107, [%rd203+4]
  f107 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd203) + (4)))));
  // PTX:1045 ld.global.f32 %f108, [%rd201+8]
  f108 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (8)))));
  // PTX:1046 mul.f32 %f720, %f108, %f107
  asm("mul.f32 %0, %1, %2;" : "=f"(f720) : "f"(f108), "f"(f107));
  // PTX:1047 sub.f32 %f109, %f719, %f720
  asm("sub.f32 %0, %1, %2;" : "=f"(f109) : "f"(f719), "f"(f720));
  // PTX:1048 ld.global.f32 %f110, [%rd203]
  f110 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd203) + (0)))));
  // PTX:1049 mul.f32 %f721, %f108, %f110
  asm("mul.f32 %0, %1, %2;" : "=f"(f721) : "f"(f108), "f"(f110));
  // PTX:1050 ld.global.f32 %f111, [%rd201]
  f111 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd201) + (0)))));
  // PTX:1051 mul.f32 %f722, %f111, %f105
  asm("mul.f32 %0, %1, %2;" : "=f"(f722) : "f"(f111), "f"(f105));
  // PTX:1052 sub.f32 %f112, %f721, %f722
  asm("sub.f32 %0, %1, %2;" : "=f"(f112) : "f"(f721), "f"(f722));
  // PTX:1053 mul.f32 %f723, %f111, %f107
  asm("mul.f32 %0, %1, %2;" : "=f"(f723) : "f"(f111), "f"(f107));
  // PTX:1054 mul.f32 %f724, %f106, %f110
  asm("mul.f32 %0, %1, %2;" : "=f"(f724) : "f"(f106), "f"(f110));
  // PTX:1055 sub.f32 %f113, %f723, %f724
  asm("sub.f32 %0, %1, %2;" : "=f"(f113) : "f"(f723), "f"(f724));
  // PTX:1056 ld.global.f32 %f114, [%rd199]
  f114 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (0)))));
  // PTX:1057 ld.global.f32 %f115, [%rd199+4]
  f115 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (4)))));
  // PTX:1058 mul.f32 %f725, %f115, %f112
  asm("mul.f32 %0, %1, %2;" : "=f"(f725) : "f"(f115), "f"(f112));
  // PTX:1059 ld.global.f32 %f116, [%rd199+8]
  f116 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd199) + (8)))));
  // PTX:1060 fma.rn.f32 %f726, %f114, %f109, %f725
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f726) : "f"(f114), "f"(f109), "f"(f725));
  // PTX:1061 fma.rn.f32 %f117, %f116, %f113, %f726
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f117) : "f"(f116), "f"(f113), "f"(f726));
  // PTX:1062 abs.f32 %f727, %f117
  asm("abs.f32 %0, %1;" : "=f"(f727) : "f"(f117));
  // PTX:1063 setp.leu.f32 %p80, %f727, 0f2EDBE6FF
  p80 = ((isnan(((float)(f727))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) || (((float)(f727)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:1064 setp.geu.f32 %p81, %f727, 0f7F800000
  p81 = ((isnan(((float)(f727))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f727)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1065 or.pred %p82, %p80, %p81
  p82 = ((p80) || (p81));
  // PTX:1066 @%p82 bra $L__BB2_84
  if (p82) { goto L_BB2_84; }
  // PTX:1067 bra.uni $L__BB2_83
  goto L_BB2_83;
  // PTX:1069 $L__BB2_84:
L_BB2_84:;
  // PTX:1070 mul.f32 %f765, %f115, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f765) : "f"(f115), "f"(f115));
  // PTX:1071 fma.rn.f32 %f766, %f114, %f114, %f765
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f766) : "f"(f114), "f"(f114), "f"(f765));
  // PTX:1072 fma.rn.f32 %f767, %f116, %f116, %f766
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f767) : "f"(f116), "f"(f116), "f"(f766));
  // PTX:1073 mul.f32 %f768, %f106, %f106
  asm("mul.f32 %0, %1, %2;" : "=f"(f768) : "f"(f106), "f"(f106));
  // PTX:1074 fma.rn.f32 %f769, %f111, %f111, %f768
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f769) : "f"(f111), "f"(f111), "f"(f768));
  // PTX:1075 fma.rn.f32 %f770, %f108, %f108, %f769
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f770) : "f"(f108), "f"(f108), "f"(f769));
  // PTX:1076 add.f32 %f771, %f767, %f770
  asm("add.f32 %0, %1, %2;" : "=f"(f771) : "f"(f767), "f"(f770));
  // PTX:1077 mul.f32 %f772, %f107, %f107
  asm("mul.f32 %0, %1, %2;" : "=f"(f772) : "f"(f107), "f"(f107));
  // PTX:1078 fma.rn.f32 %f773, %f110, %f110, %f772
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f773) : "f"(f110), "f"(f110), "f"(f772));
  // PTX:1079 fma.rn.f32 %f774, %f105, %f105, %f773
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f774) : "f"(f105), "f"(f105), "f"(f773));
  // PTX:1080 add.f32 %f775, %f771, %f774
  asm("add.f32 %0, %1, %2;" : "=f"(f775) : "f"(f771), "f"(f774));
  // PTX:1081 div.rn.f32 %f776, %f775, 0f40400000
  asm("div.rn.f32 %0, %1, 0f40400000;" : "=f"(f776) : "f"(f775));
  // PTX:1082 sqrt.rn.f32 %f118, %f776
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f118) : "f"(f776));
  // PTX:1083 setp.leu.f32 %p83, %f118, 0f322BCC77
  p83 = ((isnan(((float)(f118))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f118)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1084 mov.u32 %r465, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r465) : );
  // PTX:1085 mov.u32 %r466, 0
  asm("mov.u32 %0, 0;" : "=r"(r466) : );
  // PTX:1086 mov.u32 %r467, %r466
  asm("mov.u32 %0, %1;" : "=r"(r467) : "r"(r466));
  // PTX:1087 mov.u32 %r468, %r466
  asm("mov.u32 %0, %1;" : "=r"(r468) : "r"(r466));
  // PTX:1088 mov.u32 %r469, %r465
  asm("mov.u32 %0, %1;" : "=r"(r469) : "r"(r465));
  // PTX:1089 mov.u32 %r470, %r466
  asm("mov.u32 %0, %1;" : "=r"(r470) : "r"(r466));
  // PTX:1090 mov.u32 %r471, %r466
  asm("mov.u32 %0, %1;" : "=r"(r471) : "r"(r466));
  // PTX:1091 mov.u32 %r472, %r466
  asm("mov.u32 %0, %1;" : "=r"(r472) : "r"(r466));
  // PTX:1092 mov.u32 %r473, %r465
  asm("mov.u32 %0, %1;" : "=r"(r473) : "r"(r465));
  // PTX:1093 @%p83 bra $L__BB2_101
  if (p83) { goto L_BB2_101; }
  // PTX:1095 abs.f32 %f777, %f118
  asm("abs.f32 %0, %1;" : "=f"(f777) : "f"(f118));
  // PTX:1096 setp.geu.f32 %p84, %f777, 0f7F800000
  p84 = ((isnan(((float)(f777))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f777)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1097 @%p84 bra $L__BB2_101
  if (p84) { goto L_BB2_101; }
  // PTX:1099 rcp.rn.f32 %f778, %f118
  asm("rcp.rn.f32 %0, %1;" : "=f"(f778) : "f"(f118));
  // PTX:1100 mul.f32 %f1589, %f114, %f778
  asm("mul.f32 %0, %1, %2;" : "=f"(f1589) : "f"(f114), "f"(f778));
  // PTX:1101 mul.f32 %f1590, %f115, %f778
  asm("mul.f32 %0, %1, %2;" : "=f"(f1590) : "f"(f115), "f"(f778));
  // PTX:1102 mul.f32 %f1591, %f116, %f778
  asm("mul.f32 %0, %1, %2;" : "=f"(f1591) : "f"(f116), "f"(f778));
  // PTX:1103 mul.f32 %f1592, %f111, %f778
  asm("mul.f32 %0, %1, %2;" : "=f"(f1592) : "f"(f111), "f"(f778));
  // PTX:1104 mul.f32 %f1593, %f106, %f778
  asm("mul.f32 %0, %1, %2;" : "=f"(f1593) : "f"(f106), "f"(f778));
  // PTX:1105 mul.f32 %f1594, %f108, %f778
  asm("mul.f32 %0, %1, %2;" : "=f"(f1594) : "f"(f108), "f"(f778));
  // PTX:1106 mul.f32 %f1595, %f110, %f778
  asm("mul.f32 %0, %1, %2;" : "=f"(f1595) : "f"(f110), "f"(f778));
  // PTX:1107 mul.f32 %f1596, %f107, %f778
  asm("mul.f32 %0, %1, %2;" : "=f"(f1596) : "f"(f107), "f"(f778));
  // PTX:1108 mul.f32 %f1597, %f105, %f778
  asm("mul.f32 %0, %1, %2;" : "=f"(f1597) : "f"(f105), "f"(f778));
  // PTX:1109 mov.u32 %r449, 0
  asm("mov.u32 %0, 0;" : "=r"(r449) : );
  // PTX:1111 $L__BB2_87:
L_BB2_87:;
  // PTX:1112 mul.f32 %f779, %f1594, %f1596
  asm("mul.f32 %0, %1, %2;" : "=f"(f779) : "f"(f1594), "f"(f1596));
  // PTX:1113 mul.f32 %f780, %f1593, %f1597
  asm("mul.f32 %0, %1, %2;" : "=f"(f780) : "f"(f1593), "f"(f1597));
  // PTX:1114 sub.f32 %f137, %f780, %f779
  asm("sub.f32 %0, %1, %2;" : "=f"(f137) : "f"(f780), "f"(f779));
  // PTX:1115 mul.f32 %f781, %f1592, %f1597
  asm("mul.f32 %0, %1, %2;" : "=f"(f781) : "f"(f1592), "f"(f1597));
  // PTX:1116 mul.f32 %f782, %f1594, %f1595
  asm("mul.f32 %0, %1, %2;" : "=f"(f782) : "f"(f1594), "f"(f1595));
  // PTX:1117 sub.f32 %f138, %f782, %f781
  asm("sub.f32 %0, %1, %2;" : "=f"(f138) : "f"(f782), "f"(f781));
  // PTX:1118 mul.f32 %f783, %f1593, %f1595
  asm("mul.f32 %0, %1, %2;" : "=f"(f783) : "f"(f1593), "f"(f1595));
  // PTX:1119 mul.f32 %f784, %f1592, %f1596
  asm("mul.f32 %0, %1, %2;" : "=f"(f784) : "f"(f1592), "f"(f1596));
  // PTX:1120 sub.f32 %f139, %f784, %f783
  asm("sub.f32 %0, %1, %2;" : "=f"(f139) : "f"(f784), "f"(f783));
  // PTX:1121 mul.f32 %f785, %f1590, %f138
  asm("mul.f32 %0, %1, %2;" : "=f"(f785) : "f"(f1590), "f"(f138));
  // PTX:1122 fma.rn.f32 %f786, %f1589, %f137, %f785
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f786) : "f"(f1589), "f"(f137), "f"(f785));
  // PTX:1123 fma.rn.f32 %f140, %f1591, %f139, %f786
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f140) : "f"(f1591), "f"(f139), "f"(f786));
  // PTX:1124 abs.f32 %f787, %f140
  asm("abs.f32 %0, %1;" : "=f"(f787) : "f"(f140));
  // PTX:1125 setp.le.f32 %p85, %f787, 0f2EDBE6FF
  p85 = (!(isnan(((float)(f787))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f787)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:1126 setp.geu.f32 %p86, %f787, 0f7F800000
  p86 = ((isnan(((float)(f787))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f787)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1127 or.pred %p87, %p85, %p86
  p87 = ((p85) || (p86));
  // PTX:1128 @%p87 bra $L__BB2_90
  if (p87) { goto L_BB2_90; }
  // PTX:1130 rcp.rn.f32 %f788, %f140
  asm("rcp.rn.f32 %0, %1;" : "=f"(f788) : "f"(f140));
  // PTX:1131 mul.f32 %f789, %f1590, %f1597
  asm("mul.f32 %0, %1, %2;" : "=f"(f789) : "f"(f1590), "f"(f1597));
  // PTX:1132 mul.f32 %f790, %f1591, %f1596
  asm("mul.f32 %0, %1, %2;" : "=f"(f790) : "f"(f1591), "f"(f1596));
  // PTX:1133 sub.f32 %f791, %f790, %f789
  asm("sub.f32 %0, %1, %2;" : "=f"(f791) : "f"(f790), "f"(f789));
  // PTX:1134 mul.f32 %f792, %f1591, %f1595
  asm("mul.f32 %0, %1, %2;" : "=f"(f792) : "f"(f1591), "f"(f1595));
  // PTX:1135 mul.f32 %f793, %f1589, %f1597
  asm("mul.f32 %0, %1, %2;" : "=f"(f793) : "f"(f1589), "f"(f1597));
  // PTX:1136 sub.f32 %f794, %f793, %f792
  asm("sub.f32 %0, %1, %2;" : "=f"(f794) : "f"(f793), "f"(f792));
  // PTX:1137 mul.f32 %f795, %f1589, %f1596
  asm("mul.f32 %0, %1, %2;" : "=f"(f795) : "f"(f1589), "f"(f1596));
  // PTX:1138 mul.f32 %f796, %f1590, %f1595
  asm("mul.f32 %0, %1, %2;" : "=f"(f796) : "f"(f1590), "f"(f1595));
  // PTX:1139 sub.f32 %f797, %f796, %f795
  asm("sub.f32 %0, %1, %2;" : "=f"(f797) : "f"(f796), "f"(f795));
  // PTX:1140 mul.f32 %f798, %f1591, %f1593
  asm("mul.f32 %0, %1, %2;" : "=f"(f798) : "f"(f1591), "f"(f1593));
  // PTX:1141 mul.f32 %f799, %f1590, %f1594
  asm("mul.f32 %0, %1, %2;" : "=f"(f799) : "f"(f1590), "f"(f1594));
  // PTX:1142 sub.f32 %f800, %f799, %f798
  asm("sub.f32 %0, %1, %2;" : "=f"(f800) : "f"(f799), "f"(f798));
  // PTX:1143 mul.f32 %f801, %f1589, %f1594
  asm("mul.f32 %0, %1, %2;" : "=f"(f801) : "f"(f1589), "f"(f1594));
  // PTX:1144 mul.f32 %f802, %f1591, %f1592
  asm("mul.f32 %0, %1, %2;" : "=f"(f802) : "f"(f1591), "f"(f1592));
  // PTX:1145 sub.f32 %f803, %f802, %f801
  asm("sub.f32 %0, %1, %2;" : "=f"(f803) : "f"(f802), "f"(f801));
  // PTX:1146 mul.f32 %f804, %f1590, %f1592
  asm("mul.f32 %0, %1, %2;" : "=f"(f804) : "f"(f1590), "f"(f1592));
  // PTX:1147 mul.f32 %f805, %f1589, %f1593
  asm("mul.f32 %0, %1, %2;" : "=f"(f805) : "f"(f1589), "f"(f1593));
  // PTX:1148 sub.f32 %f806, %f805, %f804
  asm("sub.f32 %0, %1, %2;" : "=f"(f806) : "f"(f805), "f"(f804));
  // PTX:1149 fma.rn.f32 %f807, %f137, %f788, %f1589
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f807) : "f"(f137), "f"(f788), "f"(f1589));
  // PTX:1150 fma.rn.f32 %f808, %f138, %f788, %f1590
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f808) : "f"(f138), "f"(f788), "f"(f1590));
  // PTX:1151 fma.rn.f32 %f809, %f139, %f788, %f1591
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f809) : "f"(f139), "f"(f788), "f"(f1591));
  // PTX:1152 fma.rn.f32 %f810, %f791, %f788, %f1592
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f810) : "f"(f791), "f"(f788), "f"(f1592));
  // PTX:1153 fma.rn.f32 %f811, %f794, %f788, %f1593
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f811) : "f"(f794), "f"(f788), "f"(f1593));
  // PTX:1154 fma.rn.f32 %f812, %f797, %f788, %f1594
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f812) : "f"(f797), "f"(f788), "f"(f1594));
  // PTX:1155 fma.rn.f32 %f813, %f800, %f788, %f1595
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f813) : "f"(f800), "f"(f788), "f"(f1595));
  // PTX:1156 fma.rn.f32 %f814, %f803, %f788, %f1596
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f814) : "f"(f803), "f"(f788), "f"(f1596));
  // PTX:1157 fma.rn.f32 %f815, %f806, %f788, %f1597
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f815) : "f"(f806), "f"(f788), "f"(f1597));
  // PTX:1158 mul.f32 %f1589, %f807, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1589) : "f"(f807));
  // PTX:1159 mul.f32 %f1590, %f808, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1590) : "f"(f808));
  // PTX:1160 mul.f32 %f1591, %f809, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1591) : "f"(f809));
  // PTX:1161 mul.f32 %f1592, %f810, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1592) : "f"(f810));
  // PTX:1162 mul.f32 %f1593, %f811, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1593) : "f"(f811));
  // PTX:1163 mul.f32 %f1594, %f812, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1594) : "f"(f812));
  // PTX:1164 mul.f32 %f1595, %f813, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1595) : "f"(f813));
  // PTX:1165 mul.f32 %f1596, %f814, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1596) : "f"(f814));
  // PTX:1166 mul.f32 %f1597, %f815, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1597) : "f"(f815));
  // PTX:1167 mul.f32 %f816, %f1593, %f1597
  asm("mul.f32 %0, %1, %2;" : "=f"(f816) : "f"(f1593), "f"(f1597));
  // PTX:1168 mul.f32 %f817, %f1594, %f1596
  asm("mul.f32 %0, %1, %2;" : "=f"(f817) : "f"(f1594), "f"(f1596));
  // PTX:1169 sub.f32 %f150, %f816, %f817
  asm("sub.f32 %0, %1, %2;" : "=f"(f150) : "f"(f816), "f"(f817));
  // PTX:1170 mul.f32 %f818, %f1594, %f1595
  asm("mul.f32 %0, %1, %2;" : "=f"(f818) : "f"(f1594), "f"(f1595));
  // PTX:1171 mul.f32 %f819, %f1592, %f1597
  asm("mul.f32 %0, %1, %2;" : "=f"(f819) : "f"(f1592), "f"(f1597));
  // PTX:1172 sub.f32 %f151, %f818, %f819
  asm("sub.f32 %0, %1, %2;" : "=f"(f151) : "f"(f818), "f"(f819));
  // PTX:1173 mul.f32 %f820, %f1592, %f1596
  asm("mul.f32 %0, %1, %2;" : "=f"(f820) : "f"(f1592), "f"(f1596));
  // PTX:1174 mul.f32 %f821, %f1593, %f1595
  asm("mul.f32 %0, %1, %2;" : "=f"(f821) : "f"(f1593), "f"(f1595));
  // PTX:1175 sub.f32 %f152, %f820, %f821
  asm("sub.f32 %0, %1, %2;" : "=f"(f152) : "f"(f820), "f"(f821));
  // PTX:1176 mul.f32 %f822, %f1590, %f151
  asm("mul.f32 %0, %1, %2;" : "=f"(f822) : "f"(f1590), "f"(f151));
  // PTX:1177 fma.rn.f32 %f823, %f1589, %f150, %f822
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f823) : "f"(f1589), "f"(f150), "f"(f822));
  // PTX:1178 fma.rn.f32 %f153, %f1591, %f152, %f823
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f153) : "f"(f1591), "f"(f152), "f"(f823));
  // PTX:1179 abs.f32 %f824, %f153
  asm("abs.f32 %0, %1;" : "=f"(f824) : "f"(f153));
  // PTX:1180 setp.le.f32 %p88, %f824, 0f2EDBE6FF
  p88 = (!(isnan(((float)(f824))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f824)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:1181 setp.geu.f32 %p89, %f824, 0f7F800000
  p89 = ((isnan(((float)(f824))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f824)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1182 or.pred %p90, %p88, %p89
  p90 = ((p88) || (p89));
  // PTX:1183 @%p90 bra $L__BB2_90
  if (p90) { goto L_BB2_90; }
  // PTX:1185 rcp.rn.f32 %f825, %f153
  asm("rcp.rn.f32 %0, %1;" : "=f"(f825) : "f"(f153));
  // PTX:1186 mul.f32 %f826, %f1590, %f1597
  asm("mul.f32 %0, %1, %2;" : "=f"(f826) : "f"(f1590), "f"(f1597));
  // PTX:1187 mul.f32 %f827, %f1591, %f1596
  asm("mul.f32 %0, %1, %2;" : "=f"(f827) : "f"(f1591), "f"(f1596));
  // PTX:1188 sub.f32 %f828, %f827, %f826
  asm("sub.f32 %0, %1, %2;" : "=f"(f828) : "f"(f827), "f"(f826));
  // PTX:1189 mul.f32 %f829, %f1591, %f1595
  asm("mul.f32 %0, %1, %2;" : "=f"(f829) : "f"(f1591), "f"(f1595));
  // PTX:1190 mul.f32 %f830, %f1589, %f1597
  asm("mul.f32 %0, %1, %2;" : "=f"(f830) : "f"(f1589), "f"(f1597));
  // PTX:1191 sub.f32 %f831, %f830, %f829
  asm("sub.f32 %0, %1, %2;" : "=f"(f831) : "f"(f830), "f"(f829));
  // PTX:1192 mul.f32 %f832, %f1589, %f1596
  asm("mul.f32 %0, %1, %2;" : "=f"(f832) : "f"(f1589), "f"(f1596));
  // PTX:1193 mul.f32 %f833, %f1590, %f1595
  asm("mul.f32 %0, %1, %2;" : "=f"(f833) : "f"(f1590), "f"(f1595));
  // PTX:1194 sub.f32 %f834, %f833, %f832
  asm("sub.f32 %0, %1, %2;" : "=f"(f834) : "f"(f833), "f"(f832));
  // PTX:1195 mul.f32 %f835, %f1591, %f1593
  asm("mul.f32 %0, %1, %2;" : "=f"(f835) : "f"(f1591), "f"(f1593));
  // PTX:1196 mul.f32 %f836, %f1590, %f1594
  asm("mul.f32 %0, %1, %2;" : "=f"(f836) : "f"(f1590), "f"(f1594));
  // PTX:1197 sub.f32 %f837, %f836, %f835
  asm("sub.f32 %0, %1, %2;" : "=f"(f837) : "f"(f836), "f"(f835));
  // PTX:1198 mul.f32 %f838, %f1589, %f1594
  asm("mul.f32 %0, %1, %2;" : "=f"(f838) : "f"(f1589), "f"(f1594));
  // PTX:1199 mul.f32 %f839, %f1591, %f1592
  asm("mul.f32 %0, %1, %2;" : "=f"(f839) : "f"(f1591), "f"(f1592));
  // PTX:1200 sub.f32 %f840, %f839, %f838
  asm("sub.f32 %0, %1, %2;" : "=f"(f840) : "f"(f839), "f"(f838));
  // PTX:1201 mul.f32 %f841, %f1590, %f1592
  asm("mul.f32 %0, %1, %2;" : "=f"(f841) : "f"(f1590), "f"(f1592));
  // PTX:1202 mul.f32 %f842, %f1589, %f1593
  asm("mul.f32 %0, %1, %2;" : "=f"(f842) : "f"(f1589), "f"(f1593));
  // PTX:1203 sub.f32 %f843, %f842, %f841
  asm("sub.f32 %0, %1, %2;" : "=f"(f843) : "f"(f842), "f"(f841));
  // PTX:1204 fma.rn.f32 %f844, %f150, %f825, %f1589
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f844) : "f"(f150), "f"(f825), "f"(f1589));
  // PTX:1205 fma.rn.f32 %f845, %f151, %f825, %f1590
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f845) : "f"(f151), "f"(f825), "f"(f1590));
  // PTX:1206 fma.rn.f32 %f846, %f152, %f825, %f1591
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f846) : "f"(f152), "f"(f825), "f"(f1591));
  // PTX:1207 fma.rn.f32 %f847, %f828, %f825, %f1592
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f847) : "f"(f828), "f"(f825), "f"(f1592));
  // PTX:1208 fma.rn.f32 %f848, %f831, %f825, %f1593
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f848) : "f"(f831), "f"(f825), "f"(f1593));
  // PTX:1209 fma.rn.f32 %f849, %f834, %f825, %f1594
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f849) : "f"(f834), "f"(f825), "f"(f1594));
  // PTX:1210 fma.rn.f32 %f850, %f837, %f825, %f1595
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f850) : "f"(f837), "f"(f825), "f"(f1595));
  // PTX:1211 fma.rn.f32 %f851, %f840, %f825, %f1596
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f851) : "f"(f840), "f"(f825), "f"(f1596));
  // PTX:1212 fma.rn.f32 %f852, %f843, %f825, %f1597
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f852) : "f"(f843), "f"(f825), "f"(f1597));
  // PTX:1213 mul.f32 %f1589, %f844, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1589) : "f"(f844));
  // PTX:1214 mul.f32 %f1590, %f845, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1590) : "f"(f845));
  // PTX:1215 mul.f32 %f1591, %f846, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1591) : "f"(f846));
  // PTX:1216 mul.f32 %f1592, %f847, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1592) : "f"(f847));
  // PTX:1217 mul.f32 %f1593, %f848, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1593) : "f"(f848));
  // PTX:1218 mul.f32 %f1594, %f849, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1594) : "f"(f849));
  // PTX:1219 mul.f32 %f1595, %f850, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1595) : "f"(f850));
  // PTX:1220 mul.f32 %f1596, %f851, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1596) : "f"(f851));
  // PTX:1221 mul.f32 %f1597, %f852, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1597) : "f"(f852));
  // PTX:1222 add.s32 %r449, %r449, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r449) : "r"(r449));
  // PTX:1223 setp.lt.u32 %p91, %r449, 8
  p91 = (((unsigned)(r449)) < ((unsigned)(8)));
  // PTX:1224 @%p91 bra $L__BB2_87
  if (p91) { goto L_BB2_87; }
  // PTX:1226 $L__BB2_90:
L_BB2_90:;
  // PTX:1227 mul.f32 %f853, %f1590, %f1590
  asm("mul.f32 %0, %1, %2;" : "=f"(f853) : "f"(f1590), "f"(f1590));
  // PTX:1228 fma.rn.f32 %f854, %f1589, %f1589, %f853
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f854) : "f"(f1589), "f"(f1589), "f"(f853));
  // PTX:1229 fma.rn.f32 %f855, %f1591, %f1591, %f854
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f855) : "f"(f1591), "f"(f1591), "f"(f854));
  // PTX:1230 sqrt.rn.f32 %f172, %f855
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f172) : "f"(f855));
  // PTX:1231 setp.leu.f32 %p92, %f172, 0f00000000
  p92 = ((isnan(((float)(f172))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f172)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1232 mov.u32 %r462, 0
  asm("mov.u32 %0, 0;" : "=r"(r462) : );
  // PTX:1233 mov.u32 %r450, %r462
  asm("mov.u32 %0, %1;" : "=r"(r450) : "r"(r462));
  // PTX:1234 mov.u32 %r451, %r462
  asm("mov.u32 %0, %1;" : "=r"(r451) : "r"(r462));
  // PTX:1235 mov.u32 %r452, %r462
  asm("mov.u32 %0, %1;" : "=r"(r452) : "r"(r462));
  // PTX:1236 @%p92 bra $L__BB2_92
  if (p92) { goto L_BB2_92; }
  // PTX:1238 div.rn.f32 %f856, %f1589, %f172
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f856) : "f"(f1589), "f"(f172));
  // PTX:1239 div.rn.f32 %f857, %f1590, %f172
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f857) : "f"(f1590), "f"(f172));
  // PTX:1240 div.rn.f32 %f858, %f1591, %f172
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f858) : "f"(f1591), "f"(f172));
  // PTX:1241 mov.b32 %r452, %f858
  asm("mov.b32 %0, %1;" : "=r"(r452) : "f"(f858));
  // PTX:1242 mov.b32 %r451, %f857
  asm("mov.b32 %0, %1;" : "=r"(r451) : "f"(f857));
  // PTX:1243 mov.b32 %r450, %f856
  asm("mov.b32 %0, %1;" : "=r"(r450) : "f"(f856));
  // PTX:1245 $L__BB2_92:
L_BB2_92:;
  // PTX:1246 mov.b32 %f173, %r450
  asm("mov.b32 %0, %1;" : "=f"(f173) : "r"(r450));
  // PTX:1247 mov.b32 %f174, %r451
  asm("mov.b32 %0, %1;" : "=f"(f174) : "r"(r451));
  // PTX:1248 mul.f32 %f859, %f1593, %f174
  asm("mul.f32 %0, %1, %2;" : "=f"(f859) : "f"(f1593), "f"(f174));
  // PTX:1249 mov.b32 %f175, %r452
  asm("mov.b32 %0, %1;" : "=f"(f175) : "r"(r452));
  // PTX:1250 fma.rn.f32 %f860, %f1592, %f173, %f859
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f860) : "f"(f1592), "f"(f173), "f"(f859));
  // PTX:1251 fma.rn.f32 %f861, %f1594, %f175, %f860
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f861) : "f"(f1594), "f"(f175), "f"(f860));
  // PTX:1252 mul.f32 %f862, %f861, %f173
  asm("mul.f32 %0, %1, %2;" : "=f"(f862) : "f"(f861), "f"(f173));
  // PTX:1253 mul.f32 %f863, %f861, %f174
  asm("mul.f32 %0, %1, %2;" : "=f"(f863) : "f"(f861), "f"(f174));
  // PTX:1254 mul.f32 %f864, %f861, %f175
  asm("mul.f32 %0, %1, %2;" : "=f"(f864) : "f"(f861), "f"(f175));
  // PTX:1255 sub.f32 %f176, %f1592, %f862
  asm("sub.f32 %0, %1, %2;" : "=f"(f176) : "f"(f1592), "f"(f862));
  // PTX:1256 sub.f32 %f177, %f1593, %f863
  asm("sub.f32 %0, %1, %2;" : "=f"(f177) : "f"(f1593), "f"(f863));
  // PTX:1257 sub.f32 %f178, %f1594, %f864
  asm("sub.f32 %0, %1, %2;" : "=f"(f178) : "f"(f1594), "f"(f864));
  // PTX:1258 mul.f32 %f865, %f177, %f177
  asm("mul.f32 %0, %1, %2;" : "=f"(f865) : "f"(f177), "f"(f177));
  // PTX:1259 fma.rn.f32 %f866, %f176, %f176, %f865
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f866) : "f"(f176), "f"(f176), "f"(f865));
  // PTX:1260 fma.rn.f32 %f867, %f178, %f178, %f866
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f867) : "f"(f178), "f"(f178), "f"(f866));
  // PTX:1261 sqrt.rn.f32 %f179, %f867
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f179) : "f"(f867));
  // PTX:1262 setp.leu.f32 %p93, %f179, 0f00000000
  p93 = ((isnan(((float)(f179))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f179)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1263 mov.u32 %r463, %r462
  asm("mov.u32 %0, %1;" : "=r"(r463) : "r"(r462));
  // PTX:1264 mov.u32 %r464, %r462
  asm("mov.u32 %0, %1;" : "=r"(r464) : "r"(r462));
  // PTX:1265 @%p93 bra $L__BB2_94
  if (p93) { goto L_BB2_94; }
  // PTX:1267 div.rn.f32 %f868, %f176, %f179
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f868) : "f"(f176), "f"(f179));
  // PTX:1268 div.rn.f32 %f869, %f177, %f179
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f869) : "f"(f177), "f"(f179));
  // PTX:1269 div.rn.f32 %f870, %f178, %f179
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f870) : "f"(f178), "f"(f179));
  // PTX:1270 mov.b32 %r464, %f870
  asm("mov.b32 %0, %1;" : "=r"(r464) : "f"(f870));
  // PTX:1271 mov.b32 %r463, %f869
  asm("mov.b32 %0, %1;" : "=r"(r463) : "f"(f869));
  // PTX:1272 mov.b32 %r462, %f868
  asm("mov.b32 %0, %1;" : "=r"(r462) : "f"(f868));
  // PTX:1274 $L__BB2_94:
L_BB2_94:;
  // PTX:1275 mov.u32 %r465, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r465) : );
  // PTX:1276 mul.f32 %f871, %f174, %f174
  asm("mul.f32 %0, %1, %2;" : "=f"(f871) : "f"(f174), "f"(f174));
  // PTX:1277 fma.rn.f32 %f872, %f173, %f173, %f871
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f872) : "f"(f173), "f"(f173), "f"(f871));
  // PTX:1278 fma.rn.f32 %f873, %f175, %f175, %f872
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f873) : "f"(f175), "f"(f175), "f"(f872));
  // PTX:1279 sqrt.rn.f32 %f874, %f873
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f874) : "f"(f873));
  // PTX:1280 setp.le.f32 %p94, %f874, 0f322BCC77
  p94 = (!(isnan(((float)(f874))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f874)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1281 mov.u32 %r466, 0
  asm("mov.u32 %0, 0;" : "=r"(r466) : );
  // PTX:1282 mov.u32 %r467, %r466
  asm("mov.u32 %0, %1;" : "=r"(r467) : "r"(r466));
  // PTX:1283 mov.u32 %r468, %r466
  asm("mov.u32 %0, %1;" : "=r"(r468) : "r"(r466));
  // PTX:1284 mov.u32 %r469, %r465
  asm("mov.u32 %0, %1;" : "=r"(r469) : "r"(r465));
  // PTX:1285 mov.u32 %r470, %r466
  asm("mov.u32 %0, %1;" : "=r"(r470) : "r"(r466));
  // PTX:1286 mov.u32 %r471, %r466
  asm("mov.u32 %0, %1;" : "=r"(r471) : "r"(r466));
  // PTX:1287 mov.u32 %r472, %r466
  asm("mov.u32 %0, %1;" : "=r"(r472) : "r"(r466));
  // PTX:1288 mov.u32 %r473, %r465
  asm("mov.u32 %0, %1;" : "=r"(r473) : "r"(r465));
  // PTX:1289 @%p94 bra $L__BB2_101
  if (p94) { goto L_BB2_101; }
  // PTX:1291 mov.u32 %r465, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r465) : );
  // PTX:1292 mov.b32 %f180, %r462
  asm("mov.b32 %0, %1;" : "=f"(f180) : "r"(r462));
  // PTX:1293 mov.b32 %f181, %r463
  asm("mov.b32 %0, %1;" : "=f"(f181) : "r"(r463));
  // PTX:1294 mul.f32 %f875, %f181, %f181
  asm("mul.f32 %0, %1, %2;" : "=f"(f875) : "f"(f181), "f"(f181));
  // PTX:1295 mov.b32 %f182, %r464
  asm("mov.b32 %0, %1;" : "=f"(f182) : "r"(r464));
  // PTX:1296 fma.rn.f32 %f876, %f180, %f180, %f875
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f876) : "f"(f180), "f"(f180), "f"(f875));
  // PTX:1297 fma.rn.f32 %f877, %f182, %f182, %f876
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f877) : "f"(f182), "f"(f182), "f"(f876));
  // PTX:1298 sqrt.rn.f32 %f878, %f877
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f878) : "f"(f877));
  // PTX:1299 setp.le.f32 %p95, %f878, 0f322BCC77
  p95 = (!(isnan(((float)(f878))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f878)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1300 @%p95 bra $L__BB2_101
  if (p95) { goto L_BB2_101; }
  // PTX:1302 mul.f32 %f879, %f174, %f182
  asm("mul.f32 %0, %1, %2;" : "=f"(f879) : "f"(f174), "f"(f182));
  // PTX:1303 mul.f32 %f880, %f175, %f181
  asm("mul.f32 %0, %1, %2;" : "=f"(f880) : "f"(f175), "f"(f181));
  // PTX:1304 sub.f32 %f183, %f879, %f880
  asm("sub.f32 %0, %1, %2;" : "=f"(f183) : "f"(f879), "f"(f880));
  // PTX:1305 mul.f32 %f881, %f173, %f182
  asm("mul.f32 %0, %1, %2;" : "=f"(f881) : "f"(f173), "f"(f182));
  // PTX:1306 mul.f32 %f882, %f175, %f180
  asm("mul.f32 %0, %1, %2;" : "=f"(f882) : "f"(f175), "f"(f180));
  // PTX:1307 sub.f32 %f184, %f882, %f881
  asm("sub.f32 %0, %1, %2;" : "=f"(f184) : "f"(f882), "f"(f881));
  // PTX:1308 mul.f32 %f883, %f174, %f180
  asm("mul.f32 %0, %1, %2;" : "=f"(f883) : "f"(f174), "f"(f180));
  // PTX:1309 mul.f32 %f884, %f173, %f181
  asm("mul.f32 %0, %1, %2;" : "=f"(f884) : "f"(f173), "f"(f181));
  // PTX:1310 sub.f32 %f185, %f884, %f883
  asm("sub.f32 %0, %1, %2;" : "=f"(f185) : "f"(f884), "f"(f883));
  // PTX:1311 mul.f32 %f885, %f184, %f184
  asm("mul.f32 %0, %1, %2;" : "=f"(f885) : "f"(f184), "f"(f184));
  // PTX:1312 fma.rn.f32 %f886, %f183, %f183, %f885
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f886) : "f"(f183), "f"(f183), "f"(f885));
  // PTX:1313 fma.rn.f32 %f887, %f185, %f185, %f886
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f887) : "f"(f185), "f"(f185), "f"(f886));
  // PTX:1314 sqrt.rn.f32 %f186, %f887
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f186) : "f"(f887));
  // PTX:1315 setp.leu.f32 %p96, %f186, 0f00000000
  p96 = ((isnan(((float)(f186))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f186)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1316 mov.u32 %r471, 0
  asm("mov.u32 %0, 0;" : "=r"(r471) : );
  // PTX:1317 mov.u32 %r472, %r471
  asm("mov.u32 %0, %1;" : "=r"(r472) : "r"(r471));
  // PTX:1318 mov.u32 %r473, %r471
  asm("mov.u32 %0, %1;" : "=r"(r473) : "r"(r471));
  // PTX:1319 @%p96 bra $L__BB2_98
  if (p96) { goto L_BB2_98; }
  // PTX:1321 div.rn.f32 %f888, %f183, %f186
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f888) : "f"(f183), "f"(f186));
  // PTX:1322 div.rn.f32 %f889, %f184, %f186
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f889) : "f"(f184), "f"(f186));
  // PTX:1323 div.rn.f32 %f890, %f185, %f186
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f890) : "f"(f185), "f"(f186));
  // PTX:1324 mov.b32 %r473, %f890
  asm("mov.b32 %0, %1;" : "=r"(r473) : "f"(f890));
  // PTX:1325 mov.b32 %r472, %f889
  asm("mov.b32 %0, %1;" : "=r"(r472) : "f"(f889));
  // PTX:1326 mov.b32 %r471, %f888
  asm("mov.b32 %0, %1;" : "=r"(r471) : "f"(f888));
  // PTX:1328 $L__BB2_98:
L_BB2_98:;
  // PTX:1329 mov.b32 %f187, %r471
  asm("mov.b32 %0, %1;" : "=f"(f187) : "r"(r471));
  // PTX:1330 mov.b32 %f188, %r472
  asm("mov.b32 %0, %1;" : "=f"(f188) : "r"(r472));
  // PTX:1331 mul.f32 %f891, %f1596, %f188
  asm("mul.f32 %0, %1, %2;" : "=f"(f891) : "f"(f1596), "f"(f188));
  // PTX:1332 mov.b32 %f189, %r473
  asm("mov.b32 %0, %1;" : "=f"(f189) : "r"(r473));
  // PTX:1333 fma.rn.f32 %f892, %f1595, %f187, %f891
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f892) : "f"(f1595), "f"(f187), "f"(f891));
  // PTX:1334 fma.rn.f32 %f893, %f1597, %f189, %f892
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f893) : "f"(f1597), "f"(f189), "f"(f892));
  // PTX:1335 setp.geu.f32 %p97, %f893, 0f00000000
  p97 = ((isnan(((float)(f893))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f893)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:1336 @%p97 bra $L__BB2_100
  if (p97) { goto L_BB2_100; }
  // PTX:1338 neg.f32 %f894, %f180
  asm("neg.f32 %0, %1;" : "=f"(f894) : "f"(f180));
  // PTX:1339 mov.b32 %r462, %f894
  asm("mov.b32 %0, %1;" : "=r"(r462) : "f"(f894));
  // PTX:1340 neg.f32 %f895, %f181
  asm("neg.f32 %0, %1;" : "=f"(f895) : "f"(f181));
  // PTX:1341 mov.b32 %r463, %f895
  asm("mov.b32 %0, %1;" : "=r"(r463) : "f"(f895));
  // PTX:1342 neg.f32 %f896, %f182
  asm("neg.f32 %0, %1;" : "=f"(f896) : "f"(f182));
  // PTX:1343 mov.b32 %r464, %f896
  asm("mov.b32 %0, %1;" : "=r"(r464) : "f"(f896));
  // PTX:1344 neg.f32 %f897, %f187
  asm("neg.f32 %0, %1;" : "=f"(f897) : "f"(f187));
  // PTX:1345 mov.b32 %r471, %f897
  asm("mov.b32 %0, %1;" : "=r"(r471) : "f"(f897));
  // PTX:1346 neg.f32 %f898, %f188
  asm("neg.f32 %0, %1;" : "=f"(f898) : "f"(f188));
  // PTX:1347 mov.b32 %r472, %f898
  asm("mov.b32 %0, %1;" : "=r"(r472) : "f"(f898));
  // PTX:1348 neg.f32 %f899, %f189
  asm("neg.f32 %0, %1;" : "=f"(f899) : "f"(f189));
  // PTX:1349 mov.b32 %r473, %f899
  asm("mov.b32 %0, %1;" : "=r"(r473) : "f"(f899));
  // PTX:1351 $L__BB2_100:
L_BB2_100:;
  // PTX:1352 mov.u32 %r465, %r450
  asm("mov.u32 %0, %1;" : "=r"(r465) : "r"(r450));
  // PTX:1353 mov.u32 %r466, %r451
  asm("mov.u32 %0, %1;" : "=r"(r466) : "r"(r451));
  // PTX:1354 mov.u32 %r467, %r452
  asm("mov.u32 %0, %1;" : "=r"(r467) : "r"(r452));
  // PTX:1355 mov.u32 %r468, %r462
  asm("mov.u32 %0, %1;" : "=r"(r468) : "r"(r462));
  // PTX:1356 mov.u32 %r469, %r463
  asm("mov.u32 %0, %1;" : "=r"(r469) : "r"(r463));
  // PTX:1357 mov.u32 %r470, %r464
  asm("mov.u32 %0, %1;" : "=r"(r470) : "r"(r464));
  // PTX:1359 $L__BB2_101:
L_BB2_101:;
  // PTX:1360 mov.b32 %f900, %r465
  asm("mov.b32 %0, %1;" : "=f"(f900) : "r"(r465));
  // PTX:1361 mov.b32 %f901, %r468
  asm("mov.b32 %0, %1;" : "=f"(f901) : "r"(r468));
  // PTX:1362 mov.b32 %f902, %r471
  asm("mov.b32 %0, %1;" : "=f"(f902) : "r"(r471));
  // PTX:1363 mov.b32 %f903, %r466
  asm("mov.b32 %0, %1;" : "=f"(f903) : "r"(r466));
  // PTX:1364 mul.f32 %f904, %f103, %f903
  asm("mul.f32 %0, %1, %2;" : "=f"(f904) : "f"(f103), "f"(f903));
  // PTX:1365 mov.b32 %f905, %r469
  asm("mov.b32 %0, %1;" : "=f"(f905) : "r"(r469));
  // PTX:1366 mul.f32 %f906, %f103, %f905
  asm("mul.f32 %0, %1, %2;" : "=f"(f906) : "f"(f103), "f"(f905));
  // PTX:1367 mov.b32 %f907, %r472
  asm("mov.b32 %0, %1;" : "=f"(f907) : "r"(r472));
  // PTX:1368 mul.f32 %f908, %f103, %f907
  asm("mul.f32 %0, %1, %2;" : "=f"(f908) : "f"(f103), "f"(f907));
  // PTX:1369 fma.rn.f32 %f909, %f102, %f900, %f904
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f909) : "f"(f102), "f"(f900), "f"(f904));
  // PTX:1370 fma.rn.f32 %f910, %f102, %f901, %f906
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f910) : "f"(f102), "f"(f901), "f"(f906));
  // PTX:1371 fma.rn.f32 %f911, %f102, %f902, %f908
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f911) : "f"(f102), "f"(f902), "f"(f908));
  // PTX:1372 mov.b32 %f912, %r467
  asm("mov.b32 %0, %1;" : "=f"(f912) : "r"(r467));
  // PTX:1373 mov.b32 %f913, %r470
  asm("mov.b32 %0, %1;" : "=f"(f913) : "r"(r470));
  // PTX:1374 mov.b32 %f914, %r473
  asm("mov.b32 %0, %1;" : "=f"(f914) : "r"(r473));
  // PTX:1375 fma.rn.f32 %f1598, %f104, %f912, %f909
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1598) : "f"(f104), "f"(f912), "f"(f909));
  // PTX:1376 fma.rn.f32 %f1599, %f104, %f913, %f910
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1599) : "f"(f104), "f"(f913), "f"(f910));
  // PTX:1377 fma.rn.f32 %f1600, %f104, %f914, %f911
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1600) : "f"(f104), "f"(f914), "f"(f911));
  // PTX:1378 bra.uni $L__BB2_102
  goto L_BB2_102;
  // PTX:1380 $L__BB2_103:
L_BB2_103:;
  // PTX:1381 mul.f32 %f927, %f100, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f927) : "f"(f100), "f"(f10));
  // PTX:1382 mov.b32 %f928, %r40
  asm("mov.b32 %0, %1;" : "=f"(f928) : "r"(r40));
  // PTX:1383 sub.f32 %f929, %f928, %f101
  asm("sub.f32 %0, %1, %2;" : "=f"(f929) : "f"(f928), "f"(f101));
  // PTX:1384 mov.b32 %f930, %r41
  asm("mov.b32 %0, %1;" : "=f"(f930) : "r"(r41));
  // PTX:1385 sub.f32 %f931, %f930, %f927
  asm("sub.f32 %0, %1, %2;" : "=f"(f931) : "f"(f930), "f"(f927));
  // PTX:1386 mov.b32 %f932, %r42
  asm("mov.b32 %0, %1;" : "=f"(f932) : "r"(r42));
  // PTX:1387 mul.f32 %f933, %f100, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f933) : "f"(f100), "f"(f11));
  // PTX:1388 sub.f32 %f934, %f932, %f933
  asm("sub.f32 %0, %1, %2;" : "=f"(f934) : "f"(f932), "f"(f933));
  // PTX:1389 mov.b32 %r479, %f929
  asm("mov.b32 %0, %1;" : "=r"(r479) : "f"(f929));
  // PTX:1390 mov.b32 %r478, %f931
  asm("mov.b32 %0, %1;" : "=r"(r478) : "f"(f931));
  // PTX:1391 mov.b32 %r477, %f934
  asm("mov.b32 %0, %1;" : "=r"(r477) : "f"(f934));
  // PTX:1392 bra.uni $L__BB2_104
  goto L_BB2_104;
  // PTX:1394 $L__BB2_83:
L_BB2_83:;
  // PTX:1395 rcp.rn.f32 %f728, %f117
  asm("rcp.rn.f32 %0, %1;" : "=f"(f728) : "f"(f117));
  // PTX:1396 mul.f32 %f729, %f115, %f105
  asm("mul.f32 %0, %1, %2;" : "=f"(f729) : "f"(f115), "f"(f105));
  // PTX:1397 mul.f32 %f730, %f116, %f107
  asm("mul.f32 %0, %1, %2;" : "=f"(f730) : "f"(f116), "f"(f107));
  // PTX:1398 sub.f32 %f731, %f730, %f729
  asm("sub.f32 %0, %1, %2;" : "=f"(f731) : "f"(f730), "f"(f729));
  // PTX:1399 mul.f32 %f732, %f116, %f110
  asm("mul.f32 %0, %1, %2;" : "=f"(f732) : "f"(f116), "f"(f110));
  // PTX:1400 mul.f32 %f733, %f114, %f105
  asm("mul.f32 %0, %1, %2;" : "=f"(f733) : "f"(f114), "f"(f105));
  // PTX:1401 sub.f32 %f734, %f733, %f732
  asm("sub.f32 %0, %1, %2;" : "=f"(f734) : "f"(f733), "f"(f732));
  // PTX:1402 mul.f32 %f735, %f114, %f107
  asm("mul.f32 %0, %1, %2;" : "=f"(f735) : "f"(f114), "f"(f107));
  // PTX:1403 mul.f32 %f736, %f115, %f110
  asm("mul.f32 %0, %1, %2;" : "=f"(f736) : "f"(f115), "f"(f110));
  // PTX:1404 sub.f32 %f737, %f736, %f735
  asm("sub.f32 %0, %1, %2;" : "=f"(f737) : "f"(f736), "f"(f735));
  // PTX:1405 mul.f32 %f738, %f116, %f106
  asm("mul.f32 %0, %1, %2;" : "=f"(f738) : "f"(f116), "f"(f106));
  // PTX:1406 mul.f32 %f739, %f115, %f108
  asm("mul.f32 %0, %1, %2;" : "=f"(f739) : "f"(f115), "f"(f108));
  // PTX:1407 sub.f32 %f740, %f739, %f738
  asm("sub.f32 %0, %1, %2;" : "=f"(f740) : "f"(f739), "f"(f738));
  // PTX:1408 mul.f32 %f741, %f114, %f108
  asm("mul.f32 %0, %1, %2;" : "=f"(f741) : "f"(f114), "f"(f108));
  // PTX:1409 mul.f32 %f742, %f116, %f111
  asm("mul.f32 %0, %1, %2;" : "=f"(f742) : "f"(f116), "f"(f111));
  // PTX:1410 sub.f32 %f743, %f742, %f741
  asm("sub.f32 %0, %1, %2;" : "=f"(f743) : "f"(f742), "f"(f741));
  // PTX:1411 mul.f32 %f744, %f115, %f111
  asm("mul.f32 %0, %1, %2;" : "=f"(f744) : "f"(f115), "f"(f111));
  // PTX:1412 mul.f32 %f745, %f114, %f106
  asm("mul.f32 %0, %1, %2;" : "=f"(f745) : "f"(f114), "f"(f106));
  // PTX:1413 sub.f32 %f746, %f745, %f744
  asm("sub.f32 %0, %1, %2;" : "=f"(f746) : "f"(f745), "f"(f744));
  // PTX:1414 mul.f32 %f747, %f109, %f728
  asm("mul.f32 %0, %1, %2;" : "=f"(f747) : "f"(f109), "f"(f728));
  // PTX:1415 mul.f32 %f748, %f112, %f728
  asm("mul.f32 %0, %1, %2;" : "=f"(f748) : "f"(f112), "f"(f728));
  // PTX:1416 mul.f32 %f749, %f113, %f728
  asm("mul.f32 %0, %1, %2;" : "=f"(f749) : "f"(f113), "f"(f728));
  // PTX:1417 mul.f32 %f750, %f731, %f728
  asm("mul.f32 %0, %1, %2;" : "=f"(f750) : "f"(f731), "f"(f728));
  // PTX:1418 mul.f32 %f751, %f734, %f728
  asm("mul.f32 %0, %1, %2;" : "=f"(f751) : "f"(f734), "f"(f728));
  // PTX:1419 mul.f32 %f752, %f737, %f728
  asm("mul.f32 %0, %1, %2;" : "=f"(f752) : "f"(f737), "f"(f728));
  // PTX:1420 mul.f32 %f753, %f740, %f728
  asm("mul.f32 %0, %1, %2;" : "=f"(f753) : "f"(f740), "f"(f728));
  // PTX:1421 mul.f32 %f754, %f743, %f728
  asm("mul.f32 %0, %1, %2;" : "=f"(f754) : "f"(f743), "f"(f728));
  // PTX:1422 mul.f32 %f755, %f746, %f728
  asm("mul.f32 %0, %1, %2;" : "=f"(f755) : "f"(f746), "f"(f728));
  // PTX:1423 mul.f32 %f756, %f748, %f103
  asm("mul.f32 %0, %1, %2;" : "=f"(f756) : "f"(f748), "f"(f103));
  // PTX:1424 mul.f32 %f757, %f751, %f103
  asm("mul.f32 %0, %1, %2;" : "=f"(f757) : "f"(f751), "f"(f103));
  // PTX:1425 mul.f32 %f758, %f754, %f103
  asm("mul.f32 %0, %1, %2;" : "=f"(f758) : "f"(f754), "f"(f103));
  // PTX:1426 fma.rn.f32 %f759, %f747, %f102, %f756
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f759) : "f"(f747), "f"(f102), "f"(f756));
  // PTX:1427 fma.rn.f32 %f760, %f750, %f102, %f757
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f760) : "f"(f750), "f"(f102), "f"(f757));
  // PTX:1428 fma.rn.f32 %f761, %f753, %f102, %f758
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f761) : "f"(f753), "f"(f102), "f"(f758));
  // PTX:1429 fma.rn.f32 %f1598, %f749, %f104, %f759
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1598) : "f"(f749), "f"(f104), "f"(f759));
  // PTX:1430 fma.rn.f32 %f1599, %f752, %f104, %f760
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1599) : "f"(f752), "f"(f104), "f"(f760));
  // PTX:1431 fma.rn.f32 %f1600, %f755, %f104, %f761
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1600) : "f"(f755), "f"(f104), "f"(f761));
  // PTX:1433 $L__BB2_102:
L_BB2_102:;
  // PTX:1434 mov.b32 %f919, %r40
  asm("mov.b32 %0, %1;" : "=f"(f919) : "r"(r40));
  // PTX:1435 add.f32 %f920, %f919, %f1598
  asm("add.f32 %0, %1, %2;" : "=f"(f920) : "f"(f919), "f"(f1598));
  // PTX:1436 mov.b32 %f922, %r41
  asm("mov.b32 %0, %1;" : "=f"(f922) : "r"(r41));
  // PTX:1437 add.f32 %f923, %f922, %f1599
  asm("add.f32 %0, %1, %2;" : "=f"(f923) : "f"(f922), "f"(f1599));
  // PTX:1438 mov.b32 %f925, %r42
  asm("mov.b32 %0, %1;" : "=f"(f925) : "r"(r42));
  // PTX:1439 add.f32 %f926, %f925, %f1600
  asm("add.f32 %0, %1, %2;" : "=f"(f926) : "f"(f925), "f"(f1600));
  // PTX:1440 mov.b32 %r479, %f920
  asm("mov.b32 %0, %1;" : "=r"(r479) : "f"(f920));
  // PTX:1441 mov.b32 %r478, %f923
  asm("mov.b32 %0, %1;" : "=r"(r478) : "f"(f923));
  // PTX:1442 mov.b32 %r477, %f926
  asm("mov.b32 %0, %1;" : "=r"(r477) : "f"(f926));
  // PTX:1444 $L__BB2_104:
L_BB2_104:;
  // PTX:1445 ld.param.u64 %rd446, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_6]
  rd446 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:1446 ld.param.u64 %rd406, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_4]
  rd406 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:1447 cvta.to.global.u64 %rd405, %rd406
  rd405 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd406));
  // PTX:1448 add.s64 %rd61, %rd405, %rd159
  asm("add.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd405), "l"(rd159));
  // PTX:1449 setp.eq.s64 %p98, %rd446, 0
  p98 = (((long long)(rd446)) == ((long long)(0)));
  // PTX:1450 @%p98 bra $L__BB2_106
  if (p98) { goto L_BB2_106; }
  // PTX:1452 ld.param.u64 %rd447, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_6]
  rd447 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:1453 cvta.to.global.u64 %rd205, %rd447
  rd205 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd447));
  // PTX:1454 add.s64 %rd207, %rd205, %rd159
  asm("add.s64 %0, %1, %2;" : "=l"(rd207) : "l"(rd205), "l"(rd159));
  // PTX:1455 ld.global.f32 %f935, [%rd207]
  f935 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd207) + (0)))));
  // PTX:1456 ld.global.f32 %f936, [%rd61]
  f936 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))));
  // PTX:1457 add.f32 %f937, %f936, %f935
  asm("add.f32 %0, %1, %2;" : "=f"(f937) : "f"(f936), "f"(f935));
  // PTX:1458 ld.global.f32 %f938, [%rd207+4]
  f938 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd207) + (4)))));
  // PTX:1459 ld.global.f32 %f939, [%rd61+4]
  f939 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (4)))));
  // PTX:1460 add.f32 %f940, %f939, %f938
  asm("add.f32 %0, %1, %2;" : "=f"(f940) : "f"(f939), "f"(f938));
  // PTX:1461 ld.global.f32 %f941, [%rd207+8]
  f941 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd207) + (8)))));
  // PTX:1462 ld.global.f32 %f942, [%rd61+8]
  f942 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (8)))));
  // PTX:1463 add.f32 %f943, %f942, %f941
  asm("add.f32 %0, %1, %2;" : "=f"(f943) : "f"(f942), "f"(f941));
  // PTX:1464 mov.b32 %r448, %f937
  asm("mov.b32 %0, %1;" : "=r"(r448) : "f"(f937));
  // PTX:1465 mov.b32 %r447, %f940
  asm("mov.b32 %0, %1;" : "=r"(r447) : "f"(f940));
  // PTX:1466 mov.b32 %r446, %f943
  asm("mov.b32 %0, %1;" : "=r"(r446) : "f"(f943));
  // PTX:1468 $L__BB2_106:
L_BB2_106:;
  // PTX:1469 ld.param.u64 %rd448, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_7]
  rd448 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:1470 ld.param.u64 %rd408, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_5]
  rd408 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:1471 cvta.to.global.u64 %rd407, %rd408
  rd407 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd408));
  // PTX:1472 add.s64 %rd62, %rd407, %rd159
  asm("add.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd407), "l"(rd159));
  // PTX:1473 setp.eq.s64 %p99, %rd448, 0
  p99 = (((long long)(rd448)) == ((long long)(0)));
  // PTX:1474 @%p99 bra $L__BB2_108
  if (p99) { goto L_BB2_108; }
  // PTX:1476 ld.param.u64 %rd449, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_7]
  rd449 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:1477 cvta.to.global.u64 %rd209, %rd449
  rd209 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd449));
  // PTX:1478 add.s64 %rd211, %rd209, %rd159
  asm("add.s64 %0, %1, %2;" : "=l"(rd211) : "l"(rd209), "l"(rd159));
  // PTX:1479 ld.global.f32 %f944, [%rd211]
  f944 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd211) + (0)))));
  // PTX:1480 ld.global.f32 %f945, [%rd62]
  f945 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))));
  // PTX:1481 add.f32 %f946, %f945, %f944
  asm("add.f32 %0, %1, %2;" : "=f"(f946) : "f"(f945), "f"(f944));
  // PTX:1482 ld.global.f32 %f947, [%rd211+4]
  f947 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd211) + (4)))));
  // PTX:1483 ld.global.f32 %f948, [%rd62+4]
  f948 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (4)))));
  // PTX:1484 add.f32 %f949, %f948, %f947
  asm("add.f32 %0, %1, %2;" : "=f"(f949) : "f"(f948), "f"(f947));
  // PTX:1485 ld.global.f32 %f950, [%rd211+8]
  f950 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd211) + (8)))));
  // PTX:1486 ld.global.f32 %f951, [%rd62+8]
  f951 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (8)))));
  // PTX:1487 add.f32 %f952, %f951, %f950
  asm("add.f32 %0, %1, %2;" : "=f"(f952) : "f"(f951), "f"(f950));
  // PTX:1488 mov.b32 %r479, %f946
  asm("mov.b32 %0, %1;" : "=r"(r479) : "f"(f946));
  // PTX:1489 mov.b32 %r478, %f949
  asm("mov.b32 %0, %1;" : "=r"(r478) : "f"(f949));
  // PTX:1490 mov.b32 %r477, %f952
  asm("mov.b32 %0, %1;" : "=r"(r477) : "f"(f952));
  // PTX:1492 $L__BB2_108:
L_BB2_108:;
  // PTX:1493 setp.eq.s32 %p168, %r35, 3
  p168 = (((int)(r35)) == ((int)(3)));
  // PTX:1494 setp.eq.s32 %p166, %r36, 3
  p166 = (((int)(r36)) == ((int)(3)));
  // PTX:1495 ld.param.u64 %rd410, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_9]
  rd410 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:1496 ld.param.u64 %rd409, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_10]
  rd409 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:1497 or.pred %p1, %p168, %p166
  p1 = ((p168) || (p166));
  // PTX:1498 cvta.to.global.u64 %rd212, %rd409
  rd212 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd409));
  // PTX:1499 add.s64 %rd214, %rd212, %rd124
  asm("add.s64 %0, %1, %2;" : "=l"(rd214) : "l"(rd212), "l"(rd124));
  // PTX:1500 ld.global.f32 %f953, [%rd214]
  f953 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd214) + (0)))));
  // PTX:1501 cvta.to.global.u64 %rd215, %rd410
  rd215 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd410));
  // PTX:1502 add.s64 %rd216, %rd215, %rd124
  asm("add.s64 %0, %1, %2;" : "=l"(rd216) : "l"(rd215), "l"(rd124));
  // PTX:1503 ld.global.f32 %f954, [%rd216]
  f954 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd216) + (0)))));
  // PTX:1504 add.f32 %f955, %f954, %f953
  asm("add.f32 %0, %1, %2;" : "=f"(f955) : "f"(f954), "f"(f953));
  // PTX:1505 mov.b32 %f956, %r408
  asm("mov.b32 %0, %1;" : "=f"(f956) : "r"(r408));
  // PTX:1506 mov.b32 %f957, %r411
  asm("mov.b32 %0, %1;" : "=f"(f957) : "r"(r411));
  // PTX:1507 sub.f32 %f958, %f957, %f956
  asm("sub.f32 %0, %1, %2;" : "=f"(f958) : "f"(f957), "f"(f956));
  // PTX:1508 mov.b32 %f959, %r407
  asm("mov.b32 %0, %1;" : "=f"(f959) : "r"(r407));
  // PTX:1509 mov.b32 %f960, %r410
  asm("mov.b32 %0, %1;" : "=f"(f960) : "r"(r410));
  // PTX:1510 sub.f32 %f961, %f960, %f959
  asm("sub.f32 %0, %1, %2;" : "=f"(f961) : "f"(f960), "f"(f959));
  // PTX:1511 mov.b32 %f962, %r406
  asm("mov.b32 %0, %1;" : "=f"(f962) : "r"(r406));
  // PTX:1512 mov.b32 %f963, %r409
  asm("mov.b32 %0, %1;" : "=f"(f963) : "r"(r409));
  // PTX:1513 sub.f32 %f964, %f963, %f962
  asm("sub.f32 %0, %1, %2;" : "=f"(f964) : "f"(f963), "f"(f962));
  // PTX:1514 mul.f32 %f965, %f961, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f965) : "f"(f961), "f"(f10));
  // PTX:1515 fma.rn.f32 %f966, %f958, %f9, %f965
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f966) : "f"(f958), "f"(f9), "f"(f965));
  // PTX:1516 fma.rn.f32 %f967, %f964, %f11, %f966
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f967) : "f"(f964), "f"(f11), "f"(f966));
  // PTX:1517 sub.f32 %f190, %f955, %f967
  asm("sub.f32 %0, %1, %2;" : "=f"(f190) : "f"(f955), "f"(f967));
  // PTX:1518 setp.le.f32 %p102, %f190, 0f00000000
  p102 = (!(isnan(((float)(f190))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f190)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1519 @%p102 bra $L__BB2_203
  if (p102) { goto L_BB2_203; }
  // PTX:1521 mov.f32 %f1628, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1628) : );
  // PTX:1522 mov.f32 %f1613, %f1628
  asm("mov.f32 %0, %1;" : "=f"(f1613) : "f"(f1628));
  // PTX:1523 mov.f32 %f1614, %f1628
  asm("mov.f32 %0, %1;" : "=f"(f1614) : "f"(f1628));
  // PTX:1524 mov.f32 %f1615, %f1628
  asm("mov.f32 %0, %1;" : "=f"(f1615) : "f"(f1628));
  // PTX:1525 @%p26 bra $L__BB2_123
  if (p26) { goto L_BB2_123; }
  // PTX:1527 ld.param.u64 %rd457, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_30]
  rd457 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param30 + (0))));
  // PTX:1528 ld.global.f32 %f191, [%rd59]
  f191 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:1529 ld.global.f32 %f192, [%rd59+4]
  f192 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4)))));
  // PTX:1530 ld.global.f32 %f193, [%rd59+8]
  f193 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8)))));
  // PTX:1531 cvt.s64.s32 %rd63, %r395
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd63) : "r"(r395));
  // PTX:1532 setp.eq.s64 %p104, %rd457, 0
  p104 = (((long long)(rd457)) == ((long long)(0)));
  // PTX:1533 @%p104 bra $L__BB2_112
  if (p104) { goto L_BB2_112; }
  // PTX:1535 mul.lo.s64 %rd217, %rd63, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd217) : "l"(rd63));
  // PTX:1536 add.s64 %rd218, %rd6, %rd217
  asm("add.s64 %0, %1, %2;" : "=l"(rd218) : "l"(rd6), "l"(rd217));
  // PTX:1537 add.s64 %rd219, %rd4, %rd217
  asm("add.s64 %0, %1, %2;" : "=l"(rd219) : "l"(rd4), "l"(rd217));
  // PTX:1538 ld.global.f32 %f971, [%rd219]
  f971 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd219) + (0)))));
  // PTX:1539 ld.global.f32 %f972, [%rd218]
  f972 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd218) + (0)))));
  // PTX:1540 sub.f32 %f973, %f972, %f971
  asm("sub.f32 %0, %1, %2;" : "=f"(f973) : "f"(f972), "f"(f971));
  // PTX:1541 ld.global.f32 %f974, [%rd219+4]
  f974 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd219) + (4)))));
  // PTX:1542 ld.global.f32 %f975, [%rd218+4]
  f975 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd218) + (4)))));
  // PTX:1543 sub.f32 %f976, %f975, %f974
  asm("sub.f32 %0, %1, %2;" : "=f"(f976) : "f"(f975), "f"(f974));
  // PTX:1544 ld.global.f32 %f977, [%rd219+8]
  f977 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd219) + (8)))));
  // PTX:1545 ld.global.f32 %f978, [%rd218+8]
  f978 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd218) + (8)))));
  // PTX:1546 sub.f32 %f979, %f978, %f977
  asm("sub.f32 %0, %1, %2;" : "=f"(f979) : "f"(f978), "f"(f977));
  // PTX:1547 mul.f32 %f1601, %f973, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1601) : "f"(f973), "f"(f414));
  // PTX:1548 mul.f32 %f1602, %f976, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1602) : "f"(f976), "f"(f414));
  // PTX:1549 mul.f32 %f1603, %f979, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1603) : "f"(f979), "f"(f414));
  // PTX:1550 bra.uni $L__BB2_113
  goto L_BB2_113;
  // PTX:1552 $L__BB2_112:
L_BB2_112:;
  // PTX:1553 mul.lo.s64 %rd220, %rd63, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd220) : "l"(rd63));
  // PTX:1554 add.s64 %rd221, %rd3, %rd220
  asm("add.s64 %0, %1, %2;" : "=l"(rd221) : "l"(rd3), "l"(rd220));
  // PTX:1555 ld.global.f32 %f1601, [%rd221]
  f1601 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd221) + (0)))));
  // PTX:1556 ld.global.f32 %f1602, [%rd221+4]
  f1602 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd221) + (4)))));
  // PTX:1557 ld.global.f32 %f1603, [%rd221+8]
  f1603 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd221) + (8)))));
  // PTX:1559 $L__BB2_113:
L_BB2_113:;
  // PTX:1560 cvt.s64.s32 %rd64, %r396
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd64) : "r"(r396));
  // PTX:1561 @%p104 bra $L__BB2_115
  if (p104) { goto L_BB2_115; }
  // PTX:1563 mul.lo.s64 %rd222, %rd64, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd222) : "l"(rd64));
  // PTX:1564 add.s64 %rd223, %rd6, %rd222
  asm("add.s64 %0, %1, %2;" : "=l"(rd223) : "l"(rd6), "l"(rd222));
  // PTX:1565 add.s64 %rd224, %rd4, %rd222
  asm("add.s64 %0, %1, %2;" : "=l"(rd224) : "l"(rd4), "l"(rd222));
  // PTX:1566 ld.global.f32 %f980, [%rd224]
  f980 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd224) + (0)))));
  // PTX:1567 ld.global.f32 %f981, [%rd223]
  f981 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd223) + (0)))));
  // PTX:1568 sub.f32 %f982, %f981, %f980
  asm("sub.f32 %0, %1, %2;" : "=f"(f982) : "f"(f981), "f"(f980));
  // PTX:1569 ld.global.f32 %f983, [%rd224+4]
  f983 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd224) + (4)))));
  // PTX:1570 ld.global.f32 %f984, [%rd223+4]
  f984 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd223) + (4)))));
  // PTX:1571 sub.f32 %f985, %f984, %f983
  asm("sub.f32 %0, %1, %2;" : "=f"(f985) : "f"(f984), "f"(f983));
  // PTX:1572 ld.global.f32 %f986, [%rd224+8]
  f986 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd224) + (8)))));
  // PTX:1573 ld.global.f32 %f987, [%rd223+8]
  f987 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd223) + (8)))));
  // PTX:1574 sub.f32 %f988, %f987, %f986
  asm("sub.f32 %0, %1, %2;" : "=f"(f988) : "f"(f987), "f"(f986));
  // PTX:1575 mul.f32 %f1604, %f982, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1604) : "f"(f982), "f"(f414));
  // PTX:1576 mul.f32 %f1605, %f985, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1605) : "f"(f985), "f"(f414));
  // PTX:1577 mul.f32 %f1606, %f988, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1606) : "f"(f988), "f"(f414));
  // PTX:1578 bra.uni $L__BB2_116
  goto L_BB2_116;
  // PTX:1580 $L__BB2_115:
L_BB2_115:;
  // PTX:1581 mul.lo.s64 %rd225, %rd64, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd225) : "l"(rd64));
  // PTX:1582 add.s64 %rd226, %rd3, %rd225
  asm("add.s64 %0, %1, %2;" : "=l"(rd226) : "l"(rd3), "l"(rd225));
  // PTX:1583 ld.global.f32 %f1604, [%rd226]
  f1604 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd226) + (0)))));
  // PTX:1584 ld.global.f32 %f1605, [%rd226+4]
  f1605 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd226) + (4)))));
  // PTX:1585 ld.global.f32 %f1606, [%rd226+8]
  f1606 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd226) + (8)))));
  // PTX:1587 $L__BB2_116:
L_BB2_116:;
  // PTX:1588 cvt.s64.s32 %rd65, %r397
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd65) : "r"(r397));
  // PTX:1589 @%p104 bra $L__BB2_118
  if (p104) { goto L_BB2_118; }
  // PTX:1591 mul.lo.s64 %rd227, %rd65, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd227) : "l"(rd65));
  // PTX:1592 add.s64 %rd228, %rd6, %rd227
  asm("add.s64 %0, %1, %2;" : "=l"(rd228) : "l"(rd6), "l"(rd227));
  // PTX:1593 add.s64 %rd229, %rd4, %rd227
  asm("add.s64 %0, %1, %2;" : "=l"(rd229) : "l"(rd4), "l"(rd227));
  // PTX:1594 ld.global.f32 %f989, [%rd229]
  f989 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd229) + (0)))));
  // PTX:1595 ld.global.f32 %f990, [%rd228]
  f990 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd228) + (0)))));
  // PTX:1596 sub.f32 %f991, %f990, %f989
  asm("sub.f32 %0, %1, %2;" : "=f"(f991) : "f"(f990), "f"(f989));
  // PTX:1597 ld.global.f32 %f992, [%rd229+4]
  f992 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd229) + (4)))));
  // PTX:1598 ld.global.f32 %f993, [%rd228+4]
  f993 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd228) + (4)))));
  // PTX:1599 sub.f32 %f994, %f993, %f992
  asm("sub.f32 %0, %1, %2;" : "=f"(f994) : "f"(f993), "f"(f992));
  // PTX:1600 ld.global.f32 %f995, [%rd229+8]
  f995 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd229) + (8)))));
  // PTX:1601 ld.global.f32 %f996, [%rd228+8]
  f996 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd228) + (8)))));
  // PTX:1602 sub.f32 %f997, %f996, %f995
  asm("sub.f32 %0, %1, %2;" : "=f"(f997) : "f"(f996), "f"(f995));
  // PTX:1603 mul.f32 %f1607, %f991, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1607) : "f"(f991), "f"(f414));
  // PTX:1604 mul.f32 %f1608, %f994, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1608) : "f"(f994), "f"(f414));
  // PTX:1605 mul.f32 %f1609, %f997, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1609) : "f"(f997), "f"(f414));
  // PTX:1606 bra.uni $L__BB2_119
  goto L_BB2_119;
  // PTX:1608 $L__BB2_118:
L_BB2_118:;
  // PTX:1609 mul.lo.s64 %rd230, %rd65, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd230) : "l"(rd65));
  // PTX:1610 add.s64 %rd231, %rd3, %rd230
  asm("add.s64 %0, %1, %2;" : "=l"(rd231) : "l"(rd3), "l"(rd230));
  // PTX:1611 ld.global.f32 %f1607, [%rd231]
  f1607 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd231) + (0)))));
  // PTX:1612 ld.global.f32 %f1608, [%rd231+4]
  f1608 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd231) + (4)))));
  // PTX:1613 ld.global.f32 %f1609, [%rd231+8]
  f1609 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd231) + (8)))));
  // PTX:1615 $L__BB2_119:
L_BB2_119:;
  // PTX:1616 cvt.s64.s32 %rd66, %r398
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd66) : "r"(r398));
  // PTX:1617 @%p104 bra $L__BB2_121
  if (p104) { goto L_BB2_121; }
  // PTX:1619 mul.lo.s64 %rd232, %rd66, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd232) : "l"(rd66));
  // PTX:1620 add.s64 %rd233, %rd6, %rd232
  asm("add.s64 %0, %1, %2;" : "=l"(rd233) : "l"(rd6), "l"(rd232));
  // PTX:1621 add.s64 %rd234, %rd4, %rd232
  asm("add.s64 %0, %1, %2;" : "=l"(rd234) : "l"(rd4), "l"(rd232));
  // PTX:1622 ld.global.f32 %f998, [%rd234]
  f998 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd234) + (0)))));
  // PTX:1623 ld.global.f32 %f999, [%rd233]
  f999 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd233) + (0)))));
  // PTX:1624 sub.f32 %f1000, %f999, %f998
  asm("sub.f32 %0, %1, %2;" : "=f"(f1000) : "f"(f999), "f"(f998));
  // PTX:1625 ld.global.f32 %f1001, [%rd234+4]
  f1001 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd234) + (4)))));
  // PTX:1626 ld.global.f32 %f1002, [%rd233+4]
  f1002 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd233) + (4)))));
  // PTX:1627 sub.f32 %f1003, %f1002, %f1001
  asm("sub.f32 %0, %1, %2;" : "=f"(f1003) : "f"(f1002), "f"(f1001));
  // PTX:1628 ld.global.f32 %f1004, [%rd234+8]
  f1004 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd234) + (8)))));
  // PTX:1629 ld.global.f32 %f1005, [%rd233+8]
  f1005 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd233) + (8)))));
  // PTX:1630 sub.f32 %f1006, %f1005, %f1004
  asm("sub.f32 %0, %1, %2;" : "=f"(f1006) : "f"(f1005), "f"(f1004));
  // PTX:1631 mul.f32 %f1610, %f1000, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1610) : "f"(f1000), "f"(f414));
  // PTX:1632 mul.f32 %f1611, %f1003, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1611) : "f"(f1003), "f"(f414));
  // PTX:1633 mul.f32 %f1612, %f1006, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1612) : "f"(f1006), "f"(f414));
  // PTX:1634 bra.uni $L__BB2_122
  goto L_BB2_122;
  // PTX:1636 $L__BB2_121:
L_BB2_121:;
  // PTX:1637 mul.lo.s64 %rd235, %rd66, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd235) : "l"(rd66));
  // PTX:1638 add.s64 %rd236, %rd3, %rd235
  asm("add.s64 %0, %1, %2;" : "=l"(rd236) : "l"(rd3), "l"(rd235));
  // PTX:1639 ld.global.f32 %f1610, [%rd236]
  f1610 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd236) + (0)))));
  // PTX:1640 ld.global.f32 %f1611, [%rd236+4]
  f1611 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd236) + (4)))));
  // PTX:1641 ld.global.f32 %f1612, [%rd236+8]
  f1612 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd236) + (8)))));
  // PTX:1643 $L__BB2_122:
L_BB2_122:;
  // PTX:1644 mov.b32 %f1007, %r37
  asm("mov.b32 %0, %1;" : "=f"(f1007) : "r"(r37));
  // PTX:1645 sub.f32 %f1008, %f1007, %f191
  asm("sub.f32 %0, %1, %2;" : "=f"(f1008) : "f"(f1007), "f"(f191));
  // PTX:1646 mov.b32 %f1009, %r38
  asm("mov.b32 %0, %1;" : "=f"(f1009) : "r"(r38));
  // PTX:1647 sub.f32 %f1010, %f1009, %f192
  asm("sub.f32 %0, %1, %2;" : "=f"(f1010) : "f"(f1009), "f"(f192));
  // PTX:1648 mov.b32 %f1011, %r39
  asm("mov.b32 %0, %1;" : "=f"(f1011) : "r"(r39));
  // PTX:1649 sub.f32 %f1012, %f1011, %f193
  asm("sub.f32 %0, %1, %2;" : "=f"(f1012) : "f"(f1011), "f"(f193));
  // PTX:1650 fma.rn.f32 %f1013, %f1008, %f1604, %f1601
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1013) : "f"(f1008), "f"(f1604), "f"(f1601));
  // PTX:1651 fma.rn.f32 %f1014, %f1008, %f1605, %f1602
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1014) : "f"(f1008), "f"(f1605), "f"(f1602));
  // PTX:1652 fma.rn.f32 %f1015, %f1008, %f1606, %f1603
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1015) : "f"(f1008), "f"(f1606), "f"(f1603));
  // PTX:1653 fma.rn.f32 %f1016, %f1010, %f1607, %f1013
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1016) : "f"(f1010), "f"(f1607), "f"(f1013));
  // PTX:1654 fma.rn.f32 %f1017, %f1010, %f1608, %f1014
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1017) : "f"(f1010), "f"(f1608), "f"(f1014));
  // PTX:1655 fma.rn.f32 %f1018, %f1010, %f1609, %f1015
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1018) : "f"(f1010), "f"(f1609), "f"(f1015));
  // PTX:1656 fma.rn.f32 %f1615, %f1012, %f1610, %f1016
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1615) : "f"(f1012), "f"(f1610), "f"(f1016));
  // PTX:1657 fma.rn.f32 %f1614, %f1012, %f1611, %f1017
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1614) : "f"(f1012), "f"(f1611), "f"(f1017));
  // PTX:1658 fma.rn.f32 %f1613, %f1012, %f1612, %f1018
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1613) : "f"(f1012), "f"(f1612), "f"(f1018));
  // PTX:1660 $L__BB2_123:
L_BB2_123:;
  // PTX:1661 mov.f32 %f1629, %f1628
  asm("mov.f32 %0, %1;" : "=f"(f1629) : "f"(f1628));
  // PTX:1662 mov.f32 %f1630, %f1628
  asm("mov.f32 %0, %1;" : "=f"(f1630) : "f"(f1628));
  // PTX:1663 @%p29 bra $L__BB2_137
  if (p29) { goto L_BB2_137; }
  // PTX:1665 ld.param.u64 %rd458, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_30]
  rd458 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param30 + (0))));
  // PTX:1666 ld.global.f32 %f236, [%rd60]
  f236 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:1667 ld.global.f32 %f237, [%rd60+4]
  f237 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:1668 ld.global.f32 %f238, [%rd60+8]
  f238 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:1669 cvt.s64.s32 %rd67, %r399
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd67) : "r"(r399));
  // PTX:1670 setp.eq.s64 %p109, %rd458, 0
  p109 = (((long long)(rd458)) == ((long long)(0)));
  // PTX:1671 @%p109 bra $L__BB2_126
  if (p109) { goto L_BB2_126; }
  // PTX:1673 mul.lo.s64 %rd237, %rd67, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd237) : "l"(rd67));
  // PTX:1674 add.s64 %rd238, %rd6, %rd237
  asm("add.s64 %0, %1, %2;" : "=l"(rd238) : "l"(rd6), "l"(rd237));
  // PTX:1675 add.s64 %rd239, %rd4, %rd237
  asm("add.s64 %0, %1, %2;" : "=l"(rd239) : "l"(rd4), "l"(rd237));
  // PTX:1676 ld.global.f32 %f1022, [%rd239]
  f1022 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd239) + (0)))));
  // PTX:1677 ld.global.f32 %f1023, [%rd238]
  f1023 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd238) + (0)))));
  // PTX:1678 sub.f32 %f1024, %f1023, %f1022
  asm("sub.f32 %0, %1, %2;" : "=f"(f1024) : "f"(f1023), "f"(f1022));
  // PTX:1679 ld.global.f32 %f1025, [%rd239+4]
  f1025 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd239) + (4)))));
  // PTX:1680 ld.global.f32 %f1026, [%rd238+4]
  f1026 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd238) + (4)))));
  // PTX:1681 sub.f32 %f1027, %f1026, %f1025
  asm("sub.f32 %0, %1, %2;" : "=f"(f1027) : "f"(f1026), "f"(f1025));
  // PTX:1682 ld.global.f32 %f1028, [%rd239+8]
  f1028 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd239) + (8)))));
  // PTX:1683 ld.global.f32 %f1029, [%rd238+8]
  f1029 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd238) + (8)))));
  // PTX:1684 sub.f32 %f1030, %f1029, %f1028
  asm("sub.f32 %0, %1, %2;" : "=f"(f1030) : "f"(f1029), "f"(f1028));
  // PTX:1685 mul.f32 %f1616, %f1024, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1616) : "f"(f1024), "f"(f414));
  // PTX:1686 mul.f32 %f1617, %f1027, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1617) : "f"(f1027), "f"(f414));
  // PTX:1687 mul.f32 %f1618, %f1030, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1618) : "f"(f1030), "f"(f414));
  // PTX:1688 bra.uni $L__BB2_127
  goto L_BB2_127;
  // PTX:1690 $L__BB2_126:
L_BB2_126:;
  // PTX:1691 mul.lo.s64 %rd240, %rd67, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd240) : "l"(rd67));
  // PTX:1692 add.s64 %rd241, %rd3, %rd240
  asm("add.s64 %0, %1, %2;" : "=l"(rd241) : "l"(rd3), "l"(rd240));
  // PTX:1693 ld.global.f32 %f1616, [%rd241]
  f1616 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd241) + (0)))));
  // PTX:1694 ld.global.f32 %f1617, [%rd241+4]
  f1617 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd241) + (4)))));
  // PTX:1695 ld.global.f32 %f1618, [%rd241+8]
  f1618 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd241) + (8)))));
  // PTX:1697 $L__BB2_127:
L_BB2_127:;
  // PTX:1698 cvt.s64.s32 %rd68, %r400
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd68) : "r"(r400));
  // PTX:1699 @%p109 bra $L__BB2_129
  if (p109) { goto L_BB2_129; }
  // PTX:1701 mul.lo.s64 %rd242, %rd68, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd242) : "l"(rd68));
  // PTX:1702 add.s64 %rd243, %rd6, %rd242
  asm("add.s64 %0, %1, %2;" : "=l"(rd243) : "l"(rd6), "l"(rd242));
  // PTX:1703 add.s64 %rd244, %rd4, %rd242
  asm("add.s64 %0, %1, %2;" : "=l"(rd244) : "l"(rd4), "l"(rd242));
  // PTX:1704 ld.global.f32 %f1031, [%rd244]
  f1031 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd244) + (0)))));
  // PTX:1705 ld.global.f32 %f1032, [%rd243]
  f1032 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd243) + (0)))));
  // PTX:1706 sub.f32 %f1033, %f1032, %f1031
  asm("sub.f32 %0, %1, %2;" : "=f"(f1033) : "f"(f1032), "f"(f1031));
  // PTX:1707 ld.global.f32 %f1034, [%rd244+4]
  f1034 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd244) + (4)))));
  // PTX:1708 ld.global.f32 %f1035, [%rd243+4]
  f1035 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd243) + (4)))));
  // PTX:1709 sub.f32 %f1036, %f1035, %f1034
  asm("sub.f32 %0, %1, %2;" : "=f"(f1036) : "f"(f1035), "f"(f1034));
  // PTX:1710 ld.global.f32 %f1037, [%rd244+8]
  f1037 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd244) + (8)))));
  // PTX:1711 ld.global.f32 %f1038, [%rd243+8]
  f1038 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd243) + (8)))));
  // PTX:1712 sub.f32 %f1039, %f1038, %f1037
  asm("sub.f32 %0, %1, %2;" : "=f"(f1039) : "f"(f1038), "f"(f1037));
  // PTX:1713 mul.f32 %f1619, %f1033, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1619) : "f"(f1033), "f"(f414));
  // PTX:1714 mul.f32 %f1620, %f1036, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1620) : "f"(f1036), "f"(f414));
  // PTX:1715 mul.f32 %f1621, %f1039, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1621) : "f"(f1039), "f"(f414));
  // PTX:1716 bra.uni $L__BB2_130
  goto L_BB2_130;
  // PTX:1718 $L__BB2_129:
L_BB2_129:;
  // PTX:1719 mul.lo.s64 %rd245, %rd68, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd245) : "l"(rd68));
  // PTX:1720 add.s64 %rd246, %rd3, %rd245
  asm("add.s64 %0, %1, %2;" : "=l"(rd246) : "l"(rd3), "l"(rd245));
  // PTX:1721 ld.global.f32 %f1619, [%rd246]
  f1619 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd246) + (0)))));
  // PTX:1722 ld.global.f32 %f1620, [%rd246+4]
  f1620 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd246) + (4)))));
  // PTX:1723 ld.global.f32 %f1621, [%rd246+8]
  f1621 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd246) + (8)))));
  // PTX:1725 $L__BB2_130:
L_BB2_130:;
  // PTX:1726 cvt.s64.s32 %rd69, %r401
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd69) : "r"(r401));
  // PTX:1727 @%p109 bra $L__BB2_132
  if (p109) { goto L_BB2_132; }
  // PTX:1729 mul.lo.s64 %rd247, %rd69, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd247) : "l"(rd69));
  // PTX:1730 add.s64 %rd248, %rd6, %rd247
  asm("add.s64 %0, %1, %2;" : "=l"(rd248) : "l"(rd6), "l"(rd247));
  // PTX:1731 add.s64 %rd249, %rd4, %rd247
  asm("add.s64 %0, %1, %2;" : "=l"(rd249) : "l"(rd4), "l"(rd247));
  // PTX:1732 ld.global.f32 %f1040, [%rd249]
  f1040 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd249) + (0)))));
  // PTX:1733 ld.global.f32 %f1041, [%rd248]
  f1041 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd248) + (0)))));
  // PTX:1734 sub.f32 %f1042, %f1041, %f1040
  asm("sub.f32 %0, %1, %2;" : "=f"(f1042) : "f"(f1041), "f"(f1040));
  // PTX:1735 ld.global.f32 %f1043, [%rd249+4]
  f1043 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd249) + (4)))));
  // PTX:1736 ld.global.f32 %f1044, [%rd248+4]
  f1044 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd248) + (4)))));
  // PTX:1737 sub.f32 %f1045, %f1044, %f1043
  asm("sub.f32 %0, %1, %2;" : "=f"(f1045) : "f"(f1044), "f"(f1043));
  // PTX:1738 ld.global.f32 %f1046, [%rd249+8]
  f1046 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd249) + (8)))));
  // PTX:1739 ld.global.f32 %f1047, [%rd248+8]
  f1047 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd248) + (8)))));
  // PTX:1740 sub.f32 %f1048, %f1047, %f1046
  asm("sub.f32 %0, %1, %2;" : "=f"(f1048) : "f"(f1047), "f"(f1046));
  // PTX:1741 mul.f32 %f1622, %f1042, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1622) : "f"(f1042), "f"(f414));
  // PTX:1742 mul.f32 %f1623, %f1045, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1623) : "f"(f1045), "f"(f414));
  // PTX:1743 mul.f32 %f1624, %f1048, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1624) : "f"(f1048), "f"(f414));
  // PTX:1744 bra.uni $L__BB2_133
  goto L_BB2_133;
  // PTX:1746 $L__BB2_132:
L_BB2_132:;
  // PTX:1747 mul.lo.s64 %rd250, %rd69, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd250) : "l"(rd69));
  // PTX:1748 add.s64 %rd251, %rd3, %rd250
  asm("add.s64 %0, %1, %2;" : "=l"(rd251) : "l"(rd3), "l"(rd250));
  // PTX:1749 ld.global.f32 %f1622, [%rd251]
  f1622 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd251) + (0)))));
  // PTX:1750 ld.global.f32 %f1623, [%rd251+4]
  f1623 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd251) + (4)))));
  // PTX:1751 ld.global.f32 %f1624, [%rd251+8]
  f1624 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd251) + (8)))));
  // PTX:1753 $L__BB2_133:
L_BB2_133:;
  // PTX:1754 cvt.s64.s32 %rd70, %r402
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd70) : "r"(r402));
  // PTX:1755 @%p109 bra $L__BB2_135
  if (p109) { goto L_BB2_135; }
  // PTX:1757 mul.lo.s64 %rd252, %rd70, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd252) : "l"(rd70));
  // PTX:1758 add.s64 %rd253, %rd6, %rd252
  asm("add.s64 %0, %1, %2;" : "=l"(rd253) : "l"(rd6), "l"(rd252));
  // PTX:1759 add.s64 %rd254, %rd4, %rd252
  asm("add.s64 %0, %1, %2;" : "=l"(rd254) : "l"(rd4), "l"(rd252));
  // PTX:1760 ld.global.f32 %f1049, [%rd254]
  f1049 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd254) + (0)))));
  // PTX:1761 ld.global.f32 %f1050, [%rd253]
  f1050 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd253) + (0)))));
  // PTX:1762 sub.f32 %f1051, %f1050, %f1049
  asm("sub.f32 %0, %1, %2;" : "=f"(f1051) : "f"(f1050), "f"(f1049));
  // PTX:1763 ld.global.f32 %f1052, [%rd254+4]
  f1052 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd254) + (4)))));
  // PTX:1764 ld.global.f32 %f1053, [%rd253+4]
  f1053 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd253) + (4)))));
  // PTX:1765 sub.f32 %f1054, %f1053, %f1052
  asm("sub.f32 %0, %1, %2;" : "=f"(f1054) : "f"(f1053), "f"(f1052));
  // PTX:1766 ld.global.f32 %f1055, [%rd254+8]
  f1055 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd254) + (8)))));
  // PTX:1767 ld.global.f32 %f1056, [%rd253+8]
  f1056 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd253) + (8)))));
  // PTX:1768 sub.f32 %f1057, %f1056, %f1055
  asm("sub.f32 %0, %1, %2;" : "=f"(f1057) : "f"(f1056), "f"(f1055));
  // PTX:1769 mul.f32 %f1625, %f1051, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1625) : "f"(f1051), "f"(f414));
  // PTX:1770 mul.f32 %f1626, %f1054, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1626) : "f"(f1054), "f"(f414));
  // PTX:1771 mul.f32 %f1627, %f1057, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1627) : "f"(f1057), "f"(f414));
  // PTX:1772 bra.uni $L__BB2_136
  goto L_BB2_136;
  // PTX:1774 $L__BB2_135:
L_BB2_135:;
  // PTX:1775 mul.lo.s64 %rd255, %rd70, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd255) : "l"(rd70));
  // PTX:1776 add.s64 %rd256, %rd3, %rd255
  asm("add.s64 %0, %1, %2;" : "=l"(rd256) : "l"(rd3), "l"(rd255));
  // PTX:1777 ld.global.f32 %f1625, [%rd256]
  f1625 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (0)))));
  // PTX:1778 ld.global.f32 %f1626, [%rd256+4]
  f1626 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (4)))));
  // PTX:1779 ld.global.f32 %f1627, [%rd256+8]
  f1627 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (8)))));
  // PTX:1781 $L__BB2_136:
L_BB2_136:;
  // PTX:1782 mov.b32 %f1058, %r40
  asm("mov.b32 %0, %1;" : "=f"(f1058) : "r"(r40));
  // PTX:1783 sub.f32 %f1059, %f1058, %f236
  asm("sub.f32 %0, %1, %2;" : "=f"(f1059) : "f"(f1058), "f"(f236));
  // PTX:1784 mov.b32 %f1060, %r41
  asm("mov.b32 %0, %1;" : "=f"(f1060) : "r"(r41));
  // PTX:1785 sub.f32 %f1061, %f1060, %f237
  asm("sub.f32 %0, %1, %2;" : "=f"(f1061) : "f"(f1060), "f"(f237));
  // PTX:1786 mov.b32 %f1062, %r42
  asm("mov.b32 %0, %1;" : "=f"(f1062) : "r"(r42));
  // PTX:1787 sub.f32 %f1063, %f1062, %f238
  asm("sub.f32 %0, %1, %2;" : "=f"(f1063) : "f"(f1062), "f"(f238));
  // PTX:1788 fma.rn.f32 %f1064, %f1059, %f1619, %f1616
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1064) : "f"(f1059), "f"(f1619), "f"(f1616));
  // PTX:1789 fma.rn.f32 %f1065, %f1059, %f1620, %f1617
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1065) : "f"(f1059), "f"(f1620), "f"(f1617));
  // PTX:1790 fma.rn.f32 %f1066, %f1059, %f1621, %f1618
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1066) : "f"(f1059), "f"(f1621), "f"(f1618));
  // PTX:1791 fma.rn.f32 %f1067, %f1061, %f1622, %f1064
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1067) : "f"(f1061), "f"(f1622), "f"(f1064));
  // PTX:1792 fma.rn.f32 %f1068, %f1061, %f1623, %f1065
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1068) : "f"(f1061), "f"(f1623), "f"(f1065));
  // PTX:1793 fma.rn.f32 %f1069, %f1061, %f1624, %f1066
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1069) : "f"(f1061), "f"(f1624), "f"(f1066));
  // PTX:1794 fma.rn.f32 %f1630, %f1063, %f1625, %f1067
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1630) : "f"(f1063), "f"(f1625), "f"(f1067));
  // PTX:1795 fma.rn.f32 %f1629, %f1063, %f1626, %f1068
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1629) : "f"(f1063), "f"(f1626), "f"(f1068));
  // PTX:1796 fma.rn.f32 %f1628, %f1063, %f1627, %f1069
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1628) : "f"(f1063), "f"(f1627), "f"(f1069));
  // PTX:1798 $L__BB2_137:
L_BB2_137:;
  // PTX:1799 mov.f32 %f1658, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1658) : );
  // PTX:1800 mov.f32 %f1643, %f1658
  asm("mov.f32 %0, %1;" : "=f"(f1643) : "f"(f1658));
  // PTX:1801 mov.f32 %f1644, %f1658
  asm("mov.f32 %0, %1;" : "=f"(f1644) : "f"(f1658));
  // PTX:1802 mov.f32 %f1645, %f1658
  asm("mov.f32 %0, %1;" : "=f"(f1645) : "f"(f1658));
  // PTX:1803 @%p26 bra $L__BB2_151
  if (p26) { goto L_BB2_151; }
  // PTX:1805 ld.param.u64 %rd459, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_30]
  rd459 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param30 + (0))));
  // PTX:1806 ld.global.f32 %f281, [%rd59]
  f281 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:1807 ld.global.f32 %f282, [%rd59+4]
  f282 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4)))));
  // PTX:1808 ld.global.f32 %f283, [%rd59+8]
  f283 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8)))));
  // PTX:1809 cvt.s64.s32 %rd71, %r395
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd71) : "r"(r395));
  // PTX:1810 setp.eq.s64 %p114, %rd459, 0
  p114 = (((long long)(rd459)) == ((long long)(0)));
  // PTX:1811 @%p114 bra $L__BB2_140
  if (p114) { goto L_BB2_140; }
  // PTX:1813 mul.lo.s64 %rd257, %rd71, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd257) : "l"(rd71));
  // PTX:1814 add.s64 %rd258, %rd6, %rd257
  asm("add.s64 %0, %1, %2;" : "=l"(rd258) : "l"(rd6), "l"(rd257));
  // PTX:1815 add.s64 %rd259, %rd4, %rd257
  asm("add.s64 %0, %1, %2;" : "=l"(rd259) : "l"(rd4), "l"(rd257));
  // PTX:1816 ld.global.f32 %f1073, [%rd259]
  f1073 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd259) + (0)))));
  // PTX:1817 ld.global.f32 %f1074, [%rd258]
  f1074 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd258) + (0)))));
  // PTX:1818 sub.f32 %f1075, %f1074, %f1073
  asm("sub.f32 %0, %1, %2;" : "=f"(f1075) : "f"(f1074), "f"(f1073));
  // PTX:1819 ld.global.f32 %f1076, [%rd259+4]
  f1076 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd259) + (4)))));
  // PTX:1820 ld.global.f32 %f1077, [%rd258+4]
  f1077 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd258) + (4)))));
  // PTX:1821 sub.f32 %f1078, %f1077, %f1076
  asm("sub.f32 %0, %1, %2;" : "=f"(f1078) : "f"(f1077), "f"(f1076));
  // PTX:1822 ld.global.f32 %f1079, [%rd259+8]
  f1079 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd259) + (8)))));
  // PTX:1823 ld.global.f32 %f1080, [%rd258+8]
  f1080 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd258) + (8)))));
  // PTX:1824 sub.f32 %f1081, %f1080, %f1079
  asm("sub.f32 %0, %1, %2;" : "=f"(f1081) : "f"(f1080), "f"(f1079));
  // PTX:1825 mul.f32 %f1631, %f1075, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1631) : "f"(f1075), "f"(f414));
  // PTX:1826 mul.f32 %f1632, %f1078, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1632) : "f"(f1078), "f"(f414));
  // PTX:1827 mul.f32 %f1633, %f1081, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1633) : "f"(f1081), "f"(f414));
  // PTX:1828 bra.uni $L__BB2_141
  goto L_BB2_141;
  // PTX:1830 $L__BB2_140:
L_BB2_140:;
  // PTX:1831 mul.lo.s64 %rd260, %rd71, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd260) : "l"(rd71));
  // PTX:1832 add.s64 %rd261, %rd3, %rd260
  asm("add.s64 %0, %1, %2;" : "=l"(rd261) : "l"(rd3), "l"(rd260));
  // PTX:1833 ld.global.f32 %f1631, [%rd261]
  f1631 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd261) + (0)))));
  // PTX:1834 ld.global.f32 %f1632, [%rd261+4]
  f1632 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd261) + (4)))));
  // PTX:1835 ld.global.f32 %f1633, [%rd261+8]
  f1633 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd261) + (8)))));
  // PTX:1837 $L__BB2_141:
L_BB2_141:;
  // PTX:1838 cvt.s64.s32 %rd72, %r396
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd72) : "r"(r396));
  // PTX:1839 @%p114 bra $L__BB2_143
  if (p114) { goto L_BB2_143; }
  // PTX:1841 mul.lo.s64 %rd262, %rd72, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd262) : "l"(rd72));
  // PTX:1842 add.s64 %rd263, %rd6, %rd262
  asm("add.s64 %0, %1, %2;" : "=l"(rd263) : "l"(rd6), "l"(rd262));
  // PTX:1843 add.s64 %rd264, %rd4, %rd262
  asm("add.s64 %0, %1, %2;" : "=l"(rd264) : "l"(rd4), "l"(rd262));
  // PTX:1844 ld.global.f32 %f1082, [%rd264]
  f1082 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd264) + (0)))));
  // PTX:1845 ld.global.f32 %f1083, [%rd263]
  f1083 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd263) + (0)))));
  // PTX:1846 sub.f32 %f1084, %f1083, %f1082
  asm("sub.f32 %0, %1, %2;" : "=f"(f1084) : "f"(f1083), "f"(f1082));
  // PTX:1847 ld.global.f32 %f1085, [%rd264+4]
  f1085 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd264) + (4)))));
  // PTX:1848 ld.global.f32 %f1086, [%rd263+4]
  f1086 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd263) + (4)))));
  // PTX:1849 sub.f32 %f1087, %f1086, %f1085
  asm("sub.f32 %0, %1, %2;" : "=f"(f1087) : "f"(f1086), "f"(f1085));
  // PTX:1850 ld.global.f32 %f1088, [%rd264+8]
  f1088 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd264) + (8)))));
  // PTX:1851 ld.global.f32 %f1089, [%rd263+8]
  f1089 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd263) + (8)))));
  // PTX:1852 sub.f32 %f1090, %f1089, %f1088
  asm("sub.f32 %0, %1, %2;" : "=f"(f1090) : "f"(f1089), "f"(f1088));
  // PTX:1853 mul.f32 %f1634, %f1084, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1634) : "f"(f1084), "f"(f414));
  // PTX:1854 mul.f32 %f1635, %f1087, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1635) : "f"(f1087), "f"(f414));
  // PTX:1855 mul.f32 %f1636, %f1090, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1636) : "f"(f1090), "f"(f414));
  // PTX:1856 bra.uni $L__BB2_144
  goto L_BB2_144;
  // PTX:1858 $L__BB2_143:
L_BB2_143:;
  // PTX:1859 mul.lo.s64 %rd265, %rd72, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd265) : "l"(rd72));
  // PTX:1860 add.s64 %rd266, %rd3, %rd265
  asm("add.s64 %0, %1, %2;" : "=l"(rd266) : "l"(rd3), "l"(rd265));
  // PTX:1861 ld.global.f32 %f1634, [%rd266]
  f1634 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd266) + (0)))));
  // PTX:1862 ld.global.f32 %f1635, [%rd266+4]
  f1635 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd266) + (4)))));
  // PTX:1863 ld.global.f32 %f1636, [%rd266+8]
  f1636 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd266) + (8)))));
  // PTX:1865 $L__BB2_144:
L_BB2_144:;
  // PTX:1866 cvt.s64.s32 %rd73, %r397
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd73) : "r"(r397));
  // PTX:1867 @%p114 bra $L__BB2_146
  if (p114) { goto L_BB2_146; }
  // PTX:1869 mul.lo.s64 %rd267, %rd73, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd267) : "l"(rd73));
  // PTX:1870 add.s64 %rd268, %rd6, %rd267
  asm("add.s64 %0, %1, %2;" : "=l"(rd268) : "l"(rd6), "l"(rd267));
  // PTX:1871 add.s64 %rd269, %rd4, %rd267
  asm("add.s64 %0, %1, %2;" : "=l"(rd269) : "l"(rd4), "l"(rd267));
  // PTX:1872 ld.global.f32 %f1091, [%rd269]
  f1091 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd269) + (0)))));
  // PTX:1873 ld.global.f32 %f1092, [%rd268]
  f1092 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd268) + (0)))));
  // PTX:1874 sub.f32 %f1093, %f1092, %f1091
  asm("sub.f32 %0, %1, %2;" : "=f"(f1093) : "f"(f1092), "f"(f1091));
  // PTX:1875 ld.global.f32 %f1094, [%rd269+4]
  f1094 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd269) + (4)))));
  // PTX:1876 ld.global.f32 %f1095, [%rd268+4]
  f1095 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd268) + (4)))));
  // PTX:1877 sub.f32 %f1096, %f1095, %f1094
  asm("sub.f32 %0, %1, %2;" : "=f"(f1096) : "f"(f1095), "f"(f1094));
  // PTX:1878 ld.global.f32 %f1097, [%rd269+8]
  f1097 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd269) + (8)))));
  // PTX:1879 ld.global.f32 %f1098, [%rd268+8]
  f1098 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd268) + (8)))));
  // PTX:1880 sub.f32 %f1099, %f1098, %f1097
  asm("sub.f32 %0, %1, %2;" : "=f"(f1099) : "f"(f1098), "f"(f1097));
  // PTX:1881 mul.f32 %f1637, %f1093, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1637) : "f"(f1093), "f"(f414));
  // PTX:1882 mul.f32 %f1638, %f1096, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1638) : "f"(f1096), "f"(f414));
  // PTX:1883 mul.f32 %f1639, %f1099, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1639) : "f"(f1099), "f"(f414));
  // PTX:1884 bra.uni $L__BB2_147
  goto L_BB2_147;
  // PTX:1886 $L__BB2_146:
L_BB2_146:;
  // PTX:1887 mul.lo.s64 %rd270, %rd73, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd270) : "l"(rd73));
  // PTX:1888 add.s64 %rd271, %rd3, %rd270
  asm("add.s64 %0, %1, %2;" : "=l"(rd271) : "l"(rd3), "l"(rd270));
  // PTX:1889 ld.global.f32 %f1637, [%rd271]
  f1637 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd271) + (0)))));
  // PTX:1890 ld.global.f32 %f1638, [%rd271+4]
  f1638 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd271) + (4)))));
  // PTX:1891 ld.global.f32 %f1639, [%rd271+8]
  f1639 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd271) + (8)))));
  // PTX:1893 $L__BB2_147:
L_BB2_147:;
  // PTX:1894 cvt.s64.s32 %rd74, %r398
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd74) : "r"(r398));
  // PTX:1895 @%p114 bra $L__BB2_149
  if (p114) { goto L_BB2_149; }
  // PTX:1897 mul.lo.s64 %rd272, %rd74, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd272) : "l"(rd74));
  // PTX:1898 add.s64 %rd273, %rd6, %rd272
  asm("add.s64 %0, %1, %2;" : "=l"(rd273) : "l"(rd6), "l"(rd272));
  // PTX:1899 add.s64 %rd274, %rd4, %rd272
  asm("add.s64 %0, %1, %2;" : "=l"(rd274) : "l"(rd4), "l"(rd272));
  // PTX:1900 ld.global.f32 %f1100, [%rd274]
  f1100 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd274) + (0)))));
  // PTX:1901 ld.global.f32 %f1101, [%rd273]
  f1101 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd273) + (0)))));
  // PTX:1902 sub.f32 %f1102, %f1101, %f1100
  asm("sub.f32 %0, %1, %2;" : "=f"(f1102) : "f"(f1101), "f"(f1100));
  // PTX:1903 ld.global.f32 %f1103, [%rd274+4]
  f1103 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd274) + (4)))));
  // PTX:1904 ld.global.f32 %f1104, [%rd273+4]
  f1104 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd273) + (4)))));
  // PTX:1905 sub.f32 %f1105, %f1104, %f1103
  asm("sub.f32 %0, %1, %2;" : "=f"(f1105) : "f"(f1104), "f"(f1103));
  // PTX:1906 ld.global.f32 %f1106, [%rd274+8]
  f1106 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd274) + (8)))));
  // PTX:1907 ld.global.f32 %f1107, [%rd273+8]
  f1107 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd273) + (8)))));
  // PTX:1908 sub.f32 %f1108, %f1107, %f1106
  asm("sub.f32 %0, %1, %2;" : "=f"(f1108) : "f"(f1107), "f"(f1106));
  // PTX:1909 mul.f32 %f1640, %f1102, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1640) : "f"(f1102), "f"(f414));
  // PTX:1910 mul.f32 %f1641, %f1105, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1641) : "f"(f1105), "f"(f414));
  // PTX:1911 mul.f32 %f1642, %f1108, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1642) : "f"(f1108), "f"(f414));
  // PTX:1912 bra.uni $L__BB2_150
  goto L_BB2_150;
  // PTX:1914 $L__BB2_149:
L_BB2_149:;
  // PTX:1915 mul.lo.s64 %rd275, %rd74, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd275) : "l"(rd74));
  // PTX:1916 add.s64 %rd276, %rd3, %rd275
  asm("add.s64 %0, %1, %2;" : "=l"(rd276) : "l"(rd3), "l"(rd275));
  // PTX:1917 ld.global.f32 %f1640, [%rd276]
  f1640 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd276) + (0)))));
  // PTX:1918 ld.global.f32 %f1641, [%rd276+4]
  f1641 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd276) + (4)))));
  // PTX:1919 ld.global.f32 %f1642, [%rd276+8]
  f1642 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd276) + (8)))));
  // PTX:1921 $L__BB2_150:
L_BB2_150:;
  // PTX:1922 mov.b32 %f1109, %r448
  asm("mov.b32 %0, %1;" : "=f"(f1109) : "r"(r448));
  // PTX:1923 sub.f32 %f1110, %f1109, %f281
  asm("sub.f32 %0, %1, %2;" : "=f"(f1110) : "f"(f1109), "f"(f281));
  // PTX:1924 mov.b32 %f1111, %r447
  asm("mov.b32 %0, %1;" : "=f"(f1111) : "r"(r447));
  // PTX:1925 sub.f32 %f1112, %f1111, %f282
  asm("sub.f32 %0, %1, %2;" : "=f"(f1112) : "f"(f1111), "f"(f282));
  // PTX:1926 mov.b32 %f1113, %r446
  asm("mov.b32 %0, %1;" : "=f"(f1113) : "r"(r446));
  // PTX:1927 sub.f32 %f1114, %f1113, %f283
  asm("sub.f32 %0, %1, %2;" : "=f"(f1114) : "f"(f1113), "f"(f283));
  // PTX:1928 fma.rn.f32 %f1115, %f1110, %f1634, %f1631
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1115) : "f"(f1110), "f"(f1634), "f"(f1631));
  // PTX:1929 fma.rn.f32 %f1116, %f1110, %f1635, %f1632
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1116) : "f"(f1110), "f"(f1635), "f"(f1632));
  // PTX:1930 fma.rn.f32 %f1117, %f1110, %f1636, %f1633
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1117) : "f"(f1110), "f"(f1636), "f"(f1633));
  // PTX:1931 fma.rn.f32 %f1118, %f1112, %f1637, %f1115
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1118) : "f"(f1112), "f"(f1637), "f"(f1115));
  // PTX:1932 fma.rn.f32 %f1119, %f1112, %f1638, %f1116
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1119) : "f"(f1112), "f"(f1638), "f"(f1116));
  // PTX:1933 fma.rn.f32 %f1120, %f1112, %f1639, %f1117
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1120) : "f"(f1112), "f"(f1639), "f"(f1117));
  // PTX:1934 fma.rn.f32 %f1645, %f1114, %f1640, %f1118
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1645) : "f"(f1114), "f"(f1640), "f"(f1118));
  // PTX:1935 fma.rn.f32 %f1644, %f1114, %f1641, %f1119
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1644) : "f"(f1114), "f"(f1641), "f"(f1119));
  // PTX:1936 fma.rn.f32 %f1643, %f1114, %f1642, %f1120
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1643) : "f"(f1114), "f"(f1642), "f"(f1120));
  // PTX:1938 $L__BB2_151:
L_BB2_151:;
  // PTX:1939 mov.f32 %f1659, %f1658
  asm("mov.f32 %0, %1;" : "=f"(f1659) : "f"(f1658));
  // PTX:1940 mov.f32 %f1660, %f1658
  asm("mov.f32 %0, %1;" : "=f"(f1660) : "f"(f1658));
  // PTX:1941 @%p29 bra $L__BB2_165
  if (p29) { goto L_BB2_165; }
  // PTX:1943 ld.param.u64 %rd460, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_30]
  rd460 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param30 + (0))));
  // PTX:1944 ld.global.f32 %f326, [%rd60]
  f326 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:1945 ld.global.f32 %f327, [%rd60+4]
  f327 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:1946 ld.global.f32 %f328, [%rd60+8]
  f328 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:1947 cvt.s64.s32 %rd75, %r399
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd75) : "r"(r399));
  // PTX:1948 setp.eq.s64 %p119, %rd460, 0
  p119 = (((long long)(rd460)) == ((long long)(0)));
  // PTX:1949 @%p119 bra $L__BB2_154
  if (p119) { goto L_BB2_154; }
  // PTX:1951 mul.lo.s64 %rd277, %rd75, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd277) : "l"(rd75));
  // PTX:1952 add.s64 %rd278, %rd6, %rd277
  asm("add.s64 %0, %1, %2;" : "=l"(rd278) : "l"(rd6), "l"(rd277));
  // PTX:1953 add.s64 %rd279, %rd4, %rd277
  asm("add.s64 %0, %1, %2;" : "=l"(rd279) : "l"(rd4), "l"(rd277));
  // PTX:1954 ld.global.f32 %f1124, [%rd279]
  f1124 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd279) + (0)))));
  // PTX:1955 ld.global.f32 %f1125, [%rd278]
  f1125 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd278) + (0)))));
  // PTX:1956 sub.f32 %f1126, %f1125, %f1124
  asm("sub.f32 %0, %1, %2;" : "=f"(f1126) : "f"(f1125), "f"(f1124));
  // PTX:1957 ld.global.f32 %f1127, [%rd279+4]
  f1127 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd279) + (4)))));
  // PTX:1958 ld.global.f32 %f1128, [%rd278+4]
  f1128 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd278) + (4)))));
  // PTX:1959 sub.f32 %f1129, %f1128, %f1127
  asm("sub.f32 %0, %1, %2;" : "=f"(f1129) : "f"(f1128), "f"(f1127));
  // PTX:1960 ld.global.f32 %f1130, [%rd279+8]
  f1130 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd279) + (8)))));
  // PTX:1961 ld.global.f32 %f1131, [%rd278+8]
  f1131 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd278) + (8)))));
  // PTX:1962 sub.f32 %f1132, %f1131, %f1130
  asm("sub.f32 %0, %1, %2;" : "=f"(f1132) : "f"(f1131), "f"(f1130));
  // PTX:1963 mul.f32 %f1646, %f1126, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1646) : "f"(f1126), "f"(f414));
  // PTX:1964 mul.f32 %f1647, %f1129, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1647) : "f"(f1129), "f"(f414));
  // PTX:1965 mul.f32 %f1648, %f1132, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1648) : "f"(f1132), "f"(f414));
  // PTX:1966 bra.uni $L__BB2_155
  goto L_BB2_155;
  // PTX:1968 $L__BB2_154:
L_BB2_154:;
  // PTX:1969 mul.lo.s64 %rd280, %rd75, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd280) : "l"(rd75));
  // PTX:1970 add.s64 %rd281, %rd3, %rd280
  asm("add.s64 %0, %1, %2;" : "=l"(rd281) : "l"(rd3), "l"(rd280));
  // PTX:1971 ld.global.f32 %f1646, [%rd281]
  f1646 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd281) + (0)))));
  // PTX:1972 ld.global.f32 %f1647, [%rd281+4]
  f1647 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd281) + (4)))));
  // PTX:1973 ld.global.f32 %f1648, [%rd281+8]
  f1648 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd281) + (8)))));
  // PTX:1975 $L__BB2_155:
L_BB2_155:;
  // PTX:1976 cvt.s64.s32 %rd76, %r400
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd76) : "r"(r400));
  // PTX:1977 @%p119 bra $L__BB2_157
  if (p119) { goto L_BB2_157; }
  // PTX:1979 mul.lo.s64 %rd282, %rd76, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd282) : "l"(rd76));
  // PTX:1980 add.s64 %rd283, %rd6, %rd282
  asm("add.s64 %0, %1, %2;" : "=l"(rd283) : "l"(rd6), "l"(rd282));
  // PTX:1981 add.s64 %rd284, %rd4, %rd282
  asm("add.s64 %0, %1, %2;" : "=l"(rd284) : "l"(rd4), "l"(rd282));
  // PTX:1982 ld.global.f32 %f1133, [%rd284]
  f1133 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd284) + (0)))));
  // PTX:1983 ld.global.f32 %f1134, [%rd283]
  f1134 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd283) + (0)))));
  // PTX:1984 sub.f32 %f1135, %f1134, %f1133
  asm("sub.f32 %0, %1, %2;" : "=f"(f1135) : "f"(f1134), "f"(f1133));
  // PTX:1985 ld.global.f32 %f1136, [%rd284+4]
  f1136 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd284) + (4)))));
  // PTX:1986 ld.global.f32 %f1137, [%rd283+4]
  f1137 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd283) + (4)))));
  // PTX:1987 sub.f32 %f1138, %f1137, %f1136
  asm("sub.f32 %0, %1, %2;" : "=f"(f1138) : "f"(f1137), "f"(f1136));
  // PTX:1988 ld.global.f32 %f1139, [%rd284+8]
  f1139 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd284) + (8)))));
  // PTX:1989 ld.global.f32 %f1140, [%rd283+8]
  f1140 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd283) + (8)))));
  // PTX:1990 sub.f32 %f1141, %f1140, %f1139
  asm("sub.f32 %0, %1, %2;" : "=f"(f1141) : "f"(f1140), "f"(f1139));
  // PTX:1991 mul.f32 %f1649, %f1135, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1649) : "f"(f1135), "f"(f414));
  // PTX:1992 mul.f32 %f1650, %f1138, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1650) : "f"(f1138), "f"(f414));
  // PTX:1993 mul.f32 %f1651, %f1141, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1651) : "f"(f1141), "f"(f414));
  // PTX:1994 bra.uni $L__BB2_158
  goto L_BB2_158;
  // PTX:1996 $L__BB2_157:
L_BB2_157:;
  // PTX:1997 mul.lo.s64 %rd285, %rd76, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd285) : "l"(rd76));
  // PTX:1998 add.s64 %rd286, %rd3, %rd285
  asm("add.s64 %0, %1, %2;" : "=l"(rd286) : "l"(rd3), "l"(rd285));
  // PTX:1999 ld.global.f32 %f1649, [%rd286]
  f1649 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd286) + (0)))));
  // PTX:2000 ld.global.f32 %f1650, [%rd286+4]
  f1650 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd286) + (4)))));
  // PTX:2001 ld.global.f32 %f1651, [%rd286+8]
  f1651 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd286) + (8)))));
  // PTX:2003 $L__BB2_158:
L_BB2_158:;
  // PTX:2004 cvt.s64.s32 %rd77, %r401
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd77) : "r"(r401));
  // PTX:2005 @%p119 bra $L__BB2_160
  if (p119) { goto L_BB2_160; }
  // PTX:2007 mul.lo.s64 %rd287, %rd77, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd287) : "l"(rd77));
  // PTX:2008 add.s64 %rd288, %rd6, %rd287
  asm("add.s64 %0, %1, %2;" : "=l"(rd288) : "l"(rd6), "l"(rd287));
  // PTX:2009 add.s64 %rd289, %rd4, %rd287
  asm("add.s64 %0, %1, %2;" : "=l"(rd289) : "l"(rd4), "l"(rd287));
  // PTX:2010 ld.global.f32 %f1142, [%rd289]
  f1142 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd289) + (0)))));
  // PTX:2011 ld.global.f32 %f1143, [%rd288]
  f1143 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd288) + (0)))));
  // PTX:2012 sub.f32 %f1144, %f1143, %f1142
  asm("sub.f32 %0, %1, %2;" : "=f"(f1144) : "f"(f1143), "f"(f1142));
  // PTX:2013 ld.global.f32 %f1145, [%rd289+4]
  f1145 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd289) + (4)))));
  // PTX:2014 ld.global.f32 %f1146, [%rd288+4]
  f1146 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd288) + (4)))));
  // PTX:2015 sub.f32 %f1147, %f1146, %f1145
  asm("sub.f32 %0, %1, %2;" : "=f"(f1147) : "f"(f1146), "f"(f1145));
  // PTX:2016 ld.global.f32 %f1148, [%rd289+8]
  f1148 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd289) + (8)))));
  // PTX:2017 ld.global.f32 %f1149, [%rd288+8]
  f1149 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd288) + (8)))));
  // PTX:2018 sub.f32 %f1150, %f1149, %f1148
  asm("sub.f32 %0, %1, %2;" : "=f"(f1150) : "f"(f1149), "f"(f1148));
  // PTX:2019 mul.f32 %f1652, %f1144, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1652) : "f"(f1144), "f"(f414));
  // PTX:2020 mul.f32 %f1653, %f1147, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1653) : "f"(f1147), "f"(f414));
  // PTX:2021 mul.f32 %f1654, %f1150, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1654) : "f"(f1150), "f"(f414));
  // PTX:2022 bra.uni $L__BB2_161
  goto L_BB2_161;
  // PTX:2024 $L__BB2_160:
L_BB2_160:;
  // PTX:2025 mul.lo.s64 %rd290, %rd77, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd290) : "l"(rd77));
  // PTX:2026 add.s64 %rd291, %rd3, %rd290
  asm("add.s64 %0, %1, %2;" : "=l"(rd291) : "l"(rd3), "l"(rd290));
  // PTX:2027 ld.global.f32 %f1652, [%rd291]
  f1652 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd291) + (0)))));
  // PTX:2028 ld.global.f32 %f1653, [%rd291+4]
  f1653 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd291) + (4)))));
  // PTX:2029 ld.global.f32 %f1654, [%rd291+8]
  f1654 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd291) + (8)))));
  // PTX:2031 $L__BB2_161:
L_BB2_161:;
  // PTX:2032 cvt.s64.s32 %rd78, %r402
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd78) : "r"(r402));
  // PTX:2033 @%p119 bra $L__BB2_163
  if (p119) { goto L_BB2_163; }
  // PTX:2035 mul.lo.s64 %rd292, %rd78, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd292) : "l"(rd78));
  // PTX:2036 add.s64 %rd293, %rd6, %rd292
  asm("add.s64 %0, %1, %2;" : "=l"(rd293) : "l"(rd6), "l"(rd292));
  // PTX:2037 add.s64 %rd294, %rd4, %rd292
  asm("add.s64 %0, %1, %2;" : "=l"(rd294) : "l"(rd4), "l"(rd292));
  // PTX:2038 ld.global.f32 %f1151, [%rd294]
  f1151 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd294) + (0)))));
  // PTX:2039 ld.global.f32 %f1152, [%rd293]
  f1152 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd293) + (0)))));
  // PTX:2040 sub.f32 %f1153, %f1152, %f1151
  asm("sub.f32 %0, %1, %2;" : "=f"(f1153) : "f"(f1152), "f"(f1151));
  // PTX:2041 ld.global.f32 %f1154, [%rd294+4]
  f1154 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd294) + (4)))));
  // PTX:2042 ld.global.f32 %f1155, [%rd293+4]
  f1155 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd293) + (4)))));
  // PTX:2043 sub.f32 %f1156, %f1155, %f1154
  asm("sub.f32 %0, %1, %2;" : "=f"(f1156) : "f"(f1155), "f"(f1154));
  // PTX:2044 ld.global.f32 %f1157, [%rd294+8]
  f1157 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd294) + (8)))));
  // PTX:2045 ld.global.f32 %f1158, [%rd293+8]
  f1158 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd293) + (8)))));
  // PTX:2046 sub.f32 %f1159, %f1158, %f1157
  asm("sub.f32 %0, %1, %2;" : "=f"(f1159) : "f"(f1158), "f"(f1157));
  // PTX:2047 mul.f32 %f1655, %f1153, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1655) : "f"(f1153), "f"(f414));
  // PTX:2048 mul.f32 %f1656, %f1156, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1656) : "f"(f1156), "f"(f414));
  // PTX:2049 mul.f32 %f1657, %f1159, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f1657) : "f"(f1159), "f"(f414));
  // PTX:2050 bra.uni $L__BB2_164
  goto L_BB2_164;
  // PTX:2052 $L__BB2_163:
L_BB2_163:;
  // PTX:2053 mul.lo.s64 %rd295, %rd78, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd295) : "l"(rd78));
  // PTX:2054 add.s64 %rd296, %rd3, %rd295
  asm("add.s64 %0, %1, %2;" : "=l"(rd296) : "l"(rd3), "l"(rd295));
  // PTX:2055 ld.global.f32 %f1655, [%rd296]
  f1655 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd296) + (0)))));
  // PTX:2056 ld.global.f32 %f1656, [%rd296+4]
  f1656 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd296) + (4)))));
  // PTX:2057 ld.global.f32 %f1657, [%rd296+8]
  f1657 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd296) + (8)))));
  // PTX:2059 $L__BB2_164:
L_BB2_164:;
  // PTX:2060 mov.b32 %f1160, %r479
  asm("mov.b32 %0, %1;" : "=f"(f1160) : "r"(r479));
  // PTX:2061 sub.f32 %f1161, %f1160, %f326
  asm("sub.f32 %0, %1, %2;" : "=f"(f1161) : "f"(f1160), "f"(f326));
  // PTX:2062 mov.b32 %f1162, %r478
  asm("mov.b32 %0, %1;" : "=f"(f1162) : "r"(r478));
  // PTX:2063 sub.f32 %f1163, %f1162, %f327
  asm("sub.f32 %0, %1, %2;" : "=f"(f1163) : "f"(f1162), "f"(f327));
  // PTX:2064 mov.b32 %f1164, %r477
  asm("mov.b32 %0, %1;" : "=f"(f1164) : "r"(r477));
  // PTX:2065 sub.f32 %f1165, %f1164, %f328
  asm("sub.f32 %0, %1, %2;" : "=f"(f1165) : "f"(f1164), "f"(f328));
  // PTX:2066 fma.rn.f32 %f1166, %f1161, %f1649, %f1646
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1166) : "f"(f1161), "f"(f1649), "f"(f1646));
  // PTX:2067 fma.rn.f32 %f1167, %f1161, %f1650, %f1647
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1167) : "f"(f1161), "f"(f1650), "f"(f1647));
  // PTX:2068 fma.rn.f32 %f1168, %f1161, %f1651, %f1648
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1168) : "f"(f1161), "f"(f1651), "f"(f1648));
  // PTX:2069 fma.rn.f32 %f1169, %f1163, %f1652, %f1166
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1169) : "f"(f1163), "f"(f1652), "f"(f1166));
  // PTX:2070 fma.rn.f32 %f1170, %f1163, %f1653, %f1167
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1170) : "f"(f1163), "f"(f1653), "f"(f1167));
  // PTX:2071 fma.rn.f32 %f1171, %f1163, %f1654, %f1168
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1171) : "f"(f1163), "f"(f1654), "f"(f1168));
  // PTX:2072 fma.rn.f32 %f1660, %f1165, %f1655, %f1169
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1660) : "f"(f1165), "f"(f1655), "f"(f1169));
  // PTX:2073 fma.rn.f32 %f1659, %f1165, %f1656, %f1170
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1659) : "f"(f1165), "f"(f1656), "f"(f1170));
  // PTX:2074 fma.rn.f32 %f1658, %f1165, %f1657, %f1171
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1658) : "f"(f1165), "f"(f1657), "f"(f1171));
  // PTX:2076 $L__BB2_165:
L_BB2_165:;
  // PTX:2077 cvt.s64.s32 %rd469, %rd494
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd469) : "l"(rd494));
  // PTX:2078 shl.b64 %rd468, %rd469, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd468) : "l"(rd469));
  // PTX:2079 cvt.s64.s32 %rd467, %rd491
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd467) : "l"(rd491));
  // PTX:2080 shl.b64 %rd466, %rd467, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd466) : "l"(rd467));
  // PTX:2081 ld.param.f32 %f1556, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_19]
  f1556 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param19 + (0))));
  // PTX:2082 ld.param.u64 %rd411, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_15]
  rd411 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:2083 cvta.to.global.u64 %rd297, %rd411
  rd297 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd411));
  // PTX:2084 sub.f32 %f1172, %f1630, %f1615
  asm("sub.f32 %0, %1, %2;" : "=f"(f1172) : "f"(f1630), "f"(f1615));
  // PTX:2085 mul.f32 %f1173, %f1172, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f1173) : "f"(f1172), "f"(f9));
  // PTX:2086 sub.f32 %f1174, %f1629, %f1614
  asm("sub.f32 %0, %1, %2;" : "=f"(f1174) : "f"(f1629), "f"(f1614));
  // PTX:2087 sub.f32 %f1175, %f1628, %f1613
  asm("sub.f32 %0, %1, %2;" : "=f"(f1175) : "f"(f1628), "f"(f1613));
  // PTX:2088 fma.rn.f32 %f1176, %f1174, %f10, %f1173
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1176) : "f"(f1174), "f"(f10), "f"(f1173));
  // PTX:2089 fma.rn.f32 %f371, %f1175, %f11, %f1176
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f371) : "f"(f1175), "f"(f11), "f"(f1176));
  // PTX:2090 add.s64 %rd299, %rd297, %rd466
  asm("add.s64 %0, %1, %2;" : "=l"(rd299) : "l"(rd297), "l"(rd466));
  // PTX:2091 ld.global.f32 %f372, [%rd299]
  f372 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd299) + (0)))));
  // PTX:2092 add.s64 %rd301, %rd297, %rd468
  asm("add.s64 %0, %1, %2;" : "=l"(rd301) : "l"(rd297), "l"(rd468));
  // PTX:2093 ld.global.f32 %f373, [%rd301]
  f373 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd301) + (0)))));
  // PTX:2094 setp.gt.f32 %p123, %f1556, 0f00000000
  p123 = (!(isnan(((float)(f1556))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f1556)) > ((float)(as_f32(0x00000000u)))));
  // PTX:2095 @%p123 bra $L__BB2_167
  if (p123) { goto L_BB2_167; }
  // PTX:2096 bra.uni $L__BB2_166
  goto L_BB2_166;
  // PTX:2098 $L__BB2_167:
L_BB2_167:;
  // PTX:2099 add.f32 %f1177, %f372, %f373
  asm("add.f32 %0, %1, %2;" : "=f"(f1177) : "f"(f372), "f"(f373));
  // PTX:2100 mul.f32 %f1661, %f1177, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1661) : "f"(f1177));
  // PTX:2101 bra.uni $L__BB2_168
  goto L_BB2_168;
  // PTX:2103 $L__BB2_166:
L_BB2_166:;
  // PTX:2104 max.f32 %f1661, %f372, %f373
  asm("max.f32 %0, %1, %2;" : "=f"(f1661) : "f"(f372), "f"(f373));
  // PTX:2106 $L__BB2_168:
L_BB2_168:;
  // PTX:2107 cvt.s64.s32 %rd473, %rd494
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd473) : "l"(rd494));
  // PTX:2108 shl.b64 %rd472, %rd473, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd472) : "l"(rd473));
  // PTX:2109 cvt.s64.s32 %rd471, %rd491
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd471) : "l"(rd491));
  // PTX:2110 shl.b64 %rd470, %rd471, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd470) : "l"(rd471));
  // PTX:2111 ld.param.u64 %rd412, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_16]
  rd412 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param16 + (0))));
  // PTX:2112 cvta.to.global.u64 %rd302, %rd412
  rd302 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd412));
  // PTX:2113 add.s64 %rd304, %rd302, %rd470
  asm("add.s64 %0, %1, %2;" : "=l"(rd304) : "l"(rd302), "l"(rd470));
  // PTX:2114 ld.global.f32 %f377, [%rd304]
  f377 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd304) + (0)))));
  // PTX:2115 add.s64 %rd306, %rd302, %rd472
  asm("add.s64 %0, %1, %2;" : "=l"(rd306) : "l"(rd302), "l"(rd472));
  // PTX:2116 ld.global.f32 %f378, [%rd306]
  f378 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd306) + (0)))));
  // PTX:2117 @%p123 bra $L__BB2_170
  if (p123) { goto L_BB2_170; }
  // PTX:2118 bra.uni $L__BB2_169
  goto L_BB2_169;
  // PTX:2120 $L__BB2_170:
L_BB2_170:;
  // PTX:2121 add.f32 %f1178, %f377, %f378
  asm("add.f32 %0, %1, %2;" : "=f"(f1178) : "f"(f377), "f"(f378));
  // PTX:2122 mul.f32 %f1662, %f1178, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1662) : "f"(f1178));
  // PTX:2123 bra.uni $L__BB2_171
  goto L_BB2_171;
  // PTX:2125 $L__BB2_169:
L_BB2_169:;
  // PTX:2126 max.f32 %f1662, %f377, %f378
  asm("max.f32 %0, %1, %2;" : "=f"(f1662) : "f"(f377), "f"(f378));
  // PTX:2128 $L__BB2_171:
L_BB2_171:;
  // PTX:2129 mul.f32 %f382, %f190, %f1661
  asm("mul.f32 %0, %1, %2;" : "=f"(f382) : "f"(f190), "f"(f1661));
  // PTX:2130 setp.ge.f32 %p125, %f371, 0f00000000
  p125 = (!(isnan(((float)(f371))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f371)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:2131 and.pred %p127, %p123, %p125
  p127 = ((p123) && (p125));
  // PTX:2132 selp.f32 %f383, 0f00000000, %f1662, %p127
  f383 = p127 ? as_f32(0x00000000u) : f1662;
  // PTX:2133 @%p123 bra $L__BB2_173
  if (p123) { goto L_BB2_173; }
  // PTX:2134 bra.uni $L__BB2_172
  goto L_BB2_172;
  // PTX:2136 $L__BB2_173:
L_BB2_173:;
  // PTX:2137 mul.f32 %f1182, %f371, %f383
  asm("mul.f32 %0, %1, %2;" : "=f"(f1182) : "f"(f371), "f"(f383));
  // PTX:2138 sub.f32 %f1663, %f382, %f1182
  asm("sub.f32 %0, %1, %2;" : "=f"(f1663) : "f"(f382), "f"(f1182));
  // PTX:2139 bra.uni $L__BB2_174
  goto L_BB2_174;
  // PTX:2141 $L__BB2_172:
L_BB2_172:;
  // PTX:2142 mul.f32 %f1179, %f371, %f1662
  asm("mul.f32 %0, %1, %2;" : "=f"(f1179) : "f"(f371), "f"(f1662));
  // PTX:2143 sub.f32 %f1180, %f382, %f1179
  asm("sub.f32 %0, %1, %2;" : "=f"(f1180) : "f"(f382), "f"(f1179));
  // PTX:2144 mov.f32 %f1181, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1181) : );
  // PTX:2145 max.f32 %f1663, %f1180, %f1181
  asm("max.f32 %0, %1, %2;" : "=f"(f1663) : "f"(f1180), "f"(f1181));
  // PTX:2147 $L__BB2_174:
L_BB2_174:;
  // PTX:2148 cvt.s64.s32 %rd477, %rd494
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd477) : "l"(rd494));
  // PTX:2149 shl.b64 %rd476, %rd477, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd476) : "l"(rd477));
  // PTX:2150 cvt.s64.s32 %rd475, %rd491
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd475) : "l"(rd491));
  // PTX:2151 shl.b64 %rd474, %rd475, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd474) : "l"(rd475));
  // PTX:2152 ld.param.u64 %rd413, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_18]
  rd413 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param18 + (0))));
  // PTX:2153 cvta.to.global.u64 %rd307, %rd413
  rd307 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd413));
  // PTX:2154 sub.f32 %f1183, %f1660, %f1645
  asm("sub.f32 %0, %1, %2;" : "=f"(f1183) : "f"(f1660), "f"(f1645));
  // PTX:2155 mul.f32 %f1184, %f1183, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f1184) : "f"(f1183), "f"(f9));
  // PTX:2156 sub.f32 %f1185, %f1659, %f1644
  asm("sub.f32 %0, %1, %2;" : "=f"(f1185) : "f"(f1659), "f"(f1644));
  // PTX:2157 sub.f32 %f1186, %f1658, %f1643
  asm("sub.f32 %0, %1, %2;" : "=f"(f1186) : "f"(f1658), "f"(f1643));
  // PTX:2158 fma.rn.f32 %f1187, %f1185, %f10, %f1184
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1187) : "f"(f1185), "f"(f10), "f"(f1184));
  // PTX:2159 fma.rn.f32 %f1188, %f1186, %f11, %f1187
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1188) : "f"(f1186), "f"(f11), "f"(f1187));
  // PTX:2160 mul.f32 %f1189, %f1188, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f1189) : "f"(f1188), "f"(f9));
  // PTX:2161 mul.f32 %f1190, %f1188, %f10
  asm("mul.f32 %0, %1, %2;" : "=f"(f1190) : "f"(f1188), "f"(f10));
  // PTX:2162 mul.f32 %f1191, %f1188, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f1191) : "f"(f1188), "f"(f11));
  // PTX:2163 sub.f32 %f387, %f1183, %f1189
  asm("sub.f32 %0, %1, %2;" : "=f"(f387) : "f"(f1183), "f"(f1189));
  // PTX:2164 sub.f32 %f388, %f1185, %f1190
  asm("sub.f32 %0, %1, %2;" : "=f"(f388) : "f"(f1185), "f"(f1190));
  // PTX:2165 sub.f32 %f389, %f1186, %f1191
  asm("sub.f32 %0, %1, %2;" : "=f"(f389) : "f"(f1186), "f"(f1191));
  // PTX:2166 mul.f32 %f1192, %f388, %f388
  asm("mul.f32 %0, %1, %2;" : "=f"(f1192) : "f"(f388), "f"(f388));
  // PTX:2167 fma.rn.f32 %f1193, %f387, %f387, %f1192
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1193) : "f"(f387), "f"(f387), "f"(f1192));
  // PTX:2168 fma.rn.f32 %f1194, %f389, %f389, %f1193
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1194) : "f"(f389), "f"(f389), "f"(f1193));
  // PTX:2169 sqrt.rn.f32 %f390, %f1194
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f390) : "f"(f1194));
  // PTX:2170 add.s64 %rd309, %rd307, %rd474
  asm("add.s64 %0, %1, %2;" : "=l"(rd309) : "l"(rd307), "l"(rd474));
  // PTX:2171 ld.global.f32 %f391, [%rd309]
  f391 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd309) + (0)))));
  // PTX:2172 add.s64 %rd311, %rd307, %rd476
  asm("add.s64 %0, %1, %2;" : "=l"(rd311) : "l"(rd307), "l"(rd476));
  // PTX:2173 ld.global.f32 %f392, [%rd311]
  f392 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd311) + (0)))));
  // PTX:2174 @%p123 bra $L__BB2_176
  if (p123) { goto L_BB2_176; }
  // PTX:2175 bra.uni $L__BB2_175
  goto L_BB2_175;
  // PTX:2177 $L__BB2_176:
L_BB2_176:;
  // PTX:2178 mul.f32 %f1195, %f391, %f392
  asm("mul.f32 %0, %1, %2;" : "=f"(f1195) : "f"(f391), "f"(f392));
  // PTX:2179 mov.f32 %f1196, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1196) : );
  // PTX:2180 max.f32 %f1197, %f1195, %f1196
  asm("max.f32 %0, %1, %2;" : "=f"(f1197) : "f"(f1195), "f"(f1196));
  // PTX:2181 sqrt.rn.f32 %f1664, %f1197
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f1664) : "f"(f1197));
  // PTX:2182 bra.uni $L__BB2_177
  goto L_BB2_177;
  // PTX:2184 $L__BB2_175:
L_BB2_175:;
  // PTX:2185 max.f32 %f1664, %f391, %f392
  asm("max.f32 %0, %1, %2;" : "=f"(f1664) : "f"(f391), "f"(f392));
  // PTX:2187 $L__BB2_177:
L_BB2_177:;
  // PTX:2188 selp.f32 %f1198, %f382, %f1663, %p123
  f1198 = p123 ? f382 : f1663;
  // PTX:2189 mul.f32 %f396, %f1198, %f1664
  asm("mul.f32 %0, %1, %2;" : "=f"(f396) : "f"(f1198), "f"(f1664));
  // PTX:2190 mov.f32 %f1665, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1665) : );
  // PTX:2191 @%p123 bra $L__BB2_180
  if (p123) { goto L_BB2_180; }
  // PTX:2192 bra.uni $L__BB2_178
  goto L_BB2_178;
  // PTX:2194 $L__BB2_180:
L_BB2_180:;
  // PTX:2195 setp.leu.f32 %p131, %f396, 0f00000000
  p131 = ((isnan(((float)(f396))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f396)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:2196 setp.leu.f32 %p132, %f390, 0f00000000
  p132 = ((isnan(((float)(f390))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f390)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:2197 or.pred %p133, %p132, %p131
  p133 = ((p132) || (p131));
  // PTX:2198 @%p133 bra $L__BB2_184
  if (p133) { goto L_BB2_184; }
  // PTX:2200 ld.param.f32 %f1557, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_19]
  f1557 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param19 + (0))));
  // PTX:2201 setp.gtu.f32 %p134, %f390, %f1557
  p134 = ((isnan(((float)(f390))) || isnan(((float)(f1557)))) || (((float)(f390)) > ((float)(f1557))));
  // PTX:2202 @%p134 bra $L__BB2_183
  if (p134) { goto L_BB2_183; }
  // PTX:2203 bra.uni $L__BB2_182
  goto L_BB2_182;
  // PTX:2205 $L__BB2_183:
L_BB2_183:;
  // PTX:2206 div.rn.f32 %f1665, %f396, %f390
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f1665) : "f"(f396), "f"(f390));
  // PTX:2207 bra.uni $L__BB2_184
  goto L_BB2_184;
  // PTX:2209 $L__BB2_178:
L_BB2_178:;
  // PTX:2210 cvt.s64.s32 %rd481, %rd494
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd481) : "l"(rd494));
  // PTX:2211 shl.b64 %rd480, %rd481, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd480) : "l"(rd481));
  // PTX:2212 cvt.s64.s32 %rd479, %rd491
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd479) : "l"(rd491));
  // PTX:2213 shl.b64 %rd478, %rd479, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd478) : "l"(rd479));
  // PTX:2214 ld.param.u64 %rd414, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_17]
  rd414 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param17 + (0))));
  // PTX:2215 cvta.to.global.u64 %rd312, %rd414
  rd312 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd414));
  // PTX:2216 add.s64 %rd314, %rd312, %rd478
  asm("add.s64 %0, %1, %2;" : "=l"(rd314) : "l"(rd312), "l"(rd478));
  // PTX:2217 add.s64 %rd316, %rd312, %rd480
  asm("add.s64 %0, %1, %2;" : "=l"(rd316) : "l"(rd312), "l"(rd480));
  // PTX:2218 ld.global.f32 %f1200, [%rd316]
  f1200 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd316) + (0)))));
  // PTX:2219 ld.global.f32 %f1201, [%rd314]
  f1201 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd314) + (0)))));
  // PTX:2220 max.f32 %f397, %f1201, %f1200
  asm("max.f32 %0, %1, %2;" : "=f"(f397) : "f"(f1201), "f"(f1200));
  // PTX:2221 setp.leu.f32 %p130, %f396, 0f00000000
  p130 = ((isnan(((float)(f396))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f396)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:2222 @%p130 bra $L__BB2_184
  if (p130) { goto L_BB2_184; }
  // PTX:2224 mov.f32 %f1202, 0f322BCC77
  asm("mov.f32 %0, 0f322BCC77;" : "=f"(f1202) : );
  // PTX:2225 max.f32 %f1203, %f390, %f1202
  asm("max.f32 %0, %1, %2;" : "=f"(f1203) : "f"(f390), "f"(f1202));
  // PTX:2226 div.rn.f32 %f1204, %f396, %f1203
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f1204) : "f"(f396), "f"(f1203));
  // PTX:2227 min.f32 %f1665, %f397, %f1204
  asm("min.f32 %0, %1, %2;" : "=f"(f1665) : "f"(f397), "f"(f1204));
  // PTX:2228 bra.uni $L__BB2_184
  goto L_BB2_184;
  // PTX:2230 $L__BB2_182:
L_BB2_182:;
  // PTX:2231 ld.param.f32 %f1558, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_19]
  f1558 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param19 + (0))));
  // PTX:2232 div.rn.f32 %f1206, %f390, %f1558
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f1206) : "f"(f390), "f"(f1558));
  // PTX:2233 mov.f32 %f1207, 0f40000000
  asm("mov.f32 %0, 0f40000000;" : "=f"(f1207) : );
  // PTX:2234 sub.f32 %f1208, %f1207, %f1206
  asm("sub.f32 %0, %1, %2;" : "=f"(f1208) : "f"(f1207), "f"(f1206));
  // PTX:2235 mul.f32 %f1209, %f1208, %f396
  asm("mul.f32 %0, %1, %2;" : "=f"(f1209) : "f"(f1208), "f"(f396));
  // PTX:2236 div.rn.f32 %f1665, %f1209, %f1558
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f1665) : "f"(f1209), "f"(f1558));
  // PTX:2238 $L__BB2_184:
L_BB2_184:;
  // PTX:2239 ld.param.u64 %rd451, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_7]
  rd451 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:2240 ld.param.u64 %rd450, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_6]
  rd450 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:2241 neg.f32 %f1210, %f1663
  asm("neg.f32 %0, %1;" : "=f"(f1210) : "f"(f1663));
  // PTX:2242 mul.f32 %f402, %f9, %f1210
  asm("mul.f32 %0, %1, %2;" : "=f"(f402) : "f"(f9), "f"(f1210));
  // PTX:2243 mul.f32 %f403, %f10, %f1210
  asm("mul.f32 %0, %1, %2;" : "=f"(f403) : "f"(f10), "f"(f1210));
  // PTX:2244 mul.f32 %f404, %f11, %f1210
  asm("mul.f32 %0, %1, %2;" : "=f"(f404) : "f"(f11), "f"(f1210));
  // PTX:2245 mul.f32 %f405, %f387, %f1665
  asm("mul.f32 %0, %1, %2;" : "=f"(f405) : "f"(f387), "f"(f1665));
  // PTX:2246 mul.f32 %f406, %f388, %f1665
  asm("mul.f32 %0, %1, %2;" : "=f"(f406) : "f"(f388), "f"(f1665));
  // PTX:2247 mul.f32 %f407, %f389, %f1665
  asm("mul.f32 %0, %1, %2;" : "=f"(f407) : "f"(f389), "f"(f1665));
  // PTX:2248 fma.rn.f32 %f408, %f383, %f414, %f1661
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f408) : "f"(f383), "f"(f414), "f"(f1661));
  // PTX:2249 mul.f32 %f409, %f1665, %f414
  asm("mul.f32 %0, %1, %2;" : "=f"(f409) : "f"(f1665), "f"(f414));
  // PTX:2250 setp.ne.s64 %p135, %rd450, 0
  p135 = (((long long)(rd450)) != ((long long)(0)));
  // PTX:2251 or.pred %p136, %p135, %p1
  p136 = ((p135) || (p1));
  // PTX:2252 setp.ne.s64 %p137, %rd451, 0
  p137 = (((long long)(rd451)) != ((long long)(0)));
  // PTX:2253 or.pred %p138, %p137, %p136
  p138 = ((p137) || (p136));
  // PTX:2254 @%p138 bra $L__BB2_193
  if (p138) { goto L_BB2_193; }
  // PTX:2255 bra.uni $L__BB2_185
  goto L_BB2_185;
  // PTX:2257 $L__BB2_193:
L_BB2_193:;
  // PTX:2258 ld.param.u64 %rd417, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_32]
  rd417 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param32 + (0))));
  // PTX:2259 setp.eq.s64 %p152, %rd417, 0
  p152 = (((long long)(rd417)) == ((long long)(0)));
  // PTX:2260 or.pred %p153, %p152, %p26
  p153 = ((p152) || (p26));
  // PTX:2261 @%p153 bra $L__BB2_195
  if (p153) { goto L_BB2_195; }
  // PTX:2263 ld.global.f32 %f1323, [%rd59]
  f1323 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:2264 mov.b32 %f1324, %r37
  asm("mov.b32 %0, %1;" : "=f"(f1324) : "r"(r37));
  // PTX:2265 sub.f32 %f1325, %f1324, %f1323
  asm("sub.f32 %0, %1, %2;" : "=f"(f1325) : "f"(f1324), "f"(f1323));
  // PTX:2266 mov.b32 %f1326, %r38
  asm("mov.b32 %0, %1;" : "=f"(f1326) : "r"(r38));
  // PTX:2267 ld.global.f32 %f1327, [%rd59+4]
  f1327 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4)))));
  // PTX:2268 sub.f32 %f1328, %f1326, %f1327
  asm("sub.f32 %0, %1, %2;" : "=f"(f1328) : "f"(f1326), "f"(f1327));
  // PTX:2269 mov.b32 %f1329, %r39
  asm("mov.b32 %0, %1;" : "=f"(f1329) : "r"(r39));
  // PTX:2270 ld.global.f32 %f1330, [%rd59+8]
  f1330 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8)))));
  // PTX:2271 sub.f32 %f1331, %f1329, %f1330
  asm("sub.f32 %0, %1, %2;" : "=f"(f1331) : "f"(f1329), "f"(f1330));
  // PTX:2272 mul.wide.s32 %rd365, %r395, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd365) : "r"(r395));
  // PTX:2273 add.s64 %rd366, %rd1, %rd365
  asm("add.s64 %0, %1, %2;" : "=l"(rd366) : "l"(rd1), "l"(rd365));
  // PTX:2274 red.global.add.f32 [%rd366], %f402
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd366) + (0)))), (float)(f402));
  // PTX:2275 add.s64 %rd367, %rd366, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd367) : "l"(rd366));
  // PTX:2276 red.global.add.f32 [%rd367], %f403
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd367) + (0)))), (float)(f403));
  // PTX:2277 add.s64 %rd368, %rd366, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd368) : "l"(rd366));
  // PTX:2278 red.global.add.f32 [%rd368], %f404
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd368) + (0)))), (float)(f404));
  // PTX:2279 mul.wide.s32 %rd369, %r396, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd369) : "r"(r396));
  // PTX:2280 add.s64 %rd370, %rd1, %rd369
  asm("add.s64 %0, %1, %2;" : "=l"(rd370) : "l"(rd1), "l"(rd369));
  // PTX:2281 mul.f32 %f1335, %f402, %f1325
  asm("mul.f32 %0, %1, %2;" : "=f"(f1335) : "f"(f402), "f"(f1325));
  // PTX:2282 red.global.add.f32 [%rd370], %f1335
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd370) + (0)))), (float)(f1335));
  // PTX:2283 add.s64 %rd371, %rd370, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd371) : "l"(rd370));
  // PTX:2284 mul.f32 %f1337, %f403, %f1325
  asm("mul.f32 %0, %1, %2;" : "=f"(f1337) : "f"(f403), "f"(f1325));
  // PTX:2285 red.global.add.f32 [%rd371], %f1337
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd371) + (0)))), (float)(f1337));
  // PTX:2286 add.s64 %rd372, %rd370, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd372) : "l"(rd370));
  // PTX:2287 mul.f32 %f1339, %f404, %f1325
  asm("mul.f32 %0, %1, %2;" : "=f"(f1339) : "f"(f404), "f"(f1325));
  // PTX:2288 red.global.add.f32 [%rd372], %f1339
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd372) + (0)))), (float)(f1339));
  // PTX:2289 mul.wide.s32 %rd373, %r397, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd373) : "r"(r397));
  // PTX:2290 add.s64 %rd374, %rd1, %rd373
  asm("add.s64 %0, %1, %2;" : "=l"(rd374) : "l"(rd1), "l"(rd373));
  // PTX:2291 mul.f32 %f1341, %f402, %f1328
  asm("mul.f32 %0, %1, %2;" : "=f"(f1341) : "f"(f402), "f"(f1328));
  // PTX:2292 red.global.add.f32 [%rd374], %f1341
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd374) + (0)))), (float)(f1341));
  // PTX:2293 add.s64 %rd375, %rd374, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd375) : "l"(rd374));
  // PTX:2294 mul.f32 %f1343, %f403, %f1328
  asm("mul.f32 %0, %1, %2;" : "=f"(f1343) : "f"(f403), "f"(f1328));
  // PTX:2295 red.global.add.f32 [%rd375], %f1343
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd375) + (0)))), (float)(f1343));
  // PTX:2296 add.s64 %rd376, %rd374, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd376) : "l"(rd374));
  // PTX:2297 mul.f32 %f1345, %f404, %f1328
  asm("mul.f32 %0, %1, %2;" : "=f"(f1345) : "f"(f404), "f"(f1328));
  // PTX:2298 red.global.add.f32 [%rd376], %f1345
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd376) + (0)))), (float)(f1345));
  // PTX:2299 mul.wide.s32 %rd377, %r398, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd377) : "r"(r398));
  // PTX:2300 add.s64 %rd378, %rd1, %rd377
  asm("add.s64 %0, %1, %2;" : "=l"(rd378) : "l"(rd1), "l"(rd377));
  // PTX:2301 mul.f32 %f1347, %f402, %f1331
  asm("mul.f32 %0, %1, %2;" : "=f"(f1347) : "f"(f402), "f"(f1331));
  // PTX:2302 red.global.add.f32 [%rd378], %f1347
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd378) + (0)))), (float)(f1347));
  // PTX:2303 add.s64 %rd379, %rd378, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd379) : "l"(rd378));
  // PTX:2304 mul.f32 %f1349, %f403, %f1331
  asm("mul.f32 %0, %1, %2;" : "=f"(f1349) : "f"(f403), "f"(f1331));
  // PTX:2305 red.global.add.f32 [%rd379], %f1349
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd379) + (0)))), (float)(f1349));
  // PTX:2306 add.s64 %rd380, %rd378, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd380) : "l"(rd378));
  // PTX:2307 mul.f32 %f1351, %f404, %f1331
  asm("mul.f32 %0, %1, %2;" : "=f"(f1351) : "f"(f404), "f"(f1331));
  // PTX:2308 red.global.add.f32 [%rd380], %f1351
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd380) + (0)))), (float)(f1351));
  // PTX:2309 mov.b32 %f1353, %r448
  asm("mov.b32 %0, %1;" : "=f"(f1353) : "r"(r448));
  // PTX:2310 ld.global.f32 %f1354, [%rd59]
  f1354 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:2311 sub.f32 %f1355, %f1353, %f1354
  asm("sub.f32 %0, %1, %2;" : "=f"(f1355) : "f"(f1353), "f"(f1354));
  // PTX:2312 mov.b32 %f1356, %r447
  asm("mov.b32 %0, %1;" : "=f"(f1356) : "r"(r447));
  // PTX:2313 ld.global.f32 %f1357, [%rd59+4]
  f1357 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4)))));
  // PTX:2314 sub.f32 %f1358, %f1356, %f1357
  asm("sub.f32 %0, %1, %2;" : "=f"(f1358) : "f"(f1356), "f"(f1357));
  // PTX:2315 mov.b32 %f1359, %r446
  asm("mov.b32 %0, %1;" : "=f"(f1359) : "r"(r446));
  // PTX:2316 ld.global.f32 %f1360, [%rd59+8]
  f1360 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8)))));
  // PTX:2317 sub.f32 %f1361, %f1359, %f1360
  asm("sub.f32 %0, %1, %2;" : "=f"(f1361) : "f"(f1359), "f"(f1360));
  // PTX:2318 red.global.add.f32 [%rd366], %f405
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd366) + (0)))), (float)(f405));
  // PTX:2319 red.global.add.f32 [%rd367], %f406
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd367) + (0)))), (float)(f406));
  // PTX:2320 red.global.add.f32 [%rd368], %f407
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd368) + (0)))), (float)(f407));
  // PTX:2321 mul.f32 %f1365, %f405, %f1355
  asm("mul.f32 %0, %1, %2;" : "=f"(f1365) : "f"(f405), "f"(f1355));
  // PTX:2322 red.global.add.f32 [%rd370], %f1365
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd370) + (0)))), (float)(f1365));
  // PTX:2323 mul.f32 %f1367, %f406, %f1355
  asm("mul.f32 %0, %1, %2;" : "=f"(f1367) : "f"(f406), "f"(f1355));
  // PTX:2324 red.global.add.f32 [%rd371], %f1367
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd371) + (0)))), (float)(f1367));
  // PTX:2325 mul.f32 %f1369, %f407, %f1355
  asm("mul.f32 %0, %1, %2;" : "=f"(f1369) : "f"(f407), "f"(f1355));
  // PTX:2326 red.global.add.f32 [%rd372], %f1369
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd372) + (0)))), (float)(f1369));
  // PTX:2327 mul.f32 %f1371, %f405, %f1358
  asm("mul.f32 %0, %1, %2;" : "=f"(f1371) : "f"(f405), "f"(f1358));
  // PTX:2328 red.global.add.f32 [%rd374], %f1371
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd374) + (0)))), (float)(f1371));
  // PTX:2329 mul.f32 %f1373, %f406, %f1358
  asm("mul.f32 %0, %1, %2;" : "=f"(f1373) : "f"(f406), "f"(f1358));
  // PTX:2330 red.global.add.f32 [%rd375], %f1373
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd375) + (0)))), (float)(f1373));
  // PTX:2331 mul.f32 %f1375, %f407, %f1358
  asm("mul.f32 %0, %1, %2;" : "=f"(f1375) : "f"(f407), "f"(f1358));
  // PTX:2332 red.global.add.f32 [%rd376], %f1375
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd376) + (0)))), (float)(f1375));
  // PTX:2333 mul.f32 %f1377, %f405, %f1361
  asm("mul.f32 %0, %1, %2;" : "=f"(f1377) : "f"(f405), "f"(f1361));
  // PTX:2334 red.global.add.f32 [%rd378], %f1377
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd378) + (0)))), (float)(f1377));
  // PTX:2335 mul.f32 %f1379, %f406, %f1361
  asm("mul.f32 %0, %1, %2;" : "=f"(f1379) : "f"(f406), "f"(f1361));
  // PTX:2336 red.global.add.f32 [%rd379], %f1379
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd379) + (0)))), (float)(f1379));
  // PTX:2337 mul.f32 %f1381, %f407, %f1361
  asm("mul.f32 %0, %1, %2;" : "=f"(f1381) : "f"(f407), "f"(f1361));
  // PTX:2338 red.global.add.f32 [%rd380], %f1381
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd380) + (0)))), (float)(f1381));
  // PTX:2340 $L__BB2_195:
L_BB2_195:;
  // PTX:2341 or.pred %p156, %p152, %p29
  p156 = ((p152) || (p29));
  // PTX:2342 @%p156 bra $L__BB2_197
  if (p156) { goto L_BB2_197; }
  // PTX:2344 ld.global.f32 %f1383, [%rd60]
  f1383 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:2345 mov.b32 %f1384, %r40
  asm("mov.b32 %0, %1;" : "=f"(f1384) : "r"(r40));
  // PTX:2346 sub.f32 %f1385, %f1384, %f1383
  asm("sub.f32 %0, %1, %2;" : "=f"(f1385) : "f"(f1384), "f"(f1383));
  // PTX:2347 mov.b32 %f1386, %r41
  asm("mov.b32 %0, %1;" : "=f"(f1386) : "r"(r41));
  // PTX:2348 ld.global.f32 %f1387, [%rd60+4]
  f1387 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:2349 sub.f32 %f1388, %f1386, %f1387
  asm("sub.f32 %0, %1, %2;" : "=f"(f1388) : "f"(f1386), "f"(f1387));
  // PTX:2350 mov.b32 %f1389, %r42
  asm("mov.b32 %0, %1;" : "=f"(f1389) : "r"(r42));
  // PTX:2351 ld.global.f32 %f1390, [%rd60+8]
  f1390 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:2352 sub.f32 %f1391, %f1389, %f1390
  asm("sub.f32 %0, %1, %2;" : "=f"(f1391) : "f"(f1389), "f"(f1390));
  // PTX:2353 mul.wide.s32 %rd381, %r399, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd381) : "r"(r399));
  // PTX:2354 add.s64 %rd382, %rd1, %rd381
  asm("add.s64 %0, %1, %2;" : "=l"(rd382) : "l"(rd1), "l"(rd381));
  // PTX:2355 neg.f32 %f1392, %f402
  asm("neg.f32 %0, %1;" : "=f"(f1392) : "f"(f402));
  // PTX:2356 red.global.add.f32 [%rd382], %f1392
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd382) + (0)))), (float)(f1392));
  // PTX:2357 add.s64 %rd383, %rd382, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd383) : "l"(rd382));
  // PTX:2358 neg.f32 %f1394, %f403
  asm("neg.f32 %0, %1;" : "=f"(f1394) : "f"(f403));
  // PTX:2359 red.global.add.f32 [%rd383], %f1394
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd383) + (0)))), (float)(f1394));
  // PTX:2360 add.s64 %rd384, %rd382, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd384) : "l"(rd382));
  // PTX:2361 neg.f32 %f1396, %f404
  asm("neg.f32 %0, %1;" : "=f"(f1396) : "f"(f404));
  // PTX:2362 red.global.add.f32 [%rd384], %f1396
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd384) + (0)))), (float)(f1396));
  // PTX:2363 mul.wide.s32 %rd385, %r400, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd385) : "r"(r400));
  // PTX:2364 add.s64 %rd386, %rd1, %rd385
  asm("add.s64 %0, %1, %2;" : "=l"(rd386) : "l"(rd1), "l"(rd385));
  // PTX:2365 mul.f32 %f1398, %f402, %f1385
  asm("mul.f32 %0, %1, %2;" : "=f"(f1398) : "f"(f402), "f"(f1385));
  // PTX:2366 neg.f32 %f1399, %f1398
  asm("neg.f32 %0, %1;" : "=f"(f1399) : "f"(f1398));
  // PTX:2367 red.global.add.f32 [%rd386], %f1399
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd386) + (0)))), (float)(f1399));
  // PTX:2368 add.s64 %rd387, %rd386, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd387) : "l"(rd386));
  // PTX:2369 mul.f32 %f1401, %f403, %f1385
  asm("mul.f32 %0, %1, %2;" : "=f"(f1401) : "f"(f403), "f"(f1385));
  // PTX:2370 neg.f32 %f1402, %f1401
  asm("neg.f32 %0, %1;" : "=f"(f1402) : "f"(f1401));
  // PTX:2371 red.global.add.f32 [%rd387], %f1402
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd387) + (0)))), (float)(f1402));
  // PTX:2372 add.s64 %rd388, %rd386, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd388) : "l"(rd386));
  // PTX:2373 mul.f32 %f1404, %f404, %f1385
  asm("mul.f32 %0, %1, %2;" : "=f"(f1404) : "f"(f404), "f"(f1385));
  // PTX:2374 neg.f32 %f1405, %f1404
  asm("neg.f32 %0, %1;" : "=f"(f1405) : "f"(f1404));
  // PTX:2375 red.global.add.f32 [%rd388], %f1405
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd388) + (0)))), (float)(f1405));
  // PTX:2376 mul.wide.s32 %rd389, %r401, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd389) : "r"(r401));
  // PTX:2377 add.s64 %rd390, %rd1, %rd389
  asm("add.s64 %0, %1, %2;" : "=l"(rd390) : "l"(rd1), "l"(rd389));
  // PTX:2378 mul.f32 %f1407, %f402, %f1388
  asm("mul.f32 %0, %1, %2;" : "=f"(f1407) : "f"(f402), "f"(f1388));
  // PTX:2379 neg.f32 %f1408, %f1407
  asm("neg.f32 %0, %1;" : "=f"(f1408) : "f"(f1407));
  // PTX:2380 red.global.add.f32 [%rd390], %f1408
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd390) + (0)))), (float)(f1408));
  // PTX:2381 add.s64 %rd391, %rd390, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd391) : "l"(rd390));
  // PTX:2382 mul.f32 %f1410, %f403, %f1388
  asm("mul.f32 %0, %1, %2;" : "=f"(f1410) : "f"(f403), "f"(f1388));
  // PTX:2383 neg.f32 %f1411, %f1410
  asm("neg.f32 %0, %1;" : "=f"(f1411) : "f"(f1410));
  // PTX:2384 red.global.add.f32 [%rd391], %f1411
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd391) + (0)))), (float)(f1411));
  // PTX:2385 add.s64 %rd392, %rd390, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd392) : "l"(rd390));
  // PTX:2386 mul.f32 %f1413, %f404, %f1388
  asm("mul.f32 %0, %1, %2;" : "=f"(f1413) : "f"(f404), "f"(f1388));
  // PTX:2387 neg.f32 %f1414, %f1413
  asm("neg.f32 %0, %1;" : "=f"(f1414) : "f"(f1413));
  // PTX:2388 red.global.add.f32 [%rd392], %f1414
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd392) + (0)))), (float)(f1414));
  // PTX:2389 mul.wide.s32 %rd393, %r402, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd393) : "r"(r402));
  // PTX:2390 add.s64 %rd394, %rd1, %rd393
  asm("add.s64 %0, %1, %2;" : "=l"(rd394) : "l"(rd1), "l"(rd393));
  // PTX:2391 mul.f32 %f1416, %f402, %f1391
  asm("mul.f32 %0, %1, %2;" : "=f"(f1416) : "f"(f402), "f"(f1391));
  // PTX:2392 neg.f32 %f1417, %f1416
  asm("neg.f32 %0, %1;" : "=f"(f1417) : "f"(f1416));
  // PTX:2393 red.global.add.f32 [%rd394], %f1417
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd394) + (0)))), (float)(f1417));
  // PTX:2394 add.s64 %rd395, %rd394, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd395) : "l"(rd394));
  // PTX:2395 mul.f32 %f1419, %f403, %f1391
  asm("mul.f32 %0, %1, %2;" : "=f"(f1419) : "f"(f403), "f"(f1391));
  // PTX:2396 neg.f32 %f1420, %f1419
  asm("neg.f32 %0, %1;" : "=f"(f1420) : "f"(f1419));
  // PTX:2397 red.global.add.f32 [%rd395], %f1420
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd395) + (0)))), (float)(f1420));
  // PTX:2398 add.s64 %rd396, %rd394, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd396) : "l"(rd394));
  // PTX:2399 mul.f32 %f1422, %f404, %f1391
  asm("mul.f32 %0, %1, %2;" : "=f"(f1422) : "f"(f404), "f"(f1391));
  // PTX:2400 neg.f32 %f1423, %f1422
  asm("neg.f32 %0, %1;" : "=f"(f1423) : "f"(f1422));
  // PTX:2401 red.global.add.f32 [%rd396], %f1423
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd396) + (0)))), (float)(f1423));
  // PTX:2402 mov.b32 %f1425, %r479
  asm("mov.b32 %0, %1;" : "=f"(f1425) : "r"(r479));
  // PTX:2403 ld.global.f32 %f1426, [%rd60]
  f1426 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:2404 sub.f32 %f1427, %f1425, %f1426
  asm("sub.f32 %0, %1, %2;" : "=f"(f1427) : "f"(f1425), "f"(f1426));
  // PTX:2405 mov.b32 %f1428, %r478
  asm("mov.b32 %0, %1;" : "=f"(f1428) : "r"(r478));
  // PTX:2406 ld.global.f32 %f1429, [%rd60+4]
  f1429 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:2407 sub.f32 %f1430, %f1428, %f1429
  asm("sub.f32 %0, %1, %2;" : "=f"(f1430) : "f"(f1428), "f"(f1429));
  // PTX:2408 mov.b32 %f1431, %r477
  asm("mov.b32 %0, %1;" : "=f"(f1431) : "r"(r477));
  // PTX:2409 ld.global.f32 %f1432, [%rd60+8]
  f1432 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:2410 sub.f32 %f1433, %f1431, %f1432
  asm("sub.f32 %0, %1, %2;" : "=f"(f1433) : "f"(f1431), "f"(f1432));
  // PTX:2411 neg.f32 %f1434, %f405
  asm("neg.f32 %0, %1;" : "=f"(f1434) : "f"(f405));
  // PTX:2412 red.global.add.f32 [%rd382], %f1434
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd382) + (0)))), (float)(f1434));
  // PTX:2413 neg.f32 %f1436, %f406
  asm("neg.f32 %0, %1;" : "=f"(f1436) : "f"(f406));
  // PTX:2414 red.global.add.f32 [%rd383], %f1436
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd383) + (0)))), (float)(f1436));
  // PTX:2415 neg.f32 %f1438, %f407
  asm("neg.f32 %0, %1;" : "=f"(f1438) : "f"(f407));
  // PTX:2416 red.global.add.f32 [%rd384], %f1438
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd384) + (0)))), (float)(f1438));
  // PTX:2417 mul.f32 %f1440, %f405, %f1427
  asm("mul.f32 %0, %1, %2;" : "=f"(f1440) : "f"(f405), "f"(f1427));
  // PTX:2418 neg.f32 %f1441, %f1440
  asm("neg.f32 %0, %1;" : "=f"(f1441) : "f"(f1440));
  // PTX:2419 red.global.add.f32 [%rd386], %f1441
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd386) + (0)))), (float)(f1441));
  // PTX:2420 mul.f32 %f1443, %f406, %f1427
  asm("mul.f32 %0, %1, %2;" : "=f"(f1443) : "f"(f406), "f"(f1427));
  // PTX:2421 neg.f32 %f1444, %f1443
  asm("neg.f32 %0, %1;" : "=f"(f1444) : "f"(f1443));
  // PTX:2422 red.global.add.f32 [%rd387], %f1444
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd387) + (0)))), (float)(f1444));
  // PTX:2423 mul.f32 %f1446, %f407, %f1427
  asm("mul.f32 %0, %1, %2;" : "=f"(f1446) : "f"(f407), "f"(f1427));
  // PTX:2424 neg.f32 %f1447, %f1446
  asm("neg.f32 %0, %1;" : "=f"(f1447) : "f"(f1446));
  // PTX:2425 red.global.add.f32 [%rd388], %f1447
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd388) + (0)))), (float)(f1447));
  // PTX:2426 mul.f32 %f1449, %f405, %f1430
  asm("mul.f32 %0, %1, %2;" : "=f"(f1449) : "f"(f405), "f"(f1430));
  // PTX:2427 neg.f32 %f1450, %f1449
  asm("neg.f32 %0, %1;" : "=f"(f1450) : "f"(f1449));
  // PTX:2428 red.global.add.f32 [%rd390], %f1450
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd390) + (0)))), (float)(f1450));
  // PTX:2429 mul.f32 %f1452, %f406, %f1430
  asm("mul.f32 %0, %1, %2;" : "=f"(f1452) : "f"(f406), "f"(f1430));
  // PTX:2430 neg.f32 %f1453, %f1452
  asm("neg.f32 %0, %1;" : "=f"(f1453) : "f"(f1452));
  // PTX:2431 red.global.add.f32 [%rd391], %f1453
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd391) + (0)))), (float)(f1453));
  // PTX:2432 mul.f32 %f1455, %f407, %f1430
  asm("mul.f32 %0, %1, %2;" : "=f"(f1455) : "f"(f407), "f"(f1430));
  // PTX:2433 neg.f32 %f1456, %f1455
  asm("neg.f32 %0, %1;" : "=f"(f1456) : "f"(f1455));
  // PTX:2434 red.global.add.f32 [%rd392], %f1456
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd392) + (0)))), (float)(f1456));
  // PTX:2435 mul.f32 %f1458, %f405, %f1433
  asm("mul.f32 %0, %1, %2;" : "=f"(f1458) : "f"(f405), "f"(f1433));
  // PTX:2436 neg.f32 %f1459, %f1458
  asm("neg.f32 %0, %1;" : "=f"(f1459) : "f"(f1458));
  // PTX:2437 red.global.add.f32 [%rd394], %f1459
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd394) + (0)))), (float)(f1459));
  // PTX:2438 mul.f32 %f1461, %f406, %f1433
  asm("mul.f32 %0, %1, %2;" : "=f"(f1461) : "f"(f406), "f"(f1433));
  // PTX:2439 neg.f32 %f1462, %f1461
  asm("neg.f32 %0, %1;" : "=f"(f1462) : "f"(f1461));
  // PTX:2440 red.global.add.f32 [%rd395], %f1462
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd395) + (0)))), (float)(f1462));
  // PTX:2441 mul.f32 %f1464, %f407, %f1433
  asm("mul.f32 %0, %1, %2;" : "=f"(f1464) : "f"(f407), "f"(f1433));
  // PTX:2442 neg.f32 %f1465, %f1464
  asm("neg.f32 %0, %1;" : "=f"(f1465) : "f"(f1464));
  // PTX:2443 red.global.add.f32 [%rd396], %f1465
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd396) + (0)))), (float)(f1465));
  // PTX:2445 $L__BB2_197:
L_BB2_197:;
  // PTX:2446 ld.param.u64 %rd418, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_33]
  rd418 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param33 + (0))));
  // PTX:2447 setp.eq.s64 %p158, %rd418, 0
  p158 = (((long long)(rd418)) == ((long long)(0)));
  // PTX:2448 or.pred %p159, %p158, %p26
  p159 = ((p158) || (p26));
  // PTX:2449 @%p159 bra $L__BB2_200
  if (p159) { goto L_BB2_200; }
  // PTX:2451 ld.global.f32 %f1467, [%rd59]
  f1467 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:2452 mov.b32 %f1468, %r37
  asm("mov.b32 %0, %1;" : "=f"(f1468) : "r"(r37));
  // PTX:2453 sub.f32 %f1469, %f1468, %f1467
  asm("sub.f32 %0, %1, %2;" : "=f"(f1469) : "f"(f1468), "f"(f1467));
  // PTX:2454 mov.b32 %f1470, %r38
  asm("mov.b32 %0, %1;" : "=f"(f1470) : "r"(r38));
  // PTX:2455 ld.global.f32 %f1471, [%rd59+4]
  f1471 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4)))));
  // PTX:2456 sub.f32 %f1472, %f1470, %f1471
  asm("sub.f32 %0, %1, %2;" : "=f"(f1472) : "f"(f1470), "f"(f1471));
  // PTX:2457 mov.b32 %f1473, %r39
  asm("mov.b32 %0, %1;" : "=f"(f1473) : "r"(r39));
  // PTX:2458 ld.global.f32 %f1474, [%rd59+8]
  f1474 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8)))));
  // PTX:2459 sub.f32 %f1475, %f1473, %f1474
  asm("sub.f32 %0, %1, %2;" : "=f"(f1475) : "f"(f1473), "f"(f1474));
  // PTX:2460 mul.wide.s32 %rd397, %r395, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd397) : "r"(r395));
  // PTX:2461 add.s64 %rd79, %rd2, %rd397
  asm("add.s64 %0, %1, %2;" : "=l"(rd79) : "l"(rd2), "l"(rd397));
  // PTX:2462 red.global.add.f32 [%rd79], %f408
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0)))), (float)(f408));
  // PTX:2463 mul.wide.s32 %rd398, %r396, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd398) : "r"(r396));
  // PTX:2464 add.s64 %rd80, %rd2, %rd398
  asm("add.s64 %0, %1, %2;" : "=l"(rd80) : "l"(rd2), "l"(rd398));
  // PTX:2465 mul.f32 %f1477, %f408, %f1469
  asm("mul.f32 %0, %1, %2;" : "=f"(f1477) : "f"(f408), "f"(f1469));
  // PTX:2466 mul.f32 %f1478, %f1469, %f1477
  asm("mul.f32 %0, %1, %2;" : "=f"(f1478) : "f"(f1469), "f"(f1477));
  // PTX:2467 red.global.add.f32 [%rd80], %f1478
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (0)))), (float)(f1478));
  // PTX:2468 mul.wide.s32 %rd399, %r397, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd399) : "r"(r397));
  // PTX:2469 add.s64 %rd81, %rd2, %rd399
  asm("add.s64 %0, %1, %2;" : "=l"(rd81) : "l"(rd2), "l"(rd399));
  // PTX:2470 mul.f32 %f1480, %f408, %f1472
  asm("mul.f32 %0, %1, %2;" : "=f"(f1480) : "f"(f408), "f"(f1472));
  // PTX:2471 mul.f32 %f1481, %f1472, %f1480
  asm("mul.f32 %0, %1, %2;" : "=f"(f1481) : "f"(f1472), "f"(f1480));
  // PTX:2472 red.global.add.f32 [%rd81], %f1481
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))), (float)(f1481));
  // PTX:2473 mul.wide.s32 %rd400, %r398, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd400) : "r"(r398));
  // PTX:2474 add.s64 %rd82, %rd2, %rd400
  asm("add.s64 %0, %1, %2;" : "=l"(rd82) : "l"(rd2), "l"(rd400));
  // PTX:2475 mul.f32 %f1483, %f408, %f1475
  asm("mul.f32 %0, %1, %2;" : "=f"(f1483) : "f"(f408), "f"(f1475));
  // PTX:2476 mul.f32 %f1484, %f1475, %f1483
  asm("mul.f32 %0, %1, %2;" : "=f"(f1484) : "f"(f1475), "f"(f1483));
  // PTX:2477 red.global.add.f32 [%rd82], %f1484
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (0)))), (float)(f1484));
  // PTX:2478 setp.leu.f32 %p160, %f409, 0f00000000
  p160 = ((isnan(((float)(f409))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f409)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:2479 @%p160 bra $L__BB2_200
  if (p160) { goto L_BB2_200; }
  // PTX:2481 ld.global.f32 %f1486, [%rd59]
  f1486 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:2482 mov.b32 %f1487, %r448
  asm("mov.b32 %0, %1;" : "=f"(f1487) : "r"(r448));
  // PTX:2483 sub.f32 %f1488, %f1487, %f1486
  asm("sub.f32 %0, %1, %2;" : "=f"(f1488) : "f"(f1487), "f"(f1486));
  // PTX:2484 mov.b32 %f1489, %r447
  asm("mov.b32 %0, %1;" : "=f"(f1489) : "r"(r447));
  // PTX:2485 ld.global.f32 %f1490, [%rd59+4]
  f1490 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4)))));
  // PTX:2486 sub.f32 %f1491, %f1489, %f1490
  asm("sub.f32 %0, %1, %2;" : "=f"(f1491) : "f"(f1489), "f"(f1490));
  // PTX:2487 mov.b32 %f1492, %r446
  asm("mov.b32 %0, %1;" : "=f"(f1492) : "r"(r446));
  // PTX:2488 ld.global.f32 %f1493, [%rd59+8]
  f1493 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8)))));
  // PTX:2489 sub.f32 %f1494, %f1492, %f1493
  asm("sub.f32 %0, %1, %2;" : "=f"(f1494) : "f"(f1492), "f"(f1493));
  // PTX:2490 red.global.add.f32 [%rd79], %f409
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0)))), (float)(f409));
  // PTX:2491 mul.f32 %f1496, %f409, %f1488
  asm("mul.f32 %0, %1, %2;" : "=f"(f1496) : "f"(f409), "f"(f1488));
  // PTX:2492 mul.f32 %f1497, %f1488, %f1496
  asm("mul.f32 %0, %1, %2;" : "=f"(f1497) : "f"(f1488), "f"(f1496));
  // PTX:2493 red.global.add.f32 [%rd80], %f1497
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (0)))), (float)(f1497));
  // PTX:2494 mul.f32 %f1499, %f409, %f1491
  asm("mul.f32 %0, %1, %2;" : "=f"(f1499) : "f"(f409), "f"(f1491));
  // PTX:2495 mul.f32 %f1500, %f1491, %f1499
  asm("mul.f32 %0, %1, %2;" : "=f"(f1500) : "f"(f1491), "f"(f1499));
  // PTX:2496 red.global.add.f32 [%rd81], %f1500
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))), (float)(f1500));
  // PTX:2497 mul.f32 %f1502, %f409, %f1494
  asm("mul.f32 %0, %1, %2;" : "=f"(f1502) : "f"(f409), "f"(f1494));
  // PTX:2498 mul.f32 %f1503, %f1494, %f1502
  asm("mul.f32 %0, %1, %2;" : "=f"(f1503) : "f"(f1494), "f"(f1502));
  // PTX:2499 red.global.add.f32 [%rd82], %f1503
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (0)))), (float)(f1503));
  // PTX:2501 $L__BB2_200:
L_BB2_200:;
  // PTX:2502 or.pred %p163, %p158, %p29
  p163 = ((p158) || (p29));
  // PTX:2503 @%p163 bra $L__BB2_203
  if (p163) { goto L_BB2_203; }
  // PTX:2505 ld.global.f32 %f1505, [%rd60]
  f1505 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:2506 mov.b32 %f1506, %r40
  asm("mov.b32 %0, %1;" : "=f"(f1506) : "r"(r40));
  // PTX:2507 sub.f32 %f1507, %f1506, %f1505
  asm("sub.f32 %0, %1, %2;" : "=f"(f1507) : "f"(f1506), "f"(f1505));
  // PTX:2508 mov.b32 %f1508, %r41
  asm("mov.b32 %0, %1;" : "=f"(f1508) : "r"(r41));
  // PTX:2509 ld.global.f32 %f1509, [%rd60+4]
  f1509 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:2510 sub.f32 %f1510, %f1508, %f1509
  asm("sub.f32 %0, %1, %2;" : "=f"(f1510) : "f"(f1508), "f"(f1509));
  // PTX:2511 mov.b32 %f1511, %r42
  asm("mov.b32 %0, %1;" : "=f"(f1511) : "r"(r42));
  // PTX:2512 ld.global.f32 %f1512, [%rd60+8]
  f1512 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:2513 sub.f32 %f1513, %f1511, %f1512
  asm("sub.f32 %0, %1, %2;" : "=f"(f1513) : "f"(f1511), "f"(f1512));
  // PTX:2514 mul.wide.s32 %rd401, %r399, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd401) : "r"(r399));
  // PTX:2515 add.s64 %rd83, %rd2, %rd401
  asm("add.s64 %0, %1, %2;" : "=l"(rd83) : "l"(rd2), "l"(rd401));
  // PTX:2516 red.global.add.f32 [%rd83], %f408
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0)))), (float)(f408));
  // PTX:2517 mul.wide.s32 %rd402, %r400, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd402) : "r"(r400));
  // PTX:2518 add.s64 %rd84, %rd2, %rd402
  asm("add.s64 %0, %1, %2;" : "=l"(rd84) : "l"(rd2), "l"(rd402));
  // PTX:2519 mul.f32 %f1515, %f408, %f1507
  asm("mul.f32 %0, %1, %2;" : "=f"(f1515) : "f"(f408), "f"(f1507));
  // PTX:2520 mul.f32 %f1516, %f1507, %f1515
  asm("mul.f32 %0, %1, %2;" : "=f"(f1516) : "f"(f1507), "f"(f1515));
  // PTX:2521 red.global.add.f32 [%rd84], %f1516
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0)))), (float)(f1516));
  // PTX:2522 mul.wide.s32 %rd403, %r401, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd403) : "r"(r401));
  // PTX:2523 add.s64 %rd85, %rd2, %rd403
  asm("add.s64 %0, %1, %2;" : "=l"(rd85) : "l"(rd2), "l"(rd403));
  // PTX:2524 mul.f32 %f1518, %f408, %f1510
  asm("mul.f32 %0, %1, %2;" : "=f"(f1518) : "f"(f408), "f"(f1510));
  // PTX:2525 mul.f32 %f1519, %f1510, %f1518
  asm("mul.f32 %0, %1, %2;" : "=f"(f1519) : "f"(f1510), "f"(f1518));
  // PTX:2526 red.global.add.f32 [%rd85], %f1519
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0)))), (float)(f1519));
  // PTX:2527 mul.wide.s32 %rd404, %r402, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd404) : "r"(r402));
  // PTX:2528 add.s64 %rd86, %rd2, %rd404
  asm("add.s64 %0, %1, %2;" : "=l"(rd86) : "l"(rd2), "l"(rd404));
  // PTX:2529 mul.f32 %f1521, %f408, %f1513
  asm("mul.f32 %0, %1, %2;" : "=f"(f1521) : "f"(f408), "f"(f1513));
  // PTX:2530 mul.f32 %f1522, %f1513, %f1521
  asm("mul.f32 %0, %1, %2;" : "=f"(f1522) : "f"(f1513), "f"(f1521));
  // PTX:2531 red.global.add.f32 [%rd86], %f1522
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (0)))), (float)(f1522));
  // PTX:2532 setp.leu.f32 %p164, %f409, 0f00000000
  p164 = ((isnan(((float)(f409))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f409)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:2533 @%p164 bra $L__BB2_203
  if (p164) { goto L_BB2_203; }
  // PTX:2535 ld.global.f32 %f1524, [%rd60]
  f1524 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:2536 mov.b32 %f1525, %r479
  asm("mov.b32 %0, %1;" : "=f"(f1525) : "r"(r479));
  // PTX:2537 sub.f32 %f1526, %f1525, %f1524
  asm("sub.f32 %0, %1, %2;" : "=f"(f1526) : "f"(f1525), "f"(f1524));
  // PTX:2538 mov.b32 %f1527, %r478
  asm("mov.b32 %0, %1;" : "=f"(f1527) : "r"(r478));
  // PTX:2539 ld.global.f32 %f1528, [%rd60+4]
  f1528 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:2540 sub.f32 %f1529, %f1527, %f1528
  asm("sub.f32 %0, %1, %2;" : "=f"(f1529) : "f"(f1527), "f"(f1528));
  // PTX:2541 mov.b32 %f1530, %r477
  asm("mov.b32 %0, %1;" : "=f"(f1530) : "r"(r477));
  // PTX:2542 ld.global.f32 %f1531, [%rd60+8]
  f1531 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:2543 sub.f32 %f1532, %f1530, %f1531
  asm("sub.f32 %0, %1, %2;" : "=f"(f1532) : "f"(f1530), "f"(f1531));
  // PTX:2544 red.global.add.f32 [%rd83], %f409
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0)))), (float)(f409));
  // PTX:2545 mul.f32 %f1534, %f409, %f1526
  asm("mul.f32 %0, %1, %2;" : "=f"(f1534) : "f"(f409), "f"(f1526));
  // PTX:2546 mul.f32 %f1535, %f1526, %f1534
  asm("mul.f32 %0, %1, %2;" : "=f"(f1535) : "f"(f1526), "f"(f1534));
  // PTX:2547 red.global.add.f32 [%rd84], %f1535
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0)))), (float)(f1535));
  // PTX:2548 mul.f32 %f1537, %f409, %f1529
  asm("mul.f32 %0, %1, %2;" : "=f"(f1537) : "f"(f409), "f"(f1529));
  // PTX:2549 mul.f32 %f1538, %f1529, %f1537
  asm("mul.f32 %0, %1, %2;" : "=f"(f1538) : "f"(f1529), "f"(f1537));
  // PTX:2550 red.global.add.f32 [%rd85], %f1538
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0)))), (float)(f1538));
  // PTX:2551 mul.f32 %f1540, %f409, %f1532
  asm("mul.f32 %0, %1, %2;" : "=f"(f1540) : "f"(f409), "f"(f1532));
  // PTX:2552 mul.f32 %f1541, %f1532, %f1540
  asm("mul.f32 %0, %1, %2;" : "=f"(f1541) : "f"(f1532), "f"(f1540));
  // PTX:2553 red.global.add.f32 [%rd86], %f1541
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (0)))), (float)(f1541));
  // PTX:2554 bra.uni $L__BB2_203
  goto L_BB2_203;
  // PTX:2556 $L__BB2_185:
L_BB2_185:;
  // PTX:2557 ld.param.u64 %rd415, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_32]
  rd415 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param32 + (0))));
  // PTX:2558 add.f32 %f410, %f402, %f405
  asm("add.f32 %0, %1, %2;" : "=f"(f410) : "f"(f402), "f"(f405));
  // PTX:2559 add.f32 %f411, %f403, %f406
  asm("add.f32 %0, %1, %2;" : "=f"(f411) : "f"(f403), "f"(f406));
  // PTX:2560 add.f32 %f412, %f404, %f407
  asm("add.f32 %0, %1, %2;" : "=f"(f412) : "f"(f404), "f"(f407));
  // PTX:2561 setp.eq.s64 %p140, %rd415, 0
  p140 = (((long long)(rd415)) == ((long long)(0)));
  // PTX:2562 or.pred %p141, %p140, %p26
  p141 = ((p140) || (p26));
  // PTX:2563 @%p141 bra $L__BB2_187
  if (p141) { goto L_BB2_187; }
  // PTX:2565 ld.global.f32 %f1211, [%rd59]
  f1211 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:2566 ld.global.f32 %f1212, [%rd61]
  f1212 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))));
  // PTX:2567 sub.f32 %f1213, %f1212, %f1211
  asm("sub.f32 %0, %1, %2;" : "=f"(f1213) : "f"(f1212), "f"(f1211));
  // PTX:2568 ld.global.f32 %f1214, [%rd61+4]
  f1214 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (4)))));
  // PTX:2569 ld.global.f32 %f1215, [%rd59+4]
  f1215 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4)))));
  // PTX:2570 sub.f32 %f1216, %f1214, %f1215
  asm("sub.f32 %0, %1, %2;" : "=f"(f1216) : "f"(f1214), "f"(f1215));
  // PTX:2571 ld.global.f32 %f1217, [%rd61+8]
  f1217 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (8)))));
  // PTX:2572 ld.global.f32 %f1218, [%rd59+8]
  f1218 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8)))));
  // PTX:2573 sub.f32 %f1219, %f1217, %f1218
  asm("sub.f32 %0, %1, %2;" : "=f"(f1219) : "f"(f1217), "f"(f1218));
  // PTX:2574 mul.wide.s32 %rd317, %r395, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd317) : "r"(r395));
  // PTX:2575 add.s64 %rd318, %rd1, %rd317
  asm("add.s64 %0, %1, %2;" : "=l"(rd318) : "l"(rd1), "l"(rd317));
  // PTX:2576 red.global.add.f32 [%rd318], %f410
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd318) + (0)))), (float)(f410));
  // PTX:2577 add.s64 %rd319, %rd318, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd319) : "l"(rd318));
  // PTX:2578 red.global.add.f32 [%rd319], %f411
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd319) + (0)))), (float)(f411));
  // PTX:2579 add.s64 %rd320, %rd318, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd320) : "l"(rd318));
  // PTX:2580 red.global.add.f32 [%rd320], %f412
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd320) + (0)))), (float)(f412));
  // PTX:2581 mul.wide.s32 %rd321, %r396, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd321) : "r"(r396));
  // PTX:2582 add.s64 %rd322, %rd1, %rd321
  asm("add.s64 %0, %1, %2;" : "=l"(rd322) : "l"(rd1), "l"(rd321));
  // PTX:2583 mul.f32 %f1223, %f410, %f1213
  asm("mul.f32 %0, %1, %2;" : "=f"(f1223) : "f"(f410), "f"(f1213));
  // PTX:2584 red.global.add.f32 [%rd322], %f1223
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd322) + (0)))), (float)(f1223));
  // PTX:2585 add.s64 %rd323, %rd322, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd323) : "l"(rd322));
  // PTX:2586 mul.f32 %f1225, %f411, %f1213
  asm("mul.f32 %0, %1, %2;" : "=f"(f1225) : "f"(f411), "f"(f1213));
  // PTX:2587 red.global.add.f32 [%rd323], %f1225
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd323) + (0)))), (float)(f1225));
  // PTX:2588 add.s64 %rd324, %rd322, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd324) : "l"(rd322));
  // PTX:2589 mul.f32 %f1227, %f412, %f1213
  asm("mul.f32 %0, %1, %2;" : "=f"(f1227) : "f"(f412), "f"(f1213));
  // PTX:2590 red.global.add.f32 [%rd324], %f1227
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd324) + (0)))), (float)(f1227));
  // PTX:2591 mul.wide.s32 %rd325, %r397, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd325) : "r"(r397));
  // PTX:2592 add.s64 %rd326, %rd1, %rd325
  asm("add.s64 %0, %1, %2;" : "=l"(rd326) : "l"(rd1), "l"(rd325));
  // PTX:2593 mul.f32 %f1229, %f410, %f1216
  asm("mul.f32 %0, %1, %2;" : "=f"(f1229) : "f"(f410), "f"(f1216));
  // PTX:2594 red.global.add.f32 [%rd326], %f1229
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd326) + (0)))), (float)(f1229));
  // PTX:2595 add.s64 %rd327, %rd326, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd327) : "l"(rd326));
  // PTX:2596 mul.f32 %f1231, %f411, %f1216
  asm("mul.f32 %0, %1, %2;" : "=f"(f1231) : "f"(f411), "f"(f1216));
  // PTX:2597 red.global.add.f32 [%rd327], %f1231
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd327) + (0)))), (float)(f1231));
  // PTX:2598 add.s64 %rd328, %rd326, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd328) : "l"(rd326));
  // PTX:2599 mul.f32 %f1233, %f412, %f1216
  asm("mul.f32 %0, %1, %2;" : "=f"(f1233) : "f"(f412), "f"(f1216));
  // PTX:2600 red.global.add.f32 [%rd328], %f1233
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd328) + (0)))), (float)(f1233));
  // PTX:2601 mul.wide.s32 %rd329, %r398, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd329) : "r"(r398));
  // PTX:2602 add.s64 %rd330, %rd1, %rd329
  asm("add.s64 %0, %1, %2;" : "=l"(rd330) : "l"(rd1), "l"(rd329));
  // PTX:2603 mul.f32 %f1235, %f410, %f1219
  asm("mul.f32 %0, %1, %2;" : "=f"(f1235) : "f"(f410), "f"(f1219));
  // PTX:2604 red.global.add.f32 [%rd330], %f1235
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd330) + (0)))), (float)(f1235));
  // PTX:2605 add.s64 %rd331, %rd330, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd331) : "l"(rd330));
  // PTX:2606 mul.f32 %f1237, %f411, %f1219
  asm("mul.f32 %0, %1, %2;" : "=f"(f1237) : "f"(f411), "f"(f1219));
  // PTX:2607 red.global.add.f32 [%rd331], %f1237
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd331) + (0)))), (float)(f1237));
  // PTX:2608 add.s64 %rd332, %rd330, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd332) : "l"(rd330));
  // PTX:2609 mul.f32 %f1239, %f412, %f1219
  asm("mul.f32 %0, %1, %2;" : "=f"(f1239) : "f"(f412), "f"(f1219));
  // PTX:2610 red.global.add.f32 [%rd332], %f1239
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd332) + (0)))), (float)(f1239));
  // PTX:2612 $L__BB2_187:
L_BB2_187:;
  // PTX:2613 or.pred %p144, %p140, %p29
  p144 = ((p140) || (p29));
  // PTX:2614 @%p144 bra $L__BB2_189
  if (p144) { goto L_BB2_189; }
  // PTX:2616 ld.global.f32 %f1241, [%rd60]
  f1241 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:2617 ld.global.f32 %f1242, [%rd62]
  f1242 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))));
  // PTX:2618 sub.f32 %f1243, %f1242, %f1241
  asm("sub.f32 %0, %1, %2;" : "=f"(f1243) : "f"(f1242), "f"(f1241));
  // PTX:2619 ld.global.f32 %f1244, [%rd62+4]
  f1244 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (4)))));
  // PTX:2620 ld.global.f32 %f1245, [%rd60+4]
  f1245 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:2621 sub.f32 %f1246, %f1244, %f1245
  asm("sub.f32 %0, %1, %2;" : "=f"(f1246) : "f"(f1244), "f"(f1245));
  // PTX:2622 ld.global.f32 %f1247, [%rd62+8]
  f1247 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (8)))));
  // PTX:2623 ld.global.f32 %f1248, [%rd60+8]
  f1248 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:2624 sub.f32 %f1249, %f1247, %f1248
  asm("sub.f32 %0, %1, %2;" : "=f"(f1249) : "f"(f1247), "f"(f1248));
  // PTX:2625 mul.wide.s32 %rd333, %r399, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd333) : "r"(r399));
  // PTX:2626 add.s64 %rd334, %rd1, %rd333
  asm("add.s64 %0, %1, %2;" : "=l"(rd334) : "l"(rd1), "l"(rd333));
  // PTX:2627 neg.f32 %f1250, %f410
  asm("neg.f32 %0, %1;" : "=f"(f1250) : "f"(f410));
  // PTX:2628 red.global.add.f32 [%rd334], %f1250
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd334) + (0)))), (float)(f1250));
  // PTX:2629 add.s64 %rd335, %rd334, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd335) : "l"(rd334));
  // PTX:2630 neg.f32 %f1252, %f411
  asm("neg.f32 %0, %1;" : "=f"(f1252) : "f"(f411));
  // PTX:2631 red.global.add.f32 [%rd335], %f1252
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd335) + (0)))), (float)(f1252));
  // PTX:2632 add.s64 %rd336, %rd334, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd336) : "l"(rd334));
  // PTX:2633 neg.f32 %f1254, %f412
  asm("neg.f32 %0, %1;" : "=f"(f1254) : "f"(f412));
  // PTX:2634 red.global.add.f32 [%rd336], %f1254
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd336) + (0)))), (float)(f1254));
  // PTX:2635 mul.wide.s32 %rd337, %r400, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd337) : "r"(r400));
  // PTX:2636 add.s64 %rd338, %rd1, %rd337
  asm("add.s64 %0, %1, %2;" : "=l"(rd338) : "l"(rd1), "l"(rd337));
  // PTX:2637 mul.f32 %f1256, %f410, %f1243
  asm("mul.f32 %0, %1, %2;" : "=f"(f1256) : "f"(f410), "f"(f1243));
  // PTX:2638 neg.f32 %f1257, %f1256
  asm("neg.f32 %0, %1;" : "=f"(f1257) : "f"(f1256));
  // PTX:2639 red.global.add.f32 [%rd338], %f1257
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd338) + (0)))), (float)(f1257));
  // PTX:2640 add.s64 %rd339, %rd338, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd339) : "l"(rd338));
  // PTX:2641 mul.f32 %f1259, %f411, %f1243
  asm("mul.f32 %0, %1, %2;" : "=f"(f1259) : "f"(f411), "f"(f1243));
  // PTX:2642 neg.f32 %f1260, %f1259
  asm("neg.f32 %0, %1;" : "=f"(f1260) : "f"(f1259));
  // PTX:2643 red.global.add.f32 [%rd339], %f1260
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd339) + (0)))), (float)(f1260));
  // PTX:2644 add.s64 %rd340, %rd338, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd340) : "l"(rd338));
  // PTX:2645 mul.f32 %f1262, %f412, %f1243
  asm("mul.f32 %0, %1, %2;" : "=f"(f1262) : "f"(f412), "f"(f1243));
  // PTX:2646 neg.f32 %f1263, %f1262
  asm("neg.f32 %0, %1;" : "=f"(f1263) : "f"(f1262));
  // PTX:2647 red.global.add.f32 [%rd340], %f1263
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd340) + (0)))), (float)(f1263));
  // PTX:2648 mul.wide.s32 %rd341, %r401, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd341) : "r"(r401));
  // PTX:2649 add.s64 %rd342, %rd1, %rd341
  asm("add.s64 %0, %1, %2;" : "=l"(rd342) : "l"(rd1), "l"(rd341));
  // PTX:2650 mul.f32 %f1265, %f410, %f1246
  asm("mul.f32 %0, %1, %2;" : "=f"(f1265) : "f"(f410), "f"(f1246));
  // PTX:2651 neg.f32 %f1266, %f1265
  asm("neg.f32 %0, %1;" : "=f"(f1266) : "f"(f1265));
  // PTX:2652 red.global.add.f32 [%rd342], %f1266
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd342) + (0)))), (float)(f1266));
  // PTX:2653 add.s64 %rd343, %rd342, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd343) : "l"(rd342));
  // PTX:2654 mul.f32 %f1268, %f411, %f1246
  asm("mul.f32 %0, %1, %2;" : "=f"(f1268) : "f"(f411), "f"(f1246));
  // PTX:2655 neg.f32 %f1269, %f1268
  asm("neg.f32 %0, %1;" : "=f"(f1269) : "f"(f1268));
  // PTX:2656 red.global.add.f32 [%rd343], %f1269
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd343) + (0)))), (float)(f1269));
  // PTX:2657 add.s64 %rd344, %rd342, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd344) : "l"(rd342));
  // PTX:2658 mul.f32 %f1271, %f412, %f1246
  asm("mul.f32 %0, %1, %2;" : "=f"(f1271) : "f"(f412), "f"(f1246));
  // PTX:2659 neg.f32 %f1272, %f1271
  asm("neg.f32 %0, %1;" : "=f"(f1272) : "f"(f1271));
  // PTX:2660 red.global.add.f32 [%rd344], %f1272
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd344) + (0)))), (float)(f1272));
  // PTX:2661 mul.wide.s32 %rd345, %r402, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd345) : "r"(r402));
  // PTX:2662 add.s64 %rd346, %rd1, %rd345
  asm("add.s64 %0, %1, %2;" : "=l"(rd346) : "l"(rd1), "l"(rd345));
  // PTX:2663 mul.f32 %f1274, %f410, %f1249
  asm("mul.f32 %0, %1, %2;" : "=f"(f1274) : "f"(f410), "f"(f1249));
  // PTX:2664 neg.f32 %f1275, %f1274
  asm("neg.f32 %0, %1;" : "=f"(f1275) : "f"(f1274));
  // PTX:2665 red.global.add.f32 [%rd346], %f1275
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd346) + (0)))), (float)(f1275));
  // PTX:2666 add.s64 %rd347, %rd346, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd347) : "l"(rd346));
  // PTX:2667 mul.f32 %f1277, %f411, %f1249
  asm("mul.f32 %0, %1, %2;" : "=f"(f1277) : "f"(f411), "f"(f1249));
  // PTX:2668 neg.f32 %f1278, %f1277
  asm("neg.f32 %0, %1;" : "=f"(f1278) : "f"(f1277));
  // PTX:2669 red.global.add.f32 [%rd347], %f1278
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd347) + (0)))), (float)(f1278));
  // PTX:2670 add.s64 %rd348, %rd346, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd348) : "l"(rd346));
  // PTX:2671 mul.f32 %f1280, %f412, %f1249
  asm("mul.f32 %0, %1, %2;" : "=f"(f1280) : "f"(f412), "f"(f1249));
  // PTX:2672 neg.f32 %f1281, %f1280
  asm("neg.f32 %0, %1;" : "=f"(f1281) : "f"(f1280));
  // PTX:2673 red.global.add.f32 [%rd348], %f1281
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd348) + (0)))), (float)(f1281));
  // PTX:2675 $L__BB2_189:
L_BB2_189:;
  // PTX:2676 ld.param.u64 %rd416, [_ZN7synreal6kernel22evaluate_contact_forceEPKimS2_S2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_S8_S8_S8_PKfSA_S2_S2_PKNS_9TransformES8_SA_SA_SA_SA_fmmmS2_PKNS4_ILi4EiLS5_0EEES8_mmS8_S8_S8_fPS6_Pf_param_33]
  rd416 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param33 + (0))));
  // PTX:2677 setp.eq.s64 %p146, %rd416, 0
  p146 = (((long long)(rd416)) == ((long long)(0)));
  // PTX:2678 or.pred %p147, %p146, %p26
  p147 = ((p146) || (p26));
  // PTX:2679 @%p147 bra $L__BB2_191
  if (p147) { goto L_BB2_191; }
  // PTX:2681 ld.global.f32 %f1283, [%rd59]
  f1283 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (0)))));
  // PTX:2682 ld.global.f32 %f1284, [%rd61]
  f1284 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))));
  // PTX:2683 sub.f32 %f1285, %f1284, %f1283
  asm("sub.f32 %0, %1, %2;" : "=f"(f1285) : "f"(f1284), "f"(f1283));
  // PTX:2684 ld.global.f32 %f1286, [%rd61+4]
  f1286 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (4)))));
  // PTX:2685 ld.global.f32 %f1287, [%rd59+4]
  f1287 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (4)))));
  // PTX:2686 sub.f32 %f1288, %f1286, %f1287
  asm("sub.f32 %0, %1, %2;" : "=f"(f1288) : "f"(f1286), "f"(f1287));
  // PTX:2687 ld.global.f32 %f1289, [%rd61+8]
  f1289 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (8)))));
  // PTX:2688 ld.global.f32 %f1290, [%rd59+8]
  f1290 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd59) + (8)))));
  // PTX:2689 sub.f32 %f1291, %f1289, %f1290
  asm("sub.f32 %0, %1, %2;" : "=f"(f1291) : "f"(f1289), "f"(f1290));
  // PTX:2690 mul.wide.s32 %rd349, %r395, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd349) : "r"(r395));
  // PTX:2691 add.s64 %rd350, %rd2, %rd349
  asm("add.s64 %0, %1, %2;" : "=l"(rd350) : "l"(rd2), "l"(rd349));
  // PTX:2692 max.f32 %f1292, %f408, %f409
  asm("max.f32 %0, %1, %2;" : "=f"(f1292) : "f"(f408), "f"(f409));
  // PTX:2693 red.global.add.f32 [%rd350], %f1292
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd350) + (0)))), (float)(f1292));
  // PTX:2694 mul.wide.s32 %rd351, %r396, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd351) : "r"(r396));
  // PTX:2695 add.s64 %rd352, %rd2, %rd351
  asm("add.s64 %0, %1, %2;" : "=l"(rd352) : "l"(rd2), "l"(rd351));
  // PTX:2696 mul.f32 %f1294, %f1292, %f1285
  asm("mul.f32 %0, %1, %2;" : "=f"(f1294) : "f"(f1292), "f"(f1285));
  // PTX:2697 mul.f32 %f1295, %f1285, %f1294
  asm("mul.f32 %0, %1, %2;" : "=f"(f1295) : "f"(f1285), "f"(f1294));
  // PTX:2698 red.global.add.f32 [%rd352], %f1295
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd352) + (0)))), (float)(f1295));
  // PTX:2699 mul.wide.s32 %rd353, %r397, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd353) : "r"(r397));
  // PTX:2700 add.s64 %rd354, %rd2, %rd353
  asm("add.s64 %0, %1, %2;" : "=l"(rd354) : "l"(rd2), "l"(rd353));
  // PTX:2701 mul.f32 %f1297, %f1292, %f1288
  asm("mul.f32 %0, %1, %2;" : "=f"(f1297) : "f"(f1292), "f"(f1288));
  // PTX:2702 mul.f32 %f1298, %f1288, %f1297
  asm("mul.f32 %0, %1, %2;" : "=f"(f1298) : "f"(f1288), "f"(f1297));
  // PTX:2703 red.global.add.f32 [%rd354], %f1298
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd354) + (0)))), (float)(f1298));
  // PTX:2704 mul.wide.s32 %rd355, %r398, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd355) : "r"(r398));
  // PTX:2705 add.s64 %rd356, %rd2, %rd355
  asm("add.s64 %0, %1, %2;" : "=l"(rd356) : "l"(rd2), "l"(rd355));
  // PTX:2706 mul.f32 %f1300, %f1292, %f1291
  asm("mul.f32 %0, %1, %2;" : "=f"(f1300) : "f"(f1292), "f"(f1291));
  // PTX:2707 mul.f32 %f1301, %f1291, %f1300
  asm("mul.f32 %0, %1, %2;" : "=f"(f1301) : "f"(f1291), "f"(f1300));
  // PTX:2708 red.global.add.f32 [%rd356], %f1301
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd356) + (0)))), (float)(f1301));
  // PTX:2710 $L__BB2_191:
L_BB2_191:;
  // PTX:2711 or.pred %p150, %p146, %p29
  p150 = ((p146) || (p29));
  // PTX:2712 @%p150 bra $L__BB2_203
  if (p150) { goto L_BB2_203; }
  // PTX:2714 ld.global.f32 %f1303, [%rd60]
  f1303 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:2715 ld.global.f32 %f1304, [%rd62]
  f1304 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))));
  // PTX:2716 sub.f32 %f1305, %f1304, %f1303
  asm("sub.f32 %0, %1, %2;" : "=f"(f1305) : "f"(f1304), "f"(f1303));
  // PTX:2717 ld.global.f32 %f1306, [%rd62+4]
  f1306 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (4)))));
  // PTX:2718 ld.global.f32 %f1307, [%rd60+4]
  f1307 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:2719 sub.f32 %f1308, %f1306, %f1307
  asm("sub.f32 %0, %1, %2;" : "=f"(f1308) : "f"(f1306), "f"(f1307));
  // PTX:2720 ld.global.f32 %f1309, [%rd62+8]
  f1309 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (8)))));
  // PTX:2721 ld.global.f32 %f1310, [%rd60+8]
  f1310 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:2722 sub.f32 %f1311, %f1309, %f1310
  asm("sub.f32 %0, %1, %2;" : "=f"(f1311) : "f"(f1309), "f"(f1310));
  // PTX:2723 mul.wide.s32 %rd357, %r399, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd357) : "r"(r399));
  // PTX:2724 add.s64 %rd358, %rd2, %rd357
  asm("add.s64 %0, %1, %2;" : "=l"(rd358) : "l"(rd2), "l"(rd357));
  // PTX:2725 max.f32 %f1312, %f408, %f409
  asm("max.f32 %0, %1, %2;" : "=f"(f1312) : "f"(f408), "f"(f409));
  // PTX:2726 red.global.add.f32 [%rd358], %f1312
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd358) + (0)))), (float)(f1312));
  // PTX:2727 mul.wide.s32 %rd359, %r400, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd359) : "r"(r400));
  // PTX:2728 add.s64 %rd360, %rd2, %rd359
  asm("add.s64 %0, %1, %2;" : "=l"(rd360) : "l"(rd2), "l"(rd359));
  // PTX:2729 mul.f32 %f1314, %f1312, %f1305
  asm("mul.f32 %0, %1, %2;" : "=f"(f1314) : "f"(f1312), "f"(f1305));
  // PTX:2730 mul.f32 %f1315, %f1305, %f1314
  asm("mul.f32 %0, %1, %2;" : "=f"(f1315) : "f"(f1305), "f"(f1314));
  // PTX:2731 red.global.add.f32 [%rd360], %f1315
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd360) + (0)))), (float)(f1315));
  // PTX:2732 mul.wide.s32 %rd361, %r401, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd361) : "r"(r401));
  // PTX:2733 add.s64 %rd362, %rd2, %rd361
  asm("add.s64 %0, %1, %2;" : "=l"(rd362) : "l"(rd2), "l"(rd361));
  // PTX:2734 mul.f32 %f1317, %f1312, %f1308
  asm("mul.f32 %0, %1, %2;" : "=f"(f1317) : "f"(f1312), "f"(f1308));
  // PTX:2735 mul.f32 %f1318, %f1308, %f1317
  asm("mul.f32 %0, %1, %2;" : "=f"(f1318) : "f"(f1308), "f"(f1317));
  // PTX:2736 red.global.add.f32 [%rd362], %f1318
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd362) + (0)))), (float)(f1318));
  // PTX:2737 mul.wide.s32 %rd363, %r402, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd363) : "r"(r402));
  // PTX:2738 add.s64 %rd364, %rd2, %rd363
  asm("add.s64 %0, %1, %2;" : "=l"(rd364) : "l"(rd2), "l"(rd363));
  // PTX:2739 mul.f32 %f1320, %f1312, %f1311
  asm("mul.f32 %0, %1, %2;" : "=f"(f1320) : "f"(f1312), "f"(f1311));
  // PTX:2740 mul.f32 %f1321, %f1311, %f1320
  asm("mul.f32 %0, %1, %2;" : "=f"(f1321) : "f"(f1311), "f"(f1320));
  // PTX:2741 red.global.add.f32 [%rd364], %f1321
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd364) + (0)))), (float)(f1321));
  // PTX:2743 $L__BB2_203:
L_BB2_203:;
  // PTX:2744 ret
  return;
}
