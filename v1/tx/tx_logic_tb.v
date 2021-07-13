`timescale 1ns/1ps

module logic_tb;

wire gptp_ts_vaild;
reg gptp_ts_ready;
wire [351:0] gptp_ts_data;
///收
reg gptp_ts_rv_vaild;
reg [79:0] gptp_ts_rv_data;


//buffer侧
///读
reg [7:0] send_addr;//抱持住 直到send_r_vaild
reg send_vaild;
wire send_ready;
reg [79:0] send_data;//抱持住 直到send_r_vaild
///写
wire send_r_vaild;
wire [79:0] send_r_data;
reg clk;

initial clk<=0;
always #1 clk<=~clk;
reg reset;

initial begin
	reset<=1;
	#1
	reset<=0;
	#1
	reset<=1;
end
initial begin
	gptp_ts_ready <= 0;
	gptp_ts_rv_vaild <= 0;
	gptp_ts_rv_data <= 0;
	send_addr <= 0;
	send_vaild <= 0;
	send_data <= 0;
	#5
	send_addr <= 8'd1;
	send_vaild <= 1;
	send_data[79:0] <= 80'h123456789abc00000010;
	#1
	gptp_ts_ready <= 1;
	#2
	gptp_ts_rv_vaild <= 1;
	gptp_ts_rv_data[79:0] <= 80'h123456789abc00000020;
end

logic DUT(
	.reset(reset),
	.gptp_ts_vaild(gptp_ts_vaild),
	.gptp_ts_ready(gptp_ts_ready),
	.gptp_ts_data(gptp_ts_data),
	.gptp_ts_rv_vaild(gptp_ts_rv_vaild),
	.gptp_ts_rv_data(gptp_ts_rv_data),
	.send_addr(send_addr),
	.send_vaild(send_vaild),
	.send_ready(send_ready),
	.send_data(send_data),
	.send_r_vaild(send_r_vaild),
	.send_r_data(send_r_data),
	.clk(clk)
);

endmodule