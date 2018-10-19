# parallel-proj2
Jize Dong, Minsheng Wang

## To run on Spartan, use below slurm scripts:

- Running on CPU, suppose n = 2048. 

    If testing other n (n could be 256, 2048, 4096 or 20K), just replace all 2048 with n

    cd into cpu/
```
#!/bin/bash

#SBATCH --time=02:00:00
#SBATCH --partition physical
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --output=2048.out

# Load required modules
module load GCC/4.9.2
module load GMP/6.1.1-GCC-4.9.2

# make cpu
# time ./rsa_cpu ../2048-keys.txt
# make clean

make cpu_gmp
time ./rsa_cpu_gmp ../2048-keys.txt
make clean
```
- Running on GPU, suppose n = 4096

    If testing other n (n could be 256, 2048, 4096 or 20K), just replace all 4096 with n

    cd into gpu/
```
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
```
    
