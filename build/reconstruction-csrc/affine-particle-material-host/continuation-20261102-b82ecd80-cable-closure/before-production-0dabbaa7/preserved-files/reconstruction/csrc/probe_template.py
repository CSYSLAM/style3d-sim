"""Template: run one kernel from the legacy PTX and from our compiled csrc PTX on identical inputs and list the
output elements that differ. Copy this file, then edit the three marked places (SETUP, KERNEL, LAUNCH).

    .venv/bin/python reconstruction/csrc/probe_template.py [seed]

This example probes evaluate_joint_drive_load with the inputs of kernel_ab.run_joint_drives.
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

# KERNEL: the .cu file that defines it and the length-prefixed name used in the mangled symbol.
SOURCE_FILE, PREFIX = 'joints.cu', '25evaluate_joint_drive_load'

d = k.Driver()
try:
    e = namespace['_setup'](d, np.random.default_rng(int(sys.argv[1]) if len(sys.argv) > 1 else 1))
    ours = pc.compile_ptx(pc.CSRC/'kernels'/SOURCE_FILE, pc.DEFAULT_NVCC)
    name = re.search(r'\.entry (_ZN7synreal\w*' + PREFIX + r'\w*)\(', ours).group(1)
    results = {}
    for tag, function in (('legacy', d.function(*k.legacy_ptx(PREFIX))), ('ours', d.function(ours, name))):
        up = d.upload
        out_force, out_angle, out_init = up(e['force0']), up(e['angle0']), up(e['init0'])
        # LAUNCH: copy the parameter list of the kernel_ab launch; outputs are fresh uploads per run.
        d.launch(function, e['count'], [
            up(e['q']), up(e['previous']), up(e['qd']), out_angle, out_init, up(e['indices']), up(e['drives'].types),
            up(e['pairs']), up(e['po']), up(e['pa']), up(e['pr']), up(e['drives'].w_po), up(e['drives'].w_co),
            up(e['drives'].w_pa), up(e['drives'].w_pr), up(e['drives'].w_cr), up(e['dof']), up(e['target']),
            up(e['ke']), up(e['kd']), up(e['effort']), up(e['modes']), up(e['damping']), up(e['feed']), up(e['tq']),
            up(e['tqd']), out_force, k.u64(e['count']), k.u64(e['count']), k.u64(len(e['q'])), k.u64(e['count']),
            k.u64(e['count']), k.f32(240.0)])
        results[tag] = d.download(out_force, e['force0'])
    a, b = results['legacy'], results['ours']
    bad = np.argwhere(a.view(np.uint32) != b.view(np.uint32))
    print('mismatches', len(bad))
    for row, column in bad[:20]:
        print('row', row, 'component', column, 'legacy', a[row, column], 'ours', b[row, column])
finally:
    d.free()
