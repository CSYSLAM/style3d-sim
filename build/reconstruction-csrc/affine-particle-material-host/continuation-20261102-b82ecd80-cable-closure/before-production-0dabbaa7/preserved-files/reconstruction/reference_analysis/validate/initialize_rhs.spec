label initialize_rhs
ptx initialize_rhs.ptx
cubin cubins/initialize_rhs.cubin
name_ptx _ZN7synreal6kernel14initialize_rhsEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKfPKiPKNS_12NonZeroEntryEmS6_SA_PS4_mm
name_cubin _Z14initialize_rhsfPK4Vec3S1_PKfPKiPK12NonZeroEntrymS1_S5_PS_mm
grid 1 1 1
block 256 1 1
f32 0.016
ptr randf 3072
ptr randf 3072
ptr small 1024
ptr idx 256 4
ptr pair 1536 64
u64 3
ptr randf 768
ptr idx 1024 2
ptr zero 3072
u64 64
u64 64
