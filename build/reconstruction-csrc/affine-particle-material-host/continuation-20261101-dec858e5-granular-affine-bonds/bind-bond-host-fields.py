"""Record directly reviewed fixed-SDK argument loads for both bond groups across three host methods."""
import hashlib
import json
from pathlib import Path
import re

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
folder = BASE / 'host-bond-argument-binding'
manifest = json.loads((folder / 'manifest.json').read_text())
sdk = ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
assert hashlib.sha256(sdk.read_bytes()).hexdigest() == manifest['SDK_sha256']
instructions = {}
for item in manifest['ranges']:
    path = folder / item['file']
    assert hashlib.sha256(path.read_bytes()).hexdigest() == item['sha256']
    rows = {}
    for line in path.read_text().splitlines():
        match = re.match(r'\s*([0-9a-f]+):\s+(.*)', line)
        if match:
            rows[int(match[1], 16)] = re.sub(r'\s+', ' ', match[2].strip())
    instructions[item['file']] = rows
sites = [
    ('multiply.asm', 0x1279b6, 'authored', {
        0x127995: 'mov 0x754(%rbx),%ecx', 0x1279a1: 'mov 0x8f0(%rbx),%rdx',
        0x1279a8: 'mov 0x970(%rbx),%rsi', 0x1279af: 'mov 0x910(%rbx),%rdi'}),
    ('multiply.asm', 0x127a44, 'dynamic', {
        0x127a23: 'mov 0x758(%rbx),%ecx', 0x127a2f: 'mov 0xa70(%rbx),%rdx',
        0x127a36: 'mov 0xa50(%rbx),%rsi', 0x127a3d: 'mov 0x9f0(%rbx),%rdi'}),
    ('commit.asm', 0x1274c2, 'authored', {
        0x127490: 'mov 0x950(%rbx),%r11', 0x127497: 'mov 0x910(%rbx),%r10',
        0x1274a1: 'mov 0x930(%rbx),%rdx', 0x1274ab: 'mov %r11,%rcx',
        0x1274b1: 'mov %r10,%rsi', 0x1274b4: 'mov 0x754(%rbx),%r9d', 0x1274bb: 'mov 0x970(%rbx),%r8'}),
    ('commit.asm', 0x1276f1, 'dynamic', {
        0x1276bf: 'mov 0xa30(%rbx),%r11', 0x1276c6: 'mov 0x9f0(%rbx),%r10',
        0x1276cd: 'mov 0xa10(%rbx),%rdx', 0x1276da: 'mov %r11,%rcx',
        0x1276e0: 'mov %r10,%rsi', 0x1276e3: 'mov 0x758(%rbx),%r9d', 0x1276ea: 'mov 0xa50(%rbx),%r8'}),
    ('commit.asm', 0x1273f1, 'dynamic-formation', {
        0x1272ff: 'mov 0x9b0(%rbx),%r11', 0x127306: 'mov 0x990(%rbx),%r10',
        0x127315: 'mov 0x9f0(%rbx),%r12', 0x12732d: 'mov 0x9d0(%rbx),%rdx',
        0x12735e: 'push 0xa50(%rbx)', 0x1273da: 'mov 0xa30(%rbx),%r9',
        0x1273e1: 'mov %r12,%rcx', 0x1273e4: 'mov %r11,%rsi',
        0x1273e7: 'mov 0xa10(%rbx),%r8', 0x1273ee: 'mov %r10,%rdi'}),
    ('accumulate.asm', 0x126eb7, 'authored', {
        0x126e57: 'mov 0x930(%rbx),%r10', 0x126e66: 'mov 0x910(%rbx),%rdx',
        0x126e6d: 'push 0x8f0(%rbx)', 0x126e73: 'push 0x8d0(%rbx)',
        0x126e7b: 'mov 0x754(%rbx),%eax', 0x126e8f: 'mov %r10,%rcx',
        0x126ea1: 'movss 0x134(%rbx),%xmm1', 0x126ea9: 'mov 0x970(%rbx),%r9',
        0x126eb0: 'mov 0x950(%rbx),%r8'}),
    ('accumulate.asm', 0x126de7, 'dynamic', {
        0x126d87: 'mov 0xa10(%rbx),%r10', 0x126d96: 'mov 0x9f0(%rbx),%rdx',
        0x126d9d: 'push 0xa70(%rbx)', 0x126da3: 'push 0x8d0(%rbx)',
        0x126dab: 'mov 0x758(%rbx),%eax', 0x126dbf: 'mov %r10,%rcx',
        0x126dd1: 'movss 0x148(%rbx),%xmm1', 0x126dd9: 'mov 0xa50(%rbx),%r9',
        0x126de0: 'mov 0xa30(%rbx),%r8'}),
]
evidence = []
for name, call, group, expected in sites:
    code = instructions[name]
    assert code[call].startswith('call ') and 'synreal::granular_kernel::' in code[call]
    for address, instruction in expected.items():
        assert code[address] == instruction, (hex(address), code[address], instruction)
        assert address < call
    evidence.append({'file': name, 'group': group, 'call': hex(call), 'callee': code[call],
                     'reviewed_instruction_loads': {hex(a): s for a, s in expected.items()}})
bindings = {
    'authored': {'count': '0x754', 'pairs_pointer': '0x910', 'rest_pointer': '0x930',
                 'history_pointer': '0x950', 'active_pointer': '0x970', 'tangent_pointer': '0x8f0',
                 'force_stiffness_Model_word': '0x134'},
    'dynamic': {'count': '0x758', 'pairs_pointer': '0x9f0', 'rest_pointer': '0xa10',
                'history_pointer': '0xa30', 'active_pointer': '0xa50', 'tangent_pointer': '0xa70',
                'force_stiffness_Model_word': '0x148'},
    'formation': {'CSR_offsets_pointer': '0x990', 'CSR_columns_pointer': '0x9b0', 'partner_pointer': '0x9d0'},
    'shared': {'diagonal_pointer': '0x8d0'},
}
report = {'SDK_sha256': manifest['SDK_sha256'], 'static_argument_bindings': bindings, 'reviewed_call_sites': evidence,
          'direct_instruction_loads_checked': sum(len(item[3]) for item in sites),
          'binding_basis': 'SysV x86-64 register/stack arguments and actual demangled CUDA host function signatures',
          'GPU_runtime_binding_claimed': False, 'production_changed': False, 'whole_solver_complete': False,
          'auditor_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
with (folder / 'static-field-bindings.json').open('x') as out:
    out.write(json.dumps(report, indent=2) + '\n')
print('Reviewed', len(evidence), 'actual call sites and', report['direct_instruction_loads_checked'], 'exact loads')
