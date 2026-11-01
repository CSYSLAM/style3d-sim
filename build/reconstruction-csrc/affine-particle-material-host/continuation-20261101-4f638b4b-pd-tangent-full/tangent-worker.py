"""Observe actual RHS/PCG before/after bytes in the original full-order PD contact worker."""
import argparse
import ast
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
observer_spec = importlib.util.spec_from_file_location('reconstruction.csrc.pd_tangent_capture',
                                                      BASE / 'capture-observer.py')
observer_module = importlib.util.module_from_spec(observer_spec)
sys.modules[observer_spec.name] = observer_module
observer_spec.loader.exec_module(observer_module)
Observer = observer_module.Observer
from reconstruction.csrc.host_api_probe import REFERENCE, REFERENCE_SHA

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
assert hashlib.sha256(REFERENCE.read_bytes()).hexdigest() == REFERENCE_SHA
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
observers = []
graph_abi = json.loads(abi.read_text())


def attach(graph, scene):
    observer = Observer(args.output / ('tangent-graph-' + str(len(observers))), graph_abi,
                        int(scene.model.particle_count), int(scene.model.body_count))
    observers.append(observer)
    observer.attach(graph)


text = runner.read_text()
replacements = {
    "(Path(__file__).resolve().parents[2] / 'discovery-v2/plan.json')": 'case_plan',
    "Path(__file__).resolve().parents[2] / 'graph-worker-v2.py'": 'base_graph_loader',
    '                    graphs.append(capture.graph)\n':
        '                    graphs.append(capture.graph)\n'
        '                    if name == trace_target:\n'
        '                        attach_tangent(capture.graph, scene)\n',
    '                    record[key].append(array.numpy().copy())\n':
        '                    record[key].append(array.numpy().copy())\n'
        '                if graph and name == trace_target:\n'
        "                    tangent_observers[step % 2].record(step, record['particle_q'][-1])\n",
}
for before, after in replacements.items():
    assert text.count(before) == 1, before
    text = text.replace(before, after)
ast.parse(text)
script = args.output / 'worker-as-run.py'
script.write_text(text)
record = {'base_worker_sha256': hashlib.sha256(runner.read_bytes()).hexdigest(),
          'actual_worker_sha256': hashlib.sha256(script.read_bytes()).hexdigest(),
          'wrapper_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
          'capture_sha256': hashlib.sha256(Path(sys.modules[Observer.__module__].__file__).read_bytes()).hexdigest(),
          'complete': False, 'frames_read': [], 'production_changed': False,
          'diagnostic_graph_snapshots_can_change_atomic_schedule': True,
          'fixed_source0_replaced': False, 'whole_solver_complete': False}
sys.argv = [str(script), '--worker', args.backend, '--frames', '60', '--output', str(args.output)]
namespace = {'__name__': '__main__', '__package__': 'reconstruction.csrc', '__file__': str(script),
             'case_plan': old / 'discovery-v2/plan.json', 'base_graph_loader': old / 'graph-worker-v2.py',
             'trace_target': 'w3-b1-n2-s1-mixed-pd-b0-both-hit0', 'attach_tangent': attach, 'tangent_observers': observers}
try:
    try:
        exec(compile(text, str(script), 'exec'), namespace)
    except SystemExit as result:
        if result.code not in (None, 0):
            raise
    assert len(observers) == 2 and [o.frames for o in observers] == [30, 30]
    record['complete'] = True
    record['original_SDK_mapped'] = '_core.cpython-' in Path('/proc/self/maps').read_text()
    assert record['original_SDK_mapped'] == (args.backend == 'original')
finally:
    record['frames_read'] = [o.frames for o in observers]
    (args.output / 'provenance.json').write_text(json.dumps(record, indent=2) + '\n')
    for observer in observers:
        observer.close()
