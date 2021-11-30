module keyboard
(input clk, ps_clk, ps_data, output reg btn_pressed);

	reg reading = 0;
	reg pressed = 0;
	reg zatichka = 0;
	reg [4:0]count = 0;																																																																																																																						
	reg [7:0]data = 0;
	
always @(negedge clk)
begin
	if (pressed == 0)
	begin
		btn_pressed <= 0;
		zatichka = 0;
	end
	
	if (pressed == 1)
	begin
		btn_pressed <= 1;
	end
	else
		zatichka = 1;
end
	
	

always @(negedge ps_clk)
begin
	if(zatichka == 1)
	begin
		pressed = 0;
	end
	
	if(ps_data == 0 & reading == 0)
	begin
		reading = 1;
		pressed = 1;
		count = 0;
	end
		
	if(reading == 1)
	begin
		data = (ps_data<<count)|data;
		count = count + 1;
		
		if(count == 9)
		begin
			reading = 0;
			data = 0;
			count = 0;
		end
	end
end

endmodule
