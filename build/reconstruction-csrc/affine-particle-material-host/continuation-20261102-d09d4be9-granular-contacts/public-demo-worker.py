"""Record actual public-Core solver returns while running an unchanged example and its original end test."""
import hashlib
import json
import os
from pathlib import Path
import runpy
import sys

import numpy as np

ROOT = Path.cwd()
sys.path.insert(0, str(ROOT))
from reconstruction import core_demo

destination = Path(os.environ['PUBLIC_DEMO_STATES'])
assert not destination.exists()
records = {key: [] for key in ('particle_q', 'particle_qd', 'body_q', 'body_qd')}
original_path = runpy.run_path


def record_path(*args, **kwargs):
    import newton.examples

    original_run = newton.examples.run

    def run(example, options):
        assert getattr(example, 'graph', None) is None
        original_step = example.solver.step

        def step(state_in, state_out, *values, **keywords):
            result = original_step(state_in, state_out, *values, **keywords)
            for key in records:
                array = getattr(state_out, key, None)
                if array is not None and array.shape[0]:
                    records[key].append(array.numpy().copy())
            return result

        example.solver.step = step
        return original_run(example, options)

    newton.examples.run = run
    return original_path(*args, **kwargs)


runpy.run_path = record_path
code = None
try:
    code = core_demo.main()
finally:
    arrays = {key: np.asarray(values) for key, values in records.items() if values}
    assert arrays and all(np.isfinite(value).all() for value in arrays.values())
    np.savez_compressed(destination, **arrays)
    destination.with_suffix('.provenance.json').write_text(json.dumps({
        'actual_core_demo_return': code, 'records': {key: len(values) for key, values in records.items()},
        'public_core_abi': True, 'ab_bridge_used': False, 'end_test_modified': False,
        'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'whole_solver_complete': False}, indent=2) + '\n')
raise SystemExit(code)
