module rv2send_v1(
input clk_rv,
input clk_sd,

input reset,//浣庢湁鏁�?

//rv
output [431:0] gptp_rv_data,//鍓嶉潰鐨刦ifo涓�瀹氳淇濇寔杈撳�?
output reg gptp_rv_vaild,
input gptp_rv_ready,//ready缃珮鍙鍏�

//send
input gptp_ts_vaild,
output gptp_ts_ready,
input [351:0] gptp_ts_data,
//回写时间�?
output reg gptp_ts_rv_vaild,
output  reg [79:0] gptp_ts_rv_data,

//rtc rv
input [31:0]                        rtc_nanosec_field_rv,
input [31:0]                        rtc_sec_field_rv,
input [15:0]                        rtc_epoch_field_rv,

//rtc send
input [31:0]                        rtc_nanosec_field_sd,
input [31:0]                        rtc_sec_field_sd,
input [15:0]                        rtc_epoch_field_sd
);
//fifo
wire sd_full;
wire rv_empty;
reg [79:0] gptp_ts_rv_data_t;

reg [4:0] state_sd;
localparam idle=5'b0;
localparam wait_sd=5'd1;
localparam rsd_ts=5'd2;
localparam rsd_ts2=5'd3;
always @(posedge clk_sd)
begin
  if(~reset) begin
   state_sd<=1'b0;
  end
  else begin
   case(state_sd)
   
    idle:begin
      gptp_ts_rv_vaild<=1'b0;
      if(!sd_full)begin
        state_sd<=wait_sd;
      end
    end
    
    wait_sd:begin
      if(gptp_ts_vaild) begin
        state_sd<=rsd_ts;
        gptp_ts_rv_data_t<={rtc_epoch_field_sd,rtc_sec_field_sd,rtc_nanosec_field_sd};
      end
    end
    
    rsd_ts:begin
      gptp_ts_rv_vaild<=1'b1;
      gptp_ts_rv_data<=gptp_ts_rv_data_t;
      state_sd<=rsd_ts2;
    end
    
    rsd_ts2:begin
      gptp_ts_rv_vaild<=1'b0;
      state_sd<=idle;
    end
    
    default:begin
      state_sd<=idle;
    end
   endcase
  end
end



assign gptp_ts_ready=(state_sd==wait_sd);

//fifo
wire [351:0] fifo_rv;


reg [4:0] state_rv;
localparam idle_rv=5'd0;
localparam rv_frame=5'd1;
reg [79:0] gptp_rv_data_ts;
reg [351:0] gptp_rv_data_frame;
reg gptp_rv_data_vaild;
localparam rv_frame1=5'd2;
localparam rv_frame2=5'd3;
localparam rv_frame3=5'd4;  
assign gptp_rv_data={gptp_rv_data_frame,gptp_rv_data_ts};
localparam rv_frame4=5'd5;
reg [31:0] rv_cnt;
wire [31:0] rv_cnt_max=32'd1000;
always @(posedge clk_rv)
begin
 if(~reset) begin
  state_rv<=idle;
 end
 else begin
  case(state_rv)
  
   idle:begin
      rv_cnt<=0;
     gptp_rv_data_vaild<=1'b0;
     gptp_rv_vaild<=1'b0;
     if(~rv_empty) begin
       state_rv<=rv_frame ;
     end
   end  
   
   rv_frame:begin
     gptp_rv_data_vaild<=1'b1;
     state_rv<=rv_frame1;
   end
   
   rv_frame1:begin
     gptp_rv_data_vaild<=1'b0;
     state_rv<=rv_frame2;
   end
   
   rv_frame2:begin
     
     gptp_rv_data_frame<=fifo_rv;
     gptp_rv_data_ts<={rtc_epoch_field_rv,rtc_sec_field_rv,rtc_nanosec_field_rv};
     state_rv<=rv_frame3;
   end
   
   rv_frame3:begin
    if(gptp_rv_ready) begin
     gptp_rv_vaild<=1'b1;
     state_rv<=rv_frame4;
    end
   end
   
   rv_frame4:begin
     gptp_rv_vaild<=1'b0;
     if(rv_cnt==rv_cnt_max) begin
       state_rv<=idle;
     end
     else begin
       rv_cnt<=rv_cnt+32'b1;
     end
   end
  endcase
 end

end

fifo_generator_0 fifo_generator_0_1(
    .wr_clk(clk_sd),
   . rd_clk (clk_rv),
    .din (gptp_ts_data),
  .  wr_en(gptp_ts_vaild),
   . rd_en(gptp_rv_data_vaild),
   . dout (fifo_rv),
  .  full(sd_full),
  .  empty (rv_empty)
    
    );


    
endmodule

