"""Recompute every saved pointwise output, real operand trace and hardware F32 order certificate from raw bytes."""
from collections import Counter
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

root = Path.cwd()
base = Path(__file__).resolve().parent
sys.path.insert(0, str(root))
plan = json.loads((base / 'plan.json').read_text())
for name, digest in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
for name in ('replay.status.json', 'certificates.status.json'):
    assert json.loads((base / name).read_text()) == {'exit': 0, 'complete': True, 'whole_solver_complete': False}
frozen = json.loads((base / 'capture-files-and-replay-source.json').read_text())
for name, entry in frozen['files'].items():
    payload = Path(name).read_bytes()
    assert len(payload) == entry['bytes'] and hashlib.sha256(payload).hexdigest() == entry['sha256']
replay = json.loads((base / 'replay/report.json').read_text())
certificates = json.loads((base / 'certificates/report.json').read_text())
certificate_plan = json.loads((base / 'certification-plan.json').read_text())
assert certificates['packet_count'] == len(certificates['packets']) == len(replay['packets']) == 120
assert certificates['certificates'] == certificate_plan['unique_target_count'] == 211
cert_lookup = {(row['side'], row['frame']): row for row in certificates['packets']}
target_lookup = {(row['side'], row['frame']): row['target_bits'] for row in certificate_plan['packets']}
counts, aggregate_matches = Counter(), Counter()
negative_operands, subnormal_operands = 0, 0
nonzero = {'original': [], 'source': []}
tiny = np.finfo('f4').tiny


def ftz(value):
    return np.copysign(np.float32(0), value) if 0 < abs(value) < tiny else value


for row in replay['packets']:
    side, frame = row['side'], row['frame']
    folder = base / side
    layout = json.loads((folder / 'readback-layout.json').read_text())
    matrix = layout['matrix']
    assert len(layout['tail_potential_writers']) == 19
    packet_path = folder / 'packets' / ('frame-' + str(frame).zfill(2) + '.npz')
    assert hashlib.sha256(packet_path.read_bytes()).hexdigest() == replay['input_sha256'][str(packet_path)]
    with np.load(packet_path) as packet, np.load(base / 'replay' / (side + '-' + packet_path.name)) as outputs:
        raw = [packet['parameter-' + str(index)].tobytes() for index in range(12)]
        assert [value.hex() for value in raw] == matrix['parameter_hex']
        pointers = [int.from_bytes(value, 'little') for value in raw]
        for index, size in layout['sizes'].items():
            index = int(index)
            assert packet['post-frame-arg-' + str(index)].nbytes == size
            for writer in layout['tail_potential_writers']:
                assert min(pointers[index] + size, writer['address'] + writer['bytes']) <= max(
                    pointers[index], writer['address'])
        for span in row['spans']:
            start = min(pointers[index] for index in span['indices'])
            assert start % 256 == span['original_start_mod256']
            assert span['offsets'] == {str(index): pointers[index] - start for index in span['indices']}
        expected = packet['post-frame-arg-6'].tobytes()
        captured_bits = packet['post-frame-arg-9'].view('<u4').tolist()
        direction = packet['post-frame-arg-4'].view('<f4')
        product = packet['post-frame-arg-6'].view('<f4')
        assert np.isfinite(direction).all() and np.isfinite(product).all()
        nonzero[side].append([int(np.count_nonzero(direction)), int(np.count_nonzero(product))])
        assert captured_bits == row['captured_aggregate_bits']
        expected_output_keys = set()
        targets = {captured_bits[0]}
        assert len(row['checks']) == 6
        for check in row['checks']:
            tag = check['backend'] + '-seed-' + str(check['controlled_Ap_seed_byte'])
            expected_output_keys.update((tag + '-ap', tag + '-denominator'))
            value = outputs[tag + '-ap']
            bits = outputs[tag + '-denominator'].view('<u4').tolist()
            assert value.tobytes() == expected
            assert hashlib.sha256(value.tobytes()).hexdigest() == check['pointwise_sha256']
            assert check['pointwise_equal'] and check['unwritten_bytes_unchanged']
            assert bits == check['aggregate_bits']
            assert check['captured_aggregate_equal'] == (bits == captured_bits)
            aggregate_matches[check['backend']] += bits == captured_bits
            targets.add(bits[0])
            counts['pointwise_outputs_recomputed_from_saved_bytes'] += 1
        assert set(outputs.files) == expected_output_keys
        assert sorted(targets) == target_lookup[(side, frame)]
    cert = cert_lookup[(side, frame)]
    assert cert['real_original_source_operands_equal'] and not cert['unexplained_bits']
    filename = side + '-frame-' + str(frame).zfill(2) + '.npz'
    with np.load(base / 'certificates' / filename) as proof:
        operands = proof['original-lane-operands']
        assert operands.tobytes() == proof['source-lane-operands'].tobytes()
        assert len(operands) == 176 and np.isfinite(operands).all()
        for backend in ('original', 'source'):
            actual_counts = proof[backend + '-counts']
            record = proof[backend + '-raw-atomic-records']
            assert actual_counts.shape == (256,) and np.all(actual_counts[:176] == 1)
            assert not actual_counts[176:].any() and record.shape == (176, 16)
            addresses = record[:, :8].copy().view('<u8').reshape(-1)
            assert addresses[0] and np.all(addresses == addresses[0])
            assert record[:, 8:12].copy().view('<f4').reshape(-1).tobytes() == operands.tobytes()
            counts['GPU_recorded_lane_operands'] += 176
        negatives = int(np.count_nonzero(operands < 0))
        subnormals = int(np.count_nonzero((np.abs(operands) > 0) & (np.abs(operands) < tiny)))
        assert negatives == cert['negative_operands'] and subnormals == cert['subnormal_operands']
        negative_operands += negatives
        subnormal_operands += subnormals
        assert {item['target_bits'] for item in cert['certificates']} == targets
        for item in cert['certificates']:
            word = item['target_bits']
            order, history = proof[str(word) + '-order'], proof[str(word) + '-hardware-history']
            assert np.array_equal(np.sort(order), np.arange(176, dtype=order.dtype))
            assert history.shape == (176,)
            accumulator = np.float32(0)
            for index, lane in enumerate(order):
                assert accumulator.tobytes() == history[index].tobytes()
                accumulator = ftz(np.float32(accumulator + ftz(operands[lane])))
            assert int(accumulator.view('u4')) == word
            assert item['passed'] and item['hardware_global_F32_atomic_verified']
            counts['hardware_atomic_certificates_recomputed'] += 1
            counts['hardware_atomic_history_values_recomputed'] += 176
