// Copyright (C) 2022  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 21.1.1 Build 850 06/23/2022 SJ Lite Edition"
// CREATED		"Tue Sep 23 20:10:26 2025"

module vga(
	clk,
	sck,
	data,
	rst,
	h,
	v,
	r,
	b,
	g,
	pin_name1,
	bell,
	abcdefgh,
	digit,
     EA
);


input wire	clk;
input wire	sck;
input wire	data;
input wire	rst;
output wire	h;
output wire	v;
output wire	r;
output wire	b;
output wire	g;
output wire	pin_name1;
output wire	bell;
output wire	[7:0] abcdefgh;
output wire	[3:0] digit;
output wire    EA;

assign EA = SYNTHESIZED_WIRE_2;

wire	SYNTHESIZED_WIRE_31;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_32;
wire	[11:0] SYNTHESIZED_WIRE_33;
wire	[11:0] SYNTHESIZED_WIRE_34;
wire	[11:0] SYNTHESIZED_WIRE_35;
wire	[11:0] SYNTHESIZED_WIRE_36;
wire	[10:0] SYNTHESIZED_WIRE_8;
wire	[10:0] SYNTHESIZED_WIRE_9;
wire	[8:0] SYNTHESIZED_WIRE_10;
wire	[13:0] SYNTHESIZED_WIRE_14;
wire	[8:0] SYNTHESIZED_WIRE_15;
wire	SYNTHESIZED_WIRE_37;
wire	SYNTHESIZED_WIRE_18;
wire	SYNTHESIZED_WIRE_24;
wire	SYNTHESIZED_WIRE_25;
wire	SYNTHESIZED_WIRE_30;





pll	b2v_inst(
	.inclk0(clk),
	.c0(SYNTHESIZED_WIRE_31));


sync	b2v_inst1(
	.clk(SYNTHESIZED_WIRE_31),
	.h_sync(h),
	.v_sync(v),
	.EA(SYNTHESIZED_WIRE_2),
	.h_count(SYNTHESIZED_WIRE_8),
	.v_count(SYNTHESIZED_WIRE_9));

assign	SYNTHESIZED_WIRE_25 =  ~data;


bit_stream	b2v_inst2(
	.clk(SYNTHESIZED_WIRE_31),
	.EA(SYNTHESIZED_WIRE_2),
	.game_over(SYNTHESIZED_WIRE_32),
	.cactuses0(SYNTHESIZED_WIRE_33),
	.cactuses1(SYNTHESIZED_WIRE_34),
	.cactuses2(SYNTHESIZED_WIRE_35),
	.cactuses3(SYNTHESIZED_WIRE_36),
	.count_h(SYNTHESIZED_WIRE_8),
	.count_v(SYNTHESIZED_WIRE_9),
	.jump_chn(SYNTHESIZED_WIRE_10),
	.red(r),
	.blue(b),
	.green(g));


random	b2v_inst22(
	.clk(SYNTHESIZED_WIRE_31),
	.random_bits(SYNTHESIZED_WIRE_15));


cactus_generator	b2v_inst24(
	.clk(SYNTHESIZED_WIRE_31),
	.game_over(SYNTHESIZED_WIRE_32),
	.rst(rst),
	.dino_speed(SYNTHESIZED_WIRE_14),
	.random_input(SYNTHESIZED_WIRE_15),
	.cactus_sync(SYNTHESIZED_WIRE_18),
	.cactus0(SYNTHESIZED_WIRE_33),
	.cactus1(SYNTHESIZED_WIRE_34),
	.cactus2(SYNTHESIZED_WIRE_35),
	.cactus3(SYNTHESIZED_WIRE_36));
	defparam	b2v_inst24.FRAC_PART_SIZE = 2;


game	b2v_inst27(
	.clk(SYNTHESIZED_WIRE_31),
	.up(SYNTHESIZED_WIRE_37),
	.cactus_sync(SYNTHESIZED_WIRE_18),
	.rst(rst),
	.cactuses0(SYNTHESIZED_WIRE_33),
	.cactuses1(SYNTHESIZED_WIRE_34),
	.cactuses2(SYNTHESIZED_WIRE_35),
	.cactuses3(SYNTHESIZED_WIRE_36),
	.game_over(SYNTHESIZED_WIRE_32),
	.abcdefgh(abcdefgh),
	.digit(digit),
	.jump_chn(SYNTHESIZED_WIRE_10));


keyboard	b2v_inst3(
	.clk(SYNTHESIZED_WIRE_31),
	.ps_clk(SYNTHESIZED_WIRE_24),
	.ps_data(SYNTHESIZED_WIRE_25),
	.btn_pressed(SYNTHESIZED_WIRE_37));


speed_controller	b2v_inst4(
	.clk(SYNTHESIZED_WIRE_31),
	.rst(rst),
	.speed(SYNTHESIZED_WIRE_14));
	defparam	b2v_inst4.FRAC_PART_SIZE = 2;
	defparam	b2v_inst4.SPEED_INCREACE_TIME = 1000;

assign	pin_name1 =  ~SYNTHESIZED_WIRE_32;


sound	b2v_inst6(
	.clk(SYNTHESIZED_WIRE_31),
	.insignal(SYNTHESIZED_WIRE_37),
	.outsignal(SYNTHESIZED_WIRE_30));

assign	bell =  ~SYNTHESIZED_WIRE_30;

assign	SYNTHESIZED_WIRE_24 =  ~sck;


endmodule
