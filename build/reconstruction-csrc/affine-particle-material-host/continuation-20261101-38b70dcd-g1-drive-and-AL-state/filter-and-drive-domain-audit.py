"""Explain the observed soft-contact no-op and record the actual initialized revolute-drive domain."""
from collections import Counter
import hashlib
import json
from pathlib import Path
import re

import numpy as np

BASE = Path(__file__).resolve().parent
entry = (BASE / 'soft-original-entry.ptx').read_text()
pattern = (r'ld.param.u64 (?P<parameter>%rd\d+), \[[^\]]+_param_9\];\s*'
           r'cvta.to.global.u64 (?P<base>%rd\d+), (?P=parameter);\s*'
           r'add.s64 (?P<address>%rd\d+), (?P=base), (?P<offset>%rd\d+);\s*'
           r'ld.global.u32 (?P<kind>%r\d+), \[(?P=address)\];\s*'
           r'setp.ne.s32 (?P<predicate>%p\d+), (?P=kind), 0;\s*'
           r'@(?P=predicate) bra (?P<label>\$[\w_]+);')
matches = list(re.finditer(pattern, entry))
assert len(matches) == 1
guard = matches[0]
assert re.search(re.escape(guard['label']) + r':\s*ret;\s*}', entry)
shift = re.search(r'shl.b64 ' + re.escape(guard['offset']) + r', %rd\d+, 2;', entry)
assert shift
replay = json.loads((BASE / 'replay/report.json').read_text())
assert json.loads((BASE / 'replay.status.json').read_text())['complete']
by_side, inputs = {}, {}
for side in ('original', 'source'):
    soft = Counter()
    for path in sorted((BASE / side / 'soft-packets').glob('frame-*.npz')):
        inputs[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        with np.load(path, allow_pickle=False) as packet:
            count = int.from_bytes(packet['before-arg-0'].tobytes(), 'little', signed=True)
            assert 0 < count <= 18480
            particles = packet['before-arg-2'].view('<i4')[:count]
            assert ((particles >= 0) & (particles < 176)).all()
            kinds = packet['before-arg-9'].view('<i4')[particles % 176]
            mass = packet['before-arg-8'].view('<f4')[particles % 176]
            assert np.all(kinds != 0) and np.all(mass > 0)
            soft['prefix_records'] += count
            soft['nonzero_particle_kind'] += int(np.count_nonzero(kinds))
            for i in (36, 37):
                assert packet['after-arg-' + str(i)].tobytes() == packet['before-arg-' + str(i)].tobytes()
            soft['packets'] += 1
    types, flags, drive = Counter(), Counter(), Counter()
    for path in sorted((BASE / side / 'drive-packets').glob('frame-*.npz')):
        inputs[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        with np.load(path, allow_pickle=False) as packet:
            types.update(packet['before-arg-6'].view('<i4').tolist())
            flags.update(packet['before-arg-4'].view('<i4').tolist())
            for i in (16, 17):
                indices = packet['before-arg-' + str(i)].view('<i4')
                assert ((indices >= 0) & (indices < 49)).all()
            for i in (3, 4):
                assert packet['after-arg-' + str(i)].tobytes() == packet['before-arg-' + str(i)].tobytes()
            drive['packets'] += 1
    assert soft['packets'] == drive['packets'] == 60
    assert types == flags == Counter({1: 2580})
    by_side[side] = {'soft': dict(soft), 'drive_types': dict(types), 'drive_initialized': dict(flags)}
soft_rows = [row for row in replay['packets'] if row['stage'] == 'soft']
assert len(soft_rows) == 120
assert all(row['atomic_operands'] == {'original': 0, 'source': 0} for row in soft_rows)
assert all(check['all_outputs_equal'] for row in soft_rows for check in row['checks'])
report = {
    'backends': by_side, 'original_PTX_kind_nonzero_return_guard': guard.group(),
    'original_PTX_kind_offset_scale': shift.group(),
    'original_PTX_return_label': guard['label'], 'actual_soft_probe_atomic_count': 0,
    'active_soft_force_arithmetic_exercised': False, 'drive_first_initialization_exercised': False,
    'input_sha256': inputs, 'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    'whole_solver_complete': False,
}
output = BASE / 'filter-and-drive-domain-audit.json'
assert not output.exists()
output.write_text(json.dumps(report, indent=2) + '\n')
print('Soft no-op: all19008 candidates have nonzero particle kind; actual probes record zero atomics', flush=True)
print('All120 drive inputs are revolute and already initialized; first initialization is not covered', flush=True)
