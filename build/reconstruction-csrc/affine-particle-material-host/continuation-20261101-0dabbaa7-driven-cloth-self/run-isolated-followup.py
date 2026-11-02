"""Wait for the same verified idle-gated worker, then audit immutable GPU outputs without inferring its exit code."""
import json
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
folder = BASE / 'surface-scalar-certificates-isolated'
identity = json.loads((folder / 'waiter-identity.json').read_text())
status_path = BASE / 'isolated-followup-status.json'
assert not status_path.exists()
status = {'complete': False, 'GPU_worker_identity': identity, 'GPU_actual_exit_observed_by_this_process': None,
          'root_must_observe_GPU_tool_session': 67261, 'running': None, 'completed': [], 'waits': [],
          'source0_failures_reclassified': False, 'whole_solver_complete': False}


def save():
    status_path.write_text(json.dumps(status, indent=2) + '\n')


def live():
    try:
        proc = Path('/proc') / str(identity['pid'])
        stat = (proc / 'stat').read_text().split(') ', 1)[1].split()
        return (Path('/proc/sys/kernel/random/boot_id').read_text().strip() == identity['boot_id'] and
                int(stat[19]) == identity['start_ticks'] and stat[0] != 'Z' and
                'certify-surface-scalars-isolated.py' in (proc / 'cmdline').read_bytes().decode())
    except (FileNotFoundError, ProcessLookupError):
        return False


save()
while live():
    status['waits'].append({'epoch': time.time(), 'same_original_waiter_verified_live': True})
    save()
    time.sleep(5)
report = json.loads((folder / 'report.json').read_text())
assert report['complete'] and report['actual_calls'] == 593
command = [sys.executable, str(BASE / 'audit-surface-scalar-certificates.py'), '--certificates', str(folder)]
with (BASE / 'isolated-followup-cpu.log').open('w') as log:
    process = subprocess.Popen(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    status['running'] = {'label': 'independent-CPU', 'pid': process.pid}
    save()
    code = process.wait()
status['completed'].append({'label': 'independent-CPU', 'pid': process.pid, 'actual_exit': code})
status['running'] = None
save()
assert code == 0
status['complete'] = True
save()
print('Isolated GPU outputs audited;root still must observe actual GPU tool session67261 exit', flush=True)
