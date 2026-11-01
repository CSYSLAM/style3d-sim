# Frozen G1 reconstruction inputs

This bundle contains the exact 203 G1 files used by the fixed SDK64a and source host38/Core7eb diagnostics.
The uncompressed files total 293,932,151 bytes. Every file SHA256 matches the saved capture input manifests.
The source cache was read without changing its contents; no new asset package was downloaded.

Upstream: `https://github.com/newton-physics/newton-assets.git` at commit
`261cd1f429619d8ef4f546bd788ab9dea906b5e1`, directory `unitree_g1`.
The top-level BSD 3-Clause license and the policy subdirectory's Apache license are retained inside the archive.
The top-level license is also available as the adjacent `LICENSE` file.

`manifest.json` fixes every original file length/hash, the combined archive hash and the four archive chunk hashes.
The chunks are ordinary Git files, each at most 32 MiB. Concatenation order is given by the manifest.

From the repository root in Linux or WSL:

```bash
source scripts/reconstruction_env.sh
.venv/bin/python scripts/restore_reconstruction_g1_assets.py
```

The command validates the chunks, archive and all restored files. It installs the exact cache folder
`newton-assets_unitree_g1_110bd790_261cd1f4` under `NEWTON_CACHE_PATH`, or the Linux/WSL default cache root.
An existing identical folder is verified and reused. A differing folder is rejected rather than overwritten.
For a separate cache location:

```bash
export NEWTON_CACHE_PATH=/absolute/path/to/newton-cache
.venv/bin/python scripts/restore_reconstruction_g1_assets.py --cache-dir "$NEWTON_CACHE_PATH"
```

An independent fresh restore and repeated restore both passed. The real installed Newton1.5 asset resolver
returned the restored directory with a fresh cache and after its TTL expired, with network attempts prohibited.
The complete CPU evidence is in
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-contact-rhs-matrix/asset-source-audit/`.
This validates the asset transfer; GPU solver equivalence and native Windows execution remain separate requirements.
The missing `trampoline_v1051.obj` is not part of the G1 package and remains unresolved.
