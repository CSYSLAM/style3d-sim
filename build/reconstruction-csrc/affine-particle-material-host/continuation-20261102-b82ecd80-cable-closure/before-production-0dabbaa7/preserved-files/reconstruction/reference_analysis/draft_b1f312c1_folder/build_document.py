from pathlib import Path
import re, html, json, hashlib
D=Path('draft_b1f312c1_folder'); src=Path('ALGORITHM_ANALYSIS_ZH.md').read_text()
def esc(s): return html.escape(s,quote=False)
# Small, self-contained diagrams use standard editable SVG primitives.
class SVG:
 def __init__(self,title,h=420):
  self.h=h; self.s=[f'<svg xmlns="http://www.w3.org/2000/svg" width="1000" height="{h}" viewBox="0 0 1000 {h}">',f'<rect x="0" y="0" width="1000" height="{h}" rx="16" fill="#f8fafc"/>']; self.text(32,40,title,24,'#0f172a')
 def text(self,x,y,t,size=19,color='#334155',anchor='start'):
  self.s.append(f'<text x="{x}" y="{y}" font-family="Noto Sans CJK SC, sans-serif" font-size="{size}" fill="{color}" text-anchor="{anchor}">{esc(t)}</text>')
 def rect(self,x,y,w,h,fill='#e0e7ff',stroke='#818cf8',r=12): self.s.append(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="{r}" fill="{fill}" stroke="{stroke}" stroke-width="2"/>')
 def box(self,x,y,w,title,sub='',color='#e0e7ff'):
  self.rect(x,y,w,78,color);self.text(x+w/2,y+30,title,20,anchor='middle');self.text(x+w/2,y+58,sub,16,anchor='middle')
 def line(self,pts,color='#64748b',arrow=True):
  self.s.append('<polyline points="'+' '.join(f'{x},{y}' for x,y in pts)+f'" fill="none" stroke="{color}" stroke-width="2.5"/>')
  if arrow:
   x,y=pts[-1]; px,py=pts[-2]; dx,dy=x-px,y-py; n=(dx*dx+dy*dy)**.5; ux,uy=dx/n,dy/n
   p=[(x,y),(x-10*ux+5*uy,y-10*uy-5*ux),(x-10*ux-5*uy,y-10*uy+5*ux)]
   self.s.append('<polygon points="'+' '.join(f'{a},{b}' for a,b in p)+f'" fill="{color}"/>')
 def circle(self,x,y,r,fill='#2563eb'):
  self.s.append(f'<circle cx="{x}" cy="{y}" r="{r}" fill="{fill}"/>')
 def poly(self,pts,fill,stroke='#64748b'):
  self.s.append('<polygon points="'+' '.join(f'{x},{y}' for x,y in pts)+f'" fill="{fill}" stroke="{stroke}" stroke-width="2"/>')
 def save(self,name): (D/(name+'.svg')).write_text('\n'.join(self.s+['</svg>']))
s=SVG('图 1｜多物理模块如何接入统一求解器',480)
s.box(30,75,280,'输入与静态数据','Model · State · Control · Contact');s.box(360,75,280,'局部物理评估','力 / 残差 / 历史状态');s.box(690,75,280,'线性系统','稀疏项 + 局部算子 + 预条件')
s.line([(310,114),(360,114)]);s.line([(640,114),(690,114)])
s.box(30,230,280,'物理模块','弹性 · 刚体 · 关节 · 线缆');s.box(360,230,280,'相互作用与介质','接触 · 自碰撞 · 流体 · 颗粒');s.box(690,230,280,'Newton / PCG','求增量 → 限步 → 更新坐标')
s.line([(170,230),(170,193),(470,193),(470,153)]);s.line([(500,230),(500,153)]);s.line([(830,153),(830,230)])
s.line([(830,308),(830,350),(500,350),(500,308)]);s.text(550,378,'更新几何后重新线性化',18)
s.text(32,435,'依赖关系示意；不代表已恢复全部主机分支或实际 launch 时序。',18);s.save('01_architecture')
s=SVG('图 2｜Newton 外迭代与 PCG 内迭代',535)
s.box(35,75,260,'时间步预测','惯性 / 外力 / 本步状态');s.box(365,75,270,'重新线性化','当前残差 R 与算子 A');s.line([(295,114),(365,114)])
s.rect(335,190,615,180,'#eff6ff','#60a5fa');s.text(355,220,'PCG：固定本轮线性化，近似求解 A Δx = −R',19)
s.box(355,245,170,'算子作用','Ap 与内积');s.box(555,245,170,'向量更新','解 z 与残差 r');s.box(755,245,170,'预条件','Pr 与方向 p')
s.line([(525,284),(555,284)]);s.line([(725,284),(755,284)]);s.line([(840,323),(840,348),(440,348),(440,323)])
s.line([(500,153),(500,190)]);s.box(35,265,250,'步长与坐标更新','流体限步 / 局部状态周期');s.line([(335,280),(285,280)]);s.line([(160,265),(160,173),(390,173),(390,153)])
s.box(35,410,250,'结束本步','历史提交 / 速度恢复');s.line([(160,343),(160,410)]);s.text(345,425,'外层：减少非线性误差',20);s.text(345,460,'内层：减少当前线性系统误差',20);s.text(35,510,'循环次数由配置决定；图中顺序是逻辑组织，分支与局部状态更新见正文。',17);s.save('02_solver')
s=SVG('图 3｜三角形膜内：材料方向与三个残差',410)
s.poly([(70,300),(390,300),(165,105)],'#dbeafe');
for x,y,t in [(70,300,'x₀'),(390,300,'x₁'),(165,105,'x₂')]:s.circle(x,y,7);s.text(x-12,y+30,t)
s.line([(155,245),(305,245)],'#2563eb');s.text(250,230,'a',22,'#2563eb');s.line([(155,245),(202,155)],'#0d9488');s.text(215,175,'b',22,'#0d9488')
s.text(485,110,'a、b 来自参考形函数导数',22);s.text(485,165,'经向伸长：|a| − 1',22,'#2563eb');s.text(485,215,'纬向伸长：|b| − 1',22,'#0d9488');s.text(485,265,'剪切：正则化单位方向的点积',22);s.text(35,380,'几何示意：方向与比例仅用于解释；精确正则项、梯度和装配增量见本节公式。',17);s.save('03_membrane')
s=SVG('图 4｜仿射刚体：平移 + 三列矩阵 = 12 个标量自由度',400)
s.poly([(70,240),(210,240),(210,100),(70,100)],'#dbeafe');s.text(80,285,'参考局部坐标 X',19)
s.line([(270,175),(420,175)]);s.text(283,150,'x = t + AX',20)
s.poly([(480,265),(665,235),(720,85),(535,115)],'#ccfbf1');s.circle(480,265,6);s.line([(480,265),(650,237)],'#2563eb');s.line([(480,265),(530,125)],'#0d9488');s.line([(480,265),(440,210)],'#9333ea')
s.text(770,125,'t：3 个分量',21);s.text(770,175,'A：9 个分量',21);s.text(770,235,'SO(3) 约束',21);s.text(770,270,'抑制非刚性形变',18)
s.text(35,360,'空间力通过点 Jacobian 映射回广义坐标；刚性模型与惯性模式是不同配置。',18);s.save('04_affine')
s=SVG('图 5｜自碰撞：搜索结构、几何判断与物理响应',430)
s.box(30,80,280,'包围盒与编码','AABB → Morton 排序');s.box(360,80,280,'LBVH','基数树 / refit / escape');s.box(690,80,280,'候选查询','缩小可能相交的组合')
s.line([(310,119),(360,119)]);s.line([(640,119),(690,119)]);s.line([(830,158),(830,250)])
s.box(690,250,280,'精确几何判断','点面 / 边边 / 粒子对 / 边面');s.box(360,250,280,'局部响应','力 / 切线 / 对角贡献');s.box(30,250,280,'接入全局求解','PCG 算子与预条件')
s.line([(690,289),(640,289)]);s.line([(360,289),(310,289)]);s.text(32,390,'BVH 只加速搜索；这些入口本身不构成 CCD、严格无穿透或全局可行性的证明。',18);s.save('05_collision')
s=SVG('图 6｜流体：空间邻居 → 密度残差 → 行式算子',450)
for i in range(4):s.line([(40+i*75,95),(40+i*75,320)],'#cbd5e1',False);s.line([(40,95+i*75),(265,95+i*75)],'#cbd5e1',False)
for x,y in [(145,202),(80,150),(215,145),(98,270),(230,285),(184,240)]:s.circle(x,y,8,'#0d9488' if (x,y)!=(145,202) else '#2563eb')
s.text(35,360,'查询周围 27 格（图为二维切片）',17);s.line([(280,205),(365,205)])
s.box(380,80,255,'归一化密度','流体体积 + 固定边界贡献');s.box(690,80,280,'单边残差','仅过密时激活压力项');s.line([(635,119),(690,119)])
s.box(380,250,255,'Jacobian 行','先 Jp，再 Jᵀ(kJp)');s.box(690,250,280,'世界级步长缩放','relaxation 与最大位移限制');s.line([(830,158),(830,205),(507,205),(507,250)]);s.line([(635,289),(690,289)])
s.text(35,410,'动态邻居 ≤64 时使用缓存；≥65 时重新查询。黏性配对独立于压力激活。',18);s.save('06_fluid')
s=SVG('图 7｜验证范围：入口核对与运行场景是不同层次',390)
s.text(35,100,'131 个自研入口：语句映射、编译与加载均完成',22)
s.rect(35,135,920,66,'#e2e8f0','#cbd5e1',3);s.rect(35,135,920*46/131,66,'#bfdbfe','#60a5fa',3)
s.text(50,175,'46 个：独立公式运行对照',19);s.text(395,175,'85 个：尚未加入独立公式运行场景',19)
s.text(35,250,'408 项输出检查 ≠ 408 个独立物理场景',23,'#1d4ed8');s.text(35,295,'已测入口仍有未穷举分支；完整 step 与长期轨迹尚待验证。',20);s.text(35,350,'来源：原稿第 23.6 节。以上为原有记录，本次整理未重新运行 GPU 验证。',17);s.save('07_validation')
# Preserve all technical paragraphs and equations; convert presentation only.
math=[]; local_refs=[]
def inline(s):
 pattern=r'(`[^`]+`|\$[^$]+\$|\[[^\]]+\]\([^)]+\)|\*\*.+?\*\*)'
 out=[];pos=0
 for m in re.finditer(pattern,s):
  out.append(esc(s[pos:m.start()]));v=m.group()
  if v.startswith('`'):out.append('<span>'+esc(v[1:-1])+'</span>')
  elif v.startswith('$'):math.append(v[1:-1]);out.append('<latex>'+esc(v[1:-1])+'</latex>')
  elif v.startswith('**'):out.append('<b>'+inline(v[2:-2])+'</b>')
  else:
   a=re.match(r'\[([^\]]+)\]\(([^)]+)\)',v);label,url=a.groups()
   if url.startswith('http'):out.append('<a href="'+html.escape(url,quote=True)+'">'+inline(label)+'</a>')
   elif url.startswith('#'):out.append(inline(label))
   else:local_refs.append(url);out.append(inline(label)+'（工作区路径：'+esc(url)+'）')
  pos=m.end()
 out.append(esc(s[pos:]));return ''.join(out)
def para(t):return '<p>'+inline(t)+'</p>'
def board(name,caption):return f'<whiteboard type="svg" path="@./{D}/{name}.svg"/>\n'+para(caption)
inserts={
 '## 3. 单个时间步的算法流程':('02_solver','图 2：外层更新非线性状态，内层求当前线性子问题。保留原伪代码便于对照。'),
 '## 8. 布料膜内伸长与剪切':('03_membrane','图 3：两个材料方向对应伸长与剪切；这是形函数模型，不是三条边弹簧的替代画法。'),
 '## 11. 仿射刚体与 SO(3) 刚性约束':('04_affine','图 4：仿射自由度统一接入力与切线；额外刚性约束抑制形变。'),
 '## 14. 自碰撞与 LBVH':('05_collision','图 5：将搜索、几何判断和响应分开阅读，避免从加速结构推断碰撞保证。'),
 '## 15. 流体密度约束、空间哈希与步长限制':('06_fluid','图 6：密度约束以 Jacobian 行参与统一求解；固定边界只贡献采样，不获得动态自由度。'),
 '## 23. 未确认事项与复现检查清单':('07_validation','图 7：蓝色区域表示加入独立公式运行对照的入口数量，不能解释成分支覆盖率。')}
out=['<title>Synreal / Style3D CUDA 仿真核心｜算法、公式与实现图解</title>']
out += [para('文档状态：基于用户提供的 ALGORITHM_ANALYSIS_ZH.md 整理的内部技术分析。分析日期：2026-10-27；适用对象为原稿记录的二进制版本。适读人群：仿真算法、GPU 实现与复现验证工程师。'),'<callout background-color="light-blue" border-color="blue"><p><b>核心结论：</b>多类物理对象通过力、残差、切线和预条件贡献接入统一的位置／广义坐标求解。Newton 负责非线性外迭代，PCG 求解当前线性增量；接触、颗粒和线缆还需要独立解释历史状态。</p></callout>',para('阅读方法：先读第 1–6 节建立证据与求解框架，再按第 7–18 节查局部物理模型，最后用第 19–23 节核对布局、配置、数值边界与验证范围。原稿的 23 章、公式、36 项配置及验证记录完整保留。'),para('关键边界：131 个自研入口已完成语句核对与编译加载；其中 46 个入口有独立公式运行场景。局部通过不代表完整调度、所有条件分支或长期轨迹均已验证。本次仅整理文档，未重新执行这些 GPU 实验。'),para('公式说明：使用飞书原生 LaTeX；独立公式居中。图示根据原稿绘制，作为概念与依赖关系的辅助说明，不新增实现证据。正文中“工作区路径”是源码定位信息，不是飞书网页链接。'),'<hr/>']
lines=src.splitlines();i=1
while i<len(lines):
 s=lines[i].strip()
 if not s or s.startswith('<a id=') or s.startswith('<!--'):i+=1;continue
 if s=='## 阅读导航':
  i+=1
  while i<len(lines) and not lines[i].startswith('<a id="s1"'):i+=1
  continue
 if s.startswith('#'):
  m=re.match(r'(#+)\s+(.*)',s);level=len(m[1])-1;title=re.sub(r'^\d+(?:\.\d+)*\.?\s+','',m[2]);out.append(f'<h{level} seq="auto">'+inline(title)+f'</h{level}>')
  if s in inserts:out.append(board(*inserts[s]))
  i+=1;continue
 if s.startswith('```'):
  lang=s[3:];code=[];i+=1
  while not lines[i].strip().startswith('```'):code.append(lines[i]);i+=1
  i+=1
  if lang=='mermaid':out.append(board('01_architecture','图 1：依赖关系图，不是已恢复的逐分支运行轨迹。'))
  else:out.append(f'<pre lang="{dict(cpp="cpp",bash="bash",text="plaintext",ptx="plaintext").get(lang,"plaintext")}"><code>'+esc('\n'.join(code))+'</code></pre>')
  continue
 if s.startswith('$$'):
  eq=s[2:]
  while not eq.endswith('$$'):i+=1;eq+='\n'+lines[i].strip()
  eq=eq[:-2].strip();math.append(eq);out.append('<p align="center"><latex>'+esc('\\displaystyle '+eq)+'</latex></p>');i+=1;continue
 if s.startswith('|'):
  rows=[]
  while i<len(lines) and lines[i].strip().startswith('|'):
   line=lines[i].strip();cells=[c.strip() for c in line[1:-1].split('|')]
   if not all(re.fullmatch(r':?-+:?',c) for c in cells):rows.append(cells)
   i+=1
  assert len({len(r) for r in rows})==1, rows
  parts=['<table><thead><tr>']
  parts += ['<th background-color="light-gray">'+para(c)+'</th>' for c in rows[0]];parts.append('</tr></thead><tbody>')
  for row in rows[1:]:parts.append('<tr>'+''.join('<td>'+para(c)+'</td>' for c in row)+'</tr>')
  parts.append('</tbody></table>');out.append(''.join(parts));continue
 if re.match(r'^(?:- |\d+\. )',s):
  typ='ul' if s.startswith('- ') else 'ol';items=[]
  while i<len(lines) and re.match(r'^(- |\d+\. )',lines[i].strip()):items.append('<li>'+inline(re.sub(r'^(- |\d+\. )','',lines[i].strip()))+'</li>');i+=1
  out.append('<'+typ+'>'+''.join(items)+'</'+typ+'>');continue
 if s=='---':out.append('<hr/>');i+=1;continue
 p=[s];i+=1
 while i<len(lines) and lines[i].strip() and not re.match(r'^(#|\$\$|```|\||<a |<!--|- |\d+\. )',lines[i].strip()):p.append(lines[i].strip());i+=1
 out.append(para(' '.join(p)))
out += ['<hr/>',para('配套附件与追溯：下列文件为当前工作区的原始分析与配套记录，保留完整入口目录和验证依据。其他源码路径需在对应工作区中访问。')]
for f in ['ALGORITHM_ANALYSIS_ZH.md','ALGORITHM_KERNEL_CATALOG_ZH.md','PTX_CODE_VERIFICATION_ZH.md','host/VERIFIED_ARGUMENTS_ZH.md']:
 if Path(f).exists():out.append(f'<source path="@./{f}" name="{Path(f).name}"/>')
(D/'draft.xml').write_text('\n'.join(out))
(D/'formulas.json').write_text(json.dumps(math,ensure_ascii=False,indent=2))
meta={'source_sha256':hashlib.sha256(src.encode()).hexdigest(),'formulas':len(math),'display_formulas':sum('align="center"' in x for x in out),'tables':sum(x.startswith('<table>') for x in out),'diagrams':7,'headings':sum(x.startswith('<h') and not x.startswith('<hr') for x in out),'local_references':len(local_refs),'xml_bytes':(D/'draft.xml').stat().st_size}
(D/'build_manifest.json').write_text(json.dumps(meta,indent=2));print(json.dumps(meta))
