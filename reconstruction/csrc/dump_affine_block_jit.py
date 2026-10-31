"""Save old/source affine kernel JIT images for inspecting contraction after PTX compilation."""
import ctypes as c
import subprocess

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc


def main():
    out = pc.OUT/'affine-block-audit'
    compiled = pc.entries(pc.compile_ptx(pc.CSRC/'kernels/affine_block.cu', pc.DEFAULT_NVCC))
    entries = [(name, entry) for path in sorted(pc.LEGACY_PTX.glob('*.ptx'))
               for name, entry in pc.entries(path.read_text()).items() if name in compiled]
    driver = k.Driver()
    try:
        for name, entry in entries:
            for backend, body in (('legacy', entry), ('source', compiled[name])):
                tag = backend + ('-scalar' if '12NonZeroEntry' in name else '-block')
                text = '.version 8.4\n.target sm_52\n.address_size 64\n' + body + '\n'
                state = c.c_void_p()
                driver.check(driver.cu.cuLinkCreate_v2(0, None, None, c.byref(state)))
                try:
                    blob = c.create_string_buffer(text.encode())
                    driver.check(driver.cu.cuLinkAddData_v2(state, 1, c.cast(blob, c.c_void_p),
                                                          c.c_size_t(len(blob)), tag.encode(), 0, None, None))
                    pointer, size = c.c_void_p(), c.c_size_t()
                    driver.check(driver.cu.cuLinkComplete(state, c.byref(pointer), c.byref(size)))
                    cubin = out/f'{tag}-jit.cubin'
                    cubin.write_bytes(c.string_at(pointer, size.value))
                finally:
                    driver.check(driver.cu.cuLinkDestroy(state))
                sass = subprocess.check_output(['/usr/local/cuda-13.2/bin/nvdisasm', '-c', str(cubin)], text=True)
                (out/f'{tag}-jit.sass').write_text(sass)
                print(tag, 'SASS lines', len(sass.splitlines()), flush=True)
    finally:
        driver.free()


if __name__ == '__main__':
    main()
