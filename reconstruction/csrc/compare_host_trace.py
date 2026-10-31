"""Find the first actual GPU-stage difference; never turn nondeterministic reductions into a passing tolerance."""
import argparse
from collections import defaultdict
import json
from pathlib import Path

import numpy as np


def compare(left, right):
    old, new = sorted(left.glob('*.json')), sorted(right.glob('*.json'))
    assert old and len(old) == len(new), 'Trace coverage differs or no launches were observed'
    indexed = []
    for directory in (left, right):
        groups = defaultdict(list)
        for path in sorted(directory.glob('*.bin')):
            groups[path.name.split('.', 1)[0]].append(path)
        indexed.append(groups)
    result = {'launches': len(old), 'first_difference': None, 'launch_metadata_equal': True, 'differences': []}
    for a, b in zip(old, new):
        assert a.name == b.name
        x, y = json.loads(a.read_text()), json.loads(b.read_text())
        result['launch_metadata_equal'] &= x == y
        prefix = a.name[:-4]
        # Index by sequence once instead of rescanning the entire trace directory for every launch.
        af, bf = [[p for p in group[a.name.split('.', 1)[0]] if p.name.startswith(prefix)] for group in indexed]
        assert [p.name for p in af] == [p.name for p in bf], 'Captured buffer coverage differs'
        differences = []
        for p, q in zip(af, bf):
            u, v = p.read_bytes(), q.read_bytes()
            assert len(u) == len(v)
            if u == v:
                continue
            row = {'buffer': p.name[len(prefix):-4], 'bytes': len(u),
                   'different_bytes': int(np.count_nonzero(np.frombuffer(u, dtype='u1') !=
                                                           np.frombuffer(v, dtype='u1')))}
            if len(u) % 4 == 0:
                ua, va = np.frombuffer(u, dtype='<u4'), np.frombuffer(v, dtype='<u4')
                row['different_words'] = int(np.count_nonzero(ua != va))
                row['first_old_bits'], row['first_new_bits'] = int(ua[ua != va][0]), int(va[ua != va][0])
                row['max_abs_float32'] = float(np.max(np.abs(ua.view('f4').astype('f8')-va.view('f4').astype('f8'))))
            differences.append(row)
        if differences:
            row = {'launch': a.name, 'kernel': x['name'], 'buffers': differences}
            result['differences'].append(row)
            if result['first_difference'] is None:
                result['first_difference'] = row
    result['bitwise_equal'] = not result['differences'] and result['launch_metadata_equal']
    return result


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('left', type=Path)
    parser.add_argument('right', type=Path)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    result = compare(args.left, args.right)
    args.output.write_text(json.dumps(result, indent=2)+'\n')
    print('launches', result['launches'], 'metadata_equal', result['launch_metadata_equal'],
          'first_difference', result['first_difference'])
    if not result['bitwise_equal']:
        raise SystemExit(1)


if __name__ == '__main__':
    main()
