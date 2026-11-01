"""Independently match raw typed fields with a two-way address map and check recorded copy/fill span offsets."""
from collections import Counter
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

root = Path.cwd()
sys.path.insert(0, str(root))
from reconstruction.csrc.audit_cudahook import SCALAR_WORDS, schemas

base = Path(__file__).resolve().parent
plan = json.loads((base / 'plan.json').read_text())
for name, digest in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
status = json.loads((base / 'status.json').read_text())
assert status['complete'] and status['completed'] == [
    {'backend': 'original', 'exit': 0}, {'backend': 'source', 'exit': 0}]
graphs = [json.loads((base / tag / 'worker/definition-0/graph.json').read_text())
          for tag in ('original', 'source')]


def chain(graph):
    nodes = {node['handle']: node for node in graph['nodes']}
    predecessor, successor = {}, {}
    for source, target in graph['edges']:
        assert target not in predecessor and source not in successor
        predecessor[target], successor[source] = source, target
    roots = set(nodes) - set(predecessor)
    assert len(roots) == 1
    result = [nodes[roots.pop()]]
    while result[-1]['handle'] in successor:
        result.append(nodes[successor[result[-1]['handle']]])
        assert len(result) <= len(nodes)
    assert len(result) == len(nodes) and len(successor) + 1 == len(nodes)
    return result


ordered = [chain(graph) for graph in graphs]
assert len(ordered[0]) == len(ordered[1])
layout = schemas()[0]
warp = json.loads((base / 'warp-schema.json').read_text())
forward, reverse = {}, {}
counts = Counter()
spans = []


def pointer(left, right, domain='device'):
    left, right = int(left), int(right)
    assert bool(left) == bool(right)
    counts['pointer_field_occurrences'] += 1
    if not left:
        return
    old, new = (domain, left), (domain, right)
    assert forward.setdefault(old, new) == new
    assert reverse.setdefault(new, old) == old


def scalar(left, right):
    assert left == right
    counts['scalar_fields'] += 1


for rank, (left, right) in enumerate(zip(*ordered)):
    assert left['type'] == right['type']
    kind = left['type']
    if kind == 0:
        for field in ('name', 'geometry', 'parameter_offsets', 'parameter_widths', 'owned_kernel'):
            assert left[field] == right[field], (rank, field)
        raw = [[bytes.fromhex(value) for value in node['parameter_hex']] for node in (left, right)]
        assert len(raw[0]) == len(raw[1]) == len(left['parameter_widths'])
        for index, (old, new, width) in enumerate(zip(*raw, left['parameter_widths'])):
            assert len(old) == len(new) == width
            if left['owned_kernel']:
                kind_code = layout[left['name']][index]
                if kind_code == 'pointer':
                    pointer(int.from_bytes(old, 'little'), int.from_bytes(new, 'little'))
                elif kind_code in SCALAR_WORDS:
                    for offset in range(0, width, 8):
                        a, b = (int.from_bytes(value[offset:offset + 8], 'little') for value in (old, new))
                        if offset in SCALAR_WORDS[kind_code]:
                            mask = 0xffffffffffffffff
                            if (kind_code, offset) in (('U', 288), ('W', 112)):
                                mask = 0xffffffff
                            if (kind_code, offset) == ('H', 248):
                                mask = 0x00ffffffffffffff
                            scalar(a & mask, b & mask)
                        else:
                            pointer(a, b)
                else:
                    assert kind_code != 'M'
                    scalar(old, new)
            else:
                description = warp['kernels'][left['name']][index]
                assert description['width'] == width
                for field in description['fields']:
                    offset, length = field['offset'], field['size']
                    a, b = old[offset:offset + length], new[offset:offset + length]
                    if field['kind'] == 'pointer':
                        pointer(int.from_bytes(a, 'little'), int.from_bytes(b, 'little'))
                    else:
                        scalar(a, b)
        counts['kernel_nodes'] += 1
    elif kind in (1, 2):
        a, b = left['parameters'], right['parameters']
        assert set(a) == set(b)
        for field in a:
            if kind == 1 and field.endswith(('Host', 'Device', 'Array')):
                domain = {'Host': 'host', 'Device': 'device', 'Array': 'array'}[field[3:]]
                pointer(a[field], b[field], domain)
            elif kind == 2 and field == 'dst':
                pointer(a[field], b[field])
            else:
                scalar(a[field], b[field])
        if kind == 1:
            assert a['Height'] == a['Depth'] == 1
            assert all(a[prefix + axis] == 0 for prefix in ('src', 'dst') for axis in ('XInBytes', 'Y', 'Z'))
            for prefix in ('src', 'dst'):
                assert a[prefix + 'MemoryType'] == b[prefix + 'MemoryType'] == 2
                spans.append((rank, prefix, a[prefix + 'Device'], b[prefix + 'Device'], a['WidthInBytes']))
        else:
            assert a['height'] == 1
            spans.append((rank, 'dst', a['dst'], b['dst'], a['width'] * a['elementSize']))
        counts['copy_nodes' if kind == 1 else 'fill_nodes'] += 1
    else:
        raise ValueError(f'Unexpected graph node type {kind}')

