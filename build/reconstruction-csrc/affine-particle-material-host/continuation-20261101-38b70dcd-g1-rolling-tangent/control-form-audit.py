"""Check the actual entries use only the control-transfer forms supported by the parameter-alias witness."""
import hashlib
import json
from pathlib import Path
import re

import numpy as np

base=Path(__file__).resolve().parent
proofs=json.loads((base/'CPU-layout-preflight.json').read_text())['PTX_proofs']
rows=[]
for path in sorted(base.glob('*-entry.ptx')):
    text=path.read_text()
    lines=text.splitlines()
    operations=[]
    for line in lines:
        match=re.match(r'\s*(?:@!?%\w+\s+)?([\w.]+)\b',line.split('//',1)[0])
        if match and match[1].startswith(('bra','brx','ret','exit','trap','call')):
            operations.append(match[1])
    assert set(operations)<={'bra','bra.uni','ret','trap'} and 'ret' in operations,path.name
    traps=[]
    if 'trap' in operations:
        assert path.name.endswith('-source-entry.ptx') and operations.count('trap')==1
        trap_at=next(i for i,line in enumerate(lines) if line.strip()=='trap;')
        assert all(i<trap_at for i,line in enumerate(lines) if re.search(r'\bld\.param\.',line))
        label=lines[trap_at-1].strip().removesuffix(':')
        assert label.startswith('$L__BB') and lines[trap_at-1].strip().endswith(':')
        previous=[line.strip() for line in lines[:trap_at-1] if line.strip()]
        assert previous[-1]=='ret;'
        incoming=[i for i,line in enumerate(lines[:trap_at-1]) if label in line]
        assert len(incoming)==2
        key=path.name.split('-',1)[0]
        loads=proofs[key]['source']['stores']['canonicalized_parameter_loads']
        for i in incoming:
            branch=re.fullmatch(r'\s*@(%p\d+)\s+bra(?:\.uni)?\s+'+re.escape(label)+r';\s*',lines[i])
            assert branch
            guard=next(line.strip() for line in reversed(lines[:i]) if line.strip())
            match=re.fullmatch(r'setp.eq.s64\s+'+re.escape(branch[1])+r',\s*(%rd\d+),\s*0;',guard)
            assert match
            definitions=[line for line in lines if re.match(r'\s*setp\.[\w.]+\s+'
                                                           +re.escape(branch[1])+r',',line)]
            assert len(definitions)==1
            sources=[row for row in loads if re.match(r'ld.param.u64\s+'
                                                     +re.escape(match[1])+r',',row['original_instruction'])]
            assert len(sources)==1 and (sources[0]['parameter'],sources[0]['offset'],sources[0]['bytes'])==(0,232,8)
            traps.append({'branch':lines[i].strip(),'guard':guard,'parameter':0,'offset':232,
                          'condition':'RollingContactView.previous is NULL'})
        for side in ('original','source'):
            for packet in sorted((base/side/(key+'-packets')).glob('frame-*.npz')):
                with np.load(packet) as data:
                    assert int.from_bytes(data['parameter-0'].tobytes()[232:240],'little')!=0
    rows.append({'entry':path.name,'sha256':hashlib.sha256(path.read_bytes()).hexdigest(),
                 'actual_control_forms':sorted(set(operations)),'control_transfer_count':len(operations),
                 'source_terminal_trap_guards':traps,'trap_branch_false_for_all_captured_previous_pointers':True})
assert len(rows)==2
(base/'control-form-audit.json').write_text(json.dumps({
 'entries':rows,'actual_entries_fit_alias_dominance_witness':True,
 'arbitrary_control_flow_or_index_bounds_proven':False,'GPU_code_changed':False,
 'runner_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()},indent=2)+'\n')
print('All2 actual control inventories checked; source terminal traps require NULL previous, absent in all120 packets.')
