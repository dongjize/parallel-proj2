#!/bin/bash

#SBATCH --time=02:00:00
#SBATCH --partition gpu
#SBATCH --gres=gpu:1
#SBATCH --output=2048.out

# Load required modules
module load GCC/4.9.2
module load CUDA/8.0.44-GCC-4.9.2
module load GMP/6.1.1-GCC-4.9.2


make cpu
time ./rsa_cpu 2048-keys.txt
make clean

make cpu_gmp
time ./rsa_cpu_gmp 2048-keys.txt
make clean

make gcd
make crackRSA
make cuda
time ./rsa_cuda 2048-keys.txt
make clean