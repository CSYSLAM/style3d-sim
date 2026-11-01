"""Check the actual entries use only the control-transfer forms supported by the parameter-alias witness."""
import hashlib
import json
from pathlib import Path
import re

base=Path(__file__).resolve().parent
rows=[]
for path in sorted(base.glob('*-entry.ptx')):
    text=path.read_text()
    operations=[]
    for line in text.splitlines():
        match=re.match(r'\s*(?:@!?%\w+\s+)?([\w.]+)\b',line.split('//',1)[0])
        if match and match[1].startswith(('bra','brx','ret','exit','trap','call')):
            operations.append(match[1])
    assert set(operations)<={'bra','bra.uni','ret'} and 'ret' in operations,path.name
    rows.append({'entry':path.name,'sha256':hashlib.sha256(path.read_bytes()).hexdigest(),
                 'actual_control_forms':sorted(set(operations)),'control_transfer_count':len(operations)})
assert len(rows)==4
(base/'control-form-audit.json').write_text(json.dumps({
 'entries':rows,'actual_entries_fit_alias_dominance_witness':True,
 'arbitrary_control_flow_or_index_bounds_proven':False,'GPU_code_changed':False,
 'runner_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()},indent=2)+'\n')
print('All4 actual entries use only bra/bra.uni/ret control flow covered by the alias witness.')
