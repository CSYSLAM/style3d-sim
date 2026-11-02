"""Read actual inertial-cache CSR prefix arrays before sizing every pointer for a complete native-step capture."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'csr-prefix'
OUTPUT.mkdir(exist_ok=False)
PREVIOUS = BASE.parent / 'continuation-20261102-0dabbaa7-anymal-RHS-preconditioners'
FOOT = BASE.parent / 'continuation-20261102-0dabbaa7-anymal-foot-contact'
hook = PREVIOUS / 'cudahook-selected-owned.so'
worker = FOOT / 'common-step.py'
manifest = ROOT / 'reconstruction/assets/anybotics_anymal_d/manifest.json'
assets = json.loads(manifest.read_text())
inputs = [Path(__file__), hook, worker, manifest, BASE / 'asset-restore.json']
for name, entry in assets['files'].items():
    path = BASE / 'asset-cache' / assets['cache_directory'] / assets['asset_name'] / name
    data = path.read_bytes()
    assert len(data) == entry['bytes'] and hashlib.sha256(data).hexdigest() == entry['sha256']
    inputs.append(path)
hashes = {str(p.resolve()): hashlib.sha256(p.read_bytes()).hexdigest() for p in inputs}
fields = {'31refresh_inertial_cache_nonzeros': {1: (68 * 19 + 1) * 8, 4: (68 * 19 + 1) * 8},
          '32refresh_inertial_cache_diagonals': {1: (68 + 1) * 8}}
environment = {k: v for k, v in os.environ.items() if not k.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
               and k not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
environment.update({'PYTHONPATH': str(ROOT), 'PYTHONDONTWRITEBYTECODE': '1', 'LD_PRELOAD': str(hook),
                    'CUDAHOOK_DUMP_LIMIT': '1', 'CUDAHOOK_DUMP_OWNED': '0,1',
                    'NEWTON_CACHE_PATH': str(BASE / 'asset-cache')})
environment['CUDAHOOK_DUMP'] = ';'.join(k + '=' + ','.join(str(i) + ':' + str(n) for i, n in values.items())
                                       for k, values in fields.items())
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission_policy': 'available-memory'}
raw, rows = {}, []
for backend in ('original', 'source'):
    free = int(subprocess.check_output(
        ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
    apps = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
    assert free >= 4096
    for path, digest in hashes.items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest
    directory = OUTPUT / backend
    command = [sys.executable, '-B', str(worker), backend, 'synced', str(directory)]
    (OUTPUT / (backend + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (OUTPUT / (backend + '.log')).open('w') as log:
        child = subprocess.Popen(command, cwd=ROOT, env={**environment, 'CUDAHOOK_DIR': str(directory)},
                                 stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'backend': backend, 'pid': child.pid}
        (OUTPUT / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
        code = child.wait()
    status['running'] = None
    status['completed'].append({'backend': backend, 'pid': child.pid, 'actual_exit': code,
                                'free_memory_MiB': free, 'compute_apps': apps})
    (OUTPUT / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
    assert code == 0
    for key, sizes in fields.items():
        for i, size in sizes.items():
            before = directory / f'dump_{key}_pre_arg{i}.bin'
            after = directory / f'dump_{key}_post_arg{i}.bin'
            data = before.read_bytes()
            assert len(data) == size and after.read_bytes() == data
            offsets = np.frombuffer(data, dtype='<u8')
            assert offsets[0] == 0 and np.all(offsets[1:] >= offsets[:-1])
            raw[backend, key, i] = data
            rows.append({'backend': backend, 'kind': key, 'argument': i, 'prefix_words': len(offsets),
                         'actual_terminal_count': int(offsets[-1]), 'raw_sha256': hashlib.sha256(data).hexdigest()})
            for path in (before, after):
                hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
    assert len(list(directory.glob('dump_*.bin'))) == 6
    print('Actual CSR prefix discovery', backend, 'exit', code, flush=True)
for key, sizes in fields.items():
    for i in sizes:
        assert raw['original', key, i] == raw['source', key, i]
for path, digest in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest
status['complete'] = True
(OUTPUT / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
report = {'prefix_arrays': rows, 'original_source_all_prefix_bytes_equal': True, 'input_sha256': hashes,
          'ids_extent_inferred_from_real_terminal_offsets': True, 'ids_contents_already_verified': False,
          'whole_native_step_verified': False, 'production_changed': False}
(OUTPUT / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
print('Actual CSR terminal counts:', [(r['kind'], r['argument'], r['actual_terminal_count']) for r in rows[:3]])
