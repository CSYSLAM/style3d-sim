"""Build a separate diagnostic observer and capture complete flat parameters for three pointwise entries."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys

from .affine_tetrahedron_contact_ab import clean_env
from .demo_source_ab import ROOT


TOKENS = ('15initialize_stepE', '14initialize_rhsE', '27invert_block_preconditionerE')
PARTICLE_TOKENS = TOKENS + (
    '25initialize_block_diagonalE', '23precondition_and_reduceIN3glm', '19update_cg_directionE',
    '26multiply_matrix_and_reduceINS_17BlockNonZeroEntry', '28update_solution_and_residualEP',
    '20apply_nonlinear_stepE', '15update_velocityE',
)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--all-entries', action='store_true', help='Capture all ten entries in the failing particle path')
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    metadata = json.loads(saved)
    (args.output / 'solver-build.json').write_bytes(saved)
    base = ROOT / 'reconstruction/csrc/native/host_trace.cpp'
    text = base.read_text()
    (args.output / 'base-host_trace.cpp').write_bytes(base.read_bytes())

    def replace(old, new):
        nonlocal text
        assert text.count(old) == 1, old
        text = text.replace(old, new)

    extra = []
    for token in PARTICLE_TOKENS if args.all_entries else TOKENS:
        matches = [spec for name, spec in metadata['kernels'].items() if token in name]
        assert len(matches) == 1
        widths = matches[0]['parameters']
        extra.append('        if (!after && group_ == "' + token + '") {\n'
                     '            const std::size_t widths[] = {' + ','.join(map(str, widths)) + '};\n'
                     '            for (std::size_t i = 0; i < sizeof(widths)/sizeof(widths[0]); ++i)\n'
                     '                bytes("before.param_" + std::to_string(i), args_[i], widths[i]);\n'
                     '        }\n')
    anchor = '        if (group_ == "15initialize_stepE") {\n            const auto n'
    replace(anchor, ''.join(extra) + anchor)
    replace('                   copy("particle_kind", 19, local, 4); }',
            '''                   copy("particle_kind", 19, local, 4);
                   copy("gravity", 1, argument<std::size_t>(args_, 2), 12);
                   copy("world", 3, local, 4); }''')
    replace('            else { copy("x", 1, n, 12); copy("target", 2, n, 12); copy("external", 7, n, 12); }',
            '''            else { copy("x", 1, n, 12); copy("target", 2, n, 12); copy("external", 7, n, 12);
                   const auto local = argument<std::size_t>(args_, 11);
                   copy("mass", 3, local, 4); copy("flags", 8, local, 4);
                   const auto maximum = argument<std::size_t>(args_, 6);
                   if (maximum) { copy("row_count", 4, local, 4); copy("entries", 5, maximum * local, 8); } }''')
    replace('            if (after) copy("inverse", 3, n, 36); else copy("blocks", 0, n, 36);',
            '''            if (after) copy("inverse", 3, n, 36);
            else { copy("blocks", 0, n, 36);
                   const auto local = argument<std::size_t>(args_, 5);
                   copy("mass", 1, local, 4); copy("flags", 2, local, 4); }''')
    source = args.output / 'host_trace_packets.cpp'
    source.write_text(text)
    observer = args.output / 'host_trace_packets.so'
    cuda = ROOT / 'build/toolchains/cuda-12.4'
    command = ['c++', '-std=c++17', '-O2', '-shared', '-fPIC', '-I' + str(cuda / 'include'),
               '-I' + str(base.parent), str(source), '-L' + str(cuda / 'lib/stubs'), '-lcuda', '-ldl',
               '-o', str(observer)]
    (args.output / 'build.command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (args.output / 'build.log').open('w') as log:
        subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT, check=True)
    paths = (Path(__file__), base, source, observer, base.parent / 'surface_view.h',
             ROOT / 'reconstruction/csrc/particle_full_worker_trace.py')
    hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths}
    (args.output / 'provenance.json').write_text(json.dumps({
        'source_sha256': metadata['extension_sha256'], 'sha256': hashes,
        'original_observer_overwritten': False, 'production_modified': False,
        'all_particle_entries': args.all_entries}, indent=2) + '\n')
    for backend in ('legacy', 'source'):
        assert build.read_bytes() == saved
        assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest() == sha for p, sha in hashes.items())
        command = [sys.executable, '-m', 'reconstruction.csrc.particle_full_worker_trace', '--backend', backend,
                   '--output', str(args.output / backend)]
        (args.output / (backend + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
        with (args.output / (backend + '.log')).open('w') as log:
            subprocess.run(command, cwd=ROOT, env={**clean_env(), 'LD_PRELOAD': str(observer)},
                           stdout=log, stderr=subprocess.STDOUT, timeout=900, check=True)
        print('complete flat packets', backend, flush=True)


if __name__ == '__main__':
    main()
