"""Check fixed first material candidates against eight originals; stop at a real primary-C or ABI failure."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

from .audit_cudahook import compare, schemas
from .demo_source_ab import ROOT


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--validation', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--original-runs', type=int, default=8)
    parser.add_argument('--previous-results', type=Path, help='Reuse already fixed cohorts from this same source image')
    parser.add_argument('--keep-going', action='store_true', help='Record each primary-C failure and check remaining cases')
    args = parser.parse_args()
    assert args.original_runs >= 5
    args.validation = args.validation.resolve(strict=True)
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    manifest = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = manifest.read_bytes()
    digest = json.loads(saved)['extension_sha256']
    assert json.loads((args.validation/'build.json').read_text())['extension_sha256'] == digest
    if args.previous_results:
        args.previous_results = args.previous_results.resolve(strict=True)
        assert json.loads((args.previous_results/'status.json').read_text())['source_sha256'] == digest
    groups = ('previous-failures6', 'material26', 'previous-pp-failures2', 'material-pp14', 'material-cloth-contact8')
    candidates = []
    for group in groups:
        report = json.loads((args.validation/group/'report.json').read_text())
        for row in report['cases']:
            assert row['worker_exit'] == 0 and row['metadata']['equal'] and row['coverage'] and row['finite']
            assert all(row['buffers'].values())
            if row['passed']:
                continue
            candidate = args.validation/group/row['case']
            candidates.append({'group': group, 'case': row['case'], 'candidate': str(candidate),
                               'reference': row['reference'], 'source_npz_sha256':
                               hashlib.sha256((candidate/'capture.npz').read_bytes()).hexdigest()})
    (args.output/'candidates.json').write_text(json.dumps(candidates, indent=2)+'\n')
    hook = ROOT/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    schema = schemas()[0]
    env = {k: v for k, v in os.environ.items() if k not in (
        'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
        'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT', 'DEMO_NATIVE_TRACE_DIR', 'DEMO_NATIVE_TRACE_SUBSTEPS',
        'DEMO_MEMORY_TRACE_DIR')}
    status = {'source_sha256': digest, 'planned': candidates, 'completed': [],
              'all_candidates_checked': False, 'full_solver_replacement_complete': False,
              'separate_ab_evidence_required': True}

    def save():
        (args.output/'status.json').write_text(json.dumps(status, indent=2)+'\n')

    save()
    for index, item in enumerate(candidates):
        assert manifest.read_bytes() == saved
        name = item['group']+'-'+item['case']
        candidate, reference = Path(item['candidate']), Path(item['reference'])
        assert hashlib.sha256((candidate/'capture.npz').read_bytes()).hexdigest() == item['source_npz_sha256']
        previous = args.previous_results/name if args.previous_results else None
        if previous and (previous/'cohort/report.json').exists():
            output = previous
            reused = True
        elif item['group'] == 'previous-failures6' and item['case'] == 'spring-w3-newton-d0':
            output = args.validation/'spring-newton-cohort8'
            assert args.original_runs == 8
            reused = True
        else:
            output = args.output/name
            command = [sys.executable, '-m', 'reconstruction.csrc.granular_dense_distribution',
                       '--candidate', str(candidate), '--initial-original', str(reference),
                       '--original-runs', str(args.original_runs), '--launch-hook', str(hook),
                       '--dump-spec', str(candidate/'dump.json'), '--output', str(output)]
            (args.output/(name+'.command.json')).write_text(json.dumps(command, indent=2)+'\n')
            with (args.output/(name+'.log')).open('w') as log:
                code = subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT,
                                      timeout=1800).returncode
            if code not in (0, 1):
                status['worker_failure'] = {'candidate': item, 'exit': code}
                save()
                return 2
            reused = False
        cohort = output/'cohort'
        report = json.loads((cohort/'report.json').read_text())
        assert report['source_sha256'] == digest and report['originals'] == args.original_runs
        assert hashlib.sha256((cohort/'source0.npz').read_bytes()).hexdigest() == item['source_npz_sha256']
        launches = []
        for tag, directory in [('source1', output/'source-fixed/source1-hook'),
                               ('source2', output/'source-fixed/source2-hook'),
                               *[(f'original{i}', cohort/f'original{i}-hook') for i in range(1, args.original_runs)]]:
            row = {'tag': tag, **compare(reference/'launches.txt', directory/'launches.txt', schema)}
            if tag.startswith('source'):
                counts = json.loads((output/'source-fixed'/(tag+'.launches.json')).read_text())
                row['source_count_coverage'] = sum(counts.values()) == row['right_launches']
                assert row['source_count_coverage']
            assert row['equal'], row
            launches.append(row)
        primary = {tag: {key: value['substeps_within_spread'] == value['substeps'] for key, value in fields.items()}
                   for tag, fields in report['source_statistics'].items()}
        passed = all(all(fields.values()) for fields in primary.values())
        row = {'group': item['group'], 'case': item['case'], 'reused_existing_cohort': reused,
               'source_npz_sha256': item['source_npz_sha256'], 'primary_c_passed': passed,
               'all_steps_within': primary, 'complete_owned_metadata': launches, 'cohort': str(cohort)}
        (args.output/(name+'.audit.json')).write_text(json.dumps(row, indent=2)+'\n')
        status['completed'].append({k: v for k, v in row.items() if k != 'complete_owned_metadata'})
        save()
        print(name, 'primary C', passed, 'originals', args.original_runs, flush=True)
        if not passed and not args.keep_going:
            status['pending'] = candidates[index+1:]
            save()
            return 1
    status['all_candidates_checked'] = True
    status['all_primary_c_passed'] = all(row['primary_c_passed'] for row in status['completed'])
    save()
    return int(not status['all_primary_c_passed'])


if __name__ == '__main__':
    raise SystemExit(main())
