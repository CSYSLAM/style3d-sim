"""Serial regression on one pinned source image; preserve all strict failures and independent output paths."""
import argparse
import hashlib
import json
import os
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SCENES = ('particles', 'springs', 'pd_springs', 'pd_particles', 'switching', 'soft_contacts', 'pd_soft_contacts',
          'membranes', 'pd_membranes', 'bending', 'pd_bending', 'mixed_cloth', 'pd_mixed_cloth', 'tetrahedra',
          'pd_tetrahedra', 'drag', 'pd_drag', 'surface', 'pd_surface')
DEMOS = ('example_basic_dzhanibekov', 'example_body_spring', 'example_distance_constraint',
         'example_body_point_line', 'example_physical_pendulum', 'example_joints', 'example_basic_joints')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--seeds', type=int, nargs='+', default=[1, 2, 3])
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    expected = build.read_bytes()
    metadata = json.loads(expected)
    jobs = []

    def job(name, module, options, report):
        jobs.append((name, [sys.executable, '-m', 'reconstruction.csrc.'+module, *map(str, options)], report))

    for demo in DEMOS:
        out = args.output/demo
        job(demo, 'demo_source_ab', ['--example', f'examples/{demo}.py', '--frames', 60, '--output', out],
            out/'report.json')
    for module, file in [('host_api_ab', 'api.json'), ('api_float_ab', 'api-float.json')]:
        job(module, module, ['--output', args.output/file], args.output/file)
    for scene in ('free_body', 'two_bodies', 'ground_box', 'ground_box_smooth'):
        for mode in ('newton', 'pd'):
            name = f'bodies-{scene}-{mode}'
            out = args.output/name
            job(name, 'host_bodies_ab', ['--scene', scene, '--mode', mode, '--steps', 30, '--output', out],
                out/'comparison.json')
    for seed in args.seeds:
        for scene in SCENES:
            name = f'{scene}-seed{seed}'
            out = args.output/name
            options = ['--scenario', scene, '--seed', seed, '--output', out]
            if scene in SCENES[:11] and scene != 'switching':
                options += ['--adapter']
            job(name, 'host_particles_ab', options, out/f'comparison-seed{seed}.json')
    state = {'source_sha256': metadata['extension_sha256'], 'jobs_total': len(jobs), 'completed': [], 'running': None,
             'failures_are_strict': True}

    def save():
        target = args.output/'status.json'
        temporary = target.with_suffix('.tmp')
        temporary.write_text(json.dumps(state, indent=2)+'\n')
        temporary.replace(target)

    (args.output/'build.json').write_bytes(expected)
    harness = [Path(__file__), *[ROOT/'reconstruction/csrc'/f'{module}.py' for module in
               ('demo_source_ab', 'host_bodies_ab', 'host_particles_ab', 'host_api_ab', 'api_float_ab')]]
    (args.output/'harness-hashes.json').write_text(json.dumps(
        {str(p.relative_to(ROOT)): hashlib.sha256(p.read_bytes()).hexdigest() for p in harness}, indent=2)+'\n')
    env = {k: v for k, v in os.environ.items() if k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD')}
    for name, command, report in jobs:
        if build.read_bytes() != expected:
            raise RuntimeError('Source image/build changed during regression')
        state['running'] = {'name': name, 'command': command}
        save()
        start = time.monotonic()
        with (args.output/f'{name}.log').open('w') as log:
            code = subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT,
                                  timeout=1800).returncode
        row = {'name': name, 'exit': code, 'seconds': time.monotonic()-start, 'report': str(report)}
        if report.exists():
            data = json.loads(report.read_text())
            row['failures'] = data.get('failures', [])
            row['arrays'] = len(data.get('checks', {})) or data.get('arrays')
            if 'bitwise' in data:
                row['bitwise'] = data['bitwise']['bitwise']
        state['completed'].append(row)
        state['running'] = None
        save()
        print(name, 'exit', code, flush=True)
    state['complete'] = True
    save()
    return int(any(r['exit'] for r in state['completed']))


if __name__ == '__main__':
    raise SystemExit(main())
