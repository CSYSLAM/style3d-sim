"""Map only the verified live spin-diagonal contractions into the old evaluate entry."""
import re
from functools import lru_cache

from reconstruction.csrc import ptx_compare as pc


def blocks(entry):
    labels = list(re.finditer(r'^\$L__BB\d+_\d+:', entry, re.M))
    return [(match[0], entry[match.end():labels[i + 1].start() if i + 1 < len(labels) else len(entry)])
            for i, match in enumerate(labels)]


@lru_cache(maxsize=2)
def contract_current_spin_diagonals(entry):
    prepare = next(body for path in sorted(pc.LEGACY_PTX.glob('*.ptx'))
                   for name, body in pc.entries(path.read_text()).items() if '22prepare_cable_tangents' in name)
    reference = next(body for label, body in blocks(prepare) if label == '$L__BB72_41:')
    matched = [(label, body) for label, body in blocks(entry) if pc.normalise(body) == pc.normalise(reference)]
    assert [label for label, _ in matched] == ['$L__BB74_47:', '$L__BB74_86:', '$L__BB74_283:', '$L__BB74_322:']
    subtract_products, first_products = set(), set()
    for _, body in matched[:2]:
        registers = dict(zip(re.findall(r'%[a-z]+\d+', reference), re.findall(r'%[a-z]+\d+', body)))
        subtract_products |= {registers[name] for name in ('%f1220', '%f1254', '%f1287')}
        first_products |= {registers[name] for name in ('%f1249', '%f1282', '%f1315')}
    products = {dst: (a, b) for dst, a, b in re.findall(
        r'mul\.f32\s+(%\w+),\s*(%\w+),\s*(%\w+);', entry)}
    seen = set()

    def replace(match):
        dst, left, right = match.groups()
        if dst not in subtract_products | first_products: return match[0]
        seen.add(dst)
        neg = '%audit_spin_negative_' + dst[1:]
        if dst in subtract_products:
            a, b = products[right]
            return f'neg.f32 {neg}, {a};\nfma.rn.f32 {dst}, {neg}, {b}, {left};'
        a, b = products[left]
        return f'neg.f32 {neg}, {right};\nfma.rn.f32 {dst}, {a}, {b}, {neg};'

    result = re.sub(r'sub\.f32\s+(%\w+),\s*(%\w+),\s*(%\w+);', replace, entry)
    assert len(seen) == 12
    return result