offset_checks = 0
inside_checks = 0
for (domain, old), (_, new) in forward.items():
    if domain != 'device':
        continue
    for rank, role, left, right, length in spans:
        a = old - left if 0 <= old - left < length else None
        b = new - right if 0 <= new - right < length else None
        assert a == b, (domain, old, new, rank, role, length, a, b)
        offset_checks += 1
        inside_checks += a is not None

fixed = base.parent / 'continuation-20261101-38b70dcd-g1-public-core/graph60-fixed-original-C8'
fixed_report = fixed / 'report.json'
assert hashlib.sha256(fixed_report.read_bytes()).hexdigest() == status['fixed_source_C8_report_sha256']
paths = json.loads(fixed_report.read_text())['input_npz_paths']
diagnostics = json.loads((base / 'diagnostic-trajectories.json').read_text())
with ExitStack() as stack:
    native = [stack.enter_context(np.load(paths['original' + str(index)])) for index in range(8)]
    for backend in ('original', 'source'):
        folder = base / backend
        provenance = json.loads((folder / 'provenance.json').read_text())
        for file, key in (('worker-as-run.py', 'patched_worker_sha256'),):
            assert hashlib.sha256((folder / file).read_bytes()).hexdigest() == provenance[key]
        runtime = json.loads((folder / 'worker/runtime.json').read_text())
        assert runtime['exit'] == 0 and runtime['public_core_abi'] and runtime['real_graph_observed']
        assert not runtime['ab_bridge_used'] and runtime['reference_solver_mapped'] == (backend == 'original')
        run = stack.enter_context(np.load(folder / 'worker/states.npz'))
        for key in run.files:
            assert len(run[key]) == 60 and np.isfinite(run[key]).all()
            values = np.stack([item[key].astype(np.float64) for item in native])
            candidate = run[key].astype(np.float64)
            total = values.sum(axis=0)
            axes = tuple(range(1, candidate.ndim))
            spread = np.maximum.reduce([
                np.abs(values[index] - (total - values[index]) / 7).max(axis=axes) for index in range(8)])
            error = np.abs(candidate - total / 8).max(axis=axes)
            saved = diagnostics[backend]['statistics'][key]
            assert int(np.count_nonzero(error <= spread)) == saved['substeps_within_spread']
            assert float(error.max()) == saved['reconstruction_error_max']
            assert float(spread.max()) == saved['legacy_spread_max']
            assert np.flatnonzero(error > spread).tolist() == diagnostics[backend]['outside_fields'][key]['frames']

result = {'counts': dict(counts), 'two_way_pointer_pairs': len(forward),
          'recorded_copy_fill_spans': len(spans), 'pointer_span_membership_offset_checks': offset_checks,
          'pointer_inside_recorded_span_checks': inside_checks,
          'typed_fields_and_pointer_bijection_equal': True,
          'relative_offsets_within_recorded_copy_fill_spans_equal': True,
          'full_allocation_boundaries_checked': False, 'device_pointees_compared': False,
          'diagnostic_C_statistics_independently_recomputed': True,
          'fixed_source_C8_report_sha256': status['fixed_source_C8_report_sha256'],
          'frozen_source_failure_reclassified': False, 'whole_solver_complete': False,
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(base / 'pointer-bijection.json').write_text(json.dumps([
    {'domain': domain, 'original': old, 'source': forward[(domain, old)][1]}
    for domain, old in forward], indent=2) + '\n')
(base / 'independent-cpu-audit.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(result, indent=2))
