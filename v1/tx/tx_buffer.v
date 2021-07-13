module tx_buffer(
//logic
///发�??
output [7:0] send_addr,
output reg send_vaild,
input send_ready,
output [79:0] send_data,
///接收
input send_r_vaild,
input [79:0] send_r_data,
//gptp
///�?
input [7:0] gptp_rd_addr,
output [79:0] gptp_rd_data,
//�?
input [7:0] gptp_wr_addr,
input [79:0] gptp_wr_data,//保持到ready有效
input gptp_wr_vaild,
output reg gptp_wr_ready,//当发送时间戳写入在有�?
output gptp_wr_vaild_ready,

input clk,
input reset

);
wire [79:0] next_data=send_r_data;
wire lden_data=send_r_vaild;

wire lden7=lden_data&gptp_wr_addr[7];
wire [79:0] dnxt7=next_data;
wire [79:0] qout7;
sirv_gnrl_dfflr#(80) tx_dfflr7 (lden7,dnxt7,qout7,clk,reset);
wire lden6=lden_data&gptp_wr_addr[6];
wire [79:0] dnxt6=next_data;
wire [79:0] qout6;
sirv_gnrl_dfflr#(80) tx_dfflr6 (lden6,dnxt6,qout6,clk,reset);
wire lden5=lden_data&gptp_wr_addr[5];
wire [79:0] dnxt5=next_data;
wire [79:0] qout5;
sirv_gnrl_dfflr#(80) tx_dfflr5 (lden5,dnxt5,qout5,clk,reset);
wire lden4=lden_data&gptp_wr_addr[4];
wire [79:0] dnxt4=next_data;
wire [79:0] qout4;
sirv_gnrl_dfflr#(80) tx_dfflr4 (lden4,dnxt4,qout4,clk,reset);
wire lden3=lden_data&gptp_wr_addr[3];
wire [79:0] dnxt3=next_data;
wire [79:0] qout3;
sirv_gnrl_dfflr#(80) tx_dfflr3 (lden3,dnxt3,qout3,clk,reset);
wire lden2=lden_data&gptp_wr_addr[2];
wire [79:0] dnxt2=next_data;
wire [79:0] qout2;
sirv_gnrl_dfflr#(80) tx_dfflr2 (lden2,dnxt2,qout2,clk,reset);
wire lden1=lden_data&gptp_wr_addr[1];
wire [79:0] dnxt1=next_data;
wire [79:0] qout1;
sirv_gnrl_dfflr#(80) tx_dfflr1 (lden1,dnxt1,qout1,clk,reset);
wire lden0=lden_data&gptp_wr_addr[0];
wire [79:0] dnxt0=next_data;
wire [79:0] qout0;
sirv_gnrl_dfflr#(80) tx_dfflr0 (lden0,dnxt0,qout0,clk,reset);


reg [5:0] state;
localparam idle=6'b0;
localparam rv_send_req=6'b1;
localparam send1=6'd2;
localparam send2=6'd3;

always@(posedge clk)
begin
 if(~reset) begin
  state<=6'b0;
  gptp_wr_ready<=1'b0;
  send_vaild<=1'b0;
 end
 else begin
  case(state)
  
   idle:begin
    state<=rv_send_req;
	 gptp_wr_ready<=1'b0;
	 send_vaild<=1'b0;
   end
   
	rv_send_req:begin
	 if(gptp_wr_vaild) begin
	  state<=send1;
	 end
	end
   
	send1:begin
	  send_vaild<=1'b1;
	  if(send_ready) begin
	   state<=send2;
	  end
	end
   
   send2:begin
     if(send_r_vaild) begin
	    gptp_wr_ready<=1'b1;
	    state<=idle;
	  end
   end	
  endcase
 end
end
assign gptp_wr_vaild_ready=(state==rv_send_req);

assign send_addr=gptp_wr_addr;
assign send_data=gptp_wr_data;

assign gptp_rd_data=({80{gptp_rd_addr[0]}}&qout0)
						|({80{gptp_rd_addr[1]}}&qout1)
						|({80{gptp_rd_addr[2]}}&qout2)
						|({80{gptp_rd_addr[3]}}&qout3)
						|({80{gptp_rd_addr[4]}}&qout4)
						|({80{gptp_rd_addr[5]}}&qout5)
						|({80{gptp_rd_addr[6]}}&qout6)
						|({80{gptp_rd_addr[7]}}&qout7)
						;
						
endmodule
