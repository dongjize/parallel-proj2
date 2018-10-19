NVCC=nvcc
GPP=g++

NVFLAGS=-O3 -gencode arch=compute_20,code=sm_20 -gencode arch=compute_30,code=sm_30 -gencode arch=compute_35,code=sm_35
LDFLAGS=-L. -L/usr/local/cuda/lib64 -L/home/clupo/gmp/lib -lcudart -lgmp -I.
GPPFLAGS=-O3 -Wno-write-strings -I/home/clupo/gmp/include -I/usr/local/cuda/include

all: main

main: main.o rsa.o integer.o
	$(GPP) $(LDFLAGS) $^ -o $@

main.o: main.cpp
	$(GPP) $(GPPFLAGS) -c $< -o $@

rsa.o: rsa.cpp
	$(GPP) $(GPPFLAGS) -c $< -o $@

integer.o: integer.cu integer.h
	$(NVCC) $(NVFLAGS) -c $< -o $@

clean:
	rm -f *.o
