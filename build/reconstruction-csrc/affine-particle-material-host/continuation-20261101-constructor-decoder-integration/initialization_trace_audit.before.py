"""Compare captured Thrust value initializers using their actual owned-kernel pointer uses, excluding padding."""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path


TYPES = (
    ('device_ptrIN3glm3matILi3ELi3Ef', 'mat3', 36),
    ('device_ptrIN3glm3vecILi2Ei', 'ivec2', 8),
    ('device_ptrIN3glm3vecILi3Ef', 'vec3', 12),
    ('device_ptrIN7synreal17BlockNonZeroEntry', 'block-entry', 40),
    ('device_ptrIN7synreal12NonZeroEntry', 'scalar-entry', 8),
    ('device_ptrIN7synreal4Aabb', 'aabb', 24),
    ('device_ptrIfEEfE', 'float', 4),
    ('device_ptrIiEEiE', 'int', 4),
    ('device_ptrIjEEjE', 'uint', 4),
)


def capture(directory, domain):
    uses = {}
    for line in (directory/'launches.txt').read_text().splitlines():
        head, tail = line.split(' symbol:', 1)
        symbol = tail.split()[0]
        for index, token in enumerate(head.split()[5:]):
            if token.startswith('u:'):
                pointer = int(token[2:], 16)
                uses.setdefault(pointer, set()).add((symbol, index))
    result = []
    for line in (directory/'memory.jsonl').read_text().splitlines():
        row = json.loads(line)
        if row.get('domain') != domain or '__uninitialized_fill' not in row.get('symbol', ''):
            continue
        matches = [(kind, width) for pattern, kind, width in TYPES if pattern in row['symbol']]
        assert len(matches) == 1, row
        kind, width = matches[0]
        functor, size = map(bytes.fromhex, row['parameters'])
        count = int.from_bytes(size, 'little')
        pointer = int.from_bytes(functor[:8], 'little')
        assert len(functor) == (8+width+7)//8*8 and len(size) == 8
        result.append({'sequence': row['seq'], 'type': kind, 'count': count, 'pointer': hex(pointer),
                       'value_hex': functor[8:8+width].hex(), 'grid_x': row['grid_x'], 'block_x': row['block_x'],
                       'grid_matches_thrust_256x2': row['grid_x'] == (count+511)//512 and row['block_x'] == 256,
                       'owned_uses': sorted(uses.get(pointer, set()))})
    return result


def signature(row):
    return json.dumps({k: row[k] for k in ('type', 'count', 'value_hex', 'grid_x', 'block_x', 'owned_uses')},
                      sort_keys=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--original', type=Path, required=True)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--source-domain', type=int, choices=(1, 2), default=2,
                        help='CUPTI driver=1, runtime=2; select one to avoid duplicate callbacks')
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    original, source = capture(args.original, 2), capture(args.source, args.source_domain)
    old, new = Counter(map(signature, original)), Counter(map(signature, source))
    missing, extra = old-new, new-old
    order_equal = list(map(signature, original)) == list(map(signature, source))
    files = [Path(__file__), *(p/n for p in (args.original, args.source) for n in ('launches.txt', 'memory.jsonl'))]
    report = {'original_calls': len(original), 'source_calls': len(source), 'matched_calls': sum((old & new).values()),
              'missing_original': [{'signature': json.loads(k), 'calls': n} for k, n in missing.items()],
              'unmatched_source': [{'signature': json.loads(k), 'calls': n} for k, n in extra.items()],
              'original': original, 'source': source,
              'padding_compared': False, 'allocation_order_compared': False,
              'all_calls_match': not missing and not extra,
              'initialization_call_order_compared': True, 'initialization_call_order_equal': order_equal,
              'all_calls_and_order_match': not missing and not extra and order_equal,
              'sha256': {str(p.resolve()): hashlib.sha256(p.read_bytes()).hexdigest() for p in files}}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    assert not args.output.exists(), 'Preserve the earlier audit'
    args.output.write_text(json.dumps(report, indent=2)+'\n')
    print('initializers', len(original), len(source), 'matched', report['matched_calls'],
          'call_order_equal', order_equal, flush=True)
    return int(not report['all_calls_and_order_match'])


if __name__ == '__main__':
    raise SystemExit(main())
