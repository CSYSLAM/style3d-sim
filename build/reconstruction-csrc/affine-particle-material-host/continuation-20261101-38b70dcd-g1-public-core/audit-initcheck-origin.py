"""Classify the observed host-copy reports using exact array labels, prefix control and preserved Newton code."""
import hashlib
import json
from pathlib import Path
import re
import shutil

root = Path.cwd()
base = Path(__file__).resolve().parent
rows = []
for side, folder in (('original', 'numpy-origin-original-labeled'), ('source', 'numpy-origin-source')):
    reads = [json.loads(line) for line in (base / folder / '420-byte-reads.jsonl').read_text().splitlines()]
    selected = [row for row in reads if row.get('model_field') == 'bvh_shape_enabled']
    assert len(selected) == 1
    row = selected[0]
    assert row['active_count'] == 54 and row['shape'] == [105] and row['bytes'] == 420
    assert 'uint32' in row['dtype'] and len(set(row['active_prefix_values'])) == 54
    assert all(0 <= value < 105 for value in row['active_prefix_values'])
    log = (base / 'initcheck60' / (side + '.log')).read_text()
    sources = re.findall(r'Host API memory access error at host access to (0x[0-9a-f]+) of size (\d+) bytes', log)
    assert len(sources) == 8 and all(pointer == row['pointer'] and size == '420' for pointer, size in sources)
    assert 'ERROR SUMMARY: 8 errors' in log and 'Uninitialized __global__' not in log
    rows.append({'side': side, 'pointer': row['pointer'], 'field': row['model_field'], 'active_count': 54,
                 'capacity': 105, 'unused_tail_entries': 51, 'observed_host_copy_reports': 8,
                 'device_kernel_uninitialized_reports_in_this_log': 0,
                 'log_sha256': hashlib.sha256(log.encode()).hexdigest()})
control_log = (base / 'numpy-origin-prefix-control/run.log').read_text()
begin = control_log.index('INITIALIZED_PREFIX_COPY_BEGIN 54')
end = control_log.index('INITIALIZED_PREFIX_COPY_END', begin)
assert 'Uninitialized' not in control_log[begin:end] and 'memory access error' not in control_log[begin:end]
assert control_log.index('Host API memory access error', end) > end
control_rows = [json.loads(line) for line in
                (base / 'numpy-origin-prefix-control/420-byte-reads.jsonl').read_text().splitlines()]
control = next(row for row in control_rows if row.get('model_field') == 'bvh_shape_enabled')
assert control['prefix_control_bytes'] == 216 and control['prefix_equals_full_scan_active_bytes']
names = ('newton/tests/unittest_utils.py', 'newton/_src/sim/model.py',
         'newton/_src/geometry/bvh.py', 'newton/examples/__init__.py')
sources = {}
for name in names:
    source = root / '.venv/lib/python3.12/site-packages' / name
    target = base / 'newton-harness-as-run' / name
    target.parent.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(source, target)
    sources[name] = hashlib.sha256(source.read_bytes()).hexdigest()
model = (base / 'newton-harness-as-run/newton/_src/sim/model.py').read_text()
geometry = (base / 'newton-harness-as-run/newton/_src/geometry/bvh.py').read_text()
examples = (base / 'newton-harness-as-run/newton/examples/__init__.py').read_text()
assert 'self.bvh_shape_enabled = wp.empty(shape_count, dtype=wp.uint32' in model
assert 'out_shape_enabled[index] = wp.uint32(tid)' in geometry
assert examples.index('viewer.close()') < examples.index('nan_members = find_nan_members(example.model)')
result = {'reports': rows, 'array_field_exactly_identified_on_both_backends': True,
          'prefix_control_bytes': 216, 'prefix_control_no_reports_between_markers': True,
          'prefix_control_before_full_invalid_copy': True, 'unused_capacity_read_by_post_run_model_nan_scanner': True,
          'original_full_error_reports_suppressed': False, 'initcheck_still_reports_8_per_backend': True,
          'can_explain_prior_frozen_G1_physics_divergence': False, 'production_changed': False,
          'GPU_used_by_this_audit': False, 'dependency_source_sha256': sources,
          'whole_solver_complete': False, 'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(base / 'initcheck-origin-audit.json').write_text(json.dumps(result, indent=2) + '\n')
print('Both reports identify the post-run unused BVH index capacity; initialized prefix control is clean')
