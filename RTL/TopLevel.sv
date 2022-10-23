module TopLevel (input logic clk,rst);

    logic        PCsrc,reg_wr,sel_A,sel_B,cs,wr,br_taken;
    logic [1:0]  wb_sel;
    logic [2:0]  ImmSrcD,funct3;
    logic [3:0]  mask;
    logic [4:0]  raddr1,raddr2,waddr,alu_op;
    logic [6:0]  instr_opcode;
    logic [31:0] Addr,PC,Inst,PCF,wdata,rdata1,rdata2,ImmExtD,SrcA,SrcB,ALUResult,rdata,data_rd,addr,data_wr;

Mux_PC MuxPC(.PCF(PCF),.ALUResult(ALUResult),.PCsrc(PCsrc),.PC(PC));
program_counter ProgCouner (.clk(clk),.rst(rst),.PC(PC),.Addr(Addr));
Instruction_Memory InstMem(.Addr(Addr),.Inst(Inst));
Instruction_Fetch Fetch(.Inst(Inst),.raddr1(raddr1),.raddr2(raddr2),.waddr(waddr));
PCPlus4 PCplus4 (.Addr(Addr),.PCF(PCF));
Register_file RegsiterFile(.clk(clk),.rst(rst),.reg_wr(reg_wr),.raddr1(raddr1),.raddr2(raddr2),.waddr(waddr),.wdata(wdata),.rdata1(rdata1),.rdata2(rdata2));
ALU Alu(.alu_op(alu_op),.SrcA(SrcA),.SrcB(SrcB),.ALUResult(ALUResult));
controller Controller(.br_taken(br_taken),.Inst(Inst),.PCsrc(PCsrc),.reg_wr(reg_wr),.sel_A(sel_A),.sel_B(sel_B),.wb_sel(wb_sel),.ImmSrcD(ImmSrcD),
.funct3(funct3),.alu_op(alu_op),.instr_opcode(instr_opcode));
LoadStore_Unit loadstore(.funct3(funct3),.instr_opcode(instr_opcode),.data_rd(data_rd),.rdata2(rdata2),.ALUResult(ALUResult),.cs(cs),.wr(wr),.mask(mask),.addr(addr),.data_wr(data_wr),.rdata(rdata));
Data_Memory Dmem(.clk(clk),.rst(rst),.cs(cs),.wr(wr),.mask(mask),.addr(addr),.data_wr(data_wr),.data_rd(data_rd));
immediate_gen Immediate(.Inst(Inst),.ImmSrcD(ImmSrcD),.ImmExtD(ImmExtD));
mux_selA MuxselA(.sel_A(sel_A),.rdata1(rdata1),.Addr(Addr),.SrcA(SrcA));
mux_selB MuxselB(.sel_B(sel_B),.ImmExtD(ImmExtD),.rdata2(rdata2),.SrcB(SrcB));
MuxResult Muxresult(.wb_sel(wb_sel),.ALUResult(ALUResult),.rdata(rdata),.PCF(PCF),.wdata(wdata));
BranchCond Branchcond(.funct3(funct3),.instr_opcode(instr_opcode),.rdata1(rdata1),.rdata2(rdata2),.br_taken(br_taken));

endmodule