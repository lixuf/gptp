#include <ap_int.h>
#include <ap_fixed.h>
#include <iostream>

typedef unsigned int uint32;
typedef ap_uint<4> uint4;
typedef ap_ufixed<12,4> uz8f4;
typedef ap_uint<48> uint48;
uint32 Delay(uint48 t1_s,uint48 t2_s,uint48 t3_s,uint48 t4_s,uint32 t1,uint32 t2,uint32 t3,uint32 t4,uz8f4 rv);
