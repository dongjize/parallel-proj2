#!/bin/bash

#SBATCH --time=02:00:00
#SBATCH --partition gpu
#SBATCH --gres=gpu:1
#SBATCH --output=main.out

# Load required modules
module load GCC/4.9.2
module load CUDA/8.0.44-GCC-4.9.2
module load GMP/6.1.1-GCC-4.9.2

# make cpu
make cpu_gmp
make cuda

# Execute the programs
# time ./rsa_cpu_gmp 256-keys.txt
# time ./rsa_cuda 256-keys.txt

time ./rsa_cpu_gmp 20K-keys.txt
time ./rsa_cuda 20K-keys.txt