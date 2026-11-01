"""CPU-only verification of the cross-mode actual-SDK witness; fixed C8 is not reclassified."""
import argparse
import hashlib
import json
from pathlib import Path
import sys
import numpy as np
root=Path.cwd().resolve()
sys.path.insert(0,str(root))
from reconstruction.demo_ab import compare
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--output',type=Path,required=True)
args=parser.parse_args()
assert not args.output.exists()
base=Path(__file__).resolve().parent.parent
cross=json.loads((base/'self-original-holdouts3/cross-mode-source0-audit.json').read_text())
world=json.loads((base/'self-original-holdouts3/world-separated-source0-audit.json').read_text())
source_path=base/'graph-cohort-d0/source0/source-w3-pd-b1-0.npz'
assert hashlib.sha256(source_path.read_bytes()).hexdigest()==cross['fixed_source0_sha256']==world['source0_sha256']
with np.load(source_path) as source:
    for row in cross['comparisons']:
        path=base/f"self-original-holdouts3/holdout{row['holdout']}/original-w3-pd-b1-{int(row['graph'])}.npz"
        assert hashlib.sha256(path.read_bytes()).hexdigest()==row['sha256']
        with np.load(path) as old:
            assert compare(old,source)==row['comparison']
    path=base/'self-original-holdouts3/holdout1/original-w3-pd-b1-1.npz'
    with np.load(path) as old:
        coordinates={}
        for name in source.files:
            for w in range(3):
                stride=24 if name.startswith('particle_') else 1
                a,b=source[name][:,w*stride:(w+1)*stride],old[name][:,w*stride:(w+1)*stride]
                check={'bitwise':a.tobytes()==b.tobytes(),
                       'different_words':int(np.count_nonzero(a.view('u4')!=b.view('u4'))),
                       'max_abs':float(abs(a.astype('f8')-b.astype('f8')).max())}
                assert check==world['comparisons'][str(w)][name]
            indices=np.argwhere(source[name].view('u4')!=old[name].view('u4'))
            coordinates[name]=sorted({(int(i[1]),int(i[2])) for i in indices})
receipt={'all_saved_comparisons_reproduced':True,'frames':60,'body_arrays_both_bitwise':
    not coordinates['body_q'] and not coordinates['body_qd'],
    'remaining_coordinates':coordinates,'source0_sha256':cross['fixed_source0_sha256'],
    'reference_npz_sha256':hashlib.sha256(path.read_bytes()).hexdigest(),
    'cohort_expanded':False,'primary_c_reclassified':False,'GPU_used':False,'whole_solver_complete':False,
    'runner_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
args.output.write_text(json.dumps(receipt,indent=2)+'\n')
print(receipt,flush=True)
