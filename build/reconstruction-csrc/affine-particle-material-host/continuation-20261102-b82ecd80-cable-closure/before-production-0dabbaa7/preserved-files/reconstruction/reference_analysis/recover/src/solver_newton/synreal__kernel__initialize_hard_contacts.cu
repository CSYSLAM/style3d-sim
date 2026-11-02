// 机械还原自 PTX：synreal::kernel::initialize_hard_contacts(synreal::kernel::HardContactView)
// PTX SHA256: 9139e154bef83406dc714bb0b0584c06339ea266c32dc7857ac33f428d326654
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__initialize_hard_contacts(ByVal<312, 8> param0) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62, p63, p64, p65, p66, p67, p68, p69, p70, p71, p72, p73, p74, p75, p76, p77, p78, p79, p80, p81, p82, p83, p84, p85, p86, p87, p88, p89, p90, p91, p92, p93, p94, p95, p96, p97, p98, p99, p100, p101, p102, p103, p104, p105, p106, p107, p108, p109, p110, p111, p112, p113, p114, p115, p116, p117, p118, p119, p120, p121, p122, p123, p124, p125, p126, p127, p128, p129, p130, p131, p132, p133, p134, p135, p136, p137, p138, p139, p140, p141, p142, p143, p144, p145, p146, p147, p148, p149, p150;
  unsigned short rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8, rs9, rs10;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242, f243, f244, f245, f246, f247, f248, f249, f250, f251, f252, f253, f254, f255, f256, f257, f258, f259, f260, f261, f262, f263, f264, f265, f266, f267, f268, f269, f270, f271, f272, f273, f274, f275, f276, f277, f278, f279, f280, f281, f282, f283, f284, f285, f286, f287, f288, f289, f290, f291, f292, f293, f294, f295, f296, f297, f298, f299, f300, f301, f302, f303, f304, f305, f306, f307, f308, f309, f310, f311, f312, f313, f314, f315, f316, f317, f318, f319, f320, f321, f322, f323, f324, f325, f326, f327, f328, f329, f330, f331, f332, f333, f334, f335, f336, f337, f338, f339, f340, f341, f342, f343, f344, f345, f346, f347, f348, f349, f350, f351, f352, f353, f354, f355, f356, f357, f358, f359, f360, f361, f362, f363, f364, f365, f366, f367, f368, f369, f370, f371, f372, f373, f374, f375, f376, f377, f378, f379, f380, f381, f382, f383, f384, f385, f386, f387, f388, f389, f390, f391, f392, f393, f394, f395, f396, f397, f398, f399, f400, f401, f402, f403, f404, f405, f406, f407, f408, f409, f410, f411, f412, f413, f414, f415, f416, f417, f418, f419, f420, f421, f422, f423, f424, f425, f426, f427, f428, f429, f430, f431, f432, f433, f434, f435, f436, f437, f438, f439, f440, f441, f442, f443, f444, f445, f446, f447, f448, f449, f450, f451, f452, f453, f454, f455, f456, f457, f458, f459, f460, f461, f462, f463, f464, f465, f466, f467, f468, f469, f470, f471, f472, f473, f474, f475, f476, f477, f478, f479, f480, f481, f482, f483, f484, f485, f486, f487, f488, f489, f490, f491, f492, f493, f494, f495, f496, f497, f498, f499, f500, f501, f502, f503, f504, f505, f506, f507, f508, f509, f510, f511, f512, f513, f514, f515, f516, f517, f518, f519, f520, f521, f522, f523, f524, f525, f526, f527, f528, f529, f530, f531, f532, f533, f534, f535, f536, f537, f538, f539, f540, f541, f542, f543, f544, f545, f546, f547, f548, f549, f550, f551, f552, f553, f554, f555, f556, f557, f558, f559, f560, f561, f562, f563, f564, f565, f566, f567, f568, f569, f570, f571, f572, f573, f574, f575, f576, f577, f578, f579, f580, f581, f582, f583, f584, f585, f586, f587, f588, f589, f590, f591, f592, f593, f594, f595, f596, f597, f598, f599, f600, f601, f602, f603, f604, f605, f606, f607, f608, f609, f610, f611, f612, f613, f614, f615, f616, f617, f618, f619, f620, f621, f622, f623, f624, f625, f626, f627, f628, f629, f630, f631, f632, f633, f634, f635, f636, f637, f638, f639, f640, f641, f642, f643, f644, f645, f646, f647, f648, f649, f650, f651, f652, f653, f654, f655, f656, f657, f658, f659, f660, f661, f662, f663, f664, f665, f666, f667, f668, f669, f670, f671, f672, f673, f674, f675, f676, f677, f678, f679, f680, f681, f682, f683, f684, f685, f686, f687, f688, f689, f690, f691, f692, f693, f694, f695, f696, f697, f698, f699, f700, f701, f702, f703, f704, f705, f706, f707, f708, f709, f710, f711, f712, f713, f714, f715, f716, f717, f718, f719, f720, f721, f722, f723, f724, f725, f726, f727, f728, f729, f730, f731, f732, f733, f734, f735, f736, f737, f738, f739, f740, f741, f742, f743, f744, f745, f746, f747, f748, f749, f750, f751, f752, f753, f754, f755, f756, f757, f758, f759, f760, f761, f762, f763, f764, f765, f766, f767, f768, f769, f770, f771, f772, f773, f774, f775, f776, f777, f778, f779, f780, f781, f782, f783, f784, f785, f786, f787, f788, f789, f790, f791, f792, f793, f794, f795, f796, f797, f798, f799, f800, f801, f802, f803, f804, f805, f806, f807, f808, f809, f810, f811, f812, f813, f814, f815, f816, f817, f818, f819, f820, f821, f822, f823, f824, f825, f826, f827, f828, f829, f830, f831, f832, f833, f834, f835, f836, f837, f838, f839, f840, f841, f842, f843, f844, f845, f846, f847, f848, f849, f850, f851, f852, f853, f854, f855, f856, f857, f858, f859, f860, f861, f862, f863, f864, f865, f866, f867, f868, f869, f870, f871, f872, f873, f874, f875, f876, f877, f878, f879, f880, f881, f882, f883, f884, f885, f886, f887, f888, f889, f890, f891, f892, f893, f894, f895, f896, f897, f898, f899, f900, f901, f902, f903, f904, f905, f906, f907, f908, f909, f910, f911, f912, f913, f914, f915, f916, f917, f918, f919, f920, f921, f922, f923, f924, f925, f926, f927, f928, f929, f930, f931, f932, f933, f934, f935, f936, f937, f938, f939, f940, f941, f942, f943, f944, f945, f946, f947, f948, f949, f950, f951, f952, f953, f954, f955, f956, f957, f958, f959, f960, f961, f962, f963, f964, f965, f966, f967, f968, f969, f970, f971, f972, f973, f974, f975, f976, f977, f978, f979, f980, f981, f982, f983, f984, f985, f986, f987, f988, f989, f990, f991, f992, f993, f994, f995, f996, f997, f998, f999, f1000, f1001, f1002, f1003, f1004, f1005, f1006, f1007, f1008, f1009, f1010, f1011, f1012, f1013, f1014, f1015, f1016, f1017, f1018, f1019, f1020, f1021, f1022, f1023, f1024, f1025, f1026, f1027, f1028, f1029, f1030, f1031, f1032, f1033, f1034, f1035, f1036, f1037, f1038, f1039, f1040, f1041, f1042, f1043, f1044, f1045, f1046, f1047, f1048, f1049, f1050, f1051, f1052, f1053, f1054, f1055, f1056, f1057, f1058, f1059, f1060, f1061, f1062, f1063, f1064, f1065, f1066, f1067, f1068, f1069, f1070, f1071, f1072, f1073, f1074, f1075, f1076, f1077, f1078, f1079, f1080, f1081, f1082, f1083, f1084, f1085, f1086;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99, r100, r101, r102, r103, r104, r105, r106, r107, r108, r109, r110, r111, r112, r113, r114, r115, r116, r117, r118, r119, r120, r121, r122, r123, r124, r125, r126, r127, r128, r129, r130, r131, r132, r133, r134, r135, r136, r137, r138, r139, r140, r141, r142, r143, r144, r145, r146, r147, r148, r149, r150, r151, r152, r153, r154, r155, r156, r157, r158, r159, r160, r161, r162, r163, r164, r165, r166, r167, r168, r169, r170, r171, r172, r173, r174, r175, r176, r177, r178, r179, r180, r181, r182, r183, r184, r185, r186, r187, r188, r189, r190, r191, r192, r193, r194, r195, r196, r197, r198, r199, r200, r201, r202, r203, r204, r205, r206, r207, r208, r209, r210, r211, r212, r213, r214, r215, r216, r217, r218, r219, r220, r221, r222, r223, r224, r225, r226, r227, r228, r229, r230, r231, r232, r233, r234, r235, r236, r237, r238, r239, r240, r241, r242, r243, r244, r245, r246, r247, r248, r249, r250, r251, r252, r253, r254, r255, r256, r257, r258, r259, r260, r261, r262, r263, r264, r265, r266, r267, r268, r269, r270, r271, r272, r273, r274, r275, r276, r277, r278, r279, r280, r281, r282, r283, r284, r285, r286, r287, r288, r289, r290, r291, r292, r293, r294, r295, r296, r297, r298, r299, r300, r301, r302, r303, r304, r305, r306, r307, r308, r309, r310, r311, r312, r313, r314, r315, r316, r317, r318, r319, r320, r321, r322, r323, r324, r325, r326, r327, r328, r329, r330, r331, r332, r333, r334, r335, r336, r337, r338, r339, r340, r341, r342, r343, r344, r345, r346, r347, r348, r349, r350, r351, r352, r353, r354, r355, r356, r357, r358, r359, r360, r361, r362, r363, r364, r365, r366, r367, r368, r369, r370, r371, r372, r373, r374, r375, r376, r377, r378, r379, r380, r381, r382, r383, r384, r385, r386, r387, r388, r389, r390, r391, r392, r393, r394, r395, r396, r397, r398, r399, r400, r401, r402, r403, r404, r405, r406, r407, r408, r409, r410, r411, r412, r413, r414, r415, r416, r417, r418, r419, r420, r421, r422, r423, r424, r425, r426, r427, r428, r429, r430, r431, r432, r433, r434, r435, r436, r437, r438, r439, r440, r441, r442, r443, r444, r445, r446, r447, r448, r449, r450, r451, r452, r453, r454, r455, r456, r457, r458, r459, r460, r461, r462, r463, r464, r465, r466, r467, r468, r469, r470, r471, r472, r473, r474, r475, r476, r477, r478, r479, r480, r481, r482, r483, r484, r485, r486, r487, r488, r489, r490, r491, r492, r493, r494, r495, r496, r497, r498, r499, r500, r501, r502, r503, r504, r505, r506, r507, r508, r509, r510, r511, r512, r513, r514, r515, r516, r517, r518, r519, r520, r521, r522, r523, r524, r525, r526, r527, r528, r529, r530, r531, r532, r533, r534, r535, r536, r537, r538, r539, r540, r541, r542, r543, r544, r545, r546, r547, r548, r549, r550, r551, r552, r553, r554, r555, r556, r557, r558, r559, r560, r561, r562, r563, r564, r565, r566, r567, r568, r569, r570, r571, r572, r573, r574, r575, r576, r577, r578, r579, r580, r581, r582, r583, r584, r585, r586, r587, r588, r589, r590, r591, r592, r593, r594, r595, r596, r597, r598, r599, r600, r601, r602, r603, r604, r605, r606, r607, r608, r609, r610, r611, r612, r613, r614, r615, r616, r617, r618, r619, r620, r621, r622, r623, r624, r625, r626, r627, r628, r629, r630, r631, r632, r633, r634, r635, r636, r637, r638, r639, r640, r641, r642, r643, r644, r645, r646, r647, r648, r649, r650, r651, r652, r653, r654, r655;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157, rd158, rd159, rd160, rd161, rd162, rd163, rd164, rd165, rd166, rd167, rd168, rd169, rd170, rd171, rd172, rd173, rd174, rd175, rd176, rd177, rd178, rd179, rd180, rd181, rd182, rd183, rd184, rd185, rd186, rd187, rd188, rd189, rd190, rd191, rd192, rd193, rd194, rd195, rd196, rd197, rd198, rd199, rd200, rd201, rd202, rd203, rd204, rd205, rd206, rd207, rd208, rd209, rd210, rd211, rd212, rd213, rd214, rd215, rd216, rd217, rd218, rd219, rd220, rd221, rd222, rd223, rd224, rd225, rd226, rd227, rd228, rd229, rd230, rd231, rd232, rd233, rd234, rd235, rd236, rd237, rd238, rd239, rd240, rd241, rd242, rd243, rd244, rd245, rd246, rd247, rd248, rd249, rd250, rd251, rd252, rd253, rd254, rd255, rd256, rd257, rd258, rd259, rd260, rd261, rd262, rd263, rd264, rd265, rd266, rd267, rd268, rd269, rd270, rd271, rd272, rd273, rd274, rd275, rd276, rd277, rd278, rd279, rd280, rd281, rd282, rd283, rd284, rd285, rd286, rd287, rd288, rd289, rd290, rd291, rd292, rd293, rd294, rd295, rd296, rd297, rd298, rd299, rd300, rd301, rd302, rd303, rd304, rd305, rd306, rd307, rd308, rd309, rd310, rd311, rd312, rd313, rd314, rd315, rd316, rd317, rd318, rd319, rd320, rd321, rd322, rd323, rd324, rd325, rd326, rd327, rd328, rd329, rd330, rd331, rd332, rd333, rd334, rd335, rd336, rd337, rd338, rd339, rd340, rd341, rd342, rd343, rd344, rd345, rd346, rd347, rd348, rd349, rd350, rd351, rd352, rd353, rd354, rd355, rd356, rd357, rd358, rd359, rd360, rd361, rd362, rd363, rd364, rd365, rd366, rd367, rd368, rd369, rd370, rd371, rd372, rd373, rd374, rd375, rd376, rd377, rd378, rd379, rd380, rd381, rd382, rd383, rd384, rd385, rd386, rd387, rd388, rd389, rd390, rd391, rd392, rd393, rd394, rd395, rd396, rd397, rd398, rd399, rd400, rd401, rd402, rd403, rd404, rd405, rd406, rd407, rd408, rd409, rd410, rd411, rd412, rd413, rd414, rd415, rd416, rd417, rd418, rd419, rd420, rd421, rd422, rd423, rd424;
  // PTX:18 mov.b64 %rd79, _ZN7synreal6kernel24initialize_hard_contactsENS0_15HardContactViewE_param_0
  rd79 = (unsigned long long)(uintptr_t)&param0;
  // PTX:19 mov.u32 %r300, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r300) : "r"(blockIdx.x));
  // PTX:20 mov.u32 %r301, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r301) : "r"(blockDim.x));
  // PTX:21 mul.wide.u32 %rd80, %r300, %r301
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd80) : "r"(r300), "r"(r301));
  // PTX:22 mov.u32 %r302, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r302) : "r"(threadIdx.x));
  // PTX:23 cvt.u64.u32 %rd81, %r302
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd81) : "r"(r302));
  // PTX:24 add.s64 %rd1, %rd80, %rd81
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd80), "l"(rd81));
  // PTX:25 add.s64 %rd2, %rd79, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd2) : "l"(rd79));
  // PTX:26 ld.param.u64 %rd83, [_ZN7synreal6kernel24initialize_hard_contactsENS0_15HardContactViewE_param_0+8]
  rd83 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (8))));
  // PTX:27 setp.le.u64 %p2, %rd83, %rd1
  p2 = (((unsigned long long)(rd83)) <= ((unsigned long long)(rd1)));
  // PTX:28 ld.param.u64 %rd3, [_ZN7synreal6kernel24initialize_hard_contactsENS0_15HardContactViewE_param_0]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:29 setp.eq.s64 %p3, %rd3, 0
  p3 = (((long long)(rd3)) == ((long long)(0)));
  // PTX:30 or.pred %p4, %p2, %p3
  p4 = ((p2) || (p3));
  // PTX:31 mov.u16 %rs10, 0
  asm("mov.u16 %0, 0;" : "=h"(rs10) : );
  // PTX:32 @%p4 bra $L__BB77_2
  if (p4) { goto L_BB77_2; }
  // PTX:34 cvta.to.global.u64 %rd84, %rd3
  rd84 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd3));
  // PTX:35 ld.global.u32 %r303, [%rd84]
  r303 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0)))));
  // PTX:36 max.s32 %r304, %r303, 0
  asm("max.s32 %0, %1, 0;" : "=r"(r304) : "r"(r303));
  // PTX:37 cvt.s64.s32 %rd85, %r304
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd85) : "r"(r304));
  // PTX:38 setp.lt.u64 %p5, %rd1, %rd85
  p5 = (((unsigned long long)(rd1)) < ((unsigned long long)(rd85)));
  // PTX:39 selp.u16 %rs10, 1, 0, %p5
  rs10 = p5 ? 1 : 0;
  // PTX:41 $L__BB77_2:
L_BB77_2:;
  // PTX:42 setp.eq.s16 %p6, %rs10, 0
  p6 = (((short)(rs10)) == ((short)(0)));
  // PTX:43 mov.f32 %f1081, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1081) : );
  // PTX:44 @%p6 bra $L__BB77_141
  if (p6) { goto L_BB77_141; }
  // PTX:46 mov.u64 %rd423, 0
  asm("mov.u64 %0, 0;" : "=l"(rd423) : );
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
  // PTX:59 mov.pred %p150, -1
  p150 = ((-1) != 0);
  // PTX:60 mov.u32 %r627, 0
  asm("mov.u32 %0, 0;" : "=r"(r627) : );
  // PTX:61 mov.u32 %r628, %r627
  asm("mov.u32 %0, %1;" : "=r"(r628) : "r"(r627));
  // PTX:62 mov.u32 %r629, %r627
  asm("mov.u32 %0, %1;" : "=r"(r629) : "r"(r627));
  // PTX:63 mov.u32 %r638, %r627
  asm("mov.u32 %0, %1;" : "=r"(r638) : "r"(r627));
  // PTX:64 mov.u32 %r639, %r627
  asm("mov.u32 %0, %1;" : "=r"(r639) : "r"(r627));
  // PTX:65 mov.u64 %rd424, %rd423
  asm("mov.u64 %0, %1;" : "=l"(rd424) : "l"(rd423));
  // PTX:66 @%p8 bra $L__BB77_122
  if (p8) { goto L_BB77_122; }
  // PTX:68 setp.gt.u64 %p9, %rd6, %rd11
  p9 = (((unsigned long long)(rd6)) > ((unsigned long long)(rd11)));
  // PTX:69 @%p9 bra $L__BB77_6
  if (p9) { goto L_BB77_6; }
  // PTX:70 bra.uni $L__BB77_5
  goto L_BB77_5;
  // PTX:72 $L__BB77_6:
L_BB77_6:;
  // PTX:73 or.b64 %rd99, %rd11, %rd5
  asm("or.b64 %0, %1, %2;" : "=l"(rd99) : "l"(rd11), "l"(rd5));
  // PTX:74 and.b64 %rd100, %rd99, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd100) : "l"(rd99));
  // PTX:75 setp.eq.s64 %p12, %rd100, 0
  p12 = (((long long)(rd100)) == ((long long)(0)));
  // PTX:76 @%p12 bra $L__BB77_8
  if (p12) { goto L_BB77_8; }
  // PTX:78 ld.param.u64 %rd385, [%rd2+152]
  rd385 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (152))));
  // PTX:79 div.u64 %rd409, %rd11, %rd385
  asm("div.u64 %0, %1, %2;" : "=l"(rd409) : "l"(rd11), "l"(rd385));
  // PTX:80 mul.lo.s64 %rd101, %rd409, %rd385
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd101) : "l"(rd409), "l"(rd385));
  // PTX:81 sub.s64 %rd411, %rd11, %rd101
  asm("sub.s64 %0, %1, %2;" : "=l"(rd411) : "l"(rd11), "l"(rd101));
  // PTX:82 bra.uni $L__BB77_9
  goto L_BB77_9;
  // PTX:84 $L__BB77_5:
L_BB77_5:;
  // PTX:85 mov.pred %p150, -1
  p150 = ((-1) != 0);
  // PTX:86 mov.u64 %rd423, 0
  asm("mov.u64 %0, 0;" : "=l"(rd423) : );
  // PTX:87 mov.u32 %r627, 0
  asm("mov.u32 %0, 0;" : "=r"(r627) : );
  // PTX:88 mov.f32 %f1081, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1081) : );
  // PTX:89 ld.param.u64 %rd366, [%rd2+144]
  rd366 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (144))));
  // PTX:90 sub.s64 %rd98, %rd11, %rd6
  asm("sub.s64 %0, %1, %2;" : "=l"(rd98) : "l"(rd11), "l"(rd6));
  // PTX:91 add.s64 %rd411, %rd98, %rd5
  asm("add.s64 %0, %1, %2;" : "=l"(rd411) : "l"(rd98), "l"(rd5));
  // PTX:92 setp.lt.u64 %p11, %rd411, %rd366
  p11 = (((unsigned long long)(rd411)) < ((unsigned long long)(rd366)));
  // PTX:93 mov.u32 %r520, -1
  asm("mov.u32 %0, -1;" : "=r"(r520) : );
  // PTX:94 mov.u32 %r628, %r627
  asm("mov.u32 %0, %1;" : "=r"(r628) : "r"(r627));
  // PTX:95 mov.u32 %r629, %r627
  asm("mov.u32 %0, %1;" : "=r"(r629) : "r"(r627));
  // PTX:96 mov.u32 %r638, %r627
  asm("mov.u32 %0, %1;" : "=r"(r638) : "r"(r627));
  // PTX:97 mov.u32 %r639, %r627
  asm("mov.u32 %0, %1;" : "=r"(r639) : "r"(r627));
  // PTX:98 mov.u64 %rd424, %rd423
  asm("mov.u64 %0, %1;" : "=l"(rd424) : "l"(rd423));
  // PTX:99 @%p11 bra $L__BB77_10
  if (p11) { goto L_BB77_10; }
  // PTX:100 bra.uni $L__BB77_122
  goto L_BB77_122;
  // PTX:102 $L__BB77_8:
L_BB77_8:;
  // PTX:103 ld.param.u64 %rd386, [%rd2+152]
  rd386 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (152))));
  // PTX:104 cvt.u32.u64 %r318, %rd386
  asm("cvt.u32.u64 %0, %1;" : "=r"(r318) : "l"(rd386));
  // PTX:105 cvt.u32.u64 %r319, %rd11
  asm("cvt.u32.u64 %0, %1;" : "=r"(r319) : "l"(rd11));
  // PTX:106 div.u32 %r320, %r319, %r318
  asm("div.u32 %0, %1, %2;" : "=r"(r320) : "r"(r319), "r"(r318));
  // PTX:107 mul.lo.s32 %r321, %r320, %r318
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r321) : "r"(r320), "r"(r318));
  // PTX:108 sub.s32 %r322, %r319, %r321
  asm("sub.s32 %0, %1, %2;" : "=r"(r322) : "r"(r319), "r"(r321));
  // PTX:109 cvt.u64.u32 %rd409, %r320
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd409) : "r"(r320));
  // PTX:110 cvt.u64.u32 %rd411, %r322
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd411) : "r"(r322));
  // PTX:112 $L__BB77_9:
L_BB77_9:;
  // PTX:113 cvt.u32.u64 %r520, %rd409
  asm("cvt.u32.u64 %0, %1;" : "=r"(r520) : "l"(rd409));
  // PTX:115 $L__BB77_10:
L_BB77_10:;
  // PTX:116 mov.u64 %rd424, %rd411
  asm("mov.u64 %0, %1;" : "=l"(rd424) : "l"(rd411));
  // PTX:117 ld.param.u64 %rd369, [%rd2+88]
  rd369 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (88))));
  // PTX:118 cvta.to.global.u64 %rd368, %rd369
  rd368 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd369));
  // PTX:119 shl.b64 %rd102, %rd424, 32
  asm("shl.b64 %0, %1, 32;" : "=l"(rd102) : "l"(rd424));
  // PTX:120 shr.s64 %rd103, %rd102, 30
  asm("shr.s64 %0, %1, 30;" : "=l"(rd103) : "l"(rd102));
  // PTX:121 add.s64 %rd104, %rd368, %rd103
  asm("add.s64 %0, %1, %2;" : "=l"(rd104) : "l"(rd368), "l"(rd103));
  // PTX:122 ld.global.s32 %rd21, [%rd104]
  rd21 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (0)))));
  // PTX:123 setp.lt.s64 %p13, %rd21, 0
  p13 = (((long long)(rd21)) < ((long long)(0)));
  // PTX:124 mov.u32 %r323, -1
  asm("mov.u32 %0, -1;" : "=r"(r323) : );
  // PTX:125 mov.u32 %r639, %r323
  asm("mov.u32 %0, %1;" : "=r"(r639) : "r"(r323));
  // PTX:126 @%p13 bra $L__BB77_18
  if (p13) { goto L_BB77_18; }
  // PTX:128 setp.gt.u64 %p14, %rd9, %rd21
  p14 = (((unsigned long long)(rd9)) > ((unsigned long long)(rd21)));
  // PTX:129 @%p14 bra $L__BB77_13
  if (p14) { goto L_BB77_13; }
  // PTX:130 bra.uni $L__BB77_12
  goto L_BB77_12;
  // PTX:132 $L__BB77_13:
L_BB77_13:;
  // PTX:133 cvt.u32.u64 %r325, %rd21
  asm("cvt.u32.u64 %0, %1;" : "=r"(r325) : "l"(rd21));
  // PTX:134 shl.b64 %rd105, %rd21, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd105) : "l"(rd21));
  // PTX:135 add.s64 %rd106, %rd8, %rd105
  asm("add.s64 %0, %1, %2;" : "=l"(rd106) : "l"(rd8), "l"(rd105));
  // PTX:136 ld.global.u32 %r326, [%rd106]
  r326 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))));
  // PTX:137 setp.eq.s32 %p16, %r326, %r325
  p16 = (((int)(r326)) == ((int)(r325)));
  // PTX:138 setp.eq.s64 %p17, %rd9, 0
  p17 = (((long long)(rd9)) == ((long long)(0)));
  // PTX:139 or.pred %p18, %p16, %p17
  p18 = ((p16) || (p17));
  // PTX:140 selp.b32 %r639, %r325, -1, %p16
  r639 = p16 ? r325 : -1;
  // PTX:141 @%p18 bra $L__BB77_18
  if (p18) { goto L_BB77_18; }
  // PTX:142 bra.uni $L__BB77_14
  goto L_BB77_14;
  // PTX:144 $L__BB77_12:
L_BB77_12:;
  // PTX:145 setp.eq.s64 %p15, %rd9, 0
  p15 = (((long long)(rd9)) == ((long long)(0)));
  // PTX:146 mov.u32 %r639, %r323
  asm("mov.u32 %0, %1;" : "=r"(r639) : "r"(r323));
  // PTX:147 @%p15 bra $L__BB77_18
  if (p15) { goto L_BB77_18; }
  // PTX:149 $L__BB77_14:
L_BB77_14:;
  // PTX:150 mov.u64 %rd412, 0
  asm("mov.u64 %0, 0;" : "=l"(rd412) : );
  // PTX:151 cvt.u32.u64 %r328, %rd21
  asm("cvt.u32.u64 %0, %1;" : "=r"(r328) : "l"(rd21));
  // PTX:153 $L__BB77_15:
L_BB77_15:;
  // PTX:154 shl.b64 %rd108, %rd412, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd108) : "l"(rd412));
  // PTX:155 add.s64 %rd109, %rd8, %rd108
  asm("add.s64 %0, %1, %2;" : "=l"(rd109) : "l"(rd8), "l"(rd108));
  // PTX:156 ld.global.u32 %r327, [%rd109]
  r327 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd109) + (0)))));
  // PTX:157 setp.eq.s32 %p19, %r327, %r328
  p19 = (((int)(r327)) == ((int)(r328)));
  // PTX:158 @%p19 bra $L__BB77_17
  if (p19) { goto L_BB77_17; }
  // PTX:160 add.s64 %rd412, %rd412, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd412) : "l"(rd412));
  // PTX:161 setp.lt.u64 %p20, %rd412, %rd9
  p20 = (((unsigned long long)(rd412)) < ((unsigned long long)(rd9)));
  // PTX:162 mov.u32 %r639, %r323
  asm("mov.u32 %0, %1;" : "=r"(r639) : "r"(r323));
  // PTX:163 @%p20 bra $L__BB77_15
  if (p20) { goto L_BB77_15; }
  // PTX:164 bra.uni $L__BB77_18
  goto L_BB77_18;
  // PTX:166 $L__BB77_17:
L_BB77_17:;
  // PTX:167 cvt.u32.u64 %r639, %rd412
  asm("cvt.u32.u64 %0, %1;" : "=r"(r639) : "l"(rd412));
  // PTX:169 $L__BB77_18:
L_BB77_18:;
  // PTX:170 mov.pred %p150, -1
  p150 = ((-1) != 0);
  // PTX:171 mov.u64 %rd423, 0
  asm("mov.u64 %0, 0;" : "=l"(rd423) : );
  // PTX:172 mov.u32 %r627, 0
  asm("mov.u32 %0, 0;" : "=r"(r627) : );
  // PTX:173 mov.f32 %f1081, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1081) : );
  // PTX:174 cvt.u32.u64 %r335, %rd21
  asm("cvt.u32.u64 %0, %1;" : "=r"(r335) : "l"(rd21));
  // PTX:175 setp.gt.s32 %p22, %r335, -1
  p22 = (((int)(r335)) > ((int)(-1)));
  // PTX:176 setp.lt.s32 %p23, %r639, 0
  p23 = (((int)(r639)) < ((int)(0)));
  // PTX:177 and.pred %p24, %p22, %p23
  p24 = ((p22) && (p23));
  // PTX:178 mov.u32 %r628, %r627
  asm("mov.u32 %0, %1;" : "=r"(r628) : "r"(r627));
  // PTX:179 mov.u32 %r629, %r627
  asm("mov.u32 %0, %1;" : "=r"(r629) : "r"(r627));
  // PTX:180 mov.u32 %r638, %r627
  asm("mov.u32 %0, %1;" : "=r"(r638) : "r"(r627));
  // PTX:181 @%p24 bra $L__BB77_122
  if (p24) { goto L_BB77_122; }
  // PTX:183 mov.pred %p150, -1
  p150 = ((-1) != 0);
  // PTX:184 mov.u64 %rd423, 0
  asm("mov.u64 %0, 0;" : "=l"(rd423) : );
  // PTX:185 mov.u32 %r627, 0
  asm("mov.u32 %0, 0;" : "=r"(r627) : );
  // PTX:186 mov.f32 %f1081, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1081) : );
  // PTX:187 setp.gt.s32 %p26, %r639, -1
  p26 = (((int)(r639)) > ((int)(-1)));
  // PTX:188 setp.lt.s32 %p27, %r520, 0
  p27 = (((int)(r520)) < ((int)(0)));
  // PTX:189 and.pred %p28, %p26, %p27
  p28 = ((p26) && (p27));
  // PTX:190 @%p28 bra $L__BB77_122
  if (p28) { goto L_BB77_122; }
  // PTX:192 setp.lt.s32 %p148, %r639, 0
  p148 = (((int)(r639)) < ((int)(0)));
  // PTX:193 mov.u32 %r637, 0
  asm("mov.u32 %0, 0;" : "=r"(r637) : );
  // PTX:194 mov.u32 %r636, %r637
  asm("mov.u32 %0, %1;" : "=r"(r636) : "r"(r637));
  // PTX:195 mov.u32 %r635, %r637
  asm("mov.u32 %0, %1;" : "=r"(r635) : "r"(r637));
  // PTX:196 mov.u32 %r634, %r637
  asm("mov.u32 %0, %1;" : "=r"(r634) : "r"(r637));
  // PTX:197 @%p148 bra $L__BB77_22
  if (p148) { goto L_BB77_22; }
  // PTX:199 ld.param.u32 %r514, [%rd2+200]
  r514 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd2) + (200))));
  // PTX:200 ld.param.u64 %rd373, [%rd2+176]
  rd373 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (176))));
  // PTX:201 cvta.to.global.u64 %rd372, %rd373
  rd372 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd373));
  // PTX:202 mul.wide.s32 %rd112, %r639, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd112) : "r"(r639));
  // PTX:203 add.s64 %rd113, %rd372, %rd112
  asm("add.s64 %0, %1, %2;" : "=l"(rd113) : "l"(rd372), "l"(rd112));
  // PTX:204 mul.lo.s32 %r345, %r520, %r514
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r345) : "r"(r520), "r"(r514));
  // PTX:205 ld.global.u32 %r346, [%rd113]
  r346 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd113) + (0)))));
  // PTX:206 ld.global.u32 %r347, [%rd113+4]
  r347 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd113) + (4)))));
  // PTX:207 ld.global.u32 %r348, [%rd113+8]
  r348 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd113) + (8)))));
  // PTX:208 ld.global.u32 %r349, [%rd113+12]
  r349 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd113) + (12)))));
  // PTX:209 add.s32 %r634, %r345, %r349
  asm("add.s32 %0, %1, %2;" : "=r"(r634) : "r"(r345), "r"(r349));
  // PTX:210 add.s32 %r635, %r345, %r348
  asm("add.s32 %0, %1, %2;" : "=r"(r635) : "r"(r345), "r"(r348));
  // PTX:211 add.s32 %r636, %r345, %r347
  asm("add.s32 %0, %1, %2;" : "=r"(r636) : "r"(r345), "r"(r347));
  // PTX:212 add.s32 %r637, %r345, %r346
  asm("add.s32 %0, %1, %2;" : "=r"(r637) : "r"(r345), "r"(r346));
  // PTX:214 $L__BB77_22:
