"""Record virtual-register/text differences and inspect the next authentic G1 stages without GPU execution."""
import difflib
import hashlib
import json
from pathlib import Path
import re
import sys

sys.path.insert(0, str(Path.cwd()))
from reconstruction.csrc.audit_cudahook import parameter_types
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.ptx_compare import normalise

BASE = Path(__file__).resolve().parent
texts = {side: (BASE / ('joint-' + side + '-entry.ptx')).read_text() for side in ('original', 'source')}
arithmetic = {}
for side, text in texts.items():
    arithmetic[side] = [re.sub(r'\s+', ' ', line.strip()) for line in text.splitlines()
                        if re.match(r'^\s*(?:add|sub|mul|fma|neg|div|rcp|sqrt|rsqrt|abs|min|max|cvt|setp|selp)\.', line)
                        and re.search(r'\.f32\s', line)]
diff = '\n'.join(difflib.unified_diff(normalise(texts['original']).splitlines(),
                                     normalise(texts['source']).splitlines(), 'original', 'source')) + '\n'
(BASE / 'joint-normalized.diff').write_text(diff)
report = {
    'virtual_register_declarations': {side: re.findall(r'\.reg[^;]+;', text) for side, text in texts.items()},
    'F32_arithmetic_lines': arithmetic, 'F32_arithmetic_register_text_equal': arithmetic['original'] == arithmetic['source'],
    'normalized_PTX_equal': normalise(texts['original']) == normalise(texts['source']),
    'physical_register_usage_not_inferred_from_PTX_declarations': True,
    'whole_schedule_or_trajectory_equality_not_inferred': True, 'whole_solver_complete': False,
}
(BASE / 'joint-PTX-diagnostic.json').write_text(json.dumps(report, indent=2) + '\n')
inspected = {}
tokens = ('25evaluate_joint_drive_loadE', '30evaluate_soft_body_contact_forceE',
          '51update_joint_body_spring_augmented_lagrangian_stateE',
          '48update_affine_body_so3_augmented_lagrangian_stateE')
for side in ('original', 'source'):
    path = BASE / side / 'definition-before/graph.json'
    nodes = linear_order(json.loads(path.read_text()))[0]
    rows = []
    for token in tokens:
        matches = [(i, node) for i, node in enumerate(nodes) if i >= 14567 and token in node.get('name', '')]
        if not matches:
            # Preserve the exact symbol inventory rather than guessing a mangled-name length.
            stem = token.split('E')[0].lstrip('0123456789')
            matches = [(i, node) for i, node in enumerate(nodes) if i >= 14567 and stem in node.get('name', '')]
        assert matches, token
        rank, node = matches[0] if 'drive_load' in token or 'contact_force' in token else matches[-1]
        rows.append({'rank': rank, 'calls_in_last_substep': len(matches), 'node': node,
                     'parameter_types': parameter_types(node['name']), 'GPU_replay_done': False})
    inspected[side] = {'graph_sha256': hashlib.sha256(path.read_bytes()).hexdigest(), 'stages': rows}
(BASE / 'next-drive-and-AL-state-inspection.json').write_text(json.dumps({
    'backends': inspected, 'inspection_only_not_execution_proof': True, 'whole_solver_complete': False,
}, indent=2) + '\n')
print('Joint F32 arithmetic text equal:', report['F32_arithmetic_register_text_equal'], flush=True)
print('Next-stage ranks:', {side: [r['rank'] for r in row['stages']] for side, row in inspected.items()}, flush=True)
