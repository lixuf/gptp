module rx(
input clk,
input reset,//高有�?

//接收模块
input [431:0] gptp_rv_data,//前面的fifo�?定要保持输出
input gptp_rv_vaild,
output gptp_rv_ready,//ready置高可读�?



//gptp读数�?
output [7:0] rx_gptp_rd_vaild,
output [79:0] rx_gptp_rd_data,
input [7:0] rx_gptp_rd_addr,
input rx_gptp_rd_ready//pdelay_resp要用两个数据位置 要ready两次

);

wire rx_rev_wr_ready;//ready置高表示可以读下�?个数�?
wire rx_rev_wr_vaild;//存帧，严格置�?1clk
wire rx_rev_wr_v_ready;//有效表示可接收rx_rev_wr_vaild
wire [7:0] rx_rev_wr_addr; //指明帧类�?
wire [79:0] rx_rev_wr_data1;//pdelay_resp要用两个数据位置  //j接收时间�?
wire [79:0] rx_rev_wr_data2; //帧携带的时间�?

rx_buffer buffer11(
.clk(clk),
.reset(reset),
.rx_gptp_rd_vaild(rx_gptp_rd_vaild),
.rx_gptp_rd_data(rx_gptp_rd_data),
.rx_gptp_rd_addr(rx_gptp_rd_addr),
.rx_gptp_rd_ready(rx_gptp_rd_ready),


.rx_rev_wr_ready(rx_rev_wr_ready),
.rx_rev_wr_vaild(rx_rev_wr_vaild),
.rx_rev_wr_v_ready(rx_rev_wr_v_ready),
.rx_rev_wr_addr(rx_rev_wr_addr),
.rx_rev_wr_data1(rx_rev_wr_data1),
.rx_rev_wr_data2(rx_rev_wr_data2)
);

rx_logic logic11(
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
