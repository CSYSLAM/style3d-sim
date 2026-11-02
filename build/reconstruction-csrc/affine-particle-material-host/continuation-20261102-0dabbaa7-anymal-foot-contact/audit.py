"""Audit actual foot sphere geometry and independently reconstructed world-space contact gaps on CPU."""
from collections import Counter
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'independent-cpu.json'
assert not OUTPUT.exists()
hashes, rows, constants, topology = {}, [], {}, {}


def pin(path):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()


def transform(pose, point):
    xyz, q = pose[:3].astype('f8'), pose[3:].astype('f8')
    value = point.astype('f8')
    return xyz + value + 2.0 * np.cross(q[:3], np.cross(q[:3], value) + q[3] * value)


for backend in ('original', 'source'):
    directory = BASE / backend
    path = directory / 'report.json'
    report = json.loads(path.read_text())
    assert report['reference_mapped'] == (backend == 'original')
    expected = ('64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63' if backend == 'original'
                else '7151054e4597e6ea919c0caee576579e577aca233ea4de4dc8ad7aa20fa4b4e7')
    assert report['native_image_sha256'] == expected and report['free_memory_MiB_before_launch'] >= 4096
    assert report['solver_steps_run'] == 0 and report['real_Newton_collision_pipeline_run']
    pin(path)
    pin(directory / 'raw.npz')
    assert hashes[str((directory / 'raw.npz').resolve())] == report['raw_sha256']
    with np.load(directory / 'raw.npz', allow_pickle=False) as raw:
        constants[backend] = {key: raw[key].copy() for key in raw.files if key.startswith('shape_') or key == 'body_com'}
        count = int(raw['rigid_contact_count'][0])
        assert count == report['contact_count'] == 160
        feet = set(report['foot_bodies'])
        spheres = [i for i in range(len(raw['shape_body']))
                   if raw['shape_body'][i] in feet and raw['shape_type'][i] == report['GeoType']['SPHERE']
                   and int(raw['shape_flags'][i]) & report['ShapeFlags']['COLLIDE_SHAPES']]
        assert len(spheres) == len(feet) == 32
        foot_rows = []
        for shape in spheres:
            body = int(raw['shape_body'][shape])
            center = transform(raw['body_q'][body], raw['shape_transform'][shape][:3])
            radius = float(raw['shape_scale'][shape, 0])
            bottom = float(center[2] - radius)
            assert bottom < 0 and float(raw['shape_margin'][shape]) == 0
            matches = [i for i in range(count) if shape in (raw['rigid_contact_shape0'][i],
                                                           raw['rigid_contact_shape1'][i])]
            assert len(matches) == 1
            index = matches[0]
            assert raw['rigid_contact_shape1'][index] == shape
            plane = int(raw['rigid_contact_shape0'][index])
            assert raw['shape_body'][plane] == -1 and raw['shape_type'][plane] == report['GeoType']['PLANE']
            normal = raw['rigid_contact_normal'][index].astype('f8')
            assert np.array_equal(normal, [0., 0., 1.])
            point0 = raw['rigid_contact_point0'][index].astype('f8')
            point1 = transform(raw['body_q'][body], raw['rigid_contact_point1'][index])
            margin = float(raw['rigid_contact_margin0'][index] + raw['rigid_contact_margin1'][index])
            gap = float(np.dot(point1 - point0, normal) - margin)
            assert gap < 0
            foot_rows.append({'shape': shape, 'body': body, 'label': report['body_labels'][body],
                              'body_origin_z': float(raw['body_q'][body, 2]), 'sphere_center_z': float(center[2]),
                              'sphere_radius': radius, 'sphere_bottom_z': bottom, 'contact_gap': gap,
                              'gap_minus_geometric_bottom': gap - bottom,
                              'shape_stiffness': float(raw['shape_material_ke'][shape]),
                              'ground_stiffness': float(raw['shape_material_ke'][plane])})
        topology[backend] = Counter(zip(raw['rigid_contact_shape0'].tolist(), raw['rigid_contact_shape1'].tolist()))
    rows.append({'backend': backend, 'feet': foot_rows, 'all32_sphere_surfaces_and_contact_gaps_below_ground': True,
                 'sphere_bottom_min': min(row['sphere_bottom_z'] for row in foot_rows),
                 'sphere_bottom_max': max(row['sphere_bottom_z'] for row in foot_rows)})
assert set(constants['original']) == set(constants['source'])
for key in constants['original']:
    assert constants['original'][key].dtype == constants['source'][key].dtype
    assert constants['original'][key].tobytes() == constants['source'][key].tobytes(), key
assert topology['original'] == topology['source']
for path in (Path(__file__), BASE / 'probe.py'):
    pin(path)
for path, digest in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest
result = {'rows': rows, 'all_static_shape_parameters_and_body_COM_bitwise_equal': True,
          'all160_contact_shape_pair_multisets_equal': True, 'contact_values_across_different_states_claimed_equal': False,
          'input_sha256': hashes, 'GPU_used_for_audit': False, 'native_contact_force_cause_verified': False,
          'production_or_tolerances_changed': False, 'old_failures_reclassified': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('CPU verified64 penetrated foot surfaces;both160 contact topologies and static parameters match')
for row in rows:
    print(row['backend'], row['sphere_bottom_min'], row['sphere_bottom_max'])
