"""Independently audit all native cloth outputs and diagnostic controls with the frozen integer F32 adder."""
import ast
from collections import Counter
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
previous = BASE.parent / 'continuation-20261102-f07b35a4-h1-first-cg'
frozen = json.loads((previous / 'completion-manifest.json').read_text())
adder_path = previous / 'audit-membrane-native-isolation.py'
adder_raw = adder_path.read_bytes()
assert hashlib.sha256(adder_raw).hexdigest() == frozen['files'][str(adder_path.relative_to(ROOT))]['sha256']
adder_ast = ast.parse(adder_raw.decode())
function = next(node for node in adder_ast.body if isinstance(node, ast.FunctionDef) and node.name == 'integer_add')
namespace = {}
exec(compile(ast.Module(body=[function], type_ignores=[]), str(adder_path), 'exec'), namespace)
integer_add = namespace['integer_add']
terminal = json.loads((BASE / 'cloth-native-isolation.status.json').read_text())
assert terminal['complete'] and terminal['running'] is None
assert [row['actual_exit'] for row in terminal['completed']] == [0, 0, 0, 0]
assert all(row['free_memory_MiB'] >= 4096 for row in terminal['GPU_admission'])
plan = json.loads((BASE / 'cloth-native-isolation-plan.json').read_text())
hashes = dict(plan['input_sha256'])
hashes[str(adder_path)] = hashlib.sha256(adder_raw).hexdigest()
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
prepared = json.loads((BASE / 'cloth-native-inputs-v2/plan.json').read_text())
operands = json.loads((BASE / 'producer-operands-report.json').read_text())
assert plan['case_tags'] == [row['tag'] for row in prepared['cases']]
counts, rows = Counter(), []
for case in prepared['cases']:
    folder = BASE / 'cloth-native-isolation' / case['tag']
    report = json.loads((folder / 'report.json').read_text())
    assert report['complete'] and report['primitives'] == case['count']
    assert report['actual_calls'] == case['count'] * 3
    assert report['backends'] == ['original-runtime', 'original-ptx', 'source-ptx']
    assert report['source_host_sha256'] == 'f07b35a4733a3196cf66bc22617bfbe1bd23a03ce16772f3df9b18e2819a3b20'
    assert report['reference_sha256'] == '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
    index = case['output_arg']
    with np.load(case['packet'], allow_pickle=False) as packet:
        seed = packet[f'before-arg-{index}'].view('u4').copy()
        address = int.from_bytes(packet[f'parameter-{index}'].tobytes(), 'little')
    padding = 256 + address % 256
    main = np.full(padding // 4 + len(seed) + 64, 0xd3d3d3d3, dtype='u4')
    main[padding // 4:padding // 4 + len(seed)] = seed
    baseline = [main, np.full(128, 0xd3d3d3d3, dtype='u4')]
    n0, n1 = map(len, baseline)
    assert report['full_output_and_guard_words_checked_per_backend_call'] == n0 + n1
    controls = json.loads((folder / 'helper-controls.json').read_text())
    assert controls['complete'] and controls['all_word_counts_including_guards'] == [n0, n1]
    points = sorted(set([0, padding // 4, n0 // 2, n0 - 1, n0, n0 + n1 // 2, n0 + n1 - 1]))
    assert [row['mutated_word_indices'] for row in controls['controls']] == [[], *[[i] for i in points], points]
    for control in controls['controls']:
        expected = [array.copy() for array in baseline]
        selected = control['mutated_word_indices']
        for point in selected:
            side, offset = (0, point) if point < n0 else (1, point - n0)
            expected[side][offset] ^= np.uint32(1)
        assert control['GPU_status'] == [len(selected), min(selected) if selected else 0xffffffff]
        assert control['complete_CPU_readback_verified']
        assert control['actual_complete_sha256'] == [hashlib.sha256(array.tobytes()).hexdigest() for array in expected]
    probe_case = next(row for row in operands['rows'] if
                      row['label'] == case['label'] and row['stage'] == case['stage'])
    with np.load(case['trace'], allow_pickle=False) as packet:
        trace = packet['raw-trace'][:case['count'], :12].copy()
        raw_counts = packet['counts'][:case['count']].copy()
        assert not packet['counts'][case['count']:].any()
    addresses = trace.view('u8').reshape(case['count'], 12, 2)[:, :, 0]
    raw_operands = trace.view('u4').reshape(case['count'], 12, 4)[:, :, 2]
    raw_used = np.arange(12)[None, :] < raw_counts[:, None]
    span = probe_case['outputs'][str(index)]
    raw_targets = np.zeros(raw_counts.shape + (12,), dtype='u4')
    assert np.all((addresses[raw_used] >= span['address']) &
                  (addresses[raw_used] < span['address'] + span['bytes']))
    raw_targets[raw_used] = (addresses[raw_used] - span['address']) // 4
    case_steps = 0
    assert len(case['chunks']) == len(report['chunks'])
    for original, actual in zip(case['chunks'], report['chunks'], strict=True):
        left, right = original['start'], original['stop']
        assert (left, right) == (actual['start'], actual['stop'])
        for descriptor in (original, actual):
            path = Path(descriptor['file'])
            assert hashlib.sha256(path.read_bytes()).hexdigest() == descriptor['sha256']
            hashes[str(path)] = descriptor['sha256']
        with np.load(original['file'], allow_pickle=False) as archive:
            data = {key: archive[key] for key in archive.files}
        assert np.array_equal(data['counts'], raw_counts[left:right])
        assert np.array_equal(data['targets'], raw_targets[left:right])
        assert np.array_equal(data['operands'], raw_operands[left:right])
        used = raw_used[left:right]
        assert np.all(data['targets'][used] < len(seed))
        assert np.array_equal(data['before'][used], seed[data['targets'][used]])
        assert not data['before'][~used].any() and not data['after'][~used].any()
        result = np.fromiter((integer_add(int(a), int(b)) for a, b in
                             zip(data['before'][used], data['operands'][used], strict=True)), dtype='u4')
        assert np.array_equal(result, data['after'][used])
        with np.load(actual['file'], allow_pickle=False) as archive:
            words, statuses = archive['actual_words'], archive['complete_comparison_status']
            assert words.shape == (right - left, 3, 12) and statuses.shape == (right - left, 3, 2)
            assert not statuses[:, :, 0].any() and np.all(statuses[:, :, 1] == 0xffffffff)
            assert np.array_equal(words, np.broadcast_to(data['after'][:, None, :], words.shape))
        case_steps += int(used.sum())
        counts['primitives'] += right - left
        counts['actual_native_PTX_source_calls'] += (right - left) * 3
        counts['full_RHS_guard_and_dummy_words_GPU_compared'] += (right - left) * 3 * (n0 + n1)
        counts['actual_valid_target_words_recorded'] += int(used.sum()) * 3
    assert case_steps == case['atomic_records']
    counts['independent_integer_F32_steps'] += case_steps
    for path in (folder / 'report.json', folder / 'helper-controls.json'):
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    rows.append({'tag': case['tag'], 'primitives': case['count'], 'integer_F32_steps': case_steps,
                 'all_three_backends_full_outputs_strict': True, 'all_negative_controls_CPU_verified': True})
    print('Independent cloth native CPU audit:', rows[-1], flush=True)
assert counts['primitives'] == 335128 and counts['actual_native_PTX_source_calls'] == 1005384
assert counts['independent_integer_F32_steps'] == 3608484
hashes[str(Path(__file__))] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
target = BASE / 'cloth-native-isolation-independent-cpu.json'
assert not target.exists()
target.write_text(json.dumps({'cases': rows, 'counts': dict(counts), 'input_sha256': hashes,
    'integer_adder_from_immutable_independent_previous_auditor_not_GPU_worker': True,
    'all_full_outputs_determined_losslessly_by_seeds_actual_gathers_and_complete_GPU_word_checks': True,
    'all_full_word_comparator_controls_reconstructed_on_CPU': True,
    'original_aggregate_or_C8_failures_rejudged': False, 'joint_global_schedule_proven': False,
    'GPU_runs': 0, 'whole_solver_complete': False}, indent=2) + '\n')
print('All actual cloth SDK/PTX/f07 primitive outputs audited:', dict(counts))
