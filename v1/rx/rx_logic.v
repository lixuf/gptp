module rx_logic(
input clk,
input reset,//高有�?

input [431:0] gptp_rv_data,//前面的fifo�?定要保持输出
input gptp_rv_vaild,
output gptp_rv_ready,//ready置高可读�?

input rx_rev_wr_ready,//ready置高表示可以读下�?个数�?
output reg rx_rev_wr_vaild,//存帧，严格置�?1clk
input rx_rev_wr_v_ready,
output [7:0] rx_rev_wr_addr, //指明帧类�?
output [79:0] rx_rev_wr_data1,//pdelay_resp要用两个数据位置 //j接收时间�?
output [79:0] rx_rev_wr_data2 //帧携带的时间�?
);



dec_frame dec_frame1(
.gptp_rv_data(gptp_rv_data),
.rx_rev_wr_addr(rx_rev_wr_addr),
.rx_rev_wr_data1(rx_rev_wr_data1),
.rx_rev_wr_data2(rx_rev_wr_data2)
);


reg [3:0] state;
localparam idle=4'd0;
localparam rv=4'd1;
localparam dec=4'd2;
localparam store1=4'd3;
localparam store2=4'd4;

reg [31:0] cnt;
wire [31:0] cnt_max=32'd2;

always@(posedge clk)
begin
 if(~reset) begin
  state<=4'b0;
  rx_rev_wr_vaild<=1'b0;
  cnt<=32'b0;
 end
 else begin
  case(state)
   idle:begin
	 rx_rev_wr_vaild<=1'b0;
	 cnt<=32'b0;
    state<=rv;
   end
   
	rv:begin//等待接收数据
    if(gptp_rv_vaild) begin
	  state<=dec;
	 end
	end
	
	
   dec:begin//解析�? 组合电路
	 if(cnt==cnt_max) begin
	   state<=store1;
	 end
	 else begin
	   cnt<=cnt+32'b1; 
	 end
	end
	
	store1:begin//把帧存入buffer�?
	if(rx_rev_wr_v_ready) begin
	 rx_rev_wr_vaild<=1'b1;
	 state<=store2;
	end
	end
	
	store2:begin
	 rx_rev_wr_vaild<=1'b0;
	 if(rx_rev_wr_ready) begin
	  state<=idle;
	 end
	end
	
	default:begin
	 state<=idle;
	end
  endcase
 end
end


assign gptp_rv_ready=(state==rv);

endmodule
