"""Validate the promoted host image against frozen SDK runs and its own full regression."""
from contextlib import ExitStack
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

OLD = BASE.parent / 'continuation-20261101-38b70dcd-granular-affine-support'
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
build_bytes = build_path.read_bytes()
build = json.loads(build_bytes)
output = BASE / ('validation-' + build['extension_sha256'][:8])
output.mkdir(exist_ok=False)
(output / 'build.json').write_bytes(build_bytes)
schema = schemas()[0]
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
env = {k: v for k, v in os.environ.items() if not k.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': [],
          'source_sha256': build['extension_sha256'], 'whole_solver_complete': False}
hashes = {str(ROOT / p): sha for p, sha in build['sources'].items()}
hashes[str(ROOT / 'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so')] = \
    build['extension_sha256']
sdk = ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
hashes[str(sdk)] = '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
for p in [Path(__file__), hook, ROOT / 'reconstruction/csrc/granular_affine_scene.py',
          ROOT / 'reconstruction/csrc/granular_affine_layout_scene.py', ROOT / 'reconstruction/core_demo.py',
          ROOT / 'reconstruction/csrc/demo_source_ab.py', BASE / 'graph-worker.py']:
    hashes[str(p)] = hashlib.sha256(p.read_bytes()).hexdigest()


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


def verify():
    assert build_path.read_bytes() == build_bytes
    for name, sha in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == sha, name


def freeze_reference(path):
    for p in path.rglob('*'):
        if p.is_file():
            hashes[str(p)] = hashlib.sha256(p.read_bytes()).hexdigest()


