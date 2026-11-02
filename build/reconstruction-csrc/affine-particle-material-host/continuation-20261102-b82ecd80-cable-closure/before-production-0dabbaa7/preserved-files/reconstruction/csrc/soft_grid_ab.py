"""Compare real fluid/body contact launches across the original soft-product grid boundary."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

import numpy as np

from reconstruction.csrc.audit_cudahook import compare as compare_launches, schemas
from reconstruction.demo_ab import compare

ROOT = Path(__file__).resolve().parents[2]


def main():
    output = Path(sys.argv[1]).resolve()
    output.mkdir(parents=True, exist_ok=False)
    manifest = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = manifest.read_bytes()
    (output/'build.json').write_bytes(saved)
    hook = ROOT/'build/reconstruction-csrc/bodies/cudahook.so'
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'CUDAHOOK_DIR', 'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    env['LD_PRELOAD'] = str(hook)
    key = '42multiply_soft_contact_hessian_off_diagonal'
    env['CUDAHOOK_DUMP'] = key+'=0:4'
    schema, count = schemas()
    results = []
    for mode in ('newton', 'pd'):
        for capacity in (8191, 8192, 8193, 405504):
            case = output/f'{mode}-{capacity}'
            for backend in ('original', 'source'):
                if manifest.read_bytes() != saved:
                    raise RuntimeError('Source changed during the batch')
                directory = case/backend
                directory.mkdir(parents=True)
                env['CUDAHOOK_DIR'] = str(directory)
                command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend,
                           '--tag', 'capture', '--example', 'reconstruction/csrc/soft_grid_scene.py',
                           '--frames', '3', '--output', str(directory), '--', '--mode', mode,
                           '--capacity', str(capacity)]
                with (directory/'run.log').open('w') as log:
                    run = subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT,
                                         timeout=600)
                if run.returncode:
                    raise RuntimeError(f'{case.name}/{backend}: exit {run.returncode}')
            a, b = case/'original', case/'source'
            metadata = compare_launches(a/'launches.txt', b/'launches.txt', schema)
            states = compare(np.load(a/'capture.npz'), np.load(b/'capture.npz'))
            counts = {}
            for backend, directory in (('original', a), ('source', b)):
                dumps = list(directory.glob('dump_'+key+'*pre_arg0.bin'))
                if len(dumps) != 1:
                    raise RuntimeError(f'{directory}: expected a captured contact count, found {dumps}')
                counts[backend] = int(np.fromfile(dumps[0], dtype='i4')[0])
                if not 0 < counts[backend] < capacity:
                    raise RuntimeError(f'{directory}: missing contacts or overflow')
            grids = [line.split()[2] for line in (a/'launches.txt').read_text().splitlines() if key in line]
            result = {'case': case.name, 'metadata': metadata, 'strict_states': states,
                      'first_contact_counts': counts, 'original_product_grids': sorted(set(grids))}
            (case/'report.json').write_text(json.dumps(result, indent=2)+'\n')
            results.append(result)
            (output/'report.json').write_text(json.dumps({'abi_entries': count,
                'source_sha256': json.loads(saved)['extension_sha256'],
                'hook_sha256': hashlib.sha256(hook.read_bytes()).hexdigest(), 'results': results}, indent=2)+'\n')
            print(case.name, metadata['equal'], states['bitwise'], counts, sorted(set(grids)), flush=True)
    return int(any(not row['metadata']['equal'] for row in results))


if __name__ == '__main__':
    raise SystemExit(main())
