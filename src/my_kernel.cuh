#ifndef MY_KERNEL_CUH
#define MY_KERNEL_CUH

__global__ void addKernel(int *c, const int *a, const int *b, int size) {
    int i = threadIdx.x + blockDim.x * blockIdx.x;
    if (i < size) {
        c[i] = a[i] + b[i];
    }
}

#endif
