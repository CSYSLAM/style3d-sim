"""Serial fixed full-worker diagnostic, retaining untouched first graph candidates."""
import json
from pathlib import Path
import subprocess
import sys
root = Path.cwd().resolve()
sys.path.insert(0, str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.csrc.compare_host_trace import compare
base = Path(__file__).resolve().parent
assert len(json.loads((base / 'graph-cohorts.status.json').read_text())) == 2
saved = (root / 'build/reconstruction-csrc/host-particles/build.json').read_bytes()
observer = base / 'self-pcg-trace/host_trace.so'
output = base / 'self-pcg-step2'
output.mkdir(exist_ok=False)
(output / 'runner.py').write_bytes((root / 'reconstruction/csrc/tetrahedron_full_worker_trace.py').read_bytes())
for backend in ('original', 'source'):
    command = [sys.executable, '-m', 'reconstruction.csrc.tetrahedron_full_worker_trace', '--backend', backend,
               '--baseline', str(base.parent / 'validation-04b46fb0-self-tet/self-graph60-d0'),
               '--output', str(output / backend), '--start-step', '2', '--steps', '1']
    (output / (backend + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (output / (backend + '.log')).open('w') as log:
        code = subprocess.run(command, env={**clean_env(), 'LD_PRELOAD': str(observer)}, stdout=log,
                              stderr=subprocess.STDOUT, timeout=1800).returncode
    assert code == 0, (backend, code)
    assert (root / 'build/reconstruction-csrc/host-particles/build.json').read_bytes() == saved
    print(backend, 'trace complete', flush=True)
report = compare(output / 'original/native', output / 'source/native')
(output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
print('first difference', report['first_difference'], flush=True)
