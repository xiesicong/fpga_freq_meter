`timescale  1ns/1ns
///////////////////////////////////////////////////////////////////////////
// Author        : EmbedFire
// Create Date   : 2020/08/12
// Module Name   : 
// Project Name  : 
// Target Devices: Xilinx XC6SLX16
// Tool Versions : ISE 14.7
// Description   : 
//
// Revision      : V1.0
// Additional Comments:
// 
// 实验平台: 野火_踏浪Pro_FPGA开发板
// 公司    : http://www.embedfire.com
// 论坛    : http://www.firebbs.cn
// 淘宝    : https://fire-stm32.taobao.com
//////////////////////////////////////////////////////////////////////////

module tb_freq_meter();

//********************************************************************//
//****************** Parameter And Internal Signal *******************//
//********************************************************************//
//wire  define
wire    clk_out;

//reg   define
reg             sys_clk     ;
reg             sys_rst_n   ;
reg             clk_test    ;

//********************************************************************//
//***************************** Main Code ****************************//
//********************************************************************//
//时钟、复位、待检测时钟的生成
initial
    begin
        sys_clk     =   1'b1;
        sys_rst_n   <=  1'b0;
        #200
        sys_rst_n  <=  1'b1;
        #500
        clk_test      =   1'b1;
    end

always  #10     sys_clk =   ~sys_clk    ;   //50MHz系统时钟
always  #100    clk_test=   ~clk_test    ;   //5MHz待检测时钟

//重定义软件闸门计数时间,缩短仿真时间
defparam freq_meter_inst.freq_meter_calc_inst.CNT_GATE_S_MAX    = 240   ;
defparam freq_meter_inst.freq_meter_calc_inst.CNT_RISE_MAX      = 40    ;

//********************************************************************//
//*************************** Instantiation **************************//
//********************************************************************//
//------------- freq_meter_inst -------------
freq_meter  freq_meter_inst
(
    .sys_clk     (sys_clk   ),   //系统时钟,频率50MHz
    .sys_rst_n   (sys_rst_n ),   //复位信号,低电平有效
    .clk_test    (clk_test  ),   //待检测时钟

    .clk_out     (clk_out   )    //生成的待检测时钟

);

endmodule
