

#include <hls_half.h>
#include <iostream>
#include <ap_int.h>
#include <ap_fixed.h>

typedef unsigned int uint32;
typedef unsigned short int uint16;
typedef ap_ufixed<12,4> z4f8;
typedef ap_ufixed<14,6> z6f8;
typedef ap_uint<6> uint6;
typedef ap_uint<20> uint20;
typedef ap_uint<48> uint48;



z4f8 R(uint48 t4_sec,uint48 t2_sec,uint48 t3_sec,uint48 t1_sec,uint32 t1,uint32 t2,uint32 t3,uint32 t4,uint32 found_clock, uint6* increment_nano,uint20* increment_subnano);
