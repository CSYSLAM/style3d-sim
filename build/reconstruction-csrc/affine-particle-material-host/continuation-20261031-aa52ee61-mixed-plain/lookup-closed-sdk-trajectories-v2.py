"""CPU-only lookup in the committed closed SDK captures; never expand or reclassify an acceptance cohort."""
from pathlib import Path
import hashlib,json,re
import numpy as np
root=Path.cwd();base=Path(__file__).resolve().parent
snapshot=json.loads((root/'RECONSTRUCTION_SNAPSHOT.json').read_text())
image=json.loads((root/'build/reconstruction-csrc/host-particles/build.json').read_text())['extension_sha256']
validation=base/('validation-'+image[:8]);reference_sha='64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
results=[];cohort_cache={}
for seed in (1,2,3):
 folder=validation/f'regression74/particles-seed{seed}'
 comparison=json.loads((folder/f'comparison-seed{seed}.json').read_text())
 assert comparison['reference_sha256']==reference_sha
 assert comparison['source_runtime']['extension_sha256']==image
 source=folder/f'source-seed{seed}.npz';source_sha=sha(source)
 targets=sorted({k.split('/')[0] for k,v in comparison['checks'].items() if not v})
 candidates=sorted(k for k in snapshot['files'] if re.search(rf'/regression-fixed-C10/particles-seed{seed}/original[0-9]+\.npz$',k))
 checks=[]
 with np.load(source) as actual:
  selected={t:{k:actual[k].copy() for k in actual.files if k.startswith(t+'/')} for t in targets}
  for name in candidates:
   path=root/name;assert sha(path)==snapshot['files'][name]['sha256']
   old_validation=path.parent.parent.parent
   if str(old_validation) not in cohort_cache:
    old_comparison=json.loads((old_validation/f'regression74/particles-seed{seed}/comparison-seed{seed}.json').read_text())
    assert old_comparison['reference_sha256']==reference_sha
    legacy_root=Path(old_comparison['reference_path']).parents[3]
    hashes=json.loads((path.parent.parent/'harness-sha256.json').read_text())
    mismatch=[str(Path(p).relative_to(legacy_root)) for p,h in hashes.items() if sha(root/Path(p).relative_to(legacy_root))!=h]
    cohort_cache[str(old_validation)]={'eligible':not mismatch,'different_harnesses':mismatch}
   if not cohort_cache[str(old_validation)]['eligible']:
    checks.append({'sdk_npz':name,'sha256':sha(path),'eligible':False,**cohort_cache[str(old_validation)]});continue
   with np.load(path) as original:
    assert set(original.files)==set(actual.files)
    matches={}
    for target,arrays in selected.items():
     same={k:original[k].dtype==v.dtype and original[k].shape==v.shape and original[k].tobytes()==v.tobytes() for k,v in arrays.items()}
     matches[target]={'matching_arrays':sum(same.values()),'target_arrays':len(same),'all_bitwise':all(same.values())}
   checks.append({'sdk_npz':name,'sha256':sha(path),'eligible':True,'targets':matches})
 matches={t:[r['sdk_npz'] for r in checks if r['eligible'] and r['targets'][t]['all_bitwise']] for t in targets}
 row={'seed':seed,'source_npz':str(source.relative_to(root)),'source_sha256':source_sha,'indexed_closed_sdk_candidates':len(candidates),'eligible_closed_sdk_candidates':sum(r['eligible'] for r in checks),'targets':matches,'all_failed_targets_in_one_actual_sdk_run':[r['sdk_npz'] for r in checks if r['eligible'] and all(v['all_bitwise'] for v in r['targets'].values())],'all_lookup_rows':checks}
 results.append(row);assert sha(source)==source_sha
 print('seed',seed,'candidates',len(candidates),'exact target witnesses',{t:len(v) for t,v in matches.items()},'joint runs',len(row['all_failed_targets_in_one_actual_sdk_run']),flush=True)
report={'source_sha256':image,'reference_sha256':reference_sha,'GPU_used':False,'new_originals_collected':False,'acceptance_cohorts_changed':False,'current_C10_reclassified':False,'whole_solver_complete':False,'snapshot_source_sha256':snapshot['source_image_sha256'],'cases':results}
(base/'closed-sdk-trajectory-lookup.json').write_text(json.dumps(report,indent=2)+'\n')
