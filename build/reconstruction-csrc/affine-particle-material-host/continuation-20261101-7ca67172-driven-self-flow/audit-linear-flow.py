"""Independently check complete diagnostic snapshots and link actual PCG vectors to public positions."""
from collections import defaultdict
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import compare, schemas
from reconstruction.demo_ab import compare as compare_states

SELF = BASE.parent / 'continuation-20261101-0dabbaa7-driven-cloth-self'
PLAN = json.loads((BASE / 'linear-flow-plan.json').read_text())
OUTPUT = BASE / 'linear-independent-cpu.json'
assert not OUTPUT.exists()
HASHES, schema = dict(PLAN['input_sha256']), schemas()[0]
HASHES[str(Path(__file__).resolve())] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
for name, expected in HASHES.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
F32_OUTPUTS = {
    '14initialize_rhs': ['9'], '25initialize_block_diagonal': ['1', '2'],
    '27invert_block_preconditioner': ['3'], '23precondition_and_reduce': ['2', '6'],
    '19update_cg_direction': ['6'], '26multiply_matrix_and_reduce': ['6', '9'],
    '28update_solution_and_residual': ['6', '7'], '20apply_nonlinear_step': ['1', '2'],
    '22accumulate_vertex_face': ['11', '12'], '20accumulate_edge_edge': ['9', '10'],
    '20accumulate_edge_face': ['10', '11'], '20add_hessian_diagonal': ['1'],
    '25multiply_contact_tangents': ['3'],
}


def read(path):
    data = path.read_bytes()
    HASHES[str(path.resolve())] = hashlib.sha256(data).hexdigest()
    return data


