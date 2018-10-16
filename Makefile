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

gcd.o:
	nvcc gcd.cu -c -O3 -g -gencode arch=compute_20,code=sm_20 -gencode arch=compute_30,code=sm_30 -gencode arch=compute_35,code=sm_35 -lgmp -Wl,

crackRSA.o:
	nvcc crackRSA.cu -c -O3 -g -gencode arch=compute_20,code=sm_20 -gencode arch=compute_30,code=sm_30 -gencode arch=compute_35,code=sm_35 -lgmp -Wl,

cpu:
	gcc cpu.c common.c -O3 -std=c99 -lgmp -o rsa_cpu

cpu_gmp: $(CPUFILES) $(COMMON)
	gcc $(CCFLAGS) -o rsa_cpu $^ -DGMP -L$(LIBPATH) -I$(INCPATH) $(LDFLAGS) -Wl,-rpath=$(LIBPATH)

cpuHome: $(CPUFILES) $(COMMON)
	gcc $(CCFLAGS) -o rsa_cpu $^ $(LDFLAGS)

clean: 
	rm -f *.o rsa_cuda rsa_cpu

