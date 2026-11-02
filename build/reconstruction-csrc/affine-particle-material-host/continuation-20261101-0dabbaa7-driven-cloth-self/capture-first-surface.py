"""Preserve complete first-surface inputs for both fixed short failures without replacing acceptance samples."""
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
plan = json.loads((BASE / 'short-fixed-C8/plan.json').read_text())
build_path = BASE / 'candidate-force-order/build.json'
build = json.loads(build_path.read_text())
out = BASE / 'first-surface-inputs'
out.mkdir(exist_ok=False)
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
hashes = {**plan['input_sha256'], str(Path(__file__)): hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
rows = []
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
       and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
for case in plan['cases']:
    reference = BASE / 'discovery' / case['name'] / 'original'
    line = next(s for s in (reference / 'launches.txt').read_text().splitlines()
                if '30evaluate_surface_contact_force ' in s)
    words = {int(off): int(value, 16) for off, value in re.findall(r'(\d+):([0-9a-f]+)\([^)]*\)', line.split()[5])}
    capacity, local, total, shapes, bodies = [words[i] for i in (8, 112, 120, 200, 264)]
    assert total == 48 and local == 16 and capacity == 180 and shapes == bodies == 2
    fields = {0: ('count', 4)}
    for off, name, width in ((16, 'indices', 12), (24, 'barycentric', 12), (32, 'shape', 4),
                              (40, 'body_pos', 12), (48, 'body_vel', 12), (56, 'normal', 12)):
        fields[off] = (name, capacity * width)
    if words[64]:
        fields[64] = ('particle_only', words[72] * 4)
    else:
        assert words[72] == 0
    for off, name in ((80, 'radius'), (88, 'mass'), (96, 'flags'), (104, 'kind')):
        fields[off] = (name, local * 4)
    for off, name, width in ((128, 'shape_body', 4), (136, 'shape_type', 4), (144, 'transform', 28),
                              (152, 'shape_scale', 12), (160, 'shape_margin', 4), (168, 'shape_ke', 4),
                              (176, 'shape_kd', 4), (184, 'shape_kf', 4), (192, 'shape_mu', 4)):
        fields[off] = (name, shapes * width)
    for off, name, width in ((240, 'body_ids', 4), (248, 'body_indices', 16), (256, 'body_com', 12)):
        fields[off] = (name, bodies * width)
    fields[272], fields[280] = ('x', total * 12), ('previous', total * 12)
    assert len(fields) == 25 and all(words[off] and size > 0 for off, (_, size) in fields.items())
    view_fields = ','.join(f'0{f"+{off}" if off else ""}:{size}' for off, (_, size) in fields.items())
    n = total
    specification = ';'.join([
        '30evaluate_surface_contact_force=1:' + str(n * 12) + ',' + view_fields,
        f'14initialize_rhs=9:{n * 12}',
        f'22accumulate_vertex_face=11:{n * 12},12:{n * 36},14:4',
        f'20accumulate_edge_edge=9:{n * 12},10:{n * 36},12:4',
        f'20accumulate_edge_face=10:{n * 12},11:{n * 36},13:4',
    ])
    for backend in ('original', 'source'):
        while True:
            live = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            if not live:
                break
            time.sleep(5)
        directory = out / case['name'] / backend
        directory.mkdir(parents=True)
        (directory / 'fields.json').write_text(json.dumps(fields, indent=2) + '\n')
        command = [sys.executable, str(BASE / 'worker.py'), '--backend', backend, '--output', str(directory),
                   '--frames', '3']
        if backend == 'source':
            command.extend(['--candidate-build', str(build_path)])
        command.extend(['--', *case['extra']])
        (directory / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        with (directory / 'run.log').open('w') as log:
            worker = subprocess.Popen(command, cwd=ROOT, env={**env, 'LD_PRELOAD': str(hook),
                'CUDAHOOK_DIR': str(directory), 'CUDAHOOK_DUMP': specification, 'CUDAHOOK_DUMP_LIMIT': '1',
                'DRIVEN_SELF_LAYOUT_OUTPUT': str(directory / 'layout.json')}, stdout=log, stderr=subprocess.STDOUT)
            code = worker.wait()
        rows.append({'case': case['name'], 'backend': backend, 'pid': worker.pid, 'actual_exit': code})
        (out / 'status.json').write_text(json.dumps({'complete': False, 'completed': rows}, indent=2) + '\n')
        assert code == 0
        for path in directory.glob('dump_*_pre_*.bin'):
            hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        print(case['name'], backend, 'actual exit', code, flush=True)
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
(out / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'cases': plan['cases'],
    'complete_capacity_preserved_active_prefix_only_interpreted': True, 'first_failed_source0_replaced': False,
    'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
(out / 'status.json').write_text(json.dumps({'complete': True, 'completed': rows}, indent=2) + '\n')
