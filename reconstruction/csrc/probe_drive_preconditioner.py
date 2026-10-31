"""Compare legacy and CUDA preconditioner outputs for all drives together and one drive at a time.

Run as: .venv/bin/python -m reconstruction.csrc.probe_drive_preconditioner SEED
The isolated runs zero other drive coefficients, without changing the formal A/B suite.
"""
import re
import sys
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from reconstruction import kernel_ab as k  # noqa: E402
from reconstruction.csrc import ptx_compare as pc  # noqa: E402

# SETUP: reuse the input-building part of a kernel_ab test function (everything before its first launch).
source = (ROOT/'reconstruction/kernel_ab.py').read_text()
setup = source[source.index('def run_joint_drives'):source.index("    for label, use_modes, use_damping in (('modes'")]
namespace = dict(vars(k))
exec(setup.replace('def run_joint_drives(driver, rng):', 'def _setup(driver, rng):') + '    return locals()\n',
     namespace)



d = k.Driver()
try:
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    e = namespace['_setup'](d, np.random.default_rng(seed))
    ours = pc.compile_ptx(pc.CSRC/'kernels'/'joints.cu', pc.DEFAULT_NVCC)
    prefix = '30add_joint_drive_preconditioner'
    name = re.search(r'\.entry (_ZN7synreal\w*' + prefix + r'\w*)\(', ours).group(1)
    fs = [d.function(*k.legacy_ptx(prefix)), d.function(ours, name)]
    rows = []
    for active in [-1]+list(range(e['count'])):
        kd = e['kd'].copy()
        if active >= 0:
            kd[:] = 0
            kd[e['dof'][active]] = e['kd'][e['dof'][active]]
        outputs = []
        for fun in fs:
            up = d.upload
            before = np.zeros((len(e['q']), 9), k.F)
            out = up(before)
            d.launch(fun, e['count'], [up(e['q']), up(e['indices']), up(e['drives'].types), up(e['pairs']),
                up(e['po']), up(e['pa']), up(e['pr']), up(e['drives'].w_po), up(e['drives'].w_co),
                up(e['drives'].w_pa), up(e['drives'].w_pr), up(e['drives'].w_cr), up(e['dof']),
                k.null(), k.null(), up(kd), k.f32(240), out, k.u64(e['count']), k.u64(e['count']), k.u64(len(e['q']))])
            outputs.append(d.download(out, before))
        a,b=outputs
        bad=np.argwhere(a.view(np.uint32)!=b.view(np.uint32))
        row={'active':active, 'type':int(e['drives'].types[active]) if active>=0 else None,
             'bad':len(bad), 'locations':bad.tolist()}
        rows.append(row)
        if len(bad): print(row, flush=True)
        d.free()
    import json
    (pc.OUT/f'drive-preconditioner-probe-seed{seed}.json').write_text(json.dumps(rows,indent=2)+'\n')
finally:
    d.free()
