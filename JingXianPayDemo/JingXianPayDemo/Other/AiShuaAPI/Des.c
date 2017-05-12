/***********************************
**说明:此模块是Des加解密模块 
**author:白常青
**日期:2012－05
**
************************************/

#include "des.h"



//常量定义
const uint8_t BitIP[64] =
    {
     57, 49, 41, 33, 25, 17,  9,  1,
     59, 51, 43, 35, 27, 19, 11,  3,
     61, 53, 45, 37, 29, 21, 13,  5,
     63, 55, 47, 39, 31, 23, 15,  7,
     56, 48, 40, 32, 24, 16,  8,  0,
     58, 50, 42, 34, 26, 18, 10,  2,
     60, 52, 44, 36, 28, 20, 12,  4,
     62, 54, 46, 38, 30, 22, 14,  6 
    };

const uint8_t  BitCP[64] =
    { 
      39,  7, 47, 15, 55, 23, 63, 31,
      38,  6, 46, 14, 54, 22, 62, 30,
      37,  5, 45, 13, 53, 21, 61, 29,
      36,  4, 44, 12, 52, 20, 60, 28,
      35,  3, 43, 11, 51, 19, 59, 27,
      34,  2, 42, 10, 50, 18, 58, 26,
      33,  1, 41,  9, 49, 17, 57, 25,
      32,  0, 40,  8, 48, 16, 56, 24
    };

const uint8_t  BitExp[48] =
    { 
      31,  0,  1,  2,  3,  4,  3,  4, 
       5,  6,  7,  8,  7,  8,  9, 10,
      11, 12, 11, 12, 13, 14, 15, 16,
      15, 16, 17, 18, 19, 20, 19, 20,
      21, 22, 23, 24, 23, 24, 25, 26,
      27, 28, 27, 28, 29, 30, 31,  0 
    };

const uint8_t  BitPM[32] =
    { 
      15,  6, 19, 20, 28, 11, 27, 16, 
       0, 14, 22, 25,  4, 17, 30,  9,
       1,  7, 23, 13, 31, 26,  2,  8,
      18, 12, 29,  5, 21, 10,  3, 24 
    };

