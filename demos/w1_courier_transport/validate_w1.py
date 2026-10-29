"""Check dual-arm payload retention, release, settling and sampled bag containment."""

import json
from pathlib import Path
import sys

import numpy as np
from scipy.spatial.transform import Rotation
from scipy.signal import find_peaks

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'piper_package_transport'))
from validate import inside_surface
from geometry import six_volumes


def validate(folder):
    data = np.load(folder / 'trajectory.npz')
    p, b = data['particles'], data['bodies']
    # Native ABD proxy coordinates follow the physical cloth/tet particles in state.particle_q.
    physical = p[:, :int(data['group_ranges'][-1, 1])]
    film0, film1, jelly = [p[:, a:z] for a, z in data['group_ranges']]
    carton_pose = b[:, int(data['carton'])]
    carton = np.einsum('tij,pj->tpi', Rotation.from_quat(carton_pose[:, 3:]).as_matrix(), data['carton_points'])
    carton += carton_pose[:, None, :3]
    times = np.arange(len(p)) / 30
    held = (times >= 7) & (times <= 10)
    ratios = np.array([six_volumes(frame, data['tets']) / data['rest_volumes'] for frame in jelly])
    checks = dict(full_duration=len(p) == 451, finite=bool(np.isfinite(p).all() and np.isfinite(b).all()),
                  positive_tetrahedra=bool(ratios.min() > 0), table_clearance=bool(physical[:, :, 2].min() > .854))
    metrics = dict(min_tet_volume_ratio=float(ratios.min()), minimum_particle_z=float(physical[:, :, 2].min()))
    for name, payload, film in [('carton', carton, film0), ('soft_package', jelly, film1)]:
        center = payload.mean(1)
        inside = [inside_surface(payload[t], film[t], data['film_faces']).mean() for t in range(0, len(p), 30)]
        lift = float(center[held, 2].min() - center[0, 2])
        drop = float(center[300, 2] - center[360, 2])
        settling = float(np.linalg.norm(center[-30:] - center[-1], axis=1).max())
        checks[name+'_held_during_shake'] = lift > .10
        checks[name+'_released'] = drop > .10
        checks[name+'_settled'] = settling < .01
        checks[name+'_contained_sampled'] = bool(min(inside) >= .98)
        metrics[name] = dict(minimum_held_lift_m=lift, drop_within_two_seconds_m=drop,
                             last_second_displacement_m=settling, minimum_inside_fraction=float(min(inside)))
    for side, ids in enumerate(np.asarray(data['gripper_bodies']).reshape(2, 2)):
        x = b[held][:, ids, 0].mean(1)
        peaks = len(find_peaks(x, prominence=.015)[0])
        checks[f'hand_{side}_three_shakes'] = peaks == 3
        metrics[f'hand_{side}'] = dict(shake_peaks=peaks, x_span_m=float(np.ptp(x)))
    report = dict(passed=all(checks.values()), checks=checks, metrics=metrics,
                  scope='Sampled trajectory checks; not continuous collision certification.')
    (folder / 'validation.json').write_text(json.dumps(report, indent=2), encoding='utf8')
    print(json.dumps(report, indent=2))
    return report


if __name__ == '__main__':
    result = validate(Path(sys.argv[1]))
    raise SystemExit(0 if result['passed'] else 1)
