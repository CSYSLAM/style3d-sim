"""Preserve current reconstruction sources/build inputs and hash immutable result files before a host change."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil

from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE, REFERENCE_SHA


def digest(path):
    sha = hashlib.sha256()
    with path.open('rb') as stream:
        for block in iter(lambda: stream.read(1024*1024), b''):
            sha.update(block)
    return sha.hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--results', type=Path, nargs='+', required=True)
    parser.add_argument('--note', required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    assert args.output.is_relative_to(ROOT/'build'), 'Checkpoints belong under build/'
    args.output.mkdir(parents=True, exist_ok=False)
    manifest_path = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = manifest_path.read_bytes()
    manifest = json.loads(saved)
    for name, expected in manifest['sources'].items():
        assert digest(ROOT/name) == expected, 'Active build/source mismatch: '+name
    image = manifest_path.parent/'_source_solver.cpython-312-x86_64-linux-gnu.so'
    assert digest(image) == manifest['extension_sha256']
    assert digest(REFERENCE) == REFERENCE_SHA
    sources = {p for p in (ROOT/'reconstruction').rglob('*') if p.is_file() and '__pycache__' not in p.parts}
    sources.update(ROOT/name for name in manifest['sources'])
    sources.update((manifest_path, image))
    records = []
    for path in sorted(sources):
        relative = path.relative_to(ROOT)
        destination = args.output/'preserved-files'/relative
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(path, destination)
        sha = digest(destination)
        assert sha == digest(path)
        records.append({'path': str(relative), 'sha256': sha, 'bytes': path.stat().st_size})
    results = {}
    # A redirected completion log can live inside a result root. It is still being written by this
    # process, so recording its unfinished hash would make the checkpoint invalidate itself.
    output_streams = {(Path('/proc/self/fd')/str(fd)).resolve() for fd in (1, 2)}
    excluded = set()
    for directory in args.results:
        directory = directory.resolve(strict=True)
        assert not args.output.is_relative_to(directory), 'Do not hash a checkpoint recursively into itself'
        for path in sorted(directory.rglob('*')):
            if path.is_file() and '__pycache__' not in path.parts:
                if path in output_streams:
                    excluded.add(str(path.relative_to(ROOT)))
                    continue
                results[str(path.relative_to(ROOT))] = digest(path)
    assert manifest_path.read_bytes() == saved, 'Build changed during checkpoint'
    report = {'source_sha256': manifest['extension_sha256'], 'reference_sha256': REFERENCE_SHA,
              'note': args.note, 'preserved_files': records, 'result_sha256': results,
              'excluded_mutable_output_logs': sorted(excluded),
              'full_solver_replacement_complete': False}
    (args.output/'provenance.json').write_text(json.dumps(report, indent=2)+'\n')
    print('Preserved', len(records), 'files and', len(results), 'result hashes', flush=True)


if __name__ == '__main__':
    raise SystemExit(main())
