"""Dump an unchanged G1 public-core graph only after all recorded frames and example tests finish."""
import argparse
import hashlib
import json
from pathlib import Path
import sys

from .demo_source_ab import ROOT


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--abi', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=60)
    args = parser.parse_args()
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    runner = ROOT / ('build/reconstruction-csrc/affine-particle-material-host/'
                     'continuation-20261101-688f9633-driven-cloth-rigid-soft/'
                     'official-g1-public-core-graph60/worker-as-run.py')
    text = runner.read_text()
    assert text.count('graphs.append(True)') == 1
    text = text.replace('graphs.append(True)', 'graphs.append(graph)')
    # Save the diagnostic trajectory before querying the graph, including if a query fails.
    anchor = "    np.savez_compressed(output / 'states.npz', **arrays)\n"
    assert text.count(anchor) == 1
    extra = ("    from reconstruction.csrc.graph_definition_dump import dump_graph\n"
             "    abi = json.loads(Path(" + repr(str(args.abi.resolve())) + ").read_text())\n"
             "    for index, graph in enumerate(graphs):\n"
             "        dump_graph(graph, output / ('definition-' + str(index)), abi)\n")
    text = text.replace(anchor, anchor + extra)
    patched = output / 'worker-as-run.py'
    patched.write_text(text)
    (output / 'provenance.json').write_text(json.dumps({
        'base_worker_sha256': hashlib.sha256(runner.read_bytes()).hexdigest(),
        'patched_worker_sha256': hashlib.sha256(patched.read_bytes()).hexdigest(),
        'wrapper_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'dump_sha256': hashlib.sha256((ROOT / 'reconstruction/csrc/graph_definition_dump.py').read_bytes()).hexdigest(),
        'abi_sha256': hashlib.sha256(args.abi.read_bytes()).hexdigest(),
        'queries_after_recorded_frames_and_tests': True, 'production_changed': False,
        'GPU_allocations_added_by_dump': 0, 'graph_nodes_changed': False,
        'replaces_frozen_candidate': False, 'whole_solver_complete': False}, indent=2) + '\n')
    sys.argv = [str(patched), '--backend', args.backend, '--core-build',
                str(ROOT / 'build/reconstruction-csrc/source-core/a318a3ce42f6a731/build.json'),
                '--example', str(ROOT / 'examples/example_robot_g1.py'), '--frames', str(args.frames),
                '--output', str(output / 'worker'), '--', '--solver', 'synreal', '--world-count', '1']
    exec(compile(text, str(patched), 'exec'),
         {'__name__': '__main__', '__package__': 'reconstruction.csrc', '__file__': str(patched)})


if __name__ == '__main__':
    main()
