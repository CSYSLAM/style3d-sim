"""Validate one new source image serially; keep all strict failures and reject ABI/worker failures."""
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
output = base.parent / ('validation-' + metadata['extension_sha256'][:8] + '-legacy-contact')
output.mkdir(exist_ok=False)
(output / 'build.json').write_bytes(saved)
(output / 'driver.py').write_bytes(Path(__file__).read_bytes())
python = sys.executable
surface_reference = base.parent / 'continuation-20261031-b9456031-contact/original16-view-aware'
tasks = [
    ('legacy-source16', [python, '-m', 'reconstruction.csrc.affine_tetrahedron_contact_ab', '--contact-kind', 'legacy',
        '--backend', 'source', '--references', str(base / 'original16'), '--output', str(output / 'legacy-source16')]),
    ('legacy-graph60', [python, '-m', 'reconstruction.csrc.affine_tetrahedron_contact_graph_ab',
        '--contact-kind', 'legacy', '--output', str(output / 'legacy-graph60')]),
    ('surface-source16', [python, '-m', 'reconstruction.csrc.affine_tetrahedron_contact_ab', '--backend', 'source',
        '--references', str(surface_reference), '--output', str(output / 'surface-source16')]),
    ('surface-graph60', [python, '-m', 'reconstruction.csrc.affine_tetrahedron_contact_graph_ab',
        '--output', str(output / 'surface-graph60')]),
    ('legacy-constructor', [python, '-m', 'reconstruction.csrc.affine_tetrahedron_contact_constructor_ab',
        '--contact-kind', 'legacy', '--output', str(output / 'legacy-constructor')]),
    ('noncontact-tet-graph60', [python, '-m', 'reconstruction.csrc.affine_tetrahedron_graph_ab',
        '--output', str(output / 'noncontact-tet-graph60')]),
]
sanitizer = root / 'build/toolchains/diagnostics-13.2/compute-sanitizer/compute-sanitizer'
for backend in ('original', 'source'):
    tasks.append(('legacy-initcheck3-' + backend, [str(sanitizer), '--tool', 'initcheck', '--error-exitcode', '99',
        python, '-m', 'reconstruction.csrc.affine_tetrahedron_contact_graph_ab', '--contact-kind', 'legacy',
        '--worker', backend, '--frames', '3', '--output', str(output / ('legacy-initcheck3-' + backend))]))
status = {'source_sha256': metadata['extension_sha256'], 'complete': False, 'running': None, 'finished': [],
          'regression74_collected': False, 'whole_solver_complete': False}
for name, command in tasks:
    assert build.read_bytes() == saved
    for path, expected in metadata['sources'].items():
        assert hashlib.sha256((root / path).read_bytes()).hexdigest() == expected, path
    if name.startswith('legacy-initcheck'):
        Path(command[-1]).mkdir(exist_ok=False)
    status['running'] = name
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
    (output / (name + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (output / (name + '.log')).open('w') as log:
        code = subprocess.run(command, cwd=root, env=clean_env(), stdout=log, stderr=subprocess.STDOUT,
                              timeout=7200).returncode
    status['finished'].append({'name': name, 'exit': code})
    print(name, 'exit', code, flush=True)
    if name.endswith('source16'):
        rows = json.loads((output / name / 'report.json').read_text())['cases']
        assert len(rows) == 16 and all(not r['exit'] and r['finite'] and r['metadata']['equal'] and r['coverage']
                                     for r in rows), 'Do not classify an ABI/worker failure as atomic variation'
    assert code in (0, 1)
    if name.startswith('legacy-initcheck'):
        assert code == 0
status['running'], status['complete'] = None, True
(output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
