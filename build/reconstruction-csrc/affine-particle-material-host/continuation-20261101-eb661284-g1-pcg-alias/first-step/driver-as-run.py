"""Capture actual PCG parameters and pre-call pointer spans using an isolated diagnostic observer."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys

from .affine_tetrahedron_contact_ab import clean_env
from .audit_cudahook import parameter_types
from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE, REFERENCE_SHA


TOKENS = ('23precondition_and_reduceIN3glm', '26multiply_matrix_and_reduceINS_17BlockNonZeroEntry')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=3)
    parser.add_argument('--substeps', type=int, default=1)
    args = parser.parse_args()
    assert args.frames > 0 and 0 < args.substeps <= args.frames * 6
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build_path.read_bytes()
    build = json.loads(saved)
    (output / 'solver-build.json').write_bytes(saved)
    assert hashlib.sha256(REFERENCE.read_bytes()).hexdigest() == REFERENCE_SHA
    base = ROOT / 'reconstruction/csrc/native/host_trace.cpp'
    text = base.read_text()
    (output / 'base-host_trace.cpp').write_bytes(base.read_bytes())

    def replace(old, new):
        nonlocal text
        assert text.count(old) == 1, old
        text = text.replace(old, new)

    start = text.index('    for (const char* token : {')
    end = text.index('})\n', start) + 2
    text = text[:start] + '    for (const char* token : {"' + '", "'.join(TOKENS) + '"})' + text[end:]
    additions, schema = [], {}
    for token in TOKENS:
        names = [name for name in build['kernels'] if token in name]
        assert len(names) == 1
        name = names[0]
        widths = build['kernels'][name]['parameters']
        types = parameter_types(name)
        assert len(widths) == len(types)
        pointers = [i for i, kind in enumerate(types) if '*' in kind]
        assert all(widths[i] == 8 for i in pointers)
        schema[name] = {'widths': widths, 'pointer_indices': pointers, 'types': types}
        additions.append('        if (!after && group_ == "' + token + '") {\n'
                         '            const std::size_t widths[] = {' + ','.join(map(str, widths)) + '};\n'
                         '            for (std::size_t i = 0; i < sizeof(widths)/sizeof(widths[0]); ++i)\n'
                         '                bytes("before.param_" + std::to_string(i), args_[i], widths[i]);\n'
                         '        }\n')
    replace('        if (group_ == "15initialize_stepE") {\n            const auto n',
            ''.join(additions) + '        if (group_ == "15initialize_stepE") {\n            const auto n')
    replace('            else { copy("r", 1, n, 12); copy("inverse", 0, n, group_ ==',
            '            else { copy("z", 2, n, 12); copy("r", 1, n, 12); copy("inverse", 0, n, group_ ==')
    replace('            else { copy("blocks", 3, n, group_.find("EntryEf")',
            '            else { copy("ap", 6, n, 12); copy("blocks", 3, n, group_.find("EntryEf")')
    replace('CUstream stream, unsigned grid, unsigned block)\n',
            'CUstream stream, unsigned grid, unsigned block, unsigned gy, unsigned gz,\n'
            '                unsigned by, unsigned bz, std::size_t shared)\n')
    anchor = '        if (group_ == "15initialize_stepE") {\n            // Compare actual alias relationships'
    replace(anchor, '        meta << ",\\\"grid_xyz\\\":[" << grid << "," << gy << "," << gz\n'
            '             << "],\\\"block_xyz\\\":[" << block << "," << by << "," << bz\n'
            '             << "],\\\"shared_bytes\\\":" << shared;\n' + anchor)
    replace('reinterpret_cast<CUstream>(stream), grid.x, block.x);',
            'reinterpret_cast<CUstream>(stream), grid.x, block.x,\n'
            '                      grid.y, grid.z, block.y, block.z, shared);')
    replace('Observation trace(name, args, stream, gx, bx);',
            'Observation trace(name, args, stream, gx, bx, gy, gz, by, bz, shared);')
    source = output / 'host_trace_pcg_alias.cpp'
    source.write_text(text)
    observer = output / 'host_trace_pcg_alias.so'
    cuda = ROOT / 'build/toolchains/cuda-12.4'
    command = ['c++', '-std=c++17', '-O2', '-shared', '-fPIC', '-I' + str(cuda / 'include'),
               '-I' + str(base.parent), str(source), '-L' + str(cuda / 'lib/stubs'), '-lcuda', '-ldl',
               '-o', str(observer)]
    (output / 'build.command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (output / 'build.log').open('w') as log:
        subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT, check=True)
    asset_manifest = ROOT / ('build/reconstruction-csrc/affine-particle-material-host/'
                            'continuation-20261101-688f9633-driven-cloth-rigid-soft/official-g1-asset-manifest.json')
    assets = json.loads(asset_manifest.read_text())

    def check_assets():
        for name, expected in assets['files'].items():
            data = (Path(assets['cache_root']) / name).read_bytes()
            assert len(data) == expected['bytes'] and hashlib.sha256(data).hexdigest() == expected['sha256'], name

    check_assets()
    (output / 'asset-verification.json').write_text(json.dumps({
        'manifest_sha256': hashlib.sha256(asset_manifest.read_bytes()).hexdigest(),
        'verified_files': len(assets['files']), 'all_match': True}, indent=2) + '\n')
    tracked = (Path(__file__), base, base.parent / 'surface_view.h', source, observer, asset_manifest,
               ROOT / 'reconstruction/csrc/demo_source_ab.py', ROOT / 'examples/example_robot_g1.py', REFERENCE)
    hashes = {str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in tracked}
    (output / 'provenance.json').write_text(json.dumps({
        'source_sha256': build['extension_sha256'], 'reference_sha256': REFERENCE_SHA, 'files': hashes,
        'schema': schema, 'production_changed': False, 'original_observer_overwritten': False,
        'observed_native_substeps': args.substeps, 'only_pcg_observed': True,
        'synchronizing_observer': True, 'frozen_candidate_replaced': False,
        'complete_owned_launch_coverage': False,
    }, indent=2) + '\n')
    status = {'completed': [], 'complete': False, 'whole_solver_complete': False}
    for backend, side in (('original', 'legacy'), ('source', 'source')):
        assert build_path.read_bytes() == saved
        check_assets()
        assert all(hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha for path, sha in hashes.items())
        for path, sha in build['sources'].items():
            assert hashlib.sha256((ROOT / path).read_bytes()).hexdigest() == sha, path
        directory = output / side
        directory.mkdir()
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend,
                   '--tag', 'capture', '--example', str(ROOT / 'examples/example_robot_g1.py'),
                   '--frames', str(args.frames), '--output', str(directory), '--',
                   '--solver', 'synreal', '--world-count', '1']
        (directory / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        (output / 'status.json').write_text(json.dumps({**status, 'running': side}, indent=2) + '\n')
        with (directory / 'run.log').open('w') as log:
            result = subprocess.run(command, cwd=ROOT, env={**clean_env(), 'LD_PRELOAD': str(observer),
                'DEMO_NATIVE_TRACE_DIR': str(directory / 'actual'), 'DEMO_NATIVE_TRACE_SUBSTEPS': str(args.substeps)},
                stdout=log, stderr=subprocess.STDOUT, timeout=1800)
        status['completed'].append({'side': side, 'exit': result.returncode})
        (output / 'status.json').write_text(json.dumps({**status, 'running': None}, indent=2) + '\n')
        assert result.returncode == 0, side
        assert list((directory / 'actual').glob('*.json')), side
        print('captured PCG raw parameters and pre-call spans', side, flush=True)
    status['complete'] = True
    (output / 'status.json').write_text(json.dumps({**status, 'running': None}, indent=2) + '\n')


if __name__ == '__main__':
    main()
