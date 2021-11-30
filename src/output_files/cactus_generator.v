module cactus_generator 
(input clk, game_over, input [8:0] random_input,
output [11:0] cactus0, cactus1, cactus2, cactus3, output reg cactus_sync);

reg [11:0] cactuses [0:4];

assign cactus0 = cactuses[0];
assign cactus1 = cactuses[1];
assign cactus2 = cactuses[2];
assign cactus3 = cactuses[3];

integer spd = 200000;

reg begining = 1;
integer count1 = 0;
integer count2 = 0;
integer i = 0;

always @ (negedge clk)
begin
	cactus_sync = 0;
	count1 = count1 + 1;
	count2 = count2 + 1;
	
	// -- INITIAL WORLD --
	if (begining == 1)
	begin
		cactuses[0] = 300;//-50
		cactuses[1] = -1224;
		cactuses[2] = -1274;
		cactuses[3] = -1875;
		begining = 0;
	end
	// --
	
	// -- SPEEED INCRESING --
	if(count2 == 180000000)
	begin
		count2 = 0;
		if (spd > 50000)
			spd = spd - 10000;
	end
	// --
	
	// -- GENERATOR -- 
	if(count1 >= spd & !game_over) begin
		count1 = 0;
		for (i = 0; i < 1; i = i+1) begin
			cactuses[i] = cactuses[i] + 1; 
			if(cactuses[i] == 1074)begin
				/*if (i == 0)
					cactuses[i] = cactuses[2] - (random_input + 1024);
				else
					cactuses[i] = cactuses[i-1] - (random_input + 1024);*/
					
				cactuses[i] = -50;
			end
		end
		cactus_sync = 1;
	end
	// --
end
endmodule