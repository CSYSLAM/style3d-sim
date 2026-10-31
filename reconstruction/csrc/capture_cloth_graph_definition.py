"""Read actual captured graph definitions after capture; preserve the full cloth worker execution context."""
import argparse
import ctypes
import hashlib
import json
from pathlib import Path

from .demo_source_ab import ROOT


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--frames', type=int, default=60)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    import warp as wp
    from . import affine_cloth_graph_ab
    driver = ctypes.CDLL('libcuda.so.1')
    dump = driver.cuGraphDebugDotPrint
    dump.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_uint]
    dump.restype = ctypes.c_int
    previous_exit = wp.ScopedCapture.__exit__
    records = []

    def inspected_exit(capture, *values):
        result = previous_exit(capture, *values)
        if capture.graph is not None:
            path = args.output/f'graph-{len(records):02d}.dot'
            status = dump(capture.graph.graph, str(path).encode(), 1)
            assert status == 0, status
            records.append({'file': path.name, 'sha256': hashlib.sha256(path.read_bytes()).hexdigest()})
        return result

    wp.ScopedCapture.__exit__ = inspected_exit
    args.worker = args.backend
    affine_cloth_graph_ab.worker(args)
    assert len(records) == 16
    (args.output/'graph-definitions.json').write_text(json.dumps({
        'graphs': records, 'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'replaces_fixed_candidate': False, 'graph_parameters_changed': False,
        'source_sha256': json.loads((ROOT/'build/reconstruction-csrc/host-particles/build.json').read_text())[
            'extension_sha256'],
    }, indent=2)+'\n')


if __name__ == '__main__':
    main()
