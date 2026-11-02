"""Run one real SDK/source H1 graph probe, preserving actual failures before any numeric acceptance claim."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

core_path = BASE / 'candidate-public-core/build.json'
core = json.loads(core_path.read_text())
assert core['source_host_sha256'] == 'f07b35a4733a3196cf66bc22617bfbe1bd23a03ce16772f3df9b18e2819a3b20'
output = BASE / 'public-h1-d2h396-names'
output.mkdir(exist_ok=False)
hashes = {str(ROOT / name): expected for name, expected in core['sources'].items()}
for path in (Path(__file__), core_path, BASE / 'public-h1-d2h396-names-worker.py', BASE / 'h1-asset-manifest.json',
             ROOT / 'examples/example_cloth_h1_free.py'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
(output / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'frames': 4,
    'source_core_sha256': core['extension_sha256'], 'source_host_sha256': core['source_host_sha256'],
    'first_frame_is_original_inline_capture_not_claimed_as_graph_replay': True,
    'original_physics_and_test_final_unchanged': True, 'asset_bytes_pinned': True,
    'numeric_acceptance_claimed': False, 'whole_solver_complete': False}, indent=2) + '\n')
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
    command = ['/usr/local/cuda-12.8/bin/compute-sanitizer', '--tool', 'initcheck',
               '--error-exitcode', '97', sys.executable, '-B',
               str(BASE / 'public-h1-d2h396-names-worker.py'), '--backend', backend,
               '--core-build', str(core_path), '--output', str(output / backend), '--frames', '4']
    (output / (backend + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (output / (backend + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1'},
                                   stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'backend': backend, 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'backend': backend, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    print(backend, 'original H1 graph4/test actual exit', code, flush=True)
status['complete'] = True
dump()
raise SystemExit(int(any(row['actual_exit'] for row in status['completed'])))
