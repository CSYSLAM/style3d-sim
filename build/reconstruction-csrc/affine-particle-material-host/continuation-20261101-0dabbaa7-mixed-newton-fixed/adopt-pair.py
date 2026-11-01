"""Copy the first planned diagnostics reproducing both frozen targets; retain every other diagnostic."""
import hashlib
import json
from pathlib import Path
import shutil

BASE = Path(__file__).resolve().parent
capture = BASE / 'traces4'
status = json.loads((capture / 'status.json').read_text())
assert status['complete'] and all(row['actual_exit'] == 0 for row in status['completed'])
output = BASE / 'frozen-reproduced-mixed-pair'
output.mkdir(exist_ok=False)
(output / 'solver-build.json').write_bytes((capture / 'solver-build.json').read_bytes())
selected = {}
for side, reference in (('legacy', 'original0'), ('source', 'source0')):
    matches = [row for row in status['completed'] if row['backend'] == side and
               row[reference + '_target']['all_arrays_bitwise'] and row['captured_outputs_match_public_states']]
    assert matches, (side, 'No planned diagnostic reproduced the frozen target')
    chosen = matches[0]['index']
    shutil.copytree(capture / str(chosen), output / side)
    selected[side] = {'planned_run_index': chosen, 'copied_from': str(capture / str(chosen)),
                      'target_arrays_bitwise': 18}
files = {str(path.relative_to(output)): hashlib.sha256(path.read_bytes()).hexdigest()
         for path in sorted(output.rglob('*')) if path.is_file()}
record = {'selected': selected, 'files': files, 'original_captures_retained': True,
          'fixed_cohort_expanded': False, 'frozen_source0_replaced': False, 'whole_solver_complete': False}
(output / 'adopted.json').write_text(json.dumps(record, indent=2) + '\n')
print('Adopted current frozen-target pair:', selected)
