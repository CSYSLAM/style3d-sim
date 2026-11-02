"""Python adapter for the new C++ CUDA execution layer; only embedded source kernels are accepted."""
import ctypes
from functools import lru_cache
import hashlib
import importlib.util
import sysconfig

import numpy as np

from reconstruction.csrc import ptx_compare as pc
from reconstruction.csrc.library_entries import entries


@lru_cache(maxsize=1)
def extension():
    path = pc.OUT/'native'/('_source_cuda' + sysconfig.get_config_var('EXT_SUFFIX'))
    spec = importlib.util.spec_from_file_location('_source_cuda', path)
    if spec is None: raise RuntimeError('Build the source CUDA extension first: python -m reconstruction.csrc.build_native')
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


@lru_cache(maxsize=32)
def digests(text):
    return {name: hashlib.sha256(pc.normalise(entry).encode()).hexdigest() for name, entry in entries(text).items()}


class Driver:
    def __init__(self):
        self.native = extension().Driver()
        self.allocations = []
        self.source_entries_used = set()

    def function(self, text, name):
        if digests(text).get(name) != extension().kernel_digests.get(name) or name not in digests(text):
            raise RuntimeError('Compiled source image differs from requested kernel; rebuild: ' + name)
        self.source_entries_used.add(name)
        return ctypes.c_void_p(self.native.function(name))

    def upload(self, array):
        pointer = ctypes.c_void_p(self.native.upload(np.ascontiguousarray(array).tobytes()))
        self.allocations.append(pointer)
        return pointer

    def download(self, pointer, template):
        payload = self.native.download(pointer.value, template.nbytes)
        return np.frombuffer(payload, dtype=template.dtype).reshape(template.shape).copy()

    def launch(self, function, threads, params, block=256):
        arguments = [ctypes.string_at(ctypes.byref(param), ctypes.sizeof(param)) for param in params]
        self.native.launch(function.value, max(1, (threads + block - 1) // block), block, arguments)

    def free(self):
        for pointer in self.allocations: self.native.release(pointer.value)
        self.allocations.clear()