def load(number, job):
    directory = BASE / 'linear-captures' / str(number)
    runtime = json.loads(read(directory / 'capture.runtime.json'))
    provenance = json.loads(read(directory / 'wrapper-provenance.json'))
    assert provenance['complete'] and provenance['original_SDK_mapped'] == (job['backend'] == 'original')
    expected = ('64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
                if job['backend'] == 'original' else PLAN['candidate_image_sha256'])
    assert runtime['image_sha256'] == expected
    reference = SELF / 'constructors-force-order' / job['case']['name'] / 'external-full-memory' / job['backend']
    read(directory / 'launches.txt')
    metadata = compare(reference / 'launches.txt', directory / 'launches.txt', schema)
    assert metadata['equal']
    lines = (directory / 'launches.txt').read_text().splitlines()
    counts, stages, files = defaultdict(int), [], set()
    readonly, alias_bytes = 0, 0
    for planned in job['stages']:
        key = planned['key']
        args = lines[planned['owned_launch']].split(' symbol:')[0].split()[5:]
        index = counts[key]
        counts[key] += 1
        arrays = {}
        for phase in ('pre', 'post'):
            for field, size in planned['fields'].items():
                argument, *offset = field.split('+')
                suffix = '_offset' + offset[0] if offset else ''
                filename = f'dump_{key}_call{index:03d}_{phase}_arg{argument}{suffix}.bin'
                raw = read(directory / filename)
                assert len(raw) == size, (number, filename, len(raw), size)
                files.add(filename)
                arrays[(phase, field)] = raw
        if planned['all_flat_nonnull_inputs']:
            addresses = {field: int(args[int(field)][2:], 16) for field in planned['fields']}
            for field, size in planned['fields'].items():
                mask = np.ones(size, dtype=bool)
                for output in planned['outputs']:
                    start = max(addresses[field], addresses[output])
                    end = min(addresses[field] + size, addresses[output] + planned['fields'][output])
                    if start < end:
                        mask[start - addresses[field]:end - addresses[field]] = False
                        if field not in planned['outputs']:
                            alias_bytes += end - start
                before, after = [np.frombuffer(arrays[(phase, field)], dtype='u1') for phase in ('pre', 'post')]
                assert before[mask].tobytes() == after[mask].tobytes(), (number, key, index, field)
                readonly += int(mask.sum())
        stages.append({'key': key, 'index': index, 'planned': planned, 'arrays': arrays})
    assert files == {path.name for path in directory.glob('dump_*.bin')}
    assert len(files) == job['expected_snapshot_files']
    groups = defaultdict(list)
    for stage in stages:
        groups[stage['key']].append(stage)
    links = defaultdict(int)

    def link(left, lp, la, right, rp, ra, kind):
        assert left['arrays'][(lp, la)] == right['arrays'][(rp, ra)], (number, kind, left['index'], right['index'])
        links[kind] += 1

    pre, direction, product, solution, apply = [groups[key] for key in (
        '23precondition_and_reduce', '19update_cg_direction', '26multiply_matrix_and_reduce',
        '28update_solution_and_residual', '20apply_nonlinear_step')]
    assert len(pre) == len(direction) == len(product) == len(solution) == 45 and len(apply) == 9
    for i in range(45):
        link(pre[i], 'post', '2', direction[i], 'pre', '1', 'precondition-to-direction')
        link(direction[i], 'post', '6', product[i], 'pre', '4', 'direction-to-matrix')
        link(direction[i], 'post', '6', solution[i], 'pre', '4', 'direction-to-update')
        link(product[i], 'post', '6', solution[i], 'pre', '5', 'matrix-to-update')
        if i % 5 != 4:
            link(solution[i], 'post', '7', pre[i + 1], 'pre', '1', 'residual-to-next-precondition')
            link(solution[i], 'post', '6', solution[i + 1], 'pre', '6', 'delta-to-next-update')
        else:
            link(solution[i], 'post', '6', apply[i // 5], 'pre', '2', 'last-delta-to-apply')
    for i in range(9):
        link(groups['22evaluate_bending_force'][i], 'post', '7', pre[5 * i], 'pre', '1', 'last-force-to-CG-RHS')
        link(groups['35add_surface_contact_stiffness_scale'][i], 'post', '1',
             groups['22accumulate_vertex_face'][i], 'pre', '6', 'surface-scale-to-self-stiffness')
    public = np.load(directory / 'capture.npz', allow_pickle=False)
    read(directory / 'capture.npz')
    for frame in range(3):
        assert apply[3 * frame + 2]['arrays'][('post', '1')] == public['particle_q'][frame].tobytes()
        links['last-apply-to-public-q'] += 1
    old = SELF / ('discovery' if job['backend'] == 'original' else 'force-order-captures') / job['case']['name']
    if job['backend'] == 'original':
        old = old / 'original'
    with np.load(old / 'capture.npz', allow_pickle=False) as frozen:
        reproduces = compare_states(frozen, public)['bitwise']
    states = {key: public[key].copy() for key in public.files}
    public.close()
    return stages, states, {'job': number, 'case': job['case']['name'], 'backend': job['backend'],
                            'actual_snapshot_files': len(files), 'stages': len(stages),
                            'readonly_bytes_checked': readonly, 'readonly_alias_bytes_excluded': alias_bytes,
                            'links': dict(links), 'original_frozen_trajectory_reproduced': reproduces,
                            'all_owned_metadata_equal': True, 'source_SDK_mapping': provenance['original_SDK_mapped']}


def numerical(left, right):
    a, b = [np.frombuffer(raw, dtype='<f4') for raw in (left, right)]
    finite = bool(np.isfinite(a).all() and np.isfinite(b).all())
    return {'bitwise_equal': left == right, 'finite': finite,
            'max_abs_difference': float(np.abs(a.astype('f8') - b.astype('f8')).max()) if finite else None}


loaded, workers = [], []
for number, job in enumerate(PLAN['jobs']):
    stages, states, report = load(number, job)
    loaded.append((stages, states))
    workers.append(report)
comparisons = []
for first in (0, 2):
    left, right = loaded[first][0], loaded[first + 1][0]
    assert len(left) == len(right)
    differences, applies = [], []
    for a, b in zip(left, right):
        assert (a['key'], a['index']) == (b['key'], b['index'])
        key = a['key']
        fields = F32_OUTPUTS.get(key)
        if fields is None:
            fields = [field for field in a['planned']['fields'] if '+' not in field and field != '0']
        for field in fields:
            if ('post', field) not in a['arrays']:
                continue
            stats = numerical(a['arrays'][('post', field)], b['arrays'][('post', field)])
            if not stats['bitwise_equal']:
                differences.append({'key': key, 'call': a['index'], 'field': field, **stats})
        if key == '20apply_nonlinear_step':
            applies.append({'nonlinear_call': a['index'],
                            'delta_before': numerical(a['arrays'][('pre', '2')], b['arrays'][('pre', '2')]),
                            'q_after': numerical(a['arrays'][('post', '1')], b['arrays'][('post', '1')])})
    comparisons.append({'case': PLAN['jobs'][first]['case']['name'], 'post_buffer_differences': differences,
                        'apply_progression': applies, 'public_states': compare_states(loaded[first][1], loaded[first + 1][1])})
report = {'workers': workers, 'comparisons': comparisons, 'GPU_used': False,
          'captures_are_diagnostic_not_replacement_acceptance_samples': True,
          'fixed_C8_failures_reclassified': False, 'candidate_promoted': False, 'whole_solver_complete': False,
          'input_sha256': HASHES}
OUTPUT.write_text(json.dumps(report, indent=2) + '\n')
print('Actual linear/self snapshots audited:', sum(row['actual_snapshot_files'] for row in workers),
      'files;', sum(row['stages'] for row in workers), 'stages', flush=True)
