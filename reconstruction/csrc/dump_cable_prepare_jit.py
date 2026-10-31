"""Save actual full native/source prepare JIT images for diagnosing float fallback contractions."""
import ctypes as c
import subprocess

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc


def main():
    out = pc.OUT/'cable-prepare-audit'
    old_text, old_name = next((path.read_text(), name) for path in sorted(pc.LEGACY_PTX.glob('*.ptx'))
                              for name in pc.entries(path.read_text()) if '22prepare_cable_tangents' in name)
    old_entry = pc.entries(old_text)[old_name]
    constants = '\n'.join(line for line in old_text.splitlines()
                          if line.startswith('.global ') and '__cudart_i2opi_f' in line)
    source = pc.entries((pc.OUT/'cable_tangents.ptx').read_text())[old_name]
    driver = k.Driver()
    try:
        for tag, entry in (('legacy', old_entry), ('source', source)):
            text = '.version 8.4\n.target sm_52\n.address_size 64\n' + constants + '\n' + entry + '\n'
            state = c.c_void_p()
            driver.check(driver.cu.cuLinkCreate_v2(0, None, None, c.byref(state)))
            try:
                blob = c.create_string_buffer(text.encode())
                driver.check(driver.cu.cuLinkAddData_v2(state, 1, c.cast(blob, c.c_void_p), c.c_size_t(len(blob)),
                                                      tag.encode(), 0, None, None))
                pointer, size = c.c_void_p(), c.c_size_t()
                driver.check(driver.cu.cuLinkComplete(state, c.byref(pointer), c.byref(size)))
                cubin = out/f'{tag}-prepare-jit.cubin'
                cubin.write_bytes(c.string_at(pointer, size.value))
            finally:
                driver.check(driver.cu.cuLinkDestroy(state))
            sass = subprocess.check_output(['/usr/local/cuda-13.2/bin/nvdisasm', '-c', str(cubin)], text=True)
            (out/f'{tag}-prepare-jit.sass').write_text(sass)
            print(tag, 'SASS lines', len(sass.splitlines()), flush=True)
    finally:
        driver.free()


if __name__ == '__main__':
    main()
