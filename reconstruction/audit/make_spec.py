"""Write the replay_hook spec: every kernel shared by the reference PTX and the source image, with its reference PTX file
and parameter sizes (from the source image's kernel table).

    .venv/bin/python -m reconstruction.audit.make_spec OUT.txt
"""
import re
import sys

from reconstruction.audit.kernel_audit import BUNDLE, REFERENCE
from reconstruction.csrc.ptx_compare import entries


def main(out):
    where = {}
    for path in sorted(REFERENCE.glob('*.ptx')):
        for name in entries(path.read_text()):
            where[name] = path
    table = re.findall(r'^\{"([^"]+)", \d+, "[0-9a-f]+", \{([\d,]*)\}\},', BUNDLE.read_text(), re.M)
    lines = [f'{name} {where[name]} {sizes}' for name, sizes in table if name in where and sizes]
    open(out, 'w').write('\n'.join(lines) + '\n')
    print(len(lines), 'kernels in spec')


if __name__ == '__main__':
    main(sys.argv[1])
