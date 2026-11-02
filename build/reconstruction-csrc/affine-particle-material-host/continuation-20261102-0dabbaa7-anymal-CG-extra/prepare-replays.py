"""Pack all50 complete first-NL extra chains, keeping raw flat/view bytes and unused52-call captures intact."""
from collections import Counter, defaultdict
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import compare, schemas
from reconstruction.csrc.hook_parameter_bytes import decode
from schema import KEYS, WRITES, fields, integer, validate_scalars, CONTACT, LIMIT, DIRECTION, MATRIX

PHASE = BASE / 'capture'
OUTPUT = PHASE / 'full-input-replays'
OUTPUT.mkdir(exist_ok=False)
plan = json.loads((PHASE / 'plan.json').read_text())
status = json.loads((PHASE / 'status.json').read_text())
assert status['complete'] and status['running'] is None
assert len(status['completed']) == 2 and all(row['actual_exit'] == 0 for row in status['completed'])
metadata = compare(PHASE / 'original/launches.txt', PHASE / 'source/launches.txt', schemas()[0])
assert metadata['equal'] and metadata['left_launches'] == metadata['right_launches'] == 2608
hashes, packets, names, bounds = dict(plan['input_sha256']), [], set(), []
all_counts = []
for worker, backend in enumerate(('original', 'source')):
    directory = PHASE / backend
    log = directory / 'launches.txt'
    hashes[str(log.resolve())] = hashlib.sha256(log.read_bytes()).hexdigest()
    nodes = [decode(line) for line in log.read_text().splitlines()]
    start = next(node['owned_launch'] for node in nodes if node['key'] == DIRECTION)
    end = next(node['owned_launch'] for node in nodes if node['key'] == '20apply_nonlinear_step')
    assert (start, end) == (25, 524)
    bounds.append({'backend': backend, 'first_direction': start, 'first_apply': end})
    occurrences, selected, archives = Counter(), Counter(), defaultdict(dict)
    for node in nodes:
        key = node['key']
        if key not in KEYS:
            continue
        ordinal = occurrences[key]
        occurrences[key] += 1
        if not start <= node['owned_launch'] < end:
            continue
        assert ordinal < plan['dump_limit_per_key']
        iteration = selected[key]
        selected[key] += 1
        assert ordinal == iteration + {CONTACT: 1, LIMIT: 2}.get(key, 0), (key, ordinal, iteration)
        validate_scalars(node)
        if key == DIRECTION:
            assert integer(node, 0, width=4) == iteration
        stage_key = f'{node["owned_launch"]:04d}-{key}-call{ordinal:03d}'
        target = OUTPUT / f'worker-{worker}-iterations-{iteration // 10}.npz'
        arrays = archives[target]
        bindings = []
        assert fields(node) == plan['fields'][key]
        for binding in fields(node):
            i, offset, size, label = [binding[k] for k in ('argument', 'offset', 'bytes', 'label')]
            pointer = integer(node, i, offset)
            for source_phase, target_phase in (('pre', 'before'), ('post', 'after')):
                suffix = '_offset' + str(offset) if offset else ''
                path = directory / f'dump_{key}_call{ordinal:03d}_{source_phase}_arg{i}{suffix}.bin'
                if not pointer:
                    assert not path.exists()
                    continue
                data = path.read_bytes()
                assert len(data) == size, (path, len(data), size)
                hashes[str(path.resolve())] = hashlib.sha256(data).hexdigest()
                arrays[stage_key + '/' + target_phase + '/' + label] = np.frombuffer(data, dtype='u1').copy()
            if pointer:
                bindings.append({**binding, 'address': pointer})
        writes = ['arg-' + str(i) for i in WRITES[key]]
        assert set(writes) <= {binding['label'] for binding in bindings}
        stage = {'key': stage_key, 'kind': key, 'node': node, 'bindings': bindings, 'outputs': writes,
                 'call_ordinal': ordinal, 'CG_iteration': iteration,
                 'all_nonnull_flat_and_view_pointer_inputs_captured': True}
        packets.append({'worker': worker, 'frame': 0, 'stage': stage, 'input': str(target)})
        names.add(node['name'])
    assert selected == Counter({key: 50 for key in KEYS}), selected
    all_counts.append(dict(selected))
    for path, arrays in archives.items():
        np.savez_compressed(path, **arrays)
        assert path.stat().st_size < 100 * 1024 * 1024, path
        with np.load(path, allow_pickle=False) as actual:
            assert set(actual.files) == set(arrays)
            assert all(actual[key].tobytes() == value.tobytes() for key, value in arrays.items())
        hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
assert len(packets) == 800 and all_counts[0] == all_counts[1]
origin = BASE.parent / 'continuation-20261102-0dabbaa7-anymal-first-CG/full50'
for name in ('replay-engine-as-run.py', 'audit-replays.py', 'run-replays.py'):
    source, target = origin / name, PHASE / name
    text = source.read_text().replace('430', '800').replace('1290', '2400').replace('ANYmal50 CG', 'ANYmal extra50 CG')
    assert not target.exists()
    target.write_text(text)
    for path in (source, target):
        hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
image = ROOT / 'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so'
source_hash = hashlib.sha256(image.read_bytes()).hexdigest()
assert source_hash == '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
hashes[str(image)] = source_hash
for path in (Path(__file__), PHASE / 'plan.json', PHASE / 'status.json'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
result = {'packets': packets, 'kernel_names': sorted(names), 'input_sha256': hashes,
          'candidate_image': str(image), 'candidate_sha256': source_hash,
          'backends': ['SDK-runtime', 'original-ptx', 'source-ptx'], 'expected_unmodified_calls': 2400,
          'counts_by_worker': all_counts, 'first_NL_owned_boundaries': bounds,
          'all50_first_NL_extra_chains_captured': True, 'other_NL_or_full_trajectory_claimed': False,
          'old_frozen_failures_reclassified': False, 'production_changed': False, 'whole_solver_complete': False}
(OUTPUT / 'plan.json').write_text(json.dumps(result, indent=2) + '\n')
print('Prepared800 complete first-NL extra-chain packets and2400 real calls;view pointers included')
