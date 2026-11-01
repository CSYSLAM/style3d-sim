The first diagnostic read SO3 tangent argument 1 (local body indices) as a full particle vector.
The parameter is a pointer, but the element type and allocation extent were wrong.
The diagnostic original process stopped with a CUDA invalid-argument error.
Its partial dump and log are preserved; no solver change or cohort reclassification was made.
Correct argument 0 and check all full-particle vector dump pointee types before retrying.
