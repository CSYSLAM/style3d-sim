"""Run fixed broader material layouts only after the real candidate2 constructor/graph/initcheck gates pass."""
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

output = BASE / 'broader-layouts'
output.mkdir(exist_ok=False)
build = json.loads((BASE / 'candidate2/build.json').read_text())
fixture = ROOT / 'reconstruction/csrc/granular_affine_layout_scene.py'
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
paths = [Path(__file__), fixture, hook, BASE / 'candidate2-worker.py', BASE / 'followup-candidate2.py',
         BASE / 'candidate2/build.json', Path(build['image']), ROOT / 'reconstruction/csrc/audit_cudahook.py',
         ROOT / 'reconstruction/demo_ab.py']
hashes = dict(build['input_sha256'])
hashes.update({str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths})
cases = []
for worlds, bodies, width, subset, mode, block in [
    (1, 2, 2, False, 'newton', False), (1, 2, 3, False, 'pd', True),
    (3, 1, 2, False, 'newton', False), (3, 2, 2, True, 'pd', True),
    (1, 1, 3, False, 'pd', False), (3, 1, 3, False, 'newton', True),
]:
    label = f'w{worlds}-bodies{bodies}-width{width}-subset{int(subset)}-{mode}-block{int(block)}'
    extra = ['--worlds', str(worlds), '--bodies', str(bodies), '--width', str(width), '--mode', mode]
    extra += ['--subset'] if subset else []
    extra += ['--body-block'] if block else []
    cases.append({'label': label, 'worlds': worlds, 'bodies': bodies, 'width': width, 'subset': subset, 'extra': extra})
preceding = (BASE / 'followup-candidate2.py').resolve()
matches = []
for proc in Path('/proc').iterdir():
    if not proc.name.isdigit():
        continue
    try:
        args = (proc / 'cmdline').read_bytes().split(b'\0')
        if len(args) > 1 and args[1] and Path(os.fsdecode(args[1])).resolve() == preceding:
            matches.append({'pid': int(proc.name), 'starttime': (proc / 'stat').read_text().rsplit(')', 1)[1].split()[19]})
    except (OSError, ValueError):
        continue
assert len(matches) <= 1
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'cases': cases, 'preceding_live_driver': matches,
                                            'frames': 3, 'production_changed': False,
                                            'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'driver_waits': [], 'GPU_waits': [],
          'whole_solver_complete': False}


def dump():
    (output / 'run.status.json').write_text(json.dumps(status, indent=2) + '\n')


def verify():
    for name, digest in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name


