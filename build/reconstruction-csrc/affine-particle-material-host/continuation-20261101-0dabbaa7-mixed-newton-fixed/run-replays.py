"""Replay the actual current frozen paths using the SDK, original PTX and independent source kernels."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

pair = BASE / 'frozen-reproduced-mixed-pair'
adopted = json.loads((pair / 'adopted.json').read_text())
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
saved = build_path.read_bytes()
assert (pair / 'solver-build.json').read_bytes() == saved
build = json.loads(saved)
fold = BASE.parent / 'continuation-20261031-86916989-fixed-failures/gpu-three-fold/fold.ptx'
helpers = [ROOT / 'reconstruction/csrc/mixed_pointwise_packet_replay.py',
           ROOT / 'reconstruction/csrc/mixed_atomic_runtime_audit.py', Path(__file__), fold]
hashes = {str(pair / name): sha for name, sha in adopted['files'].items()}
hashes.update({str(ROOT / name): sha for name, sha in build['sources'].items()})
hashes.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in helpers})
output = BASE / 'replays'
output.mkdir(exist_ok=False)
jobs = [{'name': 'pointwise', 'arguments': ['-m', 'reconstruction.csrc.mixed_pointwise_packet_replay',
         '--complete', str(pair), '--frozen', str(pair), '--trials', '2', '--output', str(output / 'pointwise')]}]
for side in ('legacy', 'source'):
    force_calls = sorted((pair / side / 'native').glob('*.22evaluate_stretch_forceE.json'))
    assert len(force_calls) == 9
    for index, path in enumerate(force_calls):
        offset = int(path.name.split('.')[0]) - 3
        name = side + '-NL' + str(index)
        jobs.append({'name': name, 'arguments': ['-m', 'reconstruction.csrc.mixed_atomic_runtime_audit',
                     '--directory', str(pair), '--sum-ptx', str(fold), '--output', str(output / name),
                     '--side', side, '--offset', str(offset)]})
(output / 'plan.json').write_text(json.dumps({'jobs': jobs, 'input_sha256': hashes,
    'source_sha256': build['extension_sha256'], 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': [], 'whole_solver_complete': False}


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
for job in jobs:
    assert build_path.read_bytes() == saved
    for name, sha in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == sha, name
    while True:
        live = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        status['GPU_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': live})
        dump()
        if not live:
            break
        time.sleep(5)
    command = [sys.executable, *job['arguments']]
    (output / (job['name'] + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (output / (job['name'] + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=clean_env(), stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'name': job['name'], 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'name': job['name'], 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    print(job['name'], 'actual exit', code, flush=True)
    assert code == 0
status['complete'] = True
dump()
