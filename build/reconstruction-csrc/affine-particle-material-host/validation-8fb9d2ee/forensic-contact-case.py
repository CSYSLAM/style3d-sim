import json
import os
from pathlib import Path
import subprocess
import sys

root = Path.cwd()
out = Path(__file__).resolve().parent
manifest = root/'build/reconstruction-csrc/host-particles/build.json'
saved = manifest.read_bytes()
assert saved == (out/'build.json').read_bytes()
env = {k: v for k, v in os.environ.items() if k not in (
    'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR', 'CUDAHOOK_DUMP',
    'CUDAHOOK_DUMP_LIMIT', 'DEMO_MEMORY_TRACE_DIR', 'DEMO_NATIVE_TRACE_DIR')}
python = sys.executable
target = out/'contact-case-constructor'
target.mkdir(exist_ok=False)
(target/'build.json').write_bytes(saved)
jobs = []
extra = ['--worlds', '3', '--mode', 'newton', '--body-block', '--diagonal-only', '--contacts', '--self', '--springs']
for label, observer, options in (
    ('full-memory', 'memory_trace_full.so', []),
    ('payload', '../payload-observer-v2/payload_trace.so', []),
    ('initializers', 'cupti_param_trace.so', ['--parameter-layout',
        str(root/'build/reconstruction-csrc/self-host/memory-observer/initialization-layouts.tsv')])):
    jobs.append(('cloth-w3-'+label, [python, '-m', 'reconstruction.csrc.demo_memory_ab', '--memory-observer',
        str(root/'build/reconstruction-csrc/self-host/memory-observer'/observer), *options,
        '--example', 'reconstruction/csrc/affine_cloth_scene.py', '--frames', '3',
        '--output', str(target/('cloth-w3-'+label)), '--', *extra]))
jobs.append(('constructor-audit', [python, '-m', 'reconstruction.csrc.affine_constructor_audit',
    '--capture', str(target), '--output', str(target/'audit.json')]))
for backend in ('original', 'source'):
    jobs.append(('contact-graph-trace-'+backend, [python, '-m', 'reconstruction.csrc.cloth_graph_buffer_trace',
        '--backend', backend, '--graphs', '14', '15', '--snapshot-runs', '2', '--frames', '60',
        '--output', str(out/('contact-graph-trace-'+backend))]))
status = []
for name, command in jobs:
    assert manifest.read_bytes() == saved
    (target/(name+'.command.json')).write_text(json.dumps(command, indent=2)+'\n')
    with (target/(name+'.log')).open('w') as log:
        code = subprocess.run(command, cwd=root, env=env, stdout=log, stderr=subprocess.STDOUT, timeout=3600).returncode
    status.append({'name': name, 'exit': code})
    (target/'status.json').write_text(json.dumps(status, indent=2)+'\n')
    print(name, code, flush=True)
    assert code == 0, (name, code)
