module filter(
	input clk,
	input rst_n,
	input [15:0] data_in,
	output [19:0] data_out
);


reg [15:00 ] shift_reg[4];
parameter COF0 = 0  ;
parameter COF1 = 0  ;
parameter COF2 = 0  ;
parameter COF3 = 0  ;

wire [31:0] mul_temp0 = shift_reg[0] * COF0;
wire [31:0] mul_temp1 = shift_reg[1] * COF1;
wire [31:0] mul_temp2 = shift_reg[2] * COF2;
wire [31:0] mul_temp3 = shift_reg[3] * COF3;

assign data_out = mul_temp0[31:8] + mul_temp1[31:8] + mul_temp2[31:8] + mul_temp3[31:8];
genvar  i;
generate
	for(i = 0; i < 3 ; i = i + 1)begin:shift_reg_inst
		always @(posedge clk or negedge rst_n) begin
			if(!rst_n)
				shift_reg[i] <= 0;
			else
				shift_reg[i] <= shift_reg[i+1];
		end
	end
endgenerate
always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		shift_reg[3] <= 0;
		end
	else
		shift_reg[3] <= data_in;
end

endmodule
