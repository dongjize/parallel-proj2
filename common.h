#ifndef COMMON_H
#define COMMON_H

#include <inttypes.h>
#include <gmp.h>

typedef uint64_t bigInt;

#define BIGINT_SIZE 8
#define SIZE 16 // 1024 bit / 64 bits per bigInt
#define SIZE_BYTES 128 // SIZE * 8 bytes per bigInt
#define HIGHBIT 0x8000000000000000
#define LOWBIT  0x00000001

#define WORK_BYTES 16
#define WORK_SIZE (WORK_BYTES * 8)

#define EQ 0 // equal
#define GT 1 // greater than
#define LT -1 // less than

int readFile(const char *fileName, bigInt **numbers, char **res);

void computePrivate(mpz_t N1, mpz_t pb2, mpz_t *pk1, mpz_t *pk2);

void writeFiles(const char *privateFile, int numKeys, bigInt *keys, char *res);

#endif
