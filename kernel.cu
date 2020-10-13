#include <cuda.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <stdio.h>


#if defined(__CUDA_ARCH__) && (__CUDA_ARCH__ < 200)
  # error printf is only supported on devices of compute capability 2.0 and higher, please compile with -arch=sm_20 or higher
#endif

extern "C"
void runCudaPart();


__global__ void helloCUDA()
{
    int tid = blockIdx.x;
    printf("Hello block %d thread %d \n",tid , threadIdx.x );
}

extern "C"
void runCudaPart()
{
    // all your cuda code here
    helloCUDA<<<5,1>>>();
    cudaDeviceSynchronize();
}
