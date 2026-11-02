"""Serially discover and compare cable/constraint combinations using fixed images and recorded memory admission."""
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
parser.add_argument('--stage', choices=('discovery', 'candidate'), required=True)
parser.add_argument('--candidate-build', type=Path)
parser.add_argument('--frames', type=int, default=3)
args = parser.parse_args()
assert args.frames > 0 and (args.stage != 'candidate' or args.candidate_build)
output = BASE / (args.stage + '-cache-order-v2-' + str(args.frames))
output.mkdir(exist_ok=False)
fixture = ROOT / 'reconstruction/csrc/cable_body_constraint_scene.py'
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
build_bytes = build_path.read_bytes()
build = json.loads(build_bytes)
hashes = {str(path): hashlib.sha256(path.read_bytes()).hexdigest()
          for path in (Path(__file__), BASE / 'worker.py', fixture, hook, build_path,
                       ROOT / 'reconstruction/csrc/native/source_solver.cpp')}
if args.candidate_build:
    hashes[str(args.candidate_build)] = hashlib.sha256(args.candidate_build.read_bytes()).hexdigest()
cases = []
for constraint in ('spring', 'point-line', 'distance'):
    for worlds in (1, 3):
        for mode in ('newton', 'pd'):
            for block in (False, True):
                name = f'{constraint}-w{worlds}-{mode}-b{int(block)}'
                extra = ['--constraint', constraint, '--worlds', str(worlds), '--mode', mode]
                if block:
                    extra.append('--body-block')
                cases.append({'name': name, 'constraint': constraint, 'worlds': worlds, 'extra': extra})
plan = {'cases': cases, 'frames': args.frames, 'stage': args.stage, 'input_sha256': hashes,
        'source_sha256': build['extension_sha256'], 'own_GPU_workers_serial': True, 'external_apps_allowed': True,
        'minimum_free_memory_MiB': 4096, 'production_modified': False, 'whole_solver_complete': False}
(output / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
layout = schemas()[0]
for case in cases:
    backends = ('original', 'source') if args.stage == 'discovery' else ('source',)
    for backend in backends:
        for name, expected in hashes.items():
            assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
        assert build_path.read_bytes() == build_bytes
        free = int(subprocess.check_output(
            ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
        apps = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
        admission = {'UTC': datetime.now(timezone.utc).isoformat(), 'case': case['name'], 'backend': backend,
                     'free_memory_MiB': free, 'compute_apps': apps}
        status['GPU_admission'].append(admission)
        dump()
        assert free >= 4096, admission
        folder = output / case['name'] / backend
        folder.mkdir(parents=True, exist_ok=False)
        command = [sys.executable, '-B', str(BASE / 'worker.py'), '--backend', backend, '--output', str(folder),
                   '--frames', str(args.frames)]
        if args.candidate_build:
            command += ['--candidate-build', str(args.candidate_build)]
        command += ['--', *case['extra']]
        (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        token, argument = {'spring': ('26evaluate_body_spring_force', 12),
                           'point-line': ('30evaluate_body_point_line_force', 14),
                           'distance': ('39evaluate_body_distance_constraint_force', 11)}[case['constraint']]
        dump_fields = f'{token}={argument}:{8 * case["worlds"] * 12};evaluate_cables=5:{8 * case["worlds"] * 12}'
        environment = {**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1', 'LD_PRELOAD': str(hook),
                       'CUDAHOOK_DIR': str(folder), 'CUDAHOOK_DUMP': dump_fields, 'CUDAHOOK_DUMP_LIMIT': '1',
                       'DEMO_POINTERS': '1'}
        with (folder / 'run.log').open('w') as log:
            process = subprocess.Popen(command, cwd=ROOT, env=environment, stdout=log, stderr=subprocess.STDOUT)
            status['running'] = {'case': case['name'], 'backend': backend, 'pid': process.pid}
            dump()
            code = process.wait()
        row = {'case': case['name'], 'backend': backend, 'pid': process.pid, 'actual_exit': code}
        provenance = json.loads((folder / 'wrapper-provenance.json').read_text())
        assert provenance['original_SDK_mapped'] == (backend == 'original')
        row['scope_error'] = provenance['error']
        if code == 0:
            with np.load(folder / 'capture.npz', allow_pickle=False) as arrays:
                row['finite'] = all(np.isfinite(arrays[key]).all() for key in arrays.files)
                row['arrays'] = {key: list(arrays[key].shape) for key in arrays.files}
            row['active_force_outputs'] = {}
            for name, index in ((token, argument), ('evaluate_cables', 5)):
                before, after = [folder / f'dump_{name}_{phase}_arg{index}.bin' for phase in ('pre', 'post')]
                assert before.stat().st_size == after.stat().st_size == 8 * case['worlds'] * 12
                row['active_force_outputs'][name] = before.read_bytes() != after.read_bytes()
            if args.stage == 'candidate':
                reference = BASE / 'discovery-v2-3' / case['name'] / 'original'
                with np.load(reference / 'capture.npz', allow_pickle=False) as old, \
                        np.load(folder / 'capture.npz', allow_pickle=False) as new:
                    if args.frames == 3:
                        row['states'] = compare(old, new)
                if args.frames == 3:
                    row['metadata'] = compare_launches(reference / 'launches.txt', folder / 'launches.txt', layout)
                    counts = json.loads((folder / 'capture.launches.json').read_text())
                    row['coverage'] = sum(counts.values()) == row['metadata']['right_launches']
        status['completed'].append(row)
        status['running'] = None
        dump()
        print(case['name'], backend, 'actual exit', code,
              'strict', row.get('states', {}).get('bitwise'), flush=True)
status['complete'] = True
dump()
if args.stage == 'discovery':
    passed = all((row['actual_exit'] == 0 and row['finite']) if row['backend'] == 'original' else
                 row['actual_exit'] == 1 and 'Cable mixed with body constraints has not been captured' in row['scope_error']
                 for row in status['completed'])
else:
    passed = all(row['actual_exit'] == 0 and row['finite'] and row.get('states', {}).get('bitwise', False)
                 and row.get('metadata', {}).get('equal', False) and row.get('coverage', False)
                 for row in status['completed'])
print('Stage', args.stage, 'complete;', len(status['completed']), 'workers; passed', passed, flush=True)
raise SystemExit(int(not passed))