const uint8_t  sBox[8][64] =
    { 
      { 
        14,  4, 13,  1,  2, 15, 11,  8,  
         3, 10,  6, 12,  5,  9,  0,  7,
         0, 15,  7,  4, 14,  2, 13,  1, 
        10,  6, 12, 11,  9,  5,  3,  8,
         4,  1, 14,  8, 13,  6,  2, 11, 
        15, 12,  9,  7,  3, 10,  5,  0,
        15, 12,  8,  2,  4,  9,  1,  7,  
         5, 11,  3, 14, 10,  0,  6, 13 
      },

      { 
        15,  1,  8, 14,  6, 11,  3,  4,  
         9,  7,  2, 13, 12,  0,  5, 10,
         3, 13,  4,  7, 15,  2,  8, 14,
        12,  0,  1, 10,  6,  9, 11,  5,
         0, 14,  7, 11, 10,  4, 13,  1,
         5,  8, 12,  6,  9,  3,  2, 15,
        13,  8, 10,  1,  3, 15,  4,  2,
        11,  6,  7, 12,  0,  5, 14,  9 
      },

      { 
        10,  0,  9, 14,  6,  3, 15,  5,
         1, 13, 12,  7, 11,  4,  2,  8,
        13,  7,  0,  9,  3,  4,  6, 10,
         2,  8,  5, 14, 12, 11, 15,  1,
        13,  6,  4,  9,  8, 15,  3,  0,
        11,  1,  2, 12,  5, 10, 14,  7,
         1, 10, 13,  0,  6,  9,  8,  7,
         4, 15, 14,  3, 11,  5,  2, 12 
      },

      {  
         7, 13, 14,  3,  0,  6,  9, 10,
         1,  2,  8,  5, 11, 12,  4, 15,
        13,  8, 11,  5,  6, 15,  0,  3,
         4,  7,  2, 12,  1, 10, 14,  9,
        10,  6,  9,  0, 12, 11,  7, 13,
        15,  1,  3, 14,  5,  2,  8,  4,
         3, 15,  0,  6, 10,  1, 13,  8,
         9,  4,  5, 11, 12,  7,  2, 14 
      },

      {  
         2, 12,  4,  1,  7, 10, 11,  6,
         8,  5,  3, 15, 13,  0, 14,  9,
        14, 11,  2, 12,  4,  7, 13,  1,
         5,  0, 15, 10,  3,  9,  8,  6,
         4,  2,  1, 11, 10, 13,  7,  8,
        15,  9, 12,  5,  6,  3,  0, 14,
        11,  8, 12,  7,  1, 14,  2, 13,
         6, 15,  0,  9, 10,  4,  5,  3 
      },

      { 
        12,  1, 10, 15,  9,  2,  6,  8,
         0, 13,  3,  4, 14,  7,  5, 11,
        10, 15,  4,  2,  7, 12,  9,  5,
         6,  1, 13, 14,  0, 11,  3,  8,
         9, 14, 15,  5,  2,  8, 12,  3,
         7,  0,  4, 10,  1, 13, 11,  6,
         4,  3,  2, 12,  9,  5, 15, 10,
        11, 14,  1,  7,  6,  0,  8, 13 
      },

      {  
         4, 11,  2, 14, 15,  0,  8, 13,
         3, 12,  9,  7,  5, 10,  6,  1,
        13,  0, 11,  7,  4,  9,  1, 10,
        14,  3,  5, 12,  2, 15,  8,  6,
         1,  4, 11, 13, 12,  3,  7, 14,
        10, 15,  6,  8,  0,  5,  9,  2,
         6, 11, 13,  8,  1,  4, 10,  7,
         9,  5,  0, 15, 14,  2,  3, 12 
      },

      { 
        13,  2,  8,  4,  6, 15, 11,  1,
        10,  9,  3, 14,  5,  0, 12,  7,
         1, 15, 13,  8, 10,  3,  7,  4,
        12,  5,  6, 11,  0, 14,  9,  2,
         7, 11,  4,  1,  9, 12, 14,  2,
         0,  6, 10, 13, 15,  3,  5,  8,
         2,  1, 14,  7,  4, 10,  8, 13,
        15, 12,  9,  0,  3,  5,  6, 11 
      }
    };

const uint8_t  BitPMC1[56] =
    { 
      56, 48, 40, 32, 24, 16,  8,
       0, 57, 49, 41, 33, 25, 17,
       9,  1, 58, 50, 42, 34, 26,
      18, 10,  2, 59, 51, 43, 35,
      62, 54, 46, 38, 30, 22, 14,
       6, 61, 53, 45, 37, 29, 21,
      13,  5, 60, 52, 44, 36, 28,
      20, 12,  4, 27, 19, 11,  3 
    };

const uint8_t  BitPMC2[48] =
    { 
      13, 16, 10, 23,  0,  4,
       2, 27, 14,  5, 20,  9,
      22, 18, 11,  3, 25,  7,
      15,  6, 26, 19, 12,  1,
      40, 51, 30, 36, 46, 54,
      29, 39, 50, 44, 32, 47,
      43, 48, 38, 55, 33, 52,
      45, 41, 49, 35, 28, 31 
    };

const uint8_t bitDisplace[16] =
    {
        1,1,2,2, 
        2,2,2,2, 
        1,2,2,2, 
        2,2,2,1
    };


/****************************
***根据密钥长度获取加密模式
***
*****************************/
E_DES_KEY_MODE Des_GetDesMode(uint8_t keylen)
{
    if (keylen == 8)
        return DES_KEY_MODE_SINGLE;
    else if(keylen == 16)
        return DES_KEY_MODE_DOUBLE;
    else
        return DES_KEY_MODE_TRIPPLE;
}

