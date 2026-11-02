"""Version the established 24-case eager/graph worker for the recovered coupled cable scope."""
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
original_path = ROOT / 'reconstruction/csrc/plain_body_constraint_graph_ab.py'
before = original_path.read_text()
text = before.split('\ndef main():')[0]
changes = [
    ('Plain body constraints: spring/point-line/distance, W1/W3, both modes and body blocks, real graphs.',
     'Coupled cable/body constraints:24 cases, unchanged arithmetic, eager and real CUDA graphs.'),
    ('import argparse\n', "import argparse\n__package__ = 'reconstruction.csrc'\nimport importlib.util\n"),
    ('import numpy as np\n', 'import numpy as np\nsys.path.insert(0, str(Path.cwd()))\n'),
    ('from .plain_body_constraint_scene import Example', 'from .cable_body_constraint_scene import Example'),
    ("ROOT / 'reconstruction/csrc/plain_body_constraint_scene.py'", "ROOT / 'reconstruction/csrc/cable_body_constraint_scene.py'"),
    ("assert counts.get(force, 0) > 0", "assert counts.get(force, 0) > 0 and counts.get('cable_evaluate', 0) > 0"),
]
for old, new in changes:
    assert text.count(old) == 1, old
    text = text.replace(old, new)
text += '''
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=60)
    parser.add_argument('--worker', choices=('original', 'source'), required=True)
    parser.add_argument('--candidate-build', type=Path, required=True)
    args = parser.parse_args()
    assert args.frames > 0 and args.output.is_dir()
    from reconstruction.csrc import host_particles_ab
    candidate_build = json.loads(args.candidate_build.read_text())
    image = Path(candidate_build['image'])
    assert hashlib.sha256(image.read_bytes()).hexdigest() == candidate_build['image_sha256']
    for path, expected in candidate_build['input_sha256'].items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path

    def candidate():
        spec = importlib.util.spec_from_file_location('_source_solver', image)
        core = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(core)
        assert core.source_only and not core.solver_api_ready
        return core

    if args.worker == 'source':
        host_particles_ab.native_source = candidate
    from reconstruction.csrc.host_api_probe import REFERENCE
    try:
        worker(args)
    finally:
        mapped = str(REFERENCE.resolve()) in Path('/proc/self/maps').read_text()
        (args.output / (args.worker + '-mapping.json')).write_text(json.dumps({
            'SDK_mapped': mapped, 'backend': args.worker, 'source_calculated_independently': args.worker == 'source',
            'whole_solver_complete': False}, indent=2) + '\\n')
        assert mapped == (args.worker == 'original')
'''
compile(text, 'graph-worker.py', 'exec')
assert max(map(len, text.splitlines())) <= 128
target = BASE / 'graph-worker.py'
assert not target.exists()
target.write_text(text)
(BASE / 'graph-worker-origin.json').write_text(json.dumps({
    'previous': str(original_path), 'previous_sha256': hashlib.sha256(before.encode()).hexdigest(),
    'new': str(target), 'new_sha256': hashlib.sha256(text.encode()).hexdigest(),
    'generator_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    'preplanned_frames': 60, 'cases': 24, 'seeds': [1, 3], 'production_modified': False,
    'whole_solver_complete': False}, indent=2) + '\n')
print('Prepared24-case60-step eager/graph worker; source uses independent isolated image')
