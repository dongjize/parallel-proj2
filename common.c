#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <gmp.h>

#include "common.h"

int readFile(const char *fileName, bigInt **numbers, char **res) {
    int countBytes;
    mpz_t tempNum;
    mpz_init(tempNum);


    FILE *fp = fopen(fileName, "r");

    int numKeys = 0;
    while (EOF != (fscanf(fp, "%*[^\n]"), fscanf(fp, "%*c"))) {
        ++numKeys;
    }

    printf("%d keys\n", numKeys);

    fseek(fp, 0, SEEK_SET);

    countBytes = 1 + ((numKeys - 1) / 8);
    *numbers = (bigInt *) malloc(SIZE_BYTES * numKeys);
    *res = (char *) calloc(numKeys, countBytes);

    int i;
    for (i = 0; i < numKeys; i++) {
        gmp_fscanf(fp, "%Zd\n", &tempNum);
        mpz_export((*numbers) + i * SIZE, NULL, -1, BIGINT_SIZE, -1, 0, tempNum);
    }
    fclose(fp);

    return numKeys;
}

/**
 * Compute the private key
 * @param N1 N1 = p * q
 * @param N2 N2 = p * q
 * @param pk1 private key 1
 * @param pk2 private key 2
 */
void computePrivate(mpz_t N1, mpz_t N2, mpz_t *d1, mpz_t *d2) {
    mpz_t p, q1, q2, e, t1, t2, tc, phi1, phi2;
    mpz_inits(p, q1, q2, e, t1, t2, tc, phi1, phi2, NULL);

    mpz_gcd(p, N1, N2); // p := gcd (N1, N2)
    mpz_cdiv_q(q1, N1, p); // q1 = N1 / p
    mpz_cdiv_q(q2, N2, p); // q2 = N2 / p

    mpz_sub_ui(t1, q1, 1); // t1 = q1 - 1
    mpz_sub_ui(t2, q2, 1); // t2 = q2 - 1
    mpz_sub_ui(tc, p, 1); // tc = p - 1

    mpz_mul(phi1, t1, tc); // phi1 = t1 * tc
    mpz_mul(phi2, t2, tc); // phi2 = t2 * tc

    mpz_set_ui(e, 65537); // e = 65537

    mpz_invert(*d1, e, phi1); // compute the inverse d such that: d * e mod phi1 = 1
    mpz_invert(*d2, e, phi2); // compute the inverse d such that: d * e mod phi2 = 1
}

void writeFiles(const char *privateFile, int numKeys, bigInt *keys, char *res) {

    int i, j, k;
    mpz_t N1, N2, d1, d2;

    mpz_inits(N1, N2, d1, d2, NULL);

    int countBytes = 1 + ((numKeys - 1) / 8);
    int ndx = 0;

    FILE *outFile = fopen(privateFile, "w");

    for (i = 0; i < numKeys; i++) {
        for (j = 0; j < countBytes; j++, ndx++) {
            if (res[ndx]) {
                for (k = 0; k < 8; k++) {
                    if (res[ndx] & (1 << k)) {
                        printf("Keys %d %d share a factor\n", i, j * 8 + k);

                        mpz_import(N1, SIZE, -1, BIGINT_SIZE, -1, 0, keys + i * SIZE);
                        mpz_import(N2, SIZE, -1, BIGINT_SIZE, -1, 0, keys + (j * 8 + k) * SIZE);
                        computePrivate(N1, N2, &d1, &d2);

                        gmp_fprintf(outFile, "%Zd:%Zd\n%Zd:%Zd\n", N1, d1, N2, d2);
                    }
                }
            }
        }
    }

    fclose(outFile);
}