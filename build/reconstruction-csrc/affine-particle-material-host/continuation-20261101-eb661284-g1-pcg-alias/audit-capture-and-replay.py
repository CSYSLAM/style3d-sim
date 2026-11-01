"""Independently audit actual PCG span intersections, paired ABI and saved replay evidence without a GPU."""
from collections import Counter
import hashlib
import itertools
import json
from pathlib import Path

import numpy as np

base = Path(__file__).resolve().parent
capture = base / 'first-step'
report = json.loads((base / 'replay/report.json').read_text())
provenance = json.loads((capture / 'provenance.json').read_text())
assert len(report['packets']) == 1000
for path, digest in report['input_sha256'].items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest, path
for path, digest in provenance['files'].items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest, path
rows = {(row['side'], row['launch']): row for row in report['packets']}
pointer_rows, scalar_pairs, offset_pairs, flags, null_worlds = 0, 0, 0, Counter(), 0
aggregate_matches, checked_files = Counter(), {}
paired = {}
for side in ('legacy', 'source'):
    folder = capture / side / 'actual'
    files = sorted(folder.glob('*.json'))
    assert len(files) == 500
    for sequence, path in enumerate(files):
        assert int(path.name.split('.')[0]) == sequence
        metadata = json.loads(path.read_text())
        schema = provenance['schema'][metadata['name']]
        pointer_indices = [i for i, kind in enumerate(schema['types']) if '*' in kind]
        assert pointer_indices == schema['pointer_indices']
        prefix = path.name[:-4]
        raw = [(folder / (prefix + f'before.param_{i}.bin')).read_bytes() for i in range(len(schema['widths']))]
        assert list(map(len, raw)) == schema['widths']
        values = [int.from_bytes(data, 'little') for data in raw]
        precondition = '23precondition_and_reduce' in metadata['name']
        labels = ({0: 'inverse', 1: 'r', 2: 'z', 4: 'world', 6: 'numerator'} if precondition else
                  {0: 'row_count', 1: 'entries', 3: 'blocks', 4: 'p', 5: 'extra', 6: 'ap',
                   7: 'world', 9: 'denominator'})
        spans = {}
        for index in pointer_indices:
            payload = folder / (prefix + 'before.' + labels[index] + '.bin')
            assert payload.exists() == bool(values[index])
            if payload.exists():
                spans[index] = (values[index], values[index] + payload.stat().st_size)
        overlaps = []
        for left, right in itertools.combinations(sorted(spans), 2):
            size = min(spans[left][1], spans[right][1]) - max(spans[left][0], spans[right][0])
            if size > 0:
                overlaps.append((left, right, size))
        assert not overlaps
        row = rows[side, path.name]
        assert not row['overlaps'] and len(row['groups']) == len(spans)
        for group in row['groups']:
            assert len(group['indices']) == 1
            index = group['indices'][0]
            assert group['bytes'] == spans[index][1] - spans[index][0]
            assert group['offsets'] == {str(index): 0}
            assert group['original_start_mod256'] == values[index] % 256
        assert {item['backend'] for item in row['checks']} == {'original-runtime', 'original-ptx', 'source-ptx'}
        pointwise = 'z' if precondition else 'ap'
        expected = (folder / (prefix + 'after.' + pointwise + '.bin')).read_bytes()
        assert len(expected) == row['particles'] * 12 and np.isfinite(np.frombuffer(expected, dtype='<f4')).all()
        for item in row['checks']:
            assert item['pointwise_equal'] and item['unwritten_bytes_unchanged']
            assert item['pointwise_sha256'] == hashlib.sha256(expected).hexdigest()
            assert item['captured_aggregate_equal'] == (item['aggregate_bits'] == row['captured_aggregate_bits'])
            aggregate_matches[item['backend']] += item['captured_aggregate_equal']
        if precondition:
            flags[values[3]] += 1
        null_worlds += values[4 if precondition else 7] == 0
        pointer_rows += 1
        anchor = next(values[i] for i in pointer_indices if values[i])
        normalized = (metadata, [data for i, data in enumerate(raw) if i not in pointer_indices],
                      [values[i] - anchor if values[i] else None for i in pointer_indices])
        if side == 'legacy':
            paired[path.name] = normalized
        else:
            other = paired[path.name]
            assert metadata == other[0]
            scalar_pairs += normalized[1] == other[1]
            offset_pairs += normalized[2] == other[2]
    checked_files[side] = len(list(folder.iterdir()))
assert pointer_rows == 1000 and scalar_pairs == offset_pairs == 500
assert flags == {0: 500} and null_worlds == 1000
result = {'source_sha256': report['source_sha256'], 'reference_sha256': report['reference_sha256'],
          'actual_packets': pointer_rows, 'overlapping_packets': 0, 'raw_files': checked_files,
          'paired_complete_geometry_equal': 500, 'paired_scalar_bytes_equal': scalar_pairs,
          'paired_relative_pointer_offsets_equal': offset_pairs, 'null_world_packets': null_worlds,
          'precomputed_false_packets': flags[0], 'pointwise_matches': 3000,
          'unwritten_bytes_unchanged_checks': 3000, 'captured_aggregate_matches': dict(aggregate_matches),
          'GPU_used': False, 'production_changed': False, 'whole_allocation_layout_proven': False,
          'frozen_failure_path_compared': False, 'whole_solver_complete': False,
          'replay_report_sha256': hashlib.sha256((base / 'replay/report.json').read_bytes()).hexdigest(),
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(base / 'independent-audit.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(result, indent=2))
