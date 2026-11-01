"""Serial validation of the new self/tet/body scope and related preserved contact scopes."""
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
output = base.parent / ('validation-' + metadata['extension_sha256'][:8] + '-self-tet')
output.mkdir(exist_ok=False)
(output / 'build.json').write_bytes(saved)
(output / 'driver.py').write_bytes(Path(__file__).read_bytes())
python = sys.executable
fixture = root / 'reconstruction/csrc/affine_tetrahedron_self_scene.py'
cases = [f'tet-w{worlds}-{mode}-d{diagonal}' for worlds in (1, 3) for mode in ('newton', 'pd') for diagonal in (0, 1)]
tasks = []
for block in (0, 1):
    command = [python, '-m', 'reconstruction.csrc.self_material_ab', '--backend', 'source',
        '--fixture', str(fixture), '--particles-per-world', '24', '--only-case', *cases,
        '--references', str(base / f'original-b{block}'), '--output', str(output / f'source-b{block}')]
    if block:
        command.append('--body-block')
    tasks.append((f'source-b{block}', command))
for diagonal in (0, 1):
    command = [python, '-m', 'reconstruction.csrc.affine_tetrahedron_graph_ab', '--fixture', str(fixture),
        '--particles-per-world', '24', '--output', str(output / f'self-graph60-d{diagonal}')]
    if diagonal:
        command.append('--diagonal-only')
    tasks.append((f'self-graph60-d{diagonal}', command))
tasks += [
    ('self-constructor', [python, '-m', 'reconstruction.csrc.affine_tetrahedron_contact_constructor_ab',
        '--fixture', str(fixture), '--prefix', 'body-tet-self-w3', '--output', str(output / 'self-constructor')]),
    ('legacy-source16', [python, '-m', 'reconstruction.csrc.affine_tetrahedron_contact_ab', '--contact-kind', 'legacy',
        '--backend', 'source', '--references', str(base.parent / 'continuation-20261031-8f4127f0-legacy/original16'),
        '--output', str(output / 'legacy-source16')]),
    ('surface-source16', [python, '-m', 'reconstruction.csrc.affine_tetrahedron_contact_ab', '--backend', 'source',
        '--references', str(base.parent / 'continuation-20261031-b9456031-contact/original16-view-aware'),
        '--output', str(output / 'surface-source16')]),
    ('noncontact-tet-graph60', [python, '-m', 'reconstruction.csrc.affine_tetrahedron_graph_ab',
        '--output', str(output / 'noncontact-tet-graph60')]),
    ('self-contract246', [python, '-m', 'reconstruction.csrc.self_collision_contract_ab',
        '--output', str(output / 'self-contract246')]),
]
sanitizer = root / 'build/toolchains/diagnostics-13.2/compute-sanitizer/compute-sanitizer'
for diagonal in (0, 1):
    for backend in ('original', 'source'):
        name = f'initcheck3-{backend}-d{diagonal}'
        command = [str(sanitizer), '--tool', 'initcheck', '--error-exitcode', '99', python,
            '-m', 'reconstruction.csrc.affine_tetrahedron_graph_ab', '--fixture', str(fixture),
            '--particles-per-world', '24', '--worker', backend, '--frames', '3', '--output', str(output / name)]
        if diagonal:
            command.append('--diagonal-only')
        tasks.append((name, command))
status = {'source_sha256': metadata['extension_sha256'], 'complete': False, 'running': None, 'finished': [],
          'whole_solver_complete': False, 'regression74_collected': False}
for name, command in tasks:
    assert build.read_bytes() == saved
    for path, expected in metadata['sources'].items():
        assert hashlib.sha256((root / path).read_bytes()).hexdigest() == expected, path
    if name.startswith('initcheck'):
        (output / name).mkdir(exist_ok=False)
    status['running'] = name
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
    (output / (name + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (output / (name + '.log')).open('w') as log:
        code = subprocess.run(command, cwd=root, env=clean_env(), stdout=log, stderr=subprocess.STDOUT,
                              timeout=7200).returncode
    status['finished'].append({'name': name, 'exit': code})
    print(name, 'exit', code, flush=True)
    if name.startswith('source-b'):
        rows = json.loads((output / name / 'report.json').read_text())['cases']
        assert len(rows) == 8 and all(not r['worker_exit'] and r['finite'] and r['metadata']['equal'] and r['coverage']
                                    for r in rows), 'Resolve the actual ABI/worker failure before broadening the suite'
    assert code in (0, 1)
    if name.startswith('initcheck') or name == 'self-contract246':
        assert code == 0
status['running'], status['complete'] = None, True
(output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
