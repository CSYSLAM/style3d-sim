"""CPU-only checks and first-difference localization for the authentic PD RHS/PCG diagnostic snapshots."""
import argparse
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path

import numpy as np

from .demo_source_ab import ROOT
from .graph_definition_compare import linear_order
from .pcg_alias_replay import span_groups
from .pd_contact_rhs_capture import select_stages
from reconstruction.demo_ab import spread_report


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(frame, stage, phase, label):
    return frame[stage['key'] + '/' + phase + '/' + label]


def meaningful(frame, stage, phase, label):
    """Exclude overwritten inputs and cache tails; never interpret uninitialized capacity slots as state."""
    value = read(frame, stage, phase, label)
    kind = stage['kind']
    if kind == 'grain-contacts':
        if phase == 'before' and label in ('view-64', 'view-72', 'view-80', 'arg-3', 'arg-4', 'arg-5'):
            return None
        if phase == 'after' and label in ('arg-4', 'arg-5'):
            counts = read(frame, stage, 'after', 'arg-3').view('<i4')
            assert counts.shape == (12,) and np.all(counts >= 0)
            mask = np.arange(32)[:, None] < np.minimum(counts[None, :], 32)
            width = 4 if label == 'arg-4' else 16
            return value.reshape(32, 12, width)[mask].copy()
    if phase == 'before':
        overwritten = {'rhs-initialize': {'arg-9'}, 'CG-product': {'arg-6'}, 'apply': {'arg-1'},
                       'authored-bonds': {'arg-12'}, 'dynamic-bonds': {'arg-12'}, 'inverse-block': {'arg-3'}}
        if label in overwritten.get(kind, set()):
            return None
        raw = stage['node']['parameter_hex']
        if kind == 'CG-precondition' and label == 'arg-2' and int.from_bytes(bytes.fromhex(raw[3]), 'little') == 0:
            return None
        if kind == 'CG-direction' and label == 'arg-6' and int.from_bytes(bytes.fromhex(raw[0]), 'little') == 0:
            return None
        if kind in ('authored-bonds', 'dynamic-bonds') and label in ('arg-4', 'arg-5', 'arg-6'):
            active = read(frame, stage, 'before', 'arg-7').view('<i4') != 0
            width = 8 if label == 'arg-4' else 4
            return value.reshape(len(active), width)[active].copy()
        if kind in ('rhs-initialize', 'CG-product') and label == ('arg-5' if kind == 'rhs-initialize' else 'arg-1'):
            counts = read(frame, stage, 'before', 'arg-4' if kind == 'rhs-initialize' else 'arg-0').view('<i4')
            assert counts.shape == (36,)
            mask = np.arange(2)[:, None] < np.minimum(np.maximum(counts[None, :], 0), 2)
            return value.reshape(2, 36, 8)[mask].copy()
    return value


