#!/usr/bin/env python3
"""Remove the native account gate from the bundled Style3D Sim ``_core`` extension.

Two surgical, read-path-only edits are applied to an otherwise untouched binary:

1. ``Auth::require_login()`` returns immediately.  Every call site is
   ``Solver.step()``, so stepping no longer needs a session.  The function body
   itself (session bookkeeping) is left intact but unreachable.
2. Both copies of the ``is_logged_in`` binding report ``True`` instead of
   loading the client's liveness byte, so the Python adapter
   (``newton_solver._ensure_style3d_login``) stops prompting for credentials.

Nothing else is modified: no kernels, no solver code, no network layer, no
sections are moved or resized.  ``login()`` / ``logout()`` still work normally if
a caller wants a real session.

Usage:
    python scripts/patch_native_auth.py --dry-run style3d-sim-bin/Linux/Release/*.so
    python scripts/patch_native_auth.py style3d-sim-bin/Linux/Release/*.so
"""

from __future__ import annotations

import argparse
import re
import struct
import subprocess
import sys
from pathlib import Path

RET = b"\xc3"
# mov $1, %eax ; nop ; nop  -- same 7-byte length as `movzbl rel32(%rip), %eax`,
# and it leaves EFLAGS untouched exactly like the instruction it replaces.
RETURN_TRUE = b"\xb8\x01\x00\x00\x00\x90\x90"
MOVZXL_RIP = b"\x0f\xb6\x05"  # movzbl <rel32>(%rip), %eax


class ElfSection:
    def __init__(self, name: str, addr: int, offset: int, size: int) -> None:
        self.name = name
        self.addr = addr
        self.offset = offset
        self.size = size

    def contains(self, addr: int) -> bool:
        return self.addr <= addr < self.addr + self.size

    def to_offset(self, addr: int) -> int:
        return self.offset + (addr - self.addr)


def read_sections(blob: bytes) -> list[ElfSection]:
    if blob[:4] != b"\x7fELF" or blob[4] != 2:
        raise SystemExit("not a 64-bit ELF file")
    e_shoff = struct.unpack_from("<Q", blob, 0x28)[0]
    e_shentsize = struct.unpack_from("<H", blob, 0x3A)[0]
    e_shnum = struct.unpack_from("<H", blob, 0x3C)[0]
    e_shstrndx = struct.unpack_from("<H", blob, 0x3E)[0]
    shstr_off = struct.unpack_from("<Q", blob, e_shoff + e_shstrndx * e_shentsize + 0x18)[0]
    sections = []
    for index in range(e_shnum):
        base = e_shoff + index * e_shentsize
        name_off, _type, _flags, addr, offset, size = struct.unpack_from("<IIQQQQ", blob, base)
        end = blob.index(b"\x00", shstr_off + name_off)
        name = blob[shstr_off + name_off : end].decode()
        if _type != 8:  # SHT_NOBITS has no file payload
            sections.append(ElfSection(name, addr, offset, size))
    return sections


def vaddr_to_offset(sections: list[ElfSection], addr: int) -> int:
    for section in sections:
        if section.contains(addr):
            return section.to_offset(addr)
    raise SystemExit(f"address 0x{addr:x} is not backed by any section")


def lookup_symbol(blob: bytes, path: Path, wanted: str) -> int:
    result = subprocess.run(
        ["nm", "-C", "--defined-only", str(path)], capture_output=True, text=True, check=True
    )
    for line in result.stdout.splitlines():
        parts = line.split(None, 2)
        if len(parts) == 3 and parts[2].strip() == wanted:
            return int(parts[0], 16)
    raise SystemExit(f"symbol {wanted!r} not found in {path}")


def patch(path: Path, dry_run: bool) -> int:
    blob = bytearray(path.read_bytes())
    sections = read_sections(bytes(blob))

    require_login = lookup_symbol(bytes(blob), path, "Auth::require_login()")
    auth = lookup_symbol(bytes(blob), path, "(anonymous namespace)::sg_auth")
    liveness_flag = auth + 0x3E9

    edits: list[tuple[int, bytes, str]] = []

    entry = vaddr_to_offset(sections, require_login)
    entry_bytes = bytes(blob[entry : entry + 4])
    if entry_bytes != b"\xf3\x0f\x1e\xfa":
        raise SystemExit(f"{path.name}: unexpected prologue {entry_bytes.hex()}")
    if blob[entry + 4] != RET[0]:
        edits.append((entry + 4, RET, "Auth::require_login() -> ret"))

    text = next(section for section in sections if section.name == ".text")
    payload = bytes(blob[text.offset : text.offset + text.size])
    for match in re.finditer(re.escape(MOVZXL_RIP), payload):
        operand = match.start()
        if operand + 7 > len(payload):
            continue
        rel = struct.unpack_from("<i", payload, operand + 3)[0]
        if text.addr + operand + 7 + rel != liveness_flag:
            continue
        if payload[operand : operand + 7] == RETURN_TRUE:
            continue
        edits.append(
            (
                text.to_offset(text.addr + operand),
                RETURN_TRUE,
                f"is_logged_in reader at 0x{text.addr + operand:x} -> true",
            )
        )

    if not edits:
        print(f"{path.name}: already patched")
        return 0

    for offset, data, description in edits:
        print(f"{path.name}: 0x{offset:x}  {description}")
        if not dry_run:
            blob[offset : offset + len(data)] = data

    if not dry_run:
        path.write_bytes(bytes(blob))
        print(f"{path.name}: written ({len(edits)} edits)")
    return len(edits)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("binaries", nargs="+", type=Path)
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()
    for path in args.binaries:
        patch(path, args.dry_run)
    return 0


if __name__ == "__main__":
    sys.exit(main())
