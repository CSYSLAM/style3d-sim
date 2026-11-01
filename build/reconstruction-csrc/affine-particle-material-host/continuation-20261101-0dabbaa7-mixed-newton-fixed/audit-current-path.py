"""Independently verify frozen target adoption, pointer-span coverage and actual GPU fold evidence on the CPU."""
from collections import Counter
import hashlib
import itertools
import json
from pathlib import Path
import sys

import numpy as np

sys.path.insert(0, str(Path.cwd()))
from reconstruction.csrc.audit_cudahook import parameter_types

base = Path(__file__).resolve().parent
pair = base / 'frozen-reproduced-mixed-pair'
validation = base.parent / 'continuation-20261101-granular-affine-bonds-production/validation-0dabbaa7-v2'
cohort = validation / 'regression-fixed-C10/mixed_cloth-seed3'
target = 'mixed_w129_duplicates'
build = json.loads((pair / 'solver-build.json').read_text())
replay = json.loads((base / 'replays/pointwise/report.json').read_text())
assert len(replay['packets']) == 732 and replay['all_pointwise_equal']
assert replay['source_sha256'] == build['extension_sha256']
terminal = json.loads((base / 'replays/status.json').read_text())
assert terminal['complete'] and len(terminal['completed']) == 19
assert all(row['actual_exit'] == 0 for row in terminal['completed'])
for path, expected in replay['input_sha256'].items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
adopted = json.loads((pair / 'adopted.json').read_text())
for name, expected in adopted['files'].items():
    assert hashlib.sha256((pair / name).read_bytes()).hexdigest() == expected, name
diagnostics = []
saved = json.loads((base / 'traces4/status.json').read_text())
assert saved['complete'] and len(saved['completed']) == 4
for row in saved['completed']:
    side, number = row['backend'], row['index']
    actual = base / 'traces4' / str(number) / f'{side}-seed3.npz'
    with np.load(actual) as arrays:
        for reference in ('original0', 'source0'):
            with np.load(cohort / (reference + '.npz')) as expected:
                keys = sorted(key for key in expected.files if key.startswith(target + '/'))
                equal = {key: expected[key].tobytes() == arrays[key].tobytes() for key in keys}
                assert len(equal) == 18 and equal == row[reference + '_target']['per_array']
                assert all(equal.values()) == row[reference + '_target']['all_arrays_bitwise']
    diagnostics.append({'run': number, 'side': side,
                        'original0_equal': row['original0_target']['all_arrays_bitwise'],
                        'source0_equal': row['source0_target']['all_arrays_bitwise']})
prototype_cache, normalized, span_calls, partial_overlap_calls = {}, {}, 0, 0
counter_words, actual_calls = 0, 0
for side in ('legacy', 'source'):
    folder = pair / side / 'native'
    first = sorted(folder.glob('*.15initialize_stepE.json'))[0].name[:-4]
    for row in replay['packets']:
        if row['capture'] != side:
            continue
        filename = row['packet']
        meta = json.loads((folder / filename).read_text())
        name, prefix = meta['name'], filename[:-4]
        widths = build['kernels'][name]['parameters']
        raw = [(folder / (prefix + f'before.param_{i}.bin')).read_bytes() for i in range(len(widths))]
        assert list(map(len, raw)) == widths
        if name not in prototype_cache:
            prototype_cache[name] = parameter_types(name)
        pointer_indices = [i for i, typ in enumerate(prototype_cache[name]) if '*' in typ]
        values = [int.from_bytes(data, 'little') for data in raw]
        n = 387
        spans = {}

        def add(index, label, phase='before', static=False, size=None):
            if not values[index]:
                return
            path = folder / ((first if static else prefix) + phase + '.' + label + '.bin')
            length = size if size is not None else path.stat().st_size
            assert length > 0
            spans[index] = max(spans.get(index, 0), length)

        if '15initialize_stepE' in name:
            for index, label in ((1, 'gravity'), (3, 'world'), (4, 'v'), (5, 'x'), (6, 'host_diagonal'),
                                 (17, 'mass'), (18, 'flags'), (19, 'particle_kind')):
                add(index, label)
            for slot in range(5):
                add(7 + 2 * slot, 'diagonal_template' + str(slot))
            for index, label in ((20, 'previous'), (21, 'target'), (22, 'diagonal')):
                add(index, label, 'after')
        elif '14initialize_rhsE' in name:
            for index, label in ((1, 'x'), (2, 'target'), (3, 'mass'), (4, 'row_count'), (5, 'entries'),
                                 (7, 'external'), (8, 'flags')):
                add(index, label)
            add(9, 'rhs', 'after')
        elif '27invert_block_preconditionerE' in name:
            add(0, 'blocks')
            add(1, 'mass', static=True)
            add(2, 'flags', static=True)
            add(3, 'inverse', 'after')
        elif '25initialize_block_diagonalE' in name:
            add(0, 'diagonal')
            add(1, 'blocks', 'after')
            add(2, 'precond', 'after')
        elif '23precondition_and_reduceIN3glm' in name:
            assert values[3] == 0
            for index, label in ((0, 'inverse'), (1, 'r'), (4, 'world'), (6, 'numerator')):
                add(index, label)
            add(2, 'z', 'after')
        elif '19update_cg_directionE' in name:
            for index, label in ((1, 'z'), (2, 'world'), (4, 'numerator'), (5, 'previous_numerator')):
                add(index, label)
            add(6, 'p', 'after')
        elif '26multiply_matrix_and_reduceINS_17BlockNonZeroEntry' in name:
            for index, label in ((0, 'row_count'), (1, 'entries'), (3, 'blocks'), (4, 'p'), (5, 'extra'),
                                 (7, 'world'), (9, 'denominator')):
                add(index, label)
            add(6, 'ap', 'after')
        elif '28update_solution_and_residualEP' in name:
            for index, label in ((0, 'world'), (2, 'numerator'), (3, 'denominator'), (4, 'p'), (5, 'ap'),
                                 (6, 'x'), (7, 'r')):
                add(index, label)
        elif '20apply_nonlinear_stepE' in name:
            add(0, 'q')
            add(1, 'q', 'after')
            add(2, 'dx')
        else:
            assert '15update_velocityE' in name
            add(1, 'previous')
            add(2, 'q')
            add(3, 'v', 'after')
        assert set(spans) == {index for index in pointer_indices if values[index]}
        for left, right in itertools.combinations(sorted(spans), 2):
            overlap = min(values[left] + spans[left], values[right] + spans[right]) - max(values[left], values[right])
            if overlap > 0 and values[left] != values[right]:
                partial_overlap_calls += 1
        aliases = [None if values[i] == 0 else [j for j in pointer_indices if values[j] == values[i]]
                   for i in pointer_indices]
        item = (meta, [data for i, data in enumerate(raw) if i not in pointer_indices], aliases)
        if side == 'legacy':
            normalized[filename] = item
        else:
            assert normalized[filename] == item
        assert len(row['checks']) == 6 and row['passed']
        actual_calls += len(row['checks'])
        for check in row['checks']:
            assert all(check['outputs_equal'].values())
            if 'atomic_counter_count' in check:
                assert check['atomic_counter_count'] == 129 and check['all_atomic_counter_words_equal']
                counter_words += check['atomic_counter_count']
        span_calls += 1
