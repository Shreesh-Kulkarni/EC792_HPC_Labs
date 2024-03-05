module control(opcode, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch,Jump, AluOP);

input [5:0] opcode;

output reg RegDst;
output reg ALUSrc;
output reg MemtoReg;
output reg RegWrite;
output reg MemRead;
output reg MemWrite;
output reg Branch;
output reg Jump;

output reg [1:0] AluOP;

always @(opcode) begin
	case (opcode)
		6'b000000:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch,Jump, AluOP}=10'b100100_0_0_10; //r (includes sll)
		6'b100011:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch,Jump, AluOP}=10'b011110_0_0_00; //lw
		6'b101011:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch,Jump, AluOP}=10'bx1x001_0_0_00; //sw
		6'b000100:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch,Jump, AluOP}=10'bx0x000_1_0_01; //beq
		6'b001000:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch,Jump, AluOP}=10'b010100_0_0_00; //addi
		6'b000101:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch,Jump, AluOP}=10'bx0x000_1_0_01; //bne
		6'b000010:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch,Jump, AluOP}=10'bxxx000_0_1_xx;//jump
	        
		default:
	{RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,Jump,AluOP}=10'bxxx_xxx_x_xx;
	endcase
end

endmodule
