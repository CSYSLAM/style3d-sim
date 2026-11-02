"""Audit all PTX and cubin entry symbols from a fresh extraction of the pinned legacy library."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import subprocess

from reconstruction.kernel_ab import LEGACY, LEGACY_SHA


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--coverage', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    if hashlib.sha256(LEGACY.read_bytes()).hexdigest() != LEGACY_SHA:
        raise RuntimeError('Reference library hash mismatch')
    args.output.mkdir(parents=True, exist_ok=True)
    if list(args.output.iterdir()):
        raise RuntimeError('Use an empty output directory')
    extract = args.output/'ptx'
    extract.mkdir()
    subprocess.run(['cuobjdump', '-xptx', 'all', str(LEGACY)], cwd=extract, check=True, capture_output=True)
    modules = {p.name: {'sha256': hashlib.sha256(p.read_bytes()).hexdigest(),
                       'entries': re.findall(r'\.entry\s+([^\s(]+)\s*\(', p.read_text())}
               for p in sorted(extract.glob('*.ptx'))}
    entries = {e for m in modules.values() for e in m['entries']}
    symbols = subprocess.check_output(['cuobjdump', '-symbols', str(LEGACY)], text=True)
    (args.output/'cubin-symbols.txt').write_text(symbols)
    elf_entries = set(re.findall(r'^STT_FUNC\s+\S+\s+STO_ENTRY\s+(\S+)', symbols, flags=re.M))
    coverage = json.loads(args.coverage.read_text())
    if coverage['legacy_sha256'] != LEGACY_SHA:
        raise RuntimeError('Coverage reference mismatch')
    launched = set(coverage['launched_entry_names']) & entries
    groups = {}
    for label, prefix in (('synreal', '_ZN7synreal'), ('cub', '_ZN3cub'), ('thrust', '_ZN6thrust')):
        group = {e for e in entries if e.startswith(prefix)}
        groups[label] = {'total': len(group), 'launched': len(group & launched), 'missing': sorted(group-launched)}
    report = {'legacy_sha256': LEGACY_SHA, 'coverage_file': str(args.coverage.resolve()),
              'coverage_sha256': hashlib.sha256(args.coverage.read_bytes()).hexdigest(),
              'ab_exit_code': coverage['ab_exit_code'], 'modules': modules,
              'ptx_entry_occurrences': sum(len(m['entries']) for m in modules.values()),
              'unique_ptx_entries': len(entries), 'unique_cubin_entries': len(elf_entries),
              'ptx_only': sorted(entries-elf_entries), 'cubin_only': sorted(elf_entries-entries),
              'unique_launched': len(launched), 'missing': sorted(entries-launched), 'groups': groups,
              'scope': 'All entry symbols, without template merging or namespace exclusion. Duplicate symbols '
                       'across modules are listed but merged in unique counts. Successful execution plus passing '
                       'A/B tests is evidence for tested inputs, not complete branch or host equivalence.'}
    (args.output/'inventory.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps({k: report[k] for k in ('ptx_entry_occurrences', 'unique_ptx_entries',
                                          'unique_cubin_entries', 'unique_launched', 'ptx_only', 'cubin_only')}, indent=2))
    for label, group in groups.items():
        print(label, group['launched'], '/', group['total'])
    if entries != elf_entries:
        raise SystemExit('PTX/cubin inventory differs; inspect report')


if __name__ == '__main__':
    main()
