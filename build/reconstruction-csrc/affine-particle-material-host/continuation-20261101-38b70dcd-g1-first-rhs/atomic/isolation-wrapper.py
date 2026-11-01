"""Execute the frozen first-joint diagnostic template without changing production code."""
from pathlib import Path
BASE = Path(__file__).resolve().parent
NAME = 'isolation'
text = (BASE / (NAME + '-template.py')).read_text()
script = BASE / (NAME + '-' + NAME + '-as-run.py')
assert not script.exists()
script.write_text(text)
namespace = {'__name__': 'reconstruction.csrc.first_joint_' + NAME,
             '__package__': 'reconstruction.csrc', '__file__': str(script)}
exec(compile(text, str(script), 'exec'), namespace)
raise SystemExit(namespace['main']())
