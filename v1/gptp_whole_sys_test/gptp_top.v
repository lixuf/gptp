`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/22 15:12:09
// Design Name: 
// Module Name: gptp_top
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


module gptp_top#
(
  parameter         position            = 1'b1//0slave 1master
)(
input clk,
input reset,

//rtc����
input [31:0]                        rtc_nanosec_field,
input [31:0]                        rtc_sec_field,
input [15:0]                        rtc_epoch_field,
//rtc����
output gptp_vaild,
input rtc_ready,//目前恒为1
output gptp_sw,
//更新参数
output [31:0] syntonised_nanosec_field_r,
output [31:0] syntonised_sec_field_r,
output [15:0] syntonised_epoch_field_r,

output [29:0] nanosec_offset,//�?30�?
output [31:0] sec_offset,//初始值一定要�?0
output [15:0] epoch_offset,

output [25:0] rtc_increment,//初�?�为�?小自增量

//tx send
///�?
output gptp_ts_vaild,
input gptp_ts_ready,
output [351:0] gptp_ts_data,
///�?
input gptp_ts_rv_vaild,
input [79:0] gptp_ts_rv_data,

//rx rv
input [431:0] gptp_rv_data,//前面的fifo�?定要保持输出
input gptp_rv_vaild,
output gptp_rv_ready//ready置高可读�?
);
 


  
//rx �?
wire [7:0] rx_gptp_rd_vaild;//指明接收到何种帧
wire [79:0] rx_gptp_rd_data;
wire  [7:0] rx_gptp_rd_addr;//读地�?
wire  rx_gptp_rd_ready; //读使�? ，给出使能下�?个clk读到数据


//tx �?
wire [79:0] gptp_rd_data;
wire  [7:0]gptp_rd_addr;//读都是统�?给出地址后的�?个clk�?

//tx �?
wire  [7:0] gptp_wr_addr;
wire  [79:0] gptp_wr_data;
wire  gptp_wr_vaild;
wire gptp_wr_ready;//表明当前帧发送出去了
wire gptp_wr_vaild_ready;

gptp2 #(position) gptp1 
(
.clk(clk),
.reset(reset),
.gptp_vaild(gptp_vaild),
.rtc_ready(rtc_ready),
.gptp_sw(gptp_sw),
.syntonised_nanosec_field_r(syntonised_nanosec_field_r),
.syntonised_sec_field_r(syntonised_sec_field_r),
.syntonised_epoch_field_r(syntonised_epoch_field_r),
.nanosec_offset(nanosec_offset),
.sec_offset(sec_offset),
.epoch_offset(epoch_offset),
.rtc_increment(rtc_increment),
.rtc_nanosec_field(rtc_nanosec_field),
.rtc_sec_field(rtc_sec_field),
.rtc_epoch_field(rtc_epoch_field),
.rx_gptp_rd_vaild(rx_gptp_rd_vaild),
.rx_gptp_rd_data(rx_gptp_rd_data),
.rx_gptp_rd_addr(rx_gptp_rd_addr),
.rx_gptp_rd_ready(rx_gptp_rd_ready),
.gptp_rd_data(gptp_rd_data),
.gptp_rd_addr(gptp_rd_addr),
.gptp_wr_addr(gptp_wr_addr),
.gptp_wr_data(gptp_wr_data),
.gptp_wr_vaild(gptp_wr_vaild),
.gptp_wr_ready(gptp_wr_ready),
.gptp_wr_vaild_ready(gptp_wr_vaild_ready)
);


tx tx1(
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

rx rx1(
.clk(clk),
.reset(reset),
.gptp_rv_data(gptp_rv_data),
.gptp_rv_vaild(gptp_rv_vaild),
.gptp_rv_ready(gptp_rv_ready),
.rx_gptp_rd_vaild(rx_gptp_rd_vaild),
.rx_gptp_rd_data(rx_gptp_rd_data),
.rx_gptp_rd_addr(rx_gptp_rd_addr),
.rx_gptp_rd_ready(rx_gptp_rd_ready)
);
endmodule
