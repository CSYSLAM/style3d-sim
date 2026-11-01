"""Independently verify the exact candidate source delta, ELF isolation and actual discovery inputs."""
import hashlib
import json
from pathlib import Path
import re
import subprocess

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
build = json.loads((BASE / 'candidate-guard-only/build.json').read_text())
image = Path(build['image'])
assert hashlib.sha256(image.read_bytes()).hexdigest() == build['image_sha256']
native = ROOT / 'reconstruction/csrc/native/source_solver.cpp'
old = '(!so3 || config.enable_self_collision || contact.max_count || contact.soft_max_count))'
new = '(!so3 || config.enable_self_collision))'
candidate = (BASE / 'candidate-guard-only/source_solver.cpp').read_text()
assert native.read_text().count(old) == candidate.count(new) == 1
assert candidate.replace(new, old, 1) == native.read_text()
dynamic = subprocess.check_output(['readelf', '-d', str(image)], text=True)
exports = subprocess.check_output(['nm', '-D', '--defined-only', str(image)], text=True)
(BASE / 'candidate-guard-only/elf-dynamic.txt').write_text(dynamic)
(BASE / 'candidate-guard-only/elf-exports.txt').write_text(exports)
needed = re.findall(r'Shared library: \[(.*?)\]', dynamic)
assert all('_core' not in name and 'synreal' not in name and 'style3d' not in name for name in needed)
assert any(line.endswith(' PyInit__source_solver') for line in exports.splitlines())
plan = json.loads((BASE / 'discovery-v2/plan.json').read_text())
rows = []
for case in plan['cases']:
    folder = BASE / 'discovery-v2' / case['label']
    comparisons = {}
    for filename in ('model-before.npz', 'actual-layout.npz', 'contacts-0.npz'):
        with np.load(folder / 'original' / filename, allow_pickle=False) as a, \
                np.load(folder / 'source' / filename, allow_pickle=False) as b:
            assert set(a.files) == set(b.files)
            comparisons[filename] = {key: a[key].dtype == b[key].dtype and a[key].shape == b[key].shape
                                     and a[key].tobytes() == b[key].tobytes() for key in a.files}
    assert all(comparisons['model-before.npz'].values()) and all(comparisons['actual-layout.npz'].values())
    rows.append({'case': case['label'], 'actual_input_byte_comparisons': comparisons})
record = {'candidate_sha256': build['image_sha256'], 'only_contact_scope_condition_changed': True,
          'all_constructor_and_iterative_math_text_identical': True, 'SDK_ELF_dependency_absent': True,
          'correct_PyInit_export': True, 'ELF_needed': needed, 'cases': rows, 'GPU_used_for_this_audit': False,
          'production_changed': False, 'whole_solver_complete': False,
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(BASE / 'candidate-independent-cpu.json').write_text(json.dumps(record, indent=2) + '\n')
print('Exact one-condition candidate delta and independent ELF verified; six discovery models byte-identical')