/**************************
***功能;初始化数据
***
****************************/
void Des_InitPermutation(uint8_t *indata)
{
    uint8_t newdata[8]={0,0,0,0,0,0,0,0};
    uint8_t i;

    for (i=0; i<64; i++)
    {
        if ((indata[BitIP[i]>>3] &(1<<(7-(BitIP[i]&0x07)))) !=0)
        {
            newdata[i>>3] |= (1<<(7-(i & 0x07)));
        }
    }

    for (i=0; i<8; i++)
    {
        indata[i] = newdata[i];
    }   
}


/*********************************
***功能:队列转换
***
***********************************/
void Des_ConversePermutation(uint8_t *indata)
{
    uint8_t newdata[8] = {0,0,0,0,0,0,0,0};
    uint8_t i;

    for (i=0; i<64; i++)
    {
        if ((indata[BitCP[i]>>3] &(1<<(7-(BitCP[i]&0x07)))) !=0)
        {
            newdata[i>>3] |= (1<<(7-(i & 0x07)));
        }
    }

    for (i=0; i<8; i++)
    {
        indata[i] = newdata[i];
    }
    
}

/***************************
***数据扩展
***
*******************************/
void Des_Expand(uint8_t *indata, uint8_t *outdata)
{
    uint8_t i;

    for (i=0; i<6; i++)
        outdata[i] = 0;


    for (i=0; i<48; i++)
    {
        if ((indata[BitExp[i]>>3] &(1<<(7-(BitExp[i]&0x07)))) !=0)
        {
            outdata[i>>3] |= (1<<(7-(i & 0x07)));
        }
    }
}

/*************************
**8
****************************/
void Des_Permutation(uint8_t *indata)
{
    uint8_t newdata[4] = {0,0,0,0};
    uint8_t i;

    for (i=0; i<32; i++)
    {
        if ((indata[BitPM[i]>>3] &(1<<(7-(BitPM[i]&0x07)))) !=0)
        {
            newdata[i>>3] |= (1<<(7-(i & 0x07)));
        }
    }

    for (i=0; i<4; i++)
    {
        indata[i] = newdata[i];
    }
}


/****************************
***
*****************************/
uint8_t Des_SI(uint8_t s, uint8_t u8data)
{
    uint8_t c;

    c = (u8data & 0x20) | ((u8data & 0x1e) >> 1) | ((u8data & 0x01) << 4);

    return (sBox[s][c] & 0x0f);
    
}

/************************************
***
***
*************************************/
void Des_PermutationChoose1(const uint8_t *indata, uint8_t *outdata)
{
    uint8_t i;
    for (i=0; i<7; i++)
        outdata[i] = 0;

    for (i=0; i<56; i++)
    {
        if ((indata[BitPMC1[i]>>3] &(1<<(7-(BitPMC1[i]&0x07)))) !=0)
        {
            outdata[i>>3] |= (1<<(7-(i & 0x07)));
        }
    }
}

/************************************
***
***
*************************************/
void Des_PermutationChoose2(uint8_t *indata, uint8_t *outdata)
{
    uint8_t i;
    for (i=0; i<7; i++)
        outdata[i] = 0;

    for (i=0; i<56; i++)
    {
        if ((indata[BitPMC2[i]>>3] &(1<<(7-(BitPMC2[i]&0x07)))) !=0)
        {
            outdata[i>>3] |= (1<<(7-(i & 0x07)));
        }
    }
}

/*******************************
***
***
********************************/
void Des_CycleMove(uint8_t *indata, uint8_t bitmove)
{
    uint16_t i;
    
    for (i=0; i<bitmove; i++)
    {
        indata[0] = (indata[0] << 1) | (indata[1] >> 7);
        indata[1] = (indata[1] << 1) | (indata[2] >> 7);
        indata[2] = (indata[2] << 1) | (indata[3] >> 7);
        indata[3] = (indata[3] << 1) | ((indata[0] & 0x10) >> 4);
        indata[0] = (indata[0] & 0x0f);
    }
}