def first_word(left, right):
    assert left.shape == right.shape and left.dtype == right.dtype == np.dtype('u1')
    index = int(np.flatnonzero(left.reshape(-1) != right.reshape(-1))[0])
    a, b = left.reshape(-1), right.reshape(-1)
    row = {'first_byte_offset': index}
    if len(a) % 4 == 0:
        word = index // 4
        row.update(first_word_index=word, original_bits=int(a.view('<u4')[word]), source_bits=int(b.view('<u4')[word]))
    return row


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--phase', type=Path, required=True)
    args = parser.parse_args()
    base = args.phase.resolve()
    capture = base / 'rhs-captures-v2'
    terminal = json.loads((capture / 'status.json').read_text())
    assert terminal['complete'] and len(terminal['completed']) == 4
    assert all(row['actual_exit'] == 0 for row in terminal['completed'])
    plan = json.loads((capture / 'plan.json').read_text())
    hashes = dict(plan['input_sha256'])
    hashes[str(Path(__file__))] = sha(Path(__file__))
    layouts, stage_checks, public_checks, alias_checks = {}, 0, 0, 0
    for worker in range(4):
        folder = capture / str(worker)
        provenance_path = folder / 'provenance.json'
        provenance = json.loads(provenance_path.read_text())
        hashes[str(provenance_path)] = sha(provenance_path)
        assert provenance['complete'] and provenance['frames_read'] == [30, 30]
        assert provenance['original_SDK_mapped'] == (worker == 0)
        backend = 'original' if worker == 0 else 'source'
        public_path = folder / (backend + '-' + plan['target'] + '-1.npz')
        hashes[str(public_path)] = sha(public_path)
        with np.load(public_path, allow_pickle=False) as public:
            assert public['particle_q'].shape == (60, 36, 3)
            for graph in range(2):
                directory = folder / ('rhs-graph-' + str(graph))
                layout_path = directory / 'snapshot-layout.json'
                before_path = directory / 'definition-before/graph.json'
                after_path = directory / 'graph-after-topology.json'
                hashes.update({str(p): sha(p) for p in (layout_path, before_path, after_path)})
                layout = json.loads(layout_path.read_text())
                before = json.loads(before_path.read_text())
                after = json.loads(after_path.read_text())
                ordered = linear_order(before)[0]
                assert select_stages(ordered) == layout['stages']
                positions = {n['handle']: i for i, n in enumerate(linear_order(after)[0])}
                assert len(after['nodes']) == 960 and len(after['edges']) == 1139
                assert set(map(tuple, before['edges'])) <= set(map(tuple, after['edges']))
                assert layout['total_snapshot_bytes'] == 324984 and layout['graph_nodes_added'] == 684
                for stage in layout['stages']:
                    previous, target, following = (ordered[stage['rank'] + d]['handle'] for d in (-1, 0, 1))
                    for row in layout['snapshots']:
                        if row['stage'] == stage['key']:
                            assert positions[previous] < positions[row['node']] < positions[target] if (
                                row['phase'] == 'before') else positions[target] < positions[row['node']] < positions[following]
                layouts[worker, graph] = layout
                paths = sorted((directory / 'frames').glob('frame-*.npz'))
                assert len(paths) == 30
                for frame, path in zip(range(graph, 60, 2), paths):
                    assert path.name == f'frame-{frame:02d}.npz'
                    hashes[str(path)] = sha(path)
                    with np.load(path, allow_pickle=False) as data:
                        expected = {r['stage'] + '/' + r['phase'] + '/' + r['label'] for r in layout['snapshots']}
                        assert set(data.files) == expected
                        for stage in layout['stages']:
                            addresses = {b['label']: b['address'] for b in stage['bindings']}
                            payloads = {}
                            for binding in stage['bindings']:
                                value = read(data, stage, 'before', binding['label'])
                                assert value.dtype == np.dtype('u1') and value.shape == (binding['bytes'],)
                                payloads[binding['label']] = value.tobytes()
                            groups = span_groups(addresses, payloads)
                            alias_checks += sum(len(g['indices']) > 1 for g in groups)
                            for label in stage['outputs']:
                                assert read(data, stage, 'after', label).shape == (len(payloads[label]),)
                            stage_checks += 1
                        final = next(s for s in reversed(layout['stages']) if s['kind'] == 'apply')
                        assert read(data, final, 'after', 'arg-1').tobytes() == public['particle_q'][frame].tobytes()
                        public_checks += 1
    assert stage_checks == 21600 and public_checks == 240
    comparisons, selected_frames = [], {0, 32}
    for worker in (1, 2, 3):
        first_numeric, first_apply, first_observed, differing_outputs = None, None, None, 0
        for frame in range(60):
            graph = frame % 2
            left_layout, right_layout = layouts[0, graph], layouts[worker, graph]
            name = f'frame-{frame:02d}.npz'
            paths = [capture / str(w) / f'rhs-graph-{graph}/frames' / name for w in (0, worker)]
            with np.load(paths[0], allow_pickle=False) as left, np.load(paths[1], allow_pickle=False) as right:
                for a, b in zip(left_layout['stages'], right_layout['stages']):
                    assert a['key'] == b['key'] and a['node']['name'] == b['node']['name']
                    before_differences = []
                    for binding in a['bindings']:
                        label = binding['label']
                        x, y = meaningful(left, a, 'before', label), meaningful(right, b, 'before', label)
                        if x is not None and (x.shape != y.shape or x.tobytes() != y.tobytes()):
                            before_differences.append(label)
                    if before_differences and first_observed is None:
                        first_observed = {'frame': frame, 'stage': a['key'], 'labels': before_differences}
                    for label in a['outputs']:
                        x, y = meaningful(left, a, 'after', label), meaningful(right, b, 'after', label)
                        equal = x.shape == y.shape and x.tobytes() == y.tobytes()
                        differing_outputs += not equal
                        primary = not (a['kind'] == 'grain-contacts' and label in ('arg-3', 'arg-4', 'arg-5'))
                        if not equal and primary and first_numeric is None:
                            assert x.shape == y.shape
                            first_numeric = {'frame': frame, 'stage': a['key'], 'kind': a['kind'], 'label': label,
                                             'before_differing_observed_labels': before_differences,
                                             'all_flat_inputs_captured': a['all_flat_pointer_inputs_captured'],
                                             **first_word(x, y)}
                        if not equal and a['kind'] == 'apply' and label == 'arg-1' and first_apply is None:
                            first_apply = {'frame': frame, 'stage': a['key'], **first_word(x, y)}
        for item in (first_numeric, first_apply):
            if item is not None:
                selected_frames.add(item['frame'])
        comparisons.append({'source_worker': worker, 'first_numeric_output_difference': first_numeric,
                            'first_apply_position_difference': first_apply, 'first_observed_before_difference': first_observed,
                            'differing_defined_output_packets': differing_outputs,
                            'not_the_original_frozen_failure_path': True})
    old = base.parent / 'continuation-20261101-0dabbaa7-granular-affine-contacts'
    cohort = old / 'graph-fixed-C8/cohorts' / (plan['target'] + '-g1')
    trajectories = []
    with ExitStack() as stack:
        originals = [stack.enter_context(np.load(cohort / f'original{i}.npz', allow_pickle=False)) for i in range(8)]
        for worker, backend in enumerate(('original', 'source', 'source', 'source')):
            path = capture / str(worker) / (backend + '-' + plan['target'] + '-1.npz')
            data = stack.enter_context(np.load(path, allow_pickle=False))
            assert all(len(data[k]) == 60 and np.isfinite(data[k]).all() for k in data.files)
            stats = spread_report(originals, [data])
            trajectories.append({'worker': worker, 'backend': backend, 'statistics': stats,
                                 'within_existing_C8': all(v['substeps_within_spread'] == 60 for v in stats.values())})
    hashes.update({str(p): sha(p) for p in cohort.glob('*.npz')})
    for path, expected in hashes.items():
        assert sha(Path(path)) == expected, path
    record = {'stage_packets_checked': stage_checks, 'public_q_matches': public_checks, 'alias_groups_checked': alias_checks,
              'input_sha256': hashes, 'comparisons': comparisons, 'diagnostic_trajectory_C8_checks': trajectories,
              'selected_replay_frames': sorted(selected_frames),
              'selection_rule': 'Frame0 and32 plus each source first numeric output difference and first apply difference',
              'unused_cache_tails_and_overwritten_inputs_excluded_from_semantic_comparison': True,
              'minimal_contact_snapshots_are_not_full_input_proofs': True, 'GPU_used': False,
              'fixed_cohorts_expanded': False, 'fixed_failure_reclassified': False, 'whole_solver_complete': False}
    (base / 'rhs-independent-cpu-audit.json').write_text(json.dumps(record, indent=2) + '\n')
    print(json.dumps(comparisons, indent=2))
    print('CPU:21600 stage packets,240 public q checks;selected replay frames', sorted(selected_frames), flush=True)


if __name__ == '__main__':
    main()
