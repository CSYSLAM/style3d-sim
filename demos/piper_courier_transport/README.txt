不透明快递外包装袋场景

在仓库根目录运行窗口版：
.\.venv\Scripts\python.exe demos\piper_courier_transport\demo_piper_courier_transport.py

记录完整仿真：
.\.venv\Scripts\python.exe demos\piper_courier_transport\demo_piper_courier_transport.py --viewer=false

渲染预览帧：
& D:\software\blender\blender.exe --background --python demos/piper_courier_transport/render_courier.py -- --frames 0,210,630,810

新增场景独立输出到 build/courier-package，不覆盖透明袋场景。
窗口与 USD 使用灰色不透明袋面；Blender 使用不透明塑料材质，保留变形、褶皱和白色标签。
Blender 输出 reference_scene.blend 与 reference_frames 目录，均位于新场景输出目录内。
加 --animation 可以渲染完整 900 帧。

渲染并输出完整视频（使用已有仿真缓存）：
.\.venv\Scripts\python.exe demos\piper_courier_transport\make_video.py
输出：build/courier-package/courier_package_transport.mp4，30 秒、30 fps。
该命令会完整解码检查视频；--encode-only 可以使用已经渲染的 900 帧直接编码。
assets 中包含通用示例运单与袋面封口线贴图，不包含真实收件人信息或品牌标识。
封口线仅是外观细节，未新增可撕胶条或翻盖力学结构；并非某一实物快递袋的精确复刻。

此版本仅将原薄膜袋外观改成快递外包装袋；几何、动作、内部载荷、接触、粘附和力学参数沿用原场景。
默认 8 子步，由 s3d.NewtonSolver 求解；并未额外标定真实快递袋的材料参数。
已有预览复用原场景物理缓存生成，未另算 30 秒动力学；新入口已经通过短时无窗口求解和 USD 导出检查。
