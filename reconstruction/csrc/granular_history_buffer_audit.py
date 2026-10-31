"""Audit saved histories, including initialized bond values after those bonds have broken."""
import argparse
import json
from pathlib import Path

import numpy as np

from .granular_history_ab import COMMIT, FORM
from .host_api_probe import REFERENCE_SHA


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--capture', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert not args.output.exists(), 'Preserve previous audit results'
    source_hash = json.loads((args.capture/'build.json').read_text())['extension_sha256']
    results = []
    for case in sorted(p for p in args.capture.iterdir() if p.is_dir()):
        history = case.name.split('-')[0]
        count = 24 if history == 'form' else 2
        runtimes = [json.loads((case/b/'capture.runtime.json').read_text()) for b in ('original', 'source')]
        assert runtimes[0]['image_sha256'] == REFERENCE_SHA and runtimes[1]['image_sha256'] == source_hash
        assert runtimes[0]['extra'] == runtimes[1]['extra']
        frames = runtimes[0]['frames']
        assert frames == runtimes[1]['frames']
        checks = {}
        initialized = np.full(count, history != 'form')
        dead_values = 0

        def data(backend, key, step, phase, argument, size, dtype='f4'):
            path = case/backend/f'dump_{key}_call{step:03d}_{phase}_arg{argument}.bin'
            raw = path.read_bytes()
            assert len(raw) == size*4, (path, len(raw), size)
            return np.frombuffer(raw, dtype=dtype)

        for backend in ('original', 'source'):
            with np.load(case/backend/'capture.npz') as state:
                checks[f'{backend}/states_finite'] = all(np.isfinite(state[k]).all() for k in state.files)
        groups = [(COMMIT, ((2, 2, 'i4'), (3, 1, 'f4'), (4, 1, 'f4')))]
        if history == 'form':
            groups.append((FORM, ((5, 2, 'i4'), (6, 1, 'f4'), (7, 1, 'f4'))))
        for step in range(frames):
            for key, fields in groups:
                active_argument = 8 if key == FORM else 5
                for phase in ('pre', 'post'):
                    active = data('original', key, step, phase, active_argument, count, 'i4')
                    other = data('source', key, step, phase, active_argument, count, 'i4')
                    label = f'{key}/{step}/{phase}'
                    checks[label+'/active'] = active.tobytes() == other.tobytes()
                    checks[label+'/active_boolean'] = bool(np.isin(active, (0, 1)).all())
                    initialized |= (active != 0) | (other != 0)
                    dead_values += int((initialized & (active == 0)).sum())
                    for argument, width, dtype in fields:
                        a = data('original', key, step, phase, argument, count*width, dtype).reshape(count, width)
                        b = data('source', key, step, phase, argument, count*width, dtype).reshape(count, width)
                        checks[f'{label}/{argument}'] = a[initialized].tobytes() == b[initialized].tobytes()
                        if dtype == 'f4':
                            checks[f'{label}/{argument}/finite'] = bool(
                                np.isfinite(a[initialized]).all() and np.isfinite(b[initialized]).all())
                    if key == FORM:
                        for argument, size in ((2, 9), (4, count)):
                            a = data('original', key, step, phase, argument, size, 'i4')
                            b = data('source', key, step, phase, argument, size, 'i4')
                            checks[f'{label}/{argument}'] = a.tobytes() == b.tobytes()
        row = {'case': case.name, 'frames': frames, 'checks': len(checks),
               'initialized_inactive_bond_observations': dead_values,
               'failures': [key for key, good in checks.items() if not good]}
        results.append(row)
        print(row, flush=True)
    assert len(results) == 6, 'Expected the complete three-history/two-mode batch'
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps({'source_sha256': source_hash, 'capture': str(args.capture.resolve()),
                                       'cases': results}, indent=2)+'\n')
    return int(any(row['failures'] for row in results))


if __name__ == '__main__':
    raise SystemExit(main())
