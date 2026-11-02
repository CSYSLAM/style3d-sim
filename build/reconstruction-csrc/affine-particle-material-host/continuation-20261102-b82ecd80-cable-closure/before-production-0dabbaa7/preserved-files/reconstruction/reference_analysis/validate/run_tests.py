"""编译 human/*.cu → sm_120 cubin，生成 spec，跑 A/B 比对"""
import os, re, subprocess, json, sys
NVCC='/usr/local/cuda/bin/nvcc'
CUOBJ='/usr/local/cuda/bin/cuobjdump'
HUMAN='../recover/human'; RECON='../reconstructed'
OUT='cubins'; os.makedirs(OUT, exist_ok=True)
sys.path.insert(0,'.')
from mkjit import extract

K=json.load(open('../kernels.json'))
def mangled_of(short):
    for k in K:
        d=k['disp']
        if d.split('<')[0].split('(')[0].strip().endswith(short) or d.split('<')[0].strip()==short:
            return k['mangled']
    return None

def cubin_kernel_name(cubin):
    sym=subprocess.run([CUOBJ,'-symbols',cubin],capture_output=True,text=True).stdout
    for l in sym.splitlines():
        if 'STT_FUNC' in l and 'STO_ENTRY' in l:
            return l.split()[-1]
    for l in sym.splitlines():
        if 'STT_FUNC' in l:
            return l.split()[-1]
    return None

def compile_cu(cu):
    out=os.path.join(OUT, os.path.basename(cu).replace('.cu','.cubin'))
    r=subprocess.run([NVCC,'-O3','-arch=sm_120','-cubin','-o',out,cu,'-I','../recover/human','-I','../recover'],
                     capture_output=True, text=True)
    if r.returncode!=0: return None, r.stderr[:200]
    return out, None

