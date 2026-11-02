"""Run three independent SDK controls for each failed self case without extending the fixed eight references."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.demo_ab import spread_report

cohort = BASE / 'short-fixed-C8'
plan = json.loads((cohort / 'plan.json').read_text())
status0 = json.loads((cohort / 'status.json').read_text())
assert status0['complete'] and status0['running'] is None
assert len(plan['cases']) == 2
output = BASE / 'sdk-heldout3'
output.mkdir(exist_ok=False)
hashes = dict(plan['input_sha256'])
for path in (Path(__file__), BASE / 'worker.py', cohort / 'plan.json', cohort / 'report.json'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'cases': plan['cases'],
    'controls_per_case': 3, 'frames': 3, 'fixed_SDK_references': 8, 'same_hook_and_fields_as_source': True,
    'controls_added_to_reference': False, 'source_failures_rejudged': False,
    'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
rows = []


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
for case in plan['cases']:
    for index in range(3):
        for name, expected in hashes.items():
            assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
        free = int(subprocess.check_output(
            ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
        apps = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
        status['GPU_admission'].append({'case': case['name'], 'control': index, 'free_memory_MiB': free,
                                       'compute_apps': apps, 'UTC': datetime.now(timezone.utc).isoformat()})
        assert free >= 4096
        folder = output / case['name'] / f'control{index}'
        folder.mkdir(parents=True)
        n = 16 * case['worlds']
        fields = {'22accumulate_vertex_face': {11: n * 12, 12: n * 36, 14: 4},
                  '20accumulate_edge_edge': {9: n * 12, 10: n * 36, 12: 4},
                  '20accumulate_edge_face': {10: n * 12, 11: n * 36, 13: 4}}
        specification = ';'.join(name + '=' + ','.join(f'{i}:{size}' for i, size in values.items())
                                 for name, values in fields.items())
        command = [sys.executable, '-B', str(BASE / 'worker.py'), '--backend', 'original', '--frames', '3',
                   '--output', str(folder), '--', *case['extra']]
        (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        env = {**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1', 'LD_PRELOAD': str(hook),
               'CUDAHOOK_DIR': str(folder), 'CUDAHOOK_DUMP': specification, 'CUDAHOOK_DUMP_LIMIT': '1',
               'DRIVEN_SELF_LAYOUT_OUTPUT': str(folder / 'layout.json')}
        with (folder / 'run.log').open('w') as log:
            process = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
            status['running'] = {'case': case['name'], 'control': index, 'pid': process.pid}
            dump()
            code = process.wait()
        status['completed'].append({**status['running'], 'actual_exit': code})
        status['running'] = None
        dump()
        assert code == 0
        runtime = json.loads((folder / 'capture.runtime.json').read_text())
        assert runtime['image_sha256'] == '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
        assert json.loads((folder / 'wrapper-provenance.json').read_text())['original_SDK_mapped']
        print(case['name'], 'SDK control', index, 'actual exit0', flush=True)
    originals = [np.load(cohort / 'cohorts' / case['name'] / f'original{i}.npz') for i in range(8)]
    controls = [np.load(output / case['name'] / f'control{i}/capture.npz') for i in range(3)]
    try:
        statistics = [spread_report(originals, [control]) for control in controls]
        passed = [all(v['substeps_within_spread'] == 3 for v in fields.values()) for fields in statistics]
        rows.append({'case': case['name'], 'statistics': statistics, 'controls_within_C8': passed})
    finally:
        for data in originals + controls:
            data.close()
status['complete'] = True
dump()
(output / 'report.json').write_text(json.dumps({'cases': rows, 'controls_added_to_reference': False,
    'source_failures_rejudged': False, 'whole_solver_complete': False}, indent=2) + '\n')
print('SDK controls, fixed C8:', [(row['case'], row['controls_within_C8']) for row in rows], flush=True)
