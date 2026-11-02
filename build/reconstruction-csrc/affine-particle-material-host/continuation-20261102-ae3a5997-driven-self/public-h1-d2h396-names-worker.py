"""Locate the H1 initcheck 396-byte host reads without adding GPU copies or changing array contents."""
import argparse
import hashlib
import inspect
import json
from pathlib import Path
import sys
import traceback

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--backend', choices=('original', 'source'), required=True)
parser.add_argument('--core-build', type=Path, required=True)
parser.add_argument('--output', type=Path, required=True)
parser.add_argument('--frames', type=int, default=4)
args = parser.parse_args()
output = args.output.resolve()
output.mkdir(parents=True, exist_ok=False)
source = BASE / 'public-h1-worker.py'
text = source.read_text()
old = 'ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent'
assert text.count(old) == 1
text = text.replace(old, 'ROOT, BASE = Path.cwd(), asset_manifest_base', 1)
old = 'import newton.utils\n'
assert text.count(old) == 1
text = text.replace(old, old + 'install_read_observer()\n', 1)
patched = output / 'worker-as-run.py'
patched.write_text(text)
reads = []


def install_read_observer():
    import numpy as np
    import warp as wp
    from warp._src.types import type_size_in_bytes

    original = wp.array.numpy

    def observed(array, *values, **keywords):
        size = array.size * type_size_in_bytes(array.dtype)
        if not array.device.is_cuda or size != 396:
            return original(array, *values, **keywords)
        index = len(reads)
        record = {'index': index, 'ptr': int(array.ptr), 'bytes': size, 'shape': list(array.shape),
                  'dtype': str(array.dtype), 'stack': traceback.format_stack(limit=12)}
        caller = inspect.currentframe().f_back
        if caller.f_code.co_name == 'find_nan_members':
            assert caller.f_locals['attr'] is array
            record['array_member'] = caller.f_locals['key']
            model = caller.f_locals['obj']
            record['model_shape_count'] = int(model.shape_count)
            record['model_bvh_enabled_count'] = int(model.bvh_shape_count_enabled)
        reads.append(record)
        print('H1_D2H396_BEGIN', json.dumps(record), file=sys.stderr, flush=True)
        result = original(array, *values, **keywords)
        raw = result.tobytes()
        record['result_shape'] = list(result.shape)
        record['result_dtype'] = str(result.dtype)
        record['result_sha256'] = hashlib.sha256(raw).hexdigest()
        np.save(output / f'read-{index:03d}.npy', result, allow_pickle=False)
        print('H1_D2H396_END', index, file=sys.stderr, flush=True)
        return result

    wp.array.numpy = observed


sys.argv = [str(patched), '--backend', args.backend, '--core-build', str(args.core_build),
            '--output', str(output / 'worker'), '--frames', str(args.frames)]
try:
    exec(compile(text, str(patched), 'exec'),
         {'__name__': '__main__', '__file__': str(patched), 'asset_manifest_base': BASE,
          'install_read_observer': install_read_observer})
finally:
    (output / 'array-reads396.json').write_text(json.dumps({'reads': reads,
        'extra_GPU_copies': 0, 'GPU_array_contents_modified': False,
        'worker_as_run_sha256': hashlib.sha256(patched.read_bytes()).hexdigest(),
        'diagnostic_only_not_fixed_C8_replacement': True, 'whole_solver_complete': False}, indent=2) + '\n')
