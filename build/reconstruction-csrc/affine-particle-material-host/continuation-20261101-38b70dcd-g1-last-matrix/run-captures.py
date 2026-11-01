"""Capture both final-matrix diagnostic trajectories once; preserve every frozen original/source candidate."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

root = Path.cwd()
sys.path.insert(0, str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

base = Path(__file__).resolve().parent
old = base.parent / 'continuation-20261101-38b70dcd-g1-graph-definition'
plan = json.loads((base / 'plan.json').read_text())
fixed = base.parent / 'continuation-20261101-38b70dcd-g1-public-core/graph60-fixed-original-C8/report.json'
fixed_bytes = fixed.read_bytes()
status = {'complete': False, 'running': None, 'completed': [],
          'fixed_C8_report_sha256': hashlib.sha256(fixed_bytes).hexdigest(), 'whole_solver_complete': False}
for backend in ('original', 'source'):
    for name, digest in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
    assert fixed.read_bytes() == fixed_bytes
    command = [sys.executable, '-m', 'reconstruction.csrc.g1_last_matrix_capture', '--backend', backend,
               '--proof', str(base / 'tail-store-origins.json'), '--abi', str(old / 'abi.json'),
               '--warp-schema', str(old / 'warp-schema.json'), '--frames', '60', '--output', str(base / backend)]
    (base / (backend + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    status['running'] = backend
    (base / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
    with (base / (backend + '.log')).open('w') as log:
        code = subprocess.run(command, cwd=root, env=clean_env(), stdout=log,
                              stderr=subprocess.STDOUT, timeout=1800).returncode
    status['completed'].append({'backend': backend, 'exit': code})
    status['running'] = None
    (base / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
    assert fixed.read_bytes() == fixed_bytes
    assert code == 0, (backend, code)
    assert json.loads((base / backend / 'provenance.json').read_text())['frames_read'] == 60
    print(backend, '60 final-matrix packets captured after actual frame downloads', flush=True)
status['complete'] = True
(base / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
