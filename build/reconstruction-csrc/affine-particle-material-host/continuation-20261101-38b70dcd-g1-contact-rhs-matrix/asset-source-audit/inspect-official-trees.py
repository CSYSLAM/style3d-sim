"""Read official repository metadata only, looking for the exact missing trampoline mesh without downloading packages."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import urllib.error
import urllib.request

base = Path(__file__).resolve().parent
records = []
for repo in ('Style3D/style3d-sim-assets', 'Style3D/style3d-sim'):
    url = 'https://api.github.com/repos/' + repo + '/git/trees/main?recursive=1'
    request = urllib.request.Request(url, headers={'User-Agent': 'Style3D-source-reconstruction-audit',
                                                 'Accept': 'application/vnd.github+json'})
    stem = repo.replace('/', '-')
    try:
        with urllib.request.urlopen(request, timeout=30) as response:
            data, status, headers = response.read(), response.status, dict(response.headers)
        (base / (stem + '-tree.json')).write_bytes(data)
        tree = json.loads(data)
        assert status == 200 and not tree.get('truncated')
        matches = [row for row in tree['tree'] if any(token in row['path'].lower()
                                                    for token in ('trampoline', '1051'))]
        records.append({'repository': repo, 'URL': url, 'status': status, 'tree_sha': tree['sha'],
                        'tree_entries': len(tree['tree']), 'matching_paths': matches,
                        'exact_mesh_paths': [row for row in tree['tree']
                                             if Path(row['path']).name == 'trampoline_v1051.obj'],
                        'response_sha256': hashlib.sha256(data).hexdigest(), 'response_headers': headers})
    except urllib.error.HTTPError as error:
        data = error.read()
        (base / (stem + '-error.json')).write_bytes(data)
        records.append({'repository': repo, 'URL': url, 'status': error.code,
                        'error_body_sha256': hashlib.sha256(data).hexdigest()})
report = {'UTC': datetime.now(timezone.utc).isoformat(), 'queries': records,
          'mesh_downloaded': False, 'SDK_updated': False, 'substitute_mesh_created': False,
          'whole_solver_complete': False,
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(base / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
for record in records:
    print(record['repository'], record['status'], 'matches:',
          [row['path'] for row in record.get('matching_paths', [])], flush=True)
