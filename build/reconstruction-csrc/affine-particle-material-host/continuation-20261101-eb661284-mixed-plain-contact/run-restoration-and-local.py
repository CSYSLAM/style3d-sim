"""Run the captured guard restoration, strict source matrix and local validation in serial."""
import json
from pathlib import Path
import subprocess
import sys

root = Path.cwd()
base = Path(__file__).resolve().parent
assert json.loads((base / 'original32/report.json').read_text())['complete']
status = {'complete': False, 'completed': [], 'running': None, 'whole_solver_complete': False}
for stage, script in (('restore-captured-scope', 'restore-captured-scope.py'),
                      ('source32', 'capture-source32.py'), ('local-validation', 'run-local-validation.py')):
    status['running'] = stage
    (base / 'restoration-status.json').write_text(json.dumps(status, indent=2) + '\n')
    command = [sys.executable, str(base / script)]
    (base / (stage + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (base / (stage + '.log')).open('w') as log:
        code = subprocess.run(command, cwd=root, stdout=log, stderr=subprocess.STDOUT, timeout=14400).returncode
    status['completed'].append({'stage': stage, 'exit': code})
    status['running'] = None
    (base / 'restoration-status.json').write_text(json.dumps(status, indent=2) + '\n')
    print(stage, code, flush=True)
    assert code == 0, (stage, code)
    if stage == 'source32':
        build = json.loads((root / 'build/reconstruction-csrc/host-particles/build.json').read_text())
        report = json.loads((base / ('source32-' + build['extension_sha256'][:8]) / 'report.json').read_text())
        assert report['complete'] and len(report['cases']) == 32
        bad = [row['case'] for row in report['cases'] if not row['passed']]
        assert not bad, bad
status['complete'] = True
(base / 'restoration-status.json').write_text(json.dumps(status, indent=2) + '\n')
