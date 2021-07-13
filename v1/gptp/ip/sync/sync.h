#include <ap_int.h>
#include <ap_fixed.h>
#include <iostream>
typedef ap_uint<48> uint48;
typedef ap_uint<32> uint32;
typedef ap_uint<16> uint16;
typedef ap_uint<4> uint4;
typedef ap_uint<80> uint80;
typedef ap_ufixed<12,4> uz8f4;

void Sync(

uint48 t1_s,
uint32 t1_n,

uint48 t2_s,
uint32 t2_n,

uint48 t3_s,
uint32 t3_n,

uint48 tb_s,
uint32 tb_n,

uint48 * of_s,
uint32 * of_n,

uint48 * ta_s,
uint32 * ta_n,

uint32 delay,
uz8f4 rv,
uint32 ta_offset,
bool * f//1 ʱѡoff 0ѡta
);
