"""Discover actual SDK support and current-source guard results for bonded grains with SO3 bodies."""
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
from reconstruction.csrc.audit_cudahook import schemas

production = BASE.parent / 'continuation-20261101-granular-affine-production'
preceding = production / 'check-current-constructors.py'
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
build_bytes = build_path.read_bytes()
build = json.loads(build_bytes)
fixture = ROOT / 'reconstruction/csrc/granular_affine_bonds_scene.py'
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
sdk = ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
paths = [Path(__file__), fixture, hook, sdk, ROOT / 'reconstruction/csrc/demo_source_ab.py',
         ROOT / 'reconstruction/csrc/audit_cudahook.py', ROOT / 'examples/example_granular_beaf.py']
hashes = {str(ROOT / p): sha for p, sha in build['sources'].items()}
hashes.update({str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths})
assert hashes[str(sdk)] == '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
cases = []
for worlds, bodies, width, subset, bonds, mode, block in [
    (1, 1, 2, False, 'authored', 'newton', False),
    (1, 2, 3, True, 'authored', 'pd', True),
    (1, 1, 2, False, 'dynamic', 'newton', True),
    (3, 1, 2, True, 'dynamic', 'pd', False),
    (3, 2, 2, False, 'mixed', 'newton', True),
    (1, 1, 3, False, 'mixed', 'pd', False),
]:
    label = f'w{worlds}-b{bodies}-n{width}-subset{int(subset)}-{bonds}-{mode}-block{int(block)}'
    extra = ['--worlds', str(worlds), '--bodies', str(bodies), '--width', str(width), '--bonds', bonds, '--mode', mode]
    extra += ['--subset'] if subset else []
    extra += ['--body-block'] if block else []
    n = width ** 3
    grains = worlds * len(range(0, n, 2 if subset else 1))
    total = worlds * (n + 4 * bodies)
    rows = 2 * worlds if bonds != 'dynamic' else grains * 3
    fields = {'32initialize_affine_body_so3_state': {1: worlds * bodies * 16}, '14initialize_rhs': {9: total * 12},
              '15granular_kernel10build_grid': {7: grains * 4, 8: grains * 4},
              '15granular_kernel19accumulate_contacts': {1: total * 12, 2: total * 36},
              '15granular_kernel16accumulate_bonds': {10: total * 12, 11: total * 36, 12: rows * 36},
              '15granular_kernel12commit_bonds': {4: rows * 4, 5: rows * 4}}
    cases.append({'label': label, 'worlds': worlds, 'bodies': bodies, 'width': width, 'subset': subset,
                  'bonds': bonds, 'extra': extra, 'fields': fields})
matches = []
for proc in Path('/proc').iterdir():
    if not proc.name.isdigit():
        continue
    try:
        argv = (proc / 'cmdline').read_bytes().split(b'\0')
        if len(argv) > 1 and argv[1] and Path(os.fsdecode(argv[1])).resolve() == preceding.resolve():
            matches.append({'pid': int(proc.name), 'starttime': (proc / 'stat').read_text().rsplit(')', 1)[1].split()[19]})
    except (OSError, ValueError):
        continue
