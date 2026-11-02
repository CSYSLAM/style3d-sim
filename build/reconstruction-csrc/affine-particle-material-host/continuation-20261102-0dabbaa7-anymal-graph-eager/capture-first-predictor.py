"""Observe the first real Python rigid predictor before either SDK/source native step;do not alter its arithmetic."""
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
backend, variant, directory = sys.argv[1:]
OUTPUT = Path(directory)
OUTPUT.mkdir(exist_ok=False)
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
           else BASE / 'example_robot_anymal_d_synced.py')
spec = importlib.util.spec_from_file_location('diagnostic_anymal', example)
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


def eager_capture(instance):
    instance.graph = None


module.Example.capture = eager_capture
sys.argv = [str(example), '--viewer', 'null', '--num-frames', '1']
viewer, args = newton.examples.init(_parser_for(module, str(example)))
instance = module.Example(viewer, args)
arrays = {}
original_launch = wp.launch


def observe(kernel, *values, **keywords):
    selected = getattr(kernel, 'key', '') == '_predict_affine_body_velocities' and not arrays
    if selected:
        inputs = keywords['inputs']
        for index, name in enumerate(('body_q', 'predicted_body_q', 'indices', 'body_ids', 'body_com', 'particle_q')):
            arrays[name] = inputs[index].numpy().copy()
        arrays['dt'] = np.asarray([inputs[6]], dtype='<f4')
    result = original_launch(kernel, *values, **keywords)
    if selected:
        arrays['actual_first_predictor_particle_qd'] = keywords['outputs'][0].numpy().copy()
    return result


wp.launch = observe
try:
    instance.step()
finally:
    wp.launch = original_launch
assert arrays
arrays['first_frame_body_q'] = instance.state_0.body_q.numpy().copy()
arrays['first_frame_body_qd'] = instance.state_0.body_qd.numpy().copy()
np.savez_compressed(OUTPUT / 'raw.npz', **arrays)
reference = ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
mapped = str(reference.resolve()) in Path('/proc/self/maps').read_text()
assert mapped == (backend == 'original')
body_ids, centers = arrays['body_ids'], arrays['indices'][:, 0]
report = {'backend': backend, 'variant': variant, 'reference_mapped': mapped,
          'native_image_sha256': hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest(),
          'example_sha256': hashlib.sha256(example.read_bytes()).hexdigest(),
          'maximum_first_predictor_center_velocity': float(np.abs(arrays['actual_first_predictor_particle_qd'][centers]).max()),
          'first_frame_maximum_body_velocity': float(np.abs(arrays['first_frame_body_qd']).max()),
          'raw_sha256': hashlib.sha256((OUTPUT / 'raw.npz').read_bytes()).hexdigest(),
          'first_predictor_observed_before_native_step': True, 'production_changed': False}
(OUTPUT / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
print(report)
