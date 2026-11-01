"""Find the first actual semantic payload difference of the reproduced current frozen paths."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
pair = BASE / 'frozen-reproduced-mixed-pair'
folders = [pair / side / 'native' for side in ('legacy', 'source')]
metadata = sorted(path.name for path in folders[0].glob('*.json') if path.name != 'deferred-receipt.json')
assert len(metadata) == 402
assert metadata == sorted(path.name for path in folders[1].glob('*.json') if path.name != 'deferred-receipt.json')
inputs, rows = {}, []


def read(path):
    data = path.read_bytes()
    inputs[str(path)] = hashlib.sha256(data).hexdigest()
    return data


for name in metadata:
    descriptions = [json.loads(read(folder / name)) for folder in folders]
    assert descriptions[0] == descriptions[1]
    prefix = name[:-4]
    for phase in ('before', 'after'):
        names = sorted(path.name for path in folders[0].glob(prefix + phase + '.*.bin')
                       if '.param_' not in path.name)
        assert names == sorted(path.name for path in folders[1].glob(prefix + phase + '.*.bin')
                               if '.param_' not in path.name)
        for filename in names:
            left, right = [read(folder / filename) for folder in folders]
            assert len(left) == len(right)
            if left != right:
                rows.append({'packet': name, 'phase': phase, 'file': filename, 'bytes': len(left)})
    if rows:
        break
assert rows and all(row['packet'] == metadata[2] and row['phase'] == 'after' for row in rows)
assert len(rows) == 1 and rows[0]['file'].endswith('after.rhs.bin')
name = rows[0]['file']
a, b = [np.frombuffer(read(folder / name), dtype='<f4') for folder in folders]
different = np.flatnonzero(a.view('u4') != b.view('u4'))
record = {'first_different_packet': rows[0], 'preceding_semantic_payloads_equal': True,
          'all_captured_before_fields_of_first_different_packet_equal': True,
          'different_scalar_indices': different.tolist(),
          'different_worlds': sorted({int(index // 9) for index in different}),
          'original_bits': [int(a.view('u4')[index]) for index in different],
          'source_bits': [int(b.view('u4')[index]) for index in different],
          'input_sha256': inputs, 'actual_global_atomic_order_inferred': False,
          'fixed_C10_reclassified': False, 'whole_solver_complete': False}
(BASE / 'first-difference.json').write_text(json.dumps(record, indent=2) + '\n')
print('First difference:', rows[0]['packet'], 'rhs scalar indices', different.tolist())
