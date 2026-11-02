"""Compare the PTX of kernels compiled from reconstruction/csrc with the PTX embedded in the legacy _core.so.

    .venv/bin/python -m reconstruction.csrc.ptx_compare [--nvcc PATH] [kernel-name-substring ...]

Each .cu under csrc/kernels is compiled to PTX for sm_52 (the legacy binary ships sm_52 cubins plus PTX 8.4, which
the driver JIT-compiles on newer GPUs). Every .entry found in our PTX is looked up by its mangled name in the legacy
PTX and compared after normalisation: comments and blank lines dropped, register numbers and branch labels renamed
in order of first use. Identical normalised PTX means the driver JIT produces the same machine code.
"""
import argparse
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
CSRC = Path(__file__).resolve().parent
LEGACY_PTX = ROOT/'build/reconstruction-ptx/4c223854a5a55414'
GLM = ROOT/'build/third_party/glm-1.0.1'
OUT = ROOT/'build/reconstruction-csrc'
DEFAULT_NVCC = str(ROOT/'build/toolchains/cuda-12.4/bin/nvcc')
CSRC_ENTRIES_USED = set()   # entries kernel_ab ran from our compiled PTX (RECONSTRUCTION_KERNELS=csrc)

ENTRY = re.compile(r'^\.(?:visible|weak) \.entry (\S+?)\(', re.M)


def entries(text):
    """Map mangled entry name -> full text of that entry (header up to the closing brace)."""
    found = {}
    for match in ENTRY.finditer(text):
        start, depth = match.start(), 0
        body_start = text.index('{', match.end())
        for pos in range(body_start, len(text)):
            if text[pos] == '{':
                depth += 1
            elif text[pos] == '}':
                depth -= 1
                if depth == 0:
                    found[match.group(1)] = text[start:pos+1]
                    break
    return found


def normalise(entry):
    lines = []
    for line in entry.splitlines():
        line = ' '.join(line.split('//')[0].split())
        if line:
            lines.append(line)
    text = '\n'.join(lines)
    names, counts = {}, {}

    def rename(match):
        key = match.group(0)
        if key not in names:
            kind = match.group(1)
            counts[kind] = counts.get(kind, 0)+1
            names[key] = f'{kind}#{counts[kind]-1}'
        return names[key]
    text = re.sub(r'(%[a-z]+)\d+\b', rename, text)
    text = re.sub(r'(\$L__BB)\d+_\d+', rename, text)
    # The declared register counts differ when numbering differs; they carry no semantics.
    return re.sub(r'(\.reg \.\w+ %\w+)<\d+>', r'\1<n>', text)


def show_legacy(legacy, filters):
    """Print matching legacy entries with readable parameter names (P0, P1, ...)."""
    names = [n for n in legacy if 'synreal' in n and any(re.search(r'\d' + re.escape(f) + r'[EI]', n) for f in filters)]
    demangled = subprocess.run(['c++filt'], input='\n'.join(names), capture_output=True, text=True).stdout.splitlines()
    for name, signature in zip(names, demangled):
        print('//', signature.replace('glm::vec<3, float, (glm::qualifier)0>', 'vec3')
              .replace('glm::mat<3, 3, float, (glm::qualifier)0>', 'mat3').replace('(glm::qualifier)0', 'Q'))
        text = re.sub(re.escape(name) + r'_param_(\d+)', r'P\1', legacy[name])
        print('\n'.join(line for line in text.splitlines() if line.strip()))
        print()
    return 0


def compile_ptx(source, nvcc):
    OUT.mkdir(parents=True, exist_ok=True)
    target = OUT/(source.stem+'.ptx')
    cmd = [nvcc, '-ptx', '-arch=sm_52', '-Wno-deprecated-gpu-targets', '-diag-suppress=20012', '-std=c++17', '-O3',
           # Release build of the legacy library: NDEBUG removes glm's index asserts, which changes IR order.
           '-DNDEBUG', '-I', str(GLM),
           '-I', str(CSRC/'kernels'), str(source), '-o', str(target)]
    subprocess.run(cmd, check=True)
    return target.read_text()


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    # The legacy PTX is ISA 8.4 from CUDA 12.4 (NVVM CL-34097967); 12.8 emits atom instead of red for unused results.
    parser.add_argument('--nvcc', default=DEFAULT_NVCC)
    parser.add_argument('--show-diff', action='store_true')
    parser.add_argument('filters', nargs='*')
    parser.add_argument('--show-legacy', action='store_true',
                        help='print the demangled signature and PTX of the legacy entries matching the filters')
    args = parser.parse_args()
    legacy = {}
    for path in sorted(LEGACY_PTX.glob('*.ptx')):
        legacy.update(entries(path.read_text()))
    if args.show_legacy:
        return show_legacy(legacy, args.filters)
    failures = identical = different = 0
    compiled = set()
    for source in sorted((CSRC/'kernels').glob('*.cu')):
        ours = entries(compile_ptx(source, args.nvcc))
        for name, text in ours.items():
            if args.filters and not any(f in name for f in args.filters):
                continue
            if name not in legacy:
                print(f'MISSING-IN-LEGACY {source.name} {name}')
                failures += 1
                continue
            a, b = normalise(legacy[name]), normalise(text)
            same = a == b
            compiled.add(name)
            identical += same
            different += not same
            failures += not same
            print(f'{"PTX-IDENTICAL" if same else "PTX-DIFFERENT"} {source.name} {name}')
            if not same and args.show_diff:
                import difflib
                sys.stdout.writelines(difflib.unified_diff(a.splitlines(True), b.splitlines(True), 'legacy', 'ours'))
                print()
    # SynReal-owned entries only; Thrust/CUB instances (namespace thrust:: / cub::) come from the libraries.
    owned = [n for n in legacy if n.startswith('_ZN7synreal')]
    print(f'summary: {identical} PTX-identical, {different} different, '
          f'{len([n for n in owned if n not in compiled])} of {len(owned)} SynReal entries not written yet')
    return 1 if failures else 0


if __name__ == '__main__':
    sys.exit(main())
