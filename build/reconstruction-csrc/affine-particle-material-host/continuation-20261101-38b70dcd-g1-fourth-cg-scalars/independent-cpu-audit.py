"""Audit shared checkpoint inputs, original end-test failures and numerical output without reclassifying old C8."""
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT = Path.cwd()
sys.path.insert(0, str(ROOT))
from reconstruction.demo_ab import spread_report

BASE = Path(__file__).resolve().parent
plan = json.loads((BASE / 'plan.json').read_text())
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
status = json.loads((BASE / 'run.status.json').read_text())
assert status['complete'] and status['running'] is None
assert [row['label'] for row in status['completed']] == [row['label'] for row in plan['runs']]
assert len(status['completed']) == 11
with np.load(plan['input_checkpoint'], allow_pickle=False) as data:
    initial = {field: data[field][30].copy() for field in ('body_q', 'body_qd', 'particle_q', 'particle_qd')}
    old_target = {field: data[field][31].copy() for field in initial}
inputs, configuration, control_baseline = {}, None, None
end_tests = []
with ExitStack() as stack:
    traces = {}
    for run, outcome in zip(plan['runs'], status['completed']):
        label, backend = run['label'], run['backend']
        folder = BASE / label
        runtime = json.loads((folder / 'worker/runtime.json').read_text())
        assert runtime['real_graph_observed'] and runtime['public_core_abi'] and not runtime['ab_bridge_used']
        assert runtime['reference_solver_mapped'] == (backend == 'original')
        expected_image = ('64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63' if backend == 'original'
                          else '7eb6e847ad6f100b51f2bc89db0a88744f93878077c318c91288d2f595116b53')
        assert runtime['image_sha256'] == expected_image and runtime['exit'] == outcome['actual_exit']
        assert all(value == 1 for value in runtime['recorded_frames'].values())
        injection = json.loads((folder / 'injection.json').read_text())
        assert injection['graph_counts_before'] == injection['graph_counts_after'] == [17467, 17466]
        assert injection['sim_substeps'] == 6 and not injection['demo_end_tests_modified']
        assert injection['native_drive_flags_reset_via_existing_API'] and injection['python_feedback_angle_flags_zeroed']
        if configuration is None:
            configuration = injection['config']
        assert configuration == injection['config']
        assert (folder / 'worker-as-run.py').read_bytes() == (BASE / 'worker-template.py').read_bytes()
        with np.load(folder / 'before.npz', allow_pickle=False) as before:
            for state in ('state0', 'state1'):
                for field, expected in initial.items():
                    assert before[state + '-' + field].tobytes() == expected.tobytes()
            assert before['feedback-angle-flags'].shape == (43,) and not before['feedback-angle-flags'].any()
        with np.load(folder / 'control-before.npz', allow_pickle=False) as control:
            raw = {key: (control[key].dtype.str, control[key].shape, control[key].tobytes()) for key in control.files}
            if control_baseline is None:
                control_baseline = raw
            assert raw == control_baseline
        trace = stack.enter_context(np.load(folder / 'recorded-states.npz', allow_pickle=False))
        assert set(trace.files) == set(initial)
        assert all(trace[key].shape == (1, *initial[key].shape) and np.isfinite(trace[key]).all() for key in trace.files)
        traces[label] = trace
        if outcome['actual_exit']:
            assert outcome['actual_exit'] == 1 and outcome['end_test_failure'] and not outcome['normal_demo_test_passed']
            exception = json.loads((folder / 'exception.json').read_text())
            assert exception['exception_rethrown_and_original_exit_preserved']
            assert any(row['function'] == 'test_final' and row['file'] == str(ROOT / 'examples/example_robot_g1.py')
                       for row in exception['frames'])
        else:
            assert outcome['normal_demo_test_passed'] and not outcome['end_test_failure']
            with np.load(folder / 'worker/states.npz', allow_pickle=False) as ordinary:
                assert all(ordinary[key].tobytes() == trace[key].tobytes() for key in trace.files)
        end_tests.append({'label': label, 'actual_exit': outcome['actual_exit'],
                          'normal_demo_test_passed': outcome['normal_demo_test_passed']})
        for path in folder.rglob('*'):
            if path.is_file():
                inputs[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    originals = [traces['sdk' + str(i)] for i in range(8)]
    numeric, strict, old_target_error = {}, {}, {}
    for label, trace in traces.items():
        strict[label] = {key: trace[key].tobytes() == originals[0][key].tobytes() for key in trace.files}
        old_target_error[label] = {key: float(np.abs(trace[key][0].astype(np.float64) - old_target[key]).max())
                                   for key in trace.files}
        if label.startswith('rebuilt'):
            stats = spread_report(originals, [trace])
            for key in trace.files:
                values = np.stack([data[key].astype(np.float64) for data in originals])
                total = values.sum(0)
                # Recalculate the same per-frame maximum over all state components independently.
                axes = tuple(range(1, trace[key].ndim))
                spread = np.maximum.reduce([np.abs(values[i] - (total - values[i]) / 7).max(axis=axes)
                                            for i in range(8)])
                error = np.abs(trace[key].astype(np.float64) - total / 8).max(axis=axes)
                assert int(np.count_nonzero(error <= spread)) == stats[key]['substeps_within_spread']
                assert float(error.max()) == stats[key]['reconstruction_error_max']
            numeric[label] = {'statistics': stats,
                              'all_fields_within': all(v['substeps_within_spread'] == 1 for v in stats.values())}
    component = {'old_saved_source1_frame31_value': float(old_target['body_qd'].reshape(-1)[76]),
                 'SDK': [float(traces['sdk' + str(i)]['body_qd'][0].reshape(-1)[76]) for i in range(8)],
                 'source': [float(traces['rebuilt' + str(i)]['body_qd'][0].reshape(-1)[76]) for i in range(3)]}
result = {
    'normal_demo_end_test_results': end_tests, 'configuration': configuration,
    'all_both_buffer_public_inputs_bitwise_equal_to_checkpoint': True,
    'all_recorded_control_inputs_bitwise_equal': True,
    'diagnostic_numeric_comparison': numeric, 'strict_vs_first_SDK': strict,
    'max_error_to_old_saved_source1_frame31': old_target_error, 'body12_component4': component,
    'input_sha256': inputs, 'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    'controlled_restart_not_old_internal_state_replay': True,
    'normal_end_test_failure_does_not_become_pass': True, 'old_C8_reclassified': False, 'whole_solver_complete': False,
}
output = BASE / 'independent-cpu-audit.json'
assert not output.exists()
output.write_text(json.dumps(result, indent=2) + '\n')
print('Completed controlled full frames:11; original end-test results:', end_tests, flush=True)
print('Diagnostic numerical C:', {key: value['all_fields_within'] for key, value in numeric.items()}, flush=True)
print('Body12 component4 values:', component, flush=True)