assert span_calls == 732 and partial_overlap_calls == 0
assert actual_calls == 4392 and counter_words == 250776
force_reports, isolated, folds, touched = [], 0, 0, 0
for path in sorted((base / 'replays').glob('*-NL*/report.json')):
    report = json.loads(path.read_text())
    assert not report['force_only'] and len(report['stages']) == 4
    assert report['all_three_backends_pointwise_equal'] and report['all_captured_atomic_folds_verified_on_gpu']
    for filename, expected in report['input_sha256'].items():
        assert hashlib.sha256(Path(filename).read_bytes()).hexdigest() == expected, filename
    with np.load(path.parent / 'contributions.npz') as data:
        fields = [name.removesuffix('_hardware_folds') for name in data.files if name.endswith('_hardware_folds')]
        assert len(fields) == 6
        for field in fields:
            hardware, after = data[field + '_hardware_folds'], data[field + '_after']
            assert hardware.shape == (6,) + after.shape
            assert np.all((hardware.view('u4') == after.view('u4')[None]).any(axis=0))
            folds += after.size
    isolated += sum(stage['isolated_scalar_checks'] for stage in report['stages'])
    touched += sum(sum(stage['captured_scalars_explained_by_exact_permutations'].values()) for stage in report['stages'])
    force_reports.append(str(path))
assert len(force_reports) == 18
result = {'source_sha256': build['extension_sha256'], 'reference_sha256': replay['reference_sha256'],
          'frozen_target': target, 'frozen_arrays_per_side': 18, 'diagnostic_reproduction': diagnostics,
          'pointwise_packets': span_calls, 'actual_three_backend_calls': actual_calls,
          'counter_words_strict': counter_words,
          'paired_pointwise_scalar_and_exact_alias_patterns_equal': len(normalized),
          'different_start_overlapping_spans': partial_overlap_calls, 'force_and_hessian_packets': 72,
          'isolated_force_and_hessian_scalar_checks': isolated, 'GPU_fold_scalar_checks': folds,
          'force_touched_scalar_checks': touched, 'force_reports': force_reports,
          'GPU_used_for_this_audit': False, 'complete_launch_geometry_captured': False,
          'production_atomic_schedule_inferred': False, 'complete_device_allocation_ownership_proven': False,
          'fixed_C10_still_failed': not json.loads((cohort / 'report.json').read_text())['every_array_and_step_within'],
          'frozen_candidate_replaced': False, 'cohort_expanded': False, 'production_changed': False,
          'whole_solver_complete': False, 'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(base / 'independent-frozen-path-audit.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps({key: value for key, value in result.items() if key not in ('force_reports', 'diagnostic_reproduction')},
                 indent=2))
