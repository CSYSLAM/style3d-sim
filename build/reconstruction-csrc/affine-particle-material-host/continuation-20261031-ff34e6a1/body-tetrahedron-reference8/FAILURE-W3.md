The four W1 native-reference cases completed. W3 failed before native initialization.
The official Python shared-world adapter unconditionally accesses style3d.edge_rest_area,
which is absent when the test explicitly disables surface mesh edges.
Use add_soft_mesh default edge creation, as official tetrahedron demos do, and recapture all eight cases
in a new directory. Preserve this fixture and the old W1 captures; do not change the native SDK or adapter.
