module dec_frame(
input [431:0] gptp_rv_data,

output [7:0] rx_rev_wr_addr,//指明帧类型
output [79:0] rx_rev_wr_data1,//接收时间戳
output [79:0] rx_rev_wr_data2//帧携带的时间戳
);

assign rx_rev_wr_data1=gptp_rv_data[79:0];
assign rx_rev_wr_data2=gptp_rv_data[431:352];
wire [3:0] massagetype=gptp_rv_data[83:80];
wire massage_is_sync=(massagetype==4'h0);
wire massage_is_preq=(massagetype==4'h2);
wire massage_is_presp=(massagetype==4'h3);
wire massage_is_fu=(massagetype==4'h8);
wire massage_is_pfu=(massagetype==4'ha);
assign rx_rev_wr_addr=({8{massage_is_sync}}&8'd1)
							|({8{massage_is_preq}}&8'd4)
							|({8{massage_is_presp}}&8'b1000_1000)
							|({8{massage_is_fu}}&8'd2)
							|({8{massage_is_pfu}}&8'd16)
							;


endmodule
