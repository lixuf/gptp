module rtc #
(
  parameter         C_IS_EVAL            = 1,
  parameter         C_SIMULATION_MODE    = 0,
  parameter         C_XDEVICEFAMILY      = "Virtex7",
  parameter         C_S_AXI_ADDR_WIDTH   = 32
)

(

  
  input                                rtc_reset,
  input                                rtc_clk,

  //调整后的时钟
  output [31:0]                        rtc_nanosec_field,
  output [31:0]                        rtc_sec_field,
  output [15:0]                        rtc_epoch_field,

  //基本时钟
  output [31:0]                        syntonised_nanosec_field,
  output [31:0]                        syntonised_sec_field,
  output [15:0]                        syntonised_epoch_field,

  //更新参数
  input [31:0] syntonised_nanosec_field_r,
  input [31:0] syntonised_sec_field_r,
  input [15:0] syntonised_epoch_field_r,
  
  input [29:0] nanosec_offset ,
  input [31:0] sec_offset,//初始值一定要�?0
  input [15:0] epoch_offset  ,
  
  input [25:0] rtc_increment,//初�?�为�?小自增量
  
  input gptp_vaild,
  output rtc_ready,
  
  input gptp_sw //1更新offset 0更新基本时钟 vaild的同时给�?

);


  wire rejust_fundement_f= (~gptp_vaild|gptp_sw);//0表示要修改基本时�?


  //基本时钟
  reg  [28:0]    rtc_syntonised_subnano;     
  reg  [31:0]    rtc_syntonised_nano;        
  reg  [47:0]    rtc_syntonised_sec;         
  reg            rtc_syntonised_nano_wrap;//表示纳秒域的进位

  
  //wire [25:0]    rtc_increment;//亚纳秒域偏移
  wire [25:0]    rtc_increment_int;
  assign rtc_increment_int = rtc_increment;
  
  //同步后的时钟
  reg  [31:0]    rtc_synchronized_nano;      
  reg  [47:0]    rtc_synchronized_sec;       
  reg  [31:0]    rtc_synchronized_nano_reg1;//rtc_synchronized_nano延迟�?个周�?
  wire           inc_rtc_seconds;//表示纳秒域有进位
  reg  [31:0]    rtc_nano_plus_offset;

  wire           offset_update;//控制秒域更新
  reg            offset_update_reg1;
  reg            offset_update_reg2;

  //wire [29:0]    nanosec_offset;//偏移
  //wire [31:0]    sec_offset;
  //wire [15:0]    epoch_offset;

 
  
  always @(posedge rtc_clk)//基本时钟修正
  begin
    if (rtc_reset == 0 ) begin
      rtc_syntonised_subnano   <= 29'h0;
      rtc_syntonised_nano[8:0] <= 9'h0;
    end
    else if (rejust_fundement_f) begin
      rtc_syntonised_subnano   <= rtc_syntonised_subnano +
                               {3'b0, rtc_increment_int};//亚纳秒域修正
      rtc_syntonised_nano[8:0] <= rtc_syntonised_subnano[28:20];//亚纳秒向纳秒的进位，采用错位赋�?�的方法
 
    end
	 else begin
     rtc_syntonised_nano[8:0] <=syntonised_nanosec_field_r[8:0];
	 rtc_syntonised_subnano[28:20] <= 9'b0;//syx:对纳秒域修正是不是得考虑亚纳秒域的错位同时赋�?0
	 end
  end




  always @(posedge rtc_clk)
  begin
    if (rtc_reset == 0) begin
      rtc_syntonised_nano_wrap <= 1'b0;
    end

    else begin

      if (rtc_syntonised_nano[31:9] == 23'h1DCD64) begin//判断纳秒是否进位
        rtc_syntonised_nano_wrap <= 1'b1;
      end
      else begin
        rtc_syntonised_nano_wrap <= 1'b0;
      end

    end
  end



  always @(posedge rtc_clk)
  begin
    if (rtc_reset == 0) begin
       rtc_syntonised_nano[31:9] <= 23'h0;
    end
    else if ((!rtc_syntonised_subnano[28] & rtc_syntonised_nano[8])&rejust_fundement_f) begin

      if (rtc_syntonised_nano_wrap) begin//有进位则清零
        rtc_syntonised_nano[31:9] <= 23'h0;
      end
      else begin//否则按进位时间自�?
        rtc_syntonised_nano[31:9] <= rtc_syntonised_nano[31:9] + 1'b1;
      end

    end
	 else if(~rejust_fundement_f)
	 begin
	  rtc_syntonised_nano[31:9] <=syntonised_nanosec_field_r[31:9];
	 end
  end



  always @(posedge rtc_clk)//基本时钟修正
  begin
    if (rtc_reset == 0) begin
      rtc_syntonised_sec <= 48'b0;
    end
    else if ((!rtc_syntonised_subnano[28] & rtc_syntonised_nano[8])&rejust_fundement_f) begin

      if (rtc_syntonised_nano_wrap) begin
        rtc_syntonised_sec <= rtc_syntonised_sec + 1'b1;//当纳秒进位时，秒域自�?
      end
    end
	 else if(~rejust_fundement_f)
	 begin
	   rtc_syntonised_sec[31:0]<=syntonised_sec_field_r[31:0];
	   rtc_syntonised_sec[47:32]<=syntonised_epoch_field_r[15:0];
	 end
  end





  always @(posedge rtc_clk)
  begin
    if (rtc_reset == 0) begin
      rtc_nano_plus_offset        <= 32'b0;
      rtc_synchronized_nano       <= 32'b0;
    end
    else begin
	 rtc_nano_plus_offset    <= rtc_syntonised_nano + {2'b0, nanosec_offset};//产生纳秒域修正�??

  
      if (rtc_nano_plus_offset > 32'h3B9AC9FF) begin//32'h3B9AC9FF为纳秒域�?大�?�，超过要减�?
        rtc_synchronized_nano <= rtc_nano_plus_offset - 32'h3B9ACA00;
      end

      else begin
        rtc_synchronized_nano <= rtc_nano_plus_offset;
      end

    end
  end



  always @(posedge rtc_clk)
  begin
    if (rtc_reset == 0 ) begin
      rtc_synchronized_nano_reg1  <= 32'b0;
    end
    else begin
      rtc_synchronized_nano_reg1  <= rtc_synchronized_nano;//修正后的纳秒域�?�延迟一个clk
    end
  end




  assign inc_rtc_seconds = rtc_synchronized_nano_reg1[29] &
                           !rtc_synchronized_nano[29];//判断修正后的纳秒域�?�是否超过最大�?�，超过秒域�?要自�?




  always @(posedge rtc_clk)
  begin
    if (rtc_reset == 0 ) begin
      rtc_synchronized_sec <= 48'b0;
    end
    else begin
      if (offset_update_reg2) begin//修正使能信号要延�?2个clk是因为需要等待纳秒域的修正，与后面自�?1分开执行
        rtc_synchronized_sec <= rtc_syntonised_sec +//修正使能到来后，修正秒域
                                {epoch_offset, sec_offset};
      end
      else if (inc_rtc_seconds) begin
        rtc_synchronized_sec <= rtc_synchronized_sec + 1'b1;
      end
    end
  end
   
     
	  //采样输出
  assign rtc_nanosec_field = rtc_synchronized_nano_reg1;
  assign rtc_sec_field     = rtc_synchronized_sec[31:0];
  assign rtc_epoch_field   = rtc_synchronized_sec[47:32];

    
	 //输出基本时钟
  assign syntonised_nanosec_field = rtc_syntonised_nano;
  assign syntonised_sec_field     = rtc_syntonised_sec[31:0];
  assign syntonised_epoch_field   = rtc_syntonised_sec[47:32];




  always @(posedge rtc_clk)//秒域修正使能延迟两个周期
  begin
    if (rtc_reset == 0 ) begin
      offset_update_reg1     <= 1'b0;
      offset_update_reg2     <= 1'b0;
    end
    else begin
      offset_update_reg1     <= gptp_vaild&gptp_sw;
      offset_update_reg2     <= offset_update_reg1;
      end
    end
 





endmodule
