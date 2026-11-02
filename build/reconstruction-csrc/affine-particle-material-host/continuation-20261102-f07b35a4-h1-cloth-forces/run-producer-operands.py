"""Run one bounded operand recorder after checking all current packet and image inputs; preserve its actual terminal code."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

status_path = BASE / 'producer-operands.status.json'
assert not status_path.exists()
script = BASE / 'producer-operands.py'
capture = BASE
plan = json.loads((capture / 'plan.json').read_text())
hashes = dict(plan['input_sha256'])
for path in [Path(__file__), script, capture / 'plan.json', capture / 'replay-independent-cpu-audit.json'] + list(
        capture.glob('*/trace/*-packets/frame-00.npz')):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
(BASE / 'producer-operands-plan.json').write_text(json.dumps({'input_sha256': hashes, 'actual_probe_calls': 8,
    'normal_demo_source_processes_do_not_load_SDK': True, 'this_is_explicit_operand_diagnostic': True,
    'SDK_native_aggregate_calls_already_performed': 6, 'original_and_source_PTX_operand_probes': True,
    'every_launched_thread_count_recorded_and_trace_stores_bounded': True,
    'fixed_C8_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
free = int(subprocess.check_output(
    ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
apps = subprocess.check_output(
    ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
status = {'complete': False, 'running': None, 'completed': [],
          'GPU_admission': [{'UTC': datetime.now(timezone.utc).isoformat(),
                             'free_memory_MiB': free, 'compute_apps': apps}], 'whole_solver_complete': False}
assert free >= 4096
command = [sys.executable, '-B', str(script)]
(BASE / 'producer-operands.command.json').write_text(json.dumps(command, indent=2) + '\n')
with (BASE / 'producer-operands.log').open('w') as log:
    process = subprocess.Popen(command, cwd=ROOT, env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1'},
                               stdout=log, stderr=subprocess.STDOUT)
    status['running'] = {'pid': process.pid}
    status_path.write_text(json.dumps(status, indent=2) + '\n')
    code = process.wait()
status['complete'] = True
status['running'] = None
status['completed'].append({'pid': process.pid, 'actual_exit': code})
status_path.write_text(json.dumps(status, indent=2) + '\n')
print('Full producer operand GPU diagnostic actual exit', code, flush=True)
raise SystemExit(code)
