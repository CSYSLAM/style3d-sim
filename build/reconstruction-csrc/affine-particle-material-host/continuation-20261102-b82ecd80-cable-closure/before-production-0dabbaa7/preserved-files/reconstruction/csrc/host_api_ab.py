"""Compare actual old/source API defaults and integer boundaries, then check source-only failure guards."""
import json
import argparse
from pathlib import Path

import numpy as np

from .host_api_probe import describe, load_reference
from .host_particles_ab import OUT, native_source


def outcome(instance, key, value):
    try:
        setattr(instance, key, value)
        return ['value', getattr(instance, key)]
    except (AttributeError, TypeError, ValueError, OverflowError) as exc:
        return ['error', type(exc).__name__]


def span_assignment(module, class_name, field):
    instance = getattr(module, class_name)()
    supplied = module.Span(1234, 5)
    setattr(instance, field, supplied)
    borrowed = getattr(instance, field)
    setattr(instance, field, module.Span(5678, 7))
    return [(supplied.ptr, supplied.size), (borrowed.ptr, borrowed.size),
            (getattr(instance, field).ptr, getattr(instance, field).size)]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=OUT/'api-validation.json')
    output_path = parser.parse_args().output
    old, source = load_reference(), native_source()
    assert not hasattr(source, 'login') and not hasattr(source, 'is_logged_in')
    schema = describe(old)
    assert describe(source) == schema
    checks = {'source_has_no_authentication_api': True}
    for name, fields in schema['classes'].items():
        for key, field in fields.items():
            checks[f'default/{name}.{key}'] = True
            if field['type'] == 'Span':
                x, y = span_assignment(old, name, key), span_assignment(source, name, key)
                checks[f'span_assignment/{name}.{key}'] = x == y
                assert x == y, (name, key, x, y)
            if field['type'] != 'int':
                continue
            a, b = getattr(old, name)(), getattr(source, name)()
            for value in (-1, 0, 2**31-1, 2**31, 2**32-1, 2**32, 2**64-1, 2**64):
                x, y = outcome(a, key, value), outcome(b, key, value)
                checks[f'integer/{name}.{key}/{value}'] = x == y
                assert x == y, (name, key, value, x, y)
    for args in ((0, 1), (-1, 0), (0, -1), (2**64, 0)):
        results = []
        for module in (old, source):
            try:
                module.Span(*args)
                results.append('accepted')
            except Exception as exc:
                results.append(type(exc).__name__)
        checks[f'span/{args}'] = results[0] == results[1]
        assert checks[f'span/{args}'], results
    import warp as wp
    wp.init()
    arrays = [wp.array(np.array([[.25, .5, .75]], dtype='f4'), dtype=wp.vec3, device='cuda:0') for _ in range(4)]
    mass = wp.array([1.0], dtype=wp.float32, device='cuda:0')
    spans = [source.Span(array.ptr, 1) for array in arrays]
    model = source.Model()
    model.particle_count = model.particle_state_count = 1
    model.particle_masses = source.Span(mass.ptr, 1)
    model.particle_rest_positions = spans[0]
    a, b = source.State(), source.State()
    a.particle_q, a.particle_qd, b.particle_q, b.particle_qd = spans
    solver = source.Solver()
    expected = [array.numpy().copy() for array in arrays]

    def rejected(name, operation, error):
        try:
            operation()
        except error:
            pass
        else:
            raise AssertionError('Unsafe call was accepted: ' + name)
        wp.synchronize()
        assert all(np.array_equal(x.view('u4'), y.numpy().view('u4')) for x, y in zip(expected, arrays))
        checks['guard/' + name] = True

    rejected('before_initialize', lambda: solver.step(a, b, .01), RuntimeError)
    solver.initialize(model)
    for dt in (0, -.1, float('nan'), float('inf')):
        rejected('dt_' + str(dt), lambda: solver.step(a, b, dt), ValueError)
    a.particle_q = source.Span()
    rejected('short_span', lambda: solver.step(a, b, .01), ValueError)
    a.particle_q = spans[0]
    unavailable_outputs = []
    # Self-collision is now supported. With no collision primitives, the current original accepts
    # enable_self_collision; verify that actual behavior instead of retaining the old source-only guard.
    for module in (old, source):
        probe_arrays = [wp.array(value, dtype=wp.vec3, device='cuda:0') for value in expected]
        probe_model = module.Model()
        probe_model.particle_count = probe_model.particle_state_count = 1
        probe_model.particle_masses = module.Span(mass.ptr, 1)
        probe_model.particle_rest_positions = module.Span(probe_arrays[0].ptr, 1)
        probe_a, probe_b = module.State(), module.State()
        probe_a.particle_q, probe_a.particle_qd, probe_b.particle_q, probe_b.particle_qd = \
            [module.Span(array.ptr, 1) for array in probe_arrays]
        probe_solver = module.Solver()
        probe_solver.config.nonlinear_iterations = 0
        probe_solver.config.enable_self_collision = True
        probe_solver.initialize(probe_model)
        probe_solver.step(probe_a, probe_b, .01)
        wp.synchronize()
        unavailable_outputs.append([array.numpy().tobytes() for array in probe_arrays])
    assert unavailable_outputs[0] == unavailable_outputs[1]
    checks['step/self_collision_unavailable_matches_original'] = True
    rejected('bad_stream', lambda: solver.step(a, b, .01, object()), TypeError)
    for field, value in (('linear_iterations', 0), ('nonlinear_iterations', -1)):
        previous = getattr(solver.config, field)
        setattr(solver.config, field, value)
        rejected(field, lambda: solver.step(a, b, .01), ValueError)
        setattr(solver.config, field, previous)
    model.hinge_count = 1
    rejected('surface_topology_not_implemented', lambda: source.Solver().initialize(model), RuntimeError)
    model.hinge_count = 0
    extra = []

    def span(data, dtype):
        array = wp.array(data, dtype=dtype, device='cuda:0')
        extra.append(array)
        return source.Span(array.ptr, len(array))

    model.shape_count = model.shape_replicated_count = 1
    for field, data, dtype in (
            ('particle_radii', [.05], wp.float32), ('shape_bodies', [-1], wp.int32),
            ('shape_types', [6], wp.int32), ('shape_transforms', [[0, 0, 0, 0, 0, 0, 1]], wp.transform),
            ('shape_scales', [[1, 1, 1]], wp.vec3), ('shape_margins', [0], wp.float32),
            ('shape_contact_stiffnesses', [1000], wp.float32), ('shape_contact_dampings', [0], wp.float32),
            ('shape_contact_friction_gains', [1000], wp.float32), ('shape_frictions', [0], wp.float32)):
        setattr(model, field, span(data, dtype))
    for field in ('particle_radii', 'shape_bodies', 'shape_types', 'shape_transforms', 'shape_scales', 'shape_margins',
                  'shape_contact_stiffnesses', 'shape_contact_dampings', 'shape_contact_friction_gains', 'shape_frictions'):
        saved = getattr(model, field)
        saved = source.Span(saved.ptr, saved.size)
        setattr(model, field, source.Span())
        rejected('missing_model_' + field, lambda: source.Solver().initialize(model), ValueError)
        setattr(model, field, saved)
    solver.initialize(model)
    contact = source.Contact()
    contact.soft_max_count = 1
    for field, data, dtype in (
            ('soft_count', [1], wp.int32), ('soft_particle', [0], wp.int32), ('soft_shape', [0], wp.int32),
            ('soft_body_pos', [[0, 0, 0]], wp.vec3), ('soft_body_vel', [[0, 0, 0]], wp.vec3),
            ('soft_normal', [[0, 0, 1]], wp.vec3)):
        setattr(contact, field, span(data, dtype))
    for field in ('soft_count', 'soft_particle', 'soft_shape', 'soft_body_pos', 'soft_body_vel', 'soft_normal'):
        saved = getattr(contact, field)
        saved = source.Span(saved.ptr, saved.size)
        setattr(contact, field, source.Span())
        rejected('missing_contact_' + field, lambda: solver.step(a, b, contact, .01), ValueError)
        setattr(contact, field, saved)
    contact.soft_indices = span([[0, 0, 0]], wp.vec3i)
    rejected('partial_surface_inputs_not_implemented', lambda: solver.step(a, b, contact, .01), RuntimeError)
    for count_field, specifications in (
            ('triangle_count', (('triangle_indices', [[0, 0, 0]], wp.vec3i),
                                ('triangle_inv_dms', [[[1, 0], [0, 1]]], wp.mat22),
                                ('triangle_rest_areas', [1], wp.float32),
                                ('triangle_aniso_stiffnesses', [[1, 1, 1]], wp.vec3))),
            ('edge_count', (('edge_indices', [[-1, -1, 0, 0]], wp.vec4i), ('edge_rest_areas', [0], wp.float32),
                            ('edge_bending_cots', [[0, 0, 0, 0]], wp.vec4),
                            ('edge_bending_properties', [[0, 0]], wp.vec2)))):
        setattr(model, count_field, 1)
        for field, data, dtype in specifications:
            setattr(model, field, span(data, dtype))
        for field, _, _ in specifications:
            saved = getattr(model, field)
            saved = source.Span(saved.ptr, saved.size)
            setattr(model, field, source.Span())
            rejected('missing_model_' + field, lambda: source.Solver().initialize(model), ValueError)
            setattr(model, field, saved)
        setattr(model, count_field, 0)
    result = {'checks': checks, 'passed': len(checks), 'original_login_required': False,
              'source_extension_sha256': json.loads((OUT/'build.json').read_text())['extension_sha256']}
    output_path.write_text(json.dumps(result, indent=2)+'\n')
    print('API/guard checks passed', len(checks))


if __name__ == '__main__':
    main()
