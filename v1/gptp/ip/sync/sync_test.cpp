#include "sync.h"

int main()
{

	uint48 of_s;
	uint32 of_n;

	uint48 ta_s;
	uint32 ta_n;
	bool  f;//1 ʱѡoff 0ѡta
	Sync(

	1,//1
	200,

	1,//2
	300,

	4,//3
	10,

	6,//b
	2,

	&of_s,
	&of_n,

	& ta_s,
	& ta_n,

	100,
	uz8f4(1.5),//(uint48 t1_s,uint32 t1_n,uint48 t2_s,uint32 t2_n,uint48 t3_s,uint32 t3_n,uint48 tb_s,uint32 tb_n,uint48 * of_s,uint32 * of_n,uint48 * ta_s,uint32 * ta_n,uint32 delay,uz8f4 rv,bool * f
	80,
	& f//1 ʱѡoff 0ѡta

    );
	std::cout<<of_s<<"\n"<<of_n<<"\n"<<ta_s<<"\n"<<ta_n<<"\n"<<f<<"\n";
	return 0;
}
