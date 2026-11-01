"""Recover the SDK's independent block-matrix flag from fixed disassembly and twelve actual native probes."""
from pathlib import Path
import hashlib,json
root=Path.cwd();base=Path(__file__).resolve().parent
checkpoint=root/'build/reconstruction-checkpoints/driven-cloth-contact-matrix-before-1d0cc836/checkpoint.json'
proof=json.loads(checkpoint.read_text());source=root/'reconstruction/csrc/native/source_solver.cpp'
old=source.read_bytes();assert hashlib.sha256(old).hexdigest()==proof['files']['reconstruction/csrc/native/source_solver.cpp']
expected={'six-none':0,'six-rigid':3,'six-soft':0,'six-both':3,'six-soft-alpha0':0,'six-soft-diagonal':0,
          'so3-both':0,'six-surface-soft':3,'six-surface-alpha0':0,'six-both-diagonal':3,
          'six-rigid-alpha0':0,'six-surface-diagonal':3}
observed={}
for name in ('matrix-selection-probes9','matrix-selection-probes3-boundaries'):
    report=json.loads((base/name/'report.json').read_text());assert report['complete']
    for row in report['cases']:
        assert row['exit']==0 and row['block_template_calls']==expected[row['case']]
        assert row['membrane_gn_calls']==0
        assert ('17BlockNonZeroEntry' in row['first_matrix'])==bool(row['block_template_calls'])
        observed[row['case']]=row['block_template_calls']
assert observed==expected
s=old.decode()
changes=[
 ('const bool block = !pd || self || surface || contact_product || bending_damping_ || tetrahedron_count_ || drag ||',
  '// The SDK selects sparse block entries independently of PD when SIX_SPRINGS has rigid/surface input.\n        const bool block_matrix = !pd || (six_springs && alpha > 0.0f && (rigid || surface));\n        const bool block = block_matrix || self || surface || contact_product || bending_damping_ ||\n                           tetrahedron_count_ || drag ||'),
 ('if (!pd && max_entries_)','if (block_matrix && max_entries_)'),
 ('pd ? preconditioner_blocks_ : null','block_matrix ? null : preconditioner_blocks_'),
 ('if (!pd && six_springs && so3_alpha > 0.0f)','if (block_matrix && six_springs && so3_alpha > 0.0f)'),
 ('if (!pd) copy(preconditioner_blocks_, blocks_, count_ * 36, stream);',
  'if (block_matrix) copy(preconditioner_blocks_, blocks_, count_ * 36, stream);'),
 ('launch(pd ? "affine_build_scalar" : "affine_build", body_state_count_, stream,',
  'launch(block_matrix ? "affine_build" : "affine_build_scalar", body_state_count_, stream,'),
 ('pd ? template_row_counts() : row_count_, pd ? scalar_template_ : block_entries_, max_entries_,',
  'block_matrix ? row_count_ : template_row_counts(),\n                           block_matrix ? block_entries_ : scalar_template_, max_entries_,'),
 ('pd ? per_world_ : count_,','block_matrix ? count_ : per_world_,'),
 ('launch(pd ? (block ? "scalar_block_multiply" : "scalar_multiply") : "multiply",\n                       count_, stream, pd ? template_row_counts() : row_count_,\n                       pd ? scalar_template_ : block_entries_, max_entries_,',
  'launch(block_matrix ? "multiply" : (block ? "scalar_block_multiply" : "scalar_multiply"),\n                       count_, stream, block_matrix ? row_count_ : template_row_counts(),\n                       block_matrix ? block_entries_ : scalar_template_, max_entries_,'),
 ('pd ? per_world_ : count_);','block_matrix ? count_ : per_world_);')]
for a,b in changes:
    assert s.count(a)==(2 if a=='if (!pd && max_entries_)' else 1),(a,s.count(a))
    s=s.replace(a,b)
assert max(map(len,s.splitlines()))<=128
source.write_text(s)
(base/'block-matrix-edit-receipt.json').write_text(json.dumps({'before_sha256':hashlib.sha256(old).hexdigest(),
    'after_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),'checkpoint':str(checkpoint),'changes':changes,
    'actual_sdk_probe_cases':observed,'PD_mode_unchanged':True,'membrane_GN_still_Newton_only':True,
    'math_and_CUDA_unchanged':True},indent=2)+'\n')
