//�??鏈夊姞鍑忎箻闄よ鑰冭檻杩涗綅鍊熶綅鐨勯棶棰?

module gptp2 #
(
  parameter         position            = 1'b1//0slave 1master
)(
input clk,
input reset,//高电平有�?

//rtc
output reg gptp_vaild,
input rtc_ready,//目前恒为1
output gptp_sw,
//更新参数
output [31:0] syntonised_nanosec_field_r,
output [31:0] syntonised_sec_field_r,
output [15:0] syntonised_epoch_field_r,

output [29:0] nanosec_offset,//�?30�?
output [31:0] sec_offset,//初始值一定要�?0
output [15:0] epoch_offset,

output [25:0] rtc_increment,//初�?�为�?小自增量
//rtc 采样
input [31:0]                        rtc_nanosec_field,
input [31:0]                        rtc_sec_field,
input [15:0]                        rtc_epoch_field,
  
//rx �?
input [7:0] rx_gptp_rd_vaild,//指明接收到何种帧
input [79:0] rx_gptp_rd_data,
output reg [7:0] rx_gptp_rd_addr,//读地�?
output reg rx_gptp_rd_ready, //读使�? ，给出使能下�?个clk读到数据


//tx �?
input [79:0] gptp_rd_data,
output reg [7:0]gptp_rd_addr,//读都是统�?给出地址后的�?个clk�?

//tx �?
output reg [7:0] gptp_wr_addr,
output reg [79:0] gptp_wr_data,
output reg gptp_wr_vaild,
input gptp_wr_ready,//表明当前帧发送出去了
input gptp_wr_vaild_ready
);


parameter clock_incre=26'b1000_0000_0000_0000_0000_0000;//全局时钟自增值，125MHZ


reg state_pos;
localparam pos_slave=1'b0;
localparam pos_master=1'b1;
reg [7:0] state_master;
localparam master_idle=7'd0;
reg [31:0] cyc_cnt;
wire [31:0] cyc_cnt_max=32'd250000;//ͬ�����
localparam master_send_sync1=7'd1;
localparam master_send2_sync1=7'd2;
localparam master_send_fu1=7'd3;
localparam master_send2_fu1=7'd4;
localparam master_send_sync2=7'd5;
localparam master_send2_sync2=7'd6;
localparam master_send_fu2=7'd7;
localparam master_send2_fu2=7'd8;
localparam master_wait_preq=7'd9;
localparam master_rv_preq=7'd10;
localparam master_send_presp=7'd11;
localparam master_send2_presp=7'd12;
localparam master_send_pfu=7'd13;
localparam master_send2_pfu=7'd14;
localparam master_send_s_sync=7'd15;
localparam master_send2_s_sync=7'd16;
localparam master_send_s_fu=7'd17;
localparam master_send2_s_fu=7'd18;
reg [7:0] state_slave;
localparam slave_idle=7'd0;
localparam slave_wait_sync1=7'd1;
localparam slave_rv_st2=7'd2;
localparam slave_rv2_st2=7'd3;
localparam slave_wait_fu1=7'd4;
localparam slave_rv_st1=7'd5;
localparam slave_rv2_st1=7'd6;
localparam slave_wait_sync2=7'd7;
localparam slave_rv_st4=7'd8;
localparam slave_rv2_st4=7'd9;
localparam slave_wait_fu2=7'd10;
localparam slave_rv_st3=7'd11;
localparam slave_rv2_st3=7'd12;
localparam slave_compute_r=7'd13;
localparam salve_compute2_r=7'd14;
localparam slave_send_preq=7'd15;
localparam salve_send2_preq=7'd16;
localparam slave_rv_dt1=7'd17;
localparam slave_rv2_dt1=7'd18;
localparam slave_wait_presp=7'd19;
localparam slave_rv_dt4=7'd20;
localparam slave_rv2_dt4=7'd21;
localparam slave_rv_dt2=7'd22;
localparam slave_rv2_dt2=7'd23;
localparam slave_rv3_dt2=7'd24;
localparam slave_wait_pfu=7'd25;
localparam slave_rv_dt3=7'd26;
localparam slave_rv2_dt3=7'd27;
localparam slave_compute_delay=7'd28;
localparam slave_wait_s_sync=7'd29;
localparam slave_rv_sst2=7'd30;
localparam slave_rv2_sst2=7'd31;
localparam slave_wait_s_fu=7'd32;
localparam slave_rv_sst1=7'd33;
localparam slave_rv2_sst1=7'd34;
localparam slave_get_rtc=7'd35;
localparam slave_get2_rtc=7'd36;
localparam slave_compute_sync=7'd37;
localparam slave_updata_sync=7'd38;
localparam slave_updata2_sync=7'd39;




