// 与 glm::vec3 同布局（12 B，align 4），用于让还原代码不依赖 glm
#pragma once
struct Vec3 { float x, y, z; };
