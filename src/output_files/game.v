module game
(input clk, up, input [11:0] cactuses0, cactuses1, cactuses2, cactuses3, input cactus_sync, output [8:0] jump_chn, output reg game_over);

integer timeout = 0;
integer i = 0;

reg [8:0] jump_chn_reg = 0;
reg jump = 0;
reg jump_invulnerability = 0;
integer jump_coefficient = 0;
//reg [11:0] jump_coefficient = 0;
integer jump_length = 14;

assign jump_chn = jump_chn_reg;

integer j = 0;

reg [11:0] cactuses [0:4];
reg fake_gameover1;

reg init = 0;
reg start = 0;

always @(posedge clk)
begin
	// -- INIT --
	if (init == 0)
	begin
	   //jump_chn_reg = 300;
		init = 1;
		game_over = 1;
		jump = 0;
	end
	// --
	
	// -- STRAT GAME --
	if (start == 0 & up == 1)
	begin
		start = 1;
		game_over = 0;
	end
	//--
	
	// -- JUMP --
	if (jump == 0 && up == 1)
	begin
		jump = 1;
		timeout = 0;
	end
	
	if (jump)
	begin
		timeout = timeout + 1;
		
		if(timeout >= 1562500)
		begin
			jump_coefficient = jump_coefficient + 1;
			timeout = 0;
		end
			
		jump_chn_reg = (jump_length * jump_length) - (jump_coefficient - jump_length) * (jump_coefficient - jump_length);
		
		if (jump_coefficient == jump_length * 2)
		begin
			jump = 0;
			jump_coefficient = 0;
		end
	end
	
	if (jump_chn_reg >= 32)
		jump_invulnerability = 1;
	else
		jump_invulnerability = 0;
	// --
	
	// -- CACTUS COLLISION -- 
	cactuses[0] = cactuses0;
	cactuses[1] = cactuses1;
	cactuses[2] = cactuses2;
	cactuses[3] = cactuses3;
	
	if (jump_invulnerability == 0 && !cactus_sync)
		for(i = 0; i < 4; i=i+1) begin
			if (1024 + 200 - cactuses[i] >= 200 + 200)
				if (1024 + 200 - cactuses[i] <= 300 + 200)
				begin
					game_over = 1;
					
					/*for(j = 0; j < 11; j = j + 1)begin
						if(j == 0)
							lcdd0 = cactuses[i][j];
						if(j == 1)
							lcdd1 = cactuses[i][j];
						if(j == 2)
							lcdd2 = cactuses[i][j];
						if(j == 3)
							lcdd3 = cactuses[i][j];
						if(j == 4)
							lcdd4 = cactuses[i][j];
						if(j == 5)
							lcdd5 = cactuses[i][j];
						if(j == 6)
							lcdd6 = cactuses[i][j];
						if(j == 7)
							lcdd7 = cactuses[i][j];
						if(j == 8)
							lcdd8 = cactuses[i][j];
						if(j == 9)
							lcdd9 = cactuses[i][j];
						if(j == 10)
							lcdd10 = cactuses[i][j];
					end*/
				end
			
			if (1024 + 200 - cactuses[i] + 50 >= 200 + 200)
				if (1024 + 200 - cactuses[i] + 50 <= 300 + 200)
					game_over = 1;
		end
	// --
end
endmodule