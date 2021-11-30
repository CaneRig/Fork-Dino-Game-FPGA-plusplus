module sound(input clk, insignal, output reg outsignal);

integer timeout;

always@(negedge clk)
begin
	if (insignal == 1 && outsignal == 0)
	begin
		outsignal = 1;
	end
	if (outsignal == 1)
	begin
		timeout = timeout + 1;
		if (timeout >= 10000000)
		begin
			outsignal = 0;
		end
	end
	
end
endmodule