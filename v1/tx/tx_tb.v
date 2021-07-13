`timescale 1ns/1ps

module tx_tb;

reg clk;
initial clk<=0;
always #1 clk<=~clk;
reg reset;
initial begin
	reset<=1;
	#3
	reset<=0;
	#2
	reset<=1;
end

//gptp
///读
reg [7:0] gptp_rd_addr;
wire [79:0] gptp_rd_data;
//写
reg [7:0] gptp_wr_addr;
reg [79:0] gptp_wr_data;//保持到ready有效
reg gptp_wr_vaild;
wire gptp_wr_ready;//当发送时间戳写入在有效
wire gptp_wr_vaild_ready;
//发送端
///发
wire gptp_ts_vaild;
reg gptp_ts_ready;
wire [351:0] gptp_ts_data;
///收
reg gptp_ts_rv_vaild;
reg [79:0] gptp_ts_rv_data;

initial begin
	clk<=0;
	gptp_rd_addr<=0;
	gptp_wr_addr<=0;
	gptp_wr_data<=0;
	gptp_wr_vaild<=0;
	gptp_ts_ready<=0;
	gptp_ts_rv_vaild<=0;
	gptp_ts_rv_data<=0;
	#3
	gptp_wr_vaild <= 1;
	gptp_wr_data[79:0] <= 80'h123456789abc00000001;
	gptp_wr_addr[7:0] <= 8'd1;
	#3
	gptp_ts_ready <= 1;
	#3
	gptp_ts_rv_vaild <= 1;
	gptp_ts_rv_data[79:0] <= 80'h123456789abc00000020;
	#3
	gptp_rd_addr <= 8'd1;
end

tx DUT(
	.clk(clk),
	.reset(reset),
	.gptp_rd_addr(gptp_rd_addr),
	.gptp_rd_data(gptp_rd_data),
	.gptp_wr_addr(gptp_wr_addr),
	.gptp_wr_data(gptp_wr_data),
	.gptp_wr_vaild(gptp_wr_vaild),
	.gptp_wr_ready(gptp_wr_ready),
	.gptp_wr_vaild_ready(gptp_wr_vaild_ready),
	.gptp_ts_vaild(gptp_ts_vaild),
	.gptp_ts_ready(gptp_ts_ready),
	.gptp_ts_data(gptp_ts_data),
	.gptp_ts_rv_vaild(gptp_ts_rv_vaild),
	.gptp_ts_rv_data(gptp_ts_rv_data)
	);
	
endmodule