# 测试矩阵：(label, cu 路径, PTX mangled 名, grid, block, params)
T = [
 ('initialize_scale', f'{RECON}/initialize_scale.cu', '_ZN7synreal12fluid_kernel16initialize_scaleEPffi',
  (4,1,1),(256,1,1), ['ptr randf 4096','f32 2.5','u32 1024']),
 ('update_velocity', f'{HUMAN}/update_velocity.cu', '_ZN7synreal6kernel15update_velocityEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PS4_m',
  (1,1,1),(256,1,1), ['f32 0.5','ptr randf 3072','ptr randf 3072','ptr zero 3072','u64 256']),
 ('apply_nonlinear_step', f'{HUMAN}/apply_nonlinear_step.cu', '_ZN7synreal6kernel20apply_nonlinear_stepEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPS4_S7_m',
  (1,1,1),(256,1,1), ['ptr randf 3072','ptr randf 3072','ptr randf 3072','u64 256']),
 ('add_diagonal_mat3', f'{HUMAN}/add_diagonal_mat3.cu', '_ZN7synreal12fluid_kernel12add_diagonalEPKN3glm3matILi3ELi3EfLNS1_9qualifierE0EEEPS4_i',
  (1,1,1),(256,1,1), ['ptr randf 9216','ptr randf 9216','u32 256']),
 ('add_hessian_diagonal', f'{HUMAN}/add_hessian_diagonal.cu', '_ZN7synreal21self_collision_kernel20add_hessian_diagonalEPKN3glm3matILi3ELi3EfLNS1_9qualifierE0EEEPS4_m',
  (1,1,1),(256,1,1), ['ptr randf 9216','ptr randf 9216','u64 256']),
 ('multiply_hessian_diagonal', f'{HUMAN}/multiply_hessian_diagonal.cu', '_ZN7synreal21self_collision_kernel25multiply_hessian_diagonalEPKN3glm3matILi3ELi3EfLNS1_9qualifierE0EEEPKNS1_3vecILi3EfLS3_0EEEPS8_m',
  (1,1,1),(256,1,1), ['ptr randf 9216','ptr randf 3072','ptr zero 3072','u64 256']),
 ('initialize_joint_body_spring_state', f'{HUMAN}/initialize_joint_body_spring_state.cu', '_ZN7synreal6kernel34initialize_joint_body_spring_stateEPN3glm3vecILi3EfLNS1_9qualifierE0EEEm',
  (1,1,1),(256,1,1), ['ptr randf 3072','u64 256']),
 ('reset_selected_joint_drive_state', f'{HUMAN}/reset_selected_joint_drive_state.cu', '_ZN7synreal6kernel35reset_selected_joint_drive_stateEPKiPim',
  (1,1,1),(256,1,1), ['ptr idx 1024 2','ptr randf 1024','u64 256']),
 ('build_primitive_leaf_nodes', f'{HUMAN}/build_primitive_leaf_nodes.cu', '_ZN7synreal6kernel25build_primitive_leaf_nodesEPiPKij',
  (1,1,1),(256,1,1), ['ptr zero 1024','ptr idx 1024 256','u32 256']),
 ('update_preconditioned_cg_direction', f'{HUMAN}/update_preconditioned_cg_direction.cu', '_ZN7synreal6kernel36update_preconditioned_cg_directionEiPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKfPS4_m',
  (1,1,1),(256,1,1), ['u32 1','ptr randf 3072','ptr randf 1024','ptr randf 3072','u64 256']),
 ('add_triangle_drag_preconditioner', f'{HUMAN}/add_triangle_drag_preconditioner.cu', '_ZN7synreal6kernel33add_triangle_drag_preconditionerEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi3EiLS3_0EEEPKfPNS1_3matILi3ELi3EfLS3_0EEEmmm',
  (1,1,1),(256,1,1), ['ptr idx 3072 255','ptr randf 3072','ptr small 1024','ptr randf 9216','u64 256','u64 256','u64 256']),

 ('evaluate_spring_force', '../reconstructed/evaluate_spring_force.cu', None,
  (1,1,1),(256,1,1), ['ptr randf 3072','ptr idx 1024 255','ptr randf 512','ptr randf 512','ptr zero 3072','u64 128','u64 256','u64 128']),
 ('combine_system_non_diagonal', f'{HUMAN}/combine_system_non_diagonal.cu', None,
  (1,1,1),(256,1,1), ['f32 0.3','f32 0.4','f32 0.5','f32 0.6','f32 0.7','f32 0.8',
                      'ptr pair 2048 256','ptr pair 2048 256','ptr pair 2048 256','ptr pair 2048 256',
                      'ptr pair 2048 256','ptr pair 2048 256','ptr pair 2048 256','ptr zero 2048','u64 256']),
 ('initialize_block_diagonal', f'{HUMAN}/initialize_block_diagonal.cu', None,
  (1,1,1),(256,1,1), ['ptr randf 1024','ptr zero 9216','ptr zero 9216','u64 256']),
 ('prepare_inverse_preconditioner', f'{HUMAN}/prepare_inverse_preconditioner.cu', None,
  (1,1,1),(256,1,1), ['ptr small 1024','ptr small 1024','ptr idx 1024 2','ptr zero 1024','u64 256','u64 256']),
 ('multiply_bonds', f'{HUMAN}/multiply_bonds.cu', None,
  (1,1,1),(256,1,1), ['ptr idx 2048 255','ptr idx 1024 2','ptr randf 9216','u32 256','ptr randf 3072','ptr zero 3072']),
 ('update_solution_and_residual', f'{HUMAN}/update_solution_and_residual.cu', None,
  (1,1,1),(256,1,1), ['u32 1','ptr randf 1024','ptr randf 1024','ptr randf 3072','ptr randf 3072','ptr randf 3072','ptr randf 3072','u64 256']),
 ('initialize_zero_solution_and_reduce', f'{HUMAN}/initialize_zero_solution_and_reduce.cu', None,
  (1,1,1),(256,1,1), ['ptr randf 3072','ptr randf 9216','ptr zero 3072','ptr zero 3072','ptr zero 1024','u64 256']),
 ('build_particle_aabbs', f'{HUMAN}/build_particle_aabbs.cu', None,
  (1,1,1),(256,1,1), ['ptr randf 3072','ptr idx 1024 255','ptr small 1024','ptr zero 6144','u64 256','u64 256','u64 256']),

 ('refresh_inertial_cache_diagonals', f'{HUMAN}/refresh_inertial_cache_diagonals.cu', None,
  (1,1,1),(256,1,1), ['ptr randf 2048','ptr idx64 4096','ptr idx 2048','ptr zero 1024','ptr zero 1024','u64 256']),
 ('update_cg_direction_blockjacobi', f'{HUMAN}/update_cg_direction_blockjacobi.cu',
  '_ZN7synreal6kernel19update_cg_directionIN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKT_PKNS2_3vecILi3EfLS4_0EEEPKfPSA_m',
  (1,1,1),(256,1,1), ['u32 1','ptr randf 9216','ptr randf 3072','ptr randf 1024','ptr randf 3072','u64 256']),
 ('update_solution_residual_and_reduce', f'{HUMAN}/update_solution_residual_and_reduce.cu', None,
  (1,1,1),(256,1,1), ['u32 1','ptr randf 1024','ptr randf 1024','ptr randf 3072','ptr randf 3072','ptr randf 9216','ptr randf 3072','ptr randf 3072','ptr zero 1024','u32 1','u64 256']),

 ('refresh_inertial_cache_nonzeros', f'{HUMAN}/refresh_inertial_cache_nonzeros.cu', None,
  (1,1,1),(256,1,1), ['ptr randf 2048','ptr idx64 4096','ptr idx 2048',
                      'ptr randf 2048','ptr idx64 4096','ptr idx 2048',
                      'ptr zero 2048','ptr zero 2048','u64 256']),

 ('scale_step', f'{HUMAN}/scale_step.cu', None,
  (1,1,1),(256,1,1), ['byval 1864','ptr randf 3072','ptr small 1024','u32 256']),
 ('commit_bonds', f'{HUMAN}/commit_bonds.cu', None,
  (1,1,1),(256,1,1), ['byval 1864','ptr randf 3072','ptr idx 2048 255','ptr small 1024','ptr small 1024','ptr idx 1024 2','u32 256']),
 ('build_escape_nodes', f'{HUMAN}/build_escape_nodes.cu', None,
  (1,1,1),(256,1,1), ['ptr zero 1024','ptr treeparent 1024','ptr treechildren 2048','u32 256']),

 ('multiply_matrix', f'{HUMAN}/multiply_matrix.cu', None,
  (1,1,1),(64,1,1), ['ptr idx 256 4','ptr pair 1536 64','u64 3','ptr small 256','ptr randf 768','ptr randf 768','ptr zero 768','u64 64','u64 64']),
 ('evaluate_residual', f'{HUMAN}/evaluate_residual.cu', None,
  (1,1,1),(64,1,1), ['ptr idx 256 4','ptr pair 1536 64','u64 3','ptr small 256','ptr randf 768','ptr randf 768','ptr randf 768','ptr zero 768','u64 64','u64 64']),
 ('multiply_matrix_and_reduce', f'{HUMAN}/multiply_matrix_and_reduce.cu', None,
  (1,1,1),(64,1,1), ['ptr idx 256 3','ptr block40 7680 64','u64 3','ptr randf 2304','ptr randf 768','ptr randf 768','ptr zero 768','ptr zero 256','u64 64','u64 64']),
 ('initialize_block_non_diagonal', f'{HUMAN}/initialize_block_non_diagonal.cu', None,
  (1,1,1),(64,1,1), ['ptr pair 512 8','ptr idx 256 2','u64 8','u64 8','ptr zero 2560','u64 32']),

 ('build_edge_aabbs', f'{HUMAN}/build_edge_aabbs.cu', None,
  (1,1,1),(256,1,1), ['ptr randf 3072','ptr idx 4096 255','ptr zero 6144','f32 0.05','u64 256','u64 256','u64 256']),
 ('initialize_rhs', f'{HUMAN}/initialize_rhs.cu', None,
  (1,1,1),(256,1,1), ['f32 0.016','ptr randf 3072','ptr randf 3072','ptr small 1024','ptr idx 256 4','ptr pair 1536 64','u64 3','ptr randf 768','ptr idx 1024 2','ptr zero 3072','u64 64','u64 64']),
 ('invert_block_preconditioner', f'{HUMAN}/invert_block_preconditioner.cu', None,
  (1,1,1),(256,1,1), ['ptr randf 9216','ptr small 1024','ptr idx 1024 2','ptr zero 9216','u64 256','u64 256']),

 ('apply_block_diagonal_preconditioner', f'{HUMAN}/apply_block_diagonal_preconditioner.cu', None,
  (1,1,1),(256,1,1), ['ptr randf 9216','ptr randf 3072','ptr zero 3072','u64 256']),
]

