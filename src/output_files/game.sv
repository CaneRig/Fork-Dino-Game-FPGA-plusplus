module game
(input clk, up, input [11:0] cactuses0, cactuses1, cactuses2, cactuses3, input cactus_sync, output [8:0] jump_chn, output reg game_over, input rst, output [7:0] abcdefgh, output [3:0] digit);

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

score score(
	    .clk       ( clk ),
		 .rst       ( rst ),
		 .game_over ( game_over ),
		 .digit     ( digit ),
		 .abcdefgh  ( abcdefgh )
	 );

// ---------------------------------------------------------------------------------------------------------------------------
 // -- GAME --
always @(posedge clk or negedge rst)
begin

	if (!rst)
	begin
		// start <= 0;
		game_over <= 0;
		jump_chn_reg <= 0;
		timeout <= 0;
		jump_coefficient <= 0;
		jump <= 0;
	end
	else begin

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
end
endmodule



module score
(
    input clk,
	 input rst,
	 input game_over,
	 output [3:0] digit,
	 output [7:0] abcdefgh
);
    

localparam w_digit   = 4;
localparam clk_mhz   = 50;
localparam update_hz = 4;


 //------------------------------------------------------------------------
function [7:0] dig_to_seg (input [3:0] dig);

	  case (dig)

	  'h0: dig_to_seg = 'b11111100;  // a b c d e f g h
	  'h1: dig_to_seg = 'b01100000;
	  'h2: dig_to_seg = 'b11011010;  //   --a--
	  'h3: dig_to_seg = 'b11110010;  //  |   |
	  'h4: dig_to_seg = 'b01100110;  //  f   b
	  'h5: dig_to_seg = 'b10110110;  //  |   |
	  'h6: dig_to_seg = 'b10111110;  //   --g--
	  'h7: dig_to_seg = 'b11100000;  //  |   |
	  'h8: dig_to_seg = 'b11111110;  //  e   c
	  'h9: dig_to_seg = 'b11100110;  //  |   |
	  'ha: dig_to_seg = 'b11101110;  //   --d--  h
	  'hb: dig_to_seg = 'b00111110;
	  'hc: dig_to_seg = 'b10011100;
	  'hd: dig_to_seg = 'b01111010;
	  'he: dig_to_seg = 'b10011110;
	  'hf: dig_to_seg = 'b10001110;

	  endcase

 endfunction

 // Calculate display update freq divider

 localparam cnt_max = clk_mhz * 1_000_000 / update_hz,
				w_cnt   = $clog2 (cnt_max + 1);

 logic [w_cnt - 1:0] cnt;
 logic [15:0] q; // Just counting in dec system
 
     //one
    count Inst1_count
    (
        .clk(clk),
        .reset(rst),
        .ena(1'b1),
        .q(q[3:0])
    );
    
    //ten 
    count Inst2_count
    (
        .clk(clk),
        .reset(rst),
        .ena(q[3:0] == 4'd9),
        .q(q[7:4])
    );
    
    //hundred
    count Inst3_count
    (
        .clk(clk),
        .reset(rst),
        .ena(q[7:4] == 4'd9 && q[3:0] == 4'd9),
        .q(q[11:8])
    );
    
    //thousand
    count Inst4_count
    (
        .clk(clk),
        .reset(rst),
        .ena(q[11:8] == 4'd9 && q[7:4] == 4'd9 && q[3:0] == 4'd9),
        .q(q[15:12])
    );


 always_ff @ (posedge clk or negedge rst)
	  if (!rst) begin
			cnt <= '0;
	  end else if (cnt == cnt_max) begin
			cnt <= '0;
		end
	  else
			cnt <= cnt + 1'd1;


 // Update display output register with specified frequency
 
 wire enable = cnt == cnt_max;
 logic  [w_digit * 4 - 1:0] r_number;
// always_ff @ (posedge clk) begin
// if (!game_over) 
//     enable = cnt == cnt_max;
// else
//     enable = '0;
// end
     


 always @ (posedge clk or negedge rst) begin
	  if (!rst)
			r_number <= '0;
	  else if (enable)
			r_number <= q;
	end

 localparam w_index = $clog2 (w_digit);
 logic [w_index - 1:0] index;				

 always_ff @ (posedge clk or negedge rst)
	  if (!rst)
			index <= '0;
	  else if (cnt[15:0] == 16'b0) // Perhaps a check is needed that w_cnt >= 16
			index <= (index == w_index' (w_digit - 1) ? w_index' (0) : index + 1'd1);
			
//	Not enough place on fpga for this shit:
//		
// always_comb begin
////	for (int i = 0; i < w_digit*4; i++) begin
////		r_number[i*4 - 1: (i-1)*4] <= (r_number[i*4 - 1: (i-1)*4] / $pow(10, i) ) % 10;
////	end
//	r_number[1*4 - 1: (1-1)*4] <= (r_number[1*4 - 1: (1-1)*4]         ) % 10; 
//	r_number[2*4 - 1: (2-1)*4] <= (r_number[2*4 - 1: (2-1)*4] / 10    ) % 10; 
//	r_number[3*4 - 1: (3-1)*4] <= (r_number[3*4 - 1: (3-1)*4] / 100   ) % 10; 
//	r_number[4*4 - 1: (4-1)*4] <= (r_number[4*4 - 1: (4-1)*4] / 10000 ) % 10;
// end
 
 // Outputs are combinational like before
 assign abcdefgh = ~ (dig_to_seg (r_number [index * 4 +: 4]));
 assign digit    = ~ (w_digit' (1'b1) << index);
 

endmodule


module count
(
	input clk,
    input reset,
    input ena,
    output reg[3:0] q
);
    
    always @ (posedge clk or negedge reset)
        begin
            if(!reset)
                q <= 4'b0;
            else if (ena)
                begin
                    if(q == 4'd9) 
                    	q <= 4'd0;
                    else
                        q <= q + 1'b1;
                end
        end

endmodule

