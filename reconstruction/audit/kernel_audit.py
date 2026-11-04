"""Audit every kernel the compiled source image embeds against the reference image's PTX.

    .venv/bin/python -m reconstruction.audit.kernel_audit [--diff NAME-SUBSTRING]

Source side: the exact PTX embedded in _source_solver (host-particles/source_ptx_bundle.h, i.e. build_native modules plus
the 23fb797 revisions) and the LBVH bridge PTX. Reference side: PTX extracted from 64a0be7f. Entries are compared after
ptx_compare.normalise (comments, register numbers, labels) and nvcc's path-derived anonymous-namespace names.
"""
import argparse
import collections
import difflib
import json
import re
import sys
from pathlib import Path

from reconstruction.csrc.ptx_compare import entries, normalise

ROOT = Path(__file__).resolve().parents[2]
REFERENCE = ROOT/'build/reconstruction-ptx/64a0be7f7a3c03cb'
BUNDLE = ROOT/'build/reconstruction-csrc/host-particles/source_ptx_bundle.h'
BVH = sorted((ROOT/'build/reconstruction-csrc/bvh-host-library').glob('*/bvh_library.ptx'))


def portable(text):
    text = re.sub(r'_INTERNAL_[0-9a-f]{8}_', '_INTERNAL_X_', text)
    return re.sub(r'_cu_[0-9a-f]{8}_[0-9a-f]{8}', '_cu_H', text)


def source_modules():
    text = BUNDLE.read_text()
    mods = re.findall(r'\{("[^"]*"), R"(\w+)\((.*?)\)\2"\}', text, re.S)
    out = [(json.loads(path), ptx) for path, _, ptx in mods]
    out += [(str(p.relative_to(ROOT)), p.read_text()) for p in BVH]
    kernels = re.findall(r'^\{("[^"]+"), (\d+), "', text, re.M)
    return out, {json.loads(n): int(m) for n, m in kernels}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--diff', help='print the normalised diff of entries containing this substring')
    parser.add_argument('--json', type=Path)
    args = parser.parse_args()
    reference = {}
    for path in sorted(REFERENCE.glob('*.ptx')):
        reference.update(entries(path.read_text()))
    modules, exported = source_modules()
    # Later modules (revisions) override earlier ones for the same entry, as in the host loader's kernel table.
    source, origin = {}, {}
    for index, (path, ptx) in enumerate(modules):
        for name, body in entries(ptx).items():
            source.setdefault(name, []).append((index, path, body))
    report = collections.defaultdict(list)
    for name, versions in sorted(source.items()):
        used = [v for v in versions if exported.get(name) == v[0]] or versions[-1:]
        index, path, body = used[0]
        if name not in reference:
            report['source_only'].append((name, path)); continue
        same = normalise(portable(reference[name])) == normalise(portable(body))
        report['identical' if same else 'different'].append((name, path))
        if not same and args.diff and args.diff in name:
            a, b = normalise(portable(reference[name])), normalise(portable(body))
            sys.stdout.writelines(difflib.unified_diff(a.splitlines(True), b.splitlines(True), 'reference', 'source'))
    owned = sorted(n for n in reference if n.startswith('_ZN7synreal'))
    report['reference_synreal_missing'] = [(n, '') for n in owned if n not in source]
    library = sorted(n for n in reference if not n.startswith('_ZN7synreal'))
    report['reference_library_missing'] = [(n, '') for n in library if n not in source]
    summary = {k: len(v) for k, v in report.items()}
    summary['reference_entries'] = len(reference)
    summary['reference_synreal'] = len(owned)
    summary['source_entries'] = len(source)
    summary['exported_by_host'] = len(exported)
    print(json.dumps(summary, indent=1))
    if args.json:
        args.json.write_text(json.dumps(report, indent=1))


if __name__ == '__main__':
    main()
