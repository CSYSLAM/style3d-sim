"""Version the historical mixed checker with an upload fence and complete raw replay evidence."""
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
original = ROOT / 'reconstruction/csrc/mixed_pointwise_packet_replay.py'
before = original.read_text()
assert not (BASE / 'mixed-replay.py').exists()
(BASE / 'before-mixed-pointwise.py').write_text(before)
text = before


def replace(old, new):
    global text
    assert text.count(old) == 1, old
    text = text.replace(old, new)


replace('import argparse\n',
        "import sys\n__package__ = 'reconstruction.csrc'\nsys.path.insert(0, str(__import__('pathlib').Path.cwd()))\n"
        'import argparse\n')
replace('    args.output.mkdir(parents=True, exist_ok=False)\n',
        '    args.output.mkdir(parents=True, exist_ok=False)\n'
        "    (args.output / 'raw').mkdir()\n")
replace('                checks = []\n',
        "                checks, actual_arrays = [], {}\n"
        "                for group_number, (address, group) in enumerate(groups.items()):\n"
        "                    actual_arrays[f'group-{group_number}/initial'] = group['initial'].copy()\n"
        "                for index, parameter in enumerate(parameters):\n"
        "                    actual_arrays[f'actual-parameter-{index}'] = np.frombuffer(bytes(parameter), dtype='u1').copy()\n")
replace('                        reset()\n',
        '                        reset()\n'
        '                        # Pageable H2D must complete before a nonblocking stream consumes these buffers.\n'
        '                        driver.check(driver.cu.cuCtxSynchronize())\n')
replace("                            same[outputs[index]] = actual.tobytes() == data\n",
        "                            same[outputs[index]] = actual.tobytes() == data\n"
        "                            actual_arrays[f'{backend}/{trial}/output-{index}'] = actual.copy()\n"
        "                            actual_arrays[f'expected-{index}'] = np.frombuffer(data, dtype='u1').copy()\n")
replace("                        row = {'backend': backend, 'trial': trial, 'outputs_equal': same}\n",
        "                        readonly_bytes = 0\n"
        "                        for group_number, (address, group) in enumerate(groups.items()):\n"
        "                            after = driver.download(group['pointer'], np.empty_like(group['initial']))\n"
        "                            actual_arrays[f'{backend}/{trial}/group-{group_number}'] = after.copy()\n"
        "                            protected = np.ones(group['size'], dtype=bool)\n"
        "                            for index, data in expected.items():\n"
        "                                if value(index) == address:\n"
        "                                    protected[:len(data)] = False\n"
        "                            assert after[protected].tobytes() == group['initial'][protected].tobytes()\n"
        "                            readonly_bytes += int(protected.sum())\n"
        "                        row = {'backend': backend, 'trial': trial, 'outputs_equal': same,\n"
        "                               'readonly_bytes_checked': readonly_bytes}\n")
replace('                certificate = None\n',
        "                raw_path = args.output / 'raw' / f'{side}-{meta_path.stem}.npz'\n"
        "                np.savez_compressed(raw_path, **actual_arrays)\n"
        "                raw_metadata = {'path': str(raw_path), 'sha256': hashlib.sha256(raw_path.read_bytes()).hexdigest(),\n"
        "                                'groups': [{'address': address, 'size': group['size'],\n"
        "                                            'device_address': group['pointer'].value}\n"
        "                                           for address, group in groups.items()],\n"
        "                                'output_arguments': {str(index): label for index, label in outputs.items()},\n"
        "                                'original_parameter_hex': [value.hex() for value in raw]}\n"
        '                certificate = None\n')
replace("                rows.append({'capture': side, 'packet': meta_path.name, 'checks': checks,\n",
        "                rows.append({'capture': side, 'packet': meta_path.name, 'checks': checks, 'raw': raw_metadata,\n")
replace("                  'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}\n",
        "                  'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),\n"
        "                  'upload_completion_fenced': True, 'out_of_allocation_guards_checked': False}\n")
compile(text, str(BASE / 'mixed-replay.py'), 'exec')
assert max(map(len, text.splitlines())) <= 128
(BASE / 'mixed-replay.py').write_text(text)
plan = {'historical_checker': str(original), 'historical_checker_sha256': hashlib.sha256(before.encode()).hexdigest(),
        'versioned_checker_sha256': hashlib.sha256(text.encode()).hexdigest(),
        'fixed_pair': str(BASE.parent / 'continuation-20261101-0dabbaa7-mixed-newton-fixed/frozen-reproduced-mixed-pair'),
        'packets': 732, 'trials_per_backend': 2, 'planned_actual_calls': 4392,
        'GPU_workers_serial': True, 'minimum_free_memory_MiB': 4096, 'external_apps_allowed': True,
        'original_cohort_or_failed_source_replaced': False, 'production_modified': False,
        'whole_solver_complete': False}
(BASE / 'mixed-replay-plan.json').write_text(json.dumps(plan, indent=2) + '\n')
print('Prepared fenced historical mixed replay; complete raw groups/parameters/outputs will be preserved')