L_BB77_22:;
  // PTX:215 mov.u32 %r627, 0
  asm("mov.u32 %0, 0;" : "=r"(r627) : );
  // PTX:216 mov.pred %p150, -1
  p150 = ((-1) != 0);
  // PTX:217 mov.u64 %rd423, 0
  asm("mov.u64 %0, 0;" : "=l"(rd423) : );
  // PTX:218 mov.f32 %f1081, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1081) : );
  // PTX:219 ld.param.u64 %rd115, [%rd2+16]
  rd115 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (16))));
  // PTX:220 cvta.to.global.u64 %rd116, %rd115
  rd116 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd115));
  // PTX:221 add.s64 %rd118, %rd116, %rd94
  asm("add.s64 %0, %1, %2;" : "=l"(rd118) : "l"(rd116), "l"(rd94));
  // PTX:222 ld.global.s32 %rd24, [%rd118]
  rd24 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (0)))));
  // PTX:223 setp.lt.s64 %p31, %rd24, 0
  p31 = (((long long)(rd24)) < ((long long)(0)));
  // PTX:224 mov.u32 %r628, %r627
  asm("mov.u32 %0, %1;" : "=r"(r628) : "r"(r627));
  // PTX:225 mov.u32 %r629, %r627
  asm("mov.u32 %0, %1;" : "=r"(r629) : "r"(r627));
  // PTX:226 mov.u32 %r638, %r627
  asm("mov.u32 %0, %1;" : "=r"(r638) : "r"(r627));
  // PTX:227 @%p31 bra $L__BB77_122
  if (p31) { goto L_BB77_122; }
  // PTX:229 setp.gt.u64 %p32, %rd6, %rd24
  p32 = (((unsigned long long)(rd6)) > ((unsigned long long)(rd24)));
  // PTX:230 @%p32 bra $L__BB77_25
  if (p32) { goto L_BB77_25; }
  // PTX:231 bra.uni $L__BB77_24
  goto L_BB77_24;
  // PTX:233 $L__BB77_25:
L_BB77_25:;
  // PTX:234 ld.param.u64 %rd382, [%rd2+152]
  rd382 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (152))));
  // PTX:235 or.b64 %rd121, %rd24, %rd382
  asm("or.b64 %0, %1, %2;" : "=l"(rd121) : "l"(rd24), "l"(rd382));
  // PTX:236 and.b64 %rd122, %rd121, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd122) : "l"(rd121));
  // PTX:237 setp.eq.s64 %p35, %rd122, 0
  p35 = (((long long)(rd122)) == ((long long)(0)));
  // PTX:238 @%p35 bra $L__BB77_27
  if (p35) { goto L_BB77_27; }
  // PTX:240 ld.param.u64 %rd383, [%rd2+152]
  rd383 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (152))));
  // PTX:241 div.u64 %rd413, %rd24, %rd383
  asm("div.u64 %0, %1, %2;" : "=l"(rd413) : "l"(rd24), "l"(rd383));
  // PTX:242 mul.lo.s64 %rd123, %rd413, %rd383
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd123) : "l"(rd413), "l"(rd383));
  // PTX:243 sub.s64 %rd415, %rd24, %rd123
  asm("sub.s64 %0, %1, %2;" : "=l"(rd415) : "l"(rd24), "l"(rd123));
  // PTX:244 bra.uni $L__BB77_28
  goto L_BB77_28;
  // PTX:246 $L__BB77_24:
L_BB77_24:;
  // PTX:247 mov.u32 %r627, 0
  asm("mov.u32 %0, 0;" : "=r"(r627) : );
  // PTX:248 ld.param.u64 %rd381, [%rd2+152]
  rd381 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (152))));
  // PTX:249 mov.pred %p150, -1
  p150 = ((-1) != 0);
  // PTX:250 mov.u64 %rd423, 0
  asm("mov.u64 %0, 0;" : "=l"(rd423) : );
  // PTX:251 mov.f32 %f1081, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1081) : );
  // PTX:252 ld.param.u64 %rd375, [%rd2+144]
  rd375 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (144))));
  // PTX:253 sub.s64 %rd120, %rd24, %rd6
  asm("sub.s64 %0, %1, %2;" : "=l"(rd120) : "l"(rd24), "l"(rd6));
  // PTX:254 add.s64 %rd415, %rd120, %rd381
  asm("add.s64 %0, %1, %2;" : "=l"(rd415) : "l"(rd120), "l"(rd381));
  // PTX:255 setp.lt.u64 %p34, %rd415, %rd375
  p34 = (((unsigned long long)(rd415)) < ((unsigned long long)(rd375)));
  // PTX:256 mov.u32 %r526, -1
  asm("mov.u32 %0, -1;" : "=r"(r526) : );
  // PTX:257 mov.u32 %r628, %r627
  asm("mov.u32 %0, %1;" : "=r"(r628) : "r"(r627));
  // PTX:258 mov.u32 %r629, %r627
  asm("mov.u32 %0, %1;" : "=r"(r629) : "r"(r627));
  // PTX:259 mov.u32 %r638, %r627
  asm("mov.u32 %0, %1;" : "=r"(r638) : "r"(r627));
  // PTX:260 @%p34 bra $L__BB77_29
  if (p34) { goto L_BB77_29; }
  // PTX:261 bra.uni $L__BB77_122
  goto L_BB77_122;
  // PTX:263 $L__BB77_27:
L_BB77_27:;
  // PTX:264 ld.param.u64 %rd384, [%rd2+152]
  rd384 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (152))));
  // PTX:265 cvt.u32.u64 %r361, %rd384
  asm("cvt.u32.u64 %0, %1;" : "=r"(r361) : "l"(rd384));
  // PTX:266 cvt.u32.u64 %r362, %rd24
  asm("cvt.u32.u64 %0, %1;" : "=r"(r362) : "l"(rd24));
  // PTX:267 div.u32 %r363, %r362, %r361
  asm("div.u32 %0, %1, %2;" : "=r"(r363) : "r"(r362), "r"(r361));
  // PTX:268 mul.lo.s32 %r364, %r363, %r361
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r364) : "r"(r363), "r"(r361));
  // PTX:269 sub.s32 %r365, %r362, %r364
  asm("sub.s32 %0, %1, %2;" : "=r"(r365) : "r"(r362), "r"(r364));
  // PTX:270 cvt.u64.u32 %rd413, %r363
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd413) : "r"(r363));
  // PTX:271 cvt.u64.u32 %rd415, %r365
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd415) : "r"(r365));
  // PTX:273 $L__BB77_28:
L_BB77_28:;
  // PTX:274 cvt.u32.u64 %r526, %rd413
  asm("cvt.u32.u64 %0, %1;" : "=r"(r526) : "l"(rd413));
  // PTX:276 $L__BB77_29:
L_BB77_29:;
  // PTX:277 mov.u64 %rd423, %rd415
  asm("mov.u64 %0, %1;" : "=l"(rd423) : "l"(rd415));
  // PTX:278 ld.param.u64 %rd378, [%rd2+88]
  rd378 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (88))));
  // PTX:279 cvta.to.global.u64 %rd377, %rd378
  rd377 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd378));
  // PTX:280 shl.b64 %rd124, %rd423, 32
  asm("shl.b64 %0, %1, 32;" : "=l"(rd124) : "l"(rd423));
  // PTX:281 shr.s64 %rd125, %rd124, 30
  asm("shr.s64 %0, %1, 30;" : "=l"(rd125) : "l"(rd124));
  // PTX:282 add.s64 %rd126, %rd377, %rd125
  asm("add.s64 %0, %1, %2;" : "=l"(rd126) : "l"(rd377), "l"(rd125));
  // PTX:283 ld.global.s32 %rd34, [%rd126]
  rd34 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (0)))));
  // PTX:284 setp.lt.s64 %p36, %rd34, 0
  p36 = (((long long)(rd34)) < ((long long)(0)));
  // PTX:285 mov.u32 %r366, -1
  asm("mov.u32 %0, -1;" : "=r"(r366) : );
  // PTX:286 mov.u32 %r638, %r366
  asm("mov.u32 %0, %1;" : "=r"(r638) : "r"(r366));
  // PTX:287 @%p36 bra $L__BB77_37
  if (p36) { goto L_BB77_37; }
  // PTX:289 setp.gt.u64 %p37, %rd9, %rd34
  p37 = (((unsigned long long)(rd9)) > ((unsigned long long)(rd34)));
  // PTX:290 @%p37 bra $L__BB77_32
  if (p37) { goto L_BB77_32; }
  // PTX:291 bra.uni $L__BB77_31
  goto L_BB77_31;
  // PTX:293 $L__BB77_32:
L_BB77_32:;
  // PTX:294 cvt.u32.u64 %r368, %rd34
  asm("cvt.u32.u64 %0, %1;" : "=r"(r368) : "l"(rd34));
  // PTX:295 shl.b64 %rd127, %rd34, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd127) : "l"(rd34));
  // PTX:296 add.s64 %rd128, %rd8, %rd127
  asm("add.s64 %0, %1, %2;" : "=l"(rd128) : "l"(rd8), "l"(rd127));
  // PTX:297 ld.global.u32 %r369, [%rd128]
  r369 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (0)))));
  // PTX:298 setp.eq.s32 %p39, %r369, %r368
  p39 = (((int)(r369)) == ((int)(r368)));
  // PTX:299 setp.eq.s64 %p40, %rd9, 0
  p40 = (((long long)(rd9)) == ((long long)(0)));
  // PTX:300 or.pred %p41, %p39, %p40
  p41 = ((p39) || (p40));
  // PTX:301 selp.b32 %r638, %r368, -1, %p39
  r638 = p39 ? r368 : -1;
  // PTX:302 @%p41 bra $L__BB77_37
  if (p41) { goto L_BB77_37; }
  // PTX:303 bra.uni $L__BB77_33
  goto L_BB77_33;
  // PTX:305 $L__BB77_31:
L_BB77_31:;
  // PTX:306 setp.eq.s64 %p38, %rd9, 0
  p38 = (((long long)(rd9)) == ((long long)(0)));
  // PTX:307 mov.u32 %r638, %r366
  asm("mov.u32 %0, %1;" : "=r"(r638) : "r"(r366));
  // PTX:308 @%p38 bra $L__BB77_37
  if (p38) { goto L_BB77_37; }
  // PTX:310 $L__BB77_33:
L_BB77_33:;
  // PTX:311 mov.u64 %rd416, 0
  asm("mov.u64 %0, 0;" : "=l"(rd416) : );
  // PTX:312 cvt.u32.u64 %r371, %rd34
  asm("cvt.u32.u64 %0, %1;" : "=r"(r371) : "l"(rd34));
  // PTX:314 $L__BB77_34:
L_BB77_34:;
  // PTX:315 shl.b64 %rd130, %rd416, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd130) : "l"(rd416));
  // PTX:316 add.s64 %rd131, %rd8, %rd130
  asm("add.s64 %0, %1, %2;" : "=l"(rd131) : "l"(rd8), "l"(rd130));
  // PTX:317 ld.global.u32 %r370, [%rd131]
  r370 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd131) + (0)))));
  // PTX:318 setp.eq.s32 %p42, %r370, %r371
  p42 = (((int)(r370)) == ((int)(r371)));
  // PTX:319 @%p42 bra $L__BB77_36
  if (p42) { goto L_BB77_36; }
  // PTX:321 add.s64 %rd416, %rd416, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd416) : "l"(rd416));
  // PTX:322 setp.lt.u64 %p43, %rd416, %rd9
  p43 = (((unsigned long long)(rd416)) < ((unsigned long long)(rd9)));
  // PTX:323 mov.u32 %r638, %r366
  asm("mov.u32 %0, %1;" : "=r"(r638) : "r"(r366));
  // PTX:324 @%p43 bra $L__BB77_34
  if (p43) { goto L_BB77_34; }
  // PTX:325 bra.uni $L__BB77_37
  goto L_BB77_37;
  // PTX:327 $L__BB77_36:
L_BB77_36:;
  // PTX:328 cvt.u32.u64 %r638, %rd416
  asm("cvt.u32.u64 %0, %1;" : "=r"(r638) : "l"(rd416));
  // PTX:330 $L__BB77_37:
L_BB77_37:;
  // PTX:331 mov.u32 %r627, 0
  asm("mov.u32 %0, 0;" : "=r"(r627) : );
  // PTX:332 mov.pred %p150, -1
  p150 = ((-1) != 0);
  // PTX:333 mov.f32 %f1081, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1081) : );
  // PTX:334 cvt.u32.u64 %r377, %rd34
  asm("cvt.u32.u64 %0, %1;" : "=r"(r377) : "l"(rd34));
  // PTX:335 setp.gt.s32 %p45, %r377, -1
  p45 = (((int)(r377)) > ((int)(-1)));
  // PTX:336 setp.lt.s32 %p46, %r638, 0
  p46 = (((int)(r638)) < ((int)(0)));
  // PTX:337 and.pred %p47, %p45, %p46
  p47 = ((p45) && (p46));
  // PTX:338 mov.u32 %r628, %r627
  asm("mov.u32 %0, %1;" : "=r"(r628) : "r"(r627));
  // PTX:339 mov.u32 %r629, %r627
  asm("mov.u32 %0, %1;" : "=r"(r629) : "r"(r627));
  // PTX:340 @%p47 bra $L__BB77_122
  if (p47) { goto L_BB77_122; }
  // PTX:342 mov.u32 %r627, 0
  asm("mov.u32 %0, 0;" : "=r"(r627) : );
  // PTX:343 mov.pred %p150, -1
  p150 = ((-1) != 0);
  // PTX:344 mov.f32 %f1081, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1081) : );
  // PTX:345 setp.gt.s32 %p49, %r638, -1
  p49 = (((int)(r638)) > ((int)(-1)));
  // PTX:346 setp.lt.s32 %p50, %r526, 0
  p50 = (((int)(r526)) < ((int)(0)));
  // PTX:347 and.pred %p51, %p49, %p50
  p51 = ((p49) && (p50));
  // PTX:348 @%p51 bra $L__BB77_122
  if (p51) { goto L_BB77_122; }
  // PTX:350 mov.u32 %r627, 0
  asm("mov.u32 %0, 0;" : "=r"(r627) : );
  // PTX:351 mov.u32 %r633, %r627
  asm("mov.u32 %0, %1;" : "=r"(r633) : "r"(r627));
  // PTX:352 mov.u32 %r632, %r627
  asm("mov.u32 %0, %1;" : "=r"(r632) : "r"(r627));
  // PTX:353 mov.u32 %r631, %r627
  asm("mov.u32 %0, %1;" : "=r"(r631) : "r"(r627));
  // PTX:354 mov.u32 %r630, %r627
  asm("mov.u32 %0, %1;" : "=r"(r630) : "r"(r627));
  // PTX:355 @%p46 bra $L__BB77_41
  if (p46) { goto L_BB77_41; }
  // PTX:357 ld.param.u32 %r515, [%rd2+200]
  r515 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)(rd2) + (200))));
  // PTX:358 ld.param.u64 %rd380, [%rd2+176]
  rd380 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (176))));
  // PTX:359 cvta.to.global.u64 %rd379, %rd380
  rd379 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd380));
  // PTX:360 mul.wide.s32 %rd132, %r638, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd132) : "r"(r638));
  // PTX:361 add.s64 %rd133, %rd379, %rd132
  asm("add.s64 %0, %1, %2;" : "=l"(rd133) : "l"(rd379), "l"(rd132));
  // PTX:362 mul.lo.s32 %r386, %r526, %r515
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r386) : "r"(r526), "r"(r515));
  // PTX:363 ld.global.u32 %r387, [%rd133]
  r387 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd133) + (0)))));
  // PTX:364 ld.global.u32 %r388, [%rd133+4]
  r388 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd133) + (4)))));
  // PTX:365 ld.global.u32 %r389, [%rd133+8]
  r389 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd133) + (8)))));
  // PTX:366 ld.global.u32 %r390, [%rd133+12]
  r390 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd133) + (12)))));
  // PTX:367 add.s32 %r630, %r386, %r390
  asm("add.s32 %0, %1, %2;" : "=r"(r630) : "r"(r386), "r"(r390));
  // PTX:368 add.s32 %r631, %r386, %r389
  asm("add.s32 %0, %1, %2;" : "=r"(r631) : "r"(r386), "r"(r389));
  // PTX:369 add.s32 %r632, %r386, %r388
  asm("add.s32 %0, %1, %2;" : "=r"(r632) : "r"(r386), "r"(r388));
  // PTX:370 add.s32 %r633, %r386, %r387
  asm("add.s32 %0, %1, %2;" : "=r"(r633) : "r"(r386), "r"(r387));
  // PTX:372 $L__BB77_41:
L_BB77_41:;
  // PTX:373 mov.pred %p150, -1
  p150 = ((-1) != 0);
  // PTX:374 mov.f32 %f1081, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1081) : );
  // PTX:375 or.b32 %r395, %r526, %r520
  asm("or.b32 %0, %1, %2;" : "=r"(r395) : "r"(r526), "r"(r520));
  // PTX:376 setp.gt.s32 %p54, %r395, -1
  p54 = (((int)(r395)) > ((int)(-1)));
  // PTX:377 setp.ne.s32 %p55, %r520, %r526
  p55 = (((int)(r520)) != ((int)(r526)));
  // PTX:378 and.pred %p56, %p55, %p54
  p56 = ((p55) && (p54));
  // PTX:379 and.b32 %r396, %r638, %r639
  asm("and.b32 %0, %1, %2;" : "=r"(r396) : "r"(r638), "r"(r639));
  // PTX:380 setp.lt.s32 %p57, %r396, 0
  p57 = (((int)(r396)) < ((int)(0)));
  // PTX:381 or.pred %p58, %p56, %p57
  p58 = ((p56) || (p57));
  // PTX:382 mov.u32 %r628, %r627
  asm("mov.u32 %0, %1;" : "=r"(r628) : "r"(r627));
  // PTX:383 mov.u32 %r629, %r627
  asm("mov.u32 %0, %1;" : "=r"(r629) : "r"(r627));
  // PTX:384 @%p58 bra $L__BB77_122
  if (p58) { goto L_BB77_122; }
  // PTX:386 ld.param.u64 %rd136, [%rd2+56]
  rd136 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (56))));
  // PTX:387 cvta.to.global.u64 %rd137, %rd136
  rd137 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd136));
  // PTX:388 mul.lo.s64 %rd138, %rd1, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd138) : "l"(rd1));
  // PTX:389 add.s64 %rd139, %rd137, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd139) : "l"(rd137), "l"(rd138));
  // PTX:390 ld.global.f32 %f1, [%rd139]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd139) + (0)))));
  // PTX:391 ld.global.f32 %f2, [%rd139+4]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd139) + (4)))));
  // PTX:392 mul.f32 %f248, %f2, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f248) : "f"(f2), "f"(f2));
  // PTX:393 ld.global.f32 %f3, [%rd139+8]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd139) + (8)))));
  // PTX:394 fma.rn.f32 %f249, %f1, %f1, %f248
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f249) : "f"(f1), "f"(f1), "f"(f248));
  // PTX:395 fma.rn.f32 %f250, %f3, %f3, %f249
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f250) : "f"(f3), "f"(f3), "f"(f249));
  // PTX:396 sqrt.rn.f32 %f4, %f250
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f4) : "f"(f250));
  // PTX:397 setp.leu.f32 %p59, %f4, 0f00000000
  p59 = ((isnan(((float)(f4))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f4)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:398 mov.u32 %r532, 0
  asm("mov.u32 %0, 0;" : "=r"(r532) : );
  // PTX:399 mov.u32 %r533, %r532
  asm("mov.u32 %0, %1;" : "=r"(r533) : "r"(r532));
  // PTX:400 mov.u32 %r534, %r532
  asm("mov.u32 %0, %1;" : "=r"(r534) : "r"(r532));
  // PTX:401 @%p59 bra $L__BB77_44
  if (p59) { goto L_BB77_44; }
  // PTX:403 div.rn.f32 %f251, %f1, %f4
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f251) : "f"(f1), "f"(f4));
  // PTX:404 div.rn.f32 %f252, %f2, %f4
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f252) : "f"(f2), "f"(f4));
  // PTX:405 div.rn.f32 %f253, %f3, %f4
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f253) : "f"(f3), "f"(f4));
  // PTX:406 mov.b32 %r534, %f253
  asm("mov.b32 %0, %1;" : "=r"(r534) : "f"(f253));
  // PTX:407 mov.b32 %r533, %f252
  asm("mov.b32 %0, %1;" : "=r"(r533) : "f"(f252));
  // PTX:408 mov.b32 %r532, %f251
  asm("mov.b32 %0, %1;" : "=r"(r532) : "f"(f251));
  // PTX:410 $L__BB77_44:
L_BB77_44:;
  // PTX:411 cvt.s64.s32 %rd351, %rd423
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd351) : "l"(rd423));
  // PTX:412 cvt.s64.s32 %rd350, %rd424
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd350) : "l"(rd424));
  // PTX:413 ld.param.u64 %rd349, [%rd2+96]
  rd349 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (96))));
  // PTX:414 cvta.to.global.u64 %rd144, %rd349
  rd144 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd349));
  // PTX:415 shl.b64 %rd145, %rd350, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd145) : "l"(rd350));
  // PTX:416 add.s64 %rd146, %rd144, %rd145
  asm("add.s64 %0, %1, %2;" : "=l"(rd146) : "l"(rd144), "l"(rd145));
  // PTX:417 ld.global.u32 %r42, [%rd146]
  r42 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd146) + (0)))));
  // PTX:418 setp.eq.s32 %p60, %r42, 3
  p60 = (((int)(r42)) == ((int)(3)));
  // PTX:419 shl.b64 %rd147, %rd351, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd147) : "l"(rd351));
  // PTX:420 add.s64 %rd148, %rd144, %rd147
  asm("add.s64 %0, %1, %2;" : "=l"(rd148) : "l"(rd144), "l"(rd147));
  // PTX:421 ld.global.u32 %r43, [%rd148]
  r43 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd148) + (0)))));
  // PTX:422 @%p60 bra $L__BB77_46
  if (p60) { goto L_BB77_46; }
  // PTX:423 bra.uni $L__BB77_45
  goto L_BB77_45;
  // PTX:425 $L__BB77_46:
L_BB77_46:;
  // PTX:426 ld.param.u64 %rd396, [%rd2+104]
  rd396 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (104))));
  // PTX:427 cvta.to.global.u64 %rd395, %rd396
  rd395 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd396));
  // PTX:428 cvt.s64.s32 %rd359, %rd424
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd359) : "l"(rd424));
  // PTX:429 mul.lo.s64 %rd150, %rd359, 28
  asm("mul.lo.s64 %0, %1, 28;" : "=l"(rd150) : "l"(rd359));
  // PTX:430 add.s64 %rd419, %rd395, %rd150
  asm("add.s64 %0, %1, %2;" : "=l"(rd419) : "l"(rd395), "l"(rd150));
  // PTX:431 add.s64 %rd418, %rd419, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd418) : "l"(rd419));
  // PTX:432 add.s64 %rd417, %rd419, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd417) : "l"(rd419));
  // PTX:433 bra.uni $L__BB77_47
  goto L_BB77_47;
  // PTX:435 $L__BB77_45:
L_BB77_45:;
  // PTX:436 ld.param.u64 %rd353, [%rd2+24]
  rd353 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (24))));
  // PTX:437 cvta.to.global.u64 %rd352, %rd353
  rd352 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd353));
  // PTX:438 add.s64 %rd419, %rd352, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd419) : "l"(rd352), "l"(rd138));
  // PTX:439 add.s64 %rd418, %rd419, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd418) : "l"(rd419));
  // PTX:440 add.s64 %rd417, %rd419, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd417) : "l"(rd419));
  // PTX:442 $L__BB77_47:
L_BB77_47:;
  // PTX:443 ld.global.u32 %r626, [%rd419]
  r626 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd419) + (0)))));
  // PTX:444 ld.global.u32 %r625, [%rd418]
  r625 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd418) + (0)))));
  // PTX:445 ld.global.u32 %r624, [%rd417]
  r624 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd417) + (0)))));
  // PTX:446 setp.eq.s32 %p61, %r43, 3
  p61 = (((int)(r43)) == ((int)(3)));
  // PTX:447 @%p61 bra $L__BB77_49
  if (p61) { goto L_BB77_49; }
  // PTX:448 bra.uni $L__BB77_48
  goto L_BB77_48;
  // PTX:450 $L__BB77_49:
L_BB77_49:;
  // PTX:451 ld.param.u64 %rd394, [%rd2+104]
  rd394 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (104))));
  // PTX:452 cvta.to.global.u64 %rd393, %rd394
  rd393 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd394));
  // PTX:453 cvt.s64.s32 %rd358, %rd423
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd358) : "l"(rd423));
  // PTX:454 mul.lo.s64 %rd152, %rd358, 28
  asm("mul.lo.s64 %0, %1, 28;" : "=l"(rd152) : "l"(rd358));
  // PTX:455 add.s64 %rd422, %rd393, %rd152
  asm("add.s64 %0, %1, %2;" : "=l"(rd422) : "l"(rd393), "l"(rd152));
  // PTX:456 add.s64 %rd421, %rd422, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd421) : "l"(rd422));
  // PTX:457 add.s64 %rd420, %rd422, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd420) : "l"(rd422));
  // PTX:458 bra.uni $L__BB77_50
  goto L_BB77_50;
  // PTX:460 $L__BB77_48:
L_BB77_48:;
  // PTX:461 ld.param.u64 %rd355, [%rd2+32]
  rd355 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (32))));
  // PTX:462 cvta.to.global.u64 %rd354, %rd355
  rd354 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd355));
  // PTX:463 add.s64 %rd422, %rd354, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd422) : "l"(rd354), "l"(rd138));
  // PTX:464 add.s64 %rd421, %rd422, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd421) : "l"(rd422));
  // PTX:465 add.s64 %rd420, %rd422, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd420) : "l"(rd422));
  // PTX:467 $L__BB77_50:
L_BB77_50:;
  // PTX:468 setp.lt.s32 %p149, %r639, 0
  p149 = (((int)(r639)) < ((int)(0)));
  // PTX:469 ld.global.u32 %r623, [%rd422]
  r623 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd422) + (0)))));
  // PTX:470 ld.global.u32 %r622, [%rd421]
  r622 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd421) + (0)))));
  // PTX:471 ld.global.u32 %r621, [%rd420]
  r621 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd420) + (0)))));
  // PTX:472 mov.u32 %r535, %r624
  asm("mov.u32 %0, %1;" : "=r"(r535) : "r"(r624));
  // PTX:473 mov.u32 %r536, %r625
  asm("mov.u32 %0, %1;" : "=r"(r536) : "r"(r625));
  // PTX:474 mov.u32 %r537, %r626
  asm("mov.u32 %0, %1;" : "=r"(r537) : "r"(r626));
  // PTX:475 @%p149 bra $L__BB77_52
  if (p149) { goto L_BB77_52; }
  // PTX:477 ld.param.u64 %rd400, [%rd2+208]
  rd400 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (208))));
  // PTX:478 mul.wide.s32 %rd399, %r636, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd399) : "r"(r636));
  // PTX:479 cvta.to.global.u64 %rd398, %rd400
  rd398 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd400));
  // PTX:480 add.s64 %rd397, %rd398, %rd399
  asm("add.s64 %0, %1, %2;" : "=l"(rd397) : "l"(rd398), "l"(rd399));
  // PTX:481 ld.param.u64 %rd365, [%rd2+208]
  rd365 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (208))));
  // PTX:482 cvta.to.global.u64 %rd364, %rd365
  rd364 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd365));
  // PTX:483 mul.wide.s32 %rd363, %r634, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd363) : "r"(r634));
  // PTX:484 add.s64 %rd362, %rd364, %rd363
  asm("add.s64 %0, %1, %2;" : "=l"(rd362) : "l"(rd364), "l"(rd363));
  // PTX:485 mul.wide.s32 %rd361, %r635, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd361) : "r"(r635));
  // PTX:486 add.s64 %rd360, %rd364, %rd361
  asm("add.s64 %0, %1, %2;" : "=l"(rd360) : "l"(rd364), "l"(rd361));
  // PTX:487 ld.param.u64 %rd357, [%rd2+184]
  rd357 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (184))));
  // PTX:488 cvta.to.global.u64 %rd356, %rd357
  rd356 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd357));
  // PTX:489 mul.wide.s32 %rd156, %r639, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd156) : "r"(r639));
  // PTX:490 add.s64 %rd157, %rd356, %rd156
  asm("add.s64 %0, %1, %2;" : "=l"(rd157) : "l"(rd356), "l"(rd156));
  // PTX:491 mov.b32 %f254, %r626
  asm("mov.b32 %0, %1;" : "=f"(f254) : "r"(r626));
  // PTX:492 ld.global.f32 %f255, [%rd157]
  f255 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd157) + (0)))));
  // PTX:493 sub.f32 %f256, %f254, %f255
  asm("sub.f32 %0, %1, %2;" : "=f"(f256) : "f"(f254), "f"(f255));
  // PTX:494 mov.b32 %f257, %r625
  asm("mov.b32 %0, %1;" : "=f"(f257) : "r"(r625));
  // PTX:495 ld.global.f32 %f258, [%rd157+4]
  f258 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd157) + (4)))));
  // PTX:496 sub.f32 %f259, %f257, %f258
  asm("sub.f32 %0, %1, %2;" : "=f"(f259) : "f"(f257), "f"(f258));
  // PTX:497 mov.b32 %f260, %r624
  asm("mov.b32 %0, %1;" : "=f"(f260) : "r"(r624));
  // PTX:498 ld.global.f32 %f261, [%rd157+8]
  f261 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd157) + (8)))));
  // PTX:499 sub.f32 %f262, %f260, %f261
  asm("sub.f32 %0, %1, %2;" : "=f"(f262) : "f"(f260), "f"(f261));
  // PTX:500 mul.wide.s32 %rd158, %r637, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd158) : "r"(r637));
  // PTX:501 add.s64 %rd159, %rd364, %rd158
  asm("add.s64 %0, %1, %2;" : "=l"(rd159) : "l"(rd364), "l"(rd158));
  // PTX:502 ld.global.f32 %f263, [%rd397]
  f263 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd397) + (0)))));
  // PTX:503 ld.global.f32 %f264, [%rd397+4]
  f264 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd397) + (4)))));
  // PTX:504 ld.global.f32 %f265, [%rd397+8]
  f265 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd397) + (8)))));
  // PTX:505 ld.global.f32 %f266, [%rd159]
  f266 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd159) + (0)))));
  // PTX:506 fma.rn.f32 %f267, %f256, %f263, %f266
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f267) : "f"(f256), "f"(f263), "f"(f266));
  // PTX:507 ld.global.f32 %f268, [%rd159+4]
  f268 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd159) + (4)))));
  // PTX:508 fma.rn.f32 %f269, %f256, %f264, %f268
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f269) : "f"(f256), "f"(f264), "f"(f268));
  // PTX:509 ld.global.f32 %f270, [%rd159+8]
  f270 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd159) + (8)))));
  // PTX:510 fma.rn.f32 %f271, %f256, %f265, %f270
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f271) : "f"(f256), "f"(f265), "f"(f270));
  // PTX:511 ld.global.f32 %f272, [%rd360]
  f272 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd360) + (0)))));
  // PTX:512 ld.global.f32 %f273, [%rd360+4]
  f273 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd360) + (4)))));
  // PTX:513 ld.global.f32 %f274, [%rd360+8]
  f274 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd360) + (8)))));
  // PTX:514 fma.rn.f32 %f275, %f259, %f272, %f267
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f275) : "f"(f259), "f"(f272), "f"(f267));
  // PTX:515 fma.rn.f32 %f276, %f259, %f273, %f269
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f276) : "f"(f259), "f"(f273), "f"(f269));
  // PTX:516 fma.rn.f32 %f277, %f259, %f274, %f271
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f277) : "f"(f259), "f"(f274), "f"(f271));
  // PTX:517 ld.global.f32 %f278, [%rd362]
  f278 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd362) + (0)))));
  // PTX:518 ld.global.f32 %f279, [%rd362+4]
  f279 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd362) + (4)))));
  // PTX:519 ld.global.f32 %f280, [%rd362+8]
  f280 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd362) + (8)))));
  // PTX:520 fma.rn.f32 %f281, %f262, %f278, %f275
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f281) : "f"(f262), "f"(f278), "f"(f275));
  // PTX:521 fma.rn.f32 %f282, %f262, %f279, %f276
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f282) : "f"(f262), "f"(f279), "f"(f276));
  // PTX:522 fma.rn.f32 %f283, %f262, %f280, %f277
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f283) : "f"(f262), "f"(f280), "f"(f277));
  // PTX:523 mov.b32 %r537, %f281
  asm("mov.b32 %0, %1;" : "=r"(r537) : "f"(f281));
  // PTX:524 mov.b32 %r536, %f282
  asm("mov.b32 %0, %1;" : "=r"(r536) : "f"(f282));
  // PTX:525 mov.b32 %r535, %f283
  asm("mov.b32 %0, %1;" : "=r"(r535) : "f"(f283));
  // PTX:527 $L__BB77_52:
