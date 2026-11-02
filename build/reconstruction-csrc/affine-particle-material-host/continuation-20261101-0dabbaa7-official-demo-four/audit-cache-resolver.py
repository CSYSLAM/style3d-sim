"""Verify actual Newton ANYmal cache resolution before and after TTL expiry without repository network operations."""
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
assert os.environ.get('CUDA_VISIBLE_DEVICES') == ''
image = ROOT / 'build/reconstruction-csrc/source-core/5037032b98b9d614/_core.cpython-312-x86_64-linux-gnu.so'
assert hashlib.sha256(image.read_bytes()).hexdigest() == (
    '7151054e4597e6ea919c0caee576579e577aca233ea4de4dc8ad7aa20fa4b4e7')
spec = importlib.util.spec_from_file_location('style3d_sim._core', image)
module = importlib.util.module_from_spec(spec)
sys.modules[spec.name] = module
spec.loader.exec_module(module)
assert module.source_only
import git
import newton.utils
import newton._src.utils.download_assets as resolver
import warp as wp

execute = git.Git.execute
observed = []


def local_only(self, command, *args, **keywords):
    words = command.split() if isinstance(command, str) else command
    assert not set(words).intersection({'clone', 'ls-remote', 'fetch', 'pull', 'push'}), command
    observed.append(list(words))
    return execute(self, command, *args, **keywords)


git.Git.execute = local_only
manifest_path = ROOT / 'reconstruction/assets/anybotics_anymal_d/manifest.json'
manifest = json.loads(manifest_path.read_text())
assert resolver.NEWTON_ASSETS_REF == manifest['asset_reference']
cache = BASE / 'asset-cache'
parent = cache / manifest['cache_directory']
expected = parent / manifest['asset_name']
rows = []
for expired in (False, True):
    stamp = time.time() - (7200 if expired else 0)
    os.utime(parent, (stamp, stamp))
    selected = newton.utils.download_asset('anybotics_anymal_d', cache_dir=str(cache))
    assert selected.resolve() == expected.resolve()
    for name, spec in manifest['files'].items():
        raw = (selected / name).read_bytes()
        assert len(raw) == spec['bytes'] and hashlib.sha256(raw).hexdigest() == spec['sha256']
    rows.append({'TTL_expired': expired, 'selected_asset': str(selected), 'all_20_files_verified': True})
assert not wp.get_cuda_devices()
reference = ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
assert str(reference.resolve()) not in Path('/proc/self/maps').read_text()
paths = [Path(__file__), image, manifest_path, Path(resolver.__file__)]
result = {'rows': rows, 'observed_local_Git_commands': observed, 'repository_network_commands_guarded': True,
          'actual_Newton_download_asset_used': True, 'reference_SDK_mapped': False, 'CUDA_devices_visible': 0,
          'solver_constructed_or_stepped': False, 'GPU_numerics_validated': False,
          'input_sha256': {str(path.resolve()): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths}}
output = BASE / 'cache-resolver-independent-cpu.json'
assert not output.exists()
output.write_text(json.dumps(result, indent=2) + '\n')
print('Actual Newton ANYmal resolver: fresh/expired cache both exact;network Git operations blocked;no CUDA', flush=True)
