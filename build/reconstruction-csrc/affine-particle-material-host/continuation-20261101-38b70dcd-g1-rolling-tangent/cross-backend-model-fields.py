"""Reproduce the twelve constant model-field comparisons from the closed rolling-tangent packets."""
import hashlib
import json
from pathlib import Path

import numpy as np


BASE = Path(__file__).resolve().parent
FIELDS = {
    88: 'shape_body', 96: 'shape_type', 104: 'shape_transform', 112: 'shape_scale',
    120: 'ke', 128: 'kd', 136: 'rolling', 144: 'torsional',
    176: 'body_ids', 184: 'body_indices', 192: 'body_com', 200: 'inertia',
}


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    output = BASE / 'cross-backend-model-fields-reproduced.json'
    assert not output.exists(), 'Preserve closed evidence'
    inputs, contents = {}, {}
    for side in ('original', 'source'):
        packets = sorted((BASE / side / 'tangent-packets').glob('frame*.npz'))
        assert len(packets) == 60, (side, len(packets))
        contents[side] = {offset: [] for offset in FIELDS}
        for path in packets:
            inputs[str(path)] = digest(path)
            with np.load(path, allow_pickle=False) as packet:
                for offset in FIELDS:
                    contents[side][offset].append(packet[f'before-binding-{256 + offset // 8}'].tobytes())
    fields = {}
    for offset, name in FIELDS.items():
        backends = {}
        for side in ('original', 'source'):
            values = contents[side][offset]
            assert len({len(value) for value in values}) == 1
            hashes = sorted({hashlib.sha256(value).hexdigest() for value in values})
            backends[side] = {
                'unique_sha256': hashes, 'constant_over60': len(hashes) == 1, 'bytes': len(values[0]),
            }
        equal = (all(row['constant_over60'] for row in backends.values()) and
                 contents['original'][offset][0] == contents['source'][offset][0])
        fields[name] = {'view_offset': offset, 'backends': backends, 'both_constant_and_equal': equal}
    recorded = BASE / 'cross-backend-model-fields.json'
    expected = json.loads(recorded.read_text())
    assert fields == expected['fields'], 'Reproduction differs from the first recorded CPU comparison'
    assert all(row['both_constant_and_equal'] for row in fields.values())
    inputs[str(recorded)] = digest(recorded)
    report = {
        'fields': fields, 'all12_recorded_model_fields_constant_and_equal': True,
        'first_report_independently_reproduced': True, 'input_sha256': inputs,
        'runner_sha256': digest(Path(__file__)), 'constructor_caches_not_covered_by_this_check': True,
        'whole_solver_complete': False,
    }
    output.write_text(json.dumps(report, indent=2) + '\n')
    print('120 closed packets: all twelve constant model fields match; first report reproduced', flush=True)


if __name__ == '__main__':
    main()
