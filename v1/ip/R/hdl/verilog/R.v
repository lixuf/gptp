// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2018.3
// Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="R,hls_ip_2018_3,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xczu9eg-ffvb1156-2-i,HLS_INPUT_CLOCK=8.000000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=6.393000,HLS_SYN_LAT=16,HLS_SYN_TPT=1,HLS_SYN_MEM=0,HLS_SYN_DSP=7,HLS_SYN_FF=1243,HLS_SYN_LUT=2461,HLS_VERSION=2018_3}" *)

module R (
        ap_clk,
        ap_rst,
        t4_sec_V,
        t2_sec_V,
        t3_sec_V,
        t1_sec_V,
        t1,
        t2,
        t3,
        t4,
        found_clock,
        increment_nano_V,
        increment_nano_V_ap_vld,
        increment_subnano_V,
        increment_subnano_V_ap_vld,
        ap_return
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input  [47:0] t4_sec_V;
input  [47:0] t2_sec_V;
input  [47:0] t3_sec_V;
input  [47:0] t1_sec_V;
input  [31:0] t1;
input  [31:0] t2;
input  [31:0] t3;
input  [31:0] t4;
input  [31:0] found_clock;
output  [5:0] increment_nano_V;
output   increment_nano_V_ap_vld;
output  [19:0] increment_subnano_V;
output   increment_subnano_V_ap_vld;
output  [11:0] ap_return;

reg increment_nano_V_ap_vld;
reg increment_subnano_V_ap_vld;

wire   [31:0] t1_assign_fu_203_p2;
reg   [31:0] t1_assign_reg_527;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
wire    ap_block_state4_pp0_stage0_iter3;
wire    ap_block_state5_pp0_stage0_iter4;
wire    ap_block_state6_pp0_stage0_iter5;
wire    ap_block_state7_pp0_stage0_iter6;
wire    ap_block_state8_pp0_stage0_iter7;
wire    ap_block_state9_pp0_stage0_iter8;
wire    ap_block_state10_pp0_stage0_iter9;
wire    ap_block_state11_pp0_stage0_iter10;
wire    ap_block_state12_pp0_stage0_iter11;
wire    ap_block_state13_pp0_stage0_iter12;
wire    ap_block_state14_pp0_stage0_iter13;
wire    ap_block_state15_pp0_stage0_iter14;
wire    ap_block_state16_pp0_stage0_iter15;
wire    ap_block_state17_pp0_stage0_iter16;
wire    ap_block_pp0_stage0_11001;
wire   [31:0] t2_assign_fu_231_p2;
reg   [31:0] t2_assign_reg_532;
wire  signed [13:0] tmp_27_fu_237_p1;
reg  signed [13:0] tmp_27_reg_537;
reg  signed [13:0] tmp_27_reg_537_pp0_iter1_reg;
reg  signed [13:0] tmp_27_reg_537_pp0_iter2_reg;
reg  signed [13:0] tmp_27_reg_537_pp0_iter3_reg;
reg  signed [13:0] tmp_27_reg_537_pp0_iter4_reg;
reg  signed [13:0] tmp_27_reg_537_pp0_iter5_reg;
reg  signed [13:0] tmp_27_reg_537_pp0_iter6_reg;
reg  signed [13:0] tmp_27_reg_537_pp0_iter7_reg;
reg  signed [13:0] tmp_27_reg_537_pp0_iter8_reg;
reg  signed [13:0] tmp_27_reg_537_pp0_iter9_reg;
reg  signed [13:0] tmp_27_reg_537_pp0_iter10_reg;
reg  signed [13:0] tmp_27_reg_537_pp0_iter11_reg;
reg  signed [13:0] tmp_27_reg_537_pp0_iter12_reg;
reg  signed [13:0] tmp_27_reg_537_pp0_iter13_reg;
reg  signed [13:0] tmp_27_reg_537_pp0_iter14_reg;
reg  signed [13:0] tmp_27_reg_537_pp0_iter15_reg;
wire   [31:0] grp_fu_172_p1;
reg   [31:0] tmp_8_reg_542;
wire   [31:0] grp_fu_175_p1;
reg   [31:0] tmp_9_reg_547;
wire   [31:0] grp_fu_168_p2;
reg   [31:0] v_assign_reg_552;
wire   [53:0] man_V_2_fu_293_p3;
reg   [53:0] man_V_2_reg_558;
wire  signed [11:0] sh_amt_fu_331_p3;
reg  signed [11:0] sh_amt_reg_563;
wire   [11:0] tmp_24_fu_345_p1;
reg   [11:0] tmp_24_reg_569;
wire   [0:0] tmp_14_fu_349_p2;
reg   [0:0] tmp_14_reg_574;
wire   [0:0] sel_tmp7_fu_412_p2;
reg   [0:0] sel_tmp7_reg_579;
wire   [11:0] sel_tmp_fu_430_p3;
reg   [11:0] sel_tmp_reg_584;
wire   [0:0] sel_tmp11_fu_450_p2;
reg   [0:0] sel_tmp11_reg_589;
reg    ap_enable_reg_pp0_iter1;
wire    ap_block_pp0_stage0_subdone;
reg    ap_enable_reg_pp0_iter2;
reg    ap_enable_reg_pp0_iter3;
reg    ap_enable_reg_pp0_iter4;
reg    ap_enable_reg_pp0_iter5;
reg    ap_enable_reg_pp0_iter6;
reg    ap_enable_reg_pp0_iter7;
reg    ap_enable_reg_pp0_iter8;
reg    ap_enable_reg_pp0_iter9;
reg    ap_enable_reg_pp0_iter10;
reg    ap_enable_reg_pp0_iter11;
reg    ap_enable_reg_pp0_iter12;
reg    ap_enable_reg_pp0_iter13;
reg    ap_enable_reg_pp0_iter14;
reg    ap_enable_reg_pp0_iter15;
reg    ap_enable_reg_pp0_iter16;
wire    ap_block_pp0_stage0_01001;
wire    ap_block_pp0_stage0;
wire   [47:0] t1_sec_V_assign_fu_181_p2;
wire  signed [31:0] tmp_1_fu_187_p1;
wire   [31:0] tmp_2_fu_191_p2;
wire   [31:0] t1_assign_2_fu_197_p2;
wire   [47:0] tmp_4_fu_209_p2;
wire  signed [31:0] tmp_5_fu_215_p1;
wire   [31:0] tmp_6_fu_219_p2;
wire   [31:0] t2_assign_2_fu_225_p2;
wire   [63:0] d_assign_fu_178_p1;
wire   [63:0] ireg_V_fu_241_p1;
wire   [10:0] exp_tmp_V_fu_257_p4;
wire   [51:0] tmp_19_fu_271_p1;
wire   [52:0] tmp_fu_275_p3;
wire   [53:0] p_Result_1_fu_283_p1;
wire   [0:0] p_Result_s_fu_249_p3;
wire   [53:0] man_V_1_fu_287_p2;
wire   [62:0] tmp_13_fu_245_p1;
wire   [11:0] tmp_s_fu_267_p1;
wire   [11:0] F2_fu_307_p2;
wire   [0:0] tmp_3_fu_313_p2;
wire   [11:0] tmp_10_fu_319_p2;
wire   [11:0] tmp_11_fu_325_p2;
wire   [31:0] ireg_V_to_int_fu_361_p1;
wire   [0:0] tmp_26_fu_364_p3;
wire   [0:0] tmp_7_fu_301_p2;
wire   [0:0] tmp_12_fu_339_p2;
wire   [0:0] sel_tmp1_fu_380_p2;
wire   [0:0] sel_tmp2_fu_386_p2;
wire   [0:0] sel_tmp6_demorgan_fu_400_p2;
wire   [0:0] sel_tmp6_fu_406_p2;
wire   [0:0] sel_tmp8_fu_418_p2;
wire   [0:0] sel_tmp9_fu_424_p2;
wire   [11:0] tmp_18_fu_372_p3;
wire   [11:0] sel_tmp3_fu_392_p3;
wire   [0:0] sel_tmp21_demorgan_fu_438_p2;
wire   [0:0] tmp_15_fu_355_p2;
wire   [0:0] sel_tmp10_fu_444_p2;
wire  signed [31:0] sh_amt_cast_fu_456_p1;
wire   [53:0] tmp_16_fu_459_p1;
wire   [53:0] tmp_17_fu_463_p2;
wire   [0:0] sel_tmp4_fu_476_p2;
wire   [11:0] tmp_25_fu_468_p1;
wire   [11:0] tmp_20_fu_472_p2;
wire   [11:0] sel_tmp5_fu_480_p3;
wire   [11:0] r_V_fu_487_p3;
wire  signed [13:0] res_V_fu_520_p2;
wire   [7:0] tmp_28_fu_508_p1;
wire   [11:0] res_V_fu_520_p1;
reg   [0:0] ap_NS_fsm;
wire    ap_reset_idle_pp0;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
wire   [13:0] res_V_fu_520_p10;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_enable_reg_pp0_iter3 = 1'b0;
#0 ap_enable_reg_pp0_iter4 = 1'b0;
#0 ap_enable_reg_pp0_iter5 = 1'b0;
#0 ap_enable_reg_pp0_iter6 = 1'b0;
#0 ap_enable_reg_pp0_iter7 = 1'b0;
#0 ap_enable_reg_pp0_iter8 = 1'b0;
#0 ap_enable_reg_pp0_iter9 = 1'b0;
#0 ap_enable_reg_pp0_iter10 = 1'b0;
#0 ap_enable_reg_pp0_iter11 = 1'b0;
#0 ap_enable_reg_pp0_iter12 = 1'b0;
#0 ap_enable_reg_pp0_iter13 = 1'b0;
#0 ap_enable_reg_pp0_iter14 = 1'b0;
#0 ap_enable_reg_pp0_iter15 = 1'b0;
#0 ap_enable_reg_pp0_iter16 = 1'b0;
end

R_fdiv_32ns_32ns_bkb #(
    .ID( 1 ),
    .NUM_STAGE( 10 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
R_fdiv_32ns_32ns_bkb_U1(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(tmp_8_reg_542),
    .din1(tmp_9_reg_547),
    .ce(1'b1),
    .dout(grp_fu_168_p2)
);

R_uitofp_32ns_32_cud #(
    .ID( 1 ),
    .NUM_STAGE( 4 ),
    .din0_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
R_uitofp_32ns_32_cud_U2(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(t1_assign_reg_527),
    .ce(1'b1),
    .dout(grp_fu_172_p1)
);

R_uitofp_32ns_32_cud #(
    .ID( 1 ),
    .NUM_STAGE( 4 ),
    .din0_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
R_uitofp_32ns_32_cud_U3(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(t2_assign_reg_532),
    .ce(1'b1),
    .dout(grp_fu_175_p1)
);

R_fpext_32ns_64_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 32 ),
    .dout_WIDTH( 64 ))
R_fpext_32ns_64_1_1_U4(
    .din0(v_assign_reg_552),
    .dout(d_assign_fu_178_p1)
);

R_mul_mul_14s_12ndEe #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 14 ),
    .din1_WIDTH( 12 ),
    .dout_WIDTH( 14 ))
R_mul_mul_14s_12ndEe_U5(
    .din0(tmp_27_reg_537_pp0_iter15_reg),
    .din1(res_V_fu_520_p1),
    .dout(res_V_fu_520_p2)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter1 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter10 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter10 <= ap_enable_reg_pp0_iter9;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter11 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter11 <= ap_enable_reg_pp0_iter10;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter12 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter12 <= ap_enable_reg_pp0_iter11;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter13 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter13 <= ap_enable_reg_pp0_iter12;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter14 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter14 <= ap_enable_reg_pp0_iter13;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter15 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter15 <= ap_enable_reg_pp0_iter14;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter16 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter16 <= ap_enable_reg_pp0_iter15;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter3 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter4 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter4 <= ap_enable_reg_pp0_iter3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter5 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter5 <= ap_enable_reg_pp0_iter4;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter6 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter6 <= ap_enable_reg_pp0_iter5;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter7 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter7 <= ap_enable_reg_pp0_iter6;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter8 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter8 <= ap_enable_reg_pp0_iter7;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter9 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter9 <= ap_enable_reg_pp0_iter8;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        man_V_2_reg_558 <= man_V_2_fu_293_p3;
        sel_tmp11_reg_589 <= sel_tmp11_fu_450_p2;
        sel_tmp7_reg_579 <= sel_tmp7_fu_412_p2;
        sel_tmp_reg_584 <= sel_tmp_fu_430_p3;
        sh_amt_reg_563 <= sh_amt_fu_331_p3;
        tmp_14_reg_574 <= tmp_14_fu_349_p2;
        tmp_24_reg_569 <= tmp_24_fu_345_p1;
        tmp_27_reg_537_pp0_iter10_reg <= tmp_27_reg_537_pp0_iter9_reg;
        tmp_27_reg_537_pp0_iter11_reg <= tmp_27_reg_537_pp0_iter10_reg;
        tmp_27_reg_537_pp0_iter12_reg <= tmp_27_reg_537_pp0_iter11_reg;
        tmp_27_reg_537_pp0_iter13_reg <= tmp_27_reg_537_pp0_iter12_reg;
        tmp_27_reg_537_pp0_iter14_reg <= tmp_27_reg_537_pp0_iter13_reg;
        tmp_27_reg_537_pp0_iter15_reg <= tmp_27_reg_537_pp0_iter14_reg;
        tmp_27_reg_537_pp0_iter2_reg <= tmp_27_reg_537_pp0_iter1_reg;
        tmp_27_reg_537_pp0_iter3_reg <= tmp_27_reg_537_pp0_iter2_reg;
        tmp_27_reg_537_pp0_iter4_reg <= tmp_27_reg_537_pp0_iter3_reg;
        tmp_27_reg_537_pp0_iter5_reg <= tmp_27_reg_537_pp0_iter4_reg;
        tmp_27_reg_537_pp0_iter6_reg <= tmp_27_reg_537_pp0_iter5_reg;
        tmp_27_reg_537_pp0_iter7_reg <= tmp_27_reg_537_pp0_iter6_reg;
        tmp_27_reg_537_pp0_iter8_reg <= tmp_27_reg_537_pp0_iter7_reg;
        tmp_27_reg_537_pp0_iter9_reg <= tmp_27_reg_537_pp0_iter8_reg;
        tmp_8_reg_542 <= grp_fu_172_p1;
        tmp_9_reg_547 <= grp_fu_175_p1;
        v_assign_reg_552 <= grp_fu_168_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        t1_assign_reg_527 <= t1_assign_fu_203_p2;
        t2_assign_reg_532 <= t2_assign_fu_231_p2;
        tmp_27_reg_537 <= tmp_27_fu_237_p1;
        tmp_27_reg_537_pp0_iter1_reg <= tmp_27_reg_537;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter16 == 1'b0) & (ap_enable_reg_pp0_iter15 == 1'b0) & (ap_enable_reg_pp0_iter14 == 1'b0) & (ap_enable_reg_pp0_iter13 == 1'b0) & (ap_enable_reg_pp0_iter12 == 1'b0) & (ap_enable_reg_pp0_iter11 == 1'b0) & (ap_enable_reg_pp0_iter10 == 1'b0) & (ap_enable_reg_pp0_iter9 == 1'b0) & (ap_enable_reg_pp0_iter8 == 1'b0) & (ap_enable_reg_pp0_iter7 == 1'b0) & (ap_enable_reg_pp0_iter6 == 1'b0) & (ap_enable_reg_pp0_iter5 == 1'b0) & (ap_enable_reg_pp0_iter4 == 1'b0) & (ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (1'b1 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

assign ap_reset_idle_pp0 = 1'b0;

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter16 == 1'b1))) begin
        increment_nano_V_ap_vld = 1'b1;
    end else begin
        increment_nano_V_ap_vld = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter16 == 1'b1))) begin
        increment_subnano_V_ap_vld = 1'b1;
    end else begin
        increment_subnano_V_ap_vld = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign F2_fu_307_p2 = (12'd1075 - tmp_s_fu_267_p1);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_01001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_subdone = ~(1'b1 == 1'b1);

assign ap_block_state10_pp0_stage0_iter9 = ~(1'b1 == 1'b1);

assign ap_block_state11_pp0_stage0_iter10 = ~(1'b1 == 1'b1);

assign ap_block_state12_pp0_stage0_iter11 = ~(1'b1 == 1'b1);

assign ap_block_state13_pp0_stage0_iter12 = ~(1'b1 == 1'b1);

assign ap_block_state14_pp0_stage0_iter13 = ~(1'b1 == 1'b1);

assign ap_block_state15_pp0_stage0_iter14 = ~(1'b1 == 1'b1);

assign ap_block_state16_pp0_stage0_iter15 = ~(1'b1 == 1'b1);

assign ap_block_state17_pp0_stage0_iter16 = ~(1'b1 == 1'b1);

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_block_state4_pp0_stage0_iter3 = ~(1'b1 == 1'b1);

assign ap_block_state5_pp0_stage0_iter4 = ~(1'b1 == 1'b1);

assign ap_block_state6_pp0_stage0_iter5 = ~(1'b1 == 1'b1);

assign ap_block_state7_pp0_stage0_iter6 = ~(1'b1 == 1'b1);

assign ap_block_state8_pp0_stage0_iter7 = ~(1'b1 == 1'b1);

assign ap_block_state9_pp0_stage0_iter8 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_return = r_V_fu_487_p3;

assign exp_tmp_V_fu_257_p4 = {{ireg_V_fu_241_p1[62:52]}};

assign increment_nano_V = {{res_V_fu_520_p2[13:8]}};

assign increment_subnano_V = {{tmp_28_fu_508_p1}, {12'd0}};

assign ireg_V_fu_241_p1 = d_assign_fu_178_p1;

assign ireg_V_to_int_fu_361_p1 = v_assign_reg_552;

assign man_V_1_fu_287_p2 = (54'd0 - p_Result_1_fu_283_p1);

assign man_V_2_fu_293_p3 = ((p_Result_s_fu_249_p3[0:0] === 1'b1) ? man_V_1_fu_287_p2 : p_Result_1_fu_283_p1);

assign p_Result_1_fu_283_p1 = tmp_fu_275_p3;

assign p_Result_s_fu_249_p3 = ireg_V_fu_241_p1[32'd63];

assign r_V_fu_487_p3 = ((sel_tmp11_reg_589[0:0] === 1'b1) ? tmp_20_fu_472_p2 : sel_tmp5_fu_480_p3);

assign res_V_fu_520_p1 = res_V_fu_520_p10;

assign res_V_fu_520_p10 = r_V_fu_487_p3;

assign sel_tmp10_fu_444_p2 = (sel_tmp21_demorgan_fu_438_p2 ^ 1'd1);

assign sel_tmp11_fu_450_p2 = (tmp_15_fu_355_p2 & sel_tmp10_fu_444_p2);

assign sel_tmp1_fu_380_p2 = (tmp_7_fu_301_p2 ^ 1'd1);

assign sel_tmp21_demorgan_fu_438_p2 = (tmp_3_fu_313_p2 | sel_tmp6_demorgan_fu_400_p2);

assign sel_tmp2_fu_386_p2 = (tmp_12_fu_339_p2 & sel_tmp1_fu_380_p2);

assign sel_tmp3_fu_392_p3 = ((sel_tmp2_fu_386_p2[0:0] === 1'b1) ? tmp_24_fu_345_p1 : 12'd0);

assign sel_tmp4_fu_476_p2 = (tmp_14_reg_574 & sel_tmp7_reg_579);

assign sel_tmp5_fu_480_p3 = ((sel_tmp4_fu_476_p2[0:0] === 1'b1) ? tmp_25_fu_468_p1 : sel_tmp_reg_584);

assign sel_tmp6_demorgan_fu_400_p2 = (tmp_7_fu_301_p2 | tmp_12_fu_339_p2);

assign sel_tmp6_fu_406_p2 = (sel_tmp6_demorgan_fu_400_p2 ^ 1'd1);

assign sel_tmp7_fu_412_p2 = (tmp_3_fu_313_p2 & sel_tmp6_fu_406_p2);

assign sel_tmp8_fu_418_p2 = (tmp_14_fu_349_p2 ^ 1'd1);

assign sel_tmp9_fu_424_p2 = (sel_tmp8_fu_418_p2 & sel_tmp7_fu_412_p2);

assign sel_tmp_fu_430_p3 = ((sel_tmp9_fu_424_p2[0:0] === 1'b1) ? tmp_18_fu_372_p3 : sel_tmp3_fu_392_p3);

assign sh_amt_cast_fu_456_p1 = sh_amt_reg_563;

assign sh_amt_fu_331_p3 = ((tmp_3_fu_313_p2[0:0] === 1'b1) ? tmp_10_fu_319_p2 : tmp_11_fu_325_p2);

assign t1_assign_2_fu_197_p2 = (t3 - t1);

assign t1_assign_fu_203_p2 = (tmp_2_fu_191_p2 + t1_assign_2_fu_197_p2);

assign t1_sec_V_assign_fu_181_p2 = (t3_sec_V - t1_sec_V);

assign t2_assign_2_fu_225_p2 = (t4 - t2);

assign t2_assign_fu_231_p2 = (tmp_6_fu_219_p2 + t2_assign_2_fu_225_p2);

assign tmp_10_fu_319_p2 = ($signed(12'd4088) + $signed(F2_fu_307_p2));

assign tmp_11_fu_325_p2 = (12'd8 - F2_fu_307_p2);

assign tmp_12_fu_339_p2 = ((F2_fu_307_p2 == 12'd8) ? 1'b1 : 1'b0);

assign tmp_13_fu_245_p1 = ireg_V_fu_241_p1[62:0];

assign tmp_14_fu_349_p2 = ((sh_amt_fu_331_p3 < 12'd54) ? 1'b1 : 1'b0);

assign tmp_15_fu_355_p2 = ((sh_amt_fu_331_p3 < 12'd12) ? 1'b1 : 1'b0);

assign tmp_16_fu_459_p1 = $unsigned(sh_amt_cast_fu_456_p1);

assign tmp_17_fu_463_p2 = $signed(man_V_2_reg_558) >>> tmp_16_fu_459_p1;

assign tmp_18_fu_372_p3 = ((tmp_26_fu_364_p3[0:0] === 1'b1) ? 12'd4095 : 12'd0);

assign tmp_19_fu_271_p1 = ireg_V_fu_241_p1[51:0];

assign tmp_1_fu_187_p1 = t1_sec_V_assign_fu_181_p2[31:0];

assign tmp_20_fu_472_p2 = tmp_24_reg_569 << sh_amt_reg_563;

assign tmp_24_fu_345_p1 = man_V_2_fu_293_p3[11:0];

assign tmp_25_fu_468_p1 = tmp_17_fu_463_p2[11:0];

assign tmp_26_fu_364_p3 = ireg_V_to_int_fu_361_p1[32'd31];

assign tmp_27_fu_237_p1 = found_clock[13:0];

assign tmp_28_fu_508_p1 = res_V_fu_520_p2[7:0];

assign tmp_2_fu_191_p2 = ($signed({{1'b0}, {32'd1000000000}}) * $signed(tmp_1_fu_187_p1));

assign tmp_3_fu_313_p2 = (($signed(F2_fu_307_p2) > $signed(12'd8)) ? 1'b1 : 1'b0);

assign tmp_4_fu_209_p2 = (t4_sec_V - t2_sec_V);

assign tmp_5_fu_215_p1 = tmp_4_fu_209_p2[31:0];

assign tmp_6_fu_219_p2 = ($signed({{1'b0}, {32'd1000000000}}) * $signed(tmp_5_fu_215_p1));

assign tmp_7_fu_301_p2 = ((tmp_13_fu_245_p1 == 63'd0) ? 1'b1 : 1'b0);

assign tmp_fu_275_p3 = {{1'd1}, {tmp_19_fu_271_p1}};

assign tmp_s_fu_267_p1 = exp_tmp_V_fu_257_p4;

endmodule //R
