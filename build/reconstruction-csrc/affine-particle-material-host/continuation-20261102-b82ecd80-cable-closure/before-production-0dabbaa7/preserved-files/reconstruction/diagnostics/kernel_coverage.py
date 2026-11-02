"""Run kernel A/B and report successfully launched legacy entry coverage, not solver completeness."""
import argparse
import json
import re
import sys
from pathlib import Path

from reconstruction import kernel_ab as kab


def base_name(name):
    match = re.match(r'_ZN7synreal\d+[a-z_]*kernel\d+([a-z0-9_]+?)(?:I|E)', name)
    if match is None:
        raise ValueError(f'Unrecognized kernel symbol: {name}')
    return match.group(1)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--seed', type=int, default=1)
    parser.add_argument('--count', type=int, default=512)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    if list(args.output.iterdir()):
        raise RuntimeError('Use an empty output directory')
    names, launched = {}, set()
    original_function, original_launch = kab.Driver.function, kab.Driver.launch
    original_argv = sys.argv

    def function(self, ptx, name):
        handle = original_function(self, ptx, name)
        names[handle.value] = name
        return handle

    def launch(self, function, threads, params, block=256):
        original_launch(self, function, threads, params, block)
        launched.add(names[function.value])

    kab.Driver.function, kab.Driver.launch = function, launch
    code = 1
    try:
        sys.argv = ['kernel_ab', '--seed', str(args.seed), '--count', str(args.count),
                    '--output', str(args.output/'ab.json')]
        try:
            kab.main()
        except SystemExit as ex:
            code = int(ex.code or 0)
    finally:
        kab.Driver.function, kab.Driver.launch = original_function, original_launch
        sys.argv = original_argv
        modules = kab.ROOT/'build/reconstruction-ptx'/kab.LEGACY_SHA[:16]
        entries = {name for path in modules.glob('*.ptx')
                   for name in re.findall(r'\.entry\s+([^\s(]+)\s*\(', path.read_text())}
        if not entries:
            raise RuntimeError('No reference entries found')
        synreal = {n for n in entries if n.startswith('_ZN7synreal')}
        covered = {base_name(n) for n in launched if n in synreal}
        total = {base_name(n) for n in synreal}
        report = {'legacy_sha256': kab.LEGACY_SHA, 'seed': args.seed, 'count': args.count,
                  'ab_exit_code': code, 'covered_count': len(covered), 'total_count': len(total),
                  'covered': sorted(covered), 'missing': sorted(total-covered),
                  'synreal_entry_count': len(synreal), 'synreal_entries_launched': len(synreal & launched),
                  'synreal_entries_missing': sorted(synreal-launched),
                  'all_entry_count': len(entries), 'all_entries_launched': len(entries & launched),
                  'all_entries_missing': sorted(entries-launched),
                  'all_entries_exercised_and_ab_passed': code == 0 and not entries-launched,
                  'launched_entry_names': sorted(launched),
                  'scope': 'Successful launches; coverage is validated only when the entire A/B report passes. '
                           'covered_count/total_count are SynReal base names only, merging templates. '
                           'Use all_entry_count and all_entries_missing for whole-library symbol coverage. '
                           'Neither metric proves full branch or demo equivalence.'}
        (args.output/'coverage.json').write_text(json.dumps(report, indent=2)+'\n')
    raise SystemExit(code)


if __name__ == '__main__':
    main()
