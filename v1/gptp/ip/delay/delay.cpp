#include "delay.h"



uint32 Delay(uint48 t1_s,uint48 t2_s,uint48 t3_s,uint48 t4_s,uint32 t1,uint32 t2,uint32 t3,uint32 t4,uz8f4 rv)
{
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE ap_ctrl_none port=return

    t4_s=t4_s-t1_s;
    t4=t4-t1;
    t4=t4+t4_s*1000000000;
    t3_s=t3_s-t2_s;
    t3=t3-t2;
    t3=t3+t3_s*1000000000;
	return ((t4)*rv-(t3))>>1;
}
