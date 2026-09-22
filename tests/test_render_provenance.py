"""Prevent frame reuse or encoding across different sealed simulation runs."""

import json

import pytest

from demos.utils.render_provenance import RenderManifest, sha256, validate_scene_run, verify_frame_provenance


@pytest.fixture
def bundle(tmp_path):
    usd = tmp_path / "simulation.usdc"
    usd.write_bytes(b"first simulation")
    blend = tmp_path / "scene.blend"
    blend.write_bytes(b"editable scene")
    run_path = tmp_path / "run_manifest.json"
    run = {
        "schema_version": 1, "run_id": "run-a", "artifacts": {"usd": {"path": usd.name, "sha256": sha256(usd)}},
        "timeline": {"first_frame": 0, "last_frame": 1, "frame_count": 2, "fps": 60},
    }
    run_path.write_text(json.dumps(run), encoding="utf-8")
    folder = tmp_path / "frames"
    folder.mkdir()
    return tmp_path, folder, blend, run_path, run


def test_matching_run_frames_resume_and_supply_encoding_provenance(bundle):
    root, folder, blend, run_path, run = bundle
    manifest = RenderManifest(folder, blend, run_path, 0, 1, 60, {"samples": 256})
    frames = [folder / f"frame_{index:04d}.png" for index in range(2)]
    for index, path in enumerate(frames):
        path.write_bytes(f"image {index}".encode())
        manifest.record(index, path)
    resumed = RenderManifest(folder, blend, run_path, 0, 1, 60, {"samples": 256})
    for index, path in enumerate(frames):
        resumed.validate_existing(index, path)
    result = verify_frame_provenance(frames, root, 0, 60)
    assert result["run_id"] == run["run_id"]
    assert result["source_usd_sha256"] == run["artifacts"]["usd"]["sha256"]
    assert result["render_manifest"]["sha256"] == sha256(folder / "render_manifest.json")


@pytest.mark.parametrize("changed", ("blend", "run", "settings"))
def test_resume_rejects_changed_scene_run_or_preview_quality(bundle, changed):
    _, folder, blend, run_path, run = bundle
    RenderManifest(folder, blend, run_path, 0, 1, 60, {"samples": 256})
    if changed == "blend":
        blend.write_bytes(b"hand-edited material")
    if changed == "run":
        run["run_id"] = "run-b"
        run_path.write_text(json.dumps(run), encoding="utf-8")
    with pytest.raises(ValueError, match="provenance changed"):
        RenderManifest(folder, blend, run_path, 0, 1, 60, {"samples": 16 if changed == "settings" else 256})


def test_unrecorded_or_modified_pngs_cannot_be_reused_or_encoded(bundle):
    root, folder, blend, run_path, _ = bundle
    frame = folder / "frame_0000.png"
    frame.write_bytes(b"an older untracked image")
    with pytest.raises(ValueError, match="no run provenance"):
        RenderManifest(folder, blend, run_path, 0, 1, 60, {})
    with pytest.raises(ValueError, match="no rendered-frame provenance"):
        verify_frame_provenance([frame], root, 0, 60)
    manifest = RenderManifest(folder, blend, run_path, 0, 1, 60, {}, overwrite=True)
    with pytest.raises(ValueError, match="missing or differs"):
        manifest.validate_existing(0, frame)
    manifest.record(0, frame)
    frame.write_bytes(b"PNG replaced after rendering")
    with pytest.raises(ValueError, match="differs from the recorded simulation run"):
        verify_frame_provenance([frame], root, 0, 60)


def test_replaced_usd_and_retimed_scene_are_rejected(bundle):
    root, folder, blend, run_path, run = bundle
    digest = run["artifacts"]["usd"]["sha256"]
    validate_scene_run(run, [digest], 0, 1, 60)
    with pytest.raises(ValueError, match="frame rate differs"):
        validate_scene_run(run, [digest], 0, 1, 30)
    with pytest.raises(ValueError, match="sources do not match"):
        validate_scene_run(run, ["another USD"], 0, 1, 60)
    (root / "simulation.usdc").write_bytes(b"replacement simulation")
    with pytest.raises(ValueError, match="USD differs"):
        RenderManifest(folder, blend, run_path, 0, 1, 60, {})
