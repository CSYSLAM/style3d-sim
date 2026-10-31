#!/usr/bin/env python3
"""Typed scenes for the remaining readable kernels; run original, human, or mechanical."""
import ctypes as C
import json
from pathlib import Path
import struct
import sys
import numpy as np
import review_algorithm_claims as core
from review_algorithm_claims import ROOT,META,GPU,F,I,u64,i32,f32,packmatrix

pair=np.dtype([('col','i4'),('val','f4')]);block=np.dtype([('col','i4'),('matrix','f4',(9,))])
manual={'add_diagonal_mat3':('fluid','add_diagonal'),
        'multiply_matrix':('pcg_solver','multiply_matrix<NonZeroEntry, float>'),
        'evaluate_residual':('pcg_solver','evaluate_residual<NonZeroEntry, float>'),
        'multiply_matrix_and_reduce':('pcg_solver','multiply_matrix_and_reduce<256u, BlockNonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >'),
        'initialize_zero_solution_and_reduce':('pcg_solver','initialize_zero_solution_and_reduce<256u, glm::mat<3, 3, float, (glm::qualifier)0> >'),
        'update_cg_direction_blockjacobi':('pcg_solver','update_cg_direction<glm::mat<3, 3, float, (glm::qualifier)0> >')}
registry={}
for path in sorted((ROOT/'recover/human').glob('*.cu'))+sorted((ROOT/'reconstructed').glob('*.cu')):
    name=path.stem
    if name in manual:key=manual[name]
    else:
        matches=[m for m in META if m['disp'].split('<')[0]==name and '_kernel_agent' not in m['pretty']]
        if len(matches)>1:
            matches=[m for m in matches if m['cu']=='lbvh_builder.cu']
        assert len(matches)==1,(name,[m['disp'] for m in matches])
        m=matches[0];key=(m['cu'].removesuffix('.cu'),m['disp'])
    registry[name]=key;core.HUMAN[key]=str(path.relative_to(ROOT))


