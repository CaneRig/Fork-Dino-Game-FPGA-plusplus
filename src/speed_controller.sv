module speed_controller(input clk, rst, output [11+FRAC_PART_SIZE: 0] speed);

parameter FRAC_PART_SIZE = 2;
parameter integer SPEED_INCREACE_TIME = 1000;

reg[31: 0] timer;
reg[11+FRAC_PART_SIZE: 0] dino_speed;

assign speed = dino_speed;

always @ (posedge clk or negedge rst) begin
	if(!rst) begin
		timer <= '0;
		dino_speed<= (11+FRAC_PART_SIZE)'(1) << FRAC_PART_SIZE;
	end else begin
		if(timer > SPEED_INCREACE_TIME) begin
			timer <= '0;
			dino_speed <= dino_speed + (11+FRAC_PART_SIZE)'(1);
		end else begin
			timer <= timer + 32'd1;
		end
	end
end

endmodule