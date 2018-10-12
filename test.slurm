#!/bin/bash

#SBATCH --time=00:30:00
#SBATCH --partition gpu
#SBATCH --gres=gpu:1
#SBATCH --output=test_gpu.out

# Load required modules
module load CUDA/8.0.44-GCC-4.9.2
module load OpenCV/3.1.0-GCC-4.9.2

# Compile .c file
# gcc test.c -std=gnu99 -o test

# Compile .cu file
nvcc test.cu -o test_gpu

# Execute the programs
time ./test_gpu