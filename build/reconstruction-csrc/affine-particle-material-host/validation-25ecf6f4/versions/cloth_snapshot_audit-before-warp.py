"""Compare captured native graph parameters and copy/clear wiring without launching a GPU worker."""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import re

from .audit_cudahook import SCALAR_WORDS, WIDTH, schemas


def normalize(folder):
    metadata = json.loads((folder / 'post-step.json').read_text())
    native = {row['index']: row for row in metadata['nodes']}
    layout, aliases, records, unknown = schemas()[0], {}, [], []

    def pointer(value):
        if not value:
            return None
        if value not in aliases:
            aliases[value] = len(aliases)
        return aliases[value]

    def parameter(kind, value):
        data = bytes.fromhex(value)
        if kind == 'pointer':
            assert len(data) == 8
            return ['pointer', pointer(int.from_bytes(data, 'little'))]
        assert len(data) == WIDTH[kind]
        if kind not in SCALAR_WORDS:
            assert kind != 'M', 'Opaque Model fields require a separate field layout'
            return [kind, value]
        words = []
        for offset in range(0, len(data), 8):
            word = int.from_bytes(data[offset:offset + 8], 'little')
            if kind == 'U' and offset == 288 or kind == 'W' and offset == 112:
                word &= 0xffffffff
            if kind == 'H' and offset == 248:
                word &= 0x00ffffffffffffff
            words.append([offset, ['scalar', word] if offset in SCALAR_WORDS[kind] else ['pointer', pointer(word)]])
        return [kind, words]

    for block in (folder / 'sampled-graph.dot').read_text().split('\n\n'):
        match = re.search(r'"graph_\d+_node_(\d+)"\[', block)
        if not match:
            continue
        index = int(match[1])
        blind = re.sub(r'0x[0-9A-Fa-f]+', 'PTR', block)
        blind = re.sub(r'graph_\d+', 'GRAPH', blind)
        row = {'index': index, 'address_blind_definition': blind}
        if 'label="{KERNEL' in block:
            row['type'] = 'kernel'
            if index in native:
                node = native[index]
                assert node['name'] in layout
                assert len(layout[node['name']]) == len(node['parameters'])
                row.update(name=node['name'], geometry=node['geometry'],
                           parameters=[parameter(kind, value) for kind, value in
                                       zip(layout[node['name']], node['parameters'])])
            else:
                unknown.append(index)
        elif '\nMEMCPY\n' in block:
            row['type'] = 'copy'
            line = next(line for line in block.splitlines() if line.startswith('| {{src | dst}'))
            values = [part.strip() for part in line.rsplit('| {', 1)[1].split('}', 1)[0].split('|')]
            assert len(values) == 20, values
            row['endpoints'] = [[i, pointer(int(value, 16)) if i in (1, 2, 3, 11, 12, 13) else value]
                                for i, value in enumerate(values)]
        elif 'label="{MEMSET' in block:
            row['type'] = 'clear'
            line = next(line for line in block.splitlines() if line.startswith('| {{ID'))
            values = [part.strip() for part in line.rsplit('| {', 1)[1].split('}', 1)[0].split('|')]
            assert len(values) == 8, values
            row['destination'] = pointer(int(values[2], 16))
            row['pitch_value_element_size_width_height'] = list(map(int, values[3:]))
        else:
            raise ValueError(f'Unsupported graph node: {index}')
        records.append(row)
    assert len(native) == sum('parameters' in row for row in records)
    return metadata, records, unknown


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--original', type=Path, required=True)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert not args.output.exists()
    left, right = normalize(args.original), normalize(args.source)
    assert len(left[1]) == len(right[1])
    differences = [{'node': i, 'original': a, 'source': b}
                   for i, (a, b) in enumerate(zip(left[1], right[1])) if a != b]
    files = [Path(__file__), *[folder / name for folder in (args.original, args.source)
                              for name in ('post-step.json', 'post-step.npz', 'sampled-graph.dot')]]
    report = {
        'same_captured_graph_parameters_and_copy_clear_wiring': not differences,
        'counts': dict(Counter(row['type'] for row in left[1])),
        'native_parameter_nodes': len(left[0]['nodes']), 'differences': differences,
        'uncompared_non_native_parameter_nodes': {'original': left[2], 'source': right[2]},
        'allocation_relative_offsets_compared': False, 'pointee_values_compared': False,
        'fixed_candidate_replaced': False, 'whole_solver_complete': False,
        'inputs': {str(path.resolve()): hashlib.sha256(path.read_bytes()).hexdigest() for path in files},
    }
    args.output.write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({key: value for key, value in report.items() if key not in ('inputs', 'differences')}), flush=True)
    return int(bool(differences))


if __name__ == '__main__':
    raise SystemExit(main())
