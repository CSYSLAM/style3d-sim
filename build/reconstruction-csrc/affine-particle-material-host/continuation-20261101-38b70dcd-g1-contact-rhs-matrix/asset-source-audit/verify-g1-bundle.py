"""Verify a fresh offline restore and the real installed Newton cache resolver, including expired TTL."""
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import time

root, base = Path.cwd(), Path(__file__).resolve().parent
manifest = json.loads((root / 'reconstruction/assets/unitree_g1/manifest.json').read_text())
plan = json.loads((base.parent / 'plan.json').read_text())
loader = root / '.venv/lib/python3.12/site-packages/newton/_src/utils/download_assets.py'
(base / 'newton-download-assets-as-run.py').write_bytes(loader.read_bytes())
commands, forbidden = [], []


def audit(event, args):
    if event in ('socket.connect', 'socket.getaddrinfo'):
        forbidden.append(event)
        raise AssertionError('Network access attempted during offline asset resolution')
    if event == 'subprocess.Popen':
        command = args[1]
        commands.append(command)
        tokens = command if isinstance(command, (list, tuple)) else str(command).split()
        assert not any(word in ('clone', 'fetch', 'ls-remote', 'curl', 'wget') for word in tokens)


restores = []
with tempfile.TemporaryDirectory(prefix='style3d-g1-cache-check-') as temp:
    cache = Path(temp)
    for label in ('fresh', 'reuse'):
        command = [sys.executable, str(root / 'scripts/restore_reconstruction_g1_assets.py'),
                   '--cache-dir', str(cache), '--report', str(base / ('g1-restore-' + label + '.json'))]
        (base / ('g1-restore-' + label + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
        result = subprocess.run(command, text=True, capture_output=True)
        (base / ('g1-restore-' + label + '.log')).write_text(result.stdout + result.stderr)
        assert result.returncode == 0, result.stderr
        report = json.loads((base / ('g1-restore-' + label + '.json')).read_text())
        assert report['restored'] == (label == 'fresh') and report['all_asset_bytes_verified']
        restores.append(report)
    actual_asset = cache / manifest['cache_directory'] / 'unitree_g1'
    original_asset = Path('/home/oem/.cache/newton') / manifest['cache_directory'] / 'unitree_g1'
    total = 0
    for name, record in manifest['files'].items():
        old, new = original_asset / name, actual_asset / name
        old_bytes, new_bytes = old.read_bytes(), new.read_bytes()
        assert old_bytes == new_bytes and len(new_bytes) == record['bytes']
        assert hashlib.sha256(new_bytes).hexdigest() == record['sha256'] == plan['input_sha256'][str(old)]
        total += len(new_bytes)
    sys.addaudithook(audit)
    spec = importlib.util.spec_from_file_location('newton_assets_offline_as_run', loader)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    assert module.NEWTON_ASSETS_REF == manifest['asset_reference']
    assert module.NEWTON_ASSETS_URL == manifest['upstream_repository']
    fresh = module.download_asset('unitree_g1', cache_dir=str(cache))
    assert fresh == actual_asset
    expired = time.time() - 7200
    os.utime(actual_asset.parent, (expired, expired))
    stale = module.download_asset('unitree_g1', cache_dir=str(cache))
    assert stale == actual_asset
    process_text = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid', '--format=csv,noheader'], text=True)
    assert str(os.getpid()) not in process_text.split()
assert not forbidden
result = {'file_count': len(manifest['files']), 'bytes_independently_equal_to_fixed_cache': total,
          'fresh_restore_exit': 0, 'idempotent_restore_exit': 0,
          'real_Newton_resolver_fresh_cache': True, 'real_Newton_resolver_expired_cache': True,
          'network_attempts': forbidden, 'CPU_subprocesses_observed': commands,
          'Newton_loader_sha256': hashlib.sha256(loader.read_bytes()).hexdigest(),
          'manifest_sha256': hashlib.sha256((root / 'reconstruction/assets/unitree_g1/manifest.json').read_bytes()).hexdigest(),
          'GPU_compute_process_created': False, 'source_cache_bytes_changed': False,
          'whole_solver_complete': False, 'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(base / 'g1-bundle-independent-audit.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(result, indent=2), flush=True)
