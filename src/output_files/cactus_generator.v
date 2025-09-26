module cactus_generator 
(input clk, game_over, input [8:0] random_input, input[11+FRAC_PART_SIZE:0] dino_speed,
output [11:0] cactus0, cactus1, cactus2, cactus3, output reg cactus_sync, input rst);

parameter FRAC_PART_SIZE = 2;

reg [11+FRAC_PART_SIZE:0] cactuses [0:4];

assign cactus0 = cactuses[0][11+FRAC_PART_SIZE:FRAC_PART_SIZE];
assign cactus1 = cactuses[1][11+FRAC_PART_SIZE:FRAC_PART_SIZE];
assign cactus2 = cactuses[2][11+FRAC_PART_SIZE:FRAC_PART_SIZE];
assign cactus3 = cactuses[3][11+FRAC_PART_SIZE:FRAC_PART_SIZE];

integer spd = 200000;

reg begining = 1;
integer count1 = 0;
integer count2 = 0;
integer i = 0;

always @ (posedge clk or negedge rst)
begin
	if (!rst) begin 
		begining <= 1;
		count1 <= 0;
		count2 <= 0;
		i <= 0;
		spd <= 200000;
	end else begin

	cactus_sync = 0;
	count1 = count1 + 1;
	count2 = count2 + 1;
	
	// -- INITIAL WORLD --
	if (begining == 1)
	begin
		cactuses[0] = 300<<FRAC_PART_SIZE;//-50
		cactuses[1] = -(1224<<FRAC_PART_SIZE);
		cactuses[2] = -(1274<<FRAC_PART_SIZE);
		cactuses[3] = -(1875<<FRAC_PART_SIZE);
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
			cactuses[i] = cactuses[i] + dino_speed; // horizontal speed
			if(cactuses[i] == (1074<<FRAC_PART_SIZE))begin
				/*if (i == 0)
					cactuses[i] = cactuses[2] - (random_input + 1024);
				else
					cactuses[i] = cactuses[i-1] - (random_input + 1024);*/
					
				cactuses[i] = -(50<<FRAC_PART_SIZE);
			end
		end
		cactus_sync = 1;
	end
	end
	// --
end
endmodule