/**********************************
***生成密钥
***
************************************/
void Des_MakeKey(const uint8_t *inkey, uint8_t *outkey)
{


    uint8_t outdata56[7],key28r[4],key28l[4],key56o[7];
    uint8_t i;

    Des_PermutationChoose1(inkey, outdata56);

    key28l[0] = outdata56[0] >> 4;
    key28l[1] = (outdata56[0] << 4) | (outdata56[1] >> 4);
    key28l[2] = (outdata56[1] << 4) | (outdata56[2] >> 4);
    key28l[3] = (outdata56[2] << 4) | (outdata56[3] >> 4);
    key28r[0] = outdata56[3] & 0x0f;
    key28r[1] = outdata56[4];
    key28r[2] = outdata56[5];
    key28r[3] = outdata56[6];

    for (i=0;i<16;i++)
    {
  
        Des_CycleMove(key28l, bitDisplace[i]);
        Des_CycleMove(key28r, bitDisplace[i]);
        key56o[0] = (key28l[0] << 4) | (key28l[1] >> 4);
        key56o[1] = (key28l[1] << 4) | (key28l[2] >> 4);
        key56o[2] = (key28l[2] << 4) | (key28l[3] >> 4);
        key56o[3] = (key28l[3] << 4) | (key28r[0]);
        key56o[4] = key28r[1];
        key56o[5] = key28r[2];
        key56o[6] = key28r[3];
        Des_PermutationChoose2(key56o, outkey+i*6);
    }
}

/********************************8
***
***
**********************************/
void Des_Encry(uint8_t *indata, uint8_t *subkey, uint8_t *outdata)
{
    uint8_t outBuf[6], buf[8], i;

    Des_Expand(indata, outBuf);

    for (i=0; i<6; i++)
    {
        outBuf[i] ^= subkey[i];
    }

    buf[0] = outBuf[0] >> 2;                                  //xxxxxx -> 2
    buf[1] = ((outBuf[0] & 0x03) << 4) | (outBuf[1] >> 4); // 4 <- xx xxxx -> 4
    buf[2] = ((outBuf[1] & 0x0f) << 2) | (outBuf[2] >> 6); //        2 <- xxxx xx -> 6
    buf[3] = outBuf[2] & 0x3f;                                //                    xxxxxx
    buf[4] = outBuf[3] >> 2;                                  //                           xxxxxx
    buf[5] = ((outBuf[3] & 0x03) << 4) | (outBuf[4] >> 4); //                                 xx xxxx
    buf[6] = ((outBuf[4] & 0x0f) << 2) | (outBuf[5] >> 6); //                                        xxxx xx
    buf[7] = outBuf[5] & 0x3f;                                //  


    for (i=0; i<8; i++)
    {
        buf[i] = Des_SI(i, buf[i]);
    }

    for (i=0; i<4; i++)
    {
        outBuf[i] = (buf[i*2] << 4) | buf[i*2+1];
    }

    Des_Permutation(outBuf);

    for (i=0; i<4; i++)
        outdata[i] = outBuf[i];
    
    
}

