
`timescale  1ns/1ns

module  freq_meter
(
    input   wire            sys_clk     ,   //系统时钟,频率50MHz
    input   wire            sys_rst_n   ,   //复位信号,低电平有效
    input   wire            clk_test    ,   //待检测时钟

    output  wire            clk_out         //生成的待检测时钟
);

//wire  define
(* keep = "true" *)  wire    [33:0]  freq    ;   //计算得到的待检测信号时钟频率

//********************************************************************//
//*************************** Instantiation **************************//
//********************************************************************//
//---------- clk_gen_test_inst ----------
clk_test_gen    clk_gen_test_inst
(
    .reset     (~sys_rst_n ),  //复位端口,高电平有效
    .clk_in1   (sys_clk    ),  //输入系统时钟

    .clk_out1  (clk_out    )   //输出生成的待检测时钟信号
);

//------------- freq_meter_calc_inst --------------
freq_meter_calc freq_meter_calc_inst
(
    .sys_clk    (sys_clk    ),   //系统时钟,频率50MHz
    .sys_rst_n  (sys_rst_n  ),   //复位信号,低电平有效
    .clk_test   (clk_test   ),   //待检测时钟

    .freq       (freq       )    //待检测时钟频率
);

ila_0 ila_inst (
	.clk        (sys_clk    ), // input wire clk

	.probe0     (freq       )  // input wire [33:0] probe0
);

endmodule
