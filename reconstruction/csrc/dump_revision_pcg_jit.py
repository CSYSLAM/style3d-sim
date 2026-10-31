"""Compare native instruction bytes after JIT-linking the complete original/source PCG modules on this GPU."""
import ctypes as c
import hashlib
import json
from pathlib import Path
import re
import struct
import subprocess

from reconstruction import kernel_ab as k
from . import ptx_compare as pc
from .library_entries import entries

OUT = pc.OUT/'pcg-order-investigation'


def sections(blob):
    assert blob[:6] == b'\x7fELF\x02\x01'
    offset = struct.unpack_from('<Q', blob, 40)[0]
    stride, count, strings = struct.unpack_from('<HHH', blob, 58)
    headers = [struct.unpack_from('<IIQQQQIIQQ', blob, offset + i * stride) for i in range(count)]
    names = headers[strings]
    table = blob[names[4]:names[4] + names[5]]
    return {table[h[0]:table.index(b'\0', h[0])].decode(): blob[h[4]:h[4] + h[5]] for h in headers}


def link(driver, text, tag):
    state = c.c_void_p()
    driver.check(driver.cu.cuLinkCreate_v2(0, None, None, c.byref(state)))
    try:
        payload = c.create_string_buffer(text.encode())
        driver.check(driver.cu.cuLinkAddData_v2(state, 1, c.cast(payload, c.c_void_p), c.c_size_t(len(payload)),
                                               tag.encode(), 0, None, None))
        address, size = c.c_void_p(), c.c_size_t()
        driver.check(driver.cu.cuLinkComplete(state, c.byref(address), c.byref(size)))
        return c.string_at(address, size.value)
    finally:
        driver.check(driver.cu.cuLinkDestroy(state))


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    manifest = json.loads((pc.OUT/'host-particles/build.json').read_text())
    wanted = set(json.loads((pc.OUT/'host-particles/new-pcg-ptx.json').read_text()))
    original = next(p.read_text() for p in (pc.ROOT/'build/reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx')
                    if wanted <= set(entries(p.read_text())))
    header = (pc.OUT/'host-particles/source_ptx_bundle.h').read_text()
    compiled = next(text for _, _, text in re.findall(r'\{("[^"\n]+"), R"(\w+)\((.*?)\)\2"\},', header, re.S)
                    if wanted <= set(entries(text)))
    driver = k.Driver()
    binaries = {}
    for tag, text in (('original', original), ('source', compiled)):
        blob = link(driver, text, tag)
        path = OUT/f'{tag}.cubin'
        path.write_bytes(blob)
        binaries[tag] = sections(blob)
        result = subprocess.run(['/usr/local/cuda-13.2/bin/nvdisasm', '-c', str(path)], capture_output=True,
                                text=True, check=True)
        (OUT/f'{tag}.sass').write_text(result.stdout)
    checks = {}
    for name in sorted(wanted):
        a, b = binaries['original']['.text.' + name], binaries['source']['.text.' + name]
        checks[name] = {'instruction_bytes_equal': a == b, 'original_bytes': len(a), 'source_bytes': len(b),
                        'original_sha256': hashlib.sha256(a).hexdigest(), 'source_sha256': hashlib.sha256(b).hexdigest()}
    report = {'method': 'complete PTX modules linked by current CUDA driver, compare ELF .text bytes',
              'source_extension_sha256': manifest['extension_sha256'], 'checks': checks,
              'all_equal': all(row['instruction_bytes_equal'] for row in checks.values())}
    (OUT/'jit-comparison.json').write_text(json.dumps(report, indent=2)+'\n')
    print('JIT native instruction bytes identical', sum(v['instruction_bytes_equal'] for v in checks.values()), '/', len(checks))
    assert report['all_equal']


if __name__ == '__main__':
    main()
