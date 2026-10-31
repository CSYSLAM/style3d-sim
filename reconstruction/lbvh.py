"""Linear BVH of the legacy self-collision module (lbvh_builder + self_collision_kernel), transcribed bit-exactly.

Sequence observed in the legacy library (nsys + LD_PRELOAD argument capture):

* at solver initialisation, per primitive set (triangles, then edges): build_*_aabbs on the model's initial
  positions with zero thickness -> centroid bounds (cub reduce of PrimitiveCentroidAabb with MergeAabbs) ->
  generate_morton_codes -> cub stable radix sort of (code, index) -> build_radix_tree (Karras) ->
  build_escape_nodes -> build_primitive_leaf_nodes. The topology is never rebuilt;
* every substep: build_*_aabbs on current positions with thickness = self_collision_radius -> refit_bvh.

Aabb is {min xyz, max xyz}. Node layout: internal nodes [0, n-2], leaves [n-1, 2n-2] in Morton order.
"""
import numpy as np

F = np.float32


def triangle_aabbs(x, triangles, thickness):
    """build_triangle_aabbs: min/max over the three vertices (pairwise as in the PTX), then -/+ thickness."""
    a, b, c = (x[triangles[:, k]] for k in range(3))
    lo = np.minimum(a, np.minimum(b, c))
    hi = np.maximum(a, np.maximum(b, c))
    return np.concatenate((lo-F(thickness), hi+F(thickness)), axis=1).astype(F)


def edge_aabbs(x, edges, thickness):
    """build_edge_aabbs: the edge endpoints are components .z and .w of the ivec4 stencil."""
    a, b = x[edges[:, 2]], x[edges[:, 3]]
    return np.concatenate((np.minimum(a, b)-F(thickness), np.maximum(a, b)+F(thickness)), axis=1).astype(F)


def centroid_bounds(aabbs):
    """cub reduce with PrimitiveCentroidAabb: bounds of (min + max) * 0.5 (min/max are order independent)."""
    c = ((aabbs[:, :3]+aabbs[:, 3:])*F(0.5)).astype(F)
    return np.concatenate((c.min(axis=0), c.max(axis=0))).astype(F)


def _expand_bits(v):
    v = np.asarray(v, np.uint32)
    v = (v*np.uint32(65537)) & np.uint32(0x030000FF)
    v = (v*np.uint32(257)) & np.uint32(0x0300F00F)
    v = (v*np.uint32(17)) & np.uint32(0x030C30C3)
    return v


def morton_codes(aabbs, bounds):
    """generate_morton_codes: 10 bits per axis of the centroid normalised in `bounds`, x in the highest bits."""
    lo, hi = bounds[:3], bounds[3:]
    extent = (hi-lo).astype(F)
    cells = []
    for axis in range(3):
        centre = (aabbs[:, axis]+aabbs[:, 3+axis])*F(0.5)
        if extent[axis] > 0:
            t = (centre-lo[axis])/extent[axis]
        else:
            t = np.full(len(aabbs), F(0.5))
        t = np.minimum(np.maximum(t.astype(F), F(0)), F(0.99999994))
        cells.append((t*F(1024)).astype(F).astype(np.uint32))  # cvt.rzi: truncation
    x, y, z = cells
    # Expansion constants as in the PTX: x uses 0x030000FF..., y and z a variant shifted by two bits.
    ex = _expand_bits(x)
    ey = (y*np.uint32(65537)) & np.uint32(251658495)
    ey = (ey*np.uint32(257)) & np.uint32(251719695)
    ey = (ey*np.uint32(17)) & np.uint32(1124872387)
    ez = (z*np.uint32(65537)) & np.uint32(251658495)
    ez = (ez*np.uint32(257)) & np.uint32(251719695)
    ez = (ez*np.uint32(17)) & np.uint32(1124872387)
    code = ((ey*np.uint32(10)) & np.uint32(0x92492492)) | ((ex*np.uint32(20)) & np.uint32(613566756))
    return (code | ((ez*np.uint32(5)) & np.uint32(1227133513))).astype(np.uint32)


