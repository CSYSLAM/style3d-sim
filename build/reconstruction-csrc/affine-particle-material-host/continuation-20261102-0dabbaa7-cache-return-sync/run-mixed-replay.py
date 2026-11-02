"""Run one diagnostic worker with shared GPU memory admission and retain its real exit status."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

plan = json.loads((BASE / 'mixed-replay-plan.json').read_text())
checker = BASE / 'mixed-replay.py'
assert hashlib.sha256(checker.read_bytes()).hexdigest() == plan['versioned_checker_sha256']
output = BASE / 'mixed-fenced'
assert not output.exists() and not (BASE / 'mixed-worker-status.json').exists()


def sample():
    memory = subprocess.check_output(
        ['nvidia-smi', '--id=0', '--query-gpu=memory.total,memory.used,memory.free',
         '--format=csv,noheader,nounits'], text=True).strip()
    apps = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
    total, used, free = map(int, memory.split(','))
    return {'UTC': datetime.now(timezone.utc).isoformat(), 'total_MiB': total, 'used_MiB': used,
            'free_MiB': free, 'compute_apps': apps}


first = sample()
assert first['free_MiB'] >= plan['minimum_free_memory_MiB'], first
command = [sys.executable, '-B', str(checker), '--complete', plan['fixed_pair'], '--frozen', plan['fixed_pair'],
           '--trials', str(plan['trials_per_backend']), '--output', str(output)]
(BASE / 'mixed-worker-command.json').write_text(json.dumps(command, indent=2) + '\n')
status = {'command': command, 'memory_samples': [first], 'actual_exit': None, 'GPU_workers_serial': True,
          'external_apps_allowed': True, 'production_modified': False, 'whole_solver_complete': False}
with (BASE / 'mixed-worker.log').open('w') as log:
    process = subprocess.Popen(command, cwd=ROOT, env=clean_env(), stdout=log, stderr=subprocess.STDOUT)
    status['pid'] = process.pid
    while True:
        try:
            code = process.wait(timeout=2)
            break
        except subprocess.TimeoutExpired:
            status['memory_samples'].append(sample())
            (BASE / 'mixed-worker-status.json').write_text(json.dumps(status, indent=2) + '\n')
    status['actual_exit'] = code
    status['memory_samples'].append(sample())
(BASE / 'mixed-worker-status.json').write_text(json.dumps(status, indent=2) + '\n')
print('Single fenced mixed worker actual exit', code, '; minimum sampled free MiB',
      min(row['free_MiB'] for row in status['memory_samples']), flush=True)
raise SystemExit(code)