def main():
    mode=sys.argv[1] if len(sys.argv)>1 else 'original';assert mode in ['original','human','mechanical']
    gpu=GPU(human=mode=='human',mechanical=mode=='mechanical');rng=np.random.default_rng(20261028);rows=[]
    def run(name,args,n=1):gpu.run(*registry[name],args,n)
    def check(name,got,expected):
        a=np.asarray(got);b=np.asarray(expected)
        if a.dtype.fields:
            for field in a.dtype.names:check(name+'/'+field,a[field],b[field])
            return
        finite=np.isfinite(a)&np.isfinite(b)
        # Non-finite outcomes are checked by classification, separately from tolerance.
        same_special=np.array_equal(np.isnan(a),np.isnan(b)) and np.array_equal(np.isposinf(a),np.isposinf(b)) and np.array_equal(np.isneginf(a),np.isneginf(b))
        ok=a.shape==b.shape and same_special
        if np.issubdtype(a.dtype,np.integer):ok=ok and np.array_equal(a,b)
        else:ok=ok and np.allclose(a[finite],b[finite],rtol=5e-5,atol=5e-6)
        row=dict(case=name,kernel=gpu.last_kernel,pass_=bool(ok),max_abs_error=float(np.max(np.abs(a[finite].astype(float)-b[finite]))) if np.any(finite) else None)
        if not ok:row.update(actual=a.tolist(),expected=b.tolist())
        rows.append(row)
    for trial in range(4):
        n=17;x=F(rng.normal(size=(n,3)));y=F(rng.normal(size=(n,3)));mat=F(rng.normal(size=(n,3,3)));packed=F([packmatrix(m) for m in mat]);s=.7
        out=gpu.d(F([-9]*(n+3)));run('initialize_scale',[out,f32(s),i32(n)],n);check(f'scale/{trial}',out.read(),F([s]*n+[-9]*3))
        out=gpu.d(np.zeros_like(x));run('update_velocity',[f32(s),gpu.d(x),gpu.d(y),out,u64(n)],n);check(f'velocity/{trial}',out.read(),s*(y-x))
        out=gpu.d(np.zeros_like(x));delta=gpu.d(y);run('apply_nonlinear_step',[gpu.d(x),out,delta,u64(n)],n);check(f'step/{trial}',out.read(),x+y);check(f'step_clear/{trial}',delta.read(),np.zeros_like(x))
        for name in ['add_diagonal_mat3','add_hessian_diagonal']:
            old=F(rng.normal(size=(n,9)));out=gpu.d(old);run(name,[gpu.d(packed),out,i32(n) if name=='add_diagonal_mat3' else u64(n)],n);check(name+f'/{trial}',out.read(),old+packed)
        for name in ['multiply_hessian_diagonal','apply_block_diagonal_preconditioner']:
            out=gpu.d(y);run(name,[gpu.d(packed),gpu.d(x),out,u64(n)],n);check(name+f'/{trial}',out.read(),np.einsum('nij,nj->ni',mat,x)+(y if name=='multiply_hessian_diagonal' else 0))
        out=gpu.d(x);run('initialize_joint_body_spring_state',[out,u64(n)],n);check(f'joint_zero/{trial}',out.read(),np.zeros_like(x))
        mask=I(rng.integers(-1,2,n));old=I(rng.integers(3,99,n));out=gpu.d(old);run('reset_selected_joint_drive_state',[gpu.d(mask),out,u64(n)],n);check(f'joint_mask/{trial}',out.read(),np.where(mask!=0,0,old))
        ids=I(rng.permutation(n));out=gpu.d(I([-1]*n));run('build_primitive_leaf_nodes',[out,gpu.d(ids),C.c_uint(n)],n);expected=I([0]*n);expected[ids]=np.arange(n)+n-1;check(f'leaf/{trial}',out.read(),expected)
        # Several CSR lengths exercise the remainder and unrolled paths.
        ptr=np.array([0,0,1,3,6,10,15],np.uint64);idx=I(rng.integers(0,n,15));values=F(rng.normal(size=n));sums=F([sum(values[idx[ptr[i]:ptr[i+1]]]) for i in range(6)])
        o1=gpu.d(F([7]*6));o2=gpu.d(F([8]*6));run('refresh_inertial_cache_diagonals',[gpu.d(values),gpu.d(ptr),gpu.d(idx),o1,o2,u64(6)],6);check(f'csr_diag/{trial}',o1.read(),np.where(np.diff(ptr)==0,7,3*sums));check(f'csr_sum/{trial}',o2.read(),np.where(np.diff(ptr)==0,8,sums))
        old=np.zeros(6,pair);old['col']=np.arange(6)+10;old['val']=13;o1=gpu.d(old);o2=gpu.d(old)
        run('refresh_inertial_cache_nonzeros',[gpu.d(values),gpu.d(ptr),gpu.d(idx),gpu.d(values*2),gpu.d(ptr),gpu.d(idx),o1,o2,u64(6)],6)
        e1=old.copy();e2=old.copy();e1['val']=np.where(np.diff(ptr)==0,13,sums);e2['val']=np.where(np.diff(ptr)==0,13,-2*sums);check(f'csr_nonzero_a/{trial}',o1.read(),e1);check(f'csr_nonzero_b/{trial}',o2.read(),e2)
        # Existing columns are preserved in the aligned seven-way combination.
        arrays=[]
        for j in range(7):
            a=np.zeros(n,pair);a['col']=np.arange(n)+j;a['val']=F(rng.normal(size=n));arrays.append(a)
        coeff=F([.2,-.3,.4,-.5,.6,-.7]);expected=arrays[0].copy();expected['val']=arrays[0]['val']+coeff[0]*(arrays[1]['val']+sum(coeff[j]*arrays[j+1]['val'] for j in range(1,6)))
        out=gpu.d(np.zeros(n,pair));run('combine_system_non_diagonal',[*[f32(c) for c in coeff],*[gpu.d(a) for a in arrays],out,u64(n)],n);check(f'combine/{trial}',out.read(),expected)
        diag=F(rng.uniform(.1,3,n));o1=gpu.d(np.zeros((n,9),np.float32));o2=gpu.d(np.zeros((n,9),np.float32));run('initialize_block_diagonal',[gpu.d(diag),o1,o2 if trial%2 else C.c_uint64(0),u64(n)],n);expected=F([packmatrix(v*np.eye(3)) for v in diag]);check(f'init_diag/{trial}',o1.read(),expected)
        if trial%2:check(f'init_diag_copy/{trial}',o2.read(),expected)
        vals=F([2.,0.,-1.,3.,4.,5.]);sc=F([1.,1.,1.]);mk=I([1,0,3]);out=gpu.d(np.zeros(6,np.float32));run('prepare_inverse_preconditioner',[gpu.d(vals),gpu.d(sc),gpu.d(mk) if trial%2 else C.c_uint64(0),out,u64(6),u64(3)],6)
        expected=F([1/v if v>0 and (not trial%2 or mk[i%3]&1) else 0 for i,v in enumerate(vals)]);check(f'inv_scalar/{trial}',out.read(),expected)
        # AABB template indices and radii are shared, coordinates are per world.
        positions=F(rng.normal(size=(10,3)));ids=I([3,1]);radii=F([.1,.2,.3,.4,.5]);out=gpu.d(np.zeros((4,6),np.float32));run('build_particle_aabbs',[gpu.d(positions),gpu.d(ids),gpu.d(radii),out,u64(4),u64(2),u64(5)],4)
        expected=F([np.r_[positions[(i//2)*5+ids[i%2]]-radii[ids[i%2]],positions[(i//2)*5+ids[i%2]]+radii[ids[i%2]]] for i in range(4)]);check(f'particle_box/{trial}',out.read(),expected)
        edges=I([[4,3,0,1],[4,0,2,3]]);out=gpu.d(np.zeros((4,6),np.float32));run('build_edge_aabbs',[gpu.d(positions),gpu.d(edges),out,f32(.07),u64(4),u64(2),u64(5)],4)
        expected=[]
        for i in range(4):
            a,b=positions[edges[i%2,2:]+i//2*5];expected.append(np.r_[np.minimum(a,b)-.07,np.maximum(a,b)+.07])
        check(f'edge_box/{trial}',out.read(),expected)
        # Three-node full tree. Both leaf/right ascent and root exit paths.
        out=gpu.d(I([88]*3));run('build_escape_nodes',[out,gpu.d(I([-1,0,0])),gpu.d(I([[1,2],[-1,-1],[-1,-1]])),C.c_uint(3)],3);check(f'escape/{trial}',out.read(),I([-1,2,-1]))
        # Three-point drag contribution replicated into two independent worlds.
        normals=F([[.2,.6,.8],[-.7,.1,.3]]);weights=F([.4,.8]);out=gpu.d(np.zeros((8,9),np.float32));run('add_triangle_drag_preconditioner',[gpu.d(I([[0,1,2]])),gpu.d(normals),gpu.d(weights),out,u64(2),u64(1),u64(4)],2)
        expected=np.zeros((8,9),np.float32)
        for i in range(2):expected[4*i:4*i+3]=packmatrix(weights[i]*np.outer(normals[i],normals[i]))
        check(f'drag_diag/{trial}',out.read(),expected)
        # Pair force application checks activity and transpose conventions.
        pairs=I([[0,1],[1,2],[2,3]]);active=I([1,0,1]);old=F(rng.normal(size=(4,3)));out=gpu.d(old);expect=old.astype(float)
        for j,(a,b) in enumerate(pairs):
            if active[j]:q=mat[j]@(x[a]-x[b]);expect[a]+=q;expect[b]-=q
        run('multiply_bonds',[gpu.d(pairs),gpu.d(active),gpu.d(packed[:3]),i32(3),gpu.d(x[:4]),out],3);check(f'bond_product/{trial}',out.read(),expect)
    # ELL template expansion: max_nnz is an actual launch upper bound.
    tile=3;group=6;maximum=2;entries=np.zeros(tile*maximum,pair);entries['col']=[1,2,0,2,0,1];entries['val']=[.1,.2,.3,.4,.5,.6];nnz=I([1,2,0]);old=np.zeros(256,block);old['col']=-77;old['matrix']=19;expected=old.copy()
    for i in range(group*maximum):
        e=i//group;mid=i%group;row=mid%tile
        if e<nnz[row]:expected[i]['col']=entries[e*tile+row]['col']+mid-row;expected[i]['matrix']=packmatrix(entries[e*tile+row]['val']*np.eye(3))
    out=gpu.d(old);run('initialize_block_non_diagonal',[gpu.d(entries),gpu.d(nnz),u64(tile),u64(maximum),out,u64(group)],group*maximum);check('ell_expand',out.read(),expected)
    # Shared topology with partial final tile, invalid columns and count clamping.
    for trial in range(4):
        tile=7;n=300;maximum=3;nnz=I([3,2,0,-1,5,1,3]);es=np.zeros(tile*maximum,pair);es['col']=rng.integers(-1,tile+1,len(es));es['val']=F(rng.normal(size=len(es))*.2)
        x=F(rng.normal(size=(n,3)));rhs=F(rng.normal(size=(n,3)));extra=F(rng.normal(size=(n,3)));diag=F(rng.uniform(1,3,n));mats=F(rng.normal(size=(n,3,3)));bs=np.zeros(tile*maximum,block);bs['col']=es['col'];bs['matrix']=F([packmatrix(m) for m in rng.normal(size=(len(bs),3,3))*.2])
        prod=diag[:,None]*x;bprod=np.einsum('nij,nj->ni',mats,x)
        for i in range(n):
            row=i%tile;base=i-row
            for e in range(max(0,min(maximum,nnz[row]))):
                entry=es[e*tile+row];col=int(entry['col']);j=base+col
                if 0<=col<tile and j<n:
                    prod[i]+=entry['val']*x[j];bprod[i]+=bs[e*tile+row]['matrix'].reshape(3,3).T@x[j]
        out=gpu.d(np.zeros_like(x));use_extra=trial%2
        run('multiply_matrix',[gpu.d(nnz),gpu.d(es),u64(maximum),gpu.d(diag),gpu.d(x),gpu.d(extra) if use_extra else C.c_uint64(0),out,u64(n),u64(tile)],n);check(f'ell_product/{trial}',out.read(),prod+(extra if use_extra else 0))
        out=gpu.d(np.zeros_like(x));run('evaluate_residual',[gpu.d(nnz),gpu.d(es),u64(maximum),gpu.d(diag),gpu.d(x),gpu.d(rhs),gpu.d(extra) if use_extra else C.c_uint64(0),out,u64(n),u64(tile)],n);check(f'ell_residual/{trial}',out.read(),rhs-prod-(extra if use_extra else 0))
        out=gpu.d(np.zeros_like(x));red=gpu.d(F([0,0]));run('multiply_matrix_and_reduce',[gpu.d(nnz),gpu.d(bs),u64(maximum),gpu.d(F([packmatrix(m) for m in mats])),gpu.d(x),gpu.d(extra),out,red,u64(n),u64(tile)],n);expect=bprod+extra;check(f'ell_fused/{trial}',out.read(),expect);check(f'ell_reduce/{trial}',red.read(),[np.sum(x[:256]*expect[:256]),np.sum(x[256:]*expect[256:])])
        a=gpu.d(np.zeros_like(x));b=gpu.d(np.ones_like(x));red=gpu.d(F([0,0]));run('initialize_zero_solution_and_reduce',[gpu.d(x),gpu.d(F([packmatrix(m) for m in mats])),a,b,red,u64(n)],n);check(f'init_cg_copy/{trial}',a.read(),x);check(f'init_cg_zero/{trial}',b.read(),np.zeros_like(x));q=np.einsum('ni,nij,nj->n',x,mats,x);check(f'init_cg_reduce/{trial}',red.read(),[sum(q[:256]),sum(q[256:])])
        # RHS has template mass, active bit mask, and optional applied force.
        mass=F([2,0,-1,3,4,5,6]);mask=I([1,1,1,0,3,1,0]);previous=F(rng.normal(size=(n,3)));current=x;dx=current-previous;expected=np.zeros_like(x)
        for i in range(n):
            row=i%tile;base=i-row
            if mass[row]<=0 or not mask[row]&1:continue
            v=mass[row]*dx[i]
            for e in range(max(0,min(maximum,nnz[row]))):
                en=es[e*tile+row];col=int(en['col']);j=base+col
                if 0<=col<tile and j<n:v+=en['val']*dx[j]
            expected[i]=.4*v+(extra[i] if use_extra else 0)
        out=gpu.d(np.zeros_like(x));run('initialize_rhs',[f32(.4),gpu.d(previous),gpu.d(current),gpu.d(mass),gpu.d(nnz),gpu.d(es),u64(maximum),gpu.d(extra) if use_extra else C.c_uint64(0),gpu.d(mask),out,u64(n),u64(tile)],n);check(f'rhs/{trial}',out.read(),expected)
    # max_nnz=0 skips sparse buffers; tile=0 uses row=gid and rejects every column.
    for empty in ['zero_capacity','zero_tile']:
        n=17;x=F(rng.normal(size=(n,3)));diag=F(rng.uniform(1,2,n));rhs=F(rng.normal(size=(n,3)))
        nnz=C.c_uint64(0) if empty=='zero_capacity' else gpu.d(I([1]*n))
        maximum=0 if empty=='zero_capacity' else 1;tile=0
        es=np.zeros(n,pair);es['col']=0;bs=np.zeros(n,block);bs['col']=0
        out=gpu.d(np.zeros_like(x));run('multiply_matrix',[nnz,gpu.d(es),u64(maximum),gpu.d(diag),gpu.d(x),C.c_uint64(0),out,u64(n),u64(tile)],n);check('empty_product/'+empty,out.read(),diag[:,None]*x)
        out=gpu.d(np.zeros_like(x));run('evaluate_residual',[nnz,gpu.d(es),u64(maximum),gpu.d(diag),gpu.d(x),gpu.d(rhs),C.c_uint64(0),out,u64(n),u64(tile)],n);check('empty_residual/'+empty,out.read(),rhs-diag[:,None]*x)
        out=gpu.d(np.zeros_like(x));red=gpu.d(F([0]));mats=F([packmatrix(d*np.eye(3)) for d in diag]);run('multiply_matrix_and_reduce',[nnz,gpu.d(bs),u64(maximum),gpu.d(mats),gpu.d(x),C.c_uint64(0),out,red,u64(n),u64(tile)],n);check('empty_fused/'+empty,out.read(),diag[:,None]*x);check('empty_reduce/'+empty,red.read(),[np.sum(diag[:,None]*x*x)])
    out=gpu.d(np.zeros_like(x));run('initialize_rhs',[f32(.4),gpu.d(np.zeros_like(x)),gpu.d(x),gpu.d(diag),C.c_uint64(0),C.c_uint64(0),u64(0),C.c_uint64(0),C.c_uint64(0),out,u64(n),u64(n)],n);check('rhs_without_sparse',out.read(),.4*diag[:,None]*x)
    for kind in ['replicated','world_map','default']:
        n=6;model=bytearray(1864);scale=F([.5,.25,.125]);world=I([1,0,-1,2,1,2]);dw=gpu.d(world);struct.pack_into('<II',model,24,2 if kind=='replicated' else n,n)
        if kind=='world_map':struct.pack_into('<QQ',model,120,dw.ptr.value,n)
        x=F(rng.normal(size=(n,3)));out=gpu.d(x);run('scale_step',[model,out,gpu.d(scale),i32(n)],n);index=np.arange(n)//2 if kind=='replicated' else np.maximum(world,0) if kind=='world_map' else np.zeros(n,np.int32);check('world_scale/'+kind,out.read(),x*scale[index,None])
    report=dict(mode=mode,entries=gpu.entries,checks=rows,passed=sum(r['pass_'] for r in rows),failed=sum(not r['pass_'] for r in rows));gpu.close()
    (ROOT/f'validate/readable_{mode}_results.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    print(f'mode={mode} entries={len(report["entries"])} checks={len(rows)} passed={report["passed"]} failed={report["failed"]}')
    for row in rows:
        if not row['pass_']:print(row['case'],row['max_abs_error'])
    return bool(report['failed'])


if __name__=='__main__':raise SystemExit(main())
