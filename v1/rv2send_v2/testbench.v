`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/22 14:24:24
// Design Name: 
// Module Name: testbench
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


module testbench;
reg clk;
initial clk<=1'b0;
always #4 clk<=~clk;

reg reset;
initial begin
reset<=1'b1;
#5
reset<=1'b0;
#8
reset<=1'b1;
end



wire [431:0] gptp_rv_data;//前面的fifo�?定要保持输出
wire gptp_rv_vaild;
reg gptp_rv_ready;//ready置高可读�?

//send
reg gptp_ts_vaild;
wire gptp_ts_ready;
reg [351:0] gptp_ts_data;
//��дʱ���
wire  gptp_ts_rv_vaild;
wire  [79:0] gptp_ts_rv_data;

//rtc rv
reg [31:0]                        rtc_nanosec_field_rv;
reg [31:0]                        rtc_sec_field_rv;
reg [15:0]                        rtc_epoch_field_rv;

//rtc send
reg [31:0]                        rtc_nanosec_field_sd;
reg [31:0]                        rtc_sec_field_sd;
reg [15:0]                        rtc_epoch_field_sd;

reg [4:0] sd_state;
initial begin
gptp_rv_ready<='b1;
gptp_ts_vaild<='b0;
gptp_ts_data<='b0;
rtc_nanosec_field_rv<='b0;
rtc_sec_field_rv<='b0;
rtc_epoch_field_rv<='b0;
rtc_nanosec_field_sd<='b0;
rtc_sec_field_sd<='b0;
rtc_epoch_field_sd<='b0;
sd_state<=5'b0;
end


always@(posedge clk)
begin
 
 case(sd_state)
  5'b0:begin
   if(gptp_ts_ready) begin
    gptp_ts_vaild<=1'b1;
    sd_state<=5'd1;
    gptp_ts_data<=gptp_ts_data+'b1;
   end
  end
  
  5'd1:begin
    gptp_ts_vaild<=1'b0;
    sd_state<=5'd0;
  end
 endcase
end


always@(posedge clk)
begin
 rtc_sec_field_sd<=rtc_sec_field_sd+'b1;
 rtc_epoch_field_sd<=rtc_epoch_field_sd+'b1;
 rtc_nanosec_field_sd<=rtc_nanosec_field_sd+'b1;
end

 rv2send_v2  rv2send_v11(
.clk_rv(clk),
.clk_sd(clk),

. reset(reset),//低有�?

//rv
. gptp_rv_data(gptp_rv_data),//前面的fifo�?定要保持输出
.  gptp_rv_vaild(gptp_rv_vaild),
. gptp_rv_ready(gptp_rv_ready),//ready置高可读�?

//send
. gptp_ts_vaild(gptp_ts_vaild),
. gptp_ts_ready(gptp_ts_ready),
.gptp_ts_data(gptp_ts_data),
//��дʱ���
.gptp_ts_rv_vaild(gptp_ts_rv_vaild),
.  gptp_ts_rv_data(gptp_ts_rv_data),

//rtc rv
.                     rtc_nanosec_field_rv(rtc_nanosec_field_sd),
.                   rtc_sec_field_rv( rtc_sec_field_sd),
.               rtc_epoch_field_rv( rtc_epoch_field_sd),

//rtc send
.   rtc_nanosec_field_sd(rtc_nanosec_field_sd),
.   rtc_sec_field_sd(rtc_sec_field_sd),
. rtc_epoch_field_sd(rtc_epoch_field_sd)
);


endmodule
