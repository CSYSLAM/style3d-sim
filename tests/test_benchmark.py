import importlib.util
import json
from pathlib import Path


BENCHMARK_PATH = (
    Path(__file__).resolve().parents[2]
    / "benchmarks"
    / "benchmark_robot_h1_genesis.py"
)
SPEC = importlib.util.spec_from_file_location("benchmark_robot_h1_genesis", BENCHMARK_PATH)
assert SPEC is not None and SPEC.loader is not None
benchmark = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(benchmark)


def test_benchmark_parser_accepts_repeat_and_output_options(tmp_path: Path) -> None:
    output = tmp_path / "results.json"
    args = benchmark.create_parser().parse_args(
        ("--solver", "synreal", "--repeats", "3", "--output", str(output))
    )

    assert args.repeats == 3
    assert args.output == output


def test_benchmark_writes_json_and_csv_results(tmp_path: Path) -> None:
    config = {"solver": "synreal", "world_count": 16}
    metadata = {"git_commit": "abc123", "device": "cuda:0"}
    records = [
        {
            "repeat": 1,
            "device": "cuda:0",
            "measured_frames": 100,
            "elapsed_seconds": 2.0,
            "milliseconds_per_frame": 20.0,
            "world_frames_per_second": 800.0,
            "aggregate_realtime": 16.0,
        },
        {
            "repeat": 2,
            "device": "cuda:0",
            "measured_frames": 100,
            "elapsed_seconds": 1.0,
            "milliseconds_per_frame": 10.0,
            "world_frames_per_second": 1600.0,
            "aggregate_realtime": 32.0,
        },
    ]

    json_output = tmp_path / "results.json"
    csv_output = tmp_path / "results.csv"
    benchmark.write_results(json_output, config, metadata, records)
    benchmark.write_results(csv_output, config, metadata, records)

    payload = json.loads(json_output.read_text(encoding="utf-8"))
    assert payload["summary"]["repeat_count"] == 2
    assert payload["summary"]["median_world_frames_per_second"] == 1200.0
    assert payload["metadata"]["git_commit"] == "abc123"
    csv_lines = csv_output.read_text(encoding="utf-8").splitlines()
    assert len(csv_lines) == 3
    assert "world_frames_per_second" in csv_lines[0]
