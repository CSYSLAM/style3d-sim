"""Read both target graph templates only after the complete original worker has saved its trajectories."""
import argparse
import ast
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--backend', choices=('original', 'source'), required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
args.output.mkdir(parents=True, exist_ok=False)
old = BASE.parent / 'continuation-20261101-0dabbaa7-granular-affine-contacts'
build = json.loads((old / 'candidate-guard-only/build.json').read_text())
for path, sha in build['input_sha256'].items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha, path
image = Path(build['image'])
assert hashlib.sha256(image.read_bytes()).hexdigest() == build['image_sha256']
if args.backend == 'source':
    from reconstruction.csrc import host_particles_ab

    def candidate():
        spec = importlib.util.spec_from_file_location('_source_solver', image)
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        assert module.source_only and not module.solver_api_ready
        return module

    host_particles_ab.native_source = candidate
runner = old / 'graph60-and-initcheck-v2/graph60/original-graph-as-run.py'
abi = BASE.parent / 'continuation-20261101-38b70dcd-g1-graph-definition/abi.json'
text = runner.read_text()
replacements = {
    "(Path(__file__).resolve().parents[2] / 'discovery-v2/plan.json')": 'case_plan',
    "Path(__file__).resolve().parents[2] / 'graph-worker-v2.py'": 'base_graph_loader',
    '    for name, worlds, diagonal, extra in cases():\n':
        '    retained_target = []\n    for name, worlds, diagonal, extra in cases():\n',
    "            np.savez_compressed(args.output/f'{args.worker}-{name}-{int(graph)}.npz', **record)\n":
        "            np.savez_compressed(args.output/f'{args.worker}-{name}-{int(graph)}.npz', **record)\n"
        "            if graph and name == trace_target:\n"
        "                retained_target.append((scene, list(graphs)))\n",
    "    if args.worker == 'source':\n        assert '_core.cpython-'":
        "    assert len(retained_target) == 1\n"
        "    from reconstruction.csrc.graph_definition_dump import dump_graph\n"
        "    for index, captured in enumerate(retained_target[0][1]):\n"
        "        dump_graph(captured, args.output / ('definition-' + str(index)), graph_abi)\n"
        "    if args.worker == 'source':\n        assert '_core.cpython-'",
}
for before, after in replacements.items():
    expected = 2 if before == '    for name, worlds, diagonal, extra in cases():\n' else 1
    assert text.count(before) == expected, before
    text = text.replace(before, after, 1)
ast.parse(text)
script = args.output / 'worker-as-run.py'
script.write_text(text)
record = {'queries_after_complete_worker': True, 'graph_nodes_changed': False, 'device_pointees_read': False,
          'GPU_allocations_added_by_queries': 0, 'target_lifetimes_extended_after_target_saved': True,
          'target_worker_prefix_and_all_60_frames_unchanged': True,
          'base_worker_sha256': hashlib.sha256(runner.read_bytes()).hexdigest(),
          'actual_worker_sha256': hashlib.sha256(script.read_bytes()).hexdigest(),
          'wrapper_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
          'complete': False, 'fixed_source0_replaced': False, 'whole_solver_complete': False}
sys.argv = [str(script), '--worker', args.backend, '--frames', '60', '--output', str(args.output)]
namespace = {'__name__': '__main__', '__package__': 'reconstruction.csrc', '__file__': str(script),
             'case_plan': old / 'discovery-v2/plan.json', 'base_graph_loader': old / 'graph-worker-v2.py',
             'trace_target': 'w3-b1-n2-s1-mixed-pd-b0-both-hit0', 'graph_abi': json.loads(abi.read_text())}
try:
    exec(compile(text, str(script), 'exec'), namespace)
except SystemExit as result:
    if result.code not in (None, 0):
        raise
    record['complete'] = True
finally:
    (args.output / 'provenance.json').write_text(json.dumps(record, indent=2) + '\n')