L_BB77_52:;
  // PTX:528 setp.lt.s32 %p138, %r638, 0
  p138 = (((int)(r638)) < ((int)(0)));
  // PTX:529 mov.u32 %r538, %r621
  asm("mov.u32 %0, %1;" : "=r"(r538) : "r"(r621));
  // PTX:530 mov.u32 %r539, %r622
  asm("mov.u32 %0, %1;" : "=r"(r539) : "r"(r622));
  // PTX:531 mov.u32 %r540, %r623
  asm("mov.u32 %0, %1;" : "=r"(r540) : "r"(r623));
  // PTX:532 @%p138 bra $L__BB77_54
  if (p138) { goto L_BB77_54; }
  // PTX:534 ld.param.u64 %rd408, [%rd2+208]
  rd408 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (208))));
  // PTX:535 cvta.to.global.u64 %rd407, %rd408
  rd407 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd408));
  // PTX:536 mul.wide.s32 %rd406, %r630, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd406) : "r"(r630));
  // PTX:537 add.s64 %rd405, %rd407, %rd406
  asm("add.s64 %0, %1, %2;" : "=l"(rd405) : "l"(rd407), "l"(rd406));
  // PTX:538 mul.wide.s32 %rd404, %r631, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd404) : "r"(r631));
  // PTX:539 add.s64 %rd403, %rd407, %rd404
  asm("add.s64 %0, %1, %2;" : "=l"(rd403) : "l"(rd407), "l"(rd404));
  // PTX:540 mul.wide.s32 %rd402, %r632, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd402) : "r"(r632));
  // PTX:541 add.s64 %rd401, %rd407, %rd402
  asm("add.s64 %0, %1, %2;" : "=l"(rd401) : "l"(rd407), "l"(rd402));
  // PTX:542 ld.param.u64 %rd392, [%rd2+208]
  rd392 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (208))));
  // PTX:543 cvta.to.global.u64 %rd391, %rd392
  rd391 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd392));
  // PTX:544 ld.param.u64 %rd327, [%rd2+184]
  rd327 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (184))));
  // PTX:545 cvta.to.global.u64 %rd326, %rd327
  rd326 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd327));
  // PTX:546 mul.wide.s32 %rd163, %r638, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd163) : "r"(r638));
  // PTX:547 add.s64 %rd164, %rd326, %rd163
  asm("add.s64 %0, %1, %2;" : "=l"(rd164) : "l"(rd326), "l"(rd163));
  // PTX:548 mov.b32 %f284, %r623
  asm("mov.b32 %0, %1;" : "=f"(f284) : "r"(r623));
  // PTX:549 ld.global.f32 %f285, [%rd164]
  f285 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd164) + (0)))));
  // PTX:550 sub.f32 %f286, %f284, %f285
  asm("sub.f32 %0, %1, %2;" : "=f"(f286) : "f"(f284), "f"(f285));
  // PTX:551 mov.b32 %f287, %r622
  asm("mov.b32 %0, %1;" : "=f"(f287) : "r"(r622));
  // PTX:552 ld.global.f32 %f288, [%rd164+4]
  f288 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd164) + (4)))));
  // PTX:553 sub.f32 %f289, %f287, %f288
  asm("sub.f32 %0, %1, %2;" : "=f"(f289) : "f"(f287), "f"(f288));
  // PTX:554 mov.b32 %f290, %r621
  asm("mov.b32 %0, %1;" : "=f"(f290) : "r"(r621));
  // PTX:555 ld.global.f32 %f291, [%rd164+8]
  f291 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd164) + (8)))));
  // PTX:556 sub.f32 %f292, %f290, %f291
  asm("sub.f32 %0, %1, %2;" : "=f"(f292) : "f"(f290), "f"(f291));
  // PTX:557 mul.wide.s32 %rd165, %r633, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd165) : "r"(r633));
  // PTX:558 add.s64 %rd166, %rd391, %rd165
  asm("add.s64 %0, %1, %2;" : "=l"(rd166) : "l"(rd391), "l"(rd165));
  // PTX:559 ld.global.f32 %f293, [%rd401]
  f293 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd401) + (0)))));
  // PTX:560 ld.global.f32 %f294, [%rd401+4]
  f294 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd401) + (4)))));
  // PTX:561 ld.global.f32 %f295, [%rd401+8]
  f295 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd401) + (8)))));
  // PTX:562 ld.global.f32 %f296, [%rd166]
  f296 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (0)))));
  // PTX:563 fma.rn.f32 %f297, %f286, %f293, %f296
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f297) : "f"(f286), "f"(f293), "f"(f296));
  // PTX:564 ld.global.f32 %f298, [%rd166+4]
  f298 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (4)))));
  // PTX:565 fma.rn.f32 %f299, %f286, %f294, %f298
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f299) : "f"(f286), "f"(f294), "f"(f298));
  // PTX:566 ld.global.f32 %f300, [%rd166+8]
  f300 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd166) + (8)))));
  // PTX:567 fma.rn.f32 %f301, %f286, %f295, %f300
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f301) : "f"(f286), "f"(f295), "f"(f300));
  // PTX:568 ld.global.f32 %f302, [%rd403]
  f302 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd403) + (0)))));
  // PTX:569 ld.global.f32 %f303, [%rd403+4]
  f303 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd403) + (4)))));
  // PTX:570 ld.global.f32 %f304, [%rd403+8]
  f304 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd403) + (8)))));
  // PTX:571 fma.rn.f32 %f305, %f289, %f302, %f297
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f305) : "f"(f289), "f"(f302), "f"(f297));
  // PTX:572 fma.rn.f32 %f306, %f289, %f303, %f299
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f306) : "f"(f289), "f"(f303), "f"(f299));
  // PTX:573 fma.rn.f32 %f307, %f289, %f304, %f301
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f307) : "f"(f289), "f"(f304), "f"(f301));
  // PTX:574 ld.global.f32 %f308, [%rd405]
  f308 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd405) + (0)))));
  // PTX:575 ld.global.f32 %f309, [%rd405+4]
  f309 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd405) + (4)))));
  // PTX:576 ld.global.f32 %f310, [%rd405+8]
  f310 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd405) + (8)))));
  // PTX:577 fma.rn.f32 %f311, %f292, %f308, %f305
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f311) : "f"(f292), "f"(f308), "f"(f305));
  // PTX:578 fma.rn.f32 %f312, %f292, %f309, %f306
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f312) : "f"(f292), "f"(f309), "f"(f306));
  // PTX:579 fma.rn.f32 %f313, %f292, %f310, %f307
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f313) : "f"(f292), "f"(f310), "f"(f307));
  // PTX:580 mov.b32 %r540, %f311
  asm("mov.b32 %0, %1;" : "=r"(r540) : "f"(f311));
  // PTX:581 mov.b32 %r539, %f312
  asm("mov.b32 %0, %1;" : "=r"(r539) : "f"(f312));
  // PTX:582 mov.b32 %r538, %f313
  asm("mov.b32 %0, %1;" : "=r"(r538) : "f"(f313));
  // PTX:584 $L__BB77_54:
L_BB77_54:;
  // PTX:585 setp.ne.s32 %p64, %r42, 3
  p64 = (((int)(r42)) != ((int)(3)));
  // PTX:586 setp.ne.s32 %p65, %r43, 3
  p65 = (((int)(r43)) != ((int)(3)));
  // PTX:587 mov.u32 %r629, 0
  asm("mov.u32 %0, 0;" : "=r"(r629) : );
  // PTX:588 or.pred %p66, %p64, %p65
  p66 = ((p64) || (p65));
  // PTX:589 mov.u32 %r628, %r629
  asm("mov.u32 %0, %1;" : "=r"(r628) : "r"(r629));
  // PTX:590 mov.u32 %r627, %r629
  asm("mov.u32 %0, %1;" : "=r"(r627) : "r"(r629));
  // PTX:591 @%p66 bra $L__BB77_57
  if (p66) { goto L_BB77_57; }
  // PTX:593 mov.b32 %f314, %r540
  asm("mov.b32 %0, %1;" : "=f"(f314) : "r"(r540));
  // PTX:594 mov.b32 %f315, %r537
  asm("mov.b32 %0, %1;" : "=f"(f315) : "r"(r537));
  // PTX:595 sub.f32 %f5, %f314, %f315
  asm("sub.f32 %0, %1, %2;" : "=f"(f5) : "f"(f314), "f"(f315));
  // PTX:596 mov.b32 %f316, %r536
  asm("mov.b32 %0, %1;" : "=f"(f316) : "r"(r536));
  // PTX:597 mov.b32 %f317, %r539
  asm("mov.b32 %0, %1;" : "=f"(f317) : "r"(r539));
  // PTX:598 sub.f32 %f6, %f317, %f316
  asm("sub.f32 %0, %1, %2;" : "=f"(f6) : "f"(f317), "f"(f316));
  // PTX:599 mov.b32 %f318, %r535
  asm("mov.b32 %0, %1;" : "=f"(f318) : "r"(r535));
  // PTX:600 mov.b32 %f319, %r538
  asm("mov.b32 %0, %1;" : "=f"(f319) : "r"(r538));
  // PTX:601 sub.f32 %f7, %f319, %f318
  asm("sub.f32 %0, %1, %2;" : "=f"(f7) : "f"(f319), "f"(f318));
  // PTX:602 mul.f32 %f320, %f6, %f6
  asm("mul.f32 %0, %1, %2;" : "=f"(f320) : "f"(f6), "f"(f6));
  // PTX:603 fma.rn.f32 %f321, %f5, %f5, %f320
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f321) : "f"(f5), "f"(f5), "f"(f320));
  // PTX:604 fma.rn.f32 %f322, %f7, %f7, %f321
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f322) : "f"(f7), "f"(f7), "f"(f321));
  // PTX:605 sqrt.rn.f32 %f8, %f322
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f8) : "f"(f322));
  // PTX:606 setp.leu.f32 %p67, %f8, 0f00000000
  p67 = ((isnan(((float)(f8))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f8)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:607 mov.u32 %r629, 0
  asm("mov.u32 %0, 0;" : "=r"(r629) : );
  // PTX:608 @%p67 bra $L__BB77_57
  if (p67) { goto L_BB77_57; }
  // PTX:610 div.rn.f32 %f323, %f5, %f8
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f323) : "f"(f5), "f"(f8));
  // PTX:611 div.rn.f32 %f324, %f6, %f8
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f324) : "f"(f6), "f"(f8));
  // PTX:612 div.rn.f32 %f325, %f7, %f8
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f325) : "f"(f7), "f"(f8));
  // PTX:613 mov.b32 %r627, %f325
  asm("mov.b32 %0, %1;" : "=r"(r627) : "f"(f325));
  // PTX:614 mov.b32 %r628, %f324
  asm("mov.b32 %0, %1;" : "=r"(r628) : "f"(f324));
  // PTX:615 mov.b32 %r629, %f323
  asm("mov.b32 %0, %1;" : "=r"(r629) : "f"(f323));
  // PTX:617 $L__BB77_57:
L_BB77_57:;
  // PTX:618 mov.b32 %f1032, %r629
  asm("mov.b32 %0, %1;" : "=f"(f1032) : "r"(r629));
  // PTX:619 mov.b32 %f1031, %r628
  asm("mov.b32 %0, %1;" : "=f"(f1031) : "r"(r628));
  // PTX:620 mul.f32 %f326, %f1031, %f1031
  asm("mul.f32 %0, %1, %2;" : "=f"(f326) : "f"(f1031), "f"(f1031));
  // PTX:621 mov.b32 %f1030, %r627
  asm("mov.b32 %0, %1;" : "=f"(f1030) : "r"(r627));
  // PTX:622 fma.rn.f32 %f327, %f1032, %f1032, %f326
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f327) : "f"(f1032), "f"(f1032), "f"(f326));
  // PTX:623 fma.rn.f32 %f1029, %f1030, %f1030, %f327
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1029) : "f"(f1030), "f"(f1030), "f"(f327));
  // PTX:624 setp.ge.f32 %p68, %f1029, 0f3F000000
  p68 = (!(isnan(((float)(f1029))) || isnan(((float)(as_f32(0x3F000000u))))) && (((float)(f1029)) >= ((float)(as_f32(0x3F000000u)))));
  // PTX:625 @%p68 bra $L__BB77_59
  if (p68) { goto L_BB77_59; }
  // PTX:627 mov.b32 %f1032, %r532
  asm("mov.b32 %0, %1;" : "=f"(f1032) : "r"(r532));
  // PTX:628 mov.b32 %f1031, %r533
  asm("mov.b32 %0, %1;" : "=f"(f1031) : "r"(r533));
  // PTX:629 mul.f32 %f328, %f1031, %f1031
  asm("mul.f32 %0, %1, %2;" : "=f"(f328) : "f"(f1031), "f"(f1031));
  // PTX:630 mov.b32 %f1030, %r534
  asm("mov.b32 %0, %1;" : "=f"(f1030) : "r"(r534));
  // PTX:631 fma.rn.f32 %f329, %f1032, %f1032, %f328
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f329) : "f"(f1032), "f"(f1032), "f"(f328));
  // PTX:632 fma.rn.f32 %f1029, %f1030, %f1030, %f329
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1029) : "f"(f1030), "f"(f1030), "f"(f329));
  // PTX:633 mov.u32 %r627, %r534
  asm("mov.u32 %0, %1;" : "=r"(r627) : "r"(r534));
  // PTX:634 mov.u32 %r628, %r533
  asm("mov.u32 %0, %1;" : "=r"(r628) : "r"(r533));
  // PTX:635 mov.u32 %r629, %r532
  asm("mov.u32 %0, %1;" : "=r"(r629) : "r"(r532));
  // PTX:637 $L__BB77_59:
L_BB77_59:;
  // PTX:638 mov.pred %p150, -1
  p150 = ((-1) != 0);
  // PTX:639 mov.f32 %f1081, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1081) : );
  // PTX:640 setp.ltu.f32 %p70, %f1029, 0f3F000000
  p70 = ((isnan(((float)(f1029))) || isnan(((float)(as_f32(0x3F000000u))))) || (((float)(f1029)) < ((float)(as_f32(0x3F000000u)))));
  // PTX:641 @%p70 bra $L__BB77_122
  if (p70) { goto L_BB77_122; }
  // PTX:643 @%p64 bra $L__BB77_84
  if (p64) { goto L_BB77_84; }
  // PTX:645 setp.lt.s32 %p137, %r639, 0
  p137 = (((int)(r639)) < ((int)(0)));
  // PTX:646 ld.param.u64 %rd331, [%rd2+112]
  rd331 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (112))));
  // PTX:647 cvta.to.global.u64 %rd330, %rd331
  rd330 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd331));
  // PTX:648 cvt.s64.s32 %rd329, %rd424
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd329) : "l"(rd424));
  // PTX:649 mul.lo.s64 %rd167, %rd329, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd167) : "l"(rd329));
  // PTX:650 add.s64 %rd70, %rd330, %rd167
  asm("add.s64 %0, %1, %2;" : "=l"(rd70) : "l"(rd330), "l"(rd167));
  // PTX:651 @%p137 bra $L__BB77_83
  if (p137) { goto L_BB77_83; }
  // PTX:653 ld.param.u64 %rd340, [%rd2+208]
  rd340 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (208))));
  // PTX:654 cvta.to.global.u64 %rd339, %rd340
  rd339 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd340));
  // PTX:655 mul.wide.s32 %rd338, %r634, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd338) : "r"(r634));
  // PTX:656 add.s64 %rd337, %rd339, %rd338
  asm("add.s64 %0, %1, %2;" : "=l"(rd337) : "l"(rd339), "l"(rd338));
  // PTX:657 mul.wide.s32 %rd336, %r635, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd336) : "r"(r635));
  // PTX:658 add.s64 %rd335, %rd339, %rd336
  asm("add.s64 %0, %1, %2;" : "=l"(rd335) : "l"(rd339), "l"(rd336));
  // PTX:659 mul.wide.s32 %rd334, %r636, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd334) : "r"(r636));
  // PTX:660 add.s64 %rd333, %rd339, %rd334
  asm("add.s64 %0, %1, %2;" : "=l"(rd333) : "l"(rd339), "l"(rd334));
  // PTX:661 ld.global.f32 %f331, [%rd70]
  f331 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))));
  // PTX:662 ld.global.f32 %f24, [%rd337+8]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd337) + (8)))));
  // PTX:663 ld.global.f32 %f25, [%rd335+4]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd335) + (4)))));
  // PTX:664 mul.f32 %f332, %f25, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f332) : "f"(f25), "f"(f24));
  // PTX:665 ld.global.f32 %f26, [%rd337+4]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd337) + (4)))));
  // PTX:666 ld.global.f32 %f27, [%rd335+8]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd335) + (8)))));
  // PTX:667 mul.f32 %f333, %f27, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f333) : "f"(f27), "f"(f26));
  // PTX:668 sub.f32 %f28, %f332, %f333
  asm("sub.f32 %0, %1, %2;" : "=f"(f28) : "f"(f332), "f"(f333));
  // PTX:669 ld.global.f32 %f29, [%rd337]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd337) + (0)))));
  // PTX:670 mul.f32 %f334, %f27, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f334) : "f"(f27), "f"(f29));
  // PTX:671 ld.global.f32 %f30, [%rd335]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd335) + (0)))));
  // PTX:672 mul.f32 %f335, %f30, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f335) : "f"(f30), "f"(f24));
  // PTX:673 sub.f32 %f31, %f334, %f335
  asm("sub.f32 %0, %1, %2;" : "=f"(f31) : "f"(f334), "f"(f335));
  // PTX:674 mul.f32 %f336, %f30, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f336) : "f"(f30), "f"(f26));
  // PTX:675 mul.f32 %f337, %f25, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f337) : "f"(f25), "f"(f29));
  // PTX:676 sub.f32 %f32, %f336, %f337
  asm("sub.f32 %0, %1, %2;" : "=f"(f32) : "f"(f336), "f"(f337));
  // PTX:677 ld.global.f32 %f33, [%rd333]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd333) + (0)))));
  // PTX:678 ld.global.f32 %f34, [%rd333+4]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd333) + (4)))));
  // PTX:679 mul.f32 %f338, %f34, %f31
  asm("mul.f32 %0, %1, %2;" : "=f"(f338) : "f"(f34), "f"(f31));
  // PTX:680 ld.global.f32 %f35, [%rd333+8]
  f35 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd333) + (8)))));
  // PTX:681 fma.rn.f32 %f339, %f33, %f28, %f338
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f339) : "f"(f33), "f"(f28), "f"(f338));
  // PTX:682 fma.rn.f32 %f36, %f35, %f32, %f339
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f35), "f"(f32), "f"(f339));
  // PTX:683 abs.f32 %f340, %f36
  asm("abs.f32 %0, %1;" : "=f"(f340) : "f"(f36));
  // PTX:684 setp.leu.f32 %p73, %f340, 0f2EDBE6FF
  p73 = ((isnan(((float)(f340))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) || (((float)(f340)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:685 setp.geu.f32 %p74, %f340, 0f7F800000
  p74 = ((isnan(((float)(f340))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f340)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:686 or.pred %p75, %p73, %p74
  p75 = ((p73) || (p74));
  // PTX:687 @%p75 bra $L__BB77_64
  if (p75) { goto L_BB77_64; }
  // PTX:688 bra.uni $L__BB77_63
  goto L_BB77_63;
  // PTX:690 $L__BB77_64:
L_BB77_64:;
  // PTX:691 mul.f32 %f378, %f34, %f34
  asm("mul.f32 %0, %1, %2;" : "=f"(f378) : "f"(f34), "f"(f34));
  // PTX:692 fma.rn.f32 %f379, %f33, %f33, %f378
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f379) : "f"(f33), "f"(f33), "f"(f378));
  // PTX:693 fma.rn.f32 %f380, %f35, %f35, %f379
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f380) : "f"(f35), "f"(f35), "f"(f379));
  // PTX:694 mul.f32 %f381, %f25, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f381) : "f"(f25), "f"(f25));
  // PTX:695 fma.rn.f32 %f382, %f30, %f30, %f381
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f382) : "f"(f30), "f"(f30), "f"(f381));
  // PTX:696 fma.rn.f32 %f383, %f27, %f27, %f382
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f383) : "f"(f27), "f"(f27), "f"(f382));
  // PTX:697 add.f32 %f384, %f380, %f383
  asm("add.f32 %0, %1, %2;" : "=f"(f384) : "f"(f380), "f"(f383));
  // PTX:698 mul.f32 %f385, %f26, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f385) : "f"(f26), "f"(f26));
  // PTX:699 fma.rn.f32 %f386, %f29, %f29, %f385
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f386) : "f"(f29), "f"(f29), "f"(f385));
  // PTX:700 fma.rn.f32 %f387, %f24, %f24, %f386
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f387) : "f"(f24), "f"(f24), "f"(f386));
  // PTX:701 add.f32 %f388, %f384, %f387
  asm("add.f32 %0, %1, %2;" : "=f"(f388) : "f"(f384), "f"(f387));
  // PTX:702 div.rn.f32 %f389, %f388, 0f40400000
  asm("div.rn.f32 %0, %1, 0f40400000;" : "=f"(f389) : "f"(f388));
  // PTX:703 sqrt.rn.f32 %f37, %f389
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f37) : "f"(f389));
  // PTX:704 setp.leu.f32 %p76, %f37, 0f322BCC77
  p76 = ((isnan(((float)(f37))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f37)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:705 mov.u32 %r566, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r566) : );
  // PTX:706 mov.u32 %r567, 0
  asm("mov.u32 %0, 0;" : "=r"(r567) : );
  // PTX:707 mov.u32 %r568, %r567
  asm("mov.u32 %0, %1;" : "=r"(r568) : "r"(r567));
  // PTX:708 mov.u32 %r569, %r567
  asm("mov.u32 %0, %1;" : "=r"(r569) : "r"(r567));
  // PTX:709 mov.u32 %r570, %r566
  asm("mov.u32 %0, %1;" : "=r"(r570) : "r"(r566));
  // PTX:710 mov.u32 %r571, %r567
  asm("mov.u32 %0, %1;" : "=r"(r571) : "r"(r567));
  // PTX:711 mov.u32 %r572, %r567
  asm("mov.u32 %0, %1;" : "=r"(r572) : "r"(r567));
  // PTX:712 mov.u32 %r573, %r567
  asm("mov.u32 %0, %1;" : "=r"(r573) : "r"(r567));
  // PTX:713 mov.u32 %r574, %r566
  asm("mov.u32 %0, %1;" : "=r"(r574) : "r"(r566));
  // PTX:714 @%p76 bra $L__BB77_81
  if (p76) { goto L_BB77_81; }
  // PTX:716 abs.f32 %f390, %f37
  asm("abs.f32 %0, %1;" : "=f"(f390) : "f"(f37));
  // PTX:717 setp.geu.f32 %p77, %f390, 0f7F800000
  p77 = ((isnan(((float)(f390))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f390)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:718 @%p77 bra $L__BB77_81
  if (p77) { goto L_BB77_81; }
  // PTX:720 rcp.rn.f32 %f391, %f37
  asm("rcp.rn.f32 %0, %1;" : "=f"(f391) : "f"(f37));
  // PTX:721 mul.f32 %f1042, %f33, %f391
  asm("mul.f32 %0, %1, %2;" : "=f"(f1042) : "f"(f33), "f"(f391));
  // PTX:722 mul.f32 %f1043, %f34, %f391
  asm("mul.f32 %0, %1, %2;" : "=f"(f1043) : "f"(f34), "f"(f391));
  // PTX:723 mul.f32 %f1044, %f35, %f391
  asm("mul.f32 %0, %1, %2;" : "=f"(f1044) : "f"(f35), "f"(f391));
  // PTX:724 mul.f32 %f1045, %f30, %f391
  asm("mul.f32 %0, %1, %2;" : "=f"(f1045) : "f"(f30), "f"(f391));
  // PTX:725 mul.f32 %f1046, %f25, %f391
  asm("mul.f32 %0, %1, %2;" : "=f"(f1046) : "f"(f25), "f"(f391));
  // PTX:726 mul.f32 %f1047, %f27, %f391
  asm("mul.f32 %0, %1, %2;" : "=f"(f1047) : "f"(f27), "f"(f391));
  // PTX:727 mul.f32 %f1048, %f29, %f391
  asm("mul.f32 %0, %1, %2;" : "=f"(f1048) : "f"(f29), "f"(f391));
  // PTX:728 mul.f32 %f1049, %f26, %f391
  asm("mul.f32 %0, %1, %2;" : "=f"(f1049) : "f"(f26), "f"(f391));
  // PTX:729 mul.f32 %f1050, %f24, %f391
  asm("mul.f32 %0, %1, %2;" : "=f"(f1050) : "f"(f24), "f"(f391));
  // PTX:730 mov.u32 %r550, 0
  asm("mov.u32 %0, 0;" : "=r"(r550) : );
  // PTX:732 $L__BB77_67:
L_BB77_67:;
  // PTX:733 mul.f32 %f392, %f1047, %f1049
  asm("mul.f32 %0, %1, %2;" : "=f"(f392) : "f"(f1047), "f"(f1049));
  // PTX:734 mul.f32 %f393, %f1046, %f1050
  asm("mul.f32 %0, %1, %2;" : "=f"(f393) : "f"(f1046), "f"(f1050));
  // PTX:735 sub.f32 %f56, %f393, %f392
  asm("sub.f32 %0, %1, %2;" : "=f"(f56) : "f"(f393), "f"(f392));
  // PTX:736 mul.f32 %f394, %f1045, %f1050
  asm("mul.f32 %0, %1, %2;" : "=f"(f394) : "f"(f1045), "f"(f1050));
  // PTX:737 mul.f32 %f395, %f1047, %f1048
  asm("mul.f32 %0, %1, %2;" : "=f"(f395) : "f"(f1047), "f"(f1048));
  // PTX:738 sub.f32 %f57, %f395, %f394
  asm("sub.f32 %0, %1, %2;" : "=f"(f57) : "f"(f395), "f"(f394));
  // PTX:739 mul.f32 %f396, %f1046, %f1048
  asm("mul.f32 %0, %1, %2;" : "=f"(f396) : "f"(f1046), "f"(f1048));
  // PTX:740 mul.f32 %f397, %f1045, %f1049
  asm("mul.f32 %0, %1, %2;" : "=f"(f397) : "f"(f1045), "f"(f1049));
  // PTX:741 sub.f32 %f58, %f397, %f396
  asm("sub.f32 %0, %1, %2;" : "=f"(f58) : "f"(f397), "f"(f396));
  // PTX:742 mul.f32 %f398, %f1043, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f398) : "f"(f1043), "f"(f57));
  // PTX:743 fma.rn.f32 %f399, %f1042, %f56, %f398
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f399) : "f"(f1042), "f"(f56), "f"(f398));
  // PTX:744 fma.rn.f32 %f59, %f1044, %f58, %f399
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f59) : "f"(f1044), "f"(f58), "f"(f399));
  // PTX:745 abs.f32 %f400, %f59
  asm("abs.f32 %0, %1;" : "=f"(f400) : "f"(f59));
  // PTX:746 setp.le.f32 %p78, %f400, 0f2EDBE6FF
  p78 = (!(isnan(((float)(f400))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f400)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:747 setp.geu.f32 %p79, %f400, 0f7F800000
  p79 = ((isnan(((float)(f400))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f400)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:748 or.pred %p80, %p78, %p79
  p80 = ((p78) || (p79));
  // PTX:749 @%p80 bra $L__BB77_70
  if (p80) { goto L_BB77_70; }
  // PTX:751 rcp.rn.f32 %f401, %f59
  asm("rcp.rn.f32 %0, %1;" : "=f"(f401) : "f"(f59));
  // PTX:752 mul.f32 %f402, %f1043, %f1050
  asm("mul.f32 %0, %1, %2;" : "=f"(f402) : "f"(f1043), "f"(f1050));
  // PTX:753 mul.f32 %f403, %f1044, %f1049
  asm("mul.f32 %0, %1, %2;" : "=f"(f403) : "f"(f1044), "f"(f1049));
  // PTX:754 sub.f32 %f404, %f403, %f402
  asm("sub.f32 %0, %1, %2;" : "=f"(f404) : "f"(f403), "f"(f402));
  // PTX:755 mul.f32 %f405, %f1044, %f1048
  asm("mul.f32 %0, %1, %2;" : "=f"(f405) : "f"(f1044), "f"(f1048));
  // PTX:756 mul.f32 %f406, %f1042, %f1050
  asm("mul.f32 %0, %1, %2;" : "=f"(f406) : "f"(f1042), "f"(f1050));
  // PTX:757 sub.f32 %f407, %f406, %f405
  asm("sub.f32 %0, %1, %2;" : "=f"(f407) : "f"(f406), "f"(f405));
  // PTX:758 mul.f32 %f408, %f1042, %f1049
  asm("mul.f32 %0, %1, %2;" : "=f"(f408) : "f"(f1042), "f"(f1049));
  // PTX:759 mul.f32 %f409, %f1043, %f1048
  asm("mul.f32 %0, %1, %2;" : "=f"(f409) : "f"(f1043), "f"(f1048));
  // PTX:760 sub.f32 %f410, %f409, %f408
  asm("sub.f32 %0, %1, %2;" : "=f"(f410) : "f"(f409), "f"(f408));
  // PTX:761 mul.f32 %f411, %f1044, %f1046
  asm("mul.f32 %0, %1, %2;" : "=f"(f411) : "f"(f1044), "f"(f1046));
  // PTX:762 mul.f32 %f412, %f1043, %f1047
  asm("mul.f32 %0, %1, %2;" : "=f"(f412) : "f"(f1043), "f"(f1047));
  // PTX:763 sub.f32 %f413, %f412, %f411
  asm("sub.f32 %0, %1, %2;" : "=f"(f413) : "f"(f412), "f"(f411));
  // PTX:764 mul.f32 %f414, %f1042, %f1047
  asm("mul.f32 %0, %1, %2;" : "=f"(f414) : "f"(f1042), "f"(f1047));
  // PTX:765 mul.f32 %f415, %f1044, %f1045
  asm("mul.f32 %0, %1, %2;" : "=f"(f415) : "f"(f1044), "f"(f1045));
  // PTX:766 sub.f32 %f416, %f415, %f414
  asm("sub.f32 %0, %1, %2;" : "=f"(f416) : "f"(f415), "f"(f414));
  // PTX:767 mul.f32 %f417, %f1043, %f1045
  asm("mul.f32 %0, %1, %2;" : "=f"(f417) : "f"(f1043), "f"(f1045));
  // PTX:768 mul.f32 %f418, %f1042, %f1046
  asm("mul.f32 %0, %1, %2;" : "=f"(f418) : "f"(f1042), "f"(f1046));
  // PTX:769 sub.f32 %f419, %f418, %f417
  asm("sub.f32 %0, %1, %2;" : "=f"(f419) : "f"(f418), "f"(f417));
  // PTX:770 fma.rn.f32 %f420, %f56, %f401, %f1042
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f420) : "f"(f56), "f"(f401), "f"(f1042));
  // PTX:771 fma.rn.f32 %f421, %f57, %f401, %f1043
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f421) : "f"(f57), "f"(f401), "f"(f1043));
  // PTX:772 fma.rn.f32 %f422, %f58, %f401, %f1044
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f422) : "f"(f58), "f"(f401), "f"(f1044));
  // PTX:773 fma.rn.f32 %f423, %f404, %f401, %f1045
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f423) : "f"(f404), "f"(f401), "f"(f1045));
  // PTX:774 fma.rn.f32 %f424, %f407, %f401, %f1046
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f424) : "f"(f407), "f"(f401), "f"(f1046));
  // PTX:775 fma.rn.f32 %f425, %f410, %f401, %f1047
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f425) : "f"(f410), "f"(f401), "f"(f1047));
  // PTX:776 fma.rn.f32 %f426, %f413, %f401, %f1048
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f426) : "f"(f413), "f"(f401), "f"(f1048));
  // PTX:777 fma.rn.f32 %f427, %f416, %f401, %f1049
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f427) : "f"(f416), "f"(f401), "f"(f1049));
  // PTX:778 fma.rn.f32 %f428, %f419, %f401, %f1050
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f428) : "f"(f419), "f"(f401), "f"(f1050));
  // PTX:779 mul.f32 %f1042, %f420, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1042) : "f"(f420));
  // PTX:780 mul.f32 %f1043, %f421, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1043) : "f"(f421));
  // PTX:781 mul.f32 %f1044, %f422, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1044) : "f"(f422));
  // PTX:782 mul.f32 %f1045, %f423, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1045) : "f"(f423));
  // PTX:783 mul.f32 %f1046, %f424, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1046) : "f"(f424));
  // PTX:784 mul.f32 %f1047, %f425, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1047) : "f"(f425));
  // PTX:785 mul.f32 %f1048, %f426, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1048) : "f"(f426));
  // PTX:786 mul.f32 %f1049, %f427, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1049) : "f"(f427));
  // PTX:787 mul.f32 %f1050, %f428, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1050) : "f"(f428));
  // PTX:788 mul.f32 %f429, %f1046, %f1050
  asm("mul.f32 %0, %1, %2;" : "=f"(f429) : "f"(f1046), "f"(f1050));
  // PTX:789 mul.f32 %f430, %f1047, %f1049
  asm("mul.f32 %0, %1, %2;" : "=f"(f430) : "f"(f1047), "f"(f1049));
  // PTX:790 sub.f32 %f69, %f429, %f430
  asm("sub.f32 %0, %1, %2;" : "=f"(f69) : "f"(f429), "f"(f430));
  // PTX:791 mul.f32 %f431, %f1047, %f1048
  asm("mul.f32 %0, %1, %2;" : "=f"(f431) : "f"(f1047), "f"(f1048));
  // PTX:792 mul.f32 %f432, %f1045, %f1050
  asm("mul.f32 %0, %1, %2;" : "=f"(f432) : "f"(f1045), "f"(f1050));
  // PTX:793 sub.f32 %f70, %f431, %f432
  asm("sub.f32 %0, %1, %2;" : "=f"(f70) : "f"(f431), "f"(f432));
  // PTX:794 mul.f32 %f433, %f1045, %f1049
  asm("mul.f32 %0, %1, %2;" : "=f"(f433) : "f"(f1045), "f"(f1049));
  // PTX:795 mul.f32 %f434, %f1046, %f1048
  asm("mul.f32 %0, %1, %2;" : "=f"(f434) : "f"(f1046), "f"(f1048));
  // PTX:796 sub.f32 %f71, %f433, %f434
  asm("sub.f32 %0, %1, %2;" : "=f"(f71) : "f"(f433), "f"(f434));
  // PTX:797 mul.f32 %f435, %f1043, %f70
  asm("mul.f32 %0, %1, %2;" : "=f"(f435) : "f"(f1043), "f"(f70));
  // PTX:798 fma.rn.f32 %f436, %f1042, %f69, %f435
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f436) : "f"(f1042), "f"(f69), "f"(f435));
  // PTX:799 fma.rn.f32 %f72, %f1044, %f71, %f436
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f72) : "f"(f1044), "f"(f71), "f"(f436));
  // PTX:800 abs.f32 %f437, %f72
  asm("abs.f32 %0, %1;" : "=f"(f437) : "f"(f72));
  // PTX:801 setp.le.f32 %p81, %f437, 0f2EDBE6FF
  p81 = (!(isnan(((float)(f437))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f437)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:802 setp.geu.f32 %p82, %f437, 0f7F800000
  p82 = ((isnan(((float)(f437))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f437)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:803 or.pred %p83, %p81, %p82
  p83 = ((p81) || (p82));
  // PTX:804 @%p83 bra $L__BB77_70
  if (p83) { goto L_BB77_70; }
  // PTX:806 rcp.rn.f32 %f438, %f72
  asm("rcp.rn.f32 %0, %1;" : "=f"(f438) : "f"(f72));
  // PTX:807 mul.f32 %f439, %f1043, %f1050
  asm("mul.f32 %0, %1, %2;" : "=f"(f439) : "f"(f1043), "f"(f1050));
  // PTX:808 mul.f32 %f440, %f1044, %f1049
  asm("mul.f32 %0, %1, %2;" : "=f"(f440) : "f"(f1044), "f"(f1049));
  // PTX:809 sub.f32 %f441, %f440, %f439
  asm("sub.f32 %0, %1, %2;" : "=f"(f441) : "f"(f440), "f"(f439));
  // PTX:810 mul.f32 %f442, %f1044, %f1048
  asm("mul.f32 %0, %1, %2;" : "=f"(f442) : "f"(f1044), "f"(f1048));
  // PTX:811 mul.f32 %f443, %f1042, %f1050
  asm("mul.f32 %0, %1, %2;" : "=f"(f443) : "f"(f1042), "f"(f1050));
  // PTX:812 sub.f32 %f444, %f443, %f442
  asm("sub.f32 %0, %1, %2;" : "=f"(f444) : "f"(f443), "f"(f442));
  // PTX:813 mul.f32 %f445, %f1042, %f1049
  asm("mul.f32 %0, %1, %2;" : "=f"(f445) : "f"(f1042), "f"(f1049));
  // PTX:814 mul.f32 %f446, %f1043, %f1048
  asm("mul.f32 %0, %1, %2;" : "=f"(f446) : "f"(f1043), "f"(f1048));
  // PTX:815 sub.f32 %f447, %f446, %f445
  asm("sub.f32 %0, %1, %2;" : "=f"(f447) : "f"(f446), "f"(f445));
  // PTX:816 mul.f32 %f448, %f1044, %f1046
  asm("mul.f32 %0, %1, %2;" : "=f"(f448) : "f"(f1044), "f"(f1046));
  // PTX:817 mul.f32 %f449, %f1043, %f1047
  asm("mul.f32 %0, %1, %2;" : "=f"(f449) : "f"(f1043), "f"(f1047));
  // PTX:818 sub.f32 %f450, %f449, %f448
  asm("sub.f32 %0, %1, %2;" : "=f"(f450) : "f"(f449), "f"(f448));
  // PTX:819 mul.f32 %f451, %f1042, %f1047
  asm("mul.f32 %0, %1, %2;" : "=f"(f451) : "f"(f1042), "f"(f1047));
  // PTX:820 mul.f32 %f452, %f1044, %f1045
  asm("mul.f32 %0, %1, %2;" : "=f"(f452) : "f"(f1044), "f"(f1045));
  // PTX:821 sub.f32 %f453, %f452, %f451
  asm("sub.f32 %0, %1, %2;" : "=f"(f453) : "f"(f452), "f"(f451));
  // PTX:822 mul.f32 %f454, %f1043, %f1045
  asm("mul.f32 %0, %1, %2;" : "=f"(f454) : "f"(f1043), "f"(f1045));
  // PTX:823 mul.f32 %f455, %f1042, %f1046
  asm("mul.f32 %0, %1, %2;" : "=f"(f455) : "f"(f1042), "f"(f1046));
  // PTX:824 sub.f32 %f456, %f455, %f454
  asm("sub.f32 %0, %1, %2;" : "=f"(f456) : "f"(f455), "f"(f454));
  // PTX:825 fma.rn.f32 %f457, %f69, %f438, %f1042
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f457) : "f"(f69), "f"(f438), "f"(f1042));
  // PTX:826 fma.rn.f32 %f458, %f70, %f438, %f1043
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f458) : "f"(f70), "f"(f438), "f"(f1043));
  // PTX:827 fma.rn.f32 %f459, %f71, %f438, %f1044
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f459) : "f"(f71), "f"(f438), "f"(f1044));
  // PTX:828 fma.rn.f32 %f460, %f441, %f438, %f1045
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f460) : "f"(f441), "f"(f438), "f"(f1045));
  // PTX:829 fma.rn.f32 %f461, %f444, %f438, %f1046
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f461) : "f"(f444), "f"(f438), "f"(f1046));
  // PTX:830 fma.rn.f32 %f462, %f447, %f438, %f1047
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f462) : "f"(f447), "f"(f438), "f"(f1047));
  // PTX:831 fma.rn.f32 %f463, %f450, %f438, %f1048
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f463) : "f"(f450), "f"(f438), "f"(f1048));
  // PTX:832 fma.rn.f32 %f464, %f453, %f438, %f1049
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f464) : "f"(f453), "f"(f438), "f"(f1049));
  // PTX:833 fma.rn.f32 %f465, %f456, %f438, %f1050
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f465) : "f"(f456), "f"(f438), "f"(f1050));
  // PTX:834 mul.f32 %f1042, %f457, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1042) : "f"(f457));
  // PTX:835 mul.f32 %f1043, %f458, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1043) : "f"(f458));
  // PTX:836 mul.f32 %f1044, %f459, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1044) : "f"(f459));
  // PTX:837 mul.f32 %f1045, %f460, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1045) : "f"(f460));
  // PTX:838 mul.f32 %f1046, %f461, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1046) : "f"(f461));
  // PTX:839 mul.f32 %f1047, %f462, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1047) : "f"(f462));
  // PTX:840 mul.f32 %f1048, %f463, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1048) : "f"(f463));
  // PTX:841 mul.f32 %f1049, %f464, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1049) : "f"(f464));
  // PTX:842 mul.f32 %f1050, %f465, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1050) : "f"(f465));
  // PTX:843 add.s32 %r550, %r550, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r550) : "r"(r550));
  // PTX:844 setp.lt.u32 %p84, %r550, 8
  p84 = (((unsigned)(r550)) < ((unsigned)(8)));
  // PTX:845 @%p84 bra $L__BB77_67
  if (p84) { goto L_BB77_67; }
  // PTX:847 $L__BB77_70:
