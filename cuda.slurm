#!/bin/bash

#SBATCH --time=00:10:00
#SBATCH --partition gpu 
#SBATCH --gres=gpu:1 
#SBATCH --output=hello.out

# Load required modules
# module load OpenMPI/1.10.2-GCC-4.9.2
# module load GCC/6.2.0
# module load OpenMPI/1.10.2-intel-2017.u2
module load CUDA/7.5.18-GCC-4.9.2

# Compile with OpenMP directives
# g++ -o graph.exe graph.cpp -fopenmp
# gcc -o3 -o mandelbrot main.cpp -lstdc++ -fopenmp
gcc hello.cu -std=gnu99 -o hello

# Execute the programs
./hello
