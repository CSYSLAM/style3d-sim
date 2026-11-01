# ABI preflight failure before any GPU worker

The first harness treated every dumped argument as a direct pointer. Surface force argument zero is a by-value
SurfaceContactView; its first word is the device contact-count pointer, which the existing hook dereferences.
The assertion stopped before spawning a worker. No original trajectory was obtained or replaced.
The prior harness is preserved as preflight-before-view-pointer-check.py; original16.log contains the failure.
The corrected preflight permits only this exact view/count/4-byte combination and retains direct-pointer checks
for all other fields. Fresh captures use original16-view-aware rather than reusing the failed directory.
