#!/usr/bin/env python3
"""Independent document-formula checks against PTX freshly extracted from the binary.
No import of ptx2c.py, human reconstructions, mkjit.py, or the old A/B harness.
Requires numpy, cuobjdump and a CUDA GPU. Writes review_algorithm_results.json.
Run: python3 validate/review_algorithm_claims.py
Optional --human compiles seven readable CUDA implementations with nvcc, uses
them for the same cases, and writes review_algorithm_human_results.json.
"""
import ctypes as C
import hashlib
import json
from pathlib import Path
import shutil
import struct
import subprocess
import re
import sys
import tempfile
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
BINARY=ROOT.parent/'_core.cpython-312-x86_64-linux-gnu.so'
META=json.loads((ROOT/'kernels.json').read_text())
F=lambda x: np.asarray(x,dtype=np.float32)
I=lambda x: np.asarray(x,dtype=np.int32)
u64=C.c_uint64
i32=C.c_int32
f32=C.c_float
HUMAN={
    ('solver_newton','evaluate_spring_force'):'reconstructed/evaluate_spring_force.cu',
    ('solver_newton','invert_block_preconditioner'):'recover/human/invert_block_preconditioner.cu',
    ('granular','commit_bonds'):'recover/human/commit_bonds.cu',
    ('pcg_solver','update_solution_and_residual'):'recover/human/update_solution_and_residual.cu',
    ('pcg_solver','update_preconditioned_cg_direction'):'recover/human/update_preconditioned_cg_direction.cu',
    ('pcg_solver','update_cg_direction<glm::mat<3, 3, float, (glm::qualifier)0> >'):'recover/human/update_cg_direction_blockjacobi.cu',
    ('pcg_solver','update_solution_residual_and_reduce<256u, glm::mat<3, 3, float, (glm::qualifier)0> >'):'recover/human/update_solution_residual_and_reduce.cu',
}

def packmatrix(x): return F(x).T.copy().reshape(-1)
def sym(x): return (x+x.T)*.5

class Device:
    def __init__(self, gpu, arr):
        self.a=np.ascontiguousarray(arr)
        self.ptr=C.c_uint64()
        gpu.ck(gpu.lib.cuMemAlloc_v2(C.byref(self.ptr),C.c_size_t(self.a.nbytes)))
        gpu.ck(gpu.lib.cuMemcpyHtoD_v2(self.ptr,C.c_void_p(self.a.ctypes.data),C.c_size_t(self.a.nbytes)))
        gpu.allocs.append(self.ptr)
        self.gpu=gpu
    def read(self):
        out=np.empty_like(self.a)
        self.gpu.ck(self.gpu.lib.cuMemcpyDtoH_v2(C.c_void_p(out.ctypes.data),self.ptr,C.c_size_t(out.nbytes)))
        return out

