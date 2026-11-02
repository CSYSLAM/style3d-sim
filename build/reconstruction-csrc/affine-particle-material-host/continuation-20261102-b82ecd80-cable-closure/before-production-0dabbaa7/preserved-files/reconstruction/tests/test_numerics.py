"""Independent physical invariants and comparison-gate regression tests."""
import numpy as np
import pytest
from scipy import sparse
from reconstruction.numerics import F, bending_terms, membrane_terms, pcg, spring_terms


@pytest.mark.parametrize('length', [0.0, 0.5, 1.0, 2.0])
def test_spring_force_and_stabilized_spectrum(length):
    x = np.array([[0, 0, 0], [length, 0, 0]], dtype=F)
    force, h = spring_terms(x, np.array([[0, 1]]), np.array([2], dtype=F), np.array([1], dtype=F))
    expected = 2*(length-1) if length else 0
    np.testing.assert_allclose(force[0, 0], [expected, 0, 0], atol=1e-6)
    np.testing.assert_allclose(force.sum(axis=1), 0, atol=1e-6)
    eig = np.linalg.eigvalsh(h.transpose(0, 1, 3, 2, 4).reshape(6, 6))
    assert eig.min() >= -1e-6
    np.testing.assert_allclose(h.sum(axis=2), 0, atol=1e-6)


def test_membrane_force_is_energy_gradient_and_translation_invariant():
    x = np.array([[0.2, 0.1, 0.3], [1.4, -0.1, 0.2], [0.6, 1.1, -0.1]], dtype=F)
    inv = np.array([[[1.2, -0.2], [0.3, 0.8]]], dtype=F)
    area = np.array([0.4], dtype=F)
    k = np.array([[3, 5, 2]], dtype=F)
    ids = np.array([[0, 1, 2]])
    force, blocks = membrane_terms(x, ids, inv, area, k)
    def energy(y):
        deformation = np.stack((y[1]-y[0], y[2]-y[0]), axis=1) @ inv[0].astype(float)
        a, b = deformation.T
        shear = np.dot(a, b)/np.sqrt((np.dot(a, a)+1e-12)*(np.dot(b, b)+1e-12))
        return 0.5*area[0]*np.dot(k[0], [(np.linalg.norm(a)-1)**2, (np.linalg.norm(b)-1)**2, shear**2])
    gradient = np.zeros((3, 3))
    for i in range(3):
        for j in range(3):
            a, b = x.astype(float), x.astype(float)
            a[i, j] += 1e-5
            b[i, j] -= 1e-5
            gradient[i, j] = (energy(a)-energy(b))/2e-5
    np.testing.assert_allclose(force[0], -gradient, atol=2e-6, rtol=1e-5)
    np.testing.assert_allclose(force.sum(axis=1), 0, atol=1e-6)
    matrix = blocks.transpose(0, 1, 3, 2, 4).reshape(9, 9)
    np.testing.assert_allclose(matrix, matrix.T, atol=1e-6)
    assert np.linalg.eigvalsh(matrix).min() > -1e-5
    translated, _ = membrane_terms(x + F(2), ids, inv, area, k)
    np.testing.assert_allclose(force, translated, atol=3e-6)


def test_bending_hessian_matches_force_derivative_without_damping():
    rng = np.random.default_rng(12)
    x = rng.normal(size=(4, 3)).astype(F)
    cots = np.array([[0.5, 1.2, 0.7, -0.1]], dtype=F)
    args = (np.array([[0, 1, 2, 3]]), cots, np.array([1.2], dtype=F), np.array([[2, 0]], dtype=F), F(0.01))
    force, blocks = bending_terms(x, x, *args)
    direction = rng.normal(size=(4, 3)).astype(F)
    perturbed, _ = bending_terms(x+F(1e-3)*direction, x, *args)
    matrix = blocks.transpose(0, 1, 3, 2, 4).reshape(12, 12)
    np.testing.assert_allclose((perturbed-force).reshape(-1)/F(1e-3), -matrix@direction.reshape(-1),
                               atol=1e-2, rtol=1e-3)
    np.testing.assert_allclose(force.sum(axis=1), 0, atol=4e-6)


def test_block_pcg_matches_independent_dense_solution_and_zero_rhs():
    rng = np.random.default_rng(42)
    a = rng.normal(size=(18, 18)).astype(F)
    a = a.T@a + np.eye(18, dtype=F)*F(4)
    b = rng.normal(size=18).astype(F)
    result = pcg(sparse.csr_matrix(a), b, 50)
    np.testing.assert_allclose(result, np.linalg.solve(a.astype(float), b.astype(float)), atol=2e-6, rtol=2e-5)
    np.testing.assert_array_equal(pcg(sparse.csr_matrix(a), np.zeros_like(b), 50), np.zeros_like(b))


