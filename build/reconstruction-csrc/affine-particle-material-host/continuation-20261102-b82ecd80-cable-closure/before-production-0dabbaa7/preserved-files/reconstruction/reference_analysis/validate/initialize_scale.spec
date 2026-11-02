label initialize_scale
ptx initialize_scale.ptx
cubin cubins/initialize_scale.cubin
name_ptx _ZN7synreal12fluid_kernel16initialize_scaleEPffi
name_cubin _Z16initialize_scalePffi
grid 4 1 1
block 256 1 1
ptr randf 4096
f32 2.5
u32 1024
