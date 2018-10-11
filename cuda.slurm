#!/bin/bash

#SBATCH --time=0:30:0
#SBATCH --partition gpu 
#SBATCH --gres=gpu:1 
#SBATCH --output=hello_gpu.out

# Load required modules
module load CUDA/7.5.18-GCC-4.9.2

# Compile
nvcc hello.cu -o hello_gpu

# Execute the programs
time ./hello_gpu
