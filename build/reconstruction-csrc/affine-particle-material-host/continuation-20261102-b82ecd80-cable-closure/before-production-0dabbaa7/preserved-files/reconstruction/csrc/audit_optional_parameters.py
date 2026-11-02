"""Flag direct optional-parameter checks that need manual PTX/source inspection; this is not equivalence proof."""
import json
import re

from .host_particles_ab import OUT
from .library_entries import entries


def guards(body):
    aliases, result = {}, set()
    for line in body.splitlines():
        parameter = re.search(r'ld\.param\.u64\s+(%rd\d+),\s*\[[^\]]+_param_(\d+)\]', line)
        if parameter:
            aliases[parameter[1]] = int(parameter[2])
            continue
        move = re.search(r'(?:mov|cvta\.to\.global)\.(?:u|b)64\s+(%rd\d+),\s*(%rd\d+)', line)
        if move:
            if move[2] in aliases:
                aliases[move[1]] = aliases[move[2]]
            else:
                aliases.pop(move[1], None)
            continue
        test = re.search(r'setp\.(?:eq|ne)\.[sub]64\s+%p\d+,\s*(%rd\d+),\s*0;', line)
        if test and test[1] in aliases:
            result.add(aliases[test[1]])
        assignment = re.search(r'^\w+(?:\.\w+)*\s+(%rd\d+),', line.strip())
        if assignment:
            aliases.pop(assignment[1], None)
    return sorted(result)


def main():
    original = {}
    for path in (OUT.parents[1]/'reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx'):
        original.update(entries(path.read_text()))
    source = {}
    header = (OUT/'source_ptx_bundle.h').read_text()
    for _, _, text in re.findall(r'\{("[^"\n]+"), R"(\w+)\((.*?)\)\2"\},', header, re.S):
        source.update(entries(text))
    assert set(source) == set(original) and len(source) == 176
    differences = {}
    for name in sorted(original):
        old, new = set(guards(original[name])), set(guards(source[name]))
        if old != new:
            differences[name] = {'reference_checked_parameters': sorted(old), 'source_checked_parameters': sorted(new),
                                 'possible_missing_checks': sorted(old-new), 'possible_extra_checks': sorted(new-old)}
    report = {'diagnostic_only': True, 'method': 'direct u64 parameter/cvta/mov aliases and eq/ne-zero checks',
              'kernel_count': len(source), 'candidates': differences,
              'source_extension_sha256': json.loads((OUT/'build.json').read_text())['extension_sha256']}
    tet = next(name for name in original if 'kernel26evaluate_tetrahedron_forceE' in name)
    old_header = (OUT.parent/'native/source_ptx_bundle.h').read_text()
    old_tet = next(entries(text)[tet] for _, _, text in
                   re.findall(r'\{("[^"\n]+"), R"(\w+)\((.*?)\)\2"\},', old_header, re.S) if tet in entries(text))
    assert 6 in guards(original[tet]) and 6 not in guards(old_tet) and 6 in guards(source[tet])
    report['known_regression_detected'] = 'Historical tetrahedron activation P6 guard missing; corrected bundle has it'
    (OUT/'optional-parameter-audit.json').write_text(json.dumps(report, indent=2)+'\n')
    print('Scanned', len(source), 'entries; manual candidates', len(differences))
    for name, row in differences.items():
        if row['possible_missing_checks']:
            print(name, 'possible missing', row['possible_missing_checks'], 'extra', row['possible_extra_checks'])


if __name__ == '__main__':
    main()
