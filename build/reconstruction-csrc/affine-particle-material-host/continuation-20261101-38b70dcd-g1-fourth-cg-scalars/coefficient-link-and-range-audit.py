"""Verify actual scalar producer/consumer pointer links and finite ranges from the frozen graph and blob bytes."""
from collections import Counter
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_drive_tangent_capture import integer
from reconstruction.csrc.graph_definition_compare import linear_order

plan = json.loads((BASE / 'plan.json').read_text())
counts, hashes = Counter(), {}
for run in plan['runs']:
    folder = BASE / run['label'] / 'trace'
    graph = folder / 'definition-before/graph.json'
    hashes[str(graph)] = hashlib.sha256(graph.read_bytes()).hexdigest()
    nodes = linear_order(json.loads(graph.read_text()))[0]
    layout = json.loads((folder / 'layout.json').read_text())
    for event in layout['events']:
        if event['kind'] != 'cg':
            continue
        rank, k = event['rank'], event['iteration']
        update, direction, precondition, matrix = nodes[rank], nodes[rank - 9], nodes[rank - 10], nodes[rank - 1]
        assert '19update_cg_directionE' in direction['name']
        assert direction['parameter_widths'] == [4, 8, 8, 4, 8, 8, 8, 8]
        assert integer(direction, 0) == k and integer(direction, 2) == 0
        assert integer(direction, 3) == integer(direction, 7) == 176
        assert integer(direction, 4) == integer(update, 2)
        assert integer(direction, 5) == (integer(update, 2) - 4 if k else 0)
        assert '23precondition_and_reduceI' in precondition['name']
        assert integer(precondition, 6) == integer(update, 2)
        assert integer(precondition, 4) == 0 and integer(precondition, 5) == integer(precondition, 7) == 176
        assert '26multiply_matrix_and_reduceI' in matrix['name']
        assert integer(matrix, 9) == integer(update, 3) and integer(matrix, 7) == 0
        assert [integer(matrix, i) for i in (8, 10, 11)] == [176, 176, 176]
        assert all(node['geometry'] == [1, 1, 1, 256, 1, 1, 0]
                   for node in (update, direction, precondition, matrix))
        counts['actual_precondition_num_links'] += 1
        counts['actual_matrix_den_links'] += 1
        counts['actual_direction_current_num_links'] += 1
        counts['actual_beta_previous_num_links' if k else 'actual_first_iteration_null_previous'] += 1
metrics = {}
with np.load(BASE / 'coefficients.npz', allow_pickle=False) as pairs:
    for kind in ('alpha', 'beta'):
        num, den = pairs[kind + '_num'].view('<f4'), pairs[kind + '_den'].view('<f4')
        assert np.isfinite(num).all() and np.isfinite(den).all()
        assert np.all(den > np.float32(1e-30))
        metrics[kind] = {'pairs': len(num), 'minimum_numerator': float(num.min()),
                         'maximum_numerator': float(num.max()), 'minimum_denominator': float(den.min()),
                         'maximum_denominator': float(den.max()),
                         'smallest_denominator_to_guard_threshold_ratio': float(den.min()) / float(np.float32(1e-30)),
                         'all_num_and_den_finite': True, 'all_denominators_positive_above_guard': True}
assert counts['actual_beta_previous_num_links'] == 2695 and counts['actual_first_iteration_null_previous'] == 55
output = BASE / 'coefficient-link-and-range-audit.json'
assert not output.exists()
output.write_text(json.dumps({'counts': dict(counts), 'metrics': metrics, 'input_sha256': hashes,
                              'observed_pairs_linked_to_real_graph_producers_and_consumers': True,
                              'production_changed': False, 'old_C8_reclassified': False,
                              'whole_solver_complete': False}, indent=2) + '\n')
print(json.dumps({'counts': dict(counts), 'metrics': metrics}, indent=2))
