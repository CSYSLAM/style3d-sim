"""Dump the unmodified old module's public fields and defaults without logging in."""
import argparse
import importlib.util
import json
import sys

from reconstruction import validate

REFERENCE = validate.ROOT/'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
REFERENCE_SHA = '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'


def load_reference():
    assert validate.sha(REFERENCE) == REFERENCE_SHA
    name = 'style3d_sim._core'
    spec = importlib.util.spec_from_file_location(name, REFERENCE)
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module


def describe(module):
    enums = {}
    for name in ('NonlinearSolver', 'JointConstraintMode', 'InertiaMode', 'AffineBodyRigidityModel', 'LogLevel'):
        cls = getattr(module, name)
        enums[name] = {key: int(value) for key, value in cls.__members__.items()}
    classes = {}
    for name in ('Span', 'Model', 'State', 'Control', 'Contact', 'Config'):
        instance = getattr(module, name)()
        fields = {}
        for key in dir(instance):
            if key.startswith('_'):
                continue
            value = getattr(instance, key)
            if isinstance(value, module.Span):
                fields[key] = {'type': 'Span', 'default': [value.ptr, value.size]}
            elif type(value).__name__ in enums:
                fields[key] = {'type': type(value).__name__, 'default': int(value)}
            elif isinstance(value, tuple):
                fields[key] = {'type': 'vec3', 'default': list(value)}
            else:
                fields[key] = {'type': type(value).__name__, 'default': value}
            if name == 'Span':
                try:
                    setattr(instance, key, value)
                    fields[key]['readonly'] = False
                except AttributeError:
                    fields[key]['readonly'] = True
            elif type(value) is int:
                try:
                    setattr(instance, key, -1)
                    fields[key]['cpp_type'] = 'int'
                except TypeError:
                    fields[key]['cpp_type'] = 'std::uint32_t'
                finally:
                    setattr(instance, key, value)
        classes[name] = fields
    return {'enums': enums, 'classes': classes}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=str, required=True)
    args = parser.parse_args()
    from pathlib import Path
    Path(args.output).write_text(json.dumps(describe(load_reference()), indent=2) + '\n')


if __name__ == '__main__':
    main()
