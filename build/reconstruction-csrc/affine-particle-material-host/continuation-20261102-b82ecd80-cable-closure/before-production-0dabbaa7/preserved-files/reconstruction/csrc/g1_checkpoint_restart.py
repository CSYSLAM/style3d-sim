"""Run a controlled G1 frame from one frozen public checkpoint, preserving the original demo end tests."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path
import sys
import traceback

import numpy as np

from .demo_source_ab import ROOT


WORKER = ROOT / ('build/reconstruction-csrc/affine-particle-material-host/'
                 'continuation-20261101-688f9633-driven-cloth-rigid-soft/'
                 'official-g1-public-core-graph60/worker-as-run.py')
WORKER_SHA = '9d0accab204c7910ab95ed8b01430c532daa265be2503f20b2aa2cfc5cbd28b4'
FIELDS = ('body_q', 'body_qd', 'particle_q', 'particle_qd')


def rendered_worker():
    assert hashlib.sha256(WORKER.read_bytes()).hexdigest() == WORKER_SHA
    text = WORKER.read_text()
    old = '        original_step = example.step\n'
    assert text.count(old) == 1
    text = text.replace(old, '        checkpoint_hook.install(example)\n' + old)
    old = '        return previous_run(example, options)\n'
    assert text.count(old) == 1
    text = text.replace(old, '''        try:
            return previous_run(example, options)
        except BaseException as problem:
            checkpoint_hook.record_exception(problem)
            raise
        finally:
            checkpoint_hook.save_records(records)
''')
    return text


class CheckpointHook:
    def __init__(self, plan, output):
        self.plan, self.output, self.uploads = plan, output, []

    @staticmethod
    def graph_counts(graph):
        driver = ct.CDLL('libcuda.so.1')
        nodes, edges = ct.c_size_t(), ct.c_size_t()
        driver.cuGraphGetNodes.argtypes = [ct.c_void_p, ct.c_void_p, ct.POINTER(ct.c_size_t)]
        driver.cuGraphGetNodes.restype = ct.c_int
        driver.cuGraphGetEdges.argtypes = [ct.c_void_p, ct.c_void_p, ct.c_void_p, ct.POINTER(ct.c_size_t)]
        driver.cuGraphGetEdges.restype = ct.c_int
        assert driver.cuGraphGetNodes(graph.graph, None, ct.byref(nodes)) == 0
        assert driver.cuGraphGetEdges(graph.graph, None, None, ct.byref(edges)) == 0
        return [nodes.value, edges.value]

    def install(self, example):
        import warp as wp

        before_graph = self.graph_counts(example.graph)
        assert before_graph == [17467, 17466]
        assert example.model.body_count == 44 and example.model.particle_count == 176
        assert example.sim_substeps == 6
        with np.load(self.plan['input_checkpoint'], allow_pickle=False) as checkpoint:
            expected = {field: checkpoint[field][self.plan['input_frame']].copy() for field in FIELDS}
        for state in (example.state_0, example.state_1):
            for field in FIELDS:
                target = getattr(state, field)
                values = expected[field]
                assert target.numpy().shape == values.shape and values.dtype == np.dtype('<f4')
                upload = wp.array(values, dtype=target.dtype, device=target.device)
                self.uploads.append(upload)
                wp.copy(target, upload)
        stream = wp.get_stream(example.model.device)
        example.solver._native_solver.reset_joint_drive_state(stream)
        feedback_flags = example.solver._joint_drive_feedback_angle_initialized
        assert feedback_flags is not None and feedback_flags.shape == (43,)
        feedback_flags.zero_()
        wp.synchronize_device(example.model.device)
        saved = {}
        for name, state in (('state0', example.state_0), ('state1', example.state_1)):
            for field in FIELDS:
                value = getattr(state, field).numpy().copy()
                assert value.tobytes() == expected[field].tobytes()
                saved[name + '-' + field] = value
        saved['feedback-angle-flags'] = feedback_flags.numpy().copy()
        assert not saved['feedback-angle-flags'].any()
        np.savez_compressed(self.output / 'before.npz', **saved)
        control = {}
        for prefix, owner, names in (
            ('control', example.control, ('joint_target_pos', 'joint_target_vel', 'joint_f', 'joint_act')),
            ('model', example.model, ('joint_target_ke', 'joint_target_kd', 'joint_target_mode', 'gravity')),
        ):
            for name in names:
                array = getattr(owner, name, None)
                if array is not None and hasattr(array, 'numpy'):
                    control[prefix + '-' + name] = array.numpy().copy()
        assert control
        np.savez_compressed(self.output / 'control-before.npz', **control)
        config_names = ('affine_body_rigidity_model', 'joint_constraint_mode', 'nonlinear_solver', 'inertia_mode',
                        'joint_constraint_primal_iterations', 'nonlinear_iterations', 'linear_iterations')
        config = {}
        for name in config_names:
            value = getattr(example.solver.config, name)
            config[name] = int(value.value) if hasattr(value, 'value') else int(value)
        after_graph = self.graph_counts(example.graph)
        assert after_graph == before_graph
        (self.output / 'injection.json').write_text(json.dumps({
            'input_frame': self.plan['input_frame'], 'both_public_state_buffers_set_to_the_same_checkpoint': True,
            'native_drive_flags_reset_via_existing_API': True, 'python_feedback_angle_flags_zeroed': True,
            'original_hidden_caches_not_restored': True, 'graph_counts_before': before_graph,
            'graph_counts_after': after_graph, 'sim_substeps': example.sim_substeps,
            'frame_dt': example.frame_dt, 'sim_dt': example.sim_dt, 'display_sim_time': example.sim_time,
            'config': config, 'demo_end_tests_modified': False, 'whole_solver_complete': False,
        }, indent=2) + '\n')

    def record_exception(self, problem):
        frames = [{'file': frame.filename, 'function': frame.name, 'line': frame.lineno}
                  for frame in traceback.extract_tb(problem.__traceback__)]
        (self.output / 'exception.json').write_text(json.dumps({
            'type': type(problem).__name__, 'message': str(problem), 'frames': frames,
            'exception_rethrown_and_original_exit_preserved': True,
        }, indent=2) + '\n')

    def save_records(self, records):
        arrays = {key: np.asarray(values) for key, values in records.items() if values}
        np.savez_compressed(self.output / 'recorded-states.npz', **arrays)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--plan', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    plan = json.loads(args.plan.read_text())
    for name, expected in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    script = output / 'worker-as-run.py'
    text = rendered_worker()
    assert hashlib.sha256(text.encode()).hexdigest() == plan['patched_worker_sha256']
    script.write_text(text)
    hook = CheckpointHook(plan, output)
    sys.argv = [str(script), '--backend', args.backend, '--core-build', plan['core_build'],
                '--example', str(ROOT / 'examples/example_robot_g1.py'), '--frames', '1',
                '--output', str(output / 'worker'), '--', '--solver', 'synreal', '--world-count', '1']
    try:
        exec(compile(text, str(script), 'exec'), {'__name__': '__main__', '__package__': 'reconstruction.csrc',
                                               '__file__': str(script), 'checkpoint_hook': hook})
    finally:
        (output / 'provenance.json').write_text(json.dumps({
            'base_worker_sha256': WORKER_SHA, 'patched_worker_sha256': hashlib.sha256(text.encode()).hexdigest(),
            'wrapper_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            'plan_sha256': hashlib.sha256(args.plan.read_bytes()).hexdigest(),
            'controlled_restart_not_old_internal_state_replay': True, 'demo_end_tests_modified': False,
            'production_changed': False, 'old_C8_reclassified': False, 'whole_solver_complete': False,
        }, indent=2) + '\n')


if __name__ == '__main__':
    main()
