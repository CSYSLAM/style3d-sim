import hashlib
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
env['PYTHONPATH'] = str(root)
status = json.loads((out/'queue-status.json').read_text())
python = sys.executable


def run(name, command, report=None, allow_state_failure=False):
    assert manifest.read_bytes() == saved
    record = {'command': command, 'PYTHONPATH': env['PYTHONPATH']}
    (out/(name+'.command.json')).write_text(json.dumps(record, indent=2)+'\n')
    with (out/(name+'.log')).open('w') as log:
        code = subprocess.run(command, cwd=root, env=env, stdout=log, stderr=subprocess.STDOUT, timeout=14400).returncode
    status['completed'].append({'name': name, 'exit': code})
    (out/'queue-status.json').write_text(json.dumps(status, indent=2)+'\n')
    print(name, code, flush=True)
    if allow_state_failure:
        assert code in (0, 1) and report.is_file(), 'A worker/import error is not an accepted state comparison'
    else:
        assert code == 0, (name, code)


run('graph-cohort8-retry-import', [python, str(out/'graph-cohort8.py')],
    out/'body-cloth-graph-cohort8/report.json', True)
short = json.loads((out/'body-cloth8/report.json').read_text())
for row in short['cases']:
    if row['passed']:
        continue
    assert row['worker_exit'] == 0 and row['finite'] and row['metadata']['equal'] and row['coverage']
    assert all(row['checks'].values())
    name = row['case']
    candidate = out/'body-cloth8'/name
    reference = root/'build/reconstruction-csrc/affine-particle-material-host/validation-0853c9ac/body-cloth-reference8'/name
    destination = out/'short-cohort8'/name
    command = [python, '-m', 'reconstruction.csrc.granular_dense_distribution', '--candidate', str(candidate),
               '--initial-original', str(reference), '--original-runs', '8', '--launch-hook',
               str(root/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'),
               '--dump-spec', str(candidate/'dump.json'), '--output', str(destination)]
    run('short-cohort8-'+name, command, destination/'cohort/report.json', True)
    assert hashlib.sha256((candidate/'capture.npz').read_bytes()).hexdigest() == hashlib.sha256(
        (destination/'cohort/source0.npz').read_bytes()).hexdigest()
directory = out/'graph-initcheck-source3'
assert directory.is_dir() and not any(directory.iterdir())
run('graph-initcheck-source3', ['/usr/local/cuda-12.8/bin/compute-sanitizer', '--tool', 'initcheck',
    '--error-exitcode', '9', python, '-m', 'reconstruction.csrc.affine_cloth_graph_ab', '--worker', 'source',
    '--frames', '3', '--output', str(directory)])
run('self-contract246', [python, '-m', 'reconstruction.csrc.self_collision_contract_ab',
    '--output', str(out/'self-contract246')])
run('regression', [python, '-m', 'reconstruction.csrc.joint_continuation_regression',
    '--output', str(out/'regression')], out/'regression/status.json', True)
status['complete'] = True
(out/'queue-status.json').write_text(json.dumps(status, indent=2)+'\n')
