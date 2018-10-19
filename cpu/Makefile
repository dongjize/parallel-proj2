NVFLAGS=-O3 -g -gencode arch=compute_20,code=sm_20 -gencode arch=compute_30,code=sm_30 -gencode arch=compute_35,code=sm_35 
CCFLAGS=-O3 -std=c99

cpu:
	gcc -O3 cpu.c common.c -std=c99 -lgmp -o rsa_cpu

cpu_gmp:
	gcc -O3 cpu.c common.c -std=c99 -DGMP -lgmp -o rsa_cpu_gmp

clean:
	rm -f *.o