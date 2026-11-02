"""Audit the named prepare-body differential helper against the old internal exit probe."""
import json
import os
import re
import sys

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.csrc import ptx_compare as pc
from reconstruction.csrc import probe_cable_spin as probe
from reconstruction.csrc.audit_drive_ptx import PathAudit
from reconstruction.csrc.audit_fluid_ptx import lower_memory
from reconstruction.csrc.cable_ptx_ops import CableExpressions, double_operations


class SpinExpressions(CableExpressions):
    def node(self, op, *args):
        if op in ('mul.f32', 'mul.f64'):
            neg = 'neg.' + op.split('.')[1]
            negative, factors = False, []
            for argument in args:
                if self.nodes[argument][0] == neg:
                    negative = not negative
                    argument = self.nodes[argument][1]
                factors.append(argument)
            product = super().node(op, *factors)
            return super().node(neg, product) if negative else product
        if op in ('neg.f32', 'neg.f64') and self.nodes[args[0]][0] == op:
            return self.nodes[args[0]][1]
        return super().node(op, *args)


def contract_old_spin_diagonals(entry, include_child=False):
    """Model six float contractions confirmed in the old sm_120 image, not arbitrary reassociation."""
    products = dict((dst, (a, b)) for dst, a, b in re.findall(
        r'mul\.f32\s+(%\w+),\s*(%\w+),\s*(%\w+);', entry))
    # Each triplet is one output diagonal of the three affine-column maps.
    subtract_products = {'%f1220', '%f1254', '%f1287'}
    first_products = {'%f1249', '%f1282', '%f1315'}
    if include_child:
        subtract_products |= {'%f1686', '%f1720', '%f1753'}
        first_products |= {'%f1715', '%f1748', '%f1781'}
    seen = set()

    def replace(match):
        dst, left, right = match.groups()
        if dst not in subtract_products | first_products:
            return match[0]
        seen.add(dst)
        if dst in subtract_products:
            a, b = products[right]
            neg = '%audit_spin_negative_' + dst[1:]
            return f'neg.f32 {neg}, {a};\nfma.rn.f32 {dst}, {neg}, {b}, {left};'
        a, b = products[left]
        neg = '%audit_spin_negative_' + dst[1:]
        return f'neg.f32 {neg}, {right};\nfma.rn.f32 {dst}, {a}, {b}, {neg};'

    result = re.sub(r'sub\.f32\s+(%\w+),\s*(%\w+),\s*(%\w+);', replace, entry)
    assert seen == subtract_products | first_products
    return result


def main():
    driver_class = k.Driver
    driver = driver_class()
    upload, function, launch = driver.upload, driver.function, driver.launch
    memory, entries, reports = {}, {}, []
    out = pc.OUT/'cable-spin-audit'
    if os.environ.get('CABLE_SPIN_AUDIT_TAG'): out /= os.environ['CABLE_SPIN_AUDIT_TAG']
    out.mkdir(parents=True, exist_ok=True)
    old_handle = None

    def capture_upload(array):
        pointer = upload(array)
        memory[pointer.value] = np.ascontiguousarray(array).tobytes()
        return pointer

    def capture_function(text, name):
        nonlocal old_handle
        result = function(text, name)
        if '22prepare_cable_tangents' in name:
            entries['old'] = contract_old_spin_diagonals(pc.entries(text)[name])
            old_handle = result.value
        elif name == 'cable_spin_probe': entries['source'] = pc.entries(text)[name]
        return result

    def capture_launch(fun, threads, params, block=32):
        if fun.value == old_handle:
            pool = SpinExpressions()
            left, right = (lower_memory(entries[tag], params, memory) for tag in ('old', 'source'))
            options = {'block': block, 'allow_dead_undefined': True, 'opcode_extension': double_operations}
            old, new = PathAudit(left, [], memory, pool, **options), PathAudit(right, [], memory, pool, **options)
            differences, writes = [], 0
            lanes = [0, 1, 2, 7, 63, 64, threads]
            if os.environ.get('CABLE_SPIN_AUDIT_LANES'):
                lanes = [int(x) for x in os.environ['CABLE_SPIN_AUDIT_LANES'].split(',')]
            for lane in lanes:
                a, ga = old.run(lane, include_values=True)
                b, gb = new.run(lane, include_values=True)
                # Probe-created outputs are separate scratch arrays. Compare by unique address, since the
                # two diagnostic wrappers deliberately export R/maps/flags in different orders.
                assert len({x[0] for x in a}) == len(a) and len({x[0] for x in b}) == len(b)
                a, b = sorted(a), sorted(b)
                writes += len(a)
                if a != b:
                    first = next(((x, y) for x, y in zip(a, b) if x != y), None)
                    differences.append({'lane': lane, 'old_writes': len(a), 'source_writes': len(b),
                                        'first': first, 'expression': pool.difference(first[0][1], first[1][1])
                                        if first else None})
            row = {'call': len(reports), 'lanes': lanes, 'writes': writes, 'differences': differences,
                   'old_jit_spin_contractions': 6}
            reports.append(row)
            (out/'progress.json').write_text(json.dumps(reports, indent=2) + '\n')
            print('spin audit', row['call'], 'differences', len(differences), flush=True)
            if differences and os.environ.get('CABLE_SPIN_AUDIT_STOP_FIRST'):
                (out/'debug-first.json').write_text(json.dumps(row, indent=2) + '\n')
                (out/'debug-expressions.json').write_text(json.dumps(pool.nodes))
                raise RuntimeError('Stopped at first differential expression difference')
        launch(fun, threads, params, block)

    driver.upload, driver.function, driver.launch = capture_upload, capture_function, capture_launch
    k.Driver = lambda: driver
    try:
        result = probe.main()
    finally:
        k.Driver = driver_class
        (out/'dataflow.json').write_text(json.dumps(reports, indent=2) + '\n')
    return int(result or not reports or any(row['differences'] for row in reports))


if __name__ == '__main__':
    sys.exit(main())