/************************************
***数据加密
***para:  desmode-加密/解密
          indata -输入的8字节数据的指针
          outdata - 输出的8字节数据的指针
***
*************************************/
void Des_desData(E_DES_MODE desmode, uint8_t *indata, uint8_t *subkey, uint8_t *outdata)
{
    uint8_t i,j;
    uint8_t temp[4],buf[4];

    for (i=0; i<8; i++)
    {
        outdata[i] = indata[i];
    }

    Des_InitPermutation(outdata);

    switch (desmode)
    {
        case DES_MODE_ENC:
        {
            //加密
            for (i=0; i<16; i++)
            {
                for (j=0; j<4; j++) temp[j] = outdata[j];                 //temp = Ln
                for (j=0; j<4; j++) outdata[j] = outdata[j + 4];            //Ln+1 = Rn

                Des_Encry(outdata, subkey+i*6, buf);                           //Rn ==Kn==> buf

                for (j=0; j<4; j++) outdata[j + 4] = temp[j] ^ buf[j];  //Rn+1 = Ln^buf
            }

            for (j=0; j<4; j++) temp[j] = outdata[j + 4];
            for (j=0; j<4; j++) outdata[j + 4] = outdata[j];
            for (j=0; j<4; j++) outdata[j] = temp[j];
            
            break;
            
        }

        case DES_MODE_DEC:
        {
            //解密

            for (i=16; i>0; i--)
            {
                for (j=0; j<4; j++) temp[j] = outdata[j]; 
                for (j=0; j<4; j++) outdata[j] = outdata[j + 4];

                Des_Encry(outdata, subkey+(i-1)*6, buf);

                for (j=0; j<4; j++) outdata[j + 4] = temp[j] ^ buf[j];
            }

            for (j=0; j<4; j++) temp[j] = outdata[j + 4];
            for (j=0; j<4; j++) outdata[j + 4] = outdata[j];
            for (j=0; j<4; j++) outdata[j] = temp[j];
            break;
        }

        default: break;
    }

    Des_ConversePermutation(outdata);
    
}

/************************************
***生成密钥子过程
***
***************************************/
void Des_MakeKeySub(const uint8_t *key, E_DES_KEY_MODE keymode, S_Subkey *subkey)

{
    //uint8_t i,j;
    
    Des_MakeKey(key, subkey->subkey1);

    if (keymode != DES_KEY_MODE_SINGLE)
    {
        //双倍长和三倍长密钥
        Des_MakeKey(&key[8], subkey->subkey2);
    }

    if (keymode == DES_KEY_MODE_TRIPPLE)
    {
        //三倍长密钥
        Des_MakeKey(&key[16], subkey->subkey3);
    }
    else if (keymode == DES_KEY_MODE_DOUBLE)
    {
        //双倍长密钥:将subkey1 copy到subkey3
        memcpy(subkey->subkey3, subkey->subkey1, 16*6);
        /*
        for (i=0; i<16; i++)
        {
            for (j=0; j<6; j++)
            {
                subkey3[i][j] = subkey1[i][j];
            }
        }
        */
        
    }
}


/************************************
***加密
***
*************************************/
bool Des_EncData(uint8_t *indata,
                       uint8_t *outdata,
                       uint16_t  Len,
                      const uint8_t *key, E_DES_KEY_MODE keymode)
{
    //uint8_t subkey1[16*6], subkey2[16*6], subkey3[16*6], temp[8];
    uint8_t temp[8];
    uint16_t i,j;

    S_Subkey subkey;

    if (keymode > DES_KEY_MODE_TRIPPLE)
        return false;   //不支持的密钥模式

    if ((Len %8) !=0)
        return false;   //非8字节对齐
    
    //生成自密钥
    Des_MakeKeySub(key, keymode, &subkey);


    //进行加密

    for (i=0; i<(Len/8); i++)
    {

        Des_desData(DES_MODE_ENC, &indata[i*8], subkey.subkey1, &outdata[i*8]);

        if (keymode != DES_KEY_MODE_SINGLE)
        {
            for (j=0; j<8; j++)  temp[j] = outdata[i*8 +j];
            
            //双倍长和三倍长密钥
            Des_desData(DES_MODE_DEC, temp, subkey.subkey2, &outdata[i*8]);

            
            for (j=0; j<8; j++) temp[j] = outdata[i*8 +j];

            Des_desData(DES_MODE_ENC, temp, subkey.subkey3, &outdata[i*8]);
        }
    }

    return true;
    
}

