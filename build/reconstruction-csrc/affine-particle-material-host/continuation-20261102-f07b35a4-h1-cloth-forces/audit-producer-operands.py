"""Audit all recorded atomic operands and compare contact-corresponding rows without altering production inputs."""
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.pcg_alias_replay import span_groups

report_path = BASE / 'producer-operands-report.json'
report = json.loads(report_path.read_text())
assert report['complete'] and report['actual_probe_calls'] == 8 and len(report['rows']) == 4
assert hashlib.sha256((BASE / 'producer-operands.py').read_bytes()).hexdigest() == report['runner_sha256']
for path, expected in report['input_sha256'].items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
hashes, normals, contact_rows, rows = {}, {}, {}, []
total_records = 0
for case in report['rows']:
    packet_path = Path(case['packet'])
    with np.load(packet_path, allow_pickle=False) as packet:
        parameter_count = len([key for key in packet.files if key.startswith('parameter-')])
        raw = [packet[f'parameter-{i}'].tobytes() for i in range(parameter_count)]
        bindings = {int(key.rsplit('-', 1)[1]): packet[key].tobytes()
                    for key in packet.files if key.startswith('before-arg-')}
        if case['stage'].startswith('soft'):
            count = case['active_lanes']
            contact_rows[case['label'], case['stage']] = np.concatenate([
                packet[f'before-arg-{i}'][:count * width].reshape(count, width)
                for i, width in [(2, 4), (3, 4), (4, 12), (5, 12), (6, 12)]], axis=1).copy().view('V44').reshape(-1)
    values = [int.from_bytes(value, 'little') for value in raw]
    groups = span_groups(values, bindings)
    observed = []
    for probe in case['probes']:
        path = Path(probe['file'])
        sha = hashlib.sha256(path.read_bytes()).hexdigest()
        assert sha == probe['sha256']
        hashes[str(path)] = sha
        with np.load(path, allow_pickle=False) as data:
            actual = [data[f'actual-parameter-{i}'].tobytes() for i in range(parameter_count + 2)]
            for i, value in enumerate(raw):
                assert len(actual[i]) == len(value)
                if i in bindings:
                    assert int.from_bytes(actual[i], 'little') % 256 == values[i] % 256
                else:
                    assert actual[i] == value
            for group in groups:
                for left in group['indices']:
                    for right in group['indices']:
                        assert int.from_bytes(actual[left], 'little') - int.from_bytes(actual[right], 'little') == \
                            values[left] - values[right]
            records, counts = data['raw-trace'], data['counts']
            assert records.shape == (case['trace_lanes'], 128, 16) and records.dtype == np.uint8
            assert counts.shape == (case['counts_lanes'],) and counts.dtype == np.uint32
            assert not counts[case['active_lanes']:].any() and int(counts.max()) <= 128
            used = np.arange(128)[None, :] < counts[:case['trace_lanes'], None]
            assert not records[~used].any() and not records[:, :, 12:].any()
            selected = records[used]
            assert len(selected) == probe['actual_atomic_records'] == int(counts.sum())
            addresses = selected[:, :8].copy().view('<u8').reshape(-1)
            operands = selected[:, 8:12].copy().view('<u4').reshape(-1)
            assert np.isfinite(operands.view('f4')).all()
            target_ids, matches = np.zeros(len(selected), dtype='u8'), np.zeros(len(selected), dtype=bool)
            for index, output in case['outputs'].items():
                i = int(index)
                assert int.from_bytes(actual[i], 'little') == output['address']
                valid = (addresses >= output['address']) & (addresses < output['address'] + output['bytes'])
                assert not np.any(matches & valid)
                offsets = (addresses[valid] - output['address']) // 4
                assert np.all((addresses[valid] - output['address']) % 4 == 0)
                if case['stage'] == 'membrane' and i == 7:
                    assert np.all(offsets % 10 != 0), 'An integer column field was treated as an atomic float target'
                    assert np.array_equal(data['output-7'].view('u4').reshape(-1, 10)[:, 0],
                                          np.frombuffer(bindings[7], dtype='u4').reshape(-1, 10)[:, 0])
                target_ids[valid] = (np.uint64(i) << np.uint64(32)) | offsets
                matches |= valid
            assert matches.all()
            normalized = {'counts': counts[:case['active_lanes']].copy(), 'targets': target_ids, 'operands': operands}
            observed.append(normalized)
            total_records += len(selected)
    equal = all(observed[0][field].tobytes() == observed[1][field].tobytes()
                for field in ('counts', 'targets', 'operands'))
    normals[case['label'], case['stage']] = observed[0]
    rows.append({'label': case['label'], 'stage': case['stage'], 'records_per_side': len(observed[0]['targets']),
                 'actual_original_source_ordered_per_thread_operands_equal': equal,
                 'all_record_targets_within_declared_outputs': True, 'inactive_and_unused_trace_bytes_zero': True})


def reordered(normalized, order):
    offsets = np.concatenate(([0], np.cumsum(normalized['counts'], dtype='i8')))
    return {'counts': normalized['counts'][order], **{
        field: np.concatenate([normalized[field][offsets[i]:offsets[i + 1]] for i in order])
        for field in ('targets', 'operands')}}


cross = []
for stage in ('stretch', 'bend'):
    old, new = normals['sdk0', stage], normals['rebuilt0', stage]
    if stage.startswith('soft'):
        a, b = contact_rows['sdk0', stage], contact_rows['rebuilt0', stage]
        first, second = np.argsort(a, kind='stable'), np.argsort(b, kind='stable')
        assert a[first].tobytes() == b[second].tobytes()
        old, new = reordered(old, first), reordered(new, second)
    equal = all(old[field].tobytes() == new[field].tobytes() for field in ('counts', 'targets', 'operands'))
    cross.append({'stage': stage, 'records': len(old['targets']), 'corresponding_actual_operands_equal': equal,
                  'production_contact_order_changed': False})
target = BASE / 'producer-operands-independent-cpu.json'
assert not target.exists()
target.write_text(json.dumps({'cases': rows, 'cross_endpoint': cross, 'total_actual_records_checked': total_records,
    'input_sha256': hashes, 'all_packet_PTX_operands_equal': all(
        row['actual_original_source_ordered_per_thread_operands_equal'] for row in rows),
    'native_SDK_per_primitive_isolation_completed': False, 'joint_global_atomic_schedule_proven': False,
    'full_trajectory_or_C8_rejudged': False, 'GPU_runs': 0, 'whole_solver_complete': False}, indent=2) + '\n')
print('Actual PTX operand audit:', rows)
print('Actual records checked:', total_records, '; cross-endpoint contact/triangle correspondence:', cross)
