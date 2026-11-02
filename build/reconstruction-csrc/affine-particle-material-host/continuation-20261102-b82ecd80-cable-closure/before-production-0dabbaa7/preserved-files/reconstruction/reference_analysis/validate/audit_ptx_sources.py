#!/usr/bin/env python3
"""Account for every PTX statement, compile every mechanical source and JIT-load both sides."""
from pathlib import Path
import concurrent.futures as futures
import ctypes as C
import hashlib
import json
import re
import subprocess
import sys
import tempfile
from review_algorithm_claims import GPU, ROOT, META, BINARY
sys.path.insert(0,str(ROOT/'recover'))
import ptx2c


def h(data):return hashlib.sha256(data).hexdigest()


def main():
    ptx2c.load_globals();gpu=GPU();build=ROOT/'validate/audit_build';build.mkdir(exist_ok=True)
    metas=[m for m in META if 'synreal::' in m['pretty'] and '_kernel_agent' not in m['pretty']]
    globals_text='\n'.join(line for line in gpu.raw.splitlines() if line.startswith('.global') and '__cudart_i2opi_f' in line)
    # Multiple fatbin modules carry the same constant. One definition per JIT module.
    globals_text='\n'.join(dict.fromkeys(globals_text.splitlines()))
    def process(meta):
        path=ROOT/meta['file'].removeprefix('_re_analysis/');k=ptx2c.parse(path);symbol=ptx2c.symbol_name(k);mod=meta['cu'].removesuffix('.cu')
        source=ROOT/'recover/src'/mod/(symbol+'.cu');body=path.read_text();src=source.read_text()
        row={'kernel':meta['disp'],'module':mod,'ptx':str(path.relative_to(ROOT)),'source':str(source.relative_to(ROOT)),
             'ptx_sha256':h(path.read_bytes()),'source_sha256':h(source.read_bytes()),'statement_count':sum(not s.endswith(':') for s in k.instrs),
             'compound_shuffle_blocks':sum(s.startswith('{') for s in k.instrs),'label_count':len(k.labels),'parameter_count':len(k.params)}
        try:
            markers=[(int(n),s) for n,s in re.findall(r'^\s*// PTX:(\d+) (.+)$',src,re.M)]
            assert markers==list(zip(k.lines,k.instrs)),'source-line accounting'
            # Independent lexical scan includes inline compound blocks; declarations
            # and pragmas are classified, not silently treated as instructions.
            rawbody=body[body.index('\n{')+2:body.rfind('}')]
            rawstatements=[]
            for line in rawbody.splitlines():
                line=line.strip()
                if not line or line in ('{','}') or line.startswith('//') or line.startswith('.'):continue
                rawstatements.append(line.rstrip(';'))
            assert rawstatements==k.instrs,'lexical instruction accounting'
            with tempfile.TemporaryDirectory() as tmp:
                output,*_=ptx2c.emit(k,tmp,mod)
                assert Path(output).read_text()==src,'source reproducibility'
            name=meta['mangled'];start=gpu.raw.index('.visible .entry '+name+'(');b=gpu.raw.index('{',start);depth=0
            for end in range(b,len(gpu.raw)):
                depth+=(gpu.raw[end]=='{')-(gpu.raw[end]=='}')
                if not depth:break
            entry=gpu.raw[start:end+1]
            stored=body[body.index(name+'('):body.rfind('}')+1]
            normalize=lambda x:''.join(x.replace('.visible .entry ','').split())
            assert normalize(entry)==normalize(stored),'fresh binary snapshot'
            row.update(fresh_binary_matches_snapshot=True,all_statements_accounted=True,reproducible=True)
            cubin=build/(mod+'__'+symbol+'.cubin');log=cubin.with_suffix('.log')
            command=['nvcc','-cubin','-arch=sm_120','-std=c++14','-diag-suppress=177','-diag-suppress=550','-I',str(ROOT/'recover'),str(source),'-o',str(cubin)]
            proc=subprocess.run(command,capture_output=True,text=True,timeout=180);log.write_text(proc.stdout+proc.stderr)
            row['compile_pass']=proc.returncode==0;row['compile_log']=str(log.relative_to(ROOT))
            if proc.returncode:row['compile_error']=proc.stderr[-3000:]
            row['_original_ptx']=('.version 8.4\n.target sm_52\n.address_size 64\n'+globals_text+'\n'+entry).encode()
            row['_cubin']=cubin;row['_symbol']=symbol
        except Exception as exc:row['error']=str(exc)
        return row
    rows=[]
    with futures.ThreadPoolExecutor(max_workers=4) as pool:
        for future in futures.as_completed([pool.submit(process,m) for m in metas]):
            row=future.result()
            for kind,data in [('original',row.pop('_original_ptx',None)),('mechanical',row.pop('_cubin',None))]:
                if data is None:continue
                try:
                    data=data.read_bytes() if isinstance(data,Path) else data
                    module=C.c_void_p();buf=C.create_string_buffer(data)
                    gpu.ck(gpu.lib.cuModuleLoadDataEx(C.byref(module),C.cast(buf,C.c_void_p),0,None,None))
                    gpu.ck(gpu.lib.cuModuleUnload(module));row[kind+'_load_pass']=True
                except Exception as exc:row[kind+'_load_pass']=False;row[kind+'_load_error']=str(exc)
            row.pop('_symbol',None);rows.append(row)
            if 'error' in row or not row.get('compile_pass'):print('FAIL',row['module'],row['kernel'],row.get('error',row.get('compile_error','')),flush=True)
            elif len(rows)%20==0:print(f'checked={len(rows)}/{len(metas)}',flush=True)
    gpu.close();rows.sort(key=lambda r:(r['module'],r['kernel']))
    report={'binary_sha256':h(BINARY.read_bytes()),'translator_sha256':h((ROOT/'recover/ptx2c.py').read_bytes()),'kernels':rows,
            'total':len(rows),'statements':sum(r['statement_count'] for r in rows),'compound_blocks':sum(r['compound_shuffle_blocks'] for r in rows),
            'static_pass':sum(r.get('all_statements_accounted',False) and r.get('reproducible',False) and r.get('fresh_binary_matches_snapshot',False) for r in rows),
            'compile_pass':sum(r.get('compile_pass',False) for r in rows),'original_load_pass':sum(r.get('original_load_pass',False) for r in rows),'mechanical_load_pass':sum(r.get('mechanical_load_pass',False) for r in rows)}
    (ROOT/'validate/ptx_source_audit.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({k:v for k,v in report.items() if k!='kernels'},indent=2))
    return any(report[k]!=len(rows) for k in ['static_pass','compile_pass','original_load_pass','mechanical_load_pass'])


if __name__=='__main__':raise SystemExit(main())
