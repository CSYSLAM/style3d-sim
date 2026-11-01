"""Run an unchanged frozen template with the project import path explicitly available."""
from pathlib import Path
import sys
sys.path.insert(0, str(Path.cwd()))
BASE = Path(__file__).resolve().parent
NAME = 'certificates'
text = (BASE / (NAME + '-template.py')).read_text()
script = BASE / (NAME + '-' + NAME + '-as-run.py')
if script.exists():
    assert script.read_text() == text
else:
    script.write_text(text)
namespace = {'__name__': 'reconstruction.csrc.first_joint_' + NAME,
             '__package__': 'reconstruction.csrc', '__file__': str(script)}
exec(compile(text, str(script), 'exec'), namespace)
raise SystemExit(namespace['main']())
