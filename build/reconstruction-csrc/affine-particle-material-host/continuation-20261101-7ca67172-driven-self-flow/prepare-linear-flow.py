"""Plan complete PCG/self inputs and force-boundary snapshots from actual same-run allocation extents."""
import hashlib
import json
from pathlib import Path
import re
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import schemas

SELF = BASE.parent / 'continuation-20261101-0dabbaa7-driven-cloth-self'
OUTPUT = BASE / 'linear-flow-plan.json'
assert not OUTPUT.exists()
HASHES = {}
SCHEMA = schemas()[0]
FULL = {
    '14initialize_rhs': [9], '25initialize_block_diagonal': [1, 2],
    '27invert_block_preconditioner': [3], '23precondition_and_reduce': [2, 6],
    '19update_cg_direction': [6], '26multiply_matrix_and_reduce': [6, 9],
    '28update_solution_and_residual': [6, 7], '20apply_nonlinear_step': [1, 2],
    '22accumulate_vertex_face': [11, 12, 13, 14], '20accumulate_edge_edge': [9, 10, 11, 12],
    '20accumulate_edge_face': [10, 11, 12, 13], '20add_hessian_diagonal': [1],
    '25multiply_contact_tangents': [3],
}
BOUNDARIES = {
    '26evaluate_body_spring_force': {12: 576},
    '53evaluate_joint_body_spring_augmented_lagrangian_force': {10: 576},
    '25evaluate_joint_drive_load': {26: 576},
    '23evaluate_angular_limits': {8: 576, 9: 1728},
    '51evaluate_affine_body_so3_augmented_lagrangian_force': {6: 576},
    '22evaluate_stretch_force': {5: 576}, '22evaluate_bending_force': {7: 576},
    '32multiply_bending_damping_tangent': {7: 576},
    '53multiply_affine_body_so3_augmented_lagrangian_tangent': {5: 576},
    '28multiply_joint_drive_tangent': {18: 576},
}


def read(path):
    data = path.read_bytes()
    HASHES[str(path.resolve())] = hashlib.sha256(data).hexdigest()
    return data.decode()


def scalar(args, index):
    token = args[index]
    assert token.startswith(('u:', 'i:'))
    return int(token[2:], 16 if token.startswith('u:') else 10)


def view_fields(directory):
    table = json.loads(read(directory / 'fields.json'))
    return {f'0+{offset}' if int(offset) else '0': int(values[1]) for offset, values in table.items()}


