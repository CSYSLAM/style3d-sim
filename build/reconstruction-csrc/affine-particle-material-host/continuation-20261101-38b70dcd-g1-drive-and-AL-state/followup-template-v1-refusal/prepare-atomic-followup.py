"""Freeze per-drive SDK isolation and every observed drive-force scalar target after the strict gate."""
import ast
import hashlib
import json
from pathlib import Path
import sys

ROOT = Path.cwd()
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_drive_load_isolated import rendered_source as isolation_source
from reconstruction.csrc.g1_drive_load_certificates import rendered_source as certificate_source

BASE = Path(__file__).resolve().parent
OLD = BASE.parent / 'continuation-20261101-38b70dcd-g1-inertial-joint-so3-rhs'
assert not (BASE / 'isolation-plan.json').exists()
assert not (BASE / 'certification-plan.json').exists()
old_audit = OLD / 'atomic-followup-cpu-audit.py'
assert hashlib.sha256(old_audit.read_bytes()).hexdigest() == '788ca8e715dd86cc42f56deec4557711d5048297dc43d3a0fdaab2a6cde7c403'
text = old_audit.read_text()
changes = []


def replace(old, new, count=1):
    global text
    assert text.count(old) == count, (old, text.count(old))
    text = text.replace(old, new)
    changes.append({'old': old, 'new': new, 'count': count})


replace("row['stage'] == 'joint'", "row['stage'] == 'drive'")
replace("BASE / side / 'joint-packets'", "BASE / side / 'drive-packets'")
replace("f'joint-{side}-frame-{frame:02d}.npz'", "f'drive-{side}-frame-{frame:02d}.npz'")
replace('range(86)', 'range(43)', 2)
replace('lane < 86', 'lane < 43')
replace("['actual_output_replay_addresses']['10']", "['actual_output_replay_addresses']['26']")
replace('np.empty((2, 86, 528)', 'np.empty((2, 43, 528)')
replace('== (3, 2, 86, 528)', '== (3, 2, 43, 528)')
replace('range(15)', 'range(33)')
replace('assert set(pointers) == {*range(9), 10}',
        'assert set(pointers) == set(range(27))\n'
        '        shifted = {2: 4, 3: 4, 4: 4, 6: 4, 7: 8, 8: 12, 9: 12, 10: 12,\n'
        '                   11: 16, 12: 16, 13: 16, 14: 16, 15: 16, 16: 4, 17: 4}')
replace('pointers[i] + (12 * lane if i == 8 else 0)', 'pointers[i] + shifted.get(i, 0) * lane')
replace("                if i in (11, 13):\n                    expected = 1\n"
        "                elif i == 12:\n                    expected = lane + 1",
        "                if i in (27, 28):\n                    expected = 1")
replace('== (86, len(value))', '== (43, len(value))')
replace("packet['before-arg-10']", "packet['before-arg-26']")
replace('== 61920', '== 30960')
ast.parse(text)
assert all(len(line) <= 128 for line in text.splitlines())
(BASE / 'atomic-followup-cpu-audit.py').write_text(text)
(BASE / 'followup-audit-generation.json').write_text(json.dumps({
    'base_sha256': hashlib.sha256(old_audit.read_bytes()).hexdigest(), 'changes': changes,
    'generated_sha256': hashlib.sha256(text.encode()).hexdigest(),
}, indent=2) + '\n')
for kind, generated in [('isolation', isolation_source()), ('certificates', certificate_source())]:
    ast.parse(generated)
    assert all(len(line) <= 128 for line in generated.splitlines()), kind
    (BASE / (kind + '-template.py')).write_text(generated)

# Preserve the previously checked, independent enumeration and hardware-fold protocol.
old_planner = OLD / 'prepare-atomic-followup.py'
text = old_planner.read_text()
changes = []
replace('from reconstruction.csrc.g1_joint_rhs_isolated', 'from reconstruction.csrc.g1_drive_load_isolated')
replace('from reconstruction.csrc.g1_joint_rhs_certificates', 'from reconstruction.csrc.g1_drive_load_certificates')
replace("row['stage'] != 'joint'", "row['stage'] != 'drive'")
replace("BASE / side / 'joint-packets'", "BASE / side / 'drive-packets'")
replace("f'joint-{side}-frame-{frame:02d}.npz'", "f'drive-{side}-frame-{frame:02d}.npz'")
replace("source['after-arg-10']", "source['after-arg-26']")
replace("'-output-10'", "'-output-26'")
replace("['actual_output_replay_addresses']['10']", "['actual_output_replay_addresses']['26']")
replace("ROOT / 'reconstruction/csrc/g1_joint_rhs_isolated.py'", "ROOT / 'reconstruction/csrc/g1_drive_load_isolated.py'")
replace("ROOT / 'reconstruction/csrc/g1_joint_rhs_certificates.py'",
        "ROOT / 'reconstruction/csrc/g1_drive_load_certificates.py'")
replace("'expected_calls': 61920", "'expected_calls': 30960")
replace("             'count': 1, 'joints_per_world': 1, 'spring_count': 'k+1', 'multiplier_byte_offset': '12*k',\n"
        "             'global_spring_body_particle_arrays_unchanged': True, 'particle_world_width': 176}",
        "             'count': 1, 'drives_per_world': 1, 'global_body_DOF_target_arrays_unchanged': True,\n"
        "             'dofs_per_world': 49, 'targets_per_world': 49, 'particle_world_width': 176}")
ast.parse(text)
assert all(len(line) <= 128 for line in text.splitlines())
planner = BASE / 'atomic-target-plan-as-run.py'
planner.write_text(text)
namespace = {'__name__': '__main__', '__file__': str(planner)}
exec(compile(text, str(planner), 'exec'), namespace)
(BASE / 'followup-plan-generation.json').write_text(json.dumps({
    'base_sha256': hashlib.sha256(old_planner.read_bytes()).hexdigest(), 'changes': changes,
    'generated_sha256': hashlib.sha256(text.encode()).hexdigest(),
}, indent=2) + '\n')
driver = (OLD / 'run-atomic-followup.py').read_text()
assert driver.count('g1_joint_rhs_isolated') == driver.count('g1_joint_rhs_certificates') == 1
driver = driver.replace('g1_joint_rhs_isolated', 'g1_drive_load_isolated')
driver = driver.replace('g1_joint_rhs_certificates', 'g1_drive_load_certificates')
(BASE / 'run-atomic-followup.py').write_text(driver)
