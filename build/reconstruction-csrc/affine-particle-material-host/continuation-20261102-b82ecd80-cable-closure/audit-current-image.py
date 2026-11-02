"""Audit current-image terminal evidence without promoting normal CLI execution to whole-solver equivalence."""
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
validation = BASE / 'validation-d09d4be9-v2'
hashes = {}


def read(path):
    raw = path.read_bytes()
    hashes[str(path)] = hashlib.sha256(raw).hexdigest()
    return json.loads(raw)


host_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
host = read(host_path)
before = read(BASE / 'production-build/before-build.json')
assert host['extension_sha256'] == 'd09d4be940335764a1e1e7d2f4978366c47e96caf20a3b556d3ac6cfe79e5c68'
assert host['kernel_count'] == 176 and host['kernels'] == before['kernels']
assert host['cuda_source_digest'] == before['cuda_source_digest']
cpp = ROOT / 'reconstruction/csrc/native/source_solver.cpp'
assert cpp.read_bytes() == (BASE / 'candidate-weight-order/source_solver.cpp').read_bytes()
for name, expected in host['sources'].items():
    assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == expected, name
parent = read(validation / 'status.json')
assert parent['complete'] and parent['running'] is None
assert all(row['actual_exit'] == (1 if row['name'] == 'regression74' else 0) for row in parent['completed'])
short = read(validation / 'short-report.json')
broader = read(validation / 'broader-report.json')
bonds = read(validation / 'bond-report.json')
assert len(short) == 4 and all(row['strict_passed'] for row in short)
assert len(bonds) == 6 and all(row['strict_passed'] for row in bonds)
assert len(broader) == 6 and all(row['states']['bitwise'] and row['metadata']['equal'] and
                               row['complete_owned_coverage'] for row in broader)
intermediate_non_strict = [{'case': row['case'], 'buffers': [key for key, value in row['buffers'].items() if not value]}
                           for row in broader if not all(row['buffers'].values())]
graphs = read(validation / 'graph-report.json')
assert len(graphs) == 24 and all(row['bitwise'] for row in graphs.values())
contracts = {}
for name, expected in (('granular_contract_ab', 103), ('fluid_contract_ab', 57), ('self_collision_contract_ab', 246)):
    report = read(validation / name / 'report.json')
    assert report['checks'] == expected and not report['differences']
    contracts[name] = expected
core_path = ROOT / 'build/reconstruction-csrc/source-core/9cb2fcaa1082d1df/build.json'
core = read(core_path)
assert core['source_host_sha256'] == host['extension_sha256'] and core['source_only'] and not core['solver_api_ready']
assert core['extension_sha256'] == '55d626f06c10c7f6cbc48663bf7fde25be1cfcd8edfb4ce8cf57f30fd300dab5'
assert hashlib.sha256((core_path.parent / '_core.cpython-312-x86_64-linux-gnu.so').read_bytes()).hexdigest() == \
    core['extension_sha256']
normal_status = read(BASE / 'normal-core-five60/status.json')
assert normal_status['complete'] and normal_status['running'] is None and len(normal_status['completed']) == 5
assert all(row['actual_exit'] == 0 for row in normal_status['completed'])
normal_reports = [validation / (name + '.json') for name in
                  ('core-dzhanibekov60', 'core-plastic-bag3', 'core-g1-graph60')]
normal_reports += [BASE / 'normal-core-five60' / (row['case'] + '.json') for row in normal_status['completed']]
for path in normal_reports:
    report = read(path)
    assert report['exit'] == 0 and report['source_only'] and report['public_core_abi']
    assert not report['reference_solver_mapped'] and report['source_sha256'] == core['extension_sha256']
regression = read(validation / 'regression74/status.json')
assert regression['complete'] and regression['running'] is None and len(regression['completed']) == 74
failures = [row['name'] for row in regression['completed'] if row['exit']]
assert failures == ['particles-seed1', 'particles-seed2', 'particles-seed3']
cohort = read(validation / 'regression-fixed-C10/report.json')
cpu = read(validation / 'regression-fixed-C10/cpu-audit.json')
assert not cpu['GPU_used'] and not cpu['source0_replaced'] and cpu['additional_originals_collected'] == 0
assert len(cohort['cases']) == len(cpu['cases']) == 3
for case, checked in zip(cohort['cases'], cpu['cases']):
    assert case['case'] == checked['case'] and case['original_runs'] == 10 and not case['source0_replaced']
    assert case['every_array_and_step_within'] and checked['saved_report_reproduced']
    assert checked['every_array_and_step_within'] and not checked['outside']
    source = validation / 'regression-fixed-C10' / case['case'] / 'source0.npz'
    assert hashlib.sha256(source.read_bytes()).hexdigest() == case['fixed_source_npz_sha256']
cables = read(BASE / 'production-cables-independent-cpu.json')
assert cables['strict_complete_state_pairs'] == 104 and cables['penalty_arrays_CPU_checked'] == 840
hashes[str(Path(__file__))] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
result = {'host_sha256': host['extension_sha256'], 'core_sha256': core['extension_sha256'],
          'kernel_specs_and_CUDA_digest_unchanged': True, 'short_strict_cases': 4, 'bonded_strict_cases': 6,
          'broader_state_and_ABI_strict_cases': 6, 'broader_intermediate_non_strict_retained': intermediate_non_strict,
          'bond_graph_strict_pairs': 24, 'contract_checks': contracts, 'normal_public_core_actual_exits0': 8,
          'regression74_strict': 71, 'regression74_retained_strict_failures': failures,
          'current_fixed_C10_all3_within': True, 'old_0dab_C10_failures_reclassified': False,
          'production_cable_cases_strict': 104, 'normal_CLI_proves_numerical_equivalence': False,
          'input_sha256': hashes, 'whole_solver_complete': False}
(BASE / 'current-image-independent-cpu.json').write_text(json.dumps(result, indent=2) + '\n')
print('CPU verified new host/Core current checks:104 cables;71/74 strict;3 fixed C10 within;8 normal API exits0')
