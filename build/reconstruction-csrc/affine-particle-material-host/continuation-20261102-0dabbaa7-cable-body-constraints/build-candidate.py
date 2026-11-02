"""Admit a verified plain-constraint/cable scope in an isolated host image; retain all solver arithmetic."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
audit_path = BASE / 'discovery-independent-cpu.json'
audit = json.loads(audit_path.read_text())
assert audit['SDK_supported_cases'] == audit['production_guard_rejections'] == 24
assert audit['both_modules_effective_cases'] == 24
for name, expected in audit['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
saved = build_path.read_bytes()
build = json.loads(saved)
original_cpp = ROOT / 'reconstruction/csrc/native/source_solver.cpp'
original = original_cpp.read_text()
changes = [
    ('        if (model_.body_spring_count || model_.body_point_line_count || model_.body_distance_constraint_count ||\n'
     '            model_.joint_drive_count)\n'
     '            throw std::runtime_error("Cable mixed with body constraints has not been captured");\n',
     '        if (model_.joint_body_spring_count || model_.joint_body_point_line_count || model_.joint_drive_count)\n'
     '            throw std::runtime_error("Cable mixed with joint constraints has not been captured");\n'),
    ('        const bool isolated_plain =\n',
     '        // Plain constraints and cables share the captured SO3 block/tangent schedule.\n'
     '        const bool cable_plain = cable_count_ && so3 && joint_al &&\n'
     '            (plain_spring_count_ || plain_line_count_ || distance_total_) &&\n'
     '            !joint_spring_total_ && !joint_line_total_ && !drive_total_ && !fluid_rows_ &&\n'
     '            !granular_points_ && !self && !drag_count_ && !tetrahedron_count_ && !spring_count_ &&\n'
     '            !triangle_count_ && !edge_count_ && !contact.max_count && !contact.soft_max_count;\n'
     '        const bool isolated_plain =\n'),
    ('if (body_block && !driven_cloth && !isolated_plain && !plain_contact && !isolated_undriven_joint &&',
     'if (body_block && !driven_cloth && !isolated_plain && !plain_contact && !isolated_undriven_joint &&\n'
     '            !cable_plain &&'),
    ('            !isolated_plain && !plain_contact && !isolated_undriven_joint &&\n'
     '            pd && (plain_spring_count_',
     '            !isolated_plain && !plain_contact && !isolated_undriven_joint && !cable_plain &&\n'
     '            pd && (plain_spring_count_'),
]
candidate = original
for old, new in changes:
    assert candidate.count(old) == 1, old
    candidate = candidate.replace(old, new, 1)
restored = candidate
for old, new in reversed(changes):
    assert restored.count(new) == 1
    restored = restored.replace(new, old, 1)
assert restored == original and max(map(len, candidate.splitlines())) <= 128
out = BASE / 'candidate-scope-only'
out.mkdir(exist_ok=False)
cpp = out / 'source_solver.cpp'
cpp.write_text(candidate)
command = list(build['build_command'])
assert command.count(str(original_cpp)) == 1
command[command.index(str(original_cpp))] = str(cpp)
command.insert(1, '-I' + str(original_cpp.parent))
image = out / Path(command[-1]).name
command[-1] = str(image)
inputs = {str(ROOT / name): expected for name, expected in build['sources'].items()}
inputs.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest()
               for path in (Path(__file__), audit_path, cpp, BASE / 'SDK-host-provenance.json')})
record = {'input_sha256': inputs, 'command': command, 'changes': changes, 'only_scope_predicates_changed': True,
          'production_changed': False, 'GPU_runtime_validation_claimed': False, 'whole_solver_complete': False}
(out / 'plan.json').write_text(json.dumps(record, indent=2) + '\n')
with (out / 'build.log').open('w') as log:
    process = subprocess.Popen(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    code = process.wait()
(out / 'build.status.json').write_text(json.dumps({'pid': process.pid, 'actual_exit': code}, indent=2) + '\n')
assert code == 0 and build_path.read_bytes() == saved
for name, expected in inputs.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
record.update(image=str(image), image_sha256=hashlib.sha256(image.read_bytes()).hexdigest())
(out / 'build.json').write_text(json.dumps(record, indent=2) + '\n')
print('Built isolated scope candidate:', record['image_sha256'], ';actual runtime validation pending', flush=True)
