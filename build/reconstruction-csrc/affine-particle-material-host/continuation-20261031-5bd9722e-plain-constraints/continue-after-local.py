"""Continue closed local validation with complete regression and standalone tests, then capture next SDK scope."""
import json
from pathlib import Path
import subprocess,sys
base=Path(__file__).resolve().parent
status=json.loads((base/'validation-86916989/status.json').read_text())
assert status['complete'] and all(r['exit']==0 for r in status['finished'])
tasks=[('regression',base/'run-regression.py'),('frontends',base/'run-frontends.py'),
 ('next-undriven-reference',base.parent/'continuation-20261031-86916989-undriven-joints/capture-original.py')]
report=[]
for name,script in tasks:
 with (base/(name+'-driver.log')).open('w') as log:
  code=subprocess.run([sys.executable,'-u',str(script)],stdout=log,stderr=subprocess.STDOUT,timeout=14400).returncode
 report.append({'task':name,'exit':code})
 (base/'next-queue-status.json').write_text(json.dumps(report,indent=2)+'\n')
 print(name,code,flush=True)
 assert code==0
