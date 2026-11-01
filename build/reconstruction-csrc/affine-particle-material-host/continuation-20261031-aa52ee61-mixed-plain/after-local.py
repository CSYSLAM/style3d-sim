from pathlib import Path
import json,subprocess,sys
root=Path.cwd();base=Path(__file__).resolve().parent
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes();rows=[]
for name in ('run-regression.py','run-frontends.py'):
 assert build.read_bytes()==saved
 with (base/(name+'.driver.log')).open('w') as log:
  code=subprocess.run([sys.executable,str(base/name)],stdout=log,stderr=subprocess.STDOUT,timeout=18000).returncode
 rows.append({'name':name,'exit':code});(base/'after-local-status.json').write_text(json.dumps({'complete':False,'finished':rows,'official_cloth_repeated':False,'reason':'The guarded plain-mixture change does not enter the formal cloth branch; retain the frozen aa52 failure and its separate diagnosis'},indent=2)+'\n')
 print(name,code,flush=True);assert code==0
(base/'after-local-status.json').write_text(json.dumps({'complete':True,'finished':rows,'official_cloth_repeated':False,'whole_solver_complete':False},indent=2)+'\n')
