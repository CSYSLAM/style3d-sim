"""Use the existing grouped-PCG GPU certificate primitive only after the device is idle."""
import json
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'certificate-status.json'
assert not OUTPUT.exists()
status = {'complete': False, 'GPU_waits': []}
while True:
    live = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
    status['GPU_waits'].append({'compute_apps': live, 'epoch': time.time()})
    OUTPUT.write_text(json.dumps(status, indent=2) + '\n')
    if not live:
        break
    time.sleep(5)
command = [sys.executable, '-m', 'reconstruction.csrc.pcg_grouped_atomic_certificate',
           '--capture', str(BASE / 'certificate-inputs'), '--launch', '000014-23precondition_and_reduce',
           '--output', str(BASE / 'GPU-certificates')]
(BASE / 'certificate.command.json').write_text(json.dumps(command, indent=2) + '\n')
with (BASE / 'certificate.log').open('w') as log:
    child = subprocess.Popen(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    code = child.wait()
status.update(complete=True, pid=child.pid, actual_exit=code)
OUTPUT.write_text(json.dumps(status, indent=2) + '\n')
print('First cable PCG GPU certificates actual exit', code, flush=True)
raise SystemExit(code)
