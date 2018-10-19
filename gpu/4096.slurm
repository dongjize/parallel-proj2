#!/bin/bash

#SBATCH --time=02:00:00
#SBATCH --partition gpu
#SBATCH --gres=gpu:1
#SBATCH --output=4096.out

# Load required modules
module load GCC/4.9.2
module load CUDA/8.0.44-GCC-4.9.2
module load GMP/6.1.1-GCC-4.9.2


make main.o
make rsa.o
make integer.o
make all
time ./main ../4096-keys.txt 4096 cracked
make clean
