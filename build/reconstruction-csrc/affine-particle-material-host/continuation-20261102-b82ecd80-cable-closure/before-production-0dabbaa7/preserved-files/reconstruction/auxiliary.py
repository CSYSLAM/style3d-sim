"""Source replacements for legacy Thrust fill/sequence and CUB empty operations."""
import numpy as np


def fill_bytes(output, value, count):
    """Repeat a trivially copyable value without interpreting floats or touching the tail."""
    value = np.asarray(value, np.uint8).reshape(-1)
    output = np.asarray(output).view(np.uint8).reshape(-1)
    if count < 0 or count*len(value) > len(output) or not len(value):
        raise ValueError('Invalid fill extent')
    output[:count*len(value)].reshape(count, len(value))[:] = value


def sequence_int32(output, initial, step, count):
    """Thrust's signed int sequence uses low 32 bits of multiply/add, including overflow."""
    if count < 0 or count > len(output):
        raise ValueError('Invalid sequence extent')
    values = (np.arange(count, dtype=np.uint64)*np.uint64(int(step) & 0xffffffff)
              + np.uint64(int(initial) & 0xffffffff)).astype(np.uint32)
    output[:count] = values.view(np.int32)


def empty():
    """CUB EmptyKernel has no parameters, state writes or computation."""


def exclusive_sum_u32(output, count, segment_size=None):
    """In-place uint32 exclusive scan, optionally restarting at fixed-size segment boundaries."""
    if output.dtype != np.uint32 or count < 0 or count > output.size:
        raise ValueError('Invalid uint32 scan extent')
    if count == 0:
        return
    stride = count if segment_size is None else segment_size
    if stride <= 0:
        raise ValueError('Invalid scan segment')
    for start in range(0, count, stride):
        end = min(start+stride, count)
        source = output[start:end].copy()
        output[start] = 0
        output[start+1:end] = np.cumsum(source[:-1], dtype=np.uint64).astype(np.uint32)


def radix_histogram_u32(keys, output, begin_bit, end_bit):
    """Add counts for each successive 8-bit digit, masking a partial final digit."""
    if not 0 <= begin_bit <= end_bit <= 32:
        raise ValueError('Invalid radix bit range')
    keys = np.asarray(keys, np.uint32)
    for digit, shift in enumerate(range(begin_bit, end_bit, 8)):
        mask = (1 << min(8, end_bit-shift))-1
        bins = ((keys >> shift) & mask).astype(np.int64)
        counts = np.bincount(bins, minlength=256).astype(np.uint32)
        # Native histogram counts invalid lanes as UINT_MAX keys in its final 2048-item tile.
        # These sentinel counts affect only the largest bin, leaving valid key offsets unchanged.
        counts[mask] += np.uint32((-len(keys)) % 2048)
        output[digit*256:(digit+1)*256] += counts


def radix_sort_pairs(keys, values, begin_bit, end_bit, descending=False):
    """Stable uint32 digit-range ordering, preserving arbitrary 32-bit value payloads."""
    if not 0 <= begin_bit <= end_bit <= 32:
        raise ValueError('Invalid radix bit range')
    digit = (np.asarray(keys, np.uint32) >> begin_bit) & np.uint32((1 << (end_bit-begin_bit))-1)
    rank = np.bitwise_not(digit) if descending else digit
    order = np.argsort(rank, kind='stable')
    return keys[order].copy(), values[order].copy()


def grid_even_share(count, max_grid, tile):
    """Layout and contiguous ranges for legacy GridEvenShare<uint32_t>, GRID_MAPPING_RAKE."""
    tiles = (count+tile-1)//tile
    grid = max(1, min(tiles, max_grid))
    normal, big = divmod(tiles, grid)
    fields = [tiles, big, (normal+1)*tile, normal*tile, big*tile, count, grid, count, count, 0]
    ranges = []
    for block in range(grid):
        start = block*fields[2] if block < big else fields[4]+block*fields[3]
        end = start+(fields[2] if block < big else fields[3])
        ranges.append((min(count, start), min(count, end)))
    return np.asarray(fields, np.uint32), ranges


def radix_upsweep(keys, ranges, begin_bit, digit_bits, bins):
    """Histogram in bin-major/block-minor order; no invalid-lane padding in upsweep."""
    output = np.zeros((bins, len(ranges)), np.uint32)
    for block, (start, end) in enumerate(ranges):
        digit = (keys[start:end] >> begin_bit) & np.uint32((1 << digit_bits)-1)
        output[:, block] = np.bincount(digit.astype(np.int64), minlength=bins)
    return output.reshape(-1)


def radix_downsweep(keys, values, ranges, offsets, begin_bit, digit_bits, keys_out, values_out):
    """Scatter each contiguous share using the supplied bin-major exclusive spine offsets."""
    cursors = np.asarray(offsets, np.uint32).reshape(-1, len(ranges)).copy()
    for block, (start, end) in enumerate(ranges):
        for i in range(start, end):
            digit = (int(keys[i]) >> begin_bit) & ((1 << digit_bits)-1)
            destination = int(cursors[digit, block])
            keys_out[destination], values_out[destination] = keys[i], values[i]
            cursors[digit, block] += np.uint32(1)


