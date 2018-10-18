// driver for rsa cracking

#include <stdio.h>

#include "common.h"
#include "gcd.h"

/**
 * Main function to read keys from file and then matrix
 * @param argc
 * @param argv
 * @return
 */
int main(int argc, char *argv[]) {
    char *res, *cudaRes;
    bitInt *numbers, *cudaNums;

    if (argc != 2) {
        printf("error, syntax is %s <file name>\n", argv[0]);
        return 0;
    }

    int numKeys = readFile(argv[1], &numbers, &res);
    int countBytes = 1 + ((numKeys - 1) / 8);
    int numSize = SIZE_BYTES * numKeys;

    cudaMalloc(&cudaNums, numSize);
    cudaMalloc(&cudaRes, numKeys * countBytes);
    cudaMemset(cudaRes, 0, numKeys * countBytes);

    cudaMemcpy(cudaNums, numbers, numSize, cudaMemcpyHostToDevice);

    int dimBlock = SIZE * 2; // the size of each block
    int dimGrid = 1 + ((numKeys - 1) / dimBlock); // the number of blocks divided into on the GPU

    printf("%d blocks of size %d\n", dimGrid, dimBlock);

    //Lets gcd
//    for (int offset = 0; offset < numKeys; offset += WORK_SIZE) {
//        findGCDs << < dimGrid, dimBlock >> > (cudaNums, numKeys, cudaRes, offset);
//    }
    gmpGCDs << < dimGrid, dimBlock >> > (cudaNums, numKeys, cudaRes);

    cudaMemcpy(res, cudaRes, numKeys * countBytes, cudaMemcpyDeviceToHost);

    cudaFree(cudaNums);
    cudaFree(cudaRes);

    writeFiles("privateKeys", numKeys, numbers, res);

    free(numbers);
    free(res);

    return 0;
}
