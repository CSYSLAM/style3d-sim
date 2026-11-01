"""Extend the frozen atomic recorder to preserve literal F32 operand bits without changing reductions."""
import hashlib
import inspect
from pathlib import Path
import re

from .library_entries import entries
from . import surface_atomic_operands as base


BASE_SHA = '183ec44e38a60147ee44bdc1daea67f80de8036323a80ba3dd1ff363741911bc'


def rendered_instrument_source():
    assert hashlib.sha256(Path(base.__file__).read_bytes()).hexdigest() == BASE_SHA
    text = inspect.getsource(base.instrument)
    changes = [
        (r'(%f\d+);', r'(%f\d+|0f[0-9a-fA-F]{8});'),
        ('        offset = int(match[2] or 0)',
         "        offset = int(match[2] or 0)\n"
         "        value = match[3]\n"
         "        record = ('st.global.u32 [%audit_record+8], 0x' + value[2:] + ';' if value.startswith('0f')\n"
         "                  else 'st.global.f32 [%audit_record+8], ' + value + ';')"),
        ('st.global.f32 [%audit_record+8], {match[3]};', '{record}'),
    ]
    for old, new in changes:
        assert text.count(old) == 1, old
        text = text.replace(old, new)
    return text


def instrument(module, symbol):
    namespace = {'entries': entries, 're': re}
    exec(compile(rendered_instrument_source(), str(Path(__file__)) + ':generated', 'exec'), namespace)
    changed, sites = namespace['instrument'](module, symbol)
    original = entries(module)[symbol]
    patched = entries(changed)[symbol]
    reductions = r'\bred\.global\.add\.f32\s+\[[^\]]+\],\s*[^;]+;'
    assert re.findall(reductions, original) == re.findall(reductions, patched)
    assert sites == len(re.findall(reductions, original))
    return changed, sites


def instrument256(module, symbol):
    changed, sites = instrument(module, symbol)
    old = 'mul.wide.u32 %audit_lane_offset, %audit_lane, 2048;'
    assert changed.count(old) == sites
    return changed.replace(old, 'mul.wide.u32 %audit_lane_offset, %audit_lane, 4096;'), sites
