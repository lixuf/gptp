#include "sync.h"

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
)
{
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS PIPELINE II=1

 uint80 t1=t1_s*1000000000+t1_n;
 uint80 t2=t2_s*1000000000+t2_n*rv;
 uint80 t2_y=t2_s*1000000000+t2_n;
 uint80 t3=t3_s*1000000000+t3_n;
 uint80 tb=tb_s*1000000000+tb_n*rv;
 uint80 ta=t1+delay+(tb-t2)+ta_offset;
 uint80 of=(t1+delay)-t2_y;
 *f=(t1+delay)>=t2_y;
 *ta_s=ta/1000000000;
 *ta_n=ta-(uint80(*ta_s)*1000000000);
 *of_s=of/1000000000;
 *of_n=of-(uint80(*of_s)*1000000000);
}
