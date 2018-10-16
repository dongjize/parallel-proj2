NVFLAGS=-O3 -g -gencode arch=compute_20,code=sm_20 -gencode arch=compute_30,code=sm_30 -gencode arch=compute_35,code=sm_35 
CCFLAGS=-O3 -std=c99

# list .c and .cu source files here
CUDAFILES=gcd.cu crackRSA.cu
CUDAOBJS=$(CUDAFILES:.cu=.o)
COMMON=common.c
CPUFILES=cpu.c
LDFLAGS=-lgmp
LIBPATH=/home/clupo/gmp/lib
INCPATH=/home/clupo/gmp/include

cuda:
	g++ -O3 common.c gcd.o crackRSA.o -o rsa_cuda $^ -lcuda -lcudart -lgmp

%.o: %.cu
	nvcc -c -O3 -g -gencode arch=compute_20,code=sm_20 -gencode arch=compute_30,code=sm_30 -gencode arch=compute_35,code=sm_35 -lgmp

cpu:
	gcc -O3 cpu.c common.c -std=c99 -lgmp -o rsa_cpu

cpu_gmp:
	gcc -O3 cpu.c common.c -std=c99 -DGMP -lgmp -o rsa_cpu

clean:
	rm -f *.o rsa_cuda rsa_cpu