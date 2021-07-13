module rv2send(
input clk,
input reset,//低有�?

//rx
output [431:0] gptp_rv_data,//前面的fifo�?定要保持输出
output reg gptp_rv_vaild,
input gptp_rv_ready,//ready置高可读�?

//tx
input gptp_ts_vaild,
output gptp_ts_ready,
input [351:0] gptp_ts_data,
///发�?�时间戳
output reg gptp_ts_rv_vaild,
output  [79:0] gptp_ts_rv_data,

//rtc
input [31:0]                        rtc_nanosec_field,
input [31:0]                        rtc_sec_field,
input [15:0]                        rtc_epoch_field
);


reg [79:0] send_t;
reg [79:0] rv_t;

reg [4:0] state;

reg [351:0] frame;
reg [31:0] wait_cnt;
wire [31:0] wait_cnt_max=32'd1000;
localparam idle=5'd0;
localparam rv=5'd1;
localparam rv2=5'd2;
localparam wait_1ms=5'd3;
localparam send=5'd4;
localparam send2=5'd5;
always @(posedge clk)
begin
 if(~reset) begin
  state<=0;
  gptp_ts_rv_vaild<=1'b0;
  wait_cnt<=32'b0;
  gptp_rv_vaild<=1'b0;
 end
 else begin
  case(state)
   idle:begin
	 state<=rv;
	 gptp_ts_rv_vaild<=1'b0;
	 wait_cnt<=32'b0;
	 gptp_rv_vaild<=1'b0;
	end
	
	rv:begin
	 if(gptp_ts_vaild) begin
	  frame<=gptp_ts_data;
	  state<=rv2;
	  send_t<={rtc_epoch_field,rtc_sec_field,rtc_nanosec_field};
	 end
	end
	
	rv2:begin
	 gptp_ts_rv_vaild<=1'b1;
	 state<=wait_1ms;
	end
  
  
   wait_1ms:begin
	 gptp_ts_rv_vaild<=1'b0;
	 if(wait_cnt==wait_cnt_max) begin
	  state<=send;
	 end
	 else begin
	  wait_cnt<=wait_cnt+32'b1;
	 end
	end
	
	send:begin
	 rv_t<={rtc_epoch_field,rtc_sec_field,rtc_nanosec_field};
	 state<=send2;
	end
	
	send2:begin
	 if(gptp_rv_ready) begin
	  gptp_rv_vaild<=1'b1;
	  state<=idle;
	 end
	end
  endcase
 end
end

assign gptp_ts_rv_data=send_t;
assign gptp_ts_ready=(state==rv);
assign send_frame={rv_t,frame};
assign gptp_rv_data=send_frame;

fifo_generator_0 fifo_generator_0_1(
    .wr_clk(),
   . rd_clk (),
    .din (),
  .  wr_en(),
   . rd_en(),
   . dout (),
  .  full(),
  .  empty ()
    
    );
    
endmodule

