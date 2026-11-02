"""Run the saved complementary replay script with its required package context."""
import importlib.util
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
name = 'reconstruction.csrc.pd_contact_remaining_as_run'
spec = importlib.util.spec_from_file_location(name, BASE / 'remaining-replays-as-run.py')
module = importlib.util.module_from_spec(spec)
sys.modules[name] = module
spec.loader.exec_module(module)
raise SystemExit(module.main())
