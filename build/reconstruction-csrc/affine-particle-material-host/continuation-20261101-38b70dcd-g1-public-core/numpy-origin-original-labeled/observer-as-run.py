"""Identify the Python origin of G1's observed 420-byte D2H reads without changing arrays or solver math."""
import argparse
import hashlib
import json
from pathlib import Path
import sys
import traceback

from .demo_source_ab import ROOT


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=1)
    args = parser.parse_args()
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    import warp as wp
    previous = wp.array.numpy
    records = []

    def observed_numpy(array, *values, **kwargs):
        size = array.size * wp.types.type_size_in_bytes(array.dtype)
        row = None
        if size == 420 and array.device.is_cuda:
            caller = sys._getframe(1)
            field = caller.f_locals.get('key') if caller.f_code.co_name == 'find_nan_members' else None
            model = caller.f_locals.get('obj') if field == 'bvh_shape_enabled' else None
            row = {'pointer': hex(array.ptr), 'bytes': size, 'dtype': str(array.dtype),
                   'shape': list(array.shape), 'strides': list(array.strides),
                   'model_field': field,
                   'active_count': getattr(model, 'bvh_shape_count_enabled', None),
                   'stack': [dict(file=frame.filename, line=frame.lineno, function=frame.name, code=frame.line)
                             for frame in traceback.extract_stack(limit=18)[:-1]]}
            records.append(row)
        result = previous(array, *values, **kwargs)
        if row is not None:
            if row['model_field'] == 'bvh_shape_enabled':
                row['active_prefix_values'] = result[:row['active_count']].tolist()
            with (output / '420-byte-reads.jsonl').open('a') as file:
                file.write(json.dumps(row) + '\n')
        return result

    wp.array.numpy = observed_numpy
    runner = ROOT / ('build/reconstruction-csrc/affine-particle-material-host/'
                     'continuation-20261101-688f9633-driven-cloth-rigid-soft/'
                     'official-g1-public-core-graph60/worker-as-run.py')
    sys.argv = [str(runner), '--backend', args.backend, '--core-build',
                str(ROOT / 'build/reconstruction-csrc/source-core/a318a3ce42f6a731/build.json'),
                '--example', str(ROOT / 'examples/example_robot_g1.py'), '--frames', str(args.frames),
                '--output', str(output / 'worker'), '--', '--solver', 'synreal', '--world-count', '1']
    try:
        exec(compile(runner.read_bytes(), str(runner), 'exec'),
             {'__name__': '__main__', '__package__': 'reconstruction.csrc', '__file__': str(runner)})
    finally:
        wp.array.numpy = previous
        (output / 'provenance.json').write_text(json.dumps({
            'backend': args.backend, 'frames': args.frames, 'read_events': len(records),
            'observer_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            'array_bytes_modified': False, 'production_changed': False,
            'frozen_candidate_replaced': False, 'whole_solver_complete': False}, indent=2) + '\n')


if __name__ == '__main__':
    main()
