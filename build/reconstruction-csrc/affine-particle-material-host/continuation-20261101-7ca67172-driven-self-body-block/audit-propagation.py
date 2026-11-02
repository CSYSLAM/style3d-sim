"""Compare actual SIX body-block captures and verify producer/consumer links without changing GPU inputs."""
from collections import defaultdict
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.hook_parameter_bytes import decode
from reconstruction.csrc.audit_cudahook import compare, schemas
from reconstruction.demo_ab import compare as compare_states

OUTPUT = BASE / 'propagation-independent-cpu.json'
assert not OUTPUT.exists()
plan = json.loads((BASE / 'plan.json').read_text())
hashes = dict(plan['input_sha256'])


def read(path):
    value = path.read_bytes()
    hashes[str(path.resolve())] = hashlib.sha256(value).hexdigest()
    return value


def numerical(left, right):
    a, b = [np.frombuffer(raw, dtype='<f4') for raw in (left, right)]
    different = np.flatnonzero(a.view('<u4') != b.view('<u4'))
    finite = bool(np.isfinite(a).all() and np.isfinite(b).all())
    return {'bitwise_equal': left == right, 'different_words': len(different),
            'max_abs_difference': float(np.abs(a.astype('f8') - b.astype('f8')).max()) if finite else None,
            'first_different_words': [{'index': int(i), 'original_bits': hex(int(a.view('<u4')[i])),
                                      'source_bits': hex(int(b.view('<u4')[i])),
                                      'original': float(a[i]), 'source': float(b[i])} for i in different[:8]]}


all_stages, groups, states, link_counts = [], [], [], []
for side in ('original', 'source'):
    directory = BASE / 'captures' / side
    counts, loaded, by_key, files = defaultdict(int), [], defaultdict(list), set()
    for line in read(directory / 'launches.txt').decode().splitlines():
        node = decode(line)
        key = node['key']
        if key not in plan['fields']:
            continue
        index = counts[key]
        counts[key] += 1
        arrays = {}
        for field, size in plan['fields'][key].items():
            argument, *extra = field.split('+')
            suffix = '_offset' + extra[0] if extra else ''
            for phase in ('pre', 'post'):
                path = directory / f'dump_{key}_call{index:03d}_{phase}_arg{argument}{suffix}.bin'
                value = read(path)
                assert len(value) == size
                files.add(path.name)
                arrays[(phase, field)] = value
        stage = {'key': key, 'index': index, 'node': node, 'arrays': arrays}
        loaded.append(stage)
        by_key[key].append(stage)
    assert files == {path.name for path in directory.glob('dump_*.bin')}
    links = defaultdict(int)

    def link(left, lp, la, right, rp, ra, kind):
        assert left['arrays'][(lp, la)] == right['arrays'][(rp, ra)], (side, kind, left['index'], right['index'])
        links[kind] += 1

    build, block, affine, reduce, update, apply = [by_key[key] for key in (
        'build_affine_body_preconditioner', 'apply_block_diagonal_preconditioner',
        'apply_affine_body_preconditioner', '23precondition_and_reduce',
        '28update_solution_and_residual', '20apply_nonlinear_step')]
    assert len(build) == len(apply) == 9 and len(block) == len(affine) == len(reduce) == len(update) == 45
    for i in range(45):
        link(build[i // 5], 'post', '17', affine[i], 'pre', '1', 'body-inverse-to-affine-apply')
        link(build[i // 5], 'post', '18', affine[i], 'pre', '2', 'body-valid-to-affine-apply')
        link(block[i], 'pre', '1', affine[i], 'pre', '3', 'residual-shared-between-two-applies')
        link(affine[i], 'post', '4', reduce[i], 'pre', '2', 'combined-z-to-precomputed-reduce')
        link(block[i], 'pre', '1', reduce[i], 'pre', '1', 'residual-to-precomputed-reduce')
        if i % 5 != 4:
            link(update[i], 'post', '7', block[i + 1], 'pre', '1', 'updated-residual-to-next-apply')
        else:
            link(update[i], 'post', '6', apply[i // 5], 'pre', '2', 'last-delta-to-nonlinear-apply')
    for i in range(9):
        link(by_key['34add_surface_contact_preconditioner'][i], 'post', '1',
             build[i], 'pre', '4', 'surface-diagonal-to-body-build')
    read(directory / 'capture.npz')
    with np.load(directory / 'capture.npz', allow_pickle=False) as data:
        states.append({key: data[key].copy() for key in data.files})
        for frame in range(3):
            assert apply[3 * frame + 2]['arrays'][('post', '1')] == data['particle_q'][frame].tobytes()
            links['last-apply-to-public-q'] += 1
    all_stages.append(loaded)
    groups.append(by_key)
    link_counts.append({'side': side, 'snapshots': len(files), 'stages': len(loaded), 'links': dict(links)})

metadata = compare(BASE / 'captures/original/launches.txt', BASE / 'captures/source/launches.txt', schemas()[0])
assert metadata['equal']
assert len(all_stages[0]) == len(all_stages[1])
rows = []
for left, right in zip(*all_stages):
    assert (left['key'], left['index']) == (right['key'], right['index'])
    node = left['node']
    row = {'owned_launch': node['owned_launch'], 'kind': left['key'], 'index': left['index'], 'fields': {}}
    for phase, field in left['arrays']:
        row['fields'][phase + '/' + field] = numerical(left['arrays'][(phase, field)], right['arrays'][(phase, field)])
    rows.append(row)
public = {key: numerical(states[0][key].tobytes(), states[1][key].tobytes())
          for key in ('particle_q', 'particle_qd', 'body_q', 'body_qd')}
read(Path(__file__))
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
report = {'workers': link_counts, 'owned_metadata_equal': True, 'comparisons': rows, 'public_states': public,
          'input_sha256': hashes, 'GPU_used_for_this_audit': False, 'old_failure_reclassified': False,
          'production_changed': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(report, indent=2) + '\n')
print('Complete paired body-block propagation:', len(rows), 'stages; producer/consumer links verified', flush=True)
for row in rows:
    if any(not v['bitwise_equal'] for v in row['fields'].values()):
        print('First observed difference:', row['owned_launch'], row['kind'], row['index'],
              {k: v['max_abs_difference'] for k, v in row['fields'].items() if not v['bitwise_equal']})
        break
print('Public maximum differences:', {key: value['max_abs_difference'] for key, value in public.items()}, flush=True)
