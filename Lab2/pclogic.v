module pclogic(clk, reset,Jump, ain, aout, pcsel);

input reset;
input clk;
input [31:0] ain;
input Jump;
//pecsel = branch & zero
input pcsel;

output reg [31:0] aout;

always @(posedge clk ) begin
	if (reset==1)
		aout<=32'b0;
	else
	case({pcsel,Jump})
	2'b00: aout<=aout+1;
	2'b10: aout<=ain+aout+1;
	2'b01: aout<=ain;
	2'b11:aout<=ain;
	endcase

end

endmodule
