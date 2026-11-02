"""Independently compare all real initial buffers and recompute complete inertial CSR refresh outputs on CPU."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
OUTPUT = BASE / 'initial-cache-independent-cpu.json'
assert not OUTPUT.exists()
path = BASE / 'capture/full-input-replays/plan.json'
plan = json.loads(path.read_text())
hashes = {str(path): hashlib.sha256(path.read_bytes()).hexdigest()}
archives, comparisons, recomputed = {}, [], []
tiny = np.finfo('f4').tiny


def ftz(value):
    return np.copysign(np.float32(0), value) if 0 < abs(value) < tiny else value


def data(packet, phase, field):
    path = packet['input']
    if path not in archives:
        archives[path] = np.load(path, allow_pickle=False)
    return archives[path][packet['stage']['key'] + '/' + phase + '/arg-' + str(field)]


try:
    for ordinal in range(7):
        a, b = plan['packets'][ordinal], plan['packets'][2608 + ordinal]
        assert a['stage']['kind'] == b['stage']['kind']
        assert a['stage']['node']['owned_launch'] == b['stage']['node']['owned_launch'] == ordinal
        for phase in ('before', 'after'):
            for binding in a['stage']['bindings']:
                field = binding['argument']
                x, y = data(a, phase, field), data(b, phase, field)
                assert x.tobytes() == y.tobytes(), (ordinal, phase, field)
                comparisons.append({'owned_launch': ordinal, 'kind': a['stage']['kind'], 'phase': phase,
                                    'field': field, 'bytes': len(x), 'original_source_equal': True})
    for worker in (0, 1):
        packet = plan['packets'][worker * 2608]
        for value_field, offset_field, id_field, out_field, sign in [(0, 1, 2, 6, 1), (3, 4, 5, 7, -1)]:
            values = data(packet, 'before', value_field).view('<f4')
            offsets = data(packet, 'before', offset_field).view('<u8')
            ids = data(packet, 'before', id_field).view('<i4')
            assert len(offsets) == 1293 and offsets[0] == 0 and offsets[-1] == len(ids) == 102
            assert np.all(offsets[1:] >= offsets[:-1]) and np.all((ids >= 0) & (ids < len(values)))
            expected = data(packet, 'before', out_field).copy().view('<u4').reshape(1292, 2)
            floats = expected.view('<f4')
            for row in range(1292):
                lo, hi = int(offsets[row]), int(offsets[row + 1])
                if lo == hi:
                    continue
                total = np.float32(0)
                for i in ids[lo:hi]:
                    total = ftz(np.float32(ftz(total) + sign * ftz(values[i])))
                floats[row, 1] = total
            actual = data(packet, 'after', out_field)
            assert expected.tobytes() == actual.tobytes()
            recomputed.append({'worker': worker, 'field': out_field, 'kind': packet['stage']['kind'],
                               'complete_output_bytes': actual.nbytes, 'CPU_F32_FTZ_equal': True})
        packet = plan['packets'][worker * 2608 + 1]
        values = data(packet, 'before', 0).view('<f4')
        offsets = data(packet, 'before', 1).view('<u8')
        ids = data(packet, 'before', 2).view('<i4')
        assert len(offsets) == 69 and offsets[0] == 0 and offsets[-1] == len(ids) == 51
        assert np.all(offsets[1:] >= offsets[:-1]) and np.all((ids >= 0) & (ids < len(values)))
        expected = {i: data(packet, 'before', i).copy().view('<f4') for i in (3, 4)}
        for row in range(68):
            lo, hi = int(offsets[row]), int(offsets[row + 1])
            if lo == hi:
                continue
            total = np.float32(0)
            for i in ids[lo:hi]:
                total = ftz(np.float32(ftz(total) + ftz(values[i])))
            expected[3][row], expected[4][row] = ftz(np.float32(total * np.float32(3))), total
        for field in (3, 4):
            actual = data(packet, 'after', field)
            assert expected[field].tobytes() == actual.tobytes()
            recomputed.append({'worker': worker, 'field': field, 'kind': packet['stage']['kind'],
                               'complete_output_bytes': actual.nbytes, 'CPU_F32_FTZ_equal': True})
finally:
    for path, archive in archives.items():
        archive.close()
        hashes[path] = hashlib.sha256(Path(path).read_bytes()).hexdigest()
OUTPUT.write_text(json.dumps({'cross_backend_full_buffer_comparisons': comparisons,
    'cross_backend_comparison_count': len(comparisons), 'CPU_recomputed_outputs': recomputed,
    'all_actual_CSR_offsets_and_ids_in_bounds': True, 'input_sha256': hashes, 'GPU_used_for_this_audit': False,
    'all_other_host_combinations_verified': False, 'whole_solver_complete': False}, indent=2) + '\n')
print('Initial actual buffers cross-backend equal:', len(comparisons), ';8 complete CSR outputs recomputed exactly')
