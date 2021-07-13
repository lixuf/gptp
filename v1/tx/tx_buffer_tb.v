`timescale 1ns/1ps

module buffer_test;

parameter ClockPeriod = 8;

reg clk;
reg reset;

initial begin
	clk <= 1'b0;
	reset <= 1'b1;
	#10
	reset <= 1'b0;
	#10
	reset <= 1'b1;
end

always #(ClockPeriod/2) clk <= ~clk;

//logic
///发送
wire [7:0] send_addr;
wire send_vaild;
reg send_ready;
wire [79:0] send_data;
///接收
reg send_r_vaild;
reg [79:0] send_r_data;
//gptp
///读
reg [7:0] gptp_rd_addr;
wire [79:0] gptp_rd_data;
//写
reg [7:0] gptp_wr_addr;
reg [79:0] gptp_wr_data;//保持到ready有效
reg gptp_wr_vaild;
wire gptp_wr_ready;//当发送时间戳写入在有效

initial begin
	send_ready <= 0;
	send_r_vaild <= 0;
	send_r_data <= 0;
	gptp_wr_vaild <= 0;
	gptp_rd_addr <= 0;
	gptp_wr_addr <= 0;
	gptp_wr_data <= 0;
	#100
	gptp_wr_vaild <= 1;
	gptp_wr_data[79:0] <= 80'h123456789abc00000001;
	gptp_wr_addr[7:0] <= 8'd1;
	#8
	gptp_wr_vaild <= 0;
	#20
	send_ready <= 1;
	#10
	send_r_vaild <= 1;
	send_r_data[79:0] <= 80'h123456789abc00000002;
	#10
	gptp_rd_addr <= 8'd1;
end

buffer DUT(

	.send_addr(send_addr),
	.send_vaild(send_vaild),
	.send_ready(send_ready),
	.send_data(send_data),
	.send_r_vaild(send_r_vaild),
	.send_r_data(send_r_data),
	.gptp_rd_addr(gptp_rd_addr),
	.gptp_rd_data(gptp_rd_data),
	.gptp_wr_addr(gptp_wr_addr),
	.gptp_wr_data(gptp_wr_data),
	.gptp_wr_vaild(gptp_wr_vaild),
	.gptp_wr_ready(gptp_wr_ready),
	.clk(clk),
	.reset(reset)
);

endmodule
