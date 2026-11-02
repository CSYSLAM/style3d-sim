"""Connect all three trajectory first differences to the audited joint GPU certificates for their exact full inputs."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
audit_path = BASE / 'tangent-independent-cpu-audit.json'
reduction_audit_path = BASE / 'reduction-independent-cpu-audit.json'
audit = json.loads(audit_path.read_text())
reduction_audit = json.loads(reduction_audit_path.read_text())
plan = json.loads((BASE / 'reduction-differences/plan.json').read_text())
report_path = BASE / 'reduction-differences/report.json'
report = json.loads(report_path.read_text())
assert report['complete'] and reduction_audit['metrics']['cases'] == 131
hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest()
          for p in (Path(__file__), audit_path, reduction_audit_path, report_path)}
rows = []
for comparison in audit['comparisons']:
    worker, first = comparison['source_worker'], comparison['first_numeric_output_difference']
    frame, key = first['frame'], first['stage']
    assert frame == 0 and first['kind'] == 'CG-product' and first['before_differing_observed_labels'] == []
    folders = [BASE / f'tangent-captures/{i}/tangent-graph-{frame % 2}' for i in (0, worker)]
    layouts = [json.loads((path / 'snapshot-layout.json').read_text()) for path in folders]
    stages = [next(s for s in layout['stages'] if s['key'] == key) for layout in layouts]
    paths = [folder / f'frames/frame-{frame:02d}.npz' for folder in folders]
    for path in paths:
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    with np.load(paths[0], allow_pickle=False) as left, np.load(paths[1], allow_pickle=False) as right:
        payload = {b['label']: left[key + '/before/' + b['label']].tobytes() for b in stages[0]['bindings']}
        for label, value in payload.items():
            assert value == right[key + '/before/' + label].tobytes()
        assert len(payload) == 7 and not any(payload['arg-9'])
        point = left[key + '/after/arg-6'].tobytes()
        assert point == right[key + '/after/arg-6'].tobytes()
        targets = {name: data[key + '/after/arg-9'].tobytes() for name, data in (('SDK', left), ('source', right))}
    a, b = [np.frombuffer(value, dtype='<u4') for value in targets.values()]
    assert a[:2].tobytes() == b[:2].tobytes() and abs(int(a[2]) - int(b[2])) == 1
    for i, (a, b) in enumerate(zip(stages[0]['node']['parameter_hex'], stages[1]['node']['parameter_hex'])):
        if 'arg-' + str(i) not in payload:
            assert a == b
    selected = None
    for case, certified in zip(plan['cases'], report['cases']):
        packet = case['packet']
        if packet['frame'] != frame or packet['stage']['key'] != key:
            continue
        values = {np.asarray(c['target_bits'], dtype='<u4').tobytes() for c in certified['certificates']}
        if not all(value in values for value in targets.values()):
            continue
        with np.load(packet['input'], allow_pickle=False) as original:
            if any(original[key + '/before/' + label].tobytes() != value for label, value in payload.items()):
                continue
        selected = certified
        break
    assert selected is not None, ('No complete-input joint witness covers both first-difference vectors', worker)
    path = Path(selected['output'])
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    assert hashes[str(path)] == selected['output_sha256']
    links = {}
    with np.load(path, allow_pickle=False) as saved:
        assert saved['original-raw-operands'].tobytes() == saved['source-raw-operands'].tobytes()
        offset = selected['buffer_metadata']['6']['prefix']
        assert saved['original-probe-buffer-6'][offset:offset + 432].tobytes() == point
        assert saved['source-probe-buffer-6'][offset:offset + 432].tobytes() == point
        for name, target in targets.items():
            certificate = next(c for c in selected['certificates']
                               if saved[c['tag'] + '-total-buffer'][256:268].tobytes() == target)
            links[name] = {'certificate_tag': certificate['tag'], 'target_bits': list(np.frombuffer(target, dtype='<u4'))}
            links[name]['target_bits'] = [int(value) for value in links[name]['target_bits']]
    rows.append({'source_worker': worker, 'frame': frame, 'first_stage': key,
                 'all_seven_complete_before_spans_equal': True, 'complete_Ap_equal': True,
                 'difference_only_third_group_one_ULP': True, 'joint_witness_case': selected['case_index'],
                 'both_original_and_source_complete_scalar_vectors_covered': links})
assert len(rows) == 3
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
record = {'rows': rows, 'input_sha256': hashes, 'GPU_used_for_this_audit': False,
          'actual_global_schedule_inferred': False, 'old_fixed_source0_failure_reclassified': False,
          'whole_solver_complete': False}
(BASE / 'first-difference-bridge.json').write_text(json.dumps(record, indent=2) + '\n')
print('CPU:all three first trajectory differences linked to joint GPU witnesses for both complete scalar vectors')
