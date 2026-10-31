"""Run the frozen auxiliary arithmetic fixtures on all 47 current-reference/source-image library entries."""
import argparse
import ctypes
import hashlib
import json
from pathlib import Path
import re

import numpy as np

from reconstruction import kernel_ab as k
from reconstruction.diagnostics import cub_remaining_ab, cub_scan_ab, thrust_ab
from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE, REFERENCE_SHA
from .host_particles_ab import native_source
from .library_entries import entries
from . import library_reduction_cases, native_cuda, ptx_compare


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def inventory():
    assert sha(REFERENCE) == REFERENCE_SHA
    manifest_path = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    manifest = json.loads(manifest_path.read_text())
    names = {name for name in manifest['kernels'] if not name.startswith('_ZN7synreal')}
    assert len(names) == 47
    source, reference, inputs = {}, {}, {}
    bundle = manifest_path.parent/'source_ptx_bundle.h'
    inputs[str(bundle)] = sha(bundle)
    modules = re.findall(r'\{("[^"\n]+"), R"(\w+)\((.*?)\)\2"\},', bundle.read_text(), re.S)
    for path, delimiter, text in modules:
        for name, entry in entries(text).items():
            if name in names:
                source.setdefault(name, (text, entry))
    for path in sorted((ROOT/'build/reconstruction-ptx'/REFERENCE_SHA[:16]).glob('*.ptx')):
        inputs[str(path)] = sha(path)
        text = path.read_text()
        for name, entry in entries(text).items():
            if name in names:
                reference.setdefault(name, (text, entry))
    assert set(source) == set(reference) == names
    details = {}
    for name in sorted(names):
        old, new = [ptx_compare.normalise(table[name][1]) for table in (reference, source)]
        visible = lambda text: re.sub(r'^\.(?:visible|weak) ', '', text)
        details[name] = {'normalized_ptx_identical': old == new,
                         'only_entry_visibility_can_differ': visible(old) == visible(new)}
    assert all(row['only_entry_visibility_can_differ'] for row in details.values())
    return manifest, source, reference, inputs, details


def bind_discovery(reference):
    """Change only entry discovery for the new ABI; the frozen inputs and arithmetic checks remain verbatim."""
    def definitions(prefix, family=''):
        for name, (text, entry) in sorted(reference.items()):
            if name.startswith(prefix) and family in name:
                yield text, name, entry

    def verify_extraction(unused_bootstrap_token):
        # Old discovery used a removed PCG name only to trigger extraction, never as a test operand.
        assert sha(REFERENCE) == REFERENCE_SHA and len(reference) == 47

    thrust_ab.definitions = lambda: definitions('_ZN6thrust')
    cub_remaining_ab.entries = lambda family: definitions('_ZN3cub', family)
    for module in (thrust_ab, cub_scan_ab):
        module.LEGACY_SHA = REFERENCE_SHA
        module.legacy_ptx = verify_extraction


class SourceDriver(native_cuda.Driver):
    def __init__(self, core, reference, manifest):
        self.native = core._KernelDriver()
        self.allocations = []
        self.source_entries_used = set()
        self.reference = reference
        self.parameters = manifest['kernels']
        self.functions = {}

    def function(self, text, name):
        assert name in self.reference and text == self.reference[name][0]
        self.source_entries_used.add(name)
        pointer = ctypes.c_void_p(self.native.function(name))
        self.functions[pointer.value] = name
        return pointer

    def launch(self, function, threads, params, block=256):
        name = self.functions[function.value]
        assert [ctypes.sizeof(value) for value in params] == self.parameters[name]['parameters'], name
        super().launch(function, threads, params, block)