def run(name, arguments, task_env=None, allowed=(0,), gpu=True):
    verify()
    if gpu:
        while True:
            live = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            status['GPU_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': live})
            dump()
            if not live:
                break
            time.sleep(5)
    command = [sys.executable, *map(str, arguments)]
    (output / (name + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (output / (name + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=task_env or env, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'name': name, 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'name': name, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    print(name, 'actual exit', code, flush=True)
    assert code in allowed, (name, code)
    verify()


def capture(label, reference, fixture, extra, fields, layout_file):
    freeze_reference(reference)
    folder = output / label
    folder.mkdir()
    task_env = {**env, 'LD_PRELOAD': str(hook), 'CUDAHOOK_DIR': str(folder), 'CUDAHOOK_DUMP_LIMIT': '1',
                'GRANULAR_AFFINE_MODEL_OUTPUT': str(folder),
                'CUDAHOOK_DUMP': ';'.join(k + '=' + ','.join(str(i) + ':' + str(n) for i, n in sizes.items())
                                        for k, sizes in fields.items())}
    run(label, ['-m', 'reconstruction.csrc.demo_source_ab', '--worker', 'source', '--tag', 'capture',
                '--example', fixture, '--frames', '3', '--output', folder, '--', *extra], task_env)
    runtime = json.loads((folder / 'capture.runtime.json').read_text())
    original_runtime = json.loads((reference / 'capture.runtime.json').read_text())
    assert runtime['image_sha256'] == build['extension_sha256']
    assert original_runtime['image_sha256'] == hashes[str(sdk)]
    assert runtime['extra'] == original_runtime['extra'] == extra
    assert runtime['frames'] == original_runtime['frames'] == 3
    assert runtime['example_sha256'] == original_runtime['example_sha256'] == hashes[str(fixture)]
    with np.load(folder / layout_file, allow_pickle=False) as new, \
            np.load(reference / layout_file, allow_pickle=False) as old:
        assert set(new.files) == set(old.files) and all(new[k].tobytes() == old[k].tobytes() for k in old.files)
    with np.load(folder / 'capture.npz', allow_pickle=False) as new, \
            np.load(reference / 'capture.npz', allow_pickle=False) as old:
        assert all(np.isfinite(a[k]).all() for a in (new, old) for k in a.files)
        states = compare(old, new)
    metadata = compare_launches(reference / 'launches.txt', folder / 'launches.txt', schema)
    buffers = {}
    for token, sizes in fields.items():
        for i, n in sizes.items():
            for when in ('pre', 'post'):
                filename = 'dump_' + token + '_' + when + '_arg' + str(i) + '.bin'
                a, b = (reference / filename).read_bytes(), (folder / filename).read_bytes()
                assert len(a) == len(b) == n
                buffers[filename] = a == b
    counts = json.loads((folder / 'capture.launches.json').read_text())
    coverage = sum(counts.values()) == metadata['right_launches']
    assert 'demo_source_ab_complete' in (output / (label + '.log')).read_text()
    row = {'case': label, 'states': states, 'metadata': metadata, 'buffers': buffers,
           'complete_owned_coverage': coverage, 'model_layout_identical': True,
           'strict_passed': bool(states['bitwise'] and metadata['equal'] and coverage and all(buffers.values()))}
    (folder / 'comparison.json').write_text(json.dumps(row, indent=2) + '\n')
    return row


dump()
short_plan = json.loads((OLD / 'candidate2-run-plan.json').read_text())
short = []
for case in short_plan['runs']:
    label = case['label'].replace('candidate2-', 'current-', 1)
    reference = OLD / case['label'].replace('candidate2-', 'original-', 1)
    short.append(capture(label, reference, ROOT / 'reconstruction/csrc/granular_affine_scene.py',
                         case['extra'], short_plan['fields'], 'model-before.npz'))
(output / 'short-report.json').write_text(json.dumps(short, indent=2) + '\n')
assert all(row['strict_passed'] for row in short)
broader_plan = json.loads((OLD / 'broader-layouts-v3/plan.json').read_text())
broader = []
for case in broader_plan['cases']:
    total = case['worlds'] * (case['width'] ** 3 + 4 * case['bodies'])
    grains = case['worlds'] * len(range(0, case['width'] ** 3, 2 if case['subset'] else 1))
    fields = {'32initialize_affine_body_so3_state': {1: case['worlds'] * case['bodies'] * 16},
              '14initialize_rhs': {9: total * 12}, '15granular_kernel10build_grid': {7: grains * 4, 8: grains * 4},
              '15granular_kernel19accumulate_contacts': {1: total * 12, 2: total * 36}}
    row = capture('layout-' + case['label'], OLD / 'broader-layouts-v3' / case['label'] / 'original',
                  ROOT / 'reconstruction/csrc/granular_affine_layout_scene.py', case['extra'], fields,
                  'actual-layout.npz')
    broader.append(row)
(output / 'broader-report.json').write_text(json.dumps(broader, indent=2) + '\n')
# Intermediate buffers retain their strict result even when all recorded states agree.
assert all(row['states']['bitwise'] and row['metadata']['equal'] and row['complete_owned_coverage'] for row in broader)
graph = output / 'graph60'
graph.mkdir()
reference_graph = OLD / 'graph60-candidate2-v3'
freeze_reference(reference_graph)
run('granular-graph60', [BASE / 'graph-worker.py', '--backend', 'source', '--output', graph])
runtime = json.loads((graph / 'source.runtime.json').read_text())
assert runtime['image_sha256'] == build['extension_sha256'] and runtime['frames'] == 60
graph_rows = {}
for mode in ('newton', 'pd'):
    for block in (0, 1):
        case = mode + '-b' + str(block)
        with ExitStack() as stack:
            arrays = {(backend, g): stack.enter_context(np.load(
                (reference_graph if backend == 'original' else graph) / (backend + '-' + case + '-' + str(g) + '.npz'),
                allow_pickle=False)) for backend in ('original', 'source') for g in (0, 1)}
            assert all(np.isfinite(a[k]).all() for a in arrays.values() for k in a.files)
            for g in (0, 1):
                graph_rows[case + '-cross-g' + str(g)] = compare(arrays['original', g], arrays['source', g])
            for backend in ('original', 'source'):
                graph_rows[case + '-' + backend + '-eager-graph'] = compare(arrays[backend, 0], arrays[backend, 1])
(output / 'graph-report.json').write_text(json.dumps(graph_rows, indent=2) + '\n')
assert all(row['bitwise'] for row in graph_rows.values())
run('build-core', ['-m', 'reconstruction.csrc.build_core'], gpu=False)
core_path = Path((output / 'build-core.log').read_text().splitlines()[-1])
core_build = core_path.parent / 'build.json'
core = json.loads(core_build.read_text())
assert core['source_host_sha256'] == build['extension_sha256']
(output / 'core-build.json').write_bytes(core_build.read_bytes())
for name, example, frames, extra in [
    ('core-dzhanibekov60', 'example_basic_dzhanibekov', 60, []),
    ('core-plastic-bag3', 'example_plastic_bag', 3, []),
    ('core-g1-graph60', 'example_robot_g1', 60, ['--solver', 'synreal', '--world-count', '1']),
]:
    report = output / (name + '.json')
    run(name, ['-m', 'reconstruction.core_demo', '--core-build', core_build, '--report', report,
               'examples/' + example + '.py', '--viewer', 'null', '--num-frames', str(frames), '--test', *extra])
    data = json.loads(report.read_text())
    assert data['exit'] == 0 and data['source_only'] and data['public_core_abi']
    assert not data['reference_solver_mapped'] and data['source_sha256'] == core['extension_sha256']
run('regression74', ['-m', 'reconstruction.csrc.joint_continuation_regression',
                     '--output', output / 'regression74'], allowed=(0, 1))
regression = json.loads((output / 'regression74/status.json').read_text())
assert regression['complete'] and len(regression['completed']) == 74
if any(row['exit'] for row in regression['completed']):
    run('regression-fixed-C10', ['-m', 'reconstruction.csrc.regression_fixed_spread', '--validation', output,
                                '--output', output / 'regression-fixed-C10'], allowed=(0, 1))
    run('regression-fixed-C10-cpu', ['-m', 'reconstruction.csrc.audit_regression_fixed_spread',
                                    '--cohort', output / 'regression-fixed-C10', '--report', 'report.json',
                                    '--output', output / 'regression-fixed-C10/cpu-audit.json'], gpu=False)
verify()
(output / 'input-sha256.json').write_text(json.dumps(hashes, indent=2) + '\n')
status['complete'] = True
dump()
print('Current-image validation terminal; whole solver is still incomplete', flush=True)
