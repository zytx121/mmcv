# Copyright (c) OpenMMLab. All rights reserved.
from ..utils import ext_loader

ext_module = ext_loader.load_ext('_ext', ['min_area_polygons'])


def min_area_polygons(pointsets):
    """Find the smallest polygons that surrounds all points in the point sets.

    Args:
        pointsets (Tensor): point sets with shape  (N, 2 * K), where the
        integer K > 4.

    Returns:
        torch.Tensor: Return the smallest polygons with shape (N, 8).
    """
    polygons = pointsets.new_zeros((pointsets.size(0) * 8))
    ext_module.min_area_polygons(pointsets, polygons)
    return polygons.view(-1, 8)
