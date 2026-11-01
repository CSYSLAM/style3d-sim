"""Run existing noncontact and broad regression checks after the new contact validation finishes."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

root = Path.cwd().resolve()
sys.path.insert(0, str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

build = root / 'build/reconstruction-csrc/host-particles/build.json'
saved = build.read_bytes()
metadata = json.loads(saved)
out = Path(__file__).resolve().parent.parent / ('validation-' + metadata['extension_sha256'][:8] + '-tet-contact')
state = json.loads((out / 'status.json').read_text())
assert state['complete'] and state['image_sha256'] == metadata['extension_sha256']
assert all(row['exit'] == 0 for row in state['finished']), 'Investigate targeted failures before broadening tests'
(out / 'followup-driver.py').write_bytes(Path(__file__).read_bytes())
status = {'source_sha256': metadata['extension_sha256'], 'complete': False, 'running': None, 'finished': []}
python = sys.executable


def run(name, module, options):
    assert build.read_bytes() == saved
    for path, sha in metadata['sources'].items():
        assert hashlib.sha256((root / path).read_bytes()).hexdigest() == sha, path
    command = [python, '-m', 'reconstruction.csrc.' + module, *map(str, options)]
    status['running'] = name
    (out / 'followup-status.json').write_text(json.dumps(status, indent=2) + '\n')
    (out / (name + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (out / (name + '.log')).open('w') as log:
        code = subprocess.run(command, cwd=root, env=clean_env(), stdout=log, stderr=subprocess.STDOUT,
                              timeout=14400).returncode
    status['finished'].append({'name': name, 'exit': code})
    status['running'] = None
    (out / 'followup-status.json').write_text(json.dumps(status, indent=2) + '\n')
    print(name, 'exit', code, flush=True)
    return code


assert run('noncontact-tet-graph60', 'affine_tetrahedron_graph_ab',
           ['--output', out / 'noncontact-tet-graph60']) == 0
assert run('self-contract246', 'self_collision_contract_ab', ['--output', out / 'self-contract246']) == 0
run('regression74', 'joint_continuation_regression', ['--output', out / 'regression74'])
regression = json.loads((out / 'regression74/status.json').read_text())
assert regression['complete']
failures = [row for row in regression['completed'] if row['exit']]
if failures:
    code = run('regression-fixed-C10', 'regression_fixed_spread',
               ['--validation', out, '--output', out / 'regression-fixed-C10'])
    if code in (0, 1):
        run('regression-fixed-C10-cpu-audit', 'audit_regression_fixed_spread',
            ['--cohort', out / 'regression-fixed-C10', '--report', 'report.json',
             '--output', out / 'regression-fixed-C10/cpu-audit.json'])
status['complete'] = True
(out / 'followup-status.json').write_text(json.dumps(status, indent=2) + '\n')
