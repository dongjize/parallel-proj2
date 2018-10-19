#!/bin/bash

#SBATCH --time=02:00:00
#SBATCH --partition physical
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --output=256.out

# Load required modules
module load GCC/4.9.2
module load GMP/6.1.1-GCC-4.9.2


# make cpu
# time ./rsa_cpu ../256-keys.txt
# make clean

make cpu_gmp
time ./rsa_cpu_gmp ../256-keys.txt
make clean
