"""Pack222 complete five-NL assembly/bookend inputs and verify exact selected-copy coverage on runtime and driver."""
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
from schema import fields, integer, validate, outputs, select

PHASE = BASE / 'capture'
OUTPUT = PHASE / 'full-input-replays'
OUTPUT.mkdir(exist_ok=False)
plan = json.loads((PHASE / 'plan.json').read_text())
status = json.loads((PHASE / 'status.json').read_text())
assert status['complete'] and status['running'] is None
assert len(status['completed']) == 2 and all(row['actual_exit'] == 0 for row in status['completed'])
schema = schemas()[0]
metadata = compare(PHASE / 'original/launches.txt', PHASE / 'source/launches.txt', schema)
assert metadata['equal'] and metadata['left_launches'] == metadata['right_launches'] == 2608
previous = BASE.parent / 'continuation-20261102-0dabbaa7-anymal-CG-extra/capture/original/launches.txt'
old_metadata = compare(previous, PHASE / 'original/launches.txt', schema)
assert old_metadata['equal'] and old_metadata['right_launches'] == 2608
hashes, packets, names, counts_by_worker, copy_coverage = dict(plan['input_sha256']), [], set(), [], []
for worker, backend in enumerate(('original', 'source')):
    directory = PHASE / backend
    log = directory / 'launches.txt'
    hashes[str(log.resolve())] = hashlib.sha256(log.read_bytes()).hexdigest()
    nodes = [decode(line) for line in log.read_text().splitlines()]
    selected = select(nodes)
    assert [row['node']['owned_launch'] for row in selected] == plan['selected_owned_ranks']
    archives, expected_files, counts = defaultdict(dict), set(), Counter()
    for row in selected:
        node, ordinal, nl = row['node'], row['call_ordinal'], row['NL_iteration']
        key = node['key']
        validate(node)
        assert ordinal < plan['dump_limit_per_key'] and fields(node) == plan['fields'][key]
        stage_key = f'{node["owned_launch"]:04d}-{key}-call{ordinal:03d}'
        target = OUTPUT / f'worker-{worker}-NL-{nl}.npz'
        arrays, bindings = archives[target], []
        for binding in fields(node):
            i, offset, size, label = [binding[k] for k in ('argument', 'offset', 'bytes', 'label')]
            pointer = integer(node, i, offset)
            for source_phase, target_phase in (('pre', 'before'), ('post', 'after')):
                suffix = '_offset' + str(offset) if offset else ''
                path = directory / f'dump_{key}_call{ordinal:03d}_{source_phase}_arg{i}{suffix}.bin'
                if not pointer:
                    assert not path.exists()
                    continue
                expected_files.add(path)
                data = path.read_bytes()
                assert len(data) == size, (path, len(data), size)
                hashes[str(path.resolve())] = hashlib.sha256(data).hexdigest()
                arrays[stage_key + '/' + target_phase + '/' + label] = np.frombuffer(data, dtype='u1').copy()
            if pointer:
                bindings.append({**binding, 'address': pointer})
        writes = outputs(node)
        assert set(writes) <= {binding['label'] for binding in bindings}
        stage = {'key': stage_key, 'kind': key, 'node': node, 'bindings': bindings, 'outputs': writes,
                 'call_ordinal': ordinal, 'NL_iteration': nl,
                 'all_nonnull_flat_and_view_pointer_inputs_captured': True}
        packets.append({'worker': worker, 'frame': 0, 'stage': stage, 'input': str(target)})
        names.add(node['name'])
        counts[key] += 1
    actual_files = set(directory.glob('dump_*.bin'))
    assert actual_files == expected_files, (backend, len(actual_files), len(expected_files))
    copy_coverage.append({'backend': backend, 'exact_expected_dump_files': len(expected_files),
                          'no_unselected_or_missing_raw_dumps': True})
    counts_by_worker.append(dict(counts))
    for path, arrays in archives.items():
        np.savez_compressed(path, **arrays)
        assert path.stat().st_size < 100 * 1024 * 1024, path
        with np.load(path, allow_pickle=False) as actual:
            assert set(actual.files) == set(arrays)
            assert all(actual[key].tobytes() == value.tobytes() for key, value in arrays.items())
        hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
assert len(packets) == 222 and counts_by_worker[0] == counts_by_worker[1]
origin = BASE.parent / 'continuation-20261102-0dabbaa7-anymal-CG-extra/capture'
for name in ('replay-engine-as-run.py', 'audit-replays.py', 'run-replays.py'):
    source, target = origin / name, PHASE / name
    text = source.read_text().replace('800', '222').replace('2400', '666').replace('ANYmal extra50 CG', 'ANYmal RHS5 NL')
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
          'backends': ['SDK-runtime', 'original-ptx', 'source-ptx'], 'expected_unmodified_calls': 666,
          'counts_by_worker': counts_by_worker, 'all2608_launches_have_unchanged_normalized_metadata': True,
          'selected_copy_coverage': copy_coverage, 'all_five_RHS_preconditioner_assemblies_captured': True,
          'all_intermediate_CG_iterations_captured': False, 'old_frozen_failures_reclassified': False,
          'production_changed': False, 'whole_solver_complete': False}
(OUTPUT / 'plan.json').write_text(json.dumps(result, indent=2) + '\n')
print('Prepared222 complete five-NL inputs and666 calls; selected-copy file coverage exact on runtime and driver')
