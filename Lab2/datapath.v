module datapath(clk, reset, RegDst,AluSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,Jump,ALUOp,OpCode,shamt);

input clk;
input reset;

input RegDst,AluSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,Jump;

wire [31:0] Instruction;

input [1:0] ALUOp;
wire [3:0] ALUCtrl;
wire [31:0] ALUout;
wire Zero;

output [5:0] OpCode;
output [4:0] shamt;
assign OpCode = Instruction[31:26];
assign shamt = Instruction[10:6];
wire [31:0] PC_adr;

wire [31:0] ReadRegister1;
wire [31:0] ReadRegister2;

wire [4:0] muxinstr_out;
wire [31:0] muxalu_out;
wire [31:0] muxdata_out;

wire [31:0] ReadData;

wire [31:0] signExtend;

wire PCsel;
wire branch_detected;
wire [31:0] x,jump_address;
mem_async meminstr(PC_adr[7:0],Instruction); //Instruction memory
mem_sync memdata(clk, ALUout[7:0], ReadData, ReadRegister2, MemRead, MemWrite); //Data memory
rf registerfile(clk,RegWrite,Instruction[25:21],Instruction[20:16],muxinstr_out, ReadRegister1, ReadRegister2, muxdata_out); //Registers

alucontrol AluControl(ALUOp, Instruction[5:0], ALUCtrl); //ALUControl
alu Alu(ReadRegister1, muxalu_out,shamt, ALUCtrl, ALUout, Zero); //ALU
assign branch_detected=Instruction[26]?~Zero:Zero;
pclogic PC(clk, reset,Jump,x, PC_adr, PCsel); //generate PC
andm andPC(Branch, branch_detected, PCsel); //AndPC (branch & zero)
signextend Signextend(signExtend, Instruction[15:0]); //Sign extend

mux #(5) muxinstr(RegDst, Instruction[20:16],Instruction[15:11],muxinstr_out);//MUX for Write Register
mux #(32) muxalu(AluSrc, ReadRegister2, signExtend, muxalu_out);//MUX for ALU
mux #(32) muxdata(MemtoReg, ALUout, ReadData, muxdata_out); //MUX for Data memory
//mux muxbranch(Instruction[26],Zero,~Zero,branch_detected);
assign jump_address={PC_adr[31:28],Instruction[25:0],2'b00};
assign x= Jump?jump_address:signExtend;


endmodule
