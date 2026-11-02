"""Locate observed first assembly accumulator differences; partial watches never count as full-input kernel validation."""
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.h1_pre_cg_watch_layout import select_stages

folder = BASE / 'assembly-watch'
plan = json.loads((folder / 'plan.json').read_text())
terminal = json.loads((folder / 'run.status.json').read_text())
assert terminal['complete'] and terminal['running'] is None
assert [row['actual_exit'] for row in terminal['completed']] == [0, 0]
hashes, layouts = {}, []
for path, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
for label in ('sdk0', 'rebuilt0'):
    trace = folder / label / 'trace'
    graph = json.loads((trace / 'definition-before/graph.json').read_text())
    layout = json.loads((trace / 'snapshot-layout.json').read_text())
    assert layout['stages'] == json.loads(json.dumps(select_stages(linear_order(graph)[0], 46, 51)))
    assert len(layout['snapshots']) == 70 and layout['total_snapshot_bytes'] == 125246352
    layouts.append(layout)
rows = []
for old, new in zip(layouts[0]['stages'], layouts[1]['stages'], strict=True):
    assert (old['rank'], old['sizes'], old['watched_buffers']) == (new['rank'], new['sizes'], new['watched_buffers'])
    paths = [folder / label / 'trace' / (old['key'] + '-packets/frame-00.npz') for label in ('sdk0', 'rebuilt0')]
    with np.load(paths[0], allow_pickle=False) as a, np.load(paths[1], allow_pickle=False) as b:
        for index, label in old['watched_buffers'].items():
            size = old['sizes'][index]
            old_before, old_after = [a[f'{phase}-arg-{index}'] for phase in ('before', 'after')]
            new_before, new_after = [b[f'{phase}-arg-{index}'] for phase in ('before', 'after')]
            assert all(data.dtype == np.uint8 and data.nbytes == size for data in
                       (old_before, old_after, new_before, new_after))
            before_words = np.flatnonzero(old_before.view('u4') != new_before.view('u4'))
            after_words = np.flatnonzero(old_after.view('u4') != new_after.view('u4'))
            row = {'rank': old['rank'], 'kernel': old['node']['name'], 'buffer': label, 'bytes': size,
                   'before_different_words': len(before_words), 'after_different_words': len(after_words),
                   'SDK_changed_buffer': old_before.tobytes() != old_after.tobytes(),
                   'source_changed_buffer': new_before.tobytes() != new_after.tobytes()}
            if label != 'entries':
                x, y = old_after.view('f4'), new_after.view('f4')
                row['all_after_values_finite'] = bool(np.isfinite(x).all() and np.isfinite(y).all())
                row['max_after_abs_error'] = float(np.max(np.abs(x.astype('f8') - y.astype('f8'))))
            rows.append(row)
    for path in paths:
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
first = {}
for row in rows:
    if row['after_different_words'] and row['buffer'] not in first:
        first[row['buffer']] = row
target = BASE / 'assembly-watch-independent-cpu.json'
assert not target.exists()
target.write_text(json.dumps({'rows': rows, 'first_observed_buffer_differences': first,
    'input_sha256': hashes, 'full_kernel_inputs_not_captured': True, 'same_input_math_equivalence_claimed': False,
    'fixed_C8_changed': False, 'GPU_runs': 0, 'whole_solver_complete': False}, indent=2) + '\n')
print('First observed assembly buffer differences:', {key: {k: value[k] for k in
      ('rank', 'before_different_words', 'after_different_words')} for key, value in first.items()})
