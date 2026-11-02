"""Audit current image identities, real constructor bytes, frozen failures and normal public API evidence."""
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
hashes = {}


def read(path):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    return json.loads(path.read_text())


host = read(ROOT / 'build/reconstruction-csrc/host-particles/build.json')
candidate = read(BASE / 'candidate-guard-only/build.json')
core_path = BASE / 'candidate-public-core/build.json'
core = read(core_path)
assert host['extension_sha256'] == 'd09d4be940335764a1e1e7d2f4978366c47e96caf20a3b556d3ac6cfe79e5c68'
assert candidate['image_sha256'] == 'ae3a599746804de7218285712a29428138ffe78892d6e28953d77408ed8264e8'
assert core['source_host_sha256'] == candidate['image_sha256']
assert core['extension_sha256'] == '5688f23b64d3de2fa01242e31777191820b069e4bdf935675e540d5a1b980417'
for path, expected in [(Path(candidate['image']), candidate['image_sha256']),
                       (core_path.parent / '_core.cpython-312-x86_64-linux-gnu.so', core['extension_sha256'])]:
    assert hashlib.sha256(path.read_bytes()).hexdigest() == expected
for name, expected in candidate['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
for name, expected in core['sources'].items():
    assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == expected, name
native = (ROOT / 'reconstruction/csrc/native/source_solver.cpp').read_bytes()
cpp = (BASE / 'candidate-guard-only/source_solver.cpp').read_bytes()
old = b'(!so3 || config.enable_self_collision || contact.max_count || contact.soft_max_count))'
new = b'(!so3 || config.enable_self_collision))'
assert native.count(old) == cpp.count(new) == 1 and cpp.replace(new, old, 1) == native
assert (ROOT / core['compiled_solver_source']).read_bytes() == cpp
assert core['kernel_count'] == host['kernel_count'] == 176 and core['cuda_source_digest'] == host['cuda_source_digest']
assert core['compiler_include_trace_verified']
assert str(ROOT / core['compiled_solver_source']) in (core_path.parent / 'build.log').read_text()
for name, count in [('candidate-captures', 6), ('constructors-guard-only', 16), ('fixed-C8', 4),
                    ('graph-fixed-C8', 3), ('sdk-heldout3', 3), ('source-initcheck', 4), ('public-beef-fixed-C8', 3)]:
    status = read(BASE / name / 'status.json')
    assert status['complete'] and status['running'] is None and len(status['completed']) == count
    assert all(row['actual_exit'] == 0 for row in status['completed'])
    assert all(row['free_memory_MiB'] >= 4096 for row in status['GPU_admission'])
capture = read(BASE / 'candidate-captures/report.json')
assert len(capture['cases']) == 6 and sum(row['strict_passed'] for row in capture['cases']) == 4
assert all(row['metadata']['equal'] and row['complete_owned_coverage'] for row in capture['cases'])
legacy = BASE.parent / 'continuation-20261101-0dabbaa7-granular-affine-contacts'
models = []
for row in capture['cases']:
    label = row['case']
    for filename in ('model-before.npz', 'actual-layout.npz'):
        left = legacy / 'discovery-v2' / label / 'original' / filename
        right = BASE / 'candidate-captures' / label / filename
        hashes[str(left)] = hashlib.sha256(left.read_bytes()).hexdigest()
        hashes[str(right)] = hashlib.sha256(right.read_bytes()).hexdigest()
        with np.load(left, allow_pickle=False) as a, np.load(right, allow_pickle=False) as b:
            assert set(a.files) == set(b.files)
            assert all(a[key].shape == b[key].shape and a[key].dtype == b[key].dtype
                       and a[key].tobytes() == b[key].tobytes() for key in a.files)
        models.append({'case': label, 'file': filename, 'all_bytes_equal': True})
ctors = read(BASE / 'constructors-guard-only/report.json')
assert len(ctors['cases']) == 4 and all(all(row['checks'].values()) for row in ctors['cases'])
copies = read(BASE / 'constructors-guard-only/frozen-original-copies.json')
assert len(copies) == 584
for name, entry in copies.items():
    raw = Path(name).read_bytes()
    assert len(raw) == entry['bytes'] and hashlib.sha256(raw).hexdigest() == entry['sha256']
short = read(BASE / 'fixed-C8-cpu-audit.json')
assert len(short['cases']) == 2 and all(row['all3_sources_within_C8'] for row in short['cases'])
long = read(BASE / 'graph-fixed-C8-cpu-audit.json')
assert long['fixed_source0_passed_groups'] == 9 and long['all3_passed_groups'] == 8 and long['total_groups'] == 12
assert not long['all_acceptance_passed'] and not long['first_samples_replaced']
sdk = read(BASE / 'sdk-heldout3-independent-cpu.json')
assert sdk['all_statistics_reproduced'] and sdk['control_passed_counts'] == [10, 9, 9]
assert not sdk['source_failures_rejudged'] and not sdk['controls_added_to_original_cohort']
literal = read(BASE / 'literal-native-states.json')
assert literal['all_pairs_checked'] == 396 and literal['source_trajectories_with_an_entire_native_match'] == 24
assert not literal['fixed_C8_changed'] and not literal['source_failures_rejudged']
proof = next(row for row in literal['rows'] if row['source'] == 0 and
             row['label'] == 'w3-b1-n2-s1-mixed-pd-b0-both-hit0-g0')
assert proof['first_failed_frames'][0]['frame'] == 1
assert proof['first_failed_frames'][0]['complete_prefix_same_single_native_run'] == ['control2']
sanitizer = read(BASE / 'source-initcheck/status.json')
assert all(row['error_summary_zero'] for row in sanitizer['completed'])
beef = read(BASE / 'public-beef-independent-cpu.json')
assert beef['three_normal_public_Core_exits_zero'] and beef['source_C8_passed'] == [True, True, True]
assert beef['unchanged_original_end_test_verified'] and not beef['default_or_long_cut_validated']
result = {'production_host_sha256': host['extension_sha256'], 'candidate_host_sha256': candidate['image_sha256'],
          'candidate_core_sha256': core['extension_sha256'], 'one_guard_delta_only': True,
          'constructor_classes_five_checks_passed': 4, 'frozen_SDK_constructor_files_reused': 584,
          'current_initial_model_and_layout_files_equal': models, 'short_cases_complete_strict': 4,
          'short_cases_total': 6, 'short_failed2_fixed_C8_all_three_within': True,
          'long_fixed_C8_first_source_passed_groups': 9, 'long_fixed_C8_all_three_passed_groups': 8,
          'long_fixed_C8_total_groups': 12, 'long_fixed_failures_rejudged': False,
          'SDK_heldout_passed_groups': [10, 9, 9], 'heldout_controls_extend_reference_cohort': False,
          'failed_PD_first_two_frames_equal_single_actual_SDK_control': True,
          'full60_native_trajectory_matches': 24, 'source_trajectories_total': 36,
          'candidate_source_initcheck_zero_error_classes': 4,
          'normal_public_beef3_fixed_C8_all_three_within': True,
          'normal_public_beef3_no_bridge_no_SDK_original_end_tests_passed': True,
          'normal_public_beef_default_or_long_cut_validated': False,
          'source_guard_candidate_promoted': False, 'production_changed': False,
          'input_sha256': hashes, 'GPU_runs': 0, 'whole_solver_complete': False}
output = BASE / 'close-independent-cpu.json'
assert not output.exists()
output.write_text(json.dumps(result, indent=2) + '\n')
print('Independent close: four constructors, shortC8 and normal public beef3 passed; long8/12 retained; not promoted')
