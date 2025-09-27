module speed_controller(input clk, rst, output [11+FRAC_PART_SIZE: 0] speed);

parameter FRAC_PART_SIZE = 2;
parameter MAXIMUM_SPEED = 46;
localparam SPEED_INCREACE_MASK = 1<<30;

localparam DEFAULT_SPEED= (11+FRAC_PART_SIZE)'(1) << FRAC_PART_SIZE;


reg[31: 0] timer;
reg[11+FRAC_PART_SIZE: 0] dino_speed = DEFAULT_SPEED;

wire[11+FRAC_PART_SIZE: 0] incremented_speed;
wire[11+FRAC_PART_SIZE: 0] next_dino_speed;


assign speed = dino_speed;
assign next_dino_speed = (incremented_speed==MAXIMUM_SPEED)? MAXIMUM_SPEED: incremented_speed;
assign incremented_speed = dino_speed + (11+FRAC_PART_SIZE)'(1);

always @ (posedge clk or negedge rst) begin
	if(~rst) begin
		timer <= '0;
		dino_speed<= DEFAULT_SPEED;
	end else begin
		if(timer & SPEED_INCREACE_MASK) begin
			timer <= '0;
			dino_speed <= next_dino_speed;
		end else begin
			timer <= timer + 32'd1;
		end
	end
end

endmodule