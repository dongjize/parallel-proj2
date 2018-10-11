#!/bin/bash

#SBATCH sinteractive
#SBATCH --time=00:10:00
#SBATCH --partition gpu 
#SBATCH --gres=gpu:1 
#SBATCH --output=hello.out

# Load required modules
module load CUDA/7.5.18-GCC-4.9.2

# Compile .c file
gcc hello.c -std=gnu99 -o hello

# Compile .cu file
# nvcc hello.cu -o hello_gpu

# Execute the programs
time ./hello
