"""Adopt complete first surface-scale inputs from the finished flow capture;rename files only for replay compatibility."""
import hashlib
import json
from pathlib import Path
import shutil

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
PARENT = BASE.parent
FLOW = PARENT / 'continuation-20261101-7ca67172-driven-self-flow'
SELF = PARENT / 'continuation-20261101-0dabbaa7-driven-cloth-self'
REPLAY = PARENT / 'continuation-20261101-7ca67172-driven-self-replay'
OUTPUT = BASE / 'packets'
OUTPUT.mkdir(exist_ok=False)
key = '35add_surface_contact_stiffness_scale'
hashes, audit_counts = {}, []


def read(path):
    data = path.read_bytes()
    hashes[str(path.resolve())] = hashlib.sha256(data).hexdigest()
    return data


for phase, filename in ((FLOW, 'linear-independent-cpu-v2.json'),
                        (REPLAY / 'complete-input-replays', 'independent-cpu.json'),
                        (SELF / 'surface-scalar-certificates-isolated', 'independent-cpu-audit.json')):
    audit = json.loads(read(phase / filename))
    for name, expected in audit['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    audit_counts.append({'audit': str(phase / filename), 'input_hashes_verified_now': len(audit['input_sha256'])})
plan = json.loads(read(FLOW / 'linear-flow-plan.json'))
rows = []
for number, job in enumerate(plan['jobs']):
    source = FLOW / 'linear-captures-v2' / str(number)
    selected = [stage for stage in job['stages'] if stage['key'] == key]
    assert len(selected) == 9
    stage = selected[0]
    line = read(source / 'launches.txt').decode().splitlines()[stage['owned_launch']]
    assert line.split()[1] == key
    folder = OUTPUT / str(number)
    folder.mkdir()
    (folder / 'launches.txt').write_text(line + '\n')
    fields, mapping = {}, {}
    for field, size in stage['fields'].items():
        if field == '1':
            continue
        offset = int(field.split('+')[1]) if '+' in field else 0
        fields[offset] = ['view-' + str(offset), size]
        suffix = '_offset' + str(offset) if offset else ''
        old = source / f'dump_{key}_call000_pre_arg0{suffix}.bin'
        new = folder / f'dump_30evaluate_surface_contact_force_pre_arg0{suffix}.bin'
        data = read(old)
        assert len(data) == size
        new.write_bytes(data)
        mapping[new.name] = {'source': str(old), 'sha256': hashlib.sha256(data).hexdigest()}
    for at in ('pre', 'post'):
        old = source / f'dump_{key}_call000_{at}_arg1.bin'
        new = folder / f'dump_{key}_{at}_arg1.bin'
        data = read(old)
        assert len(data) == 192
        new.write_bytes(data)
        mapping[new.name] = {'source': str(old), 'sha256': hashlib.sha256(data).hexdigest()}
    assert len(fields) == 25
    (folder / 'fields.json').write_text(json.dumps(fields, indent=2) + '\n')
    (folder / 'rename-only-map.json').write_text(json.dumps(mapping, indent=2) + '\n')
    rows.append({'worker': number, 'case': job['case']['name'], 'backend': job['backend'], 'capture': str(folder)})
candidate_path = SELF / 'candidate-force-order/build.json'
candidate = json.loads(read(candidate_path))
assert candidate['image_sha256'] == plan['candidate_image_sha256']
hashes.update(candidate['input_sha256'])
hashes[candidate['image']] = candidate['image_sha256']
for path in (Path(__file__), ROOT / 'reconstruction/csrc/surface_common_input_replay.py',
             ROOT / 'reconstruction/csrc/surface_atomic_operands.py'):
    read(path)
record = {'packets': rows, 'audit_input_hash_checks': audit_counts, 'input_sha256': hashes,
          'candidate_build': str(candidate_path), 'candidate_sha256': candidate['image_sha256'],
          'adapter_renames_bytes_without_changing_them': True, 'GPU_used_for_preparation': False,
          'old_fixed_samples_replaced': False, 'candidate_promoted': False, 'whole_solver_complete': False}
(BASE / 'plan.json').write_text(json.dumps(record, indent=2) + '\n')
print('Prepared four actual scale packets;all prior audit input hashes verified in current environment', flush=True)
