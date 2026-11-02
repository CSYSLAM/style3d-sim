"""Freeze the first cable bend source and original, then collect the fixed 8-original/3-source per-step cohort."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
import numpy as np
from reconstruction.demo_ab import compare, spread_report

OUTPUT = BASE / 'cohort8'
OUTPUT.mkdir(exist_ok=False)
initial = json.loads((BASE / 'status.json').read_text())
assert initial['complete'] and len(initial['completed']) == 4
assert all(row['actual_exit'] == 0 for row in initial['completed'])
hashes = dict(initial['input_sha256'])
for mode in ('synreal', 'pd'):
    for side in ('original', 'source'):
        for extension in ('npz', 'runtime.json', 'log'):
            path = BASE / mode / (side + '.' + extension)
            hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path in (BASE / 'status.json', Path(__file__), ROOT / 'reconstruction/demo_ab.py'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
plan = {'frames': 60, 'substeps': 600, 'original_runs': 8, 'source_runs': 3, 'modes': ['synreal', 'pd'],
        'original0_and_source0_reused_without_replacement': True, 'input_sha256': hashes,
        'criterion': 'All 600 substeps of every array must lie within fixed-original leave-one-out spread',
        'production_changed': False, 'full_settling_test_run': False, 'whole_solver_complete': False}
(OUTPUT / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
status = {'complete': False, 'completed': [], 'GPU_waits': []}
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
       and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
env.update({'PYTHONPATH': str(ROOT), 'PYTHONDONTWRITEBYTECODE': '1'})


def save():
    (OUTPUT / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


def verify():
    for name, expected in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name


save()
results = {}
for mode in plan['modes']:
    directory = OUTPUT / mode
    directory.mkdir(exist_ok=False)
    paths = {'original': [BASE / mode / 'original.npz'], 'source': [BASE / mode / 'source.npz']}
    for side, runs in (('original', 8), ('source', 3)):
        for number in range(1, runs):
            verify()
            while True:
                live = subprocess.check_output(
                    ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
                status['GPU_waits'].append({'mode': mode, 'backend': side, 'run': number,
                                            'compute_apps': live, 'epoch': time.time()})
                save()
                if not live:
                    break
                time.sleep(5)
            tag = side + str(number)
            command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', side, '--tag', tag,
                       '--example', str(ROOT / 'examples/cable/example_cable_bend_stiffness.py'),
                       '--frames', '60', '--output', str(directory), '--', '--solver', mode]
            (directory / (tag + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
            with (directory / (tag + '.log')).open('w') as log:
                child = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
                code = child.wait()
            status['completed'].append({'mode': mode, 'backend': side, 'run': number,
                                        'pid': child.pid, 'actual_exit': code})
            save()
            assert code == 0 and (directory / (tag + '.npz')).exists()
            paths[side].append(directory / (tag + '.npz'))
            print('Fixed C8', mode, tag, 'actual exit', code, flush=True)
    originals = [np.load(path, allow_pickle=False) for path in paths['original']]
    sources = [np.load(path, allow_pickle=False) for path in paths['source']]
    rows = []
    try:
        for number, source in enumerate(sources):
            strict = compare(originals[0], source)
            stats = spread_report(originals, [source], checkpoints=600)
            assert set(stats) == set(source.files) == {'particle_q', 'particle_qd', 'body_q', 'body_qd'}
            assert all(len(source[key]) == 600 for key in source.files)
            outside = [key for key, value in stats.items() if value['substeps_within_spread'] != 600]
            rows.append({'source': number, 'strict': strict, 'spread': stats,
                         'outside': outside, 'all_steps_within_C8': not outside})
    finally:
        for handle in originals + sources:
            handle.close()
    results[mode] = {'paths': {side: [str(p) for p in ps] for side, ps in paths.items()},
                     'sources': rows, 'all_three_sources_within_C8': all(row['all_steps_within_C8'] for row in rows)}
    verify()
report = {'modes': results, 'original0_and_source0_replaced': False,
          'all_modes_passed': all(row['all_three_sources_within_C8'] for row in results.values()),
          'full_settling_test_run': False, 'production_changed': False, 'whole_solver_complete': False}
(OUTPUT / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
status['complete'] = True
save()
print('Fixed cable bend C8:', {mode: [r['all_steps_within_C8'] for r in value['sources']]
                                  for mode, value in results.items()}, flush=True)
