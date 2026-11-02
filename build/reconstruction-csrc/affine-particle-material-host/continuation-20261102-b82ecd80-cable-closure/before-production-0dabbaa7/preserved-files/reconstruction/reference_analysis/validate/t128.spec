label t128
ptx multiply_matrix_and_reduce.ptx
cubin cubins/mmr_hyp.cubin
name_ptx _ZN7synreal6kernel26multiply_matrix_and_reduceILj256ENS_17BlockNonZeroEntryEN3glm3matILi3ELi3EfLNS3_9qualifierE0EEEEEvPKiPKT0_mPKT1_PKNS3_3vecILi3EfLS5_0EEESI_PSG_Pfmm
name_cubin _Z26multiply_matrix_and_reducePKiPK17BlockNonZeroEntrymPK4Mat3PK4Vec3S9_PS7_Pfmm
grid 1 1 1
block 128 1 1
ptr zero 512
ptr zero 15360
u64 0
ptr ident3 4608
ptr vec3c 1536 1 0 0
ptr vec3c 1536 0 2 0
ptr zero 1536
ptr zero 512
u64 128
u64 128
