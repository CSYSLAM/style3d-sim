"""Test three predeclared current public Core trajectories against the unchanged eight SDK references."""
from contextlib import ExitStack
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys

import numpy as np

root = Path.cwd()
sys.path.insert(0, str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.demo_ab import compare, spread_report

base = Path(__file__).resolve().parent
old = base.parent / 'continuation-20261101-688f9633-driven-cloth-rigid-soft'
original_report_path = old / 'official-g1-public-core-graph60-fixed-C8/report.json'
original_report = json.loads(original_report_path.read_text())
runner = old / 'official-g1-public-core-graph60/worker-as-run.py'
core_build = root / 'build/reconstruction-csrc/source-core/9cb2fcaa1082d1df/build.json'
core = json.loads(core_build.read_text())
build_path = root / 'build/reconstruction-csrc/host-particles/build.json'
saved = build_path.read_bytes()
metadata = json.loads(saved)
assert core['source_host_sha256'] == metadata['extension_sha256']
assert core['extension_sha256'] == '55d626f06c10c7f6cbc48663bf7fde25be1cfcd8edfb4ce8cf57f30fd300dab5'
assert metadata['extension_sha256'] == 'd09d4be940335764a1e1e7d2f4978366c47e96caf20a3b556d3ac6cfe79e5c68'
output = base / 'graph60-fixed-original-C8'
output.mkdir(exist_ok=False)
(output / 'driver-as-run.py').write_bytes(Path(__file__).read_bytes())
(output / 'build.json').write_bytes(saved)
(output / 'core-build.json').write_bytes(core_build.read_bytes())
locked = {str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in
          (Path(__file__), original_report_path, runner, core_build, root / 'examples/example_robot_g1.py')}
assets = json.loads((old / 'official-g1-asset-manifest.json').read_text())
for name, entry in assets['files'].items():
    locked[str(Path(assets['cache_root']) / name)] = entry['sha256']
paths, original_runtime = {}, None
for index in range(8):
    tag = 'original' + str(index)
    source = Path(original_report['input_npz_paths'][tag])
    expected = original_report['input_npz_sha256'][tag]
    assert hashlib.sha256(source.read_bytes()).hexdigest() == expected
    runtime = json.loads(source.with_name('runtime.json').read_text())
    if original_runtime is None:
        original_runtime = runtime
    assert runtime == original_runtime
    folder = output / tag
    folder.mkdir()
    shutil.copyfile(source, folder / 'states.npz')
    shutil.copyfile(source.with_name('runtime.json'), folder / 'runtime.json')
    paths[tag] = folder / 'states.npz'
    locked[str(source)] = expected
    locked[str(paths[tag])] = expected
assert hashlib.sha256(runner.read_bytes()).hexdigest() == original_runtime['runner_sha256']
assert hashlib.sha256((root / 'examples/example_robot_g1.py').read_bytes()).hexdigest() == original_runtime['example_sha256']
(output / 'plan.json').write_text(json.dumps({
    'source_runs': 3, 'frozen_original_runs': 8, 'new_original_runs': 0,
    'source_host_sha256': metadata['extension_sha256'], 'public_core_sha256': core['extension_sha256'],
    'input_sha256': locked, 'source_candidates_selected_after_results': False,
    'old_failure_replaced': False, 'whole_solver_complete': False,
    'own_GPU_workers_serial': True, 'external_apps_allowed': True, 'minimum_free_memory_MiB': 4096,
}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [],
          'whole_solver_complete': False}
execute = ("import sys;from pathlib import Path;p=Path(sys.argv.pop(1));"
           "exec(compile(p.read_bytes(),str(p),'exec'),"
           "{'__name__':'__main__','__package__':'reconstruction.csrc','__file__':str(p)})")
for index in range(3):
    assert build_path.read_bytes() == saved
    for name, digest in locked.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
    for name, digest in metadata['sources'].items():
        assert hashlib.sha256((root / name).read_bytes()).hexdigest() == digest, name
    free = int(subprocess.check_output(
        ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
    apps = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
    status['GPU_admission'].append({'case': index, 'free_memory_MiB': free, 'compute_apps': apps,
                                    'UTC': datetime.now(timezone.utc).isoformat()})
    assert free >= 4096
    tag = 'source' + str(index)
    folder = output / tag
    command = [sys.executable, '-B', '-c', execute, str(runner), '--backend', 'source', '--core-build', str(core_build),
               '--example', 'examples/example_robot_g1.py', '--frames', '60', '--output', str(folder),
               '--', '--solver', 'synreal', '--world-count', '1']
    status['running'] = tag
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
    (output / (tag + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (output / (tag + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=root, env={**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1'},
                                   stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'case': tag, 'pid': process.pid}
        (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
        code = process.wait(timeout=1800)
    assert code == 0, (tag, code)
    runtime = json.loads((folder / 'runtime.json').read_text())
    expected = {**original_runtime, 'backend': 'source', 'image_sha256': core['extension_sha256'],
                'reference_solver_mapped': False}
    assert runtime == expected, (tag, runtime, expected)
    paths[tag] = folder / 'states.npz'
    status['completed'].append({'name': tag, 'exit': code})
    status['running'] = None
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
    print(tag, 'normal public core graph60 and --test completed', flush=True)
with ExitStack() as stack:
    originals = [stack.enter_context(np.load(paths[f'original{i}'])) for i in range(8)]
    sources = [stack.enter_context(np.load(paths[f'source{i}'])) for i in range(3)]
    assert all(set(run.files) == set(originals[0].files) for run in originals + sources)
    assert all(run[key].shape == originals[0][key].shape and np.isfinite(run[key]).all()
               for run in originals + sources for key in run.files)
    statistics = {f'source{i}': spread_report(originals, [run]) for i, run in enumerate(sources)}
    within = {tag: {key: row['substeps_within_spread'] == row['substeps'] for key, row in fields.items()}
              for tag, fields in statistics.items()}
    report = {'source_sha256': metadata['extension_sha256'], 'public_core_sha256': core['extension_sha256'],
              'source_statistics': statistics, 'all_steps_within': within,
              'primary_c_passed': all(all(fields.values()) for fields in within.values()),
              'strict_sources': [compare(originals[0], run) for run in sources],
              'original_runs': 8, 'source_runs': 3, 'new_original_runs': 0,
              'input_npz_paths': {tag: str(path) for tag, path in paths.items()},
              'input_npz_sha256': {tag: hashlib.sha256(path.read_bytes()).hexdigest() for tag, path in paths.items()},
              'old_failure_replaced': False, 'cohorts_resampled': False, 'whole_solver_complete': False}
    (output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
status['complete'] = True
(output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
print('Current Core55 G1 fixed-original C8', report['primary_c_passed'], within, flush=True)
raise SystemExit(int(not report['primary_c_passed']))
