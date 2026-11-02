"""Run the fixed first cable CG replay on an idle GPU, then audit all saved data on CPU."""
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
status = {'complete': False, 'completed': [], 'GPU_waits': [], 'whole_solver_complete': False}
output = BASE / 'operator-status-v2.json'
assert not output.exists()


def save():
    output.write_text(json.dumps(status, indent=2) + '\n')


while True:
    live = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
    status['GPU_waits'].append({'compute_apps': live, 'epoch': time.time()})
    save()
    if not live:
        break
    time.sleep(5)
for label, script, arguments in [('three-backend-GPU', 'replay-engine-as-run.py', [str(BASE)]),
                                  ('independent-CPU', 'audit-replays.py', [])]:
    command = [sys.executable, str(BASE / script), *arguments]
    (BASE / (label + '-v2.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (BASE / (label + '-v2.log')).open('w') as log:
        environment = dict(os.environ)
        environment['PYTHONPATH'] = str(ROOT)
        process = subprocess.Popen(command, cwd=ROOT, env=environment, stdout=log, stderr=subprocess.STDOUT)
        code = process.wait()
    status['completed'].append({'label': label, 'pid': process.pid, 'actual_exit': code})
    save()
    print(label, 'actual exit', code, flush=True)
    if label == 'three-backend-GPU':
        result = json.loads((BASE / 'full-input-replays/report.json').read_text())
        assert result['complete'] and result['error'] is None and result['actual_calls'] == 30
        assert code == int(result['strict_packets'] != 10)
    else:
        assert code == 0
status['complete'] = True
status['strict_packets'] = result['strict_packets']
status['fixed_failures_reclassified'] = False
save()
raise SystemExit(int(result['strict_packets'] != 10))
