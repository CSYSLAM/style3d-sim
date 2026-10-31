"""Complete exact float32 sum certificates on CPU; never alter solver outputs or accept an unexplained target."""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path

import numpy as np


def result_bits(initial, values, order):
    sequence = np.empty(len(order) + 1, dtype='f4')
    sequence[0], sequence[1:] = initial, values[order]
    return int(np.add.accumulate(sequence, dtype='f4')[-1].view('u4'))


def find_order(initial, values, target, seed):
    n = len(values)
    orders = [np.arange(n), np.arange(n)[::-1], np.argsort(values), np.argsort(-values),
              np.argsort(abs(values)), np.argsort(-abs(values))]
    for order in orders:
        if result_bits(initial, values, order) == target:
            return order.tolist()
    nonzero, zeros = np.flatnonzero(values != 0), np.flatnonzero(values == 0)
    if len(nonzero) <= 16:
        # Exhaustive subset states retain every reachable rounded partial sum, including rare extreme orders.
        v, count = values[nonzero], len(nonzero)
        states = [{} for _ in range(1 << count)]
        states[0][int(initial.view('u4'))] = ()
        for mask in range((1 << count) - 1):
            for bits, path in states[mask].items():
                s = np.asarray(bits, dtype='u4').view('f4')[()]
                for j in range(count):
                    if not (mask >> j & 1):
                        bits = int(np.float32(s + v[j]).view('u4'))
                        states[mask | (1 << j)].setdefault(bits, path + (j,))
        if target in states[-1]:
            order = np.concatenate((nonzero[np.array(states[-1][target], dtype='i4')], zeros))
            if result_bits(initial, values, order) == target:
                return order.tolist()
        return None
    rng = np.random.default_rng(seed)
    wanted = np.asarray(target, dtype='u4').view('f4')[()]
    best_distance, best = 2**32, nonzero.copy()
    # Search only permutation space. The recorded initial value and every actual atomic operand stay immutable.
    for trial in range(64):
        remaining, order, s = nonzero.copy(), [], initial
        total = np.sum(values[remaining], dtype='f8')
        while len(remaining):
            v = values[remaining]
            candidate = np.add(s, v, dtype='f4')
            errors = candidate.astype('f8') - (np.float64(s) + v.astype('f8'))
            desired = (np.float64(wanted) - np.float64(s) - total) / len(remaining)
            scores = abs(errors - desired)
            near = np.flatnonzero(scores <= scores.min() + max(1e-12, float(scores.min()) * .02))
            if trial % 2 == 0:
                large = abs(candidate[near])
                near = near[large >= large.max() * .75]
            j = int(rng.choice(near))
            s = candidate[j]
            total -= np.float64(v[j])
            order.append(int(remaining[j]))
            remaining = np.delete(remaining, j)
        distance = abs(int(s.view('u4')) - target)
        if distance < best_distance:
            best_distance, best = distance, np.asarray(order, dtype='i4')
        if not distance:
            return order + zeros.tolist()
    for batch in range(128):
        orders = np.tile(best, (512, 1))
        for _ in range(1 + batch % 3):
            a, b = rng.integers(0, len(best), (2, len(orders)))
            i = np.arange(len(orders))
            orders[i, a], orders[i, b] = orders[i, b].copy(), orders[i, a].copy()
        sequence = np.concatenate((np.full((len(orders), 1), initial, dtype='f4'), values[orders]), axis=1)
        sums = np.add.accumulate(sequence, axis=1, dtype='f4')[:, -1].view('u4')
        matched = np.flatnonzero(sums == target)
        if len(matched):
            return orders[matched[0]].tolist() + zeros.tolist()
        distances = abs(sums.astype('i8') - target)
        candidates = np.flatnonzero(distances == distances.min())
        if distances.min() <= best_distance:
            best = orders[int(rng.choice(candidates))].copy()
            best_distance = int(distances.min())
    for trial in range(48):
        # Reserve a mixed-sign tail whose exact subset states can correct the final few rounded bits.
        selected = rng.permutation(nonzero)
        tail, remaining = selected[:13], selected[13:]
        order, s = [], initial
        total = np.sum(values[nonzero], dtype='f8')
        while len(remaining):
            v = values[remaining]
            candidate = np.add(s, v, dtype='f4')
            errors = candidate.astype('f8') - (np.float64(s) + v.astype('f8'))
            desired = (np.float64(wanted) - np.float64(s) - total) / (len(remaining) + len(tail))
            score = abs(errors - desired)
            near = np.flatnonzero(score <= score.min() + max(1e-12, float(score.min()) * .05))
            j = int(rng.choice(near))
            s = candidate[j]
            total -= np.float64(v[j])
            order.append(int(remaining[j]))
            remaining = np.delete(remaining, j)
        suffix = find_order(s, values[tail], target, seed + trial + 1)
        if suffix is not None:
            full = order + tail[np.asarray(suffix)].tolist() + zeros.tolist()
            if result_bits(initial, values, full) == target:
                return full
    return None


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--replay', type=Path, required=True)
    parser.add_argument('--capture', type=Path, required=True)
    parser.add_argument('--source-capture', type=Path)
    parser.add_argument('--resume', type=Path, help='Reuse only previously verified exact certificates')
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert not args.output.exists()
    report = json.loads((args.replay / 'report.json').read_text())
    assert report['operation'] == 'force' and report['all_isolated_contact_outputs_equal']
    assert report['all_per_contact_atomic_operand_sequences_identical']
    with np.load(args.replay / 'outputs.npz') as arrays:
        before = arrays['before'].copy()
    trace = json.loads((args.replay / 'atomic-operands.json').read_text())['original']['thread_operands']
    terms = [[] for _ in before]
    for row in trace:
        for index, bits in row:
            terms[index].append(bits)
    values = [np.asarray(row, dtype='u4').view('f4') for row in terms]
    targets = {name: np.asarray([row['target_bits'] for row in rows], dtype='u4')
               for name, rows in report['witnesses'].items()}
    initials = {name: before for name in targets}
    packet_audit = None
    if args.source_capture:
        folders = (args.capture, args.source_capture)
        fields = json.loads((folders[0] / 'fields.json').read_text())
        assert fields == json.loads((folders[1] / 'fields.json').read_text())
        payloads = [{int(k): (folder / f'dump_30evaluate_surface_contact_force_pre_arg0'
                    f'{"_offset" + k if int(k) else ""}.bin').read_bytes() for k in fields} for folder in folders]
        contact_fields = {16: 12, 24: 12, 32: 4, 40: 12, 48: 12, 56: 12}
        records = [[b''.join(data[k][i*s:(i+1)*s] for k, s in contact_fields.items())
                    for i in range(report['contacts'])] for data in payloads]
        same = Counter(records[0]) == Counter(records[1])
        readonly = {str(k): payloads[0][k] == payloads[1][k] for k in payloads[0] if k not in contact_fields}
        assert same and all(readonly.values()), 'Source capture has different force operands'
        runtime = json.loads((args.source_capture / 'capture.runtime.json').read_text())
        assert runtime['image_sha256'] == report['source_sha256']
        source_before = np.fromfile(args.source_capture / 'dump_30evaluate_surface_contact_force_pre_arg1.bin', 'f4')
        source_after = np.fromfile(args.source_capture / 'dump_30evaluate_surface_contact_force_post_arg1.bin', 'u4')
        assert source_before.shape == source_after.shape == before.shape
        targets['source-captured'], initials['source-captured'] = source_after, source_before
        packet_audit = {'complete_record_multiset_equal': same, 'same_order': records[0] == records[1],
                        'readonly_fields_equal': readonly, 'initial_rhs_equal': before.tobytes() == source_before.tobytes()}
    known, additions = {}, []
    for name, rows in report['witnesses'].items():
        for row in rows:
            if row['exact_float32_witness']:
                index, target, order = row['scalar'], row['target_bits'], row['order']
                assert sorted(order) == list(range(len(values[index])))
                assert result_bits(before[index], values[index], order) == target
                known[index, int(before[index].view('u4')), target] = order
    if args.resume:
        previous = json.loads(args.resume.read_text())
        assert previous['source_sha256'] == report['source_sha256']
        assert previous['reference_sha256'] == report['reference_sha256']
        for row in previous['additional_certificates']:
            index, target, order = row['scalar'], row['target_bits'], row['order']
            initial = np.asarray(row['initial_bits'], dtype='u4').view('f4')[()]
            assert sorted(order) == list(range(len(values[index])))
            assert result_bits(initial, values[index], order) == target
            known[index, row['initial_bits'], target] = order
            additions.append(row)
    unresolved, counts = [], {}
    for name, target in targets.items():
        counts[name] = 0
        for index, bits in enumerate(target):
            initial, bits = initials[name][index], int(bits)
            key = index, int(initial.view('u4')), bits
            if key not in known:
                order = find_order(initial, values[index], bits, index + bits)
                if order is not None:
                    assert sorted(order) == list(range(len(values[index])))
                    assert result_bits(initial, values[index], order) == bits
                    known[key] = order
                    additions.append({'scalar': index, 'initial_bits': key[1], 'target_bits': bits, 'order': order})
                else:
                    unresolved.append({'target': name, 'scalar': index, 'bits': bits})
            counts[name] += key in known
    result = {'source_sha256': report['source_sha256'], 'reference_sha256': report['reference_sha256'],
              'output_scalars': len(before), 'exact_certificates_per_target': counts,
              'all_targets_have_exact_witness': not unresolved, 'unexplained': unresolved,
              'additional_certificates': additions, 'source_packet_audit': packet_audit,
              'GPU_used': False, 'production_order_inferred': False, 'fixed_candidate_replaced': False,
              'whole_solver_complete': False, 'harness_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
    args.output.write_text(json.dumps(result, indent=2) + '\n')
    print('exact scalar certificates', counts, 'unexplained', unresolved, flush=True)
    return int(bool(unresolved))


if __name__ == '__main__':
    raise SystemExit(main())
