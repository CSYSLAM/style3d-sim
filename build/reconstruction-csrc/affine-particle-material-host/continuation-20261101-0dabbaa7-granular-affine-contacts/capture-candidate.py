"""Compare one isolated contact candidate with the six already frozen actual SDK runs."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import compare as compare_launches, schemas
from reconstruction.demo_ab import compare

reference = BASE / 'discovery-v2'
plan = json.loads((reference / 'plan.json').read_text())
build_path = BASE / 'candidate-guard-only/build.json'
build = json.loads(build_path.read_text())
worker = BASE / 'candidate-worker.py'
fixture = ROOT / 'reconstruction/csrc/granular_affine_contacts_scene.py'
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
output = BASE / 'candidate-captures'
output.mkdir(exist_ok=False)
hashes = dict(build['input_sha256'])
hashes[str(worker)] = hashlib.sha256(worker.read_bytes()).hexdigest()
hashes[str(fixture)] = plan['input_sha256'][str(fixture)]
hashes[build['image']] = build['image_sha256']
for path in reference.rglob('*'):
    if path.is_file():
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'cases': plan['cases'],
    'candidate_sha256': build['image_sha256'], 'production_changed': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': [], 'whole_solver_complete': False}
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and key not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}
rows = []


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
for case in plan['cases']:
    for name, sha in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == sha, name
    while True:
        live = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        status['GPU_waits'].append(live)
        dump()
        if not live:
            break
        time.sleep(5)
    folder = output / case['label']
    folder.mkdir()
    original = reference / case['label'] / 'original'
    command = [sys.executable, str(worker), '--candidate-build', str(build_path), '--worker', 'source',
               '--tag', 'capture', '--example', str(fixture), '--frames', '3', '--output', str(folder),
               '--', *case['extra']]
    task_env = {**env, 'LD_PRELOAD': str(hook), 'CUDAHOOK_DIR': str(folder), 'CUDAHOOK_DUMP_LIMIT': '1',
                'GRANULAR_AFFINE_MODEL_OUTPUT': str(folder),
                'CUDAHOOK_DUMP': ';'.join(key + '=' + ','.join(str(i) + ':' + str(n) for i, n in fields.items())
                                        for key, fields in case['fields'].items())}
    (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (folder / 'run.log').open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=task_env, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'case': case['label'], 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'case': case['label'], 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    row = {'case': case['label'], 'actual_exit': code, 'strict_passed': False}
    if code == 0:
        runtime = json.loads((folder / 'capture.runtime.json').read_text())
        assert runtime['image_sha256'] == build['image_sha256']
        with np.load(original / 'capture.npz', allow_pickle=False) as old, \
                np.load(folder / 'capture.npz', allow_pickle=False) as new:
            assert all(np.isfinite(data[key]).all() for data in (old, new) for key in data.files)
            states = compare(old, new)
        metadata = compare_launches(original / 'launches.txt', folder / 'launches.txt', schemas()[0])
        buffers = {}
        for token, fields in case['fields'].items():
            for index, size in fields.items():
                for phase in ('pre', 'post'):
                    name = 'dump_' + token + '_' + phase + '_arg' + str(index) + '.bin'
                    if not (original / name).exists():
                        continue
                    data = (original / name).read_bytes()
                    assert len(data) == size
                    buffers[name] = (folder / name).is_file() and data == (folder / name).read_bytes()
        launches = json.loads((folder / 'capture.launches.json').read_text())
        coverage = sum(launches.values()) == metadata['right_launches']
        row.update(states=states, metadata=metadata, buffers=buffers, complete_owned_coverage=coverage,
                   strict_passed=states['bitwise'] and metadata['equal'] and coverage and all(buffers.values()))
    rows.append(row)
    (output / 'report.json').write_text(json.dumps({'cases': rows, 'whole_solver_complete': False}, indent=2) + '\n')
    print(case['label'], code, 'strict', row['strict_passed'], flush=True)
status['complete'] = True
dump()
raise SystemExit(int(not all(row['strict_passed'] for row in rows)))