def frozen_checks(driver, seed):
    rng = np.random.default_rng(seed)
    result = thrust_ab.run(driver, rng)
    result.update(cub_scan_ab.run(driver, rng))
    for function in (cub_remaining_ab.histogram, cub_remaining_ab.single_sort, cub_remaining_ab.sweeps,
                     cub_remaining_ab.onesweep, cub_remaining_ab.reductions):
        result.update(function(driver, rng))
    result.update({key+'/signed_zero': value for key, value in
                   cub_remaining_ab.reductions(driver, cub_remaining_ab.SignedZeroInputs()).items()})
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--seed', type=int, default=1)
    parser.add_argument('--inventory-only', action='store_true')
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    manifest, source, reference, inputs, details = inventory()
    (args.output/'build.json').write_text(json.dumps(manifest, indent=2)+'\n')
    files = [Path(__file__), Path(k.__file__), Path(thrust_ab.__file__), Path(cub_scan_ab.__file__),
             Path(cub_remaining_ab.__file__), Path(library_reduction_cases.__file__), ROOT/'reconstruction/auxiliary.py']
    inputs.update({str(path): sha(path) for path in files})
    (args.output/'provenance.json').write_text(json.dumps(inputs, indent=2)+'\n')
    report = {'reference_sha256': REFERENCE_SHA, 'source_sha256': manifest['extension_sha256'],
              'source_cuda_digest': manifest['cuda_source_digest'], 'seed': args.seed, 'entries': details,
              'discovery_only_rebound': True, 'frozen_arithmetic_unchanged': True, 'backends': {},
              'full_solver_complete': False}
    if args.inventory_only:
        (args.output/'inventory.json').write_text(json.dumps(report, indent=2)+'\n')
        print('Inventoried', len(details), 'entries; no GPU execution', flush=True)
        return 0
    bind_discovery(reference)
    for backend in ('original-ptx', 'source-image'):
        core = native_source() if backend == 'source-image' else None
        driver = SourceDriver(core, reference, manifest) if core is not None else k.Driver()
        used = set()
        function = driver.function

        def selected_function(text, name):
            assert name in reference and text == reference[name][0]
            used.add(name)
            return function(text, name)

        driver.function = selected_function
        try:
            checks = frozen_checks(driver, args.seed)
        finally:
            driver.free()
        assert used == set(reference), ('Incomplete current ABI entry coverage', set(reference)-used)
        bad = {key: value for key, value in checks.items() if not value['bitwise_equal']}
        report['backends'][backend] = {'checks': len(checks), 'failures': bad, 'entries_used': sorted(used)}
        (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
        print(backend, 'checks', len(checks), 'failures', len(bad), 'entries', len(used), flush=True)
    driver = k.Driver()
    native = SourceDriver(core, reference, manifest)
    old_function, old_launch = driver.function, driver.launch
    native_functions = set()

    def paired_function(text, name):
        assert name in reference
        if text == source[name][0]:
            pointer = native.function(reference[name][0], name)
            native_functions.add(pointer.value)
            return pointer
        assert text == reference[name][0]
        return old_function(text, name)

    def paired_launch(function, threads, params, block=256):
        if function.value in native_functions:
            native.launch(function, threads, params, block)
        else:
            old_launch(function, threads, params, block)

    driver.function, driver.launch = paired_function, paired_launch
    try:
        checks, used = library_reduction_cases.run(driver, np.random.default_rng(args.seed+100), reference,
                                                  {name: row[0] for name, row in source.items()})
    finally:
        driver.free()
        native.free()
    expected = {name for name in reference if 'DeviceReduce' in name}
    assert used == expected
    bad = {key: value for key, value in checks.items() if not value['bitwise_equal']}
    report['exceptional_reductions'] = {'checks': len(checks), 'failures': bad, 'entries_used': sorted(used)}
    report['original_solver_mapped'] = '_core.cpython-' in Path('/proc/self/maps').read_text()
    assert not report['original_solver_mapped']
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print('Exceptional reductions', len(checks), 'failures', len(bad), flush=True)
    return int(any(row['failures'] for row in report['backends'].values()) or bool(bad))


if __name__ == '__main__':
    raise SystemExit(main())