def test_tetrahedron_force_matches_independent_energy_gradient():
    from reconstruction.numerics import tetrahedron_terms
    x = np.array([[0, 0, 0], [1.1, .1, 0], [0, .9, .1], [.1, 0, 1.2]], dtype=F)
    inv = np.eye(3, dtype=F)[None]
    material = np.array([[2, 5, 0]], dtype=F)
    force, blocks = tetrahedron_terms(x, x, np.array([[0, 1, 2, 3]]), inv,
                                      np.array([1/6], dtype=F), material, np.array([.04], dtype=F), .01)
    def energy(y):
        deformation = (y[1:]-y[0]).T
        return (np.sum(deformation*deformation) + 3.5*(np.linalg.det(deformation)-1-2/7+.04)**2)/6
    gradient = np.zeros_like(x)
    for i in range(4):
        for j in range(3):
            a, b = x.astype(float), x.astype(float)
            a[i, j] += 1e-5
            b[i, j] -= 1e-5
            gradient[i, j] = (energy(a)-energy(b))/2e-5
    np.testing.assert_allclose(force[0], -gradient, atol=1e-6, rtol=1e-5)
    matrix = blocks.transpose(0, 1, 3, 2, 4).reshape(12, 12)
    np.testing.assert_allclose(matrix, matrix.T, atol=1e-6)
    assert np.linalg.eigvalsh(matrix).min() > -1e-5



def _contact_case(velocity, shape_type=1):
    from reconstruction.contact import SoftContactInputs, soft_contact_kernel
    dt = F(0.01)
    x = F([[0, 0, 0.09]])
    c = SoftContactInputs(
        count=1, particle=np.array([0], np.int32), shape=np.array([0], np.int32), body_pos=F([[5, 5, 0]]),
        body_vel=F([[0, 0, 0]]), normal=F([[0, 0, 2]]), radius=F([0.1]), mass=F([2]),
        shape_body=np.array([-1], np.int32), shape_type=np.array([shape_type], np.int32),
        shape_position=F([[0, 0, -1]]), shape_scale=F([[1, 0, 0]]), shape_margin=F([0]),
        shape_ke=F([1e4]), shape_kd=F([10]), shape_kf=F([1e3]), shape_mu=F([0.5]),
        ke=1e5, kd=100, kf=1e4, mu=0.4, x=x, previous=x-F(velocity)*dt, inv_dt=F(1)/dt)
    force, scalar, block = soft_contact_kernel(c)
    return force[0], scalar[0]*np.eye(3, dtype=F)+block[0], dt


def test_soft_contact_penalty_friction_cap_and_tangent():
    # Resting contact with tiny sliding: friction gain is capped by kf = min(1e4, 1e3).
    force, tangent, dt = _contact_case([1e-3, 0, 0])
    ke, kd = 1e4, 10.0  # kd = min(100, 10, 2*sqrt(ke*m)=282.8)
    np.testing.assert_allclose(force, [-1e3*1e-3, 0, ke*0.01], rtol=1e-5)
    np.testing.assert_allclose(tangent, np.diag([1e3/dt, 1e3/dt, ke+kd/dt]), rtol=1e-5)
    # Fast sliding: friction saturates at the Coulomb limit mu*fn opposite the slip.
    force, tangent, dt = _contact_case([2.0, 0, 0])
    np.testing.assert_allclose(force, [-0.4*ke*0.01, 0, ke*0.01], rtol=1e-5)
    np.testing.assert_allclose(tangent[0, 0], 0.4*ke*0.01/2.0/dt, rtol=1e-5)


def test_soft_contact_releases_when_separating():
    # Fast separation makes the damped normal force negative: no force and no stiffness.
    force, tangent, dt = _contact_case([0, 0, 50.0])
    np.testing.assert_allclose(force, 0, atol=1e-6)
    np.testing.assert_allclose(tangent, 0, atol=1e-3)


def test_soft_contact_sphere_uses_centre_direction():
    # Sphere of radius 1 centred at z=-1: surface at z=0, particle radius 0.1 at z=0.09 -> penetration 0.01.
    force, tangent, dt = _contact_case([0, 0, 0], shape_type=3)
    np.testing.assert_allclose(force, [0, 0, 1e4*0.01], rtol=1e-4)


def test_kernel_ab_against_legacy_ptx():
    """Bit-for-bit A/B of reconstructed kernels against the legacy library's PTX (needs GPU + cuobjdump)."""
    import shutil
    import subprocess
    import sys
    from reconstruction.kernel_ab import LEGACY
    if not LEGACY.exists() or shutil.which('cuobjdump') is None:
        pytest.skip('legacy library or CUDA toolkit unavailable')
    result = subprocess.run([sys.executable, '-m', 'reconstruction.kernel_ab', '--count', '20000'],
                            capture_output=True, text=True, timeout=600)
    assert result.returncode == 0, result.stdout[-3000:]+result.stderr[-3000:]