/************************************
***解密
***
************************************/
bool Des_DecData(uint8_t *indata,
                       uint8_t *outdata,
                       uint16_t  Len,
                      const uint8_t *key, E_DES_KEY_MODE keymode)
{
    //uint8_t subkey1[16*6], subkey2[16*6], subkey3[16*6], temp[8];
    uint8_t temp[8];
    uint16_t i,j;

    S_Subkey subkey;

    if (keymode > DES_KEY_MODE_TRIPPLE)
        return false;   //不支持的密钥模式

    if ((Len %8) !=0)
        return false;   //非8字节对齐
    
    //生成自密钥
    Des_MakeKeySub(key, keymode, &subkey);


    //进行加密

    for (i=0; i<(Len/8); i++)
    {

        Des_desData(DES_MODE_DEC, &indata[i*8], subkey.subkey1, &outdata[i*8]);

        if (keymode != DES_KEY_MODE_SINGLE)
        {
            for (j=0; j<8; j++)  temp[j] = outdata[i*8 +j];
            
            //双倍长和三倍长密钥
            Des_desData(DES_MODE_ENC, temp, subkey.subkey2, &outdata[i*8]);

            
            for (j=0; j<8; j++) temp[j] = outdata[i*8 +j];

            Des_desData(DES_MODE_DEC, temp, subkey.subkey3, &outdata[i*8]);
        }   
    }

    return true;
}


/**********************************
***功能;加密或者解密数据
***
***********************************/
bool DES_ProcessData(uint8_t *indata,
                             uint8_t *outdata,
                             uint16_t  Len,
                            const uint8_t *key, E_DES_KEY_MODE keymode,
                             E_DES_MODE mode)
{

    bool b_result = false;

    switch (mode)
    {
        case DES_MODE_ENC:
        {
            b_result = Des_EncData(indata, outdata, Len, key, keymode);
            break;
        }

        case DES_MODE_DEC:
        {
            b_result = Des_DecData(indata, outdata, Len, key, keymode);
            break;
        }

        default: break;
    }
    
    return b_result;
}


/***************************
***离散
***输入;8字节的离散数据
***输出:16字节的离散结果
*****************************/
bool Des_Discrete(uint8_t *random, const uint8_t *key, uint8_t keylen, uint8_t *out)
{
    uint8_t temp[8] ={0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
    uint8_t encresult[8];
    uint8_t i;

    if ((keylen !=8) && (keylen !=16) && (keylen !=24))
        return false;
    
    if (!Des_EncData(random, encresult, 8, key, Des_GetDesMode(keylen)))
        return false;


    //异或随机数
    for (i=0; i<8; i++)
        temp[i] ^= random[i];

    if (!Des_EncData(temp, &out[8], 8, key, Des_GetDesMode(keylen)))
        return false;

    for (i=0; i<8; i++)
        out[i] = encresult[i];
    return true;
    
}

/*********************************
**解密并判断是否合法
**
**********************************/
bool Des_CheckValue(uint8_t *inkey,
                            uint16_t len,
                            uint8_t *checkvalue,
                            uint8_t cvlen,
                           const uint8_t *deckey, E_DES_KEY_MODE keymode)

{
    uint8_t temp[8]={0,0,0,0,0,0,0,0};
    uint8_t outkey[24];

    if(cvlen ==0)
        return true;
    
    //解密数据
    if (!Des_DecData(inkey, &outkey[0], len, deckey, keymode))
        return false;

    //用解密后的密钥对数据全0进行加密,然后判断是否checkvalue 正确
    if(!Des_EncData(&temp[0], &temp[0], 8, &outkey[0], Des_GetDesMode(len)))
        return false;


    /*
    for (i=0; i<4; i++)
    {
        if (temp[i] !=checkvalue[i])
            return false;
    }
        
    return true;
    */

    
    if (cvlen>8)
        cvlen = 8;
     
    if (memcmp(temp, checkvalue, cvlen)  == 0)
        return true;
    else
        return false;


}