assert len(matches) <= 1
with (BASE / 'plan.json').open('x') as out:
    out.write(json.dumps({'input_sha256': hashes, 'source_sha256': build['extension_sha256'],
                          'cases': cases, 'frames': 3, 'preceding_live_driver': matches,
                          'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'driver_waits': [], 'GPU_waits': [],
          'whole_solver_complete': False}


def dump():
    (BASE / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


def verify():
    assert build_path.read_bytes() == build_bytes
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
prior = production / ('constructors-' + build['extension_sha256'][:8])
assert json.loads((prior / 'status.json').read_text())['complete']
assert json.loads((prior / 'audit.json').read_text())['all_captured_checks_passed']
env = {k: v for k, v in os.environ.items() if not k.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}
schema = schemas()[0]
rows = []
for case in cases:
    total = case['worlds'] * (case['width'] ** 3 + 4 * case['bodies'])
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
        folder = BASE / case['label'] / backend
        folder.mkdir(parents=True, exist_ok=False)
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend, '--tag', 'capture',
                   '--example', str(fixture), '--frames', '3', '--output', str(folder), '--', *case['extra']]
        task_env = {**env, 'LD_PRELOAD': str(hook), 'CUDAHOOK_DIR': str(folder), 'CUDAHOOK_DUMP_LIMIT': '1',
                    'GRANULAR_AFFINE_MODEL_OUTPUT': str(folder),
                    'CUDAHOOK_DUMP': ';'.join(k + '=' + ','.join(str(i) + ':' + str(n) for i, n in sizes.items())
                                            for k, sizes in case['fields'].items())}
        (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        with (folder / 'run.log').open('w') as log:
            process = subprocess.Popen(command, cwd=ROOT, env=task_env, stdout=log, stderr=subprocess.STDOUT)
            status['running'] = {'case': case['label'], 'backend': backend, 'pid': process.pid}
            dump()
            code = process.wait()
        status['completed'].append({'case': case['label'], 'backend': backend, 'pid': process.pid, 'actual_exit': code})
        status['running'] = None
        dump()
        print(case['label'], backend, 'actual exit', code, flush=True)
        runtime = json.loads((folder / 'capture.runtime.json').read_text())
        expected = hashes[str(sdk)] if backend == 'original' else build['extension_sha256']
        assert runtime['image_sha256'] == expected and runtime['frames'] == 3 and runtime['extra'] == case['extra']
        row = {'case': case['label'], 'backend': backend, 'actual_exit': code}
        if backend == 'original' and code == 0:
            with np.load(folder / 'capture.npz', allow_pickle=False) as states, \
                    np.load(folder / 'actual-layout.npz', allow_pickle=False) as layout:
                assert all(np.isfinite(states[k]).all() for k in states.files)
                assert states['particle_q'].shape == (3, total, 3)
                n, worlds, bodies = case['width'] ** 3, case['worlds'], case['bodies']
                selection = np.arange(n, dtype='i4')[::2 if case['subset'] else 1]
                selected = np.concatenate([selection + w * (n + 4 * bodies) for w in range(worlds)])
                assert np.array_equal(layout['granular_indices'], selected)
                authored = case['bonds'] != 'dynamic'
                pairs = np.asarray([(w * (n + 4 * bodies) + selection[a], w * (n + 4 * bodies) + selection[b])
                                    for w in range(worlds) for a, b in ((0, 1), (1, 2))], dtype='i4')
                expected_pairs = pairs if authored else np.empty((0, 2), dtype='i4')
                assert np.array_equal(layout['bond_indices'], expected_pairs)
                assert int(layout['native_bond_indices_count']) == len(expected_pairs)
                assert np.all(layout['bond_rest_lengths'] > 0.)
                row.update(finite=True, states_recorded=3, body_and_granular_mapping_checked=True,
                           authored_bond_mapping_checked=True, authored_bond_rows=len(expected_pairs))
            launches = (folder / 'launches.txt').read_text().splitlines()
            symbols = [line.split(' symbol:', 1)[1].split()[0] for line in launches]
            row['owned_launches'] = len(symbols)
            assert all(symbol in schema for symbol in symbols)
            assert any('granular_kernel16accumulate_bonds' in symbol for symbol in symbols)
            row['actual_bond_force_launched'] = True
        elif backend == 'source' and code == 1:
            row['actual_source_guard'] = 'Constrained or bonded granular/body combinations have not been captured' in \
                (folder / 'run.log').read_text()
        rows.append(row)
        (BASE / 'report.json').write_text(json.dumps({'rows': rows, 'production_changed': False,
                                                     'whole_solver_complete': False}, indent=2) + '\n')
verify()
status['complete'] = True
dump()
assert all(row['actual_exit'] == 0 and row.get('actual_bond_force_launched') for row in rows
           if row['backend'] == 'original')
assert all(row['actual_exit'] == 1 and row.get('actual_source_guard') for row in rows if row['backend'] == 'source')
print('Actual SDK supports all six bonded-body layouts; current source rejects each before stepping', flush=True)
