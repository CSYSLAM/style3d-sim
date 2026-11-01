"""Check all closed constructor, graph and initcheck evidence from file bytes without new GPU samples."""
import hashlib
import json
from pathlib import Path

import numpy as np

base = Path(__file__).resolve().parent
output = base / 'validation-38b70dcd'
status = json.loads((output / 'status.json').read_text())
assert status['complete'] and len(status['completed']) == 11
assert all(row['exit'] == 0 for row in status['completed'])
constructors, graph_cases, checks, fields = [], [], 0, 0
for kind in ('spring-line', 'spring-distance', 'line-distance', 'all'):
    for mode in ('newton', 'pd'):
        path = output / f'{kind}-{mode}-constructor/audit.json'
        audit = json.loads(path.read_text())
        assert len(audit['checks']) == 5 and all(audit['checks'].values())
        assert audit['all_captured_checks_passed'] and audit['source_sha256'] == status['source_sha256']
        constructors.append({'kind': kind, 'mode': mode, 'checks': audit['checks'],
                             'audit_sha256': hashlib.sha256(path.read_bytes()).hexdigest()})
        for worlds in (1, 3):
            for block in (False, True):
                name = f'{kind}-w{worlds}-{mode}-b{int(block)}'
                arrays = []
                for backend in ('original', 'source'):
                    for graph in (0, 1):
                        path = output / f'graph60/{backend}-{name}-{graph}.npz'
                        with np.load(path) as data:
                            assert set(data.files) == {'particle_q', 'particle_qd', 'body_q', 'body_qd'}
                            arrays.append({key: (data[key].dtype, data[key].shape, data[key].tobytes())
                                           for key in data.files})
                            assert data['particle_q'].shape == (60, 8 * worlds, 3)
                            assert all(data[key].shape[0] == 60 and np.isfinite(data[key]).all() for key in data.files)
                            fields += 4
                assert all(row == arrays[0] for row in arrays)
                graph_cases.append(name)
                checks += 4
assert len(constructors) == 8 and len(graph_cases) == 32 and checks == 128 and fields == 512
saved = json.loads((output / 'graph60/report.json').read_text())
assert len(saved) == 128 and all(row['bitwise'] for row in saved.values())
logs = {}
for backend in ('original', 'source'):
    path = output / ('initcheck3-' + backend + '.log')
    text = path.read_text()
    assert 'ERROR SUMMARY: 0 errors' in text
    logs[backend] = {'sha256': hashlib.sha256(path.read_bytes()).hexdigest(),
                     'trajectories': 64, 'steps': 3, 'errors': 0}
report = {'source_sha256': status['source_sha256'], 'constructors': constructors,
          'graph_cases': len(graph_cases), 'strict_comparisons': checks, 'raw_state_fields': fields,
          'initcheck': logs, 'all_passed': True, 'GPU_used': False, 'whole_solver_complete': False,
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(base / 'local-independent-audit.json').write_text(json.dumps(report, indent=2) + '\n')
print('constructor8 five checks, graph128 comparisons and initcheck logs independently verified')
