"""Freeze five actual G1 graph stages and independently specialize the raw-byte CPU auditor."""
import ast
import hashlib
import json
from pathlib import Path
import re
import sys

ROOT = Path.cwd()
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_drive_state_capture import rendered_source as capture_source
from reconstruction.csrc.g1_drive_state_replay import rendered_source as replay_source
from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
from reconstruction.csrc.ptx_atomic_literal_probe import instrument256
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.audit_cudahook import parameter_types
from reconstruction.csrc.library_entries import entries
from reconstruction.csrc.ptx_store_origins_param import store_origins

BASE = Path(__file__).resolve().parent
OLD = BASE.parent / 'continuation-20261101-38b70dcd-g1-inertial-joint-so3-rhs'
assert not (BASE / 'plan.json').exists()
templates = {'capture': capture_source(), 'replay': replay_source()}
for kind, text in templates.items():
    ast.parse(text)
    assert all(len(line) <= 128 for line in text.splitlines()), kind
    (BASE / (kind + '-template.py')).write_text(text)
namespace = {'__name__': 'reconstruction.csrc.drive_state_preflight', '__package__': 'reconstruction.csrc',
             '__file__': str(BASE / 'capture-template.py')}
exec(compile(templates['capture'], str(BASE / 'capture-template.py'), 'exec'), namespace)
build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
assert build['extension_sha256'] == '38b70dcd9f3ca5053184eca9c6ec64cc33c137248a3e70efa729bd7ff0d92a49'
records, kernels, paths = {}, {}, []
for side in ('original', 'source'):
    graph = OLD / side / 'definition-before/graph.json'
    paths.append(graph)
    stages = namespace['select_stages'](linear_order(json.loads(graph.read_text()))[0], 44, 49)
    for stage in stages:
        node = stage['node']
        assert node['parameter_widths'] == build['kernels'][node['name']]['parameters']
    names = {stage['key']: stage['node']['name'] for stage in stages}
    assert not kernels or kernels == names
    kernels, records[side] = names, stages
proofs = {}
for stage in records['original']:
    key, node = stage['key'], stage['node']
    texts, original = kernel_texts(build, node['name'])
    paths.append(original)
    fields = [(i, 0) for i, kind in enumerate(parameter_types(node['name'])) if '*' in kind]
    expected = {i for i in stage['outputs']} | ({40, 41} if key == 'soft' else set())
    proofs[key] = {}
    for side, text in texts.items():
        entry = entries(text)[node['name']]
        proof = store_origins(entry, fields)
        assert set(map(tuple, proof['potential_written_pointer_fields'])) == {(i, 0) for i in expected}
        (BASE / (key + '-' + side + '-entry.ptx')).write_text(entry)
        sites = len(re.findall(r'\bred\.global\.add\.f32\b', entry))
        if key in ('drive', 'soft'):
            changed, actual = instrument256(text, node['name'])
            assert sites == actual
            (BASE / (key + '-' + side + '-instrumented-preflight.ptx')).write_text(changed)
        else:
            assert sites == 0 and not re.search(r'\b(?:red|atom)\.', entry)
        proofs[key][side] = {'store_origins': proof, 'static_atomic_sites': sites,
                             'NULL_optional_outputs': [40, 41] if key == 'soft' else []}
snapshot_count = sum(len(s['sizes']) + len(s['outputs']) for s in records['original'])
snapshot_bytes = sum(sum(s['sizes'].values()) + sum(s['sizes'][i] for i in s['outputs']) for s in records['original'])
assert snapshot_count == 79