L_BB77_70:;
  // PTX:848 mul.f32 %f466, %f1043, %f1043
  asm("mul.f32 %0, %1, %2;" : "=f"(f466) : "f"(f1043), "f"(f1043));
  // PTX:849 fma.rn.f32 %f467, %f1042, %f1042, %f466
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f467) : "f"(f1042), "f"(f1042), "f"(f466));
  // PTX:850 fma.rn.f32 %f468, %f1044, %f1044, %f467
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f468) : "f"(f1044), "f"(f1044), "f"(f467));
  // PTX:851 sqrt.rn.f32 %f91, %f468
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f91) : "f"(f468));
  // PTX:852 setp.leu.f32 %p85, %f91, 0f00000000
  p85 = ((isnan(((float)(f91))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f91)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:853 mov.u32 %r563, 0
  asm("mov.u32 %0, 0;" : "=r"(r563) : );
  // PTX:854 mov.u32 %r551, %r563
  asm("mov.u32 %0, %1;" : "=r"(r551) : "r"(r563));
  // PTX:855 mov.u32 %r552, %r563
  asm("mov.u32 %0, %1;" : "=r"(r552) : "r"(r563));
  // PTX:856 mov.u32 %r553, %r563
  asm("mov.u32 %0, %1;" : "=r"(r553) : "r"(r563));
  // PTX:857 @%p85 bra $L__BB77_72
  if (p85) { goto L_BB77_72; }
  // PTX:859 div.rn.f32 %f469, %f1042, %f91
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f469) : "f"(f1042), "f"(f91));
  // PTX:860 div.rn.f32 %f470, %f1043, %f91
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f470) : "f"(f1043), "f"(f91));
  // PTX:861 div.rn.f32 %f471, %f1044, %f91
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f471) : "f"(f1044), "f"(f91));
  // PTX:862 mov.b32 %r553, %f471
  asm("mov.b32 %0, %1;" : "=r"(r553) : "f"(f471));
  // PTX:863 mov.b32 %r552, %f470
  asm("mov.b32 %0, %1;" : "=r"(r552) : "f"(f470));
  // PTX:864 mov.b32 %r551, %f469
  asm("mov.b32 %0, %1;" : "=r"(r551) : "f"(f469));
  // PTX:866 $L__BB77_72:
L_BB77_72:;
  // PTX:867 mov.b32 %f92, %r551
  asm("mov.b32 %0, %1;" : "=f"(f92) : "r"(r551));
  // PTX:868 mov.b32 %f93, %r552
  asm("mov.b32 %0, %1;" : "=f"(f93) : "r"(r552));
  // PTX:869 mul.f32 %f472, %f1046, %f93
  asm("mul.f32 %0, %1, %2;" : "=f"(f472) : "f"(f1046), "f"(f93));
  // PTX:870 mov.b32 %f94, %r553
  asm("mov.b32 %0, %1;" : "=f"(f94) : "r"(r553));
  // PTX:871 fma.rn.f32 %f473, %f1045, %f92, %f472
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f473) : "f"(f1045), "f"(f92), "f"(f472));
  // PTX:872 fma.rn.f32 %f474, %f1047, %f94, %f473
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f474) : "f"(f1047), "f"(f94), "f"(f473));
  // PTX:873 mul.f32 %f475, %f474, %f92
  asm("mul.f32 %0, %1, %2;" : "=f"(f475) : "f"(f474), "f"(f92));
  // PTX:874 mul.f32 %f476, %f474, %f93
  asm("mul.f32 %0, %1, %2;" : "=f"(f476) : "f"(f474), "f"(f93));
  // PTX:875 mul.f32 %f477, %f474, %f94
  asm("mul.f32 %0, %1, %2;" : "=f"(f477) : "f"(f474), "f"(f94));
  // PTX:876 sub.f32 %f95, %f1045, %f475
  asm("sub.f32 %0, %1, %2;" : "=f"(f95) : "f"(f1045), "f"(f475));
  // PTX:877 sub.f32 %f96, %f1046, %f476
  asm("sub.f32 %0, %1, %2;" : "=f"(f96) : "f"(f1046), "f"(f476));
  // PTX:878 sub.f32 %f97, %f1047, %f477
  asm("sub.f32 %0, %1, %2;" : "=f"(f97) : "f"(f1047), "f"(f477));
  // PTX:879 mul.f32 %f478, %f96, %f96
  asm("mul.f32 %0, %1, %2;" : "=f"(f478) : "f"(f96), "f"(f96));
  // PTX:880 fma.rn.f32 %f479, %f95, %f95, %f478
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f479) : "f"(f95), "f"(f95), "f"(f478));
  // PTX:881 fma.rn.f32 %f480, %f97, %f97, %f479
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f480) : "f"(f97), "f"(f97), "f"(f479));
  // PTX:882 sqrt.rn.f32 %f98, %f480
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f98) : "f"(f480));
  // PTX:883 setp.leu.f32 %p86, %f98, 0f00000000
  p86 = ((isnan(((float)(f98))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f98)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:884 mov.u32 %r564, %r563
  asm("mov.u32 %0, %1;" : "=r"(r564) : "r"(r563));
  // PTX:885 mov.u32 %r565, %r563
  asm("mov.u32 %0, %1;" : "=r"(r565) : "r"(r563));
  // PTX:886 @%p86 bra $L__BB77_74
  if (p86) { goto L_BB77_74; }
  // PTX:888 div.rn.f32 %f481, %f95, %f98
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f481) : "f"(f95), "f"(f98));
  // PTX:889 div.rn.f32 %f482, %f96, %f98
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f482) : "f"(f96), "f"(f98));
  // PTX:890 div.rn.f32 %f483, %f97, %f98
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f483) : "f"(f97), "f"(f98));
  // PTX:891 mov.b32 %r565, %f483
  asm("mov.b32 %0, %1;" : "=r"(r565) : "f"(f483));
  // PTX:892 mov.b32 %r564, %f482
  asm("mov.b32 %0, %1;" : "=r"(r564) : "f"(f482));
  // PTX:893 mov.b32 %r563, %f481
  asm("mov.b32 %0, %1;" : "=r"(r563) : "f"(f481));
  // PTX:895 $L__BB77_74:
L_BB77_74:;
  // PTX:896 mov.u32 %r566, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r566) : );
  // PTX:897 mul.f32 %f484, %f93, %f93
  asm("mul.f32 %0, %1, %2;" : "=f"(f484) : "f"(f93), "f"(f93));
  // PTX:898 fma.rn.f32 %f485, %f92, %f92, %f484
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f485) : "f"(f92), "f"(f92), "f"(f484));
  // PTX:899 fma.rn.f32 %f486, %f94, %f94, %f485
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f486) : "f"(f94), "f"(f94), "f"(f485));
  // PTX:900 sqrt.rn.f32 %f487, %f486
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f487) : "f"(f486));
  // PTX:901 setp.le.f32 %p87, %f487, 0f322BCC77
  p87 = (!(isnan(((float)(f487))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f487)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:902 mov.u32 %r567, 0
  asm("mov.u32 %0, 0;" : "=r"(r567) : );
  // PTX:903 mov.u32 %r568, %r567
  asm("mov.u32 %0, %1;" : "=r"(r568) : "r"(r567));
  // PTX:904 mov.u32 %r569, %r567
  asm("mov.u32 %0, %1;" : "=r"(r569) : "r"(r567));
  // PTX:905 mov.u32 %r570, %r566
  asm("mov.u32 %0, %1;" : "=r"(r570) : "r"(r566));
  // PTX:906 mov.u32 %r571, %r567
  asm("mov.u32 %0, %1;" : "=r"(r571) : "r"(r567));
  // PTX:907 mov.u32 %r572, %r567
  asm("mov.u32 %0, %1;" : "=r"(r572) : "r"(r567));
  // PTX:908 mov.u32 %r573, %r567
  asm("mov.u32 %0, %1;" : "=r"(r573) : "r"(r567));
  // PTX:909 mov.u32 %r574, %r566
  asm("mov.u32 %0, %1;" : "=r"(r574) : "r"(r566));
  // PTX:910 @%p87 bra $L__BB77_81
  if (p87) { goto L_BB77_81; }
  // PTX:912 mov.u32 %r566, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r566) : );
  // PTX:913 mov.b32 %f99, %r563
  asm("mov.b32 %0, %1;" : "=f"(f99) : "r"(r563));
  // PTX:914 mov.b32 %f100, %r564
  asm("mov.b32 %0, %1;" : "=f"(f100) : "r"(r564));
  // PTX:915 mul.f32 %f488, %f100, %f100
  asm("mul.f32 %0, %1, %2;" : "=f"(f488) : "f"(f100), "f"(f100));
  // PTX:916 mov.b32 %f101, %r565
  asm("mov.b32 %0, %1;" : "=f"(f101) : "r"(r565));
  // PTX:917 fma.rn.f32 %f489, %f99, %f99, %f488
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f489) : "f"(f99), "f"(f99), "f"(f488));
  // PTX:918 fma.rn.f32 %f490, %f101, %f101, %f489
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f490) : "f"(f101), "f"(f101), "f"(f489));
  // PTX:919 sqrt.rn.f32 %f491, %f490
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f491) : "f"(f490));
  // PTX:920 setp.le.f32 %p88, %f491, 0f322BCC77
  p88 = (!(isnan(((float)(f491))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f491)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:921 @%p88 bra $L__BB77_81
  if (p88) { goto L_BB77_81; }
  // PTX:923 mul.f32 %f492, %f93, %f101
  asm("mul.f32 %0, %1, %2;" : "=f"(f492) : "f"(f93), "f"(f101));
  // PTX:924 mul.f32 %f493, %f94, %f100
  asm("mul.f32 %0, %1, %2;" : "=f"(f493) : "f"(f94), "f"(f100));
  // PTX:925 sub.f32 %f102, %f492, %f493
  asm("sub.f32 %0, %1, %2;" : "=f"(f102) : "f"(f492), "f"(f493));
  // PTX:926 mul.f32 %f494, %f92, %f101
  asm("mul.f32 %0, %1, %2;" : "=f"(f494) : "f"(f92), "f"(f101));
  // PTX:927 mul.f32 %f495, %f94, %f99
  asm("mul.f32 %0, %1, %2;" : "=f"(f495) : "f"(f94), "f"(f99));
  // PTX:928 sub.f32 %f103, %f495, %f494
  asm("sub.f32 %0, %1, %2;" : "=f"(f103) : "f"(f495), "f"(f494));
  // PTX:929 mul.f32 %f496, %f93, %f99
  asm("mul.f32 %0, %1, %2;" : "=f"(f496) : "f"(f93), "f"(f99));
  // PTX:930 mul.f32 %f497, %f92, %f100
  asm("mul.f32 %0, %1, %2;" : "=f"(f497) : "f"(f92), "f"(f100));
  // PTX:931 sub.f32 %f104, %f497, %f496
  asm("sub.f32 %0, %1, %2;" : "=f"(f104) : "f"(f497), "f"(f496));
  // PTX:932 mul.f32 %f498, %f103, %f103
  asm("mul.f32 %0, %1, %2;" : "=f"(f498) : "f"(f103), "f"(f103));
  // PTX:933 fma.rn.f32 %f499, %f102, %f102, %f498
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f499) : "f"(f102), "f"(f102), "f"(f498));
  // PTX:934 fma.rn.f32 %f500, %f104, %f104, %f499
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f500) : "f"(f104), "f"(f104), "f"(f499));
  // PTX:935 sqrt.rn.f32 %f105, %f500
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f105) : "f"(f500));
  // PTX:936 setp.leu.f32 %p89, %f105, 0f00000000
  p89 = ((isnan(((float)(f105))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f105)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:937 mov.u32 %r572, 0
  asm("mov.u32 %0, 0;" : "=r"(r572) : );
  // PTX:938 mov.u32 %r573, %r572
  asm("mov.u32 %0, %1;" : "=r"(r573) : "r"(r572));
  // PTX:939 mov.u32 %r574, %r572
  asm("mov.u32 %0, %1;" : "=r"(r574) : "r"(r572));
  // PTX:940 @%p89 bra $L__BB77_78
  if (p89) { goto L_BB77_78; }
  // PTX:942 div.rn.f32 %f501, %f102, %f105
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f501) : "f"(f102), "f"(f105));
  // PTX:943 div.rn.f32 %f502, %f103, %f105
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f502) : "f"(f103), "f"(f105));
  // PTX:944 div.rn.f32 %f503, %f104, %f105
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f503) : "f"(f104), "f"(f105));
  // PTX:945 mov.b32 %r574, %f503
  asm("mov.b32 %0, %1;" : "=r"(r574) : "f"(f503));
  // PTX:946 mov.b32 %r573, %f502
  asm("mov.b32 %0, %1;" : "=r"(r573) : "f"(f502));
  // PTX:947 mov.b32 %r572, %f501
  asm("mov.b32 %0, %1;" : "=r"(r572) : "f"(f501));
  // PTX:949 $L__BB77_78:
L_BB77_78:;
  // PTX:950 mov.b32 %f106, %r572
  asm("mov.b32 %0, %1;" : "=f"(f106) : "r"(r572));
  // PTX:951 mov.b32 %f107, %r573
  asm("mov.b32 %0, %1;" : "=f"(f107) : "r"(r573));
  // PTX:952 mul.f32 %f504, %f1049, %f107
  asm("mul.f32 %0, %1, %2;" : "=f"(f504) : "f"(f1049), "f"(f107));
  // PTX:953 mov.b32 %f108, %r574
  asm("mov.b32 %0, %1;" : "=f"(f108) : "r"(r574));
  // PTX:954 fma.rn.f32 %f505, %f1048, %f106, %f504
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f505) : "f"(f1048), "f"(f106), "f"(f504));
  // PTX:955 fma.rn.f32 %f506, %f1050, %f108, %f505
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f506) : "f"(f1050), "f"(f108), "f"(f505));
  // PTX:956 setp.geu.f32 %p90, %f506, 0f00000000
  p90 = ((isnan(((float)(f506))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f506)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:957 @%p90 bra $L__BB77_80
  if (p90) { goto L_BB77_80; }
  // PTX:959 neg.f32 %f507, %f99
  asm("neg.f32 %0, %1;" : "=f"(f507) : "f"(f99));
  // PTX:960 mov.b32 %r563, %f507
  asm("mov.b32 %0, %1;" : "=r"(r563) : "f"(f507));
  // PTX:961 neg.f32 %f508, %f100
  asm("neg.f32 %0, %1;" : "=f"(f508) : "f"(f100));
  // PTX:962 mov.b32 %r564, %f508
  asm("mov.b32 %0, %1;" : "=r"(r564) : "f"(f508));
  // PTX:963 neg.f32 %f509, %f101
  asm("neg.f32 %0, %1;" : "=f"(f509) : "f"(f101));
  // PTX:964 mov.b32 %r565, %f509
  asm("mov.b32 %0, %1;" : "=r"(r565) : "f"(f509));
  // PTX:965 neg.f32 %f510, %f106
  asm("neg.f32 %0, %1;" : "=f"(f510) : "f"(f106));
  // PTX:966 mov.b32 %r572, %f510
  asm("mov.b32 %0, %1;" : "=r"(r572) : "f"(f510));
  // PTX:967 neg.f32 %f511, %f107
  asm("neg.f32 %0, %1;" : "=f"(f511) : "f"(f107));
  // PTX:968 mov.b32 %r573, %f511
  asm("mov.b32 %0, %1;" : "=r"(r573) : "f"(f511));
  // PTX:969 neg.f32 %f512, %f108
  asm("neg.f32 %0, %1;" : "=f"(f512) : "f"(f108));
  // PTX:970 mov.b32 %r574, %f512
  asm("mov.b32 %0, %1;" : "=r"(r574) : "f"(f512));
  // PTX:972 $L__BB77_80:
L_BB77_80:;
  // PTX:973 mov.u32 %r566, %r551
  asm("mov.u32 %0, %1;" : "=r"(r566) : "r"(r551));
  // PTX:974 mov.u32 %r567, %r552
  asm("mov.u32 %0, %1;" : "=r"(r567) : "r"(r552));
  // PTX:975 mov.u32 %r568, %r553
  asm("mov.u32 %0, %1;" : "=r"(r568) : "r"(r553));
  // PTX:976 mov.u32 %r569, %r563
  asm("mov.u32 %0, %1;" : "=r"(r569) : "r"(r563));
  // PTX:977 mov.u32 %r570, %r564
  asm("mov.u32 %0, %1;" : "=r"(r570) : "r"(r564));
  // PTX:978 mov.u32 %r571, %r565
  asm("mov.u32 %0, %1;" : "=r"(r571) : "r"(r565));
  // PTX:980 $L__BB77_81:
L_BB77_81:;
  // PTX:981 mul.f32 %f1015, %f331, %f1030
  asm("mul.f32 %0, %1, %2;" : "=f"(f1015) : "f"(f331), "f"(f1030));
  // PTX:982 mul.f32 %f1014, %f331, %f1032
  asm("mul.f32 %0, %1, %2;" : "=f"(f1014) : "f"(f331), "f"(f1032));
  // PTX:983 mul.f32 %f1013, %f331, %f1031
  asm("mul.f32 %0, %1, %2;" : "=f"(f1013) : "f"(f331), "f"(f1031));
  // PTX:984 mov.b32 %f513, %r566
  asm("mov.b32 %0, %1;" : "=f"(f513) : "r"(r566));
  // PTX:985 mov.b32 %f514, %r569
  asm("mov.b32 %0, %1;" : "=f"(f514) : "r"(r569));
  // PTX:986 mov.b32 %f515, %r572
  asm("mov.b32 %0, %1;" : "=f"(f515) : "r"(r572));
  // PTX:987 mov.b32 %f516, %r567
  asm("mov.b32 %0, %1;" : "=f"(f516) : "r"(r567));
  // PTX:988 mul.f32 %f517, %f1013, %f516
  asm("mul.f32 %0, %1, %2;" : "=f"(f517) : "f"(f1013), "f"(f516));
  // PTX:989 mov.b32 %f518, %r570
  asm("mov.b32 %0, %1;" : "=f"(f518) : "r"(r570));
  // PTX:990 mul.f32 %f519, %f1013, %f518
  asm("mul.f32 %0, %1, %2;" : "=f"(f519) : "f"(f1013), "f"(f518));
  // PTX:991 mov.b32 %f520, %r573
  asm("mov.b32 %0, %1;" : "=f"(f520) : "r"(r573));
  // PTX:992 mul.f32 %f521, %f1013, %f520
  asm("mul.f32 %0, %1, %2;" : "=f"(f521) : "f"(f1013), "f"(f520));
  // PTX:993 fma.rn.f32 %f522, %f1014, %f513, %f517
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f522) : "f"(f1014), "f"(f513), "f"(f517));
  // PTX:994 fma.rn.f32 %f523, %f1014, %f514, %f519
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f523) : "f"(f1014), "f"(f514), "f"(f519));
  // PTX:995 fma.rn.f32 %f524, %f1014, %f515, %f521
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f524) : "f"(f1014), "f"(f515), "f"(f521));
  // PTX:996 mov.b32 %f525, %r568
  asm("mov.b32 %0, %1;" : "=f"(f525) : "r"(r568));
  // PTX:997 mov.b32 %f526, %r571
  asm("mov.b32 %0, %1;" : "=f"(f526) : "r"(r571));
  // PTX:998 mov.b32 %f527, %r574
  asm("mov.b32 %0, %1;" : "=f"(f527) : "r"(r574));
  // PTX:999 fma.rn.f32 %f1051, %f1015, %f525, %f522
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1051) : "f"(f1015), "f"(f525), "f"(f522));
  // PTX:1000 fma.rn.f32 %f1052, %f1015, %f526, %f523
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1052) : "f"(f1015), "f"(f526), "f"(f523));
  // PTX:1001 fma.rn.f32 %f1053, %f1015, %f527, %f524
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1053) : "f"(f1015), "f"(f527), "f"(f524));
  // PTX:1002 bra.uni $L__BB77_82
  goto L_BB77_82;
  // PTX:1004 $L__BB77_83:
L_BB77_83:;
  // PTX:1005 ld.global.f32 %f540, [%rd70]
  f540 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))));
  // PTX:1006 mov.b32 %f541, %r626
  asm("mov.b32 %0, %1;" : "=f"(f541) : "r"(r626));
  // PTX:1007 fma.rn.f32 %f542, %f540, %f1032, %f541
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f542) : "f"(f540), "f"(f1032), "f"(f541));
  // PTX:1008 mov.b32 %f543, %r625
  asm("mov.b32 %0, %1;" : "=f"(f543) : "r"(r625));
  // PTX:1009 fma.rn.f32 %f544, %f540, %f1031, %f543
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f544) : "f"(f540), "f"(f1031), "f"(f543));
  // PTX:1010 mov.b32 %f545, %r624
  asm("mov.b32 %0, %1;" : "=f"(f545) : "r"(r624));
  // PTX:1011 fma.rn.f32 %f546, %f540, %f1030, %f545
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f546) : "f"(f540), "f"(f1030), "f"(f545));
  // PTX:1012 mov.b32 %r626, %f542
  asm("mov.b32 %0, %1;" : "=r"(r626) : "f"(f542));
  // PTX:1013 mov.b32 %r625, %f544
  asm("mov.b32 %0, %1;" : "=r"(r625) : "f"(f544));
  // PTX:1014 mov.b32 %r624, %f546
  asm("mov.b32 %0, %1;" : "=r"(r624) : "f"(f546));
  // PTX:1015 bra.uni $L__BB77_84
  goto L_BB77_84;
  // PTX:1017 $L__BB77_63:
