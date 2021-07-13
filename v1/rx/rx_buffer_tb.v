`timescale 1ns/1ps

module buffer_test;

parameter ClockPeriod = 8;

reg clk;
reg reset;

initial begin
	clk <= 1'b0;
	reset <= 1'b0;
	#10
	reset <= 1'b1;
	#10
	reset <= 1'b0;
end

always #(ClockPeriod/2) clk <= ~clk;

//gptp读数据
wire [7:0] rx_gptp_rd_vaild;
wire [79:0] rx_gptp_rd_data;
reg [7:0] rx_gptp_rd_addr;
reg rx_gptp_rd_ready;//pdelay_resp要用两个数据位置 要ready两次

//logic写入
wire rx_rev_wr_ready;//ready置高表示可以读下一个数据
reg rx_rev_wr_vaild;//存帧，严格置高1clk
wire rx_rev_wr_v_ready;//有效表示可接收rx_rev_wr_vaild
reg [7:0] rx_rev_wr_addr; //指明帧类型
reg [79:0] rx_rev_wr_data1;//pdelay_resp要用两个数据位置  //j接收时间戳
reg [79:0] rx_rev_wr_data2;//帧携带的时间戳

initial begin
	rx_rev_wr_vaild <= 0;
	rx_rev_wr_addr[7:0] <= 8'h00;
	rx_rev_wr_data1[79:0] <= 80'h0;
	rx_rev_wr_data2[79:0] <= 80'h0;
	#50
	rx_rev_wr_vaild <= 1;
	rx_rev_wr_addr[7:0] <= 8'h01;
	rx_rev_wr_data1[79:0] <= 80'h123456789abc00000001;
	rx_rev_wr_data2[79:0] <= 80'h123456789abc00000002;
	#8
	rx_rev_wr_vaild <= 0;
	#20
	rx_rev_wr_vaild <= 1;
	rx_rev_wr_addr[7:0] <= 8'h02;
	rx_rev_wr_data1[79:0] <= 80'h123456789abc00000010;
	rx_rev_wr_data2[79:0] <= 80'h123456789abc00000020;
	#8
	rx_rev_wr_vaild <= 0;
	#20
	rx_rev_wr_vaild <= 1;
	rx_rev_wr_addr[7:0] <= 8'h04;
	rx_rev_wr_data1[79:0] <= 80'h123456789abc00000100;
	rx_rev_wr_data2[79:0] <= 80'h123456789abc00000200;
	#8
	rx_rev_wr_vaild <= 0;
	#20
	rx_rev_wr_vaild <= 1;
	rx_rev_wr_addr[7:0] <= 8'h08;
	rx_rev_wr_data1[79:0] <= 80'h123456789abc00001000;
	rx_rev_wr_data2[79:0] <= 80'h123456789abc00002000;
	#8
	rx_rev_wr_vaild <= 0;
	#20
	rx_rev_wr_vaild <= 1;
	rx_rev_wr_addr[7:0] <= 8'h10;
	rx_rev_wr_data1[79:0] <= 80'h123456789abc00010000;
	rx_rev_wr_data2[79:0] <= 80'h123456789abc00020000;
	#8
	rx_rev_wr_vaild <= 0;
	#10
	rx_rev_wr_vaild <= 1;
	rx_rev_wr_addr[7:0] <= 8'h20;
	rx_rev_wr_data1[79:0] <= 80'h123456789abc00100000;
	rx_rev_wr_data2[79:0] <= 80'h123456789abc00200000;
	#8
	rx_rev_wr_vaild <= 0;
	#20
	rx_rev_wr_vaild <= 1;
	rx_rev_wr_addr[7:0] <= 8'h40;
	rx_rev_wr_data1[79:0] <= 80'h123456789abc01000000;
	rx_rev_wr_data2[79:0] <= 80'h123456789abc02000000;
	#8
	rx_rev_wr_vaild <= 0;
	#20
	rx_rev_wr_vaild <= 1;
	rx_rev_wr_addr[7:0] <= 8'h80;
	rx_rev_wr_data1[79:0] <= 80'h123456789abc10000000;
	rx_rev_wr_data2[79:0] <= 80'h123456789abc20000000;
	#8
	rx_rev_wr_vaild <= 0;
	
end

initial begin
	rx_gptp_rd_ready <= 0;
	rx_gptp_rd_addr[7:0] <= 8'h0;
	#79
	rx_gptp_rd_addr[7:0] <= 8'h01;
	rx_gptp_rd_ready <= 1;
	#8
	rx_gptp_rd_ready <= 0;
	#100
	rx_gptp_rd_ready <= 1;
	rx_gptp_rd_addr[7:0] <= 8'h02;
	#8
	rx_gptp_rd_ready <= 0;
	#100
	rx_gptp_rd_ready <= 1;
	rx_gptp_rd_addr[7:0] <= 8'h04;
	#8
	rx_gptp_rd_ready <= 0;
	#100
	rx_gptp_rd_ready <= 1;
	rx_gptp_rd_addr[7:0] <= 8'h08;
	#8
	rx_gptp_rd_ready <= 0;
	#100
	rx_gptp_rd_ready <= 1;
	rx_gptp_rd_addr[7:0] <= 8'h10;
	#8
	rx_gptp_rd_ready <= 0;
	#100
	rx_gptp_rd_ready <= 1;
	rx_gptp_rd_addr[7:0] <= 8'h20;
	#8
	rx_gptp_rd_ready <= 0;
	#100
	rx_gptp_rd_ready <= 1;
	rx_gptp_rd_addr[7:0] <= 8'h40;
	#8
	rx_gptp_rd_ready <= 0;
	#100
	rx_gptp_rd_ready <= 1;
	rx_gptp_rd_addr[7:0] <= 8'h80;
	#8
	rx_gptp_rd_ready <= 0;
	#100
	$finish;
	
end

/* reg state;

initial state <= 0;

always @(posedge clk) begin
case(state)
	1'b0: begin
		rx_rev_wr_vaild <= 1'b1;
		rx_rev_wr_addr[7:0] <= 8'h01;
		rx_rev_wr_data1[79:0] <= 80'h123456789abc00000001;
		rx_rev_wr_data2[79:0] <= 80'h123456789abc00000002;
		#ClockPeriod
		rx_rev_wr_vaild <= 1'b0;
		if(rx_rev_wr_ready) begin
			state <= 1;
		end
	end
	1'b1: begin
		rx_gptp_rd_ready <= 1;
		rx_gptp_rd_addr[7:0] <= 8'h01;
	end
	
endcase
end */


buffer DUT(
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


endmodule