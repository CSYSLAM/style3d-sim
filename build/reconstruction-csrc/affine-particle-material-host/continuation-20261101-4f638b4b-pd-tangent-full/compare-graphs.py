"""Audit both actual graph templates together, preserving cross-graph pointer identities and typed fields."""
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import schemas
from reconstruction.csrc.graph_definition_compare import linear_order

spec = importlib.util.spec_from_file_location('model_normalizer', BASE / 'model-normalizer.py')
normalizer = importlib.util.module_from_spec(spec)
spec.loader.exec_module(normalizer)
output = BASE / 'tangent-captures'
terminal = json.loads((output / 'status.json').read_text())
assert terminal['complete'] and len(terminal['completed']) == 4
assert all(row['actual_exit'] == 0 for row in terminal['completed'])
old = BASE.parent / 'continuation-20261101-38b70dcd-g1-graph-definition'
schema_path = old / 'warp-schema.json'
warp_schema = json.loads(schema_path.read_text())
graphs = [[json.loads((output / str(index) / ('tangent-graph-' + str(g)) / 'definition-before/graph.json').read_text())
           for g in range(2)] for index in range(4)]
names = {node['name'] for pair in graphs for graph in pair for node in graph['nodes']
         if node['type'] == 0 and not node['owned_kernel']}
assert len(names) == 3 and names <= set(warp_schema['kernels'])
for path in (ROOT / '.venv/lib/python3.12/site-packages/warp/_src/types.py',
             ROOT / '.venv/lib/python3.12/site-packages/warp/native/array.h'):
    metadata = warp_schema['artifacts'][str(path)]
    assert hashlib.sha256(path.read_bytes()).hexdigest() == metadata['sha256'], path
for pair in graphs:
    for graph in pair:
        for node in graph['nodes']:
            if node['type'] == 0 and not node['owned_kernel']:
                assert node['parameter_widths'] == [item['width'] for item in warp_schema['kernels'][node['name']]]
selected = {'kernels': {name: warp_schema['kernels'][name] for name in sorted(names)},
            'schema_from': str(schema_path), 'schema_sha256': hashlib.sha256(schema_path.read_bytes()).hexdigest(),
            'actual_driver_widths_checked_for_all_graphs': True}
(BASE / 'selected-warp-schema.json').write_text(json.dumps(selected, indent=2) + '\n')
ordered = [[linear_order(graph) for graph in pair] for pair in graphs]
owned = schemas()[0]
rows, resources = [], {}
for index in range(1, 4):
    topology, node_identity = True, True
    for g in range(2):
        left, left_edges = ordered[0][g]
        right, right_edges = ordered[index][g]
        topology &= left_edges == right_edges
        assert len(left) == len(right) == 276
        for rank, (a, b) in enumerate(zip(left, right)):
            keys = ['type'] + (['name', 'geometry', 'parameter_offsets', 'parameter_widths'] if a['type'] == 0 else [])
            node_identity &= all(a[key] == b.get(key) for key in keys)
            if a['type'] == b['type'] == 0 and a['attributes'] != b['attributes']:
                item = {'original': a['attributes'], 'source': b['attributes']}
                if a['name'] in resources:
                    assert resources[a['name']] == item
                resources[a['name']] = item
    # One alias map spans the two templates, so state ping-pong and persistent caches are also compared.
    left = normalizer.normalize(ordered[0][0][0] + ordered[0][1][0], selected, owned)
    right = normalizer.normalize(ordered[index][0][0] + ordered[index][1][0], selected, owned)
    row = {'source_run': index, 'topology_equal': topology, 'all_node_types_and_kernel_geometry_ABI_equal': node_identity,
           'complete_typed_parameters_and_cross_graph_pointer_patterns_equal': left[0] == right[0],
           'scalar_parameters_equal': left[1] == right[1], 'pointer_identities': [left[2], right[2]],
           'padding_bytes_ignored': [left[3], right[3]], 'two_graph_nodes_per_backend': 552,
           'Model_only_audited_kernel_read_fields_compared': True, 'whole_Model_equivalence_claimed': False}
    rows.append(row)
    print('Source', index, 'topology', topology, 'typed parameters', left[0] == right[0],
          'cross-graph pointer IDs', left[2], right[2], flush=True)
result = {'cases': rows, 'function_resource_differences': resources,
          'function_resource_difference_count': len(resources), 'device_pointees_read': False,
          'resource_differences_proven_to_cause_fixed_failure': False, 'GPU_used_for_this_audit': False,
          'fixed_C8_reclassified': False, 'production_changed': False, 'whole_solver_complete': False,
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(BASE / 'definition-comparison.json').write_text(json.dumps(result, indent=2) + '\n')
assert all(row['topology_equal'] and row['all_node_types_and_kernel_geometry_ABI_equal'] and
           row['complete_typed_parameters_and_cross_graph_pointer_patterns_equal'] for row in rows)
