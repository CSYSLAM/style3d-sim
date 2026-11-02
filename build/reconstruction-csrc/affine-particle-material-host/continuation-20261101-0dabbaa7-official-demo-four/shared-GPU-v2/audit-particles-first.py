"""Compare first actual particle-cloth force/PCG buffers, preserving whole-trajectory failures and scope limits."""
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import compare, schemas
from reconstruction.csrc.hook_parameter_bytes import decode
from reconstruction.csrc.official_demo_audit import SDK, HOST

PHASE = BASE / 'particles-first'
OUTPUT = PHASE / 'independent-cpu.json'
assert not OUTPUT.exists()
plan = json.loads((PHASE / 'plan.json').read_text())
status = json.loads((PHASE / 'status.json').read_text())
assert status['complete'] and len(status['completed']) == 2
assert all(row['actual_exit'] == 0 for row in status['completed'])
hashes = dict(plan['input_sha256'])


def read(path):
    raw = path.read_bytes()
    hashes[str(path.resolve())] = hashlib.sha256(raw).hexdigest()
    return raw


def difference(left, right):
    a, b = [np.frombuffer(raw, dtype='<f4') for raw in (left, right)]
    delta = np.flatnonzero(a.view('<u4') != b.view('<u4'))
    finite = bool(np.isfinite(a).all() and np.isfinite(b).all())
    return {'bitwise_equal': left == right, 'finite': finite, 'different_words': int(len(delta)),
            'max_abs': float(np.abs(a.astype('f8') - b.astype('f8')).max()) if finite else None,
            'first_different_words': [int(i) for i in delta[:8]]}


metadata = compare(PHASE / 'original/launches.txt', PHASE / 'source/launches.txt', schemas()[0])
loaded, observed, workers = [], [], []
for side in ('original', 'source'):
    directory = PHASE / side
    nodes = {}
    for line in read(directory / 'launches.txt').decode().splitlines():
        node = decode(line)
        nodes.setdefault(node['key'], node)
    arrays, files = {}, set()
    for key, fields in plan['fields'].items():
        assert key in nodes
        for field, size in fields.items():
            for phase in ('pre', 'post'):
                path = directory / f'dump_{key}_{phase}_arg{field}.bin'
                raw = read(path)
                assert len(raw) == size
                arrays[(key, phase, field)] = raw
                files.add(path.name)
    assert files == {path.name for path in directory.glob('dump_*.bin')}
    runtime = json.loads(read(directory / 'capture.runtime.json'))
    assert runtime['image_sha256'] == (SDK if side == 'original' else HOST)
    assert runtime['frames'] == 1 and runtime['extra'] == []
    with np.load(directory / 'capture.npz', allow_pickle=False) as captured:
        assert captured['particle_q'].shape == (10, 8625, 3)
        frozen_path = BASE / 'long60/cloth-particles' / (side + '.npz')
        with np.load(frozen_path, allow_pickle=False) as frozen:
            reproduces = all(captured[key][0].tobytes() == frozen[key][0].tobytes() for key in captured.files)
    read(directory / 'capture.npz')
    read(frozen_path)
    workers.append({'side': side, 'snapshot_files': len(files), 'frozen_first_substep_reproduced': reproduces})
    loaded.append(arrays)
    observed.append(nodes)
links = []
for left, lp, la, right, rp, ra in [
    ('27invert_block_preconditioner', 'post', '3', '23precondition_and_reduce', 'pre', '0'),
    ('23precondition_and_reduce', 'post', '2', '19update_cg_direction', 'pre', '1'),
    ('23precondition_and_reduce', 'post', '6', '19update_cg_direction', 'pre', '4'),
    ('23precondition_and_reduce', 'post', '6', '28update_solution_and_residual', 'pre', '2'),
    ('19update_cg_direction', 'post', '6', '26multiply_matrix_and_reduce', 'pre', '4'),
    ('19update_cg_direction', 'post', '6', '28update_solution_and_residual', 'pre', '4'),
    ('26multiply_matrix_and_reduce', 'post', '6', '28update_solution_and_residual', 'pre', '5'),
    ('26multiply_matrix_and_reduce', 'post', '9', '28update_solution_and_residual', 'pre', '3'),
    ('22evaluate_bending_force', 'post', '7', '23precondition_and_reduce', 'pre', '1'),
    ('22evaluate_stretch_force', 'post', '5', '22evaluate_bending_force', 'pre', '7')]:
    equal = [arrays[(left, lp, la)] == arrays[(right, rp, ra)] for arrays in loaded]
    assert all(equal), (left, right, equal)
    links.append({'producer': left + '/' + lp + '/' + la, 'consumer': right + '/' + rp + '/' + ra})
rows = []
for key, fields in plan['fields'].items():
    for phase in ('pre', 'post'):
        for field in fields:
            rows.append({'owned_launch': observed[0][key]['owned_launch'], 'kind': key, 'phase': phase,
                         'field': field, **difference(loaded[0][(key, phase, field)], loaded[1][(key, phase, field)])})
rows.sort(key=lambda row: (row['owned_launch'], row['phase'] == 'post', row['field']))
for path in (Path(__file__), PHASE / 'plan.json', PHASE / 'status.json'):
    read(path)
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
result = {'metadata': metadata, 'workers': workers, 'comparisons': rows, 'producer_consumer_links_per_side': links,
          'input_sha256': hashes, 'GPU_used_for_this_audit': False, 'matrix_inputs_complete': False,
          'first_CG_delta_is_not_final_12_CG_delta': True, 'first_apply_is_not_final_20_NL_public_state': True,
          'old_frozen_failures_reclassified': False, 'production_changed': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('Actual first particle buffers CPU:metadata', metadata['equal'], 'links', len(links), 'per side', flush=True)
print('Differences:', [(r['owned_launch'], r['kind'], r['phase'], r['field'], r['max_abs'])
                       for r in rows if not r['bitwise_equal']], flush=True)
