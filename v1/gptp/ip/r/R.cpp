#include "R.h"

z4f8 R(uint48 t4_sec,uint48 t2_sec,uint48 t3_sec,uint48 t1_sec,uint32 t1,uint32 t2,uint32 t3,uint32 t4,uint32 found_clock, uint6* increment_nano,uint20* increment_subnano)
{
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE ap_ctrl_none port=return
   t1_sec=t3_sec-t1_sec;
   t1=t3-t1;
   t1=t1+t1_sec*1000000000;
   t2_sec=t4_sec-t2_sec;
   t2=t4-t2;
   t2=t2+t2_sec*1000000000;



//#pragma HLS INLINE recursive
//#pragma HLS PIPELINE II=1
//#pragma HLS LATENCY min=1 max=10
	z4f8 r = (float(t1 ) )/(float(t2)) ;
#pragma HLS RESOURCE variable=r core=FDiv
	z6f8 res=found_clock*r;
#pragma HLS RESOURCE variable=res core=FMul_fulldsp
	* increment_nano =uint6(res);
	* increment_subnano = (res-*increment_nano)*1048576;
	return r;
}
