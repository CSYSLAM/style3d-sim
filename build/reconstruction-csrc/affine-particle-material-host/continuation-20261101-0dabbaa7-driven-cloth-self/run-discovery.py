"""Freeze and run SDK support discovery and the unchanged production guards, strictly serial on an idle GPU."""
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.host_api_probe import REFERENCE, REFERENCE_SHA

out = BASE / 'discovery'
out.mkdir(exist_ok=False)
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
build = json.loads(build_path.read_text())
fixture = ROOT / 'reconstruction/csrc/driven_cloth_self_scene.py'
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
cases = []
for rigidity, worlds, mode, block, contacts, diagonal in (
    ('so3', 1, 'newton', 0, 'none', 0), ('so3', 1, 'pd', 1, 'none', 0),
    ('so3', 3, 'newton', 1, 'none', 0), ('so3', 3, 'pd', 0, 'none', 0),
    ('so3', 1, 'newton', 0, 'legacy', 0), ('so3', 1, 'newton', 1, 'surface', 0),
    ('so3', 3, 'pd', 1, 'legacy', 0), ('so3', 3, 'pd', 0, 'surface', 0),
    ('so3', 1, 'newton', 1, 'none', 1), ('so3', 3, 'pd', 0, 'none', 1),
    ('six-springs', 1, 'newton', 0, 'none', 0), ('six-springs', 3, 'pd', 1, 'surface', 0),
):
    name = f'{rigidity}-w{worlds}-{mode}-b{block}-{contacts}-d{diagonal}'
    extra = ['--rigidity', rigidity, '--worlds', str(worlds), '--seed', str(worlds),
             '--mode', mode, '--contact-kind', contacts]
    if block:
        extra.append('--body-block')
    if diagonal:
        extra.append('--diagonal-only')
    cases.append({'name': name, 'worlds': worlds, 'diagonal': bool(diagonal), 'extra': extra})
hashes = {str(ROOT / name): expected for name, expected in build['sources'].items()}
for path in (Path(__file__), BASE / 'worker.py', fixture, hook, build_path, REFERENCE,
             ROOT / 'reconstruction/csrc/demo_source_ab.py', ROOT / 'reconstruction/csrc/host_bodies_ab.py'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
assert hashes[str(REFERENCE)] == REFERENCE_SHA
plan = {'cases': cases, 'frames': 3, 'SDK_sha256': REFERENCE_SHA, 'source_sha256': build['extension_sha256'],
        'input_sha256': hashes, 'production_changed': False, 'whole_solver_complete': False}
(out / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': [], 'whole_solver_complete': False}
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
       and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}


def dump():
    (out / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
for case in cases:
    n = case['worlds'] * 16
    fields = {'22accumulate_vertex_face': {11: n * 12, 12: n * 36},
              '20accumulate_edge_edge': {9: n * 12, 10: n * 36},
              '20accumulate_edge_face': {10: n * 12, 11: n * 36}}
    if not case['diagonal']:
        for name, counter in (('22accumulate_vertex_face', 14), ('20accumulate_edge_edge', 12),
                              ('20accumulate_edge_face', 13)):
            fields[name][counter] = 4
    specification = ';'.join(name + '=' + ','.join(f'{i}:{size}' for i, size in values.items())
                             for name, values in fields.items())
    for backend in ('original', 'source'):
        for name, expected in hashes.items():
            assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
        while True:
            active = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            if not active:
                break
            status['GPU_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': active})
            dump()
            time.sleep(5)
        folder = out / case['name'] / backend
        folder.mkdir(parents=True)
        command = [sys.executable, str(BASE / 'worker.py'), '--backend', backend, '--output', str(folder),
                   '--frames', '3', '--', *case['extra']]
        (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        with (folder / 'run.log').open('w') as log:
            worker = subprocess.Popen(command, cwd=ROOT, env={**env, 'LD_PRELOAD': str(hook),
                'CUDAHOOK_DIR': str(folder), 'CUDAHOOK_DUMP': specification, 'CUDAHOOK_DUMP_LIMIT': '1',
                'DRIVEN_SELF_LAYOUT_OUTPUT': str(folder / 'layout.json')}, stdout=log, stderr=subprocess.STDOUT)
            status['running'] = {'case': case['name'], 'backend': backend, 'pid': worker.pid}
            dump()
            code = worker.wait()
        row = {'case': case['name'], 'backend': backend, 'pid': worker.pid, 'actual_exit': code}
        if (folder / 'wrapper-provenance.json').exists():
            row['provenance'] = json.loads((folder / 'wrapper-provenance.json').read_text())
        status['completed'].append(row)
        status['running'] = None
        dump()
        print(case['name'], backend, 'actual exit', code, flush=True)
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
status['complete'] = True
dump()
print('Discovery terminal;all24 actual exits retained;no production change', flush=True)
