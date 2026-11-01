"""Read fixed graph initialization and normalized PTX context without creating a GPU context."""
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.library_entries import entries
from reconstruction.csrc.ptx_compare import normalise

plan = json.loads((BASE / 'plan.json').read_text())
for filename, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(filename).read_bytes()).hexdigest() == expected, filename
build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
previous = BASE.with_name('continuation-20261101-38b70dcd-g1-fourth-cg-scalars')
report = {'GPU_context_created': False, 'static_only': True, 'whole_solver_complete': False, 'sides': {}, 'kernels': {}}
for label in ('sdk0', 'rebuilt0'):
    path = previous / label / 'trace/definition-before/graph.json'
    nodes = linear_order(json.loads(path.read_text()))[0]

    def pointer(rank, argument):
        return int.from_bytes(bytes.fromhex(nodes[rank]['parameter_hex'][argument]), 'little')

    copy = nodes[9351]
    assert copy['type'] == 1
    params = copy['parameters']
    assert params['srcDevice'] == pointer(9332, 9) and params['dstDevice'] == pointer(9355, 1)
    assert (params['WidthInBytes'], params['Height'], params['Depth']) == (2112, 1, 1)
    fills = []
    for rank, consumer_rank, argument, size in [(9352, 9365, 6, 2112), (9353, 9355, 6, 200), (9354, 9364, 9, 200)]:
        node = nodes[rank]
        assert node['type'] == 2
        fill = node['parameters']
        assert fill['dst'] == pointer(consumer_rank, argument)
        assert (fill['value'], fill['elementSize'], fill['width'], fill['height']) == (0, 1, size, 1)
        fills.append({'rank': rank, 'consumer_rank': consumer_rank, 'argument': argument, 'parameters': fill})
    report['sides'][label] = {'graph_sha256': hashlib.sha256(path.read_bytes()).hexdigest(),
                            'final_accumulated_rhs_copy_rank': 9351, 'parameters': params, 'zero_initializers': fills}
for key, name in plan['kernels'].items():
    texts, original = kernel_texts(build, name)
    extracted = {side: entries(text)[name] for side, text in texts.items()}
    report['kernels'][key] = {'normalized_PTX_equal': normalise(extracted['original']) == normalise(extracted['source']),
                              'entry_sha256': {side: hashlib.sha256(text.encode()).hexdigest()
                                               for side, text in extracted.items()}, 'original_module': str(original)}
report['runner_sha256'] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
output = BASE / 'static-context.json'
assert not output.exists()
output.write_text(json.dumps(report, indent=2) + '\n')
print(json.dumps({'normalized_PTX_equal': {key: row['normalized_PTX_equal'] for key, row in report['kernels'].items()},
                  'both_graphs_copy_accumulated_rhs_and_zero_solution_num_den': True}, indent=2))
