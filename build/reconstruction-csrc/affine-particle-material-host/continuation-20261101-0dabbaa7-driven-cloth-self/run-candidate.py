"""Compare the first isolated candidate against the immutable twelve SDK support samples, without resampling."""
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

discovery = BASE / 'discovery'
original_plan = json.loads((discovery / 'plan.json').read_text())
audit = json.loads((BASE / 'discovery-independent-cpu.json').read_text())
build_path = BASE / 'candidate-guard-only/build.json'
build = json.loads(build_path.read_text())
hashes = {**audit['input_sha256'], **build['input_sha256']}
for path in (Path(__file__), build_path, Path(build['image'])):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
output = BASE / 'candidate-captures'
output.mkdir(exist_ok=False)
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'cases': original_plan['cases'],
    'reference_first_samples_unchanged': True, 'candidate_image_sha256': build['image_sha256'],
    'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': [], 'whole_solver_complete': False}
rows = []
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
       and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
    (output / 'report.json').write_text(json.dumps({'cases': rows, 'whole_solver_complete': False}, indent=2) + '\n')


dump()
for case in original_plan['cases']:
    for name, expected in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    while True:
        live = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        if not live:
            break
        status['GPU_waits'].append(live)
        dump()
        time.sleep(5)
    directory = output / case['name']
    directory.mkdir()
    n = 16 * case['worlds']
    fields = {'22accumulate_vertex_face': {11: n * 12, 12: n * 36},
              '20accumulate_edge_edge': {9: n * 12, 10: n * 36},
              '20accumulate_edge_face': {10: n * 12, 11: n * 36}}
    if not case['diagonal']:
        for name, counter in (('22accumulate_vertex_face', 14), ('20accumulate_edge_edge', 12),
                              ('20accumulate_edge_face', 13)):
            fields[name][counter] = 4
    specification = ';'.join(name + '=' + ','.join(f'{i}:{size}' for i, size in values.items())
                             for name, values in fields.items())
    command = [sys.executable, str(BASE / 'worker.py'), '--backend', 'source', '--candidate-build', str(build_path),
               '--output', str(directory), '--frames', '3', '--', *case['extra']]
    (directory / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (directory / 'run.log').open('w') as log:
        worker = subprocess.Popen(command, cwd=ROOT, env={**env, 'LD_PRELOAD': str(hook),
            'CUDAHOOK_DIR': str(directory), 'CUDAHOOK_DUMP': specification, 'CUDAHOOK_DUMP_LIMIT': '1',
            'DRIVEN_SELF_LAYOUT_OUTPUT': str(directory / 'layout.json')}, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'case': case['name'], 'pid': worker.pid}
        dump()
        code = worker.wait()
    status['completed'].append({'case': case['name'], 'pid': worker.pid, 'actual_exit': code})
    status['running'] = None
    row = {'case': case['name'], 'actual_exit': code, 'passed': False}
    if code == 0:
        reference = discovery / case['name'] / 'original'
        runtime = json.loads((directory / 'capture.runtime.json').read_text())
        assert runtime['image_sha256'] == build['image_sha256']
        provenance = json.loads((directory / 'wrapper-provenance.json').read_text())
        assert provenance['complete'] and not provenance['original_SDK_mapped']
        with np.load(reference / 'capture.npz', allow_pickle=False) as old, np.load(
                directory / 'capture.npz', allow_pickle=False) as new:
            row['state'] = compare(old, new)
        row['metadata'] = compare_launches(reference / 'launches.txt', directory / 'launches.txt', schemas()[0])
        counts = json.loads((directory / 'capture.launches.json').read_text())
        row['owned_coverage'] = sum(counts.values()) == row['metadata']['right_launches']
        row['layout_equal'] = (reference / 'layout.json').read_bytes() == (directory / 'layout.json').read_bytes()
        row['buffers'] = {p.name: (directory / p.name).exists() and p.read_bytes() == (directory / p.name).read_bytes()
                          for p in reference.glob('dump_*.bin')}
        row['passed'] = all((row['state']['bitwise'], row['metadata']['equal'], row['owned_coverage'],
                             row['layout_equal'], all(row['buffers'].values())))
    rows.append(row)
    dump()
    print(case['name'], 'actual exit', code, 'passed', row['passed'], flush=True)
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
status['complete'] = True
dump()
print('Candidate actual terminal:', sum(row['passed'] for row in rows), '/12 strict full checks', flush=True)
