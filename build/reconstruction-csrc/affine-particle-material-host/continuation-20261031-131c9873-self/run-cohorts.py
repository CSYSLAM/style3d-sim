"""Fixed self/tet graph cohorts, adopting the untouched first baseline workers."""
import json
from pathlib import Path
import subprocess
import sys
root = Path.cwd().resolve()
sys.path.insert(0, str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
base = Path(__file__).resolve().parent
validation = base.parent / 'validation-04b46fb0-self-tet'
saved = (root / 'build/reconstruction-csrc/host-particles/build.json').read_bytes()
status = []
for diagonal in (0, 1):
    command = [sys.executable, '-m', 'reconstruction.csrc.affine_graph_cohort', '--suite', 'tetrahedron_self',
               '--baseline', str(validation / f'self-graph60-d{diagonal}'),
               '--output', str(base / f'graph-cohort-d{diagonal}')]
    if diagonal:
        command.append('--diagonal-only')
    assert (root / 'build/reconstruction-csrc/host-particles/build.json').read_bytes() == saved
    (base / f'graph-cohort-d{diagonal}.command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (base / f'graph-cohort-d{diagonal}.log').open('w') as log:
        code = subprocess.run(command, env=clean_env(), stdout=log, stderr=subprocess.STDOUT,
                              timeout=7200).returncode
    status.append({'diagonal_only': diagonal, 'exit': code})
    (base / 'graph-cohorts.status.json').write_text(json.dumps(status, indent=2) + '\n')
    print(diagonal, code, flush=True)
    assert code in (0, 1)
