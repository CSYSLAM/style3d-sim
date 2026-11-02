"""Record every real F32 atomic add operand in the four full stretch/bend inputs without changing production kernels."""
import ctypes as ct
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction import kernel_ab as k
from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
from reconstruction.csrc.host_api_probe import load_reference
from reconstruction.csrc.pcg_alias_replay import span_groups
from reconstruction.csrc.surface_atomic_operands import instrument


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def bounded_probe(text, name, trace_lanes):
    changed, sites = instrument(text, name)
    anchor = '.reg .b64 %audit_record, %audit_address, %audit_lane_offset;'
    assert changed.count(anchor) == 1
    changed = changed.replace(anchor, anchor + '\n.reg .pred %audit_outside;', 1)
    pattern = (r'(ld\.global\.u32 %audit_ordinal, \[%audit_count_ptr\];)'
               r'(.*?)'
               r'(add\.u32 %audit_ordinal, %audit_ordinal, 1;)')
    seen = 0

    def bounded(match):
        nonlocal seen
        label = 'H1_AUDIT_SKIP_' + str(seen)
        seen += 1
        checks = (f'\nsetp.ge.u32 %audit_outside, %audit_lane, {trace_lanes};\n'
                  f'@%audit_outside bra {label};\n'
                  'setp.ge.u32 %audit_outside, %audit_ordinal, 128;\n'
                  f'@%audit_outside bra {label};\n')
        return match[1] + checks + match[2] + label + ':\n' + match[3]

    changed = re.sub(pattern, bounded, changed, flags=re.S)
    assert seen == sites
    return changed, sites


folder = BASE
plan = json.loads((folder / 'plan.json').read_text())
assert json.loads((folder / 'run.status.json').read_text())['complete']
assert json.loads((folder / 'replay.status.json').read_text())['complete']
for name, expected in plan['input_sha256'].items():
    assert sha(Path(name)) == expected, name
output = BASE / 'producer-operands'
output.mkdir(exist_ok=False)
build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
candidate = json.loads(Path(plan['source_host_build']).read_text())
assert candidate['image_sha256'] == plan['source_host_sha256']
assert sha(Path(candidate['image'])) == plan['source_host_sha256']
driver = k.Driver()
load_reference()
spec = importlib.util.spec_from_file_location('_source_solver', candidate['image'])
source_module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(source_module)
assert source_module.source_only
source = source_module._KernelDriver()
driver.cu.cuMemsetD8_v2.argtypes = [ct.c_uint64, ct.c_ubyte, ct.c_size_t]
driver.cu.cuMemsetD8_v2.restype = ct.c_int
stream = ct.c_void_p()
driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
rows, hashes, complete, calls = [], {}, False, 0


def reset(pointer, value):
    driver.check(driver.cu.cuMemcpyHtoD_v2(pointer, ct.c_void_p(value.ctypes.data), value.nbytes))


