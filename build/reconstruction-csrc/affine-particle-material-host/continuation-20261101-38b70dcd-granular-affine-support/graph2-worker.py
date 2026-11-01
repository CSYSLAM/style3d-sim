"""Adapt the established real eager/graph worker to the fixed granular/affine fixture and isolated candidate."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--backend', choices=('original', 'source'), required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
build = json.loads((BASE / 'candidate2/build.json').read_text())
for name, digest in build['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
image = Path(build['image'])
assert hashlib.sha256(image.read_bytes()).hexdigest() == build['image_sha256']
if args.backend == 'source':
    from reconstruction.csrc import host_particles_ab

    def candidate():
        spec = importlib.util.spec_from_file_location('_source_solver', image)
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        assert module.source_only and not module.solver_api_ready
        return module

    host_particles_ab.native_source = candidate
parent = ROOT / 'reconstruction/csrc/affine_particle_spring_graph_ab.py'
text = parent.read_text()
cases = '''def cases():
    for mode in ('newton', 'pd'):
        for block in (False, True):
            extra = ['--mode', mode] + (['--body-block'] if block else [])
            yield mode + '-b' + str(int(block)), 1, False, extra
'''
replacements = {
    'from .affine_particle_spring_ab import cases': cases.rstrip(),
    '    from .affine_particle_spring_scene import Example':
        '    from .granular_affine_scene import Example as BaseExample\n'
        '    class Example(BaseExample):\n'
        '        def __init__(self, viewer, config):\n'
        '            super().__init__(viewer, config)\n'
        '            self.pipeline = self.contacts = None',
    "ROOT/'reconstruction/csrc/affine_particle_spring_scene.py'": "ROOT/'reconstruction/csrc/granular_affine_scene.py'",
    "ROOT/'reconstruction/csrc/affine_particle_spring_ab.py'": repr(str(Path(__file__))),
}
for old, new in replacements.items():
    assert text.count(old) == 1, old
    text = text.replace(old, new)
script = args.output / (args.backend + '-graph-as-run.py')
assert not script.exists()
script.write_text(text)
sys.argv = [str(script), '--worker', args.backend, '--frames', '60', '--output', str(args.output)]
namespace = {'__name__': '__main__', '__package__': 'reconstruction.csrc', '__file__': str(script)}
exec(compile(text, str(script), 'exec'), namespace)
