"""Exercise actual snapshot-verifier entry points with isolated indexed/legacy inventories and corruption controls."""
from contextlib import redirect_stdout
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import sys
import tempfile

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'snapshot-index-CPU-checks.json'
assert not OUTPUT.exists()
path = ROOT / 'scripts/verify_reconstruction_snapshot.py'
spec = importlib.util.spec_from_file_location('snapshot_index_under_test', path)
verify = importlib.util.module_from_spec(spec)
spec.loader.exec_module(verify)


def entry(data):
    return {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}


cases = [('indexed-valid', 0), ('legacy-valid', 0), ('member-missing', 1), ('member-corrupt', 1),
         ('manifest-hash-mismatch', 1), ('manifest-count-mismatch', 1), ('manifest-not-primary-frozen', 1),
         ('duplicate-shadow-path', 1), ('unsafe-member-path', 1), ('reference-only-independent-of-evidence', 0)]
rows = []
original_root, original_argv = verify.ROOT, sys.argv
try:
    for case, expected in cases:
        with tempfile.TemporaryDirectory(prefix='snapshot-index-CPU-') as temporary:
            root = Path(temporary)
            primary = {}

            def write(name, data):
                target = root / name
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_bytes(data)
                primary[name] = entry(data)

            write('seed.bin', b'primary fixture')
            write('style3d-sim-bin/fixture.pyc', b'fixture bytecode is never imported')
            write('build/third_party/glm-1.0.1/glm/glm.hpp', b'fixture dependency')
            write('build/toolchains/cuda_nvcc-linux-x86_64-12.4.131-archive.tar.xz', b'fixture compiler inventory')
            for folder, extension in [('host-particles', '_source_solver'), ('native', '_source_cuda')]:
                name = f'build/reconstruction-csrc/{folder}/{extension}.cpython-312-x86_64-linux-gnu.so'
                data = b'\x7fELFfixture header; never loaded'
                write(name, data)
                metadata = {'sources': {}, 'extension_sha256': entry(data)['sha256']}
                write(f'build/reconstruction-csrc/{folder}/build.json', json.dumps(metadata).encode())
            member, manifest = 'phase/payload.bin', 'phase/completion-manifest.json'
            payload = b'indexed actual fixture bytes'
            (root / 'phase').mkdir()
            (root / member).write_bytes(payload)
            files = {member: entry(payload)}
            if case == 'duplicate-shadow-path':
                files['seed.bin'] = primary['seed.bin']
            if case == 'unsafe-member-path':
                files = {'../escape.bin': entry(payload)}
            raw = (json.dumps({'files': files}) + '\n').encode()
            write(manifest, raw)
            descriptor = {'path': manifest, **entry(raw), 'file_count': len(files)}
            snapshot = {'files': primary, 'evidence_file_manifests': [descriptor]}
            if case == 'legacy-valid':
                primary[member] = entry(payload)
                del snapshot['evidence_file_manifests']
            elif case == 'member-missing':
                (root / member).unlink()
            elif case == 'member-corrupt':
                (root / member).write_bytes(b'changed member')
            elif case == 'manifest-hash-mismatch':
                descriptor['sha256'] = '0' * 64
            elif case == 'manifest-count-mismatch':
                descriptor['file_count'] += 1
            elif case == 'manifest-not-primary-frozen':
                del primary[manifest]
            elif case == 'reference-only-independent-of-evidence':
                (root / manifest).unlink()
                (root / member).unlink()
            (root / 'RECONSTRUCTION_SNAPSHOT.json').write_text(json.dumps(snapshot))
            verify.ROOT = root
            sys.argv = ['verify'] + (['--reference-only'] if case.startswith('reference-only') else [])
            output = io.StringIO()
            with redirect_stdout(output):
                code = verify.main()
            assert code == expected, (case, code, output.getvalue())
            rows.append({'case': case, 'actual_exit': code, 'expected_exit': expected, 'output': output.getvalue()})
finally:
    verify.ROOT, sys.argv = original_root, original_argv
OUTPUT.write_text(json.dumps({'cases': rows, 'all10_actual_entry_point_checks_passed': True,
    'verifier_sha256': hashlib.sha256(path.read_bytes()).hexdigest(), 'fixture_images_loaded': False,
    'GPU_used': False, 'real_snapshot_replaced': False, 'solver_equivalence_claimed': False}, indent=2) + '\n')
print('Snapshot verifier10 actual entry-point controls passed; corruption/shadow/traversal rejected; legacy preserved')
