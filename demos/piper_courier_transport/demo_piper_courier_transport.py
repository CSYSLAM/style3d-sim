"""Opaque courier mailers with the original package scene's coupled physics and motion."""

import json
from pathlib import Path
import sys
import time

import newton
import numpy as np
from scipy.spatial.transform import Rotation
import warp as wp

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE.parent / 'piper_package_transport'))
from demo_piper_package_transport import Simulation, parse_args as package_args
from geometry import BAG_SIZE, GRASP_OFFSET, PAYLOAD_SIZE, six_volumes
from motion import (
    GRIP_POINTS, create_plan, CENTERS, SHAKE_START, SHAKE_END, SHAKE_CYCLES,
    DROP_RELEASE_START, DROP_RELEASE_END, RELEASE_OPENING, LIFT_HEIGHT, SHAKE_DIRECTION, SHAKE_AMPLITUDE,
    SHAKE_PITCH_CENTER, SHAKE_PITCH_AMPLITUDE,
)
from courier_materials import BAG_COLOR


def parse_args(argv=None):
    arguments = list(sys.argv[1:] if argv is None else argv)
    if not any(arg == '--substeps' or arg.startswith('--substeps=') for arg in arguments):
        arguments += ['--substeps', '8']
    if not any(arg == '--output' or arg.startswith('--output=') for arg in arguments):
        arguments += ['--output', str(ROOT / 'build/courier-package')]
    return package_args(arguments)


def main(argv=None):
    args = parse_args(argv)
    print(f'Payload dimensions (mm): {np.asarray(PAYLOAD_SIZE) * 1000}; '
          f'bag dimensions (mm): {np.asarray(BAG_SIZE) * 1000}', flush=True)
    if not args.viewer:
        args.output.mkdir(parents=True, exist_ok=True)
        print(f'Headless render recording: {args.output.resolve()}', flush=True)
    sim = Simulation(args)
    viewer = None
    viewer_meshes = []
    if args.viewer:
        viewer = newton.viewer.ViewerGL(vsync=True)
        viewer.set_model(sim.model)
        viewer.show_particles = False
        viewer.show_triangles = False
        viewer.set_camera(pos=wp.vec3(0.95, 0.75, 0.85), pitch=-48.0, yaw=230.0)
        colors = (BAG_COLOR, BAG_COLOR, (0.05, 0.55, 0.30))
        for group, color in zip(sim.groups, colors):
            indices = wp.array(group['faces'].astype(np.int32).ravel(), dtype=wp.int32, device=sim.model.device)
            viewer_meshes.append((group, indices, color))
    usd = None
    if not args.viewer:
        # Interactive playback must not construct a USD stage or retain a full trajectory in host memory.
        from courier_materials import CourierSceneUSD as SceneUSD
        usd = SceneUSD(args.output / 'simulation.usdc', sim, round(args.seconds * 30))
    particle_frames, body_frames = [], []
    start = time.perf_counter()
    completed_frame = 0
    try:
        for frame in range(round(args.seconds * 60) + 1):
            if viewer is not None and not viewer.is_running():
                break
            if frame == 14 * 60:
                actual = sim.state.particle_q.numpy()[sim.groups[-1]['start']:sim.groups[-1]['end']].mean(0)
                offset = np.clip(actual - CENTERS[1], -0.025, 0.025)
                offset[2] = 0
                sim.plan = create_plan(second_offset=offset)
                sim.targets.assign(sim.plan)
            if frame:
                sim.step()
            completed_frame = frame
            if (not args.viewer and frame % 2 == 0) or frame % 60 == 0:
                particles, bodies = sim.state.particle_q.numpy(), sim.state.body_q.numpy()
                if not np.isfinite(particles).all() or not np.isfinite(bodies).all():
                    raise RuntimeError(f'Non-finite state at frame {frame}')
            if usd is not None and frame % 2 == 0:
                usd.sample(frame // 2, particles, bodies)
                particle_frames.append(particles)
                body_frames.append(bodies)
            if viewer is not None:
                viewer.begin_frame(frame / 60.0)
                viewer.log_state(sim.state)
                for group, indices, color in viewer_meshes:
                    viewer.log_mesh(
                        f"/simulation/{group['name']}", sim.state.particle_q[group['start']:group['end']], indices,
                        color=color, roughness=0.65, backface_culling=False,
                    )
                viewer.end_frame()
            if frame % 60 == 0:
                jelly = particles[sim.jelly_start:sim.groups[-1]['end']]
                ratio = six_volumes(jelly, sim.tets) / sim.rest_volumes
                carton_normal = Rotation.from_quat(bodies[sim.carton, 3:]).as_matrix()[2, 2]
                print(f'{frame / 60:.1f}s: carton={bodies[sim.carton, :3].round(3)} '
                      f'carton_normal_z={carton_normal:.3f} '
                      f'jelly={jelly.mean(0).round(3)} floor={particles[:sim.groups[-1]["end"], 2].min():.4f} '
                      f'min_tet={ratio.min():.3f} elapsed={time.perf_counter() - start:.1f}s', flush=True)
    finally:
        if viewer is not None:
            viewer.close()
    if usd is None:
        return
    usd.stage.SetEndTimeCode(len(particle_frames) - 1)
    usd.stage.GetRootLayer().Save()
    np.savez_compressed(args.output / 'trajectory.npz', particles=particle_frames, bodies=body_frames,
                        carton=sim.carton, jelly_start=sim.jelly_start, tets=sim.tets,
                        rest_volumes=sim.rest_volumes, carton_points=sim.carton_points,
                        film_faces=sim.groups[0]['faces'],
                        film_panel_vertices=sim.film_panels, film_panel_faces=sim.film_panel_faces, wrist=sim.wrist,
                        gripper_bodies=sim.gripper_bodies, grip_local=np.asarray(GRIP_POINTS),
                        seal_patch_indices=np.flatnonzero((np.abs(sim.groups[0]['local'][:, 0]) < 0.015)
                            & (np.abs(sim.groups[0]['local'][:, 1] + GRASP_OFFSET) < 0.007)),
                        joint_targets=sim.plan,
                        group_ranges=np.array([(g['start'], g['end']) for g in sim.groups]))
    (args.output / 'run.json').write_text(json.dumps(dict(seconds=completed_frame / 60, fps=30,
        substeps=args.substeps, nonlinear=args.iterations, pcg=args.linear_iterations,
        particles=sim.model.particle_count, tetrahedra=len(sim.tets),
        payload_size_m=PAYLOAD_SIZE, bag_size_m=BAG_SIZE, bag_construction='two_rectangular_panels_perimeter_welded',
        motion='airborne_fore_aft_wrist_flick_side_grip_release_drop', shake_local_seconds=(SHAKE_START, SHAKE_END),
        shake_cycles=SHAKE_CYCLES, shake_direction_world=SHAKE_DIRECTION, shake_amplitude_m=SHAKE_AMPLITUDE,
        shake_pitch_axis_world=(1, 0, 0), shake_pitch_center_degrees=SHAKE_PITCH_CENTER,
        shake_pitch_amplitude_degrees=SHAKE_PITCH_AMPLITUDE,
        seal_grasp_offset_m=GRASP_OFFSET,
        jaw_closing_axis_world=(1, 0, 0), lift_height_m=LIFT_HEIGHT,
        release_local_seconds=(DROP_RELEASE_START, DROP_RELEASE_END), release_opening_m=RELEASE_OPENING,
        wall_seconds=time.perf_counter() - start), indent=2))


if __name__ == '__main__':
    main()
