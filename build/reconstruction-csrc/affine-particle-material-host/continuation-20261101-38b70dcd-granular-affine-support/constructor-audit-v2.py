"""Extend only the diagnostic type decoder for the two actually observed granular initializer signatures."""
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc import affine_constructor_audit as audit
from reconstruction.csrc import initialization_trace_audit as initializers

before = tuple(initializers.TYPES)
added = (('device_ptrIN3glm3vecILi3Ei', 'ivec3', 12), ('device_ptrIN3glm3vecILi4Ef', 'vec4', 16))
initializers.TYPES = (*before, *added)
folder = BASE / 'constructors'
provenance = folder / 'audit-v2-provenance.json'
assert not provenance.exists()
provenance.write_text(json.dumps({
    'base_audit_sha256': hashlib.sha256(Path(audit.__file__).read_bytes()).hexdigest(),
    'base_decoder_sha256': hashlib.sha256(Path(initializers.__file__).read_bytes()).hexdigest(),
    'wrapper_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    'original_types': before, 'actual_observed_added_types': added,
    'capture_and_production_unchanged': True, 'whole_solver_complete': False}, indent=2) + '\n')
sys.argv = [str(Path(audit.__file__)), '--capture', str(folder), '--prefix', 'granular-affine-w1',
            '--output', str(folder / 'audit-v2.json')]
raise SystemExit(audit.main())
