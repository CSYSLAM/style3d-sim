"""Compare real CUPTI module images with direct-PTX/source images; do not infer causes from trajectory differences."""
import argparse
import hashlib
import json
from pathlib import Path
import struct

from .dump_revision_pcg_jit import sections


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--capture', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert not args.output.exists()
    phase, modules = '', []
    for line in (args.capture / 'memory.jsonl').read_text().splitlines():
        row = json.loads(line)
        if row.get('event') == 'module_loaded':
            path = args.capture / row['file']
            blob = path.read_bytes()
            assert blob.startswith(b'\x7fELF')
            modules.append({'phase': phase, 'file': row['file'], 'sha256': hashlib.sha256(blob).hexdigest(),
                            'bytes': len(blob), 'elf_flags': struct.unpack_from('<I', blob, 48)[0]})
        elif row.get('event'):
            phase = row['event']
    runtimes = [r for r in modules if r['phase'].startswith('launch-before:original-runtime:')]
    assert len(runtimes) == 1, 'This diagnostic expects one complete SDK module'
    runtime = (args.capture / runtimes[0]['file']).read_bytes()
    original = sections(runtime)
    checks = []
    for row in modules:
        blob = (args.capture / row['file']).read_bytes()
        extracted = sections(blob)
        names = sorted(name for name in extracted if name.startswith('.text.') and name in original)
        equal = [name for name in names if extracted[name] == original[name]]
        checks.append({**row, 'whole_module_equal_actual_runtime': blob == runtime,
                       'compared_kernel_texts': len(names), 'identical_kernel_texts': len(equal),
                       'different_kernel_texts': [name for name in names if name not in equal]})
    literal = [row for row in checks if row['phase'].startswith('literal-module-before:')]
    assert literal and all(row['whole_module_equal_actual_runtime'] for row in literal)
    report = {'modules': checks, 'all_literal_ptx_images_equal_actual_sdk_image': True,
              'actual_sdk_text_entries': sum(name.startswith('.text.') for name in original),
              'trajectory_cause_proven': False, 'frozen_candidates_replaced': False,
              'whole_solver_complete': False,
              'harness_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
    args.output.write_text(json.dumps(report, indent=2) + '\n')
    print('literal PTX images equal actual SDK module', len(literal),
          'SDK text entries', report['actual_sdk_text_entries'], flush=True)


if __name__ == '__main__':
    main()
