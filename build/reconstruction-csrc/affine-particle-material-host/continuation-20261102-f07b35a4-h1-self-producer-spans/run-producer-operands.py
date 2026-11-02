"""Admit one real self-contact GPU recorder after pinning every actual input and the diagnostic instrumenter."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

target = BASE / 'producer-operands.status.json'
assert not target.exists()
capture = BASE / 'full-inputs'
plan = json.loads((capture / 'plan.json').read_text())
hashes = dict(plan['input_sha256'])
paths = [Path(__file__), BASE / 'producer-operands.py', capture / 'replay-independent-cpu-audit.json',
         ROOT / 'reconstruction/csrc/self_contact_operand_trace.py']
paths.extend(capture.glob('*/trace/*-packets/frame-00.npz'))
for path in paths:
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
(BASE / 'producer-operands-plan.json').write_text(json.dumps({'input_sha256': hashes, 'actual_probe_calls_planned': 16,
    'F32_capacity_producers': 1152, 'F32_capacity_tangent': 128, 'append_capacity': 32,
    'original_atomics_not_modified': True, 'whole_solver_complete': False}, indent=2) + '\n')
free = int(subprocess.check_output(
    ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
apps = subprocess.check_output(
    ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
assert free >= 4096
status = {'complete': False, 'running': None, 'completed': [],
          'GPU_admission': [{'UTC': datetime.now(timezone.utc).isoformat(), 'free_memory_MiB': free, 'compute_apps': apps}],
          'whole_solver_complete': False}
command = [sys.executable, '-B', str(BASE / 'producer-operands.py')]
(BASE / 'producer-operands.command.json').write_text(json.dumps(command, indent=2) + '\n')
with (BASE / 'producer-operands.log').open('w') as log:
    process = subprocess.Popen(command, cwd=ROOT, env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1'},
                               stdout=log, stderr=subprocess.STDOUT)
    status['running'] = {'pid': process.pid}
    target.write_text(json.dumps(status, indent=2) + '\n')
    code = process.wait()
status['complete'], status['running'] = True, None
status['completed'].append({'pid': process.pid, 'actual_exit': code})
target.write_text(json.dumps(status, indent=2) + '\n')
print('Actual self F32/contact GPU recorder exit:', code, flush=True)
raise SystemExit(code)
