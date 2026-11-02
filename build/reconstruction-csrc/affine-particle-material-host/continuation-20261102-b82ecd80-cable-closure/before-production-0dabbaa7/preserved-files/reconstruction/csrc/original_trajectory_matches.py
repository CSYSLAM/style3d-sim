"""Find exact recorded-original trajectory matches under the same image, inputs and bounded dump protocol.

This checks existence of a real matching reference trajectory. It does not form a new statistical cohort,
count duplicate capture files as independent runs, or reclassify an earlier primary-C failure.
"""
import argparse
import hashlib
import json
from pathlib import Path

import numpy as np

from .host_api_probe import REFERENCE_SHA


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cohort', type=Path, required=True)
    parser.add_argument('--search-root', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.cohort = args.cohort.resolve(strict=True)
    args.search_root = args.search_root.resolve(strict=True)
    expected = json.loads((args.cohort/'source0.runtime.json').read_text())
    assert expected['backend'] == 'source'
    protocol = json.loads((args.cohort/'launch-dump-spec.json').read_text())
    fields = ('image_sha256', 'example_sha256', 'frames', 'extra', 'launch_hook_sha256')
    original_fields = {key: expected[key] for key in fields}
    original_fields['image_sha256'] = REFERENCE_SHA
    originals = []
    for path in sorted(args.search_root.rglob('original*.runtime.json')):
        runtime = json.loads(path.read_text())
        if runtime.get('backend') != 'original' or any(runtime.get(k) != v for k, v in original_fields.items()):
            continue
        dumpfile = path.parent/'launch-dump-spec.json'
        if not dumpfile.exists():
            continue
        dump = json.loads(dumpfile.read_text())
        if dump['fields'] != protocol['fields'] or dump['dump_limit'] != protocol['dump_limit']:
            continue
        npz = path.with_name(path.name.removesuffix('.runtime.json')+'.npz')
        if npz.exists():
            originals.append((path, dumpfile, npz))
    results = {}
    for tag in ('source0', 'source1', 'source2'):
        runtime = json.loads((args.cohort/(tag+'.runtime.json')).read_text())
        assert all(runtime[key] == expected[key] for key in (*fields, 'backend'))
        source = args.cohort/(tag+'.npz')
        matches = []
        with np.load(source) as new:
            assert all(np.isfinite(new[key]).all() for key in new.files)
            for runtime_file, dumpfile, npz in originals:
                with np.load(npz) as old:
                    equal = set(new.files) == set(old.files) and all(
                        new[key].dtype == old[key].dtype and new[key].shape == old[key].shape and
                        new[key].tobytes() == old[key].tobytes() for key in new.files)
                if equal:
                    matches.append({'npz': str(npz), 'sha256': digest(npz), 'runtime': str(runtime_file),
                                    'runtime_sha256': digest(runtime_file), 'protocol_sha256': digest(dumpfile)})
        results[tag] = {'source_sha256': digest(source), 'exact_original_matches': matches,
                        'matches_actual_original': bool(matches)}
    report = {'reference_fields': original_fields, 'dump_fields': protocol['fields'],
              'dump_limit': protocol['dump_limit'], 'source_image_sha256': expected['image_sha256'],
              'matching_protocol_files_scanned': len(originals), 'file_count_is_not_independent_run_count': True,
              'first_candidates_replaced': False, 'primary_c_failure_reclassified': False,
              'launch_metadata_compared': False, 'full_solver_complete': False, 'results': results,
              'auditor_sha256': digest(Path(__file__))}
    assert not args.output.exists(), 'Preserve earlier evidence'
    args.output.write_text(json.dumps(report, indent=2)+'\n')
    print('Exact actual-original trajectory matches',
          {tag: row['matches_actual_original'] for tag, row in results.items()}, flush=True)
    return int(not all(row['matches_actual_original'] for row in results.values()))


if __name__ == '__main__':
    raise SystemExit(main())
