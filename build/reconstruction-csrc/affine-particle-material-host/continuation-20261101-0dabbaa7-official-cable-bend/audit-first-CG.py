"""Audit the exact first cable PCG input differences, producer links and two real-GPU atomic certificates on CPU."""
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import schemas, compare

PHASE = BASE / 'first-CG'
OUTPUT = PHASE / 'independent-cpu.json'
assert not OUTPUT.exists()
plan = json.loads((PHASE / 'plan.json').read_text())
certificates = json.loads((PHASE / 'GPU-certificates/report.json').read_text())
status = json.loads((PHASE / 'certificate-status.json').read_text())
assert status['complete'] and status['actual_exit'] == 0 and not status['GPU_waits'][-1]['compute_apps']
assert certificates['all_passed'] and certificates['real_lane_operands_equal']
assert certificates['particles'] == certificates['per_group'] == 192 and certificates['groups'] == 1
assert len(certificates['certificates']) == 2
hashes = {**plan['input_sha256'], **certificates['input_sha256']}


def read(path):
    raw = path.read_bytes()
    hashes[str(path.resolve())] = hashlib.sha256(raw).hexdigest()
    return raw


def numerical(left, right):
    a, b = [np.frombuffer(value, dtype='<f4') for value in (left, right)]
    assert np.isfinite(a).all() and np.isfinite(b).all()
    return {'bitwise_equal': left == right, 'different_words': int(np.count_nonzero(a.view('<u4') != b.view('<u4'))),
            'max_abs': float(np.abs(a.astype('f8') - b.astype('f8')).max())}


metadata = compare(PHASE / 'original/launches.txt', PHASE / 'source/launches.txt', schemas()[0])
assert metadata['equal'] and metadata['left_launches'] == metadata['right_launches'] == 470
loaded, workers = [], []
for side in ('original', 'source'):
    directory = PHASE / side
    data, files = {}, set()
    for key, fields in plan['fields'].items():
        for field, size in fields.items():
            for phase in ('pre', 'post'):
                path = directory / f'dump_{key}_{phase}_arg{field}.bin'
                value = read(path)
                assert len(value) == size
                data[(key, phase, field)] = value
                files.add(path.name)
    assert files == {p.name for p in directory.glob('dump_*.bin')}
    inverse, pre, direction, matrix, update, apply = ('27invert_block_preconditioner', '23precondition_and_reduce',
        '19update_cg_direction', '26multiply_matrix_and_reduce', '28update_solution_and_residual', '20apply_nonlinear_step')
    links = 0
    for left, lp, la, right, rp, ra in [
        (inverse, 'post', '3', pre, 'pre', '0'), (pre, 'post', '2', direction, 'pre', '1'),
        (pre, 'post', '6', direction, 'pre', '4'), (pre, 'post', '6', update, 'pre', '2'),
        (direction, 'post', '6', matrix, 'pre', '4'), (direction, 'post', '6', update, 'pre', '4'),
        (matrix, 'post', '6', update, 'pre', '5'), (matrix, 'post', '9', update, 'pre', '3')]:
        assert data[(left, lp, la)] == data[(right, rp, ra)], (side, left, right)
        links += 1
    path = directory / 'capture.npz'
    read(path)
    with np.load(path, allow_pickle=False) as public:
        assert public['particle_q'].shape == (10, 192, 3)
        assert data[(apply, 'post', '1')] == public['particle_q'][0].tobytes()
        frozen_path = BASE / 'synreal' / (side + '.npz')
        read(frozen_path)
        with np.load(frozen_path, allow_pickle=False) as frozen:
            reproduces_first = all(public[key][0].tobytes() == frozen[key][0].tobytes() for key in public.files)
            reproduces_ten = all(public[key].tobytes() == frozen[key][:10].tobytes() for key in public.files)
    workers.append({'side': side, 'snapshot_files': len(files), 'producer_consumer_links': links + 1,
                    'original_frozen_first_substep_reproduced': reproduces_first,
                    'original_frozen_ten_substeps_reproduced': reproduces_ten})
    loaded.append(data)
comparisons = {key + '/' + phase + '/' + field: numerical(loaded[0][(key, phase, field)],
                                                        loaded[1][(key, phase, field)])
               for key, phase, field in loaded[0]}
for field in ('0', '1', '2', '6'):
    assert loaded[0][(pre, 'pre', field)] == loaded[1][(pre, 'pre', field)]
assert loaded[0][(pre, 'post', '2')] == loaded[1][(pre, 'post', '2')]
assert loaded[0][(matrix, 'post', '6')] == loaded[1][(matrix, 'post', '6')]
assert loaded[0][(matrix, 'post', '9')] == loaded[1][(matrix, 'post', '9')]
with np.load(PHASE / 'GPU-certificates/certificates.npz', allow_pickle=False) as values:
    assert values['original-lane-operands'].tobytes() == values['source-lane-operands'].tobytes()
    operands = values['original-lane-operands']
    assert operands.dtype == np.dtype('<f4') and operands.shape == (192,) and np.isfinite(operands).all()
    tiny = np.finfo('f4').tiny

    def ftz(value):
        return np.copysign(np.float32(0), value) if 0 < abs(value) < tiny else value

    for row in certificates['certificates']:
        side = row['target_side']
        assert row['group'] == 0 and row['passed'] and row['hardware_atomic_order_verified']
        assert not row['actual_production_order_inferred']
        target = read(PHASE / side / 'dump_23precondition_and_reduce_post_arg6.bin')
        assert int.from_bytes(target, 'little') == row['target_bits']
        order = values[side + '-group0-order']
        actual_history = values[side + '-group0-hardware-history']
        assert np.array_equal(np.sort(order), np.arange(192, dtype='u4'))
        history, total = [], np.float32(0)
        for lane in order:
            history.append(total)
            total = ftz(np.float32(total + ftz(operands[lane])))
        assert np.asarray(history, dtype='<f4').tobytes() == actual_history.tobytes()
        assert int(total.view('<u4')) == row['target_bits']
for path in (Path(__file__), PHASE / 'GPU-certificates/certificates.npz', PHASE / 'GPU-certificates/report.json',
             PHASE / 'certificate-status.json', PHASE / 'certificate-inputs/rename-only-origin.json'):
    read(path)
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
replay = json.loads(read(PHASE / 'replay-independent-cpu-audit.json'))
assert replay['packets'] == 10 and replay['strict_packets'] == 8 and replay['counts']['actual_calls'] == 30
assert len(replay['failures']) == 5 and all(row['kind'] == pre and row['different_output_labels'] == ['arg-6']
                                          for row in replay['failures'])
result = {'workers': workers, 'comparisons': comparisons, 'actual_owned_launches_per_side': 470,
          'metadata_equal': True, 'complete_replay_packets': 10, 'complete_replay_calls': 30,
          'strict_replay_packets': 8, 'only_replay_differences_are_numerator_atomic_sum': True,
          'actual_original_source_lane_operands_equal': True, 'lane_operands': 192,
          'GPU_atomic_target_certificates': 2, 'GPU_history_words_checked': 384,
          'production_atomic_order_inferred': False, 'input_sha256': hashes, 'GPU_used': False,
          'old_frozen_failures_reclassified': False, 'production_changed': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('First cable CG independent CPU:192 actual operands equal;2 GPU targets/384 histories exact;'
      '30 calls only numerator differs;frozen failures retained', flush=True)
