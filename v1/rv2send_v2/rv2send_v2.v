module rv2send_v2(
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
//rv
reg rv_ready;
reg rv_ready1;
reg rv_ready2;
//sd
reg sd_vaild;
reg sd_vaild1;
reg sd_vaild2;
reg [351:0] gptp_ts_data_t;
reg [351:0] gptp_ts_data_t1;
reg [351:0] gptp_ts_data_t2;
reg [79:0] gptp_ts_rv_data_t;


reg [4:0] state_sd;
localparam idle=5'b0;
localparam wait_sd=5'd1;
localparam rsd_ts=5'd2;
localparam rsd_ts2=5'd3;
localparam rsd_ts3=5'd4;
always @(posedge clk_sd)
begin
  if(~reset) begin
   state_sd<=1'b0;
  end
  else begin
   case(state_sd)
   
    idle:begin
      gptp_ts_rv_vaild<=1'b0;
      state_sd<=wait_sd;
    end
    
    wait_sd:begin
      if(gptp_ts_vaild) begin
        state_sd<=rsd_ts;
        gptp_ts_rv_data_t<={rtc_epoch_field_sd,rtc_sec_field_sd,rtc_nanosec_field_sd};
      end
    end
    
    rsd_ts:begin//gptp_ts_vaild�ø�2clk
      gptp_ts_rv_vaild<=1'b1;
      gptp_ts_rv_data<=gptp_ts_rv_data_t;
      state_sd<=rsd_ts2;
    end
    
    rsd_ts2:begin
      state_sd<=rsd_ts3;
    end
    
    rsd_ts3:begin
      gptp_ts_rv_vaild<=1'b0;
      if(rv_ready)begin
       state_sd<=idle;
      end
    end

    default:begin
      state_sd<=idle;
    end
   endcase
  end
end

always @(posedge clk_rv)
begin
 if(~reset) begin
  sd_vaild<=1'b0;
  sd_vaild1<=1'b0;
  sd_vaild2<=1'b0;
 end
 else begin
  sd_vaild<=sd_vaild1;
  sd_vaild1<=sd_vaild2;
  sd_vaild2<=gptp_ts_vaild;
  gptp_ts_data_t<=gptp_ts_data_t1;
  gptp_ts_data_t1<=gptp_ts_data_t2;
  gptp_ts_data_t2<=gptp_ts_data;
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
localparam rv_frame5=5'd6;
reg [31:0] rv_cnt;
wire [31:0] rv_cnt_max=32'd10;//�����ӳ�
always @(posedge clk_rv)
begin
 if(~reset) begin
  state_rv<=idle;
  gptp_rv_vaild<=1'b0;
  rv_cnt<=0;
 end
 else begin
  case(state_rv)
  
   idle:begin
     rv_cnt<=0;
     gptp_rv_vaild<=1'b0;
     if(sd_vaild) begin
       state_rv<=rv_frame ;
       gptp_rv_data_frame<=gptp_ts_data_t;
     end
   end  
   
   rv_frame:begin
     if(rv_cnt==rv_cnt_max) begin
       state_rv<=rv_frame1;
     end
     else begin
       rv_cnt<=rv_cnt+32'b1;
     end
   end
   
   rv_frame1:begin
     gptp_rv_data_ts<={rtc_epoch_field_rv, rtc_sec_field_rv,rtc_nanosec_field_rv};
     gptp_rv_vaild<=1'b1;
     state_rv<=rv_frame2;
   end
   
   rv_frame2:begin
     state_rv<=rv_frame3;
   end
   
   rv_frame3:begin
     gptp_rv_vaild<=1'b0;
     state_rv<=idle;
   end
  endcase
 end

end

always@(posedge clk_sd)
begin
 if(~reset) begin
   rv_ready<=1'b0;
   rv_ready1<=1'b0;
   rv_ready2<=1'b0;
 end
 else begin
   rv_ready2<=gptp_rv_vaild;
   rv_ready1<=rv_ready2;
   rv_ready<=rv_ready1;
 end
end
    
endmodule

