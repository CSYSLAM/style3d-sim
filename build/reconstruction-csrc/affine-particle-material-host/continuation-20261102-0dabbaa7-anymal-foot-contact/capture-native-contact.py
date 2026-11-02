"""Capture every nonnull flat pointer of real rigid contact force/tangent calls from the same frozen SDK input."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import parameter_types
from reconstruction.csrc.hook_parameter_bytes import decode

OUTPUT = BASE / 'native-contact'
OUTPUT.mkdir(exist_ok=False)
N, B, S, C = 544, 17, 56, 1000
fields = {}
for key in ('22evaluate_contact_force', '24evaluate_contact_tangent'):
    sizes = {0: 4, 2: C * 4, 3: C * 4, 9: C * 4, 10: C * 4,
             11: S * 4, 12: S * 4, 13: S * 28, 14: S * 12,
             23: B * 4, 24: B * 16, 25: B * 12}
    sizes.update({i: C * 12 for i in (4, 5, 6, 7, 8)})
    sizes.update({i: S * 4 for i in (15, 16, 17, 18)})
    if key == '22evaluate_contact_force':
        sizes.update({i: N * 12 for i in (28, 29, 30, 32)})
        sizes[33] = N * 4
    else:
        sizes.update({i: N * 12 for i in (27, 28)})
        sizes.update({i: N * 36 for i in (33, 34)})
    nodes = [decode(line) for line in (BASE / 'common-original/launches.txt').read_text().splitlines()]
    node = next(node for node in nodes if node['key'] == key)
    pointers = {i for i, kind in enumerate(parameter_types(node['name']))
                if '*' in kind and int.from_bytes(bytes.fromhex(node['parameter_hex'][i]), 'little')}
    assert pointers == set(sizes)
    assert node['geometry'] == [4, 1, 1, 256, 1, 1, 0]
    fields[key] = sizes
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
inputs = [Path(__file__), BASE / 'common-step.py', hook, BASE / 'common-original/launches.txt',
          BASE / 'common-source/launches.txt']
hashes = {str(path.resolve()): hashlib.sha256(path.read_bytes()).hexdigest() for path in inputs}
(OUTPUT / 'plan.json').write_text(json.dumps({'fields': fields, 'input_sha256': hashes,
    'outputs': {'22evaluate_contact_force': [32, 33], '24evaluate_contact_tangent': [33, 34]},
    'all_nonnull_flat_pointer_fields_captured': True, 'old_failures_reclassified': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': []}
environment = {key: value for key, value in os.environ.items()
               if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_')) and key != 'LD_PRELOAD'}
environment.update({'PYTHONPATH': str(ROOT), 'PYTHONDONTWRITEBYTECODE': '1', 'LD_PRELOAD': str(hook),
                    'CUDAHOOK_DUMP_LIMIT': '1'})
environment['CUDAHOOK_DUMP'] = ';'.join(key + '=' + ','.join(str(i) + ':' + str(n) for i, n in sizes.items())
                                       for key, sizes in fields.items())


def save():
    (OUTPUT / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


save()
for backend in ('original', 'source'):
    for path, digest in hashes.items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest
    directory = OUTPUT / backend
    command = [sys.executable, '-B', str(BASE / 'common-step.py'), backend, 'synced', str(directory)]
    (OUTPUT / (backend + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (OUTPUT / (backend + '.log')).open('w') as log:
        child = subprocess.Popen(command, cwd=ROOT, env={**environment, 'CUDAHOOK_DIR': str(directory)},
                                 stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'backend': backend, 'pid': child.pid}
        save()
        code = child.wait()
    status['running'] = None
    status['completed'].append({'backend': backend, 'pid': child.pid, 'actual_exit': code})
    save()
    assert code == 0
    print('Actual native foot contact capture', backend, 'exit', code, flush=True)
status['complete'] = True
save()
