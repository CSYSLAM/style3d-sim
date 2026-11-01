"""Record actual native model counts before executing the unchanged rejected initialization."""
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.host_particles_ab import native_source
from reconstruction.csrc import demo_source_ab

core = native_source()
initialize = core.Solver.initialize


def observed(solver, model, *values, **keywords):
    names = ('body_count', 'body_state_count', 'body_spring_count', 'body_distance_constraint_count',
             'body_point_line_count', 'joint_drive_count', 'joint_body_spring_count', 'joint_body_point_line_count',
             'joint_dof_count', 'joint_target_count', 'cable_count', 'granular_particle_count', 'granular_bond_count',
             'granular_adhesion')
    report = {name: getattr(model, name) for name in names}
    target = BASE / 'rejected-actual-model-fields.json'
    with target.open('x') as out:
        out.write(json.dumps(report, indent=2) + '\n')
    return initialize(solver, model, *values, **keywords)


core.Solver.initialize = observed
demo_source_ab.main()
