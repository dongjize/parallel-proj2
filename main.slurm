#!/bin/bash

#SBATCH --time=00:30:00
#SBATCH --partition gpu
#SBATCH --gres=gpu:1
#SBATCH --output=main.out

# Load required modules
module load GCC/4.9.2
module load CUDA/8.0.44-GCC-4.9.2
module load GMP/6.1.1-GCC-4.9.2

make cuda
make cpu

# Execute the programs
./rsa_cpu 256-keys.txt
./rsa_cuda 256-keys.txt