class GPU:
    def __init__(self,human=False,mechanical=False):
        self.human=human
        self.mechanical=mechanical
        self.raw=subprocess.check_output([shutil.which('cuobjdump') or '/usr/local/cuda/bin/cuobjdump','-ptx',str(BINARY)],text=True)
        self.lib=C.CDLL('libcuda.so.1'); self.allocs=[]; self.modules={}; self.entries={}
        self.ck(self.lib.cuInit(0)); dev=C.c_int();self.ck(self.lib.cuDeviceGet(C.byref(dev),0))
        self.ctx=C.c_void_p(); self.ck(self.lib.cuCtxCreate_v2(C.byref(self.ctx),0,dev))
    def ck(self,code):
        if code:
            msg=C.c_char_p();self.lib.cuGetErrorString(code,C.byref(msg))
            raise RuntimeError(f'CUDA {code}: {msg.value}')
    def d(self,a):return Device(self,a)
    def entry(self,mod,name):
        key=(mod,name)
        if key in self.modules:return self.modules[key][1]
        choices=[k for k in META if k['cu']==mod+'.cu' and k['disp']==name]
        assert len(choices)==1,key
        k=choices[0];mangled=k['mangled'];start=self.raw.index('.visible .entry '+mangled+'(')
        b=self.raw.index('{',start);depth=0
        for e in range(b,len(self.raw)):
            if self.raw[e]=='{':depth+=1
            elif self.raw[e]=='}':
                depth-=1
                if depth==0:break
        entry=self.raw[start:e+1]
        local=(ROOT/k['file'].removeprefix('_re_analysis/')).read_text()
        # Compare complete extracted entry, ignoring whitespace and split-file comments.
        local=local[local.index(mangled+'('):];local=local[:local.rfind('}')+1]
        normalized=lambda s: ''.join(s.replace('.visible .entry ','').split())
        assert normalized(entry)==normalized(local),f'PTX snapshot differs: {key}'
        data=('.version 8.4\n.target sm_52\n.address_size 64\n'+entry).encode()
        provenance={'implementation':'original_binary_ptx'}
        if self.mechanical or (self.human and key in HUMAN):
            if self.mechanical:
                import importlib.util
                spec=importlib.util.spec_from_file_location('ptx2c',ROOT/'recover/ptx2c.py');translator=importlib.util.module_from_spec(spec);spec.loader.exec_module(translator)
                source=ROOT/'recover/src'/mod/(translator.symbol_name(translator.parse(ROOT/k['file'].removeprefix('_re_analysis/')))+'.cu')
            else:source=ROOT/HUMAN[key]
            with tempfile.TemporaryDirectory(prefix='style3d-formula-') as tmp:
                compiled=Path(tmp)/'kernel.ptx'
                subprocess.run([shutil.which('nvcc') or '/usr/local/cuda/bin/nvcc','-ptx','-arch=compute_52','-std=c++14','-Wno-deprecated-gpu-targets','-diag-suppress=177','-I',str(ROOT/'recover'),str(source),'-o',str(compiled)],check=True,capture_output=True)
                data=compiled.read_bytes()
            symbols=re.findall(rb'\.visible\s+\.entry\s+(\w+)\s*\(',data)
            assert len(symbols)==1,source
            mangled=symbols[0].decode()
            provenance={'implementation':'mechanical_cuda' if self.mechanical else 'readable_cuda','source':str(source.relative_to(ROOT)),'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest()}
        module=C.c_void_p();buf=C.create_string_buffer(data)
        self.ck(self.lib.cuModuleLoadDataEx(C.byref(module),C.cast(buf,C.c_void_p),0,None,None))
        fun=C.c_void_p();self.ck(self.lib.cuModuleGetFunction(C.byref(fun),module,mangled.encode()))
        self.modules[key]=(module,fun)
        self.entries[mod+'/'+name]={'ptx_file':k['file'].removeprefix('_re_analysis/'),'entry_sha256':hashlib.sha256(entry.encode()).hexdigest(),'fresh_binary_matches_snapshot':True,**provenance}
        return fun
    def run(self,mod,name,args,n=1,block_size=256):
        converted=[]
        for a in args:
            if isinstance(a,Device): converted.append(a.ptr)
            elif isinstance(a,(bytes,bytearray)):converted.append(C.create_string_buffer(bytes(a)))
            else:converted.append(a)
        params=(C.c_void_p*len(args))(*[C.addressof(a) for a in converted])
        entry=self.entry(mod,name)
        self.last_kernel=mod+'/'+name
        self.last_impl=self.entries[self.last_kernel]['implementation']
        self.ck(self.lib.cuLaunchKernel(entry,(n+block_size-1)//block_size,1,1,block_size,1,1,0,None,params,None))
        self.ck(self.lib.cuCtxSynchronize())
    def close(self):
        for p in self.allocs:self.ck(self.lib.cuMemFree_v2(p))
        for m,f in self.modules.values():self.ck(self.lib.cuModuleUnload(m))
        self.ck(self.lib.cuCtxDestroy_v2(self.ctx))

def main():
    human='--human' in sys.argv
    mechanical='--mechanical' in sys.argv
    gpu=GPU(human=human,mechanical=mechanical);rows=[];rng=np.random.default_rng(20261027)
    def check(name,got,expected,rtol=4e-5,atol=3e-6):
        g=np.asarray(got);e=np.asarray(expected)
        ok=g.shape==e.shape and np.all(np.isfinite(g)) and np.all(np.isfinite(e)) and np.allclose(g,e,rtol=rtol,atol=atol,equal_nan=False)
        err=float(np.max(np.abs(g.astype(float)-e.astype(float)))) if np.all(np.isfinite(g)) and np.all(np.isfinite(e)) else None
        row={'case':name,'kernel':gpu.last_kernel,'implementation':gpu.last_impl,'pass':bool(ok),'max_abs_error':err,'rtol':rtol,'atol':atol}
        if not ok:row.update(actual=g.tolist(),expected=e.tolist())
        rows.append(row)
    # Random valid, non-identity layouts; each kernel receives correctly typed, independent storage.
    for trial in range(12):
        x=F(rng.normal(size=(4,3)));xref=F(x+.1*rng.normal(size=x.shape));scale=2.3
        # Spring: total, per-world count, coordinate stride (not the old hand file's order).
        k=F([2.4]);rest=F([.8]);out=gpu.d(np.zeros((4,3),np.float32))
        gpu.run('solver_newton','evaluate_spring_force',[gpu.d(x),gpu.d(I([[0,1]])),gpu.d(k),gpu.d(rest),out,u64(1),u64(1),u64(4)])
        d=x[1].astype(float)-x[0];ff=float(k[0])*(d-float(rest[0])*d/np.linalg.norm(d));expected=np.zeros((4,3));expected[0]=ff;expected[1]=-ff
        check(f'spring/{trial}',out.read(),expected)
        # Membrane: explicit byte layout B00,B01,B10,B11 as used by PTX.
        bm=F([1.1,.2,-.15,.9]);u=np.array([-bm[0]-bm[2],bm[0],bm[2]],float);v=np.array([-bm[1]-bm[3],bm[1],bm[3]],float)
        a=u@x[:3];b=v@x[:3];la=np.linalg.norm(a);lb=np.linalg.norm(b);lea=np.sqrt(a@a+1e-12);leb=np.sqrt(b@b+1e-12);aa=a/lea;bb=b/leb;shear=aa@bb;ks=F([2.,3.,.7]);area=.8
        ga=u[:,None]*a/la;gb=v[:,None]*b/lb;gs=u[:,None]*(bb-shear*aa)/lea+v[:,None]*(aa-shear*bb)/leb
        expect=-area*(ks[0]*(la-1)*ga+ks[1]*(lb-1)*gb+ks[2]*shear*gs)
        out=gpu.d(np.zeros((3,3),np.float32))
        gpu.run('solver_newton','evaluate_stretch_force',[gpu.d(x[:3]),gpu.d(F([area])),gpu.d(bm),gpu.d(I([[0,1,2]])),gpu.d(ks),out,u64(1),u64(1),u64(3)])
        check(f'membrane/{trial}',out.read(),expect)
        # Bending, including its directional damping.
        cot=F([.7,-.2,.4,.9]);w=np.array([-cot[0]-cot[2],-cot[1]-cot[3],cot[2]+cot[3],cot[0]+cot[1]],float)
        q=w@x;qref=w@xref;unit=q/np.linalg.norm(q);kb=.7;kd=.2;ar=1.3
        expect=w[:,None]*(-3*kb/ar*q-3*kd/ar*unit*(unit@(scale*(q-qref))))
        out=gpu.d(np.zeros((4,3),np.float32))
        gpu.run('solver_newton','evaluate_bending_force',[gpu.d(x),gpu.d(xref),gpu.d(F([ar])),gpu.d(cot),gpu.d(I([[0,1,2,3]])),gpu.d(F([kb,kd])),f32(scale),out,u64(1),u64(1),u64(4)])
        check(f'bending/{trial}',out.read(),expect)
        # Tetrahedron with nontrivial inverse-rest data, activation, and damping.
        B=F([[1.1,.1,-.05],[.2,.9,.07],[.03,-.08,1.2]]);G=np.vstack([-B.sum(axis=0),B]).astype(float)
        f=x.T@G;fr=xref.T@G;mu=2.;lam=5.;kd=.12;vol=.4;act=.04
        cof=np.column_stack([np.cross(f[:,1],f[:,2]),np.cross(f[:,2],f[:,0]),np.cross(f[:,0],f[:,1])]);stress=mu*f+(mu+lam)*(np.linalg.det(f)-(1+mu/(mu+lam))+act)*cof
        Q=scale*(f.T@f-fr.T@fr);expect=-vol*(G@stress.T)-2*vol*kd*(G@(f@Q).T)
        out=gpu.d(np.zeros((4,3),np.float32))
        gpu.run('solver_newton','evaluate_tetrahedron_force',[gpu.d(x),gpu.d(xref),gpu.d(I([[0,1,2,3]])),gpu.d(B.reshape(-1)),gpu.d(F([mu,lam,kd])),gpu.d(F([vol])),gpu.d(F([act])),f32(scale),out,u64(1),u64(1),u64(4)])
        check(f'tetrahedron/{trial}',out.read(),expect,rtol=8e-5,atol=2e-5)
        # SO3 force with non-identity rotations.
        R=F(np.linalg.qr(rng.normal(size=(3,3)))[0]);U=F(rng.normal(size=(3,3))*.1);A=x[1:].T.astype(float);kap=3.2
        expect=np.zeros((4,3));expect[1:]=(-kap*R@sym(R.T@(A-R+U))).T
        out=gpu.d(np.zeros((4,3),np.float32))
        gpu.run('solver_newton','evaluate_affine_body_so3_augmented_lagrangian_force',[gpu.d(x),gpu.d(I([[0,1,2,3]])),gpu.d(F([kap])),gpu.d(packmatrix(R)),gpu.d(packmatrix(U)),f32(1),out,u64(1),u64(1),u64(4)])
        check(f'so3_force/{trial}',out.read(),expect)
        # Drag: test a non-axis aligned normal and nonzero wind.
        normal=F(rng.normal(size=3));normal=F(normal/np.linalg.norm(normal));wind=F([.2,-.3,.1]);rho=1.225;cd=.8;area=1.3
        vn=(scale*(x[:3]-xref[:3]).astype(float).mean(axis=0)-wind)@normal
        expect=np.tile(-rho*cd*area/6*vn*abs(vn)*normal,(3,1));wgt=rho*cd*area*abs(vn)*scale/9
        out=gpu.d(np.zeros((3,3),np.float32));weight=gpu.d(F([0]))
        gpu.run('solver_newton','evaluate_triangle_drag',[gpu.d(x[:3]),gpu.d(xref[:3]),gpu.d(I([[0,1,2]])),gpu.d(F([cd])),gpu.d(normal),gpu.d(F([area])),f32(rho),wind.tobytes(),f32(scale),out,weight,u64(1),u64(1),u64(3)])
        check(f'drag_force/{trial}',out.read(),expect);check(f'drag_tangent_weight/{trial}',weight.read(),[wgt])
    # Distinct world count and coordinate stride check the actual trailing ABI order.
    x=F([[0,0,0],[2,0,0],[8,8,8],[0,0,0],[0,.5,0],[9,9,9]])
    out=gpu.d(np.zeros((6,3),np.float32))
    gpu.run('solver_newton','evaluate_spring_force',[gpu.d(x),gpu.d(I([[0,1]])),gpu.d(F([2.])),gpu.d(F([1.])),out,u64(2),u64(1),u64(3)],2)
    check('spring/multiworld',out.read(),[[2,0,0],[-2,0,0],[0,0,0],[0,-1,0],[0,1,0],[0,0,0]])
    # The Hessian assembly kernels add a delta relative to an isotropic baseline.
    # Check diagonal and all off-diagonal entries, with the actual ELL byte layout.
    entry_dtype=np.dtype([('col',np.int32),('matrix',np.float32,(9,))])
    def ell_storage(n):
        entries=np.zeros(n*(n-1),entry_dtype)
        for i in range(n):
            for e,j in enumerate(j for j in range(n) if j!=i):entries[e*n+i]['col']=j
        return entries
    def check_blocks(tag,diag,entries,expected,n):
        check(tag+'/diagonal',diag.read(),np.array([packmatrix(expected[i,i]) for i in range(n)]))
        got=entries.read()
        for i in range(n):
            for e,j in enumerate(j for j in range(n) if j!=i):
                check(f'{tag}/offdiag_{i}_{j}',got[e*n+i]['matrix'],packmatrix(expected[i,j]))
    def stabilized(v,target):
        length=np.linalg.norm(v)
        if length<=1e-8:return np.eye(3)
        nn=np.outer(v,v)/(length*length)
        return nn+max(0,1-target/length)*(np.eye(3)-nn)
    for trial,length in enumerate([0.,.5,1.,2.]):
        d=np.array([1.,2.,-1.]);d*=length/np.linalg.norm(d);x=F([[0,0,0],d]);k=2.
        delta=k*(stabilized(x[1].astype(float),1.)-np.eye(3))
        expected=np.array([[delta,-delta],[-delta,delta]])
        diag=gpu.d(np.zeros((2,9),np.float32));entries=gpu.d(ell_storage(2))
        gpu.run('solver_newton','add_spring_gauss_newton_hessian',[gpu.d(x),gpu.d(I([[0,1]])),gpu.d(F([k])),gpu.d(F([1.])),diag,gpu.d(I([1,1])),entries,u64(1),u64(1),u64(1),u64(2),u64(2)])
        check_blocks(f'spring_delta/{trial}',diag,entries,expected,2)
    for trial in range(12):
        x=F(rng.normal(size=(3,3)));bm=F([1.1,.2,-.15,.9]);u=np.array([-bm[0]-bm[2],bm[0],bm[2]],float);v=np.array([-bm[1]-bm[3],bm[1],bm[3]],float)
        a=u@x;b=v@x;la=np.sqrt(a@a+1e-12);lb=np.sqrt(b@b+1e-12);aa=a/la;bb=b/lb;cs=aa@bb
        gs=u[:,None]*(bb-cs*aa)/la+v[:,None]*(aa-cs*bb)/lb
        ku,kv,ks=2.,3.,.7;area=.8;qa=stabilized(a,1.);qb=stabilized(b,1.)
        expected=np.zeros((3,3,3,3))
        for i in range(3):
            for j in range(3):
                expected[i,j]=area*(ku*u[i]*u[j]*qa+kv*v[i]*v[j]*qb+ks*np.outer(gs[i],gs[j])-((ku+ks)*u[i]*u[j]+(kv+ks)*v[i]*v[j])*np.eye(3))
        diag=gpu.d(np.zeros((3,9),np.float32));entries=gpu.d(ell_storage(3))
        gpu.run('solver_newton','add_cloth_membrane_gauss_newton_hessian',[gpu.d(x),gpu.d(I([[0,1,2]])),gpu.d(bm),gpu.d(F([area])),gpu.d(F([ku,kv,ks])),diag,gpu.d(I([2,2,2])),entries,u64(2),u64(1),u64(1),u64(3),u64(3)])
        check_blocks(f'membrane_delta/{trial}',diag,entries,expected,3)
    # Bond update: separate original/history values; exercise inactive, yield, floor, no-yield, break.
    lengths=F([.8,.5,1.11,.91,.8]);n=len(lengths);x=np.zeros((n*2,3),np.float32);x[1::2,0]=lengths
    model=bytearray(1864);struct.pack_into('<fff',model,316,.03,.4,.1)
    original=F([1]*n);history=F([1,1,1,.9,1]);active=I([1,1,1,1,0]);expected_h=history.copy();expected_a=active.copy()
    for j in range(n):
        if active[j]:
            if lengths[j]>history[j]*(1+np.float32(.1)):expected_a[j]=0
            else:expected_h[j]=max(original[j]*(1-np.float32(.4)),min(history[j],lengths[j]+np.float32(.03)*original[j]))
    dh=gpu.d(history);da=gpu.d(active)
    gpu.run('granular','commit_bonds',[model,gpu.d(x),gpu.d(I(np.arange(n*2).reshape(n,2))),gpu.d(original),dh,da,i32(n)],n)
    check('commit_bonds/history',dh.read(),expected_h);check('commit_bonds/active',da.read(),expected_a,0,0)
    # CG threshold and NaN guard: 1e-20 is above the 1e-30 threshold.
    for tag,num,den,alpha in [('tiny_valid',1e-20,1e-20,1.),('below_threshold',1.,1e-31,0.),('nan_numerator',float('nan'),1.,0.),('nan_denominator',1.,float('nan'),0.)]:
        z=gpu.d(F([[0,0,0]]));r=gpu.d(F([[3,4,5]]));p=F([[1,2,3]]);ap=F([[.5,.6,.7]])
        gpu.run('pcg_solver','update_solution_and_residual',[i32(0),gpu.d(F([num])),gpu.d(F([den])),gpu.d(p),gpu.d(ap),z,r,u64(1)])
        check('cg/'+tag+'/solution',z.read(),alpha*p);check('cg/'+tag+'/residual',r.read(),F([[3,4,5]])-alpha*ap)
    # Inverse block with determinant ~1e-18 and off-diagonal coupling.
    D=F([[2,.3,.1],[.3,1.5,.2],[.1,.2,1.2]])*np.float32(1e-6);out=gpu.d(np.zeros(9,np.float32))
    gpu.run('solver_newton','invert_block_preconditioner',[gpu.d(packmatrix(D)),gpu.d(F([1])),gpu.d(I([1])),out,u64(1),u64(1)])
    check('inverse/tiny_determinant',out.read().reshape(3,3).T,np.linalg.inv(D.astype(float)),rtol=3e-6,atol=.1)
    for tag,D,scale,mask,expect in [
        ('singular',np.diag([2.,0.,3.]),1.,1,np.diag([.5,0.,1/3])),
        ('negative_det',np.diag([2.,-1.,3.]),1.,1,np.diag([.5,0.,1/3])),
        ('inactive',np.eye(3),1.,0,np.zeros((3,3))),
        ('zero_scale',np.eye(3),0.,1,np.zeros((3,3))),
        ('nan_det',np.diag([float('nan'),2.,3.]),1.,1,np.diag([0.,.5,1/3])),
    ]:
        out=gpu.d(np.zeros(9,np.float32))
        gpu.run('solver_newton','invert_block_preconditioner',[gpu.d(packmatrix(D)),gpu.d(F([scale])),gpu.d(I([mask])),out,u64(1),u64(1)])
        check('inverse/'+tag,out.read().reshape(3,3).T,expect)
    for name,block in [('update_preconditioned_cg_direction',False),('update_cg_direction<glm::mat<3, 3, float, (glm::qualifier)0> >',True)]:
        for tag,k,num,beta in [('first',0,[1.],0.),('tiny',1,[1e-20,2e-20],2.),('nan',1,[float('nan'),1.],0.),('zero',1,[0.,1.],0.)]:
            r=F([[1.,2.,3.]]);old=F([[.1,.2,.3]]);M=np.array([[2.,.3,.1],[.3,1.5,.2],[.1,.2,1.2]])
            out=gpu.d(old);args=[i32(k)]
            if block:args.append(gpu.d(packmatrix(M)))
            args.extend([gpu.d(r),gpu.d(F(num)),out,u64(1)])
            gpu.run('pcg_solver',name,args)
            check('direction/'+('block/' if block else 'preconditioned/')+tag,out.read(),(r@M.T if block else r)+beta*old)
    name='update_solution_residual_and_reduce<256u, glm::mat<3, 3, float, (glm::qualifier)0> >'
    for energy in [False,True]:
        n=300;r=F(rng.normal(size=(n,3)));p=F(rng.normal(size=(n,3)));ap=F(rng.normal(size=(n,3)));x=F(rng.normal(size=(n,3)));M=np.array([[2.,.3,.1],[.3,1.5,.2],[.1,.2,1.2]])
        dx=gpu.d(x);dr=gpu.d(r);reduced=gpu.d(F([0,0]));alpha=.5;expected_r=r.astype(float)-alpha*ap
        gpu.run('pcg_solver',name,[i32(0),gpu.d(F([1e-20])),gpu.d(F([2e-20])),gpu.d(p),gpu.d(ap),gpu.d(np.tile(packmatrix(M),(n,1))),dx,dr,reduced,C.c_uint8(energy),u64(n)],n)
        check(f'fused/{energy}/solution',dx.read(),x+alpha*p);check(f'fused/{energy}/residual',dr.read(),expected_r)
        expected=[np.einsum('ni,ij,nj->',part,M,part) if energy else 0 for part in [expected_r[:256],expected_r[256:]]]
        check(f'fused/{energy}/quadratic',reduced.read(),expected,atol=1e-4)
    # World atomic minimum; several particles target the same scale slot.
    view=bytearray(112);indices=gpu.d(I([0,1,2]));world=gpu.d(I([0,0,0]));struct.pack_into('<QQ',view,16,indices.ptr.value,world.ptr.value);struct.pack_into('<IIII',view,80,1,3,3,3)
    out=gpu.d(F([.5]));gpu.run('fluid','bound_scale',[view,gpu.d(F([[0,0,0],[2,0,0],[4,0,0]])),f32(.5),f32(.25),out],3)
    check('fluid/world_min',out.read(),[.0625],0,0)
    # Hash build uses negative coordinates and two entries sharing a bucket.
    n=3;S=8;x=F([[-.2,0,0],[-.8,0,0],[1.2,0,0]]);model=bytearray(1864)
    masses=gpu.d(F([1,1,1]));indices=gpu.d(I([0,1,2]));struct.pack_into('<II',model,24,n,n);struct.pack_into('<Q',model,48,masses.ptr.value);struct.pack_into('<I',model,192,n);struct.pack_into('<Q',model,200,indices.ptr.value);struct.pack_into('<ff',model,216,1.,1.)
    pos=gpu.d(np.zeros((n,3),np.float32));vol=gpu.d(np.zeros(n,np.float32));ids=gpu.d(np.zeros(n,np.int32));world=gpu.d(np.zeros(n,np.int32));cells=gpu.d(np.zeros((n,3),np.int32));head=gpu.d(I([-1]*S));nxt=gpu.d(I([-1]*n))
    gpu.run('fluid','build_grid',[model,gpu.d(x),pos,vol,ids,world,cells,head,nxt,i32(n),i32(S)],n)
    check('fluid/grid_floor',cells.read(),np.floor(x).astype(np.int32),0,0)
    seen=[];hh=head.read();nn=nxt.read()
    for slot,start in enumerate(hh):
        node=int(start);local=[]
        while node!=-1:
            assert 0<=node<n and node not in local,'invalid hash chain'
            local.append(node);seen.append(node);node=int(nn[node])
    check('fluid/grid_chain_membership',np.sort(seen),np.arange(n),0,0)
    # Density rows with the actual build_grid output, no guessed common zero pool.
    view=bytearray(112)
    for off,d in [(0,head),(8,nxt),(16,ids),(24,world),(32,cells),(40,pos),(48,vol)]:struct.pack_into('<Q',view,off,d.ptr.value)
    struct.pack_into('<IIIIffff',view,80,S,n,n,n,1.,2.,0.,1.)
    gradients=gpu.d(np.zeros((n,3),np.float32));res=gpu.d(F([0]*n));weights=gpu.d(F([0]*n));counts=gpu.d(I([0]*n));neighbors=gpu.d(I([-1]*(n*64)));coeff=gpu.d(np.zeros((n*64,4),np.float32))
    gpu.run('fluid','evaluate_rows',[view,gradients,res,weights,counts,neighbors,coeff],n)
    expected=[];expected_g=[]
    for i in range(n):
        r=x[i].astype(float)-x.astype(float);z=np.maximum(1-np.sum(r*r,axis=1),0);expected.append(max(315/(64*np.pi)*np.sum(z**3)-1,0));expected_g.append(np.sum(-945/(32*np.pi)*z[:,None]**2*r,axis=0))
    check('fluid/poly6_residual',res.read(),expected);check('fluid/poly6_gradient',gradients.read(),expected_g)
    # Save provenance and every result, including failures. Do not disguise unsupported cases as passes.
    report={'binary':str(BINARY),'binary_sha256':hashlib.sha256(BINARY.read_bytes()).hexdigest(),'seed':20261027,'gpu':subprocess.check_output(['nvidia-smi','--query-gpu=name,driver_version','--format=csv,noheader'],text=True).strip(),'scope':'original binary PTX vs independent CPU formulas; not full solver equivalence','entries':gpu.entries,'checks':rows,'passed':sum(r['pass'] for r in rows),'failed':sum(not r['pass'] for r in rows)}
    report['mode']='mechanical_cuda' if mechanical else 'readable_cuda_and_original_ptx' if human else 'original_binary_ptx'
    report['readable_cuda_entries']=sum(e['implementation']=='readable_cuda' for e in gpu.entries.values())
    report['readable_cuda_checks']=sum(r['implementation']=='readable_cuda' for r in rows)
    suffix='_mechanical' if mechanical else '_human' if human else ''
    (ROOT/f'validate/review_algorithm{suffix}_results.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    gpu.close()
    print(f'entries={len(report["entries"])} checks={len(rows)} passed={report["passed"]} failed={report["failed"]}')
    for row in rows:
        if not row['pass']:print(json.dumps(row,ensure_ascii=False))
    return bool(report['failed'])

if __name__=='__main__':raise SystemExit(main())
