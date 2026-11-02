"""Capture actual coupled cloth/self constructors, including template and flattened soft-contact layouts."""
from datetime import datetime, timezone
import hashlib
import json
import os
import shutil
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
LEGACY = BASE.parent / 'continuation-20261101-0dabbaa7-driven-cloth-self'
plan = json.loads((LEGACY / 'discovery/plan.json').read_text())
candidate_path = BASE / 'candidate-force-order/build.json'
candidate = json.loads(candidate_path.read_text())
reports = json.loads((BASE / 'force-order-captures/report.json').read_text())['cases']
assert len(reports) == 12 and all(row['actual_exit'] == 0 and row['metadata']['equal'] for row in reports)
assert json.loads((BASE / 'force-order-captures/status.json').read_text())['complete']
output = BASE / 'constructors-force-order'
output.mkdir(exist_ok=False)
host_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
host_bytes = host_path.read_bytes()
host = json.loads(host_bytes)
layout = output / 'kernel-layout.tsv'
layout.write_text(''.join(name + '\t' + ','.join(map(str, spec['parameters'])) + '\n'
                          for name, spec in sorted(host['kernels'].items())))
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
observers = {
    'full-memory': ROOT / 'build/reconstruction-csrc/self-host/memory-observer/memory_trace_full.so',
    'payload': ROOT / 'build/reconstruction-csrc/self-host/payload-observer-v2/payload_trace.so',
    'initializers': ROOT / 'build/reconstruction-csrc/self-host/memory-observer/cupti_param_trace.so',
}
paths = [Path(__file__), candidate_path, BASE / 'worker.py', layout, hook, *observers.values(),
         ROOT / 'reconstruction/csrc/initialization_trace_audit.py', ROOT / 'reconstruction/csrc/memory_pointer_audit.py',
         ROOT / 'reconstruction/csrc/affine_constructor_audit.py', ROOT / 'reconstruction/csrc/demo_source_ab.py',
         ROOT / 'reconstruction/csrc/driven_cloth_self_scene.py']
hashes = dict(plan['input_sha256'])
hashes.update(candidate['input_sha256'])
archive_build = BASE.parent / (
    'continuation-20261102-b82ecd80-cable-closure/before-production-0dabbaa7/'
    'preserved-files/build/reconstruction-csrc/host-particles/build.json')
prior_expected = plan['input_sha256'][str(host_path)]
assert hashlib.sha256(archive_build.read_bytes()).hexdigest() == prior_expected
assert host['extension_sha256'] == 'd09d4be940335764a1e1e7d2f4978366c47e96caf20a3b556d3ac6cfe79e5c68'
hashes[str(archive_build)] = prior_expected
hashes[str(host_path)] = hashlib.sha256(host_bytes).hexdigest()
hashes.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths})
hashes[candidate['image']] = candidate['image_sha256']
cases = [plan['cases'][i] for i in (0, 2, 7, 11)]
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'cases': cases,
    'candidate_image_sha256': candidate['image_sha256'], 'production_changed': False,
    'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


def verify():
    assert host_path.read_bytes() == host_bytes
    for name, sha in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == sha, name


def run(label, command, directory, environment, gpu=True):
    verify()
    if gpu:
        free = int(subprocess.check_output(
            ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
        apps = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
        status['GPU_admission'].append({'case': label, 'UTC': datetime.now(timezone.utc).isoformat(),
                                       'free_memory_MiB': free, 'compute_apps': apps})
        dump()
        assert free >= 4096
    (directory / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (directory / 'run.log').open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=environment, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'label': label, 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'label': label, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    print(label, 'actual exit', code, flush=True)
    assert code == 0
    verify()


env = {k: v for k, v in os.environ.items() if not k.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}
env['PYTHONDONTWRITEBYTECODE'] = '1'
snapshot = json.loads((ROOT / 'RECONSTRUCTION_SNAPSHOT.json').read_text())
original_copies = {}
dump()
audits = []
for case in cases:
    directory = output / case['name']
    directory.mkdir()
    metadata = {'extension_sha256': candidate['image_sha256'], 'kernels': host['kernels'], 'kernel_count': 176,
                'cuda_source_digest': host['cuda_source_digest'], 'candidate_build': str(candidate_path),
                'candidate_exact_command': candidate['command'], 'candidate_input_sha256': candidate['input_sha256'],
                'production_host_sha256': host['extension_sha256'], 'production_changed': False}
    (directory / 'build.json').write_text(json.dumps(metadata, indent=2) + '\n')
    for name, observer in observers.items():
        group = directory / ('external-' + name)
        group.mkdir()
        (group / 'provenance.json').write_text(json.dumps({'sha256': hashes, 'case': case,
                                                        'whole_solver_complete': False}, indent=2) + '\n')
        donor = LEGACY / 'constructors-force-order' / case['name'] / ('external-' + name) / 'original'
        for path in donor.rglob('*'):
            if path.is_file():
                expected = snapshot['files'][str(path.relative_to(ROOT))]
                raw = path.read_bytes()
                assert len(raw) == expected['bytes'] and hashlib.sha256(raw).hexdigest() == expected['sha256']
                original_copies[str(path)] = expected
        shutil.copytree(donor, group / 'original')
        for path in (group / 'original').rglob('*'):
            if path.is_file():
                expected = original_copies[str(donor / path.relative_to(group / 'original'))]
                assert hashlib.sha256(path.read_bytes()).hexdigest() == expected['sha256']
        (output / 'frozen-original-copies.json').write_text(json.dumps(original_copies, indent=2) + '\n')
        for backend in ('source',):
            folder = group / backend
            (folder / 'uploads').mkdir(parents=True)
            command = [sys.executable, '-B', str(BASE / 'worker.py'), '--candidate-build', str(candidate_path),
                       '--backend', backend, '--frames', '3', '--output', str(folder), '--', *case['extra']]
            extra = {'CUPTI_KERNEL_LAYOUT_FILE': str(layout)} if name == 'initializers' else {}
            task_env = {**env, 'LD_PRELOAD': str(observer) + ':' + str(hook), 'CUDAHOOK_DIR': str(folder),
                        'DEMO_MEMORY_TRACE_DIR': str(folder), 'DEMO_POINTERS': '1', **extra}
            run(case['name'] + '-' + name + '-' + backend, command, folder, task_env)
    audit_directory = directory / 'cpu'
    audit_directory.mkdir()
    command = [sys.executable, '-B', '-m', 'reconstruction.csrc.affine_constructor_audit', '--capture', str(directory),
               '--prefix', 'external', '--output', str(directory / 'audit.json')]
    run(case['name'] + '-independent-CPU', command, audit_directory, env, gpu=False)
    report = json.loads((directory / 'audit.json').read_text())
    assert report['all_captured_checks_passed']
    audits.append({'case': case['name'], 'checks': report['checks'],
                   'allocation_counts': report['allocation_event_counts'], 'upload_counts': report['upload_counts'],
                   'typed_counts': report['typed_initializer_counts'], 'owned_launches': report['owned_launches'],
                   'kernel_timeline_counts': report['kernel_timeline_counts']})
    (output / 'report.json').write_text(json.dumps({'cases': audits, 'production_changed': False,
                                                  'whole_solver_complete': False}, indent=2) + '\n')
status['complete'] = True
dump()
print('Four actual driven-self constructor classes passed all five checks', flush=True)