# The second implementation of buffer schemas is deliberately independent of capture selection code.
header = '''SIZES = {
    'drive': {0: 2112, 1: 2112, 2: 172, 3: 172, 4: 172, 5: 704, 6: 172, 7: 344,
              8: 516, 9: 516, 10: 516, 11: 688, 12: 688, 13: 688, 14: 688, 15: 688,
              16: 172, 17: 172, 18: 196, 19: 196, 20: 196, 21: 196, 22: 196, 23: 196, 24: 196, 25: 196, 26: 2112},
    'soft': {0: 4, 2: 73920, 3: 73920, 4: 221760, 5: 221760, 6: 221760, 7: 704, 8: 704, 9: 704,
             12: 420, 13: 420, 14: 2940, 15: 1260, 16: 420, 17: 420, 18: 420, 19: 420, 20: 420,
             28: 176, 29: 704, 30: 528, 32: 2112, 33: 2112, 34: 2112, 36: 2112, 37: 704},
    'joint': {0: 2112, 1: 704, 2: 688, 3: 1032, 4: 1032, 5: 1376, 6: 1376, 7: 1032},
    'so3_true': {0: 2112, 1: 704, 2: 1584, 3: 1584},
    'so3_false': {0: 2112, 1: 704, 2: 1584, 3: 1584},
}
OUTPUT = {'drive': [3, 4, 26], 'soft': [36, 37], 'joint': [7], 'so3_true': [2, 3], 'so3_false': [2, 3]}
RANKS = {'drive': 14581, 'soft': 14578, 'joint': 16882, 'so3_true': 15149, 'so3_false': 17459}
WIDTHS = {'drive': [8] * 32 + [4], 'soft': [8] * 24 + [4] * 4 + [8] * 7 + [4] + [8] * 6,
          'joint': [8] * 12, 'so3_true': [8] * 4 + [1] + [8] * 3, 'so3_false': [8] * 4 + [1] + [8] * 3}
STATIC = {'drive': tuple(range(5, 23)), 'soft': (7, 8, 9, *range(12, 21), 28, 29, 30),
          'joint': tuple(range(1, 7)), 'so3_true': (1,), 'so3_false': (1,)}
SNAPSHOT_BYTES = sum(sum(v.values()) + sum(v[i] for i in OUTPUT[k]) for k, v in SIZES.items())
'''
old_audit = OLD / 'independent-cpu-audit.py'
assert hashlib.sha256(old_audit.read_bytes()).hexdigest() == 'f9d0d2cf036b317ed9358bcc50785e6f5cc22525ac5ee1ca3bd9945e3a4b24aa'
text = old_audit.read_text()
changes = []


def replace(old, new, count=1):
    global text
    assert text.count(old) == count, (old, text.count(old))
    text = text.replace(old, new)
    changes.append({'old': old, 'new': new, 'count': count})


start, end = text.index('SIZES = {'), text.index('\n\ndef digest(')
replace(text[start:end], header.rstrip())
for old, new in [('len(replay[\'packets\']) == 360', 'len(replay[\'packets\']) == 600'),
                 ('len(after) == 17494', 'len(after) == 17546'),
                 ("len(changed['edges']) == 17499", "len(changed['edges']) == 17555"),
                 ("len(layout['stages']) == 3", "len(layout['stages']) == 5"),
                 ("len(layout['snapshots']) == 27", "len(layout['snapshots']) == 79"),
                 ("node['geometry'] == [1, 1, 1, 256, 1, 1, 0]",
                  "node['geometry'] == [73 if key == 'soft' else 1, 1, 1, 256, 1, 1, 0]"),
                 ("stage['outputs'] == [OUTPUT[key]]", "stage['outputs'] == OUTPUT[key]"),
                 ("('after', OUTPUT[key])", "*(('after', i) for i in OUTPUT[key])"),
                 ('== 63728', '== SNAPSHOT_BYTES'), ('if i == out:', 'if i in outputs:'),
                 ("{str(out): pointers[out]}", "{str(i): pointers[i] for i in outputs}"),
                 ("if key != 'rhs':", "if key in ('drive', 'soft'):")]:
    replace(old, new)
