"""Capture actual constructor allocation/upload/initializer provenance for the isolated combined-material candidate."""
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
strict = json.loads((BASE / 'candidate2-independent-cpu-audit.json').read_text())
assert strict['passed'] == strict['cases'] == 4
candidate = json.loads((BASE / 'candidate2/build.json').read_text())
output = BASE / 'constructors2'
output.mkdir(exist_ok=False)
build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
build.update(extension_sha256=candidate['image_sha256'], isolated_guard_variant=True,
             production_extension_sha256='38b70dcd9f3ca5053184eca9c6ec64cc33c137248a3e70efa729bd7ff0d92a49')
(output / 'build.json').write_text(json.dumps(build, indent=2) + '\n')
layout = output / 'kernel-layout.tsv'
layout.write_text(''.join(name + '\t' + ','.join(map(str, spec['parameters'])) + '\n'
                          for name, spec in sorted(build['kernels'].items())))
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
observers = {
    'full-memory': ROOT / 'build/reconstruction-csrc/self-host/memory-observer/memory_trace_full.so',
    'payload': ROOT / 'build/reconstruction-csrc/self-host/payload-observer-v2/payload_trace.so',
    'initializers': ROOT / 'build/reconstruction-csrc/self-host/memory-observer/cupti_param_trace.so',
}
paths = [Path(__file__), BASE / 'candidate2-worker.py', ROOT / 'reconstruction/csrc/granular_affine_scene.py',
         ROOT / 'reconstruction/csrc/demo_source_ab.py', ROOT / 'reconstruction/csrc/affine_constructor_audit.py',
         ROOT / 'reconstruction/csrc/initialization_trace_audit.py', ROOT / 'reconstruction/csrc/memory_pointer_audit.py',
         layout, hook, *observers.values(), BASE / 'candidate2/build.json', Path(candidate['image'])]
hashes = dict(candidate['input_sha256'])
hashes.update({str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths})
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'source_image': candidate['image_sha256'],
                                            'extra': ['--mode', 'newton', '--body-block'],
                                            'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_wait_observations': [], 'whole_solver_complete': False}


def dump():
    (output / 'run.status.json').write_text(json.dumps(status, indent=2) + '\n')


def verify():
    for name, digest in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name


def wait_gpu():
    while True:
        live = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        status['GPU_wait_observations'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': live})
        dump()
        if not live:
            return
        print('Constructor waiting for real GPU processes', live, flush=True)
        time.sleep(5)


def execute(label, command, folder, env):
    verify()
    (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (folder / 'run.log').open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'label': label, 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'label': label, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    print(label, 'actual exit', code, flush=True)


env = {k: v for k, v in os.environ.items() if not k.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}
dump()
for name, observer in observers.items():
    group = output / ('granular-affine-w1-' + name)
    group.mkdir()
    (group / 'provenance.json').write_text(json.dumps({'sha256': hashes, 'whole_solver_complete': False}, indent=2) + '\n')
    for backend in ('original', 'source'):
        wait_gpu()
        folder = group / backend
        (folder / 'uploads').mkdir(parents=True)
        command = [sys.executable, str(BASE / 'candidate2-worker.py'), '--worker', backend, '--tag', 'capture',
                   '--example', str(ROOT / 'reconstruction/csrc/granular_affine_scene.py'), '--frames', '3',
                   '--output', str(folder), '--', '--mode', 'newton', '--body-block']
        extra = {'CUPTI_KERNEL_LAYOUT_FILE': str(layout)} if name == 'initializers' else {}
        execute(name + '-' + backend, command, folder,
                {**env, 'LD_PRELOAD': str(observer) + ':' + str(hook), 'CUDAHOOK_DIR': str(folder),
                 'DEMO_MEMORY_TRACE_DIR': str(folder), 'DEMO_POINTERS': '1', **extra})
command = [sys.executable, str(BASE / 'constructor2-audit.py')]
execute('independent-constructor-CPU', command, output, env)
status['complete'] = True
dump()