L_BB77_63:;
  // PTX:1018 mul.f32 %f1020, %f331, %f1030
  asm("mul.f32 %0, %1, %2;" : "=f"(f1020) : "f"(f331), "f"(f1030));
  // PTX:1019 mul.f32 %f1019, %f331, %f1032
  asm("mul.f32 %0, %1, %2;" : "=f"(f1019) : "f"(f331), "f"(f1032));
  // PTX:1020 mul.f32 %f1018, %f331, %f1031
  asm("mul.f32 %0, %1, %2;" : "=f"(f1018) : "f"(f331), "f"(f1031));
  // PTX:1021 rcp.rn.f32 %f341, %f36
  asm("rcp.rn.f32 %0, %1;" : "=f"(f341) : "f"(f36));
  // PTX:1022 mul.f32 %f342, %f34, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f342) : "f"(f34), "f"(f24));
  // PTX:1023 mul.f32 %f343, %f35, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f343) : "f"(f35), "f"(f26));
  // PTX:1024 sub.f32 %f344, %f343, %f342
  asm("sub.f32 %0, %1, %2;" : "=f"(f344) : "f"(f343), "f"(f342));
  // PTX:1025 mul.f32 %f345, %f35, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f345) : "f"(f35), "f"(f29));
  // PTX:1026 mul.f32 %f346, %f33, %f24
  asm("mul.f32 %0, %1, %2;" : "=f"(f346) : "f"(f33), "f"(f24));
  // PTX:1027 sub.f32 %f347, %f346, %f345
  asm("sub.f32 %0, %1, %2;" : "=f"(f347) : "f"(f346), "f"(f345));
  // PTX:1028 mul.f32 %f348, %f33, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f348) : "f"(f33), "f"(f26));
  // PTX:1029 mul.f32 %f349, %f34, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f349) : "f"(f34), "f"(f29));
  // PTX:1030 sub.f32 %f350, %f349, %f348
  asm("sub.f32 %0, %1, %2;" : "=f"(f350) : "f"(f349), "f"(f348));
  // PTX:1031 mul.f32 %f351, %f35, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f351) : "f"(f35), "f"(f25));
  // PTX:1032 mul.f32 %f352, %f34, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f352) : "f"(f34), "f"(f27));
  // PTX:1033 sub.f32 %f353, %f352, %f351
  asm("sub.f32 %0, %1, %2;" : "=f"(f353) : "f"(f352), "f"(f351));
  // PTX:1034 mul.f32 %f354, %f33, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f354) : "f"(f33), "f"(f27));
  // PTX:1035 mul.f32 %f355, %f35, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f355) : "f"(f35), "f"(f30));
  // PTX:1036 sub.f32 %f356, %f355, %f354
  asm("sub.f32 %0, %1, %2;" : "=f"(f356) : "f"(f355), "f"(f354));
  // PTX:1037 mul.f32 %f357, %f34, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f357) : "f"(f34), "f"(f30));
  // PTX:1038 mul.f32 %f358, %f33, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f358) : "f"(f33), "f"(f25));
  // PTX:1039 sub.f32 %f359, %f358, %f357
  asm("sub.f32 %0, %1, %2;" : "=f"(f359) : "f"(f358), "f"(f357));
  // PTX:1040 mul.f32 %f360, %f28, %f341
  asm("mul.f32 %0, %1, %2;" : "=f"(f360) : "f"(f28), "f"(f341));
  // PTX:1041 mul.f32 %f361, %f31, %f341
  asm("mul.f32 %0, %1, %2;" : "=f"(f361) : "f"(f31), "f"(f341));
  // PTX:1042 mul.f32 %f362, %f32, %f341
  asm("mul.f32 %0, %1, %2;" : "=f"(f362) : "f"(f32), "f"(f341));
  // PTX:1043 mul.f32 %f363, %f344, %f341
  asm("mul.f32 %0, %1, %2;" : "=f"(f363) : "f"(f344), "f"(f341));
  // PTX:1044 mul.f32 %f364, %f347, %f341
  asm("mul.f32 %0, %1, %2;" : "=f"(f364) : "f"(f347), "f"(f341));
  // PTX:1045 mul.f32 %f365, %f350, %f341
  asm("mul.f32 %0, %1, %2;" : "=f"(f365) : "f"(f350), "f"(f341));
  // PTX:1046 mul.f32 %f366, %f353, %f341
  asm("mul.f32 %0, %1, %2;" : "=f"(f366) : "f"(f353), "f"(f341));
  // PTX:1047 mul.f32 %f367, %f356, %f341
  asm("mul.f32 %0, %1, %2;" : "=f"(f367) : "f"(f356), "f"(f341));
  // PTX:1048 mul.f32 %f368, %f359, %f341
  asm("mul.f32 %0, %1, %2;" : "=f"(f368) : "f"(f359), "f"(f341));
  // PTX:1049 mul.f32 %f369, %f1018, %f361
  asm("mul.f32 %0, %1, %2;" : "=f"(f369) : "f"(f1018), "f"(f361));
  // PTX:1050 mul.f32 %f370, %f1018, %f364
  asm("mul.f32 %0, %1, %2;" : "=f"(f370) : "f"(f1018), "f"(f364));
  // PTX:1051 mul.f32 %f371, %f1018, %f367
  asm("mul.f32 %0, %1, %2;" : "=f"(f371) : "f"(f1018), "f"(f367));
  // PTX:1052 fma.rn.f32 %f372, %f1019, %f360, %f369
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f372) : "f"(f1019), "f"(f360), "f"(f369));
  // PTX:1053 fma.rn.f32 %f373, %f1019, %f363, %f370
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f373) : "f"(f1019), "f"(f363), "f"(f370));
  // PTX:1054 fma.rn.f32 %f374, %f1019, %f366, %f371
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f374) : "f"(f1019), "f"(f366), "f"(f371));
  // PTX:1055 fma.rn.f32 %f1051, %f1020, %f362, %f372
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1051) : "f"(f1020), "f"(f362), "f"(f372));
  // PTX:1056 fma.rn.f32 %f1052, %f1020, %f365, %f373
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1052) : "f"(f1020), "f"(f365), "f"(f373));
  // PTX:1057 fma.rn.f32 %f1053, %f1020, %f368, %f374
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1053) : "f"(f1020), "f"(f368), "f"(f374));
  // PTX:1059 $L__BB77_82:
L_BB77_82:;
  // PTX:1060 mov.b32 %f532, %r626
  asm("mov.b32 %0, %1;" : "=f"(f532) : "r"(r626));
  // PTX:1061 add.f32 %f533, %f532, %f1051
  asm("add.f32 %0, %1, %2;" : "=f"(f533) : "f"(f532), "f"(f1051));
  // PTX:1062 mov.b32 %f535, %r625
  asm("mov.b32 %0, %1;" : "=f"(f535) : "r"(r625));
  // PTX:1063 add.f32 %f536, %f535, %f1052
  asm("add.f32 %0, %1, %2;" : "=f"(f536) : "f"(f535), "f"(f1052));
  // PTX:1064 mov.b32 %f538, %r624
  asm("mov.b32 %0, %1;" : "=f"(f538) : "r"(r624));
  // PTX:1065 add.f32 %f539, %f538, %f1053
  asm("add.f32 %0, %1, %2;" : "=f"(f539) : "f"(f538), "f"(f1053));
  // PTX:1066 mov.b32 %r626, %f533
  asm("mov.b32 %0, %1;" : "=r"(r626) : "f"(f533));
  // PTX:1067 mov.b32 %r625, %f536
  asm("mov.b32 %0, %1;" : "=r"(r625) : "f"(f536));
  // PTX:1068 mov.b32 %r624, %f539
  asm("mov.b32 %0, %1;" : "=r"(r624) : "f"(f539));
  // PTX:1070 $L__BB77_84:
L_BB77_84:;
  // PTX:1071 setp.ne.s32 %p139, %r43, 3
  p139 = (((int)(r43)) != ((int)(3)));
  // PTX:1072 @%p139 bra $L__BB77_108
  if (p139) { goto L_BB77_108; }
  // PTX:1074 setp.lt.s32 %p136, %r638, 0
  p136 = (((int)(r638)) < ((int)(0)));
  // PTX:1075 ld.param.u64 %rd325, [%rd2+112]
  rd325 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (112))));
  // PTX:1076 cvta.to.global.u64 %rd324, %rd325
  rd324 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd325));
  // PTX:1077 cvt.s64.s32 %rd323, %rd423
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd323) : "l"(rd423));
  // PTX:1078 mul.lo.s64 %rd168, %rd323, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd168) : "l"(rd323));
  // PTX:1079 add.s64 %rd71, %rd324, %rd168
  asm("add.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd324), "l"(rd168));
  // PTX:1080 @%p136 bra $L__BB77_107
  if (p136) { goto L_BB77_107; }
  // PTX:1082 ld.param.u64 %rd348, [%rd2+208]
  rd348 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (208))));
  // PTX:1083 cvta.to.global.u64 %rd347, %rd348
  rd347 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd348));
  // PTX:1084 mul.wide.s32 %rd346, %r630, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd346) : "r"(r630));
  // PTX:1085 add.s64 %rd345, %rd347, %rd346
  asm("add.s64 %0, %1, %2;" : "=l"(rd345) : "l"(rd347), "l"(rd346));
  // PTX:1086 mul.wide.s32 %rd344, %r631, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd344) : "r"(r631));
  // PTX:1087 add.s64 %rd343, %rd347, %rd344
  asm("add.s64 %0, %1, %2;" : "=l"(rd343) : "l"(rd347), "l"(rd344));
  // PTX:1088 mul.wide.s32 %rd342, %r632, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd342) : "r"(r632));
  // PTX:1089 add.s64 %rd341, %rd347, %rd342
  asm("add.s64 %0, %1, %2;" : "=l"(rd341) : "l"(rd347), "l"(rd342));
  // PTX:1090 ld.global.f32 %f547, [%rd71]
  f547 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))));
  // PTX:1091 mul.f32 %f548, %f547, %f1032
  asm("mul.f32 %0, %1, %2;" : "=f"(f548) : "f"(f547), "f"(f1032));
  // PTX:1092 neg.f32 %f109, %f548
  asm("neg.f32 %0, %1;" : "=f"(f109) : "f"(f548));
  // PTX:1093 mul.f32 %f549, %f547, %f1031
  asm("mul.f32 %0, %1, %2;" : "=f"(f549) : "f"(f547), "f"(f1031));
  // PTX:1094 neg.f32 %f110, %f549
  asm("neg.f32 %0, %1;" : "=f"(f110) : "f"(f549));
  // PTX:1095 mul.f32 %f550, %f547, %f1030
  asm("mul.f32 %0, %1, %2;" : "=f"(f550) : "f"(f547), "f"(f1030));
  // PTX:1096 neg.f32 %f111, %f550
  asm("neg.f32 %0, %1;" : "=f"(f111) : "f"(f550));
  // PTX:1097 ld.global.f32 %f112, [%rd345+8]
  f112 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd345) + (8)))));
  // PTX:1098 ld.global.f32 %f113, [%rd343+4]
  f113 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd343) + (4)))));
  // PTX:1099 mul.f32 %f551, %f113, %f112
  asm("mul.f32 %0, %1, %2;" : "=f"(f551) : "f"(f113), "f"(f112));
  // PTX:1100 ld.global.f32 %f114, [%rd345+4]
  f114 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd345) + (4)))));
  // PTX:1101 ld.global.f32 %f115, [%rd343+8]
  f115 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd343) + (8)))));
  // PTX:1102 mul.f32 %f552, %f115, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f552) : "f"(f115), "f"(f114));
  // PTX:1103 sub.f32 %f116, %f551, %f552
  asm("sub.f32 %0, %1, %2;" : "=f"(f116) : "f"(f551), "f"(f552));
  // PTX:1104 ld.global.f32 %f117, [%rd345]
  f117 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd345) + (0)))));
  // PTX:1105 mul.f32 %f553, %f115, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f553) : "f"(f115), "f"(f117));
  // PTX:1106 ld.global.f32 %f118, [%rd343]
  f118 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd343) + (0)))));
  // PTX:1107 mul.f32 %f554, %f118, %f112
  asm("mul.f32 %0, %1, %2;" : "=f"(f554) : "f"(f118), "f"(f112));
  // PTX:1108 sub.f32 %f119, %f553, %f554
  asm("sub.f32 %0, %1, %2;" : "=f"(f119) : "f"(f553), "f"(f554));
  // PTX:1109 mul.f32 %f555, %f118, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f555) : "f"(f118), "f"(f114));
  // PTX:1110 mul.f32 %f556, %f113, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f556) : "f"(f113), "f"(f117));
  // PTX:1111 sub.f32 %f120, %f555, %f556
  asm("sub.f32 %0, %1, %2;" : "=f"(f120) : "f"(f555), "f"(f556));
  // PTX:1112 ld.global.f32 %f121, [%rd341]
  f121 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd341) + (0)))));
  // PTX:1113 ld.global.f32 %f122, [%rd341+4]
  f122 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd341) + (4)))));
  // PTX:1114 mul.f32 %f557, %f122, %f119
  asm("mul.f32 %0, %1, %2;" : "=f"(f557) : "f"(f122), "f"(f119));
  // PTX:1115 ld.global.f32 %f123, [%rd341+8]
  f123 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd341) + (8)))));
  // PTX:1116 fma.rn.f32 %f558, %f121, %f116, %f557
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f558) : "f"(f121), "f"(f116), "f"(f557));
  // PTX:1117 fma.rn.f32 %f124, %f123, %f120, %f558
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f124) : "f"(f123), "f"(f120), "f"(f558));
  // PTX:1118 abs.f32 %f559, %f124
  asm("abs.f32 %0, %1;" : "=f"(f559) : "f"(f124));
  // PTX:1119 setp.leu.f32 %p93, %f559, 0f2EDBE6FF
  p93 = ((isnan(((float)(f559))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) || (((float)(f559)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:1120 setp.geu.f32 %p94, %f559, 0f7F800000
  p94 = ((isnan(((float)(f559))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f559)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1121 or.pred %p95, %p93, %p94
  p95 = ((p93) || (p94));
  // PTX:1122 @%p95 bra $L__BB77_88
  if (p95) { goto L_BB77_88; }
  // PTX:1123 bra.uni $L__BB77_87
  goto L_BB77_87;
  // PTX:1125 $L__BB77_88:
L_BB77_88:;
  // PTX:1126 mul.f32 %f597, %f122, %f122
  asm("mul.f32 %0, %1, %2;" : "=f"(f597) : "f"(f122), "f"(f122));
  // PTX:1127 fma.rn.f32 %f598, %f121, %f121, %f597
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f598) : "f"(f121), "f"(f121), "f"(f597));
  // PTX:1128 fma.rn.f32 %f599, %f123, %f123, %f598
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f599) : "f"(f123), "f"(f123), "f"(f598));
  // PTX:1129 mul.f32 %f600, %f113, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f600) : "f"(f113), "f"(f113));
  // PTX:1130 fma.rn.f32 %f601, %f118, %f118, %f600
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f601) : "f"(f118), "f"(f118), "f"(f600));
  // PTX:1131 fma.rn.f32 %f602, %f115, %f115, %f601
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f602) : "f"(f115), "f"(f115), "f"(f601));
  // PTX:1132 add.f32 %f603, %f599, %f602
  asm("add.f32 %0, %1, %2;" : "=f"(f603) : "f"(f599), "f"(f602));
  // PTX:1133 mul.f32 %f604, %f114, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f604) : "f"(f114), "f"(f114));
  // PTX:1134 fma.rn.f32 %f605, %f117, %f117, %f604
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f605) : "f"(f117), "f"(f117), "f"(f604));
  // PTX:1135 fma.rn.f32 %f606, %f112, %f112, %f605
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f606) : "f"(f112), "f"(f112), "f"(f605));
  // PTX:1136 add.f32 %f607, %f603, %f606
  asm("add.f32 %0, %1, %2;" : "=f"(f607) : "f"(f603), "f"(f606));
  // PTX:1137 div.rn.f32 %f608, %f607, 0f40400000
  asm("div.rn.f32 %0, %1, 0f40400000;" : "=f"(f608) : "f"(f607));
  // PTX:1138 sqrt.rn.f32 %f125, %f608
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f125) : "f"(f608));
  // PTX:1139 setp.leu.f32 %p96, %f125, 0f322BCC77
  p96 = ((isnan(((float)(f125))) || isnan(((float)(as_f32(0x322BCC77u))))) || (((float)(f125)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1140 mov.u32 %r597, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r597) : );
  // PTX:1141 mov.u32 %r598, 0
  asm("mov.u32 %0, 0;" : "=r"(r598) : );
  // PTX:1142 mov.u32 %r599, %r598
  asm("mov.u32 %0, %1;" : "=r"(r599) : "r"(r598));
  // PTX:1143 mov.u32 %r600, %r598
  asm("mov.u32 %0, %1;" : "=r"(r600) : "r"(r598));
  // PTX:1144 mov.u32 %r601, %r597
  asm("mov.u32 %0, %1;" : "=r"(r601) : "r"(r597));
  // PTX:1145 mov.u32 %r602, %r598
  asm("mov.u32 %0, %1;" : "=r"(r602) : "r"(r598));
  // PTX:1146 mov.u32 %r603, %r598
  asm("mov.u32 %0, %1;" : "=r"(r603) : "r"(r598));
  // PTX:1147 mov.u32 %r604, %r598
  asm("mov.u32 %0, %1;" : "=r"(r604) : "r"(r598));
  // PTX:1148 mov.u32 %r605, %r597
  asm("mov.u32 %0, %1;" : "=r"(r605) : "r"(r597));
  // PTX:1149 @%p96 bra $L__BB77_105
  if (p96) { goto L_BB77_105; }
  // PTX:1151 abs.f32 %f609, %f125
  asm("abs.f32 %0, %1;" : "=f"(f609) : "f"(f125));
  // PTX:1152 setp.geu.f32 %p97, %f609, 0f7F800000
  p97 = ((isnan(((float)(f609))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f609)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1153 @%p97 bra $L__BB77_105
  if (p97) { goto L_BB77_105; }
  // PTX:1155 rcp.rn.f32 %f610, %f125
  asm("rcp.rn.f32 %0, %1;" : "=f"(f610) : "f"(f125));
  // PTX:1156 mul.f32 %f1063, %f121, %f610
  asm("mul.f32 %0, %1, %2;" : "=f"(f1063) : "f"(f121), "f"(f610));
  // PTX:1157 mul.f32 %f1064, %f122, %f610
  asm("mul.f32 %0, %1, %2;" : "=f"(f1064) : "f"(f122), "f"(f610));
  // PTX:1158 mul.f32 %f1065, %f123, %f610
  asm("mul.f32 %0, %1, %2;" : "=f"(f1065) : "f"(f123), "f"(f610));
  // PTX:1159 mul.f32 %f1066, %f118, %f610
  asm("mul.f32 %0, %1, %2;" : "=f"(f1066) : "f"(f118), "f"(f610));
  // PTX:1160 mul.f32 %f1067, %f113, %f610
  asm("mul.f32 %0, %1, %2;" : "=f"(f1067) : "f"(f113), "f"(f610));
  // PTX:1161 mul.f32 %f1068, %f115, %f610
  asm("mul.f32 %0, %1, %2;" : "=f"(f1068) : "f"(f115), "f"(f610));
  // PTX:1162 mul.f32 %f1069, %f117, %f610
  asm("mul.f32 %0, %1, %2;" : "=f"(f1069) : "f"(f117), "f"(f610));
  // PTX:1163 mul.f32 %f1070, %f114, %f610
  asm("mul.f32 %0, %1, %2;" : "=f"(f1070) : "f"(f114), "f"(f610));
  // PTX:1164 mul.f32 %f1071, %f112, %f610
  asm("mul.f32 %0, %1, %2;" : "=f"(f1071) : "f"(f112), "f"(f610));
  // PTX:1165 mov.u32 %r581, 0
  asm("mov.u32 %0, 0;" : "=r"(r581) : );
  // PTX:1167 $L__BB77_91:
L_BB77_91:;
  // PTX:1168 mul.f32 %f611, %f1068, %f1070
  asm("mul.f32 %0, %1, %2;" : "=f"(f611) : "f"(f1068), "f"(f1070));
  // PTX:1169 mul.f32 %f612, %f1067, %f1071
  asm("mul.f32 %0, %1, %2;" : "=f"(f612) : "f"(f1067), "f"(f1071));
  // PTX:1170 sub.f32 %f144, %f612, %f611
  asm("sub.f32 %0, %1, %2;" : "=f"(f144) : "f"(f612), "f"(f611));
  // PTX:1171 mul.f32 %f613, %f1066, %f1071
  asm("mul.f32 %0, %1, %2;" : "=f"(f613) : "f"(f1066), "f"(f1071));
  // PTX:1172 mul.f32 %f614, %f1068, %f1069
  asm("mul.f32 %0, %1, %2;" : "=f"(f614) : "f"(f1068), "f"(f1069));
  // PTX:1173 sub.f32 %f145, %f614, %f613
  asm("sub.f32 %0, %1, %2;" : "=f"(f145) : "f"(f614), "f"(f613));
  // PTX:1174 mul.f32 %f615, %f1067, %f1069
  asm("mul.f32 %0, %1, %2;" : "=f"(f615) : "f"(f1067), "f"(f1069));
  // PTX:1175 mul.f32 %f616, %f1066, %f1070
  asm("mul.f32 %0, %1, %2;" : "=f"(f616) : "f"(f1066), "f"(f1070));
  // PTX:1176 sub.f32 %f146, %f616, %f615
  asm("sub.f32 %0, %1, %2;" : "=f"(f146) : "f"(f616), "f"(f615));
  // PTX:1177 mul.f32 %f617, %f1064, %f145
  asm("mul.f32 %0, %1, %2;" : "=f"(f617) : "f"(f1064), "f"(f145));
  // PTX:1178 fma.rn.f32 %f618, %f1063, %f144, %f617
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f618) : "f"(f1063), "f"(f144), "f"(f617));
  // PTX:1179 fma.rn.f32 %f147, %f1065, %f146, %f618
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f147) : "f"(f1065), "f"(f146), "f"(f618));
  // PTX:1180 abs.f32 %f619, %f147
  asm("abs.f32 %0, %1;" : "=f"(f619) : "f"(f147));
  // PTX:1181 setp.le.f32 %p98, %f619, 0f2EDBE6FF
  p98 = (!(isnan(((float)(f619))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f619)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:1182 setp.geu.f32 %p99, %f619, 0f7F800000
  p99 = ((isnan(((float)(f619))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f619)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1183 or.pred %p100, %p98, %p99
  p100 = ((p98) || (p99));
  // PTX:1184 @%p100 bra $L__BB77_94
  if (p100) { goto L_BB77_94; }
  // PTX:1186 rcp.rn.f32 %f620, %f147
  asm("rcp.rn.f32 %0, %1;" : "=f"(f620) : "f"(f147));
  // PTX:1187 mul.f32 %f621, %f1064, %f1071
  asm("mul.f32 %0, %1, %2;" : "=f"(f621) : "f"(f1064), "f"(f1071));
  // PTX:1188 mul.f32 %f622, %f1065, %f1070
  asm("mul.f32 %0, %1, %2;" : "=f"(f622) : "f"(f1065), "f"(f1070));
  // PTX:1189 sub.f32 %f623, %f622, %f621
  asm("sub.f32 %0, %1, %2;" : "=f"(f623) : "f"(f622), "f"(f621));
  // PTX:1190 mul.f32 %f624, %f1065, %f1069
  asm("mul.f32 %0, %1, %2;" : "=f"(f624) : "f"(f1065), "f"(f1069));
  // PTX:1191 mul.f32 %f625, %f1063, %f1071
  asm("mul.f32 %0, %1, %2;" : "=f"(f625) : "f"(f1063), "f"(f1071));
  // PTX:1192 sub.f32 %f626, %f625, %f624
  asm("sub.f32 %0, %1, %2;" : "=f"(f626) : "f"(f625), "f"(f624));
  // PTX:1193 mul.f32 %f627, %f1063, %f1070
  asm("mul.f32 %0, %1, %2;" : "=f"(f627) : "f"(f1063), "f"(f1070));
  // PTX:1194 mul.f32 %f628, %f1064, %f1069
  asm("mul.f32 %0, %1, %2;" : "=f"(f628) : "f"(f1064), "f"(f1069));
  // PTX:1195 sub.f32 %f629, %f628, %f627
  asm("sub.f32 %0, %1, %2;" : "=f"(f629) : "f"(f628), "f"(f627));
  // PTX:1196 mul.f32 %f630, %f1065, %f1067
  asm("mul.f32 %0, %1, %2;" : "=f"(f630) : "f"(f1065), "f"(f1067));
  // PTX:1197 mul.f32 %f631, %f1064, %f1068
  asm("mul.f32 %0, %1, %2;" : "=f"(f631) : "f"(f1064), "f"(f1068));
  // PTX:1198 sub.f32 %f632, %f631, %f630
  asm("sub.f32 %0, %1, %2;" : "=f"(f632) : "f"(f631), "f"(f630));
  // PTX:1199 mul.f32 %f633, %f1063, %f1068
  asm("mul.f32 %0, %1, %2;" : "=f"(f633) : "f"(f1063), "f"(f1068));
  // PTX:1200 mul.f32 %f634, %f1065, %f1066
  asm("mul.f32 %0, %1, %2;" : "=f"(f634) : "f"(f1065), "f"(f1066));
  // PTX:1201 sub.f32 %f635, %f634, %f633
  asm("sub.f32 %0, %1, %2;" : "=f"(f635) : "f"(f634), "f"(f633));
  // PTX:1202 mul.f32 %f636, %f1064, %f1066
  asm("mul.f32 %0, %1, %2;" : "=f"(f636) : "f"(f1064), "f"(f1066));
  // PTX:1203 mul.f32 %f637, %f1063, %f1067
  asm("mul.f32 %0, %1, %2;" : "=f"(f637) : "f"(f1063), "f"(f1067));
  // PTX:1204 sub.f32 %f638, %f637, %f636
  asm("sub.f32 %0, %1, %2;" : "=f"(f638) : "f"(f637), "f"(f636));
  // PTX:1205 fma.rn.f32 %f639, %f144, %f620, %f1063
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f639) : "f"(f144), "f"(f620), "f"(f1063));
  // PTX:1206 fma.rn.f32 %f640, %f145, %f620, %f1064
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f640) : "f"(f145), "f"(f620), "f"(f1064));
  // PTX:1207 fma.rn.f32 %f641, %f146, %f620, %f1065
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f641) : "f"(f146), "f"(f620), "f"(f1065));
  // PTX:1208 fma.rn.f32 %f642, %f623, %f620, %f1066
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f642) : "f"(f623), "f"(f620), "f"(f1066));
  // PTX:1209 fma.rn.f32 %f643, %f626, %f620, %f1067
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f643) : "f"(f626), "f"(f620), "f"(f1067));
  // PTX:1210 fma.rn.f32 %f644, %f629, %f620, %f1068
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f644) : "f"(f629), "f"(f620), "f"(f1068));
  // PTX:1211 fma.rn.f32 %f645, %f632, %f620, %f1069
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f645) : "f"(f632), "f"(f620), "f"(f1069));
  // PTX:1212 fma.rn.f32 %f646, %f635, %f620, %f1070
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f646) : "f"(f635), "f"(f620), "f"(f1070));
  // PTX:1213 fma.rn.f32 %f647, %f638, %f620, %f1071
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f647) : "f"(f638), "f"(f620), "f"(f1071));
  // PTX:1214 mul.f32 %f1063, %f639, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1063) : "f"(f639));
  // PTX:1215 mul.f32 %f1064, %f640, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1064) : "f"(f640));
  // PTX:1216 mul.f32 %f1065, %f641, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1065) : "f"(f641));
  // PTX:1217 mul.f32 %f1066, %f642, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1066) : "f"(f642));
  // PTX:1218 mul.f32 %f1067, %f643, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1067) : "f"(f643));
  // PTX:1219 mul.f32 %f1068, %f644, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1068) : "f"(f644));
  // PTX:1220 mul.f32 %f1069, %f645, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1069) : "f"(f645));
  // PTX:1221 mul.f32 %f1070, %f646, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1070) : "f"(f646));
  // PTX:1222 mul.f32 %f1071, %f647, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1071) : "f"(f647));
  // PTX:1223 mul.f32 %f648, %f1067, %f1071
  asm("mul.f32 %0, %1, %2;" : "=f"(f648) : "f"(f1067), "f"(f1071));
  // PTX:1224 mul.f32 %f649, %f1068, %f1070
  asm("mul.f32 %0, %1, %2;" : "=f"(f649) : "f"(f1068), "f"(f1070));
  // PTX:1225 sub.f32 %f157, %f648, %f649
  asm("sub.f32 %0, %1, %2;" : "=f"(f157) : "f"(f648), "f"(f649));
  // PTX:1226 mul.f32 %f650, %f1068, %f1069
  asm("mul.f32 %0, %1, %2;" : "=f"(f650) : "f"(f1068), "f"(f1069));
  // PTX:1227 mul.f32 %f651, %f1066, %f1071
  asm("mul.f32 %0, %1, %2;" : "=f"(f651) : "f"(f1066), "f"(f1071));
  // PTX:1228 sub.f32 %f158, %f650, %f651
  asm("sub.f32 %0, %1, %2;" : "=f"(f158) : "f"(f650), "f"(f651));
  // PTX:1229 mul.f32 %f652, %f1066, %f1070
  asm("mul.f32 %0, %1, %2;" : "=f"(f652) : "f"(f1066), "f"(f1070));
  // PTX:1230 mul.f32 %f653, %f1067, %f1069
  asm("mul.f32 %0, %1, %2;" : "=f"(f653) : "f"(f1067), "f"(f1069));
  // PTX:1231 sub.f32 %f159, %f652, %f653
  asm("sub.f32 %0, %1, %2;" : "=f"(f159) : "f"(f652), "f"(f653));
  // PTX:1232 mul.f32 %f654, %f1064, %f158
  asm("mul.f32 %0, %1, %2;" : "=f"(f654) : "f"(f1064), "f"(f158));
  // PTX:1233 fma.rn.f32 %f655, %f1063, %f157, %f654
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f655) : "f"(f1063), "f"(f157), "f"(f654));
  // PTX:1234 fma.rn.f32 %f160, %f1065, %f159, %f655
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f160) : "f"(f1065), "f"(f159), "f"(f655));
  // PTX:1235 abs.f32 %f656, %f160
  asm("abs.f32 %0, %1;" : "=f"(f656) : "f"(f160));
  // PTX:1236 setp.le.f32 %p101, %f656, 0f2EDBE6FF
  p101 = (!(isnan(((float)(f656))) || isnan(((float)(as_f32(0x2EDBE6FFu))))) && (((float)(f656)) <= ((float)(as_f32(0x2EDBE6FFu)))));
  // PTX:1237 setp.geu.f32 %p102, %f656, 0f7F800000
  p102 = ((isnan(((float)(f656))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f656)) >= ((float)(as_f32(0x7F800000u)))));
  // PTX:1238 or.pred %p103, %p101, %p102
  p103 = ((p101) || (p102));
  // PTX:1239 @%p103 bra $L__BB77_94
  if (p103) { goto L_BB77_94; }
  // PTX:1241 rcp.rn.f32 %f657, %f160
  asm("rcp.rn.f32 %0, %1;" : "=f"(f657) : "f"(f160));
  // PTX:1242 mul.f32 %f658, %f1064, %f1071
  asm("mul.f32 %0, %1, %2;" : "=f"(f658) : "f"(f1064), "f"(f1071));
  // PTX:1243 mul.f32 %f659, %f1065, %f1070
  asm("mul.f32 %0, %1, %2;" : "=f"(f659) : "f"(f1065), "f"(f1070));
  // PTX:1244 sub.f32 %f660, %f659, %f658
  asm("sub.f32 %0, %1, %2;" : "=f"(f660) : "f"(f659), "f"(f658));
  // PTX:1245 mul.f32 %f661, %f1065, %f1069
  asm("mul.f32 %0, %1, %2;" : "=f"(f661) : "f"(f1065), "f"(f1069));
  // PTX:1246 mul.f32 %f662, %f1063, %f1071
  asm("mul.f32 %0, %1, %2;" : "=f"(f662) : "f"(f1063), "f"(f1071));
  // PTX:1247 sub.f32 %f663, %f662, %f661
  asm("sub.f32 %0, %1, %2;" : "=f"(f663) : "f"(f662), "f"(f661));
  // PTX:1248 mul.f32 %f664, %f1063, %f1070
  asm("mul.f32 %0, %1, %2;" : "=f"(f664) : "f"(f1063), "f"(f1070));
  // PTX:1249 mul.f32 %f665, %f1064, %f1069
  asm("mul.f32 %0, %1, %2;" : "=f"(f665) : "f"(f1064), "f"(f1069));
  // PTX:1250 sub.f32 %f666, %f665, %f664
  asm("sub.f32 %0, %1, %2;" : "=f"(f666) : "f"(f665), "f"(f664));
  // PTX:1251 mul.f32 %f667, %f1065, %f1067
  asm("mul.f32 %0, %1, %2;" : "=f"(f667) : "f"(f1065), "f"(f1067));
  // PTX:1252 mul.f32 %f668, %f1064, %f1068
  asm("mul.f32 %0, %1, %2;" : "=f"(f668) : "f"(f1064), "f"(f1068));
  // PTX:1253 sub.f32 %f669, %f668, %f667
  asm("sub.f32 %0, %1, %2;" : "=f"(f669) : "f"(f668), "f"(f667));
  // PTX:1254 mul.f32 %f670, %f1063, %f1068
  asm("mul.f32 %0, %1, %2;" : "=f"(f670) : "f"(f1063), "f"(f1068));
  // PTX:1255 mul.f32 %f671, %f1065, %f1066
  asm("mul.f32 %0, %1, %2;" : "=f"(f671) : "f"(f1065), "f"(f1066));
  // PTX:1256 sub.f32 %f672, %f671, %f670
  asm("sub.f32 %0, %1, %2;" : "=f"(f672) : "f"(f671), "f"(f670));
  // PTX:1257 mul.f32 %f673, %f1064, %f1066
  asm("mul.f32 %0, %1, %2;" : "=f"(f673) : "f"(f1064), "f"(f1066));
  // PTX:1258 mul.f32 %f674, %f1063, %f1067
  asm("mul.f32 %0, %1, %2;" : "=f"(f674) : "f"(f1063), "f"(f1067));
  // PTX:1259 sub.f32 %f675, %f674, %f673
  asm("sub.f32 %0, %1, %2;" : "=f"(f675) : "f"(f674), "f"(f673));
  // PTX:1260 fma.rn.f32 %f676, %f157, %f657, %f1063
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f676) : "f"(f157), "f"(f657), "f"(f1063));
  // PTX:1261 fma.rn.f32 %f677, %f158, %f657, %f1064
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f677) : "f"(f158), "f"(f657), "f"(f1064));
  // PTX:1262 fma.rn.f32 %f678, %f159, %f657, %f1065
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f678) : "f"(f159), "f"(f657), "f"(f1065));
  // PTX:1263 fma.rn.f32 %f679, %f660, %f657, %f1066
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f679) : "f"(f660), "f"(f657), "f"(f1066));
  // PTX:1264 fma.rn.f32 %f680, %f663, %f657, %f1067
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f680) : "f"(f663), "f"(f657), "f"(f1067));
  // PTX:1265 fma.rn.f32 %f681, %f666, %f657, %f1068
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f681) : "f"(f666), "f"(f657), "f"(f1068));
  // PTX:1266 fma.rn.f32 %f682, %f669, %f657, %f1069
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f682) : "f"(f669), "f"(f657), "f"(f1069));
  // PTX:1267 fma.rn.f32 %f683, %f672, %f657, %f1070
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f683) : "f"(f672), "f"(f657), "f"(f1070));
  // PTX:1268 fma.rn.f32 %f684, %f675, %f657, %f1071
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f684) : "f"(f675), "f"(f657), "f"(f1071));
  // PTX:1269 mul.f32 %f1063, %f676, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1063) : "f"(f676));
  // PTX:1270 mul.f32 %f1064, %f677, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1064) : "f"(f677));
  // PTX:1271 mul.f32 %f1065, %f678, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1065) : "f"(f678));
  // PTX:1272 mul.f32 %f1066, %f679, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1066) : "f"(f679));
  // PTX:1273 mul.f32 %f1067, %f680, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1067) : "f"(f680));
  // PTX:1274 mul.f32 %f1068, %f681, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1068) : "f"(f681));
  // PTX:1275 mul.f32 %f1069, %f682, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1069) : "f"(f682));
  // PTX:1276 mul.f32 %f1070, %f683, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1070) : "f"(f683));
  // PTX:1277 mul.f32 %f1071, %f684, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f1071) : "f"(f684));
  // PTX:1278 add.s32 %r581, %r581, 2
  asm("add.s32 %0, %1, 2;" : "=r"(r581) : "r"(r581));
  // PTX:1279 setp.lt.u32 %p104, %r581, 8
  p104 = (((unsigned)(r581)) < ((unsigned)(8)));
  // PTX:1280 @%p104 bra $L__BB77_91
  if (p104) { goto L_BB77_91; }
  // PTX:1282 $L__BB77_94:
