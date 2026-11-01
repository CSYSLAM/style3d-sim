"""Record missing actual typed initializers and allocation events without changing the saved comparison."""
from collections import Counter
import difflib
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc import initialization_trace_audit as initializers

initializers.TYPES = (*initializers.TYPES, ('device_ptrIN3glm3vecILi3Ei', 'ivec3', 12),
                     ('device_ptrIN3glm3vecILi4Ef', 'vec4', 16))
root = BASE / 'constructors'
calls = {side: initializers.capture(root / 'granular-affine-w1-initializers' / side, 2)
         for side in ('original', 'source')}
signatures = {side: list(map(initializers.signature, values)) for side, values in calls.items()}
opcodes = difflib.SequenceMatcher(a=signatures['original'], b=signatures['source'], autojunk=False).get_opcodes()
differences = [{'operation': op, 'original': calls['original'][a:b], 'source': calls['source'][c:d]}
               for op, a, b, c, d in opcodes if op != 'equal']
missing = Counter(signatures['original']) - Counter(signatures['source'])
extra = Counter(signatures['source']) - Counter(signatures['original'])
assert sum(missing.values()) == 14 and not extra
assert all(not any(bytes.fromhex(json.loads(signature)['value_hex'])) for signature in missing)
raw = json.loads((root / 'audit-v2.json').read_text())
assert raw['allocation_event_counts'] == [85, 83] and raw['typed_initializer_counts'] == [55, 41]
result = {'typed_calls': calls, 'ordered_differences': differences,
          'missing_signatures': [{'signature': json.loads(k), 'count': n} for k, n in missing.items()],
          'missing_original_default_value_initializers': 14, 'extra_source_typed_initializers': 0,
          'all_missing_value_fields_zero': True, 'actual_allocation_event_differences': raw['allocation_differences'],
          'input_sha256': {str(root / 'audit-v2.json'): hashlib.sha256((root / 'audit-v2.json').read_bytes()).hexdigest()},
          'production_changed': False, 'whole_solver_complete': False}
path = root / 'difference-details.json'
assert not path.exists()
path.write_text(json.dumps(result, indent=2) + '\n')
print('Actual SDK has14 missing zero-value initialization calls; no extra source typed initializers')
