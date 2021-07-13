`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/22 15:26:48
// Design Name: 
// Module Name: gptp_test_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module gptp_test_top(
input clk_s,
input clk_m,
input reset,
output [31:0] clk_n_m,
output [31:0] clk_s_m,
output [31:0] clk_e_m,
output [31:0] clk_n_s,
output [31:0] clk_s_s,
output [31:0] clk_e_s
);//0slave 1master

/////////////////////////////////////////////////slave/////////////////////////////////////////////////////////////////////////////////
//rtc采样
wire [31:0]                        rtc_nanosec_field_s;
wire [31:0]                        rtc_sec_field_s;
wire [15:0]                        rtc_epoch_field_s;
//rtc更新
wire  gptp_vaild_s;
wire rtc_ready_s;//鐩墠鎭掍负1
wire gptp_sw_s;
//鏇存柊鍙傛暟
wire [31:0] syntonised_nanosec_field_r_s;
wire [31:0] syntonised_sec_field_r_s;
wire [15:0] syntonised_epoch_field_r_s;

wire [29:0] nanosec_offset_s;//浣?30浣?
wire [31:0] sec_offset_s;//鍒濆鍊间竴瀹氳涓?0
wire [15:0] epoch_offset_s;

wire [25:0] rtc_increment_s;//鍒濆?间负鏈?灏忚嚜澧為噺

//tx send
///鍙?
wire gptp_ts_vaild_s;
wire gptp_ts_ready_s;
wire [351:0] gptp_ts_data_s;
///鏀?
wire gptp_ts_rv_vaild_s;
wire [79:0] gptp_ts_rv_data_s;

//rx rv
wire [431:0] gptp_rv_data_s;//鍓嶉潰鐨刦ifo涓?瀹氳淇濇寔杈撳嚭
wire gptp_rv_vaild_s;
wire gptp_rv_ready_s;//ready缃珮鍙鍏?
gptp_top #(1'b0) gptp_top1(
.clk(clk_s),
.reset(reset),
.rtc_nanosec_field(rtc_nanosec_field_s),
.rtc_sec_field(rtc_sec_field_s),
.rtc_epoch_field(rtc_epoch_field_s),
.gptp_vaild(gptp_vaild_s),
.rtc_ready(rtc_ready_s),
.gptp_sw(gptp_sw_s),
.syntonised_nanosec_field_r(syntonised_nanosec_field_r_s),
.syntonised_sec_field_r(syntonised_sec_field_r_s),
.syntonised_epoch_field_r(syntonised_epoch_field_r_s),
.nanosec_offset(nanosec_offset_s),
.sec_offset(sec_offset_s),
.epoch_offset(epoch_offset_s),
.rtc_increment(rtc_increment_s),
.gptp_ts_vaild(gptp_ts_vaild_s),
.gptp_ts_ready(gptp_ts_ready_s),
.gptp_ts_data(gptp_ts_data_s),
.gptp_ts_rv_vaild(gptp_ts_rv_vaild_s),
.gptp_ts_rv_data(gptp_ts_rv_data_s),
.gptp_rv_data(gptp_rv_data_s),
.gptp_rv_vaild(gptp_rv_vaild_s),
.gptp_rv_ready(gptp_rv_ready_s)
);
rtc rtc_s(
.rtc_reset(reset),
.rtc_clk(clk_s),
.rtc_nanosec_field(rtc_nanosec_field_s),
.rtc_sec_field(rtc_sec_field_s),
.rtc_epoch_field(rtc_epoch_field_s),
.syntonised_nanosec_field(syntonised_nanosec_field_s),
.syntonised_sec_field(syntonised_sec_field_s),
.syntonised_epoch_field(syntonised_epoch_field_s),
.syntonised_nanosec_field_r(syntonised_nanosec_field_r_s),
.syntonised_sec_field_r(syntonised_sec_field_r_s),
.syntonised_epoch_field_r(syntonised_epoch_field_r_s),
.nanosec_offset(nanosec_offset_s),
.sec_offset(sec_offset_s),
.epoch_offset(epoch_offset_s),
.rtc_increment(rtc_increment_s),
.gptp_vaild(gptp_vaild_s),
.rtc_ready(rtc_ready_s),
.gptp_sw(gptp_sw_s)
);

///////////////////////////////////////////////////////////////////////////////////master//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//rtc采样
wire [31:0]                        rtc_nanosec_field_m;
wire [31:0]                        rtc_sec_field_m;
wire [15:0]                        rtc_epoch_field_m;
//rtc更新
wire  gptp_vaild_m;
wire rtc_ready_m;//鐩墠鎭掍负1
wire gptp_sw_m;
//鏇存柊鍙傛暟
wire [31:0] syntonised_nanosec_field_r_m;
wire [31:0] syntonised_sec_field_r_m;
wire [15:0] syntonised_epoch_field_r_m;

wire [29:0] nanosec_offset_m;//浣?30浣?
wire [31:0] sec_offset_m;//鍒濆鍊间竴瀹氳涓?0
wire [15:0] epoch_offset_m;

wire [25:0] rtc_increment_m;//鍒濆?间负鏈?灏忚嚜澧為噺

//tx send
///鍙?
wire gptp_ts_vaild_m;
wire gptp_ts_ready_m;
wire [351:0] gptp_ts_data_m;
///鏀?
wire gptp_ts_rv_vaild_m;
wire [79:0] gptp_ts_rv_data_m;

//rx rv
wire [431:0] gptp_rv_data_m;//鍓嶉潰鐨刦ifo涓?瀹氳淇濇寔杈撳嚭
wire gptp_rv_vaild_m;
wire gptp_rv_ready_m;//ready缃珮鍙鍏?
gptp_top #(1'b1) gptp_top2(
.clk(clk_m),
.reset(reset),
.rtc_nanosec_field(rtc_nanosec_field_m),
.rtc_sec_field(rtc_sec_field_m),
.rtc_epoch_field(rtc_epoch_field_m),
.gptp_vaild(gptp_vaild_m),
.rtc_ready(rtc_ready_m),
.gptp_sw(gptp_sw_m),
.syntonised_nanosec_field_r(syntonised_nanosec_field_r_m),
.syntonised_sec_field_r(syntonised_sec_field_r_m),
.syntonised_epoch_field_r(syntonised_epoch_field_r_m),
.nanosec_offset(nanosec_offset_m),
.sec_offset(sec_offset_m),
.epoch_offset(epoch_offset_m),
.rtc_increment(rtc_increment_m),
.gptp_ts_vaild(gptp_ts_vaild_m),
.gptp_ts_ready(gptp_ts_ready_m),
.gptp_ts_data(gptp_ts_data_m),
.gptp_ts_rv_vaild(gptp_ts_rv_vaild_m),
.gptp_ts_rv_data(gptp_ts_rv_data_m),
.gptp_rv_data(gptp_rv_data_m),
.gptp_rv_vaild(gptp_rv_vaild_m),
.gptp_rv_ready(gptp_rv_ready_m)
);
rtc rtc_m(
.rtc_reset(reset),
.rtc_clk(clk_m),
.rtc_nanosec_field(rtc_nanosec_field_m),
.rtc_sec_field(rtc_sec_field_m),
.rtc_epoch_field(rtc_epoch_field_m),
.syntonised_nanosec_field(syntonised_nanosec_field_m),
.syntonised_sec_field(syntonised_sec_field_m),
.syntonised_epoch_field(syntonised_epoch_field_m),
.syntonised_nanosec_field_r(syntonised_nanosec_field_r_m),
.syntonised_sec_field_r(syntonised_sec_field_r_m),
.syntonised_epoch_field_r(syntonised_epoch_field_r_m),
.nanosec_offset(nanosec_offset_m),
.sec_offset(sec_offset_m),
.epoch_offset(epoch_offset_m),
.rtc_increment(rtc_increment_m),
.gptp_vaild(gptp_vaild_m),
.rtc_ready(rtc_ready_m),
.gptp_sw(gptp_sw_m)
);
//中间
///s-》m
rv2send_v2 rv2send_v11(
.clk_rv(clk_m),
.clk_sd(clk_s), 
.reset(reset),
.gptp_rv_data(gptp_rv_data_m),
.gptp_rv_vaild(gptp_rv_vaild_m),
.gptp_rv_ready(gptp_rv_ready_m),

.gptp_ts_vaild(gptp_ts_vaild_s),
.gptp_ts_ready(gptp_ts_ready_s),
.gptp_ts_data(gptp_ts_data_s),
.gptp_ts_rv_vaild(gptp_ts_rv_vaild_s),
.gptp_ts_rv_data(gptp_ts_rv_data_s),

.rtc_nanosec_field_rv(rtc_nanosec_field_m),
.rtc_sec_field_rv(rtc_sec_field_m),
.rtc_epoch_field_rv(rtc_epoch_field_m),
.rtc_nanosec_field_sd(rtc_nanosec_field_s),
.rtc_sec_field_sd(rtc_sec_field_s),
.rtc_epoch_field_sd(rtc_epoch_field_s)
);
///m-》s
rv2send_v2 rv2send_v12(
.clk_rv(clk_s),
.clk_sd(clk_m),
.reset(reset),
.gptp_rv_data(gptp_rv_data_s),
.gptp_rv_vaild(gptp_rv_vaild_s),
.gptp_rv_ready(gptp_rv_ready_s),

.gptp_ts_vaild(gptp_ts_vaild_m),
.gptp_ts_ready(gptp_ts_ready_m),
.gptp_ts_data(gptp_ts_data_m),
.gptp_ts_rv_vaild(gptp_ts_rv_vaild_m),
.gptp_ts_rv_data(gptp_ts_rv_data_m),

.rtc_nanosec_field_rv(rtc_nanosec_field_s),
.rtc_sec_field_rv(rtc_sec_field_s),
.rtc_epoch_field_rv(rtc_epoch_field_s),
.rtc_nanosec_field_sd(rtc_nanosec_field_m),
.rtc_sec_field_sd(rtc_sec_field_m),
.rtc_epoch_field_sd(rtc_epoch_field_m)
);


assign clk_n_m=rtc_nanosec_field_m;
assign clk_s_m=rtc_sec_field_m;
assign clk_e_m={16'b0,rtc_epoch_field_m};
assign clk_n_s=rtc_nanosec_field_s;
assign clk_s_s=rtc_sec_field_s;
assign clk_e_s={16'b0,rtc_epoch_field_s};
endmodule
