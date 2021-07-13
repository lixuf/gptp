module tx(
input clk,
input reset,
//gptp
///�?
input [7:0] gptp_rd_addr,
output [79:0] gptp_rd_data,
//�?
input [7:0] gptp_wr_addr,
input [79:0] gptp_wr_data,//保持到ready有效
input gptp_wr_vaild,
output gptp_wr_ready,//当发送时间戳写入在有�?
output gptp_wr_vaild_ready,
//发�?�端
///�?
output gptp_ts_vaild,
input gptp_ts_ready,
output [351:0] gptp_ts_data,
///�?
input gptp_ts_rv_vaild,
input [79:0] gptp_ts_rv_data


);


//buffer�?
///�?
wire [7:0] send_addr;//抱持�? 直到send_r_vaild
wire  send_vaild;
wire  send_ready;
wire [79:0] send_data;//抱持�? 直到send_r_vaild
///�?
wire send_r_vaild;
wire [79:0] send_r_data;

tx_buffer buffer1(
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
.reset(reset),
.gptp_wr_vaild_ready(gptp_wr_vaild_ready)
);

tx_logic logic1(
.clk(clk),
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
.send_r_data(send_r_data)
);
endmodule
