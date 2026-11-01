"""Continue the existing capture after its verified driver finishes; never restart or replace that capture."""
from datetime import datetime, timezone
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
receipt = json.loads((BASE / 'capture-driver-receipt.json').read_text())
status_path = BASE / 'pipeline-status.json'
assert not status_path.exists()
status = {'complete': False, 'capture_driver_receipt': receipt, 'running': None, 'completed': [],
          'waits': [], 'GPU_waits': [], 'production_changed': False, 'whole_solver_complete': False}
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and key not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}


def dump():
    status_path.write_text(json.dumps(status, indent=2) + '\n')


def same_live_capture_driver():
    base = Path('/proc') / str(receipt['driver_pid'])
    try:
        current = (base / 'stat').read_text().split(') ', 1)[1].split()
        command = (base / 'cmdline').read_bytes().replace(b'\0', b' ').decode()
        boot_id = Path('/proc/sys/kernel/random/boot_id').read_text().strip()
        return (boot_id == receipt['boot_id'] and int(current[19]) == receipt['start_ticks'] and
                current[0] != 'Z' and 'pd-tangent-full/run-tangent.py' in command)
    except (FileNotFoundError, ProcessLookupError):
        return False


dump()
while True:
    live = same_live_capture_driver()
    try:
        capture = json.loads((BASE / 'tangent-captures/status.json').read_text())
    except (OSError, json.JSONDecodeError):
        # A running writer may be between truncate and write; this is not an exit or restart signal.
        if not live:
            raise
        capture = None
    if not live:
        assert capture is not None and capture['complete'], 'Existing driver ended without a complete capture; inspect it'
        assert len(capture['completed']) == 4 and all(r['actual_exit'] == 0 for r in capture['completed'])
        break
    status['waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'verified_capture_driver_live': True,
                            'completed_workers': len(capture['completed']) if capture is not None else None})
    dump()
    time.sleep(5)


def run(label, command, allowed=(0,)):
    (BASE / (label + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (BASE / (label + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'label': label, 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'label': label, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    assert code in allowed, (label, code)


run('compare-graphs', [sys.executable, str(BASE / 'compare-graphs.py')])
run('CPU-audit', [sys.executable, str(BASE / 'run-audit.py')])
run('CPU-flow', [sys.executable, str(BASE / 'audit-flow.py')])
run('prepare-replays', [sys.executable, '-m', 'reconstruction.csrc.pd_contact_full_replay', '--phase', str(BASE), '--prepare'])
while True:
    live = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
    status['GPU_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': live})
    dump()
    if not live:
        break
    time.sleep(5)
run('execute-replays', [sys.executable, '-m', 'reconstruction.csrc.pd_contact_full_replay', '--phase', str(BASE), '--execute'],
    allowed=(0, 1))
replays = json.loads((BASE / 'full-input-replays/report.json').read_text())
assert replays['complete'] and replays['actual_calls'] == 6336
run('CPU-replay-audit', [sys.executable, str(BASE / 'audit-replays.py')])
status['complete'] = True
status['unmodified_strict_packets'] = replays['strict_packets']
status['needs_atomic_or_math_resolution'] = replays['strict_packets'] != 2112
dump()
print('Existing capture and follow-up pipeline terminal;strict packets', replays['strict_packets'], '/2112', flush=True)
