"""Serial paired H1 graph observations, with actual core versions separated from the shared ABI schema build."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

output = BASE / 'public-h1-graph-with-alloc'
output.mkdir(exist_ok=False)
old = BASE.parent / 'continuation-20261101-38b70dcd-g1-graph-definition/abi.json'
snapshot = json.loads((ROOT / 'RECONSTRUCTION_SNAPSHOT.json').read_text())
entry = snapshot['files'][str(old.relative_to(ROOT))]
assert len(old.read_bytes()) == entry['bytes'] and hashlib.sha256(old.read_bytes()).hexdigest() == entry['sha256']
shutil.copyfile(old, output / 'abi.json')
core_path = BASE / 'candidate-public-core/build.json'
core = json.loads(core_path.read_text())
hashes = {str(ROOT / name): expected for name, expected in core['sources'].items()}
for path in (Path(__file__), BASE / 'public-h1-graph-with-alloc-worker.py', BASE / 'public-h1-worker.py',
             BASE / 'h1-asset-manifest.json', core_path, old, output / 'abi.json',
             ROOT / 'reconstruction/csrc/graph_definition_dump.py',
             ROOT / 'build/reconstruction-csrc/host-particles/build.json',
             BASE / 'public-h1-graph/alloc-query.cpp', BASE / 'public-h1-graph/alloc-query.so',
             BASE / 'public-h1-graph/alloc-query.compile.status.json'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'source_core_sha256': core['extension_sha256'],
    'source_host_sha256': core['source_host_sha256'], 'frames': 4, 'readonly_graph_observation': True,
    'raw_dump_source_host_sha256_describes_ABI_schema_not_actual_loaded_candidate': True,
    'fixed_C8_not_modified': True, 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
for backend in ('original', 'source'):
    for name, expected in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    free = int(subprocess.check_output(
        ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
    apps = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
    status['GPU_admission'].append({'backend': backend, 'UTC': datetime.now(timezone.utc).isoformat(),
                                   'free_memory_MiB': free, 'compute_apps': apps})
    assert free >= 4096
    command = [sys.executable, '-B', str(BASE / 'public-h1-graph-with-alloc-worker.py'), '--backend', backend,
               '--core-build', str(core_path), '--abi', str(output / 'abi.json'), '--output', str(output / backend)]
    (output / (backend + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (output / (backend + '.log')).open('w') as log:
        worker = subprocess.Popen(command, cwd=ROOT, env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1'},
                                  stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'backend': backend, 'pid': worker.pid}
        dump()
        code = worker.wait()
    status['completed'].append({**status['running'], 'actual_exit': code})
    status['running'] = None
    dump()
    print('H1 readonly graph:', backend, 'actual exit', code, flush=True)
status['complete'] = True
dump()
raise SystemExit(int(any(row['actual_exit'] for row in status['completed'])))
