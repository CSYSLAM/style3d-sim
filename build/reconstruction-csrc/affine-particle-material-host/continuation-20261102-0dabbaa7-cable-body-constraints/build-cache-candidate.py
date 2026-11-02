"""Restore the six observed cable typed zero caches at their SDK initialization position, in isolation."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
previous_path = BASE / 'candidate-scope-only/build.json'
previous = json.loads(previous_path.read_text())
for name, expected in previous['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
audit_path = BASE / 'cable-cache-difference.json'
audit = json.loads(audit_path.read_text())
assert audit['remaining_typed_initializers_and_order_equal_after_removing_six']
for name, expected in audit['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
before_path = BASE / 'candidate-scope-only/source_solver.cpp'
before = before_path.read_text()
changes = [
    ('    void precompute_cables()\n',
     '    void initialize_cable_caches()\n'
     '    {\n'
     '        cable_count_ = model_.cable_count * (count_ / per_world_);\n'
     '        if (!cable_count_) return;\n'
     '        // SDK initialize creates these typed zero vectors before drag/diagonal/matrix caches.\n'
     '        cable_linear_ = initialized_cache(cable_count_ * 8, 36, SourceCacheType::Matrix3);\n'
     '        cable_angular_ = initialized_cache(cable_count_ * 8, 36, SourceCacheType::Matrix3);\n'
     '        cable_indices_ = initialized_cache(cable_count_ * 8, 4, SourceCacheType::Integer);\n'
     '        cable_sizes_ = initialized_cache(cable_count_, 4, SourceCacheType::Integer);\n'
     '        cable_penalty_ = initialized_cache(cable_count_, 16, SourceCacheType::Vector4);\n'
     '        cable_initialized_ = initialized_cache(cable_count_, 4, SourceCacheType::Integer);\n'
     '    }\n\n'
     '    void precompute_cables()\n'),
    ('        cable_penalty_ = driver_->allocate(cable_count_ * 16);\n'
     '        cable_initialized_ = driver_->allocate(cable_count_ * 4);\n'
     '        check(cuMemsetD8(cable_initialized_, 0, cable_count_ * 4), "cuMemsetD8 cable initialized");\n'
     '        cable_linear_ = driver_->allocate(cable_count_ * 8 * 36);\n'
     '        cable_angular_ = driver_->allocate(cable_count_ * 8 * 36);\n'
     '        cable_indices_ = driver_->allocate(cable_count_ * 8 * 4);\n'
     '        cable_sizes_ = driver_->allocate(cable_count_ * 4);\n', ''),
    ('        initialize_drive_caches();\n', '        initialize_drive_caches();\n        initialize_cable_caches();\n'),
]
candidate = before
for old, new in changes:
    assert candidate.count(old) == 1, old
    candidate = candidate.replace(old, new, 1)
assert max(map(len, candidate.splitlines())) <= 128
out = BASE / 'candidate-cache-order'
out.mkdir(exist_ok=False)
cpp = out / 'source_solver.cpp'
cpp.write_text(candidate)
command = list(previous['command'])
assert command.count(str(before_path)) == 1
command[command.index(str(before_path))] = str(cpp)
image = out / Path(previous['image']).name
command[-1] = str(image)
inputs = dict(previous['input_sha256'])
inputs.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest()
               for path in (Path(__file__), previous_path, cpp, audit_path)})
record = {'input_sha256': inputs, 'command': command, 'changes_from_scope_candidate': changes,
          'six_typed_zero_cache_initializers_and_position_restored': True, 'solver_arithmetic_changed': False,
          'production_changed': False, 'GPU_runtime_validation_claimed': False, 'whole_solver_complete': False}
(out / 'plan.json').write_text(json.dumps(record, indent=2) + '\n')
with (out / 'build.log').open('w') as log:
    process = subprocess.Popen(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    code = process.wait()
(out / 'build.status.json').write_text(json.dumps({'pid': process.pid, 'actual_exit': code}, indent=2) + '\n')
assert code == 0
for name, expected in inputs.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
record.update(image=str(image), image_sha256=hashlib.sha256(image.read_bytes()).hexdigest())
(out / 'build.json').write_text(json.dumps(record, indent=2) + '\n')
print('Built observed cable cache initialization candidate:', record['image_sha256'], flush=True)
