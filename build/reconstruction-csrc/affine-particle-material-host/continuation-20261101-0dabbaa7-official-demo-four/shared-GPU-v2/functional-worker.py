"""Run an unchanged example's real Graph path and final test, retaining final states even when its test fails."""
import hashlib
import importlib.util
import json
from pathlib import Path
import runpy
import sys

import numpy as np

ROOT = Path.cwd()
sys.path.insert(0, str(ROOT))
backend, report_name, example_name, *arguments = sys.argv[1:]
output, example = Path(report_name), Path(example_name)
assert not output.exists() and backend in ('original', 'source')
sys.path.insert(0, str(example.parent))
if backend == 'original':
    from reconstruction.csrc.host_api_probe import load_reference
    core = load_reference()
    assert core.is_logged_in(), 'The fixed project SDK must run without a login prompt'
else:
    directory = ROOT / 'build/reconstruction-csrc/source-core/5037032b98b9d614'
    metadata = json.loads((directory / 'build.json').read_text())
    assert metadata['source_host_sha256'] == '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
    image = directory / '_core.cpython-312-x86_64-linux-gnu.so'
    assert hashlib.sha256(image.read_bytes()).hexdigest() == metadata['extension_sha256']
    for path, digest in metadata['sources'].items():
        assert hashlib.sha256((ROOT / path).read_bytes()).hexdigest() == digest
    spec = importlib.util.spec_from_file_location('style3d_sim._core', image)
    core = importlib.util.module_from_spec(spec)
    sys.modules['style3d_sim._core'] = core
    spec.loader.exec_module(core)
    assert core.source_only and not core.solver_api_ready
import style3d_sim as s3d
import newton.examples
assert s3d.Solver is core.Solver
reference = ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
record = {'backend': backend, 'image': str(Path(core.__file__).resolve()),
          'image_sha256': hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest(),
          'example': str(example), 'example_sha256': hashlib.sha256(example.read_bytes()).hexdigest(),
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(), 'arguments': arguments,
          'public_core_abi': True, 'ab_bridge_used': False, 'capture_or_step_replaced': False,
          'final_test_entered': False, 'final_test_returned': False, 'exit': None,
          'whole_solver_complete': False}
old_run = newton.examples.run


def observed_run(instance, args):
    assert args.test
    record['frames_requested'] = args.num_frames
    original_test = instance.test_final

    def observed_test():
        record['final_test_entered'] = True
        result = original_test()
        record['final_test_returned'] = True
        return result

    instance.test_final = observed_test
    try:
        return old_run(instance, args)
    finally:
        state = instance.state_0
        arrays = {}
        for field in ('particle_q', 'particle_qd', 'body_q', 'body_qd'):
            value = getattr(state, field, None)
            if value is not None and value.shape[0]:
                arrays[field] = value.numpy().copy()
        assert arrays
        np.savez_compressed(output.with_suffix('.npz'), **arrays)
        record['all_final_states_finite'] = all(np.isfinite(value).all() for value in arrays.values())
        record['final_state_shapes'] = {field: list(value.shape) for field, value in arrays.items()}
        record['final_sim_time'] = float(instance.sim_time)
        native = instance.solver._native_solver
        assert isinstance(native, core.Solver)
        if backend == 'source':
            record['source_launch_counts'] = dict(native.source_launch_counts)
            assert sum(record['source_launch_counts'].values()) > 0


newton.examples.run = observed_run
sys.argv = [str(example), *arguments]
try:
    runpy.run_path(str(example), run_name='__main__')
    record['exit'] = 0
except BaseException as error:
    record['exit'] = error.code if isinstance(error, SystemExit) and isinstance(error.code, int) else 1
    record['error'] = f'{type(error).__name__}: {error}'
    raise
finally:
    record['reference_solver_mapped'] = str(reference.resolve()) in Path('/proc/self/maps').read_text()
    output.write_text(json.dumps(record, indent=2) + '\n')
    assert record['reference_solver_mapped'] == (backend == 'original')
