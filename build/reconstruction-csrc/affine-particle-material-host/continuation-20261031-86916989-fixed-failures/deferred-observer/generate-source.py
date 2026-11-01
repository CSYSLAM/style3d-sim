"""Reproduce the separate diagnostic observer from its preserved source and anchored patch."""
import argparse
from pathlib import Path
import subprocess
p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True);a=p.parse_args()
assert not a.output.exists()
b=Path(__file__).resolve().parent
subprocess.run(['patch','--silent','--output',str(a.output),str(b/'original-observer.cpp'),str(b/'observer.patch')],check=True)
assert a.output.read_bytes()==(b/'deferred-observer.cpp').read_bytes()
