"""Check fresh original/source public-core G1 graph60 runs for uninitialized GPU reads without changing candidates."""
import hashlib
import json
from pathlib import Path
import re
import subprocess
import sys

root = Path.cwd()
sys.path.insert(0, str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

base = Path(__file__).resolve().parent
output = base / 'initcheck60'
output.mkdir(exist_ok=False)
runner = base.parent / ('continuation-20261101-688f9633-driven-cloth-rigid-soft/'
                        'official-g1-public-core-graph60/worker-as-run.py')
core_build = root / 'build/reconstruction-csrc/source-core/a318a3ce42f6a731/build.json'
sanitizer = root / 'build/toolchains/diagnostics-13.2/compute-sanitizer/compute-sanitizer'
saved = (root / 'build/reconstruction-csrc/host-particles/build.json').read_bytes()
build = json.loads(saved)
assert build['extension_sha256'].startswith('38b70dcd')
execute = ("import sys;from pathlib import Path;p=Path(sys.argv.pop(1));"
           "exec(compile(p.read_bytes(),str(p),'exec'),"
           "{'__name__':'__main__','__package__':'reconstruction.csrc','__file__':str(p)})")
status = {'complete': False, 'running': None, 'completed': [], 'whole_solver_complete': False}
for side in ('original', 'source'):
    assert (root / 'build/reconstruction-csrc/host-particles/build.json').read_bytes() == saved
    for name, digest in build['sources'].items():
        assert hashlib.sha256((root / name).read_bytes()).hexdigest() == digest, name
    folder = output / side
    command = [str(sanitizer), '--tool', 'initcheck', '--error-exitcode', '99', sys.executable, '-c', execute,
               str(runner), '--backend', side, '--core-build', str(core_build),
               '--example', 'examples/example_robot_g1.py', '--frames', '60', '--output', str(folder),
               '--', '--solver', 'synreal', '--world-count', '1']
    (output / (side + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    status['running'] = side
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
    path = output / (side + '.log')
    with path.open('w') as log:
        code = subprocess.run(command, cwd=root, env=clean_env(), stdout=log, stderr=subprocess.STDOUT,
                              timeout=3600).returncode
    summaries = list(map(int, re.findall(r'ERROR SUMMARY: (\d+) errors', path.read_text())))
    row = {'side': side, 'exit': code, 'reported_error_summaries': summaries,
           'zero_reported_errors': bool(summaries) and all(value == 0 for value in summaries),
           'log_sha256': hashlib.sha256(path.read_bytes()).hexdigest()}
    status['completed'].append(row)
    status['running'] = None
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
    print(side, row, flush=True)
    assert code in (0, 99), row
status['complete'] = True
(output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
print('Fresh diagnostic runs; original cohorts and source candidates unchanged', flush=True)
