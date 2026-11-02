#!/usr/bin/env python3
"""Independent dense reference for fluid pressure, viscosity, boundary and >64-neighbor paths."""
import hashlib
import json
import struct
import sys
import numpy as np
from review_algorithm_claims import GPU, ROOT, BINARY, F, I, packmatrix


def main():
    mode=sys.argv[1] if len(sys.argv)>1 else 'original'
    assert mode in ('original','mechanical')
    gpu=GPU(mechanical=mode=='mechanical');rng=np.random.default_rng(20261029);checks=[]
    def check(case,a,b):
        a=np.asarray(a);b=np.asarray(b)
        ok=np.array_equal(a,b) if np.issubdtype(a.dtype,np.integer) else np.allclose(a,b,rtol=1e-4,atol=3e-5)
        checks.append(dict(case=case,kernel=gpu.last_kernel,passed=bool(ok),max_abs_error=float(np.max(np.abs(a-b)))))
        if not ok:print('FAIL',case,checks[-1]['max_abs_error'])
    # 65 particles => 64 dynamic neighbors; 66 particles => re-traversal path.
    for n,mu,dilute in [(3,.8,False),(65,.8,False),(66,.8,False),(66,0.,False),(3,.8,True)]:
        label=f'n={n},mu={mu},dilute={dilute}';hf=1.3;dt=.17;bulk=2.7;S=128
        ids=np.r_[rng.permutation(n),-1,-1,-1].astype(np.int32)
        x=F(rng.uniform(-.2,.2,(n,3)));reference=F(x+rng.normal(0,.05,x.shape));p=F(rng.normal(size=x.shape))
        # Boundary world=-1 applies everywhere; world=0 applies here; world=1 is excluded.
        pos=F(np.vstack([x[ids[:n]],[[.23,0,0],[-.23,.1,0],[0,0,0]]]))
        worlds=I([0]*n+[-1,0,1]);cells=I(np.floor(pos/hf));volume=F(rng.uniform(.8,1.2,n+3)*(1 if n==3 else .04))
        if dilute:volume*=.01
        head=I([-1]*S);nxt=I([-1]*(n+3))
        for j,c in enumerate(cells):
            slot=((int(c[0])*73856093)^(int(c[1])*19349663)^(int(c[2])*83492791))&(S-1)
            nxt[j]=head[slot];head[slot]=j
        view=bytearray(112)
        for off,a in [(0,head),(8,nxt),(16,ids),(24,worlds),(32,cells),(40,pos),(48,volume)]:
            d=gpu.d(a);struct.pack_into('<Q',view,off,d.ptr.value)
        counts=gpu.d(I([0]*n));neighbors=gpu.d(I([-1]*(n*64)));coeff=gpu.d(np.zeros((n*64,4),np.float32))
        for off,d in [(56,counts),(64,neighbors),(72,coeff)]:struct.pack_into('<Q',view,off,d.ptr.value)
        struct.pack_into('<IIIIffff',view,80,S,n+3,n,n,hf,bulk,mu,dt)
        gradient=gpu.d(np.zeros((n,3),np.float32));res=gpu.d(F([0]*n));weights=gpu.d(F([0]*n))
        gpu.run('fluid','evaluate_rows',[view,gradient,res,weights,counts,neighbors,coeff],n,block_size=128)
        J=np.zeros((n,n,3));c=np.zeros(n);k=np.zeros(n);pair=[];dense_coeff={};expected_count=[]
        for i in range(n):
            r=pos[i].astype(float)-pos.astype(float);r2=np.sum(r*r,axis=1);z=np.maximum(1-r2/hf**2,0)
            allowed=(worlds==0)|(worlds==-1);w=315/(64*np.pi*hf**3)*z**3
            grad=-945/(32*np.pi*hf**5)*z[:,None]**2*r
            rho=np.sum(volume[allowed]*w[allowed]);c[i]=max(rho-1,0);k[i]=bulk*volume[i] if rho>1 else 0
            J[i,ids[i]]=np.sum(volume[allowed,None]*grad[allowed],axis=0)
            js=[j for j in range(n) if j!=i and r2[j]<hf**2];expected_count.append(len(js))
            for j in js:
                J[i,ids[j]]=-volume[j]*grad[j]
                v=-2*mu*volume[i]*volume[j]*np.dot(r[j],grad[j])/((r2[j]+.01*hf**2)*dt) if j>i else 0
                dense_coeff[i,j]=np.r_[-volume[j]*grad[j],v]
                if v>0:pair.append((ids[i],ids[j],v))
        check(label+'/residual',res.read(),c);check(label+'/weights',weights.read(),k)
        check(label+'/gradient',gradient.read(),J[np.arange(n),ids[:n]])
        check(label+'/counts',counts.read(),I(expected_count))
        ns=neighbors.read().reshape(n,64);cs=coeff.read().reshape(n,64,4)
        actual=[];expected=[]
        for i in range(n):
            selected=ns[i,:min(expected_count[i],64)]
            assert len(set(selected))==len(selected) and all((i,int(j)) in dense_coeff for j in selected)
            for q,j in enumerate(selected):actual.append(cs[i,q]);expected.append(dense_coeff[i,int(j)])
        check(label+'/cache_coeff',F(actual),expected)
        force=-np.einsum('i,i,inj->nj',k,c,J)
        diagonal=np.einsum('i,inj,ink->njk',k,J,J)
        product=np.einsum('i,inj,i->nj',k,J,np.einsum('inj,nj->i',J,p))
        for a,b,v in pair:
            delta=(x[a]-x[b])-(reference[a]-reference[b]);force[a]-=v*delta;force[b]+=v*delta
            diagonal[a]+=v*np.eye(3);diagonal[b]+=v*np.eye(3)
            q=v*(p[a]-p[b]);product[a]+=q;product[b]-=q
        oldforce=F(rng.normal(size=(n,3)));olddiag=F(rng.normal(size=(n,9)));oldproduct=F(rng.normal(size=(n,3)))
        out=gpu.d(oldforce);diag=gpu.d(olddiag)
        gpu.run('fluid','accumulate_rows',[view,gradient,res,weights,gpu.d(reference),out,diag],n,block_size=128)
        check(label+'/force',out.read(),oldforce+force)
        check(label+'/diagonal',diag.read(),olddiag+F([packmatrix(m) for m in diagonal]))
        out=gpu.d(oldproduct);gpu.run('fluid','multiply_rows',[view,gradient,weights,gpu.d(p),out],n,block_size=128)
        check(label+'/product',out.read(),oldproduct+product)
    report=dict(mode=mode,binary_sha256=hashlib.sha256(BINARY.read_bytes()).hexdigest(),entries=gpu.entries,
                checks=checks,passed=sum(c['passed'] for c in checks),failed=sum(not c['passed'] for c in checks))
    gpu.close();(ROOT/f'validate/fluid_{mode}_results.json').write_text(json.dumps(report,indent=2)+'\n')
    print(f'mode={mode} entries={len(report["entries"])} checks={len(checks)} passed={report["passed"]} failed={report["failed"]}')
    return bool(report['failed'])


if __name__=='__main__':raise SystemExit(main())
