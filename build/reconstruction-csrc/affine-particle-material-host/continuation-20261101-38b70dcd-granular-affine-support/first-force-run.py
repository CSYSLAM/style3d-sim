"""Capture every actual granular View pointee before the first force call and replay the fixed six packets."""
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
from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
from reconstruction.csrc.library_entries import entries
from reconstruction.csrc.ptx_store_origins_param import store_origins

output = BASE / 'first-force'
output.mkdir(exist_ok=False)
candidate = json.loads((BASE / 'candidate2/build.json').read_text())
broader = json.loads((BASE / 'broader-layouts-v3/report.json').read_text())
assert len(broader['rows']) == 6 and all(r['states']['bitwise'] and r['metadata']['equal'] for r in broader['rows'])
assert [r['case'] for r in broader['rows'] if not r['strict_passed']] == [
    'w3-bodies1-width3-subset0-newton-block1']
build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
token = '15granular_kernel19accumulate_contacts'
name = next(n for n in build['kernels'] if token in n)
assert build['kernels'][name]['parameters'] == [120, 8, 8, 8, 8, 8]
texts, original = kernel_texts(build, name)
proofs = {}
for side, text in texts.items():
    entry = entries(text)[name]
    proof = store_origins(entry, [(i, 0) for i in range(1, 6)])
    assert set(map(tuple, proof['potential_written_pointer_fields'])) == {(i, 0) for i in range(1, 6)}
    proofs[side] = proof
    (output / (side + '-entry.ptx')).write_text(entry)
paths = [Path(__file__), BASE / 'first-force-same-inputs.py', BASE / 'candidate2-worker.py',
         ROOT / 'reconstruction/csrc/granular_affine_layout_scene.py',
         ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so', original,
         BASE / 'broader-layouts-v3/report.json']
frozen_case = BASE / 'broader-layouts-v3/w3-bodies1-width3-subset0-newton-block1'
for side in ('original', 'source'):
    for argument in (1, 2):
        paths.append(frozen_case / side / ('dump_' + token + '_post_arg' + str(argument) + '.bin'))
hashes = dict(candidate['input_sha256'])
hashes.update({str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths})
image = Path(candidate['image'])
hashes[str(image)] = candidate['image_sha256']
runs = [{'label': backend + str(i), 'backend': backend} for backend in ('original', 'source') for i in range(3)]
fields = [(('0+' + str(i * 8)) if i else '0', size) for i, size in enumerate(
          (1024, 324, 324, 324, 972, 972, 972, 324, 324, 10368, 41472))]
fields.extend((str(i), size) for i, size in enumerate((1116, 3348, 324, 10368, 41472), 1))
specification = token + '=' + ','.join(i + ':' + str(size) for i, size in fields)
plan = {'input_sha256': hashes, 'runs': runs, 'dump': specification, 'kernel': name,
        'actual_write_origins': proofs, 'real_replay_calls': 36, 'complete_output_arrays': 180,
        'new_numeric_C_cohort_created': False, 'old_two_buffer_failures_reclassified': False,
        'production_changed': False, 'whole_solver_complete': False}
(output / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': [], 'whole_solver_complete': False}
status_path = output / 'capture.status.json'


def dump():
    status_path.write_text(json.dumps(status, indent=2) + '\n')


def verify():
    for filename, digest in hashes.items():
        assert hashlib.sha256(Path(filename).read_bytes()).hexdigest() == digest, filename


def wait_gpu():
    while True:
        live = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        status['GPU_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': live})
        dump()
        if not live:
            return
        print('Actual force diagnostic GPU wait', live, flush=True)
        time.sleep(5)


def execute(label, command, env):
    verify()
    (output / (label + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (output / (label + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'label': label, 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'label': label, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    print(label, 'actual exit', code, flush=True)
    assert code == 0


env = {k: v for k, v in os.environ.items() if not k.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}
extra = ['--worlds', '3', '--bodies', '1', '--width', '3', '--mode', 'newton', '--body-block']
dump()
for run in runs:
    wait_gpu()
    folder = output / run['label']
    folder.mkdir()
    command = [sys.executable, str(BASE / 'candidate2-worker.py'), '--worker', run['backend'], '--tag', 'capture',
               '--example', str(ROOT / 'reconstruction/csrc/granular_affine_layout_scene.py'),
               '--frames', '3', '--output', str(folder), '--', *extra]
    execute(run['label'], command, {**env, 'LD_PRELOAD': str(paths[4]), 'CUDAHOOK_DIR': str(folder),
                                   'CUDAHOOK_DUMP': specification, 'CUDAHOOK_DUMP_LIMIT': '1',
                                   'GRANULAR_AFFINE_MODEL_OUTPUT': str(folder)})
status['complete'] = True
dump()
status_path = output / 'followup.status.json'
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': [], 'whole_solver_complete': False}
dump()
wait_gpu()
execute('replay', [sys.executable, str(BASE / 'first-force-same-inputs.py')], env)
execute('independent-cpu-audit', [sys.executable, str(BASE / 'first-force-same-inputs.py'), '--audit'], env)
audit = json.loads((output / 'independent-cpu-audit.json').read_text())
assert audit['strict_passed'] == 180
status['complete'] = True
dump()
