-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2018.3
-- Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Sync is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    t1_s_V : IN STD_LOGIC_VECTOR (47 downto 0);
    t1_n_V : IN STD_LOGIC_VECTOR (31 downto 0);
    t2_s_V : IN STD_LOGIC_VECTOR (47 downto 0);
    t2_n_V : IN STD_LOGIC_VECTOR (31 downto 0);
    t3_s_V : IN STD_LOGIC_VECTOR (47 downto 0);
    t3_n_V : IN STD_LOGIC_VECTOR (31 downto 0);
    tb_s_V : IN STD_LOGIC_VECTOR (47 downto 0);
    tb_n_V : IN STD_LOGIC_VECTOR (31 downto 0);
    of_s_V : OUT STD_LOGIC_VECTOR (47 downto 0);
    of_s_V_ap_vld : OUT STD_LOGIC;
    of_n_V : OUT STD_LOGIC_VECTOR (31 downto 0);
    of_n_V_ap_vld : OUT STD_LOGIC;
    ta_s_V : OUT STD_LOGIC_VECTOR (47 downto 0);
    ta_s_V_ap_vld : OUT STD_LOGIC;
    ta_n_V : OUT STD_LOGIC_VECTOR (31 downto 0);
    ta_n_V_ap_vld : OUT STD_LOGIC;
    delay_V : IN STD_LOGIC_VECTOR (31 downto 0);
    rv_V : IN STD_LOGIC_VECTOR (11 downto 0);
    ta_offset_V : IN STD_LOGIC_VECTOR (31 downto 0);
    f : OUT STD_LOGIC;
    f_ap_vld : OUT STD_LOGIC );
end;


