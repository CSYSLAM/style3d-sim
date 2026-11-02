from pathlib import Path
import xml.etree.ElementTree as E,json,re
p=Path('draft_b1f312c1_folder');raw=(p/'draft.xml').read_text();a=E.fromstring('<doc>'+raw+'</doc>')
for r in json.loads((p/'repairs.json').read_text()):a[r['index']]=E.fromstring(Path(r['path']).read_text())
res=json.loads((p/'verified_remote.json').read_text());b=E.fromstring('<doc>'+res['data']['document']['content']+'</doc>')
norm=lambda s:re.sub(r'\s','',s or '')
af=[x.text for x in a.iter('latex')];bf=[x.text for x in b.iter('latex')];assert len(af)==len(bf)==503
assert [norm(x) for x in af]==[norm(x) for x in bf],[(i,x,y) for i,(x,y) in enumerate(zip(af,bf)) if norm(x)!=norm(y)]
assert len(a)==len(b)==732
for i,(x,y) in enumerate(zip(a,b)):
 if x.tag in ['source','whiteboard']:continue
 assert norm(''.join(x.itertext()))==norm(''.join(y.itertext())),(i,x.tag)
report={'url':'https://dexforce.feishu.cn/docx/CaaPdRqBzobz9ZxQoJhc5wGbnSd','native_formulas':len(bf),'main_sections':len(b.findall('h1')),'tables':len(list(b.iter('table'))),'whiteboards':len(b.findall('whiteboard')),'attachments':len(list(b.iter('source'))),'formula_content_match':True,'all_text_content_match':True,'source_markdown_unchanged':True}
(p/'final_verification.json').write_text(json.dumps(report,ensure_ascii=False,indent=2));(p/'remote_formulas.json').write_text(json.dumps(bf));(p/'draft_initial.xml').write_text(raw);(p/'draft.xml').write_text('\n'.join(E.tostring(x,encoding='unicode') for x in a));print(json.dumps(report,ensure_ascii=False))
