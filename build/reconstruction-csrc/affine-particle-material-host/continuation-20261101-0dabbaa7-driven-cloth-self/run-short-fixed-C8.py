"""Keep both first strict failures and compare exactly eight SDK/three candidate samples per failed short case."""
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import time

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.demo_ab import spread_report

first = json.loads((BASE / 'force-order-captures/report.json').read_text())['cases']
assert len(first) == 12 and all(row['actual_exit'] == 0 and row['metadata']['equal'] for row in first)
failed = [row['case'] for row in first if not row['state']['bitwise']]
assert len(failed) == 2
discovery = json.loads((BASE / 'discovery/plan.json').read_text())
cases = [case for case in discovery['cases'] if case['name'] in failed]
build_path = BASE / 'candidate-force-order/build.json'
build = json.loads(build_path.read_text())
output = BASE / 'short-fixed-C8'
output.mkdir(exist_ok=False)
hashes = {**discovery['input_sha256'], **build['input_sha256']}
for path in (Path(__file__), build_path, BASE / 'force-order-captures/report.json', Path(build['image'])):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
for case in cases:
    folder = output / 'cohorts' / case['name']
    folder.mkdir(parents=True)
    for backend, origin in (('original', BASE / 'discovery' / case['name'] / 'original'),
                             ('source', BASE / 'force-order-captures' / case['name'])):
        for name in ('capture.npz', 'capture.runtime.json', 'wrapper-provenance.json'):
            path = origin / name
            hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        shutil.copyfile(origin / 'capture.npz', folder / (backend + '0.npz'))
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'cases': cases,
    'SDK_runs_per_case': 8, 'source_runs_per_case': 3, 'first_failed_source0_copied_byte_for_byte': True,
    'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': []}
rows = []
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
       and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
for case in cases:
    for backend, index in [('original', i) for i in range(1, 8)] + [('source', i) for i in (1, 2)]:
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
        folder = output / 'workers' / case['name'] / (backend + str(index))
        folder.mkdir(parents=True)
        n = 16 * case['worlds']
        fields = {'22accumulate_vertex_face': {11: n * 12, 12: n * 36, 14: 4},
                  '20accumulate_edge_edge': {9: n * 12, 10: n * 36, 12: 4},
                  '20accumulate_edge_face': {10: n * 12, 11: n * 36, 13: 4}}
        specification = ';'.join(name + '=' + ','.join(f'{i}:{size}' for i, size in values.items())
                                 for name, values in fields.items())
        command = [sys.executable, str(BASE / 'worker.py'), '--backend', backend, '--output', str(folder), '--frames', '3']
        if backend == 'source':
            command.extend(['--candidate-build', str(build_path)])
        command.extend(['--', *case['extra']])
        (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        with (folder / 'run.log').open('w') as log:
            worker = subprocess.Popen(command, cwd=ROOT, env={**env, 'LD_PRELOAD': str(hook),
                'CUDAHOOK_DIR': str(folder), 'CUDAHOOK_DUMP': specification, 'CUDAHOOK_DUMP_LIMIT': '1',
                'DRIVEN_SELF_LAYOUT_OUTPUT': str(folder / 'layout.json')}, stdout=log, stderr=subprocess.STDOUT)
            status['running'] = {'case': case['name'], 'backend': backend, 'index': index, 'pid': worker.pid}
            dump()
            code = worker.wait()
        status['completed'].append({**status['running'], 'actual_exit': code})
        status['running'] = None
        dump()
        assert code == 0
        provenance = json.loads((folder / 'wrapper-provenance.json').read_text())
        assert provenance['complete'] and provenance['original_SDK_mapped'] == (backend == 'original')
        shutil.copyfile(folder / 'capture.npz', output / 'cohorts' / case['name'] / (backend + str(index) + '.npz'))
    cohort = output / 'cohorts' / case['name']
    originals = [np.load(cohort / f'original{i}.npz', allow_pickle=False) for i in range(8)]
    sources = [np.load(cohort / f'source{i}.npz', allow_pickle=False) for i in range(3)]
    try:
        statistics = [spread_report(originals, [source]) for source in sources]
        passed = [all(field['substeps_within_spread'] == 3 for field in stat.values()) for stat in statistics]
        rows.append({'case': case['name'], 'statistics': statistics, 'sources_within_C8': passed,
                     'all3_sources_within_C8': all(passed), 'first_failed_source0_replaced': False})
    finally:
        for data in originals + sources:
            data.close()
    (output / 'report.json').write_text(json.dumps({'cases': rows, 'whole_solver_complete': False}, indent=2) + '\n')
    print(case['name'], 'fixed C8', passed, flush=True)
status['complete'] = True
dump()
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
raise SystemExit(int(not all(row['all3_sources_within_C8'] for row in rows)))
