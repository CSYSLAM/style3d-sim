参考视频包裹抓取仿真

参考：D:\work\video\飞书20261028-161921.mp4
重点：硬包与软包、夹膜抓取、三次抖动、自由释放、落地与停止。

物理实现复用仓库 piper_package_transport，仍由一个 s3d.NewtonSolver
计算机械臂、两个封口薄膜袋、刚体纸盒和 1400 四面体的软体内容物。
机器人与包裹之间没有绑定或位置动画；软体与薄膜之间保留原场景的有限刚度黏附弹簧。
新增入口默认采用经过本次完整验证的 8 子步、4 次非线性、50 次线性迭代配置。
原场景和二进制未修改。

在仓库根目录运行实时求解窗口：
.venv\Scripts\python.exe demos\reference_package_transport\demo_reference_package_transport.py

实时求解速度取决于机器；本次 30 秒仿真记录约耗时 509 秒，不能称为实时性能。
Blender 工程播放的是该求解器产生的完整缓存，帧率为 30 fps，时间轴为 0–900。

完整重算、验证、渲染和视频编码：
.venv\Scripts\python.exe demos\reference_package_transport\workflow.py

仅使用已有仿真缓存重新渲染：
.venv\Scripts\python.exe demos\reference_package_transport\workflow.py --render-only

默认 Blender 路径：D:\software\blender\blender.exe；可通过 --blender 指定。
默认输出：build\reference-match-8

交付文件：
- reference_reconstruction.mp4：30 秒复现视频。
- reference_side_by_side.mp4：左侧原片，右侧仿真。
- reference_scene.blend：完整 Blender 场景。
- simulation.usdc：30 秒动态缓存，Blender 工程需要此文件。
- trajectory.npz：原始仿真粒子和刚体轨迹。
- validation.json：35 项原项目验收结果。
- physics_characteristics.json：物理模型及软体形变测量。
- reconstruction_report.json：版本、参数、验证范围和已知差异。

复现范围与限制：
完成原片的主要物理流程；没有宣称原片的材料参数、全部三维运动或逐像素画面完全一致。
8 子步记录通过 35/35 项项目检查。默认 4 子步对照未通过软体包含和一次释放间距检查，
因此没有作为交付配置。包含关系检查采用离散采样，并非连续无穿透证明；本次最低
布料/软体高度约为地面以下 1.99 mm，处于原验证器容差内。
相机、灰色地面、标签和薄膜材质按参考画面调整；细皱、颜色和局部物体轨迹仍有差异。
reference_style.json 可调整渲染外观，不改变求解结果。

Blender 5.1 不能读取原 HDRI 的 CRLF 文件头。本入口仅在输出目录生成 LF 兼容副本，
保持 HDRI 二进制像素不变，并将纹理打包进 Blender 工程。
