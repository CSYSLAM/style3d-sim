"""Independently compare every recorded state byte across all fixed eager/graph pairs for both candidates."""
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
reports = []
for directory, candidate in (('mixed-graph60', 'world-attachment'), ('dynamic-mixed-graph60', 'moving-bodies')):
    folder = BASE / directory
    status = json.loads((folder / 'status.json').read_text())
    plan = json.loads((folder / 'plan.json').read_text())
    report = json.loads((folder / 'report.json').read_text())
    assert status['complete'] and status['running'] is None
    assert [(row['backend'], row['actual_exit']) for row in status['completed']] == [('original', 0), ('source', 0)]
    assert report['total'] == report['strict'] == 64 and plan['frames'] == 60
    hashes = dict(plan['input_sha256'])
    for path, expected in hashes.items():
        actual = Path(path)
        if not actual.is_file() or hashlib.sha256(actual.read_bytes()).hexdigest() != expected:
            actual = BASE / 'before-production-0dabbaa7/preserved-files' / actual.relative_to(ROOT)
        assert hashlib.sha256(actual.read_bytes()).hexdigest() == expected, path
    for backend in ('original', 'source'):
        runtime = json.loads((folder / (backend + '.runtime.json')).read_text())
        mapping = json.loads((folder / (backend + '-mapping.json')).read_text())
        assert runtime['frames'] == 60 and mapping['SDK_mapped'] == (backend == 'original')
        expected = ('64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
                    if backend == 'original' else report['source_image_sha256'])
        assert runtime['image_sha256'] == expected
        for path, expected in runtime['sha256'].items():
            actual = Path(path)
        if not actual.is_file() or hashlib.sha256(actual.read_bytes()).hexdigest() != expected:
            actual = BASE / 'before-production-0dabbaa7/preserved-files' / actual.relative_to(ROOT)
        assert hashlib.sha256(actual.read_bytes()).hexdigest() == expected, path
    pairs, compared_bytes = [], 0
    for name, worlds, extra in plan['cases']:
        assert extra[extra.index('--seed') + 1] == str(worlds)
        with ExitStack() as stack:
            arrays = {(backend, graph): stack.enter_context(np.load(folder / f'{backend}-{name}-{graph}.npz',
                                                                     allow_pickle=False))
                      for backend in ('original', 'source') for graph in (0, 1)}
            shapes = {'particle_q': (60, 8 * worlds, 3), 'particle_qd': (60, 8 * worlds, 3),
                      'body_q': (60, 2 * worlds, 7), 'body_qd': (60, 2 * worlds, 6)}
            for data in arrays.values():
                assert set(data.files) == set(shapes)
                for key, shape in shapes.items():
                    assert data[key].shape == shape and data[key].dtype == np.dtype('<f4')
                    assert np.isfinite(data[key]).all()
            comparisons = [(f'original-source/{name}/{graph}', arrays['original', graph], arrays['source', graph])
                           for graph in (0, 1)]
            comparisons += [(f'{backend}-eager-graph/{name}', arrays[backend, 0], arrays[backend, 1])
                            for backend in ('original', 'source')]
            for key, left, right in comparisons:
                assert report['comparisons'][key]['bitwise']
                count = 0
                for field in shapes:
                    assert left[field].tobytes() == right[field].tobytes(), (candidate, key, field)
                    count += left[field].nbytes
                pairs.append({'comparison': key, 'complete_state_bytes_checked': count})
                compared_bytes += count
    assert len(pairs) == 64 and set(report['comparisons']) == {row['comparison'] for row in pairs}
    for path in folder.iterdir():
        if path.is_file():
            hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    reports.append({'candidate': candidate, 'actual_GPU_workers_exit0': 2, 'strict_pairs': 96,
                    'complete_state_bytes_CPU_checked': compared_bytes, 'pairs': pairs, 'input_sha256': hashes})
result = {'candidates': reports, 'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
          'old_C8_failures_reclassified': False, 'production_modified': False, 'whole_solver_complete': False}
(BASE / 'graph60-independent-cpu.json').write_text(json.dumps(result, indent=2) + '\n')
print('Independent CPU checked all128 mixed eager/graph state comparisons,64 per fixture, complete byte equality')
