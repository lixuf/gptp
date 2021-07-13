
#include "delay.h"

int main()
{
	uint32 t1=3,t2=5,t3=6,t4=10;


	uint32 delay=Delay(199998,199999,199999,199999, t1,t2, t3,t4, 2.5);

	std::cout<<delay<<"\n";
	return 0;
}
