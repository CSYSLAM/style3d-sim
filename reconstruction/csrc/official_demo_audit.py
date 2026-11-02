"""Independently audit captured official demo states and public source-core execution records entirely on CPU."""
import argparse
import hashlib
import json
from pathlib import Path
import time

import numpy as np

ROOT = Path(__file__).resolve().parents[2]
HOST = '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
CORE = '7151054e4597e6ea919c0caee576579e577aca233ea4de4dc8ad7aa20fa4b4e7'
SDK = '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
FIELDS = {'particle_q', 'particle_qd', 'body_q', 'body_qd'}


def digest(path):
    with Path(path).open('rb') as stream:
        return hashlib.file_digest(stream, 'sha256').hexdigest()


def load_states(path):
    with np.load(path, allow_pickle=False) as archive:
        assert archive.files and set(archive.files) <= FIELDS
        result = {name: archive[name].copy() for name in archive.files}
    assert all(value.dtype == np.dtype('<f4') and value.ndim == 3 and len(value) for value in result.values())
    return result


def compare_states(original, source):
    result = {}
    for name in sorted(set(original) | set(source)):
        if name not in original or name not in source:
            result[name] = {'missing_in': 'native' if name not in original else 'candidate'}
            continue
        left, right = original[name], source[name]
        assert left.shape[1:] == right.shape[1:], (name, left.shape, right.shape)
        steps = min(len(left), len(right))
        equal = np.all(left[:steps].view('<u4') == right[:steps].view('<u4'), axis=(1, 2))
        different = np.flatnonzero(~equal)
        result[name] = {'substeps': steps, 'length_match': len(left) == len(right),
                        'bitwise_substeps': int(equal.sum()),
                        'first_diff_substep': int(different[0]) if len(different) else None,
                        'max_abs': float(np.abs(left[:steps].astype('f8') - right[:steps].astype('f8')).max()),
                        'nonfinite': bool(not np.isfinite(right[:steps]).all())}
    result['bitwise'] = bool(result) and all(value.get('first_diff_substep', 0) is None and value.get('length_match')
                                           for value in result.values())
    return result


def preflight(output):
    assert not output.exists()
    parent = ROOT / 'build/reconstruction-csrc/affine-particle-material-host'
    cable = parent / 'continuation-20261101-0dabbaa7-official-cable-bend'
    dzhanibekov = parent / ('continuation-20261101-granular-affine-bonds-production/'
                            'validation-0dabbaa7-v2/regression74/example_basic_dzhanibekov')
    cases = [(cable / mode, 'original', 'strict_comparison', False) for mode in ('synreal', 'pd')]
    cases.append((dzhanibekov, 'original0', 'bitwise', True))
    rows, hashes = [], {str(Path(__file__).resolve()): digest(Path(__file__))}
    for directory, reference, report_key, expected in cases:
        paths = [directory / (reference + '.npz'), directory / 'source.npz', directory / 'report.json']
        hashes.update({str(path): digest(path) for path in paths})
        left, right = load_states(paths[0]), load_states(paths[1])
        actual = compare_states(left, right)
        previous = json.loads(paths[2].read_text())[report_key]
        assert actual == previous and actual['bitwise'] == expected, directory
        rows.append({'directory': str(directory), 'strict_equal': actual['bitwise'],
                     'all_original_and_source_values_finite': all(np.isfinite(v).all()
                                                                for state in (left, right) for v in state.values())})
    for path, expected in hashes.items():
        assert digest(path) == expected, path
    record = {'rows': rows, 'input_sha256': hashes, 'GPU_used': False,
              'old_failures_reclassified': False, 'four_new_demo_results_validated': False}
    output.write_text(json.dumps(record, indent=2) + '\n')
    print('Independent official-demo CPU auditor preflight:2 real strict failures and1 real strict pass reproduced')


def wait_for_normal(phase):
    identity = json.loads((phase / 'normal-waiter-identity.json').read_text())['process']
    while True:
        normal = json.loads((phase / 'normal-core3/status.json').read_text())
        short = json.loads((phase / 'short3/status.json').read_text())
        assert not short['error'] and not normal['error'], (short['error'], normal['error'])
        if normal['complete']:
            assert short['complete']
            return
        assert Path('/proc/sys/kernel/random/boot_id').read_text().strip() == identity['boot_id']
        stat = (Path('/proc') / str(identity['pid']) / 'stat').read_text().rsplit(')', 1)[1].split()
        assert int(stat[19]) == identity['start_ticks'] and stat[0] != 'Z'
        time.sleep(5)


