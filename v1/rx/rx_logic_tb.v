`timescale 1ns/1ps

module logic_tb;

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

reg [431:0] gptp_rv_data;//前面的fifo一定要保持输出
reg gptp_rv_vaild;
wire gptp_rv_ready;//ready置高可读入

reg rx_rev_wr_ready; //ready置高表示可以读下一个数据
wire rx_rev_wr_vaild; //存帧，严格置高1clk
reg rx_rev_wr_v_ready;
wire [7:0] rx_rev_wr_addr; //指明帧类型
wire [79:0] rx_rev_wr_data1; //pdelay_resp要用两个数据位置 //j接收时间戳
wire [79:0] rx_rev_wr_data2; //帧携带的时间戳


reg [3:0]  messagetype=4'h3;
reg [79:0] t1 = 80'h123456789abc00000001;
reg [79:0] t2 = 80'h123456789abc00000002;

initial begin
	gptp_rv_vaild <= 1'b1;
	gptp_rv_data[431:0] <= {t2,{268{1'b0}},messagetype,t1};
	rx_rev_wr_ready <= 1'b1;
	rx_rev_wr_v_ready <= 1'b1;
end

logic DUT(
	.clk(clk),
	.reset(reset),
	.gptp_rv_data(gptp_rv_data),
	.gptp_rv_vaild(gptp_rv_vaild),
	.gptp_rv_ready(gptp_rv_ready),
	.rx_rev_wr_ready(rx_rev_wr_ready),
	.rx_rev_wr_vaild(rx_rev_wr_vaild),
	.rx_rev_wr_v_ready(rx_rev_wr_v_ready),
	.rx_rev_wr_addr(rx_rev_wr_addr),
	.rx_rev_wr_data1(rx_rev_wr_data1),
	.rx_rev_wr_data2(rx_rev_wr_data2)
);

endmodule