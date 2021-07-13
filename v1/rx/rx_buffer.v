module rx_buffer(
input clk,
input reset,//高有�?


//gptp读数�?
output reg [7:0] rx_gptp_rd_vaild,
output [79:0] rx_gptp_rd_data,
input [7:0] rx_gptp_rd_addr,
input rx_gptp_rd_ready,//pdelay_resp要用两个数据位置 要ready两次




//logic写入
output reg rx_rev_wr_ready,//ready置高表示可以读下�?个数�?
input rx_rev_wr_vaild,//存帧，严格置�?1clk
output rx_rev_wr_v_ready,//有效表示可接收rx_rev_wr_vaild
input [7:0] rx_rev_wr_addr, //指明帧类�?
input [79:0] rx_rev_wr_data1,//pdelay_resp要用两个数据位置  //接收时间�?
input [79:0] rx_rev_wr_data2 //帧携带的时间�?
);





wire lden7=rx_rev_wr_vaild&rx_rev_wr_addr[3];
wire [79:0] dnxt7=rx_rev_wr_data2;
wire [79:0] qout7;
sirv_gnrl_dfflr#(80) dfflr7 (lden7,dnxt7,qout7,clk,reset);
wire lden6=rx_rev_wr_vaild&rx_rev_wr_addr[6];



wire [79:0] dnxt6;
wire [79:0] qout6;
sirv_gnrl_dfflr#(80) dfflr6 (lden6,dnxt6,qout6,clk,reset);
wire lden5=rx_rev_wr_vaild&rx_rev_wr_addr[5];
wire [79:0] dnxt5;
wire [79:0] qout5;
sirv_gnrl_dfflr#(80) dfflr5 (lden5,dnxt5,qout5,clk,reset);


wire lden4=rx_rev_wr_vaild&rx_rev_wr_addr[4];
wire [79:0] dnxt4=rx_rev_wr_data2;
wire [79:0] qout4;
sirv_gnrl_dfflr#(80) dfflr4 (lden4,dnxt4,qout4,clk,reset);

wire lden3=rx_rev_wr_vaild&rx_rev_wr_addr[3];
wire [79:0] dnxt3=rx_rev_wr_data1;
wire [79:0] qout3;
sirv_gnrl_dfflr#(80) dfflr3 (lden3,dnxt3,qout3,clk,reset);

wire lden2=rx_rev_wr_vaild&rx_rev_wr_addr[2];
wire [79:0] dnxt2=rx_rev_wr_data1;
wire [79:0] qout2;
sirv_gnrl_dfflr#(80) dfflr2 (lden2,dnxt2,qout2,clk,reset);

wire lden1=rx_rev_wr_vaild&rx_rev_wr_addr[1];
wire [79:0] dnxt1=rx_rev_wr_data2;
wire [79:0] qout1;
sirv_gnrl_dfflr#(80) dfflr1 (lden1,dnxt1,qout1,clk,reset);

wire lden0=rx_rev_wr_vaild&rx_rev_wr_addr[0];
wire [79:0] dnxt0=rx_rev_wr_data1;
wire [79:0] qout0;
sirv_gnrl_dfflr#(80) dfflr0 (lden0,dnxt0,qout0,clk,reset);




reg [4:0] state;
localparam idle=5'b0;
localparam rv=5'b1;
localparam send1=5'd2;
localparam send2=5'd3;
localparam rv_new=5'd4;


always@(posedge clk)
begin
 if(~reset) begin
  state<=5'b0;
  rx_rev_wr_ready<=1'b0;
  rx_gptp_rd_vaild<=8'b0;
 end
 else begin
  case(state)
  
   idle:begin
	 rx_rev_wr_ready<=1'b0;
	 rx_gptp_rd_vaild<=8'b0;
	 state<=rv;
	end
	
	rv:begin
	 if(rx_rev_wr_vaild) begin
	  rx_gptp_rd_vaild<=rx_rev_wr_addr;
	  state<=send1;
	 end
	end
	
	send1:begin
	 if(rx_gptp_rd_ready) begin
	   if(rx_gptp_rd_addr[3]) begin////pdelay_resp有两个数�?
		 state<=send2;
		end
	   else begin
		 state<=rv_new;
		end
	 end
	end
	
	send2:begin
	 if(rx_gptp_rd_ready)begin
	  state<=rv_new;
	 end
	end
	
	rv_new:begin
	 rx_rev_wr_ready<=1'b1;
	 state<=idle;
	end
	
  endcase
 end
end



assign rx_rev_wr_v_ready=(state==rv);
assign rx_gptp_rd_data=({80{rx_gptp_rd_addr[0]}}&qout0)
							|({80{rx_gptp_rd_addr[1]}}&qout1)
							|({80{rx_gptp_rd_addr[2]}}&qout2)
							|({80{rx_gptp_rd_addr[3]}}&qout3)
							|({80{rx_gptp_rd_addr[4]}}&qout4)
							|({80{rx_gptp_rd_addr[5]}}&qout5)
							|({80{rx_gptp_rd_addr[6]}}&qout6)
							|({80{rx_gptp_rd_addr[7]}}&qout7)
							;

endmodule

