#!/usr/bin/env python3
"""Restore the pinned Linux CUDA 12.4 compiler from the archives shipped in this Git branch."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import tarfile


ROOT = Path(__file__).resolve().parents[1]


def restore(output):
    metadata = json.loads((ROOT / 'build/toolchains/redistrib_12.4.1.json').read_text())
    for component in ('cuda_nvcc', 'cuda_cudart', 'cuda_cccl'):
        info = metadata[component]['linux-x86_64']
        archive = ROOT / 'build/toolchains' / Path(info['relative_path']).name
        assert hashlib.sha256(archive.read_bytes()).hexdigest() == info['sha256'], archive
        with tarfile.open(archive, 'r:xz') as source:
            for member in source:
                relative = Path(*Path(member.name).parts[1:])
                if relative == Path('.'):
                    continue
                target = output / relative
                assert target.resolve().is_relative_to(output.resolve()), member.name
                if member.isdir():
                    target.mkdir(parents=True, exist_ok=True)
                    continue
                target.parent.mkdir(parents=True, exist_ok=True)
                if member.issym():
                    assert (target.parent / member.linkname).resolve().is_relative_to(output.resolve())
                    if target.is_symlink() and target.readlink() == Path(member.linkname):
                        continue
                    if target.exists() or target.is_symlink():
                        raise RuntimeError(f'Refusing to replace a different existing link: {target}')
                    target.symlink_to(member.linkname)
                elif member.isfile():
                    with source.extractfile(member) as incoming:
                        data = incoming.read()
                    if target.exists() and target.read_bytes() == data:
                        continue
                    # Components have different LICENSE files; retain each one separately as well.
                    if relative.name == 'LICENSE':
                        license_path = output / 'licenses' / (component + '.LICENSE')
                        license_path.parent.mkdir(exist_ok=True)
                        license_path.write_bytes(data)
                        if target.exists():
                            continue
                    elif target.exists():
                        raise RuntimeError(f'Refusing to replace a different existing toolchain file: {target}')
                    target.write_bytes(data)
                    target.chmod(member.mode & 0o777)
                else:
                    raise RuntimeError(f'Unexpected archive member type: {member.name}')
        print(f'{component}: verified and restored')
    assert (output / 'include/cub/version.cuh').is_file()
    assert (output / 'lib/libcudart.so.12').is_file()
    subprocess.run([str(output / 'bin/nvcc'), '--version'], check=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=ROOT / 'build/toolchains/cuda-12.4')
    args = parser.parse_args()
    restore(args.output.resolve())


if __name__ == '__main__':
    main()
