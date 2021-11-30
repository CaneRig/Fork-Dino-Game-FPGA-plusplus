module random(input clk, output reg [8:0] random_bits);

integer count = 1;
reg [32:0] random_reg = 1234;
reg [32:0] prev_random_reg = 0;
reg [8:0] random_reg_complete = 0;
reg [8:0] prev_random_reg_complete = 0;
//assign random_bits = random_reg;

integer i = 0;

always @(negedge clk)
begin
	random_reg = random_reg * random_reg;
	
	for (i = 16; i < 16+8; i = i+1) begin
		random_reg_complete [i - 16] = random_reg [i];
	end
	
	if (random_reg_complete > 0 && 
		random_reg_complete < 200 && 
		((prev_random_reg_complete - random_reg_complete)*(prev_random_reg_complete - random_reg_complete)) /
		(prev_random_reg_complete - random_reg_complete) < 200  && 
		((prev_random_reg_complete - random_reg_complete)*(prev_random_reg_complete - random_reg_complete)) /
		(prev_random_reg_complete - random_reg_complete) < 200 ) //
	begin
		random_bits = random_reg_complete;
	end
	else
	begin
		random_reg = count + 1234;
		count = count + 1;
	end
end
endmodule