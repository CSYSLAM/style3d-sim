"""Link unchanged recovered PTX entries in the six original module groups, without modifying the active solver."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path
import re

from reconstruction import kernel_ab as k
from .demo_source_ab import ROOT
from .library_entries import entries
from .ptx_compare import normalise


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    base = ROOT / 'build/reconstruction-csrc/host-particles'
    saved = (base / 'build.json').read_bytes()
    metadata = json.loads(saved)
    header = (base / 'source_ptx_bundle.h').read_text()
    parsed = re.findall(r'\{("[^"\n]+"), R"(\w+)\((.*?)\)\2"\},', header, re.S)
    assert len(parsed) == 28
    modules = [(json.loads(path), text) for path, _, text in parsed]
    driver = k.Driver()
    groups, rows, index_lines = [], [], []
    for path in sorted((ROOT / 'build/reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx')):
        wanted = entries(path.read_text()).keys() & metadata['kernels'].keys()
        assert wanted
        groups.append(wanted)
        state = ct.c_void_p()
        driver.check(driver.cu.cuLinkCreate_v2(0, None, None, ct.byref(state)))
        inputs, packets = [], []
        try:
            for i in sorted({metadata['kernels'][name]['module'] for name in wanted}):
                origin, text = modules[i]
                selected = {name for name in wanted if metadata['kernels'][name]['module'] == i}
                for name, body in entries(text).items():
                    if name not in selected:
                        text = text.replace(body, '')
                    else:
                        assert hashlib.sha256(normalise(body).encode()).hexdigest() == metadata['kernels'][name]['digest']
                assert set(entries(text)) == selected
                packet = ct.create_string_buffer(text.encode())
                packets.append(packet)
                unit = args.output / f'group{len(groups)}-source{i}.ptx'
                unit.write_text(text)
                driver.check(driver.cu.cuLinkAddData_v2(state, 1, ct.cast(packet, ct.c_void_p), ct.c_size_t(len(packet)),
                                                       str(unit).encode(), 0, None, None))
                inputs.append({'source_module': i, 'source_path': origin, 'retained_entries': len(selected),
                               'pruned_ptx': unit.name, 'sha256': hashlib.sha256(unit.read_bytes()).hexdigest()})
            pointer, size = ct.c_void_p(), ct.c_size_t()
            driver.check(driver.cu.cuLinkComplete(state, ct.byref(pointer), ct.byref(size)))
            blob = ct.string_at(pointer, size.value)
            cubin = args.output / f'source-group{len(groups)}.cubin'
            cubin.write_bytes(blob)
            index_lines += [name + '\t' + str(cubin) + '\n' for name in sorted(wanted)]
            rows.append({'original_group': path.name, 'entries': len(wanted), 'inputs': inputs,
                         'cubin': cubin.name, 'cubin_sha256': hashlib.sha256(blob).hexdigest()})
            print('linked recovered-source group', len(groups), 'entries', len(wanted), 'bytes', size.value, flush=True)
        finally:
            driver.check(driver.cu.cuLinkDestroy(state))
    assert len(groups) == 6 and len(set.union(*map(set, groups))) == 176
    repeated = {name: sum(name in group for group in groups) for name in set.union(*map(set, groups))}
    assert all(count == 1 or not name.startswith('_ZN7synreal') for name, count in repeated.items())
    unique = {}
    for line in index_lines:
        name, path = line.rstrip('\n').split('\t')
        unique.setdefault(name, path)
    (args.output / 'source-module-index.tsv').write_text(''.join(name + '\t' + path + '\n'
                                                                for name, path in sorted(unique.items())))
    (args.output / 'report.json').write_text(json.dumps({
        'source_host_sha256': metadata['extension_sha256'], 'groups': rows, 'all_input_entry_digests_unchanged': True,
        'unique_entries': len(repeated), 'entry_instances': sum(map(len, groups)),
        'shared_auxiliary_entries': {name: count for name, count in repeated.items() if count > 1},
        'literal_original_ptx_used': False, 'original_sdk_used': False, 'production_changed': False,
        'whole_solver_complete': False, 'harness_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    }, indent=2) + '\n')


if __name__ == '__main__':
    main()
