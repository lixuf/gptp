`timescale 1ns/1ps

module rx_tb;

parameter ClockPeriod = 8;

reg clk;
reg reset;

initial begin
	clk <= 1'b0;
	reset <= 1'b0;
	#10
	reset <= 1'b1;
	#10
	reset <= 1'b0;
end

always #(ClockPeriod/2) clk <= ~clk;

//接收模块
reg [431:0] gptp_rv_data;//前面的fifo一定要保持输出
reg gptp_rv_vaild;
wire gptp_rv_ready;//ready置高可读入

//gptp读数据
wire [7:0] rx_gptp_rd_vaild;
wire [79:0] rx_gptp_rd_data;
reg [7:0] rx_gptp_rd_addr;
reg rx_gptp_rd_ready;//pdelay_resp要用两个数据位置 要ready两次	

reg [3:0]  messagetype1=4'h2;
reg [3:0]  messagetype2=4'h3;
reg [79:0] t1 = 80'h123456789abc00000001;
reg [79:0] t2 = 80'h123456789abc00000002;
reg [79:0] t3 = 80'h123456789abc00000010;
reg [79:0] t4 = 80'h123456789abc00000020;

initial begin
	#100
	gptp_rv_vaild <= 1'b1;
	gptp_rv_data[431:0] <= {t2,{268{1'b0}},messagetype1,t1};
	#100
	rx_gptp_rd_addr[7:0] <= 8'd4;
	rx_gptp_rd_ready <= 1;
	#8
	gptp_rv_vaild <= 1'b0;
	rx_gptp_rd_ready <= 0;
	#100
	gptp_rv_vaild <= 1'b1;
	gptp_rv_data[431:0] <= {t4,{268{1'b0}},messagetype2,t3};
	#100
	rx_gptp_rd_addr[7:0] <= 8'b0000_1000;
	rx_gptp_rd_ready <= 1;
	#8
	gptp_rv_vaild <= 1'b0;
	rx_gptp_rd_ready <= 0;
	#16
	rx_gptp_rd_addr[7:0] <= 8'b1000_0000;
	rx_gptp_rd_ready <= 1;
	#8
	gptp_rv_vaild <= 1'b0;
	rx_gptp_rd_ready <= 0;
	
end

rx DUT(
	.clk(clk),
	.reset(reset),//高有效

	//接收模块
	.gptp_rv_data(gptp_rv_data),//前面的fifo一定要保持输出
	.gptp_rv_vaild(gptp_rv_vaild),
	.gptp_rv_ready(gptp_rv_ready),//ready置高可读入
	
	
	
	//gptp读数据
	.rx_gptp_rd_vaild(rx_gptp_rd_vaild),
	.rx_gptp_rd_data(rx_gptp_rd_data),
	.rx_gptp_rd_addr(rx_gptp_rd_addr),
	.rx_gptp_rd_ready(rx_gptp_rd_ready)//pdelay_resp要用两个数据位置 要ready两次
);

endmodule