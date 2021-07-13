`timescale 1ns/1ps
module rtc_tb;

reg rtc_clk;
reg rtc_reset;

initial begin
	rtc_clk   <= 1'b0;
	rtc_reset <= 1'b0;
	#2
	rtc_reset <= 1'b1;
	#10
	rtc_reset <= 1'b0;
end

always #4 rtc_clk <= ~rtc_clk;

wire [31:0]                        rtc_nanosec_field;
wire [31:0]                        rtc_sec_field;
wire [15:0]                        rtc_epoch_field;

  //基本时钟
wire [31:0]                        syntonised_nanosec_field;
wire [31:0]                        syntonised_sec_field;
wire [15:0]                        syntonised_epoch_field;

reg [31:0] syntonised_nanosec_field_r;
reg [31:0] syntonised_sec_field_r;
reg [15:0] syntonised_epoch_field_r;
reg [29:0] nanosec_offset;
reg [31:0] sec_offset; //初始值一定要为0
reg [15:0] epoch_offset;

reg [25:0] rtc_increment; //初值为最小自增量
reg        gptp_vaild; //RTC更新参数使能  0表示要修改基本时钟
wire       rtc_ready;

reg        gptp_sw; //1更新offset 0更新基本时钟 vaild的同时给出

initial begin
	#100
	gptp_vaild    <= 0;
	nanosec_offset[29:0] <= 30'b0;	
	sec_offset[31:0] <= 32'b0;	
	epoch_offset[15:0] <= 16'b0;
	rtc_increment <= 26'h0800000;
	#100
	gptp_vaild <= 1;
	gptp_sw <= 0;
	syntonised_nanosec_field_r[31:0] <= 32'b0;
	syntonised_sec_field_r[31:0] <= 32'b0;
	syntonised_epoch_field_r[15:0] <= 16'b0;
	#8
	gptp_vaild <= 0;
	gptp_sw <= 1;
	#100
	gptp_vaild <= 1;
	gptp_sw <= 0;
	syntonised_nanosec_field_r[31:0] <= 32'h00000008;
	#8
	gptp_vaild <= 0;
	gptp_sw <= 1;
	#30
	gptp_vaild <= 1;
	gptp_sw <= 0;
	syntonised_nanosec_field_r[31:0] <= 32'h00000000;
	syntonised_sec_field_r[31:0] <= 32'h00000008;
	#8
	gptp_vaild <= 0;
	gptp_sw <= 1;
	#30
	gptp_vaild <= 1;
	gptp_sw <= 0;
	syntonised_nanosec_field_r[31:0] <= 32'h00000000;
	syntonised_sec_field_r[31:0] <= 32'h00000000;
	syntonised_epoch_field_r[15:0] <= 16'h0001;
	#8
	gptp_vaild <= 0;
	gptp_sw <= 1;
	#1000	
	rtc_increment <= 26'h090000;
	#20;
	rtc_increment <= 26'h0700000;
	#20
	rtc_increment <= 26'h0800000;
	#100
	gptp_vaild <= 1;
	gptp_sw <= 1;
	nanosec_offset[29:0] <= 30'h0000000a;
	#40
	nanosec_offset[29:0] <= 30'b0;
	sec_offset[31:0] <= 32'h0000000f;
	#40
	nanosec_offset[29:0] <= 30'b0;
	sec_offset[31:0] <= 32'b0;
	epoch_offset[15:0]   <= 16'h0002;
	#100
	gptp_vaild <= 0;
	rtc_increment <= 26'h0800000;
	#10000
	$finish;
		
end

rtc DUT(
	.rtc_reset(rtc_reset),
	.rtc_clk(rtc_clk),
	.rtc_nanosec_field(rtc_nanosec_field),
	.rtc_sec_field(rtc_sec_field),
	.rtc_epoch_field(rtc_epoch_field),

	.syntonised_nanosec_field(syntonised_nanosec_field),
	.syntonised_sec_field(syntonised_sec_field),
	.syntonised_epoch_field(syntonised_epoch_field),
	
	.syntonised_nanosec_field_r(syntonised_nanosec_field_r),
	.syntonised_sec_field_r(syntonised_sec_field_r),
	.syntonised_epoch_field_r(syntonised_epoch_field_r),	
	
	.nanosec_offset(nanosec_offset),
	.epoch_offset(epoch_offset),
	.sec_offset(sec_offset),
	.rtc_increment(rtc_increment),
	.gptp_vaild(gptp_vaild),
	.rtc_ready(rtc_ready),
	.gptp_sw(gptp_sw)
);

endmodule