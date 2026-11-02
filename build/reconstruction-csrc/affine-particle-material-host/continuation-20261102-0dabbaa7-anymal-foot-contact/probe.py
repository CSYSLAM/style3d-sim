"""Inspect actual foot geometry and collision contacts at frozen final states without advancing either native solver."""
import hashlib
import importlib.util
import json
from pathlib import Path
import sys
import subprocess

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
backend, variant, directory = sys.argv[1:]
OUTPUT = Path(directory)
OUTPUT.mkdir(exist_ok=False)
free = int(subprocess.check_output(
    ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
assert free >= 4096
apps = subprocess.check_output(
    ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
if backend == 'original':
    from reconstruction.csrc.host_api_probe import load_reference
    core = load_reference()
else:
    image = ROOT / 'build/reconstruction-csrc/source-core/5037032b98b9d614/_core.cpython-312-x86_64-linux-gnu.so'
    expected = '7151054e4597e6ea919c0caee576579e577aca233ea4de4dc8ad7aa20fa4b4e7'
    assert hashlib.sha256(image.read_bytes()).hexdigest() == expected
    spec = importlib.util.spec_from_file_location('style3d_sim._core', image)
    core = importlib.util.module_from_spec(spec)
    sys.modules['style3d_sim._core'] = core
    spec.loader.exec_module(core)
    assert core.source_only
import warp as wp
import newton.examples
from reconstruction.demo_ab import _parser_for

example = (ROOT / 'examples/example_robot_anymal_d.py' if variant == 'original'
           else BASE.parent / 'continuation-20261102-0dabbaa7-anymal-graph-eager/example_robot_anymal_d_synced.py')
spec = importlib.util.spec_from_file_location('diagnostic_anymal', example)
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


def eager_capture(instance):
    instance.graph = None


module.Example.capture = eager_capture
sys.argv = [str(example), '--viewer', 'null', '--num-frames', '1']
viewer, args = newton.examples.init(_parser_for(module, str(example)))
instance = module.Example(viewer, args)

import newton
PREVIOUS = BASE.parent / 'continuation-20261102-0dabbaa7-anymal-graph-eager'
path = PREVIOUS / 'synced-tests' / (backend + '.npz')
arrays = {}
model = instance.model
fields = ['shape_body', 'shape_type', 'shape_transform', 'shape_scale', 'shape_flags', 'shape_margin',
          'shape_gap', 'shape_material_ke', 'shape_material_kd', 'shape_material_mu', 'body_com']
for field in fields:
    value = getattr(model, field)
    arrays[field] = value.numpy().copy()
with np.load(path, allow_pickle=False) as frozen:
    for field in frozen.files:
        value = frozen[field].copy()
        getattr(instance.state_0, field).assign(value)
        arrays[field] = value
instance.collision_pipeline.collide(instance.state_0, instance.contacts)
contacts = instance.contacts
count = int(contacts.rigid_contact_count.numpy()[0])
arrays['rigid_contact_count'] = np.asarray([count], dtype='i4')
for field in ('rigid_contact_shape0', 'rigid_contact_shape1', 'rigid_contact_point0', 'rigid_contact_point1',
              'rigid_contact_normal', 'rigid_contact_margin0', 'rigid_contact_margin1',
              'rigid_contact_offset0', 'rigid_contact_offset1'):
    value = getattr(contacts, field, None)
    if value is not None:
        arrays[field] = value.numpy()[:count].copy()
feet = [i for i, label in enumerate(model.body_label) if 'FOOT' in label.upper()]
shapes = []
for index, body in enumerate(arrays['shape_body']):
    if int(body) not in feet and body != -1:
        continue
    source = model.shape_source[index]
    item = {'index': index, 'body': int(body), 'source_class': type(source).__name__}
    if hasattr(source, 'vertices'):
        arrays['shape-' + str(index) + '-vertices'] = np.asarray(source.vertices, dtype='f4')
    shapes.append(item)
output = OUTPUT / 'raw.npz'
np.savez_compressed(output, **arrays)
reference = ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
mapped = str(reference.resolve()) in Path('/proc/self/maps').read_text()
assert mapped == (backend == 'original')
report = {'backend': backend, 'native_image_sha256': hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest(),
          'reference_mapped': mapped, 'body_labels': list(model.body_label), 'shape_labels': list(model.shape_label),
          'foot_bodies': feet, 'selected_shapes': shapes, 'contact_count': count,
          'GeoType': {name: int(value) for name, value in newton.GeoType.__members__.items()},
          'ShapeFlags': {name: int(value) for name, value in vars(newton.ShapeFlags).items() if isinstance(value, int)},
          'free_memory_MiB_before_launch': free, 'compute_apps': apps,
          'raw_sha256': hashlib.sha256(output.read_bytes()).hexdigest(),
          'frozen_final_state_sha256': hashlib.sha256(path.read_bytes()).hexdigest(),
          'solver_steps_run': 0, 'real_Newton_collision_pipeline_run': True,
          'production_or_frozen_states_changed': False}
(OUTPUT / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
print('Actual foot geometry', backend, 'feet', len(feet), 'selected shapes', len(shapes), 'contacts', count)
