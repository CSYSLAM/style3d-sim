"""Audit and optionally compile the evidence-backed CUDA sources, without the reference library."""
import argparse
from concurrent.futures import ThreadPoolExecutor
import hashlib
import json
from pathlib import Path
import shutil
import subprocess

ROOT = Path(__file__).resolve().parents[1]
ARCHIVE = ROOT/'reconstruction/recovered'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compile', action='store_true')
    parser.add_argument('--jobs', type=int, default=4)
    args = parser.parse_args()
    manifest = json.loads((ARCHIVE/'manifest.json').read_text())
    failures = [p for p, expected in manifest['files_sha256'].items()
                if not (ARCHIVE/p).is_file() or hashlib.sha256((ARCHIVE/p).read_bytes()).hexdigest() != expected]
    if failures:
        raise SystemExit('Archive integrity failure: '+str(failures))
    print(f"Verified {len(manifest['sources'])} CUDA source hashes and all evidence/support files.", flush=True)
    if not args.compile:
        return
    nvcc = shutil.which('nvcc') or '/usr/local/cuda/bin/nvcc'
    output = ROOT/'build/reconstruction-kernels'
    output.mkdir(parents=True, exist_ok=True)
    def build(item):
        source, evidence = item
        name = source.replace('/', '__')
        command = [nvcc, '-cubin', '-arch=sm_120', '-std=c++14', '-diag-suppress=177',
                   '-I', str(ARCHIVE/'recover'), str(ARCHIVE/source), '-o', str(output/(name+'.cubin'))]
        result = subprocess.run(command, capture_output=True, text=True, timeout=180)
        log = result.stdout+result.stderr
        (output/(name+'.log')).write_text(log)
        return {'source': source, 'source_sha256': evidence['source_sha256'], 'returncode': result.returncode}
    with ThreadPoolExecutor(max_workers=max(1,min(args.jobs,8))) as pool:
        results = list(pool.map(build, manifest['sources'].items()))
    report = {'nvcc': subprocess.check_output([nvcc, '--version'], text=True), 'arch': 'sm_120',
              'scope': 'Fresh compilation only; runtime numerical evidence remains in the imported reports.',
              'passed': sum(r['returncode'] == 0 for r in results), 'failed': sum(r['returncode'] != 0 for r in results),
              'results': results}
    (output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps({k: report[k] for k in ('passed', 'failed', 'scope')}), flush=True)
    print(output/'report.json')
    if report['failed']:
        raise SystemExit(1)


if __name__ == '__main__':
    main()
