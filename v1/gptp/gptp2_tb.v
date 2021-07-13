`timescale 1ns/1ps

module gptp2_tb;

reg clk;
reg reset;//高电平有�?

//rtc
wire gptp_vaild;
reg rtc_ready;//目前恒为1
wire gptp_sw;
//更新参数
wire [31:0] syntonised_nanosec_field_r;
wire [31:0] syntonised_sec_field_r;
wire [15:0] syntonised_epoch_field_r;

wire [29:0] nanosec_offset;//�?30�?
wire [31:0] sec_offset;//初始值一定要�?0
wire [15:0] epoch_offset;

wire [25:0] rtc_increment;//初�?�为�?小自增量
//rtc 采样
reg [31:0]  rtc_nanosec_field;
reg [31:0]  rtc_sec_field;
reg [15:0]  rtc_epoch_field;
  
//rx �?
reg [7:0] rx_gptp_rd_vaild;//指明接收到何种帧
reg [79:0] rx_gptp_rd_data;
wire [7:0] rx_gptp_rd_addr;//读地�?
wire rx_gptp_rd_ready; //读使�? ，给出使能下�?个clk读到数据
reg gptp_wr_vaild_ready;


//tx �?
reg [79:0] gptp_rd_data;
wire [7:0] gptp_rd_addr;//读都是统�?给出地址后的�?个clk�?

//tx �?
wire [7:0] gptp_wr_addr;
wire [79:0] gptp_wr_data;
wire gptp_wr_vaild;
reg gptp_wr_ready;//表明当前帧发送出去了

initial clk<=0;
always #1 clk<=~clk;

initial begin
rtc_nanosec_field<=5;
rtc_sec_field<=1;
rtc_epoch_field<=0;
	reset<=1;
	#1
	reset<=0;
	#1
	reset<=1;
end

initial begin

	rtc_ready<=0;
	rx_gptp_rd_vaild<=8'hff;
	rx_gptp_rd_data<=0;
	gptp_rd_data<=0;
	gptp_wr_ready<=0;
	gptp_wr_vaild_ready<=0;

end

reg [4:0] state;
reg [31:0] cnt;
wire [31:0] cnt_max='d15;
initial state<=5'b0;
always @(posedge clk) begin
 case(state)
	5'd0:begin
	gptp_wr_vaild_ready<=1;
	cnt<=0;
	if(gptp_wr_vaild) begin
	state<=5'd1;
	end
	end
	
	5'd1:begin
	gptp_wr_vaild_ready<=0;
	gptp_rd_data<=80'habababaa;
	if(cnt==cnt_max) begin
	state<=5'd2;
	end
	else begin
	cnt<=cnt+1;
	end
	end
	
	5'd2:begin
	cnt<=0;
	gptp_wr_ready<=1'b1;
	state<=5'd3;
	end
	
	5'd3:begin
		gptp_wr_ready<=1'b0;
		state<=5'd0;
	end
	endcase
end



gptp2 DUT(

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

endmodule