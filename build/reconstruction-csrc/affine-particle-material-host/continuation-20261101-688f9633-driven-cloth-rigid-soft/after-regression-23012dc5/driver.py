"""Serial fixed first-candidate and full-worker cohorts on the unchanged source image."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

root = Path.cwd().resolve()
sys.path.insert(0, str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base = Path(__file__).resolve().parent
build = root / 'build/reconstruction-csrc/host-particles/build.json'
saved = build.read_bytes()
metadata = json.loads(saved)
assert metadata['extension_sha256'].startswith('23012dc5')
validation = base / 'validation-23012dc5'
assert json.loads((validation / 'regression-driver-status.json').read_text())['complete']
frontends = json.loads((validation / 'standalone-frontends/status.json').read_text())
assert len(frontends) == 2 and all(row['exit'] == row['recorded_exit'] == 0 for row in frontends)
output = base / 'after-regression-23012dc5'
output.mkdir(exist_ok=False)
(output / 'driver.py').write_bytes(Path(__file__).read_bytes())
(output / 'build.json').write_bytes(saved)
status = {'source_sha256': metadata['extension_sha256'], 'complete': False, 'completed': [],
          'running': None, 'whole_solver_complete': False}
jobs = [
    ('contact-fixed-C8', [str(base / 'run-fixed-contact-C8.py')]),
    ('contact-fixed-C8-cpu-audit', [str(base / 'audit-fixed-contact-C8.py')]),
]
for group in ('soft', 'rigid-soft'):
    jobs.append((group + '-graph60-fixed-C8', [
        '-m', 'reconstruction.csrc.affine_graph_cohort', '--suite', 'driven_cloth_contact',
        '--contact-group', group, '--baseline', str(validation / (group + '-graph60')),
        '--output', str(output / (group + '-graph60-fixed-C8')),
    ]))
for name, arguments in jobs:
    assert build.read_bytes() == saved
    for path, sha in metadata['sources'].items():
        assert hashlib.sha256((root / path).read_bytes()).hexdigest() == sha, path
    command = [sys.executable, *arguments]
    (output / (name + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    status['running'] = name
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
    with (output / (name + '.log')).open('w') as log:
        code = subprocess.run(command, cwd=root, env=clean_env(), stdout=log,
                              stderr=subprocess.STDOUT, timeout=21600).returncode
    assert code in (0, 1), (name, code)
    if name == 'contact-fixed-C8':
        result = json.loads((base / 'fixed-C8-23012dc5/status.json').read_text())
        assert result['complete'] and len(result['completed']) == 26
        assert code == int(not result['all_primary_c_passed'])
    elif name == 'contact-fixed-C8-cpu-audit':
        assert code == 0
        result = json.loads((base / 'fixed-C8-23012dc5-cpu-audit.json').read_text())
        assert result['all_statistics_reproduced'] and len(result['checks']) == 26
    else:
        result = json.loads((output / name / 'report.json').read_text())
        assert len(result['cases']) == 64
        assert code == int(not result['primary_c_passed'])
    status['completed'].append({'name': name, 'exit': code})
    print(name, code, flush=True)
status['complete'], status['running'] = True, None
(output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
