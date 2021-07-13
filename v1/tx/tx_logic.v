module tx_logic(
input clk,
input reset,


//å‘é?ç«¯
///å?
output reg gptp_ts_vaild,
input gptp_ts_ready,
output [351:0] gptp_ts_data,
///æ”?
input gptp_ts_rv_vaild,
input [79:0] gptp_ts_rv_data,


//bufferä¾?
///è¯?
input [7:0] send_addr,//æŠ±æŒä½? ç›´åˆ°send_r_vaild
input send_vaild,
output reg send_ready,
input [79:0] send_data,//æŠ±æŒä½? ç›´åˆ°send_r_vaild
///å†?
output reg send_r_vaild,
output reg [79:0] send_r_data

);



reg [4:0] state;
localparam idle=5'b0;
localparam rv_send_req=5'd1;//æ¥æ”¶å‘é?è¯·æ±?
localparam send1=5'd2;
reg [31:0] cnt;
wire [31:0] cnt_max=32'd2;
localparam send2=5'd3;
localparam send3=5'd4;
localparam rv_t=5'd5;

always@(posedge clk)
begin
 if(~reset) begin
  state<=5'b0;
  gptp_ts_vaild<=1'b0;
  send_ready<=1'b0;
  send_r_vaild<=1'b0;
  cnt<=32'b0;
 end
 else begin
  case(state)
  
   idle:begin
     gptp_ts_vaild<=1'b0;
     send_ready<=1'b0;
     send_r_vaild<=1'b0;
	  cnt<=32'b0;
	  state<=rv_send_req;
   end
   
	rv_send_req:begin
	  if(send_vaild) begin
	    send_ready<=1'b1;
		 state<=send1;
	  end
	end
   
	send1:begin//ç»„è£…å¸?
	 send_ready<=1'b0;
	 if(cnt==cnt_max) begin
	  state<=send2;
	 end
	 else begin
	  cnt<=cnt+32'b1;
	 end
	end
	
	send2:begin //
	 if(gptp_ts_ready) begin
	   gptp_ts_vaild<=1'b1;
		state<=send3;
	 end
	end
	
	send3:begin
	 gptp_ts_vaild<=1'b0;
	 if(gptp_ts_rv_vaild) begin
	  state<=rv_t;
	  send_r_data<=gptp_ts_rv_data;
	  send_r_vaild<=1'b1;
	 end
	end
	
	rv_t:begin
	 send_r_vaild<=1'b0;
	 state<=idle;
	end
	

  endcase
 end
end



tempalet t1(
.send_addr(send_addr),
.send_data(send_data),
.gptp_ts_data(gptp_ts_data)
);
endmodule