dump()
if matches:
    identity = matches[0]
    while True:
        try:
            current = Path('/proc', str(identity['pid']), 'stat').read_text().rsplit(')', 1)[1].split()[19]
        except FileNotFoundError:
            break
        if current != identity['starttime']:
            break
        status['driver_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), **identity})
        dump()
        time.sleep(2)
prior = json.loads((BASE / 'candidate2-followup/run.status.json').read_text())
assert prior['complete'] and prior['running'] is None and all(r['actual_exit'] == 0 for r in prior['completed'])
assert json.loads((BASE / 'constructors2/audit.json').read_text())['all_captured_checks_passed']
graph = json.loads((BASE / 'graph60-candidate2/independent-cpu-audit.json').read_text())
assert graph['passed'] == graph['total'] == 16
env = {k: v for k, v in os.environ.items() if not k.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}
rows = []
schema = schemas()[0]
for case in cases:
    n, worlds, bodies = case['width'] ** 3, case['worlds'], case['bodies']
    total = worlds * (n + 4 * bodies)
    selection_count = worlds * len(range(0, n, 2 if case['subset'] else 1))
    fields = {'32initialize_affine_body_so3_state': {1: worlds * bodies * 16}, '14initialize_rhs': {9: total * 12},
              '15granular_kernel10build_grid': {7: selection_count * 4, 8: selection_count * 4},
              '15granular_kernel19accumulate_contacts': {1: total * 12, 2: total * 36}}
    for backend in ('original', 'source'):
        verify()
        while True:
            live = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            status['GPU_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': live})
            dump()
            if not live:
                break
            time.sleep(5)
        folder = output / case['label'] / backend
        folder.mkdir(parents=True, exist_ok=False)
        command = [sys.executable, str(BASE / 'candidate2-worker.py'), '--worker', backend, '--tag', 'capture',
                   '--example', str(fixture), '--frames', '3', '--output', str(folder), '--', *case['extra']]
        (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        task_env = {**env, 'LD_PRELOAD': str(hook), 'CUDAHOOK_DIR': str(folder), 'CUDAHOOK_DUMP_LIMIT': '1',
                    'GRANULAR_AFFINE_MODEL_OUTPUT': str(folder),
                    'CUDAHOOK_DUMP': ';'.join(k + '=' + ','.join(str(i) + ':' + str(size) for i, size in sizes.items())
                                            for k, sizes in fields.items())}
        with (folder / 'run.log').open('w') as log:
            process = subprocess.Popen(command, cwd=ROOT, env=task_env, stdout=log, stderr=subprocess.STDOUT)
            status['running'] = {'case': case['label'], 'backend': backend, 'pid': process.pid}
            dump()
            code = process.wait()
        status['completed'].append({'case': case['label'], 'backend': backend, 'pid': process.pid, 'actual_exit': code})
        status['running'] = None
        dump()
        print(case['label'], backend, 'actual exit', code, flush=True)
        assert code == 0
        runtime = json.loads((folder / 'capture.runtime.json').read_text())
        expected_image = ('64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
                          if backend == 'original' else build['image_sha256'])
        assert runtime['image_sha256'] == expected_image and runtime['extra'] == case['extra']
        assert runtime['frames'] == 3 and runtime['example_sha256'] == hashes[str(fixture)]
    left, right = [output / case['label'] / side for side in ('original', 'source')]
    with np.load(left / 'actual-layout.npz', allow_pickle=False) as old, \
            np.load(right / 'actual-layout.npz', allow_pickle=False) as new:
        assert set(old.files) == set(new.files) and all(old[k].tobytes() == new[k].tobytes() for k in old.files)
        ids = old['granular_indices']
        expected_ids = np.concatenate([np.arange(n, dtype='i4')[::2 if case['subset'] else 1] + w * (n + 4 * bodies)
                                       for w in range(worlds)])
        assert np.array_equal(ids, expected_ids)
        expected_bodies = np.asarray([[w * (n + 4 * bodies) + n + 4 * b + j for j in range(4)]
                                     for w in range(worlds) for b in range(bodies)], dtype='i4')
        assert np.array_equal(old['body_indices'], expected_bodies)
        # A non-replicated Newton builder authors shared world -1; replication assigns explicit world ids.
        particle_worlds = np.full(total, -1) if worlds == 1 else np.repeat(np.arange(worlds), n + 4 * bodies)
        body_worlds = np.full(bodies, -1) if worlds == 1 else np.repeat(np.arange(worlds), bodies)
        assert np.array_equal(old['particle_world'], particle_worlds)
        assert np.array_equal(old['body_world'], body_worlds)
    with np.load(left / 'capture.npz', allow_pickle=False) as old, np.load(right / 'capture.npz', allow_pickle=False) as new:
        assert all(np.isfinite(a[k]).all() for a in (old, new) for k in a.files)
        assert old['particle_q'].shape == new['particle_q'].shape == (3, total, 3)
        states = compare(old, new)
    metadata = compare_launches(left / 'launches.txt', right / 'launches.txt', schema)
    buffers = {}
    for token, sizes in fields.items():
        for i, size in sizes.items():
            for phase in ('pre', 'post'):
                filename = 'dump_' + token + '_' + phase + '_arg' + str(i) + '.bin'
                a, z = (left / filename).read_bytes(), (right / filename).read_bytes()
                assert len(a) == len(z) == size
                buffers[filename] = a == z
    counts = json.loads((right / 'capture.launches.json').read_text())
    coverage = sum(counts.values()) == metadata['right_launches']
    rows.append({'case': case['label'], 'states': states, 'metadata': metadata, 'buffers': buffers,
                 'complete_owned_coverage': coverage, 'actual_material_and_proxy_mapping_checked': True,
                 'strict_passed': bool(states['bitwise'] and metadata['equal'] and coverage and all(buffers.values()))})
    (output / 'report.json').write_text(json.dumps({'rows': rows, 'production_changed': False,
                                                  'whole_solver_complete': False}, indent=2) + '\n')
status['complete'] = True
dump()
print('Broader actual layouts', sum(r['strict_passed'] for r in rows), '/', len(rows), flush=True)
