"""Distinguish actual supported SDK execution from an unimplemented source branch using full recorded data."""
from collections import Counter
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import schemas, normalize

plan = json.loads((BASE / 'plan.json').read_text())
for name, digest in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
status = json.loads((BASE / 'run.status.json').read_text())
assert status['complete'] and status['running'] is None
assert [r['label'] for r in status['completed']] == [r['label'] for r in plan['runs']]
schema, _ = schemas()
rows, initial_base, hashes = [], None, {}
for run, terminal in zip(plan['runs'], status['completed'], strict=True):
    folder = BASE / run['label']
    runtime = json.loads((folder / 'capture.runtime.json').read_text())
    expected = ('64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63' if run['backend'] == 'original'
                else '38b70dcd9f3ca5053184eca9c6ec64cc33c137248a3e70efa729bd7ff0d92a49')
    assert runtime['image_sha256'] == expected
    assert runtime['extra'] == run['extra'] and runtime['frames'] == plan['frames'] == 3
    with np.load(folder / 'model-before.npz', allow_pickle=False) as saved:
        before = {k: saved[k].copy() for k in saved.files}
    assert before['particle_q'].shape == (8, 3) and before['body_q'].shape == (1, 7)
    assert np.array_equal(before['granular_indices'], np.arange(8))
    assert all(np.isfinite(a).all() for a in before.values())
    if initial_base is None:
        initial_base = before
    assert before.keys() == initial_base.keys() and all(before[k].tobytes() == initial_base[k].tobytes() for k in before)
    row = {'label': run['label'], 'actual_exit': terminal['actual_exit'], 'SDK_supported': False,
           'source_unimplemented_guard_observed': False}
    if terminal['actual_exit'] == 0:
        assert run['backend'] == 'original', 'Unchanged source unexpectedly accepted the branch; inspect actual path'
        with np.load(folder / 'capture.npz', allow_pickle=False) as saved:
            states = {k: saved[k].copy() for k in saved.files}
        assert all(np.isfinite(a).all() for a in states.values())
        assert states['particle_q'].shape == (3, 8, 3) and states['body_q'].shape == (3, 1, 7)
        assert states['particle_q'][0].tobytes() != before['particle_q'].tobytes()
        assert states['body_q'][0].tobytes() != before['body_q'].tobytes()
        launches = (folder / 'launches.txt').read_text().splitlines()
        counts = Counter()
        for index, line in enumerate(launches):
            assert int(line.split()[0]) == index
            normalize(line, schema)
            assert line.split()[-1].startswith('launch:') and line.split()[-2].startswith('symbol:')
            counts[line.split()[1]] += 1
        so3 = [k for k in counts if 'affine_body_so3' in k]
        granular = [k for k in counts if '15granular_kernel' in k]
        assert so3 and granular
        for token, sizes in plan['fields'].items():
            for i, size in sizes.items():
                for prefix in ('pre', 'post'):
                    path = folder / ('dump_' + token + '_' + prefix + '_arg' + i + '.bin')
                    assert len(path.read_bytes()) == size
                    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        indices = np.fromfile(folder / 'dump_32initialize_affine_body_so3_state_pre_arg1.bin', dtype='<i4')
        assert indices.tolist() == [8, 9, 10, 11]
        grains = np.fromfile(folder / 'dump_15granular_kernel10build_grid_post_arg7.bin', dtype='<i4')
        worlds = np.fromfile(folder / 'dump_15granular_kernel10build_grid_post_arg8.bin', dtype='<i4')
        assert grains.tolist() == list(range(8)) and not worlds.any()
        token = '15granular_kernel19accumulate_contacts'
        first, last = [np.fromfile(folder / ('dump_' + token + '_' + prefix + '_arg1.bin'), dtype='<u4').reshape(12, 3)
                       for prefix in ('pre', 'post')]
        assert first[:8].tobytes() != last[:8].tobytes() and first[8:].tobytes() == last[8:].tobytes()
        row.update(SDK_supported=True, initial_bodies_and_granular_states_bitwise_equal_across_cases=True,
                   native_body_proxy_indices=indices.tolist(), native_granular_indices=grains.tolist(),
                   granular_force_changes_only_granular_rows=True, all_three_states_finite=True,
                   owned_launches=len(launches), kernel_counts=dict(counts))
    else:
        log = (folder / 'run.log').read_text()
        row['exception_tail'] = log.splitlines()[-5:]
        if run['backend'] == 'source':
            assert 'Granular combined with other materials or bodies has not been captured' in log
            row['source_unimplemented_guard_observed'] = True
    rows.append(row)
supported = [r for r in rows if r['SDK_supported']]
guarded = [r for r in rows if r['source_unimplemented_guard_observed']]
output = BASE / 'independent-cpu-audit.json'
assert not output.exists()
output.write_text(json.dumps({'rows': rows, 'SDK_supported_count': len(supported), 'source_guard_count': len(guarded),
                              'input_sha256': hashes, 'source_branch_restored': False,
                              'actual_support_not_inferred_from_static_guard': True,
                              'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
print(json.dumps({'SDK_supported_count': len(supported), 'source_guard_count': len(guarded)}, indent=2))