L_BB77_94:;
  // PTX:1283 mul.f32 %f685, %f1064, %f1064
  asm("mul.f32 %0, %1, %2;" : "=f"(f685) : "f"(f1064), "f"(f1064));
  // PTX:1284 fma.rn.f32 %f686, %f1063, %f1063, %f685
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f686) : "f"(f1063), "f"(f1063), "f"(f685));
  // PTX:1285 fma.rn.f32 %f687, %f1065, %f1065, %f686
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f687) : "f"(f1065), "f"(f1065), "f"(f686));
  // PTX:1286 sqrt.rn.f32 %f179, %f687
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f179) : "f"(f687));
  // PTX:1287 setp.leu.f32 %p105, %f179, 0f00000000
  p105 = ((isnan(((float)(f179))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f179)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1288 mov.u32 %r594, 0
  asm("mov.u32 %0, 0;" : "=r"(r594) : );
  // PTX:1289 mov.u32 %r582, %r594
  asm("mov.u32 %0, %1;" : "=r"(r582) : "r"(r594));
  // PTX:1290 mov.u32 %r583, %r594
  asm("mov.u32 %0, %1;" : "=r"(r583) : "r"(r594));
  // PTX:1291 mov.u32 %r584, %r594
  asm("mov.u32 %0, %1;" : "=r"(r584) : "r"(r594));
  // PTX:1292 @%p105 bra $L__BB77_96
  if (p105) { goto L_BB77_96; }
  // PTX:1294 div.rn.f32 %f688, %f1063, %f179
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f688) : "f"(f1063), "f"(f179));
  // PTX:1295 div.rn.f32 %f689, %f1064, %f179
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f689) : "f"(f1064), "f"(f179));
  // PTX:1296 div.rn.f32 %f690, %f1065, %f179
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f690) : "f"(f1065), "f"(f179));
  // PTX:1297 mov.b32 %r584, %f690
  asm("mov.b32 %0, %1;" : "=r"(r584) : "f"(f690));
  // PTX:1298 mov.b32 %r583, %f689
  asm("mov.b32 %0, %1;" : "=r"(r583) : "f"(f689));
  // PTX:1299 mov.b32 %r582, %f688
  asm("mov.b32 %0, %1;" : "=r"(r582) : "f"(f688));
  // PTX:1301 $L__BB77_96:
L_BB77_96:;
  // PTX:1302 mov.b32 %f180, %r582
  asm("mov.b32 %0, %1;" : "=f"(f180) : "r"(r582));
  // PTX:1303 mov.b32 %f181, %r583
  asm("mov.b32 %0, %1;" : "=f"(f181) : "r"(r583));
  // PTX:1304 mul.f32 %f691, %f1067, %f181
  asm("mul.f32 %0, %1, %2;" : "=f"(f691) : "f"(f1067), "f"(f181));
  // PTX:1305 mov.b32 %f182, %r584
  asm("mov.b32 %0, %1;" : "=f"(f182) : "r"(r584));
  // PTX:1306 fma.rn.f32 %f692, %f1066, %f180, %f691
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f692) : "f"(f1066), "f"(f180), "f"(f691));
  // PTX:1307 fma.rn.f32 %f693, %f1068, %f182, %f692
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f693) : "f"(f1068), "f"(f182), "f"(f692));
  // PTX:1308 mul.f32 %f694, %f693, %f180
  asm("mul.f32 %0, %1, %2;" : "=f"(f694) : "f"(f693), "f"(f180));
  // PTX:1309 mul.f32 %f695, %f693, %f181
  asm("mul.f32 %0, %1, %2;" : "=f"(f695) : "f"(f693), "f"(f181));
  // PTX:1310 mul.f32 %f696, %f693, %f182
  asm("mul.f32 %0, %1, %2;" : "=f"(f696) : "f"(f693), "f"(f182));
  // PTX:1311 sub.f32 %f183, %f1066, %f694
  asm("sub.f32 %0, %1, %2;" : "=f"(f183) : "f"(f1066), "f"(f694));
  // PTX:1312 sub.f32 %f184, %f1067, %f695
  asm("sub.f32 %0, %1, %2;" : "=f"(f184) : "f"(f1067), "f"(f695));
  // PTX:1313 sub.f32 %f185, %f1068, %f696
  asm("sub.f32 %0, %1, %2;" : "=f"(f185) : "f"(f1068), "f"(f696));
  // PTX:1314 mul.f32 %f697, %f184, %f184
  asm("mul.f32 %0, %1, %2;" : "=f"(f697) : "f"(f184), "f"(f184));
  // PTX:1315 fma.rn.f32 %f698, %f183, %f183, %f697
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f698) : "f"(f183), "f"(f183), "f"(f697));
  // PTX:1316 fma.rn.f32 %f699, %f185, %f185, %f698
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f699) : "f"(f185), "f"(f185), "f"(f698));
  // PTX:1317 sqrt.rn.f32 %f186, %f699
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f186) : "f"(f699));
  // PTX:1318 setp.leu.f32 %p106, %f186, 0f00000000
  p106 = ((isnan(((float)(f186))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f186)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1319 mov.u32 %r595, %r594
  asm("mov.u32 %0, %1;" : "=r"(r595) : "r"(r594));
  // PTX:1320 mov.u32 %r596, %r594
  asm("mov.u32 %0, %1;" : "=r"(r596) : "r"(r594));
  // PTX:1321 @%p106 bra $L__BB77_98
  if (p106) { goto L_BB77_98; }
  // PTX:1323 div.rn.f32 %f700, %f183, %f186
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f700) : "f"(f183), "f"(f186));
  // PTX:1324 div.rn.f32 %f701, %f184, %f186
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f701) : "f"(f184), "f"(f186));
  // PTX:1325 div.rn.f32 %f702, %f185, %f186
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f702) : "f"(f185), "f"(f186));
  // PTX:1326 mov.b32 %r596, %f702
  asm("mov.b32 %0, %1;" : "=r"(r596) : "f"(f702));
  // PTX:1327 mov.b32 %r595, %f701
  asm("mov.b32 %0, %1;" : "=r"(r595) : "f"(f701));
  // PTX:1328 mov.b32 %r594, %f700
  asm("mov.b32 %0, %1;" : "=r"(r594) : "f"(f700));
  // PTX:1330 $L__BB77_98:
L_BB77_98:;
  // PTX:1331 mul.f32 %f703, %f181, %f181
  asm("mul.f32 %0, %1, %2;" : "=f"(f703) : "f"(f181), "f"(f181));
  // PTX:1332 fma.rn.f32 %f704, %f180, %f180, %f703
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f704) : "f"(f180), "f"(f180), "f"(f703));
  // PTX:1333 fma.rn.f32 %f705, %f182, %f182, %f704
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f705) : "f"(f182), "f"(f182), "f"(f704));
  // PTX:1334 sqrt.rn.f32 %f706, %f705
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f706) : "f"(f705));
  // PTX:1335 setp.le.f32 %p107, %f706, 0f322BCC77
  p107 = (!(isnan(((float)(f706))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f706)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1336 mov.u32 %r598, 0
  asm("mov.u32 %0, 0;" : "=r"(r598) : );
  // PTX:1337 mov.u32 %r599, %r598
  asm("mov.u32 %0, %1;" : "=r"(r599) : "r"(r598));
  // PTX:1338 mov.u32 %r600, %r598
  asm("mov.u32 %0, %1;" : "=r"(r600) : "r"(r598));
  // PTX:1339 mov.u32 %r601, %r597
  asm("mov.u32 %0, %1;" : "=r"(r601) : "r"(r597));
  // PTX:1340 mov.u32 %r602, %r598
  asm("mov.u32 %0, %1;" : "=r"(r602) : "r"(r598));
  // PTX:1341 mov.u32 %r603, %r598
  asm("mov.u32 %0, %1;" : "=r"(r603) : "r"(r598));
  // PTX:1342 mov.u32 %r604, %r598
  asm("mov.u32 %0, %1;" : "=r"(r604) : "r"(r598));
  // PTX:1343 mov.u32 %r605, %r597
  asm("mov.u32 %0, %1;" : "=r"(r605) : "r"(r597));
  // PTX:1344 @%p107 bra $L__BB77_105
  if (p107) { goto L_BB77_105; }
  // PTX:1346 mov.b32 %f187, %r594
  asm("mov.b32 %0, %1;" : "=f"(f187) : "r"(r594));
  // PTX:1347 mov.b32 %f188, %r595
  asm("mov.b32 %0, %1;" : "=f"(f188) : "r"(r595));
  // PTX:1348 mul.f32 %f707, %f188, %f188
  asm("mul.f32 %0, %1, %2;" : "=f"(f707) : "f"(f188), "f"(f188));
  // PTX:1349 mov.b32 %f189, %r596
  asm("mov.b32 %0, %1;" : "=f"(f189) : "r"(r596));
  // PTX:1350 fma.rn.f32 %f708, %f187, %f187, %f707
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f708) : "f"(f187), "f"(f187), "f"(f707));
  // PTX:1351 fma.rn.f32 %f709, %f189, %f189, %f708
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f709) : "f"(f189), "f"(f189), "f"(f708));
  // PTX:1352 sqrt.rn.f32 %f710, %f709
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f710) : "f"(f709));
  // PTX:1353 setp.le.f32 %p108, %f710, 0f322BCC77
  p108 = (!(isnan(((float)(f710))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f710)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:1354 mov.u32 %r601, %r597
  asm("mov.u32 %0, %1;" : "=r"(r601) : "r"(r597));
  // PTX:1355 mov.u32 %r605, %r597
  asm("mov.u32 %0, %1;" : "=r"(r605) : "r"(r597));
  // PTX:1356 @%p108 bra $L__BB77_105
  if (p108) { goto L_BB77_105; }
  // PTX:1358 mul.f32 %f711, %f181, %f189
  asm("mul.f32 %0, %1, %2;" : "=f"(f711) : "f"(f181), "f"(f189));
  // PTX:1359 mul.f32 %f712, %f182, %f188
  asm("mul.f32 %0, %1, %2;" : "=f"(f712) : "f"(f182), "f"(f188));
  // PTX:1360 sub.f32 %f190, %f711, %f712
  asm("sub.f32 %0, %1, %2;" : "=f"(f190) : "f"(f711), "f"(f712));
  // PTX:1361 mul.f32 %f713, %f180, %f189
  asm("mul.f32 %0, %1, %2;" : "=f"(f713) : "f"(f180), "f"(f189));
  // PTX:1362 mul.f32 %f714, %f182, %f187
  asm("mul.f32 %0, %1, %2;" : "=f"(f714) : "f"(f182), "f"(f187));
  // PTX:1363 sub.f32 %f191, %f714, %f713
  asm("sub.f32 %0, %1, %2;" : "=f"(f191) : "f"(f714), "f"(f713));
  // PTX:1364 mul.f32 %f715, %f181, %f187
  asm("mul.f32 %0, %1, %2;" : "=f"(f715) : "f"(f181), "f"(f187));
  // PTX:1365 mul.f32 %f716, %f180, %f188
  asm("mul.f32 %0, %1, %2;" : "=f"(f716) : "f"(f180), "f"(f188));
  // PTX:1366 sub.f32 %f192, %f716, %f715
  asm("sub.f32 %0, %1, %2;" : "=f"(f192) : "f"(f716), "f"(f715));
  // PTX:1367 mul.f32 %f717, %f191, %f191
  asm("mul.f32 %0, %1, %2;" : "=f"(f717) : "f"(f191), "f"(f191));
  // PTX:1368 fma.rn.f32 %f718, %f190, %f190, %f717
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f718) : "f"(f190), "f"(f190), "f"(f717));
  // PTX:1369 fma.rn.f32 %f719, %f192, %f192, %f718
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f719) : "f"(f192), "f"(f192), "f"(f718));
  // PTX:1370 sqrt.rn.f32 %f193, %f719
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f193) : "f"(f719));
  // PTX:1371 setp.leu.f32 %p109, %f193, 0f00000000
  p109 = ((isnan(((float)(f193))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f193)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1372 mov.u32 %r603, 0
  asm("mov.u32 %0, 0;" : "=r"(r603) : );
  // PTX:1373 mov.u32 %r604, %r603
  asm("mov.u32 %0, %1;" : "=r"(r604) : "r"(r603));
  // PTX:1374 mov.u32 %r605, %r603
  asm("mov.u32 %0, %1;" : "=r"(r605) : "r"(r603));
  // PTX:1375 @%p109 bra $L__BB77_102
  if (p109) { goto L_BB77_102; }
  // PTX:1377 div.rn.f32 %f720, %f190, %f193
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f720) : "f"(f190), "f"(f193));
  // PTX:1378 div.rn.f32 %f721, %f191, %f193
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f721) : "f"(f191), "f"(f193));
  // PTX:1379 div.rn.f32 %f722, %f192, %f193
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f722) : "f"(f192), "f"(f193));
  // PTX:1380 mov.b32 %r605, %f722
  asm("mov.b32 %0, %1;" : "=r"(r605) : "f"(f722));
  // PTX:1381 mov.b32 %r604, %f721
  asm("mov.b32 %0, %1;" : "=r"(r604) : "f"(f721));
  // PTX:1382 mov.b32 %r603, %f720
  asm("mov.b32 %0, %1;" : "=r"(r603) : "f"(f720));
  // PTX:1384 $L__BB77_102:
L_BB77_102:;
  // PTX:1385 mov.b32 %f194, %r603
  asm("mov.b32 %0, %1;" : "=f"(f194) : "r"(r603));
  // PTX:1386 mov.b32 %f195, %r604
  asm("mov.b32 %0, %1;" : "=f"(f195) : "r"(r604));
  // PTX:1387 mul.f32 %f723, %f1070, %f195
  asm("mul.f32 %0, %1, %2;" : "=f"(f723) : "f"(f1070), "f"(f195));
  // PTX:1388 mov.b32 %f196, %r605
  asm("mov.b32 %0, %1;" : "=f"(f196) : "r"(r605));
  // PTX:1389 fma.rn.f32 %f724, %f1069, %f194, %f723
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f724) : "f"(f1069), "f"(f194), "f"(f723));
  // PTX:1390 fma.rn.f32 %f725, %f1071, %f196, %f724
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f725) : "f"(f1071), "f"(f196), "f"(f724));
  // PTX:1391 setp.geu.f32 %p110, %f725, 0f00000000
  p110 = ((isnan(((float)(f725))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f725)) >= ((float)(as_f32(0x00000000u)))));
  // PTX:1392 @%p110 bra $L__BB77_104
  if (p110) { goto L_BB77_104; }
  // PTX:1394 neg.f32 %f726, %f187
  asm("neg.f32 %0, %1;" : "=f"(f726) : "f"(f187));
  // PTX:1395 mov.b32 %r594, %f726
  asm("mov.b32 %0, %1;" : "=r"(r594) : "f"(f726));
  // PTX:1396 neg.f32 %f727, %f188
  asm("neg.f32 %0, %1;" : "=f"(f727) : "f"(f188));
  // PTX:1397 mov.b32 %r595, %f727
  asm("mov.b32 %0, %1;" : "=r"(r595) : "f"(f727));
  // PTX:1398 neg.f32 %f728, %f189
  asm("neg.f32 %0, %1;" : "=f"(f728) : "f"(f189));
  // PTX:1399 mov.b32 %r596, %f728
  asm("mov.b32 %0, %1;" : "=r"(r596) : "f"(f728));
  // PTX:1400 neg.f32 %f729, %f194
  asm("neg.f32 %0, %1;" : "=f"(f729) : "f"(f194));
  // PTX:1401 mov.b32 %r603, %f729
  asm("mov.b32 %0, %1;" : "=r"(r603) : "f"(f729));
  // PTX:1402 neg.f32 %f730, %f195
  asm("neg.f32 %0, %1;" : "=f"(f730) : "f"(f195));
  // PTX:1403 mov.b32 %r604, %f730
  asm("mov.b32 %0, %1;" : "=r"(r604) : "f"(f730));
  // PTX:1404 neg.f32 %f731, %f196
  asm("neg.f32 %0, %1;" : "=f"(f731) : "f"(f196));
  // PTX:1405 mov.b32 %r605, %f731
  asm("mov.b32 %0, %1;" : "=r"(r605) : "f"(f731));
  // PTX:1407 $L__BB77_104:
L_BB77_104:;
  // PTX:1408 mov.u32 %r597, %r582
  asm("mov.u32 %0, %1;" : "=r"(r597) : "r"(r582));
  // PTX:1409 mov.u32 %r598, %r583
  asm("mov.u32 %0, %1;" : "=r"(r598) : "r"(r583));
  // PTX:1410 mov.u32 %r599, %r584
  asm("mov.u32 %0, %1;" : "=r"(r599) : "r"(r584));
  // PTX:1411 mov.u32 %r600, %r594
  asm("mov.u32 %0, %1;" : "=r"(r600) : "r"(r594));
  // PTX:1412 mov.u32 %r601, %r595
  asm("mov.u32 %0, %1;" : "=r"(r601) : "r"(r595));
  // PTX:1413 mov.u32 %r602, %r596
  asm("mov.u32 %0, %1;" : "=r"(r602) : "r"(r596));
  // PTX:1415 $L__BB77_105:
L_BB77_105:;
  // PTX:1416 mov.b32 %f732, %r597
  asm("mov.b32 %0, %1;" : "=f"(f732) : "r"(r597));
  // PTX:1417 mov.b32 %f733, %r600
  asm("mov.b32 %0, %1;" : "=f"(f733) : "r"(r600));
  // PTX:1418 mov.b32 %f734, %r603
  asm("mov.b32 %0, %1;" : "=f"(f734) : "r"(r603));
  // PTX:1419 mov.b32 %f735, %r598
  asm("mov.b32 %0, %1;" : "=f"(f735) : "r"(r598));
  // PTX:1420 mul.f32 %f736, %f110, %f735
  asm("mul.f32 %0, %1, %2;" : "=f"(f736) : "f"(f110), "f"(f735));
  // PTX:1421 mov.b32 %f737, %r601
  asm("mov.b32 %0, %1;" : "=f"(f737) : "r"(r601));
  // PTX:1422 mul.f32 %f738, %f110, %f737
  asm("mul.f32 %0, %1, %2;" : "=f"(f738) : "f"(f110), "f"(f737));
  // PTX:1423 mov.b32 %f739, %r604
  asm("mov.b32 %0, %1;" : "=f"(f739) : "r"(r604));
  // PTX:1424 mul.f32 %f740, %f110, %f739
  asm("mul.f32 %0, %1, %2;" : "=f"(f740) : "f"(f110), "f"(f739));
  // PTX:1425 fma.rn.f32 %f741, %f109, %f732, %f736
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f741) : "f"(f109), "f"(f732), "f"(f736));
  // PTX:1426 fma.rn.f32 %f742, %f109, %f733, %f738
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f742) : "f"(f109), "f"(f733), "f"(f738));
  // PTX:1427 fma.rn.f32 %f743, %f109, %f734, %f740
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f743) : "f"(f109), "f"(f734), "f"(f740));
  // PTX:1428 mov.b32 %f744, %r599
  asm("mov.b32 %0, %1;" : "=f"(f744) : "r"(r599));
  // PTX:1429 mov.b32 %f745, %r602
  asm("mov.b32 %0, %1;" : "=f"(f745) : "r"(r602));
  // PTX:1430 mov.b32 %f746, %r605
  asm("mov.b32 %0, %1;" : "=f"(f746) : "r"(r605));
  // PTX:1431 fma.rn.f32 %f1072, %f111, %f744, %f741
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1072) : "f"(f111), "f"(f744), "f"(f741));
  // PTX:1432 fma.rn.f32 %f1073, %f111, %f745, %f742
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1073) : "f"(f111), "f"(f745), "f"(f742));
  // PTX:1433 fma.rn.f32 %f1074, %f111, %f746, %f743
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1074) : "f"(f111), "f"(f746), "f"(f743));
  // PTX:1434 bra.uni $L__BB77_106
  goto L_BB77_106;
  // PTX:1436 $L__BB77_107:
L_BB77_107:;
  // PTX:1437 ld.global.f32 %f759, [%rd71]
  f759 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))));
  // PTX:1438 mul.f32 %f760, %f759, %f1032
  asm("mul.f32 %0, %1, %2;" : "=f"(f760) : "f"(f759), "f"(f1032));
  // PTX:1439 mul.f32 %f761, %f759, %f1031
  asm("mul.f32 %0, %1, %2;" : "=f"(f761) : "f"(f759), "f"(f1031));
  // PTX:1440 mul.f32 %f762, %f759, %f1030
  asm("mul.f32 %0, %1, %2;" : "=f"(f762) : "f"(f759), "f"(f1030));
  // PTX:1441 mov.b32 %f763, %r623
  asm("mov.b32 %0, %1;" : "=f"(f763) : "r"(r623));
  // PTX:1442 sub.f32 %f764, %f763, %f760
  asm("sub.f32 %0, %1, %2;" : "=f"(f764) : "f"(f763), "f"(f760));
  // PTX:1443 mov.b32 %f765, %r622
  asm("mov.b32 %0, %1;" : "=f"(f765) : "r"(r622));
  // PTX:1444 sub.f32 %f766, %f765, %f761
  asm("sub.f32 %0, %1, %2;" : "=f"(f766) : "f"(f765), "f"(f761));
  // PTX:1445 mov.b32 %f767, %r621
  asm("mov.b32 %0, %1;" : "=f"(f767) : "r"(r621));
  // PTX:1446 sub.f32 %f768, %f767, %f762
  asm("sub.f32 %0, %1, %2;" : "=f"(f768) : "f"(f767), "f"(f762));
  // PTX:1447 mov.b32 %r623, %f764
  asm("mov.b32 %0, %1;" : "=r"(r623) : "f"(f764));
  // PTX:1448 mov.b32 %r622, %f766
  asm("mov.b32 %0, %1;" : "=r"(r622) : "f"(f766));
  // PTX:1449 mov.b32 %r621, %f768
  asm("mov.b32 %0, %1;" : "=r"(r621) : "f"(f768));
  // PTX:1450 bra.uni $L__BB77_108
  goto L_BB77_108;
  // PTX:1452 $L__BB77_87:
L_BB77_87:;
  // PTX:1453 rcp.rn.f32 %f560, %f124
  asm("rcp.rn.f32 %0, %1;" : "=f"(f560) : "f"(f124));
  // PTX:1454 mul.f32 %f561, %f122, %f112
  asm("mul.f32 %0, %1, %2;" : "=f"(f561) : "f"(f122), "f"(f112));
  // PTX:1455 mul.f32 %f562, %f123, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f562) : "f"(f123), "f"(f114));
  // PTX:1456 sub.f32 %f563, %f562, %f561
  asm("sub.f32 %0, %1, %2;" : "=f"(f563) : "f"(f562), "f"(f561));
  // PTX:1457 mul.f32 %f564, %f123, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f564) : "f"(f123), "f"(f117));
  // PTX:1458 mul.f32 %f565, %f121, %f112
  asm("mul.f32 %0, %1, %2;" : "=f"(f565) : "f"(f121), "f"(f112));
  // PTX:1459 sub.f32 %f566, %f565, %f564
  asm("sub.f32 %0, %1, %2;" : "=f"(f566) : "f"(f565), "f"(f564));
  // PTX:1460 mul.f32 %f567, %f121, %f114
  asm("mul.f32 %0, %1, %2;" : "=f"(f567) : "f"(f121), "f"(f114));
  // PTX:1461 mul.f32 %f568, %f122, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f568) : "f"(f122), "f"(f117));
  // PTX:1462 sub.f32 %f569, %f568, %f567
  asm("sub.f32 %0, %1, %2;" : "=f"(f569) : "f"(f568), "f"(f567));
  // PTX:1463 mul.f32 %f570, %f123, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f570) : "f"(f123), "f"(f113));
  // PTX:1464 mul.f32 %f571, %f122, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f571) : "f"(f122), "f"(f115));
  // PTX:1465 sub.f32 %f572, %f571, %f570
  asm("sub.f32 %0, %1, %2;" : "=f"(f572) : "f"(f571), "f"(f570));
  // PTX:1466 mul.f32 %f573, %f121, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f573) : "f"(f121), "f"(f115));
  // PTX:1467 mul.f32 %f574, %f123, %f118
  asm("mul.f32 %0, %1, %2;" : "=f"(f574) : "f"(f123), "f"(f118));
  // PTX:1468 sub.f32 %f575, %f574, %f573
  asm("sub.f32 %0, %1, %2;" : "=f"(f575) : "f"(f574), "f"(f573));
  // PTX:1469 mul.f32 %f576, %f122, %f118
  asm("mul.f32 %0, %1, %2;" : "=f"(f576) : "f"(f122), "f"(f118));
  // PTX:1470 mul.f32 %f577, %f121, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f577) : "f"(f121), "f"(f113));
  // PTX:1471 sub.f32 %f578, %f577, %f576
  asm("sub.f32 %0, %1, %2;" : "=f"(f578) : "f"(f577), "f"(f576));
  // PTX:1472 mul.f32 %f579, %f116, %f560
  asm("mul.f32 %0, %1, %2;" : "=f"(f579) : "f"(f116), "f"(f560));
  // PTX:1473 mul.f32 %f580, %f119, %f560
  asm("mul.f32 %0, %1, %2;" : "=f"(f580) : "f"(f119), "f"(f560));
  // PTX:1474 mul.f32 %f581, %f120, %f560
  asm("mul.f32 %0, %1, %2;" : "=f"(f581) : "f"(f120), "f"(f560));
  // PTX:1475 mul.f32 %f582, %f563, %f560
  asm("mul.f32 %0, %1, %2;" : "=f"(f582) : "f"(f563), "f"(f560));
  // PTX:1476 mul.f32 %f583, %f566, %f560
  asm("mul.f32 %0, %1, %2;" : "=f"(f583) : "f"(f566), "f"(f560));
  // PTX:1477 mul.f32 %f584, %f569, %f560
  asm("mul.f32 %0, %1, %2;" : "=f"(f584) : "f"(f569), "f"(f560));
  // PTX:1478 mul.f32 %f585, %f572, %f560
  asm("mul.f32 %0, %1, %2;" : "=f"(f585) : "f"(f572), "f"(f560));
  // PTX:1479 mul.f32 %f586, %f575, %f560
  asm("mul.f32 %0, %1, %2;" : "=f"(f586) : "f"(f575), "f"(f560));
  // PTX:1480 mul.f32 %f587, %f578, %f560
  asm("mul.f32 %0, %1, %2;" : "=f"(f587) : "f"(f578), "f"(f560));
  // PTX:1481 mul.f32 %f588, %f580, %f110
  asm("mul.f32 %0, %1, %2;" : "=f"(f588) : "f"(f580), "f"(f110));
  // PTX:1482 mul.f32 %f589, %f583, %f110
  asm("mul.f32 %0, %1, %2;" : "=f"(f589) : "f"(f583), "f"(f110));
  // PTX:1483 mul.f32 %f590, %f586, %f110
  asm("mul.f32 %0, %1, %2;" : "=f"(f590) : "f"(f586), "f"(f110));
  // PTX:1484 fma.rn.f32 %f591, %f579, %f109, %f588
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f591) : "f"(f579), "f"(f109), "f"(f588));
  // PTX:1485 fma.rn.f32 %f592, %f582, %f109, %f589
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f592) : "f"(f582), "f"(f109), "f"(f589));
  // PTX:1486 fma.rn.f32 %f593, %f585, %f109, %f590
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f593) : "f"(f585), "f"(f109), "f"(f590));
  // PTX:1487 fma.rn.f32 %f1072, %f581, %f111, %f591
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1072) : "f"(f581), "f"(f111), "f"(f591));
  // PTX:1488 fma.rn.f32 %f1073, %f584, %f111, %f592
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1073) : "f"(f584), "f"(f111), "f"(f592));
  // PTX:1489 fma.rn.f32 %f1074, %f587, %f111, %f593
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1074) : "f"(f587), "f"(f111), "f"(f593));
  // PTX:1491 $L__BB77_106:
L_BB77_106:;
  // PTX:1492 mov.b32 %f751, %r623
  asm("mov.b32 %0, %1;" : "=f"(f751) : "r"(r623));
  // PTX:1493 add.f32 %f752, %f751, %f1072
  asm("add.f32 %0, %1, %2;" : "=f"(f752) : "f"(f751), "f"(f1072));
  // PTX:1494 mov.b32 %f754, %r622
  asm("mov.b32 %0, %1;" : "=f"(f754) : "r"(r622));
  // PTX:1495 add.f32 %f755, %f754, %f1073
  asm("add.f32 %0, %1, %2;" : "=f"(f755) : "f"(f754), "f"(f1073));
  // PTX:1496 mov.b32 %f757, %r621
  asm("mov.b32 %0, %1;" : "=f"(f757) : "r"(r621));
  // PTX:1497 add.f32 %f758, %f757, %f1074
  asm("add.f32 %0, %1, %2;" : "=f"(f758) : "f"(f757), "f"(f1074));
  // PTX:1498 mov.b32 %r623, %f752
  asm("mov.b32 %0, %1;" : "=r"(r623) : "f"(f752));
  // PTX:1499 mov.b32 %r622, %f755
  asm("mov.b32 %0, %1;" : "=r"(r622) : "f"(f755));
  // PTX:1500 mov.b32 %r621, %f758
  asm("mov.b32 %0, %1;" : "=r"(r621) : "f"(f758));
  // PTX:1502 $L__BB77_108:
