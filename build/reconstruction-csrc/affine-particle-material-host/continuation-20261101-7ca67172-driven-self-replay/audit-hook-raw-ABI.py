"""Check reconstructed hook bytes against actual same-run CUPTI parameter bytes for all four constructor classes."""
import gzip
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.hook_parameter_bytes import decode, layouts

SELF = BASE.parent / 'continuation-20261101-0dabbaa7-driven-cloth-self'
OUTPUT = BASE / 'raw-ABI'
OUTPUT.mkdir(exist_ok=False)
HASHES = {}


def read(path):
    data = path.read_bytes()
    HASHES[str(path.resolve())] = hashlib.sha256(data).hexdigest()
    return data


constructor_path = SELF / 'constructors-force-order/report.json'
constructor = json.loads(read(constructor_path))
abi = layouts()[1]
reports, failures = [], []
for case in constructor['cases']:
    for side in ('original', 'source'):
        directory = SELF / 'constructors-force-order' / case['case'] / 'external-initializers' / side
        rows = [json.loads(line) for line in read(directory / 'memory.jsonl').decode().splitlines()]
        domain, api = (2, 'cudaLaunchKernel') if side == 'original' else (1, 'cuLaunchKernel')
        actual = [row for row in rows if row.get('domain') == domain and row.get('api') == api
                  and row.get('symbol', '').startswith('_ZN7synreal') and row['symbol'] in abi]
        lines = read(directory / 'launches.txt').decode().splitlines()
        runtime = json.loads(read(directory / 'capture.runtime.json'))
        provenance = json.loads(read(directory / 'wrapper-provenance.json'))
        expected = ('64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
                    if side == 'original' else '7ca67172b329b643102560c83bf3c21a2f7c661e78321ddd5cf83977657c0220')
        assert runtime['image_sha256'] == expected
        assert provenance['complete'] and provenance['original_SDK_mapped'] == (side == 'original')
        assert len(actual) == len(lines) == case['owned_launches']
        packets, parameters, byte_count, kinds = [], 0, 0, set()
        for index, (line, original) in enumerate(zip(lines, actual)):
            packet = decode(line)
            assert packet['owned_launch'] == index
            assert packet['name'] == original['symbol']
            assert packet['geometry'][0] == original['grid_x'] and packet['geometry'][3] == original['block_x']
            equal = packet['parameter_hex'] == original['parameters']
            if not equal:
                failures.append({'case': case['case'], 'backend': side, 'owned_launch': index,
                                 'decoded': packet['parameter_hex'], 'actual': original['parameters']})
            packets.append({'node': packet, 'CUPTI_actual_parameter_hex': original['parameters'],
                            'parameter_bytes_equal': equal, 'CUPTI_sequence': original['seq'],
                            'CUPTI_correlation': original['correlation']})
            parameters += len(packet['parameter_hex'])
            byte_count += sum(packet['parameter_widths'])
            kinds.add(packet['name'])
        filename = OUTPUT / (case['case'] + '-' + side + '-packets.json.gz')
        filename.write_bytes(gzip.compress(json.dumps(packets, separators=(',', ':')).encode(), mtime=0))
        reports.append({'case': case['case'], 'backend': side, 'owned_calls': len(packets),
                        'parameter_count': parameters, 'parameter_bytes': byte_count, 'kernel_types': len(kinds),
                        'all_actual_parameter_bytes_equal': all(packet['parameter_bytes_equal'] for packet in packets),
                        'packets': str(filename), 'packets_sha256': hashlib.sha256(filename.read_bytes()).hexdigest()})
for path in (Path(__file__), ROOT / 'reconstruction/csrc/hook_parameter_bytes.py',
             ROOT / 'reconstruction/csrc/audit_cudahook.py', ROOT / 'reconstruction/diagnostics/cudahook.c',
             ROOT / 'build/reconstruction-csrc/host-particles/build.json'):
    read(path)
report = {'workers': reports, 'failures': failures, 'all_actual_parameter_bytes_equal': not failures,
          'owned_calls': sum(row['owned_calls'] for row in reports),
          'parameter_count': sum(row['parameter_count'] for row in reports),
          'parameter_bytes': sum(row['parameter_bytes'] for row in reports),
          'CUPTI_geometry_compares_only_x': True, 'pointee_contents_compared': False,
          'GPU_used': False, 'original_source_numerical_equivalence_claimed': False,
          'fixed_failures_reclassified': False, 'candidate_promoted': False, 'whole_solver_complete': False,
          'input_sha256': HASHES}
(OUTPUT / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
print('Actual same-run raw ABI checked:', report['owned_calls'], 'calls;', report['parameter_count'],
      'parameters;', report['parameter_bytes'], 'bytes;differences', len(failures), flush=True)
raise SystemExit(int(bool(failures)))
