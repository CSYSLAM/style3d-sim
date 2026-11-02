"""Pack the actual 198 body-block operators and reuse the validated alias/view replay engine with fixed counts."""
import hashlib
import inspect
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc import pd_contact_full_replay as engine
from reconstruction.csrc.hook_parameter_bytes import decode
from reconstruction.csrc.audit_cudahook import schemas, SCALAR_WORDS

OUTPUT = BASE / 'full-input-replays'
OUTPUT.mkdir(exist_ok=False)
capture = json.loads((BASE / 'plan.json').read_text())
status = json.loads((BASE / 'captures/status.json').read_text())
assert status['complete'] and all(row['actual_exit'] == 0 for row in status['completed'])
hashes = dict(capture['input_sha256'])
packets, names = [], set()
schema = schemas()[0]
writes = {'build_affine_body_preconditioner': ['17', '18'],
          'apply_block_diagonal_preconditioner': ['2'], 'apply_affine_body_preconditioner': ['4']}
for worker, side in enumerate(('original', 'source')):
    directory = BASE / 'captures' / side
    raw = (directory / 'launches.txt').read_bytes()
    hashes[str((directory / 'launches.txt').resolve())] = hashlib.sha256(raw).hexdigest()
    counters, arrays = {key: 0 for key in writes}, {}
    for line in raw.decode().splitlines():
        node = decode(line)
        key = node['key']
        if key not in writes:
            continue
        index = counters[key]
        counters[key] += 1
        stage_key = f'{node["owned_launch"]:04d}-{key}-{index:03d}'
        bindings = []
        output_labels = []
        for field, size in capture['fields'][key].items():
            argument, *extra = field.split('+')
            argument, offset = int(argument), int(extra[0]) if extra else 0
            encoded = bytes.fromhex(node['parameter_hex'][argument])
            address = int.from_bytes(encoded[offset:offset + 8], 'little')
            assert address
            label = 'arg-' + field
            suffix = '_offset' + str(offset) if offset else ''
            for at, phase in (('pre', 'before'), ('post', 'after')):
                path = directory / f'dump_{key}_call{index:03d}_{at}_arg{argument}{suffix}.bin'
                data = path.read_bytes()
                assert len(data) == size
                hashes[str(path.resolve())] = hashlib.sha256(data).hexdigest()
                arrays[stage_key + '/' + phase + '/' + label] = np.frombuffer(data, dtype='u1').copy()
            bindings.append({'label': label, 'argument': argument, 'offset': offset, 'address': address, 'bytes': size})
            if field in writes[key]:
                output_labels.append(label)
        actual_flat = {i for i, kind in enumerate(schema[node['name']]) if kind == 'pointer'
                       and int.from_bytes(bytes.fromhex(node['parameter_hex'][i]), 'little')}
        captured_flat = {b['argument'] for b in bindings if schema[node['name']][b['argument']] == 'pointer'}
        assert actual_flat == captured_flat
        if key == 'build_affine_body_preconditioner':
            view = bytes.fromhex(node['parameter_hex'][11])
            actual_view = {offset for offset in range(0, 160, 8) if offset not in SCALAR_WORDS['C']
                           and int.from_bytes(view[offset:offset + 8], 'little')}
            assert actual_view == {b['offset'] for b in bindings if b['argument'] == 11} == {0, 8, 16}
        stage = {'key': stage_key, 'kind': key, 'node': node, 'bindings': bindings, 'outputs': output_labels,
                 'all_flat_nonnull_inputs_and_nonnull_CableView_inputs_captured': True}
        frame = index // (3 if key == 'build_affine_body_preconditioner' else 15)
        packets.append({'worker': worker, 'frame': frame, 'stage': stage, 'input': str(OUTPUT / f'worker-{worker}.npz')})
        names.add(node['name'])
    assert counters == {'build_affine_body_preconditioner': 9, 'apply_block_diagonal_preconditioner': 45,
                        'apply_affine_body_preconditioner': 45}
    path = OUTPUT / f'worker-{worker}.npz'
    np.savez_compressed(path, **arrays)
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
assert len(packets) == 198 and len(names) == 3
previous = BASE.parent / 'continuation-20261101-0dabbaa7-driven-cloth-self/candidate-force-order/build.json'
candidate = json.loads(previous.read_text())
hashes[str(previous.resolve())] = hashlib.sha256(previous.read_bytes()).hexdigest()
hashes[candidate['image']] = candidate['image_sha256']
function = inspect.getsource(engine.execute)
assert function.count('2112') == 3 and function.count('6336') == 2
function = function.replace('2112', '198').replace('6336', '594').replace('Full contact/tangent', 'Body-block')
header = ('import ctypes as ct\nimport importlib.util\nimport json\nfrom pathlib import Path\nimport sys\n'
          'import numpy as np\n__package__ = "reconstruction.csrc"\n'
          'from reconstruction.csrc.pd_contact_full_replay import ROOT,sha,verify\n\n')
rendered = header + function + '\nraise SystemExit(execute(Path(sys.argv[1]).resolve()))\n'
runtime = BASE / 'replay-engine-as-run.py'
assert not runtime.exists()
runtime.write_text(rendered)
old_audit = BASE.parent / 'continuation-20261101-4f638b4b-pd-tangent-full/audit-replays.py'
audit = old_audit.read_text().replace('6336', '594').replace('2112', '198')
audit = audit.replace("output = BASE / 'full-input-replays'", "output = BASE / 'full-input-replays'\n"
                      "assert not (BASE / 'replay-independent-cpu-audit.json').exists()")
auditor = BASE / 'audit-replays.py'
assert not auditor.exists()
auditor.write_text(audit)
for path in (Path(__file__), Path(engine.__file__), old_audit, runtime, auditor,
             BASE / 'plan.json', BASE / 'captures/status.json'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
engine.verify(hashes)
plan = {'packets': packets, 'kernel_names': sorted(names), 'input_sha256': hashes,
        'candidate_image': candidate['image'], 'candidate_sha256': candidate['image_sha256'],
        'backends': ['SDK-runtime', 'original-ptx', 'source-ptx'], 'expected_unmodified_calls': 594,
        'original_fixed_samples_replaced': False, 'production_changed': False, 'whole_solver_complete': False}
(OUTPUT / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
(BASE / 'engine-origin.json').write_text(json.dumps({'source_engine': str(Path(engine.__file__)),
    'source_engine_sha256': hashes[str(Path(engine.__file__).resolve())],
    'derived_engine': str(runtime), 'derived_engine_sha256': hashes[str(runtime.resolve())],
    'allowed_changes': '198 packets/594 calls and log labels only;pointer alias/view replay arithmetic unchanged',
    'auditor_origin': str(old_audit), 'auditor_sha256': hashes[str(old_audit.resolve())],
    'derived_auditor': str(auditor), 'derived_auditor_sha256': hashes[str(auditor.resolve())]}, indent=2) + '\n')
print('Prepared198 actual body-block packets;594 three-backend calls;unchanged alias/view engine', flush=True)
