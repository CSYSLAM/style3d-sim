"""Compare actual original/source scalar and wind setters, including error type/message and unchanged value."""
import json
import argparse
import math
from pathlib import Path
import struct

from .host_api_probe import load_reference
from .host_particles_ab import OUT, native_source


def bits(value):
    if isinstance(value, (tuple, list)):
        return [struct.pack('<f', component).hex() for component in value]
    return struct.pack('<f', value).hex()


def outcome(module, cls, field, value):
    instance = getattr(module, cls)()
    before = bits(getattr(instance, field))
    try:
        setattr(instance, field, value)
        return {'accepted': True, 'bits': bits(getattr(instance, field))}
    except Exception as exc:
        after = bits(getattr(instance, field))
        assert before == after, (cls, field, type(exc).__name__)
        return {'accepted': False, 'error_type': type(exc).__name__, 'unchanged': True,
                'message': str(exc) if isinstance(exc, (ValueError, RuntimeError)) else str(exc).splitlines()[0]}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=OUT/'api-float-validation.json')
    args = parser.parse_args()
    original, source = load_reference(), native_source()
    schema = json.loads((Path(__file__).parent/'native/api_schema.json').read_text())
    values = (-math.inf, math.nan, math.inf, -1e10, -1., -1e-8, -0., 0., 1e-8, .25, .5, .99999994, 1., 1.00000012, 2., 1e10)
    checks = {}
    for cls, fields in schema['classes'].items():
        for field, info in fields.items():
            if info['type'] not in ('float', 'vec3'):
                continue
            for index, value in enumerate(values):
                value = [value, .25, -.5] if info['type'] == 'vec3' else value
                old, new = outcome(original, cls, field, value), outcome(source, cls, field, value)
                checks[f'{cls}.{field}/{index}'] = old == new
                assert old == new, (cls, field, index, old, new)
    for index, value in enumerate((None, 0, 'abc', [], [1], [1, 2], [1, 2, 3], [1, 2, 3, 4],
                                   ['1', '2', '3'], [1, None, 3], [1, math.nan, 3], [1, 2, math.inf],
                                   (1, -2, -0.), [1e300, 2, 3])):
        old, new = outcome(original, 'Config', 'wind_velocity', value), outcome(source, 'Config', 'wind_velocity', value)
        checks[f'wind_sequence/{index}'] = old == new
        assert old == new, (index, old, new)
    report = {'checks': checks, 'passed': len(checks),
              'source_extension_sha256': json.loads((OUT/'build.json').read_text())['extension_sha256']}
    args.output.write_text(json.dumps(report, indent=2)+'\n')
    print('Original/source float/vector setter checks passed', len(checks))


if __name__ == '__main__':
    main()