def cub_iterator_partials(items, grid, tile=5120):
    """CUB transform-iterator sum: striped loads, then the original warp/block reduction tree."""
    from . import pcg
    from .numerics import F
    items = np.asarray(items, F)
    partials = []
    for block in range(grid):
        aggregates = np.zeros(256, F)
        initialized = False
        valid = min(256, max(0, len(items)-block*tile))
        for start in range(block*tile, len(items), grid*tile):
            end = min(len(items), start+tile)
            for offset in range(start, end, 256):
                count = min(256, end-offset)
                if not initialized:
                    aggregates[:count] = items[offset:offset+count]
                    initialized = True
                else:
                    aggregates[:count] = (aggregates[:count]+items[offset:offset+count]).astype(F)
        partials.append(pcg._block_reduce(aggregates, valid) if valid else F(0))
    return np.asarray(partials, F)


def merge_aabbs(boxes, initial=None, centroid=False):
    """Merge finite AABBs, optionally transforming each box into a point at its centroid."""
    from .numerics import F
    boxes = np.asarray(boxes, F)
    if centroid:
        centers = ((boxes[:, :3]+boxes[:, 3:]).astype(F)*F(.5)).astype(F)
        boxes = np.concatenate((centers, centers), axis=1)
    if initial is None:
        initial = np.array([np.inf]*3+[-np.inf]*3, F)
    result = np.asarray(initial, F).copy()
    if len(boxes):
        all_boxes = np.concatenate((result[None], boxes), axis=0)
        low, high = all_boxes[:, :3], all_boxes[:, 3:]
        result[:3] = np.fmin.reduce(low, axis=0)
        result[3:] = np.fmax.reduce(high, axis=0)
        # PTX min/max treat -0 as smaller than +0. NumPy fmin/fmax do not preserve this tie rule.
        low_negative_zero = np.any((low == 0) & np.signbit(low), axis=0)
        high_positive_zero = np.any((high == 0) & ~np.signbit(high), axis=0)
        result[:3] = np.where(result[:3] == 0, np.where(low_negative_zero, F(-0.0), F(0.0)), result[:3])
        result[3:] = np.where(result[3:] == 0, np.where(high_positive_zero, F(0.0), F(-0.0)), result[3:])
    return result


def radix_onesweep(keys, values, bins_in, begin_bit, digit_bits, keys_out, values_out, lookback, bins_out, counter):
    """Recover completed onesweep outputs, including inclusive lookback tags and invalid-lane counts.

    This serial source implementation validates observable completed buffers, not CUDA's concurrent
    lookback protocol. The launch contract here starts its block allocator at zero.
    """
    tile = 5376
    blocks = max(1, (len(keys)+tile-1)//tile)
    if counter[0] != 0:
        raise NotImplementedError('Resuming a nonzero onesweep allocator is not validated')
    cursor = np.asarray(bins_in[:256], np.uint32).copy()
    inclusive = np.zeros(256, np.uint32)
    mask = (1 << digit_bits)-1
    for block in range(blocks):
        start, end = block*tile, min(len(keys), (block+1)*tile)
        for i in range(start, end):
            digit = (int(keys[i]) >> begin_bit) & mask
            dest = int(cursor[digit])
            keys_out[dest], values_out[dest] = keys[i], values[i]
            cursor[digit] += np.uint32(1)
        digit = ((keys[start:end] >> begin_bit) & mask).astype(np.int64)
        counts = np.bincount(digit, minlength=256).astype(np.uint32)
        counts[mask] += np.uint32(tile-(end-start))
        inclusive += counts
        lookback[block*256:(block+1)*256] = inclusive | np.uint32(0x80000000)
    if bins_out is not None:
        bins_out[:256] = bins_in[:256]+inclusive
    counter[0] = blocks


def cub_reduce(a, b=None, kind='raw_float', grid=None, initial=None):
    """CUB reduction entry replacement; grid=None selects the single-CTA entry including its initial value.

    Supported transform iterators are Vec3InnerProduct, scalar/mat3 preconditioned residual products,
    and PrimitiveCentroidAabb. Multi-CTA results are block partials in strip-mined tile order.
    """
    from . import pcg
    from .numerics import F
    valid = ('raw_float', 'dot', 'scalar_residual', 'block_residual', 'aabb', 'centroid_aabb')
    if kind not in valid:
        raise ValueError('Unsupported reduction transform')
    a = np.asarray(a, F)
    box = kind in ('aabb', 'centroid_aabb')
    transformed = kind not in ('raw_float', 'aabb')
    if box:
        items = a
    elif kind == 'raw_float':
        items = a
    elif kind == 'block_residual':
        items = pcg.dot(pcg.mat_vec(np.asarray(b, F), a), a)
    elif kind == 'scalar_residual':
        items = pcg.dot((np.asarray(b, F)[:, None]*a).astype(F), a)
    else:
        items = pcg.dot(a, np.asarray(b, F))
    if grid is None:
        if box:
            return merge_aabbs(a, initial, transformed)
        init = F(0) if initial is None else F(initial)
        if not len(items):
            return init
        total = cub_iterator_partials(items, 1)[0] if transformed else pcg._consume_range(items, 0, len(items))
        return F(total+init)
    tile = 768 if box else 5120
    if grid < 1 or grid > max(1, (len(items)+tile-1)//tile):
        raise ValueError('Invalid CUB grid size')
    if transformed and not box:
        return cub_iterator_partials(items, grid)
    output = []
    for block in range(grid):
        parts = [items[start:min(len(items), start+tile)] for start in range(block*tile, len(items), grid*tile)]
        subset = np.concatenate(parts) if parts else items[:0]
        if box:
            output.append(merge_aabbs(subset, centroid=transformed))
        else:
            output.append(pcg._consume_range(subset, 0, len(subset)) if len(subset) else F(0))
    return np.asarray(output, F)
