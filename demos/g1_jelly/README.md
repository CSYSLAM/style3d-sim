USD export and Blender Cycles offline rendering tools for the G1 jelly mountain example.

The top-level directory contains only scripts, render configuration, and documentation intended for version control.
All locally generated artifacts go into `outputs/`, which is excluded by the local `.gitignore`. Blender projects,
USD caches, videos, and original frames remain available for further editing.
Shared rendering, encoding, and USD import validation tools live in [`../utils/`](../utils/README.md) and accept
project and input/output paths as arguments.

```text
g1_jelly/
|-- .gitignore
|-- README.md
|-- render_config.json
|-- demo_g1_jelly_mountain.py
|-- g1_jelly_robot.py
|-- jelly_mountain.py
|-- export_simulation.py
|-- build_render_scene.py
|-- validate_simulation.py
`-- outputs/                    # Generated locally; do not commit
    |-- simulation.usdc
    |-- simulation_states.npz
    |-- simulation_metadata.json
    |-- g1_jelly_mountain.blend
    |-- g1_jelly_mountain.blend1
    |-- g1_jelly_mountain.mp4
    |-- frames/
    |-- previews/
    |-- contact_sheet.jpg
    |-- *.log
    `-- *_validation.json, *.video.json
```

Start these PowerShell commands from the repository root. Adjust the Blender executable path for your machine.

```powershell
$blenderExe = 'D:\Program Files\Blender Foundation\Blender 5.2\blender.exe'
Set-Location .\demos\g1_jelly
New-Item -ItemType Directory -Force .\outputs | Out-Null
```

Run the interactive simulation from this demo directory:

```powershell
uv run python .\demo_g1_jelly_mountain.py
```

The entry point, G1 assembly, and jelly generation scripts all live in this directory. Robot assets remain in
`assets/g1_jelly/` at the repository root and are resolved independently of the working directory.

Export the current example's physics simulation. Unspecified options use the current defaults from
`demo_g1_jelly_mountain.py`. You can append `--jelly-width`, `--layers`, `--drop-height`, `--layer-gap`,
`--base-height`, and other example options. The simulation samples at 60 Hz; `--num-frames 240` saves 241 samples,
including the initial state.

```powershell
uv run --with usd-core python .\export_simulation.py --num-frames 240 --substeps 4
uv run --with usd-core python .\validate_simulation.py
```

The exporter writes `outputs/simulation.usdc`, `outputs/simulation_states.npz`, and `outputs/simulation_metadata.json`.
Metadata records the actual parameters and source hashes. `validate_simulation.py` compares the USD with the raw states.
If you change the simulation source after exporting, the source hash check will fail; export again to validate that version.
Exports made before the scripts moved out of `examples/` retain their original provenance. Export again to produce
metadata referencing the current source paths.

Build an editable Blender project from the USD:

```powershell
& $blenderExe -b --python-exit-code 1 --python .\build_render_scene.py -- --config .\render_config.json
& $blenderExe -b .\outputs\g1_jelly_mountain.blend --python-exit-code 1 --python ..\utils\validate_import.py -- `
    --usd .\outputs\simulation.usdc
```

The `usd` and `project` paths in `render_config.json` are relative to this directory and point into `outputs/` by default.
If you change the cache length, update `frame_end` in the configuration and `--end` in the encoding command.
Check camera framing after changing scene dimensions. The build script overwrites `outputs/g1_jelly_mountain.blend`,
including any manual edits in that file.

After changing example parameters and exporting again, always run `build_render_scene.py` again before rendering.
Replacing `simulation.usdc` does not recreate the objects or static geometry already imported into the `.blend`.
For example, reducing the number of jelly layers can leave old cubes visible in an unreconstructed project.
The builder starts from an empty scene and records the USD fingerprint; rendering rejects changed caches or missing
USD object paths and asks you to rebuild. Back up any manually edited project before rebuilding.

The default preset uses Cycles / OptiX GPU, 1920 x 1080 resolution, up to 256 samples, an adaptive threshold of 0.01,
OpenImageDenoise, AgX, depth of field, and motion blur. Jelly materials use transmission and volume absorption with
2 levels of render subdivision. The USD retains the original simulation mesh.

Preview selected frames in `outputs/previews/`:

```powershell
& $blenderExe -b .\outputs\g1_jelly_mountain.blend --python-exit-code 1 --python ..\utils\render_frames.py -- `
    --frames 0,60,120,240 --preview --config .\render_config.json --overwrite
```

Render the complete sequence and encode the video:

```powershell
& $blenderExe -b .\outputs\g1_jelly_mountain.blend --python-exit-code 1 --python ..\utils\render_frames.py -- `
    --animation --overwrite
uv run --with imageio-ffmpeg --with pillow python ..\utils\encode_video.py `
    --output-dir .\outputs --output g1_jelly_mountain.mp4 --start 0 --end 240 --contact-sheet
```

Final frames are saved as 16-bit RGB PNGs from `outputs/frames/frame_0000.png` through `frame_0240.png`.
The video is written to `outputs/g1_jelly_mountain.mp4` with H.264, CRF 17, 30 fps, BT.709, and yuv420p by default.
Playing the 241 samples from a 60 Hz simulation at 30 fps gives half-speed playback lasting approximately 8.033 seconds.
Use `--fps 60` for real-time playback or `--crf 15` for higher encoding quality.
The encoder checks frame continuity, dimensions, and full video decoding. It preserves all PNGs and saves verification
results in `outputs/*.video.json`.
Relative `--input` and `--output` paths for `encode_video.py` resolve under `--output-dir`; absolute paths are supported.
`render_frames.py` defaults to `frames/` or `previews/` beside the `.blend`; use `--output-dir` to override this location.

To adjust only the rendering, open `outputs/g1_jelly_mountain.blend`, edit materials, cameras, lights, or Cycles settings,
and save the project. Then run the preview, rendering, and encoding commands above.
`render_frames.py` uses the saved project settings and skips existing frames without `--overwrite`, allowing interrupted
renders to resume. After changing render parameters, use `--overwrite` to avoid mixing old and new frames.
`--overwrite` replaces only the requested PNGs. It does not rebuild the scene or remove other preview frames.
Use a fresh `--output-dir` if you need a directory containing only the newly selected frames.

The project reads its animation through the relative path `//simulation.usdc`, so move the entire `outputs/` together.
Redirect logs into this directory as well, for example with `> .\outputs\render.log 2>&1`.
Existing logs, previews, videos, caches, validation reports, and Blender backups are all stored in `outputs/`.
