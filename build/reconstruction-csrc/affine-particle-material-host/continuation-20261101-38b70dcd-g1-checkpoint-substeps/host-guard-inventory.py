"""Inventory remaining reconstruction coverage guards from the exact compiled host source, without executing them."""
import hashlib
import json
from pathlib import Path
import re

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
name = 'reconstruction/csrc/native/source_solver.cpp'
source = ROOT / name
build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
digest = hashlib.sha256(source.read_bytes()).hexdigest()
assert build['sources'][name] == digest
text = source.read_text()
lines, rows = text.splitlines(), []
for match in re.finditer(r'throw std::runtime_error\("([^"\n]+)"\);', text):
    message = match[1]
    if not any(token in message for token in ('captur', 'implement', 'supports static shapes')):
        continue
    line = text.count('\n', 0, match.start()) + 1
    rows.append({'line': line, 'message': message,
                 'context_first_line': max(1, line - 8),
                 'context': '\n'.join(lines[max(0, line - 9):line + 1])})
assert rows
output = BASE / 'host-guard-inventory.json'
assert not output.exists()
output.write_text(json.dumps({
    'source': name, 'source_sha256': digest, 'compiled_host_sha256': build['extension_sha256'],
    'guards': rows, 'count': len(rows), 'static_source_inventory_only': True,
    'conditions_reachability_or_SDK_support_not_proven': True,
    'guard_count_is_not_a_remaining_work_estimate': True,
    'guards_not_removed': True, 'production_changed': False, 'whole_solver_complete': False,
}, indent=2) + '\n')
print('Inventoried', len(rows), 'static coverage guard sites from the exact compiled host source')
