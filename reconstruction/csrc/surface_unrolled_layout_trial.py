"""Build a source-only layout trial matching the original preconditioner's seven explicit scatter sites."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import subprocess

from .demo_source_ab import ROOT
from .library_entries import entries
from .prepare_surface_layout_trial import generate
from .ptx_compare import DEFAULT_NVCC


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--zero-contact-data', action='store_true', help='Restore observed zero-initialized contact records')
    parser.add_argument('--persistent-contact-data', action='store_true', help='Keep the output record outside the grid loop')
    parser.add_argument('--return-contact-data', action='store_true', help='Return a zero record on rejected contacts')
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    text = generate()
    start = text.index('__device__ __forceinline__ void trial_scatter_blocks(')
    stop = text.index('__device__ __forceinline__ void trial_product(', start)
    body = text[start:stop]
    before = '    for (int j = 0; j < jacobian.count; ++j) {'
    assert body.count(before) == 1
    body = body.replace(before, '    #pragma unroll\n    for (int j = 0; j < 7; ++j) {\n'
                               '        if (j >= jacobian.count) break;')
    text = text[:start] + body + text[stop:]
    if args.zero_contact_data or args.persistent_contact_data or args.return_contact_data:
        # The actual force PTX seeds both Jacobian target/weight records and matrix/force fields with zero bit patterns.
        assert text.count('SurfaceContactTrial contact;') == 5
        text = text.replace('SurfaceContactTrial contact;', 'SurfaceContactTrial contact{};')
    if args.persistent_contact_data:
        # Original zero-seed registers precede the grid-stride loop and remain live across its backedge.
        loop = ('    for (size_t i = thread_index(); i < bound; i += static_cast<size_t>(gridDim.x) * blockDim.x) {\n'
                '        SurfaceContactTrial contact{};')
        assert text.count(loop) == 4
        text = text.replace(loop, '    SurfaceContactTrial contact{};\n' + loop.split('\n')[0])
    if args.return_contact_data:
        assert not args.persistent_contact_data
        signature = ('bool surface_contact(const SurfaceContactView& view, size_t i, '
                     'SurfaceContactTrial& output)')
        assert signature in text
        text = text.replace(signature, 'SurfaceContactTrial surface_contact(const SurfaceContactView& view, size_t i)')
        begin = text.index('__device__ __forceinline__ SurfaceContactTrial surface_contact(')
        end = text.index('__device__ __forceinline__ void trial_scatter(', begin)
        calculation = text[begin:end].replace('return false;', 'return SurfaceContactTrial{};')
        assert '    output = contact;\n    return true;' in calculation
        calculation = calculation.replace('    output = contact;\n    return true;', '    return contact;')
        text = text[:begin] + calculation + text[end:]
        call = re.compile(r'SurfaceContactTrial contact\{\};\n        if \(!surface_contact(<[^>]+>)'
                          r'\(view, i, contact\)\) continue;')
        text, replaced = call.subn(r'SurfaceContactTrial contact = surface_contact\1(view, i);', text)
        assert replaced == 4
    source = args.output / 'surface_struct220_unrolled.cu'
    source.write_text(text)
    target = source.with_suffix('.ptx')
    command = [DEFAULT_NVCC, '-ptx', '-arch=sm_52', '-Wno-deprecated-gpu-targets', '-diag-suppress=20012',
               '-std=c++17', '-O3', '-DNDEBUG', '-I', str(ROOT / 'build/third_party/glm-1.0.1'),
               str(source), '-o', str(target)]
    subprocess.run(command, check=True)
    trial = entries(target.read_text())
    symbol = next(name for name in trial if '34add_surface_contact_preconditioner' in name)
    original = next(body for path in (ROOT / 'build/reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx')
                    for name, body in entries(path.read_text()).items() if name == symbol)
    original_sites = original.count('red.global.add.f32')
    trial_sites = trial[symbol].count('red.global.add.f32')
    originals = {name: body for path in (ROOT / 'build/reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx')
                 for name, body in entries(path.read_text()).items() if name in trial}
    shape = {name: {tag: {'mov_u32': body.count('mov.u32'), 'static_red': body.count('red.global.add.f32'),
                          'local_declarations': re.findall(r'^\s*\.local \.align[^;]+;', body, re.M)}
                    for tag, body in (('original', originals[name]), ('trial', body))}
             for name, body in trial.items()}
    report = {'experimental_only': True, 'production_changed': False, 'original_preconditioner_red_sites': original_sites,
              'zero_contact_data': args.zero_contact_data or args.persistent_contact_data or args.return_contact_data,
              'persistent_contact_data': args.persistent_contact_data, 'kernel_shapes': shape,
              'return_contact_data': args.return_contact_data,
              'trial_preconditioner_red_sites': trial_sites, 'static_site_counts_match': trial_sites == original_sites,
              'source_sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
              'ptx_sha256': hashlib.sha256(target.read_bytes()).hexdigest(), 'command': command,
              'generator_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
              'base_generator_sha256': hashlib.sha256((ROOT / 'reconstruction/csrc/prepare_surface_layout_trial.py')
                                                     .read_bytes()).hexdigest(),
              'whole_solver_complete': False}
    (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print('preconditioner static red sites', original_sites, trial_sites, flush=True)


if __name__ == '__main__':
    main()
