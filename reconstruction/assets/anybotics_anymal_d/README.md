# ANYmal D：源码重建用固定资产

来源为newton-physics/newton-assets的`261cd1f429619d8ef4f546bd788ab9dea906b5e1`，
与本环境Newton的固定引用一致。本包从现有同版本缓存逐字节复制，未下载或改写资产。
`files/`保留原20文件、目录结构、LICENSE和上游README，共4317058字节；逐文件长度及SHA见manifest.json。

Windows请在WSL2仓库根目录执行，无需账号或网络：

```bash
python3 scripts/restore_reconstruction_anymal_assets.py
```

可用`--cache-dir PATH`指定独立Newton缓存；首次恢复和已有目录重验均核全部20文件，内容不同则拒绝覆盖。
真正的`newton.utils.download_asset("anybotics_anymal_d")`已在CPU上验证fresh和TTL过期缓存，
两次均找到相同固定文件；测试禁止Git网络命令，未创建GPU上下文。
本次现场GPU构建尚未完成时，这只是缓存格式及资产字节保证，不宣称仿真通过。

CPU OpenUSD已组合17个RigidBody和16个Joint，16个可解析依赖均在固定20文件中。
`OmniPBR.mdl`仍未解析，30处引用均为材质库中Shader的`info:mdl:sourceAsset`，原文件未修改。
这不是所有渲染依赖齐备的声明；实际Newton模型构建、独立源码运行与原版一致性须分别验证。

详细证据及当前运行接续见[四demo记录](../../csrc/OFFICIAL_DEMO_FOUR_0DABBAA7.md)。
