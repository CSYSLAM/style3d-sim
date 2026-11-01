"""Locate the frozen current differences and compare the historical target without changing either cohort."""
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
parent = BASE.parent
cohort = parent / 'continuation-20261101-granular-affine-bonds-production/validation-0dabbaa7-v2/' \
    'regression-fixed-C10/mixed_cloth-seed3'
prior = parent / 'continuation-20261031-86916989-fixed-failures/' \
    'frozen-reproduced-mixed-pair/source/source-seed3.npz'
paths = [cohort / 'source0.npz', cohort / 'original0.npz', prior, Path(__file__)]
rows, worlds, historical = [], set(), {}
with np.load(paths[0], allow_pickle=False) as source, np.load(paths[1], allow_pickle=False) as original, \
        np.load(prior, allow_pickle=False) as old:
    keys = sorted(key for key in source.files if key.startswith('mixed_w129_duplicates/'))
    assert len(keys) == 18
    for key in keys:
        a, b, c = source[key], original[key], old[key]
        assert a.dtype == b.dtype == c.dtype and a.shape == b.shape == c.shape == (387, 3)
        assert all(np.isfinite(value).all() for value in (a, b, c))
        historical[key] = a.tobytes() == c.tobytes()
        different = np.argwhere(a.view('u4') != b.view('u4'))
        for particle, component in different:
            world = int(particle // 3)
            worlds.add(world)
            rows.append({'array': key, 'particle': int(particle), 'component': int(component), 'world': world,
                         'source_bits': int(a.view('u4')[particle, component]),
                         'original_bits': int(b.view('u4')[particle, component]),
                         'absolute_error': float(abs(float(a[particle, component]) - float(b[particle, component])))})
assert sorted(worlds) == [85] and all(historical.values())
record = {'target_arrays': 18, 'differing_worlds': sorted(worlds), 'differences': rows,
          'historical_target_array_bytes_equal': historical, 'historical_evidence_inherited_as_current': False,
          'input_sha256': {str(path.relative_to(ROOT)): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths},
          'production_changed': False, 'source0_replaced': False, 'fixed_failure_retained': True,
          'whole_solver_complete': False}
(BASE / 'initial-cpu-audit.json').write_text(json.dumps(record, indent=2) + '\n')
print('Current target: 18/18 arrays equal historical source; only world85 differs from current original0')
