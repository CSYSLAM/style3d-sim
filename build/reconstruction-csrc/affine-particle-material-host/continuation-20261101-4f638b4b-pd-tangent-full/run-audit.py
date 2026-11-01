"""Execute the retained CPU audit with explicit package context and the full-contact stage schema."""
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
path = BASE / 'audit-as-run.py'
sys.argv = [str(path), '--phase', str(BASE)]
exec(compile(path.read_bytes(), str(path), 'exec'),
     {'__name__': '__main__', '__package__': 'reconstruction.csrc', '__file__': str(path)})
