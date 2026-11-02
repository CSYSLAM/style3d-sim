"""Run the user's five named demos through the newly compiled public source Core, serially and without SDK mapping."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

core_path = ROOT / 'build/reconstruction-csrc/source-core/9cb2fcaa1082d1df/build.json'
core = json.loads(core_path.read_text())
assert core['source_host_sha256'] == 'd09d4be940335764a1e1e7d2f4978366c47e96caf20a3b556d3ac6cfe79e5c68'
assert core['extension_sha256'] == '55d626f06c10c7f6cbc48663bf7fde25be1cfcd8edfb4ce8cf57f30fd300dab5'
output = BASE / 'normal-core-five60'
output.mkdir(exist_ok=False)
cases = [('cloth-particles', 'examples/example_cloth_particles.py'), ('ball-cloth', 'examples/example_ball_cloth.py'),
         ('cable-bend', 'examples/cable/example_cable_bend_stiffness.py'),
         ('cable-bundle', 'examples/cable/example_cable_bundle_hysteresis.py'),
         ('anymal', 'examples/example_robot_anymal_d.py')]
hashes = {str(ROOT / name): sha for name, sha in core['sources'].items()}
hashes.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in
               (Path(__file__), core_path, core_path.parent / '_core.cpython-312-x86_64-linux-gnu.so',
                ROOT / 'reconstruction/core_demo.py', *[ROOT / example for _, example in cases])})
(output / 'plan.json').write_text(json.dumps({'cases': cases, 'frames': 60, 'input_sha256': hashes,
    'source_core_sha256': core['extension_sha256'], 'own_GPU_workers_serial': True, 'external_apps_allowed': True,
    'normal_graph_entrypoint_check_only': True, 'numerical_equivalence_claimed': False,
    'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
env = {**clean_env(), 'PYTHONPATH': str(ROOT), 'PYTHONDONTWRITEBYTECODE': '1'}
env['NEWTON_CACHE_PATH'] = str(BASE.parent / 'continuation-20261101-0dabbaa7-official-demo-four/shared-GPU-v2/asset-cache')
for name, example in cases:
    for path, expected in hashes.items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
    free = int(subprocess.check_output(
        ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
    apps = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
    status['GPU_admission'].append({'case': name, 'free_memory_MiB': free, 'compute_apps': apps,
                                    'UTC': datetime.now(timezone.utc).isoformat()})
    assert free >= 4096
    report = output / (name + '.json')
    command = [sys.executable, '-B', '-m', 'reconstruction.core_demo', '--core-build', str(core_path),
               '--report', str(report), str(ROOT / example), '--', '--viewer', 'null', '--num-frames', '60']
    (output / (name + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (output / (name + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'case': name, 'pid': process.pid}
        dump()
        code = process.wait()
    row = {'case': name, 'pid': process.pid, 'actual_exit': code}
    if code == 0:
        data = json.loads(report.read_text())
        assert data['source_sha256'] == core['extension_sha256'] and data['source_only'] and data['public_core_abi']
        assert not data['reference_solver_mapped'] and data['exit'] == 0
    status['completed'].append(row)
    status['running'] = None
    dump()
    print(name, 'normal public Core60 actual exit', code, flush=True)
status['complete'] = True
dump()
raise SystemExit(int(any(row['actual_exit'] for row in status['completed'])))