def capture(case, side):
    directory = SELF / 'constructors-force-order' / case['name'] / 'external-full-memory' / side
    lines = read(directory / 'launches.txt').splitlines()
    labels = json.loads(read(directory / 'capture.pointers.json'))
    live, identity, launch, stages, specs = {}, 0, 0, [], {}
    surface = view_fields(SELF / 'first-surface-inputs' / case['name'] / side)
    partial = dict(BOUNDARIES)
    # These boundaries expose complete destinations while other arguments remain outside this capture's claim.
    partial.update({'30evaluate_surface_contact_force': {**surface, '1': 576},
                    '35add_surface_contact_stiffness_scale': {**surface, '1': 192},
                    '34add_surface_contact_preconditioner': {**surface, '1': 1728},
                    '32multiply_surface_contact_tangent': {**surface, '1': 576, '2': 576}})
    for text in read(directory / 'memory.jsonl').splitlines():
        row = json.loads(text)
        assert not row.get('status', 0)
        api = row.get('api', '')
        if api in ('cudaMalloc', 'cuMemAlloc_v2'):
            live[int(row['dst'], 16)] = (identity, row['bytes'])
            identity += 1
        elif api in ('cudaFree', 'cuMemFree_v2'):
            del live[int(row['dst'], 16)]
        elif row.get('kind') == -2 and api in SCHEMA:
            head, tail = lines[launch].split(' symbol:', 1)
            assert tail.split()[0] == api
            key, args = head.split()[1], head.split()[5:]
            if key in FULL:
                sizes, targets = {}, {}
                for argument, typ in enumerate(SCHEMA[api]):
                    if typ != 'pointer' or not scalar(args, argument):
                        continue
                    address = scalar(args, argument)
                    found = [(start, number, size) for start, (number, size) in live.items()
                             if start <= address < start + size]
                    assert len(found) <= 1
                    if found:
                        start, number, size = found[0]
                        size -= address - start
                        targets[str(argument)] = ['owned', number, address - start, size]
                    else:
                        label = labels.get(hex(address))
                        if label in ('model.particle_masses[16]', 'model.particle_flags[16]'):
                            size = 64
                        elif label == 'model.triangle_indices[4]':
                            size = 48
                        elif label == 'model.edge_indices[10]':
                            size = 160
                        else:
                            assert not label, (key, argument, label)
                            allowed = key in ('14initialize_rhs', '20apply_nonlinear_step') or (
                                key in ('22accumulate_vertex_face', '20accumulate_edge_edge',
                                        '20accumulate_edge_face') and argument == 0)
                            assert allowed, (key, argument)
                            size = 576
                        targets[str(argument)] = ['external', hex(address), label, size]
                    # Each scalar pointer selects one three-world value, not its remaining 999-iteration storage.
                    if ((key == '23precondition_and_reduce' and argument == 6) or
                            (key == '19update_cg_direction' and argument in (4, 5)) or
                            (key == '26multiply_matrix_and_reduce' and argument == 9) or
                            (key == '28update_solution_and_residual' and argument in (2, 3))):
                        assert size >= 12
                        size = 12
                    sizes[str(argument)] = size
                writes = []
                for index in FULL[key]:
                    if scalar(args, index):
                        writes.append(str(index))
                    else:
                        assert key == '25initialize_block_diagonal' and index == 2
                assert set(writes) <= set(sizes)
                assert key != '27invert_block_preconditioner' or scalar(args, 0) == scalar(args, 3)
                full = True
            elif key in partial:
                sizes = {str(i): size for i, size in partial[key].items()}
                for argument in list(sizes):
                    if '+' in argument:
                        continue
                    index = int(argument)
                    if index == 0 and key.startswith(('30evaluate_surface', '35add_surface',
                                                     '34add_surface', '32multiply_surface')):
                        assert SCHEMA[api][index] == 'U'
                        continue
                    assert SCHEMA[api][index] == 'pointer', (key, index)
                    if not scalar(args, index):
                        del sizes[argument]
                        continue
                    found = [(start, length) for start, (_, length) in live.items()
                             if start <= scalar(args, index) < start + length]
                    assert len(found) == 1, (key, index, found)
                    start, length = found[0]
                    assert scalar(args, index) - start + sizes[argument] <= length, (key, index)
                writes, targets, full = [], {}, False
            else:
                launch += 1
                continue
            if key in specs:
                # The first CG direction has a NULL previous numerator; later calls add that one pointer.
                for argument, size in sizes.items():
                    assert argument not in specs[key] or specs[key][argument] == size, (key, argument)
                specs[key].update(sizes)
            else:
                specs[key] = dict(sizes)
            stages.append({'owned_launch': launch, 'key': key, 'symbol': api, 'fields': sizes,
                           'outputs': writes, 'all_flat_nonnull_inputs': full, 'allocation_targets': targets})
            launch += 1
    assert launch == len(lines)
    assert sum(stage['key'] == '20apply_nonlinear_step' for stage in stages) == 9
    assert sum(stage['key'] == '28update_solution_and_residual' for stage in stages) == 45
    return {'stages': stages, 'specifications': specs, 'owned_launches': launch,
            'expected_snapshot_files': sum(2 * len(stage['fields']) for stage in stages)}


source_plan = json.loads(read(SELF / 'short-fixed-C8/plan.json'))
candidate = json.loads(read(SELF / 'candidate-force-order/build.json'))
jobs = []
for case in source_plan['cases']:
    captures = {side: capture(case, side) for side in ('original', 'source')}
    assert captures['original']['specifications'] == captures['source']['specifications']
    for side in ('original', 'source'):
        jobs.append({'case': case, 'backend': side, **captures[side]})
for path in (Path(__file__), SELF / 'worker.py', ROOT / 'reconstruction/csrc/driven_cloth_self_scene.py',
             ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'):
    data = path.read_bytes()
    HASHES[str(path.resolve())] = hashlib.sha256(data).hexdigest()
HASHES.update(candidate['input_sha256'])
HASHES[candidate['image']] = candidate['image_sha256']
plan = {'jobs': jobs, 'input_sha256': HASHES, 'candidate_image_sha256': candidate['image_sha256'],
        'frames': 3, 'dump_limit': 999, 'raw_contact_capacity_preserved': True,
        'GPU_used_during_preparation': False, 'original_frozen_samples_replaced': False,
        'new_diagnostic_trajectories_are_not_old_fixed_acceptance_samples': True,
        'candidate_promoted': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(plan, indent=2) + '\n')
print('Prepared actual linear/self flow:', [(j['case']['name'], j['backend'], len(j['stages']),
      j['expected_snapshot_files']) for j in jobs], flush=True)
