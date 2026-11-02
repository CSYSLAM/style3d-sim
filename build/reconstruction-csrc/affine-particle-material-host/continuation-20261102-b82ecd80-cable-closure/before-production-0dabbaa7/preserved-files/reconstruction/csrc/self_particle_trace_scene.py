"""Observe the unchanged PP boundary fixture's actual PCG launches; no alternative solver arithmetic."""
import ctypes
import os
from reconstruction.csrc.self_particle_variants import Example as BaseExample


class Example(BaseExample):
    def __init__(self, viewer, args):
        super().__init__(viewer, args)
        self.observer = ctypes.CDLL(None)
        self.observer.solver_trace_begin.argtypes = [ctypes.c_char_p]
        self.observer.solver_trace_begin(os.environ['SELF_PARTICLE_TRACE_DIR'].encode())
