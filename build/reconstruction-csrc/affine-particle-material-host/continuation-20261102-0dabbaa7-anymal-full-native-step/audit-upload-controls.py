"""Independently audit real upload-fence controls, input/address identity and lost-output bytes without GPU use."""
from collections import Counter
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
OUTPUT = BASE / 'upload-control-independent-cpu.json'
assert not OUTPUT.exists()
source_plan_path = BASE / 'capture/full-input-replays/plan.json'
source_plan = json.loads(source_plan_path.read_text())
hashes = {str(source_plan_path): hashlib.sha256(source_plan_path.read_bytes()).hexdigest()}
summaries = []
for name, bad_expected, balanced in [('upload-sync-control', 13, False), ('upload-sync-control-balanced', 6, True)]:
    directory = BASE / name
    plan = json.loads((directory / 'full-input-replays/plan.json').read_text())
    report = json.loads((directory / 'full-input-replays/report.json').read_text())
    cpu = json.loads((directory / 'replay-independent-cpu-audit.json').read_text())
    assert report['complete'] and report['actual_calls'] == 4500 and len(report['packets']) == 1500
    assert cpu['counts']['actual_calls'] == 4500
    counts, failed = Counter(), []
    for left, right in zip(plan['packets'][::2], plan['packets'][1::2]):
        assert left['source_packet_index'] == right['source_packet_index']
        assert left['control_repeat'] == right['control_repeat']
        assert left['diagnostic_upload_fence'] is False and right['diagnostic_upload_fence'] is True
        original = source_plan['packets'][left['source_packet_index']]
        for packet in (left, right):
            assert all(packet[key] == original[key] for key in ('worker', 'frame', 'stage', 'input'))
        with np.load(original['input'], allow_pickle=False) as data:
            key = original['stage']['key'] + '/before/'
            body_indices = data[key + 'arg-1'].view('<i4').reshape(17, 4)
            all_indices = np.concatenate([body_indices + world * 68 for world in range(8)]).reshape(-1)
            assert np.array_equal(np.sort(all_indices), np.arange(544))
            assert not data[key + 'arg-5'].any()
    for left, right in zip(report['packets'][::2], report['packets'][1::2]):
        assert left['pointers'] == right['pointers']
        if balanced:
            assert [c['backend'] for c in left['checks']] == [c['backend'] for c in right['checks']]
    for packet, row in zip(plan['packets'], report['packets']):
        fence = packet['diagnostic_upload_fence']
        strict = all(check['all_complete_outputs_strict'] for check in row['checks'])
        counts[f'{fence}/{strict}'] += 1
        if strict:
            continue
        assert not fence
        with np.load(packet['input'], allow_pickle=False) as captured, np.load(row['output']) as actual:
            target = captured[packet['stage']['key'] + '/after/arg-5'].view('<u4')
            for check in row['checks']:
                if check['all_complete_outputs_strict']:
                    continue
                side = check['backend']
                observed = actual[side + '-output-arg-5'].view('<u4')
                different = observed != target
                failed.append({'row': row['number'], 'backend': side, 'source_packet': packet['source_packet_index'],
                               'different_words': int(different.sum()),
                               'wrong_words_overwritten_to_positive_zero': int(np.count_nonzero(different & (observed == 0))),
                               'raw_output': row['output'], 'raw_sha256': row['output_sha256']})
        path = Path(row['output'])
        assert hashlib.sha256(path.read_bytes()).hexdigest() == row['output_sha256']
    assert counts['True/True'] == 750 and counts['False/False'] == bad_expected
    assert counts['False/True'] == 750 - bad_expected and not counts['True/False']
    summaries.append({'control': name, 'same_backend_order_in_each_pair': balanced, 'same_pointer_addresses_all750_pairs': True,
                      'unsafe_failed_packets': bad_expected, 'fenced_strict_packets': 750,
                      'SO3_proxy_targets_unique_no_interthread_atomic_collisions': True, 'actual_failures': failed})
    for relative in ('full-input-replays/plan.json', 'full-input-replays/report.json', 'replay-independent-cpu-audit.json'):
        path = directory / relative
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
OUTPUT.write_text(json.dumps({'controls': summaries, 'input_sha256': hashes, 'GPU_used_for_this_audit': False,
    'kernel_arithmetic_or_launch_geometry_changed': False, 'production_changed': False,
    'whole_solver_complete': False}, indent=2) + '\n')
print('CPU controls verified:13 and6 unsafe failures;both750 fenced strict;unique proxy targets and identical inputs/addresses')