//不用�? 成float
//r用点小数uz8f4
reg [79:0] in_t;
reg [31:0] dt1_nano;
reg [31:0] dt1_sec;
reg [15:0] dt1_epoch;  
reg [31:0] dt2_nano;
reg [31:0] dt2_sec;
reg [15:0] dt2_epoch;
reg [31:0] dt3_nano;
reg [31:0] dt3_sec;
reg [15:0] dt3_epoch;
reg [31:0] dt4_nano;
reg [31:0] dt4_sec;
reg [15:0] dt4_epoch;
reg [31:0] st1_nano;
reg [31:0] st1_sec;
reg [15:0] st1_epoch;   
reg [31:0] st2_nano;
reg [31:0] st2_sec;
reg [15:0] st2_epoch;
reg [31:0] st3_nano;
reg [31:0] st3_sec;
reg [15:0] st3_epoch;
reg [31:0] st4_nano;
reg [31:0] st4_sec;
reg [15:0] st4_epoch;
reg [31:0] sst1_nano;
reg [31:0] sst1_sec;
reg [15:0] sst1_epoch;
reg [31:0] sst2_nano;
reg [31:0] sst2_sec;
reg [15:0] sst2_epoch;
reg [31:0] sstb_nano;
reg [31:0] sstb_sec;
reg [15:0] sstb_epoch;
reg [31:0] ssta_nano;
reg [31:0] ssta_sec;
reg [15:0] ssta_epoch;


