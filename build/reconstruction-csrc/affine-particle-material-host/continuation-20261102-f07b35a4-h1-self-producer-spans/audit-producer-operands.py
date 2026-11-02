"""Independently normalize all real self F32 additions and append records, preserving actual query order."""
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
from reconstruction.csrc.library_entries import entries
from reconstruction.csrc.pcg_alias_replay import span_groups

report = json.loads((BASE / 'producer-operands-report.json').read_text())
terminal = json.loads((BASE / 'producer-operands.status.json').read_text())
assert terminal['complete'] and terminal['running'] is None
assert [row['actual_exit'] for row in terminal['completed']] == [0]
assert report['complete'] and report['actual_probe_calls'] == 16 and len(report['rows']) == 8
assert hashlib.sha256((BASE / 'producer-operands.py').read_bytes()).hexdigest() == report['runner_sha256']
hashes = dict(report['input_sha256'])
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
output = BASE / 'normalized-operands'
output.mkdir(exist_ok=False)
build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
plan = json.loads((BASE / 'full-inputs/plan.json').read_text())
rows, normals, total_F32, total_appends = [], {}, 0, 0
for case in report['rows']:
    tag = case['label'] + '-' + case['stage']
    with np.load(case['packet'], allow_pickle=False) as packet:
        nparams = sum(key.startswith('parameter-') for key in packet.files)
        raw = [packet[f'parameter-{i}'].tobytes() for i in range(nparams)]
        bindings = {int(key.rsplit('-', 1)[1]): packet[key].tobytes()
                    for key in packet.files if key.startswith('before-arg-')}
    values = [int.from_bytes(value, 'little') for value in raw]
    groups = span_groups(values, bindings)
    contact = case['contact_span']['argument']
    counter = case['contact_span']['counter_argument']
    before = int.from_bytes(bindings[counter], 'little')
    assert before == case['counter_before']
    allowed = {'vf': {11, 12}, 'ee': {9, 10}, 'ef': {10, 11}, 'tangent': {3}}[case['stage']]
    observed = []
    texts, _ = kernel_texts(build, plan['kernels'][case['stage']])
    for probe in case['probes']:
        path = Path(probe['file'])
        digest = hashlib.sha256(path.read_bytes()).hexdigest()
        assert digest == probe['sha256']
        hashes[str(path)] = digest
        ptx = BASE / 'producer-operands' / (case['stage'] + '-' + probe['side'] + '.ptx')
        original_entry = entries(texts[probe['side']])[plan['kernels'][case['stage']]]
        changed_entry = entries(ptx.read_text())[plan['kernels'][case['stage']]]
        original_body = original_entry[original_entry.index('{') + 1:original_entry.rindex('}')]
        changed_body = changed_entry[changed_entry.index('{') + 1:changed_entry.rindex('}')]
        remaining = iter(line.strip() for line in changed_body.splitlines())
        for line in original_body.splitlines():
            if line.strip():
                assert any(candidate == line.strip() for candidate in remaining), 'Original PTX body instruction lost'
        with np.load(path, allow_pickle=False) as data:
            actual = [data[f'actual-parameter-{i}'].tobytes() for i in range(nparams + 4)]
            actual_values = [int.from_bytes(value, 'little') for value in actual]
            regions = []
            for group in groups:
                padding = 256 + group['start'] % 256
                reserve = 437046060 if contact in group['indices'] else len(group['initial'])
                first = group['indices'][0]
                base = actual_values[first] - (values[first] - group['start']) - padding
                assert base % 256 == 0
                regions.append((base, base + padding + reserve + 256))
                for i in group['indices']:
                    assert actual_values[i] == base + padding + values[i] - group['start']
                    assert actual_values[i] % 256 == values[i] % 256
            for i in range(nparams):
                assert len(actual[i]) == len(raw[i])
                if i not in bindings:
                    assert actual[i] == raw[i]
            sizes = [case['trace_lanes'] * case['record_capacity'] * 16,
                     case['counts_lanes'] * 4, case['trace_lanes'] * 32 * 4, case['counts_lanes'] * 4]
            for pointer, size in zip(actual_values[nparams:], sizes, strict=True):
                assert pointer % 256 == 0
                regions.append((pointer, pointer + size))
            regions.sort()
            assert all(a[1] <= b[0] for a, b in zip(regions, regions[1:]))
            counts, app_counts = data['counts'], data['contact-append-counts']
            records, app_rows = data['raw-trace'], data['contact-append-rows']
            assert counts.shape == app_counts.shape == (case['counts_lanes'],)
            assert counts.dtype == app_counts.dtype == np.dtype('u4')
            assert not counts[case['active_lanes']:].any() and not app_counts[case['active_lanes']:].any()
            assert int(counts.max()) <= case['record_capacity'] and int(app_counts.max()) <= 31
            assert records.shape == (int(counts.sum()), 16) and records.dtype == np.dtype('u1')
            assert app_rows.shape == (int(app_counts.sum()),) and app_rows.dtype == np.dtype('u4')
            assert len(records) == probe['actual_atomic_records']
            assert len(app_rows) == probe['actual_contact_appends']
            assert not records[:, 12:].any() and probe['all_unused_trace_bytes_checked_zero']
            assert probe['readonly_and_full_tail_guard_checked']
            addresses = records[:, :8].copy().view('<u8').ravel()
            operands = records[:, 8:12].copy().view('<u4').ravel()
            assert np.isfinite(operands.view('f4')).all()
            targets, matched = np.zeros(len(records), dtype='u8'), np.zeros(len(records), dtype=bool)
            for i in allowed:
                span = case['outputs'][str(i)]
                assert span['address'] == actual_values[i]
                mask = (addresses >= span['address']) & (addresses < span['address'] + span['bytes'])
                assert not np.any(mask & matched)
                assert np.all((addresses[mask] - span['address']) % 4 == 0)
                targets[mask] = (np.uint64(i) << np.uint64(32)) | ((addresses[mask] - span['address']) // 4)
                matched |= mask
            assert matched.all()
            after = int.from_bytes(data.get(f'output-{counter}', np.frombuffer(bindings[counter], dtype='u1')).tobytes(),
                                   'little')
            assert after == probe['counter_after'] and len(app_rows) == after - before
            assert np.array_equal(np.sort(app_rows), np.arange(before, after, dtype='u4'))
            if case['stage'] == 'tangent':
                assert not len(app_rows) and np.all(counts[:case['active_lanes']] == 12)
                normalized_contacts = np.zeros((0, 60), dtype='u1')
            else:
                expected = (12 + 36 * app_counts) if case['stage'] == 'vf' else (
                    24 + (24 if case['stage'] == 'ee' else 36) * app_counts)
                assert np.array_equal(counts[:case['active_lanes']], expected[:case['active_lanes']])
                qarg = 5 if case['stage'] == 'ef' else 4
                query_counts = np.frombuffer(bindings[qarg], dtype='i4')
                assert np.all((query_counts >= 0) & (query_counts <= 31))
                assert np.all(app_counts[:case['active_lanes']] <= query_counts)
                table = data[f'output-{contact}']
                seed = np.frombuffer(bindings[contact], dtype='u1')
                assert np.array_equal(table[:before * 60], seed[:before * 60])
                assert np.array_equal(table[after * 60:], seed[after * 60:])
                normalized_contacts = table.reshape(-1, 60)[app_rows].copy()
                assert np.all(normalized_contacts.view('u4').reshape(-1, 15)[:, 14] == 4)
            observed.append({'counts': counts[:case['active_lanes']].copy(), 'targets': targets, 'operands': operands,
                             'append_counts': app_counts[:case['active_lanes']].copy(),
                             'contact_records': normalized_contacts})
            total_F32 += len(records)
            total_appends += len(app_rows)
    equal = all(np.array_equal(observed[0][key], observed[1][key]) for key in observed[0])
    destination = output / (tag + '.npz')
    np.savez_compressed(destination, **observed[0])
    hashes[str(destination)] = hashlib.sha256(destination.read_bytes()).hexdigest()
    normals[case['label'], case['stage']] = observed[0]
    rows.append({'tag': tag, 'F32_records_per_side': len(observed[0]['targets']),
                 'contact_appends_per_side': len(observed[0]['contact_records']),
                 'original_source_same_packet_ordered_F32_and_complete_contact_records_equal': equal,
                 'normalized_original_file': str(destination), 'sha256': hashes[str(destination)]})
    print('Actual query operands/contact rows independently audited:', rows[-1], flush=True)
cross = []
for stage in ('vf', 'ee', 'ef'):
    first, second = normals['sdk0', stage], normals['rebuilt0', stage]
    equal = all(np.array_equal(first[key], second[key]) for key in first)
    cross.append({'stage': stage, 'actual_query_F32_and_contact_records_equal_between_endpoints': equal})
target = BASE / 'producer-operands-independent-cpu.json'
assert not target.exists()
passed = all(row['original_source_same_packet_ordered_F32_and_complete_contact_records_equal'] for row in rows)
passed = passed and all(row['actual_query_F32_and_contact_records_equal_between_endpoints'] for row in cross)
hashes[str(Path(__file__))] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
target.write_text(json.dumps({'cases': rows, 'cross_endpoint_producers': cross, 'input_sha256': hashes,
    'actual_F32_records_checked': total_F32, 'actual_contact_append_rows_checked': total_appends,
    'all_same_packet_ordered_operands_and_appends_equal': passed,
    'all_original_PTX_body_instructions_retained_in_instrumented_entries': True,
    'all_raw_traces_losslessly_recoverable_from_lane_counts_packed_records_and_checked_zero_slots': True,
    'tangent_cross_endpoint_direction_and_contact_order_not_assumed_equal': True,
    'native_SDK_per_query_isolation_not_yet_performed': True,
    'fixed_C8_or_aggregate_failures_rejudged': False, 'GPU_runs': 0, 'whole_solver_complete': False}, indent=2) + '\n')
print('Self operand/contact audit complete:', total_F32, total_appends, passed, cross)
raise SystemExit(0 if passed else 1)
