"""Wait for the observed foreign GPU job to finish, then run this phase's captures exactly once."""
from datetime import datetime, timezone
import json
from pathlib import Path
import subprocess
import sys
import time

base = Path(__file__).resolve().parent
status_path = base / 'GPU-queue-status.json'
assert not status_path.exists(), 'An existing queue must be resumed by its actual live handle, never relaunched.'
while True:
    result = subprocess.run(['nvidia-smi', '--query-compute-apps=pid,process_name,used_gpu_memory',
                             '--format=csv,noheader'], text=True, capture_output=True)
    assert result.returncode == 0, result.stderr
    rows = [line for line in result.stdout.splitlines() if line.strip()]
    record = {'UTC': datetime.now(timezone.utc).isoformat(), 'compute_processes': rows,
              'state': 'waiting_for_existing_GPU_job' if rows else 'GPU_available',
              'capture_started': False, 'whole_solver_complete': False}
    with (base / 'GPU-wait-observations.jsonl').open('a') as stream:
        stream.write(json.dumps(record) + '\n')
    status_path.write_text(json.dumps(record, indent=2) + '\n')
    if not rows:
        break
    time.sleep(10)
command = [sys.executable, str(base / 'run-captures.py')]
record.update(state='capturing', capture_started=True, command=command)
status_path.write_text(json.dumps(record, indent=2) + '\n')
code = subprocess.run(command, cwd=Path.cwd()).returncode
record.update(state='terminal', exit_code=code)
status_path.write_text(json.dumps(record, indent=2) + '\n')
assert code == 0, code
