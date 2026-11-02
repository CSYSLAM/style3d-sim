"""Disambiguate host accumulation order using captured original spring/cloth matrix inputs."""
import json
from pathlib import Path

import numpy as np

from reconstruction.precompute import cloth_constant_matrix, spring_constant_matrix
from .host_particles_ab import OUT
from .mixed_cloth_host_cases import fixtures


def spring_then_triangles(case):
    f = np.float32
    n = case['count']
    spring = spring_constant_matrix(n, case['spring_indices'], case['spring_stiffness'])
    diagonal = spring[0].copy()
    rows = [dict() for _ in range(n)]
    for row in range(n):
        for slot in range(spring[1][row]):
            rows[row][int(spring[2][slot, row])] = spring[3][slot, row]
    for indices, pose, stiffness, area in zip(case['triangle_indices'], case['triangle_inv_dms'],
                                             case['triangle_aniso_stiffnesses'], case['triangle_rest_areas']):
        m = pose.reshape(-1)
        u, v = (f(-m[0]-m[2]), m[0], m[2]), (f(-m[1]-m[3]), m[1], m[3])
        ku, kv = f(stiffness[0]+stiffness[2]), f(stiffness[2]+stiffness[1])
        for a in range(3):
            pa, qa = f(u[a]*ku), f(v[a]*kv)
            for b in range(a, 3):
                value = f(f(f(pa*u[b])+f(qa*v[b]))*area)
                row, col = int(indices[a]), int(indices[b])
                if a == b:
                    diagonal[row] = f(diagonal[row]+value)
                else:
                    rows[row][col] = f(rows[row].get(col, f(0))+value)
                    rows[col][row] = f(rows[col].get(row, f(0))+value)
    return diagonal, rows


def main():
    result = {}
    for name, case in fixtures(1):
        directory = OUT/'mixed_cloth/trace-seed1'/('oracle-'+name)/'legacy'
        if not directory.exists():
            continue
        diagonal, rows = spring_then_triangles(case)
        actual = np.fromfile(next(directory.glob('000000.*host_diagonal.bin')), dtype='f4')
        entry_path = next(directory.glob('*39add_cloth*before.entries.bin'))
        dtype = np.dtype([('column', 'i4'), ('matrix', 'f4', (9,))])
        entries = np.fromfile(entry_path, dtype=dtype).reshape(-1, case['count']*case['worlds'])
        checks = {'diagonal': bool(np.array_equal(diagonal.view('u4'), actual.view('u4')))}
        for world in range(case['worlds']):
            for row, columns in enumerate(rows):
                for slot, (column, value) in enumerate(sorted(columns.items())):
                    item = entries[slot, world*case['count']+row]
                    checks[f'{world}/{row}/{slot}/column'] = int(item['column']) == world*case['count']+column
                    checks[f'{world}/{row}/{slot}/value'] = bool(item['matrix'][0].view('u4') == value.view('u4'))
        assert all(checks.values()), (name, [key for key, equal in checks.items() if not equal])
        cloth = cloth_constant_matrix(case['count'], case['triangle_indices'], case['triangle_inv_dms'],
                                      case['triangle_rest_areas'], case['triangle_aniso_stiffnesses'],
                                      np.empty((0, 4), 'i4'), [], [], [])
        spring = spring_constant_matrix(case['count'], case['spring_indices'], case['spring_stiffness'])
        grouped = np.float32(cloth[0]+spring[0])
        cloth_first = cloth[0].copy()
        for (a, b), k in zip(case['spring_indices'], case['spring_stiffness']):
            cloth_first[a] = np.float32(cloth_first[a]+k)
            cloth_first[b] = np.float32(cloth_first[b]+k)
        result[name] = {'checks': checks,
                        'grouped_diagonal_equal': bool(np.array_equal(grouped.view('u4'), actual.view('u4'))),
                        'cloth_first_diagonal_equal': bool(np.array_equal(cloth_first.view('u4'), actual.view('u4')))}
    assert not result['mixed_w2_rounding_springs']['cloth_first_diagonal_equal']
    assert not result['mixed_w2_rounding_cloth']['grouped_diagonal_equal']
    target = OUT/'mixed_cloth/precompute-audit.json'
    target.write_text(json.dumps(result, indent=2)+'\n')
    print('Original host matrix audits passed', len(result), 'cases;', sum(len(r['checks']) for r in result.values()),
          'raw-bit checks; both incorrect accumulation candidates rejected')


if __name__ == '__main__':
    main()