L_BB77_108:;
  // PTX:1503 ld.param.u64 %rd311, [%rd2+40]
  rd311 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (40))));
  // PTX:1504 setp.eq.s64 %p111, %rd311, 0
  p111 = (((long long)(rd311)) == ((long long)(0)));
  // PTX:1505 @%p111 bra $L__BB77_110
  if (p111) { goto L_BB77_110; }
  // PTX:1507 ld.param.u64 %rd314, [%rd2+40]
  rd314 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (40))));
  // PTX:1508 ld.param.u64 %rd313, [%rd2+24]
  rd313 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (24))));
  // PTX:1509 cvta.to.global.u64 %rd312, %rd313
  rd312 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd313));
  // PTX:1510 add.s64 %rd170, %rd312, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd170) : "l"(rd312), "l"(rd138));
  // PTX:1511 cvta.to.global.u64 %rd171, %rd314
  rd171 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd314));
  // PTX:1512 add.s64 %rd172, %rd171, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd172) : "l"(rd171), "l"(rd138));
  // PTX:1513 ld.global.f32 %f769, [%rd172]
  f769 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (0)))));
  // PTX:1514 ld.global.f32 %f770, [%rd170]
  f770 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd170) + (0)))));
  // PTX:1515 add.f32 %f771, %f770, %f769
  asm("add.f32 %0, %1, %2;" : "=f"(f771) : "f"(f770), "f"(f769));
  // PTX:1516 ld.global.f32 %f772, [%rd172+4]
  f772 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (4)))));
  // PTX:1517 ld.global.f32 %f773, [%rd170+4]
  f773 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd170) + (4)))));
  // PTX:1518 add.f32 %f774, %f773, %f772
  asm("add.f32 %0, %1, %2;" : "=f"(f774) : "f"(f773), "f"(f772));
  // PTX:1519 ld.global.f32 %f775, [%rd172+8]
  f775 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd172) + (8)))));
  // PTX:1520 ld.global.f32 %f776, [%rd170+8]
  f776 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd170) + (8)))));
  // PTX:1521 add.f32 %f777, %f776, %f775
  asm("add.f32 %0, %1, %2;" : "=f"(f777) : "f"(f776), "f"(f775));
  // PTX:1522 mov.b32 %r626, %f771
  asm("mov.b32 %0, %1;" : "=r"(r626) : "f"(f771));
  // PTX:1523 mov.b32 %r625, %f774
  asm("mov.b32 %0, %1;" : "=r"(r625) : "f"(f774));
  // PTX:1524 mov.b32 %r624, %f777
  asm("mov.b32 %0, %1;" : "=r"(r624) : "f"(f777));
  // PTX:1526 $L__BB77_110:
L_BB77_110:;
  // PTX:1527 ld.param.u64 %rd315, [%rd2+48]
  rd315 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (48))));
  // PTX:1528 setp.eq.s64 %p112, %rd315, 0
  p112 = (((long long)(rd315)) == ((long long)(0)));
  // PTX:1529 @%p112 bra $L__BB77_112
  if (p112) { goto L_BB77_112; }
  // PTX:1531 ld.param.u64 %rd318, [%rd2+48]
  rd318 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (48))));
  // PTX:1532 ld.param.u64 %rd317, [%rd2+32]
  rd317 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (32))));
  // PTX:1533 cvta.to.global.u64 %rd316, %rd317
  rd316 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd317));
  // PTX:1534 add.s64 %rd174, %rd316, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd174) : "l"(rd316), "l"(rd138));
  // PTX:1535 cvta.to.global.u64 %rd175, %rd318
  rd175 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd318));
  // PTX:1536 add.s64 %rd176, %rd175, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd176) : "l"(rd175), "l"(rd138));
  // PTX:1537 ld.global.f32 %f778, [%rd176]
  f778 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (0)))));
  // PTX:1538 ld.global.f32 %f779, [%rd174]
  f779 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (0)))));
  // PTX:1539 add.f32 %f780, %f779, %f778
  asm("add.f32 %0, %1, %2;" : "=f"(f780) : "f"(f779), "f"(f778));
  // PTX:1540 ld.global.f32 %f781, [%rd176+4]
  f781 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (4)))));
  // PTX:1541 ld.global.f32 %f782, [%rd174+4]
  f782 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (4)))));
  // PTX:1542 add.f32 %f783, %f782, %f781
  asm("add.f32 %0, %1, %2;" : "=f"(f783) : "f"(f782), "f"(f781));
  // PTX:1543 ld.global.f32 %f784, [%rd176+8]
  f784 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd176) + (8)))));
  // PTX:1544 ld.global.f32 %f785, [%rd174+8]
  f785 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd174) + (8)))));
  // PTX:1545 add.f32 %f786, %f785, %f784
  asm("add.f32 %0, %1, %2;" : "=f"(f786) : "f"(f785), "f"(f784));
  // PTX:1546 mov.b32 %r623, %f780
  asm("mov.b32 %0, %1;" : "=r"(r623) : "f"(f780));
  // PTX:1547 mov.b32 %r622, %f783
  asm("mov.b32 %0, %1;" : "=r"(r622) : "f"(f783));
  // PTX:1548 mov.b32 %r621, %f786
  asm("mov.b32 %0, %1;" : "=r"(r621) : "f"(f786));
  // PTX:1550 $L__BB77_112:
L_BB77_112:;
  // PTX:1551 ld.param.u64 %rd177, [%rd2+56]
  rd177 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (56))));
  // PTX:1552 cvta.to.global.u64 %rd178, %rd177
  rd178 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd177));
  // PTX:1553 add.s64 %rd180, %rd178, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd180) : "l"(rd178), "l"(rd138));
  // PTX:1554 ld.global.f32 %f197, [%rd180]
  f197 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (0)))));
  // PTX:1555 ld.global.f32 %f198, [%rd180+4]
  f198 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (4)))));
  // PTX:1556 mul.f32 %f787, %f198, %f198
  asm("mul.f32 %0, %1, %2;" : "=f"(f787) : "f"(f198), "f"(f198));
  // PTX:1557 ld.global.f32 %f199, [%rd180+8]
  f199 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd180) + (8)))));
  // PTX:1558 fma.rn.f32 %f788, %f197, %f197, %f787
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f788) : "f"(f197), "f"(f197), "f"(f787));
  // PTX:1559 fma.rn.f32 %f789, %f199, %f199, %f788
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f789) : "f"(f199), "f"(f199), "f"(f788));
  // PTX:1560 sqrt.rn.f32 %f200, %f789
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f200) : "f"(f789));
  // PTX:1561 setp.leu.f32 %p113, %f200, 0f00000000
  p113 = ((isnan(((float)(f200))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f200)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1562 mov.u32 %r629, 0
  asm("mov.u32 %0, 0;" : "=r"(r629) : );
  // PTX:1563 mov.u32 %r628, %r629
  asm("mov.u32 %0, %1;" : "=r"(r628) : "r"(r629));
  // PTX:1564 mov.u32 %r627, %r629
  asm("mov.u32 %0, %1;" : "=r"(r627) : "r"(r629));
  // PTX:1565 @%p113 bra $L__BB77_114
  if (p113) { goto L_BB77_114; }
  // PTX:1567 div.rn.f32 %f790, %f197, %f200
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f790) : "f"(f197), "f"(f200));
  // PTX:1568 div.rn.f32 %f791, %f198, %f200
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f791) : "f"(f198), "f"(f200));
  // PTX:1569 div.rn.f32 %f792, %f199, %f200
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f792) : "f"(f199), "f"(f200));
  // PTX:1570 mov.b32 %r627, %f792
  asm("mov.b32 %0, %1;" : "=r"(r627) : "f"(f792));
  // PTX:1571 mov.b32 %r628, %f791
  asm("mov.b32 %0, %1;" : "=r"(r628) : "f"(f791));
  // PTX:1572 mov.b32 %r629, %f790
  asm("mov.b32 %0, %1;" : "=r"(r629) : "f"(f790));
  // PTX:1574 $L__BB77_114:
L_BB77_114:;
  // PTX:1575 mov.pred %p150, -1
  p150 = ((-1) != 0);
  // PTX:1576 mov.f32 %f1081, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1081) : );
  // PTX:1577 mov.b32 %f201, %r629
  asm("mov.b32 %0, %1;" : "=f"(f201) : "r"(r629));
  // PTX:1578 mul.f32 %f794, %f201, %f201
  asm("mul.f32 %0, %1, %2;" : "=f"(f794) : "f"(f201), "f"(f201));
  // PTX:1579 mov.b32 %f202, %r628
  asm("mov.b32 %0, %1;" : "=f"(f202) : "r"(r628));
  // PTX:1580 mov.b32 %f203, %r627
  asm("mov.b32 %0, %1;" : "=f"(f203) : "r"(r627));
  // PTX:1581 fma.rn.f32 %f795, %f202, %f202, %f794
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f795) : "f"(f202), "f"(f202), "f"(f794));
  // PTX:1582 fma.rn.f32 %f796, %f203, %f203, %f795
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f796) : "f"(f203), "f"(f203), "f"(f795));
  // PTX:1583 setp.lt.f32 %p115, %f796, 0f3F000000
  p115 = (!(isnan(((float)(f796))) || isnan(((float)(as_f32(0x3F000000u))))) && (((float)(f796)) < ((float)(as_f32(0x3F000000u)))));
  // PTX:1584 @%p115 bra $L__BB77_122
  if (p115) { goto L_BB77_122; }
  // PTX:1586 setp.lt.s32 %p133, %r639, 0
  p133 = (((int)(r639)) < ((int)(0)));
  // PTX:1587 ld.param.u64 %rd181, [%rd2+208]
  rd181 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (208))));
  // PTX:1588 cvta.to.global.u64 %rd72, %rd181
  rd72 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd181));
  // PTX:1589 ld.param.u64 %rd182, [%rd2+184]
  rd182 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (184))));
  // PTX:1590 cvta.to.global.u64 %rd73, %rd182
  rd73 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd182));
  // PTX:1591 @%p133 bra $L__BB77_117
  if (p133) { goto L_BB77_117; }
  // PTX:1593 mul.wide.s32 %rd332, %r636, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd332) : "r"(r636));
  // PTX:1594 mul.wide.s32 %rd328, %r635, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd328) : "r"(r635));
  // PTX:1595 mul.wide.s32 %rd319, %r634, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd319) : "r"(r634));
  // PTX:1596 mul.wide.s32 %rd183, %r639, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd183) : "r"(r639));
  // PTX:1597 add.s64 %rd184, %rd73, %rd183
  asm("add.s64 %0, %1, %2;" : "=l"(rd184) : "l"(rd73), "l"(rd183));
  // PTX:1598 ld.param.u64 %rd185, [%rd2+24]
  rd185 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (24))));
  // PTX:1599 cvta.to.global.u64 %rd186, %rd185
  rd186 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd185));
  // PTX:1600 add.s64 %rd188, %rd186, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd188) : "l"(rd186), "l"(rd138));
  // PTX:1601 ld.global.f32 %f797, [%rd188]
  f797 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd188) + (0)))));
  // PTX:1602 ld.global.f32 %f798, [%rd184]
  f798 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (0)))));
  // PTX:1603 sub.f32 %f799, %f797, %f798
  asm("sub.f32 %0, %1, %2;" : "=f"(f799) : "f"(f797), "f"(f798));
  // PTX:1604 ld.global.f32 %f800, [%rd188+4]
  f800 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd188) + (4)))));
  // PTX:1605 ld.global.f32 %f801, [%rd184+4]
  f801 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (4)))));
  // PTX:1606 sub.f32 %f802, %f800, %f801
  asm("sub.f32 %0, %1, %2;" : "=f"(f802) : "f"(f800), "f"(f801));
  // PTX:1607 ld.global.f32 %f803, [%rd188+8]
  f803 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd188) + (8)))));
  // PTX:1608 ld.global.f32 %f804, [%rd184+8]
  f804 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd184) + (8)))));
  // PTX:1609 sub.f32 %f805, %f803, %f804
  asm("sub.f32 %0, %1, %2;" : "=f"(f805) : "f"(f803), "f"(f804));
  // PTX:1610 mul.wide.s32 %rd189, %r637, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd189) : "r"(r637));
  // PTX:1611 add.s64 %rd190, %rd72, %rd189
  asm("add.s64 %0, %1, %2;" : "=l"(rd190) : "l"(rd72), "l"(rd189));
  // PTX:1612 add.s64 %rd192, %rd72, %rd332
  asm("add.s64 %0, %1, %2;" : "=l"(rd192) : "l"(rd72), "l"(rd332));
  // PTX:1613 ld.global.f32 %f806, [%rd192]
  f806 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd192) + (0)))));
  // PTX:1614 ld.global.f32 %f807, [%rd192+4]
  f807 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd192) + (4)))));
  // PTX:1615 ld.global.f32 %f808, [%rd192+8]
  f808 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd192) + (8)))));
  // PTX:1616 ld.global.f32 %f809, [%rd190]
  f809 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd190) + (0)))));
  // PTX:1617 fma.rn.f32 %f810, %f799, %f806, %f809
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f810) : "f"(f799), "f"(f806), "f"(f809));
  // PTX:1618 ld.global.f32 %f811, [%rd190+4]
  f811 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd190) + (4)))));
  // PTX:1619 fma.rn.f32 %f812, %f799, %f807, %f811
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f812) : "f"(f799), "f"(f807), "f"(f811));
  // PTX:1620 ld.global.f32 %f813, [%rd190+8]
  f813 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd190) + (8)))));
  // PTX:1621 fma.rn.f32 %f814, %f799, %f808, %f813
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f814) : "f"(f799), "f"(f808), "f"(f813));
  // PTX:1622 add.s64 %rd194, %rd72, %rd328
  asm("add.s64 %0, %1, %2;" : "=l"(rd194) : "l"(rd72), "l"(rd328));
  // PTX:1623 ld.global.f32 %f815, [%rd194]
  f815 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd194) + (0)))));
  // PTX:1624 ld.global.f32 %f816, [%rd194+4]
  f816 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd194) + (4)))));
  // PTX:1625 ld.global.f32 %f817, [%rd194+8]
  f817 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd194) + (8)))));
  // PTX:1626 fma.rn.f32 %f818, %f802, %f815, %f810
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f818) : "f"(f802), "f"(f815), "f"(f810));
  // PTX:1627 fma.rn.f32 %f819, %f802, %f816, %f812
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f819) : "f"(f802), "f"(f816), "f"(f812));
  // PTX:1628 fma.rn.f32 %f820, %f802, %f817, %f814
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f820) : "f"(f802), "f"(f817), "f"(f814));
  // PTX:1629 add.s64 %rd196, %rd72, %rd319
  asm("add.s64 %0, %1, %2;" : "=l"(rd196) : "l"(rd72), "l"(rd319));
  // PTX:1630 ld.global.f32 %f821, [%rd196]
  f821 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd196) + (0)))));
  // PTX:1631 ld.global.f32 %f822, [%rd196+4]
  f822 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd196) + (4)))));
  // PTX:1632 ld.global.f32 %f823, [%rd196+8]
  f823 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd196) + (8)))));
  // PTX:1633 fma.rn.f32 %f1077, %f805, %f821, %f818
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1077) : "f"(f805), "f"(f821), "f"(f818));
  // PTX:1634 fma.rn.f32 %f1076, %f805, %f822, %f819
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1076) : "f"(f805), "f"(f822), "f"(f819));
  // PTX:1635 fma.rn.f32 %f1075, %f805, %f823, %f820
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1075) : "f"(f805), "f"(f823), "f"(f820));
  // PTX:1636 bra.uni $L__BB77_118
  goto L_BB77_118;
  // PTX:1638 $L__BB77_117:
L_BB77_117:;
  // PTX:1639 ld.param.u64 %rd197, [%rd2+24]
  rd197 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (24))));
  // PTX:1640 cvta.to.global.u64 %rd198, %rd197
  rd198 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd197));
  // PTX:1641 add.s64 %rd200, %rd198, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd200) : "l"(rd198), "l"(rd138));
  // PTX:1642 ld.global.f32 %f1077, [%rd200]
  f1077 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd200) + (0)))));
  // PTX:1643 ld.global.f32 %f1076, [%rd200+4]
  f1076 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd200) + (4)))));
  // PTX:1644 ld.global.f32 %f1075, [%rd200+8]
  f1075 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd200) + (8)))));
  // PTX:1646 $L__BB77_118:
L_BB77_118:;
  // PTX:1647 setp.lt.s32 %p135, %r638, 0
  p135 = (((int)(r638)) < ((int)(0)));
  // PTX:1648 @%p135 bra $L__BB77_120
  if (p135) { goto L_BB77_120; }
  // PTX:1650 mul.wide.s32 %rd322, %r630, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd322) : "r"(r630));
  // PTX:1651 mul.wide.s32 %rd321, %r631, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd321) : "r"(r631));
  // PTX:1652 mul.wide.s32 %rd320, %r632, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd320) : "r"(r632));
  // PTX:1653 mul.wide.s32 %rd201, %r638, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd201) : "r"(r638));
  // PTX:1654 add.s64 %rd202, %rd73, %rd201
  asm("add.s64 %0, %1, %2;" : "=l"(rd202) : "l"(rd73), "l"(rd201));
  // PTX:1655 ld.param.u64 %rd203, [%rd2+32]
  rd203 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (32))));
  // PTX:1656 cvta.to.global.u64 %rd204, %rd203
  rd204 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd203));
  // PTX:1657 add.s64 %rd206, %rd204, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd206) : "l"(rd204), "l"(rd138));
  // PTX:1658 ld.global.f32 %f824, [%rd206]
  f824 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd206) + (0)))));
  // PTX:1659 ld.global.f32 %f825, [%rd202]
  f825 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (0)))));
  // PTX:1660 sub.f32 %f826, %f824, %f825
  asm("sub.f32 %0, %1, %2;" : "=f"(f826) : "f"(f824), "f"(f825));
  // PTX:1661 ld.global.f32 %f827, [%rd206+4]
  f827 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd206) + (4)))));
  // PTX:1662 ld.global.f32 %f828, [%rd202+4]
  f828 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (4)))));
  // PTX:1663 sub.f32 %f829, %f827, %f828
  asm("sub.f32 %0, %1, %2;" : "=f"(f829) : "f"(f827), "f"(f828));
  // PTX:1664 ld.global.f32 %f830, [%rd206+8]
  f830 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd206) + (8)))));
  // PTX:1665 ld.global.f32 %f831, [%rd202+8]
  f831 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd202) + (8)))));
  // PTX:1666 sub.f32 %f832, %f830, %f831
  asm("sub.f32 %0, %1, %2;" : "=f"(f832) : "f"(f830), "f"(f831));
  // PTX:1667 mul.wide.s32 %rd207, %r633, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd207) : "r"(r633));
  // PTX:1668 add.s64 %rd208, %rd72, %rd207
  asm("add.s64 %0, %1, %2;" : "=l"(rd208) : "l"(rd72), "l"(rd207));
  // PTX:1669 add.s64 %rd210, %rd72, %rd320
  asm("add.s64 %0, %1, %2;" : "=l"(rd210) : "l"(rd72), "l"(rd320));
  // PTX:1670 ld.global.f32 %f833, [%rd210]
  f833 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd210) + (0)))));
  // PTX:1671 ld.global.f32 %f834, [%rd210+4]
  f834 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd210) + (4)))));
  // PTX:1672 ld.global.f32 %f835, [%rd210+8]
  f835 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd210) + (8)))));
  // PTX:1673 ld.global.f32 %f836, [%rd208]
  f836 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd208) + (0)))));
  // PTX:1674 fma.rn.f32 %f837, %f826, %f833, %f836
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f837) : "f"(f826), "f"(f833), "f"(f836));
  // PTX:1675 ld.global.f32 %f838, [%rd208+4]
  f838 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd208) + (4)))));
  // PTX:1676 fma.rn.f32 %f839, %f826, %f834, %f838
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f839) : "f"(f826), "f"(f834), "f"(f838));
  // PTX:1677 ld.global.f32 %f840, [%rd208+8]
  f840 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd208) + (8)))));
  // PTX:1678 fma.rn.f32 %f841, %f826, %f835, %f840
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f841) : "f"(f826), "f"(f835), "f"(f840));
  // PTX:1679 add.s64 %rd212, %rd72, %rd321
  asm("add.s64 %0, %1, %2;" : "=l"(rd212) : "l"(rd72), "l"(rd321));
  // PTX:1680 ld.global.f32 %f842, [%rd212]
  f842 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd212) + (0)))));
  // PTX:1681 ld.global.f32 %f843, [%rd212+4]
  f843 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd212) + (4)))));
  // PTX:1682 ld.global.f32 %f844, [%rd212+8]
  f844 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd212) + (8)))));
  // PTX:1683 fma.rn.f32 %f845, %f829, %f842, %f837
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f845) : "f"(f829), "f"(f842), "f"(f837));
  // PTX:1684 fma.rn.f32 %f846, %f829, %f843, %f839
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f846) : "f"(f829), "f"(f843), "f"(f839));
  // PTX:1685 fma.rn.f32 %f847, %f829, %f844, %f841
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f847) : "f"(f829), "f"(f844), "f"(f841));
  // PTX:1686 add.s64 %rd214, %rd72, %rd322
  asm("add.s64 %0, %1, %2;" : "=l"(rd214) : "l"(rd72), "l"(rd322));
  // PTX:1687 ld.global.f32 %f848, [%rd214]
  f848 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd214) + (0)))));
  // PTX:1688 ld.global.f32 %f849, [%rd214+4]
  f849 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd214) + (4)))));
  // PTX:1689 ld.global.f32 %f850, [%rd214+8]
  f850 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd214) + (8)))));
  // PTX:1690 fma.rn.f32 %f1080, %f832, %f848, %f845
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1080) : "f"(f832), "f"(f848), "f"(f845));
  // PTX:1691 fma.rn.f32 %f1079, %f832, %f849, %f846
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1079) : "f"(f832), "f"(f849), "f"(f846));
  // PTX:1692 fma.rn.f32 %f1078, %f832, %f850, %f847
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f1078) : "f"(f832), "f"(f850), "f"(f847));
  // PTX:1693 bra.uni $L__BB77_121
  goto L_BB77_121;
  // PTX:1695 $L__BB77_120:
L_BB77_120:;
  // PTX:1696 ld.param.u64 %rd215, [%rd2+32]
  rd215 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (32))));
  // PTX:1697 cvta.to.global.u64 %rd216, %rd215
  rd216 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd215));
  // PTX:1698 add.s64 %rd218, %rd216, %rd138
  asm("add.s64 %0, %1, %2;" : "=l"(rd218) : "l"(rd216), "l"(rd138));
  // PTX:1699 ld.global.f32 %f1080, [%rd218]
  f1080 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd218) + (0)))));
  // PTX:1700 ld.global.f32 %f1079, [%rd218+4]
  f1079 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd218) + (4)))));
  // PTX:1701 ld.global.f32 %f1078, [%rd218+8]
  f1078 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd218) + (8)))));
  // PTX:1703 $L__BB77_121:
L_BB77_121:;
  // PTX:1704 ld.param.u64 %rd219, [%rd2+64]
  rd219 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (64))));
  // PTX:1705 cvta.to.global.u64 %rd220, %rd219
  rd220 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd219));
  // PTX:1706 add.s64 %rd222, %rd220, %rd94
  asm("add.s64 %0, %1, %2;" : "=l"(rd222) : "l"(rd220), "l"(rd94));
  // PTX:1707 ld.param.u64 %rd223, [%rd2+72]
  rd223 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (72))));
  // PTX:1708 cvta.to.global.u64 %rd224, %rd223
  rd224 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd223));
  // PTX:1709 add.s64 %rd225, %rd224, %rd94
  asm("add.s64 %0, %1, %2;" : "=l"(rd225) : "l"(rd224), "l"(rd94));
  // PTX:1710 ld.global.f32 %f851, [%rd225]
  f851 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd225) + (0)))));
  // PTX:1711 ld.global.f32 %f852, [%rd222]
  f852 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd222) + (0)))));
  // PTX:1712 add.f32 %f853, %f852, %f851
  asm("add.f32 %0, %1, %2;" : "=f"(f853) : "f"(f852), "f"(f851));
  // PTX:1713 sub.f32 %f854, %f1080, %f1077
  asm("sub.f32 %0, %1, %2;" : "=f"(f854) : "f"(f1080), "f"(f1077));
  // PTX:1714 sub.f32 %f855, %f1079, %f1076
  asm("sub.f32 %0, %1, %2;" : "=f"(f855) : "f"(f1079), "f"(f1076));
  // PTX:1715 mul.f32 %f856, %f855, %f202
  asm("mul.f32 %0, %1, %2;" : "=f"(f856) : "f"(f855), "f"(f202));
  // PTX:1716 sub.f32 %f857, %f1078, %f1075
  asm("sub.f32 %0, %1, %2;" : "=f"(f857) : "f"(f1078), "f"(f1075));
  // PTX:1717 fma.rn.f32 %f858, %f854, %f201, %f856
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f858) : "f"(f854), "f"(f201), "f"(f856));
  // PTX:1718 fma.rn.f32 %f859, %f857, %f203, %f858
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f859) : "f"(f857), "f"(f203), "f"(f858));
  // PTX:1719 sub.f32 %f1081, %f853, %f859
  asm("sub.f32 %0, %1, %2;" : "=f"(f1081) : "f"(f853), "f"(f859));
  // PTX:1720 mov.pred %p150, 0
  p150 = ((0) != 0);
  // PTX:1722 $L__BB77_122:
L_BB77_122:;
  // PTX:1723 @%p150 bra $L__BB77_140
  if (p150) { goto L_BB77_140; }
  // PTX:1724 bra.uni $L__BB77_123
  goto L_BB77_123;
  // PTX:1726 $L__BB77_140:
L_BB77_140:;
  // PTX:1727 ld.param.u64 %rd300, [%rd2+248]
  rd300 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (248))));
  // PTX:1728 cvta.to.global.u64 %rd301, %rd300
  rd301 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd300));
  // PTX:1729 add.s64 %rd303, %rd301, %rd94
  asm("add.s64 %0, %1, %2;" : "=l"(rd303) : "l"(rd301), "l"(rd94));
  // PTX:1730 mov.u32 %r508, 0
  asm("mov.u32 %0, 0;" : "=r"(r508) : );
  // PTX:1731 st.global.u32 [%rd303], %r508
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd303) + (0))))) = (unsigned)(r508);
  // PTX:1732 ld.param.u64 %rd304, [%rd2+256]
  rd304 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (256))));
  // PTX:1733 cvta.to.global.u64 %rd305, %rd304
  rd305 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd304));
  // PTX:1734 mul.lo.s64 %rd306, %rd1, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd306) : "l"(rd1));
  // PTX:1735 add.s64 %rd307, %rd305, %rd306
  asm("add.s64 %0, %1, %2;" : "=l"(rd307) : "l"(rd305), "l"(rd306));
  // PTX:1736 st.global.u32 [%rd307], %r508
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd307) + (0))))) = (unsigned)(r508);
  // PTX:1737 st.global.u32 [%rd307+4], %r508
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd307) + (4))))) = (unsigned)(r508);
  // PTX:1738 st.global.u32 [%rd307+8], %r508
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd307) + (8))))) = (unsigned)(r508);
  // PTX:1739 ld.param.u64 %rd308, [%rd2+264]
  rd308 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (264))));
  // PTX:1740 cvta.to.global.u64 %rd309, %rd308
  rd309 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd308));
  // PTX:1741 add.s64 %rd310, %rd309, %rd306
  asm("add.s64 %0, %1, %2;" : "=l"(rd310) : "l"(rd309), "l"(rd306));
  // PTX:1742 st.global.u32 [%rd310], %r508
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd310) + (0))))) = (unsigned)(r508);
  // PTX:1743 st.global.u32 [%rd310+4], %r508
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd310) + (4))))) = (unsigned)(r508);
  // PTX:1744 st.global.u32 [%rd310+8], %r508
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd310) + (8))))) = (unsigned)(r508);
  // PTX:1745 bra.uni $L__BB77_141
  goto L_BB77_141;
  // PTX:1747 $L__BB77_123:
L_BB77_123:;
  // PTX:1748 ld.param.u64 %rd226, [%rd2+120]
  rd226 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (120))));
  // PTX:1749 cvta.to.global.u64 %rd227, %rd226
  rd227 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd226));
  // PTX:1750 shl.b64 %rd228, %rd424, 32
  asm("shl.b64 %0, %1, 32;" : "=l"(rd228) : "l"(rd424));
  // PTX:1751 shr.s64 %rd229, %rd228, 30
  asm("shr.s64 %0, %1, 30;" : "=l"(rd229) : "l"(rd228));
  // PTX:1752 add.s64 %rd230, %rd227, %rd229
  asm("add.s64 %0, %1, %2;" : "=l"(rd230) : "l"(rd227), "l"(rd229));
  // PTX:1753 shl.b64 %rd231, %rd423, 32
  asm("shl.b64 %0, %1, 32;" : "=l"(rd231) : "l"(rd423));
  // PTX:1754 shr.s64 %rd232, %rd231, 30
  asm("shr.s64 %0, %1, 30;" : "=l"(rd232) : "l"(rd231));
  // PTX:1755 add.s64 %rd233, %rd227, %rd232
  asm("add.s64 %0, %1, %2;" : "=l"(rd233) : "l"(rd227), "l"(rd232));
  // PTX:1756 ld.global.f32 %f860, [%rd233]
  f860 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd233) + (0)))));
  // PTX:1757 ld.global.f32 %f861, [%rd230]
  f861 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd230) + (0)))));
  // PTX:1758 add.f32 %f862, %f861, %f860
  asm("add.f32 %0, %1, %2;" : "=f"(f862) : "f"(f861), "f"(f860));
  // PTX:1759 mul.f32 %f224, %f862, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f224) : "f"(f862));
  // PTX:1760 ld.param.f32 %f863, [%rd2+232]
  f863 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd2) + (232))));
  // PTX:1761 setp.leu.f32 %p119, %f863, 0f00000000
  p119 = ((isnan(((float)(f863))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f863)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:1762 mov.f32 %f1082, %f224
  asm("mov.f32 %0, %1;" : "=f"(f1082) : "f"(f224));
  // PTX:1763 @%p119 bra $L__BB77_125
  if (p119) { goto L_BB77_125; }
  // PTX:1765 ld.param.f32 %f864, [%rd2+240]
  f864 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd2) + (240))));
  // PTX:1766 min.f32 %f1082, %f864, %f224
  asm("min.f32 %0, %1, %2;" : "=f"(f1082) : "f"(f864), "f"(f224));
  // PTX:1768 $L__BB77_125:
L_BB77_125:;
  // PTX:1769 ld.param.u8 %rs4, [%rd2+246]
  rs4 = (*reinterpret_cast<volatile unsigned char*>(((uintptr_t)(rd2) + (246))));
  // PTX:1770 setp.ne.s16 %p120, %rs4, 0
  p120 = (((short)(rs4)) != ((short)(0)));
  // PTX:1771 @%p120 bra $L__BB77_128
  if (p120) { goto L_BB77_128; }
  // PTX:1772 bra.uni $L__BB77_126
  goto L_BB77_126;
  // PTX:1774 $L__BB77_128:
L_BB77_128:;
  // PTX:1775 ld.param.u8 %rs5, [%rd2+244]
  rs5 = (*reinterpret_cast<volatile unsigned char*>(((uintptr_t)(rd2) + (244))));
  // PTX:1776 setp.eq.s16 %p122, %rs5, 0
  p122 = (((short)(rs5)) == ((short)(0)));
  // PTX:1777 ld.param.u64 %rd77, [%rd2+80]
  rd77 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (80))));
  // PTX:1778 setp.eq.s64 %p123, %rd77, 0
  p123 = (((long long)(rd77)) == ((long long)(0)));
  // PTX:1779 mov.u32 %r640, -1
  asm("mov.u32 %0, -1;" : "=r"(r640) : );
  // PTX:1780 or.pred %p124, %p122, %p123
  p124 = ((p122) || (p123));
  // PTX:1781 @%p124 bra $L__BB77_130
  if (p124) { goto L_BB77_130; }
  // PTX:1783 cvta.to.global.u64 %rd244, %rd77
  rd244 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd77));
  // PTX:1784 add.s64 %rd246, %rd244, %rd94
  asm("add.s64 %0, %1, %2;" : "=l"(rd246) : "l"(rd244), "l"(rd94));
  // PTX:1785 ld.global.u32 %r640, [%rd246]
  r640 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd246) + (0)))));
  // PTX:1787 $L__BB77_130:
