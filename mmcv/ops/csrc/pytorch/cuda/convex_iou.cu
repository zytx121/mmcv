// Copyright (c) OpenMMLab. All rights reserved
#include "convex_giou_cuda_kernel.cuh"
#include "convex_iou_cuda_kernel.cuh"
#include "pytorch_cuda_helper.hpp"

void ConvexIoUCUDAKernelLauncher(const Tensor pointsets, const Tensor polygons,
                                 Tensor ious) {
  int output_size = ious.numel();
  int num_pointsets = pointsets.size(0);
  int num_polygons = polygons.size(0);

  at::cuda::CUDAGuard device_guard(pointsets.device());
  cudaStream_t stream = at::cuda::getCurrentCUDAStream();

  convex_iou_cuda_kernel<<<GET_BLOCKS(output_size), THREADS_PER_BLOCK, 0,
                           stream>>>(
      num_pointsets, num_polygons, pointsets.data_ptr<float>(),
      polygons.data_ptr<float>(), ious.data_ptr<float>());

  AT_CUDA_CHECK(cudaGetLastError());
}

void ConvexGIoUCUDAKernelLauncher(const Tensor pointsets, const Tensor polygons,
                                  Tensor output) {
  int output_size = ious.numel();
  int num_pointsets = pointsets.size(0);
  int num_polygons = polygons.size(0);

  at::cuda::CUDAGuard device_guard(pointsets.device());
  cudaStream_t stream = at::cuda::getCurrentCUDAStream();

  convex_giou_cuda_kernel<<<GET_BLOCKS(output_size), THREADS_PER_BLOCK, 0,
                            stream>>>(
      num_pointsets, num_polygons, pointsets.data_ptr<float>(),
      polygons.data_ptr<float>(), output.data_ptr<float>());

  AT_CUDA_CHECK(cudaGetLastError());
}
