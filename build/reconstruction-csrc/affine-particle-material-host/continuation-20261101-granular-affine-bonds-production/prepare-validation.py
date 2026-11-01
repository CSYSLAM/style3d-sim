"""Prepare current-image checks by preserving the established captures and replacing only fixed fixture adapters."""
import ast
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
parent = BASE.parent
old = parent / 'continuation-20261101-granular-affine-production'
bonds = parent / 'continuation-20261101-dec858e5-granular-affine-bonds'
text = (old / 'run-validation.py').read_text()
marker = "OLD = BASE.parent / 'continuation-20261101-38b70dcd-granular-affine-support'\n"
assert text.count(marker) == 1
text = text.replace(marker, marker + "BONDS = BASE.parent / 'continuation-20261101-dec858e5-granular-affine-bonds'\n")
marker = "          ROOT / 'reconstruction/csrc/granular_affine_layout_scene.py', ROOT / 'reconstruction/core_demo.py',"
assert text.count(marker) == 1
text = text.replace(marker,
    "          ROOT / 'reconstruction/csrc/granular_affine_bonds_scene.py',\n" + marker)
start = text.index("graph = output / 'graph60'\n")
end = text.index("run('build-core'", start)
replacement = '''bond_plan = json.loads((BONDS / 'plan.json').read_text())
bond_rows = []
for case in bond_plan['cases']:
    bond_rows.append(capture('bonds-' + case['label'], BONDS / case['label'] / 'original',
                             ROOT / 'reconstruction/csrc/granular_affine_bonds_scene.py',
                             case['extra'], case['fields'], 'actual-layout.npz'))
(output / 'bond-report.json').write_text(json.dumps(bond_rows, indent=2) + '\\n')
assert all(row['strict_passed'] for row in bond_rows)
graph = output / 'graph60'
graph.mkdir()
reference_graph = BONDS / 'graph60-and-initcheck/graph60'
freeze_reference(reference_graph)
run('bond-graph60', [BASE / 'graph-worker.py', '--backend', 'source', '--output', graph])
runtime = json.loads((graph / 'source.runtime.json').read_text())
assert runtime['image_sha256'] == build['extension_sha256'] and runtime['frames'] == 60
graph_rows = {}
for case in bond_plan['cases']:
    name = case['label']
    with ExitStack() as stack:
        arrays = {(backend, g): stack.enter_context(np.load(
            (reference_graph if backend == 'original' else graph) / (backend + '-' + name + '-' + str(g) + '.npz'),
            allow_pickle=False)) for backend in ('original', 'source') for g in (0, 1)}
        assert all(np.isfinite(a[k]).all() for a in arrays.values() for k in a.files)
        for g in (0, 1):
            graph_rows[name + '-cross-g' + str(g)] = compare(arrays['original', g], arrays['source', g])
        for backend in ('original', 'source'):
            graph_rows[name + '-' + backend + '-eager-graph'] = compare(arrays[backend, 0], arrays[backend, 1])
(output / 'graph-report.json').write_text(json.dumps(graph_rows, indent=2) + '\\n')
assert all(row['bitwise'] for row in graph_rows.values())
'''
text = text[:start] + replacement + text[end:]
marker = "run('regression74', ['-m', 'reconstruction.csrc.joint_continuation_regression',"
assert text.count(marker) == 1
contracts = '''for name in ('granular_contract_ab', 'fluid_contract_ab', 'self_collision_contract_ab'):
    run(name, ['-m', 'reconstruction.csrc.' + name, '--output', output / name])
'''
text = text.replace(marker, contracts + marker)
ast.parse(text)
assert all(len(line) <= 128 for line in text.splitlines())
target = BASE / 'run-validation.py'
assert not target.exists()
target.write_text(text)
worker = (bonds / 'graph-worker.py').read_text()
start = worker.index("build = json.loads((BASE / 'candidate-static-cache/build.json').read_text())")
stop = worker.index("parent = ROOT / 'reconstruction/csrc/affine_particle_spring_graph_ab.py'", start)
worker = worker[:start] + worker[stop:]
worker = worker.replace("repr(str(BASE / 'plan.json'))", 'repr(' + repr(str(bonds / 'plan.json')) + ')')
worker = worker.replace('and hashed candidate.', 'and promoted current host.')
ast.parse(worker)
assert all(len(line) <= 128 for line in worker.splitlines())
(BASE / 'graph-worker.py').write_text(worker)
print('Prepared 4 short +6 layouts +6 bonded, graph24, normal Core3, contracts and current74/fixedC10')