try:
    for run in plan['runs']:
        layout = json.loads((folder / run['label'] / 'trace/snapshot-layout.json').read_text())
        for stage in layout['stages']:
            if stage['key'] == 'self-add':
                continue
            tag = run['label'] + '-' + stage['key']
            path = folder / run['label'] / 'trace' / (stage['key'] + '-packets/frame-00.npz')
            hashes[str(path)] = sha(path)
            with np.load(path, allow_pickle=False) as packet:
                raw = [packet[f'parameter-{i}'].tobytes() for i in range(len(stage['node']['parameter_hex']))]
                bindings = {int(i): packet[f'before-arg-{i}'].tobytes() for i in stage['sizes']}
            values = [int.from_bytes(value, 'little') for value in raw]
            count = 66930 if stage['key'] == 'stretch' else 100634
            assert stage['key'] in ('stretch', 'bend')
            trace_lanes = (count + 255) // 256 * 256
            gx, gy, gz, bx, by, bz, shared = stage['node']['geometry']
            assert (gy, gz, bx, by, bz, shared) == (1, 1, 256, 1, 1, 0)
            count_zero = np.zeros(gx * bx, dtype='u4')
            trace_zero = np.zeros((trace_lanes, 128, 16), dtype='u1')
            groups = span_groups(values, bindings)
            pointers = {}
            try:
                for group in groups:
                    padding = 256 + group['start'] % 256
                    initial = np.full(padding + len(group['initial']) + 256, 211, dtype='u1')
                    initial[padding:padding + len(group['initial'])] = group['initial']
                    device = driver.upload(initial)
                    group.update(device=device, upload=initial, padding=padding)
                    mask = np.ones(len(initial), dtype=bool)
                    for i in group['indices']:
                        offset = padding + values[i] - group['start']
                        pointers[i] = device.value + offset
                        if i in stage['outputs']:
                            mask[offset:offset + len(bindings[i])] = False
                    group['unwritten'] = mask
                parameters = [(ct.c_ubyte * len(value)).from_buffer_copy(
                    pointers[i].to_bytes(8, 'little') if i in pointers else value) for i, value in enumerate(raw)]
                trace, counts = driver.upload(trace_zero), driver.upload(count_zero)
                texts, original_path = kernel_texts(build, stage['node']['name'])
                hashes[str(original_path)] = sha(original_path)
                probes = []
                for side in ('original', 'source'):
                    changed, sites = bounded_probe(texts[side], stage['node']['name'], trace_lanes)
                    ptx = output / (stage['key'] + '-' + side + '.ptx')
                    if ptx.exists():
                        assert ptx.read_text() == changed
                    else:
                        ptx.write_text(changed)
                    function = driver.function(changed, stage['node']['name'])
                    for group in groups:
                        reset(group['device'], group['upload'])
                    reset(trace, trace_zero)
                    reset(counts, count_zero)
                    driver.check(driver.cu.cuCtxSynchronize())
                    actual = [*parameters, trace, counts]
                    holders = (ct.c_void_p * len(actual))(*[ct.cast(ct.byref(value), ct.c_void_p) for value in actual])
                    driver.check(driver.cu.cuLaunchKernel(function, gx, gy, gz, bx, by, bz, shared, stream, holders, None))
                    calls += 1
                    driver.check(driver.cu.cuStreamSynchronize(stream))
                    records = driver.download(trace, trace_zero)
                    sizes = driver.download(counts, count_zero)
                    valid = not sizes[count:].any() and int(sizes.max()) <= 128
                    if not valid:
                        np.savez_compressed(output / (tag + '-' + side + '-guard-failure.npz'),
                                            trace=records, counts=sizes)
                        raise RuntimeError(f'{tag}/{side}: trace guard failed; maximum count={int(sizes.max())}')
                    assert not records[count:].any() and not records[:, :, 12:].any()
                    for ordinal in range(128):
                        assert not records[sizes[:trace_lanes] <= ordinal, ordinal].any()
                    arrays = {'raw-trace': records, 'counts': sizes}
                    for i, value in enumerate(actual):
                        arrays[f'actual-parameter-{i}'] = np.frombuffer(bytes(value), dtype='u1').copy()
                    for group in groups:
                        after = driver.download(group['device'], group['upload'])
                        assert np.array_equal(after[group['unwritten']], group['upload'][group['unwritten']])
                    for i in stage['outputs']:
                        arrays[f'output-{i}'] = driver.download(
                            ct.c_uint64(pointers[i]), np.zeros(len(bindings[i]), dtype='u1'))
                    if stage['key'] == 'membrane':
                        old_columns = np.frombuffer(bindings[7], dtype='u4').reshape(-1, 10)[:, 0]
                        actual_columns = arrays['output-7'].view('u4').reshape(-1, 10)[:, 0]
                        assert np.array_equal(old_columns, actual_columns)
                    target = output / (tag + '-' + side + '.npz')
                    np.savez_compressed(target, **arrays)
                    probes.append({'side': side, 'file': str(target), 'sha256': sha(target),
                                   'static_atomic_sites': sites, 'actual_atomic_records': int(sizes.sum()),
                                   'all_outside_active_threads_have_zero_records': True,
                                   'unwritten_input_and_guard_bytes_unchanged': True})
                rows.append({'label': run['label'], 'stage': stage['key'], 'packet': str(path),
                             'active_lanes': count, 'trace_lanes': trace_lanes, 'counts_lanes': len(count_zero),
                             'outputs': {str(i): {'address': pointers[i], 'bytes': len(bindings[i])}
                                         for i in stage['outputs']}, 'probes': probes})
                print(tag, 'full F32 operand probes', [item['actual_atomic_records'] for item in probes], flush=True)
                driver.check(driver.cu.cuMemFree_v2(trace))
                driver.check(driver.cu.cuMemFree_v2(counts))
            finally:
                for group in groups:
                    if 'device' in group:
                        driver.check(driver.cu.cuMemFree_v2(group['device']))
    assert calls == 8 and len(rows) == 4
    complete = True
finally:
    driver.check(driver.cu.cuStreamDestroy_v2(stream))
    (BASE / 'producer-operands-report.json').write_text(json.dumps({'rows': rows, 'complete': complete,
        'actual_probe_calls': calls, 'input_sha256': hashes, 'runner_sha256': sha(Path(__file__)),
        'probe_guard_only_skips_trace_storage_not_original_reductions': True,
        'capture_vectors_not_reclassified': True, 'whole_solver_complete': False}, indent=2) + '\n')