def audit(phase):
    output = phase / 'independent-cpu.json'
    assert not output.exists()
    plan = json.loads((phase / 'short3/plan.json').read_text())
    short = json.loads((phase / 'short3/status.json').read_text())
    normal = json.loads((phase / 'normal-core3/status.json').read_text())
    assert short['complete'] and normal['complete'] and not short['error'] and not normal['error']
    assert len(short['completed']) == 2 * len(plan['cases']) == 8
    hashes = dict(plan['input_sha256'])
    hashes.update(json.loads((phase / 'normal-core3/plan.json').read_text())['input_sha256'])

    def read(path):
        raw = path.read_bytes()
        hashes[str(path.resolve())] = hashlib.sha256(raw).hexdigest()
        return raw

    rows, supported = [], []
    for case in plan['cases']:
        directory = phase / 'short3' / case['name']
        report = json.loads(read(directory / 'report.json'))
        workers, states = [], {}
        for side in ('original', 'source'):
            worker = [row for row in short['completed'] if row['case'] == case['name'] and row['backend'] == side]
            assert len(worker) == 1 and worker[0] in report['workers']
            worker = worker[0]
            read(directory / (side + '.log'))
            read(directory / (side + '.command.json'))
            runtime_path = directory / (side + '.runtime.json')
            if runtime_path.exists():
                runtime = json.loads(read(runtime_path))
                assert runtime['backend'] == side and runtime['frames'] == plan['frames'] == 3
                assert runtime['extra'] == [] and runtime['example_sha256'] == digest(ROOT / case['example'])
                assert runtime['image_sha256'] == (SDK if side == 'original' else HOST)
            else:
                assert worker['actual_exit'] != 0
            gates = [gate for gate in short['GPU_waits'] if gate['case'] == case['name'] and gate['backend'] == side]
            assert gates
            if plan.get('GPU_admission_policy') == 'available-memory':
                assert gates[-1]['GPU_admission_policy'] == 'available-memory'
                assert gates[-1]['free_memory_MiB'] >= 4096
            else:
                assert not gates[-1]['compute_apps']
            path = directory / (side + '.npz')
            assert path.exists() == worker['capture_exists']
            if path.exists():
                read(path)
            if worker['actual_exit'] == 0:
                assert path.exists() and runtime_path.exists()
                states[side] = load_states(path)
                assert all(len(array) == case['substeps'] for array in states[side].values())
                if side == 'source':
                    counts = json.loads(read(directory / 'source.launches.json'))
                    assert counts and sum(counts.values()) > 0
                    supported.append(case['name'])
            workers.append(worker)
        row = {'case': case['name'], 'workers': workers, 'full_demo_accepted': False}
        if len(states) == 2:
            stats = compare_states(states['original'], states['source'])
            finite = all(np.isfinite(value).all() for state in states.values() for value in state.values())
            assert stats == report['comparison'] and finite == report['states_finite']
            row.update(comparison=stats, all_states_finite=bool(finite))
        else:
            assert 'comparison' not in report
            row['comparison_not_claimed_due_to_worker_failure'] = True
        rows.append(row)
    expected_normal = set(supported)
    assert {row['case'] for row in normal['completed']} == expected_normal
    assert {row['case'] for row in normal['skipped']} == {c['name'] for c in plan['cases']} - expected_normal
    normal_rows = []
    for worker in normal['completed']:
        name = worker['case']
        read(phase / 'normal-core3' / (name + '.log'))
        read(phase / 'normal-core3' / (name + '.command.json'))
        report_path = phase / 'normal-core3' / (name + '.json')
        if report_path.exists():
            report = json.loads(read(report_path))
            assert report['source_sha256'] == CORE and report['source_only'] and report['public_core_abi']
            assert not report['ab_bridge_used'] and not report['reference_solver_mapped']
            assert report['arguments'] == ['--viewer', 'null', '--num-frames', '3']
            assert report['exit'] == worker['actual_exit']
            if worker['actual_exit'] == 0:
                assert report['source_launch_counts'] and sum(report['source_launch_counts'].values()) > 0
        else:
            assert worker['actual_exit'] != 0
        gates = [gate for gate in normal['GPU_waits'] if gate['case'] == name]
        assert gates
        if plan.get('GPU_admission_policy') == 'available-memory':
            assert gates[-1]['GPU_admission_policy'] == 'available-memory'
            assert gates[-1]['free_memory_MiB'] >= 4096
        else:
            assert not gates[-1]['compute_apps']
        normal_rows.append({**worker, 'raw_states_compared_for_public_core_graph': False})
    for path in (Path(__file__), phase / 'short3/plan.json', phase / 'short3/status.json',
                 phase / 'normal-core3/plan.json', phase / 'normal-core3/status.json'):
        read(path)
    for path, expected in hashes.items():
        assert digest(path) == expected, path
    record = {'cases': rows, 'public_core': normal_rows, 'public_core_skipped': normal['skipped'],
              'input_sha256': hashes, 'GPU_used_for_this_audit': False,
              'parent_root_tool_exits_inferred_from_status': False, 'full_demo_accepted': False,
              'production_changed': False, 'whole_solver_complete': False}
    output.write_text(json.dumps(record, indent=2) + '\n')
    print('Independent official-demo CPU audit complete:', len(rows), 'A/B cases;', len(normal_rows), 'public-core runs')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument('--preflight', type=Path, help='New output file for comparisons against existing real reports')
    mode.add_argument('--phase', type=Path)
    parser.add_argument('--wait', action='store_true')
    args = parser.parse_args()
    if args.preflight:
        assert not args.wait
        preflight(args.preflight.resolve())
    else:
        phase = args.phase.resolve(strict=True)
        if args.wait:
            wait_for_normal(phase)
        audit(phase)


if __name__ == '__main__':
    main()