results=[]
for label, cu, mangled, grid, block, params in T:
    cubin, err = compile_cu(cu)
    if not cubin:
        results.append((label,'COMPILE_FAIL', err)); print(f'[skip] {label}: {err}'); continue
    name = cubin_kernel_name(cubin)
    if not name:
        results.append((label,'NO_SYMBOL','')); print(f'[skip] {label}: cubin 无 STT_FUNC'); continue
    ptx=f'{label}.ptx'
    if mangled is None:
        mangled = mangled_of(label)
        if not mangled:
            results.append((label,'PTX_MISS','')); print(f'[skip] {label}: 找不到 mangled 名'); continue
    try:
        open(ptx,'w').write(extract(mangled))
    except SystemExit:
        real=mangled_of(label)
        if not real:
            results.append((label,'PTX_MISS','')); print(f'[skip] {label}: PTX 名找不到'); continue
        mangled=real; open(ptx,'w').write(extract(mangled))
    spec=f'{label}.spec'
    with open(spec,'w') as f:
        f.write(f'label {label}\nptx {ptx}\ncubin {cubin}\nname_ptx {mangled}\nname_cubin {name}\n')
        f.write(f'grid {grid[0]} {grid[1]} {grid[2]}\nblock {block[0]} {block[1]} {block[2]}\n')
        for p in params: f.write(f'{p}\n')
    try:
        r=subprocess.run(['./ab',spec], capture_output=True, text=True, timeout=25)
    except subprocess.TimeoutExpired:
        subprocess.run(['pkill','-9','-x','ab'])
        results.append((label,'TIMEOUT','kernel 超时（可能死循环或访存越界）'))
        print(f'[TIMEOUT] {label}', flush=True)
        continue
    out=(r.stdout+r.stderr).strip().splitlines()
    tail=out[-1] if out else '(no output)'
    ok=('RESULT PASS' in tail) or ('RESULT PASS_TOL' in tail)
    st = 'PASS' if 'RESULT PASS ' in tail else ('PASS_TOL' if 'PASS_TOL' in tail else 'FAIL')
    results.append((label, st, tail))
    print(f'[{results[-1][1]}] {label}: {tail[:90]}', flush=True)

print('\n==== 汇总 ====')
for l,s,d in results: print(f'  {s:12s} {l}')
json.dump([{'kernel':l,'status':s,'detail':d} for l,s,d in results], open('results.json','w'), indent=1)