def sort_primitives(codes):
    """cub DeviceRadixSort::SortPairs on (code, index): stable, so ties keep index order."""
    order = np.argsort(codes, kind='stable').astype(np.int32)
    return codes[order], order


def _delta(keys, i, j):
    n = len(keys)
    if j < 0 or j >= n:
        return -1
    x = int(keys[i]) ^ int(keys[j])
    if x == 0:
        return 32+(32-int(i ^ j).bit_length())
    return 32-x.bit_length()


def radix_tree(keys):
    """build_radix_tree (Karras 2012): returns (parent[2n-1], children[n-1, 2]); the root's parent stays -1."""
    keys = np.asarray(keys, np.uint32)
    n = len(keys)
    parent = np.full(2*n-1, -1, np.int32)
    children = np.zeros((max(n-1, 0), 2), np.int32)
    for i in range(n-1):
        next_delta = _delta(keys, i, i+1)
        prev_delta = _delta(keys, i, i-1) if 1 <= i <= n else -1
        d = -1 if next_delta < prev_delta else 1
        delta_min = _delta(keys, i, i-d)
        span = 2
        while True:
            current = span
            span = current*2
            if not _delta(keys, i, i+current*d) > delta_min:
                break
        length = 0
        t_prev = current
        while t_prev >= 2:
            t = t_prev >> 1
            if _delta(keys, i, i+(length+t)*d) > delta_min:
                length += t
            if not t_prev > 3:
                break
            t_prev = t
        j = i+length*d
        first, last = min(i, j), max(i, j)
        node_delta = _delta(keys, first, last)
        split, size = first, last-first
        while True:
            step = (size+1) >> 1
            middle = split+step
            if middle < last and _delta(keys, first, middle) > node_delta:
                split = middle
            if not size > 2:
                break
            size = step
        left = split+(n-1 if split == first else 0)
        right = split+(n if split+1 == last else 1)
        children[i] = (left, right)
        parent[left] = i
        parent[right] = i
    return parent, children


def escape_nodes(parent, children):
    """build_escape_nodes: climb while the node is a right child; the escape is that parent's right child."""
    escape = np.empty(len(parent), np.int32)
    for i in range(len(parent)):
        node, p = i, parent[i]
        while p >= 0 and children[p, 1] == node:
            node, p = p, parent[p]
        escape[i] = -1 if p < 0 else children[p, 1]
    return escape


def primitive_leaves(order):
    """build_primitive_leaf_nodes: leaf node of each primitive (n - 1 + its sorted position)."""
    n = len(order)
    leaf = np.empty(n, np.int32)
    leaf[order] = np.arange(n, dtype=np.int32)+n-1
    return leaf


def refit(aabbs, order, parent, children):
    """refit_bvh: leaves take the sorted primitive boxes, internal nodes the min/max of their children."""
    n = len(order)
    nodes = np.zeros((2*n-1, 6), F)
    nodes[n-1:] = aabbs[order]
    # Children always have larger indices than... not guaranteed for Karras trees, so iterate bottom-up by depth.
    done = np.zeros(2*n-1, bool)
    done[n-1:] = True
    pending = list(range(n-1))
    while pending:
        rest = []
        for node in pending:
            a, b = children[node]
            if done[a] and done[b]:
                nodes[node, :3] = np.minimum(nodes[a, :3], nodes[b, :3])
                nodes[node, 3:] = np.maximum(nodes[a, 3:], nodes[b, 3:])
                done[node] = True
            else:
                rest.append(node)
        pending = rest
    return nodes


class Lbvh:
    """Topology built once from initial positions; refit every substep."""
    def __init__(self, aabbs_initial):
        bounds = centroid_bounds(aabbs_initial)
        self.codes, self.order = sort_primitives(morton_codes(aabbs_initial, bounds))
        self.parent, self.children = radix_tree(self.codes)
        self.escape = escape_nodes(self.parent, self.children)
        self.leaf = primitive_leaves(self.order)
        self.nodes = None

    def refit(self, aabbs):
        self.nodes = refit(aabbs, self.order, self.parent, self.children)
        return self.nodes
