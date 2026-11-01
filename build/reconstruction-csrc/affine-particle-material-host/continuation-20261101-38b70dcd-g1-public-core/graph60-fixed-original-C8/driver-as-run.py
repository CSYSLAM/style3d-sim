"""Wait for the exact live regression process, then test three current real-graph sources against frozen SDK8."""
from contextlib import ExitStack
import ctypes as ct
import errno
import hashlib
import json
import os
from pathlib import Path
import select
import re
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
core_build = root / 'build/reconstruction-csrc/source-core/a318a3ce42f6a731/build.json'
core = json.loads(core_build.read_text())
build_path = root / 'build/reconstruction-csrc/host-particles/build.json'
saved = build_path.read_bytes()
metadata = json.loads(saved)
assert core['source_host_sha256'] == metadata['extension_sha256']
assert metadata['extension_sha256'] == '38b70dcd9f3ca5053184eca9c6ec64cc33c137248a3e70efa729bd7ff0d92a49'
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
}, indent=2) + '\n')
dependency = base.parent / 'continuation-20261101-eb661284-mixed-plain-contact/validation-38b70dcd/broad-validation/status.json'
pid = 2205398
try:
    if hasattr(os, 'pidfd_open'):
        descriptor = os.pidfd_open(pid)
    else:
        header = Path('/usr/include/x86_64-linux-gnu/asm/unistd_64.h')
        number = int(re.search(r'^#define __NR_pidfd_open (\d+)$', header.read_text(), re.M)[1])
        libc = ct.CDLL(None, use_errno=True)
        libc.syscall.restype = ct.c_long
        result = libc.syscall(ct.c_long(number), ct.c_int(pid), ct.c_uint(0))
        if result < 0:
            error = ct.get_errno()
            if error == errno.ESRCH:
                raise ProcessLookupError(error, os.strerror(error))
            raise OSError(error, os.strerror(error))
        descriptor = int(result)
except ProcessLookupError:
    descriptor = None
if descriptor is not None:
    command = Path(f'/proc/{pid}/cmdline').read_bytes().replace(b'\0', b' ').decode()
    assert 'run-broad-validation.py' in command and 'eb661284-mixed-plain-contact' in command
    (output / 'wait.json').write_text(json.dumps({'pid': pid, 'command': command, 'pidfd_used': True}, indent=2) + '\n')
    print('Waiting on exact live regression pidfd', pid, flush=True)
    select.select([descriptor], [], [])
    os.close(descriptor)
dependency_status = json.loads(dependency.read_text())
assert dependency_status['complete'] and dependency_status['running'] is None
assert dependency_status['source_sha256'] == metadata['extension_sha256']
assert dependency_status['completed'][-1] == {'name': 'regression-fixed-C10-cpu', 'exit': 0}
status = {'complete': False, 'running': None, 'completed': [], 'whole_solver_complete': False}
execute = ("import sys;from pathlib import Path;p=Path(sys.argv.pop(1));"
           "exec(compile(p.read_bytes(),str(p),'exec'),"
           "{'__name__':'__main__','__package__':'reconstruction.csrc','__file__':str(p)})")
for index in range(3):
    assert build_path.read_bytes() == saved
    for name, digest in locked.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
    for name, digest in metadata['sources'].items():
        assert hashlib.sha256((root / name).read_bytes()).hexdigest() == digest, name
    tag = 'source' + str(index)
    folder = output / tag
    command = [sys.executable, '-c', execute, str(runner), '--backend', 'source', '--core-build', str(core_build),
               '--example', 'examples/example_robot_g1.py', '--frames', '60', '--output', str(folder),
               '--', '--solver', 'synreal', '--world-count', '1']
    status['running'] = tag
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
    (output / (tag + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (output / (tag + '.log')).open('w') as log:
        code = subprocess.run(command, cwd=root, env=clean_env(), stdout=log, stderr=subprocess.STDOUT, timeout=1800).returncode
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
print('Current Core7eb G1 fixed-original C8', report['primary_c_passed'], within, flush=True)
raise SystemExit(int(not report['primary_c_passed']))
