"""Read the complete inline H1 graph after capture and before its first replay without changing any nodes."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.graph_definition_dump import dump_graph

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--backend', choices=('original', 'source'), required=True)
parser.add_argument('--core-build', type=Path, required=True)
parser.add_argument('--abi', type=Path, required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
output = args.output.resolve()
output.mkdir(parents=True, exist_ok=False)
worker = BASE / 'public-h1-worker.py'
text = worker.read_text()
old = 'ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent'
assert text.count(old) == 1
text = text.replace(old, 'ROOT, BASE = Path.cwd(), asset_manifest_base', 1)
old = '        original_step()\n'
assert text.count(old) == 1
text = text.replace(old, old + '        if not old_graph:\n            inspect_actual_graph(example)\n', 1)
patched = output / 'worker-as-run.py'
patched.write_text(text)
summary = []


def inspect_actual_graph(example):
    assert not summary
    graph = example.graph
    assert graph is not None and graph.graph_exec is None
    summary.append(dump_graph(graph, output / 'definition-before-first-replay', json.loads(args.abi.read_text())))
    definition = json.loads((output / 'definition-before-first-replay/graph.json').read_text())
    helper = ct.CDLL(str(BASE / 'public-h1-graph/alloc-query.so'))
    helper.h1_allocation_node.argtypes = [ct.c_uint64, ct.c_int, ct.c_void_p, ct.c_size_t]
    helper.h1_allocation_node.restype = ct.c_int
    allocations = []
    for node in definition['unknown_node_details']:
        assert node['type'] in (10, 11)
        payload = ct.create_string_buffer(16384)
        code = helper.h1_allocation_node(node['handle'], node['type'], payload, len(payload))
        assert code == 0, (node, code)
        allocations.append({**node, 'parameters': json.loads(payload.value)})
    (output / 'allocation-nodes.json').write_text(json.dumps(allocations, indent=2) + '\n')


provenance = {'base_worker_sha256': hashlib.sha256(worker.read_bytes()).hexdigest(),
              'worker_as_run_sha256': hashlib.sha256(patched.read_bytes()).hexdigest(),
              'wrapper_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
              'abi_sha256': hashlib.sha256(args.abi.read_bytes()).hexdigest(),
              'GPU_allocations_added': 0, 'graph_nodes_changed': False, 'device_pointees_read': False,
              'diagnostic_only_not_fixed_C8_replacement': True, 'whole_solver_complete': False}
sys.argv = [str(patched), '--backend', args.backend, '--core-build', str(args.core_build),
            '--output', str(output / 'worker'), '--frames', '4']
try:
    exec(compile(text, str(patched), 'exec'),
         {'__name__': '__main__', '__file__': str(patched), 'asset_manifest_base': BASE,
          'inspect_actual_graph': inspect_actual_graph})
    assert len(summary) == 1
    provenance['complete'] = True
finally:
    provenance['graphs_observed'] = summary
    runtime = output / 'worker/runtime.json'
    if runtime.exists():
        actual = json.loads(runtime.read_text())
        provenance['actual_public_image_sha256'] = actual['image_sha256']
        provenance['actual_source_host_sha256'] = json.loads(args.core_build.read_text())['source_host_sha256'] \
            if args.backend == 'source' else None
    (output / 'provenance.json').write_text(json.dumps(provenance, indent=2) + '\n')
