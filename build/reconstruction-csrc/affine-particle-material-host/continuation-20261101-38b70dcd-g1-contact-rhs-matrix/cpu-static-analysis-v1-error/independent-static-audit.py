"""Audit the actual contact PTX store origins and recorder stride while GPU execution is queued."""
import hashlib
import json
from pathlib import Path
import re
import sys

root = Path.cwd()
sys.path.insert(0, str(root))
from reconstruction.csrc.audit_cudahook import parameter_types
from reconstruction.csrc.ptx_compare import normalise
from reconstruction.csrc.ptx_store_origins import store_origins

base = Path(__file__).resolve().parent
plan = json.loads((base / 'plan.json').read_text())
for name, digest in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
records = {}
for key, name in plan['kernels'].items():
    fields = [(i, 0) for i, kind in enumerate(parameter_types(name)) if '*' in kind]
    expected = [[32, 0], [33, 0]] if key == 'force' else [[30, 0], [33, 0], [34, 0]]
    records[key] = {}
    for side in ('original', 'source'):
        path = base / (key + '-' + side + '-entry.ptx')
        text = path.read_text()
        record = store_origins(text, fields)
        assert record['potential_written_pointer_fields'] == expected
        assert record['parameter_count'] == (34 if key == 'force' else 35)
        forms = sorted(set(re.findall(r'\b(?:atom|red)\.[\w.]+', text)))
        assert forms == ['red.global.add.f32']
        count = len(record['store_instructions'])
        assert count == (96 if key == 'force' else 75)
        changed = (base / (key + '-' + side + '-instrumented-preflight.ptx')).read_text()
        assert changed.count('mul.wide.u32 %audit_lane_offset, %audit_lane, 4096;') == count
        assert not changed.count('mul.wide.u32 %audit_lane_offset, %audit_lane, 2048;')
        record.update(entry_sha256=hashlib.sha256(path.read_bytes()).hexdigest(), atomic_forms=forms,
                      recorder_stride_bytes=4096, allocated_records_per_thread=256,
                      normalized_entry_sha256=hashlib.sha256(normalise(text).encode()).hexdigest())
        records[key][side] = record
    records[key]['normalized_PTX_equal'] = (
        records[key]['original']['normalized_entry_sha256'] == records[key]['source']['normalized_entry_sha256'])
report = {'kernels': records, 'actual_PTX_global_store_origins_match': True,
          'indirect_global_store_addresses_found': False, 'noninlined_calls_found': False,
          'bounds_or_branch_reachability_proven': False, 'GPU_execution_done_by_this_audit': False,
          'production_changed': False, 'whole_solver_complete': False,
          'analysis_sha256': hashlib.sha256((root / 'reconstruction/csrc/ptx_store_origins.py').read_bytes()).hexdigest(),
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(base / 'independent-static-audit.json').write_text(json.dumps(report, indent=2) + '\n')
print('Both force and matrix original/source PTX store origins match; no hidden global output or unrecorded atomic form.')
print('Normalized PTX:', {key: record['normalized_PTX_equal'] for key, record in records.items()})