L_BB77_130:;
  // PTX:1788 setp.lt.s32 %p125, %r640, 0
  p125 = (((int)(r640)) < ((int)(0)));
  // PTX:1789 mov.f32 %f1083, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1083) : );
  // PTX:1790 mov.f32 %f1084, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1084) : );
  // PTX:1791 mov.f32 %f1085, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f1085) : );
  // PTX:1792 mov.f32 %f1086, %f1082
  asm("mov.f32 %0, %1;" : "=f"(f1086) : "f"(f1082));
  // PTX:1793 @%p125 bra $L__BB77_133
  if (p125) { goto L_BB77_133; }
  // PTX:1795 ld.param.u64 %rd247, [%rd2+296]
  rd247 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (296))));
  // PTX:1796 cvta.to.global.u64 %rd248, %rd247
  rd248 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd247));
  // PTX:1797 ld.global.u32 %r504, [%rd248]
  r504 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd248) + (0)))));
  // PTX:1798 setp.ge.s32 %p126, %r640, %r504
  p126 = (((int)(r640)) >= ((int)(r504)));
  // PTX:1799 mov.f32 %f1086, %f1082
  asm("mov.f32 %0, %1;" : "=f"(f1086) : "f"(f1082));
  // PTX:1800 @%p126 bra $L__BB77_133
  if (p126) { goto L_BB77_133; }
  // PTX:1802 ld.param.u64 %rd249, [%rd2+272]
  rd249 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (272))));
  // PTX:1803 cvta.to.global.u64 %rd250, %rd249
  rd250 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd249));
  // PTX:1804 mul.wide.s32 %rd251, %r640, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd251) : "r"(r640));
  // PTX:1805 add.s64 %rd252, %rd250, %rd251
  asm("add.s64 %0, %1, %2;" : "=l"(rd252) : "l"(rd250), "l"(rd251));
  // PTX:1806 ld.global.f32 %f871, [%rd252]
  f871 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd252) + (0)))));
  // PTX:1807 max.f32 %f872, %f871, %f1082
  asm("max.f32 %0, %1, %2;" : "=f"(f872) : "f"(f871), "f"(f1082));
  // PTX:1808 min.f32 %f1086, %f872, %f224
  asm("min.f32 %0, %1, %2;" : "=f"(f1086) : "f"(f872), "f"(f224));
  // PTX:1809 ld.param.u64 %rd253, [%rd2+288]
  rd253 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (288))));
  // PTX:1810 cvta.to.global.u64 %rd254, %rd253
  rd254 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd253));
  // PTX:1811 mul.wide.s32 %rd255, %r640, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd255) : "r"(r640));
  // PTX:1812 add.s64 %rd256, %rd254, %rd255
  asm("add.s64 %0, %1, %2;" : "=l"(rd256) : "l"(rd254), "l"(rd255));
  // PTX:1813 ld.param.u64 %rd257, [%rd2+280]
  rd257 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (280))));
  // PTX:1814 cvta.to.global.u64 %rd258, %rd257
  rd258 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd257));
  // PTX:1815 add.s64 %rd259, %rd258, %rd255
  asm("add.s64 %0, %1, %2;" : "=l"(rd259) : "l"(rd258), "l"(rd255));
  // PTX:1816 ld.global.f32 %f873, [%rd259]
  f873 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd259) + (0)))));
  // PTX:1817 ld.global.f32 %f874, [%rd256]
  f874 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (0)))));
  // PTX:1818 ld.global.f32 %f875, [%rd259+4]
  f875 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd259) + (4)))));
  // PTX:1819 ld.global.f32 %f876, [%rd256+4]
  f876 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (4)))));
  // PTX:1820 mul.f32 %f877, %f876, %f875
  asm("mul.f32 %0, %1, %2;" : "=f"(f877) : "f"(f876), "f"(f875));
  // PTX:1821 ld.global.f32 %f878, [%rd259+8]
  f878 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd259) + (8)))));
  // PTX:1822 ld.global.f32 %f879, [%rd256+8]
  f879 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd256) + (8)))));
  // PTX:1823 fma.rn.f32 %f880, %f874, %f873, %f877
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f880) : "f"(f874), "f"(f873), "f"(f877));
  // PTX:1824 fma.rn.f32 %f881, %f879, %f878, %f880
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f881) : "f"(f879), "f"(f878), "f"(f880));
  // PTX:1825 mul.f32 %f882, %f874, %f881
  asm("mul.f32 %0, %1, %2;" : "=f"(f882) : "f"(f874), "f"(f881));
  // PTX:1826 mul.f32 %f883, %f876, %f881
  asm("mul.f32 %0, %1, %2;" : "=f"(f883) : "f"(f876), "f"(f881));
  // PTX:1827 mul.f32 %f884, %f879, %f881
  asm("mul.f32 %0, %1, %2;" : "=f"(f884) : "f"(f879), "f"(f881));
  // PTX:1828 sub.f32 %f885, %f873, %f882
  asm("sub.f32 %0, %1, %2;" : "=f"(f885) : "f"(f873), "f"(f882));
  // PTX:1829 sub.f32 %f886, %f875, %f883
  asm("sub.f32 %0, %1, %2;" : "=f"(f886) : "f"(f875), "f"(f883));
  // PTX:1830 sub.f32 %f887, %f878, %f884
  asm("sub.f32 %0, %1, %2;" : "=f"(f887) : "f"(f878), "f"(f884));
  // PTX:1831 mov.b32 %f888, %r629
  asm("mov.b32 %0, %1;" : "=f"(f888) : "r"(r629));
  // PTX:1832 mov.b32 %f889, %r628
  asm("mov.b32 %0, %1;" : "=f"(f889) : "r"(r628));
  // PTX:1833 mov.b32 %f890, %r627
  asm("mov.b32 %0, %1;" : "=f"(f890) : "r"(r627));
  // PTX:1834 fma.rn.f32 %f891, %f881, %f888, %f885
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f891) : "f"(f881), "f"(f888), "f"(f885));
  // PTX:1835 fma.rn.f32 %f892, %f881, %f889, %f886
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f892) : "f"(f881), "f"(f889), "f"(f886));
  // PTX:1836 fma.rn.f32 %f893, %f881, %f890, %f887
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f893) : "f"(f881), "f"(f890), "f"(f887));
  // PTX:1837 mul.f32 %f894, %f886, %f889
  asm("mul.f32 %0, %1, %2;" : "=f"(f894) : "f"(f886), "f"(f889));
  // PTX:1838 fma.rn.f32 %f895, %f885, %f888, %f894
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f895) : "f"(f885), "f"(f888), "f"(f894));
  // PTX:1839 fma.rn.f32 %f896, %f887, %f890, %f895
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f896) : "f"(f887), "f"(f890), "f"(f895));
  // PTX:1840 mul.f32 %f897, %f896, %f888
  asm("mul.f32 %0, %1, %2;" : "=f"(f897) : "f"(f896), "f"(f888));
  // PTX:1841 mul.f32 %f898, %f896, %f889
  asm("mul.f32 %0, %1, %2;" : "=f"(f898) : "f"(f896), "f"(f889));
  // PTX:1842 mul.f32 %f899, %f896, %f890
  asm("mul.f32 %0, %1, %2;" : "=f"(f899) : "f"(f896), "f"(f890));
  // PTX:1843 sub.f32 %f1085, %f891, %f897
  asm("sub.f32 %0, %1, %2;" : "=f"(f1085) : "f"(f891), "f"(f897));
  // PTX:1844 sub.f32 %f1084, %f892, %f898
  asm("sub.f32 %0, %1, %2;" : "=f"(f1084) : "f"(f892), "f"(f898));
  // PTX:1845 sub.f32 %f1083, %f893, %f899
  asm("sub.f32 %0, %1, %2;" : "=f"(f1083) : "f"(f893), "f"(f899));
  // PTX:1846 bra.uni $L__BB77_133
  goto L_BB77_133;
  // PTX:1848 $L__BB77_126:
L_BB77_126:;
  // PTX:1849 ld.param.u64 %rd234, [%rd2+296]
  rd234 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (296))));
  // PTX:1850 cvta.to.global.u64 %rd235, %rd234
  rd235 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd234));
  // PTX:1851 ld.global.u32 %r502, [%rd235]
  r502 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd235) + (0)))));
  // PTX:1852 setp.eq.s32 %p121, %r502, 0
  p121 = (((int)(r502)) == ((int)(0)));
  // PTX:1853 @%p121 bra $L__BB77_128
  if (p121) { goto L_BB77_128; }
  // PTX:1855 ld.param.u64 %rd236, [%rd2+248]
  rd236 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (248))));
  // PTX:1856 ld.param.u64 %rd237, [%rd2+256]
  rd237 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (256))));
  // PTX:1857 cvta.to.global.u64 %rd238, %rd236
  rd238 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd236));
  // PTX:1858 add.s64 %rd240, %rd238, %rd94
  asm("add.s64 %0, %1, %2;" : "=l"(rd240) : "l"(rd238), "l"(rd94));
  // PTX:1859 ld.global.f32 %f1086, [%rd240]
  f1086 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd240) + (0)))));
  // PTX:1860 cvta.to.global.u64 %rd241, %rd237
  rd241 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd237));
  // PTX:1861 mul.lo.s64 %rd242, %rd1, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd242) : "l"(rd1));
  // PTX:1862 add.s64 %rd243, %rd241, %rd242
  asm("add.s64 %0, %1, %2;" : "=l"(rd243) : "l"(rd241), "l"(rd242));
  // PTX:1863 ld.global.f32 %f1085, [%rd243]
  f1085 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd243) + (0)))));
  // PTX:1864 ld.global.f32 %f1084, [%rd243+4]
  f1084 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd243) + (4)))));
  // PTX:1865 ld.global.f32 %f1083, [%rd243+8]
  f1083 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd243) + (8)))));
  // PTX:1867 $L__BB77_133:
L_BB77_133:;
  // PTX:1868 ld.param.f32 %f900, [%rd2+236]
  f900 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd2) + (236))));
  // PTX:1869 mul.f32 %f901, %f1086, %f900
  asm("mul.f32 %0, %1, %2;" : "=f"(f901) : "f"(f1086), "f"(f900));
  // PTX:1870 max.f32 %f902, %f901, %f1082
  asm("max.f32 %0, %1, %2;" : "=f"(f902) : "f"(f901), "f"(f1082));
  // PTX:1871 min.f32 %f903, %f902, %f224
  asm("min.f32 %0, %1, %2;" : "=f"(f903) : "f"(f902), "f"(f224));
  // PTX:1872 ld.param.u64 %rd260, [%rd2+248]
  rd260 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (248))));
  // PTX:1873 cvta.to.global.u64 %rd261, %rd260
  rd261 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd260));
  // PTX:1874 add.s64 %rd263, %rd261, %rd94
  asm("add.s64 %0, %1, %2;" : "=l"(rd263) : "l"(rd261), "l"(rd94));
  // PTX:1875 st.global.f32 [%rd263], %f903
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd263) + (0))))) = (float)(f903);
  // PTX:1877 ld.param.v4.u8 {%rs6, %rs7, %rs8, %rs9}, [%rd2+244]
  rs6 = (*reinterpret_cast<volatile unsigned char*>(((uintptr_t)(rd2) + (244)))); rs7 = (*reinterpret_cast<volatile unsigned char*>(((uintptr_t)(rd2) + (245)))); rs8 = (*reinterpret_cast<volatile unsigned char*>(((uintptr_t)(rd2) + (246)))); rs9 = (*reinterpret_cast<volatile unsigned char*>(((uintptr_t)(rd2) + (247))));
  // PTX:1878 setp.eq.s16 %p127, %rs6, 0
  p127 = (((short)(rs6)) == ((short)(0)));
  // PTX:1879 setp.ne.s16 %p128, %rs8, 0
  p128 = (((short)(rs8)) != ((short)(0)));
  // PTX:1880 mov.u32 %r641, 0
  asm("mov.u32 %0, 0;" : "=r"(r641) : );
  // PTX:1881 and.pred %p129, %p127, %p128
  p129 = ((p127) && (p128));
  // PTX:1882 mov.u32 %r642, %r641
  asm("mov.u32 %0, %1;" : "=r"(r642) : "r"(r641));
  // PTX:1883 mov.u32 %r643, %r641
  asm("mov.u32 %0, %1;" : "=r"(r643) : "r"(r641));
  // PTX:1884 @%p129 bra $L__BB77_135
  if (p129) { goto L_BB77_135; }
  // PTX:1886 ld.param.f32 %f904, [%rd2+236]
  f904 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd2) + (236))));
  // PTX:1887 ld.param.f32 %f905, [%rd2+228]
  f905 = (*reinterpret_cast<volatile float*>(((uintptr_t)(rd2) + (228))));
  // PTX:1888 mul.f32 %f906, %f905, %f904
  asm("mul.f32 %0, %1, %2;" : "=f"(f906) : "f"(f905), "f"(f904));
  // PTX:1889 mul.f32 %f907, %f1085, %f906
  asm("mul.f32 %0, %1, %2;" : "=f"(f907) : "f"(f1085), "f"(f906));
  // PTX:1890 mul.f32 %f908, %f1084, %f906
  asm("mul.f32 %0, %1, %2;" : "=f"(f908) : "f"(f1084), "f"(f906));
  // PTX:1891 mul.f32 %f909, %f1083, %f906
  asm("mul.f32 %0, %1, %2;" : "=f"(f909) : "f"(f1083), "f"(f906));
  // PTX:1892 mov.b32 %r643, %f909
  asm("mov.b32 %0, %1;" : "=r"(r643) : "f"(f909));
  // PTX:1893 mov.b32 %r642, %f908
  asm("mov.b32 %0, %1;" : "=r"(r642) : "f"(f908));
  // PTX:1894 mov.b32 %r641, %f907
  asm("mov.b32 %0, %1;" : "=r"(r641) : "f"(f907));
  // PTX:1896 $L__BB77_135:
L_BB77_135:;
  // PTX:1897 ld.param.u64 %rd264, [%rd2+256]
  rd264 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (256))));
  // PTX:1898 cvta.to.global.u64 %rd265, %rd264
  rd265 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd264));
  // PTX:1899 mul.lo.s64 %rd266, %rd1, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd266) : "l"(rd1));
  // PTX:1900 add.s64 %rd267, %rd265, %rd266
  asm("add.s64 %0, %1, %2;" : "=l"(rd267) : "l"(rd265), "l"(rd266));
  // PTX:1901 st.global.u32 [%rd267], %r641
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd267) + (0))))) = (unsigned)(r641);
  // PTX:1902 st.global.u32 [%rd267+4], %r642
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd267) + (4))))) = (unsigned)(r642);
  // PTX:1903 st.global.u32 [%rd267+8], %r643
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd267) + (8))))) = (unsigned)(r643);
  // PTX:1904 setp.lt.s32 %p130, %r638, 0
  p130 = (((int)(r638)) < ((int)(0)));
  // PTX:1905 @%p130 bra $L__BB77_137
  if (p130) { goto L_BB77_137; }
  // PTX:1907 ld.param.u64 %rd268, [%rd2+208]
  rd268 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (208))));
  // PTX:1908 cvta.to.global.u64 %rd269, %rd268
  rd269 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd268));
  // PTX:1909 ld.param.u64 %rd270, [%rd2+184]
  rd270 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (184))));
  // PTX:1910 cvta.to.global.u64 %rd271, %rd270
  rd271 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd270));
  // PTX:1911 mul.wide.s32 %rd272, %r638, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd272) : "r"(r638));
  // PTX:1912 add.s64 %rd273, %rd271, %rd272
  asm("add.s64 %0, %1, %2;" : "=l"(rd273) : "l"(rd271), "l"(rd272));
  // PTX:1913 mov.b32 %f910, %r623
  asm("mov.b32 %0, %1;" : "=f"(f910) : "r"(r623));
  // PTX:1914 ld.global.f32 %f911, [%rd273]
  f911 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd273) + (0)))));
  // PTX:1915 sub.f32 %f912, %f910, %f911
  asm("sub.f32 %0, %1, %2;" : "=f"(f912) : "f"(f910), "f"(f911));
  // PTX:1916 mov.b32 %f913, %r622
  asm("mov.b32 %0, %1;" : "=f"(f913) : "r"(r622));
  // PTX:1917 ld.global.f32 %f914, [%rd273+4]
  f914 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd273) + (4)))));
  // PTX:1918 sub.f32 %f915, %f913, %f914
  asm("sub.f32 %0, %1, %2;" : "=f"(f915) : "f"(f913), "f"(f914));
  // PTX:1919 mov.b32 %f916, %r621
  asm("mov.b32 %0, %1;" : "=f"(f916) : "r"(r621));
  // PTX:1920 ld.global.f32 %f917, [%rd273+8]
  f917 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd273) + (8)))));
  // PTX:1921 sub.f32 %f918, %f916, %f917
  asm("sub.f32 %0, %1, %2;" : "=f"(f918) : "f"(f916), "f"(f917));
  // PTX:1922 mul.wide.s32 %rd274, %r633, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd274) : "r"(r633));
  // PTX:1923 add.s64 %rd275, %rd269, %rd274
  asm("add.s64 %0, %1, %2;" : "=l"(rd275) : "l"(rd269), "l"(rd274));
  // PTX:1924 mul.wide.s32 %rd276, %r632, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd276) : "r"(r632));
  // PTX:1925 add.s64 %rd277, %rd269, %rd276
  asm("add.s64 %0, %1, %2;" : "=l"(rd277) : "l"(rd269), "l"(rd276));
  // PTX:1926 ld.global.f32 %f919, [%rd277]
  f919 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd277) + (0)))));
  // PTX:1927 ld.global.f32 %f920, [%rd277+4]
  f920 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd277) + (4)))));
  // PTX:1928 ld.global.f32 %f921, [%rd277+8]
  f921 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd277) + (8)))));
  // PTX:1929 ld.global.f32 %f922, [%rd275]
  f922 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd275) + (0)))));
  // PTX:1930 fma.rn.f32 %f923, %f912, %f919, %f922
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f923) : "f"(f912), "f"(f919), "f"(f922));
  // PTX:1931 ld.global.f32 %f924, [%rd275+4]
  f924 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd275) + (4)))));
  // PTX:1932 fma.rn.f32 %f925, %f912, %f920, %f924
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f925) : "f"(f912), "f"(f920), "f"(f924));
  // PTX:1933 ld.global.f32 %f926, [%rd275+8]
  f926 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd275) + (8)))));
  // PTX:1934 fma.rn.f32 %f927, %f912, %f921, %f926
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f927) : "f"(f912), "f"(f921), "f"(f926));
  // PTX:1935 mul.wide.s32 %rd278, %r631, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd278) : "r"(r631));
  // PTX:1936 add.s64 %rd279, %rd269, %rd278
  asm("add.s64 %0, %1, %2;" : "=l"(rd279) : "l"(rd269), "l"(rd278));
  // PTX:1937 ld.global.f32 %f928, [%rd279]
  f928 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd279) + (0)))));
  // PTX:1938 ld.global.f32 %f929, [%rd279+4]
  f929 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd279) + (4)))));
  // PTX:1939 ld.global.f32 %f930, [%rd279+8]
  f930 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd279) + (8)))));
  // PTX:1940 fma.rn.f32 %f931, %f915, %f928, %f923
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f931) : "f"(f915), "f"(f928), "f"(f923));
  // PTX:1941 fma.rn.f32 %f932, %f915, %f929, %f925
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f932) : "f"(f915), "f"(f929), "f"(f925));
  // PTX:1942 fma.rn.f32 %f933, %f915, %f930, %f927
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f933) : "f"(f915), "f"(f930), "f"(f927));
  // PTX:1943 mul.wide.s32 %rd280, %r630, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd280) : "r"(r630));
  // PTX:1944 add.s64 %rd281, %rd269, %rd280
  asm("add.s64 %0, %1, %2;" : "=l"(rd281) : "l"(rd269), "l"(rd280));
  // PTX:1945 ld.global.f32 %f934, [%rd281]
  f934 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd281) + (0)))));
  // PTX:1946 ld.global.f32 %f935, [%rd281+4]
  f935 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd281) + (4)))));
  // PTX:1947 ld.global.f32 %f936, [%rd281+8]
  f936 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd281) + (8)))));
  // PTX:1948 fma.rn.f32 %f937, %f918, %f934, %f931
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f937) : "f"(f918), "f"(f934), "f"(f931));
  // PTX:1949 fma.rn.f32 %f938, %f918, %f935, %f932
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f938) : "f"(f918), "f"(f935), "f"(f932));
  // PTX:1950 fma.rn.f32 %f939, %f918, %f936, %f933
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f939) : "f"(f918), "f"(f936), "f"(f933));
  // PTX:1951 mov.b32 %r621, %f939
  asm("mov.b32 %0, %1;" : "=r"(r621) : "f"(f939));
  // PTX:1952 mov.b32 %r622, %f938
  asm("mov.b32 %0, %1;" : "=r"(r622) : "f"(f938));
  // PTX:1953 mov.b32 %r623, %f937
  asm("mov.b32 %0, %1;" : "=r"(r623) : "f"(f937));
  // PTX:1955 $L__BB77_137:
L_BB77_137:;
  // PTX:1956 setp.lt.s32 %p131, %r639, 0
  p131 = (((int)(r639)) < ((int)(0)));
  // PTX:1957 @%p131 bra $L__BB77_139
  if (p131) { goto L_BB77_139; }
  // PTX:1959 ld.param.u64 %rd282, [%rd2+208]
  rd282 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (208))));
  // PTX:1960 cvta.to.global.u64 %rd283, %rd282
  rd283 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd282));
  // PTX:1961 ld.param.u64 %rd284, [%rd2+184]
  rd284 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (184))));
  // PTX:1962 cvta.to.global.u64 %rd285, %rd284
  rd285 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd284));
  // PTX:1963 mul.wide.s32 %rd286, %r639, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd286) : "r"(r639));
  // PTX:1964 add.s64 %rd287, %rd285, %rd286
  asm("add.s64 %0, %1, %2;" : "=l"(rd287) : "l"(rd285), "l"(rd286));
  // PTX:1965 mov.b32 %f940, %r626
  asm("mov.b32 %0, %1;" : "=f"(f940) : "r"(r626));
  // PTX:1966 ld.global.f32 %f941, [%rd287]
  f941 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd287) + (0)))));
  // PTX:1967 sub.f32 %f942, %f940, %f941
  asm("sub.f32 %0, %1, %2;" : "=f"(f942) : "f"(f940), "f"(f941));
  // PTX:1968 mov.b32 %f943, %r625
  asm("mov.b32 %0, %1;" : "=f"(f943) : "r"(r625));
  // PTX:1969 ld.global.f32 %f944, [%rd287+4]
  f944 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd287) + (4)))));
  // PTX:1970 sub.f32 %f945, %f943, %f944
  asm("sub.f32 %0, %1, %2;" : "=f"(f945) : "f"(f943), "f"(f944));
  // PTX:1971 mov.b32 %f946, %r624
  asm("mov.b32 %0, %1;" : "=f"(f946) : "r"(r624));
  // PTX:1972 ld.global.f32 %f947, [%rd287+8]
  f947 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd287) + (8)))));
  // PTX:1973 sub.f32 %f948, %f946, %f947
  asm("sub.f32 %0, %1, %2;" : "=f"(f948) : "f"(f946), "f"(f947));
  // PTX:1974 mul.wide.s32 %rd288, %r637, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd288) : "r"(r637));
  // PTX:1975 add.s64 %rd289, %rd283, %rd288
  asm("add.s64 %0, %1, %2;" : "=l"(rd289) : "l"(rd283), "l"(rd288));
  // PTX:1976 mul.wide.s32 %rd290, %r636, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd290) : "r"(r636));
  // PTX:1977 add.s64 %rd291, %rd283, %rd290
  asm("add.s64 %0, %1, %2;" : "=l"(rd291) : "l"(rd283), "l"(rd290));
  // PTX:1978 ld.global.f32 %f949, [%rd291]
  f949 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd291) + (0)))));
  // PTX:1979 ld.global.f32 %f950, [%rd291+4]
  f950 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd291) + (4)))));
  // PTX:1980 ld.global.f32 %f951, [%rd291+8]
  f951 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd291) + (8)))));
  // PTX:1981 ld.global.f32 %f952, [%rd289]
  f952 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd289) + (0)))));
  // PTX:1982 fma.rn.f32 %f953, %f942, %f949, %f952
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f953) : "f"(f942), "f"(f949), "f"(f952));
  // PTX:1983 ld.global.f32 %f954, [%rd289+4]
  f954 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd289) + (4)))));
  // PTX:1984 fma.rn.f32 %f955, %f942, %f950, %f954
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f955) : "f"(f942), "f"(f950), "f"(f954));
  // PTX:1985 ld.global.f32 %f956, [%rd289+8]
  f956 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd289) + (8)))));
  // PTX:1986 fma.rn.f32 %f957, %f942, %f951, %f956
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f957) : "f"(f942), "f"(f951), "f"(f956));
  // PTX:1987 mul.wide.s32 %rd292, %r635, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd292) : "r"(r635));
  // PTX:1988 add.s64 %rd293, %rd283, %rd292
  asm("add.s64 %0, %1, %2;" : "=l"(rd293) : "l"(rd283), "l"(rd292));
  // PTX:1989 ld.global.f32 %f958, [%rd293]
  f958 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd293) + (0)))));
  // PTX:1990 ld.global.f32 %f959, [%rd293+4]
  f959 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd293) + (4)))));
  // PTX:1991 ld.global.f32 %f960, [%rd293+8]
  f960 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd293) + (8)))));
  // PTX:1992 fma.rn.f32 %f961, %f945, %f958, %f953
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f961) : "f"(f945), "f"(f958), "f"(f953));
  // PTX:1993 fma.rn.f32 %f962, %f945, %f959, %f955
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f962) : "f"(f945), "f"(f959), "f"(f955));
  // PTX:1994 fma.rn.f32 %f963, %f945, %f960, %f957
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f963) : "f"(f945), "f"(f960), "f"(f957));
  // PTX:1995 mul.wide.s32 %rd294, %r634, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd294) : "r"(r634));
  // PTX:1996 add.s64 %rd295, %rd283, %rd294
  asm("add.s64 %0, %1, %2;" : "=l"(rd295) : "l"(rd283), "l"(rd294));
  // PTX:1997 ld.global.f32 %f964, [%rd295]
  f964 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd295) + (0)))));
  // PTX:1998 ld.global.f32 %f965, [%rd295+4]
  f965 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd295) + (4)))));
  // PTX:1999 ld.global.f32 %f966, [%rd295+8]
  f966 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd295) + (8)))));
  // PTX:2000 fma.rn.f32 %f967, %f948, %f964, %f961
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f967) : "f"(f948), "f"(f964), "f"(f961));
  // PTX:2001 fma.rn.f32 %f968, %f948, %f965, %f962
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f968) : "f"(f948), "f"(f965), "f"(f962));
  // PTX:2002 fma.rn.f32 %f969, %f948, %f966, %f963
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f969) : "f"(f948), "f"(f966), "f"(f963));
  // PTX:2003 mov.b32 %r624, %f969
  asm("mov.b32 %0, %1;" : "=r"(r624) : "f"(f969));
  // PTX:2004 mov.b32 %r625, %f968
  asm("mov.b32 %0, %1;" : "=r"(r625) : "f"(f968));
  // PTX:2005 mov.b32 %r626, %f967
  asm("mov.b32 %0, %1;" : "=r"(r626) : "f"(f967));
  // PTX:2007 $L__BB77_139:
L_BB77_139:;
  // PTX:2008 mov.b32 %f970, %r626
  asm("mov.b32 %0, %1;" : "=f"(f970) : "r"(r626));
  // PTX:2009 mov.b32 %f971, %r623
  asm("mov.b32 %0, %1;" : "=f"(f971) : "r"(r623));
  // PTX:2010 sub.f32 %f972, %f971, %f970
  asm("sub.f32 %0, %1, %2;" : "=f"(f972) : "f"(f971), "f"(f970));
  // PTX:2011 mov.b32 %f973, %r625
  asm("mov.b32 %0, %1;" : "=f"(f973) : "r"(r625));
  // PTX:2012 mov.b32 %f974, %r622
  asm("mov.b32 %0, %1;" : "=f"(f974) : "r"(r622));
  // PTX:2013 sub.f32 %f975, %f974, %f973
  asm("sub.f32 %0, %1, %2;" : "=f"(f975) : "f"(f974), "f"(f973));
  // PTX:2014 mov.b32 %f976, %r624
  asm("mov.b32 %0, %1;" : "=f"(f976) : "r"(r624));
  // PTX:2015 mov.b32 %f977, %r621
  asm("mov.b32 %0, %1;" : "=f"(f977) : "r"(r621));
  // PTX:2016 sub.f32 %f978, %f977, %f976
  asm("sub.f32 %0, %1, %2;" : "=f"(f978) : "f"(f977), "f"(f976));
  // PTX:2017 mov.b32 %f979, %r629
  asm("mov.b32 %0, %1;" : "=f"(f979) : "r"(r629));
  // PTX:2018 mul.f32 %f980, %f1081, %f979
  asm("mul.f32 %0, %1, %2;" : "=f"(f980) : "f"(f1081), "f"(f979));
  // PTX:2019 mov.b32 %f981, %r628
  asm("mov.b32 %0, %1;" : "=f"(f981) : "r"(r628));
  // PTX:2020 mul.f32 %f982, %f1081, %f981
  asm("mul.f32 %0, %1, %2;" : "=f"(f982) : "f"(f1081), "f"(f981));
  // PTX:2021 mov.b32 %f983, %r627
  asm("mov.b32 %0, %1;" : "=f"(f983) : "r"(r627));
  // PTX:2022 mul.f32 %f984, %f1081, %f983
  asm("mul.f32 %0, %1, %2;" : "=f"(f984) : "f"(f1081), "f"(f983));
  // PTX:2023 mul.f32 %f985, %f975, %f981
  asm("mul.f32 %0, %1, %2;" : "=f"(f985) : "f"(f975), "f"(f981));
  // PTX:2024 fma.rn.f32 %f986, %f972, %f979, %f985
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f986) : "f"(f972), "f"(f979), "f"(f985));
  // PTX:2025 fma.rn.f32 %f987, %f978, %f983, %f986
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f987) : "f"(f978), "f"(f983), "f"(f986));
  // PTX:2026 mul.f32 %f988, %f987, %f979
  asm("mul.f32 %0, %1, %2;" : "=f"(f988) : "f"(f987), "f"(f979));
  // PTX:2027 mul.f32 %f989, %f987, %f981
  asm("mul.f32 %0, %1, %2;" : "=f"(f989) : "f"(f987), "f"(f981));
  // PTX:2028 mul.f32 %f990, %f987, %f983
  asm("mul.f32 %0, %1, %2;" : "=f"(f990) : "f"(f987), "f"(f983));
  // PTX:2029 sub.f32 %f991, %f972, %f988
  asm("sub.f32 %0, %1, %2;" : "=f"(f991) : "f"(f972), "f"(f988));
  // PTX:2030 sub.f32 %f992, %f975, %f989
  asm("sub.f32 %0, %1, %2;" : "=f"(f992) : "f"(f975), "f"(f989));
  // PTX:2031 sub.f32 %f993, %f978, %f990
  asm("sub.f32 %0, %1, %2;" : "=f"(f993) : "f"(f978), "f"(f990));
  // PTX:2032 sub.f32 %f994, %f980, %f991
  asm("sub.f32 %0, %1, %2;" : "=f"(f994) : "f"(f980), "f"(f991));
  // PTX:2033 sub.f32 %f995, %f982, %f992
  asm("sub.f32 %0, %1, %2;" : "=f"(f995) : "f"(f982), "f"(f992));
  // PTX:2034 sub.f32 %f996, %f984, %f993
  asm("sub.f32 %0, %1, %2;" : "=f"(f996) : "f"(f984), "f"(f993));
  // PTX:2035 ld.param.u64 %rd296, [%rd2+264]
  rd296 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)(rd2) + (264))));
  // PTX:2036 cvta.to.global.u64 %rd297, %rd296
  rd297 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd296));
  // PTX:2037 add.s64 %rd299, %rd297, %rd266
  asm("add.s64 %0, %1, %2;" : "=l"(rd299) : "l"(rd297), "l"(rd266));
  // PTX:2038 st.global.f32 [%rd299], %f994
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd299) + (0))))) = (float)(f994);
  // PTX:2039 st.global.f32 [%rd299+4], %f995
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd299) + (4))))) = (float)(f995);
  // PTX:2040 st.global.f32 [%rd299+8], %f996
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd299) + (8))))) = (float)(f996);
  // PTX:2042 $L__BB77_141:
L_BB77_141:;
  // PTX:2043 ret
  return;
}
