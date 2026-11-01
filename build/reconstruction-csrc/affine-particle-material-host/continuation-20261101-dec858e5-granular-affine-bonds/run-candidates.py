"""After actual SDK discovery, capture both isolated candidates without dropping strict failures."""
from datetime import datetime, timezone
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

plan = json.loads((BASE / 'plan.json').read_text())
builds = {name: json.loads((BASE / ('candidate-' + name) / 'build.json').read_text())
          for name in ('guard-only', 'static-cache')}
output = BASE / 'candidate-captures'
output.mkdir(exist_ok=False)
hashes = dict(plan['input_sha256'])
for build in builds.values():
    hashes.update(build['input_sha256'])
    hashes[build['image']] = build['image_sha256']
for path in [Path(__file__), BASE / 'candidate-worker.py', BASE / 'plan.json']:
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
matches = []
for proc in Path('/proc').iterdir():
    if not proc.name.isdigit():
        continue
    try:
        args = (proc / 'cmdline').read_bytes().split(b'\0')
        if len(args) > 1 and args[1] and Path(os.fsdecode(args[1])).resolve() == (BASE / 'discover.py').resolve():
            matches.append({'pid': int(proc.name), 'starttime': (proc / 'stat').read_text().rsplit(')', 1)[1].split()[19]})
    except (OSError, ValueError):
        continue
assert len(matches) <= 1
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'preceding_live_driver': matches,
    'candidate_images': {name: build['image_sha256'] for name, build in builds.items()},
    'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'driver_waits': [], 'GPU_waits': [],
          'whole_solver_complete': False}


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


def verify():
    for name, sha in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == sha, name


dump()
if matches:
    identity = matches[0]
    while True:
        try:
            actual = Path('/proc', str(identity['pid']), 'stat').read_text().rsplit(')', 1)[1].split()[19]
        except FileNotFoundError:
            break
        if actual != identity['starttime']:
            break
        status['driver_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), **identity})
        dump()
        time.sleep(2)
assert json.loads((BASE / 'status.json').read_text())['complete']
discovery = json.loads((BASE / 'report.json').read_text())['rows']
assert len(discovery) == 12
assert all(row['actual_exit'] == 0 and row['actual_bond_force_launched'] for row in discovery
           if row['backend'] == 'original')
assert all(row['actual_exit'] == 1 and row['actual_source_guard'] for row in discovery if row['backend'] == 'source')
for case in plan['cases']:
    for path in (BASE / case['label'] / 'original').rglob('*'):
        if path.is_file():
            hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
(output / 'reference-inputs-sha256.json').write_text(json.dumps(hashes, indent=2) + '\n')
env = {k: v for k, v in os.environ.items() if not k.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
schema, reports = schemas()[0], []
for name, build in builds.items():
    for case in plan['cases']:
        verify()
        while True:
            live = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            status['GPU_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': live})
            dump()
            if not live:
                break
            time.sleep(5)
        folder = output / name / case['label']
        folder.mkdir(parents=True, exist_ok=False)
        command = [sys.executable, str(BASE / 'candidate-worker.py'), '--candidate-build',
                   str(BASE / ('candidate-' + name) / 'build.json'), '--worker', 'source', '--tag', 'capture',
                   '--example', str(ROOT / 'reconstruction/csrc/granular_affine_bonds_scene.py'), '--frames', '3',
                   '--output', str(folder), '--', *case['extra']]
        fields = case['fields']
        task_env = {**env, 'LD_PRELOAD': str(hook), 'CUDAHOOK_DIR': str(folder), 'CUDAHOOK_DUMP_LIMIT': '1',
                    'GRANULAR_AFFINE_MODEL_OUTPUT': str(folder),
                    'CUDAHOOK_DUMP': ';'.join(k + '=' + ','.join(str(i) + ':' + str(n) for i, n in sizes.items())
                                            for k, sizes in fields.items())}
        (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        with (folder / 'run.log').open('w') as log:
            process = subprocess.Popen(command, cwd=ROOT, env=task_env, stdout=log, stderr=subprocess.STDOUT)
            status['running'] = {'candidate': name, 'case': case['label'], 'pid': process.pid}
            dump()
            code = process.wait()
        status['completed'].append({'candidate': name, 'case': case['label'], 'pid': process.pid, 'actual_exit': code})
        status['running'] = None
        dump()
        row = {'candidate': name, 'case': case['label'], 'actual_exit': code, 'strict_passed': False}
        if code == 0:
            reference = BASE / case['label'] / 'original'
            runtime = json.loads((folder / 'capture.runtime.json').read_text())
            old_runtime = json.loads((reference / 'capture.runtime.json').read_text())
            assert runtime['image_sha256'] == build['image_sha256']
            for key in ('extra', 'frames', 'example_sha256'):
                assert runtime[key] == old_runtime[key], key
            for filename in ('model-before.npz', 'actual-layout.npz'):
                with np.load(folder / filename, allow_pickle=False) as new, \
                        np.load(reference / filename, allow_pickle=False) as old:
                    assert set(new.files) == set(old.files)
                    assert all(new[k].shape == old[k].shape and new[k].dtype == old[k].dtype and
                               new[k].tobytes() == old[k].tobytes() for k in old.files)
            with np.load(folder / 'capture.npz', allow_pickle=False) as new, \
                    np.load(reference / 'capture.npz', allow_pickle=False) as old:
                row['finite'] = bool(all(np.isfinite(a[k]).all() for a in (new, old) for k in a.files))
                row['states'] = compare(old, new)
            row['metadata'] = compare_launches(reference / 'launches.txt', folder / 'launches.txt', schema)
            buffers = {}
            for token, sizes in fields.items():
                for i, n in sizes.items():
                    for when in ('pre', 'post'):
                        filename = 'dump_' + token + '_' + when + '_arg' + str(i) + '.bin'
                        a, b = (reference / filename).read_bytes(), (folder / filename).read_bytes()
                        assert len(a) == len(b) == n
                        buffers[filename] = a == b
            row['buffers'] = buffers
            counts = json.loads((folder / 'capture.launches.json').read_text())
            row['complete_owned_coverage'] = sum(counts.values()) == row['metadata']['right_launches']
            row['strict_passed'] = bool(row['finite'] and row['states']['bitwise'] and row['metadata']['equal'] and
                                        row['complete_owned_coverage'] and all(buffers.values()))
        reports.append(row)
        (output / 'report.json').write_text(json.dumps({'rows': reports, 'production_changed': False,
                                                       'whole_solver_complete': False}, indent=2) + '\n')
        print(name, case['label'], 'exit', code, 'strict', row['strict_passed'], flush=True)
status['complete'] = True
dump()
verify()
for name in builds:
    rows = [row for row in reports if row['candidate'] == name]
    print(name, 'strict', sum(row['strict_passed'] for row in rows), '/', len(rows), flush=True)
