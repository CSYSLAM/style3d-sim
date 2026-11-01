"""Check that promotion preserves the tested candidate math and the complete accepted CUDA inventory."""
import hashlib
import json
from pathlib import Path
import re

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
candidate = BASE.parent / 'continuation-20261101-38b70dcd-granular-affine-support/candidate2'
native = ROOT / 'reconstruction/csrc/native'
text = (native / 'source_solver.cpp').read_text()
scope = '''        // Only unconstrained, unbonded granular/SO3 body layouts have been compared against the SDK.
        // Free-body DOF/target channels alone do not imply constraints or drives.
        if (model.granular_particle_count && has_bodies &&
            (model.body_spring_count || model.body_distance_constraint_count || model.body_point_line_count ||
             model.joint_drive_count || model.joint_body_spring_count || model.joint_body_point_line_count ||
             model.cable_count || model.granular_bond_count || model.granular_adhesion > 0.0f))
            throw std::runtime_error("Constrained or bonded granular/body combinations have not been captured");
'''
step_scope = '''        if (bodies && granular_points_ &&
            (!so3 || config.enable_self_collision || contact.max_count || contact.soft_max_count))
            throw std::runtime_error("Granular bodies with other rigidity, self or external contacts are not captured");
'''
comment = '            // The SDK retains these zero-filled buffers without enabling the inactive VF query.\n'
labels = '''                                                     "granular_affine_so3_newton", "granular_affine_so3_pd_newton",
                                                     "granular_affine_so3_body_blocks",
'''
for region in (scope, step_scope, comment, labels):
    assert text.count(region) == 1
    text = text.replace(region, '')
assert text.count('Granular combined with other particle materials has not been captured') == 1
text = text.replace('Granular combined with other particle materials has not been captured',
                    'Granular combined with other materials or bodies has not been captured')
assert text == (candidate / 'source_solver.cpp').read_text()
assert (native / 'bvh_library.cu').read_bytes() == (candidate / 'bvh_library.cu').read_bytes()
assert re.sub(r'\s+', '', (native / 'bvh_library.h').read_text()) == \
    re.sub(r'\s+', '', (candidate / 'bvh_library.h').read_text())
build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
old = json.loads((BASE / 'before/build/reconstruction-csrc/host-particles/build.json').read_text())
assert len(build['sources']) == 25
for name, sha in build['sources'].items():
    assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == sha, name
assert build['kernel_count'] == old['kernel_count'] == 176
assert build['cuda_source_digest'] == old['cuda_source_digest']
assert build['kernels'] == old['kernels']
helper_paths = [p for p in build['sources'] if 'bvh-host-library/' in p and p.endswith('/build.json')]
assert len(helper_paths) == 1
helper = json.loads((ROOT / helper_paths[0]).read_text())
checks = helper['device_entries_identical_to_accepted_source']
assert len(checks) == 26 and all(checks.values())
report = {'candidate_math_text_identical_after_removing_explicit_scope_and_metadata': True,
          'helper_cuda_identical_to_tested_candidate': True, 'helper_header_whitespace_only_difference': True,
          'kernel_inventory_176_identical_to_previous_production': True, 'helper_device_entries_matched': 26,
          'current_sources_verified': len(build['sources']), 'current_host_sha256': build['extension_sha256'],
          'runtime_validation_claimed': False, 'whole_solver_complete': False}
with (BASE / 'integration-cpu-audit.json').open('x') as out:
    out.write(json.dumps(report, indent=2) + '\n')
print(json.dumps(report, indent=2))
