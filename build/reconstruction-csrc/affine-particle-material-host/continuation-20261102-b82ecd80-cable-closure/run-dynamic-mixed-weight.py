"""Serial fixed mixed-constraint and complete existing cable penalty matrices for the unchanged b82 candidate."""
import argparse
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
from reconstruction.csrc.audit_cudahook import compare as compare_launches, schemas
from reconstruction.demo_ab import compare

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--stage', choices=('mixed-short', 'penalty30'), required=True)
args = parser.parse_args()
candidate_path = BASE / 'candidate-weight-order/build.json'
candidate = json.loads(candidate_path.read_text())
assert candidate['image_sha256'] == 'd09d4be940335764a1e1e7d2f4978366c47e96caf20a3b556d3ac6cfe79e5c68'
output = BASE / 'dynamic-mixed-short-weight'
output.mkdir(exist_ok=False)
frames = 3 if args.stage == 'mixed-short' else 30
fixture = ROOT / 'reconstruction/csrc' / (
    'cable_body_mixed_dynamic_scene.py' if args.stage == 'mixed-short' else 'cable_host_scene.py')
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
cases = []
if args.stage == 'mixed-short':
    for constraint in ('spring-distance', 'point-line-distance'):
        for worlds in (1, 3):
            for mode in ('newton', 'pd'):
                for block in (False, True):
                    extra = ['--constraint', constraint, '--worlds', str(worlds), '--mode', mode]
                    if block:
                        extra += ['--body-block']
                    cases.append({'name': f'{constraint}-w{worlds}-{mode}-b{int(block)}',
                                  'worlds': worlds, 'constraint': constraint, 'extra': extra})
else:
    for mode in ('newton', 'pd'):
        for linear, angular, gamma, actions in ((0, 0, .93, False), (150, 0, .93, False),
                                               (150, 150, .93, True), (150, 150, 1., True)):
            for seed in (1, 2, 3):
                for block in (False, True):
                    extra = ['--mode', mode, '--seed', str(seed), '--worlds', str(seed), '--linear-beta', str(linear),
                             '--angular-beta', str(angular), '--gamma', str(gamma)]
                    if actions:
                        extra += ['--penalty-actions']
                    if block:
                        extra += ['--body-block']
                    name = f'{mode}-s{seed}-w{seed}-b{linear}-{angular}-g{gamma}-a{int(actions)}-block{int(block)}'
                    cases.append({'name': name, 'worlds': seed, 'actions': actions, 'extra': extra})
hashes = dict(candidate['input_sha256'])
hashes.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in
               (Path(__file__), candidate_path, fixture, hook, ROOT / 'reconstruction/csrc/candidate_demo_worker.py')})
hashes[candidate['image']] = candidate['image_sha256']
plan = {'cases': cases, 'frames': frames, 'stage': args.stage, 'input_sha256': hashes,
        'source_image_sha256': candidate['image_sha256'], 'own_GPU_workers_serial': True,
        'external_apps_allowed': True, 'production_modified': False, 'whole_solver_complete': False}
(output / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
layout = schemas()[0]
reports = []
for case in cases:
    group = output / case['name']
    for backend in ('original', 'source'):
        for path, expected in hashes.items():
            assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
        free = int(subprocess.check_output(
            ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
        apps = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
        status['GPU_admission'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'case': case['name'],
                                        'backend': backend, 'free_memory_MiB': free, 'compute_apps': apps})
        assert free >= 4096
        folder = group / backend
        folder.mkdir(parents=True, exist_ok=False)
        actual = folder / 'actual'
        command = [sys.executable, '-B', '-m', 'reconstruction.csrc.candidate_demo_worker', '--backend', backend,
                   '--candidate-build', str(candidate_path), '--example', str(fixture), '--frames', str(frames),
                   '--output', str(actual), '--', *case['extra']]
        (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        environment = {**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1', 'CABLE_PROBE_DIR': str(actual)}
        if args.stage == 'mixed-short':
            token, index = ('26evaluate_body_spring_force', 12) if case['constraint'] == 'spring-distance' else (
                '30evaluate_body_point_line_force', 14)
            size = 8 * case['worlds'] * 12
            fields = f'{token}={index}:{size};39evaluate_body_distance_constraint_force=11:{size};evaluate_cables=5:{size}'
            environment.update({'LD_PRELOAD': str(hook), 'CUDAHOOK_DIR': str(folder), 'CUDAHOOK_DUMP': fields,
                                'CUDAHOOK_DUMP_LIMIT': '1', 'DEMO_POINTERS': '1'})
        with (folder / 'run.log').open('w') as log:
            process = subprocess.Popen(command, cwd=ROOT, env=environment, stdout=log, stderr=subprocess.STDOUT)
            status['running'] = {'case': case['name'], 'backend': backend, 'pid': process.pid}
            dump()
            code = process.wait()
        terminal = {'case': case['name'], 'backend': backend, 'pid': process.pid, 'actual_exit': code}
        status['completed'].append(terminal)
        status['running'] = None
        dump()
        print(case['name'], backend, 'actual exit', code, flush=True)
    workers = status['completed'][-2:]
    row = {'case': case['name'], 'both_actual_exits': [value['actual_exit'] for value in workers], 'passed': False}
    if all(value['actual_exit'] == 0 for value in workers):
        with np.load(group / 'original/actual/capture.npz', allow_pickle=False) as old, \
                np.load(group / 'source/actual/capture.npz', allow_pickle=False) as new:
            row['states'] = compare(old, new)
        if args.stage == 'mixed-short':
            row['metadata'] = compare_launches(group / 'original/launches.txt', group / 'source/launches.txt', layout)
            fields = sorted(path.name for path in (group / 'original').glob('dump_*.bin'))
            assert len(fields) == 6
            row['force_buffers'] = {name: (group / 'original' / name).read_bytes() ==
                                  (group / 'source' / name).read_bytes() for name in fields}
            counts = json.loads((group / 'source/actual/capture.launches.json').read_text())
            row['owned_coverage'] = sum(counts.values()) == row['metadata']['right_launches']
            row['passed'] = (row['states']['bitwise'] and row['metadata']['equal'] and row['owned_coverage'] and
                             all(row['force_buffers'].values()))
        else:
            row['penalties'] = {}
            if case['actions']:
                with np.load(group / 'original/actual/penalties.npz', allow_pickle=False) as old, \
                        np.load(group / 'source/actual/penalties.npz', allow_pickle=False) as new:
                    assert set(old.files) == set(new.files)
                    row['penalties'] = {key: old[key].tobytes() == new[key].tobytes() for key in old.files}
            row['passed'] = row['states']['bitwise'] and all(row['penalties'].values())
    reports.append(row)
    (output / 'report.json').write_text(json.dumps({'cases': reports, 'source_image_sha256': candidate['image_sha256'],
        'production_modified': False, 'whole_solver_complete': False}, indent=2) + '\n')
    print('Case strict', row['passed'], flush=True)
status['complete'] = True
dump()
print(args.stage, 'complete;', sum(row['passed'] for row in reports), '/', len(reports), 'strict', flush=True)
raise SystemExit(int(not all(row['passed'] for row in reports)))
