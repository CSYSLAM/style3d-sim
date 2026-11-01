from pathlib import Path
import hashlib,json,subprocess,sys,time
root=Path.cwd();base=Path(__file__).resolve().parent
previous=root/'build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-aa52ee61-mixed-plain'
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes()
assert json.loads(saved)['extension_sha256']=='3d1b1b883a620f0028f2c4b16c2d2e490b96407a9e16e4dc75034d10baef6be1'
status={'running':'waiting_for_serial_current_regression','complete':False,'finished':[],'production_changed':False}
path=base/'queue-status.json';path.write_text(json.dumps(status,indent=2)+'\n');deadline=time.time()+18000
while True:
 assert time.time()<deadline and build.read_bytes()==saved
 marker=previous/'after-local-status.json'
 if marker.exists() and json.loads(marker.read_text()).get('complete'):break
 time.sleep(3)
for name in ('capture-original.py','compare-baseline8.py'):
 assert build.read_bytes()==saved
 status['running']=name;path.write_text(json.dumps(status,indent=2)+'\n')
 with (base/(name+'.driver.log')).open('w') as log:
  code=subprocess.run([sys.executable,str(base/name)],stdout=log,stderr=subprocess.STDOUT,timeout=7200).returncode
 status['finished'].append({'name':name,'exit':code});path.write_text(json.dumps(status,indent=2)+'\n')
 print(name,code,flush=True);assert code==0
status.update(complete=True,running=None);path.write_text(json.dumps(status,indent=2)+'\n')
