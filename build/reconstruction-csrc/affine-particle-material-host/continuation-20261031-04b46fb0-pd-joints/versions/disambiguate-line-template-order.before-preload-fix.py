"""Actual SDK initialize-only probe with reversed proxy ownership; no state trajectory or cohort replacement."""
import ctypes
import hashlib
import json
from pathlib import Path
import sys
root=Path.cwd().resolve()
sys.path.insert(0,str(root))
from reconstruction.csrc.host_api_probe import load_reference
core=load_reference()
import warp as wp
import numpy as np
from reconstruction.csrc.joint_pd_scene import Example
scene=Example(None,Example.create_parser().parse_args(['--joint-kind','prismatic','--worlds','3','--seed','3',
                                                      '--armature','.007','--derive-velocity']))
original=scene.solver._synreal_model
fields=json.loads((root/'reconstruction/csrc/native/api_schema.json').read_text())['classes']['Model']
indices=np.array([[4,5,6,7],[0,1,2,3]],dtype='i4')
replacement=wp.array(indices,dtype=wp.vec4i,device='cuda:0')
model=core.Model()
for name in fields:setattr(model,name,getattr(original,name))
model.affine_body_indices=core.Span(replacement.ptr,2)
base=Path(__file__).resolve().parent/'original-reversed-proxy-initialize'
base.mkdir(exist_ok=False)
observer=ctypes.CDLL(None)
observer.solver_memory_trace_begin.argtypes=[ctypes.c_char_p,ctypes.c_char_p]
observer.solver_memory_trace_mark.argtypes=[ctypes.c_char_p]
solver=core.Solver()
wp.synchronize_device('cuda:0')
observer.solver_memory_trace_begin(str(base).encode(),str(Path(core.__file__).resolve()).encode())
solver.initialize(model)
observer.solver_memory_trace_mark(b'end_initialize')
observer.solver_memory_trace_end()
np.savez_compressed(base/'explicit-model-change.npz',affine_body_indices=indices)
(base/'provenance.json').write_text(json.dumps({'reference_sha256':hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest(),
 'initialize_only':True,'simulation_steps':0,'explicit_override':'affine_body_indices = [[4,5,6,7],[0,1,2,3]]',
 'cohort_expanded':False,'frozen_candidate_replaced':False,'whole_solver_complete':False,
 'runner_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()},indent=2)+'\n')
print('actual SDK reversed-proxy initialize complete',flush=True)