architecture behav of Sync is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "Sync,hls_ip_2018_3,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xczu9eg-ffvb1156-2-i,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=7.453969,HLS_SYN_LAT=2,HLS_SYN_TPT=1,HLS_SYN_MEM=0,HLS_SYN_DSP=25,HLS_SYN_FF=644,HLS_SYN_LUT=1381,HLS_VERSION=2018_3}";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv78_3B9ACA00 : STD_LOGIC_VECTOR (77 downto 0) := "000000000000000000000000000000000000000000000000111011100110101100101000000000";
    constant ap_const_lv8_0 : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    constant ap_const_lv32_8 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001000";
    constant ap_const_lv32_55 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001010101";
    constant ap_const_lv32_27 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000100111";
    constant ap_const_lv161_lc_1 : STD_LOGIC_VECTOR (160 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000100010010111000001011111010000010011011010110100101001011001011100110001011010001";
    constant ap_const_lv32_6E : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001101110";
    constant ap_const_lv32_9D : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000010011101";
    constant ap_const_lv32_8D : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000010001101";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_C4653600 : STD_LOGIC_VECTOR (31 downto 0) := "11000100011001010011011000000000";

    signal ta_offset_V_read_reg_528 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm : STD_LOGIC_VECTOR (0 downto 0) := "1";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state2_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_state3_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal ta_offset_V_read_reg_528_pp0_iter1_reg : STD_LOGIC_VECTOR (31 downto 0);
    signal delay_V_read_reg_533 : STD_LOGIC_VECTOR (31 downto 0);
    signal delay_V_read_reg_533_pp0_iter1_reg : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_s_reg_540 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_s_reg_540_pp0_iter1_reg : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_4_fu_357_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_4_reg_545 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_4_reg_545_pp0_iter1_reg : STD_LOGIC_VECTOR (31 downto 0);
    signal ta_V_fu_377_p2 : STD_LOGIC_VECTOR (79 downto 0);
    signal ta_V_reg_550 : STD_LOGIC_VECTOR (79 downto 0);
    signal tmp_7_fu_383_p2 : STD_LOGIC_VECTOR (78 downto 0);
    signal tmp_7_reg_555 : STD_LOGIC_VECTOR (78 downto 0);
    signal tmp_6_fu_389_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_6_reg_560 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_6_reg_560_pp0_iter1_reg : STD_LOGIC_VECTOR (31 downto 0);
    signal ult_fu_403_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ult_reg_565 : STD_LOGIC_VECTOR (0 downto 0);
    signal ult_reg_565_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_8_reg_570 : STD_LOGIC_VECTOR (47 downto 0);
    signal tmp_9_reg_575 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_12_reg_580 : STD_LOGIC_VECTOR (47 downto 0);
    signal tmp_13_reg_585 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_enable_reg_pp0_iter2 : STD_LOGIC := '0';
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal ret_V_fu_187_p1 : STD_LOGIC_VECTOR (47 downto 0);
    signal ret_V_fu_187_p2 : STD_LOGIC_VECTOR (77 downto 0);
    signal tmp_cast_fu_193_p1 : STD_LOGIC_VECTOR (77 downto 0);
    signal t1_V_fu_197_p2 : STD_LOGIC_VECTOR (77 downto 0);
    signal ret_V_6_fu_211_p1 : STD_LOGIC_VECTOR (47 downto 0);
    signal r_V_4_fu_225_p0 : STD_LOGIC_VECTOR (31 downto 0);
    signal r_V_4_fu_225_p1 : STD_LOGIC_VECTOR (11 downto 0);
    signal tmp_5_fu_221_p1 : STD_LOGIC_VECTOR (43 downto 0);
    signal ret_V_6_fu_211_p2 : STD_LOGIC_VECTOR (77 downto 0);
    signal r_V_4_fu_225_p2 : STD_LOGIC_VECTOR (43 downto 0);
    signal lhs_V_fu_231_p3 : STD_LOGIC_VECTOR (85 downto 0);
    signal rhs_V_cast_fu_239_p1 : STD_LOGIC_VECTOR (85 downto 0);
    signal ret_V_7_fu_243_p2 : STD_LOGIC_VECTOR (85 downto 0);
    signal tmp_fu_249_p4 : STD_LOGIC_VECTOR (77 downto 0);
    signal tmp_cast_13_fu_263_p1 : STD_LOGIC_VECTOR (77 downto 0);
    signal t2_y_V_fu_267_p2 : STD_LOGIC_VECTOR (77 downto 0);
    signal ret_V_8_fu_281_p1 : STD_LOGIC_VECTOR (47 downto 0);
    signal r_V_5_fu_291_p0 : STD_LOGIC_VECTOR (31 downto 0);
    signal r_V_5_fu_291_p1 : STD_LOGIC_VECTOR (11 downto 0);
    signal ret_V_8_fu_281_p2 : STD_LOGIC_VECTOR (77 downto 0);
    signal r_V_5_fu_291_p2 : STD_LOGIC_VECTOR (43 downto 0);
    signal lhs_V_1_fu_297_p3 : STD_LOGIC_VECTOR (85 downto 0);
    signal rhs_V_1_cast_fu_305_p1 : STD_LOGIC_VECTOR (85 downto 0);
    signal ret_V_9_fu_309_p2 : STD_LOGIC_VECTOR (85 downto 0);
    signal tmp_2_fu_315_p4 : STD_LOGIC_VECTOR (77 downto 0);
    signal t1_V_cast8_fu_203_p1 : STD_LOGIC_VECTOR (78 downto 0);
    signal t2_V_cast_fu_259_p1 : STD_LOGIC_VECTOR (78 downto 0);
    signal tmp_3_fu_337_p2 : STD_LOGIC_VECTOR (78 downto 0);
    signal tmp_3_cast_fu_343_p1 : STD_LOGIC_VECTOR (79 downto 0);
    signal tb_V_fu_325_p1 : STD_LOGIC_VECTOR (79 downto 0);
    signal tmp_1_cast_fu_329_p1 : STD_LOGIC_VECTOR (32 downto 0);
    signal tmp_2_cast_fu_333_p1 : STD_LOGIC_VECTOR (32 downto 0);
    signal tmp2_fu_367_p2 : STD_LOGIC_VECTOR (32 downto 0);
    signal tmp2_cast_fu_373_p1 : STD_LOGIC_VECTOR (79 downto 0);
    signal tmp1_fu_361_p2 : STD_LOGIC_VECTOR (79 downto 0);
    signal t2_y_V_cast_fu_273_p1 : STD_LOGIC_VECTOR (78 downto 0);
    signal rhs_V_2_cast_fu_393_p1 : STD_LOGIC_VECTOR (77 downto 0);
    signal ret_V_5_fu_397_p2 : STD_LOGIC_VECTOR (77 downto 0);
    signal tmp_7_cast_fu_412_p1 : STD_LOGIC_VECTOR (79 downto 0);
    signal tmp_1_fu_409_p1 : STD_LOGIC_VECTOR (79 downto 0);
    signal mul2_fu_424_p1 : STD_LOGIC_VECTOR (79 downto 0);
    signal mul2_fu_424_p2 : STD_LOGIC_VECTOR (160 downto 0);
    signal of_V_fu_415_p2 : STD_LOGIC_VECTOR (79 downto 0);
    signal mul_fu_454_p1 : STD_LOGIC_VECTOR (79 downto 0);
    signal mul_fu_454_p2 : STD_LOGIC_VECTOR (160 downto 0);
    signal tmp_10_fu_486_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp5_fu_495_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp4_fu_500_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp3_fu_491_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_14_fu_512_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp6_fu_517_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_reset_idle_pp0 : STD_LOGIC;
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;
    signal mul2_fu_424_p10 : STD_LOGIC_VECTOR (160 downto 0);
    signal mul_fu_454_p10 : STD_LOGIC_VECTOR (160 downto 0);
    signal r_V_4_fu_225_p00 : STD_LOGIC_VECTOR (43 downto 0);
    signal r_V_5_fu_291_p00 : STD_LOGIC_VECTOR (43 downto 0);
    signal ret_V_6_fu_211_p10 : STD_LOGIC_VECTOR (77 downto 0);
    signal ret_V_8_fu_281_p10 : STD_LOGIC_VECTOR (77 downto 0);
    signal ret_V_fu_187_p10 : STD_LOGIC_VECTOR (77 downto 0);


begin




    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter1 <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter2_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
                end if; 
            end if;
        end if;
    end process;

    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                delay_V_read_reg_533 <= delay_V;
                delay_V_read_reg_533_pp0_iter1_reg <= delay_V_read_reg_533;
                ta_V_reg_550 <= ta_V_fu_377_p2;
                ta_offset_V_read_reg_528 <= ta_offset_V;
                ta_offset_V_read_reg_528_pp0_iter1_reg <= ta_offset_V_read_reg_528;
                tmp_12_reg_580 <= mul_fu_454_p2(157 downto 110);
                tmp_13_reg_585 <= mul_fu_454_p2(141 downto 110);
                tmp_4_reg_545 <= tmp_4_fu_357_p1;
                tmp_4_reg_545_pp0_iter1_reg <= tmp_4_reg_545;
                tmp_6_reg_560 <= tmp_6_fu_389_p1;
                tmp_6_reg_560_pp0_iter1_reg <= tmp_6_reg_560;
                tmp_7_reg_555 <= tmp_7_fu_383_p2;
                tmp_8_reg_570 <= mul2_fu_424_p2(157 downto 110);
                tmp_9_reg_575 <= mul2_fu_424_p2(141 downto 110);
                tmp_s_reg_540 <= ret_V_9_fu_309_p2(39 downto 8);
                tmp_s_reg_540_pp0_iter1_reg <= tmp_s_reg_540;
                ult_reg_565 <= ult_fu_403_p2;
                ult_reg_565_pp0_iter1_reg <= ult_reg_565;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_CS_fsm, ap_block_pp0_stage0_subdone, ap_reset_idle_pp0)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_pp0_stage0 => 
                ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
            when others =>  
                ap_NS_fsm <= "X";
        end case;
    end process;
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_01001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state1_pp0_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state2_pp0_stage0_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state3_pp0_stage0_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));
    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);

    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_const_logic_1 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;

    ap_reset_idle_pp0 <= ap_const_logic_0;
    f <= (ult_reg_565_pp0_iter1_reg(0) xor ap_const_logic_1);

    f_ap_vld_assign_proc : process(ap_block_pp0_stage0_11001, ap_enable_reg_pp0_iter2)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            f_ap_vld <= ap_const_logic_1;
        else 
            f_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    lhs_V_1_fu_297_p3 <= (ret_V_8_fu_281_p2 & ap_const_lv8_0);
    lhs_V_fu_231_p3 <= (ret_V_6_fu_211_p2 & ap_const_lv8_0);
    mul2_fu_424_p1 <= mul2_fu_424_p10(80 - 1 downto 0);
    mul2_fu_424_p10 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(ta_V_reg_550),161));
    mul2_fu_424_p2 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(ap_const_lv161_lc_1) * unsigned(mul2_fu_424_p1), 161));
    mul_fu_454_p1 <= mul_fu_454_p10(80 - 1 downto 0);
    mul_fu_454_p10 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(of_V_fu_415_p2),161));
    mul_fu_454_p2 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(ap_const_lv161_lc_1) * unsigned(mul_fu_454_p1), 161));
    of_V_fu_415_p2 <= std_logic_vector(signed(tmp_7_cast_fu_412_p1) + signed(tmp_1_fu_409_p1));
    of_n_V <= std_logic_vector(unsigned(tmp6_fu_517_p2) + unsigned(tmp_6_reg_560_pp0_iter1_reg));

    of_n_V_ap_vld_assign_proc : process(ap_block_pp0_stage0_11001, ap_enable_reg_pp0_iter2)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            of_n_V_ap_vld <= ap_const_logic_1;
        else 
            of_n_V_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    of_s_V <= tmp_12_reg_580;

    of_s_V_ap_vld_assign_proc : process(ap_block_pp0_stage0_11001, ap_enable_reg_pp0_iter2)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            of_s_V_ap_vld <= ap_const_logic_1;
        else 
            of_s_V_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    r_V_4_fu_225_p0 <= r_V_4_fu_225_p00(32 - 1 downto 0);
    r_V_4_fu_225_p00 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(t2_n_V),44));
    r_V_4_fu_225_p1 <= tmp_5_fu_221_p1(12 - 1 downto 0);
    r_V_4_fu_225_p2 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(r_V_4_fu_225_p0) * unsigned(r_V_4_fu_225_p1), 44));
    r_V_5_fu_291_p0 <= r_V_5_fu_291_p00(32 - 1 downto 0);
    r_V_5_fu_291_p00 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tb_n_V),44));
    r_V_5_fu_291_p1 <= tmp_5_fu_221_p1(12 - 1 downto 0);
    r_V_5_fu_291_p2 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(r_V_5_fu_291_p0) * unsigned(r_V_5_fu_291_p1), 44));
    ret_V_5_fu_397_p2 <= std_logic_vector(unsigned(t1_V_fu_197_p2) + unsigned(rhs_V_2_cast_fu_393_p1));
    ret_V_6_fu_211_p1 <= ret_V_6_fu_211_p10(48 - 1 downto 0);
    ret_V_6_fu_211_p10 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(t2_s_V),78));
    ret_V_6_fu_211_p2 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(ap_const_lv78_3B9ACA00) * unsigned(ret_V_6_fu_211_p1), 78));
    ret_V_7_fu_243_p2 <= std_logic_vector(unsigned(lhs_V_fu_231_p3) + unsigned(rhs_V_cast_fu_239_p1));
    ret_V_8_fu_281_p1 <= ret_V_8_fu_281_p10(48 - 1 downto 0);
    ret_V_8_fu_281_p10 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tb_s_V),78));
    ret_V_8_fu_281_p2 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(ap_const_lv78_3B9ACA00) * unsigned(ret_V_8_fu_281_p1), 78));
    ret_V_9_fu_309_p2 <= std_logic_vector(unsigned(lhs_V_1_fu_297_p3) + unsigned(rhs_V_1_cast_fu_305_p1));
    ret_V_fu_187_p1 <= ret_V_fu_187_p10(48 - 1 downto 0);
    ret_V_fu_187_p10 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(t1_s_V),78));
    ret_V_fu_187_p2 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(ap_const_lv78_3B9ACA00) * unsigned(ret_V_fu_187_p1), 78));
    rhs_V_1_cast_fu_305_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(r_V_5_fu_291_p2),86));
    rhs_V_2_cast_fu_393_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(delay_V),78));
    rhs_V_cast_fu_239_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(r_V_4_fu_225_p2),86));
    t1_V_cast8_fu_203_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(t1_V_fu_197_p2),79));
    t1_V_fu_197_p2 <= std_logic_vector(unsigned(ret_V_fu_187_p2) + unsigned(tmp_cast_fu_193_p1));
    t2_V_cast_fu_259_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tmp_fu_249_p4),79));
    t2_y_V_cast_fu_273_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(t2_y_V_fu_267_p2),79));
    t2_y_V_fu_267_p2 <= std_logic_vector(unsigned(ret_V_6_fu_211_p2) + unsigned(tmp_cast_13_fu_263_p1));
    ta_V_fu_377_p2 <= std_logic_vector(unsigned(tmp2_cast_fu_373_p1) + unsigned(tmp1_fu_361_p2));
    ta_n_V <= std_logic_vector(unsigned(tmp4_fu_500_p2) + unsigned(tmp3_fu_491_p2));

    ta_n_V_ap_vld_assign_proc : process(ap_block_pp0_stage0_11001, ap_enable_reg_pp0_iter2)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            ta_n_V_ap_vld <= ap_const_logic_1;
        else 
            ta_n_V_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    ta_s_V <= tmp_8_reg_570;

    ta_s_V_ap_vld_assign_proc : process(ap_block_pp0_stage0_11001, ap_enable_reg_pp0_iter2)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            ta_s_V_ap_vld <= ap_const_logic_1;
        else 
            ta_s_V_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    tb_V_fu_325_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tmp_2_fu_315_p4),80));
    tmp1_fu_361_p2 <= std_logic_vector(signed(tmp_3_cast_fu_343_p1) + signed(tb_V_fu_325_p1));
    tmp2_cast_fu_373_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tmp2_fu_367_p2),80));
    tmp2_fu_367_p2 <= std_logic_vector(unsigned(tmp_1_cast_fu_329_p1) + unsigned(tmp_2_cast_fu_333_p1));
    tmp3_fu_491_p2 <= std_logic_vector(unsigned(tmp_s_reg_540_pp0_iter1_reg) + unsigned(tmp_4_reg_545_pp0_iter1_reg));
    tmp4_fu_500_p2 <= std_logic_vector(unsigned(tmp5_fu_495_p2) + unsigned(delay_V_read_reg_533_pp0_iter1_reg));
    tmp5_fu_495_p2 <= std_logic_vector(unsigned(tmp_10_fu_486_p2) + unsigned(ta_offset_V_read_reg_528_pp0_iter1_reg));
    tmp6_fu_517_p2 <= std_logic_vector(unsigned(tmp_14_fu_512_p2) + unsigned(delay_V_read_reg_533_pp0_iter1_reg));
    tmp_10_fu_486_p2 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(std_logic_vector(signed(ap_const_lv32_C4653600) * signed(tmp_9_reg_575))), 32));
    tmp_14_fu_512_p2 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(std_logic_vector(signed(ap_const_lv32_C4653600) * signed(tmp_13_reg_585))), 32));
    tmp_1_cast_fu_329_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(delay_V),33));
    tmp_1_fu_409_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(delay_V_read_reg_533),80));
    tmp_2_cast_fu_333_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(ta_offset_V),33));
    tmp_2_fu_315_p4 <= ret_V_9_fu_309_p2(85 downto 8);
        tmp_3_cast_fu_343_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(tmp_3_fu_337_p2),80));

    tmp_3_fu_337_p2 <= std_logic_vector(unsigned(t1_V_cast8_fu_203_p1) - unsigned(t2_V_cast_fu_259_p1));
    tmp_4_fu_357_p1 <= tmp_3_fu_337_p2(32 - 1 downto 0);
    tmp_5_fu_221_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(rv_V),44));
    tmp_6_fu_389_p1 <= tmp_7_fu_383_p2(32 - 1 downto 0);
        tmp_7_cast_fu_412_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(tmp_7_reg_555),80));

    tmp_7_fu_383_p2 <= std_logic_vector(unsigned(t1_V_cast8_fu_203_p1) - unsigned(t2_y_V_cast_fu_273_p1));
    tmp_cast_13_fu_263_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(t2_n_V),78));
    tmp_cast_fu_193_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(t1_n_V),78));
    tmp_fu_249_p4 <= ret_V_7_fu_243_p2(85 downto 8);
    ult_fu_403_p2 <= "1" when (unsigned(ret_V_5_fu_397_p2) < unsigned(t2_y_V_fu_267_p2)) else "0";
end behav;
