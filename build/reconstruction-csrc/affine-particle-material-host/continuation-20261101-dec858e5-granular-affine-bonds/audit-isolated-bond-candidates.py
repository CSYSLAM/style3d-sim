"""Independently reverse every candidate source delta and verify actual SDK matrix default-value stores."""
import ast
import hashlib
import json
from pathlib import Path
import re
import subprocess

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
builder = BASE / 'build-isolated-bond-candidates.py'
constants = {}
for node in ast.parse(builder.read_text()).body:
    if isinstance(node, ast.Assign) and len(node.targets) == 1 and isinstance(node.targets[0], ast.Name):
        try:
            constants[node.targets[0].id] = ast.literal_eval(node.value)
        except (ValueError, TypeError):
            pass
root = ROOT / 'reconstruction/csrc/native/source_solver.cpp'
guard = (BASE / 'candidate-guard-only/source_solver.cpp').read_text()
cache = (BASE / 'candidate-static-cache/source_solver.cpp').read_text()
expected_guard = root.read_text().replace(constants['old_guard'], 'model.cable_count))')
expected_guard = expected_guard.replace(constants['comment'],
    '// Provisional bonded-granular/body diagnostics; runtime acceptance is pending.')
assert guard == expected_guard
for before, after in [
    (constants['integer_method'], ''),
    ('            group.active = initialized_integer_cache(bonds.size(), active);', constants['old_active']),
    ('            group.tangent = initialized_cache(bonds.size(), 36, SourceCacheType::Matrix3);',
     constants['old_tangent']),
    (constants['after'], constants['before']),
]:
    assert cache.count(before) == 1
    cache = cache.replace(before, after)
assert cache == guard
assembly = BASE / 'host-bond-argument-binding/mat3-append.asm'
rows = {}
for line in assembly.read_text().splitlines():
    match = re.match(r'\s*([0-9a-f]+):\s+(.*)', line)
    if match:
        rows[int(match[1], 16)] = re.sub(r'\s+', ' ', match[2].strip())
branches = [
    {'zero': 0x11b8e8, 'stores': {0x11b8f8: (-0x88, 16), 0x11b906: (-0x98, 16), 0x11b915: (-0x78, 4)},
     'call': 0x11b962},
    {'zero': 0x11ba40, 'stores': {0x11ba48: (-0x88, 16), 0x11ba5b: (-0x98, 16), 0x11ba6a: (-0x78, 4)},
     'call': 0x11bab7},
]
for branch in branches:
    assert rows[branch['zero']] == 'pxor %xmm0,%xmm0'
    covered = set()
    for address, (offset, width) in branch['stores'].items():
        instruction = ('movups %xmm0,' if width == 16 else 'movl $0x0,') + f'-0x{-offset:x}(%rbp)'
        assert rows[address] == instruction
        assert branch['zero'] < address < branch['call']
        covered.update(range(offset, offset + width))
    assert covered == set(range(-0x98, -0x74)) and len(covered) == 36
    assert '__uninitialized_fill::functor' in rows[branch['call']] and 'glm::mat<3, 3, float' in rows[branch['call']]
image_rows = []
for label in ('guard-only', 'static-cache'):
    folder = BASE / ('candidate-' + label)
    meta = json.loads((folder / 'build.json').read_text())
    for name, sha in meta['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == sha, name
    image = Path(meta['image'])
    assert hashlib.sha256(image.read_bytes()).hexdigest() == meta['image_sha256']
    symbols = subprocess.check_output(['nm', '-D', '--defined-only', str(image)], text=True)
    assert [line.split()[-1] for line in symbols.splitlines() if ' PyInit_' in line] == ['PyInit__source_solver']
    dynamic = subprocess.check_output(['readelf', '-d', str(image)], text=True)
    needed = [line for line in dynamic.splitlines() if '(NEEDED)' in line]
    assert not any('style3d' in line.lower() or '_core' in line.lower() for line in needed)
    image_rows.append({'candidate': label, 'image_sha256': meta['image_sha256'], 'dynamic_dependencies': needed,
                       'original_SDK_dependency_present': False})
report = {'candidate_sources_exact_after_reversing_listed_deltas': True,
          'only_guard_and_constructor_deltas': True, 'SDK_mat3_append_zero_value_bytes_both_branches': 36,
          'SDK_matrix_default_stores_and_calls': branches, 'candidate_images': image_rows,
          'production_changed': False, 'GPU_runtime_validation_claimed': False, 'whole_solver_complete': False,
          'input_sha256': {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in
                           (Path(__file__), builder, root, assembly,
                            BASE / 'candidate-guard-only/source_solver.cpp', BASE / 'candidate-static-cache/source_solver.cpp')}}
with (BASE / 'candidate-independent-cpu-audit.json').open('x') as out:
    out.write(json.dumps(report, indent=2) + '\n')
print('Both source deltas reversed exactly; both SDK mat3 append paths construct 36 zero bytes; no SDK dependency')
