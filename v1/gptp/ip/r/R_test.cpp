

#include "R.h"

using namespace std;


int main()
{
	ap_uint<32> t1=1, t2=5, t3=6, t4=16;
	ap_uint<6> in=8,out1;
	ap_uint<20> out2;
//	cin >> t1 >> t2 >> t3 >> t4 >> in;

	ap_fixed<12,4> r = R(19955,19954,18885,18884,t1, t2, t3, t4, in, &out1,&out2);
	cout << r << "\n" << out1<<"\n"<<out2<<endl;
//	system("pause");
	return 0;
}
