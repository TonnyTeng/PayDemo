#ifndef __DES_H
#define __DES_H

#include <stdint.h>
#include <stdbool.h>
#include <string.h>

#ifdef __cpulsplus
extern "C" {
#endif

typedef struct
{
    uint8_t subkey1[16*6];
    uint8_t subkey2[16*6];
    uint8_t subkey3[16*6];
} S_Subkey;

typedef enum
{
    DES_MODE_ENC = 0,
    DES_MODE_DEC = 1,
} E_DES_MODE;

typedef enum
{
    DES_KEY_MODE_SINGLE  = 0,
    DES_KEY_MODE_DOUBLE  = 1,
    DES_KEY_MODE_TRIPPLE = 2
} E_DES_KEY_MODE;


bool Des_EncData(uint8_t * indata, uint8_t * outdata, uint16_t Len, const uint8_t * key, E_DES_KEY_MODE keymode);
bool Des_DecData(uint8_t * indata, uint8_t * outdata, uint16_t Len, const uint8_t * key, E_DES_KEY_MODE keymode);
bool DES_ProcessData(uint8_t * indata, uint8_t * outdata, uint16_t Len, const uint8_t * key, E_DES_KEY_MODE keymode, E_DES_MODE mode);
bool Des_Discrete(uint8_t * random, const uint8_t * key, uint8_t keylen, uint8_t * out);
E_DES_KEY_MODE Des_GetDesMode(uint8_t keylen);
bool Des_CheckValue(uint8_t * inkey, uint16_t len, uint8_t * checkvalue, uint8_t cvlen, const uint8_t * deckey, E_DES_KEY_MODE keymode);

#ifdef __cplusplus
}
#endif

#endif

