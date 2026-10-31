from pathlib import Path
import xml.etree.ElementTree as E,json,re
p=Path('draft_b1f312c1_folder');a=E.fromstring('<doc>'+ (p/'draft.xml').read_text()+'</doc>');b=E.fromstring('<doc>'+ (p/'remote.xml').read_text()+'</doc>');patches=[]
for i,(x,y) in enumerate(zip(a,b)):
 ax=list(x.iter('latex'));by=list(y.iter('latex'))
 changed=len(ax)!=len(by) or any(re.sub(r'\s','',v.text)!=re.sub(r'\s','',w.text) for v,w in zip(ax,by))
 if not changed:continue
 for v in ax:
  v.text=v.text.replace('\n',' ').replace('\\\\-','\\\\ -').replace('\\_', '\\char95 ')
  if 'H(c)=' in v.text:v.text=v.text.replace('\\&',r'\mathbin{\mathrm{AND}}')
 if i==466: x.find('latex').tail=' 其中 AND 表示按位与。'
 f=p/f'repair_{i}.xml';f.write_text(E.tostring(x,encoding='unicode'))
 patches.append({'index':i,'block_id':y.attrib['id'],'path':str(f)})
(p/'repairs.json').write_text(json.dumps(patches,indent=2));print(json.dumps(patches))
(p/'repair_formulas.json').write_text(json.dumps([v.text for r in patches for v in E.fromstring(Path(r['path']).read_text()).iter('latex')]))
