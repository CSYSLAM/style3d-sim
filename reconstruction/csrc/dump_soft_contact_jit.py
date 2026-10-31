"""Save the original off-diagonal soft-contact entry JIT cubin/SASS, without authentication or solver imports."""
import ctypes as c
import re
import subprocess
from pathlib import Path

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc


def main():
    d = k.Driver()
    out = pc.OUT/'soft-contact-audit'
    out.mkdir(parents=True, exist_ok=True)
    # Read the original directly, even when RECONSTRUCTION_KERNELS is set by the caller.
    name, entry = next((name, entry) for path in sorted(pc.LEGACY_PTX.glob('*.ptx'))
                       for name, entry in pc.entries(path.read_text()).items()
                       if '42multiply_soft_contact_hessian_off_diagonal' in name)
    ptx = '.version 8.4\n.target sm_52\n.address_size 64\n' + entry + '\n'
    state = c.c_void_p()
    d.check(d.cu.cuLinkCreate_v2(0, None, None, c.byref(state)))
    try:
        blob = c.create_string_buffer(ptx.encode())
        d.check(d.cu.cuLinkAddData_v2(state, 1, c.cast(blob, c.c_void_p), c.c_size_t(len(blob)),
                                    b'legacy-soft-offdiag.ptx', 0, None, None))
        pointer, size = c.c_void_p(), c.c_size_t()
        d.check(d.cu.cuLinkComplete(state, c.byref(pointer), c.byref(size)))
        cubin = out/'legacy-soft-offdiag-jit.cubin'
        cubin.write_bytes(c.string_at(pointer, size.value))
    finally:
        d.check(d.cu.cuLinkDestroy(state))
        d.free()
    executable = Path('/usr/local/cuda-13.2/bin/nvdisasm')
    sass = subprocess.check_output([str(executable), '-c', str(cubin)], text=True)
    (out/'legacy-soft-offdiag-jit.sass').write_text(sass)
    lines = [line for line in sass.splitlines() if re.search(r'FFMA R\d+, -R(\d+), R\1, 1 ;', line)]
    if len(lines) != 3:
        raise RuntimeError('Expected three sphere/contact projection contractions: ' + str(lines))
    print('\n'.join(lines))


if __name__ == '__main__':
    main()
