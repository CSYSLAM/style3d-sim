"""Promote exactly the tested cache and weight-order source after closure, preserving the verified0dab checkpoint."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
output = BASE / 'production-build'
assert not output.exists()
for name, cases in (('mixed-short', 16), ('dynamic-mixed-short', 16), ('penalty30', 48)):
    audit = json.loads((BASE / (name + '-independent-cpu.json')).read_text())
    assert audit['strict_cases'] == cases
graphs = json.loads((BASE / 'graph60-independent-cpu.json').read_text())
assert len(graphs['candidates']) == 2 and all(row['strict_pairs'] == 64 for row in graphs['candidates'])
weight_short = json.loads((BASE / 'dynamic-mixed-short-weight-independent-cpu.json').read_text())
assert weight_short['strict_cases'] == 16
weight_graph = json.loads((BASE / 'graph60-weight-independent-cpu.json').read_text())
assert len(weight_graph['candidates']) == 1 and weight_graph['candidates'][0]['strict_pairs'] == 64
constructors = json.loads((BASE / 'constructors-weight-order/report.json').read_text())
status = json.loads((BASE / 'constructors-weight-order/status.json').read_text())
assert status['complete'] and status['running'] is None and len(status['completed']) == 14
assert all(row['actual_exit'] == 0 for row in status['completed'])
assert len(constructors['cases']) == 2 and all(all(row['checks'].values()) for row in constructors['cases'])
activity = json.loads((BASE / 'dynamic-activity-independent-cpu.json').read_text())
assert activity['all_actual_body_position_trajectories_move'] and activity['total_body_trajectories'] == 128
candidate_path = BASE / 'candidate-weight-order/build.json'
candidate = json.loads(candidate_path.read_text())
for name, expected in candidate['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
checkpoint = BASE / 'before-production-0dabbaa7'
preserved = json.loads((checkpoint / 'checkpoint.json').read_text())
assert preserved['source_sha256'] == '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
for name, expected in preserved['files'].items():
    assert hashlib.sha256((checkpoint / 'preserved-files' / name).read_bytes()).hexdigest() == expected, name
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
before_build = json.loads(build_path.read_text())
assert before_build['extension_sha256'] == preserved['source_sha256']
cpp = ROOT / 'reconstruction/csrc/native/source_solver.cpp'
assert hashlib.sha256(cpp.read_bytes()).hexdigest() == preserved['files'][str(cpp.relative_to(ROOT))]
candidate_cpp = BASE / 'candidate-weight-order/source_solver.cpp'
data = candidate_cpp.read_bytes()
assert hashlib.sha256(data).hexdigest() == candidate['input_sha256'][str(candidate_cpp)]
assert max(map(len, data.decode().splitlines())) <= 128
output.mkdir()
(output / 'before-build.json').write_bytes(build_path.read_bytes())
inputs = {str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in
          (Path(__file__), candidate_cpp, checkpoint / 'checkpoint.json', candidate_path)}
record = {'before_host_sha256': before_build['extension_sha256'], 'candidate_host_sha256': candidate['image_sha256'],
          'input_sha256': inputs, 'promoted_CPP_exactly_equals_verified_candidate': True,
          'solver_arithmetic_changed': False, 'old_fixed_failures_retained': True, 'whole_solver_complete': False}
(output / 'plan.json').write_text(json.dumps(record, indent=2) + '\n')
cpp.write_bytes(data)
command = [sys.executable, '-B', '-m', 'reconstruction.csrc.build_host']
(output / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
with (output / 'build.log').open('w') as log:
    process = subprocess.Popen(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    code = process.wait()
(output / 'status.json').write_text(json.dumps({'pid': process.pid, 'actual_exit': code}, indent=2) + '\n')
assert code == 0 and cpp.read_bytes() == data
after = json.loads(build_path.read_text())
assert after['kernel_count'] == before_build['kernel_count'] == 176
assert after['kernels'] == before_build['kernels'] and after['cuda_source_digest'] == before_build['cuda_source_digest']
image = build_path.parent / '_source_solver.cpython-312-x86_64-linux-gnu.so'
assert hashlib.sha256(image.read_bytes()).hexdigest() == after['extension_sha256']
(output / 'after-build.json').write_bytes(build_path.read_bytes())
record.update(new_host_sha256=after['extension_sha256'], actual_build_exit=code,
              all176_kernel_specs_and_CUDA_digest_unchanged=True, current_image_validation_complete=False)
(output / 'report.json').write_text(json.dumps(record, indent=2) + '\n')
print('Promoted exact verified source; new host', after['extension_sha256'], ';current-image validation pending', flush=True)
