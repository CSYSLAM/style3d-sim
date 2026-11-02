"""Lower only verified 32-bit half selections from NVCC's scalar-ELL packed register moves."""
import re


def lower_packed_moves(entry):
    packed, halves = {}, {}

    def pack(match):
        dst, low, high = match.groups()
        tag = dst[1:]
        lo, hi = f'%audit_pack_low_{tag}', f'%audit_pack_high_{tag}'
        packed[dst] = lo, hi
        return f'mov.b32 {lo}, {low};\nmov.b32 {hi}, {high};'

    entry = re.sub(r'mov\.b64\s+(%\w+),\s*\{(%\w+),\s*(%\w+)\};', pack, entry)

    def shift(match):
        dst, src = match.groups()
        if src not in packed:
            return match[0]
        half = f'%audit_upper_half_{dst[1:]}'
        halves[dst] = half
        return f'mov.b32 {half}, {packed[src][1]};'

    entry = re.sub(r'shr\.u64\s+(%\w+),\s*(%\w+),\s*32;', shift, entry)

    def truncate(match):
        dst, src = match.groups()
        if src in packed:
            return f'mov.b32 {dst}, {packed[src][0]};'
        if src in halves:
            return f'mov.b32 {dst}, {halves[src]};'
        return match[0]

    entry = re.sub(r'cvt\.u32\.u64\s+(%\w+),\s*(%\w+);', truncate, entry)
    for register in packed.keys() | halves.keys():
        if re.search(re.escape(register) + r'(?!\w)', entry):
            raise RuntimeError('Unsupported packed-register use: ' + register)
    return entry


def contract_so3_shared_squares(entry):
    """Model only the SO3 third-row sum's three contractions observed in the original sm_120 JIT image."""
    squares = {dst: a for dst, a, b in re.findall(r'mul\.f32\s+(%\w+),\s*(%\w+),\s*(%\w+);', entry) if a == b}
    pattern = (r'mul\.f32\s+(?P<product>%\w+),\s*(?P<a>%\w+),\s*(?P<b>%\w+);\s*'
               r'(?P<branch>@%\w+\s+bra\s+[^;]+;\s*)?'
               r'add\.f32\s+(?P<s1>%\w+),\s*(?P=product),\s*(?P<x>%\w+);\s*'
               r'add\.f32\s+(?P<s2>%\w+),\s*(?P=s1),\s*(?P<y>%\w+);\s*'
               r'add\.f32\s+(?P<s3>%\w+),\s*(?P=s2),\s*(?P<z>%\w+);')
    count = 0

    def replace(match):
        nonlocal count
        g = match.groupdict()
        if not all(g[axis] in squares for axis in ('x', 'y', 'z')):
            return match[0]
        count += 1
        # Keep the product definition: the following select still uses it on off-diagonal iterations.
        return (f'mul.f32 {g["product"]}, {g["a"]}, {g["b"]};\n'
                + (g['branch'] or '') +
                f'fma.rn.f32 {g["s1"]}, {g["a"]}, {g["b"]}, {g["x"]};\n'
                f'fma.rn.f32 {g["s2"]}, {squares[g["y"]]}, {squares[g["y"]]}, {g["s1"]};\n'
                f'fma.rn.f32 {g["s3"]}, {squares[g["z"]]}, {squares[g["z"]]}, {g["s2"]};')

    entry = re.sub(pattern, replace, entry)
    if count != 3:
        raise RuntimeError(f'Expected three original SO3 shared-squares chains, found {count}')
    return entry
