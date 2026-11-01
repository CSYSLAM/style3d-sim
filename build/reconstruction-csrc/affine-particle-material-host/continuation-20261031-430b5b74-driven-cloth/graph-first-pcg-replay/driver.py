"""Replay every actually observed graph first PCG divergence; preserve the fixed graph cohorts."""
from pathlib import Path
import json,subprocess,sys,hashlib
root=Path.cwd();base=Path(__file__).resolve().parent
build=root/'build/reconstruction-csrc/host-particles/build.json';saved=build.read_bytes();image=json.loads(saved)['extension_sha256']
input_report=base/'graph-first-pcg-packets/report.json';proof=json.loads(input_report.read_text())
output=base/'graph-first-pcg-replay';output.mkdir(exist_ok=False)
(output/'build.json').write_bytes(saved);(output/'driver.py').write_bytes(Path(__file__).read_bytes())
planned=[row for row in proof['cases'] if 'packet' in row]
assert len(planned)==6
status={'source_sha256':image,'planned':planned,'complete':False,'completed':[],
        'fixed_candidates_replaced':False,'cohorts_extended':False,'whole_solver_complete':False,
        'input_report_sha256':hashlib.sha256(input_report.read_bytes()).hexdigest()}
for row in planned:
    capture=Path(row['packet']);name=capture.name
    for kind,module,options in (
        ('three-backends','pcg_same_buffer_probe',['--directory',str(capture/'original/native'),'--trials','32']),
        ('atomic-certificate','pcg_grouped_atomic_certificate',['--capture',str(capture)])):
        assert build.read_bytes()==saved
        target=output/(name+'-'+kind)
        command=[sys.executable,'-m','reconstruction.csrc.'+module,*options,'--launch',row['launch'],'--output',str(target)]
        (output/(target.name+'.command.json')).write_text(json.dumps(command,indent=2)+'\n')
        status['running']=target.name;(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
        with (output/(target.name+'.log')).open('w') as log:
            code=subprocess.run(command,stdout=log,stderr=subprocess.STDOUT,timeout=1800).returncode
        status['completed'].append({'name':target.name,'exit':code})
        (output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
        print(target.name,code,flush=True);assert code==0
status['complete']=True;status['running']=None
(output/'status.json').write_text(json.dumps(status,indent=2)+'\n')
