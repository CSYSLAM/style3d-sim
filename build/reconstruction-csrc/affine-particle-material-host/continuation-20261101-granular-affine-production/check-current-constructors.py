"""After the live validation driver finishes, compare current-host constructor captures with frozen SDK captures."""
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
build_bytes = build_path.read_bytes()
build = json.loads(build_bytes)
validation = BASE / ('validation-' + build['extension_sha256'][:8])
output = BASE / ('constructors-' + build['extension_sha256'][:8])
output.mkdir(exist_ok=False)
(output / 'build.json').write_bytes(build_bytes)
old = BASE.parent / 'continuation-20261101-38b70dcd-granular-affine-support/constructors2'
layout = output / 'kernel-layout.tsv'
layout.write_text(''.join(name + '\t' + ','.join(map(str, spec['parameters'])) + '\n'
                          for name, spec in sorted(build['kernels'].items())))
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
observers = {
    'full-memory': ROOT / 'build/reconstruction-csrc/self-host/memory-observer/memory_trace_full.so',
    'payload': ROOT / 'build/reconstruction-csrc/self-host/payload-observer-v2/payload_trace.so',
    'initializers': ROOT / 'build/reconstruction-csrc/self-host/memory-observer/cupti_param_trace.so',
}
paths = [Path(__file__), layout, hook, *observers.values(),
         ROOT / 'reconstruction/csrc/initialization_trace_audit.py',
         ROOT / 'reconstruction/csrc/affine_constructor_audit.py', ROOT / 'reconstruction/csrc/memory_pointer_audit.py',
         ROOT / 'reconstruction/csrc/demo_source_ab.py', ROOT / 'reconstruction/csrc/granular_affine_scene.py']
hashes = {str(ROOT / p): sha for p, sha in build['sources'].items()}
hashes.update({str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths})
preceding = (BASE / 'run-validation.py').resolve()
matches = []
for proc in Path('/proc').iterdir():
    if not proc.name.isdigit():
        continue
    try:
        args = (proc / 'cmdline').read_bytes().split(b'\0')
        if len(args) > 1 and args[1] and Path(os.fsdecode(args[1])).resolve() == preceding:
            matches.append({'pid': int(proc.name), 'starttime': (proc / 'stat').read_text().rsplit(')', 1)[1].split()[19]})
    except (OSError, ValueError):
        continue
assert len(matches) <= 1
for group in observers:
    src = old / ('granular-affine-w1-' + group) / 'original'
    dst = output / ('granular-affine-w1-' + group)
    dst.mkdir()
    shutil.copytree(src, dst / 'original')
    copied = {str(p.relative_to(dst / 'original')): hashlib.sha256(p.read_bytes()).hexdigest()
              for p in (dst / 'original').rglob('*') if p.is_file()}
    hashes.update({str(dst / 'original' / p): sha for p, sha in copied.items()})
    (dst / 'provenance.json').write_text(json.dumps({'original_capture_source': str(src),
        'original_capture_files': copied, 'current_source_sha256': build['extension_sha256'],
        'original_runs_reused_unchanged': True, 'whole_solver_complete': False}, indent=2) + '\n')
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'preceding_live_driver': matches,
    'extra': ['--mode', 'newton', '--body-block'], 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'driver_waits': [], 'GPU_waits': [],
          'whole_solver_complete': False}


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


def verify():
    assert build_path.read_bytes() == build_bytes
    for name, sha in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == sha, name


dump()
if matches:
    identity = matches[0]
    while True:
        try:
            actual = Path('/proc', str(identity['pid']), 'stat').read_text().rsplit(')', 1)[1].split()[19]
        except FileNotFoundError:
            break
        if actual != identity['starttime']:
            break
        status['driver_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), **identity})
        dump()
        time.sleep(2)
assert json.loads((validation / 'status.json').read_text())['complete']
assert all(row['strict_passed'] for row in json.loads((validation / 'short-report.json').read_text()))
assert all(row['bitwise'] for row in json.loads((validation / 'graph-report.json').read_text()).values())
env = {k: v for k, v in os.environ.items() if not k.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}
for name, observer in observers.items():
    verify()
    while True:
        live = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        status['GPU_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': live})
        dump()
        if not live:
            break
        time.sleep(5)
    folder = output / ('granular-affine-w1-' + name) / 'source'
    (folder / 'uploads').mkdir(parents=True)
    command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', 'source', '--tag', 'capture',
               '--example', str(ROOT / 'reconstruction/csrc/granular_affine_scene.py'), '--frames', '3',
               '--output', str(folder), '--', '--mode', 'newton', '--body-block']
    extra = {'CUPTI_KERNEL_LAYOUT_FILE': str(layout)} if name == 'initializers' else {}
    task_env = {**env, 'LD_PRELOAD': str(observer) + ':' + str(hook), 'CUDAHOOK_DIR': str(folder),
                'DEMO_MEMORY_TRACE_DIR': str(folder), 'DEMO_POINTERS': '1', **extra}
    (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (folder / 'run.log').open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=task_env, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'name': name, 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'name': name, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    print(name, 'actual exit', code, flush=True)
    assert code == 0
    verify()
command = [sys.executable, '-m', 'reconstruction.csrc.affine_constructor_audit', '--capture', str(output),
           '--prefix', 'granular-affine-w1', '--output', str(output / 'audit.json')]
(output / 'audit.command.json').write_text(json.dumps(command, indent=2) + '\n')
with (output / 'audit.log').open('w') as log:
    process = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
    code = process.wait()
status['completed'].append({'name': 'independent-CPU', 'pid': process.pid, 'actual_exit': code})
dump()
assert code == 0
status['complete'] = True
dump()
verify()
print('Current source constructor checks all passed', flush=True)
