"""Isolate real first-call bond operands and find exact float32 witnesses for captured atomic sums."""
import argparse
import ctypes as c
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import sys

import numpy as np

from .audit_cudahook import parameter_types
from .demo_source_ab import ROOT
from .host_particles_ab import native_source
from .library_entries import entries
from reconstruction import kernel_ab as k

KEY = '15granular_kernel16accumulate_bonds'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--template', type=Path, required=True, help='A real demo capture directory')
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--trials', type=int, default=100000)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    template = json.loads((args.template/'capture.runtime.json').read_text())
    example = Path(template['example'])
    assert hashlib.sha256(example.read_bytes()).hexdigest() == template['example_sha256']
    first = next(l for l in (args.template/'launches.txt').read_text().splitlines() if l.split()[1] == KEY)
    fields = first.split()[5:]
    count = int(fields[8][2:])
    model_word = int(re.search(r'Mview:.*?24:([0-9a-f]+)\(', first).group(1), 16)
    particles = model_word >> 32
    assert 0 < count and 0 < particles
    sizes = {1: particles*12, 2: particles*12, 4: count*8, 5: count*4, 6: count*4, 7: count*4,
             10: particles*12, 11: particles*36, 12: count*36}
    name = first.split()[-2][7:]
    types = parameter_types(name)
    assert all('*' in types[i] for i in sizes)
    hook = ROOT/'build/reconstruction-csrc/granular-host/cudahook.so'
    saved = (ROOT/'build/reconstruction-csrc/host-particles/build.json').read_bytes()
    (args.output/'build.json').write_bytes(saved)
    spec = KEY+'='+','.join(f'{i}:{size}' for i, size in sizes.items())
    (args.output/'capture-settings.json').write_text(json.dumps(
        {'template': str(args.template.resolve()), 'count': count, 'particles': particles,
         'dump': spec, 'first_bond_call_only': True, 'hook_sha256': hashlib.sha256(hook.read_bytes()).hexdigest()},
        indent=2)+'\n')
    env = {key: value for key, value in os.environ.items() if key not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    env.update(LD_PRELOAD=str(hook), CUDAHOOK_DUMP=spec, CUDAHOOK_DUMP_LIMIT='1')
    for backend in ('original', 'source'):
        assert (ROOT/'build/reconstruction-csrc/host-particles/build.json').read_bytes() == saved
        folder = args.output/backend
        folder.mkdir()
        env['CUDAHOOK_DIR'] = str(folder)
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend,
                   '--tag', 'capture', '--example', str(example), '--frames', '1', '--output', str(folder),
                   '--', *template['extra']]
        (folder/'command.json').write_text(json.dumps(command, indent=2)+'\n')
        with (folder/'run.log').open('w') as log:
            subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, check=True, timeout=900)

    def read(backend, phase, argument, dtype='f4'):
        raw = (args.output/backend/f'dump_{KEY}_{phase}_arg{argument}.bin').read_bytes()
        assert len(raw) == sizes[argument]
        return np.frombuffer(raw, dtype=dtype).copy()

    # This probe remaps each noncoincident bond to disjoint endpoints. IDs are read numerically only by
    # the coincident-axis branch, which is explicitly excluded here instead of assuming remapping is harmless.
    x, previous = [read('original', 'pre', i).reshape(-1, 3) for i in (1, 2)]
    pairs = read('original', 'pre', 4, 'i4').reshape(count, 2)
    active = read('original', 'pre', 7, 'i4')
    assert np.all(active == 1), 'This first-call audit requires every authored bond to be live'
    assert np.all(np.linalg.norm(x[pairs[:, 0]]-x[pairs[:, 1]], axis=1) > 1e-8)
    for argument in sizes:
        if argument != 12:
            assert read('original', 'pre', argument).tobytes() == read('source', 'pre', argument).tobytes()
    reference = k.Driver()
    core = native_source()
    source = core._KernelDriver()
    ptxs = [p.read_text() for p in (ROOT/'build/reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx')]
    ptx = next(text for text in ptxs if name in entries(text))
    functions = {'original': reference.function(ptx, name), 'source': c.c_void_p(source.function(name))}
    line = next(l for l in (args.output/'original/launches.txt').read_text().splitlines() if l.split()[1] == KEY)
    tokens = line.split()[5:]
    assert int(tokens[8][2:]) == count
    dt, stiffness = float(tokens[3][2:]), float(tokens[9][2:])
    model = (args.output/'original'/f'model_{line.split()[0]}.bin').read_bytes()
    model_arg = (c.c_ubyte*len(model)).from_buffer_copy(model)
    assert len(model) == 1864
    isolated = {}
    for backend, function in functions.items():
        zero_force = np.full((count*2, 3), -0., dtype='f4')
        zero_diagonal = np.full((count*2, 9), -0., dtype='f4')
        zero_tangent = np.zeros((count, 9), dtype='f4')
        px, pp = [reference.upload(value[pairs].reshape(-1, 3)) for value in (x, previous)]
        pi = reference.upload(np.arange(count*2, dtype='i4').reshape(count, 2))
        pr, ph, pa = [reference.upload(read('original', 'pre', i)) for i in (5, 6, 7)]
        pf, pb, pt = [reference.upload(value) for value in (zero_force, zero_diagonal, zero_tangent)]
        reference.launch(function, count, [model_arg, px, pp, k.f32(dt), pi, pr, ph, pa,
                                          c.c_int(count), k.f32(stiffness), pf, pb, pt], block=128)
        isolated[backend] = [reference.download(ptr, like) for ptr, like in
                             ((pf, zero_force), (pb, zero_diagonal), (pt, zero_tangent))]
        reference.free()
    assert all(a.tobytes() == b.tobytes() for a, b in zip(isolated['original'], isolated['source']))
    assert all(np.isfinite(a).all() for a in isolated['original'])
    force, diagonal, tangent = isolated['original']
    for backend in ('original', 'source'):
        assert tangent.tobytes() == read(backend, 'post', 12).tobytes()
    endpoints = np.concatenate((force.reshape(count, 2, 3), diagonal.reshape(count, 2, 9)), axis=2)
    degrees = np.bincount(pairs.ravel(), minlength=particles)
    rows = np.flatnonzero(degrees)
    maximum = int(degrees.max())
    terms = np.zeros((len(rows), maximum, 12), dtype='f4')
    used = np.zeros(particles, dtype='i4')
    row_lookup = {int(p): i for i, p in enumerate(rows)}
    for bond in range(count):
        for side in range(2):
            particle = pairs[bond, side]
            terms[row_lookup[int(particle)], used[particle]] = endpoints[bond, side]
            used[particle] += 1
    degrees = degrees[rows]
    arrays = {'terms': terms, 'particles': rows, 'degrees': degrees, 'pairs': pairs,
              'isolated_force': force, 'isolated_diagonal': diagonal, 'isolated_tangent': tangent}
    reports = []
    for backend in ('original', 'source'):
        before, target = [np.concatenate((read(backend, phase, 10).reshape(particles, 3),
                                          read(backend, phase, 11).reshape(particles, 9)), axis=1)
                          for phase in ('pre', 'post')]
        untouched = np.ones(particles, dtype=bool)
        untouched[rows] = False
        assert before[untouched].tobytes() == target[untouched].tobytes()
        start, target = before[rows], target[rows]
        matched = np.zeros(start.shape, dtype=bool)
        witness = np.full((*start.shape, maximum), -1, dtype='i4')
        rng = np.random.default_rng(117)
        for trial in range(args.trials):
            order = np.broadcast_to(np.arange(maximum), (len(rows), maximum))
            if trial:
                scores = np.where(np.arange(maximum) < degrees[:, None], rng.random(order.shape), np.inf)
                order = scores.argsort(axis=1)
            value = start.copy()
            for column in range(maximum):
                addition = terms[np.arange(len(rows)), order[:, column]]
                value = np.where((column < degrees)[:, None], np.add(value, addition, dtype='f4'), value)
            hit = (value.view('u4') == target.view('u4')) & ~matched
            rr, cc = np.nonzero(hit)
            witness[rr, cc] = order[rr]
            matched |= hit
            if matched.all():
                break
        failures = np.argwhere(~matched).tolist()
        # Re-evaluate each saved witness independently; a search hit alone is not the proof artifact.
        for row, component in np.argwhere(matched):
            total = start[row, component]
            for index in witness[row, component, :degrees[row]]:
                total = np.float32(total + terms[row, index, component])
            assert total.view('u4') == target[row, component].view('u4')
        arrays.update({backend+'_before': start, backend+'_target': target, backend+'_witness': witness})
        reports.append({'backend': backend, 'trials': trial+1, 'checked_scalars': int(matched.size),
                        'unexplained': failures, 'untouched_scalars_unchanged': int(untouched.sum()*12)})
    assert '_core.cpython-' not in Path('/proc/self/maps').read_text()
    np.savez_compressed(args.output/'exact-witnesses.npz', **arrays)
    report = {'source_sha256': json.loads(saved)['extension_sha256'], 'bond_count': count,
              'maximum_incident_bonds': maximum, 'isolated_arrays_bitwise_equal': True,
              'captured_tangent_bitwise_equal': True, 'original_solver_mapped': False,
              'production_order_inferred': False, 'whole_trajectory_accepted': False, 'cases': reports}
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps(report), flush=True)
    return int(any(row['unexplained'] for row in reports))


if __name__ == '__main__':
    raise SystemExit(main())
