"""Freeze the actual diagnostic inputs, admit one GPU worker, and retain the real terminal code."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

status_path = BASE / 'membrane-native-isolation.status.json'
assert not status_path.exists()
script = BASE / 'isolate-membrane-native.py'
capture = BASE / 'assembly-full-inputs'
plan = json.loads((capture / 'plan.json').read_text())
prepared = json.loads((BASE / 'membrane-isolation-inputs/plan.json').read_text())
hashes = {**plan['input_sha256'], **prepared['input_sha256']}
paths = [Path(__file__), script, capture / 'plan.json', BASE / 'membrane-isolation-inputs/plan.json',
         BASE / 'membrane-complete-word-check.cu', BASE / 'membrane-complete-word-check.ptx',
         BASE / 'producer-operands-report.json', BASE / 'producer-operands-independent-cpu.json']
paths.extend(Path(row['file']) for row in prepared['chunks'])
for path in paths:
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
(BASE / 'membrane-native-isolation-plan.json').write_text(json.dumps({'input_sha256': hashes,
    'actual_native_PTX_source_calls_planned': 200790,
    'normal_demo_source_processes_do_not_load_SDK': True, 'this_is_explicit_operand_diagnostic': True,
    'all_66930_triangles_native_PTX_source_isolation_planned': True,
    'actual_launch_geometry_and_captured_output_seeds_preserved': True,
    'GPU_full_word_comparator_validated_by_actual_complete_CPU_readback_controls': True,
    'fixed_C8_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
free = int(subprocess.check_output(
    ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
apps = subprocess.check_output(
    ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
status = {'complete': False, 'running': None, 'completed': [],
          'GPU_admission': [{'UTC': datetime.now(timezone.utc).isoformat(),
                             'free_memory_MiB': free, 'compute_apps': apps}], 'whole_solver_complete': False}
assert free >= 4096
command = [sys.executable, '-B', str(script)]
(BASE / 'membrane-native-isolation.command.json').write_text(json.dumps(command, indent=2) + '\n')
with (BASE / 'membrane-native-isolation.log').open('w') as log:
    process = subprocess.Popen(command, cwd=ROOT, env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1'},
                               stdout=log, stderr=subprocess.STDOUT)
    status['running'] = {'pid': process.pid}
    status_path.write_text(json.dumps(status, indent=2) + '\n')
    code = process.wait()
status['complete'] = True
status['running'] = None
status['completed'].append({'pid': process.pid, 'actual_exit': code})
status_path.write_text(json.dumps(status, indent=2) + '\n')
print('Full native SDK/PTX/source triangle isolation actual exit', code, flush=True)
raise SystemExit(code)
