"""Measure held-out original runs against the unchanged fixed C8 cohort without reclassifying source failures."""
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
from reconstruction.demo_ab import spread_report

OUTPUT = BASE / 'native-controls'
OUTPUT.mkdir(exist_ok=False)
cohort = json.loads((BASE / 'cohort8/report.json').read_text())
audit = json.loads((BASE / 'cohort8/independent-cpu.json').read_text())
assert not cohort['all_modes_passed'] and not audit['all_modes_C8_passed']
hashes = dict(audit['input_sha256'])
for name in [Path(__file__), BASE / 'cohort8/independent-cpu.json']:
    hashes[str(name.resolve())] = hashlib.sha256(name.read_bytes()).hexdigest()
plan = {'held_out_original_runs_per_mode': 3, 'original_cohort_paths':
        {mode: item['paths']['original'] for mode, item in cohort['modes'].items()},
        'frames': 60, 'input_sha256': hashes, 'fixed_original_samples_replaced': False,
        'source_failures_reclassified': False, 'production_changed': False, 'whole_solver_complete': False}
(OUTPUT / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
status = {'complete': False, 'completed': [], 'GPU_waits': []}
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
       and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
env.update({'PYTHONPATH': str(ROOT), 'PYTHONDONTWRITEBYTECODE': '1'})


def save():
    (OUTPUT / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


save()
results = {}
for mode, paths in plan['original_cohort_paths'].items():
    directory = OUTPUT / mode
    directory.mkdir(exist_ok=False)
    rows = []
    for number in range(3):
        for name, expected in hashes.items():
            assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
        while True:
            live = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            status['GPU_waits'].append({'mode': mode, 'run': number, 'compute_apps': live, 'epoch': time.time()})
            save()
            if not live:
                break
            time.sleep(5)
        tag = 'held-out-original' + str(number)
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', 'original', '--tag', tag,
                   '--example', str(ROOT / 'examples/cable/example_cable_bend_stiffness.py'),
                   '--frames', '60', '--output', str(directory), '--', '--solver', mode]
        (directory / (tag + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
        with (directory / (tag + '.log')).open('w') as log:
            child = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
            code = child.wait()
        status['completed'].append({'mode': mode, 'run': number, 'pid': child.pid, 'actual_exit': code})
        save()
        assert code == 0
        originals = [np.load(path, allow_pickle=False) for path in paths]
        candidate_path = directory / (tag + '.npz')
        try:
            with np.load(candidate_path, allow_pickle=False) as candidate:
                stats = spread_report(originals, [candidate], checkpoints=600)
                assert len(candidate['particle_q']) == 600
        finally:
            for handle in originals:
                handle.close()
        outside = [key for key, value in stats.items() if value['substeps_within_spread'] != 600]
        rows.append({'run': number, 'candidate_backend': 'fixed_original_SDK', 'path': str(candidate_path),
                     'spread': stats, 'outside': outside, 'all_steps_within_fixed_C8': not outside})
        print('Held-out original', mode, number, 'actual exit', code, 'within C8', not outside, flush=True)
    results[mode] = rows
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
(OUTPUT / 'report.json').write_text(json.dumps({'modes': results, 'input_sha256': hashes,
    'fixed_original_samples_replaced': False, 'source_failures_reclassified': False,
    'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
status['complete'] = True
save()
print('Held-out SDK control complete;source C8 failures retained', flush=True)
