"""Compare actual explicitly captured HtoD payload bytes and order; API and full memory order remain separate."""
import argparse
import hashlib
import itertools
import json
from pathlib import Path


def capture(directory):
    result = []
    for line in (directory/'memory.jsonl').read_text().splitlines():
        row = json.loads(line)
        if 'file' not in row:
            continue
        assert row['status'] == 0
        path = directory/row['file']
        value = path.read_bytes()
        assert len(value) == row['bytes']
        result.append({**row, 'sha256': hashlib.sha256(value).hexdigest()})
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--capture', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    original, source = [capture(args.capture/name) for name in ('original', 'source')]
    differences = []
    for index, (a, b) in enumerate(itertools.zip_longest(original, source)):
        x, y = [(r['bytes'], r['sha256']) if r else None for r in (a, b)]
        if x != y:
            differences.append({'copy': index, 'original': a, 'source': b})
    files = [Path(__file__), args.capture/'provenance.json', args.capture/'build.json',
             *[args.capture/name/file for name in ('original', 'source') for file in
               ('memory.jsonl', 'capture.runtime.json')]]
    report = {'original_copies': len(original), 'source_copies': len(source),
              'payload_bytes_and_order_equal': not differences, 'differences': differences,
              'copy_apis_equal': [r['api'] for r in original] == [r['api'] for r in source],
              'original': original, 'source': source, 'full_memory_order_compared': False,
              'only_explicit_htod_copies_observed': True, 'whole_solver_equality_claimed': False,
              'sha256': {str(p.resolve()): hashlib.sha256(p.read_bytes()).hexdigest() for p in files}}
    assert not args.output.exists(), 'Keep the previous audit'
    args.output.write_text(json.dumps(report, indent=2)+'\n')
    print('HtoD copies', len(original), len(source), 'payload/order equal', not differences, flush=True)
    return int(bool(differences))


if __name__ == '__main__':
    raise SystemExit(main())
