"""Admit all four declared cloth seed cases serially and preserve actual child exits and frozen dependencies."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

target = BASE / 'cloth-native-isolation.status.json'
assert not target.exists()
prepared = json.loads((BASE / 'cloth-native-inputs-v2/plan.json').read_text())
assert prepared['planned_actual_SDK_PTX_source_calls'] == 1005384
plan = json.loads((BASE / 'plan.json').read_text())
previous = BASE.parent / 'continuation-20261102-f07b35a4-h1-first-cg'
manifest = json.loads((previous / 'completion-manifest.json').read_text())
helper = previous / 'membrane-complete-word-check.ptx'
assert hashlib.sha256(helper.read_bytes()).hexdigest() == manifest['files'][str(helper.relative_to(ROOT))]['sha256']
hashes = {**plan['input_sha256'], **prepared['input_sha256']}
paths = [Path(__file__), BASE / 'isolate-cloth-native.py', BASE / 'cloth-native-inputs-v2/plan.json', helper,
         BASE / 'replay-independent-cpu-audit.json', BASE / 'producer-operands-independent-cpu.json']
paths.extend(Path(chunk['file']) for case in prepared['cases'] for chunk in case['chunks'])
for path in paths:
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
(BASE / 'cloth-native-isolation-plan.json').write_text(json.dumps({'input_sha256': hashes,
    'case_tags': [case['tag'] for case in prepared['cases']], 'actual_calls_planned': 1005384,
    'SDK_original_PTX_actual_f07_all_isolated': True, 'both_real_endpoint_RHS_seeds_used': True,
    'full_comparator_negative_controls_use_actual_complete_CPU_readback': True,
    'fixed_C8_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}


def dump():
    target.write_text(json.dumps(status, indent=2) + '\n')


dump()
for case in prepared['cases']:
    for name, expected in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    free = int(subprocess.check_output(
        ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
    apps = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
    status['GPU_admission'].append({'tag': case['tag'], 'UTC': datetime.now(timezone.utc).isoformat(),
                                   'free_memory_MiB': free, 'compute_apps': apps})
    assert free >= 4096
    command = [sys.executable, '-B', str(BASE / 'isolate-cloth-native.py'), '--case', case['tag']]
    (BASE / (case['tag'] + '-native.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (BASE / (case['tag'] + '-native.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1'},
                                   stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'tag': case['tag'], 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'tag': case['tag'], 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    print(case['tag'], 'actual native isolation child exit', code, flush=True)
    if code:
        raise SystemExit(code)
status['complete'] = True
dump()
