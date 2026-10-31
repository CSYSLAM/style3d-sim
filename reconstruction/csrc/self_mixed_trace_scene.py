"""Observe the immutable mixed fixture's actual PCG stages, without changing its state or solver math."""
import ctypes
import os
from reconstruction.csrc.self_mesh_mixed_scene import Example as BaseExample


class Example(BaseExample):
    def __init__(self, viewer, args):
        super().__init__(viewer, args)
        self.observer = ctypes.CDLL(None)
        self.observer.solver_trace_begin.argtypes = [ctypes.c_char_p]
        self.observer.solver_trace_begin(os.environ['SELF_PARTICLE_TRACE_DIR'].encode())
