module decom(
	input clk,
	input rst_n,
	input [15:0] data_in,
	output reg[15:0] data_out_o,
	output reg[15:0] data_out_e
);
reg cnt;
reg [15:0] data_o_temp;
reg [15:0] data_e_temp;
always @(posedge clk or negedge rst_n) begin
	if(~rst_n)
		cnt <= 0;
	else
		cnt <= cnt + 1;
end

always @(posedge cnt or negedge rst_n) begin
	if(!rst_n)
		data_o_temp <= 0;
	else
		data_o_temp <= data_in;
end

always @(negedge cnt or negedge rst_n) begin
	if(!rst_n)
		data_e_temp <= 0;
	else
		data_e_temp <= data_in;
end


always(posedge clk or negedge rst_n) begin
	if(!rst_n)
		data_out_e <= 0;
	else
		data_out_e <= data_e_temp;
end

always(posedge clk or negedge rst_n) begin
	if(!rst_n)
		data_out_o <= 0;
	else
		data_out_o <= data_o_temp;
end

endmodule