"""A small no-contact demo through the unchanged Style3D Newton adapter, eager and captured."""
import sys
import types

import numpy as np


def run(core, seed, source, particle_springs=False, pd=False, static_contact=False, cloth=None):
    import warp as wp
    if source:
        # The official Python adapter imports authentication names unconditionally. Keep this test bridge outside
        # the independent C++ solver; it neither reads credentials nor calls any proprietary authentication code.
        adapter = types.ModuleType('style3d_sim._core')
        for name in dir(core):
            if not name.startswith('__'):
                setattr(adapter, name, getattr(core, name))
        adapter.is_logged_in = lambda: True

        def no_login(*args, **kwargs):
            raise RuntimeError('The source solver does not use login')

        adapter.login = no_login
        sys.modules['style3d_sim._core'] = adapter
    else:
        sys.modules['style3d_sim._core'] = core
    import newton
    import style3d_sim as s3d

    assert s3d.Solver is core.Solver
    rng = np.random.default_rng(seed + 1000)
    n = 73
    positions = rng.uniform(-1, 1, (n, 3)).astype('f4')
    velocities = rng.uniform(-.5, .5, (n, 3)).astype('f4')
    masses = rng.uniform(.1, 3, n).astype('f4')
    masses[::13] = 0
    if particle_springs:
        n = 2
        positions = np.array([[0, 0, 0], [1.2, .3, -.2]], dtype='f4')
        velocities = np.array([[0, 0, 0], [.1, -.05, .075]], dtype='f4')
        masses = np.array([0, 1.5], dtype='f4')
    if static_contact:
        n = 1
        positions = np.array([[.01, .02, .025]], dtype='f4')
        velocities = np.array([[.1, -.05, -.075]], dtype='f4')
        masses = np.array([1.5], dtype='f4')
    records, launches = {}, {}
    for mode in ('eager', 'graph'):
        builder = newton.ModelBuilder(gravity=(.125, -.25, -9.81))
        if static_contact:
            cfg = builder.default_shape_cfg.copy()
            cfg.ke, cfg.kd, cfg.kf, cfg.mu = 1737.5, 7.5, 71.25, .35
            builder.add_ground_plane(cfg=cfg)
        if cloth:
            from newton.solvers import style3d
            newton.solvers.SolverStyle3D.register_custom_attributes(builder)
            vertices = [[0, 0, 0], [1, 0, 0], [.25, .9, .15]]
            indices = [0, 1, 2]
            if cloth == 'bending':
                vertices = [[0, .6, 0], [0, -.6, 0], [-.5, 0, 0], [.6, .1, .2]]
                indices = [0, 2, 3, 1, 3, 2]
            style3d.add_cloth_mesh(builder, pos=wp.vec3(0), rot=wp.quat_identity(), vel=wp.vec3(0),
                                  vertices=vertices, indices=indices, density=10,
                                  tri_aniso_ke=wp.vec3(37.5, 53.75, 11.25),
                                  edge_aniso_ke=wp.vec3(.002, .001, .005), edge_kd=.75,
                                  tri_drag=0, tri_lift=0, particle_radius=.01)
            for i in range(len(vertices)-1):
                builder.particle_mass[i] = 0
            builder.particle_q[-1] = tuple(np.array(vertices[-1]) + [.075, .025, .05])
        else:
            builder.add_particles(pos=positions.tolist(), vel=velocities.tolist(), mass=masses.tolist(),
                                  radius=np.full(n, .05 if static_contact else .01).tolist())
        if particle_springs:
            builder.add_spring(0, 1, ke=37.5, kd=0, control=0)
            builder.spring_rest_length[-1] = .7
        model = builder.finalize(device='cuda:0')
        pipeline = contacts = None
        if static_contact:
            model.soft_contact_ke, model.soft_contact_kd = 2037.5, 3.75
            model.soft_contact_kf, model.soft_contact_mu = 93.75, .3
            pipeline = newton.CollisionPipeline(model, rigid_contact_max=0, soft_contact_max=8,
                                               enable_rigid_soft_full_surface_contact=False)
            contacts = model.contacts(pipeline)
        solver = s3d.NewtonSolver(model)
        solver.config.nonlinear_solver = core.NonlinearSolver.PD_NEWTON if pd else core.NonlinearSolver.NEWTON
        solver.config.nonlinear_iterations = 3
        solver.config.linear_iterations = 9
        a, b = model.state(), model.state()
        control = model.control()
        stream = wp.Stream('cuda:0')
        dt = 1 / 120

        def frame():
            for state_in, state_out in ((a, b), (b, a)):
                state_in.clear_forces()
                if pipeline is not None:
                    pipeline.collide(state_in, contacts)
                solver.step(state_in, state_out, control, contacts, dt)

        wp.synchronize()
        with wp.ScopedStream(stream):
            if mode == 'graph':
                wp.capture_begin(stream=stream)
                try:
                    frame()
                finally:
                    graph = wp.capture_end(stream=stream)
            for t in range(30):
                if mode == 'graph':
                    wp.capture_launch(graph, stream=stream)
                else:
                    frame()
                wp.synchronize_stream(stream)
                for tag, state in (('a', a), ('b', b)):
                    for field in ('particle_q', 'particle_qd', 'particle_f'):
                        records[f'adapter_{mode}/{t}/{tag}.{field}'] = getattr(state, field).numpy().copy()
                if contacts is not None:
                    records[f'adapter_{mode}/{t}/soft_count'] = contacts.soft_contact_count.numpy().copy()
            if contacts is not None:
                assert any(data[0] > 0 for key, data in records.items() if key.startswith('adapter_'+mode) and
                           key.endswith('/soft_count')), 'The contact demo did not generate any contacts'
        if source:
            launches[f'adapter_{mode}'] = dict(solver.native_solver.source_launch_counts)
    return records, launches
