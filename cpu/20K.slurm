#!/bin/bash

#SBATCH --time=06:00:00
#SBATCH --partition physical
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --output=20K.out

# Load required modules
module load GCC/4.9.2
module load GMP/6.1.1-GCC-4.9.2


# make cpu
# time ./rsa_cpu ../20K-keys.txt
# make clean

make cpu_gmp
time ./rsa_cpu_gmp ../20K-keys.txt
make clean
