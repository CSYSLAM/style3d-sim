// 机械还原自 PTX：synreal::kernel::evaluate_surface_contact_force(synreal::kernel::SurfaceContactView, glm::vec<3, float, (glm::qualifier)0>*)
// PTX SHA256: 3188081efccb6852649e475204f69b4ee485c881c87045ba7fd5111e39e0dfca
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_surface_contact_force(ByVal<296, 8> param0, unsigned long long param1) {
  unsigned long long SP, SPL, rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162, rd163, rd164, rd165, rd166, rd167, rd168, rd169, rd170, rd171, rd172, rd173, rd174, rd175, rd176, rd177, rd178, rd179, rd180, rd181, rd182, rd183, rd184, rd185, rd186, rd187, rd188, rd189, rd190, rd191, rd192, rd193, rd194, rd195, rd196, rd197, rd198, rd199, rd200, rd201, rd202, rd203, rd204, rd205, rd206, rd207, rd208, rd209, rd210, rd211, rd212, rd213, rd214, rd215, rd216, rd217, rd218, rd219, rd220, rd221, rd222, rd223, rd224, rd225, rd226, rd227, rd228, rd229, rd230, rd231, rd232, rd233, rd234, rd235, rd236, rd237, rd238, rd239, rd240, rd241, rd242, rd243, rd244, rd245, rd246, rd247, rd248, rd249, rd250, rd251, rd252, rd253, rd254, rd255, rd256, rd257, rd258, rd259, rd260, rd261, rd262, rd263, rd264, rd265, rd266, rd267, rd268, rd269, rd270, rd271, rd272, rd273, rd274, rd275, rd276, rd277, rd278, rd279, rd280, rd281, rd282, rd283, rd284, rd285, rd286, rd287, rd288, rd289, rd290, rd291, rd292, rd293, rd294, rd295, rd296, rd297, rd298, rd299, rd300, rd301, rd302, rd303, rd304, rd305, rd306, rd307, rd308, rd309, rd310, rd311, rd312, rd313, rd314, rd315, rd316, rd317, rd318, rd319, rd320, rd321, rd322, rd323, rd324, rd325, rd326, rd327, rd328, rd329, rd330, rd331, rd332, rd333, rd334, rd335, rd336, rd337, rd338, rd339, rd340, rd341, rd342, rd343, rd344, rd345, rd346, rd347, rd348, rd349, rd350, rd351, rd352, rd353, rd354, rd355, rd356, rd357, rd358, rd359, rd360, rd361, rd362, rd363, rd364, rd365, rd366, rd367, rd368, rd369, rd370, rd371, rd372, rd373, rd374, rd375, rd376, rd377, rd378, rd379, rd380, rd381, rd382, rd383, rd384, rd385, rd386, rd387, rd388, rd389, rd390, rd391, rd392, rd393, rd394, rd395, rd396, rd397, rd398, rd399, rd400, rd401, rd402, rd403, rd404, rd405, rd406, rd407, rd408, rd409;
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62, p63, p64, p65, p66, p67, p68, p69, p70, p71, p72, p73, p74, p75, p76, p77, p78, p79, p80, p81, p82, p83, p84, p85, p86, p87, p88, p89, p90, p91, p92, p93, p94, p95, p96, p97, p98, p99, p100, p101, p102, p103, p104, p105, p106, p107, p108, p109, p110, p111, p112, p113, p114, p115, p116, p117, p118, p119, p120, p121, p122, p123, p124, p125, p126, p127, p128, p129, p130, p131, p132, p133, p134, p135, p136, p137, p138, p139, p140, p141, p142, p143, p144, p145, p146, p147, p148, p149, p150, p151, p152;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503, f504, f505, f506, f507, f508, f509, f510, f511, f512, f513, f514, f515, f516, f517, f518, f519, f520, f521, f522, f523, f524, f525, f526, f527, f528, f529, f530, f531, f532, f533, f534, f535, f536, f537, f538, f539, f540, f541, f542, f543, f544, f545, f546, f547, f548, f549, f550, f551, f552, f553, f554, f555, f556, f557, f558, f559, f560, f561, f562, f563, f564, f565, f566, f567, f568, f569, f570, f571, f572, f573, f574, f575, f576, f577, f578, f579, f580, f581, f582, f583, f584, f585, f586, f587, f588, f589, f590, f591, f592, f593, f594, f595, f596, f597, f598, f599, f600, f601, f602, f603, f604, f605, f606, f607, f608, f609, f610, f611, f612, f613, f614, f615, f616, f617, f618, f619, f620, f621, f622, f623, f624, f625, f626, f627, f628, f629, f630, f631, f632, f633, f634, f635, f636, f637, f638, f639, f640, f641, f642, f643, f644, f645, f646, f647, f648, f649, f650, f651, f652, f653, f654, f655, f656, f657, f658, f659, f660, f661, f662, f663, f664, f665, f666, f667, f668, f669, f670, f671, f672, f673, f674, f675, f676, f677, f678, f679, f680, f681, f682, f683, f684, f685, f686, f687, f688, f689, f690, f691, f692, f693, f694, f695, f696, f697, f698, f699, f700, f701, f702, f703, f704, f705, f706, f707, f708, f709, f710, f711, f712, f713, f714, f715, f716, f717, f718, f719, f720, f721, f722, f723, f724, f725, f726, f727, f728, f729, f730, f731, f732, f733, f734, f735, f736, f737, f738, f739, f740, f741, f742, f743, f744, f745, f746, f747, f748, f749, f750, f751, f752, f753, f754, f755, f756, f757, f758, f759, f760, f761, f762, f763, f764, f765, f766, f767, f768, f769, f770, f771, f772, f773, f774, f775, f776, f777, f778, f779, f780, f781, f782, f783, f784, f785, f786, f787, f788, f789, f790, f791, f792, f793, f794, f795, f796, f797, f798, f799, f800, f801, f802, f803, f804, f805, f806, f807, f808, f809, f810, f811, f812, f813, f814, f815, f816, f817, f818, f819, f820, f821, f822, f823, f824, f825, f826, f827, f828, f829, f830, f831, f832, f833, f834, f835, f836, f837, f838, f839, f840, f841, f842, f843, f844, f845, f846, f847, f848, f849, f850, f851, f852, f853, f854, f855, f856, f857, f858, f859, f860, f861, f862, f863, f864, f865, f866, f867, f868, f869, f870, f871, f872, f873, f874, f875, f876, f877, f878, f879, f880, f881, f882, f883, f884, f885, f886, f887, f888, f889, f890, f891, f892, f893, f894, f895, f896, f897, f898, f899, f900, f901, f902, f903, f904, f905, f906, f907, f908, f909, f910, f911, f912, f913, f914, f915, f916, f917, f918, f919, f920, f921, f922, f923, f924, f925, f926, f927, f928, f929, f930, f931, f932, f933, f934, f935, f936, f937, f938, f939, f940, f941, f942, f943, f944, f945, f946, f947, f948, f949, f950, f951, f952, f953, f954, f955, f956, f957, f958, f959, f960, f961, f962, f963, f964, f965, f966, f967, f968, f969, f970, f971, f972, f973, f974, f975, f976, f977, f978, f979, f980, f981, f982, f983, f984, f985, f986, f987, f988, f989, f990, f991, f992, f993, f994, f995, f996, f997, f998, f999, f1000, f1001, f1002, f1003, f1004, f1005, f1006, f1007, f1008, f1009, f1010, f1011, f1012, f1013, f1014, f1015, f1016, f1017, f1018, f1019, f1020, f1021, f1022, f1023, f1024, f1025, f1026, f1027, f1028, f1029, f1030, f1031, f1032, f1033, f1034, f1035, f1036, f1037, f1038, f1039, f1040, f1041, f1042, f1043, f1044, f1045, f1046, f1047, f1048, f1049, f1050, f1051, f1052, f1053, f1054, f1055, f1056, f1057, f1058, f1059, f1060, f1061, f1062, f1063, f1064, f1065, f1066, f1067, f1068, f1069, f1070, f1071, f1072, f1073, f1074, f1075, f1076, f1077, f1078, f1079, f1080, f1081, f1082, f1083, f1084, f1085, f1086, f1087, f1088, f1089, f1090, f1091, f1092, f1093, f1094, f1095, f1096, f1097, f1098, f1099, f1100, f1101, f1102, f1103, f1104, f1105, f1106, f1107, f1108, f1109, f1110, f1111, f1112, f1113, f1114, f1115, f1116, f1117, f1118, f1119, f1120, f1121, f1122, f1123, f1124, f1125, f1126, f1127, f1128, f1129, f1130, f1131, f1132, f1133, f1134, f1135, f1136, f1137, f1138, f1139, f1140, f1141, f1142, f1143, f1144, f1145, f1146, f1147, f1148, f1149, f1150, f1151, f1152, f1153, f1154, f1155, f1156, f1157, f1158, f1159, f1160, f1161, f1162, f1163, f1164, f1165, f1166, f1167, f1168, f1169, f1170, f1171, f1172, f1173, f1174, f1175, f1176, f1177, f1178, f1179, f1180, f1181, f1182, f1183, f1184, f1185, f1186, f1187, f1188, f1189, f1190, f1191, f1192, f1193, f1194, f1195, f1196, f1197, f1198, f1199, f1200, f1201, f1202, f1203, f1204, f1205, f1206, f1207, f1208, f1209, f1210, f1211, f1212, f1213, f1214, f1215, f1216, f1217, f1218, f1219, f1220, f1221, f1222, f1223, f1224, f1225, f1226, f1227, f1228, f1229, f1230, f1231, f1232, f1233, f1234, f1235, f1236, f1237, f1238, f1239, f1240, f1241, f1242, f1243, f1244, f1245, f1246, f1247, f1248, f1249, f1250, f1251, f1252, f1253, f1254, f1255, f1256, f1257, f1258, f1259, f1260, f1261, f1262, f1263, f1264, f1265, f1266, f1267, f1268, f1269, f1270, f1271, f1272, f1273, f1274, f1275, f1276, f1277, f1278, f1279, f1280, f1281, f1282, f1283, f1284, f1285, f1286, f1287, f1288, f1289, f1290, f1291, f1292, f1293, f1294, f1295, f1296, f1297, f1298, f1299, f1300, f1301, f1302, f1303, f1304, f1305, f1306, f1307, f1308, f1309, f1310, f1311, f1312, f1313, f1314, f1315, f1316, f1317, f1318, f1319, f1320, f1321, f1322, f1323, f1324, f1325, f1326, f1327, f1328, f1329, f1330, f1331, f1332, f1333, f1334, f1335, f1336, f1337, f1338, f1339, f1340, f1341, f1342, f1343, f1344, f1345, f1346, f1347, f1348, f1349, f1350, f1351, f1352, f1353, f1354, f1355, f1356, f1357, f1358, f1359, f1360, f1361, f1362, f1363, f1364, f1365, f1366, f1367, f1368, f1369, f1370, f1371, f1372, f1373, f1374, f1375, f1376, f1377, f1378, f1379, f1380, f1381, f1382, f1383, f1384, f1385, f1386, f1387, f1388, f1389, f1390, f1391, f1392, f1393, f1394, f1395, f1396, f1397, f1398, f1399, f1400, f1401, f1402, f1403, f1404, f1405, f1406, f1407, f1408, f1409, f1410, f1411, f1412, f1413, f1414, f1415, f1416, f1417, f1418, f1419, f1420, f1421, f1422, f1423, f1424, f1425, f1426, f1427, f1428, f1429, f1430, f1431, f1432, f1433, f1434, f1435, f1436, f1437, f1438, f1439, f1440, f1441, f1442, f1443, f1444, f1445, f1446, f1447, f1448, f1449, f1450, f1451, f1452, f1453, f1454, f1455, f1456, f1457, f1458, f1459, f1460, f1461, f1462, f1463, f1464, f1465, f1466, f1467, f1468, f1469, f1470, f1471, f1472, f1473, f1474, f1475, f1476, f1477, f1478, f1479, f1480, f1481, f1482, f1483, f1484, f1485, f1486, f1487, f1488, f1489, f1490, f1491, f1492, f1493, f1494, f1495, f1496, f1497, f1498, f1499, f1500, f1501, f1502, f1503, f1504, f1505, f1506, f1507, f1508, f1509, f1510, f1511, f1512, f1513, f1514, f1515, f1516, f1517, f1518, f1519, f1520, f1521, f1522, f1523, f1524, f1525, f1526, f1527, f1528, f1529, f1530, f1531, f1532, f1533, f1534, f1535, f1536, f1537, f1538, f1539, f1540, f1541, f1542, f1543, f1544, f1545, f1546, f1547, f1548, f1549, f1550, f1551, f1552, f1553, f1554, f1555, f1556, f1557, f1558, f1559, f1560, f1561, f1562, f1563, f1564, f1565, f1566, f1567, f1568, f1569, f1570, f1571, f1572, f1573, f1574, f1575, f1576, f1577, f1578, f1579, f1580, f1581, f1582, f1583, f1584, f1585, f1586, f1587, f1588, f1589, f1590, f1591, f1592, f1593, f1594, f1595, f1596, f1597, f1598, f1599, f1600, f1601, f1602, f1603, f1604, f1605, f1606, f1607, f1608, f1609, f1610, f1611, f1612, f1613, f1614, f1615, f1616, f1617, f1618, f1619, f1620, f1621, f1622, f1623, f1624, f1625, f1626, f1627, f1628, f1629, f1630, f1631, f1632, f1633, f1634, f1635, f1636, f1637, f1638, f1639, f1640, f1641, f1642, f1643, f1644, f1645, f1646, f1647, f1648, f1649;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146, r147, r148, r149, r150, r151, r152, r153, r154, r155, r156, r157, r158, r159, r160, r161, r162, r163, r164, r165, r166, r167, r168, r169, r170, r171, r172, r173, r174, r175, r176, r177, r178, r179, r180, r181, r182, r183, r184, r185, r186, r187, r188, r189, r190, r191, r192, r193, r194, r195, r196, r197, r198, r199, r200, r201, r202, r203, r204, r205, r206, r207, r208, r209, r210, r211, r212, r213, r214, r215, r216, r217, r218, r219, r220, r221, r222, r223, r224, r225, r226, r227, r228, r229, r230, r231, r232, r233, r234, r235, r236, r237, r238, r239, r240, r241, r242, r243, r244, r245, r246, r247, r248, r249, r250, r251, r252, r253, r254, r255, r256, r257, r258, r259, r260, r261, r262, r263, r264, r265, r266, r267, r268, r269, r270, r271, r272, r273, r274, r275, r276, r277, r278, r279, r280, r281, r282, r283, r284, r285, r286, r287, r288, r289, r290, r291, r292, r293, r294, r295, r296, r297, r298, r299, r300, r301, r302, r303, r304, r305, r306, r307, r308, r309, r310, r311, r312, r313, r314, r315, r316, r317, r318, r319, r320, r321, r322, r323, r324, r325, r326, r327, r328, r329, r330, r331, r332, r333, r334, r335, r336, r337, r338, r339, r340, r341, r342, r343, r344, r345, r346, r347, r348, r349, r350, r351, r352, r353, r354, r355, r356, r357, r358, r359, r360, r361, r362, r363, r364, r365, r366, r367, r368, r369, r370, r371, r372, r373, r374, r375, r376, r377, r378, r379, r380, r381, r382, r383, r384, r385, r386, r387, r388, r389, r390, r391, r392, r393, r394, r395, r396, r397, r398, r399, r400, r401, r402, r403, r404, r405, r406, r407, r408, r409, r410, r411, r412, r413, r414, r415, r416, r417, r418, r419, r420, r421, r422, r423, r424, r425, r426, r427, r428, r429, r430, r431, r432, r433, r434, r435, r436, r437, r438, r439, r440, r441, r442, r443, r444, r445, r446, r447, r448, r449, r450, r451, r452, r453, r454, r455, r456, r457, r458, r459, r460, r461, r462, r463, r464, r465, r466, r467, r468, r469, r470, r471, r472, r473, r474, r475, r476, r477, r478, r479, r480, r481, r482, r483, r484, r485, r486, r487, r488, r489, r490, r491, r492, r493, r494, r495, r496, r497, r498, r499, r500, r501, r502, r503, r504, r505, r506, r507, r508, r509, r510, r511, r512, r513, r514, r515, r516, r517, r518, r519, r520, r521, r522, r523, r524, r525, r526, r527, r528, r529, r530, r531, r532, r533, r534, r535, r536, r537, r538, r539, r540, r541, r542, r543, r544, r545, r546, r547, r548, r549, r550, r551, r552, r553, r554, r555, r556, r557, r558, r559, r560, r561, r562, r563, r564, r565, r566, r567, r568, r569, r570, r571, r572, r573, r574, r575, r576, r577, r578, r579, r580, r581, r582, r583, r584, r585, r586, r587, r588, r589, r590, r591, r592, r593, r594, r595, r596, r597, r598, r599, r600, r601, r602, r603, r604, r605, r606, r607, r608, r609, r610, r611, r612, r613, r614, r615, r616, r617, r618, r619, r620, r621, r622, r623, r624, r625, r626, r627, r628, r629, r630, r631, r632, r633, r634, r635, r636, r637, r638, r639, r640, r641, r642, r643, r644, r645, r646, r647, r648, r649, r650, r651, r652, r653, r654, r655, r656, r657, r658, r659, r660, r661, r662, r663, r664, r665, r666, r667, r668, r669, r670, r671, r672, r673, r674, r675, r676, r677, r678, r679, r680, r681, r682, r683, r684, r685, r686, r687, r688, r689, r690, r691, r692, r693, r694, r695, r696, r697, r698, r699, r700, r701, r702, r703, r704, r705, r706, r707, r708, r709, r710, r711, r712, r713, r714, r715, r716, r717, r718, r719, r720, r721, r722, r723, r724, r725, r726, r727, r728, r729, r730, r731, r732, r733, r734, r735, r736, r737, r738, r739, r740, r741, r742, r743, r744, r745, r746, r747, r748, r749, r750, r751, r752, r753, r754, r755, r756, r757, r758, r759, r760, r761, r762, r763, r764, r765, r766, r767, r768, r769, r770, r771, r772, r773, r774, r775, r776, r777, r778, r779, r780, r781, r782, r783, r784, r785, r786, r787, r788, r789, r790, r791, r792, r793, r794, r795, r796, r797, r798, r799, r800, r801, r802, r803, r804, r805, r806, r807, r808, r809, r810, r811, r812, r813, r814, r815, r816, r817, r818, r819, r820, r821, r822, r823, r824, r825, r826, r827, r828, r829, r830, r831, r832, r833, r834, r835, r836, r837, r838, r839, r840, r841, r842, r843, r844, r845, r846, r847, r848, r849, r850, r851, r852, r853, r854, r855, r856, r857, r858, r859, r860, r861, r862, r863, r864, r865, r866, r867, r868, r869, r870, r871, r872, r873, r874, r875, r876, r877, r878, r879, r880, r881, r882, r883, r884, r885, r886, r887, r888, r889, r890, r891, r892, r893, r894, r895, r896, r897, r898, r899, r900, r901, r902, r903, r904, r905, r906, r907, r908, r909, r910, r911, r912, r913, r914, r915, r916, r917, r918, r919, r920, r921, r922, r923, r924, r925, r926, r927, r928, r929, r930, r931, r932, r933, r934, r935, r936, r937, r938, r939, r940, r941, r942, r943, r944, r945, r946, r947, r948, r949, r950, r951, r952, r953, r954, r955, r956, r957, r958, r959, r960, r961, r962, r963, r964, r965, r966, r967, r968, r969, r970, r971, r972, r973, r974, r975, r976, r977, r978, r979, r980, r981, r982, r983, r984, r985, r986, r987, r988, r989, r990, r991, r992, r993, r994, r995, r996, r997, r998, r999, r1000, r1001, r1002, r1003, r1004, r1005, r1006, r1007, r1008, r1009, r1010, r1011, r1012, r1013, r1014, r1015, r1016, r1017, r1018, r1019, r1020, r1021, r1022, r1023, r1024, r1025, r1026, r1027, r1028, r1029, r1030, r1031, r1032, r1033, r1034, r1035, r1036, r1037, r1038, r1039, r1040, r1041, r1042, r1043, r1044, r1045, r1046, r1047, r1048, r1049, r1050, r1051, r1052, r1053, r1054, r1055, r1056, r1057, r1058, r1059, r1060, r1061, r1062, r1063, r1064, r1065, r1066, r1067, r1068, r1069, r1070, r1071, r1072, r1073, r1074, r1075, r1076, r1077, r1078, r1079, r1080, r1081, r1082, r1083, r1084, r1085, r1086, r1087, r1088, r1089, r1090, r1091, r1092, r1093, r1094, r1095, r1096, r1097, r1098, r1099, r1100, r1101, r1102, r1103, r1104, r1105, r1106, r1107, r1108, r1109, r1110, r1111, r1112, r1113, r1114, r1115, r1116, r1117, r1118, r1119, r1120, r1121, r1122, r1123, r1124, r1125, r1126, r1127, r1128, r1129, r1130, r1131, r1132, r1133, r1134, r1135, r1136, r1137, r1138, r1139, r1140, r1141, r1142, r1143, r1144, r1145, r1146, r1147, r1148, r1149, r1150, r1151, r1152, r1153, r1154, r1155, r1156, r1157, r1158, r1159, r1160, r1161, r1162, r1163, r1164, r1165, r1166, r1167, r1168, r1169, r1170, r1171, r1172, r1173, r1174, r1175, r1176, r1177, r1178, r1179, r1180, r1181, r1182, r1183, r1184, r1185, r1186, r1187, r1188, r1189, r1190, r1191, r1192, r1193, r1194, r1195, r1196, r1197, r1198, r1199, r1200, r1201, r1202, r1203, r1204, r1205, r1206, r1207, r1208, r1209, r1210, r1211, r1212, r1213, r1214, r1215, r1216, r1217, r1218, r1219, r1220, r1221, r1222, r1223, r1224, r1225, r1226, r1227, r1228, r1229, r1230, r1231, r1232, r1233, r1234, r1235, r1236, r1237, r1238, r1239, r1240, r1241, r1242, r1243, r1244, r1245, r1246, r1247, r1248, r1249, r1250, r1251, r1252, r1253, r1254, r1255, r1256, r1257, r1258, r1259, r1260, r1261, r1262, r1263, r1264, r1265, r1266, r1267, r1268, r1269, r1270, r1271, r1272, r1273, r1274, r1275, r1276, r1277, r1278, r1279, r1280, r1281, r1282, r1283, r1284, r1285, r1286, r1287, r1288, r1289, r1290, r1291, r1292, r1293, r1294, r1295, r1296, r1297, r1298, r1299, r1300, r1301, r1302, r1303, r1304, r1305, r1306, r1307, r1308, r1309, r1310, r1311, r1312, r1313, r1314, r1315, r1316, r1317, r1318, r1319, r1320, r1321, r1322, r1323, r1324, r1325, r1326, r1327, r1328, r1329, r1330, r1331, r1332, r1333, r1334, r1335, r1336, r1337, r1338, r1339, r1340, r1341, r1342, r1343, r1344, r1345, r1346, r1347, r1348, r1349, r1350, r1351, r1352, r1353, r1354, r1355, r1356, r1357, r1358, r1359, r1360, r1361, r1362, r1363, r1364, r1365, r1366, r1367, r1368, r1369, r1370, r1371, r1372, r1373, r1374, r1375, r1376, r1377, r1378, r1379, r1380, r1381, r1382, r1383, r1384, r1385, r1386, r1387, r1388, r1389, r1390, r1391, r1392, r1393, r1394, r1395, r1396, r1397, r1398, r1399, r1400, r1401, r1402, r1403, r1404, r1405, r1406, r1407, r1408, r1409, r1410, r1411, r1412, r1413, r1414, r1415, r1416, r1417, r1418, r1419, r1420, r1421, r1422, r1423, r1424, r1425, r1426, r1427, r1428, r1429, r1430, r1431, r1432, r1433, r1434, r1435, r1436, r1437, r1438, r1439, r1440, r1441, r1442, r1443, r1444, r1445, r1446, r1447, r1448, r1449, r1450, r1451, r1452, r1453, r1454, r1455, r1456, r1457, r1458, r1459, r1460, r1461, r1462, r1463, r1464, r1465, r1466, r1467, r1468, r1469, r1470, r1471, r1472, r1473, r1474, r1475, r1476, r1477, r1478, r1479, r1480, r1481, r1482, r1483, r1484, r1485, r1486, r1487, r1488, r1489, r1490, r1491, r1492, r1493, r1494, r1495, r1496, r1497, r1498, r1499, r1500, r1501, r1502, r1503, r1504, r1505, r1506, r1507, r1508, r1509, r1510, r1511, r1512, r1513, r1514, r1515, r1516, r1517, r1518, r1519, r1520, r1521, r1522, r1523, r1524, r1525, r1526, r1527, r1528, r1529, r1530, r1531, r1532, r1533, r1534, r1535, r1536, r1537, r1538, r1539, r1540, r1541, r1542, r1543, r1544, r1545, r1546, r1547, r1548, r1549, r1550, r1551, r1552, r1553, r1554, r1555, r1556, r1557, r1558, r1559, r1560, r1561, r1562, r1563, r1564, r1565, r1566, r1567, r1568, r1569, r1570, r1571, r1572, r1573, r1574, r1575, r1576, r1577, r1578, r1579, r1580, r1581, r1582, r1583, r1584, r1585, r1586, r1587, r1588, r1589, r1590, r1591, r1592, r1593, r1594, r1595, r1596, r1597, r1598, r1599, r1600, r1601, r1602, r1603, r1604, r1605, r1606, r1607, r1608, r1609, r1610, r1611, r1612, r1613, r1614, r1615, r1616, r1617, r1618, r1619, r1620, r1621, r1622, r1623, r1624, r1625, r1626, r1627, r1628, r1629, r1630, r1631, r1632, r1633, r1634, r1635, r1636, r1637, r1638, r1639, r1640, r1641, r1642, r1643, r1644, r1645, r1646, r1647, r1648, r1649, r1650, r1651, r1652, r1653, r1654, r1655, r1656, r1657, r1658, r1659, r1660, r1661, r1662, r1663, r1664, r1665, r1666, r1667, r1668, r1669, r1670, r1671, r1672, r1673, r1674, r1675, r1676, r1677, r1678, r1679, r1680, r1681, r1682, r1683, r1684, r1685, r1686, r1687, r1688, r1689, r1690, r1691, r1692, r1693, r1694, r1695, r1696, r1697, r1698, r1699, r1700, r1701, r1702, r1703, r1704, r1705, r1706, r1707, r1708, r1709, r1710, r1711, r1712, r1713, r1714, r1715, r1716, r1717, r1718, r1719, r1720, r1721, r1722, r1723, r1724, r1725, r1726, r1727, r1728, r1729, r1730, r1731, r1732, r1733, r1734, r1735, r1736, r1737, r1738, r1739, r1740, r1741, r1742, r1743, r1744, r1745, r1746, r1747, r1748, r1749, r1750, r1751, r1752, r1753, r1754, r1755, r1756, r1757, r1758, r1759, r1760, r1761, r1762, r1763, r1764, r1765, r1766, r1767, r1768, r1769, r1770, r1771, r1772, r1773, r1774, r1775, r1776, r1777, r1778, r1779, r1780, r1781, r1782, r1783, r1784, r1785, r1786, r1787, r1788, r1789, r1790, r1791, r1792, r1793, r1794, r1795, r1796, r1797, r1798, r1799, r1800, r1801, r1802, r1803, r1804, r1805, r1806, r1807, r1808, r1809, r1810, r1811, r1812, r1813, r1814, r1815, r1816, r1817, r1818, r1819, r1820, r1821, r1822, r1823, r1824, r1825, r1826, r1827, r1828, r1829, r1830, r1831, r1832, r1833, r1834, r1835, r1836, r1837, r1838, r1839, r1840, r1841, r1842, r1843, r1844, r1845, r1846, r1847, r1848, r1849, r1850, r1851, r1852, r1853, r1854, r1855, r1856, r1857, r1858, r1859, r1860, r1861, r1862, r1863, r1864, r1865, r1866, r1867, r1868, r1869, r1870, r1871, r1872, r1873, r1874, r1875, r1876, r1877, r1878, r1879, r1880, r1881, r1882, r1883, r1884, r1885, r1886, r1887, r1888, r1889, r1890, r1891, r1892, r1893, r1894, r1895;
  __align__(4) unsigned char __local_depot4[440];
  // PTX:21 mov.u64 %SPL, __local_depot4
  SPL = (unsigned long long)__cvta_generic_to_local(__local_depot4);
  // PTX:22 mov.b64 %rd105, _ZN7synreal6kernel30evaluate_surface_contact_forceENS0_18SurfaceContactViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEE_param_0
  rd105 = (unsigned long long)(uintptr_t)&param0;
  // PTX:23 ld.param.u64 %rd106, [_ZN7synreal6kernel30evaluate_surface_contact_forceENS0_18SurfaceContactViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEE_param_1]
  rd106 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:24 cvta.to.global.u64 %rd1, %rd106
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd106));
  // PTX:25 add.u64 %rd2, %SPL, 0
  asm("add.u64 %0, %1, 0;" : "=l"(rd2) : "l"(SPL));
  // PTX:26 add.u64 %rd3, %SPL, 220
  asm("add.u64 %0, %1, 220;" : "=l"(rd3) : "l"(SPL));
  // PTX:27 add.s64 %rd4, %rd105, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd4) : "l"(rd105));
  // PTX:28 ld.param.u64 %rd110, [_ZN7synreal6kernel30evaluate_surface_contact_forceENS0_18SurfaceContactViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEE_param_0]
  rd110 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:29 cvta.to.global.u64 %rd111, %rd110
  rd111 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd110));
  // PTX:30 ld.global.u32 %r460, [%rd111]
  r460 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd111) + (0)))));
  // PTX:31 max.s32 %r461, %r460, 0
  asm("max.s32 %0, %1, 0;" : "=r"(r461) : "r"(r460));
  // PTX:32 cvt.s64.s32 %rd112, %r461
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd112) : "r"(r461));
  // PTX:33 ld.param.u64 %rd113, [_ZN7synreal6kernel30evaluate_surface_contact_forceENS0_18SurfaceContactViewEPN3glm3vecILi3EfLNS2_9qualifierE0EEE_param_0+8]
  rd113 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (8))));
  // PTX:34 min.u64 %rd5, %rd113, %rd112
  asm("min.u64 %0, %1, %2;" : "=l"(rd5) : "l"(rd113), "l"(rd112));
  // PTX:35 mov.u32 %r462, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r462) : "r"(blockIdx.x));
  // PTX:36 mov.u32 %r463, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r463) : "r"(blockDim.x));
  // PTX:37 cvt.u64.u32 %rd6, %r463
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd6) : "r"(r463));
  // PTX:38 mul.wide.u32 %rd114, %r462, %r463
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd114) : "r"(r462), "r"(r463));
  // PTX:39 mov.u32 %r464, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r464) : "r"(threadIdx.x));
  // PTX:40 cvt.u64.u32 %rd115, %r464
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd115) : "r"(r464));
  // PTX:41 add.s64 %rd398, %rd114, %rd115
  asm("add.s64 %0, %1, %2;" : "=l"(rd398) : "l"(rd114), "l"(rd115));
  // PTX:42 setp.ge.u64 %p1, %rd398, %rd5
  p1 = (((unsigned long long)(rd398)) >= ((unsigned long long)(rd5)));
  // PTX:43 @%p1 bra $L__BB4_181
  if (p1) { goto L_BB4_181; }
  // PTX:45 ld.param.u64 %rd116, [%rd4+24]
  rd116 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (24))));
  // PTX:46 cvta.to.global.u64 %rd8, %rd116
  rd8 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd116));
  // PTX:47 ld.param.u64 %rd9, [%rd4+64]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (64))));
  // PTX:48 ld.param.u64 %rd117, [%rd4+8]
  rd117 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (8))));
  // PTX:49 cvta.to.global.u64 %rd10, %rd117
  rd10 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd117));
  // PTX:50 ld.param.u64 %rd118, [%rd4+16]
  rd118 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (16))));
  // PTX:51 cvta.to.global.u64 %rd11, %rd118
  rd11 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd118));
  // PTX:52 mov.u32 %r465, %nctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r465) : "r"(gridDim.x));
  // PTX:53 cvt.u64.u32 %rd119, %r465
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd119) : "r"(r465));
  // PTX:54 mul.lo.s64 %rd12, %rd119, %rd6
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd12) : "l"(rd119), "l"(rd6));
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
  // PTX:62 ld.param.u64 %rd120, [%rd4+72]
  rd120 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (72))));
  // PTX:63 cvta.to.global.u64 %rd20, %rd120
  rd20 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd120));
  // PTX:64 ld.param.u64 %rd21, [%rd4+96]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (96))));
  // PTX:65 cvta.to.global.u64 %rd22, %rd21
  rd22 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:66 ld.param.u64 %rd121, [%rd4+264]
  rd121 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (264))));
  // PTX:67 cvta.to.global.u64 %rd23, %rd121
  rd23 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd121));
  // PTX:68 ld.param.f32 %f1, [%rd4+280]
  f1 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd4) + (280))));
  // PTX:69 ld.param.u64 %rd24, [%rd4+272]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (272))));
  // PTX:70 cvta.to.global.u64 %rd25, %rd24
  rd25 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd24));
  // PTX:71 ld.param.u64 %rd122, [%rd4+80]
  rd122 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (80))));
  // PTX:72 cvta.to.global.u64 %rd26, %rd122
  rd26 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd122));
  // PTX:73 ld.param.u64 %rd27, [%rd4+88]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (88))));
  // PTX:74 cvta.to.global.u64 %rd28, %rd27
  rd28 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd27));
  // PTX:75 ld.param.u64 %rd123, [%rd4+120]
  rd123 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (120))));
  // PTX:76 cvta.to.global.u64 %rd29, %rd123
  rd29 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd123));
  // PTX:77 ld.param.u64 %rd124, [%rd4+232]
  rd124 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (232))));
  // PTX:78 cvta.to.global.u64 %rd30, %rd124
  rd30 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd124));
  // PTX:79 ld.param.u64 %rd31, [%rd4+256]
  rd31 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (256))));
  // PTX:80 ld.param.u64 %rd125, [%rd4+32]
  rd125 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (32))));
  // PTX:81 cvta.to.global.u64 %rd32, %rd125
  rd32 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd125));
  // PTX:82 ld.param.u64 %rd126, [%rd4+128]
  rd126 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (128))));
  // PTX:83 cvta.to.global.u64 %rd33, %rd126
  rd33 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd126));
  // PTX:84 ld.param.u64 %rd127, [%rd4+48]
  rd127 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (48))));
  // PTX:85 cvta.to.global.u64 %rd34, %rd127
  rd34 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd127));
  // PTX:86 ld.param.u64 %rd128, [%rd4+240]
  rd128 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (240))));
  // PTX:87 cvta.to.global.u64 %rd35, %rd128
  rd35 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd128));
  // PTX:88 ld.param.u64 %rd36, [%rd4+104]
  rd36 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (104))));
  // PTX:89 cvt.u32.u64 %r1, %rd36
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd36));
  // PTX:90 ld.param.u64 %rd129, [%rd4+248]
  rd129 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (248))));
  // PTX:91 cvta.to.global.u64 %rd37, %rd129
  rd37 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd129));
  // PTX:92 ld.param.u64 %rd130, [%rd4+136]
  rd130 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (136))));
  // PTX:93 cvta.to.global.u64 %rd38, %rd130
  rd38 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd130));
  // PTX:94 ld.param.u64 %rd131, [%rd4+40]
  rd131 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (40))));
  // PTX:95 cvta.to.global.u64 %rd39, %rd131
  rd39 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd131));
  // PTX:96 ld.param.u64 %rd132, [%rd4+144]
  rd132 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (144))));
  // PTX:97 cvta.to.global.u64 %rd40, %rd132
  rd40 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd132));
  // PTX:98 ld.param.u64 %rd133, [%rd4+152]
  rd133 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (152))));
  // PTX:99 cvta.to.global.u64 %rd41, %rd133
  rd41 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd133));
  // PTX:100 ld.param.v2.f32 {%f406, %f407}, [%rd4+216]
  f406 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd4) + (216)))); f407 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd4) + (220))));
  // PTX:101 ld.param.u64 %rd134, [%rd4+160]
  rd134 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (160))));
  // PTX:102 cvta.to.global.u64 %rd42, %rd134
  rd42 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd134));
  // PTX:103 ld.param.u64 %rd135, [%rd4+168]
  rd135 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (168))));
  // PTX:104 cvta.to.global.u64 %rd43, %rd135
  rd43 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd135));
  // PTX:105 ld.param.v2.f32 {%f408, %f409}, [%rd4+224]
  f408 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd4) + (224)))); f409 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd4) + (228))));
  // PTX:106 ld.param.u64 %rd136, [%rd4+184]
  rd136 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (184))));
  // PTX:107 cvta.to.global.u64 %rd44, %rd136
  rd44 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd136));
  // PTX:108 ld.param.u64 %rd137, [%rd4+176]
  rd137 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd4) + (176))));
  // PTX:109 cvta.to.global.u64 %rd45, %rd137
  rd45 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd137));
  // PTX:110 bra.uni $L__BB4_2
  goto L_BB4_2;
  // PTX:112 $L__BB4_23:
L_BB4_23:;
  // PTX:113 abs.f32 %f425, %f21
  asm("abs.f32 %0, %1;" : "=f"(f425) : "f"(f21));
  // PTX:114 setp.geu.f32 %p21, %f425, 0f7F800000
  p21 = ((isnan(((float)(f425))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f425)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:115 setp.lt.f32 %p22, %f21, 0f00000000
  p22 = (!(isnan(((float)(f21))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f21)) < ((float)(as_f32(0x00000000u)))));
  // PTX:116 mov.u32 %r1853, 0
  asm("mov.u32 %0, 0;" : "=r"(r1853) : );
  // PTX:117 or.pred %p23, %p21, %p22
  p23 = ((p21) || (p22));
  // PTX:118 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:119 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:120 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:121 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:122 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:123 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:124 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:125 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:126 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:127 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:128 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:129 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:130 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:131 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:132 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:133 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:134 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:135 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:136 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:137 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:138 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:139 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:140 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:141 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:142 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:143 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:144 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:145 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:146 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:147 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:148 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:149 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:150 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:151 @%p23 bra $L__BB4_164
  if (p23) { goto L_BB4_164; }
  // PTX:153 setp.ne.s64 %p24, %rd399, %rd56
  p24 = (((long long)(rd399)) != ((long long)(rd56)));
  // PTX:154 @%p24 bra $L__BB4_164
  if (p24) { goto L_BB4_164; }
  // PTX:156 @%p11 bra $L__BB4_27
  if (p11) { goto L_BB4_27; }
  // PTX:158 rem.u64 %rd403, %rd52, %rd36
  asm("rem.u64 %0, %1, %2;" : "=l"(rd403) : "l"(rd52), "l"(rd36));
  // PTX:159 bra.uni $L__BB4_28
  goto L_BB4_28;
  // PTX:161 $L__BB4_27:
L_BB4_27:;
  // PTX:162 cvt.u32.u64 %r558, %rd52
  asm("cvt.u32.u64 %0, %1;" : "=r"(r558) : "l"(rd52));
  // PTX:163 rem.u32 %r559, %r558, %r1
  asm("rem.u32 %0, %1, %2;" : "=r"(r559) : "r"(r558), "r"(r1));
  // PTX:164 cvt.u64.u32 %rd403, %r559
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd403) : "r"(r559));
  // PTX:166 $L__BB4_28:
L_BB4_28:;
  // PTX:167 setp.eq.s64 %p26, %rd21, 0
  p26 = (((long long)(rd21)) == ((long long)(0)));
  // PTX:168 @%p26 bra $L__BB4_30
  if (p26) { goto L_BB4_30; }
  // PTX:170 shl.b64 %rd152, %rd403, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd152) : "l"(rd403));
  // PTX:171 add.s64 %rd153, %rd22, %rd152
  asm("add.s64 %0, %1, %2;" : "=l"(rd153) : "l"(rd22), "l"(rd152));
  // PTX:172 ld.global.u32 %r600, [%rd153]
  r600 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd153) + (0)))));
  // PTX:173 setp.ne.s32 %p27, %r600, 0
  p27 = (((int)(r600)) != ((int)(0)));
  // PTX:174 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:175 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:176 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:177 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:178 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:179 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:180 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:181 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:182 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:183 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:184 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:185 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:186 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:187 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:188 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:189 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:190 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:191 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:192 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:193 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:194 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:195 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:196 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:197 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:198 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:199 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:200 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:201 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:202 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:203 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:204 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:205 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:206 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:207 @%p27 bra $L__BB4_164
  if (p27) { goto L_BB4_164; }
  // PTX:209 $L__BB4_30:
L_BB4_30:;
  // PTX:210 shl.b64 %rd155, %rd403, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd155) : "l"(rd403));
  // PTX:211 add.s64 %rd156, %rd20, %rd155
  asm("add.s64 %0, %1, %2;" : "=l"(rd156) : "l"(rd20), "l"(rd155));
  // PTX:212 ld.global.f32 %f464, [%rd156]
  f464 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd156) + (0)))));
  // PTX:213 mov.u64 %rd404, 0
  asm("mov.u64 %0, 0;" : "=l"(rd404) : );
  // PTX:214 mov.f32 %f1578, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1578) : );
  // PTX:215 max.f32 %f1577, %f1578, %f464
  asm("max.f32 %0, %1, %2;" : "=f"(f1577) : "f"(f1578), "f"(f464));
  // PTX:216 setp.eq.f32 %p28, %f21, 0f00000000
  p28 = (!(isnan(((float)(f21))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f21)) == ((float)(as_f32(0x00000000u)))));
  // PTX:217 mov.f32 %f1571, %f1578
  asm("mov.f32 %0, %1;" : "=f"(f1571) : "f"(f1578));
  // PTX:218 mov.f32 %f1572, %f1578
  asm("mov.f32 %0, %1;" : "=f"(f1572) : "f"(f1578));
  // PTX:219 mov.f32 %f1573, %f1578
  asm("mov.f32 %0, %1;" : "=f"(f1573) : "f"(f1578));
  // PTX:220 mov.f32 %f1574, %f1578
  asm("mov.f32 %0, %1;" : "=f"(f1574) : "f"(f1578));
  // PTX:221 mov.f32 %f1575, %f1578
  asm("mov.f32 %0, %1;" : "=f"(f1575) : "f"(f1578));
  // PTX:222 mov.f32 %f1576, %f1578
  asm("mov.f32 %0, %1;" : "=f"(f1576) : "f"(f1578));
  // PTX:223 mov.f32 %f1579, %f1578
  asm("mov.f32 %0, %1;" : "=f"(f1579) : "f"(f1578));
  // PTX:224 @%p28 bra $L__BB4_35
  if (p28) { goto L_BB4_35; }
  // PTX:226 st.local.u32 [%rd2], %r44
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (0))))) = (unsigned)(r44);
  // PTX:227 mov.u32 %r601, 1
  asm("mov.u32 %0, 1;" : "=r"(r601) : );
  // PTX:228 st.local.u32 [%rd2+56], %r601
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56))))) = (unsigned)(r601);
  // PTX:229 st.local.f32 [%rd2+28], %f21
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (28))))) = (float)(f21);
  // PTX:230 st.local.u32 [%rd2+60], %r44
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (60))))) = (unsigned)(r44);
  // PTX:231 st.local.u32 [%rd2+116], %r601
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116))))) = (unsigned)(r601);
  // PTX:232 st.local.f32 [%rd2+88], %f21
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (88))))) = (float)(f21);
  // PTX:233 add.f32 %f1579, %f21, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1579) : "f"(f21));
  // PTX:234 mul.lo.s64 %rd158, %rd52, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd158) : "l"(rd52));
  // PTX:235 add.s64 %rd159, %rd23, %rd158
  asm("add.s64 %0, %1, %2;" : "=l"(rd159) : "l"(rd23), "l"(rd158));
  // PTX:236 ld.global.f32 %f466, [%rd159]
  f466 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd159) + (0)))));
  // PTX:237 ld.global.f32 %f467, [%rd159+4]
  f467 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd159) + (4)))));
  // PTX:238 ld.global.f32 %f468, [%rd159+8]
  f468 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd159) + (8)))));
  // PTX:239 fma.rn.f32 %f1574, %f21, %f466, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f1574) : "f"(f21), "f"(f466));
  // PTX:240 fma.rn.f32 %f1575, %f21, %f467, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f1575) : "f"(f21), "f"(f467));
  // PTX:241 fma.rn.f32 %f1576, %f21, %f468, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f1576) : "f"(f21), "f"(f468));
  // PTX:242 add.s64 %rd160, %rd25, %rd158
  asm("add.s64 %0, %1, %2;" : "=l"(rd160) : "l"(rd25), "l"(rd158));
  // PTX:243 ld.global.f32 %f469, [%rd160]
  f469 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd160) + (0)))));
  // PTX:244 sub.f32 %f470, %f466, %f469
  asm("sub.f32 %0, %1, %2;" : "=f"(f470) : "f"(f466), "f"(f469));
  // PTX:245 ld.global.f32 %f471, [%rd160+4]
  f471 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd160) + (4)))));
  // PTX:246 sub.f32 %f472, %f467, %f471
  asm("sub.f32 %0, %1, %2;" : "=f"(f472) : "f"(f467), "f"(f471));
  // PTX:247 ld.global.f32 %f473, [%rd160+8]
  f473 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd160) + (8)))));
  // PTX:248 sub.f32 %f474, %f468, %f473
  asm("sub.f32 %0, %1, %2;" : "=f"(f474) : "f"(f468), "f"(f473));
  // PTX:249 mul.f32 %f475, %f21, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f475) : "f"(f21), "f"(f1));
  // PTX:250 fma.rn.f32 %f1571, %f475, %f470, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f1571) : "f"(f475), "f"(f470));
  // PTX:251 fma.rn.f32 %f1572, %f475, %f472, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f1572) : "f"(f475), "f"(f472));
  // PTX:252 fma.rn.f32 %f1573, %f475, %f474, 0f00000000
  asm("fma.rn.f32 %0, %1, %2, 0f00000000;" : "=f"(f1573) : "f"(f475), "f"(f474));
  // PTX:253 add.s64 %rd162, %rd26, %rd155
  asm("add.s64 %0, %1, %2;" : "=l"(rd162) : "l"(rd26), "l"(rd155));
  // PTX:254 ld.global.f32 %f47, [%rd162]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd162) + (0)))));
  // PTX:255 setp.leu.f32 %p29, %f47, 0f00000000
  p29 = ((isnan(((float)(f47))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f47)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:256 mov.u64 %rd404, 1
  asm("mov.u64 %0, 1;" : "=l"(rd404) : );
  // PTX:257 @%p29 bra $L__BB4_35
  if (p29) { goto L_BB4_35; }
  // PTX:259 setp.eq.s64 %p30, %rd27, 0
  p30 = (((long long)(rd27)) == ((long long)(0)));
  // PTX:260 @%p30 bra $L__BB4_34
  if (p30) { goto L_BB4_34; }
  // PTX:262 add.s64 %rd165, %rd28, %rd155
  asm("add.s64 %0, %1, %2;" : "=l"(rd165) : "l"(rd28), "l"(rd155));
  // PTX:263 ld.global.u32 %r602, [%rd165]
  r602 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd165) + (0)))));
  // PTX:264 and.b32 %r603, %r602, 1
  asm("and.b32 %0, %1, 1;" : "=r"(r603) : "r"(r602));
  // PTX:265 setp.eq.b32 %p31, %r603, 1
  p31 = (((unsigned)(r603)) == ((unsigned)(1)));
  // PTX:266 mov.pred %p32, 0
  p32 = ((0) != 0);
  // PTX:267 xor.pred %p33, %p31, %p32
  p33 = ((p31) != (p32));
  // PTX:268 not.pred %p34, %p33
  p34 = !(p33);
  // PTX:269 @%p34 bra $L__BB4_35
  if (p34) { goto L_BB4_35; }
  // PTX:271 $L__BB4_34:
L_BB4_34:;
  // PTX:272 mul.f32 %f477, %f21, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f477) : "f"(f21), "f"(f21));
  // PTX:273 div.rn.f32 %f478, %f477, %f47
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f478) : "f"(f477), "f"(f47));
  // PTX:274 add.f32 %f1578, %f478, 0f00000000
  asm("add.f32 %0, %1, 0f00000000;" : "=f"(f1578) : "f"(f478));
  // PTX:276 $L__BB4_35:
L_BB4_35:;
  // PTX:277 setp.lt.s32 %p35, %r42, 0
  p35 = (((int)(r42)) < ((int)(0)));
  // PTX:278 @%p35 bra $L__BB4_52
  if (p35) { goto L_BB4_52; }
  // PTX:280 abs.f32 %f494, %f22
  asm("abs.f32 %0, %1;" : "=f"(f494) : "f"(f22));
  // PTX:281 setp.geu.f32 %p36, %f494, 0f7F800000
  p36 = ((isnan(((float)(f494))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f494)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:282 setp.lt.f32 %p37, %f22, 0f00000000
  p37 = (!(isnan(((float)(f22))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f22)) < ((float)(as_f32(0x00000000u)))));
  // PTX:283 or.pred %p38, %p37, %p36
  p38 = ((p37) || (p36));
  // PTX:284 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:285 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:286 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:287 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:288 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:289 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:290 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:291 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:292 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:293 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:294 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:295 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:296 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:297 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:298 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:299 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:300 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:301 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:302 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:303 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:304 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:305 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:306 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:307 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:308 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:309 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:310 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:311 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:312 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:313 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:314 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:315 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:316 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:317 @%p38 bra $L__BB4_164
  if (p38) { goto L_BB4_164; }
  // PTX:319 setp.le.u64 %p39, %rd15, %rd50
  p39 = (((unsigned long long)(rd15)) <= ((unsigned long long)(rd50)));
  // PTX:320 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:321 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:322 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:323 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:324 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:325 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:326 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:327 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:328 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:329 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:330 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:331 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:332 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:333 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:334 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:335 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:336 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:337 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:338 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:339 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:340 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:341 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:342 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:343 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:344 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:345 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:346 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:347 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:348 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:349 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:350 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:351 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:352 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:353 @%p39 bra $L__BB4_164
  if (p39) { goto L_BB4_164; }
  // PTX:355 or.b64 %rd167, %rd50, %rd36
  asm("or.b64 %0, %1, %2;" : "=l"(rd167) : "l"(rd50), "l"(rd36));
  // PTX:356 and.b64 %rd168, %rd167, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd168) : "l"(rd167));
  // PTX:357 setp.eq.s64 %p40, %rd168, 0
  p40 = (((long long)(rd168)) == ((long long)(0)));
  // PTX:358 @%p40 bra $L__BB4_40
  if (p40) { goto L_BB4_40; }
  // PTX:360 div.u64 %rd405, %rd50, %rd36
  asm("div.u64 %0, %1, %2;" : "=l"(rd405) : "l"(rd50), "l"(rd36));
  // PTX:361 bra.uni $L__BB4_41
  goto L_BB4_41;
  // PTX:363 $L__BB4_40:
L_BB4_40:;
  // PTX:364 cvt.u32.u64 %r685, %rd50
  asm("cvt.u32.u64 %0, %1;" : "=r"(r685) : "l"(rd50));
  // PTX:365 div.u32 %r686, %r685, %r1
  asm("div.u32 %0, %1, %2;" : "=r"(r686) : "r"(r685), "r"(r1));
  // PTX:366 cvt.u64.u32 %rd405, %r686
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd405) : "r"(r686));
  // PTX:368 $L__BB4_41:
L_BB4_41:;
  // PTX:369 setp.ne.s64 %p41, %rd405, %rd399
  p41 = (((long long)(rd405)) != ((long long)(rd399)));
  // PTX:370 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:371 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:372 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:373 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:374 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:375 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:376 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:377 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:378 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:379 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:380 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:381 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:382 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:383 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:384 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:385 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:386 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:387 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:388 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:389 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:390 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:391 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:392 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:393 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:394 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:395 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:396 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:397 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:398 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:399 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:400 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:401 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:402 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:403 @%p41 bra $L__BB4_164
  if (p41) { goto L_BB4_164; }
  // PTX:405 @%p40 bra $L__BB4_44
  if (p40) { goto L_BB4_44; }
  // PTX:407 rem.u64 %rd406, %rd50, %rd36
  asm("rem.u64 %0, %1, %2;" : "=l"(rd406) : "l"(rd50), "l"(rd36));
  // PTX:408 bra.uni $L__BB4_45
  goto L_BB4_45;
  // PTX:410 $L__BB4_44:
L_BB4_44:;
  // PTX:411 cvt.u32.u64 %r728, %rd50
  asm("cvt.u32.u64 %0, %1;" : "=r"(r728) : "l"(rd50));
  // PTX:412 rem.u32 %r729, %r728, %r1
  asm("rem.u32 %0, %1, %2;" : "=r"(r729) : "r"(r728), "r"(r1));
  // PTX:413 cvt.u64.u32 %rd406, %r729
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd406) : "r"(r729));
  // PTX:415 $L__BB4_45:
L_BB4_45:;
  // PTX:416 @%p26 bra $L__BB4_47
  if (p26) { goto L_BB4_47; }
  // PTX:418 shl.b64 %rd171, %rd406, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd171) : "l"(rd406));
  // PTX:419 add.s64 %rd172, %rd22, %rd171
  asm("add.s64 %0, %1, %2;" : "=l"(rd172) : "l"(rd22), "l"(rd171));
  // PTX:420 ld.global.u32 %r770, [%rd172]
  r770 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (0)))));
  // PTX:421 setp.ne.s32 %p44, %r770, 0
  p44 = (((int)(r770)) != ((int)(0)));
  // PTX:422 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:423 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:424 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:425 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:426 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:427 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:428 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:429 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:430 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:431 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:432 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:433 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:434 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:435 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:436 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:437 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:438 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:439 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:440 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:441 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:442 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:443 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:444 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:445 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:446 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:447 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:448 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:449 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:450 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:451 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:452 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:453 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:454 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:455 @%p44 bra $L__BB4_164
  if (p44) { goto L_BB4_164; }
  // PTX:457 $L__BB4_47:
L_BB4_47:;
  // PTX:458 shl.b64 %rd173, %rd406, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd173) : "l"(rd406));
  // PTX:459 add.s64 %rd174, %rd20, %rd173
  asm("add.s64 %0, %1, %2;" : "=l"(rd174) : "l"(rd20), "l"(rd173));
  // PTX:460 ld.global.f32 %f540, [%rd174]
  f540 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (0)))));
  // PTX:461 max.f32 %f1577, %f1577, %f540
  asm("max.f32 %0, %1, %2;" : "=f"(f1577) : "f"(f1577), "f"(f540));
  // PTX:462 setp.eq.f32 %p45, %f22, 0f00000000
  p45 = (!(isnan(((float)(f22))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f22)) == ((float)(as_f32(0x00000000u)))));
  // PTX:463 @%p45 bra $L__BB4_52
  if (p45) { goto L_BB4_52; }
  // PTX:465 shl.b64 %rd175, %rd404, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd175) : "l"(rd404));
  // PTX:466 add.s64 %rd176, %rd2, %rd175
  asm("add.s64 %0, %1, %2;" : "=l"(rd176) : "l"(rd2), "l"(rd175));
  // PTX:467 st.local.u32 [%rd176], %r42
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd176) + (0))))) = (unsigned)(r42);
  // PTX:468 ld.local.u32 %r771, [%rd2+56]
  r771 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:469 add.s32 %r772, %r771, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r772) : "r"(r771));
  // PTX:470 st.local.u32 [%rd2+56], %r772
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56))))) = (unsigned)(r772);
  // PTX:471 mul.wide.s32 %rd177, %r771, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd177) : "r"(r771));
  // PTX:472 add.s64 %rd178, %rd2, %rd177
  asm("add.s64 %0, %1, %2;" : "=l"(rd178) : "l"(rd2), "l"(rd177));
  // PTX:473 st.local.f32 [%rd178+28], %f22
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd178) + (28))))) = (float)(f22);
  // PTX:474 ld.local.u32 %r773, [%rd2+116]
  r773 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:475 mul.wide.s32 %rd179, %r773, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd179) : "r"(r773));
  // PTX:476 add.s64 %rd180, %rd2, %rd179
  asm("add.s64 %0, %1, %2;" : "=l"(rd180) : "l"(rd2), "l"(rd179));
  // PTX:477 st.local.u32 [%rd180+60], %r42
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd180) + (60))))) = (unsigned)(r42);
  // PTX:478 ld.local.u32 %r774, [%rd2+116]
  r774 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:479 add.s32 %r775, %r774, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r775) : "r"(r774));
  // PTX:480 st.local.u32 [%rd2+116], %r775
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116))))) = (unsigned)(r775);
  // PTX:481 mul.wide.s32 %rd181, %r774, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd181) : "r"(r774));
  // PTX:482 add.s64 %rd182, %rd2, %rd181
  asm("add.s64 %0, %1, %2;" : "=l"(rd182) : "l"(rd2), "l"(rd181));
  // PTX:483 st.local.f32 [%rd182+88], %f22
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd182) + (88))))) = (float)(f22);
  // PTX:484 add.f32 %f1579, %f1579, %f22
  asm("add.f32 %0, %1, %2;" : "=f"(f1579) : "f"(f1579), "f"(f22));
  // PTX:485 mul.lo.s64 %rd183, %rd50, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd183) : "l"(rd50));
  // PTX:486 add.s64 %rd184, %rd23, %rd183
  asm("add.s64 %0, %1, %2;" : "=l"(rd184) : "l"(rd23), "l"(rd183));
  // PTX:487 ld.global.f32 %f541, [%rd184]
  f541 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (0)))));
  // PTX:488 ld.global.f32 %f542, [%rd184+4]
  f542 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (4)))));
  // PTX:489 ld.global.f32 %f543, [%rd184+8]
  f543 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (8)))));
  // PTX:490 fma.rn.f32 %f1574, %f22, %f541, %f1574
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1574) : "f"(f22), "f"(f541), "f"(f1574));
  // PTX:491 fma.rn.f32 %f1575, %f22, %f542, %f1575
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1575) : "f"(f22), "f"(f542), "f"(f1575));
  // PTX:492 fma.rn.f32 %f1576, %f22, %f543, %f1576
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1576) : "f"(f22), "f"(f543), "f"(f1576));
  // PTX:493 add.s64 %rd185, %rd25, %rd183
  asm("add.s64 %0, %1, %2;" : "=l"(rd185) : "l"(rd25), "l"(rd183));
  // PTX:494 ld.global.f32 %f544, [%rd185]
  f544 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (0)))));
  // PTX:495 sub.f32 %f545, %f541, %f544
  asm("sub.f32 %0, %1, %2;" : "=f"(f545) : "f"(f541), "f"(f544));
  // PTX:496 ld.global.f32 %f546, [%rd185+4]
  f546 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (4)))));
  // PTX:497 sub.f32 %f547, %f542, %f546
  asm("sub.f32 %0, %1, %2;" : "=f"(f547) : "f"(f542), "f"(f546));
  // PTX:498 ld.global.f32 %f548, [%rd185+8]
  f548 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd185) + (8)))));
  // PTX:499 sub.f32 %f549, %f543, %f548
  asm("sub.f32 %0, %1, %2;" : "=f"(f549) : "f"(f543), "f"(f548));
  // PTX:500 mul.f32 %f550, %f22, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f550) : "f"(f22), "f"(f1));
  // PTX:501 fma.rn.f32 %f1571, %f550, %f545, %f1571
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1571) : "f"(f550), "f"(f545), "f"(f1571));
  // PTX:502 fma.rn.f32 %f1572, %f550, %f547, %f1572
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1572) : "f"(f550), "f"(f547), "f"(f1572));
  // PTX:503 fma.rn.f32 %f1573, %f550, %f549, %f1573
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1573) : "f"(f550), "f"(f549), "f"(f1573));
  // PTX:504 add.s64 %rd187, %rd26, %rd173
  asm("add.s64 %0, %1, %2;" : "=l"(rd187) : "l"(rd26), "l"(rd173));
  // PTX:505 ld.global.f32 %f65, [%rd187]
  f65 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd187) + (0)))));
  // PTX:506 setp.leu.f32 %p46, %f65, 0f00000000
  p46 = ((isnan(((float)(f65))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f65)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:507 @%p46 bra $L__BB4_52
  if (p46) { goto L_BB4_52; }
  // PTX:509 setp.eq.s64 %p47, %rd27, 0
  p47 = (((long long)(rd27)) == ((long long)(0)));
  // PTX:510 @%p47 bra $L__BB4_51
  if (p47) { goto L_BB4_51; }
  // PTX:512 add.s64 %rd189, %rd28, %rd173
  asm("add.s64 %0, %1, %2;" : "=l"(rd189) : "l"(rd28), "l"(rd173));
  // PTX:513 ld.global.u32 %r776, [%rd189]
  r776 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd189) + (0)))));
  // PTX:514 and.b32 %r777, %r776, 1
  asm("and.b32 %0, %1, 1;" : "=r"(r777) : "r"(r776));
  // PTX:515 setp.eq.b32 %p48, %r777, 1
  p48 = (((unsigned)(r777)) == ((unsigned)(1)));
  // PTX:516 mov.pred %p49, 0
  p49 = ((0) != 0);
  // PTX:517 xor.pred %p50, %p48, %p49
  p50 = ((p48) != (p49));
  // PTX:518 not.pred %p51, %p50
  p51 = !(p50);
  // PTX:519 @%p51 bra $L__BB4_52
  if (p51) { goto L_BB4_52; }
  // PTX:521 $L__BB4_51:
L_BB4_51:;
  // PTX:522 mul.f32 %f551, %f22, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f551) : "f"(f22), "f"(f22));
  // PTX:523 div.rn.f32 %f552, %f551, %f65
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f552) : "f"(f551), "f"(f65));
  // PTX:524 add.f32 %f1578, %f1578, %f552
  asm("add.f32 %0, %1, %2;" : "=f"(f1578) : "f"(f1578), "f"(f552));
  // PTX:526 $L__BB4_52:
L_BB4_52:;
  // PTX:527 setp.lt.s32 %p52, %r43, 0
  p52 = (((int)(r43)) < ((int)(0)));
  // PTX:528 @%p52 bra $L__BB4_69
  if (p52) { goto L_BB4_69; }
  // PTX:530 abs.f32 %f568, %f23
  asm("abs.f32 %0, %1;" : "=f"(f568) : "f"(f23));
  // PTX:531 setp.geu.f32 %p53, %f568, 0f7F800000
  p53 = ((isnan(((float)(f568))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f568)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:532 setp.lt.f32 %p54, %f23, 0f00000000
  p54 = (!(isnan(((float)(f23))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f23)) < ((float)(as_f32(0x00000000u)))));
  // PTX:533 or.pred %p55, %p54, %p53
  p55 = ((p54) || (p53));
  // PTX:534 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:535 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:536 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:537 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:538 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:539 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:540 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:541 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:542 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:543 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:544 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:545 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:546 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:547 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:548 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:549 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:550 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:551 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:552 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:553 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:554 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:555 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:556 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:557 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:558 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:559 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:560 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:561 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:562 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:563 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:564 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:565 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:566 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:567 @%p55 bra $L__BB4_164
  if (p55) { goto L_BB4_164; }
  // PTX:569 setp.le.u64 %p56, %rd15, %rd51
  p56 = (((unsigned long long)(rd15)) <= ((unsigned long long)(rd51)));
  // PTX:570 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:571 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:572 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:573 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:574 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:575 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:576 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:577 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:578 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:579 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:580 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:581 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:582 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:583 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:584 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:585 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:586 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:587 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:588 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:589 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:590 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:591 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:592 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:593 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:594 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:595 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:596 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:597 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:598 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:599 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:600 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:601 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:602 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:603 @%p56 bra $L__BB4_164
  if (p56) { goto L_BB4_164; }
  // PTX:605 or.b64 %rd190, %rd51, %rd36
  asm("or.b64 %0, %1, %2;" : "=l"(rd190) : "l"(rd51), "l"(rd36));
  // PTX:606 and.b64 %rd191, %rd190, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd191) : "l"(rd190));
  // PTX:607 setp.eq.s64 %p57, %rd191, 0
  p57 = (((long long)(rd191)) == ((long long)(0)));
  // PTX:608 @%p57 bra $L__BB4_57
  if (p57) { goto L_BB4_57; }
  // PTX:610 div.u64 %rd407, %rd51, %rd36
  asm("div.u64 %0, %1, %2;" : "=l"(rd407) : "l"(rd51), "l"(rd36));
  // PTX:611 bra.uni $L__BB4_58
  goto L_BB4_58;
  // PTX:613 $L__BB4_57:
L_BB4_57:;
  // PTX:614 cvt.u32.u64 %r859, %rd51
  asm("cvt.u32.u64 %0, %1;" : "=r"(r859) : "l"(rd51));
  // PTX:615 div.u32 %r860, %r859, %r1
  asm("div.u32 %0, %1, %2;" : "=r"(r860) : "r"(r859), "r"(r1));
  // PTX:616 cvt.u64.u32 %rd407, %r860
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd407) : "r"(r860));
  // PTX:618 $L__BB4_58:
L_BB4_58:;
  // PTX:619 setp.ne.s64 %p58, %rd407, %rd399
  p58 = (((long long)(rd407)) != ((long long)(rd399)));
  // PTX:620 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:621 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:622 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:623 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:624 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:625 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:626 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:627 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:628 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:629 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:630 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:631 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:632 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:633 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:634 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:635 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:636 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:637 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:638 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:639 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:640 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:641 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:642 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:643 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:644 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:645 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:646 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:647 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:648 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:649 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:650 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:651 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:652 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:653 @%p58 bra $L__BB4_164
  if (p58) { goto L_BB4_164; }
  // PTX:655 @%p57 bra $L__BB4_61
  if (p57) { goto L_BB4_61; }
  // PTX:657 rem.u64 %rd408, %rd51, %rd36
  asm("rem.u64 %0, %1, %2;" : "=l"(rd408) : "l"(rd51), "l"(rd36));
  // PTX:658 bra.uni $L__BB4_62
  goto L_BB4_62;
  // PTX:660 $L__BB4_61:
L_BB4_61:;
  // PTX:661 cvt.u32.u64 %r902, %rd51
  asm("cvt.u32.u64 %0, %1;" : "=r"(r902) : "l"(rd51));
  // PTX:662 rem.u32 %r903, %r902, %r1
  asm("rem.u32 %0, %1, %2;" : "=r"(r903) : "r"(r902), "r"(r1));
  // PTX:663 cvt.u64.u32 %rd408, %r903
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd408) : "r"(r903));
  // PTX:665 $L__BB4_62:
L_BB4_62:;
  // PTX:666 @%p26 bra $L__BB4_64
  if (p26) { goto L_BB4_64; }
  // PTX:668 shl.b64 %rd194, %rd408, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd194) : "l"(rd408));
  // PTX:669 add.s64 %rd195, %rd22, %rd194
  asm("add.s64 %0, %1, %2;" : "=l"(rd195) : "l"(rd22), "l"(rd194));
  // PTX:670 ld.global.u32 %r944, [%rd195]
  r944 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd195) + (0)))));
  // PTX:671 setp.ne.s32 %p61, %r944, 0
  p61 = (((int)(r944)) != ((int)(0)));
  // PTX:672 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:673 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:674 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:675 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:676 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:677 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:678 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:679 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:680 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:681 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:682 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:683 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:684 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:685 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:686 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:687 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:688 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:689 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:690 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:691 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:692 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:693 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:694 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:695 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:696 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:697 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:698 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:699 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:700 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:701 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:702 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:703 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:704 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:705 @%p61 bra $L__BB4_164
  if (p61) { goto L_BB4_164; }
  // PTX:707 $L__BB4_64:
L_BB4_64:;
  // PTX:708 shl.b64 %rd196, %rd408, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd196) : "l"(rd408));
  // PTX:709 add.s64 %rd197, %rd20, %rd196
  asm("add.s64 %0, %1, %2;" : "=l"(rd197) : "l"(rd20), "l"(rd196));
  // PTX:710 ld.global.f32 %f614, [%rd197]
  f614 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd197) + (0)))));
  // PTX:711 max.f32 %f1577, %f1577, %f614
  asm("max.f32 %0, %1, %2;" : "=f"(f1577) : "f"(f1577), "f"(f614));
  // PTX:712 setp.eq.f32 %p62, %f23, 0f00000000
  p62 = (!(isnan(((float)(f23))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f23)) == ((float)(as_f32(0x00000000u)))));
  // PTX:713 @%p62 bra $L__BB4_69
  if (p62) { goto L_BB4_69; }
  // PTX:715 ld.local.u32 %r945, [%rd2+56]
  r945 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:716 mul.wide.s32 %rd198, %r945, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd198) : "r"(r945));
  // PTX:717 add.s64 %rd199, %rd2, %rd198
  asm("add.s64 %0, %1, %2;" : "=l"(rd199) : "l"(rd2), "l"(rd198));
  // PTX:718 st.local.u32 [%rd199], %r43
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd199) + (0))))) = (unsigned)(r43);
  // PTX:719 ld.local.u32 %r946, [%rd2+56]
  r946 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:720 add.s32 %r947, %r946, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r947) : "r"(r946));
  // PTX:721 st.local.u32 [%rd2+56], %r947
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56))))) = (unsigned)(r947);
  // PTX:722 mul.wide.s32 %rd200, %r946, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd200) : "r"(r946));
  // PTX:723 add.s64 %rd201, %rd2, %rd200
  asm("add.s64 %0, %1, %2;" : "=l"(rd201) : "l"(rd2), "l"(rd200));
  // PTX:724 st.local.f32 [%rd201+28], %f23
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd201) + (28))))) = (float)(f23);
  // PTX:725 ld.local.u32 %r948, [%rd2+116]
  r948 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:726 mul.wide.s32 %rd202, %r948, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd202) : "r"(r948));
  // PTX:727 add.s64 %rd203, %rd2, %rd202
  asm("add.s64 %0, %1, %2;" : "=l"(rd203) : "l"(rd2), "l"(rd202));
  // PTX:728 st.local.u32 [%rd203+60], %r43
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd203) + (60))))) = (unsigned)(r43);
  // PTX:729 ld.local.u32 %r949, [%rd2+116]
  r949 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:730 add.s32 %r950, %r949, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r950) : "r"(r949));
  // PTX:731 st.local.u32 [%rd2+116], %r950
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116))))) = (unsigned)(r950);
  // PTX:732 mul.wide.s32 %rd204, %r949, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd204) : "r"(r949));
  // PTX:733 add.s64 %rd205, %rd2, %rd204
  asm("add.s64 %0, %1, %2;" : "=l"(rd205) : "l"(rd2), "l"(rd204));
  // PTX:734 st.local.f32 [%rd205+88], %f23
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd205) + (88))))) = (float)(f23);
  // PTX:735 add.f32 %f1579, %f1579, %f23
  asm("add.f32 %0, %1, %2;" : "=f"(f1579) : "f"(f1579), "f"(f23));
  // PTX:736 mul.lo.s64 %rd206, %rd51, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd206) : "l"(rd51));
  // PTX:737 add.s64 %rd207, %rd23, %rd206
  asm("add.s64 %0, %1, %2;" : "=l"(rd207) : "l"(rd23), "l"(rd206));
  // PTX:738 ld.global.f32 %f615, [%rd207]
  f615 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd207) + (0)))));
  // PTX:739 ld.global.f32 %f616, [%rd207+4]
  f616 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd207) + (4)))));
  // PTX:740 ld.global.f32 %f617, [%rd207+8]
  f617 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd207) + (8)))));
  // PTX:741 fma.rn.f32 %f1574, %f23, %f615, %f1574
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1574) : "f"(f23), "f"(f615), "f"(f1574));
  // PTX:742 fma.rn.f32 %f1575, %f23, %f616, %f1575
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1575) : "f"(f23), "f"(f616), "f"(f1575));
  // PTX:743 fma.rn.f32 %f1576, %f23, %f617, %f1576
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1576) : "f"(f23), "f"(f617), "f"(f1576));
  // PTX:744 add.s64 %rd208, %rd25, %rd206
  asm("add.s64 %0, %1, %2;" : "=l"(rd208) : "l"(rd25), "l"(rd206));
  // PTX:745 ld.global.f32 %f618, [%rd208]
  f618 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd208) + (0)))));
  // PTX:746 sub.f32 %f619, %f615, %f618
  asm("sub.f32 %0, %1, %2;" : "=f"(f619) : "f"(f615), "f"(f618));
  // PTX:747 ld.global.f32 %f620, [%rd208+4]
  f620 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd208) + (4)))));
  // PTX:748 sub.f32 %f621, %f616, %f620
  asm("sub.f32 %0, %1, %2;" : "=f"(f621) : "f"(f616), "f"(f620));
  // PTX:749 ld.global.f32 %f622, [%rd208+8]
  f622 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd208) + (8)))));
  // PTX:750 sub.f32 %f623, %f617, %f622
  asm("sub.f32 %0, %1, %2;" : "=f"(f623) : "f"(f617), "f"(f622));
  // PTX:751 mul.f32 %f624, %f23, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f624) : "f"(f23), "f"(f1));
  // PTX:752 fma.rn.f32 %f1571, %f624, %f619, %f1571
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1571) : "f"(f624), "f"(f619), "f"(f1571));
  // PTX:753 fma.rn.f32 %f1572, %f624, %f621, %f1572
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1572) : "f"(f624), "f"(f621), "f"(f1572));
  // PTX:754 fma.rn.f32 %f1573, %f624, %f623, %f1573
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1573) : "f"(f624), "f"(f623), "f"(f1573));
  // PTX:755 add.s64 %rd210, %rd26, %rd196
  asm("add.s64 %0, %1, %2;" : "=l"(rd210) : "l"(rd26), "l"(rd196));
  // PTX:756 ld.global.f32 %f84, [%rd210]
  f84 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd210) + (0)))));
  // PTX:757 setp.leu.f32 %p63, %f84, 0f00000000
  p63 = ((isnan(((float)(f84))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f84)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:758 @%p63 bra $L__BB4_69
  if (p63) { goto L_BB4_69; }
  // PTX:760 setp.eq.s64 %p64, %rd27, 0
  p64 = (((long long)(rd27)) == ((long long)(0)));
  // PTX:761 @%p64 bra $L__BB4_68
  if (p64) { goto L_BB4_68; }
  // PTX:763 add.s64 %rd212, %rd28, %rd196
  asm("add.s64 %0, %1, %2;" : "=l"(rd212) : "l"(rd28), "l"(rd196));
  // PTX:764 ld.global.u32 %r951, [%rd212]
  r951 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd212) + (0)))));
  // PTX:765 and.b32 %r952, %r951, 1
  asm("and.b32 %0, %1, 1;" : "=r"(r952) : "r"(r951));
  // PTX:766 setp.eq.b32 %p65, %r952, 1
  p65 = (((unsigned)(r952)) == ((unsigned)(1)));
  // PTX:767 mov.pred %p66, 0
  p66 = ((0) != 0);
  // PTX:768 xor.pred %p67, %p65, %p66
  p67 = ((p65) != (p66));
  // PTX:769 not.pred %p68, %p67
  p68 = !(p67);
  // PTX:770 @%p68 bra $L__BB4_69
  if (p68) { goto L_BB4_69; }
  // PTX:772 $L__BB4_68:
L_BB4_68:;
  // PTX:773 mul.f32 %f625, %f23, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f625) : "f"(f23), "f"(f23));
  // PTX:774 div.rn.f32 %f626, %f625, %f84
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f626) : "f"(f625), "f"(f84));
  // PTX:775 add.f32 %f1578, %f1578, %f626
  asm("add.f32 %0, %1, %2;" : "=f"(f1578) : "f"(f1578), "f"(f626));
  // PTX:777 $L__BB4_69:
L_BB4_69:;
  // PTX:778 abs.f32 %f642, %f1577
  asm("abs.f32 %0, %1;" : "=f"(f642) : "f"(f1577));
  // PTX:779 setp.geu.f32 %p69, %f642, 0f7F800000
  p69 = ((isnan(((float)(f642))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f642)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:780 ld.local.u32 %r88, [%rd2+56]
  r88 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:781 setp.eq.s32 %p70, %r88, 0
  p70 = (((int)(r88)) == ((int)(0)));
  // PTX:782 or.pred %p71, %p69, %p70
  p71 = ((p69) || (p70));
  // PTX:783 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:784 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:785 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:786 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:787 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:788 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:789 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:790 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:791 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:792 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:793 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:794 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:795 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:796 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:797 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:798 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:799 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:800 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:801 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:802 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:803 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:804 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:805 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:806 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:807 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:808 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:809 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:810 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:811 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:812 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:813 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:814 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:815 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:816 @%p71 bra $L__BB4_164
  if (p71) { goto L_BB4_164; }
  // PTX:818 add.f32 %f658, %f1579, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f658) : "f"(f1579));
  // PTX:819 abs.f32 %f659, %f658
  asm("abs.f32 %0, %1;" : "=f"(f659) : "f"(f658));
  // PTX:820 setp.gt.f32 %p72, %f659, 0f38D1B717
  p72 = (!(isnan(((float)(f659))) || isnan(((float)(as_f32(0x38D1B717u))))) && (((float)(f659)) > ((float)(as_f32(0x38D1B717u)))));
  // PTX:821 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:822 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:823 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:824 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:825 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:826 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:827 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:828 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:829 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:830 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:831 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:832 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:833 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:834 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:835 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:836 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:837 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:838 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:839 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:840 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:841 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:842 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:843 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:844 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:845 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:846 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:847 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:848 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:849 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:850 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:851 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:852 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:853 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:854 @%p72 bra $L__BB4_164
  if (p72) { goto L_BB4_164; }
  // PTX:856 shl.b64 %rd213, %rd402, 32
  asm("shl.b64 %0, %1, 32;" : "=l"(rd213) : "l"(rd402));
  // PTX:857 cvt.s64.s32 %rd82, %rd402
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd82) : "l"(rd402));
  // PTX:858 shr.s64 %rd214, %rd213, 30
  asm("shr.s64 %0, %1, 30;" : "=l"(rd214) : "l"(rd213));
  // PTX:859 add.s64 %rd215, %rd29, %rd214
  asm("add.s64 %0, %1, %2;" : "=l"(rd215) : "l"(rd29), "l"(rd214));
  // PTX:860 ld.global.s32 %rd83, [%rd215]
  rd83 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd215) + (0)))));
  // PTX:861 setp.lt.s64 %p73, %rd83, 0
  p73 = (((long long)(rd83)) < ((long long)(0)));
  // PTX:862 mov.u32 %r1033, -1
  asm("mov.u32 %0, -1;" : "=r"(r1033) : );
  // PTX:863 mov.u32 %r1790, %r1033
  asm("mov.u32 %0, %1;" : "=r"(r1790) : "r"(r1033));
  // PTX:864 @%p73 bra $L__BB4_79
  if (p73) { goto L_BB4_79; }
  // PTX:866 setp.gt.u64 %p74, %rd31, %rd83
  p74 = (((unsigned long long)(rd31)) > ((unsigned long long)(rd83)));
  // PTX:867 @%p74 bra $L__BB4_74
  if (p74) { goto L_BB4_74; }
  // PTX:868 bra.uni $L__BB4_73
  goto L_BB4_73;
  // PTX:870 $L__BB4_74:
L_BB4_74:;
  // PTX:871 cvt.u32.u64 %r1035, %rd83
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1035) : "l"(rd83));
  // PTX:872 shl.b64 %rd216, %rd83, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd216) : "l"(rd83));
  // PTX:873 add.s64 %rd217, %rd30, %rd216
  asm("add.s64 %0, %1, %2;" : "=l"(rd217) : "l"(rd30), "l"(rd216));
  // PTX:874 ld.global.u32 %r1036, [%rd217]
  r1036 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd217) + (0)))));
  // PTX:875 setp.eq.s32 %p76, %r1036, %r1035
  p76 = (((int)(r1036)) == ((int)(r1035)));
  // PTX:876 setp.eq.s64 %p77, %rd31, 0
  p77 = (((long long)(rd31)) == ((long long)(0)));
  // PTX:877 or.pred %p78, %p76, %p77
  p78 = ((p76) || (p77));
  // PTX:878 selp.b32 %r1790, %r1035, -1, %p76
  r1790 = p76 ? r1035 : -1;
  // PTX:879 @%p78 bra $L__BB4_79
  if (p78) { goto L_BB4_79; }
  // PTX:880 bra.uni $L__BB4_75
  goto L_BB4_75;
  // PTX:882 $L__BB4_73:
L_BB4_73:;
  // PTX:883 setp.eq.s64 %p75, %rd31, 0
  p75 = (((long long)(rd31)) == ((long long)(0)));
  // PTX:884 mov.u32 %r1790, %r1033
  asm("mov.u32 %0, %1;" : "=r"(r1790) : "r"(r1033));
  // PTX:885 @%p75 bra $L__BB4_79
  if (p75) { goto L_BB4_79; }
  // PTX:887 $L__BB4_75:
L_BB4_75:;
  // PTX:888 mov.u64 %rd409, 0
  asm("mov.u64 %0, 0;" : "=l"(rd409) : );
  // PTX:890 $L__BB4_76:
L_BB4_76:;
  // PTX:891 shl.b64 %rd219, %rd409, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd219) : "l"(rd409));
  // PTX:892 add.s64 %rd220, %rd30, %rd219
  asm("add.s64 %0, %1, %2;" : "=l"(rd220) : "l"(rd30), "l"(rd219));
  // PTX:893 ld.global.u32 %r1037, [%rd220]
  r1037 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd220) + (0)))));
  // PTX:894 cvt.u32.u64 %r1038, %rd83
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1038) : "l"(rd83));
  // PTX:895 setp.eq.s32 %p79, %r1037, %r1038
  p79 = (((int)(r1037)) == ((int)(r1038)));
  // PTX:896 @%p79 bra $L__BB4_78
  if (p79) { goto L_BB4_78; }
  // PTX:898 add.s64 %rd409, %rd409, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd409) : "l"(rd409));
  // PTX:899 setp.lt.u64 %p80, %rd409, %rd31
  p80 = (((unsigned long long)(rd409)) < ((unsigned long long)(rd31)));
  // PTX:900 mov.u32 %r1790, %r1033
  asm("mov.u32 %0, %1;" : "=r"(r1790) : "r"(r1033));
  // PTX:901 @%p80 bra $L__BB4_76
  if (p80) { goto L_BB4_76; }
  // PTX:902 bra.uni $L__BB4_79
  goto L_BB4_79;
  // PTX:904 $L__BB4_78:
L_BB4_78:;
  // PTX:905 cvt.u32.u64 %r1790, %rd409
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1790) : "l"(rd409));
  // PTX:907 $L__BB4_79:
L_BB4_79:;
  // PTX:908 cvt.u32.u64 %r1080, %rd83
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1080) : "l"(rd83));
  // PTX:909 setp.gt.s32 %p81, %r1080, -1
  p81 = (((int)(r1080)) > ((int)(-1)));
  // PTX:910 setp.lt.s32 %p82, %r1790, 0
  p82 = (((int)(r1790)) < ((int)(0)));
  // PTX:911 and.pred %p83, %p81, %p82
  p83 = ((p81) && (p82));
  // PTX:912 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:913 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:914 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:915 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:916 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:917 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:918 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:919 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:920 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:921 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:922 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:923 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:924 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:925 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:926 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:927 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:928 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:929 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:930 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:931 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:932 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:933 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:934 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:935 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:936 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:937 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:938 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:939 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:940 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:941 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:942 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:943 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:944 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:945 @%p83 bra $L__BB4_164
  if (p83) { goto L_BB4_164; }
  // PTX:947 setp.gt.s32 %p84, %r1790, -1
  p84 = (((int)(r1790)) > ((int)(-1)));
  // PTX:948 setp.lt.s32 %p85, %r1789, 0
  p85 = (((int)(r1789)) < ((int)(0)));
  // PTX:949 and.pred %p86, %p85, %p84
  p86 = ((p85) && (p84));
  // PTX:950 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:951 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:952 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:953 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:954 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:955 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:956 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:957 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:958 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:959 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:960 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:961 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:962 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:963 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:964 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:965 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:966 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:967 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:968 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:969 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:970 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:971 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:972 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:973 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:974 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:975 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:976 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:977 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:978 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:979 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:980 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:981 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:982 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:983 @%p86 bra $L__BB4_164
  if (p86) { goto L_BB4_164; }
  // PTX:985 mov.u32 %r1795, 0
  asm("mov.u32 %0, 0;" : "=r"(r1795) : );
  // PTX:986 add.s64 %rd222, %rd32, %rd141
  asm("add.s64 %0, %1, %2;" : "=l"(rd222) : "l"(rd32), "l"(rd141));
  // PTX:987 ld.global.u32 %r1841, [%rd222]
  r1841 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd222) + (0)))));
  // PTX:988 ld.global.u32 %r1842, [%rd222+4]
  r1842 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd222) + (4)))));
  // PTX:989 ld.global.u32 %r1843, [%rd222+8]
  r1843 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd222) + (8)))));
  // PTX:990 shl.b64 %rd223, %rd82, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd223) : "l"(rd82));
  // PTX:991 add.s64 %rd224, %rd33, %rd223
  asm("add.s64 %0, %1, %2;" : "=l"(rd224) : "l"(rd33), "l"(rd223));
  // PTX:992 ld.global.u32 %r95, [%rd224]
  r95 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd224) + (0)))));
  // PTX:993 mov.u32 %r1791, %r1795
  asm("mov.u32 %0, %1;" : "=r"(r1791) : "r"(r1795));
  // PTX:994 mov.u32 %r1792, %r1795
  asm("mov.u32 %0, %1;" : "=r"(r1792) : "r"(r1795));
  // PTX:995 mov.u32 %r1793, %r1795
  asm("mov.u32 %0, %1;" : "=r"(r1793) : "r"(r1795));
  // PTX:996 mov.u32 %r1794, %r1795
  asm("mov.u32 %0, %1;" : "=r"(r1794) : "r"(r1795));
  // PTX:997 @%p82 bra $L__BB4_83
  if (p82) { goto L_BB4_83; }
  // PTX:999 mul.wide.s32 %rd225, %r1790, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd225) : "r"(r1790));
  // PTX:1000 add.s64 %rd226, %rd35, %rd225
  asm("add.s64 %0, %1, %2;" : "=l"(rd226) : "l"(rd35), "l"(rd225));
  // PTX:1001 mul.lo.s32 %r1125, %r1, %r85
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r1125) : "r"(r1), "r"(r85));
  // PTX:1002 ld.global.u32 %r1126, [%rd226]
  r1126 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd226) + (0)))));
  // PTX:1003 add.s32 %r1794, %r1125, %r1126
  asm("add.s32 %0, %1, %2;" : "=r"(r1794) : "r"(r1125), "r"(r1126));
  // PTX:1004 ld.global.u32 %r1127, [%rd226+4]
  r1127 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd226) + (4)))));
  // PTX:1005 add.s32 %r1793, %r1125, %r1127
  asm("add.s32 %0, %1, %2;" : "=r"(r1793) : "r"(r1125), "r"(r1127));
  // PTX:1006 ld.global.u32 %r1128, [%rd226+8]
  r1128 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd226) + (8)))));
  // PTX:1007 add.s32 %r1792, %r1125, %r1128
  asm("add.s32 %0, %1, %2;" : "=r"(r1792) : "r"(r1125), "r"(r1128));
  // PTX:1008 ld.global.u32 %r1129, [%rd226+12]
  r1129 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd226) + (12)))));
  // PTX:1009 add.s32 %r1791, %r1125, %r1129
  asm("add.s32 %0, %1, %2;" : "=r"(r1791) : "r"(r1125), "r"(r1129));
  // PTX:1011 $L__BB4_83:
L_BB4_83:;
  // PTX:1012 add.s64 %rd228, %rd34, %rd141
  asm("add.s64 %0, %1, %2;" : "=l"(rd228) : "l"(rd34), "l"(rd141));
  // PTX:1013 ld.global.f32 %f95, [%rd228]
  f95 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd228) + (0)))));
  // PTX:1014 ld.global.f32 %f96, [%rd228+4]
  f96 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd228) + (4)))));
  // PTX:1015 mul.f32 %f690, %f96, %f96
  asm("mul.f32 %0, %1, %2;" : "=f"(f690) : "f"(f96), "f"(f96));
  // PTX:1016 ld.global.f32 %f97, [%rd228+8]
  f97 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd228) + (8)))));
  // PTX:1017 fma.rn.f32 %f691, %f95, %f95, %f690
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f691) : "f"(f95), "f"(f95), "f"(f690));
  // PTX:1018 fma.rn.f32 %f692, %f97, %f97, %f691
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f692) : "f"(f97), "f"(f97), "f"(f691));
  // PTX:1019 sqrt.rn.f32 %f98, %f692
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f98) : "f"(f692));
  // PTX:1020 setp.leu.f32 %p88, %f98, 0f00000000
  p88 = ((isnan(((float)(f98))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f98)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1021 mov.u32 %r1796, %r1795
  asm("mov.u32 %0, %1;" : "=r"(r1796) : "r"(r1795));
  // PTX:1022 mov.u32 %r1797, %r1795
  asm("mov.u32 %0, %1;" : "=r"(r1797) : "r"(r1795));
  // PTX:1023 @%p88 bra $L__BB4_85
  if (p88) { goto L_BB4_85; }
  // PTX:1025 div.rn.f32 %f693, %f95, %f98
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f693) : "f"(f95), "f"(f98));
  // PTX:1026 div.rn.f32 %f694, %f96, %f98
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f694) : "f"(f96), "f"(f98));
  // PTX:1027 div.rn.f32 %f695, %f97, %f98
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f695) : "f"(f97), "f"(f98));
  // PTX:1028 mov.b32 %r1797, %f695
  asm("mov.b32 %0, %1;" : "=r"(r1797) : "f"(f695));
  // PTX:1029 mov.b32 %r1796, %f694
  asm("mov.b32 %0, %1;" : "=r"(r1796) : "f"(f694));
  // PTX:1030 mov.b32 %r1795, %f693
  asm("mov.b32 %0, %1;" : "=r"(r1795) : "f"(f693));
  // PTX:1032 $L__BB4_85:
L_BB4_85:;
  // PTX:1033 mov.u32 %r1838, %r1841
  asm("mov.u32 %0, %1;" : "=r"(r1838) : "r"(r1841));
  // PTX:1034 mov.u32 %r1839, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1839) : "r"(r1842));
  // PTX:1035 mov.u32 %r1840, %r1843
  asm("mov.u32 %0, %1;" : "=r"(r1840) : "r"(r1843));
  // PTX:1036 @%p82 bra $L__BB4_87
  if (p82) { goto L_BB4_87; }
  // PTX:1038 mul.wide.s32 %rd229, %r1790, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd229) : "r"(r1790));
  // PTX:1039 add.s64 %rd230, %rd37, %rd229
  asm("add.s64 %0, %1, %2;" : "=l"(rd230) : "l"(rd37), "l"(rd229));
  // PTX:1040 mov.b32 %f696, %r1841
  asm("mov.b32 %0, %1;" : "=f"(f696) : "r"(r1841));
  // PTX:1041 ld.global.f32 %f697, [%rd230]
  f697 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd230) + (0)))));
  // PTX:1042 sub.f32 %f698, %f696, %f697
  asm("sub.f32 %0, %1, %2;" : "=f"(f698) : "f"(f696), "f"(f697));
  // PTX:1043 mov.b32 %f699, %r1842
  asm("mov.b32 %0, %1;" : "=f"(f699) : "r"(r1842));
  // PTX:1044 ld.global.f32 %f700, [%rd230+4]
  f700 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd230) + (4)))));
  // PTX:1045 sub.f32 %f701, %f699, %f700
  asm("sub.f32 %0, %1, %2;" : "=f"(f701) : "f"(f699), "f"(f700));
  // PTX:1046 mov.b32 %f702, %r1843
  asm("mov.b32 %0, %1;" : "=f"(f702) : "r"(r1843));
  // PTX:1047 ld.global.f32 %f703, [%rd230+8]
  f703 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd230) + (8)))));
  // PTX:1048 sub.f32 %f704, %f702, %f703
  asm("sub.f32 %0, %1, %2;" : "=f"(f704) : "f"(f702), "f"(f703));
  // PTX:1049 mul.wide.s32 %rd231, %r1794, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd231) : "r"(r1794));
  // PTX:1050 add.s64 %rd232, %rd23, %rd231
  asm("add.s64 %0, %1, %2;" : "=l"(rd232) : "l"(rd23), "l"(rd231));
  // PTX:1051 mul.wide.s32 %rd233, %r1793, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd233) : "r"(r1793));
  // PTX:1052 add.s64 %rd234, %rd23, %rd233
  asm("add.s64 %0, %1, %2;" : "=l"(rd234) : "l"(rd23), "l"(rd233));
  // PTX:1053 ld.global.f32 %f705, [%rd234]
  f705 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd234) + (0)))));
  // PTX:1054 ld.global.f32 %f706, [%rd234+4]
  f706 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd234) + (4)))));
  // PTX:1055 ld.global.f32 %f707, [%rd234+8]
  f707 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd234) + (8)))));
  // PTX:1056 ld.global.f32 %f708, [%rd232]
  f708 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd232) + (0)))));
  // PTX:1057 fma.rn.f32 %f709, %f698, %f705, %f708
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f709) : "f"(f698), "f"(f705), "f"(f708));
  // PTX:1058 ld.global.f32 %f710, [%rd232+4]
  f710 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd232) + (4)))));
  // PTX:1059 fma.rn.f32 %f711, %f698, %f706, %f710
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f711) : "f"(f698), "f"(f706), "f"(f710));
  // PTX:1060 ld.global.f32 %f712, [%rd232+8]
  f712 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd232) + (8)))));
  // PTX:1061 fma.rn.f32 %f713, %f698, %f707, %f712
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f713) : "f"(f698), "f"(f707), "f"(f712));
  // PTX:1062 mul.wide.s32 %rd235, %r1792, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd235) : "r"(r1792));
  // PTX:1063 add.s64 %rd236, %rd23, %rd235
  asm("add.s64 %0, %1, %2;" : "=l"(rd236) : "l"(rd23), "l"(rd235));
  // PTX:1064 ld.global.f32 %f714, [%rd236]
  f714 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd236) + (0)))));
  // PTX:1065 ld.global.f32 %f715, [%rd236+4]
  f715 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd236) + (4)))));
  // PTX:1066 ld.global.f32 %f716, [%rd236+8]
  f716 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd236) + (8)))));
  // PTX:1067 fma.rn.f32 %f717, %f701, %f714, %f709
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f717) : "f"(f701), "f"(f714), "f"(f709));
  // PTX:1068 fma.rn.f32 %f718, %f701, %f715, %f711
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f718) : "f"(f701), "f"(f715), "f"(f711));
  // PTX:1069 fma.rn.f32 %f719, %f701, %f716, %f713
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f719) : "f"(f701), "f"(f716), "f"(f713));
  // PTX:1070 mul.wide.s32 %rd237, %r1791, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd237) : "r"(r1791));
  // PTX:1071 add.s64 %rd238, %rd23, %rd237
  asm("add.s64 %0, %1, %2;" : "=l"(rd238) : "l"(rd23), "l"(rd237));
  // PTX:1072 ld.global.f32 %f720, [%rd238]
  f720 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd238) + (0)))));
  // PTX:1073 ld.global.f32 %f721, [%rd238+4]
  f721 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd238) + (4)))));
  // PTX:1074 ld.global.f32 %f722, [%rd238+8]
  f722 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd238) + (8)))));
  // PTX:1075 fma.rn.f32 %f723, %f704, %f720, %f717
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f723) : "f"(f704), "f"(f720), "f"(f717));
  // PTX:1076 fma.rn.f32 %f724, %f704, %f721, %f718
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f724) : "f"(f704), "f"(f721), "f"(f718));
  // PTX:1077 fma.rn.f32 %f725, %f704, %f722, %f719
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f725) : "f"(f704), "f"(f722), "f"(f719));
  // PTX:1078 mov.b32 %r1838, %f723
  asm("mov.b32 %0, %1;" : "=r"(r1838) : "f"(f723));
  // PTX:1079 mov.b32 %r1839, %f724
  asm("mov.b32 %0, %1;" : "=r"(r1839) : "f"(f724));
  // PTX:1080 mov.b32 %r1840, %f725
  asm("mov.b32 %0, %1;" : "=r"(r1840) : "f"(f725));
  // PTX:1082 $L__BB4_87:
L_BB4_87:;
  // PTX:1083 setp.eq.s32 %p90, %r95, 3
  p90 = (((int)(r95)) == ((int)(3)));
  // PTX:1084 @%p90 bra $L__BB4_89
  if (p90) { goto L_BB4_89; }
  // PTX:1085 bra.uni $L__BB4_88
  goto L_BB4_88;
  // PTX:1087 $L__BB4_89:
L_BB4_89:;
  // PTX:1088 mul.lo.s64 %rd239, %rd82, 28
  asm("mul.lo.s64 %0, %1, 28;" : "=l"(rd239) : "l"(rd82));
  // PTX:1089 add.s64 %rd240, %rd38, %rd239
  asm("add.s64 %0, %1, %2;" : "=l"(rd240) : "l"(rd38), "l"(rd239));
  // PTX:1090 ld.global.u32 %r1844, [%rd240]
  r1844 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd240) + (0)))));
  // PTX:1091 ld.global.u32 %r1845, [%rd240+4]
  r1845 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd240) + (4)))));
  // PTX:1092 ld.global.u32 %r1846, [%rd240+8]
  r1846 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd240) + (8)))));
  // PTX:1093 mov.u32 %r1801, %r1846
  asm("mov.u32 %0, %1;" : "=r"(r1801) : "r"(r1846));
  // PTX:1094 mov.u32 %r1802, %r1845
  asm("mov.u32 %0, %1;" : "=r"(r1802) : "r"(r1845));
  // PTX:1095 mov.u32 %r1803, %r1844
  asm("mov.u32 %0, %1;" : "=r"(r1803) : "r"(r1844));
  // PTX:1096 @%p82 bra $L__BB4_91
  if (p82) { goto L_BB4_91; }
  // PTX:1098 mul.wide.s32 %rd241, %r1790, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd241) : "r"(r1790));
  // PTX:1099 add.s64 %rd242, %rd37, %rd241
  asm("add.s64 %0, %1, %2;" : "=l"(rd242) : "l"(rd37), "l"(rd241));
  // PTX:1100 mov.b32 %f726, %r1844
  asm("mov.b32 %0, %1;" : "=f"(f726) : "r"(r1844));
  // PTX:1101 ld.global.f32 %f727, [%rd242]
  f727 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd242) + (0)))));
  // PTX:1102 sub.f32 %f728, %f726, %f727
  asm("sub.f32 %0, %1, %2;" : "=f"(f728) : "f"(f726), "f"(f727));
  // PTX:1103 mov.b32 %f729, %r1845
  asm("mov.b32 %0, %1;" : "=f"(f729) : "r"(r1845));
  // PTX:1104 ld.global.f32 %f730, [%rd242+4]
  f730 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd242) + (4)))));
  // PTX:1105 sub.f32 %f731, %f729, %f730
  asm("sub.f32 %0, %1, %2;" : "=f"(f731) : "f"(f729), "f"(f730));
  // PTX:1106 mov.b32 %f732, %r1846
  asm("mov.b32 %0, %1;" : "=f"(f732) : "r"(r1846));
  // PTX:1107 ld.global.f32 %f733, [%rd242+8]
  f733 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd242) + (8)))));
  // PTX:1108 sub.f32 %f734, %f732, %f733
  asm("sub.f32 %0, %1, %2;" : "=f"(f734) : "f"(f732), "f"(f733));
  // PTX:1109 mul.wide.s32 %rd243, %r1794, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd243) : "r"(r1794));
  // PTX:1110 add.s64 %rd244, %rd23, %rd243
  asm("add.s64 %0, %1, %2;" : "=l"(rd244) : "l"(rd23), "l"(rd243));
  // PTX:1111 mul.wide.s32 %rd245, %r1793, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd245) : "r"(r1793));
  // PTX:1112 add.s64 %rd246, %rd23, %rd245
  asm("add.s64 %0, %1, %2;" : "=l"(rd246) : "l"(rd23), "l"(rd245));
  // PTX:1113 ld.global.f32 %f735, [%rd246]
  f735 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd246) + (0)))));
  // PTX:1114 ld.global.f32 %f736, [%rd246+4]
  f736 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd246) + (4)))));
  // PTX:1115 ld.global.f32 %f737, [%rd246+8]
  f737 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd246) + (8)))));
  // PTX:1116 ld.global.f32 %f738, [%rd244]
  f738 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd244) + (0)))));
  // PTX:1117 fma.rn.f32 %f739, %f728, %f735, %f738
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f739) : "f"(f728), "f"(f735), "f"(f738));
  // PTX:1118 ld.global.f32 %f740, [%rd244+4]
  f740 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd244) + (4)))));
  // PTX:1119 fma.rn.f32 %f741, %f728, %f736, %f740
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f741) : "f"(f728), "f"(f736), "f"(f740));
  // PTX:1120 ld.global.f32 %f742, [%rd244+8]
  f742 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd244) + (8)))));
  // PTX:1121 fma.rn.f32 %f743, %f728, %f737, %f742
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f743) : "f"(f728), "f"(f737), "f"(f742));
  // PTX:1122 mul.wide.s32 %rd247, %r1792, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd247) : "r"(r1792));
  // PTX:1123 add.s64 %rd248, %rd23, %rd247
  asm("add.s64 %0, %1, %2;" : "=l"(rd248) : "l"(rd23), "l"(rd247));
  // PTX:1124 ld.global.f32 %f744, [%rd248]
  f744 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd248) + (0)))));
  // PTX:1125 ld.global.f32 %f745, [%rd248+4]
  f745 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd248) + (4)))));
  // PTX:1126 ld.global.f32 %f746, [%rd248+8]
  f746 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd248) + (8)))));
  // PTX:1127 fma.rn.f32 %f747, %f731, %f744, %f739
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f747) : "f"(f731), "f"(f744), "f"(f739));
  // PTX:1128 fma.rn.f32 %f748, %f731, %f745, %f741
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f748) : "f"(f731), "f"(f745), "f"(f741));
  // PTX:1129 fma.rn.f32 %f749, %f731, %f746, %f743
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f749) : "f"(f731), "f"(f746), "f"(f743));
  // PTX:1130 mul.wide.s32 %rd249, %r1791, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd249) : "r"(r1791));
  // PTX:1131 add.s64 %rd250, %rd23, %rd249
  asm("add.s64 %0, %1, %2;" : "=l"(rd250) : "l"(rd23), "l"(rd249));
  // PTX:1132 ld.global.f32 %f750, [%rd250]
  f750 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd250) + (0)))));
  // PTX:1133 ld.global.f32 %f751, [%rd250+4]
  f751 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd250) + (4)))));
  // PTX:1134 ld.global.f32 %f752, [%rd250+8]
  f752 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd250) + (8)))));
  // PTX:1135 fma.rn.f32 %f753, %f734, %f750, %f747
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f753) : "f"(f734), "f"(f750), "f"(f747));
  // PTX:1136 fma.rn.f32 %f754, %f734, %f751, %f748
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f754) : "f"(f734), "f"(f751), "f"(f748));
  // PTX:1137 fma.rn.f32 %f755, %f734, %f752, %f749
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f755) : "f"(f734), "f"(f752), "f"(f749));
  // PTX:1138 mov.b32 %r1803, %f753
  asm("mov.b32 %0, %1;" : "=r"(r1803) : "f"(f753));
  // PTX:1139 mov.b32 %r1802, %f754
  asm("mov.b32 %0, %1;" : "=r"(r1802) : "f"(f754));
  // PTX:1140 mov.b32 %r1801, %f755
  asm("mov.b32 %0, %1;" : "=r"(r1801) : "f"(f755));
  // PTX:1142 $L__BB4_91:
L_BB4_91:;
  // PTX:1143 mov.b32 %f102, %r1803
  asm("mov.b32 %0, %1;" : "=f"(f102) : "r"(r1803));
  // PTX:1144 sub.f32 %f103, %f1574, %f102
  asm("sub.f32 %0, %1, %2;" : "=f"(f103) : "f"(f1574), "f"(f102));
  // PTX:1145 mov.b32 %f104, %r1802
  asm("mov.b32 %0, %1;" : "=f"(f104) : "r"(r1802));
  // PTX:1146 sub.f32 %f105, %f1575, %f104
  asm("sub.f32 %0, %1, %2;" : "=f"(f105) : "f"(f1575), "f"(f104));
  // PTX:1147 mov.b32 %f106, %r1801
  asm("mov.b32 %0, %1;" : "=f"(f106) : "r"(r1801));
  // PTX:1148 sub.f32 %f107, %f1576, %f106
  asm("sub.f32 %0, %1, %2;" : "=f"(f107) : "f"(f1576), "f"(f106));
  // PTX:1149 mul.f32 %f756, %f103, %f103
  asm("mul.f32 %0, %1, %2;" : "=f"(f756) : "f"(f103), "f"(f103));
  // PTX:1150 fma.rn.f32 %f757, %f105, %f105, %f756
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f757) : "f"(f105), "f"(f105), "f"(f756));
  // PTX:1151 fma.rn.f32 %f758, %f107, %f107, %f757
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f758) : "f"(f107), "f"(f107), "f"(f757));
  // PTX:1152 sqrt.rn.f32 %f108, %f758
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f108) : "f"(f758));
  // PTX:1153 setp.leu.f32 %p92, %f108, 0f00000000
  p92 = ((isnan(((float)(f108))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f108)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1154 mov.u32 %r1804, 0
  asm("mov.u32 %0, 0;" : "=r"(r1804) : );
  // PTX:1155 mov.u32 %r1805, %r1804
  asm("mov.u32 %0, %1;" : "=r"(r1805) : "r"(r1804));
  // PTX:1156 mov.u32 %r1806, %r1804
  asm("mov.u32 %0, %1;" : "=r"(r1806) : "r"(r1804));
  // PTX:1157 @%p92 bra $L__BB4_93
  if (p92) { goto L_BB4_93; }
  // PTX:1159 div.rn.f32 %f759, %f103, %f108
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f759) : "f"(f103), "f"(f108));
  // PTX:1160 div.rn.f32 %f760, %f105, %f108
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f760) : "f"(f105), "f"(f108));
  // PTX:1161 div.rn.f32 %f761, %f107, %f108
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f761) : "f"(f107), "f"(f108));
  // PTX:1162 mov.b32 %r1806, %f761
  asm("mov.b32 %0, %1;" : "=r"(r1806) : "f"(f761));
  // PTX:1163 mov.b32 %r1805, %f760
  asm("mov.b32 %0, %1;" : "=r"(r1805) : "f"(f760));
  // PTX:1164 mov.b32 %r1804, %f759
  asm("mov.b32 %0, %1;" : "=r"(r1804) : "f"(f759));
  // PTX:1166 $L__BB4_93:
L_BB4_93:;
  // PTX:1167 mov.b32 %f762, %r1804
  asm("mov.b32 %0, %1;" : "=f"(f762) : "r"(r1804));
  // PTX:1168 mov.b32 %f763, %r1805
  asm("mov.b32 %0, %1;" : "=f"(f763) : "r"(r1805));
  // PTX:1169 mul.f32 %f764, %f763, %f763
  asm("mul.f32 %0, %1, %2;" : "=f"(f764) : "f"(f763), "f"(f763));
  // PTX:1170 mov.b32 %f765, %r1806
  asm("mov.b32 %0, %1;" : "=f"(f765) : "r"(r1806));
  // PTX:1171 fma.rn.f32 %f766, %f762, %f762, %f764
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f766) : "f"(f762), "f"(f762), "f"(f764));
  // PTX:1172 fma.rn.f32 %f767, %f765, %f765, %f766
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f767) : "f"(f765), "f"(f765), "f"(f766));
  // PTX:1173 setp.ltu.f32 %p93, %f767, 0f3F000000
  p93 = ((isnan(((float)(f767))) || isnan(((float)(as_f32(0x3F000000u))))) || (((float)(f767)) < ((float)(as_f32(0x3F000000u)))));
  // PTX:1174 selp.b32 %r134, %r1797, %r1806, %p93
  r134 = p93 ? r1797 : r1806;
  // PTX:1175 selp.b32 %r135, %r1796, %r1805, %p93
  r135 = p93 ? r1796 : r1805;
  // PTX:1176 selp.b32 %r1136, %r1795, %r1804, %p93
  r1136 = p93 ? r1795 : r1804;
  // PTX:1177 mul.lo.s64 %rd251, %rd82, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd251) : "l"(rd82));
  // PTX:1178 add.s64 %rd252, %rd40, %rd251
  asm("add.s64 %0, %1, %2;" : "=l"(rd252) : "l"(rd40), "l"(rd251));
  // PTX:1179 ld.global.f32 %f109, [%rd252]
  f109 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd252) + (0)))));
  // PTX:1180 mov.b32 %f1608, %r1136
  asm("mov.b32 %0, %1;" : "=f"(f1608) : "r"(r1136));
  // PTX:1181 @%p82 bra $L__BB4_115
  if (p82) { goto L_BB4_115; }
  // PTX:1183 mov.b32 %f1607, %r135
  asm("mov.b32 %0, %1;" : "=f"(f1607) : "r"(r135));
  // PTX:1184 mul.f32 %f1605, %f109, %f1608
  asm("mul.f32 %0, %1, %2;" : "=f"(f1605) : "f"(f109), "f"(f1608));
  // PTX:1185 mul.f32 %f1603, %f109, %f1607
  asm("mul.f32 %0, %1, %2;" : "=f"(f1603) : "f"(f109), "f"(f1607));
  // PTX:1186 mov.b32 %f1606, %r134
  asm("mov.b32 %0, %1;" : "=f"(f1606) : "r"(r134));
  // PTX:1187 mul.f32 %f1601, %f109, %f1606
  asm("mul.f32 %0, %1, %2;" : "=f"(f1601) : "f"(f109), "f"(f1606));
  // PTX:1188 mul.wide.s32 %rd253, %r1793, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd253) : "r"(r1793));
  // PTX:1189 add.s64 %rd254, %rd23, %rd253
  asm("add.s64 %0, %1, %2;" : "=l"(rd254) : "l"(rd23), "l"(rd253));
  // PTX:1190 mul.wide.s32 %rd255, %r1792, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd255) : "r"(r1792));
  // PTX:1191 add.s64 %rd256, %rd23, %rd255
  asm("add.s64 %0, %1, %2;" : "=l"(rd256) : "l"(rd23), "l"(rd255));
  // PTX:1192 mul.wide.s32 %rd257, %r1791, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd257) : "r"(r1791));
  // PTX:1193 add.s64 %rd258, %rd23, %rd257
  asm("add.s64 %0, %1, %2;" : "=l"(rd258) : "l"(rd23), "l"(rd257));
  // PTX:1194 ld.global.f32 %f116, [%rd258+8]
  f116 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd258) + (8)))));
  // PTX:1195 ld.global.f32 %f117, [%rd256+4]
  f117 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (4)))));
  // PTX:1196 mul.f32 %f768, %f117, %f116
  asm("mul.f32 %0, %1, %2;" : "=f"(f768) : "f"(f117), "f"(f116));
  // PTX:1197 ld.global.f32 %f118, [%rd258+4]
  f118 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd258) + (4)))));
  // PTX:1198 ld.global.f32 %f119, [%rd256+8]
  f119 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (8)))));
  // PTX:1199 mul.f32 %f769, %f119, %f118
  asm("mul.f32 %0, %1, %2;" : "=f"(f769) : "f"(f119), "f"(f118));
  // PTX:1200 sub.f32 %f120, %f768, %f769
  asm("sub.f32 %0, %1, %2;" : "=f"(f120) : "f"(f768), "f"(f769));
  // PTX:1201 ld.global.f32 %f121, [%rd258]
  f121 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd258) + (0)))));
  // PTX:1202 mul.f32 %f770, %f119, %f121
  asm("mul.f32 %0, %1, %2;" : "=f"(f770) : "f"(f119), "f"(f121));
  // PTX:1203 ld.global.f32 %f122, [%rd256]
  f122 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (0)))));
  // PTX:1204 mul.f32 %f771, %f122, %f116
  asm("mul.f32 %0, %1, %2;" : "=f"(f771) : "f"(f122), "f"(f116));
  // PTX:1205 sub.f32 %f123, %f770, %f771
  asm("sub.f32 %0, %1, %2;" : "=f"(f123) : "f"(f770), "f"(f771));
  // PTX:1206 mul.f32 %f772, %f122, %f118
  asm("mul.f32 %0, %1, %2;" : "=f"(f772) : "f"(f122), "f"(f118));
  // PTX:1207 mul.f32 %f773, %f117, %f121
  asm("mul.f32 %0, %1, %2;" : "=f"(f773) : "f"(f117), "f"(f121));
  // PTX:1208 sub.f32 %f124, %f772, %f773
  asm("sub.f32 %0, %1, %2;" : "=f"(f124) : "f"(f772), "f"(f773));
  // PTX:1209 ld.global.f32 %f125, [%rd254]
  f125 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd254) + (0)))));
  // PTX:1210 ld.global.f32 %f126, [%rd254+4]
  f126 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd254) + (4)))));
  // PTX:1211 mul.f32 %f774, %f126, %f123
  asm("mul.f32 %0, %1, %2;" : "=f"(f774) : "f"(f126), "f"(f123));
  // PTX:1212 ld.global.f32 %f127, [%rd254+8]
  f127 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd254) + (8)))));
  // PTX:1213 fma.rn.f32 %f775, %f125, %f120, %f774
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f775) : "f"(f125), "f"(f120), "f"(f774));
  // PTX:1214 fma.rn.f32 %f128, %f127, %f124, %f775
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f128) : "f"(f127), "f"(f124), "f"(f775));
  // PTX:1215 abs.f32 %f776, %f128
  asm("abs.f32 %0, %1;" : "=f"(f776) : "f"(f128));
  // PTX:1216 setp.leu.f32 %p95, %f776, 0f2EDBE6FF
  p95 = ((isnan(((float)(f776))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) || (((float)(f776)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:1217 setp.geu.f32 %p96, %f776, 0f7F800000
  p96 = ((isnan(((float)(f776))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f776)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1218 or.pred %p97, %p95, %p96
  p97 = ((p95) || (p96));
  // PTX:1219 @%p97 bra $L__BB4_96
  if (p97) { goto L_BB4_96; }
  // PTX:1220 bra.uni $L__BB4_95
  goto L_BB4_95;
  // PTX:1222 $L__BB4_96:
L_BB4_96:;
  // PTX:1223 mul.f32 %f814, %f126, %f126
  asm("mul.f32 %0, %1, %2;" : "=f"(f814) : "f"(f126), "f"(f126));
  // PTX:1224 fma.rn.f32 %f815, %f125, %f125, %f814
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f815) : "f"(f125), "f"(f125), "f"(f814));
  // PTX:1225 fma.rn.f32 %f816, %f127, %f127, %f815
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f816) : "f"(f127), "f"(f127), "f"(f815));
  // PTX:1226 mul.f32 %f817, %f117, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f817) : "f"(f117), "f"(f117));
  // PTX:1227 fma.rn.f32 %f818, %f122, %f122, %f817
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f818) : "f"(f122), "f"(f122), "f"(f817));
  // PTX:1228 fma.rn.f32 %f819, %f119, %f119, %f818
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f819) : "f"(f119), "f"(f119), "f"(f818));
  // PTX:1229 add.f32 %f820, %f816, %f819
  asm("add.f32 %0, %1, %2;" : "=f"(f820) : "f"(f816), "f"(f819));
  // PTX:1230 mul.f32 %f821, %f118, %f118
  asm("mul.f32 %0, %1, %2;" : "=f"(f821) : "f"(f118), "f"(f118));
  // PTX:1231 fma.rn.f32 %f822, %f121, %f121, %f821
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f822) : "f"(f121), "f"(f121), "f"(f821));
  // PTX:1232 fma.rn.f32 %f823, %f116, %f116, %f822
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f823) : "f"(f116), "f"(f116), "f"(f822));
  // PTX:1233 add.f32 %f824, %f820, %f823
  asm("add.f32 %0, %1, %2;" : "=f"(f824) : "f"(f820), "f"(f823));
  // PTX:1234 div.rn.f32 %f825, %f824, 0f40400000
  asm("div.rn.f32 %0, %1, 0f40400000;" : "=f"(f825) : "f"(f824));
  // PTX:1235 sqrt.rn.f32 %f129, %f825
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f129) : "f"(f825));
  // PTX:1236 setp.leu.f32 %p98, %f129, 0f322BCC77
  p98 = ((isnan(((float)(f129))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f129)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1237 mov.u32 %r1823, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r1823) : );
  // PTX:1238 mov.u32 %r1824, 0
  asm("mov.u32 %0, 0;" : "=r"(r1824) : );
  // PTX:1239 mov.u32 %r1825, %r1824
  asm("mov.u32 %0, %1;" : "=r"(r1825) : "r"(r1824));
  // PTX:1240 mov.u32 %r1826, %r1824
  asm("mov.u32 %0, %1;" : "=r"(r1826) : "r"(r1824));
  // PTX:1241 mov.u32 %r1827, %r1823
  asm("mov.u32 %0, %1;" : "=r"(r1827) : "r"(r1823));
  // PTX:1242 mov.u32 %r1828, %r1824
  asm("mov.u32 %0, %1;" : "=r"(r1828) : "r"(r1824));
  // PTX:1243 mov.u32 %r1829, %r1824
  asm("mov.u32 %0, %1;" : "=r"(r1829) : "r"(r1824));
  // PTX:1244 mov.u32 %r1830, %r1824
  asm("mov.u32 %0, %1;" : "=r"(r1830) : "r"(r1824));
  // PTX:1245 mov.u32 %r1831, %r1823
  asm("mov.u32 %0, %1;" : "=r"(r1831) : "r"(r1823));
  // PTX:1246 @%p98 bra $L__BB4_113
  if (p98) { goto L_BB4_113; }
  // PTX:1248 abs.f32 %f826, %f129
  asm("abs.f32 %0, %1;" : "=f"(f826) : "f"(f129));
  // PTX:1249 setp.geu.f32 %p99, %f826, 0f7F800000
  p99 = ((isnan(((float)(f826))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f826)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1250 @%p99 bra $L__BB4_113
  if (p99) { goto L_BB4_113; }
  // PTX:1252 rcp.rn.f32 %f827, %f129
  asm("rcp.rn.f32 %0, %1;" : "=f"(f827) : "f"(f129));
  // PTX:1253 mul.f32 %f1589, %f125, %f827
  asm("mul.f32 %0, %1, %2;" : "=f"(f1589) : "f"(f125), "f"(f827));
  // PTX:1254 mul.f32 %f1590, %f126, %f827
  asm("mul.f32 %0, %1, %2;" : "=f"(f1590) : "f"(f126), "f"(f827));
  // PTX:1255 mul.f32 %f1591, %f127, %f827
  asm("mul.f32 %0, %1, %2;" : "=f"(f1591) : "f"(f127), "f"(f827));
  // PTX:1256 mul.f32 %f1592, %f122, %f827
  asm("mul.f32 %0, %1, %2;" : "=f"(f1592) : "f"(f122), "f"(f827));
  // PTX:1257 mul.f32 %f1593, %f117, %f827
  asm("mul.f32 %0, %1, %2;" : "=f"(f1593) : "f"(f117), "f"(f827));
  // PTX:1258 mul.f32 %f1594, %f119, %f827
  asm("mul.f32 %0, %1, %2;" : "=f"(f1594) : "f"(f119), "f"(f827));
  // PTX:1259 mul.f32 %f1595, %f121, %f827
  asm("mul.f32 %0, %1, %2;" : "=f"(f1595) : "f"(f121), "f"(f827));
  // PTX:1260 mul.f32 %f1596, %f118, %f827
  asm("mul.f32 %0, %1, %2;" : "=f"(f1596) : "f"(f118), "f"(f827));
  // PTX:1261 mul.f32 %f1597, %f116, %f827
  asm("mul.f32 %0, %1, %2;" : "=f"(f1597) : "f"(f116), "f"(f827));
  // PTX:1262 mov.u32 %r1807, 0
  asm("mov.u32 %0, 0;" : "=r"(r1807) : );
  // PTX:1264 $L__BB4_99:
L_BB4_99:;
  // PTX:1265 mul.f32 %f828, %f1594, %f1596
  asm("mul.f32 %0, %1, %2;" : "=f"(f828) : "f"(f1594), "f"(f1596));
  // PTX:1266 mul.f32 %f829, %f1593, %f1597
  asm("mul.f32 %0, %1, %2;" : "=f"(f829) : "f"(f1593), "f"(f1597));
  // PTX:1267 sub.f32 %f148, %f829, %f828
  asm("sub.f32 %0, %1, %2;" : "=f"(f148) : "f"(f829), "f"(f828));
  // PTX:1268 mul.f32 %f830, %f1592, %f1597
  asm("mul.f32 %0, %1, %2;" : "=f"(f830) : "f"(f1592), "f"(f1597));
  // PTX:1269 mul.f32 %f831, %f1594, %f1595
  asm("mul.f32 %0, %1, %2;" : "=f"(f831) : "f"(f1594), "f"(f1595));
  // PTX:1270 sub.f32 %f149, %f831, %f830
  asm("sub.f32 %0, %1, %2;" : "=f"(f149) : "f"(f831), "f"(f830));
  // PTX:1271 mul.f32 %f832, %f1593, %f1595
  asm("mul.f32 %0, %1, %2;" : "=f"(f832) : "f"(f1593), "f"(f1595));
  // PTX:1272 mul.f32 %f833, %f1592, %f1596
  asm("mul.f32 %0, %1, %2;" : "=f"(f833) : "f"(f1592), "f"(f1596));
  // PTX:1273 sub.f32 %f150, %f833, %f832
  asm("sub.f32 %0, %1, %2;" : "=f"(f150) : "f"(f833), "f"(f832));
  // PTX:1274 mul.f32 %f834, %f1590, %f149
  asm("mul.f32 %0, %1, %2;" : "=f"(f834) : "f"(f1590), "f"(f149));
  // PTX:1275 fma.rn.f32 %f835, %f1589, %f148, %f834
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f835) : "f"(f1589), "f"(f148), "f"(f834));
  // PTX:1276 fma.rn.f32 %f151, %f1591, %f150, %f835
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f151) : "f"(f1591), "f"(f150), "f"(f835));
  // PTX:1277 abs.f32 %f836, %f151
  asm("abs.f32 %0, %1;" : "=f"(f836) : "f"(f151));
  // PTX:1278 setp.le.f32 %p100, %f836, 0f2EDBE6FF
  p100 = (!(isnan(((float)(f836))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f836)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:1279 setp.geu.f32 %p101, %f836, 0f7F800000
  p101 = ((isnan(((float)(f836))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f836)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1280 or.pred %p102, %p100, %p101
  p102 = ((p100) || (p101));
  // PTX:1281 @%p102 bra $L__BB4_102
  if (p102) { goto L_BB4_102; }
  // PTX:1283 rcp.rn.f32 %f837, %f151
  asm("rcp.rn.f32 %0, %1;" : "=f"(f837) : "f"(f151));
  // PTX:1284 mul.f32 %f838, %f1590, %f1597
  asm("mul.f32 %0, %1, %2;" : "=f"(f838) : "f"(f1590), "f"(f1597));
  // PTX:1285 mul.f32 %f839, %f1591, %f1596
  asm("mul.f32 %0, %1, %2;" : "=f"(f839) : "f"(f1591), "f"(f1596));
  // PTX:1286 sub.f32 %f840, %f839, %f838
  asm("sub.f32 %0, %1, %2;" : "=f"(f840) : "f"(f839), "f"(f838));
  // PTX:1287 mul.f32 %f841, %f1591, %f1595
  asm("mul.f32 %0, %1, %2;" : "=f"(f841) : "f"(f1591), "f"(f1595));
  // PTX:1288 mul.f32 %f842, %f1589, %f1597
  asm("mul.f32 %0, %1, %2;" : "=f"(f842) : "f"(f1589), "f"(f1597));
  // PTX:1289 sub.f32 %f843, %f842, %f841
  asm("sub.f32 %0, %1, %2;" : "=f"(f843) : "f"(f842), "f"(f841));
  // PTX:1290 mul.f32 %f844, %f1589, %f1596
  asm("mul.f32 %0, %1, %2;" : "=f"(f844) : "f"(f1589), "f"(f1596));
  // PTX:1291 mul.f32 %f845, %f1590, %f1595
  asm("mul.f32 %0, %1, %2;" : "=f"(f845) : "f"(f1590), "f"(f1595));
  // PTX:1292 sub.f32 %f846, %f845, %f844
  asm("sub.f32 %0, %1, %2;" : "=f"(f846) : "f"(f845), "f"(f844));
  // PTX:1293 mul.f32 %f847, %f1591, %f1593
  asm("mul.f32 %0, %1, %2;" : "=f"(f847) : "f"(f1591), "f"(f1593));
  // PTX:1294 mul.f32 %f848, %f1590, %f1594
  asm("mul.f32 %0, %1, %2;" : "=f"(f848) : "f"(f1590), "f"(f1594));
  // PTX:1295 sub.f32 %f849, %f848, %f847
  asm("sub.f32 %0, %1, %2;" : "=f"(f849) : "f"(f848), "f"(f847));
  // PTX:1296 mul.f32 %f850, %f1589, %f1594
  asm("mul.f32 %0, %1, %2;" : "=f"(f850) : "f"(f1589), "f"(f1594));
  // PTX:1297 mul.f32 %f851, %f1591, %f1592
  asm("mul.f32 %0, %1, %2;" : "=f"(f851) : "f"(f1591), "f"(f1592));
  // PTX:1298 sub.f32 %f852, %f851, %f850
  asm("sub.f32 %0, %1, %2;" : "=f"(f852) : "f"(f851), "f"(f850));
  // PTX:1299 mul.f32 %f853, %f1590, %f1592
  asm("mul.f32 %0, %1, %2;" : "=f"(f853) : "f"(f1590), "f"(f1592));
  // PTX:1300 mul.f32 %f854, %f1589, %f1593
  asm("mul.f32 %0, %1, %2;" : "=f"(f854) : "f"(f1589), "f"(f1593));
  // PTX:1301 sub.f32 %f855, %f854, %f853
  asm("sub.f32 %0, %1, %2;" : "=f"(f855) : "f"(f854), "f"(f853));
  // PTX:1302 fma.rn.f32 %f856, %f148, %f837, %f1589
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f856) : "f"(f148), "f"(f837), "f"(f1589));
  // PTX:1303 fma.rn.f32 %f857, %f149, %f837, %f1590
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f857) : "f"(f149), "f"(f837), "f"(f1590));
  // PTX:1304 fma.rn.f32 %f858, %f150, %f837, %f1591
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f858) : "f"(f150), "f"(f837), "f"(f1591));
  // PTX:1305 fma.rn.f32 %f859, %f840, %f837, %f1592
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f859) : "f"(f840), "f"(f837), "f"(f1592));
  // PTX:1306 fma.rn.f32 %f860, %f843, %f837, %f1593
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f860) : "f"(f843), "f"(f837), "f"(f1593));
  // PTX:1307 fma.rn.f32 %f861, %f846, %f837, %f1594
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f861) : "f"(f846), "f"(f837), "f"(f1594));
  // PTX:1308 fma.rn.f32 %f862, %f849, %f837, %f1595
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f862) : "f"(f849), "f"(f837), "f"(f1595));
  // PTX:1309 fma.rn.f32 %f863, %f852, %f837, %f1596
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f863) : "f"(f852), "f"(f837), "f"(f1596));
  // PTX:1310 fma.rn.f32 %f864, %f855, %f837, %f1597
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f864) : "f"(f855), "f"(f837), "f"(f1597));
  // PTX:1311 mul.f32 %f1589, %f856, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1589) : "f"(f856));
  // PTX:1312 mul.f32 %f1590, %f857, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1590) : "f"(f857));
  // PTX:1313 mul.f32 %f1591, %f858, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1591) : "f"(f858));
  // PTX:1314 mul.f32 %f1592, %f859, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1592) : "f"(f859));
  // PTX:1315 mul.f32 %f1593, %f860, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1593) : "f"(f860));
  // PTX:1316 mul.f32 %f1594, %f861, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1594) : "f"(f861));
  // PTX:1317 mul.f32 %f1595, %f862, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1595) : "f"(f862));
  // PTX:1318 mul.f32 %f1596, %f863, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1596) : "f"(f863));
  // PTX:1319 mul.f32 %f1597, %f864, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1597) : "f"(f864));
  // PTX:1320 mul.f32 %f865, %f1593, %f1597
  asm("mul.f32 %0, %1, %2;" : "=f"(f865) : "f"(f1593), "f"(f1597));
  // PTX:1321 mul.f32 %f866, %f1594, %f1596
  asm("mul.f32 %0, %1, %2;" : "=f"(f866) : "f"(f1594), "f"(f1596));
  // PTX:1322 sub.f32 %f161, %f865, %f866
  asm("sub.f32 %0, %1, %2;" : "=f"(f161) : "f"(f865), "f"(f866));
  // PTX:1323 mul.f32 %f867, %f1594, %f1595
  asm("mul.f32 %0, %1, %2;" : "=f"(f867) : "f"(f1594), "f"(f1595));
  // PTX:1324 mul.f32 %f868, %f1592, %f1597
  asm("mul.f32 %0, %1, %2;" : "=f"(f868) : "f"(f1592), "f"(f1597));
  // PTX:1325 sub.f32 %f162, %f867, %f868
  asm("sub.f32 %0, %1, %2;" : "=f"(f162) : "f"(f867), "f"(f868));
  // PTX:1326 mul.f32 %f869, %f1592, %f1596
  asm("mul.f32 %0, %1, %2;" : "=f"(f869) : "f"(f1592), "f"(f1596));
  // PTX:1327 mul.f32 %f870, %f1593, %f1595
  asm("mul.f32 %0, %1, %2;" : "=f"(f870) : "f"(f1593), "f"(f1595));
  // PTX:1328 sub.f32 %f163, %f869, %f870
  asm("sub.f32 %0, %1, %2;" : "=f"(f163) : "f"(f869), "f"(f870));
  // PTX:1329 mul.f32 %f871, %f1590, %f162
  asm("mul.f32 %0, %1, %2;" : "=f"(f871) : "f"(f1590), "f"(f162));
  // PTX:1330 fma.rn.f32 %f872, %f1589, %f161, %f871
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f872) : "f"(f1589), "f"(f161), "f"(f871));
  // PTX:1331 fma.rn.f32 %f164, %f1591, %f163, %f872
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f164) : "f"(f1591), "f"(f163), "f"(f872));
  // PTX:1332 abs.f32 %f873, %f164
  asm("abs.f32 %0, %1;" : "=f"(f873) : "f"(f164));
  // PTX:1333 setp.le.f32 %p103, %f873, 0f2EDBE6FF
  p103 = (!(isnan(((float)(f873))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f873)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:1334 setp.geu.f32 %p104, %f873, 0f7F800000
  p104 = ((isnan(((float)(f873))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f873)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1335 or.pred %p105, %p103, %p104
  p105 = ((p103) || (p104));
  // PTX:1336 @%p105 bra $L__BB4_102
  if (p105) { goto L_BB4_102; }
  // PTX:1338 rcp.rn.f32 %f874, %f164
  asm("rcp.rn.f32 %0, %1;" : "=f"(f874) : "f"(f164));
  // PTX:1339 mul.f32 %f875, %f1590, %f1597
  asm("mul.f32 %0, %1, %2;" : "=f"(f875) : "f"(f1590), "f"(f1597));
  // PTX:1340 mul.f32 %f876, %f1591, %f1596
  asm("mul.f32 %0, %1, %2;" : "=f"(f876) : "f"(f1591), "f"(f1596));
  // PTX:1341 sub.f32 %f877, %f876, %f875
  asm("sub.f32 %0, %1, %2;" : "=f"(f877) : "f"(f876), "f"(f875));
  // PTX:1342 mul.f32 %f878, %f1591, %f1595
  asm("mul.f32 %0, %1, %2;" : "=f"(f878) : "f"(f1591), "f"(f1595));
  // PTX:1343 mul.f32 %f879, %f1589, %f1597
  asm("mul.f32 %0, %1, %2;" : "=f"(f879) : "f"(f1589), "f"(f1597));
  // PTX:1344 sub.f32 %f880, %f879, %f878
  asm("sub.f32 %0, %1, %2;" : "=f"(f880) : "f"(f879), "f"(f878));
  // PTX:1345 mul.f32 %f881, %f1589, %f1596
  asm("mul.f32 %0, %1, %2;" : "=f"(f881) : "f"(f1589), "f"(f1596));
  // PTX:1346 mul.f32 %f882, %f1590, %f1595
  asm("mul.f32 %0, %1, %2;" : "=f"(f882) : "f"(f1590), "f"(f1595));
  // PTX:1347 sub.f32 %f883, %f882, %f881
  asm("sub.f32 %0, %1, %2;" : "=f"(f883) : "f"(f882), "f"(f881));
  // PTX:1348 mul.f32 %f884, %f1591, %f1593
  asm("mul.f32 %0, %1, %2;" : "=f"(f884) : "f"(f1591), "f"(f1593));
  // PTX:1349 mul.f32 %f885, %f1590, %f1594
  asm("mul.f32 %0, %1, %2;" : "=f"(f885) : "f"(f1590), "f"(f1594));
  // PTX:1350 sub.f32 %f886, %f885, %f884
  asm("sub.f32 %0, %1, %2;" : "=f"(f886) : "f"(f885), "f"(f884));
  // PTX:1351 mul.f32 %f887, %f1589, %f1594
  asm("mul.f32 %0, %1, %2;" : "=f"(f887) : "f"(f1589), "f"(f1594));
  // PTX:1352 mul.f32 %f888, %f1591, %f1592
  asm("mul.f32 %0, %1, %2;" : "=f"(f888) : "f"(f1591), "f"(f1592));
  // PTX:1353 sub.f32 %f889, %f888, %f887
  asm("sub.f32 %0, %1, %2;" : "=f"(f889) : "f"(f888), "f"(f887));
  // PTX:1354 mul.f32 %f890, %f1590, %f1592
  asm("mul.f32 %0, %1, %2;" : "=f"(f890) : "f"(f1590), "f"(f1592));
  // PTX:1355 mul.f32 %f891, %f1589, %f1593
  asm("mul.f32 %0, %1, %2;" : "=f"(f891) : "f"(f1589), "f"(f1593));
  // PTX:1356 sub.f32 %f892, %f891, %f890
  asm("sub.f32 %0, %1, %2;" : "=f"(f892) : "f"(f891), "f"(f890));
  // PTX:1357 fma.rn.f32 %f893, %f161, %f874, %f1589
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f893) : "f"(f161), "f"(f874), "f"(f1589));
  // PTX:1358 fma.rn.f32 %f894, %f162, %f874, %f1590
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f894) : "f"(f162), "f"(f874), "f"(f1590));
  // PTX:1359 fma.rn.f32 %f895, %f163, %f874, %f1591
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f895) : "f"(f163), "f"(f874), "f"(f1591));
  // PTX:1360 fma.rn.f32 %f896, %f877, %f874, %f1592
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f896) : "f"(f877), "f"(f874), "f"(f1592));
  // PTX:1361 fma.rn.f32 %f897, %f880, %f874, %f1593
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f897) : "f"(f880), "f"(f874), "f"(f1593));
  // PTX:1362 fma.rn.f32 %f898, %f883, %f874, %f1594
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f898) : "f"(f883), "f"(f874), "f"(f1594));
  // PTX:1363 fma.rn.f32 %f899, %f886, %f874, %f1595
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f899) : "f"(f886), "f"(f874), "f"(f1595));
  // PTX:1364 fma.rn.f32 %f900, %f889, %f874, %f1596
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f900) : "f"(f889), "f"(f874), "f"(f1596));
  // PTX:1365 fma.rn.f32 %f901, %f892, %f874, %f1597
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f901) : "f"(f892), "f"(f874), "f"(f1597));
  // PTX:1366 mul.f32 %f1589, %f893, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1589) : "f"(f893));
  // PTX:1367 mul.f32 %f1590, %f894, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1590) : "f"(f894));
  // PTX:1368 mul.f32 %f1591, %f895, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1591) : "f"(f895));
  // PTX:1369 mul.f32 %f1592, %f896, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1592) : "f"(f896));
  // PTX:1370 mul.f32 %f1593, %f897, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1593) : "f"(f897));
  // PTX:1371 mul.f32 %f1594, %f898, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1594) : "f"(f898));
  // PTX:1372 mul.f32 %f1595, %f899, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1595) : "f"(f899));
  // PTX:1373 mul.f32 %f1596, %f900, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1596) : "f"(f900));
  // PTX:1374 mul.f32 %f1597, %f901, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1597) : "f"(f901));
  // PTX:1375 add.s32 %r1807, %r1807, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r1807) : "r"(r1807));
  // PTX:1376 setp.lt.u32 %p106, %r1807, 8
  p106 = (((unsigned)(r1807)) < ((unsigned)(8)));
  // PTX:1377 @%p106 bra $L__BB4_99
  if (p106) { goto L_BB4_99; }
  // PTX:1379 $L__BB4_102:
L_BB4_102:;
  // PTX:1380 mul.f32 %f902, %f1590, %f1590
  asm("mul.f32 %0, %1, %2;" : "=f"(f902) : "f"(f1590), "f"(f1590));
  // PTX:1381 fma.rn.f32 %f903, %f1589, %f1589, %f902
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f903) : "f"(f1589), "f"(f1589), "f"(f902));
  // PTX:1382 fma.rn.f32 %f904, %f1591, %f1591, %f903
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f904) : "f"(f1591), "f"(f1591), "f"(f903));
  // PTX:1383 sqrt.rn.f32 %f183, %f904
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f183) : "f"(f904));
  // PTX:1384 setp.leu.f32 %p107, %f183, 0f00000000
  p107 = ((isnan(((float)(f183))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f183)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1385 mov.u32 %r1820, 0
  asm("mov.u32 %0, 0;" : "=r"(r1820) : );
  // PTX:1386 mov.u32 %r1808, %r1820
  asm("mov.u32 %0, %1;" : "=r"(r1808) : "r"(r1820));
  // PTX:1387 mov.u32 %r1809, %r1820
  asm("mov.u32 %0, %1;" : "=r"(r1809) : "r"(r1820));
  // PTX:1388 mov.u32 %r1810, %r1820
  asm("mov.u32 %0, %1;" : "=r"(r1810) : "r"(r1820));
  // PTX:1389 @%p107 bra $L__BB4_104
  if (p107) { goto L_BB4_104; }
  // PTX:1391 div.rn.f32 %f905, %f1589, %f183
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f905) : "f"(f1589), "f"(f183));
  // PTX:1392 div.rn.f32 %f906, %f1590, %f183
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f906) : "f"(f1590), "f"(f183));
  // PTX:1393 div.rn.f32 %f907, %f1591, %f183
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f907) : "f"(f1591), "f"(f183));
  // PTX:1394 mov.b32 %r1810, %f907
  asm("mov.b32 %0, %1;" : "=r"(r1810) : "f"(f907));
  // PTX:1395 mov.b32 %r1809, %f906
  asm("mov.b32 %0, %1;" : "=r"(r1809) : "f"(f906));
  // PTX:1396 mov.b32 %r1808, %f905
  asm("mov.b32 %0, %1;" : "=r"(r1808) : "f"(f905));
  // PTX:1398 $L__BB4_104:
L_BB4_104:;
  // PTX:1399 mov.b32 %f184, %r1808
  asm("mov.b32 %0, %1;" : "=f"(f184) : "r"(r1808));
  // PTX:1400 mov.b32 %f185, %r1809
  asm("mov.b32 %0, %1;" : "=f"(f185) : "r"(r1809));
  // PTX:1401 mul.f32 %f908, %f1593, %f185
  asm("mul.f32 %0, %1, %2;" : "=f"(f908) : "f"(f1593), "f"(f185));
  // PTX:1402 mov.b32 %f186, %r1810
  asm("mov.b32 %0, %1;" : "=f"(f186) : "r"(r1810));
  // PTX:1403 fma.rn.f32 %f909, %f1592, %f184, %f908
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f909) : "f"(f1592), "f"(f184), "f"(f908));
  // PTX:1404 fma.rn.f32 %f910, %f1594, %f186, %f909
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f910) : "f"(f1594), "f"(f186), "f"(f909));
  // PTX:1405 mul.f32 %f911, %f910, %f184
  asm("mul.f32 %0, %1, %2;" : "=f"(f911) : "f"(f910), "f"(f184));
  // PTX:1406 mul.f32 %f912, %f910, %f185
  asm("mul.f32 %0, %1, %2;" : "=f"(f912) : "f"(f910), "f"(f185));
  // PTX:1407 mul.f32 %f913, %f910, %f186
  asm("mul.f32 %0, %1, %2;" : "=f"(f913) : "f"(f910), "f"(f186));
  // PTX:1408 sub.f32 %f187, %f1592, %f911
  asm("sub.f32 %0, %1, %2;" : "=f"(f187) : "f"(f1592), "f"(f911));
  // PTX:1409 sub.f32 %f188, %f1593, %f912
  asm("sub.f32 %0, %1, %2;" : "=f"(f188) : "f"(f1593), "f"(f912));
  // PTX:1410 sub.f32 %f189, %f1594, %f913
  asm("sub.f32 %0, %1, %2;" : "=f"(f189) : "f"(f1594), "f"(f913));
  // PTX:1411 mul.f32 %f914, %f188, %f188
  asm("mul.f32 %0, %1, %2;" : "=f"(f914) : "f"(f188), "f"(f188));
  // PTX:1412 fma.rn.f32 %f915, %f187, %f187, %f914
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f915) : "f"(f187), "f"(f187), "f"(f914));
  // PTX:1413 fma.rn.f32 %f916, %f189, %f189, %f915
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f916) : "f"(f189), "f"(f189), "f"(f915));
  // PTX:1414 sqrt.rn.f32 %f190, %f916
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f190) : "f"(f916));
  // PTX:1415 setp.leu.f32 %p108, %f190, 0f00000000
  p108 = ((isnan(((float)(f190))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f190)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1416 mov.u32 %r1821, %r1820
  asm("mov.u32 %0, %1;" : "=r"(r1821) : "r"(r1820));
  // PTX:1417 mov.u32 %r1822, %r1820
  asm("mov.u32 %0, %1;" : "=r"(r1822) : "r"(r1820));
  // PTX:1418 @%p108 bra $L__BB4_106
  if (p108) { goto L_BB4_106; }
  // PTX:1420 div.rn.f32 %f917, %f187, %f190
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f917) : "f"(f187), "f"(f190));
  // PTX:1421 div.rn.f32 %f918, %f188, %f190
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f918) : "f"(f188), "f"(f190));
  // PTX:1422 div.rn.f32 %f919, %f189, %f190
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f919) : "f"(f189), "f"(f190));
  // PTX:1423 mov.b32 %r1822, %f919
  asm("mov.b32 %0, %1;" : "=r"(r1822) : "f"(f919));
  // PTX:1424 mov.b32 %r1821, %f918
  asm("mov.b32 %0, %1;" : "=r"(r1821) : "f"(f918));
  // PTX:1425 mov.b32 %r1820, %f917
  asm("mov.b32 %0, %1;" : "=r"(r1820) : "f"(f917));
  // PTX:1427 $L__BB4_106:
L_BB4_106:;
  // PTX:1428 mov.b32 %f1547, %r1810
  asm("mov.b32 %0, %1;" : "=f"(f1547) : "r"(r1810));
  // PTX:1429 mov.b32 %f1546, %r1808
  asm("mov.b32 %0, %1;" : "=f"(f1546) : "r"(r1808));
  // PTX:1430 mov.b32 %f1545, %r1809
  asm("mov.b32 %0, %1;" : "=f"(f1545) : "r"(r1809));
  // PTX:1431 mov.u32 %r1823, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r1823) : );
  // PTX:1432 mul.f32 %f920, %f1545, %f1545
  asm("mul.f32 %0, %1, %2;" : "=f"(f920) : "f"(f1545), "f"(f1545));
  // PTX:1433 fma.rn.f32 %f921, %f1546, %f1546, %f920
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f921) : "f"(f1546), "f"(f1546), "f"(f920));
  // PTX:1434 fma.rn.f32 %f922, %f1547, %f1547, %f921
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f922) : "f"(f1547), "f"(f1547), "f"(f921));
  // PTX:1435 sqrt.rn.f32 %f923, %f922
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f923) : "f"(f922));
  // PTX:1436 setp.le.f32 %p109, %f923, 0f322BCC77
  p109 = (!(isnan(((float)(f923))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f923)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1437 mov.u32 %r1824, 0
  asm("mov.u32 %0, 0;" : "=r"(r1824) : );
  // PTX:1438 mov.u32 %r1825, %r1824
  asm("mov.u32 %0, %1;" : "=r"(r1825) : "r"(r1824));
  // PTX:1439 mov.u32 %r1826, %r1824
  asm("mov.u32 %0, %1;" : "=r"(r1826) : "r"(r1824));
  // PTX:1440 mov.u32 %r1827, %r1823
  asm("mov.u32 %0, %1;" : "=r"(r1827) : "r"(r1823));
  // PTX:1441 mov.u32 %r1828, %r1824
  asm("mov.u32 %0, %1;" : "=r"(r1828) : "r"(r1824));
  // PTX:1442 mov.u32 %r1829, %r1824
  asm("mov.u32 %0, %1;" : "=r"(r1829) : "r"(r1824));
  // PTX:1443 mov.u32 %r1830, %r1824
  asm("mov.u32 %0, %1;" : "=r"(r1830) : "r"(r1824));
  // PTX:1444 mov.u32 %r1831, %r1823
  asm("mov.u32 %0, %1;" : "=r"(r1831) : "r"(r1823));
  // PTX:1445 @%p109 bra $L__BB4_113
  if (p109) { goto L_BB4_113; }
  // PTX:1447 mov.u32 %r1823, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r1823) : );
  // PTX:1448 mov.b32 %f191, %r1820
  asm("mov.b32 %0, %1;" : "=f"(f191) : "r"(r1820));
  // PTX:1449 mov.b32 %f192, %r1821
  asm("mov.b32 %0, %1;" : "=f"(f192) : "r"(r1821));
  // PTX:1450 mul.f32 %f924, %f192, %f192
  asm("mul.f32 %0, %1, %2;" : "=f"(f924) : "f"(f192), "f"(f192));
  // PTX:1451 mov.b32 %f193, %r1822
  asm("mov.b32 %0, %1;" : "=f"(f193) : "r"(r1822));
  // PTX:1452 fma.rn.f32 %f925, %f191, %f191, %f924
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f925) : "f"(f191), "f"(f191), "f"(f924));
  // PTX:1453 fma.rn.f32 %f926, %f193, %f193, %f925
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f926) : "f"(f193), "f"(f193), "f"(f925));
  // PTX:1454 sqrt.rn.f32 %f927, %f926
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f927) : "f"(f926));
  // PTX:1455 setp.le.f32 %p110, %f927, 0f322BCC77
  p110 = (!(isnan(((float)(f927))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f927)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1456 @%p110 bra $L__BB4_113
  if (p110) { goto L_BB4_113; }
  // PTX:1458 mov.b32 %f1550, %r1810
  asm("mov.b32 %0, %1;" : "=f"(f1550) : "r"(r1810));
  // PTX:1459 mov.b32 %f1549, %r1808
  asm("mov.b32 %0, %1;" : "=f"(f1549) : "r"(r1808));
  // PTX:1460 mov.b32 %f1548, %r1809
  asm("mov.b32 %0, %1;" : "=f"(f1548) : "r"(r1809));
  // PTX:1461 mul.f32 %f928, %f1548, %f193
  asm("mul.f32 %0, %1, %2;" : "=f"(f928) : "f"(f1548), "f"(f193));
  // PTX:1462 mul.f32 %f929, %f1550, %f192
  asm("mul.f32 %0, %1, %2;" : "=f"(f929) : "f"(f1550), "f"(f192));
  // PTX:1463 sub.f32 %f194, %f928, %f929
  asm("sub.f32 %0, %1, %2;" : "=f"(f194) : "f"(f928), "f"(f929));
  // PTX:1464 mul.f32 %f930, %f1549, %f193
  asm("mul.f32 %0, %1, %2;" : "=f"(f930) : "f"(f1549), "f"(f193));
  // PTX:1465 mul.f32 %f931, %f1550, %f191
  asm("mul.f32 %0, %1, %2;" : "=f"(f931) : "f"(f1550), "f"(f191));
  // PTX:1466 sub.f32 %f195, %f931, %f930
  asm("sub.f32 %0, %1, %2;" : "=f"(f195) : "f"(f931), "f"(f930));
  // PTX:1467 mul.f32 %f932, %f1548, %f191
  asm("mul.f32 %0, %1, %2;" : "=f"(f932) : "f"(f1548), "f"(f191));
  // PTX:1468 mul.f32 %f933, %f1549, %f192
  asm("mul.f32 %0, %1, %2;" : "=f"(f933) : "f"(f1549), "f"(f192));
  // PTX:1469 sub.f32 %f196, %f933, %f932
  asm("sub.f32 %0, %1, %2;" : "=f"(f196) : "f"(f933), "f"(f932));
  // PTX:1470 mul.f32 %f934, %f195, %f195
  asm("mul.f32 %0, %1, %2;" : "=f"(f934) : "f"(f195), "f"(f195));
  // PTX:1471 fma.rn.f32 %f935, %f194, %f194, %f934
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f935) : "f"(f194), "f"(f194), "f"(f934));
  // PTX:1472 fma.rn.f32 %f936, %f196, %f196, %f935
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f936) : "f"(f196), "f"(f196), "f"(f935));
  // PTX:1473 sqrt.rn.f32 %f197, %f936
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f197) : "f"(f936));
  // PTX:1474 setp.leu.f32 %p111, %f197, 0f00000000
  p111 = ((isnan(((float)(f197))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f197)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1475 mov.u32 %r1829, 0
  asm("mov.u32 %0, 0;" : "=r"(r1829) : );
  // PTX:1476 mov.u32 %r1830, %r1829
  asm("mov.u32 %0, %1;" : "=r"(r1830) : "r"(r1829));
  // PTX:1477 mov.u32 %r1831, %r1829
  asm("mov.u32 %0, %1;" : "=r"(r1831) : "r"(r1829));
  // PTX:1478 @%p111 bra $L__BB4_110
  if (p111) { goto L_BB4_110; }
  // PTX:1480 div.rn.f32 %f937, %f194, %f197
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f937) : "f"(f194), "f"(f197));
  // PTX:1481 div.rn.f32 %f938, %f195, %f197
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f938) : "f"(f195), "f"(f197));
  // PTX:1482 div.rn.f32 %f939, %f196, %f197
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f939) : "f"(f196), "f"(f197));
  // PTX:1483 mov.b32 %r1831, %f939
  asm("mov.b32 %0, %1;" : "=r"(r1831) : "f"(f939));
  // PTX:1484 mov.b32 %r1830, %f938
  asm("mov.b32 %0, %1;" : "=r"(r1830) : "f"(f938));
  // PTX:1485 mov.b32 %r1829, %f937
  asm("mov.b32 %0, %1;" : "=r"(r1829) : "f"(f937));
  // PTX:1487 $L__BB4_110:
L_BB4_110:;
  // PTX:1488 mov.b32 %f198, %r1829
  asm("mov.b32 %0, %1;" : "=f"(f198) : "r"(r1829));
  // PTX:1489 mov.b32 %f199, %r1830
  asm("mov.b32 %0, %1;" : "=f"(f199) : "r"(r1830));
  // PTX:1490 mul.f32 %f940, %f1596, %f199
  asm("mul.f32 %0, %1, %2;" : "=f"(f940) : "f"(f1596), "f"(f199));
  // PTX:1491 mov.b32 %f200, %r1831
  asm("mov.b32 %0, %1;" : "=f"(f200) : "r"(r1831));
  // PTX:1492 fma.rn.f32 %f941, %f1595, %f198, %f940
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f941) : "f"(f1595), "f"(f198), "f"(f940));
  // PTX:1493 fma.rn.f32 %f942, %f1597, %f200, %f941
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f942) : "f"(f1597), "f"(f200), "f"(f941));
  // PTX:1494 setp.geu.f32 %p112, %f942, 0f00000000
  p112 = ((isnan(((float)(f942))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f942)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:1495 @%p112 bra $L__BB4_112
  if (p112) { goto L_BB4_112; }
  // PTX:1497 mov.b32 %f1553, %r1820
  asm("mov.b32 %0, %1;" : "=f"(f1553) : "r"(r1820));
  // PTX:1498 mov.b32 %f1552, %r1821
  asm("mov.b32 %0, %1;" : "=f"(f1552) : "r"(r1821));
  // PTX:1499 mov.b32 %f1551, %r1822
  asm("mov.b32 %0, %1;" : "=f"(f1551) : "r"(r1822));
  // PTX:1500 neg.f32 %f943, %f1553
  asm("neg.f32 %0, %1;" : "=f"(f943) : "f"(f1553));
  // PTX:1501 mov.b32 %r1820, %f943
  asm("mov.b32 %0, %1;" : "=r"(r1820) : "f"(f943));
  // PTX:1502 neg.f32 %f944, %f1552
  asm("neg.f32 %0, %1;" : "=f"(f944) : "f"(f1552));
  // PTX:1503 mov.b32 %r1821, %f944
  asm("mov.b32 %0, %1;" : "=r"(r1821) : "f"(f944));
  // PTX:1504 neg.f32 %f945, %f1551
  asm("neg.f32 %0, %1;" : "=f"(f945) : "f"(f1551));
  // PTX:1505 mov.b32 %r1822, %f945
  asm("mov.b32 %0, %1;" : "=r"(r1822) : "f"(f945));
  // PTX:1506 neg.f32 %f946, %f198
  asm("neg.f32 %0, %1;" : "=f"(f946) : "f"(f198));
  // PTX:1507 mov.b32 %r1829, %f946
  asm("mov.b32 %0, %1;" : "=r"(r1829) : "f"(f946));
  // PTX:1508 neg.f32 %f947, %f199
  asm("neg.f32 %0, %1;" : "=f"(f947) : "f"(f199));
  // PTX:1509 mov.b32 %r1830, %f947
  asm("mov.b32 %0, %1;" : "=r"(r1830) : "f"(f947));
  // PTX:1510 neg.f32 %f948, %f200
  asm("neg.f32 %0, %1;" : "=f"(f948) : "f"(f200));
  // PTX:1511 mov.b32 %r1831, %f948
  asm("mov.b32 %0, %1;" : "=r"(r1831) : "f"(f948));
  // PTX:1513 $L__BB4_112:
L_BB4_112:;
  // PTX:1514 mov.u32 %r1823, %r1808
  asm("mov.u32 %0, %1;" : "=r"(r1823) : "r"(r1808));
  // PTX:1515 mov.u32 %r1824, %r1809
  asm("mov.u32 %0, %1;" : "=r"(r1824) : "r"(r1809));
  // PTX:1516 mov.u32 %r1825, %r1810
  asm("mov.u32 %0, %1;" : "=r"(r1825) : "r"(r1810));
  // PTX:1517 mov.u32 %r1826, %r1820
  asm("mov.u32 %0, %1;" : "=r"(r1826) : "r"(r1820));
  // PTX:1518 mov.u32 %r1827, %r1821
  asm("mov.u32 %0, %1;" : "=r"(r1827) : "r"(r1821));
  // PTX:1519 mov.u32 %r1828, %r1822
  asm("mov.u32 %0, %1;" : "=r"(r1828) : "r"(r1822));
  // PTX:1521 $L__BB4_113:
L_BB4_113:;
  // PTX:1522 mov.b32 %f949, %r1823
  asm("mov.b32 %0, %1;" : "=f"(f949) : "r"(r1823));
  // PTX:1523 mov.b32 %f950, %r1826
  asm("mov.b32 %0, %1;" : "=f"(f950) : "r"(r1826));
  // PTX:1524 mov.b32 %f951, %r1829
  asm("mov.b32 %0, %1;" : "=f"(f951) : "r"(r1829));
  // PTX:1525 mov.b32 %f952, %r1824
  asm("mov.b32 %0, %1;" : "=f"(f952) : "r"(r1824));
  // PTX:1526 mul.f32 %f953, %f1603, %f952
  asm("mul.f32 %0, %1, %2;" : "=f"(f953) : "f"(f1603), "f"(f952));
  // PTX:1527 mov.b32 %f954, %r1827
  asm("mov.b32 %0, %1;" : "=f"(f954) : "r"(r1827));
  // PTX:1528 mul.f32 %f955, %f1603, %f954
  asm("mul.f32 %0, %1, %2;" : "=f"(f955) : "f"(f1603), "f"(f954));
  // PTX:1529 mov.b32 %f956, %r1830
  asm("mov.b32 %0, %1;" : "=f"(f956) : "r"(r1830));
  // PTX:1530 mul.f32 %f957, %f1603, %f956
  asm("mul.f32 %0, %1, %2;" : "=f"(f957) : "f"(f1603), "f"(f956));
  // PTX:1531 fma.rn.f32 %f958, %f1605, %f949, %f953
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f958) : "f"(f1605), "f"(f949), "f"(f953));
  // PTX:1532 fma.rn.f32 %f959, %f1605, %f950, %f955
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f959) : "f"(f1605), "f"(f950), "f"(f955));
  // PTX:1533 fma.rn.f32 %f960, %f1605, %f951, %f957
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f960) : "f"(f1605), "f"(f951), "f"(f957));
  // PTX:1534 mov.b32 %f961, %r1825
  asm("mov.b32 %0, %1;" : "=f"(f961) : "r"(r1825));
  // PTX:1535 mov.b32 %f962, %r1828
  asm("mov.b32 %0, %1;" : "=f"(f962) : "r"(r1828));
  // PTX:1536 mov.b32 %f963, %r1831
  asm("mov.b32 %0, %1;" : "=f"(f963) : "r"(r1831));
  // PTX:1537 fma.rn.f32 %f1598, %f1601, %f961, %f958
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1598) : "f"(f1601), "f"(f961), "f"(f958));
  // PTX:1538 fma.rn.f32 %f1599, %f1601, %f962, %f959
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1599) : "f"(f1601), "f"(f962), "f"(f959));
  // PTX:1539 fma.rn.f32 %f1600, %f1601, %f963, %f960
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1600) : "f"(f1601), "f"(f963), "f"(f960));
  // PTX:1540 bra.uni $L__BB4_114
  goto L_BB4_114;
  // PTX:1542 $L__BB4_88:
L_BB4_88:;
  // PTX:1543 mov.b32 %f1608, %r1795
  asm("mov.b32 %0, %1;" : "=f"(f1608) : "r"(r1795));
  // PTX:1544 mov.b32 %f1607, %r1796
  asm("mov.b32 %0, %1;" : "=f"(f1607) : "r"(r1796));
  // PTX:1545 mov.b32 %f1606, %r1797
  asm("mov.b32 %0, %1;" : "=f"(f1606) : "r"(r1797));
  // PTX:1546 mov.u32 %r1844, %r1841
  asm("mov.u32 %0, %1;" : "=r"(r1844) : "r"(r1841));
  // PTX:1547 mov.u32 %r1845, %r1842
  asm("mov.u32 %0, %1;" : "=r"(r1845) : "r"(r1842));
  // PTX:1548 mov.u32 %r1846, %r1843
  asm("mov.u32 %0, %1;" : "=r"(r1846) : "r"(r1843));
  // PTX:1549 bra.uni $L__BB4_117
  goto L_BB4_117;
  // PTX:1551 $L__BB4_115:
L_BB4_115:;
  // PTX:1552 mul.f32 %f1605, %f109, %f1608
  asm("mul.f32 %0, %1, %2;" : "=f"(f1605) : "f"(f109), "f"(f1608));
  // PTX:1553 mov.b32 %f1607, %r135
  asm("mov.b32 %0, %1;" : "=f"(f1607) : "r"(r135));
  // PTX:1554 mul.f32 %f1603, %f109, %f1607
  asm("mul.f32 %0, %1, %2;" : "=f"(f1603) : "f"(f109), "f"(f1607));
  // PTX:1555 mov.b32 %f1606, %r134
  asm("mov.b32 %0, %1;" : "=f"(f1606) : "r"(r134));
  // PTX:1556 mul.f32 %f1601, %f109, %f1606
  asm("mul.f32 %0, %1, %2;" : "=f"(f1601) : "f"(f109), "f"(f1606));
  // PTX:1557 mov.b32 %f976, %r1844
  asm("mov.b32 %0, %1;" : "=f"(f976) : "r"(r1844));
  // PTX:1558 add.f32 %f977, %f1605, %f976
  asm("add.f32 %0, %1, %2;" : "=f"(f977) : "f"(f1605), "f"(f976));
  // PTX:1559 mov.b32 %f978, %r1845
  asm("mov.b32 %0, %1;" : "=f"(f978) : "r"(r1845));
  // PTX:1560 add.f32 %f979, %f1603, %f978
  asm("add.f32 %0, %1, %2;" : "=f"(f979) : "f"(f1603), "f"(f978));
  // PTX:1561 mov.b32 %f980, %r1846
  asm("mov.b32 %0, %1;" : "=f"(f980) : "r"(r1846));
  // PTX:1562 add.f32 %f981, %f1601, %f980
  asm("add.f32 %0, %1, %2;" : "=f"(f981) : "f"(f1601), "f"(f980));
  // PTX:1563 mov.b32 %r1841, %f977
  asm("mov.b32 %0, %1;" : "=r"(r1841) : "f"(f977));
  // PTX:1564 mov.b32 %r1843, %f981
  asm("mov.b32 %0, %1;" : "=r"(r1843) : "f"(f981));
  // PTX:1565 mov.b32 %r1842, %f979
  asm("mov.b32 %0, %1;" : "=r"(r1842) : "f"(f979));
  // PTX:1566 bra.uni $L__BB4_116
  goto L_BB4_116;
  // PTX:1568 $L__BB4_95:
L_BB4_95:;
  // PTX:1569 rcp.rn.f32 %f777, %f128
  asm("rcp.rn.f32 %0, %1;" : "=f"(f777) : "f"(f128));
  // PTX:1570 mul.f32 %f778, %f126, %f116
  asm("mul.f32 %0, %1, %2;" : "=f"(f778) : "f"(f126), "f"(f116));
  // PTX:1571 mul.f32 %f779, %f127, %f118
  asm("mul.f32 %0, %1, %2;" : "=f"(f779) : "f"(f127), "f"(f118));
  // PTX:1572 sub.f32 %f780, %f779, %f778
  asm("sub.f32 %0, %1, %2;" : "=f"(f780) : "f"(f779), "f"(f778));
  // PTX:1573 mul.f32 %f781, %f127, %f121
  asm("mul.f32 %0, %1, %2;" : "=f"(f781) : "f"(f127), "f"(f121));
  // PTX:1574 mul.f32 %f782, %f125, %f116
  asm("mul.f32 %0, %1, %2;" : "=f"(f782) : "f"(f125), "f"(f116));
  // PTX:1575 sub.f32 %f783, %f782, %f781
  asm("sub.f32 %0, %1, %2;" : "=f"(f783) : "f"(f782), "f"(f781));
  // PTX:1576 mul.f32 %f784, %f125, %f118
  asm("mul.f32 %0, %1, %2;" : "=f"(f784) : "f"(f125), "f"(f118));
  // PTX:1577 mul.f32 %f785, %f126, %f121
  asm("mul.f32 %0, %1, %2;" : "=f"(f785) : "f"(f126), "f"(f121));
  // PTX:1578 sub.f32 %f786, %f785, %f784
  asm("sub.f32 %0, %1, %2;" : "=f"(f786) : "f"(f785), "f"(f784));
  // PTX:1579 mul.f32 %f787, %f127, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f787) : "f"(f127), "f"(f117));
  // PTX:1580 mul.f32 %f788, %f126, %f119
  asm("mul.f32 %0, %1, %2;" : "=f"(f788) : "f"(f126), "f"(f119));
  // PTX:1581 sub.f32 %f789, %f788, %f787
  asm("sub.f32 %0, %1, %2;" : "=f"(f789) : "f"(f788), "f"(f787));
  // PTX:1582 mul.f32 %f790, %f125, %f119
  asm("mul.f32 %0, %1, %2;" : "=f"(f790) : "f"(f125), "f"(f119));
  // PTX:1583 mul.f32 %f791, %f127, %f122
  asm("mul.f32 %0, %1, %2;" : "=f"(f791) : "f"(f127), "f"(f122));
  // PTX:1584 sub.f32 %f792, %f791, %f790
  asm("sub.f32 %0, %1, %2;" : "=f"(f792) : "f"(f791), "f"(f790));
  // PTX:1585 mul.f32 %f793, %f126, %f122
  asm("mul.f32 %0, %1, %2;" : "=f"(f793) : "f"(f126), "f"(f122));
  // PTX:1586 mul.f32 %f794, %f125, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f794) : "f"(f125), "f"(f117));
  // PTX:1587 sub.f32 %f795, %f794, %f793
  asm("sub.f32 %0, %1, %2;" : "=f"(f795) : "f"(f794), "f"(f793));
  // PTX:1588 mul.f32 %f796, %f120, %f777
  asm("mul.f32 %0, %1, %2;" : "=f"(f796) : "f"(f120), "f"(f777));
  // PTX:1589 mul.f32 %f797, %f123, %f777
  asm("mul.f32 %0, %1, %2;" : "=f"(f797) : "f"(f123), "f"(f777));
  // PTX:1590 mul.f32 %f798, %f124, %f777
  asm("mul.f32 %0, %1, %2;" : "=f"(f798) : "f"(f124), "f"(f777));
  // PTX:1591 mul.f32 %f799, %f780, %f777
  asm("mul.f32 %0, %1, %2;" : "=f"(f799) : "f"(f780), "f"(f777));
  // PTX:1592 mul.f32 %f800, %f783, %f777
  asm("mul.f32 %0, %1, %2;" : "=f"(f800) : "f"(f783), "f"(f777));
  // PTX:1593 mul.f32 %f801, %f786, %f777
  asm("mul.f32 %0, %1, %2;" : "=f"(f801) : "f"(f786), "f"(f777));
  // PTX:1594 mul.f32 %f802, %f789, %f777
  asm("mul.f32 %0, %1, %2;" : "=f"(f802) : "f"(f789), "f"(f777));
  // PTX:1595 mul.f32 %f803, %f792, %f777
  asm("mul.f32 %0, %1, %2;" : "=f"(f803) : "f"(f792), "f"(f777));
  // PTX:1596 mul.f32 %f804, %f795, %f777
  asm("mul.f32 %0, %1, %2;" : "=f"(f804) : "f"(f795), "f"(f777));
  // PTX:1597 mul.f32 %f805, %f1603, %f797
  asm("mul.f32 %0, %1, %2;" : "=f"(f805) : "f"(f1603), "f"(f797));
  // PTX:1598 mul.f32 %f806, %f1603, %f800
  asm("mul.f32 %0, %1, %2;" : "=f"(f806) : "f"(f1603), "f"(f800));
  // PTX:1599 mul.f32 %f807, %f1603, %f803
  asm("mul.f32 %0, %1, %2;" : "=f"(f807) : "f"(f1603), "f"(f803));
  // PTX:1600 fma.rn.f32 %f808, %f1605, %f796, %f805
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f808) : "f"(f1605), "f"(f796), "f"(f805));
  // PTX:1601 fma.rn.f32 %f809, %f1605, %f799, %f806
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f809) : "f"(f1605), "f"(f799), "f"(f806));
  // PTX:1602 fma.rn.f32 %f810, %f1605, %f802, %f807
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f810) : "f"(f1605), "f"(f802), "f"(f807));
  // PTX:1603 fma.rn.f32 %f1598, %f1601, %f798, %f808
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1598) : "f"(f1601), "f"(f798), "f"(f808));
  // PTX:1604 fma.rn.f32 %f1599, %f1601, %f801, %f809
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1599) : "f"(f1601), "f"(f801), "f"(f809));
  // PTX:1605 fma.rn.f32 %f1600, %f1601, %f804, %f810
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1600) : "f"(f1601), "f"(f804), "f"(f810));
  // PTX:1607 $L__BB4_114:
L_BB4_114:;
  // PTX:1608 mov.b32 %f968, %r1844
  asm("mov.b32 %0, %1;" : "=f"(f968) : "r"(r1844));
  // PTX:1609 add.f32 %f969, %f968, %f1598
  asm("add.f32 %0, %1, %2;" : "=f"(f969) : "f"(f968), "f"(f1598));
  // PTX:1610 mov.b32 %f971, %r1845
  asm("mov.b32 %0, %1;" : "=f"(f971) : "r"(r1845));
  // PTX:1611 add.f32 %f972, %f971, %f1599
  asm("add.f32 %0, %1, %2;" : "=f"(f972) : "f"(f971), "f"(f1599));
  // PTX:1612 mov.b32 %f974, %r1846
  asm("mov.b32 %0, %1;" : "=f"(f974) : "r"(r1846));
  // PTX:1613 add.f32 %f975, %f974, %f1600
  asm("add.f32 %0, %1, %2;" : "=f"(f975) : "f"(f974), "f"(f1600));
  // PTX:1614 mov.b32 %r1841, %f969
  asm("mov.b32 %0, %1;" : "=r"(r1841) : "f"(f969));
  // PTX:1615 mov.b32 %r1842, %f972
  asm("mov.b32 %0, %1;" : "=r"(r1842) : "f"(f972));
  // PTX:1616 mov.b32 %r1843, %f975
  asm("mov.b32 %0, %1;" : "=r"(r1843) : "f"(f975));
  // PTX:1618 $L__BB4_116:
L_BB4_116:;
  // PTX:1619 add.f32 %f982, %f1605, %f102
  asm("add.f32 %0, %1, %2;" : "=f"(f982) : "f"(f1605), "f"(f102));
  // PTX:1620 mov.b32 %r1838, %f982
  asm("mov.b32 %0, %1;" : "=r"(r1838) : "f"(f982));
  // PTX:1621 add.f32 %f983, %f1603, %f104
  asm("add.f32 %0, %1, %2;" : "=f"(f983) : "f"(f1603), "f"(f104));
  // PTX:1622 mov.b32 %r1839, %f983
  asm("mov.b32 %0, %1;" : "=r"(r1839) : "f"(f983));
  // PTX:1623 add.f32 %f984, %f1601, %f106
  asm("add.f32 %0, %1, %2;" : "=f"(f984) : "f"(f1601), "f"(f106));
  // PTX:1624 mov.b32 %r1840, %f984
  asm("mov.b32 %0, %1;" : "=r"(r1840) : "f"(f984));
  // PTX:1626 $L__BB4_117:
L_BB4_117:;
  // PTX:1627 mul.f32 %f214, %f1607, %f1607
  asm("mul.f32 %0, %1, %2;" : "=f"(f214) : "f"(f1607), "f"(f1607));
  // PTX:1628 mul.f32 %f215, %f1608, %f1608
  asm("mul.f32 %0, %1, %2;" : "=f"(f215) : "f"(f1608), "f"(f1608));
  // PTX:1629 add.f32 %f1000, %f214, %f215
  asm("add.f32 %0, %1, %2;" : "=f"(f1000) : "f"(f214), "f"(f215));
  // PTX:1630 mul.f32 %f216, %f1606, %f1606
  asm("mul.f32 %0, %1, %2;" : "=f"(f216) : "f"(f1606), "f"(f1606));
  // PTX:1631 add.f32 %f1001, %f216, %f1000
  asm("add.f32 %0, %1, %2;" : "=f"(f1001) : "f"(f216), "f"(f1000));
  // PTX:1632 setp.ltu.f32 %p113, %f1001, 0f3F000000
  p113 = ((isnan(((float)(f1001))) || isnan(((float)(as_f32(0x3F000000u))))) || (((float)(f1001)) < ((float)(as_f32(0x3F000000u)))));
  // PTX:1633 mov.u32 %r1853, 0
  asm("mov.u32 %0, 0;" : "=r"(r1853) : );
  // PTX:1634 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:1635 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:1636 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:1637 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:1638 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:1639 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:1640 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:1641 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:1642 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:1643 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:1644 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:1645 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:1646 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:1647 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:1648 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:1649 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:1650 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:1651 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:1652 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:1653 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:1654 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:1655 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:1656 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:1657 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:1658 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:1659 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:1660 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:1661 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:1662 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:1663 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:1664 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:1665 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:1666 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:1667 @%p113 bra $L__BB4_164
  if (p113) { goto L_BB4_164; }
  // PTX:1669 add.s64 %rd260, %rd39, %rd141
  asm("add.s64 %0, %1, %2;" : "=l"(rd260) : "l"(rd39), "l"(rd141));
  // PTX:1670 ld.global.u32 %r1848, [%rd260]
  r1848 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd260) + (0)))));
  // PTX:1671 ld.global.u32 %r1847, [%rd260+4]
  r1847 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd260) + (4)))));
  // PTX:1672 ld.global.u32 %r1849, [%rd260+8]
  r1849 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd260) + (8)))));
  // PTX:1673 mov.u32 %r1850, %r1848
  asm("mov.u32 %0, %1;" : "=r"(r1850) : "r"(r1848));
  // PTX:1674 mov.u32 %r1851, %r1847
  asm("mov.u32 %0, %1;" : "=r"(r1851) : "r"(r1847));
  // PTX:1675 mov.u32 %r1852, %r1849
  asm("mov.u32 %0, %1;" : "=r"(r1852) : "r"(r1849));
  // PTX:1676 @%p82 bra $L__BB4_144
  if (p82) { goto L_BB4_144; }
  // PTX:1678 setp.eq.s64 %p115, %rd24, 0
  p115 = (((long long)(rd24)) == ((long long)(0)));
  // PTX:1679 mul.wide.s32 %rd261, %r1790, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd261) : "r"(r1790));
  // PTX:1680 add.s64 %rd92, %rd37, %rd261
  asm("add.s64 %0, %1, %2;" : "=l"(rd92) : "l"(rd37), "l"(rd261));
  // PTX:1681 ld.global.f32 %f1002, [%rd92]
  f1002 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0)))));
  // PTX:1682 mov.b32 %f1003, %r1844
  asm("mov.b32 %0, %1;" : "=f"(f1003) : "r"(r1844));
  // PTX:1683 sub.f32 %f1004, %f1003, %f1002
  asm("sub.f32 %0, %1, %2;" : "=f"(f1004) : "f"(f1003), "f"(f1002));
  // PTX:1684 ld.global.f32 %f1005, [%rd92+4]
  f1005 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (4)))));
  // PTX:1685 mov.b32 %f1006, %r1845
  asm("mov.b32 %0, %1;" : "=f"(f1006) : "r"(r1845));
  // PTX:1686 sub.f32 %f1007, %f1006, %f1005
  asm("sub.f32 %0, %1, %2;" : "=f"(f1007) : "f"(f1006), "f"(f1005));
  // PTX:1687 ld.global.f32 %f1008, [%rd92+8]
  f1008 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (8)))));
  // PTX:1688 mov.b32 %f1009, %r1846
  asm("mov.b32 %0, %1;" : "=f"(f1009) : "r"(r1846));
  // PTX:1689 sub.f32 %f1010, %f1009, %f1008
  asm("sub.f32 %0, %1, %2;" : "=f"(f1010) : "f"(f1009), "f"(f1008));
  // PTX:1690 mov.b32 %f217, %r1841
  asm("mov.b32 %0, %1;" : "=f"(f217) : "r"(r1841));
  // PTX:1691 sub.f32 %f1011, %f217, %f1002
  asm("sub.f32 %0, %1, %2;" : "=f"(f1011) : "f"(f217), "f"(f1002));
  // PTX:1692 mov.b32 %f218, %r1842
  asm("mov.b32 %0, %1;" : "=f"(f218) : "r"(r1842));
  // PTX:1693 sub.f32 %f1012, %f218, %f1005
  asm("sub.f32 %0, %1, %2;" : "=f"(f1012) : "f"(f218), "f"(f1005));
  // PTX:1694 mov.b32 %f219, %r1843
  asm("mov.b32 %0, %1;" : "=f"(f219) : "r"(r1843));
  // PTX:1695 sub.f32 %f1013, %f219, %f1008
  asm("sub.f32 %0, %1, %2;" : "=f"(f1013) : "f"(f219), "f"(f1008));
  // PTX:1696 mul.wide.s32 %rd262, %r88, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd262) : "r"(r88));
  // PTX:1697 add.s64 %rd263, %rd2, %rd262
  asm("add.s64 %0, %1, %2;" : "=l"(rd263) : "l"(rd2), "l"(rd262));
  // PTX:1698 st.local.u32 [%rd263], %r1794
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd263) + (0))))) = (unsigned)(r1794);
  // PTX:1699 ld.local.u32 %r1223, [%rd2+56]
  r1223 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:1700 add.s32 %r1224, %r1223, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r1224) : "r"(r1223));
  // PTX:1701 st.local.u32 [%rd2+56], %r1224
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56))))) = (unsigned)(r1224);
  // PTX:1702 add.s64 %rd264, %rd2, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd264) : "l"(rd2));
  // PTX:1703 mul.wide.s32 %rd265, %r1223, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd265) : "r"(r1223));
  // PTX:1704 add.s64 %rd266, %rd264, %rd265
  asm("add.s64 %0, %1, %2;" : "=l"(rd266) : "l"(rd264), "l"(rd265));
  // PTX:1705 mov.u32 %r1225, -1082130432
  asm("mov.u32 %0, -1082130432;" : "=r"(r1225) : );
  // PTX:1706 st.local.u32 [%rd266], %r1225
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd266) + (0))))) = (unsigned)(r1225);
  // PTX:1707 ld.local.u32 %r1226, [%rd2+116]
  r1226 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:1708 add.s64 %rd267, %rd2, 60
  asm("add.s64 %0, %1, 60;" : "=l"(rd267) : "l"(rd2));
  // PTX:1709 mul.wide.s32 %rd268, %r1226, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd268) : "r"(r1226));
  // PTX:1710 add.s64 %rd269, %rd267, %rd268
  asm("add.s64 %0, %1, %2;" : "=l"(rd269) : "l"(rd267), "l"(rd268));
  // PTX:1711 st.local.u32 [%rd269], %r1794
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd269) + (0))))) = (unsigned)(r1794);
  // PTX:1712 ld.local.u32 %r1227, [%rd2+116]
  r1227 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:1713 add.s32 %r1228, %r1227, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r1228) : "r"(r1227));
  // PTX:1714 st.local.u32 [%rd2+116], %r1228
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116))))) = (unsigned)(r1228);
  // PTX:1715 add.s64 %rd270, %rd2, 88
  asm("add.s64 %0, %1, 88;" : "=l"(rd270) : "l"(rd2));
  // PTX:1716 mul.wide.s32 %rd271, %r1227, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd271) : "r"(r1227));
  // PTX:1717 add.s64 %rd272, %rd270, %rd271
  asm("add.s64 %0, %1, %2;" : "=l"(rd272) : "l"(rd270), "l"(rd271));
  // PTX:1718 st.local.u32 [%rd272], %r1225
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd272) + (0))))) = (unsigned)(r1225);
  // PTX:1719 ld.local.u32 %r1229, [%rd2+56]
  r1229 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:1720 mul.wide.s32 %rd273, %r1229, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd273) : "r"(r1229));
  // PTX:1721 add.s64 %rd274, %rd2, %rd273
  asm("add.s64 %0, %1, %2;" : "=l"(rd274) : "l"(rd2), "l"(rd273));
  // PTX:1722 st.local.u32 [%rd274], %r1793
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd274) + (0))))) = (unsigned)(r1793);
  // PTX:1723 neg.f32 %f1014, %f1004
  asm("neg.f32 %0, %1;" : "=f"(f1014) : "f"(f1004));
  // PTX:1724 ld.local.u32 %r1230, [%rd2+56]
  r1230 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:1725 add.s32 %r1231, %r1230, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r1231) : "r"(r1230));
  // PTX:1726 st.local.u32 [%rd2+56], %r1231
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56))))) = (unsigned)(r1231);
  // PTX:1727 mul.wide.s32 %rd275, %r1230, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd275) : "r"(r1230));
  // PTX:1728 add.s64 %rd276, %rd264, %rd275
  asm("add.s64 %0, %1, %2;" : "=l"(rd276) : "l"(rd264), "l"(rd275));
  // PTX:1729 st.local.f32 [%rd276], %f1014
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd276) + (0))))) = (float)(f1014);
  // PTX:1730 ld.local.u32 %r1232, [%rd2+116]
  r1232 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:1731 mul.wide.s32 %rd277, %r1232, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd277) : "r"(r1232));
  // PTX:1732 add.s64 %rd278, %rd267, %rd277
  asm("add.s64 %0, %1, %2;" : "=l"(rd278) : "l"(rd267), "l"(rd277));
  // PTX:1733 st.local.u32 [%rd278], %r1793
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd278) + (0))))) = (unsigned)(r1793);
  // PTX:1734 neg.f32 %f1015, %f1011
  asm("neg.f32 %0, %1;" : "=f"(f1015) : "f"(f1011));
  // PTX:1735 ld.local.u32 %r1233, [%rd2+116]
  r1233 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:1736 add.s32 %r1234, %r1233, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r1234) : "r"(r1233));
  // PTX:1737 st.local.u32 [%rd2+116], %r1234
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116))))) = (unsigned)(r1234);
  // PTX:1738 mul.wide.s32 %rd279, %r1233, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd279) : "r"(r1233));
  // PTX:1739 add.s64 %rd280, %rd270, %rd279
  asm("add.s64 %0, %1, %2;" : "=l"(rd280) : "l"(rd270), "l"(rd279));
  // PTX:1740 st.local.f32 [%rd280], %f1015
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd280) + (0))))) = (float)(f1015);
  // PTX:1741 ld.local.u32 %r1235, [%rd2+56]
  r1235 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:1742 mul.wide.s32 %rd281, %r1235, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd281) : "r"(r1235));
  // PTX:1743 add.s64 %rd282, %rd2, %rd281
  asm("add.s64 %0, %1, %2;" : "=l"(rd282) : "l"(rd2), "l"(rd281));
  // PTX:1744 st.local.u32 [%rd282], %r1792
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd282) + (0))))) = (unsigned)(r1792);
  // PTX:1745 neg.f32 %f1016, %f1007
  asm("neg.f32 %0, %1;" : "=f"(f1016) : "f"(f1007));
  // PTX:1746 ld.local.u32 %r1236, [%rd2+56]
  r1236 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:1747 add.s32 %r1237, %r1236, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r1237) : "r"(r1236));
  // PTX:1748 st.local.u32 [%rd2+56], %r1237
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56))))) = (unsigned)(r1237);
  // PTX:1749 mul.wide.s32 %rd283, %r1236, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd283) : "r"(r1236));
  // PTX:1750 add.s64 %rd284, %rd264, %rd283
  asm("add.s64 %0, %1, %2;" : "=l"(rd284) : "l"(rd264), "l"(rd283));
  // PTX:1751 st.local.f32 [%rd284], %f1016
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd284) + (0))))) = (float)(f1016);
  // PTX:1752 ld.local.u32 %r1238, [%rd2+116]
  r1238 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:1753 mul.wide.s32 %rd285, %r1238, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd285) : "r"(r1238));
  // PTX:1754 add.s64 %rd286, %rd267, %rd285
  asm("add.s64 %0, %1, %2;" : "=l"(rd286) : "l"(rd267), "l"(rd285));
  // PTX:1755 st.local.u32 [%rd286], %r1792
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd286) + (0))))) = (unsigned)(r1792);
  // PTX:1756 neg.f32 %f1017, %f1012
  asm("neg.f32 %0, %1;" : "=f"(f1017) : "f"(f1012));
  // PTX:1757 ld.local.u32 %r1239, [%rd2+116]
  r1239 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:1758 add.s32 %r1240, %r1239, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r1240) : "r"(r1239));
  // PTX:1759 st.local.u32 [%rd2+116], %r1240
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116))))) = (unsigned)(r1240);
  // PTX:1760 mul.wide.s32 %rd287, %r1239, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd287) : "r"(r1239));
  // PTX:1761 add.s64 %rd288, %rd270, %rd287
  asm("add.s64 %0, %1, %2;" : "=l"(rd288) : "l"(rd270), "l"(rd287));
  // PTX:1762 st.local.f32 [%rd288], %f1017
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd288) + (0))))) = (float)(f1017);
  // PTX:1763 ld.local.u32 %r1241, [%rd2+56]
  r1241 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:1764 mul.wide.s32 %rd289, %r1241, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd289) : "r"(r1241));
  // PTX:1765 add.s64 %rd290, %rd2, %rd289
  asm("add.s64 %0, %1, %2;" : "=l"(rd290) : "l"(rd2), "l"(rd289));
  // PTX:1766 st.local.u32 [%rd290], %r1791
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd290) + (0))))) = (unsigned)(r1791);
  // PTX:1767 neg.f32 %f1018, %f1010
  asm("neg.f32 %0, %1;" : "=f"(f1018) : "f"(f1010));
  // PTX:1768 ld.local.u32 %r1242, [%rd2+56]
  r1242 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:1769 add.s32 %r1243, %r1242, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r1243) : "r"(r1242));
  // PTX:1770 st.local.u32 [%rd2+56], %r1243
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56))))) = (unsigned)(r1243);
  // PTX:1771 mul.wide.s32 %rd291, %r1242, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd291) : "r"(r1242));
  // PTX:1772 add.s64 %rd292, %rd264, %rd291
  asm("add.s64 %0, %1, %2;" : "=l"(rd292) : "l"(rd264), "l"(rd291));
  // PTX:1773 st.local.f32 [%rd292], %f1018
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd292) + (0))))) = (float)(f1018);
  // PTX:1774 ld.local.u32 %r1244, [%rd2+116]
  r1244 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:1775 mul.wide.s32 %rd293, %r1244, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd293) : "r"(r1244));
  // PTX:1776 add.s64 %rd294, %rd267, %rd293
  asm("add.s64 %0, %1, %2;" : "=l"(rd294) : "l"(rd267), "l"(rd293));
  // PTX:1777 st.local.u32 [%rd294], %r1791
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd294) + (0))))) = (unsigned)(r1791);
  // PTX:1778 neg.f32 %f1019, %f1013
  asm("neg.f32 %0, %1;" : "=f"(f1019) : "f"(f1013));
  // PTX:1779 ld.local.u32 %r1245, [%rd2+116]
  r1245 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:1780 add.s32 %r1246, %r1245, 1
  asm("add.s32 %0, %1, 1;" : "=r"(r1246) : "r"(r1245));
  // PTX:1781 st.local.u32 [%rd2+116], %r1246
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116))))) = (unsigned)(r1246);
  // PTX:1782 mul.wide.s32 %rd295, %r1245, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd295) : "r"(r1245));
  // PTX:1783 add.s64 %rd296, %rd270, %rd295
  asm("add.s64 %0, %1, %2;" : "=l"(rd296) : "l"(rd270), "l"(rd295));
  // PTX:1784 st.local.f32 [%rd296], %f1019
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd296) + (0))))) = (float)(f1019);
  // PTX:1785 mul.wide.s32 %rd297, %r1793, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd297) : "r"(r1793));
  // PTX:1786 add.s64 %rd87, %rd23, %rd297
  asm("add.s64 %0, %1, %2;" : "=l"(rd87) : "l"(rd23), "l"(rd297));
  // PTX:1787 ld.global.f32 %f1020, [%rd87]
  f1020 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (0)))));
  // PTX:1788 mov.b32 %f1021, %r1848
  asm("mov.b32 %0, %1;" : "=f"(f1021) : "r"(r1848));
  // PTX:1789 ld.global.f32 %f1022, [%rd87+4]
  f1022 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (4)))));
  // PTX:1790 ld.global.f32 %f1023, [%rd87+8]
  f1023 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (8)))));
  // PTX:1791 mul.wide.s32 %rd298, %r1792, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd298) : "r"(r1792));
  // PTX:1792 add.s64 %rd89, %rd23, %rd298
  asm("add.s64 %0, %1, %2;" : "=l"(rd89) : "l"(rd23), "l"(rd298));
  // PTX:1793 ld.global.f32 %f1024, [%rd89]
  f1024 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (0)))));
  // PTX:1794 mov.b32 %f1025, %r1847
  asm("mov.b32 %0, %1;" : "=f"(f1025) : "r"(r1847));
  // PTX:1795 mul.f32 %f1026, %f1024, %f1025
  asm("mul.f32 %0, %1, %2;" : "=f"(f1026) : "f"(f1024), "f"(f1025));
  // PTX:1796 ld.global.f32 %f1027, [%rd89+4]
  f1027 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (4)))));
  // PTX:1797 mul.f32 %f1028, %f1027, %f1025
  asm("mul.f32 %0, %1, %2;" : "=f"(f1028) : "f"(f1027), "f"(f1025));
  // PTX:1798 ld.global.f32 %f1029, [%rd89+8]
  f1029 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (8)))));
  // PTX:1799 mul.f32 %f1030, %f1029, %f1025
  asm("mul.f32 %0, %1, %2;" : "=f"(f1030) : "f"(f1029), "f"(f1025));
  // PTX:1800 fma.rn.f32 %f1031, %f1020, %f1021, %f1026
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1031) : "f"(f1020), "f"(f1021), "f"(f1026));
  // PTX:1801 fma.rn.f32 %f1032, %f1022, %f1021, %f1028
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1032) : "f"(f1022), "f"(f1021), "f"(f1028));
  // PTX:1802 fma.rn.f32 %f1033, %f1023, %f1021, %f1030
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1033) : "f"(f1023), "f"(f1021), "f"(f1030));
  // PTX:1803 mul.wide.s32 %rd299, %r1791, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd299) : "r"(r1791));
  // PTX:1804 add.s64 %rd91, %rd23, %rd299
  asm("add.s64 %0, %1, %2;" : "=l"(rd91) : "l"(rd23), "l"(rd299));
  // PTX:1805 ld.global.f32 %f1034, [%rd91]
  f1034 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (0)))));
  // PTX:1806 mov.b32 %f1035, %r1849
  asm("mov.b32 %0, %1;" : "=f"(f1035) : "r"(r1849));
  // PTX:1807 ld.global.f32 %f1036, [%rd91+4]
  f1036 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (4)))));
  // PTX:1808 ld.global.f32 %f1037, [%rd91+8]
  f1037 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (8)))));
  // PTX:1809 fma.rn.f32 %f220, %f1034, %f1035, %f1031
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f220) : "f"(f1034), "f"(f1035), "f"(f1031));
  // PTX:1810 fma.rn.f32 %f221, %f1036, %f1035, %f1032
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f221) : "f"(f1036), "f"(f1035), "f"(f1032));
  // PTX:1811 fma.rn.f32 %f222, %f1037, %f1035, %f1033
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f222) : "f"(f1037), "f"(f1035), "f"(f1033));
  // PTX:1812 ld.global.f32 %f1038, [%rd92]
  f1038 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0)))));
  // PTX:1813 sub.f32 %f223, %f1003, %f1038
  asm("sub.f32 %0, %1, %2;" : "=f"(f223) : "f"(f1003), "f"(f1038));
  // PTX:1814 ld.global.f32 %f1039, [%rd92+4]
  f1039 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (4)))));
  // PTX:1815 sub.f32 %f224, %f1006, %f1039
  asm("sub.f32 %0, %1, %2;" : "=f"(f224) : "f"(f1006), "f"(f1039));
  // PTX:1816 ld.global.f32 %f1040, [%rd92+8]
  f1040 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (8)))));
  // PTX:1817 sub.f32 %f225, %f1009, %f1040
  asm("sub.f32 %0, %1, %2;" : "=f"(f225) : "f"(f1009), "f"(f1040));
  // PTX:1818 mul.wide.s32 %rd95, %r1794, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd95) : "r"(r1794));
  // PTX:1819 @%p115 bra $L__BB4_121
  if (p115) { goto L_BB4_121; }
  // PTX:1821 mul.wide.s32 %rd390, %r1794, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd390) : "r"(r1794));
  // PTX:1822 add.s64 %rd389, %rd25, %rd390
  asm("add.s64 %0, %1, %2;" : "=l"(rd389) : "l"(rd25), "l"(rd390));
  // PTX:1823 cvt.s64.s32 %rd388, %r1794
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd388) : "r"(r1794));
  // PTX:1824 mul.lo.s64 %rd300, %rd388, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd300) : "l"(rd388));
  // PTX:1825 add.s64 %rd301, %rd23, %rd300
  asm("add.s64 %0, %1, %2;" : "=l"(rd301) : "l"(rd23), "l"(rd300));
  // PTX:1826 ld.global.f32 %f1041, [%rd389]
  f1041 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd389) + (0)))));
  // PTX:1827 ld.global.f32 %f1042, [%rd301]
  f1042 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd301) + (0)))));
  // PTX:1828 sub.f32 %f1043, %f1042, %f1041
  asm("sub.f32 %0, %1, %2;" : "=f"(f1043) : "f"(f1042), "f"(f1041));
  // PTX:1829 ld.global.f32 %f1044, [%rd389+4]
  f1044 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd389) + (4)))));
  // PTX:1830 ld.global.f32 %f1045, [%rd301+4]
  f1045 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd301) + (4)))));
  // PTX:1831 sub.f32 %f1046, %f1045, %f1044
  asm("sub.f32 %0, %1, %2;" : "=f"(f1046) : "f"(f1045), "f"(f1044));
  // PTX:1832 ld.global.f32 %f1047, [%rd389+8]
  f1047 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd389) + (8)))));
  // PTX:1833 ld.global.f32 %f1048, [%rd301+8]
  f1048 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd301) + (8)))));
  // PTX:1834 sub.f32 %f1049, %f1048, %f1047
  asm("sub.f32 %0, %1, %2;" : "=f"(f1049) : "f"(f1048), "f"(f1047));
  // PTX:1835 mul.f32 %f1609, %f1, %f1043
  asm("mul.f32 %0, %1, %2;" : "=f"(f1609) : "f"(f1), "f"(f1043));
  // PTX:1836 mul.f32 %f1610, %f1, %f1046
  asm("mul.f32 %0, %1, %2;" : "=f"(f1610) : "f"(f1), "f"(f1046));
  // PTX:1837 mul.f32 %f1611, %f1, %f1049
  asm("mul.f32 %0, %1, %2;" : "=f"(f1611) : "f"(f1), "f"(f1049));
  // PTX:1838 bra.uni $L__BB4_122
  goto L_BB4_122;
  // PTX:1840 $L__BB4_121:
L_BB4_121:;
  // PTX:1841 ld.f32 %f1609, [%rd95]
  f1609 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd95) + (0))));
  // PTX:1842 ld.f32 %f1610, [%rd95+4]
  f1610 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd95) + (4))));
  // PTX:1843 ld.f32 %f1611, [%rd95+8]
  f1611 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd95) + (8))));
  // PTX:1845 $L__BB4_122:
L_BB4_122:;
  // PTX:1846 cvt.s64.s32 %rd391, %r1793
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd391) : "r"(r1793));
  // PTX:1847 mul.lo.s64 %rd97, %rd391, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd97) : "l"(rd391));
  // PTX:1848 add.s64 %rd96, %rd25, %rd97
  asm("add.s64 %0, %1, %2;" : "=l"(rd96) : "l"(rd25), "l"(rd97));
  // PTX:1849 @%p115 bra $L__BB4_124
  if (p115) { goto L_BB4_124; }
  // PTX:1851 mul.wide.s32 %rd393, %r1793, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd393) : "r"(r1793));
  // PTX:1852 add.s64 %rd392, %rd23, %rd393
  asm("add.s64 %0, %1, %2;" : "=l"(rd392) : "l"(rd23), "l"(rd393));
  // PTX:1853 ld.global.f32 %f1050, [%rd96]
  f1050 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))));
  // PTX:1854 ld.global.f32 %f1051, [%rd392]
  f1051 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd392) + (0)))));
  // PTX:1855 sub.f32 %f1052, %f1051, %f1050
  asm("sub.f32 %0, %1, %2;" : "=f"(f1052) : "f"(f1051), "f"(f1050));
  // PTX:1856 ld.global.f32 %f1053, [%rd96+4]
  f1053 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (4)))));
  // PTX:1857 ld.global.f32 %f1054, [%rd392+4]
  f1054 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd392) + (4)))));
  // PTX:1858 sub.f32 %f1055, %f1054, %f1053
  asm("sub.f32 %0, %1, %2;" : "=f"(f1055) : "f"(f1054), "f"(f1053));
  // PTX:1859 ld.global.f32 %f1056, [%rd96+8]
  f1056 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (8)))));
  // PTX:1860 ld.global.f32 %f1057, [%rd392+8]
  f1057 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd392) + (8)))));
  // PTX:1861 sub.f32 %f1058, %f1057, %f1056
  asm("sub.f32 %0, %1, %2;" : "=f"(f1058) : "f"(f1057), "f"(f1056));
  // PTX:1862 mul.f32 %f1612, %f1, %f1052
  asm("mul.f32 %0, %1, %2;" : "=f"(f1612) : "f"(f1), "f"(f1052));
  // PTX:1863 mul.f32 %f1613, %f1, %f1055
  asm("mul.f32 %0, %1, %2;" : "=f"(f1613) : "f"(f1), "f"(f1055));
  // PTX:1864 mul.f32 %f1614, %f1, %f1058
  asm("mul.f32 %0, %1, %2;" : "=f"(f1614) : "f"(f1), "f"(f1058));
  // PTX:1865 bra.uni $L__BB4_125
  goto L_BB4_125;
  // PTX:1867 $L__BB4_124:
L_BB4_124:;
  // PTX:1868 ld.f32 %f1612, [%rd97]
  f1612 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd97) + (0))));
  // PTX:1869 ld.f32 %f1613, [%rd97+4]
  f1613 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd97) + (4))));
  // PTX:1870 ld.f32 %f1614, [%rd97+8]
  f1614 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd97) + (8))));
  // PTX:1872 $L__BB4_125:
L_BB4_125:;
  // PTX:1873 cvt.s64.s32 %rd394, %r1792
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd394) : "r"(r1792));
  // PTX:1874 mul.lo.s64 %rd99, %rd394, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd99) : "l"(rd394));
  // PTX:1875 add.s64 %rd98, %rd25, %rd99
  asm("add.s64 %0, %1, %2;" : "=l"(rd98) : "l"(rd25), "l"(rd99));
  // PTX:1876 @%p115 bra $L__BB4_127
  if (p115) { goto L_BB4_127; }
  // PTX:1878 mul.wide.s32 %rd396, %r1792, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd396) : "r"(r1792));
  // PTX:1879 add.s64 %rd395, %rd23, %rd396
  asm("add.s64 %0, %1, %2;" : "=l"(rd395) : "l"(rd23), "l"(rd396));
  // PTX:1880 ld.global.f32 %f1059, [%rd98]
  f1059 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))));
  // PTX:1881 ld.global.f32 %f1060, [%rd395]
  f1060 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd395) + (0)))));
  // PTX:1882 sub.f32 %f1061, %f1060, %f1059
  asm("sub.f32 %0, %1, %2;" : "=f"(f1061) : "f"(f1060), "f"(f1059));
  // PTX:1883 ld.global.f32 %f1062, [%rd98+4]
  f1062 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (4)))));
  // PTX:1884 ld.global.f32 %f1063, [%rd395+4]
  f1063 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd395) + (4)))));
  // PTX:1885 sub.f32 %f1064, %f1063, %f1062
  asm("sub.f32 %0, %1, %2;" : "=f"(f1064) : "f"(f1063), "f"(f1062));
  // PTX:1886 ld.global.f32 %f1065, [%rd98+8]
  f1065 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (8)))));
  // PTX:1887 ld.global.f32 %f1066, [%rd395+8]
  f1066 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd395) + (8)))));
  // PTX:1888 sub.f32 %f1067, %f1066, %f1065
  asm("sub.f32 %0, %1, %2;" : "=f"(f1067) : "f"(f1066), "f"(f1065));
  // PTX:1889 mul.f32 %f1615, %f1, %f1061
  asm("mul.f32 %0, %1, %2;" : "=f"(f1615) : "f"(f1), "f"(f1061));
  // PTX:1890 mul.f32 %f1616, %f1, %f1064
  asm("mul.f32 %0, %1, %2;" : "=f"(f1616) : "f"(f1), "f"(f1064));
  // PTX:1891 mul.f32 %f1617, %f1, %f1067
  asm("mul.f32 %0, %1, %2;" : "=f"(f1617) : "f"(f1), "f"(f1067));
  // PTX:1892 bra.uni $L__BB4_128
  goto L_BB4_128;
  // PTX:1894 $L__BB4_127:
L_BB4_127:;
  // PTX:1895 ld.f32 %f1615, [%rd99]
  f1615 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd99) + (0))));
  // PTX:1896 ld.f32 %f1616, [%rd99+4]
  f1616 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd99) + (4))));
  // PTX:1897 ld.f32 %f1617, [%rd99+8]
  f1617 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd99) + (8))));
  // PTX:1899 $L__BB4_128:
L_BB4_128:;
  // PTX:1900 cvt.s64.s32 %rd397, %r1791
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd397) : "r"(r1791));
  // PTX:1901 mul.lo.s64 %rd101, %rd397, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd101) : "l"(rd397));
  // PTX:1902 add.s64 %rd100, %rd25, %rd101
  asm("add.s64 %0, %1, %2;" : "=l"(rd100) : "l"(rd25), "l"(rd101));
  // PTX:1903 @%p115 bra $L__BB4_130
  if (p115) { goto L_BB4_130; }
  // PTX:1905 mul.wide.s32 %rd377, %r1791, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd377) : "r"(r1791));
  // PTX:1906 add.s64 %rd376, %rd23, %rd377
  asm("add.s64 %0, %1, %2;" : "=l"(rd376) : "l"(rd23), "l"(rd377));
  // PTX:1907 ld.global.f32 %f1068, [%rd100]
  f1068 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))));
  // PTX:1908 ld.global.f32 %f1069, [%rd376]
  f1069 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd376) + (0)))));
  // PTX:1909 sub.f32 %f1070, %f1069, %f1068
  asm("sub.f32 %0, %1, %2;" : "=f"(f1070) : "f"(f1069), "f"(f1068));
  // PTX:1910 ld.global.f32 %f1071, [%rd100+4]
  f1071 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (4)))));
  // PTX:1911 ld.global.f32 %f1072, [%rd376+4]
  f1072 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd376) + (4)))));
  // PTX:1912 sub.f32 %f1073, %f1072, %f1071
  asm("sub.f32 %0, %1, %2;" : "=f"(f1073) : "f"(f1072), "f"(f1071));
  // PTX:1913 ld.global.f32 %f1074, [%rd100+8]
  f1074 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (8)))));
  // PTX:1914 ld.global.f32 %f1075, [%rd376+8]
  f1075 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd376) + (8)))));
  // PTX:1915 sub.f32 %f1076, %f1075, %f1074
  asm("sub.f32 %0, %1, %2;" : "=f"(f1076) : "f"(f1075), "f"(f1074));
  // PTX:1916 mul.f32 %f1618, %f1, %f1070
  asm("mul.f32 %0, %1, %2;" : "=f"(f1618) : "f"(f1), "f"(f1070));
  // PTX:1917 mul.f32 %f1619, %f1, %f1073
  asm("mul.f32 %0, %1, %2;" : "=f"(f1619) : "f"(f1), "f"(f1073));
  // PTX:1918 mul.f32 %f1620, %f1, %f1076
  asm("mul.f32 %0, %1, %2;" : "=f"(f1620) : "f"(f1), "f"(f1076));
  // PTX:1919 bra.uni $L__BB4_131
  goto L_BB4_131;
  // PTX:1921 $L__BB4_130:
L_BB4_130:;
  // PTX:1922 ld.f32 %f1618, [%rd101]
  f1618 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd101) + (0))));
  // PTX:1923 ld.f32 %f1619, [%rd101+4]
  f1619 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd101) + (4))));
  // PTX:1924 ld.f32 %f1620, [%rd101+8]
  f1620 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd101) + (8))));
  // PTX:1926 $L__BB4_131:
L_BB4_131:;
  // PTX:1927 fma.rn.f32 %f1077, %f223, %f1612, %f1609
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1077) : "f"(f223), "f"(f1612), "f"(f1609));
  // PTX:1928 fma.rn.f32 %f1078, %f223, %f1613, %f1610
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1078) : "f"(f223), "f"(f1613), "f"(f1610));
  // PTX:1929 fma.rn.f32 %f1079, %f223, %f1614, %f1611
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1079) : "f"(f223), "f"(f1614), "f"(f1611));
  // PTX:1930 fma.rn.f32 %f1080, %f224, %f1615, %f1077
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1080) : "f"(f224), "f"(f1615), "f"(f1077));
  // PTX:1931 fma.rn.f32 %f1081, %f224, %f1616, %f1078
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1081) : "f"(f224), "f"(f1616), "f"(f1078));
  // PTX:1932 fma.rn.f32 %f1082, %f224, %f1617, %f1079
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1082) : "f"(f224), "f"(f1617), "f"(f1079));
  // PTX:1933 fma.rn.f32 %f1083, %f225, %f1618, %f1080
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1083) : "f"(f225), "f"(f1618), "f"(f1080));
  // PTX:1934 fma.rn.f32 %f1084, %f225, %f1619, %f1081
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1084) : "f"(f225), "f"(f1619), "f"(f1081));
  // PTX:1935 fma.rn.f32 %f1085, %f225, %f1620, %f1082
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1085) : "f"(f225), "f"(f1620), "f"(f1082));
  // PTX:1936 add.f32 %f1086, %f220, %f1083
  asm("add.f32 %0, %1, %2;" : "=f"(f1086) : "f"(f220), "f"(f1083));
  // PTX:1937 add.f32 %f1087, %f221, %f1084
  asm("add.f32 %0, %1, %2;" : "=f"(f1087) : "f"(f221), "f"(f1084));
  // PTX:1938 add.f32 %f1088, %f222, %f1085
  asm("add.f32 %0, %1, %2;" : "=f"(f1088) : "f"(f222), "f"(f1085));
  // PTX:1939 mov.b32 %r1850, %f1086
  asm("mov.b32 %0, %1;" : "=r"(r1850) : "f"(f1086));
  // PTX:1940 mov.b32 %r1851, %f1087
  asm("mov.b32 %0, %1;" : "=r"(r1851) : "f"(f1087));
  // PTX:1941 mov.b32 %r1852, %f1088
  asm("mov.b32 %0, %1;" : "=r"(r1852) : "f"(f1088));
  // PTX:1942 ld.global.f32 %f1089, [%rd92]
  f1089 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0)))));
  // PTX:1943 sub.f32 %f262, %f217, %f1089
  asm("sub.f32 %0, %1, %2;" : "=f"(f262) : "f"(f217), "f"(f1089));
  // PTX:1944 ld.global.f32 %f1090, [%rd92+4]
  f1090 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (4)))));
  // PTX:1945 sub.f32 %f263, %f218, %f1090
  asm("sub.f32 %0, %1, %2;" : "=f"(f263) : "f"(f218), "f"(f1090));
  // PTX:1946 ld.global.f32 %f1091, [%rd92+8]
  f1091 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (8)))));
  // PTX:1947 sub.f32 %f264, %f219, %f1091
  asm("sub.f32 %0, %1, %2;" : "=f"(f264) : "f"(f219), "f"(f1091));
  // PTX:1948 @%p115 bra $L__BB4_133
  if (p115) { goto L_BB4_133; }
  // PTX:1950 mul.wide.s32 %rd380, %r1794, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd380) : "r"(r1794));
  // PTX:1951 add.s64 %rd379, %rd25, %rd380
  asm("add.s64 %0, %1, %2;" : "=l"(rd379) : "l"(rd25), "l"(rd380));
  // PTX:1952 cvt.s64.s32 %rd378, %r1794
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd378) : "r"(r1794));
  // PTX:1953 mul.lo.s64 %rd302, %rd378, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd302) : "l"(rd378));
  // PTX:1954 add.s64 %rd303, %rd23, %rd302
  asm("add.s64 %0, %1, %2;" : "=l"(rd303) : "l"(rd23), "l"(rd302));
  // PTX:1955 ld.global.f32 %f1092, [%rd379]
  f1092 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd379) + (0)))));
  // PTX:1956 ld.global.f32 %f1093, [%rd303]
  f1093 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd303) + (0)))));
  // PTX:1957 sub.f32 %f1094, %f1093, %f1092
  asm("sub.f32 %0, %1, %2;" : "=f"(f1094) : "f"(f1093), "f"(f1092));
  // PTX:1958 ld.global.f32 %f1095, [%rd379+4]
  f1095 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd379) + (4)))));
  // PTX:1959 ld.global.f32 %f1096, [%rd303+4]
  f1096 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd303) + (4)))));
  // PTX:1960 sub.f32 %f1097, %f1096, %f1095
  asm("sub.f32 %0, %1, %2;" : "=f"(f1097) : "f"(f1096), "f"(f1095));
  // PTX:1961 ld.global.f32 %f1098, [%rd379+8]
  f1098 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd379) + (8)))));
  // PTX:1962 ld.global.f32 %f1099, [%rd303+8]
  f1099 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd303) + (8)))));
  // PTX:1963 sub.f32 %f1100, %f1099, %f1098
  asm("sub.f32 %0, %1, %2;" : "=f"(f1100) : "f"(f1099), "f"(f1098));
  // PTX:1964 mul.f32 %f1621, %f1, %f1094
  asm("mul.f32 %0, %1, %2;" : "=f"(f1621) : "f"(f1), "f"(f1094));
  // PTX:1965 mul.f32 %f1622, %f1, %f1097
  asm("mul.f32 %0, %1, %2;" : "=f"(f1622) : "f"(f1), "f"(f1097));
  // PTX:1966 mul.f32 %f1623, %f1, %f1100
  asm("mul.f32 %0, %1, %2;" : "=f"(f1623) : "f"(f1), "f"(f1100));
  // PTX:1967 bra.uni $L__BB4_134
  goto L_BB4_134;
  // PTX:1969 $L__BB4_133:
L_BB4_133:;
  // PTX:1970 mul.wide.s32 %rd387, %r1794, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd387) : "r"(r1794));
  // PTX:1971 ld.f32 %f1621, [%rd387]
  f1621 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd387) + (0))));
  // PTX:1972 ld.f32 %f1622, [%rd387+4]
  f1622 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd387) + (4))));
  // PTX:1973 ld.f32 %f1623, [%rd387+8]
  f1623 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd387) + (8))));
  // PTX:1975 $L__BB4_134:
L_BB4_134:;
  // PTX:1976 @%p115 bra $L__BB4_136
  if (p115) { goto L_BB4_136; }
  // PTX:1978 mul.wide.s32 %rd382, %r1793, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd382) : "r"(r1793));
  // PTX:1979 add.s64 %rd381, %rd23, %rd382
  asm("add.s64 %0, %1, %2;" : "=l"(rd381) : "l"(rd23), "l"(rd382));
  // PTX:1980 ld.global.f32 %f1101, [%rd96]
  f1101 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))));
  // PTX:1981 ld.global.f32 %f1102, [%rd381]
  f1102 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd381) + (0)))));
  // PTX:1982 sub.f32 %f1103, %f1102, %f1101
  asm("sub.f32 %0, %1, %2;" : "=f"(f1103) : "f"(f1102), "f"(f1101));
  // PTX:1983 ld.global.f32 %f1104, [%rd96+4]
  f1104 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (4)))));
  // PTX:1984 ld.global.f32 %f1105, [%rd381+4]
  f1105 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd381) + (4)))));
  // PTX:1985 sub.f32 %f1106, %f1105, %f1104
  asm("sub.f32 %0, %1, %2;" : "=f"(f1106) : "f"(f1105), "f"(f1104));
  // PTX:1986 ld.global.f32 %f1107, [%rd96+8]
  f1107 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (8)))));
  // PTX:1987 ld.global.f32 %f1108, [%rd381+8]
  f1108 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd381) + (8)))));
  // PTX:1988 sub.f32 %f1109, %f1108, %f1107
  asm("sub.f32 %0, %1, %2;" : "=f"(f1109) : "f"(f1108), "f"(f1107));
  // PTX:1989 mul.f32 %f1624, %f1, %f1103
  asm("mul.f32 %0, %1, %2;" : "=f"(f1624) : "f"(f1), "f"(f1103));
  // PTX:1990 mul.f32 %f1625, %f1, %f1106
  asm("mul.f32 %0, %1, %2;" : "=f"(f1625) : "f"(f1), "f"(f1106));
  // PTX:1991 mul.f32 %f1626, %f1, %f1109
  asm("mul.f32 %0, %1, %2;" : "=f"(f1626) : "f"(f1), "f"(f1109));
  // PTX:1992 bra.uni $L__BB4_137
  goto L_BB4_137;
  // PTX:1994 $L__BB4_136:
L_BB4_136:;
  // PTX:1995 ld.f32 %f1624, [%rd97]
  f1624 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd97) + (0))));
  // PTX:1996 ld.f32 %f1625, [%rd97+4]
  f1625 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd97) + (4))));
  // PTX:1997 ld.f32 %f1626, [%rd97+8]
  f1626 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd97) + (8))));
  // PTX:1999 $L__BB4_137:
L_BB4_137:;
  // PTX:2000 @%p115 bra $L__BB4_139
  if (p115) { goto L_BB4_139; }
  // PTX:2002 mul.wide.s32 %rd384, %r1792, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd384) : "r"(r1792));
  // PTX:2003 add.s64 %rd383, %rd23, %rd384
  asm("add.s64 %0, %1, %2;" : "=l"(rd383) : "l"(rd23), "l"(rd384));
  // PTX:2004 ld.global.f32 %f1110, [%rd98]
  f1110 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))));
  // PTX:2005 ld.global.f32 %f1111, [%rd383]
  f1111 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd383) + (0)))));
  // PTX:2006 sub.f32 %f1112, %f1111, %f1110
  asm("sub.f32 %0, %1, %2;" : "=f"(f1112) : "f"(f1111), "f"(f1110));
  // PTX:2007 ld.global.f32 %f1113, [%rd98+4]
  f1113 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (4)))));
  // PTX:2008 ld.global.f32 %f1114, [%rd383+4]
  f1114 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd383) + (4)))));
  // PTX:2009 sub.f32 %f1115, %f1114, %f1113
  asm("sub.f32 %0, %1, %2;" : "=f"(f1115) : "f"(f1114), "f"(f1113));
  // PTX:2010 ld.global.f32 %f1116, [%rd98+8]
  f1116 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (8)))));
  // PTX:2011 ld.global.f32 %f1117, [%rd383+8]
  f1117 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd383) + (8)))));
  // PTX:2012 sub.f32 %f1118, %f1117, %f1116
  asm("sub.f32 %0, %1, %2;" : "=f"(f1118) : "f"(f1117), "f"(f1116));
  // PTX:2013 mul.f32 %f1627, %f1, %f1112
  asm("mul.f32 %0, %1, %2;" : "=f"(f1627) : "f"(f1), "f"(f1112));
  // PTX:2014 mul.f32 %f1628, %f1, %f1115
  asm("mul.f32 %0, %1, %2;" : "=f"(f1628) : "f"(f1), "f"(f1115));
  // PTX:2015 mul.f32 %f1629, %f1, %f1118
  asm("mul.f32 %0, %1, %2;" : "=f"(f1629) : "f"(f1), "f"(f1118));
  // PTX:2016 bra.uni $L__BB4_140
  goto L_BB4_140;
  // PTX:2018 $L__BB4_139:
L_BB4_139:;
  // PTX:2019 ld.f32 %f1627, [%rd99]
  f1627 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd99) + (0))));
  // PTX:2020 ld.f32 %f1628, [%rd99+4]
  f1628 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd99) + (4))));
  // PTX:2021 ld.f32 %f1629, [%rd99+8]
  f1629 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd99) + (8))));
  // PTX:2023 $L__BB4_140:
L_BB4_140:;
  // PTX:2024 @%p115 bra $L__BB4_142
  if (p115) { goto L_BB4_142; }
  // PTX:2026 mul.wide.s32 %rd386, %r1791, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd386) : "r"(r1791));
  // PTX:2027 add.s64 %rd385, %rd23, %rd386
  asm("add.s64 %0, %1, %2;" : "=l"(rd385) : "l"(rd23), "l"(rd386));
  // PTX:2028 ld.global.f32 %f1119, [%rd100]
  f1119 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))));
  // PTX:2029 ld.global.f32 %f1120, [%rd385]
  f1120 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd385) + (0)))));
  // PTX:2030 sub.f32 %f1121, %f1120, %f1119
  asm("sub.f32 %0, %1, %2;" : "=f"(f1121) : "f"(f1120), "f"(f1119));
  // PTX:2031 ld.global.f32 %f1122, [%rd100+4]
  f1122 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (4)))));
  // PTX:2032 ld.global.f32 %f1123, [%rd385+4]
  f1123 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd385) + (4)))));
  // PTX:2033 sub.f32 %f1124, %f1123, %f1122
  asm("sub.f32 %0, %1, %2;" : "=f"(f1124) : "f"(f1123), "f"(f1122));
  // PTX:2034 ld.global.f32 %f1125, [%rd100+8]
  f1125 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (8)))));
  // PTX:2035 ld.global.f32 %f1126, [%rd385+8]
  f1126 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd385) + (8)))));
  // PTX:2036 sub.f32 %f1127, %f1126, %f1125
  asm("sub.f32 %0, %1, %2;" : "=f"(f1127) : "f"(f1126), "f"(f1125));
  // PTX:2037 mul.f32 %f1630, %f1, %f1121
  asm("mul.f32 %0, %1, %2;" : "=f"(f1630) : "f"(f1), "f"(f1121));
  // PTX:2038 mul.f32 %f1631, %f1, %f1124
  asm("mul.f32 %0, %1, %2;" : "=f"(f1631) : "f"(f1), "f"(f1124));
  // PTX:2039 mul.f32 %f1632, %f1, %f1127
  asm("mul.f32 %0, %1, %2;" : "=f"(f1632) : "f"(f1), "f"(f1127));
  // PTX:2040 bra.uni $L__BB4_143
  goto L_BB4_143;
  // PTX:2042 $L__BB4_142:
L_BB4_142:;
  // PTX:2043 ld.f32 %f1630, [%rd101]
  f1630 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd101) + (0))));
  // PTX:2044 ld.f32 %f1631, [%rd101+4]
  f1631 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd101) + (4))));
  // PTX:2045 ld.f32 %f1632, [%rd101+8]
  f1632 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd101) + (8))));
  // PTX:2047 $L__BB4_143:
L_BB4_143:;
  // PTX:2048 fma.rn.f32 %f1128, %f262, %f1624, %f1621
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1128) : "f"(f262), "f"(f1624), "f"(f1621));
  // PTX:2049 fma.rn.f32 %f1129, %f262, %f1625, %f1622
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1129) : "f"(f262), "f"(f1625), "f"(f1622));
  // PTX:2050 fma.rn.f32 %f1130, %f262, %f1626, %f1623
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1130) : "f"(f262), "f"(f1626), "f"(f1623));
  // PTX:2051 fma.rn.f32 %f1131, %f263, %f1627, %f1128
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1131) : "f"(f263), "f"(f1627), "f"(f1128));
  // PTX:2052 fma.rn.f32 %f1132, %f263, %f1628, %f1129
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1132) : "f"(f263), "f"(f1628), "f"(f1129));
  // PTX:2053 fma.rn.f32 %f1133, %f263, %f1629, %f1130
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1133) : "f"(f263), "f"(f1629), "f"(f1130));
  // PTX:2054 fma.rn.f32 %f1134, %f264, %f1630, %f1131
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1134) : "f"(f264), "f"(f1630), "f"(f1131));
  // PTX:2055 fma.rn.f32 %f1135, %f264, %f1631, %f1132
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1135) : "f"(f264), "f"(f1631), "f"(f1132));
  // PTX:2056 fma.rn.f32 %f1136, %f264, %f1632, %f1133
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1136) : "f"(f264), "f"(f1632), "f"(f1133));
  // PTX:2057 add.f32 %f1137, %f220, %f1134
  asm("add.f32 %0, %1, %2;" : "=f"(f1137) : "f"(f220), "f"(f1134));
  // PTX:2058 add.f32 %f1138, %f221, %f1135
  asm("add.f32 %0, %1, %2;" : "=f"(f1138) : "f"(f221), "f"(f1135));
  // PTX:2059 add.f32 %f1139, %f222, %f1136
  asm("add.f32 %0, %1, %2;" : "=f"(f1139) : "f"(f222), "f"(f1136));
  // PTX:2060 mov.b32 %r1848, %f1137
  asm("mov.b32 %0, %1;" : "=r"(r1848) : "f"(f1137));
  // PTX:2061 mov.b32 %r1847, %f1138
  asm("mov.b32 %0, %1;" : "=r"(r1847) : "f"(f1138));
  // PTX:2062 mov.b32 %r1849, %f1139
  asm("mov.b32 %0, %1;" : "=r"(r1849) : "f"(f1139));
  // PTX:2064 $L__BB4_144:
L_BB4_144:;
  // PTX:2065 mov.b32 %f1155, %r1838
  asm("mov.b32 %0, %1;" : "=f"(f1155) : "r"(r1838));
  // PTX:2066 sub.f32 %f301, %f1574, %f1155
  asm("sub.f32 %0, %1, %2;" : "=f"(f301) : "f"(f1574), "f"(f1155));
  // PTX:2067 mov.b32 %f1156, %r1839
  asm("mov.b32 %0, %1;" : "=f"(f1156) : "r"(r1839));
  // PTX:2068 sub.f32 %f302, %f1575, %f1156
  asm("sub.f32 %0, %1, %2;" : "=f"(f302) : "f"(f1575), "f"(f1156));
  // PTX:2069 mov.b32 %f1157, %r1840
  asm("mov.b32 %0, %1;" : "=f"(f1157) : "r"(r1840));
  // PTX:2070 sub.f32 %f303, %f1576, %f1157
  asm("sub.f32 %0, %1, %2;" : "=f"(f303) : "f"(f1576), "f"(f1157));
  // PTX:2071 mov.b32 %f1158, %r1850
  asm("mov.b32 %0, %1;" : "=f"(f1158) : "r"(r1850));
  // PTX:2072 sub.f32 %f304, %f1571, %f1158
  asm("sub.f32 %0, %1, %2;" : "=f"(f304) : "f"(f1571), "f"(f1158));
  // PTX:2073 mov.b32 %f1159, %r1851
  asm("mov.b32 %0, %1;" : "=f"(f1159) : "r"(r1851));
  // PTX:2074 sub.f32 %f305, %f1572, %f1159
  asm("sub.f32 %0, %1, %2;" : "=f"(f305) : "f"(f1572), "f"(f1159));
  // PTX:2075 mov.b32 %f1160, %r1852
  asm("mov.b32 %0, %1;" : "=f"(f1160) : "r"(r1852));
  // PTX:2076 sub.f32 %f306, %f1573, %f1160
  asm("sub.f32 %0, %1, %2;" : "=f"(f306) : "f"(f1573), "f"(f1160));
  // PTX:2077 mov.b32 %f1161, %r1848
  asm("mov.b32 %0, %1;" : "=f"(f1161) : "r"(r1848));
  // PTX:2078 sub.f32 %f307, %f1571, %f1161
  asm("sub.f32 %0, %1, %2;" : "=f"(f307) : "f"(f1571), "f"(f1161));
  // PTX:2079 mov.b32 %f1162, %r1847
  asm("mov.b32 %0, %1;" : "=f"(f1162) : "r"(r1847));
  // PTX:2080 sub.f32 %f308, %f1572, %f1162
  asm("sub.f32 %0, %1, %2;" : "=f"(f308) : "f"(f1572), "f"(f1162));
  // PTX:2081 mov.b32 %f1163, %r1849
  asm("mov.b32 %0, %1;" : "=f"(f1163) : "r"(r1849));
  // PTX:2082 sub.f32 %f309, %f1573, %f1163
  asm("sub.f32 %0, %1, %2;" : "=f"(f309) : "f"(f1573), "f"(f1163));
  // PTX:2083 abs.f32 %f1164, %f301
  asm("abs.f32 %0, %1;" : "=f"(f1164) : "f"(f301));
  // PTX:2084 setp.geu.f32 %p123, %f1164, 0f7F800000
  p123 = ((isnan(((float)(f1164))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1164)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2085 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:2086 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:2087 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:2088 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:2089 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:2090 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:2091 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:2092 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:2093 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:2094 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:2095 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:2096 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:2097 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:2098 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:2099 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:2100 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:2101 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:2102 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:2103 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:2104 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:2105 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:2106 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:2107 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:2108 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:2109 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:2110 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:2111 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:2112 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:2113 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:2114 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:2115 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:2116 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:2117 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:2118 @%p123 bra $L__BB4_164
  if (p123) { goto L_BB4_164; }
  // PTX:2120 abs.f32 %f1180, %f302
  asm("abs.f32 %0, %1;" : "=f"(f1180) : "f"(f302));
  // PTX:2121 setp.geu.f32 %p124, %f1180, 0f7F800000
  p124 = ((isnan(((float)(f1180))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1180)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2122 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:2123 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:2124 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:2125 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:2126 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:2127 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:2128 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:2129 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:2130 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:2131 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:2132 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:2133 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:2134 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:2135 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:2136 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:2137 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:2138 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:2139 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:2140 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:2141 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:2142 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:2143 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:2144 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:2145 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:2146 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:2147 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:2148 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:2149 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:2150 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:2151 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:2152 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:2153 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:2154 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:2155 @%p124 bra $L__BB4_164
  if (p124) { goto L_BB4_164; }
  // PTX:2157 abs.f32 %f1196, %f303
  asm("abs.f32 %0, %1;" : "=f"(f1196) : "f"(f303));
  // PTX:2158 setp.geu.f32 %p125, %f1196, 0f7F800000
  p125 = ((isnan(((float)(f1196))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1196)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2159 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:2160 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:2161 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:2162 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:2163 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:2164 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:2165 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:2166 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:2167 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:2168 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:2169 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:2170 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:2171 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:2172 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:2173 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:2174 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:2175 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:2176 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:2177 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:2178 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:2179 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:2180 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:2181 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:2182 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:2183 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:2184 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:2185 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:2186 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:2187 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:2188 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:2189 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:2190 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:2191 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:2192 @%p125 bra $L__BB4_164
  if (p125) { goto L_BB4_164; }
  // PTX:2194 abs.f32 %f1212, %f304
  asm("abs.f32 %0, %1;" : "=f"(f1212) : "f"(f304));
  // PTX:2195 setp.geu.f32 %p126, %f1212, 0f7F800000
  p126 = ((isnan(((float)(f1212))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1212)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2196 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:2197 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:2198 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:2199 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:2200 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:2201 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:2202 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:2203 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:2204 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:2205 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:2206 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:2207 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:2208 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:2209 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:2210 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:2211 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:2212 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:2213 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:2214 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:2215 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:2216 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:2217 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:2218 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:2219 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:2220 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:2221 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:2222 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:2223 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:2224 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:2225 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:2226 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:2227 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:2228 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:2229 @%p126 bra $L__BB4_164
  if (p126) { goto L_BB4_164; }
  // PTX:2231 abs.f32 %f1228, %f305
  asm("abs.f32 %0, %1;" : "=f"(f1228) : "f"(f305));
  // PTX:2232 setp.geu.f32 %p127, %f1228, 0f7F800000
  p127 = ((isnan(((float)(f1228))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1228)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2233 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:2234 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:2235 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:2236 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:2237 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:2238 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:2239 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:2240 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:2241 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:2242 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:2243 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:2244 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:2245 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:2246 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:2247 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:2248 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:2249 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:2250 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:2251 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:2252 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:2253 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:2254 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:2255 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:2256 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:2257 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:2258 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:2259 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:2260 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:2261 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:2262 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:2263 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:2264 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:2265 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:2266 @%p127 bra $L__BB4_164
  if (p127) { goto L_BB4_164; }
  // PTX:2268 abs.f32 %f1244, %f306
  asm("abs.f32 %0, %1;" : "=f"(f1244) : "f"(f306));
  // PTX:2269 setp.geu.f32 %p128, %f1244, 0f7F800000
  p128 = ((isnan(((float)(f1244))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1244)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2270 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:2271 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:2272 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:2273 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:2274 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:2275 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:2276 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:2277 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:2278 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:2279 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:2280 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:2281 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:2282 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:2283 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:2284 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:2285 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:2286 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:2287 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:2288 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:2289 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:2290 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:2291 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:2292 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:2293 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:2294 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:2295 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:2296 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:2297 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:2298 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:2299 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:2300 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:2301 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:2302 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:2303 @%p128 bra $L__BB4_164
  if (p128) { goto L_BB4_164; }
  // PTX:2305 abs.f32 %f1260, %f307
  asm("abs.f32 %0, %1;" : "=f"(f1260) : "f"(f307));
  // PTX:2306 setp.geu.f32 %p129, %f1260, 0f7F800000
  p129 = ((isnan(((float)(f1260))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1260)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2307 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:2308 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:2309 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:2310 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:2311 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:2312 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:2313 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:2314 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:2315 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:2316 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:2317 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:2318 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:2319 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:2320 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:2321 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:2322 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:2323 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:2324 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:2325 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:2326 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:2327 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:2328 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:2329 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:2330 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:2331 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:2332 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:2333 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:2334 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:2335 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:2336 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:2337 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:2338 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:2339 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:2340 @%p129 bra $L__BB4_164
  if (p129) { goto L_BB4_164; }
  // PTX:2342 abs.f32 %f1276, %f308
  asm("abs.f32 %0, %1;" : "=f"(f1276) : "f"(f308));
  // PTX:2343 setp.geu.f32 %p130, %f1276, 0f7F800000
  p130 = ((isnan(((float)(f1276))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1276)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2344 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:2345 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:2346 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:2347 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:2348 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:2349 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:2350 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:2351 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:2352 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:2353 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:2354 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:2355 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:2356 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:2357 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:2358 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:2359 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:2360 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:2361 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:2362 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:2363 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:2364 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:2365 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:2366 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:2367 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:2368 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:2369 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:2370 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:2371 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:2372 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:2373 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:2374 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:2375 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:2376 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:2377 @%p130 bra $L__BB4_164
  if (p130) { goto L_BB4_164; }
  // PTX:2379 abs.f32 %f1292, %f309
  asm("abs.f32 %0, %1;" : "=f"(f1292) : "f"(f309));
  // PTX:2380 setp.geu.f32 %p131, %f1292, 0f7F800000
  p131 = ((isnan(((float)(f1292))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1292)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2381 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:2382 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:2383 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:2384 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:2385 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:2386 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:2387 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:2388 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:2389 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:2390 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:2391 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:2392 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:2393 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:2394 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:2395 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:2396 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:2397 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:2398 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:2399 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:2400 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:2401 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:2402 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:2403 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:2404 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:2405 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:2406 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:2407 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:2408 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:2409 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:2410 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:2411 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:2412 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:2413 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:2414 @%p131 bra $L__BB4_164
  if (p131) { goto L_BB4_164; }
  // PTX:2416 add.s64 %rd305, %rd41, %rd223
  asm("add.s64 %0, %1, %2;" : "=l"(rd305) : "l"(rd41), "l"(rd223));
  // PTX:2417 ld.global.f32 %f1308, [%rd305]
  f1308 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd305) + (0)))));
  // PTX:2418 add.f32 %f1309, %f1577, %f1308
  asm("add.f32 %0, %1, %2;" : "=f"(f1309) : "f"(f1577), "f"(f1308));
  // PTX:2419 mul.f32 %f1310, %f302, %f1607
  asm("mul.f32 %0, %1, %2;" : "=f"(f1310) : "f"(f302), "f"(f1607));
  // PTX:2420 fma.rn.f32 %f1311, %f301, %f1608, %f1310
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1311) : "f"(f301), "f"(f1608), "f"(f1310));
  // PTX:2421 fma.rn.f32 %f1312, %f303, %f1606, %f1311
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1312) : "f"(f303), "f"(f1606), "f"(f1311));
  // PTX:2422 sub.f32 %f310, %f1309, %f1312
  asm("sub.f32 %0, %1, %2;" : "=f"(f310) : "f"(f1309), "f"(f1312));
  // PTX:2423 abs.f32 %f1313, %f310
  asm("abs.f32 %0, %1;" : "=f"(f1313) : "f"(f310));
  // PTX:2424 setp.geu.f32 %p132, %f1313, 0f7F800000
  p132 = ((isnan(((float)(f1313))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1313)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2425 setp.le.f32 %p133, %f310, 0f00000000
  p133 = (!(isnan(((float)(f310))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f310)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:2426 or.pred %p134, %p132, %p133
  p134 = ((p132) || (p133));
  // PTX:2427 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:2428 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:2429 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:2430 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:2431 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:2432 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:2433 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:2434 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:2435 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:2436 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:2437 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:2438 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:2439 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:2440 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:2441 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:2442 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:2443 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:2444 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:2445 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:2446 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:2447 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:2448 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:2449 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:2450 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:2451 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:2452 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:2453 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:2454 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:2455 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:2456 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:2457 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:2458 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:2459 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:2460 @%p134 bra $L__BB4_164
  if (p134) { goto L_BB4_164; }
  // PTX:2462 add.s64 %rd307, %rd42, %rd223
  asm("add.s64 %0, %1, %2;" : "=l"(rd307) : "l"(rd42), "l"(rd223));
  // PTX:2463 ld.global.f32 %f1314, [%rd307]
  f1314 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd307) + (0)))));
  // PTX:2464 min.f32 %f311, %f406, %f1314
  asm("min.f32 %0, %1, %2;" : "=f"(f311) : "f"(f406), "f"(f1314));
  // PTX:2465 add.s64 %rd308, %rd43, %rd223
  asm("add.s64 %0, %1, %2;" : "=l"(rd308) : "l"(rd43), "l"(rd223));
  // PTX:2466 ld.global.f32 %f1315, [%rd308]
  f1315 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd308) + (0)))));
  // PTX:2467 min.f32 %f1633, %f407, %f1315
  asm("min.f32 %0, %1, %2;" : "=f"(f1633) : "f"(f407), "f"(f1315));
  // PTX:2468 setp.leu.f32 %p135, %f1578, 0f00000000
  p135 = ((isnan(((float)(f1578))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f1578)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:2469 @%p135 bra $L__BB4_156
  if (p135) { goto L_BB4_156; }
  // PTX:2471 div.rn.f32 %f1316, %f311, %f1578
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f1316) : "f"(f311), "f"(f1578));
  // PTX:2472 sqrt.rn.f32 %f1317, %f1316
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f1317) : "f"(f1316));
  // PTX:2473 add.f32 %f1318, %f1317, %f1317
  asm("add.f32 %0, %1, %2;" : "=f"(f1318) : "f"(f1317), "f"(f1317));
  // PTX:2474 min.f32 %f1633, %f1633, %f1318
  asm("min.f32 %0, %1, %2;" : "=f"(f1633) : "f"(f1633), "f"(f1318));
  // PTX:2476 $L__BB4_156:
L_BB4_156:;
  // PTX:2477 mul.f32 %f1334, %f305, %f1607
  asm("mul.f32 %0, %1, %2;" : "=f"(f1334) : "f"(f305), "f"(f1607));
  // PTX:2478 fma.rn.f32 %f1335, %f304, %f1608, %f1334
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1335) : "f"(f304), "f"(f1608), "f"(f1334));
  // PTX:2479 fma.rn.f32 %f315, %f306, %f1606, %f1335
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f315) : "f"(f306), "f"(f1606), "f"(f1335));
  // PTX:2480 abs.f32 %f1336, %f315
  asm("abs.f32 %0, %1;" : "=f"(f1336) : "f"(f315));
  // PTX:2481 setp.geu.f32 %p136, %f1336, 0f7F800000
  p136 = ((isnan(((float)(f1336))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1336)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2482 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:2483 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:2484 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:2485 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:2486 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:2487 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:2488 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:2489 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:2490 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:2491 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:2492 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:2493 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:2494 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:2495 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:2496 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:2497 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:2498 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:2499 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:2500 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:2501 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:2502 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:2503 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:2504 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:2505 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:2506 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:2507 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:2508 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:2509 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:2510 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:2511 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:2512 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:2513 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:2514 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:2515 @%p136 bra $L__BB4_164
  if (p136) { goto L_BB4_164; }
  // PTX:2517 div.rn.f32 %f1352, %f315, %f1
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f1352) : "f"(f315), "f"(f1));
  // PTX:2518 add.f32 %f1353, %f310, %f1352
  asm("add.f32 %0, %1, %2;" : "=f"(f1353) : "f"(f310), "f"(f1352));
  // PTX:2519 mov.f32 %f1351, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1351) : );
  // PTX:2520 max.f32 %f1354, %f1353, %f1351
  asm("max.f32 %0, %1, %2;" : "=f"(f1354) : "f"(f1353), "f"(f1351));
  // PTX:2521 sub.f32 %f1355, %f310, %f1354
  asm("sub.f32 %0, %1, %2;" : "=f"(f1355) : "f"(f310), "f"(f1354));
  // PTX:2522 mul.f32 %f316, %f1633, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f316) : "f"(f1633), "f"(f1));
  // PTX:2523 mul.f32 %f1356, %f316, %f1355
  asm("mul.f32 %0, %1, %2;" : "=f"(f1356) : "f"(f316), "f"(f1355));
  // PTX:2524 fma.rn.f32 %f1357, %f310, %f311, %f1356
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1357) : "f"(f310), "f"(f311), "f"(f1356));
  // PTX:2525 max.f32 %f317, %f1357, %f1351
  asm("max.f32 %0, %1, %2;" : "=f"(f317) : "f"(f1357), "f"(f1351));
  // PTX:2526 setp.le.f32 %p137, %f317, 0f00000000
  p137 = (!(isnan(((float)(f317))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f317)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:2527 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:2528 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:2529 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:2530 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:2531 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:2532 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:2533 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:2534 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:2535 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:2536 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:2537 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:2538 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:2539 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:2540 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:2541 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:2542 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:2543 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:2544 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:2545 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:2546 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:2547 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:2548 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:2549 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:2550 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:2551 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:2552 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:2553 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:2554 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:2555 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:2556 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:2557 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:2558 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:2559 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:2560 @%p137 bra $L__BB4_164
  if (p137) { goto L_BB4_164; }
  // PTX:2562 mul.f32 %f1373, %f307, %f1608
  asm("mul.f32 %0, %1, %2;" : "=f"(f1373) : "f"(f307), "f"(f1608));
  // PTX:2563 fma.rn.f32 %f1374, %f308, %f1607, %f1373
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1374) : "f"(f308), "f"(f1607), "f"(f1373));
  // PTX:2564 fma.rn.f32 %f1375, %f309, %f1606, %f1374
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1375) : "f"(f309), "f"(f1606), "f"(f1374));
  // PTX:2565 mul.f32 %f1376, %f1375, %f1608
  asm("mul.f32 %0, %1, %2;" : "=f"(f1376) : "f"(f1375), "f"(f1608));
  // PTX:2566 mul.f32 %f1377, %f1375, %f1607
  asm("mul.f32 %0, %1, %2;" : "=f"(f1377) : "f"(f1375), "f"(f1607));
  // PTX:2567 mul.f32 %f1378, %f1375, %f1606
  asm("mul.f32 %0, %1, %2;" : "=f"(f1378) : "f"(f1375), "f"(f1606));
  // PTX:2568 sub.f32 %f318, %f307, %f1376
  asm("sub.f32 %0, %1, %2;" : "=f"(f318) : "f"(f307), "f"(f1376));
  // PTX:2569 sub.f32 %f319, %f308, %f1377
  asm("sub.f32 %0, %1, %2;" : "=f"(f319) : "f"(f308), "f"(f1377));
  // PTX:2570 sub.f32 %f320, %f309, %f1378
  asm("sub.f32 %0, %1, %2;" : "=f"(f320) : "f"(f309), "f"(f1378));
  // PTX:2571 mul.f32 %f1379, %f319, %f319
  asm("mul.f32 %0, %1, %2;" : "=f"(f1379) : "f"(f319), "f"(f319));
  // PTX:2572 fma.rn.f32 %f1380, %f318, %f318, %f1379
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1380) : "f"(f318), "f"(f318), "f"(f1379));
  // PTX:2573 fma.rn.f32 %f1381, %f320, %f320, %f1380
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1381) : "f"(f320), "f"(f320), "f"(f1380));
  // PTX:2574 sqrt.rn.f32 %f321, %f1381
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f321) : "f"(f1381));
  // PTX:2575 abs.f32 %f1382, %f321
  asm("abs.f32 %0, %1;" : "=f"(f1382) : "f"(f321));
  // PTX:2576 setp.geu.f32 %p138, %f1382, 0f7F800000
  p138 = ((isnan(((float)(f1382))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f1382)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:2577 mov.u32 %r1854, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1854) : "r"(r1853));
  // PTX:2578 mov.u32 %r1855, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1855) : "r"(r1853));
  // PTX:2579 mov.u32 %r1856, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1856) : "r"(r1853));
  // PTX:2580 mov.u32 %r1857, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1857) : "r"(r1853));
  // PTX:2581 mov.u32 %r1858, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1858) : "r"(r1853));
  // PTX:2582 mov.u32 %r1859, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1859) : "r"(r1853));
  // PTX:2583 mov.u32 %r1860, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1860) : "r"(r1853));
  // PTX:2584 mov.u32 %r1861, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1861) : "r"(r1853));
  // PTX:2585 mov.u32 %r1862, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1862) : "r"(r1853));
  // PTX:2586 mov.u32 %r1863, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1863) : "r"(r1853));
  // PTX:2587 mov.u32 %r1864, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1864) : "r"(r1853));
  // PTX:2588 mov.u32 %r1865, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1865) : "r"(r1853));
  // PTX:2589 mov.u32 %r1866, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1866) : "r"(r1853));
  // PTX:2590 mov.u32 %r1867, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1867) : "r"(r1853));
  // PTX:2591 mov.u32 %r1868, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1853));
  // PTX:2592 mov.u32 %r1869, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1853));
  // PTX:2593 mov.u32 %r1870, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1853));
  // PTX:2594 mov.u32 %r1871, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1853));
  // PTX:2595 mov.u32 %r1872, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1853));
  // PTX:2596 mov.u32 %r1873, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1853));
  // PTX:2597 mov.u32 %r1874, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1853));
  // PTX:2598 mov.u32 %r1875, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1853));
  // PTX:2599 mov.u32 %r1876, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1853));
  // PTX:2600 mov.u32 %r1877, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1853));
  // PTX:2601 mov.u32 %r1878, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1853));
  // PTX:2602 mov.u32 %r1879, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1853));
  // PTX:2603 mov.u32 %r1880, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1853));
  // PTX:2604 mov.u32 %r1881, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1853));
  // PTX:2605 mov.u32 %r1882, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1853));
  // PTX:2606 mov.u32 %r1883, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1853));
  // PTX:2607 mov.u32 %r1884, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1853));
  // PTX:2608 mov.u32 %r1885, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1853));
  // PTX:2609 mov.u32 %r1886, %r1853
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1853));
  // PTX:2610 @%p138 bra $L__BB4_164
  if (p138) { goto L_BB4_164; }
  // PTX:2612 add.s64 %rd310, %rd44, %rd223
  asm("add.s64 %0, %1, %2;" : "=l"(rd310) : "l"(rd44), "l"(rd223));
  // PTX:2613 ld.global.f32 %f1384, [%rd310]
  f1384 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd310) + (0)))));
  // PTX:2614 min.f32 %f1385, %f409, %f1384
  asm("min.f32 %0, %1, %2;" : "=f"(f1385) : "f"(f409), "f"(f1384));
  // PTX:2615 mul.f32 %f322, %f317, %f1385
  asm("mul.f32 %0, %1, %2;" : "=f"(f322) : "f"(f317), "f"(f1385));
  // PTX:2616 setp.leu.f32 %p139, %f322, 0f00000000
  p139 = ((isnan(((float)(f322))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f322)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:2617 mov.f32 %f1383, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1383) : );
  // PTX:2618 mov.f32 %f1634, %f1383
  asm("mov.f32 %0, %1;" : "=f"(f1634) : "f"(f1383));
  // PTX:2619 @%p139 bra $L__BB4_161
  if (p139) { goto L_BB4_161; }
  // PTX:2621 add.s64 %rd312, %rd45, %rd223
  asm("add.s64 %0, %1, %2;" : "=l"(rd312) : "l"(rd45), "l"(rd223));
  // PTX:2622 ld.global.f32 %f1386, [%rd312]
  f1386 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd312) + (0)))));
  // PTX:2623 mov.f32 %f1387, 0f322BCC77
  asm("mov.f32 %0, 0f322BCC77;" : "=f"(f1387) : );
  // PTX:2624 max.f32 %f1388, %f321, %f1387
  asm("max.f32 %0, %1, %2;" : "=f"(f1388) : "f"(f321), "f"(f1387));
  // PTX:2625 div.rn.f32 %f1389, %f322, %f1388
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f1389) : "f"(f322), "f"(f1388));
  // PTX:2626 min.f32 %f1390, %f408, %f1386
  asm("min.f32 %0, %1, %2;" : "=f"(f1390) : "f"(f408), "f"(f1386));
  // PTX:2627 min.f32 %f1634, %f1390, %f1389
  asm("min.f32 %0, %1, %2;" : "=f"(f1634) : "f"(f1390), "f"(f1389));
  // PTX:2629 $L__BB4_161:
L_BB4_161:;
  // PTX:2630 mul.f32 %f1544, %f1606, %f1606
  asm("mul.f32 %0, %1, %2;" : "=f"(f1544) : "f"(f1606), "f"(f1606));
  // PTX:2631 mul.f32 %f1543, %f1607, %f1607
  asm("mul.f32 %0, %1, %2;" : "=f"(f1543) : "f"(f1607), "f"(f1607));
  // PTX:2632 mul.f32 %f1542, %f1608, %f1608
  asm("mul.f32 %0, %1, %2;" : "=f"(f1542) : "f"(f1608), "f"(f1608));
  // PTX:2633 mul.f32 %f1391, %f1607, %f1608
  asm("mul.f32 %0, %1, %2;" : "=f"(f1391) : "f"(f1607), "f"(f1608));
  // PTX:2634 mul.f32 %f1392, %f1606, %f1608
  asm("mul.f32 %0, %1, %2;" : "=f"(f1392) : "f"(f1606), "f"(f1608));
  // PTX:2635 mul.f32 %f1393, %f1606, %f1607
  asm("mul.f32 %0, %1, %2;" : "=f"(f1393) : "f"(f1606), "f"(f1607));
  // PTX:2636 mul.f32 %f1394, %f317, %f1608
  asm("mul.f32 %0, %1, %2;" : "=f"(f1394) : "f"(f317), "f"(f1608));
  // PTX:2637 st.local.f32 [%rd2+120], %f1394
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (120))))) = (float)(f1394);
  // PTX:2638 mul.f32 %f1395, %f317, %f1607
  asm("mul.f32 %0, %1, %2;" : "=f"(f1395) : "f"(f317), "f"(f1607));
  // PTX:2639 st.local.f32 [%rd2+124], %f1395
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (124))))) = (float)(f1395);
  // PTX:2640 mul.f32 %f1396, %f317, %f1606
  asm("mul.f32 %0, %1, %2;" : "=f"(f1396) : "f"(f317), "f"(f1606));
  // PTX:2641 st.local.f32 [%rd2+128], %f1396
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (128))))) = (float)(f1396);
  // PTX:2642 neg.f32 %f1397, %f1634
  asm("neg.f32 %0, %1;" : "=f"(f1397) : "f"(f1634));
  // PTX:2643 mul.f32 %f1398, %f318, %f1397
  asm("mul.f32 %0, %1, %2;" : "=f"(f1398) : "f"(f318), "f"(f1397));
  // PTX:2644 mul.f32 %f1399, %f319, %f1397
  asm("mul.f32 %0, %1, %2;" : "=f"(f1399) : "f"(f319), "f"(f1397));
  // PTX:2645 mul.f32 %f1400, %f320, %f1397
  asm("mul.f32 %0, %1, %2;" : "=f"(f1400) : "f"(f320), "f"(f1397));
  // PTX:2646 st.local.f32 [%rd2+132], %f1398
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (132))))) = (float)(f1398);
  // PTX:2647 st.local.f32 [%rd2+136], %f1399
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (136))))) = (float)(f1399);
  // PTX:2648 st.local.f32 [%rd2+140], %f1400
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (140))))) = (float)(f1400);
  // PTX:2649 add.f32 %f1649, %f311, %f316
  asm("add.f32 %0, %1, %2;" : "=f"(f1649) : "f"(f311), "f"(f316));
  // PTX:2650 st.local.f32 [%rd2+216], %f1649
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (216))))) = (float)(f1649);
  // PTX:2651 mul.f32 %f1401, %f1649, %f1542
  asm("mul.f32 %0, %1, %2;" : "=f"(f1401) : "f"(f1649), "f"(f1542));
  // PTX:2652 mul.f32 %f1402, %f1649, %f1391
  asm("mul.f32 %0, %1, %2;" : "=f"(f1402) : "f"(f1649), "f"(f1391));
  // PTX:2653 mul.f32 %f1403, %f1649, %f1392
  asm("mul.f32 %0, %1, %2;" : "=f"(f1403) : "f"(f1649), "f"(f1392));
  // PTX:2654 mul.f32 %f1404, %f1649, %f1543
  asm("mul.f32 %0, %1, %2;" : "=f"(f1404) : "f"(f1649), "f"(f1543));
  // PTX:2655 mul.f32 %f1405, %f1649, %f1393
  asm("mul.f32 %0, %1, %2;" : "=f"(f1405) : "f"(f1649), "f"(f1393));
  // PTX:2656 mul.f32 %f1406, %f1649, %f1544
  asm("mul.f32 %0, %1, %2;" : "=f"(f1406) : "f"(f1649), "f"(f1544));
  // PTX:2657 st.local.f32 [%rd2+144], %f1401
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (144))))) = (float)(f1401);
  // PTX:2658 st.local.f32 [%rd2+148], %f1402
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (148))))) = (float)(f1402);
  // PTX:2659 st.local.f32 [%rd2+152], %f1403
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (152))))) = (float)(f1403);
  // PTX:2660 st.local.f32 [%rd2+156], %f1402
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (156))))) = (float)(f1402);
  // PTX:2661 st.local.f32 [%rd2+160], %f1404
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (160))))) = (float)(f1404);
  // PTX:2662 st.local.f32 [%rd2+164], %f1405
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (164))))) = (float)(f1405);
  // PTX:2663 st.local.f32 [%rd2+168], %f1403
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (168))))) = (float)(f1403);
  // PTX:2664 st.local.f32 [%rd2+172], %f1405
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (172))))) = (float)(f1405);
  // PTX:2665 st.local.f32 [%rd2+176], %f1406
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (176))))) = (float)(f1406);
  // PTX:2666 mul.f32 %f1407, %f1634, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f1407) : "f"(f1634), "f"(f1));
  // PTX:2667 mov.f32 %f1408, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f1408) : );
  // PTX:2668 sub.f32 %f1409, %f1408, %f1542
  asm("sub.f32 %0, %1, %2;" : "=f"(f1409) : "f"(f1408), "f"(f1542));
  // PTX:2669 mul.f32 %f1410, %f1409, %f1407
  asm("mul.f32 %0, %1, %2;" : "=f"(f1410) : "f"(f1409), "f"(f1407));
  // PTX:2670 sub.f32 %f1412, %f1383, %f1391
  asm("sub.f32 %0, %1, %2;" : "=f"(f1412) : "f"(f1383), "f"(f1391));
  // PTX:2671 mul.f32 %f1413, %f1412, %f1407
  asm("mul.f32 %0, %1, %2;" : "=f"(f1413) : "f"(f1412), "f"(f1407));
  // PTX:2672 sub.f32 %f1414, %f1383, %f1392
  asm("sub.f32 %0, %1, %2;" : "=f"(f1414) : "f"(f1383), "f"(f1392));
  // PTX:2673 mul.f32 %f1415, %f1414, %f1407
  asm("mul.f32 %0, %1, %2;" : "=f"(f1415) : "f"(f1414), "f"(f1407));
  // PTX:2674 sub.f32 %f1416, %f1408, %f1543
  asm("sub.f32 %0, %1, %2;" : "=f"(f1416) : "f"(f1408), "f"(f1543));
  // PTX:2675 mul.f32 %f1417, %f1416, %f1407
  asm("mul.f32 %0, %1, %2;" : "=f"(f1417) : "f"(f1416), "f"(f1407));
  // PTX:2676 sub.f32 %f1418, %f1383, %f1393
  asm("sub.f32 %0, %1, %2;" : "=f"(f1418) : "f"(f1383), "f"(f1393));
  // PTX:2677 mul.f32 %f1419, %f1418, %f1407
  asm("mul.f32 %0, %1, %2;" : "=f"(f1419) : "f"(f1418), "f"(f1407));
  // PTX:2678 sub.f32 %f1420, %f1408, %f1544
  asm("sub.f32 %0, %1, %2;" : "=f"(f1420) : "f"(f1408), "f"(f1544));
  // PTX:2679 mul.f32 %f1421, %f1420, %f1407
  asm("mul.f32 %0, %1, %2;" : "=f"(f1421) : "f"(f1420), "f"(f1407));
  // PTX:2680 st.local.f32 [%rd2+180], %f1410
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (180))))) = (float)(f1410);
  // PTX:2681 st.local.f32 [%rd2+184], %f1413
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (184))))) = (float)(f1413);
  // PTX:2682 st.local.f32 [%rd2+188], %f1415
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (188))))) = (float)(f1415);
  // PTX:2683 st.local.f32 [%rd2+192], %f1413
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (192))))) = (float)(f1413);
  // PTX:2684 st.local.f32 [%rd2+196], %f1417
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (196))))) = (float)(f1417);
  // PTX:2685 st.local.f32 [%rd2+200], %f1419
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (200))))) = (float)(f1419);
  // PTX:2686 st.local.f32 [%rd2+204], %f1415
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (204))))) = (float)(f1415);
  // PTX:2687 st.local.f32 [%rd2+208], %f1419
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (208))))) = (float)(f1419);
  // PTX:2688 st.local.f32 [%rd2+212], %f1421
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (212))))) = (float)(f1421);
  // PTX:2689 mov.b32 %r1886, %f1421
  asm("mov.b32 %0, %1;" : "=r"(r1886) : "f"(f1421));
  // PTX:2690 mov.b32 %r1884, %f1417
  asm("mov.b32 %0, %1;" : "=r"(r1884) : "f"(f1417));
  // PTX:2691 mov.b32 %r1881, %f1410
  asm("mov.b32 %0, %1;" : "=r"(r1881) : "f"(f1410));
  // PTX:2692 mov.b32 %r1879, %f1405
  asm("mov.b32 %0, %1;" : "=r"(r1879) : "f"(f1405));
  // PTX:2693 mov.b32 %r1877, %f1403
  asm("mov.b32 %0, %1;" : "=r"(r1877) : "f"(f1403));
  // PTX:2694 mov.b32 %r1876, %f1402
  asm("mov.b32 %0, %1;" : "=r"(r1876) : "f"(f1402));
  // PTX:2695 mov.b32 %r1885, %f1419
  asm("mov.b32 %0, %1;" : "=r"(r1885) : "f"(f1419));
  // PTX:2696 mov.b32 %r1883, %f1415
  asm("mov.b32 %0, %1;" : "=r"(r1883) : "f"(f1415));
  // PTX:2697 mov.b32 %r1882, %f1413
  asm("mov.b32 %0, %1;" : "=r"(r1882) : "f"(f1413));
  // PTX:2698 mov.b32 %r1871, %f1396
  asm("mov.b32 %0, %1;" : "=r"(r1871) : "f"(f1396));
  // PTX:2699 mov.b32 %r1870, %f1395
  asm("mov.b32 %0, %1;" : "=r"(r1870) : "f"(f1395));
  // PTX:2700 mov.b32 %r1869, %f1394
  asm("mov.b32 %0, %1;" : "=r"(r1869) : "f"(f1394));
  // PTX:2701 mov.b32 %r1880, %f1406
  asm("mov.b32 %0, %1;" : "=r"(r1880) : "f"(f1406));
  // PTX:2702 mov.b32 %r1878, %f1404
  asm("mov.b32 %0, %1;" : "=r"(r1878) : "f"(f1404));
  // PTX:2703 mov.b32 %r1875, %f1401
  asm("mov.b32 %0, %1;" : "=r"(r1875) : "f"(f1401));
  // PTX:2704 mov.b32 %r1874, %f1400
  asm("mov.b32 %0, %1;" : "=r"(r1874) : "f"(f1400));
  // PTX:2705 mov.b32 %r1873, %f1399
  asm("mov.b32 %0, %1;" : "=r"(r1873) : "f"(f1399));
  // PTX:2706 mov.b32 %r1872, %f1398
  asm("mov.b32 %0, %1;" : "=r"(r1872) : "f"(f1398));
  // PTX:2707 ld.local.u32 %r1868, [%rd2+116]
  r1868 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116)))));
  // PTX:2708 ld.local.f32 %f1648, [%rd2+112]
  f1648 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (112)))));
  // PTX:2709 ld.local.f32 %f1647, [%rd2+108]
  f1647 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (108)))));
  // PTX:2710 ld.local.f32 %f1646, [%rd2+104]
  f1646 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (104)))));
  // PTX:2711 ld.local.f32 %f1645, [%rd2+100]
  f1645 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (100)))));
  // PTX:2712 ld.local.f32 %f1644, [%rd2+96]
  f1644 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (96)))));
  // PTX:2713 ld.local.f32 %f1643, [%rd2+92]
  f1643 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (92)))));
  // PTX:2714 ld.local.f32 %f1642, [%rd2+88]
  f1642 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (88)))));
  // PTX:2715 ld.local.u32 %r1867, [%rd2+84]
  r1867 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (84)))));
  // PTX:2716 ld.local.u32 %r1866, [%rd2+80]
  r1866 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (80)))));
  // PTX:2717 ld.local.u32 %r1865, [%rd2+76]
  r1865 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (76)))));
  // PTX:2718 ld.local.u32 %r1864, [%rd2+72]
  r1864 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (72)))));
  // PTX:2719 ld.local.u32 %r1863, [%rd2+68]
  r1863 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (68)))));
  // PTX:2720 ld.local.u32 %r1862, [%rd2+64]
  r1862 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (64)))));
  // PTX:2721 ld.local.u32 %r1861, [%rd2+60]
  r1861 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (60)))));
  // PTX:2722 ld.local.u32 %r1860, [%rd2+56]
  r1860 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56)))));
  // PTX:2723 ld.local.f32 %f1641, [%rd2+52]
  f1641 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (52)))));
  // PTX:2724 ld.local.f32 %f1640, [%rd2+48]
  f1640 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (48)))));
  // PTX:2725 ld.local.f32 %f1639, [%rd2+44]
  f1639 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (44)))));
  // PTX:2726 ld.local.f32 %f1638, [%rd2+40]
  f1638 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (40)))));
  // PTX:2727 ld.local.f32 %f1637, [%rd2+36]
  f1637 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (36)))));
  // PTX:2728 ld.local.f32 %f1636, [%rd2+32]
  f1636 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (32)))));
  // PTX:2729 ld.local.f32 %f1635, [%rd2+28]
  f1635 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (28)))));
  // PTX:2730 ld.local.u32 %r1859, [%rd2+24]
  r1859 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (24)))));
  // PTX:2731 ld.local.u32 %r1858, [%rd2+20]
  r1858 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (20)))));
  // PTX:2732 ld.local.u32 %r1857, [%rd2+16]
  r1857 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (16)))));
  // PTX:2733 ld.local.u32 %r1856, [%rd2+12]
  r1856 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (12)))));
  // PTX:2734 ld.local.u32 %r1855, [%rd2+8]
  r1855 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (8)))));
  // PTX:2735 ld.local.u32 %r1854, [%rd2+4]
  r1854 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (4)))));
  // PTX:2736 ld.local.u32 %r1853, [%rd2]
  r1853 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (0)))));
  // PTX:2737 bra.uni $L__BB4_164
  goto L_BB4_164;
  // PTX:2739 $L__BB4_2:
L_BB4_2:;
  // PTX:2740 mov.u32 %r1860, 0
  asm("mov.u32 %0, 0;" : "=r"(r1860) : );
  // PTX:2741 st.local.u32 [%rd2+56], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (56))))) = (unsigned)(r1860);
  // PTX:2742 st.local.u32 [%rd2+116], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (116))))) = (unsigned)(r1860);
  // PTX:2743 st.local.u32 [%rd2+120], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (120))))) = (unsigned)(r1860);
  // PTX:2744 st.local.u32 [%rd2+124], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (124))))) = (unsigned)(r1860);
  // PTX:2745 st.local.u32 [%rd2+128], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (128))))) = (unsigned)(r1860);
  // PTX:2746 st.local.u32 [%rd2+132], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (132))))) = (unsigned)(r1860);
  // PTX:2747 st.local.u32 [%rd2+136], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (136))))) = (unsigned)(r1860);
  // PTX:2748 st.local.u32 [%rd2+140], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (140))))) = (unsigned)(r1860);
  // PTX:2749 st.local.u32 [%rd2+144], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (144))))) = (unsigned)(r1860);
  // PTX:2750 st.local.u32 [%rd2+148], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (148))))) = (unsigned)(r1860);
  // PTX:2751 st.local.u32 [%rd2+152], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (152))))) = (unsigned)(r1860);
  // PTX:2752 st.local.u32 [%rd2+156], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (156))))) = (unsigned)(r1860);
  // PTX:2753 st.local.u32 [%rd2+160], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (160))))) = (unsigned)(r1860);
  // PTX:2754 st.local.u32 [%rd2+164], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (164))))) = (unsigned)(r1860);
  // PTX:2755 st.local.u32 [%rd2+168], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (168))))) = (unsigned)(r1860);
  // PTX:2756 st.local.u32 [%rd2+172], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (172))))) = (unsigned)(r1860);
  // PTX:2757 st.local.u32 [%rd2+176], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (176))))) = (unsigned)(r1860);
  // PTX:2758 st.local.u32 [%rd2+180], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (180))))) = (unsigned)(r1860);
  // PTX:2759 st.local.u32 [%rd2+184], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (184))))) = (unsigned)(r1860);
  // PTX:2760 st.local.u32 [%rd2+188], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (188))))) = (unsigned)(r1860);
  // PTX:2761 st.local.u32 [%rd2+192], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (192))))) = (unsigned)(r1860);
  // PTX:2762 st.local.u32 [%rd2+196], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (196))))) = (unsigned)(r1860);
  // PTX:2763 st.local.u32 [%rd2+200], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (200))))) = (unsigned)(r1860);
  // PTX:2764 st.local.u32 [%rd2+204], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (204))))) = (unsigned)(r1860);
  // PTX:2765 st.local.u32 [%rd2+208], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (208))))) = (unsigned)(r1860);
  // PTX:2766 st.local.u32 [%rd2+212], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (212))))) = (unsigned)(r1860);
  // PTX:2767 st.local.u32 [%rd2+216], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (216))))) = (unsigned)(r1860);
  // PTX:2768 setp.eq.s64 %p2, %rd36, 0
  p2 = (((long long)(rd36)) == ((long long)(0)));
  // PTX:2769 mov.f32 %f1649, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1649) : );
  // PTX:2770 @%p2 bra $L__BB4_163
  if (p2) { goto L_BB4_163; }
  // PTX:2772 setp.eq.s64 %p3, %rd13, 0
  p3 = (((long long)(rd13)) == ((long long)(0)));
  // PTX:2773 shl.b64 %rd138, %rd398, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd138) : "l"(rd398));
  // PTX:2774 add.s64 %rd48, %rd8, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd8), "l"(rd138));
  // PTX:2775 ld.global.s32 %rd49, [%rd48]
  rd49 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:2776 setp.lt.s64 %p4, %rd49, 0
  p4 = (((long long)(rd49)) < ((long long)(0)));
  // PTX:2777 or.pred %p5, %p4, %p3
  p5 = ((p4) || (p3));
  // PTX:2778 @%p5 bra $L__BB4_7
  if (p5) { goto L_BB4_7; }
  // PTX:2780 setp.le.u64 %p6, %rd9, %rd49
  p6 = (((unsigned long long)(rd9)) <= ((unsigned long long)(rd49)));
  // PTX:2781 @%p6 bra $L__BB4_7
  if (p6) { goto L_BB4_7; }
  // PTX:2783 shl.b64 %rd139, %rd49, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd139) : "l"(rd49));
  // PTX:2784 add.s64 %rd140, %rd14, %rd139
  asm("add.s64 %0, %1, %2;" : "=l"(rd140) : "l"(rd14), "l"(rd139));
  // PTX:2785 ld.global.u32 %r467, [%rd140]
  r467 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd140) + (0)))));
  // PTX:2786 setp.eq.s32 %p7, %r467, 0
  p7 = (((int)(r467)) == ((int)(0)));
  // PTX:2787 @%p7 bra $L__BB4_7
  if (p7) { goto L_BB4_7; }
  // PTX:2789 ld.local.f32 %f1648, [%rd2+112]
  f1648 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (112)))));
  // PTX:2790 ld.local.f32 %f1647, [%rd2+108]
  f1647 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (108)))));
  // PTX:2791 ld.local.f32 %f1646, [%rd2+104]
  f1646 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (104)))));
  // PTX:2792 ld.local.f32 %f1645, [%rd2+100]
  f1645 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (100)))));
  // PTX:2793 ld.local.f32 %f1644, [%rd2+96]
  f1644 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (96)))));
  // PTX:2794 ld.local.f32 %f1643, [%rd2+92]
  f1643 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (92)))));
  // PTX:2795 ld.local.f32 %f1642, [%rd2+88]
  f1642 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (88)))));
  // PTX:2796 ld.local.u32 %r1867, [%rd2+84]
  r1867 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (84)))));
  // PTX:2797 ld.local.u32 %r1866, [%rd2+80]
  r1866 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (80)))));
  // PTX:2798 ld.local.u32 %r1865, [%rd2+76]
  r1865 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (76)))));
  // PTX:2799 ld.local.u32 %r1864, [%rd2+72]
  r1864 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (72)))));
  // PTX:2800 ld.local.u32 %r1863, [%rd2+68]
  r1863 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (68)))));
  // PTX:2801 ld.local.u32 %r1862, [%rd2+64]
  r1862 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (64)))));
  // PTX:2802 ld.local.u32 %r1861, [%rd2+60]
  r1861 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (60)))));
  // PTX:2803 ld.local.f32 %f1641, [%rd2+52]
  f1641 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (52)))));
  // PTX:2804 ld.local.f32 %f1640, [%rd2+48]
  f1640 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (48)))));
  // PTX:2805 ld.local.f32 %f1639, [%rd2+44]
  f1639 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (44)))));
  // PTX:2806 ld.local.f32 %f1638, [%rd2+40]
  f1638 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (40)))));
  // PTX:2807 ld.local.f32 %f1637, [%rd2+36]
  f1637 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (36)))));
  // PTX:2808 ld.local.f32 %f1636, [%rd2+32]
  f1636 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (32)))));
  // PTX:2809 ld.local.f32 %f1635, [%rd2+28]
  f1635 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (28)))));
  // PTX:2810 ld.local.u32 %r1859, [%rd2+24]
  r1859 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (24)))));
  // PTX:2811 ld.local.u32 %r1858, [%rd2+20]
  r1858 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (20)))));
  // PTX:2812 ld.local.u32 %r1857, [%rd2+16]
  r1857 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (16)))));
  // PTX:2813 ld.local.u32 %r1856, [%rd2+12]
  r1856 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (12)))));
  // PTX:2814 ld.local.u32 %r1855, [%rd2+8]
  r1855 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (8)))));
  // PTX:2815 ld.local.u32 %r1854, [%rd2+4]
  r1854 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (4)))));
  // PTX:2816 mov.u32 %r1868, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1860));
  // PTX:2817 mov.u32 %r1869, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1860));
  // PTX:2818 mov.u32 %r1870, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1860));
  // PTX:2819 mov.u32 %r1871, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1860));
  // PTX:2820 mov.u32 %r1872, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1860));
  // PTX:2821 mov.u32 %r1873, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1860));
  // PTX:2822 mov.u32 %r1874, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1860));
  // PTX:2823 mov.u32 %r1875, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1860));
  // PTX:2824 mov.u32 %r1876, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1860));
  // PTX:2825 mov.u32 %r1877, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1860));
  // PTX:2826 mov.u32 %r1878, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1860));
  // PTX:2827 mov.u32 %r1879, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1860));
  // PTX:2828 mov.u32 %r1880, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1860));
  // PTX:2829 mov.u32 %r1881, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1860));
  // PTX:2830 mov.u32 %r1882, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1860));
  // PTX:2831 mov.u32 %r1883, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1860));
  // PTX:2832 mov.u32 %r1884, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1860));
  // PTX:2833 mov.u32 %r1885, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1860));
  // PTX:2834 mov.u32 %r1886, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1860));
  // PTX:2835 bra.uni $L__BB4_164
  goto L_BB4_164;
  // PTX:2837 $L__BB4_7:
L_BB4_7:;
  // PTX:2838 mul.lo.s64 %rd141, %rd398, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd141) : "l"(rd398));
  // PTX:2839 add.s64 %rd142, %rd10, %rd141
  asm("add.s64 %0, %1, %2;" : "=l"(rd142) : "l"(rd10), "l"(rd141));
  // PTX:2840 ld.global.u32 %r42, [%rd142+4]
  r42 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd142) + (4)))));
  // PTX:2841 cvt.s64.s32 %rd50, %r42
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd50) : "r"(r42));
  // PTX:2842 ld.global.u32 %r43, [%rd142+8]
  r43 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd142) + (8)))));
  // PTX:2843 cvt.s64.s32 %rd51, %r43
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd51) : "r"(r43));
  // PTX:2844 add.s64 %rd143, %rd11, %rd141
  asm("add.s64 %0, %1, %2;" : "=l"(rd143) : "l"(rd11), "l"(rd141));
  // PTX:2845 ld.global.f32 %f21, [%rd143]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd143) + (0)))));
  // PTX:2846 ld.global.f32 %f22, [%rd143+4]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd143) + (4)))));
  // PTX:2847 ld.global.f32 %f23, [%rd143+8]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd143) + (8)))));
  // PTX:2848 ld.global.u32 %r44, [%rd142]
  r44 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd142) + (0)))));
  // PTX:2849 setp.gt.s32 %p8, %r44, -1
  p8 = (((int)(r44)) > ((int)(-1)));
  // PTX:2850 cvt.s64.s32 %rd52, %r44
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd52) : "r"(r44));
  // PTX:2851 setp.gt.u64 %p9, %rd15, %rd52
  p9 = (((unsigned long long)(rd15)) > ((unsigned long long)(rd52)));
  // PTX:2852 and.pred %p10, %p8, %p9
  p10 = ((p8) && (p9));
  // PTX:2853 @%p10 bra $L__BB4_9
  if (p10) { goto L_BB4_9; }
  // PTX:2854 bra.uni $L__BB4_8
  goto L_BB4_8;
  // PTX:2856 $L__BB4_9:
L_BB4_9:;
  // PTX:2857 or.b64 %rd144, %rd52, %rd36
  asm("or.b64 %0, %1, %2;" : "=l"(rd144) : "l"(rd52), "l"(rd36));
  // PTX:2858 and.b64 %rd145, %rd144, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd145) : "l"(rd144));
  // PTX:2859 setp.eq.s64 %p11, %rd145, 0
  p11 = (((long long)(rd145)) == ((long long)(0)));
  // PTX:2860 @%p11 bra $L__BB4_11
  if (p11) { goto L_BB4_11; }
  // PTX:2862 div.u64 %rd399, %rd52, %rd36
  asm("div.u64 %0, %1, %2;" : "=l"(rd399) : "l"(rd52), "l"(rd36));
  // PTX:2863 bra.uni $L__BB4_12
  goto L_BB4_12;
  // PTX:2865 $L__BB4_163:
L_BB4_163:;
  // PTX:2866 ld.local.f32 %f1648, [%rd2+112]
  f1648 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (112)))));
  // PTX:2867 ld.local.f32 %f1647, [%rd2+108]
  f1647 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (108)))));
  // PTX:2868 ld.local.f32 %f1646, [%rd2+104]
  f1646 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (104)))));
  // PTX:2869 ld.local.f32 %f1645, [%rd2+100]
  f1645 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (100)))));
  // PTX:2870 ld.local.f32 %f1644, [%rd2+96]
  f1644 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (96)))));
  // PTX:2871 ld.local.f32 %f1643, [%rd2+92]
  f1643 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (92)))));
  // PTX:2872 ld.local.f32 %f1642, [%rd2+88]
  f1642 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (88)))));
  // PTX:2873 ld.local.u32 %r1867, [%rd2+84]
  r1867 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (84)))));
  // PTX:2874 ld.local.u32 %r1866, [%rd2+80]
  r1866 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (80)))));
  // PTX:2875 ld.local.u32 %r1865, [%rd2+76]
  r1865 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (76)))));
  // PTX:2876 ld.local.u32 %r1864, [%rd2+72]
  r1864 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (72)))));
  // PTX:2877 ld.local.u32 %r1863, [%rd2+68]
  r1863 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (68)))));
  // PTX:2878 ld.local.u32 %r1862, [%rd2+64]
  r1862 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (64)))));
  // PTX:2879 ld.local.u32 %r1861, [%rd2+60]
  r1861 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (60)))));
  // PTX:2880 ld.local.f32 %f1641, [%rd2+52]
  f1641 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (52)))));
  // PTX:2881 ld.local.f32 %f1640, [%rd2+48]
  f1640 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (48)))));
  // PTX:2882 ld.local.f32 %f1639, [%rd2+44]
  f1639 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (44)))));
  // PTX:2883 ld.local.f32 %f1638, [%rd2+40]
  f1638 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (40)))));
  // PTX:2884 ld.local.f32 %f1637, [%rd2+36]
  f1637 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (36)))));
  // PTX:2885 ld.local.f32 %f1636, [%rd2+32]
  f1636 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (32)))));
  // PTX:2886 ld.local.f32 %f1635, [%rd2+28]
  f1635 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (28)))));
  // PTX:2887 ld.local.u32 %r1859, [%rd2+24]
  r1859 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (24)))));
  // PTX:2888 ld.local.u32 %r1858, [%rd2+20]
  r1858 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (20)))));
  // PTX:2889 ld.local.u32 %r1857, [%rd2+16]
  r1857 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (16)))));
  // PTX:2890 ld.local.u32 %r1856, [%rd2+12]
  r1856 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (12)))));
  // PTX:2891 ld.local.u32 %r1855, [%rd2+8]
  r1855 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (8)))));
  // PTX:2892 ld.local.u32 %r1854, [%rd2+4]
  r1854 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (4)))));
  // PTX:2893 mov.u32 %r1868, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1860));
  // PTX:2894 mov.u32 %r1869, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1860));
  // PTX:2895 mov.u32 %r1870, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1860));
  // PTX:2896 mov.u32 %r1871, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1860));
  // PTX:2897 mov.u32 %r1872, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1860));
  // PTX:2898 mov.u32 %r1873, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1860));
  // PTX:2899 mov.u32 %r1874, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1860));
  // PTX:2900 mov.u32 %r1875, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1860));
  // PTX:2901 mov.u32 %r1876, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1860));
  // PTX:2902 mov.u32 %r1877, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1860));
  // PTX:2903 mov.u32 %r1878, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1860));
  // PTX:2904 mov.u32 %r1879, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1860));
  // PTX:2905 mov.u32 %r1880, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1860));
  // PTX:2906 mov.u32 %r1881, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1860));
  // PTX:2907 mov.u32 %r1882, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1860));
  // PTX:2908 mov.u32 %r1883, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1860));
  // PTX:2909 mov.u32 %r1884, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1860));
  // PTX:2910 mov.u32 %r1885, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1860));
  // PTX:2911 mov.u32 %r1886, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1860));
  // PTX:2912 bra.uni $L__BB4_164
  goto L_BB4_164;
  // PTX:2914 $L__BB4_8:
L_BB4_8:;
  // PTX:2915 ld.local.f32 %f1648, [%rd2+112]
  f1648 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (112)))));
  // PTX:2916 ld.local.f32 %f1647, [%rd2+108]
  f1647 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (108)))));
  // PTX:2917 ld.local.f32 %f1646, [%rd2+104]
  f1646 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (104)))));
  // PTX:2918 ld.local.f32 %f1645, [%rd2+100]
  f1645 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (100)))));
  // PTX:2919 ld.local.f32 %f1644, [%rd2+96]
  f1644 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (96)))));
  // PTX:2920 ld.local.f32 %f1643, [%rd2+92]
  f1643 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (92)))));
  // PTX:2921 ld.local.f32 %f1642, [%rd2+88]
  f1642 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (88)))));
  // PTX:2922 ld.local.u32 %r1867, [%rd2+84]
  r1867 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (84)))));
  // PTX:2923 ld.local.u32 %r1866, [%rd2+80]
  r1866 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (80)))));
  // PTX:2924 ld.local.u32 %r1865, [%rd2+76]
  r1865 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (76)))));
  // PTX:2925 ld.local.u32 %r1864, [%rd2+72]
  r1864 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (72)))));
  // PTX:2926 ld.local.u32 %r1863, [%rd2+68]
  r1863 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (68)))));
  // PTX:2927 ld.local.u32 %r1862, [%rd2+64]
  r1862 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (64)))));
  // PTX:2928 ld.local.u32 %r1861, [%rd2+60]
  r1861 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (60)))));
  // PTX:2929 ld.local.f32 %f1641, [%rd2+52]
  f1641 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (52)))));
  // PTX:2930 ld.local.f32 %f1640, [%rd2+48]
  f1640 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (48)))));
  // PTX:2931 ld.local.f32 %f1639, [%rd2+44]
  f1639 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (44)))));
  // PTX:2932 ld.local.f32 %f1638, [%rd2+40]
  f1638 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (40)))));
  // PTX:2933 ld.local.f32 %f1637, [%rd2+36]
  f1637 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (36)))));
  // PTX:2934 ld.local.f32 %f1636, [%rd2+32]
  f1636 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (32)))));
  // PTX:2935 ld.local.f32 %f1635, [%rd2+28]
  f1635 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (28)))));
  // PTX:2936 ld.local.u32 %r1859, [%rd2+24]
  r1859 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (24)))));
  // PTX:2937 ld.local.u32 %r1858, [%rd2+20]
  r1858 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (20)))));
  // PTX:2938 ld.local.u32 %r1857, [%rd2+16]
  r1857 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (16)))));
  // PTX:2939 ld.local.u32 %r1856, [%rd2+12]
  r1856 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (12)))));
  // PTX:2940 ld.local.u32 %r1855, [%rd2+8]
  r1855 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (8)))));
  // PTX:2941 ld.local.u32 %r1854, [%rd2+4]
  r1854 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (4)))));
  // PTX:2942 mov.u32 %r1868, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1860));
  // PTX:2943 mov.u32 %r1869, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1860));
  // PTX:2944 mov.u32 %r1870, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1860));
  // PTX:2945 mov.u32 %r1871, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1860));
  // PTX:2946 mov.u32 %r1872, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1860));
  // PTX:2947 mov.u32 %r1873, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1860));
  // PTX:2948 mov.u32 %r1874, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1860));
  // PTX:2949 mov.u32 %r1875, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1860));
  // PTX:2950 mov.u32 %r1876, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1860));
  // PTX:2951 mov.u32 %r1877, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1860));
  // PTX:2952 mov.u32 %r1878, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1860));
  // PTX:2953 mov.u32 %r1879, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1860));
  // PTX:2954 mov.u32 %r1880, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1860));
  // PTX:2955 mov.u32 %r1881, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1860));
  // PTX:2956 mov.u32 %r1882, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1860));
  // PTX:2957 mov.u32 %r1883, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1860));
  // PTX:2958 mov.u32 %r1884, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1860));
  // PTX:2959 mov.u32 %r1885, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1860));
  // PTX:2960 mov.u32 %r1886, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1860));
  // PTX:2961 bra.uni $L__BB4_164
  goto L_BB4_164;
  // PTX:2963 $L__BB4_11:
L_BB4_11:;
  // PTX:2964 cvt.u32.u64 %r469, %rd52
  asm("cvt.u32.u64 %0, %1;" : "=r"(r469) : "l"(rd52));
  // PTX:2965 div.u32 %r470, %r469, %r1
  asm("div.u32 %0, %1, %2;" : "=r"(r470) : "r"(r469), "r"(r1));
  // PTX:2966 cvt.u64.u32 %rd399, %r470
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd399) : "r"(r470));
  // PTX:2968 $L__BB4_12:
L_BB4_12:;
  // PTX:2969 cvt.u32.u64 %r85, %rd399
  asm("cvt.u32.u64 %0, %1;" : "=r"(r85) : "l"(rd399));
  // PTX:2970 setp.lt.s32 %p12, %r85, 0
  p12 = (((int)(r85)) < ((int)(0)));
  // PTX:2971 @%p12 bra $L__BB4_162
  if (p12) { goto L_BB4_162; }
  // PTX:2973 cvt.s64.s32 %rd56, %rd399
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd56) : "l"(rd399));
  // PTX:2974 setp.ge.u64 %p13, %rd56, %rd18
  p13 = (((unsigned long long)(rd56)) >= ((unsigned long long)(rd18)));
  // PTX:2975 @%p13 bra $L__BB4_162
  if (p13) { goto L_BB4_162; }
  // PTX:2977 ld.global.s32 %rd57, [%rd48]
  rd57 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:2978 setp.lt.s64 %p14, %rd57, 0
  p14 = (((long long)(rd57)) < ((long long)(0)));
  // PTX:2979 @%p14 bra $L__BB4_17
  if (p14) { goto L_BB4_17; }
  // PTX:2981 setp.gt.u64 %p15, %rd19, %rd57
  p15 = (((unsigned long long)(rd19)) > ((unsigned long long)(rd57)));
  // PTX:2982 @%p15 bra $L__BB4_18
  if (p15) { goto L_BB4_18; }
  // PTX:2983 bra.uni $L__BB4_16
  goto L_BB4_16;
  // PTX:2985 $L__BB4_18:
L_BB4_18:;
  // PTX:2986 or.b64 %rd147, %rd57, %rd17
  asm("or.b64 %0, %1, %2;" : "=l"(rd147) : "l"(rd57), "l"(rd17));
  // PTX:2987 and.b64 %rd148, %rd147, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd148) : "l"(rd147));
  // PTX:2988 setp.eq.s64 %p17, %rd148, 0
  p17 = (((long long)(rd148)) == ((long long)(0)));
  // PTX:2989 @%p17 bra $L__BB4_20
  if (p17) { goto L_BB4_20; }
  // PTX:2991 div.u64 %rd400, %rd57, %rd17
  asm("div.u64 %0, %1, %2;" : "=l"(rd400) : "l"(rd57), "l"(rd17));
  // PTX:2992 mul.lo.s64 %rd149, %rd400, %rd17
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd149) : "l"(rd400), "l"(rd17));
  // PTX:2993 sub.s64 %rd402, %rd57, %rd149
  asm("sub.s64 %0, %1, %2;" : "=l"(rd402) : "l"(rd57), "l"(rd149));
  // PTX:2994 bra.uni $L__BB4_21
  goto L_BB4_21;
  // PTX:2996 $L__BB4_162:
L_BB4_162:;
  // PTX:2997 ld.local.f32 %f1648, [%rd2+112]
  f1648 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (112)))));
  // PTX:2998 ld.local.f32 %f1647, [%rd2+108]
  f1647 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (108)))));
  // PTX:2999 ld.local.f32 %f1646, [%rd2+104]
  f1646 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (104)))));
  // PTX:3000 ld.local.f32 %f1645, [%rd2+100]
  f1645 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (100)))));
  // PTX:3001 ld.local.f32 %f1644, [%rd2+96]
  f1644 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (96)))));
  // PTX:3002 ld.local.f32 %f1643, [%rd2+92]
  f1643 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (92)))));
  // PTX:3003 ld.local.f32 %f1642, [%rd2+88]
  f1642 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (88)))));
  // PTX:3004 ld.local.u32 %r1867, [%rd2+84]
  r1867 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (84)))));
  // PTX:3005 ld.local.u32 %r1866, [%rd2+80]
  r1866 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (80)))));
  // PTX:3006 ld.local.u32 %r1865, [%rd2+76]
  r1865 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (76)))));
  // PTX:3007 ld.local.u32 %r1864, [%rd2+72]
  r1864 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (72)))));
  // PTX:3008 ld.local.u32 %r1863, [%rd2+68]
  r1863 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (68)))));
  // PTX:3009 ld.local.u32 %r1862, [%rd2+64]
  r1862 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (64)))));
  // PTX:3010 ld.local.u32 %r1861, [%rd2+60]
  r1861 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (60)))));
  // PTX:3011 ld.local.f32 %f1641, [%rd2+52]
  f1641 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (52)))));
  // PTX:3012 ld.local.f32 %f1640, [%rd2+48]
  f1640 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (48)))));
  // PTX:3013 ld.local.f32 %f1639, [%rd2+44]
  f1639 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (44)))));
  // PTX:3014 ld.local.f32 %f1638, [%rd2+40]
  f1638 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (40)))));
  // PTX:3015 ld.local.f32 %f1637, [%rd2+36]
  f1637 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (36)))));
  // PTX:3016 ld.local.f32 %f1636, [%rd2+32]
  f1636 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (32)))));
  // PTX:3017 ld.local.f32 %f1635, [%rd2+28]
  f1635 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (28)))));
  // PTX:3018 ld.local.u32 %r1859, [%rd2+24]
  r1859 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (24)))));
  // PTX:3019 ld.local.u32 %r1858, [%rd2+20]
  r1858 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (20)))));
  // PTX:3020 ld.local.u32 %r1857, [%rd2+16]
  r1857 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (16)))));
  // PTX:3021 ld.local.u32 %r1856, [%rd2+12]
  r1856 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (12)))));
  // PTX:3022 ld.local.u32 %r1855, [%rd2+8]
  r1855 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (8)))));
  // PTX:3023 ld.local.u32 %r1854, [%rd2+4]
  r1854 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (4)))));
  // PTX:3024 mov.u32 %r1868, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1860));
  // PTX:3025 mov.u32 %r1869, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1860));
  // PTX:3026 mov.u32 %r1870, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1860));
  // PTX:3027 mov.u32 %r1871, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1860));
  // PTX:3028 mov.u32 %r1872, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1860));
  // PTX:3029 mov.u32 %r1873, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1860));
  // PTX:3030 mov.u32 %r1874, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1860));
  // PTX:3031 mov.u32 %r1875, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1860));
  // PTX:3032 mov.u32 %r1876, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1860));
  // PTX:3033 mov.u32 %r1877, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1860));
  // PTX:3034 mov.u32 %r1878, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1860));
  // PTX:3035 mov.u32 %r1879, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1860));
  // PTX:3036 mov.u32 %r1880, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1860));
  // PTX:3037 mov.u32 %r1881, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1860));
  // PTX:3038 mov.u32 %r1882, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1860));
  // PTX:3039 mov.u32 %r1883, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1860));
  // PTX:3040 mov.u32 %r1884, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1860));
  // PTX:3041 mov.u32 %r1885, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1860));
  // PTX:3042 mov.u32 %r1886, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1860));
  // PTX:3043 bra.uni $L__BB4_164
  goto L_BB4_164;
  // PTX:3045 $L__BB4_16:
L_BB4_16:;
  // PTX:3046 sub.s64 %rd146, %rd57, %rd19
  asm("sub.s64 %0, %1, %2;" : "=l"(rd146) : "l"(rd57), "l"(rd19));
  // PTX:3047 add.s64 %rd402, %rd146, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd402) : "l"(rd146), "l"(rd17));
  // PTX:3048 setp.lt.u64 %p16, %rd402, %rd16
  p16 = (((unsigned long long)(rd402)) < ((unsigned long long)(rd16)));
  // PTX:3049 mov.u32 %r1789, -1
  asm("mov.u32 %0, -1;" : "=r"(r1789) : );
  // PTX:3050 @%p16 bra $L__BB4_22
  if (p16) { goto L_BB4_22; }
  // PTX:3051 bra.uni $L__BB4_17
  goto L_BB4_17;
  // PTX:3053 $L__BB4_20:
L_BB4_20:;
  // PTX:3054 cvt.u32.u64 %r472, %rd17
  asm("cvt.u32.u64 %0, %1;" : "=r"(r472) : "l"(rd17));
  // PTX:3055 cvt.u32.u64 %r473, %rd57
  asm("cvt.u32.u64 %0, %1;" : "=r"(r473) : "l"(rd57));
  // PTX:3056 div.u32 %r474, %r473, %r472
  asm("div.u32 %0, %1, %2;" : "=r"(r474) : "r"(r473), "r"(r472));
  // PTX:3057 mul.lo.s32 %r475, %r474, %r472
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r475) : "r"(r474), "r"(r472));
  // PTX:3058 sub.s32 %r476, %r473, %r475
  asm("sub.s32 %0, %1, %2;" : "=r"(r476) : "r"(r473), "r"(r475));
  // PTX:3059 cvt.u64.u32 %rd400, %r474
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd400) : "r"(r474));
  // PTX:3060 cvt.u64.u32 %rd402, %r476
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd402) : "r"(r476));
  // PTX:3062 $L__BB4_21:
L_BB4_21:;
  // PTX:3063 cvt.u32.u64 %r1789, %rd400
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1789) : "l"(rd400));
  // PTX:3065 $L__BB4_22:
L_BB4_22:;
  // PTX:3066 setp.ne.s32 %p18, %r1789, %r85
  p18 = (((int)(r1789)) != ((int)(r85)));
  // PTX:3067 setp.gt.s32 %p19, %r1789, -1
  p19 = (((int)(r1789)) > ((int)(-1)));
  // PTX:3068 and.pred %p20, %p19, %p18
  p20 = ((p19) && (p18));
  // PTX:3069 mov.f32 %f1635, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1635) : );
  // PTX:3070 mov.f32 %f1636, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1636) : );
  // PTX:3071 mov.f32 %f1637, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1637) : );
  // PTX:3072 mov.f32 %f1638, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1638) : );
  // PTX:3073 mov.f32 %f1639, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1639) : );
  // PTX:3074 mov.f32 %f1640, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1640) : );
  // PTX:3075 mov.f32 %f1641, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1641) : );
  // PTX:3076 mov.f32 %f1642, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1642) : );
  // PTX:3077 mov.f32 %f1643, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1643) : );
  // PTX:3078 mov.f32 %f1644, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1644) : );
  // PTX:3079 mov.f32 %f1645, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1645) : );
  // PTX:3080 mov.f32 %f1646, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1646) : );
  // PTX:3081 mov.f32 %f1647, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1647) : );
  // PTX:3082 mov.f32 %f1648, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1648) : );
  // PTX:3083 @%p20 bra $L__BB4_17
  if (p20) { goto L_BB4_17; }
  // PTX:3084 bra.uni $L__BB4_23
  goto L_BB4_23;
  // PTX:3086 $L__BB4_17:
L_BB4_17:;
  // PTX:3087 ld.local.f32 %f1648, [%rd2+112]
  f1648 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (112)))));
  // PTX:3088 ld.local.f32 %f1647, [%rd2+108]
  f1647 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (108)))));
  // PTX:3089 ld.local.f32 %f1646, [%rd2+104]
  f1646 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (104)))));
  // PTX:3090 ld.local.f32 %f1645, [%rd2+100]
  f1645 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (100)))));
  // PTX:3091 ld.local.f32 %f1644, [%rd2+96]
  f1644 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (96)))));
  // PTX:3092 ld.local.f32 %f1643, [%rd2+92]
  f1643 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (92)))));
  // PTX:3093 ld.local.f32 %f1642, [%rd2+88]
  f1642 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (88)))));
  // PTX:3094 ld.local.u32 %r1867, [%rd2+84]
  r1867 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (84)))));
  // PTX:3095 ld.local.u32 %r1866, [%rd2+80]
  r1866 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (80)))));
  // PTX:3096 ld.local.u32 %r1865, [%rd2+76]
  r1865 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (76)))));
  // PTX:3097 ld.local.u32 %r1864, [%rd2+72]
  r1864 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (72)))));
  // PTX:3098 ld.local.u32 %r1863, [%rd2+68]
  r1863 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (68)))));
  // PTX:3099 ld.local.u32 %r1862, [%rd2+64]
  r1862 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (64)))));
  // PTX:3100 ld.local.u32 %r1861, [%rd2+60]
  r1861 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (60)))));
  // PTX:3101 ld.local.f32 %f1641, [%rd2+52]
  f1641 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (52)))));
  // PTX:3102 ld.local.f32 %f1640, [%rd2+48]
  f1640 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (48)))));
  // PTX:3103 ld.local.f32 %f1639, [%rd2+44]
  f1639 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (44)))));
  // PTX:3104 ld.local.f32 %f1638, [%rd2+40]
  f1638 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (40)))));
  // PTX:3105 ld.local.f32 %f1637, [%rd2+36]
  f1637 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (36)))));
  // PTX:3106 ld.local.f32 %f1636, [%rd2+32]
  f1636 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (32)))));
  // PTX:3107 ld.local.f32 %f1635, [%rd2+28]
  f1635 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (28)))));
  // PTX:3108 ld.local.u32 %r1859, [%rd2+24]
  r1859 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (24)))));
  // PTX:3109 ld.local.u32 %r1858, [%rd2+20]
  r1858 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (20)))));
  // PTX:3110 ld.local.u32 %r1857, [%rd2+16]
  r1857 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (16)))));
  // PTX:3111 ld.local.u32 %r1856, [%rd2+12]
  r1856 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (12)))));
  // PTX:3112 ld.local.u32 %r1855, [%rd2+8]
  r1855 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (8)))));
  // PTX:3113 ld.local.u32 %r1854, [%rd2+4]
  r1854 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd2) + (4)))));
  // PTX:3114 mov.u32 %r1868, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1868) : "r"(r1860));
  // PTX:3115 mov.u32 %r1869, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1869) : "r"(r1860));
  // PTX:3116 mov.u32 %r1870, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1870) : "r"(r1860));
  // PTX:3117 mov.u32 %r1871, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1871) : "r"(r1860));
  // PTX:3118 mov.u32 %r1872, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1872) : "r"(r1860));
  // PTX:3119 mov.u32 %r1873, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1873) : "r"(r1860));
  // PTX:3120 mov.u32 %r1874, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1874) : "r"(r1860));
  // PTX:3121 mov.u32 %r1875, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1875) : "r"(r1860));
  // PTX:3122 mov.u32 %r1876, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1876) : "r"(r1860));
  // PTX:3123 mov.u32 %r1877, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1877) : "r"(r1860));
  // PTX:3124 mov.u32 %r1878, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1878) : "r"(r1860));
  // PTX:3125 mov.u32 %r1879, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1879) : "r"(r1860));
  // PTX:3126 mov.u32 %r1880, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1880) : "r"(r1860));
  // PTX:3127 mov.u32 %r1881, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1881) : "r"(r1860));
  // PTX:3128 mov.u32 %r1882, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1882) : "r"(r1860));
  // PTX:3129 mov.u32 %r1883, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1883) : "r"(r1860));
  // PTX:3130 mov.u32 %r1884, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1884) : "r"(r1860));
  // PTX:3131 mov.u32 %r1885, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1885) : "r"(r1860));
  // PTX:3132 mov.u32 %r1886, %r1860
  asm("mov.u32 %0, %1;" : "=r"(r1886) : "r"(r1860));
  // PTX:3134 $L__BB4_164:
L_BB4_164:;
  // PTX:3135 st.local.u32 [%rd3], %r1853
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (0))))) = (unsigned)(r1853);
  // PTX:3136 st.local.u32 [%rd3+4], %r1854
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (4))))) = (unsigned)(r1854);
  // PTX:3137 st.local.u32 [%rd3+8], %r1855
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (8))))) = (unsigned)(r1855);
  // PTX:3138 st.local.u32 [%rd3+12], %r1856
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (12))))) = (unsigned)(r1856);
  // PTX:3139 st.local.u32 [%rd3+16], %r1857
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (16))))) = (unsigned)(r1857);
  // PTX:3140 st.local.u32 [%rd3+20], %r1858
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (20))))) = (unsigned)(r1858);
  // PTX:3141 st.local.u32 [%rd3+24], %r1859
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (24))))) = (unsigned)(r1859);
  // PTX:3142 st.local.f32 [%rd3+28], %f1635
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (28))))) = (float)(f1635);
  // PTX:3143 st.local.f32 [%rd3+32], %f1636
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (32))))) = (float)(f1636);
  // PTX:3144 st.local.f32 [%rd3+36], %f1637
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (36))))) = (float)(f1637);
  // PTX:3145 st.local.f32 [%rd3+40], %f1638
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (40))))) = (float)(f1638);
  // PTX:3146 st.local.f32 [%rd3+44], %f1639
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (44))))) = (float)(f1639);
  // PTX:3147 st.local.f32 [%rd3+48], %f1640
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (48))))) = (float)(f1640);
  // PTX:3148 st.local.f32 [%rd3+52], %f1641
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (52))))) = (float)(f1641);
  // PTX:3149 st.local.u32 [%rd3+56], %r1860
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (56))))) = (unsigned)(r1860);
  // PTX:3150 st.local.u32 [%rd3+60], %r1861
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (60))))) = (unsigned)(r1861);
  // PTX:3151 st.local.u32 [%rd3+64], %r1862
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (64))))) = (unsigned)(r1862);
  // PTX:3152 st.local.u32 [%rd3+68], %r1863
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (68))))) = (unsigned)(r1863);
  // PTX:3153 st.local.u32 [%rd3+72], %r1864
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (72))))) = (unsigned)(r1864);
  // PTX:3154 st.local.u32 [%rd3+76], %r1865
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (76))))) = (unsigned)(r1865);
  // PTX:3155 st.local.u32 [%rd3+80], %r1866
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (80))))) = (unsigned)(r1866);
  // PTX:3156 st.local.u32 [%rd3+84], %r1867
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (84))))) = (unsigned)(r1867);
  // PTX:3157 st.local.f32 [%rd3+88], %f1642
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (88))))) = (float)(f1642);
  // PTX:3158 st.local.f32 [%rd3+92], %f1643
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (92))))) = (float)(f1643);
  // PTX:3159 st.local.f32 [%rd3+96], %f1644
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (96))))) = (float)(f1644);
  // PTX:3160 st.local.f32 [%rd3+100], %f1645
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (100))))) = (float)(f1645);
  // PTX:3161 st.local.f32 [%rd3+104], %f1646
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (104))))) = (float)(f1646);
  // PTX:3162 st.local.f32 [%rd3+108], %f1647
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (108))))) = (float)(f1647);
  // PTX:3163 st.local.f32 [%rd3+112], %f1648
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (112))))) = (float)(f1648);
  // PTX:3164 st.local.u32 [%rd3+116], %r1868
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (116))))) = (unsigned)(r1868);
  // PTX:3165 st.local.u32 [%rd3+120], %r1869
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (120))))) = (unsigned)(r1869);
  // PTX:3166 st.local.u32 [%rd3+124], %r1870
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (124))))) = (unsigned)(r1870);
  // PTX:3167 st.local.u32 [%rd3+128], %r1871
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (128))))) = (unsigned)(r1871);
  // PTX:3168 st.local.u32 [%rd3+132], %r1872
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (132))))) = (unsigned)(r1872);
  // PTX:3169 st.local.u32 [%rd3+136], %r1873
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (136))))) = (unsigned)(r1873);
  // PTX:3170 st.local.u32 [%rd3+140], %r1874
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (140))))) = (unsigned)(r1874);
  // PTX:3171 st.local.u32 [%rd3+144], %r1875
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (144))))) = (unsigned)(r1875);
  // PTX:3172 st.local.u32 [%rd3+148], %r1876
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (148))))) = (unsigned)(r1876);
  // PTX:3173 st.local.u32 [%rd3+152], %r1877
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (152))))) = (unsigned)(r1877);
  // PTX:3174 st.local.u32 [%rd3+156], %r1876
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (156))))) = (unsigned)(r1876);
  // PTX:3175 st.local.u32 [%rd3+160], %r1878
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (160))))) = (unsigned)(r1878);
  // PTX:3176 st.local.u32 [%rd3+164], %r1879
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (164))))) = (unsigned)(r1879);
  // PTX:3177 st.local.u32 [%rd3+168], %r1877
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (168))))) = (unsigned)(r1877);
  // PTX:3178 st.local.u32 [%rd3+172], %r1879
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (172))))) = (unsigned)(r1879);
  // PTX:3179 st.local.u32 [%rd3+176], %r1880
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (176))))) = (unsigned)(r1880);
  // PTX:3180 st.local.u32 [%rd3+180], %r1881
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (180))))) = (unsigned)(r1881);
  // PTX:3181 st.local.u32 [%rd3+184], %r1882
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (184))))) = (unsigned)(r1882);
  // PTX:3182 st.local.u32 [%rd3+188], %r1883
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (188))))) = (unsigned)(r1883);
  // PTX:3183 st.local.u32 [%rd3+192], %r1882
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (192))))) = (unsigned)(r1882);
  // PTX:3184 st.local.u32 [%rd3+196], %r1884
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (196))))) = (unsigned)(r1884);
  // PTX:3185 st.local.u32 [%rd3+200], %r1885
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (200))))) = (unsigned)(r1885);
  // PTX:3186 st.local.u32 [%rd3+204], %r1883
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (204))))) = (unsigned)(r1883);
  // PTX:3187 st.local.u32 [%rd3+208], %r1885
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (208))))) = (unsigned)(r1885);
  // PTX:3188 st.local.u32 [%rd3+212], %r1886
  (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (212))))) = (unsigned)(r1886);
  // PTX:3189 st.local.f32 [%rd3+216], %f1649
  (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd3) + (216))))) = (float)(f1649);
  // PTX:3190 setp.lt.s32 %p140, %r1860, 1
  p140 = (((int)(r1860)) < ((int)(1)));
  // PTX:3191 mov.b32 %f400, %r1869
  asm("mov.b32 %0, %1;" : "=f"(f400) : "r"(r1869));
  // PTX:3192 mov.b32 %f401, %r1870
  asm("mov.b32 %0, %1;" : "=f"(f401) : "r"(r1870));
  // PTX:3193 mov.b32 %f402, %r1871
  asm("mov.b32 %0, %1;" : "=f"(f402) : "r"(r1871));
  // PTX:3194 mov.b32 %f403, %r1872
  asm("mov.b32 %0, %1;" : "=f"(f403) : "r"(r1872));
  // PTX:3195 mov.b32 %f404, %r1873
  asm("mov.b32 %0, %1;" : "=f"(f404) : "r"(r1873));
  // PTX:3196 mov.b32 %f405, %r1874
  asm("mov.b32 %0, %1;" : "=f"(f405) : "r"(r1874));
  // PTX:3197 @%p140 bra $L__BB4_172
  if (p140) { goto L_BB4_172; }
  // PTX:3199 max.s32 %r445, %r1860, 1
  asm("max.s32 %0, %1, 1;" : "=r"(r445) : "r"(r1860));
  // PTX:3200 add.s32 %r1768, %r445, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r1768) : "r"(r445));
  // PTX:3201 and.b32 %r446, %r445, 3
  asm("and.b32 %0, %1, 3;" : "=r"(r446) : "r"(r445));
  // PTX:3202 setp.lt.u32 %p141, %r1768, 3
  p141 = (((unsigned)(r1768)) < ((unsigned)(3)));
  // PTX:3203 mov.u32 %r1889, 0
  asm("mov.u32 %0, 0;" : "=r"(r1889) : );
  // PTX:3204 @%p141 bra $L__BB4_168
  if (p141) { goto L_BB4_168; }
  // PTX:3206 sub.s32 %r1888, %r445, %r446
  asm("sub.s32 %0, %1, %2;" : "=r"(r1888) : "r"(r445), "r"(r446));
  // PTX:3207 mov.u32 %r1889, 0
  asm("mov.u32 %0, 0;" : "=r"(r1889) : );
  // PTX:3209 $L__BB4_167:
L_BB4_167:;
  // PTX:3210 mul.wide.s32 %rd313, %r1889, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd313) : "r"(r1889));
  // PTX:3211 add.s64 %rd314, %rd3, %rd313
  asm("add.s64 %0, %1, %2;" : "=l"(rd314) : "l"(rd3), "l"(rd313));
  // PTX:3212 ld.local.u32 %r1770, [%rd314]
  r1770 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd314) + (0)))));
  // PTX:3213 mul.wide.s32 %rd315, %r1770, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd315) : "r"(r1770));
  // PTX:3214 add.s64 %rd316, %rd1, %rd315
  asm("add.s64 %0, %1, %2;" : "=l"(rd316) : "l"(rd1), "l"(rd315));
  // PTX:3215 ld.local.f32 %f1422, [%rd314+28]
  f1422 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd314) + (28)))));
  // PTX:3216 mul.f32 %f1423, %f1422, %f400
  asm("mul.f32 %0, %1, %2;" : "=f"(f1423) : "f"(f1422), "f"(f400));
  // PTX:3217 mul.f32 %f1424, %f1422, %f401
  asm("mul.f32 %0, %1, %2;" : "=f"(f1424) : "f"(f1422), "f"(f401));
  // PTX:3218 mul.f32 %f1425, %f1422, %f402
  asm("mul.f32 %0, %1, %2;" : "=f"(f1425) : "f"(f1422), "f"(f402));
  // PTX:3219 red.global.add.f32 [%rd316], %f1423
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd316) + (0)))), (float)(f1423));
  // PTX:3220 add.s64 %rd317, %rd316, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd317) : "l"(rd316));
  // PTX:3221 red.global.add.f32 [%rd317], %f1424
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd317) + (0)))), (float)(f1424));
  // PTX:3222 add.s64 %rd318, %rd316, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd318) : "l"(rd316));
  // PTX:3223 red.global.add.f32 [%rd318], %f1425
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd318) + (0)))), (float)(f1425));
  // PTX:3224 ld.local.u32 %r1771, [%rd314+4]
  r1771 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd314) + (4)))));
  // PTX:3225 mul.wide.s32 %rd319, %r1771, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd319) : "r"(r1771));
  // PTX:3226 add.s64 %rd320, %rd1, %rd319
  asm("add.s64 %0, %1, %2;" : "=l"(rd320) : "l"(rd1), "l"(rd319));
  // PTX:3227 ld.local.f32 %f1429, [%rd314+32]
  f1429 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd314) + (32)))));
  // PTX:3228 mul.f32 %f1430, %f1429, %f400
  asm("mul.f32 %0, %1, %2;" : "=f"(f1430) : "f"(f1429), "f"(f400));
  // PTX:3229 mul.f32 %f1431, %f1429, %f401
  asm("mul.f32 %0, %1, %2;" : "=f"(f1431) : "f"(f1429), "f"(f401));
  // PTX:3230 mul.f32 %f1432, %f1429, %f402
  asm("mul.f32 %0, %1, %2;" : "=f"(f1432) : "f"(f1429), "f"(f402));
  // PTX:3231 red.global.add.f32 [%rd320], %f1430
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd320) + (0)))), (float)(f1430));
  // PTX:3232 add.s64 %rd321, %rd320, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd321) : "l"(rd320));
  // PTX:3233 red.global.add.f32 [%rd321], %f1431
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd321) + (0)))), (float)(f1431));
  // PTX:3234 add.s64 %rd322, %rd320, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd322) : "l"(rd320));
  // PTX:3235 red.global.add.f32 [%rd322], %f1432
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd322) + (0)))), (float)(f1432));
  // PTX:3236 ld.local.u32 %r1772, [%rd314+8]
  r1772 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd314) + (8)))));
  // PTX:3237 mul.wide.s32 %rd323, %r1772, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd323) : "r"(r1772));
  // PTX:3238 add.s64 %rd324, %rd1, %rd323
  asm("add.s64 %0, %1, %2;" : "=l"(rd324) : "l"(rd1), "l"(rd323));
  // PTX:3239 ld.local.f32 %f1436, [%rd314+36]
  f1436 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd314) + (36)))));
  // PTX:3240 mul.f32 %f1437, %f1436, %f400
  asm("mul.f32 %0, %1, %2;" : "=f"(f1437) : "f"(f1436), "f"(f400));
  // PTX:3241 mul.f32 %f1438, %f1436, %f401
  asm("mul.f32 %0, %1, %2;" : "=f"(f1438) : "f"(f1436), "f"(f401));
  // PTX:3242 mul.f32 %f1439, %f1436, %f402
  asm("mul.f32 %0, %1, %2;" : "=f"(f1439) : "f"(f1436), "f"(f402));
  // PTX:3243 red.global.add.f32 [%rd324], %f1437
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd324) + (0)))), (float)(f1437));
  // PTX:3244 add.s64 %rd325, %rd324, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd325) : "l"(rd324));
  // PTX:3245 red.global.add.f32 [%rd325], %f1438
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd325) + (0)))), (float)(f1438));
  // PTX:3246 add.s64 %rd326, %rd324, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd326) : "l"(rd324));
  // PTX:3247 red.global.add.f32 [%rd326], %f1439
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd326) + (0)))), (float)(f1439));
  // PTX:3248 ld.local.u32 %r1773, [%rd314+12]
  r1773 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd314) + (12)))));
  // PTX:3249 mul.wide.s32 %rd327, %r1773, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd327) : "r"(r1773));
  // PTX:3250 add.s64 %rd328, %rd1, %rd327
  asm("add.s64 %0, %1, %2;" : "=l"(rd328) : "l"(rd1), "l"(rd327));
  // PTX:3251 ld.local.f32 %f1443, [%rd314+40]
  f1443 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd314) + (40)))));
  // PTX:3252 mul.f32 %f1444, %f1443, %f400
  asm("mul.f32 %0, %1, %2;" : "=f"(f1444) : "f"(f1443), "f"(f400));
  // PTX:3253 mul.f32 %f1445, %f1443, %f401
  asm("mul.f32 %0, %1, %2;" : "=f"(f1445) : "f"(f1443), "f"(f401));
  // PTX:3254 mul.f32 %f1446, %f1443, %f402
  asm("mul.f32 %0, %1, %2;" : "=f"(f1446) : "f"(f1443), "f"(f402));
  // PTX:3255 red.global.add.f32 [%rd328], %f1444
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd328) + (0)))), (float)(f1444));
  // PTX:3256 add.s64 %rd329, %rd328, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd329) : "l"(rd328));
  // PTX:3257 red.global.add.f32 [%rd329], %f1445
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd329) + (0)))), (float)(f1445));
  // PTX:3258 add.s64 %rd330, %rd328, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd330) : "l"(rd328));
  // PTX:3259 red.global.add.f32 [%rd330], %f1446
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd330) + (0)))), (float)(f1446));
  // PTX:3260 add.s32 %r1889, %r1889, 4
  asm("add.s32 %0, %1, 4;" : "=r"(r1889) : "r"(r1889));
  // PTX:3261 add.s32 %r1888, %r1888, -4
  asm("add.s32 %0, %1, -4;" : "=r"(r1888) : "r"(r1888));
  // PTX:3262 setp.ne.s32 %p142, %r1888, 0
  p142 = (((int)(r1888)) != ((int)(0)));
  // PTX:3263 @%p142 bra $L__BB4_167
  if (p142) { goto L_BB4_167; }
  // PTX:3265 $L__BB4_168:
L_BB4_168:;
  // PTX:3266 setp.eq.s32 %p143, %r446, 0
  p143 = (((int)(r446)) == ((int)(0)));
  // PTX:3267 @%p143 bra $L__BB4_172
  if (p143) { goto L_BB4_172; }
  // PTX:3269 mul.wide.s32 %rd331, %r1889, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd331) : "r"(r1889));
  // PTX:3270 add.s64 %rd102, %rd3, %rd331
  asm("add.s64 %0, %1, %2;" : "=l"(rd102) : "l"(rd3), "l"(rd331));
  // PTX:3271 ld.local.u32 %r1774, [%rd102]
  r1774 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd102) + (0)))));
  // PTX:3272 mul.wide.s32 %rd332, %r1774, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd332) : "r"(r1774));
  // PTX:3273 add.s64 %rd333, %rd1, %rd332
  asm("add.s64 %0, %1, %2;" : "=l"(rd333) : "l"(rd1), "l"(rd332));
  // PTX:3274 ld.local.f32 %f1450, [%rd102+28]
  f1450 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd102) + (28)))));
  // PTX:3275 mul.f32 %f1451, %f1450, %f400
  asm("mul.f32 %0, %1, %2;" : "=f"(f1451) : "f"(f1450), "f"(f400));
  // PTX:3276 mul.f32 %f1452, %f1450, %f401
  asm("mul.f32 %0, %1, %2;" : "=f"(f1452) : "f"(f1450), "f"(f401));
  // PTX:3277 mul.f32 %f1453, %f1450, %f402
  asm("mul.f32 %0, %1, %2;" : "=f"(f1453) : "f"(f1450), "f"(f402));
  // PTX:3278 red.global.add.f32 [%rd333], %f1451
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd333) + (0)))), (float)(f1451));
  // PTX:3279 add.s64 %rd334, %rd333, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd334) : "l"(rd333));
  // PTX:3280 red.global.add.f32 [%rd334], %f1452
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd334) + (0)))), (float)(f1452));
  // PTX:3281 add.s64 %rd335, %rd333, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd335) : "l"(rd333));
  // PTX:3282 red.global.add.f32 [%rd335], %f1453
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd335) + (0)))), (float)(f1453));
  // PTX:3283 setp.eq.s32 %p144, %r446, 1
  p144 = (((int)(r446)) == ((int)(1)));
  // PTX:3284 @%p144 bra $L__BB4_172
  if (p144) { goto L_BB4_172; }
  // PTX:3286 ld.local.u32 %r1775, [%rd102+4]
  r1775 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd102) + (4)))));
  // PTX:3287 mul.wide.s32 %rd336, %r1775, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd336) : "r"(r1775));
  // PTX:3288 add.s64 %rd337, %rd1, %rd336
  asm("add.s64 %0, %1, %2;" : "=l"(rd337) : "l"(rd1), "l"(rd336));
  // PTX:3289 ld.local.f32 %f1457, [%rd102+32]
  f1457 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd102) + (32)))));
  // PTX:3290 mul.f32 %f1458, %f1457, %f400
  asm("mul.f32 %0, %1, %2;" : "=f"(f1458) : "f"(f1457), "f"(f400));
  // PTX:3291 mul.f32 %f1459, %f1457, %f401
  asm("mul.f32 %0, %1, %2;" : "=f"(f1459) : "f"(f1457), "f"(f401));
  // PTX:3292 mul.f32 %f1460, %f1457, %f402
  asm("mul.f32 %0, %1, %2;" : "=f"(f1460) : "f"(f1457), "f"(f402));
  // PTX:3293 red.global.add.f32 [%rd337], %f1458
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd337) + (0)))), (float)(f1458));
  // PTX:3294 add.s64 %rd338, %rd337, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd338) : "l"(rd337));
  // PTX:3295 red.global.add.f32 [%rd338], %f1459
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd338) + (0)))), (float)(f1459));
  // PTX:3296 add.s64 %rd339, %rd337, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd339) : "l"(rd337));
  // PTX:3297 red.global.add.f32 [%rd339], %f1460
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd339) + (0)))), (float)(f1460));
  // PTX:3298 setp.eq.s32 %p145, %r446, 2
  p145 = (((int)(r446)) == ((int)(2)));
  // PTX:3299 @%p145 bra $L__BB4_172
  if (p145) { goto L_BB4_172; }
  // PTX:3301 ld.local.u32 %r1776, [%rd102+8]
  r1776 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd102) + (8)))));
  // PTX:3302 mul.wide.s32 %rd340, %r1776, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd340) : "r"(r1776));
  // PTX:3303 add.s64 %rd341, %rd1, %rd340
  asm("add.s64 %0, %1, %2;" : "=l"(rd341) : "l"(rd1), "l"(rd340));
  // PTX:3304 ld.local.f32 %f1464, [%rd102+36]
  f1464 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd102) + (36)))));
  // PTX:3305 mul.f32 %f1465, %f1464, %f400
  asm("mul.f32 %0, %1, %2;" : "=f"(f1465) : "f"(f1464), "f"(f400));
  // PTX:3306 mul.f32 %f1466, %f1464, %f401
  asm("mul.f32 %0, %1, %2;" : "=f"(f1466) : "f"(f1464), "f"(f401));
  // PTX:3307 mul.f32 %f1467, %f1464, %f402
  asm("mul.f32 %0, %1, %2;" : "=f"(f1467) : "f"(f1464), "f"(f402));
  // PTX:3308 red.global.add.f32 [%rd341], %f1465
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd341) + (0)))), (float)(f1465));
  // PTX:3309 add.s64 %rd342, %rd341, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd342) : "l"(rd341));
  // PTX:3310 red.global.add.f32 [%rd342], %f1466
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd342) + (0)))), (float)(f1466));
  // PTX:3311 add.s64 %rd343, %rd341, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd343) : "l"(rd341));
  // PTX:3312 red.global.add.f32 [%rd343], %f1467
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd343) + (0)))), (float)(f1467));
  // PTX:3314 $L__BB4_172:
L_BB4_172:;
  // PTX:3315 setp.lt.s32 %p146, %r1868, 1
  p146 = (((int)(r1868)) < ((int)(1)));
  // PTX:3316 @%p146 bra $L__BB4_180
  if (p146) { goto L_BB4_180; }
  // PTX:3318 add.s32 %r1778, %r1868, -1
  asm("add.s32 %0, %1, -1;" : "=r"(r1778) : "r"(r1868));
  // PTX:3319 and.b32 %r453, %r1868, 3
  asm("and.b32 %0, %1, 3;" : "=r"(r453) : "r"(r1868));
  // PTX:3320 setp.lt.u32 %p147, %r1778, 3
  p147 = (((unsigned)(r1778)) < ((unsigned)(3)));
  // PTX:3321 mov.u32 %r1892, 0
  asm("mov.u32 %0, 0;" : "=r"(r1892) : );
  // PTX:3322 @%p147 bra $L__BB4_176
  if (p147) { goto L_BB4_176; }
  // PTX:3324 sub.s32 %r1891, %r1868, %r453
  asm("sub.s32 %0, %1, %2;" : "=r"(r1891) : "r"(r1868), "r"(r453));
  // PTX:3325 mov.u32 %r1892, 0
  asm("mov.u32 %0, 0;" : "=r"(r1892) : );
  // PTX:3327 $L__BB4_175:
L_BB4_175:;
  // PTX:3328 mul.wide.s32 %rd344, %r1892, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd344) : "r"(r1892));
  // PTX:3329 add.s64 %rd345, %rd3, %rd344
  asm("add.s64 %0, %1, %2;" : "=l"(rd345) : "l"(rd3), "l"(rd344));
  // PTX:3330 ld.local.u32 %r1780, [%rd345+60]
  r1780 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd345) + (60)))));
  // PTX:3331 mul.wide.s32 %rd346, %r1780, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd346) : "r"(r1780));
  // PTX:3332 add.s64 %rd347, %rd1, %rd346
  asm("add.s64 %0, %1, %2;" : "=l"(rd347) : "l"(rd1), "l"(rd346));
  // PTX:3333 ld.local.f32 %f1471, [%rd345+88]
  f1471 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd345) + (88)))));
  // PTX:3334 mul.f32 %f1472, %f1471, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f1472) : "f"(f1471), "f"(f403));
  // PTX:3335 mul.f32 %f1473, %f1471, %f404
  asm("mul.f32 %0, %1, %2;" : "=f"(f1473) : "f"(f1471), "f"(f404));
  // PTX:3336 mul.f32 %f1474, %f1471, %f405
  asm("mul.f32 %0, %1, %2;" : "=f"(f1474) : "f"(f1471), "f"(f405));
  // PTX:3337 red.global.add.f32 [%rd347], %f1472
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd347) + (0)))), (float)(f1472));
  // PTX:3338 add.s64 %rd348, %rd347, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd348) : "l"(rd347));
  // PTX:3339 red.global.add.f32 [%rd348], %f1473
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd348) + (0)))), (float)(f1473));
  // PTX:3340 add.s64 %rd349, %rd347, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd349) : "l"(rd347));
  // PTX:3341 red.global.add.f32 [%rd349], %f1474
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd349) + (0)))), (float)(f1474));
  // PTX:3342 ld.local.u32 %r1781, [%rd345+64]
  r1781 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd345) + (64)))));
  // PTX:3343 mul.wide.s32 %rd350, %r1781, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd350) : "r"(r1781));
  // PTX:3344 add.s64 %rd351, %rd1, %rd350
  asm("add.s64 %0, %1, %2;" : "=l"(rd351) : "l"(rd1), "l"(rd350));
  // PTX:3345 ld.local.f32 %f1478, [%rd345+92]
  f1478 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd345) + (92)))));
  // PTX:3346 mul.f32 %f1479, %f1478, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f1479) : "f"(f1478), "f"(f403));
  // PTX:3347 mul.f32 %f1480, %f1478, %f404
  asm("mul.f32 %0, %1, %2;" : "=f"(f1480) : "f"(f1478), "f"(f404));
  // PTX:3348 mul.f32 %f1481, %f1478, %f405
  asm("mul.f32 %0, %1, %2;" : "=f"(f1481) : "f"(f1478), "f"(f405));
  // PTX:3349 red.global.add.f32 [%rd351], %f1479
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd351) + (0)))), (float)(f1479));
  // PTX:3350 add.s64 %rd352, %rd351, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd352) : "l"(rd351));
  // PTX:3351 red.global.add.f32 [%rd352], %f1480
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd352) + (0)))), (float)(f1480));
  // PTX:3352 add.s64 %rd353, %rd351, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd353) : "l"(rd351));
  // PTX:3353 red.global.add.f32 [%rd353], %f1481
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd353) + (0)))), (float)(f1481));
  // PTX:3354 ld.local.u32 %r1782, [%rd345+68]
  r1782 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd345) + (68)))));
  // PTX:3355 mul.wide.s32 %rd354, %r1782, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd354) : "r"(r1782));
  // PTX:3356 add.s64 %rd355, %rd1, %rd354
  asm("add.s64 %0, %1, %2;" : "=l"(rd355) : "l"(rd1), "l"(rd354));
  // PTX:3357 ld.local.f32 %f1485, [%rd345+96]
  f1485 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd345) + (96)))));
  // PTX:3358 mul.f32 %f1486, %f1485, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f1486) : "f"(f1485), "f"(f403));
  // PTX:3359 mul.f32 %f1487, %f1485, %f404
  asm("mul.f32 %0, %1, %2;" : "=f"(f1487) : "f"(f1485), "f"(f404));
  // PTX:3360 mul.f32 %f1488, %f1485, %f405
  asm("mul.f32 %0, %1, %2;" : "=f"(f1488) : "f"(f1485), "f"(f405));
  // PTX:3361 red.global.add.f32 [%rd355], %f1486
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd355) + (0)))), (float)(f1486));
  // PTX:3362 add.s64 %rd356, %rd355, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd356) : "l"(rd355));
  // PTX:3363 red.global.add.f32 [%rd356], %f1487
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd356) + (0)))), (float)(f1487));
  // PTX:3364 add.s64 %rd357, %rd355, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd357) : "l"(rd355));
  // PTX:3365 red.global.add.f32 [%rd357], %f1488
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd357) + (0)))), (float)(f1488));
  // PTX:3366 ld.local.u32 %r1783, [%rd345+72]
  r1783 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd345) + (72)))));
  // PTX:3367 mul.wide.s32 %rd358, %r1783, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd358) : "r"(r1783));
  // PTX:3368 add.s64 %rd359, %rd1, %rd358
  asm("add.s64 %0, %1, %2;" : "=l"(rd359) : "l"(rd1), "l"(rd358));
  // PTX:3369 ld.local.f32 %f1492, [%rd345+100]
  f1492 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd345) + (100)))));
  // PTX:3370 mul.f32 %f1493, %f1492, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f1493) : "f"(f1492), "f"(f403));
  // PTX:3371 mul.f32 %f1494, %f1492, %f404
  asm("mul.f32 %0, %1, %2;" : "=f"(f1494) : "f"(f1492), "f"(f404));
  // PTX:3372 mul.f32 %f1495, %f1492, %f405
  asm("mul.f32 %0, %1, %2;" : "=f"(f1495) : "f"(f1492), "f"(f405));
  // PTX:3373 red.global.add.f32 [%rd359], %f1493
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd359) + (0)))), (float)(f1493));
  // PTX:3374 add.s64 %rd360, %rd359, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd360) : "l"(rd359));
  // PTX:3375 red.global.add.f32 [%rd360], %f1494
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd360) + (0)))), (float)(f1494));
  // PTX:3376 add.s64 %rd361, %rd359, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd361) : "l"(rd359));
  // PTX:3377 red.global.add.f32 [%rd361], %f1495
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd361) + (0)))), (float)(f1495));
  // PTX:3378 add.s32 %r1892, %r1892, 4
  asm("add.s32 %0, %1, 4;" : "=r"(r1892) : "r"(r1892));
  // PTX:3379 add.s32 %r1891, %r1891, -4
  asm("add.s32 %0, %1, -4;" : "=r"(r1891) : "r"(r1891));
  // PTX:3380 setp.ne.s32 %p148, %r1891, 0
  p148 = (((int)(r1891)) != ((int)(0)));
  // PTX:3381 @%p148 bra $L__BB4_175
  if (p148) { goto L_BB4_175; }
  // PTX:3383 $L__BB4_176:
L_BB4_176:;
  // PTX:3384 setp.eq.s32 %p149, %r453, 0
  p149 = (((int)(r453)) == ((int)(0)));
  // PTX:3385 @%p149 bra $L__BB4_180
  if (p149) { goto L_BB4_180; }
  // PTX:3387 mul.wide.s32 %rd362, %r1892, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd362) : "r"(r1892));
  // PTX:3388 add.s64 %rd363, %rd3, %rd362
  asm("add.s64 %0, %1, %2;" : "=l"(rd363) : "l"(rd3), "l"(rd362));
  // PTX:3389 add.s64 %rd103, %rd363, 60
  asm("add.s64 %0, %1, 60;" : "=l"(rd103) : "l"(rd363));
  // PTX:3390 ld.local.u32 %r1784, [%rd363+60]
  r1784 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd363) + (60)))));
  // PTX:3391 mul.wide.s32 %rd364, %r1784, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd364) : "r"(r1784));
  // PTX:3392 add.s64 %rd365, %rd1, %rd364
  asm("add.s64 %0, %1, %2;" : "=l"(rd365) : "l"(rd1), "l"(rd364));
  // PTX:3393 ld.local.f32 %f1499, [%rd363+88]
  f1499 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd363) + (88)))));
  // PTX:3394 mul.f32 %f1500, %f1499, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f1500) : "f"(f1499), "f"(f403));
  // PTX:3395 mul.f32 %f1501, %f1499, %f404
  asm("mul.f32 %0, %1, %2;" : "=f"(f1501) : "f"(f1499), "f"(f404));
  // PTX:3396 mul.f32 %f1502, %f1499, %f405
  asm("mul.f32 %0, %1, %2;" : "=f"(f1502) : "f"(f1499), "f"(f405));
  // PTX:3397 red.global.add.f32 [%rd365], %f1500
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd365) + (0)))), (float)(f1500));
  // PTX:3398 add.s64 %rd366, %rd365, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd366) : "l"(rd365));
  // PTX:3399 red.global.add.f32 [%rd366], %f1501
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd366) + (0)))), (float)(f1501));
  // PTX:3400 add.s64 %rd367, %rd365, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd367) : "l"(rd365));
  // PTX:3401 red.global.add.f32 [%rd367], %f1502
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd367) + (0)))), (float)(f1502));
  // PTX:3402 setp.eq.s32 %p150, %r453, 1
  p150 = (((int)(r453)) == ((int)(1)));
  // PTX:3403 @%p150 bra $L__BB4_180
  if (p150) { goto L_BB4_180; }
  // PTX:3405 ld.local.u32 %r1785, [%rd103+4]
  r1785 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd103) + (4)))));
  // PTX:3406 mul.wide.s32 %rd368, %r1785, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd368) : "r"(r1785));
  // PTX:3407 add.s64 %rd369, %rd1, %rd368
  asm("add.s64 %0, %1, %2;" : "=l"(rd369) : "l"(rd1), "l"(rd368));
  // PTX:3408 ld.local.f32 %f1506, [%rd103+32]
  f1506 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd103) + (32)))));
  // PTX:3409 mul.f32 %f1507, %f1506, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f1507) : "f"(f1506), "f"(f403));
  // PTX:3410 mul.f32 %f1508, %f1506, %f404
  asm("mul.f32 %0, %1, %2;" : "=f"(f1508) : "f"(f1506), "f"(f404));
  // PTX:3411 mul.f32 %f1509, %f1506, %f405
  asm("mul.f32 %0, %1, %2;" : "=f"(f1509) : "f"(f1506), "f"(f405));
  // PTX:3412 red.global.add.f32 [%rd369], %f1507
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd369) + (0)))), (float)(f1507));
  // PTX:3413 add.s64 %rd370, %rd369, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd370) : "l"(rd369));
  // PTX:3414 red.global.add.f32 [%rd370], %f1508
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd370) + (0)))), (float)(f1508));
  // PTX:3415 add.s64 %rd371, %rd369, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd371) : "l"(rd369));
  // PTX:3416 red.global.add.f32 [%rd371], %f1509
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd371) + (0)))), (float)(f1509));
  // PTX:3417 setp.eq.s32 %p151, %r453, 2
  p151 = (((int)(r453)) == ((int)(2)));
  // PTX:3418 @%p151 bra $L__BB4_180
  if (p151) { goto L_BB4_180; }
  // PTX:3420 ld.local.u32 %r1786, [%rd103+8]
  r1786 = (*reinterpret_cast<volatile unsigned*>(__cvta_local_to_generic(((uintptr_t)(rd103) + (8)))));
  // PTX:3421 mul.wide.s32 %rd372, %r1786, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd372) : "r"(r1786));
  // PTX:3422 add.s64 %rd373, %rd1, %rd372
  asm("add.s64 %0, %1, %2;" : "=l"(rd373) : "l"(rd1), "l"(rd372));
  // PTX:3423 ld.local.f32 %f1513, [%rd103+36]
  f1513 = (*reinterpret_cast<volatile float*>(__cvta_local_to_generic(((uintptr_t)(rd103) + (36)))));
  // PTX:3424 mul.f32 %f1514, %f1513, %f403
  asm("mul.f32 %0, %1, %2;" : "=f"(f1514) : "f"(f1513), "f"(f403));
  // PTX:3425 mul.f32 %f1515, %f1513, %f404
  asm("mul.f32 %0, %1, %2;" : "=f"(f1515) : "f"(f1513), "f"(f404));
  // PTX:3426 mul.f32 %f1516, %f1513, %f405
  asm("mul.f32 %0, %1, %2;" : "=f"(f1516) : "f"(f1513), "f"(f405));
  // PTX:3427 red.global.add.f32 [%rd373], %f1514
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd373) + (0)))), (float)(f1514));
  // PTX:3428 add.s64 %rd374, %rd373, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd374) : "l"(rd373));
  // PTX:3429 red.global.add.f32 [%rd374], %f1515
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd374) + (0)))), (float)(f1515));
  // PTX:3430 add.s64 %rd375, %rd373, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd375) : "l"(rd373));
  // PTX:3431 red.global.add.f32 [%rd375], %f1516
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd375) + (0)))), (float)(f1516));
  // PTX:3433 $L__BB4_180:
L_BB4_180:;
  // PTX:3434 add.s64 %rd398, %rd398, %rd12
  asm("add.s64 %0, %1, %2;" : "=l"(rd398) : "l"(rd398), "l"(rd12));
  // PTX:3435 setp.lt.u64 %p152, %rd398, %rd5
  p152 = (((unsigned long long)(rd398)) < ((unsigned long long)(rd5)));
  // PTX:3436 @%p152 bra $L__BB4_2
  if (p152) { goto L_BB4_2; }
  // PTX:3438 $L__BB4_181:
L_BB4_181:;
  // PTX:3439 ret
  return;
}
