"""Compare captured graph DAGs and typed parameters without treating pointer identity as pointee equivalence."""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path

from .audit_cudahook import SCALAR_WORDS, schemas


def linear_order(graph):
    nodes = {node['handle']: node for node in graph['nodes']}
    assert len(nodes) == len(graph['nodes'])
    degree = dict.fromkeys(nodes, 0)
    following = {handle: [] for handle in nodes}
    for source, target in graph['edges']:
        assert source in nodes and target in nodes
        degree[target] += 1
        following[source].append(target)
    ready = [handle for handle, count in degree.items() if not count]
    ordered = []
    while ready:
        # A non-unique DAG needs an explicit isomorphism; do not invent a correspondence.
        assert len(ready) == 1, 'Topological correspondence is not unique'
        handle = ready.pop()
        ordered.append(nodes[handle])
        for target in following[handle]:
            degree[target] -= 1
            if not degree[target]:
                ready.append(target)
    assert len(ordered) == len(nodes), 'Graph contains a cycle'
    rank = {node['handle']: index for index, node in enumerate(ordered)}
    edges = sorted((rank[source], rank[target]) for source, target in graph['edges'])
    return ordered, edges


def normalize(ordered, warp_schema, owned_schema):
    aliases = {}
    parameters = []
    scalar_parameters = []
    padding_bytes = 0

    def pointer(value, domain='device'):
        if not value:
            return None
        key = (domain, value)
        if key not in aliases:
            aliases[key] = len(aliases)
        return aliases[key]

    def scalar_view(kind, raw, with_pointers):
        result = []
        for offset in range(0, len(raw), 8):
            assert len(raw[offset:offset + 8]) == 8
            word = int.from_bytes(raw[offset:offset + 8], 'little')
            mask = 0xffffffffffffffff
            if (kind, offset) in (('U', 288), ('W', 112)):
                mask = 0xffffffff
            if (kind, offset) == ('H', 248):
                mask = 0x00ffffffffffffff
            if offset in SCALAR_WORDS[kind]:
                result.append([offset, 'scalar', word & mask])
            elif with_pointers:
                result.append([offset, 'pointer', pointer(word)])
        return [kind, result]

    def warp_parameter(raw, description, with_pointers):
        assert len(raw) == description['width']
        fields = []
        for field in description['fields']:
            offset, size = field['offset'], field['size']
            bits = raw[offset:offset + size]
            assert len(bits) == size
            if field['kind'] == 'pointer':
                if with_pointers:
                    fields.append([field['name'], 'pointer', pointer(int.from_bytes(bits, 'little'))])
            else:
                fields.append([field['name'], 'scalar', bits.hex()])
        return fields

    for node in ordered:
        kind = node['type']
        normalized, scalars = [], []
        if kind == 0:
            raw = [bytes.fromhex(value) for value in node['parameter_hex']]
            assert [len(value) for value in raw] == node['parameter_widths']
            if node['owned_kernel']:
                layout = owned_schema[node['name']]
                assert len(layout) == len(raw)
                for field_kind, value in zip(layout, raw):
                    if field_kind == 'pointer':
                        assert len(value) == 8
                        normalized.append(['pointer', pointer(int.from_bytes(value, 'little'))])
                        scalars.append(['pointer'])
                    elif field_kind in SCALAR_WORDS:
                        normalized.append(scalar_view(field_kind, value, True))
                        scalars.append(scalar_view(field_kind, value, False))
                    else:
                        assert field_kind != 'M', 'Opaque Model needs an explicit field schema'
                        normalized.append([field_kind, value.hex()])
                        scalars.append([field_kind, value.hex()])
            else:
                layout = warp_schema['kernels'][node['name']]
                assert len(layout) == len(raw)
                for value, description in zip(raw, layout):
                    normalized.append(warp_parameter(value, description, True))
                    scalars.append(warp_parameter(value, description, False))
                    padding_bytes += len(value) - sum(field['size'] for field in description['fields'])
        elif kind in (1, 2):
            for name, value in node['parameters'].items():
                domain = None
                if kind == 1 and name.endswith(('Host', 'Device', 'Array')):
                    domain = {'Host': 'host', 'Device': 'device', 'Array': 'array'}[name[3:]]
                elif kind == 2 and name == 'dst':
                    domain = 'device'
                if domain:
                    normalized.append([name, 'pointer', pointer(value, domain)])
                    scalars.append([name, 'pointer'])
                else:
                    normalized.append([name, 'scalar', value])
                    scalars.append([name, 'scalar', value])
        elif kind != 5:
            raise ValueError(f'Node type {kind} has not been normalized')
        parameters.append(normalized)
        scalar_parameters.append(scalars)
    return parameters, scalar_parameters, len(aliases), padding_bytes


def differences(left, right):
    assert len(left) == len(right)
    indices = [index for index, (old, new) in enumerate(zip(left, right)) if old != new]
    return {'different_nodes': len(indices), 'first_examples': [
        {'rank': index, 'left': left[index], 'right': right[index]} for index in indices[:12]]}


def compare(left_path, right_path, warp_schema):
    graphs = [json.loads(path.read_text()) for path in (left_path, right_path)]
    ordered, edges = zip(*(linear_order(graph) for graph in graphs))
    assert len(ordered[0]) == len(ordered[1])
    assert all(not graph['unknown_node_details'] for graph in graphs)
    owned_schema, owned_count = schemas()
    normalized = [normalize(nodes, warp_schema, owned_schema) for nodes in ordered]
    descriptions = [[(node['type'], node.get('name'), node.get('geometry'),
                      node.get('parameter_offsets'), node.get('parameter_widths')) for node in nodes] for nodes in ordered]
    attrs = [[node.get('attributes') for node in nodes] for nodes in ordered]
    report = {
        'input_sha256': {str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in (left_path, right_path)},
        'owned_ABI_entries_checked': owned_count,
        'nodes': [len(nodes) for nodes in ordered], 'edges': [len(items) for items in edges],
        'node_types': [dict(Counter(node['type'] for node in nodes)) for nodes in ordered],
        'unique_topological_order': True, 'edges_equal': edges[0] == edges[1],
        'descriptions': differences(*descriptions),
        'typed_scalar_parameters': differences(*(items[1] for items in normalized)),
        'typed_parameters_with_pointer_identity': differences(*(items[0] for items in normalized)),
        'function_attributes': differences(*attrs),
        'pointer_aliases': [items[2] for items in normalized],
        'warp_padding_bytes_excluded': [items[3] for items in normalized],
        'relative_allocation_offsets_compared': False, 'device_pointees_compared': False,
        'frozen_failure_replaced': False, 'whole_solver_complete': False,
    }
    report['graph_structure_and_typed_parameters_equal'] = report['edges_equal'] and all(
        report[key]['different_nodes'] == 0 for key in
        ('descriptions', 'typed_scalar_parameters', 'typed_parameters_with_pointer_identity'))
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('left', type=Path)
    parser.add_argument('right', type=Path)
    parser.add_argument('--warp-schema', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    report = compare(args.left, args.right, json.loads(args.warp_schema.read_text()))
    report['warp_schema_sha256'] = hashlib.sha256(args.warp_schema.read_bytes()).hexdigest()
    report['runner_sha256'] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    args.output.write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({key: value for key, value in report.items()
                      if key not in ('input_sha256', 'function_attributes')}, indent=2))
    return 0 if report['graph_structure_and_typed_parameters_equal'] else 1


if __name__ == '__main__':
    raise SystemExit(main())
