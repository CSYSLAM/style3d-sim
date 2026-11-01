"""Adapt the established real eager/graph worker to the six fixed bonded-body cases and hashed candidate."""
import argparse
import ast
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
build = json.loads((BASE / 'candidate-static-cache/build.json').read_text())
for name, sha in build['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == sha, name
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
    plan = json.loads(Path(PLAN_PATH).read_text())
    for case in plan['cases']:
        yield case['label'], case['worlds'], False, case['extra']
'''.replace('PLAN_PATH', repr(str(BASE / 'plan.json')))
replacements = {
    'from .affine_particle_spring_ab import cases': cases.rstrip(),
    '    from .affine_particle_spring_scene import Example':
        '    from .granular_affine_bonds_scene import Example as BaseExample\n'
        '    class Example(BaseExample):\n'
        '        def __init__(self, viewer, config):\n'
        '            super().__init__(viewer, config)\n'
        '            self.pipeline = self.contacts = None',
    "ROOT/'reconstruction/csrc/affine_particle_spring_scene.py'":
        "ROOT/'reconstruction/csrc/granular_affine_bonds_scene.py'",
    "ROOT/'reconstruction/csrc/affine_particle_spring_ab.py'": 'Path(' + repr(str(Path(__file__))) + ')',
}
for before, after in replacements.items():
    assert text.count(before) == 1, before
    text = text.replace(before, after)
ast.parse(text)
script = args.output / (args.backend + '-graph-as-run.py')
assert not script.exists()
script.write_text(text)
namespace = {'__name__': '__main__', '__package__': 'reconstruction.csrc', '__file__': str(script)}
sys.argv = [str(script), '--worker', args.backend, '--frames', '60', '--output', str(args.output)]
exec(compile(text, str(script), 'exec'), namespace)
