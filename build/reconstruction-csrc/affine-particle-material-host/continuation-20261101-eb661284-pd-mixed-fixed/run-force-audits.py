"""Audit both real scatter entries in all nine nonlinear rounds of both reproduced frozen PD paths."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

root = Path.cwd()
base = Path(__file__).resolve().parent
pair = base / 'frozen-reproduced-pd-pair'
output = base / 'force-audits18'
output.mkdir(exist_ok=False)
saved = (root / 'build/reconstruction-csrc/host-particles/build.json').read_bytes()
fold = base.parent / 'continuation-20261031-86916989-fixed-failures/gpu-three-fold/fold.ptx'
files = (Path(__file__), fold, root / 'reconstruction/csrc/mixed_atomic_runtime_audit.py')
hashes = {str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in files}
jobs = []
for side in ('legacy', 'source'):
    starts = sorted((pair / side / 'native').glob('*.21evaluate_spring_forceE.json'))
    assert len(starts) == 9
    for number, path in enumerate(starts):
        offset = int(path.name.split('.')[0]) - 2
        assert list(path.parent.glob(f'{offset + 3:06d}.22evaluate_stretch_forceE.json'))
        jobs.append((side, number, offset))
(output / 'plan.json').write_text(json.dumps({'jobs': jobs, 'input_sha256': hashes,
    'production_changed': False, 'cohort_expanded': False, 'whole_solver_complete': False}, indent=2) + '\n')
rows = []
for side, number, offset in jobs:
    assert (root / 'build/reconstruction-csrc/host-particles/build.json').read_bytes() == saved
    assert all(hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha for path, sha in hashes.items())
    tag = f'{side}-{number}'
    command = [sys.executable, '-m', 'reconstruction.csrc.mixed_atomic_runtime_audit', '--directory', str(pair),
               '--sum-ptx', str(fold), '--side', side, '--offset', str(offset), '--force-only',
               '--output', str(output / tag)]
    (output / (tag + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    (output / 'status.json').write_text(json.dumps({'complete': False, 'running': tag, 'rows': rows}, indent=2) + '\n')
    with (output / (tag + '.log')).open('w') as log:
        code = subprocess.run(command, cwd=root, stdout=log, stderr=subprocess.STDOUT, timeout=1800).returncode
    row = {'side': side, 'round': number, 'offset': offset, 'exit': code}
    rows.append(row)
    (output / 'status.json').write_text(json.dumps({'complete': False, 'running': None, 'rows': rows}, indent=2) + '\n')
    print(tag, 'offset', offset, 'exit', code, flush=True)
    assert code == 0, row
(output / 'status.json').write_text(json.dumps({'complete': True, 'running': None, 'rows': rows}, indent=2) + '\n')
