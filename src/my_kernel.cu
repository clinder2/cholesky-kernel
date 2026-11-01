#include <iostream>
#include <cuda_runtime.h>
#include "my_kernel.cuh"

int main() {
    const int arraySize = 5;
    const int a[arraySize] = {1, 2, 3, 4, 5};
    const int b[arraySize] = {10, 20, 30, 40, 50};
    int c[arraySize] = {0};

    int *dev_a, *dev_b, *dev_c;
    cudaMalloc((void**)&dev_c, arraySize * sizeof(int));
    cudaMalloc((void**)&dev_a, arraySize * sizeof(int));
    cudaMalloc((void**)&dev_b, arraySize * sizeof(int));

    cudaMemcpy(dev_a, a, arraySize * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(dev_b, b, arraySize * sizeof(int), cudaMemcpyHostToDevice);

    addKernel<<<1, arraySize>>>(dev_c, dev_a, dev_b, arraySize);
    cudaDeviceSynchronize();

    cudaMemcpy(c, dev_c, arraySize * sizeof(int), cudaMemcpyDeviceToHost);

    std::cout << "Result from separate files: ";
    for (int i = 0; i < arraySize; i++) {
        std::cout << c[i] << " ";
    }
    std::cout << std::endl;

    cudaFree(dev_c);
    cudaFree(dev_a);
    cudaFree(dev_b);
    return 0;
}
