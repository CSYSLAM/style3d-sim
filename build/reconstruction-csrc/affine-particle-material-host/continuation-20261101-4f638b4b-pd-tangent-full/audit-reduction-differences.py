"""Independently audit all raw operand traces, SDK isolation buffers, ABI bytes and joint GPU F32 histories."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
folder = BASE / 'reduction-differences'
plan = json.loads((folder / 'plan.json').read_text())
report_path = folder / 'report.json'
report = json.loads(report_path.read_text())
assert report['complete'] and report['error'] is None and len(report['cases']) == len(plan['cases']) == 131
hashes = dict(plan['input_sha256'])
hashes.update({str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in (Path(__file__), report_path)})
metrics = {'cases': 0, 'raw_operands_per_backend': 0, 'base_parameter_bytes': 0, 'RO_guard_bytes': 0,
           'pointwise_bytes': 0, 'isolated_three_backend_words': 0, 'actual_map_readback_words': 0,
           'joint_vectors': 0, 'joint_scalar_words': 0, 'joint_history_words': 0, 'actual_calls': 0}
backends = ('SDK-runtime', 'original-ptx', 'source-ptx')


def ftz(value):
    return np.copysign(np.float32(0), value) if 0 < abs(value) < np.finfo('f4').tiny else value


for case, row in zip(plan['cases'], report['cases']):
    packet, replay = case['packet'], case['replay']
    assert replay['number'] == row['packet_number']
    stage, counter, point, world = packet['stage'], case['counter'], case['point'], case['world']
    path = Path(row['output'])
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    assert hashes[str(path)] == row['output_sha256']
    with np.load(packet['input'], allow_pickle=False) as saved:
        before = {b['argument']: saved[stage['key'] + '/before/' + b['label']].copy() for b in stage['bindings']}
        point_target = saved[stage['key'] + '/after/arg-' + str(point)].tobytes()
        captured = saved[stage['key'] + '/after/arg-' + str(counter)].tobytes()
    with np.load(replay['output'], allow_pickle=False) as saved:
        targets = {backend: saved[backend + '-output-arg-' + str(counter)].tobytes() for backend in backends}
    targets['captured'] = captured
    with np.load(path, allow_pickle=False) as data:
        assert data['captured-counter'].tobytes() == captured
        for backend in backends:
            assert data[backend + '-replayed-counter'].tobytes() == targets[backend]
        map_expected = np.arange(36, dtype='<i4')
        assert data['controlled-map-input'].tobytes() == map_expected.tobytes()
        prefix = row['controlled_prefix']
        assert prefix >= 256 and prefix % 256 == row['pointers'][str(counter)] % 256
        raw = [bytearray.fromhex(v) for v in stage['node']['parameter_hex']]
        for binding in stage['bindings']:
            i = binding['argument']
            meta = row['buffer_metadata'][str(i)]
            assert row['pointers'][str(i)] == meta['base'] + meta['prefix']
            assert row['pointers'][str(i)] % 256 == binding['address'] % 256
            raw[i][:] = row['pointers'][str(i)].to_bytes(8, 'little')
        for tag in ('original-probe', 'source-probe', *(b + '-isolated' for b in backends)):
            actual = [bytearray(v) for v in raw]
            isolated = tag.endswith('-isolated')
            if isolated:
                actual[world][:] = row['controlled_map_pointer'].to_bytes(8, 'little')
                actual[counter][:] = (row['controlled_base'] + prefix).to_bytes(8, 'little')
            for i, value in enumerate(actual):
                assert data[tag + '-parameter-' + str(i)].tobytes() == bytes(value)
                metrics['base_parameter_bytes'] += len(value)
            for i, value in before.items():
                meta = row['buffer_metadata'][str(i)]
                offset = meta['prefix']
                expected = np.full(offset + len(value) + 256, 211, dtype='u1')
                expected[offset:offset + len(value)] = value
                mask = np.ones(len(expected), dtype=bool)
                if i == point or (i == counter and not isolated):
                    mask[offset:offset + len(value)] = False
                after = data[tag + '-buffer-' + str(i)]
                assert after.shape == expected.shape and after.dtype == np.dtype('u1')
                assert after[mask].tobytes() == expected[mask].tobytes()
                metrics['RO_guard_bytes'] += int(mask.sum())
                if i == point:
                    assert after[offset:offset + len(value)].tobytes() == point_target
                    metrics['pointwise_bytes'] += len(value)
        values = []
        for side in ('original', 'source'):
            counts, trace = data[side + '-trace-counts'], data[side + '-raw-trace']
            assert counts.shape == (256,) and trace.shape == (256, 128, 16)
            assert np.all(counts[:36] == 1) and not counts[36:].any()
            addresses = trace[:36, 0, :8].copy().view('<u8').reshape(-1)
            expected = row['pointers'][str(counter)] + (np.arange(36, dtype='<u8') // 12) * 4
            assert np.array_equal(addresses, expected)
            operands = trace[:36, 0, 8:12].copy().view('<f4').reshape(-1)
            assert np.isfinite(operands).all() and operands.tobytes() == data[side + '-raw-operands'].tobytes()
            values.append(operands.copy())
        assert values[0].tobytes() == values[1].tobytes()
        metrics['raw_operands_per_backend'] += len(values[0])
        effective = data['effective-row-buffer']
        assert len(effective) == prefix + 144 + 256
        assert np.all(effective[:prefix] == 211) and np.all(effective[prefix + 144:] == 211)
        normalized = np.asarray([ftz(value) for value in values[0]], dtype='<f4')
        zero_added = np.asarray([ftz(np.float32(np.float32(0) + value)) for value in normalized], dtype='<f4')
        assert effective[prefix:prefix + 144].tobytes() == zero_added.tobytes()
        for backend in backends:
            tag = backend + '-isolated'
            actual = data[tag + '-controlled-buffer']
            assert actual.tobytes() == effective.tobytes()
            assert data[tag + '-controlled-map-readback'].tobytes() == map_expected.tobytes()
            metrics['isolated_three_backend_words'] += 36
            metrics['actual_map_readback_words'] += 36
        origins = []
        for certificate in row['certificates']:
            tag = certificate['tag']
            order, groups = data[tag + '-order'], data[tag + '-groups']
            assert sorted(order.tolist()) == list(range(36))
            assert groups.tobytes() == (np.arange(36, dtype='<u4') // 12).tobytes()
            assert data[tag + '-operands'].tobytes() == values[0].tobytes()
            totals, history = np.zeros(3, dtype='<f4'), []
            for lane in order:
                group = int(groups[lane])
                history.append(totals[group])
                totals[group] = ftz(np.float32(ftz(totals[group]) + normalized[lane]))
            target = np.asarray(certificate['target_bits'], dtype='<u4').tobytes()
            assert totals.tobytes() == target
            for origin in certificate['origins']:
                assert targets[origin] == target
                origins.append(origin)
            total_buffer, history_buffer = data[tag + '-total-buffer'], data[tag + '-history-buffer']
            assert total_buffer.shape == (524,) and history_buffer.shape == (656,)
            assert total_buffer[256:268].tobytes() == target
            assert history_buffer[256:400].tobytes() == np.asarray(history, dtype='<f4').tobytes()
            for actual, end in ((total_buffer, 268), (history_buffer, 400)):
                assert np.all(actual[:256] == 211) and np.all(actual[end:] == 211)
            parameters = [data[tag + '-parameter-' + str(i)].tobytes() for i in range(6)]
            assert [len(v) for v in parameters] == [8, 8, 8, 8, 8, 4]
            assert int.from_bytes(parameters[-1], 'little') == 36
            metrics['joint_vectors'] += 1
            metrics['joint_scalar_words'] += 3
            metrics['joint_history_words'] += 36
        assert sorted(origins) == sorted(targets)
        metrics['actual_calls'] += 6 + len(row['certificates'])
        metrics['cases'] += 1
assert metrics['actual_calls'] == report['actual_calls'] == 1048
assert metrics['raw_operands_per_backend'] == 4716 and metrics['joint_vectors'] == 262
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
record = {'metrics': metrics, 'input_sha256': hashes, 'GPU_used_for_this_audit': False,
          'actual_global_schedule_inferred': False, 'strict_counter_failures_reclassified': False,
          'original_fixed_failure_reclassified': False, 'whole_solver_complete': False}
(BASE / 'reduction-independent-cpu-audit.json').write_text(json.dumps(record, indent=2) + '\n')
print('Independent CPU reduction proof audit:', metrics)