assert counts['pointwise_outputs_recomputed_from_saved_bytes'] == 720
assert counts['hardware_atomic_certificates_recomputed'] == 211
assert all(all(item == [528, 528] for item in rows) and len(rows) == 60 for rows in nonzero.values())

fixed = base.parent / 'continuation-20261101-38b70dcd-g1-public-core/graph60-fixed-original-C8/report.json'
fixed_bytes = fixed.read_bytes()
assert hashlib.sha256(fixed_bytes).hexdigest() == json.loads((base / 'status.json').read_text())['fixed_C8_report_sha256']
diagnostics = json.loads((base / 'diagnostic-trajectories.json').read_text())
paths = json.loads(fixed_bytes)['input_npz_paths']
with ExitStack() as stack:
    original = [stack.enter_context(np.load(paths['original' + str(index)])) for index in range(8)]
    for side in ('original', 'source'):
        folder = base / side
        runtime = json.loads((folder / 'worker/runtime.json').read_text())
        assert runtime['exit'] == 0 and runtime['real_graph_observed'] and runtime['public_core_abi']
        assert not runtime['ab_bridge_used'] and runtime['reference_solver_mapped'] == (side == 'original')
        run = stack.enter_context(np.load(folder / 'worker/states.npz'))
        for key in run.files:
            actual = run[key].astype(np.float64)
            values = np.stack([item[key].astype(np.float64) for item in original])
            assert len(actual) == 60 and np.isfinite(actual).all()
            total, axes = values.sum(0), tuple(range(1, actual.ndim))
            envelope = np.maximum.reduce([
                np.abs(values[index] - (total - values[index]) / 7).max(axis=axes) for index in range(8)])
            error = np.abs(actual - total / 8).max(axis=axes)
            saved = diagnostics[side]['statistics'][key]
            assert int(np.count_nonzero(error <= envelope)) == saved['substeps_within_spread']
            assert float(error.max()) == saved['reconstruction_error_max']
            assert np.flatnonzero(error > envelope).tolist() == diagnostics[side]['outside'][key]['frames']

result = {'counts': dict(counts), 'aggregate_matches_of_240_per_backend': dict(aggregate_matches),
          'raw_operand_negative_values': negative_operands, 'raw_operand_subnormal_values': subnormal_operands,
          'all120_packets_have528_nonzero_direction_and_Ap_scalars': True,
          'all720_pointwise_outputs_strict': True, 'all211_hardware_atomic_certificates_valid': True,
          'actual_pre_call_output_bytes_captured': False, 'controlled_zero_seed': True,
          'actual_production_order_inferred': False, 'raw_unwritten_buffers_saved_for_CPU_recheck': False,
          'unwritten_buffers_checked_on_GPU_worker_via_full_readback': True,
          'fixed_C8_failure_reclassified': False, 'whole_solver_complete': False,
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(base / 'independent-cpu-audit.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(result, indent=2))
