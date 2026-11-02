import subprocess,json,sys
from pathlib import Path
p=Path('draft_b1f312c1_folder');doc='CaaPdRqBzobz9ZxQoJhc5wGbnSd'
for r in json.loads((p/'repairs.json').read_text()):
 f=p/f"repair_{r['index']}_result.json"
 if f.exists() and json.loads(f.read_text()).get('ok'):continue
 result=subprocess.run(['lark-cli','docs','+update','--as','user','--doc',doc,'--command','block_replace','--block-id',r['block_id'],'--doc-format','xml','--content','@./'+r['path'],'--format','json'],text=True,capture_output=True)
 if result.returncode: print(result.stderr,flush=True);sys.exit(result.returncode)
 data=json.loads(result.stdout);f.write_text(result.stdout);print(r['index'],data.get('ok'),data.get('data',{}).get('warnings',[]),flush=True)
 if data.get('data',{}).get('warnings'):sys.exit(1)