start = text.index('        out = OUTPUT[key]')
end = text.index('        for i in STATIC[key]:', start)
replace(text[start:end], '''        outputs = OUTPUT[key]
        expected = {i: packet['after-arg-' + str(i)].tobytes() for i in outputs}
        assert all(len(expected[i]) == len(bindings[i]) for i in outputs)
        effective = {str(i): int(np.count_nonzero(np.frombuffer(expected[i], '<u4') !=
                                                 np.frombuffer(bindings[i], '<u4'))) for i in outputs}
        assert row['capture_effective_scalars'] == effective
        counts[key]['effective_calls'] += int(any(effective.values()))
        if key == 'so3_false':
            assert expected[3] == bindings[3]
        for i, value in effective.items():
            counts[key]['effective_output_' + i] += int(value != 0)
''')
start = text.index('            output_bytes = actual[')
end = text.index('        active = ', start)
replace(text[start:end], '''            results = {i: actual[backend + '-output-' + str(i)].tobytes() for i in outputs}
            equals = {str(i): results[i] == expected[i] for i in outputs}
            assert check['captured_output_equal'] == equals and check['all_outputs_equal'] == all(equals.values())
            for i in outputs:
                strict[key][backend + '-output-' + str(i)] += int(equals[str(i)])
            for i, (group, initial, mask) in enumerate(zip(groups, initial_groups, masks)):
                after = actual[backend + '-group-' + str(i)]
                assert after.shape == initial.shape and np.array_equal(after[mask], initial[mask])
                counts[key]['unwritten_after_bytes_rechecked'] += int(mask.sum())
                for out in outputs:
                    if out in group['indices']:
                        offset = group['start'] % 256 + values[out] - group['start']
                        assert after[offset:offset + len(bindings[out])].tobytes() == results[out]
            assert check['unwritten_bytes_unchanged']
            counts[key]['complete_vectors_rechecked'] += len(outputs)
''')
start = text.index('        active = ')
end = text.index('            full, grouped = {}, {}', start)
replace(text[start:end], '''        if key == 'soft':
            count = int.from_bytes(bindings[0], 'little', signed=True)
            active, lanes = min(max(count, 0), 18480), 18688
        else:
            count = active = {'drive': 43, 'joint': 86, 'so3_true': 44, 'so3_false': 44}[key]
            lanes = 256
        assert row['reported_lane_count'] == count and row['active_lanes'] == active and row['trace_lanes'] == lanes
        counts[key]['active_prefix_lanes'] += active
        assert row['atomic_probes_executed'] == (key in ('drive', 'soft'))
        if key not in ('drive', 'soft'):
            assert not row['atomic_operands']
        else:
''')
start = text.index('                assert sizes.shape == (1024,)')
end = text.index('                assert records.shape', start)
replace(text[start:end], '''                assert sizes.shape == (lanes,) and not sizes[active:].any() and sizes.max() <= 36
                counts[key]['probe_zero_lanes'] += int(np.count_nonzero(sizes[:active] == 0))
''')
replace('                        assert pointers[out] <= address < pointers[out] + 2112 and '
        '(address - pointers[out]) % 4 == 0\n'
        '                        target = (out, (address - pointers[out]) // 4)',
        '''                        targets_here = [(out, (address - pointers[out]) // 4) for out in outputs
                                        if pointers[out] <= address < pointers[out] + len(bindings[out])]
                        assert len(targets_here) == 1
                        target = targets_here[0]
                        assert (address - pointers[target[0]]) % 4 == 0''')
ast.parse(text)
assert all(len(line) <= 128 for line in text.splitlines())
(BASE / 'independent-cpu-audit.py').write_text(text)
(BASE / 'audit-generation.json').write_text(json.dumps({'base_sha256': hashlib.sha256(old_audit.read_bytes()).hexdigest(),
                                                       'changes': changes,
                                                       'generated_sha256': hashlib.sha256(text.encode()).hexdigest()},
                                                      indent=2) + '\n')
for name, old_module, new_module in [('run-captures.py', 'g1_al_rhs_capture', 'g1_drive_state_capture'),
                                     ('run-replay.py', 'g1_al_rhs_replay', 'g1_drive_state_replay')]:
    path = OLD / name
    paths.append(path)
    script = path.read_text()
    assert script.count(old_module) == 1
    script = script.replace(old_module, new_module)
    script = script.replace('60 packets for each inertial/joint/SO3 stage', '60 packets for each drive/soft/AL state stage')
    (BASE / name).write_text(script)
hashes = dict(json.loads((OLD / 'plan.json').read_text())['input_sha256'])
paths += [Path(__file__), ROOT / 'reconstruction/csrc/g1_drive_state_capture.py',
          ROOT / 'reconstruction/csrc/g1_drive_state_replay.py']
paths += [BASE / name for name in ('capture-template.py', 'replay-template.py', 'independent-cpu-audit.py',
                                  'run-captures.py', 'run-replay.py')]
for path in paths:
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
(BASE / 'CPU-layout-preflight.json').write_text(json.dumps({
    'stages': records, 'proofs': proofs, 'snapshot_count': snapshot_count, 'snapshot_bytes': snapshot_bytes,
    'expected_graph_nodes': 17467 + snapshot_count, 'expected_graph_edges': 17466 + snapshot_count + 10,
    'GPU_context_created': False, 'whole_solver_complete': False,
}, indent=2) + '\n')
(BASE / 'plan.json').write_text(json.dumps({
    'previous_goal_turn': 'progress: published 8d1ca532 and verified249653 frozen files with zero failures',
    'frames': 60, 'backends': ['original', 'source'], 'kernels': kernels, 'input_sha256': hashes,
    'actual_before_and_after_required': True, 'strict_first_additional_isolation_only_if_needed': True,
    'frozen_cohort_extended': False, 'production_changed': False, 'whole_solver_complete': False,
}, indent=2) + '\n')
print('CPU preflight passed:', snapshot_count, 'snapshots,', snapshot_bytes, 'bytes', flush=True)
