module wavlet(
	input clk,
	input rst_n,
	input [15:0] data_in,
	output signed [20:0] data_out_hd,
	output signed [20:0] data_out_ld

);



localparam HD_COF0 = -59;
localparam HD_COF1 = 183;
localparam HD_COF2 = -162;
localparam HD_COF3 = -7;
localparam HD_COF4 = 48;
localparam HD_COF5 = 8;
localparam HD_COF6 = -8;
localparam HD_COF7 = -3;


localparam LD_COF0 = -3;
localparam LD_COF1 = 8;
localparam LD_COF2 = 8;
localparam LD_COF3 = -48;
localparam LD_COF4 = -7;
localparam LD_COF5 = 162;
localparam LD_COF6 = 183;
localparam LD_COF7 = 59;


wire signed [19:0] hd_out_e;
wire signed [19:0] hd_out_o;
wire signed [19:0] ld_out_e;
wire signed [19:0] ld_out_o;




decom decom_inst (
        .clk         (clk         ) ,//input   
        .rst_n       (rst_n       ) ,//input   
        .data_in     (data_in     ) ,//input   [15:0]
        .data_out_o  (data_out_o  ) ,//output  [15:0]
        .data_out_e  (data_out_e  ));//output  [15:0]
filter #(
        .COF0      (HD_COF0      ),
        .COF1      (HD_COF2      ),
        .COF2      (HD_COF4      ),
        .COF3      (HD_COF6      ))
       filter_inst0 (
        .clk       (clk       ) ,//input   
        .rst_n     (rst_n     ) ,//input   
        .data_in   (data_out_o) ,//input   [15:0]
        .data_out  (hd_out_o  ));//output  [19:0]
filter #(
        .COF0      (LD_COF0      ),
        .COF1      (LD_COF2      ),
        .COF2      (LD_COF4      ),
        .COF3      (LD_COF6      ))
       filter_inst1 (
        .clk       (clk       ) ,//input   
        .rst_n     (rst_n     ) ,//input   
        .data_in   (data_out_o) ,//input   [15:0]
        .data_out  (ld_out_o  ));//output  [19:0]
filter #(
        .COF0      (HD_COF1      ),
        .COF1      (HD_COF3      ),
        .COF2      (HD_COF5      ),
        .COF3      (HD_COF7      ))
       filter_inst2 (
        .clk       (clk       ) ,//input   
        .rst_n     (rst_n     ) ,//input   
        .data_in   (data_out_e) ,//input   [15:0]
        .data_out  (hd_out_e  ));//output  [19:0]
filter #(
        .COF0      (LD_COF1      ),
        .COF1      (LD_COF3      ),
        .COF2      (LD_COF5      ),
        .COF3      (LD_COF7      ))
       filter_inst3 (
        .clk       (clk       ) ,//input   
        .rst_n     (rst_n     ) ,//input   
        .data_in   (data_out_e) ,//input   [15:0]
        .data_out  (ld_out_e  ));//output  [19:0]


assign data_out_hd = hd_out_e + hd_out_o;
assign data_out_ld = ld_out_e + ld_out_o;
endmodule