//璁＄畻r
wire [25:0] rtc_incrment_t;
wire [11:0] r_uz8f4_t;
reg [31:0] r_cnt;
wire [31:0] r_cnt_max=32'd23;
reg [11:0] r_uz8f4;
reg [25:0] rtc_incrment_reg;
assign rtc_increment=rtc_incrment_reg;

 R_1 r1(
  .t4_sec_V({st4_epoch,st4_sec}),
  .t2_sec_V({st3_epoch,st3_sec}),
  .t3_sec_V({st2_epoch,st2_sec}),
  .t1_sec_V({st1_epoch,st1_sec}),
  .increment_nano_V_ap_vld(),
  .increment_subnano_V_ap_vld(),
  .ap_clk(clk),
  .ap_rst(~reset),
  .ap_return(r_uz8f4_t),
  .t1(st1_nano),
  .t2(st2_nano),
  .t3(st3_nano),
  .t4(st4_nano),
  .found_clock(32'd8),
  .increment_nano_V(rtc_incrment_t[25:20]),
  .increment_subnano_V(rtc_incrment_t[19:0])
);

//璁＄畻delay //閿欒鍒ゆ柇 寤惰繜澶т簬ms
wire [31:0] delay_nano_t;//uint
reg [31:0] delay_nano;
reg [31:0] delay_cnt;
wire [31:0] delay_cnt_max=32'd3;


Delay_0 d1(
  .ap_clk(clk),
  .ap_rst(~reset),
  .t1_s_V({dt1_epoch,dt1_sec}),
  .t2_s_V({dt2_epoch,dt2_sec}),
  .t3_s_V({dt3_epoch,dt3_sec}),
  .t4_s_V({dt4_epoch,dt4_sec}),
  .t1(dt1_nano),
  .t2(dt2_nano),
  .t3(dt3_nano),
  .t4(dt4_nano),
  .rv_V(r_uz8f4),
  .ap_return(delay_nano_t)
);




//璁＄畻sync
wire updata_way_t;
wire [31:0] offset_nano_t;
wire [31:0] offset_sec_t;
wire [15:0] offset_epoch_t;
wire [31:0] fund_nano_t;
wire [31:0] fund_sec_t;
wire [15:0] fund_epoch_t;

reg updata_way;
reg [31:0] offset_nano;
reg [31:0] offset_sec;
reg [15:0] offset_epoch;
reg [31:0] fund_nano;
reg [31:0] fund_sec;
reg [15:0] fund_epoch;
reg [31:0] sync_cnt;
wire [31:0] sync_cnt_max=32'd5;
//updata_way_t要�'定一�?
Sync_0 sssss1(
  .of_s_V_ap_vld(),
  .of_n_V_ap_vld(),
  .ta_s_V_ap_vld(),
  .ta_n_V_ap_vld(),
  .f_ap_vld(),
  .ap_clk(clk),
  .ap_rst(~reset),
  .t1_s_V({sst1_epoch,sst1_sec}),
  .t1_n_V(sst1_nano),
  .t2_s_V({sst2_epoch,sst2_sec}),
  .t2_n_V(sst2_nano),
  .t3_s_V({sst3_epoch,sst3_sec}),
  .t3_n_V(sst3_nano),
  .tb_s_V({sstb_epoch,sstb_sec}),
  .tb_n_V(sstb_nano),
  .of_s_V({offset_epoch_t,offset_sec_t}),
  .of_n_V(offset_nano_t),
  .ta_s_V({fund_epoch_t,fund_sec_t}),
  .ta_n_V(fund_nano_t),
  .delay_V(delay_nano),
  .rv_V(r_uz8f4),
  .f(updata_way_t),
  .ta_offset_V(32'd80)
);



//娑撹绮犻幒褍鍩?
reg pos_ready;//缂冾噣鐝�?悩鑸??浣规簚閹靛秴褰叉潻鎰攽閿涘矁銆冪粈楦款洣鏉╂稖顢戦悩鑸??浣稿瀼閹??
wire pos=position;//閺囧瓨鏁兼稉璁崇矤閻樿埖??
always @(posedge clk)
begin
 if(~reset)
 begin
  pos_ready<=1'b0;
 end
 else
 begin
  pos_ready<=1'b1;
 end
 state_pos<=pos;
end

//reset 低有效，记得�?
wire reset_pos=pos_ready&reset;//閸掑洦宕查悩�???渚婄礉閻樿埖?�??娓剁憰浣割槻�???




always@(posedge clk)
begin
 if(~reset_pos) begin
  state_master<=7'b0;
  state_slave<=7'b0;
  rx_gptp_rd_ready<=1'b0;
  gptp_wr_vaild<=1'b0;
	sync_cnt<=32'b0;
	delay_cnt<=32'b0;
	gptp_vaild<=1'b0;
	rtc_incrment_reg<=clock_incre;
	offset_nano  <=32'b0;
	offset_epoch<=16'b0;
	offset_sec<=32'b0;
	cyc_cnt<=32'b0;
 end
 else if(state_pos==pos_master) begin
 case(state_master)
  master_idle:begin//閺堫亝鍧婇崝鐘侯�?�???
   rx_gptp_rd_ready<=1'b0;
	gptp_wr_vaild<=1'b0;
	gptp_vaild<=1'b0;
	state_master<=master_send_sync1;
   cyc_cnt<=32'b0;
	
  end
 
  //鐠侊紕鐣�?
  //娑擃參妫块崣顖濆厴闂??鐟曚胶鐡戝?
  master_send_sync1:begin
   if(cyc_cnt==cyc_cnt_max) begin
        gptp_wr_addr<=8'b1;
	    gptp_wr_data<=80'b0;
	    if(gptp_wr_vaild_ready) begin
	     gptp_wr_vaild<=1'b1;
	     state_master<=master_send2_sync1;
	    end
   end
   else begin
       cyc_cnt<=cyc_cnt+32'b1;
   end
  end
  
  master_send2_sync1:begin
   gptp_wr_vaild<=1'b0;
	if(gptp_wr_ready) begin
	 gptp_rd_addr<=8'b1;
	 state_master<=master_send_fu1;
	end
  end

  master_send_fu1:begin
   gptp_wr_addr<=8'd2;
	gptp_wr_data<=gptp_rd_data;
	if(gptp_wr_vaild_ready) begin
	gptp_wr_vaild<=1'b1;
	state_master<=master_send2_fu1;
	end
  end
  
  master_send2_fu1:begin
    gptp_wr_vaild<=1'b0;
    if(gptp_wr_ready)begin
	  state_master<=master_send_sync2;
	 end
  end
  
  master_send_sync2:begin
   gptp_wr_addr<=8'b1;
	gptp_wr_data<=80'b0;
	if(gptp_wr_vaild_ready) begin
	gptp_wr_vaild<=1'b1;
	state_master<=master_send2_sync2;
	end
  end
  
  master_send2_sync2:begin
   gptp_wr_vaild<=1'b0;
	if(gptp_wr_ready) begin
	 gptp_rd_addr<=8'b1;
	 state_master<=master_send_fu2;
	end
  end
  
  master_send_fu2:begin
   gptp_wr_addr<=8'd2;
	gptp_wr_data<=gptp_rd_data;
	if(gptp_wr_vaild_ready) begin
	gptp_wr_vaild<=1'b1;
	state_master<=master_send2_fu2;
	end
  end
  
  master_send2_fu2:begin
    gptp_wr_vaild<=1'b0;
    if(gptp_wr_ready)begin
	  state_master<=master_wait_preq;
	 end
  end
  
  //鐠侊紕鐣籨elay
  master_wait_preq:begin
   if(rx_gptp_rd_vaild[2]) begin
    state_master<=master_rv_preq;
   end
  end
  
  master_rv_preq:begin
   rx_gptp_rd_addr<=8'b100;
   rx_gptp_rd_ready<=1'b1;
	state_master<=master_send_presp;
  end
 
  master_send_presp:begin
   rx_gptp_rd_ready<=1'b0;
   gptp_wr_addr<=8'b1000;
	gptp_wr_data<=rx_gptp_rd_data;
	if(gptp_wr_vaild_ready) begin
	gptp_wr_vaild<=1'b1;
	state_master<=master_send2_presp;
	end
  end
 
  master_send2_presp:begin
   gptp_wr_vaild<=1'b0;
	if(gptp_wr_ready) begin
	 state_master<=master_send_pfu;
	 gptp_rd_addr<=8'b1000;
	end
  end
  
  master_send_pfu:begin
   gptp_wr_addr<=8'b10000;
	gptp_wr_data<=gptp_rd_data;
	if(gptp_wr_vaild_ready) begin
	gptp_wr_vaild<=1'b1;
	state_master<=master_send2_pfu;
	end
  end
  
  master_send2_pfu:begin
   gptp_wr_vaild<=1'b0;
	if(gptp_wr_ready) begin
	 state_master<=master_send_s_sync;
	end
  end
  
  //閺冨爼鎸撻崥灞绢�?
  master_send_s_sync:begin
   gptp_wr_addr<=8'b1;
	gptp_wr_data<=80'b0;
	if(gptp_wr_vaild_ready) begin
	gptp_wr_vaild<=1'b1;
	state_master<=master_send2_s_sync;
	end
  end
  
  master_send2_s_sync:begin
   gptp_wr_vaild<=1'b0;
	if(gptp_wr_ready) begin
	 state_master<=master_send_s_fu;
	 gptp_rd_addr<=8'b1;
	end
  end
  
  master_send_s_fu:begin
   gptp_wr_addr<=8'b10;
	gptp_wr_data<=gptp_rd_data;
	if(gptp_wr_vaild_ready) begin
	gptp_wr_vaild<=1'b1;
	state_master<=master_send2_s_fu;
	end
  end
  
  master_send2_s_fu:begin
   gptp_wr_vaild<=1'b0;
	if(gptp_wr_ready) begin
	  state_master<=master_idle;
	end
  end
 endcase
 end
 
 else if(state_pos==pos_slave) begin
 case(state_slave)
  slave_idle:begin
	sync_cnt<=32'b0;
	delay_cnt<=32'b0;
   rx_gptp_rd_ready<=1'b0;
	gptp_wr_vaild<=1'b0;
	gptp_vaild<=1'b0;
	state_slave<=slave_wait_sync1;
	r_cnt<=32'b0;
  end
  
  //鐠侊紕鐣�?
  slave_wait_sync1:begin
   if(rx_gptp_rd_vaild[0]) begin
	   rx_gptp_rd_addr<=8'b1;
      rx_gptp_rd_ready<=1'b1;
		state_slave<=slave_rv_st2;
	end
  end
  
  
  slave_rv_st2:begin
   in_t<=rx_gptp_rd_data;
	rx_gptp_rd_ready<=1'b0;
   state_slave<= slave_rv2_st2;
  end
  
  slave_rv2_st2:begin
   st2_nano<=in_t[31:0];
   st2_sec<=in_t[63:32];
   st2_epoch<=in_t[79:64];
   state_slave<= slave_wait_fu1; 
  end
  
  slave_wait_fu1:begin
   if(rx_gptp_rd_vaild[1]) begin
	   rx_gptp_rd_addr<=8'b10;
      rx_gptp_rd_ready<=1'b1;
		state_slave<=slave_rv_st1;
	 end
  end
  
  slave_rv_st1:begin
   in_t<=rx_gptp_rd_data;
	 rx_gptp_rd_ready<=1'b0;
    state_slave<=slave_rv2_st1;
  end
  
  slave_rv2_st1:begin
   st1_nano<=in_t[31:0];
   st1_sec<=in_t[63:32];
   st1_epoch<=in_t[79:64];
   state_slave<=slave_wait_sync2;
  end
  
  slave_wait_sync2:begin
    if(rx_gptp_rd_vaild[0]) begin
	   rx_gptp_rd_addr<=8'b1;
      rx_gptp_rd_ready<=1'b1;
		state_slave<=slave_rv_st4;
	 end
  end
  
  slave_rv_st4:begin
    in_t<=rx_gptp_rd_data;
	 rx_gptp_rd_ready<=1'b0;
    state_slave<=slave_rv2_st4;
  end

 slave_rv2_st4:begin
 st4_nano<=in_t[31:0];
st4_sec<=in_t[63:32];
st4_epoch<=in_t[79:64];
 state_slave<= slave_wait_fu2;
 end
 
  slave_wait_fu2:begin
   if(rx_gptp_rd_vaild[1]) begin
	   rx_gptp_rd_addr<=8'b10;
      rx_gptp_rd_ready<=1'b1;
		state_slave<=slave_rv_st3;
	 end
  end
  
  slave_rv_st3:begin
    in_t<=rx_gptp_rd_data;
	 rx_gptp_rd_ready<=1'b0;
    state_slave<=slave_rv2_st3;
  end  
  
  slave_rv2_st3:begin
  st3_nano<=in_t[31:0];
  st3_sec<=in_t[63:32];
  st3_epoch<=in_t[79:64];
  state_slave<=slave_compute_r;
  end
  
  slave_compute_r:begin
  if(r_cnt==r_cnt_max) begin
   state_slave<=salve_compute2_r;
  end
  else begin
   r_cnt<=r_cnt+32'b1;
  end
  end
  
  salve_compute2_r:begin
   r_uz8f4<=r_uz8f4_t;
   rtc_incrment_reg<=rtc_incrment_t;
   state_slave<=slave_send_preq;
  end
  
  
  //鐠侊紕鐣籨elay
  slave_send_preq:begin
   gptp_wr_addr<=8'b100;
	gptp_wr_data<=80'b0;
	if(gptp_wr_vaild_ready) begin
	gptp_wr_vaild<=1'b1;
	state_slave<=salve_send2_preq;
	end
  end
  
  salve_send2_preq:begin
    gptp_wr_vaild<=1'b0;
    if(gptp_wr_ready)begin
	  gptp_rd_addr<=8'b100;
	  state_slave<=slave_rv_dt1;
	 end
  end
 
  slave_rv_dt1:begin
   in_t<=gptp_rd_data;
   state_slave<=slave_rv2_dt1;
  end
  
   slave_rv2_dt1:begin
   dt1_nano<=in_t[31:0];
dt1_sec<=in_t[63:32];
dt1_epoch<=in_t[79:64];
state_slave<=slave_wait_presp;
   end
  
  slave_wait_presp:begin
   if(rx_gptp_rd_vaild[3]) begin
    state_slave<=slave_rv_dt4;
	 rx_gptp_rd_addr<=8'b1000;
    rx_gptp_rd_ready<=1'b1;
   end
  end
  
  slave_rv_dt4:begin
   rx_gptp_rd_ready<=1'b0;
	in_t<=rx_gptp_rd_data;
	state_slave<=slave_rv2_dt4;
  end
  
  slave_rv2_dt4:begin
   dt4_nano<=in_t[31:0];
dt4_sec<=in_t[63:32];
dt4_epoch<=in_t[79:64];
state_slave<=slave_rv_dt2;
  end
  
  slave_rv_dt2:begin//�???閼割剚娼电拠鏉戠秼閸撳秳缍呯純顔芥杹閻ㄥ嫬姘ㄩ弰顖炴付鐟曚胶娈戦敍灞肩稻閺勵垵顕氱敮褎婀佹稉銈勯嚋閺冨爼妫块幋绛圭礉�???鐟曚焦濡搁幖鍝勭敨閻ㄥ嫭鏂佹担宥囩枂8
    rx_gptp_rd_addr<=8'b10000000;
    rx_gptp_rd_ready<=1'b1;
	 state_slave<=slave_rv2_dt2;
  end
  
  slave_rv2_dt2:begin
   in_t<=rx_gptp_rd_data;
	rx_gptp_rd_ready<=1'b0;
	state_slave<=slave_rv3_dt2;
  end
  
  slave_rv3_dt2:begin
  dt2_nano<=in_t[31:0];
dt2_sec<=in_t[63:32];
dt2_epoch<=in_t[79:64];
state_slave<=slave_wait_pfu;
  end
  
  slave_wait_pfu:begin
   if(rx_gptp_rd_vaild[4]) begin
	 state_slave<=slave_rv_dt3;
	 rx_gptp_rd_addr<=8'b10000;
    rx_gptp_rd_ready<=1'b1;
	end
  end
  
  
  slave_rv_dt3:begin
   rx_gptp_rd_ready<=1'b0;
	in_t<=rx_gptp_rd_data;
	state_slave<=slave_rv2_dt3;
  end
  
  slave_rv2_dt3:begin
   dt3_nano<=in_t[31:0];
   dt3_sec<=in_t[63:32];
   dt3_epoch<=in_t[79:64];
   state_slave<=slave_compute_delay;
  end
  
  
  slave_compute_delay:begin
  if(delay_cnt==delay_cnt_max) begin
     delay_nano<=delay_nano_t;
     state_slave<=slave_wait_s_sync;
  end
  else begin
   delay_cnt<=delay_cnt+32'b1;
  end
  end
  
 //閺冨爼鎸撻崥灞绢�?
  slave_wait_s_sync:begin
   if(rx_gptp_rd_vaild[0]) begin
    state_slave<=slave_rv_sst2;
	 rx_gptp_rd_addr<=8'b1;
    rx_gptp_rd_ready<=1'b1;
   end
  end
  
  slave_rv_sst2:begin
   rx_gptp_rd_ready<=1'b0;
	in_t<=rx_gptp_rd_data;
	state_slave<=slave_rv2_sst2;
  end
  
  slave_rv2_sst2:begin
   sst2_nano<=in_t[31:0];
   sst2_sec<=in_t[63:32];
    sst2_epoch<=in_t[79:64];
   state_slave<=slave_wait_s_fu;
  end
  
  slave_wait_s_fu:begin
   if(rx_gptp_rd_vaild[1]) begin
    state_slave<=slave_rv_sst1;
	 rx_gptp_rd_addr<=8'b10;
    rx_gptp_rd_ready<=1'b1;
   end	 
  end
  
  slave_rv_sst1:begin
   rx_gptp_rd_ready<=1'b0;
	in_t<=rx_gptp_rd_data;
	state_slave<=slave_rv2_sst1;
  end
  
  slave_rv2_sst1:begin
   sst1_nano<=in_t[31:0];
   sst1_sec<=in_t[63:32];
   sst1_epoch<=in_t[79:64];
   state_slave<= slave_get_rtc;
  end
  
  slave_get_rtc:begin
   in_t[31:0]<= rtc_nanosec_field;
   in_t[63:32]<=  rtc_sec_field;
	in_t[79:64] <= rtc_epoch_field;
	state_slave<=slave_get2_rtc;
  end
  
  slave_get2_rtc:begin
    sstb_nano<=in_t[31:0];
    sstb_sec<=in_t[63:32];
    sstb_epoch<=in_t[79:64];
    state_slave<=slave_compute_sync;
  end
  
  slave_compute_sync:begin
   if(sync_cnt==sync_cnt_max) begin
    updata_way<=updata_way_t;
      if(updata_way_t) begin
	    offset_nano  <= offset_nano+offset_nano_t;
		offset_sec<=offset_sec+offset_sec_t;
	    offset_epoch	<= offset_epoch+offset_epoch_t;
	    fund_nano	<= 'b0;
		fund_sec<='b0;
		fund_epoch<= 'b0;
	  end
	  else begin
	    offset_nano  <= 'b0;
		offset_sec<= 'b0;
	    offset_epoch	<= 'b0;
	    fund_nano	<= fund_nano_t;
		fund_sec<= fund_sec_t;
		fund_epoch<= fund_epoch_t;	  
	  end
	 state_slave<=slave_updata_sync;
	end
	else begin
	 sync_cnt<=sync_cnt+32'b1;
	end
  end
  
  slave_updata_sync:begin
    gptp_vaild<=1'b1;
    state_slave<=slave_updata2_sync;
  end
  
  slave_updata2_sync:begin
   gptp_vaild<=1'b0;
    state_slave<=slave_idle;
  end
  
 endcase
 end 
end


assign gptp_sw=updata_way;//1 offset 0 ����ʱ��
assign syntonised_nanosec_field_r =fund_nano;
assign syntonised_sec_field_r=fund_sec;
assign syntonised_epoch_field_r=fund_epoch;
assign nanosec_offset=offset_nano[29:0] ;
assign sec_offset=offset_sec;
assign epoch_offset=offset_epoch;
endmodule






/*
module gptp2(
input clk,
input reset,//楂樼數骞虫湁�??

//rtc
output gptp_vaild,
input rtc_ready,//鐩墠鎭掍负1
output gptp_sw,
  //鏇存柊鍙傛暟
  output [31:0] syntonised_nanosec_field_r,
  output [31:0] syntonised_sec_field_r,
  output [15:0] syntonised_epoch_field_r,
  
  output [29:0] nanosec_offset ,//�??30�??
  output [31:0] epoch_offset,//鍒濆鍊间竴瀹氳涓?0
  output [15:0] sec_offset  ,
  
  output [25:0] rtc_increment,//鍒濆?间负�??灏忚嚜澧為噺
  //rtc 閲囨�?
  input [31:0]                        rtc_nanosec_field,
  input [31:0]                        rtc_sec_field,
  input [15:0]                        rtc_epoch_field,
  
//rx �??
input [7:0] rx_gptp_rd_vaild,//鎸囨槑鎺ユ敹鍒颁綍绉嶅抚
input [79:0] rx_gptp_rd_data,
output reg [7:0] rx_gptp_rd_addr,//璇诲湴鍧?
output reg rx_gptp_rd_ready, //璇讳娇鑳? 锛岀粰鍑轰娇鑳戒笅涓?涓猚lk璇诲埌鏁版嵁


//tx �??
input [79:0] gptp_rd_data,
output reg [7:0]gptp_rd_addr,//璇婚兘鏄粺�??缁欏嚭鍦板潃鍚庣殑涓?涓猚lk�??

//tx �??
output reg [7:0] gptp_wr_addr,
output reg [79:0] gptp_wr_data,
output reg gptp_wr_vaild,
input gptp_wr_ready//琛ㄦ槑褰撳墠甯у彂閫佸嚭鍘讳簡



);




reg state_pos;
localparam pos_slave=1'b0;
localparam pos_master=1'b1;
reg [5:0] state_master;
localparam master_idle=5'b0;
localparam master_wait_preq=5'd1;
localparam master_rv_preq=5'd2;
reg [5:0] state_slave;

reg [79:0] dt1;
reg [79:0] dt2;
reg [79:0] dt3;
reg [79:0] dt4;
reg [79:0] st1;
reg [79:0] st2;
reg [79:0] st3;
reg [79:0] st4;
reg [79:0] sst1;
reg [79:0] sst2;
reg [79:0] sstb;
reg [79:0] ssta;

//涓讳粠鎺у�?
reg pos_ready;//缃珮鐘�??佹満鎵嶅彲杩愯锛岃〃绀鸿杩涜鐘�??佸垏�??
wire pos=pos_master;//鏇存敼涓讳粠鐘舵??
always @(posedge clk)
begin
 if(reset)
 begin
  pos_ready<=1'b0;
 end
 else
 begin
  pos_ready<=1'b1;
 end
 state_pos<=pos;
end

wire reset_pos=(~pos)|reset;//鍒囨崲鐘�??侊紝鐘舵?�?渶瑕佸�??


always@(posedge clk)
begin
 if(reset_pos) begin
  state_master<=5'b0;
  state_slave<=5'b0;
  rx_gptp_rd_ready<=1'b0;
  gptp_wr_vaild<=1'b0;
 end
 else if(state_pos==pos_master) begin
 case(state_master)
  master_idle:begin//鏈坊鍔犺�??
   rx_gptp_rd_ready<=1'b0;
	gptp_wr_vaild<=1'b0;
	state_master<=master_send_sync1
  end
 
  //璁＄畻R
  //涓棿鍙兘�??瑕佺瓑寰?
  master_send_sync1:begin
   gptp_wr_addr<=8'b0;
	gptp_wr_data<=80'b0;
	gptp_wr_vaild<=1'b1;
	state_master<=master_send2_sync1;
  end
  
  master_send2_sync1:begin
   gptp_wr_vaild<=1'b0;
	if(gptp_wr_ready) begin
	 gptp_rd_addr<=8'b0;
	 state_master<=master_send_fu1;
	end
  end
  
  master_send_fu1:begin
   gptp_wr_addr<=8'b1;
	gptp_wr_data<=gptp_rd_data;
	gptp_wr_vaild<=1'b1;
  end
  
  master_send2_fu1:begin
    gptp_wr_vaild<=1'b0;
    if(gptp_wr_ready)begin
	  state_master<=master_send_sync2;
	 end
  end
  
  master_send_sync2:begin
   gptp_wr_addr<=8'b0;
	gptp_wr_data<=80'b0;
	gptp_wr_vaild<=1'b1;
	state_master<=master_send2_sync2;
  end
  
  master_send2_sync2:begin
   gptp_wr_vaild<=1'b0;
	if(gptp_wr_ready) begin
	 gptp_rd_addr<=8'b0;
	 state_master<=master_send_fu2;
	end
  end
  
  master_send_fu2:begin
   gptp_wr_addr<=8'b1;
	gptp_wr_data<=gptp_rd_data;
	gptp_wr_vaild<=1'b1;
	state_master<=master_send2_fu2;
  end
  
  master_send2_fu2:begin
    gptp_wr_vaild<=1'b0;
    if(gptp_wr_ready)begin
	  state_master<=master_wait_preq;
	 end
  end
  
  //璁＄畻delay
  master_wait_preq:begin
   if(rx_gptp_rd_vaild[2]) begin
    state_master<=master_rv_preq;
   end
  end
  
  master_rv_preq:begin
   rx_gptp_rd_addr<=8'b100;
   rx_gptp_rd_ready<=1'b1;
	state_master<=master_send_presp;
  end
 
  master_send_presp:begin
   rx_gptp_rd_ready<=1'b0;
   gptp_wr_addr<=8'b1000;
	gptp_wr_data<=rx_gptp_rd_data;
	gptp_wr_vaild<=1'b1;
	state_master<=master_send2_presp;
  end
 
  master_send2_presp:begin
   gptp_wr_vaild<=1'b0;
	if(gptp_wr_ready) begin
	 state_master<=master_send_pfu;
	 gptp_rd_addr<=8'b1000;
	end
  end
  
  master_send_pfu:begin
   gptp_wr_addr<=8'b10000;
	gptp_wr_data<=gptp_rd_data;
	gptp_wr_vaild<=1'b1;
	state_master<=master_send2_pfu;
  end
  
  master_send2_pfu:begin
   gptp_wr_vaild<=1'b0;
	if(gptp_wr_ready) begin
	 state_master<=master_send_s_sync;
	end
  end
  
  //鏃堕挓鍚屾
  master_send_s_sync:begin
   gptp_wr_addr<=8'b0;
	gptp_wr_data<=80'b0;
	gptp_wr_vaild<=1'b1;
	state_master<=master_send2_s_sync;
  end
  
  master_send2_s_sync:begin
   gptp_wr_vaild<=1'b0;
	if(gptp_wr_ready) begin
	 state_master<=master_send_s_fu;
	 gptp_rd_addr<=8'b0;
	end
  end
  
  master_send_s_fu:begin
   gptp_wr_addr<=8'b10;
	gptp_wr_data<=gptp_rd_data;
	gptp_wr_vaild<=1'b1;
	state_master<=master_send2_s_fu;
  end
  
  master_send2_s_fu:begin
   gptp_wr_vaild<=1'b0;
	if(gptp_wr_ready) begin
	  state_master<=master_idle;
	end
  end
 end
 
 else if(state_pos==pos_slave)begin
 case(state_slave)
  slave_idle:begin
   rx_gptp_rd_ready<=1'b0;
	gptp_wr_vaild<=1'b0;
	state_slave<=slave_wait_sync1;
  end
  
  //璁＄畻r
  slave_wait_sync1:begin
   if(rx_gptp_rd_vaild[0]) begin
	   rx_gptp_rd_addr<=8'b0;
      rx_gptp_rd_ready<=1'b1;
		state_slave<=slave_rv_st2
	end
  end
  
  
  slave_rv_st2:begin
   st2<=rx_gptp_rd_data;
	rx_gptp_rd_ready<=1'b0;
   state_slave<=slave_wait_fu1;
  end
  
  slave_wait_fu1:begin
   if(rx_gptp_rd_vaild[1]) begin
	   rx_gptp_rd_addr<=8'b10;
      rx_gptp_rd_ready<=1'b1;
		state_slave<=slave_rv_st1;
	 end
  end
  
  slave_rv_st1:begin
    st1<=rx_gptp_rd_data;
	 rx_gptp_rd_ready<=1'b0;
    state_slave<=slave_wait_sync2;
  end
  
  slave_wait_sync2:begin
    if(rx_gptp_rd_vaild[0]) begin
	   rx_gptp_rd_addr<=8'b0;
      rx_gptp_rd_ready<=1'b1;
		state_slave<=slave_rv_st4;
	 end
  end
  
  slave_rv_st4:begin
    st4<=rx_gptp_rd_data;
	 rx_gptp_rd_ready<=1'b0;
    state_slave<=slave_wait_fu2;
  end

  slave_wait_fu2:begin
   if(rx_gptp_rd_vaild[1]) begin
	   rx_gptp_rd_addr<=8'b10;
      rx_gptp_rd_ready<=1'b1;
		state_slave<=slave_rv_st3;
	 end
  end
  
  slave_rv_st3:begin
    st1<=rx_gptp_rd_data;
	 rx_gptp_rd_ready<=1'b0;
    state_slave<=slave_compute_r;
  end  
  
  slave_compute_r:begin
   state_slave<=slave_send_preq;
  end
  
  //璁＄畻delay
  slave_send_preq:begin
   gptp_wr_addr<=8'b100;
	gptp_wr_data<=80'b0;
	gptp_wr_vaild<=1'b1;
	state_slave<=master_send2_fu2;
  end
  
  salve_send2_preq:begin
    gptp_wr_vaild<=1'b0;
    if(gptp_wr_ready)begin
	  gptp_rd_addr<=8'b100;
	  state_slave<=slave_rv_dt1;
	 end
  end
 
  slave_rv_dt1:begin
   dt1<=gptp_rd_data;
   if(rx_gptp_rd_vaild[3]) begin
    state_salve<=slave_rv_presp;
	 rx_gptp_rd_addr<=8'b1000;
    rx_gptp_rd_ready<=1'b1;
   end
	else begin
	 state_salve<=slave_wait_presp;
	end
  end
  
  slave_wait_presp:begin
   if(rx_gptp_rd_vaild[3]) begin
    state_salve<=slave_rv_dt4;
	 rx_gptp_rd_addr<=8'b1000;
    rx_gptp_rd_ready<=1'b1;
   end
  end
  
  slave_rv_dt4:begin
   rx_gptp_rd_ready<=1'b0;
	dt4<=rx_gptp_rd_data;
	state_salve<=slave_rv_dt2;
  end
  
  slave_rv_dt2:begin//�??鑸潵璇村綋鍓嶄綅缃斁鐨勫氨鏄渶瑕佺殑锛屼絾鏄甯ф湁涓や釜鏃堕棿鎴筹紝�??瑕佹妸鎼哄甫鐨勬斁浣嶇疆8
    rx_gptp_rd_addr<=8'b10000000;
    rx_gptp_rd_ready<=1'b1;
	 state_salve<=slave_rv2_dt2;
  end
  
  slave_rv2_dt2:begin
   dt2<=rx_gptp_rd_data;
	rx_gptp_rd_ready<=1'b0;
	state_salve<=slave_wait_pfu;
  end
  
  slave_wait_pfu:begin
   if(rx_gptp_rd_vaild[4]) begin
	 state_salve<=slave_rv_dt3;
	 rx_gptp_rd_addr<=8'b10000;
    rx_gptp_rd_ready<=1'b1;
	end
  end
  
  
  slave_rv_dt3:begin
   rx_gptp_rd_ready<=1'b0;
	dt3<=rx_gptp_rd_data;
	state_salve<=slave_compute_delay;
  end
  
  slave_compute_delay:begin
   state_salve<=slave_wait_s_sync;
  end
  
 //鏃堕挓鍚屾
  slave_wait_s_sync:begin
   if(rx_gptp_rd_vaild[0]) begin
    state_salve<=slave_rv_sst2;
	 rx_gptp_rd_addr<=8'b0;
    rx_gptp_rd_ready<=1'b1;
   end
  end
  
  slave_rv_sst2:begin
   rx_gptp_rd_ready<=1'b0;
	sst2<=rx_gptp_rd_data;
	state_salve<=slave_wait_s_fu;
  end
  
  slave_wait_s_fu:begin
   if(rx_gptp_rd_vaild[1]) begin
    state_salve<=slave_rv_sst1;
	 rx_gptp_rd_addr<=8'b10;
    rx_gptp_rd_ready<=1'b1;
   end	 
  end
  
  slave_rv_sst1:begin
   rx_gptp_rd_ready<=1'b0;
	sst1<=rx_gptp_rd_data;
	state_salve<=slave_get_rtc;
  end
  
  slave_get_rtc:begin
   sstb[31:0]<= rtc_nanosec_field;
   sstb[63:32]<=  rtc_sec_field;
	sstb[79:64] <= rtc_epoch_field;
	state_salve<=slave_compute_sync;
  end
  
  slave_compute_sync:begin
  
  end
  
  slave_updata_sync:begin
  
  
  end
  
  
 end
end


endmodule
*/

