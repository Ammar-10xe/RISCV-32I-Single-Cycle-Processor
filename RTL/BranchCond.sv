module BranchCond (
    input logic [2:0]  funct3,
    input logic [6:0]  instr_opcode,
    input logic [31:0] rdata1,rdata2,
    output logic br_taken
);

parameter [2:0] BEQ  = 3'b000;
parameter [2:0] BNE  = 3'b001;
parameter [2:0] BLT  = 3'b100;
parameter [2:0] BGE  = 3'b101;
parameter [2:0] BLTU = 3'b110;
parameter [2:0] BGEU = 3'b111;

logic [32:0] cmp_output;
logic [31:0] cmp_operand_1,cmp_operand_2;
logic        cmp_not_zero,cmp_neg,cmp_overflow;

assign cmp_operand_1 = rdata1;
assign cmp_operand_2 = rdata2;
assign cmp_output    = {1'b0, cmp_operand_1} -{1'b0, cmp_operand_2};
assign cmp_not_zero  = |cmp_output [31:0];
assign cmp_neg       = cmp_output [31];
assign cmp_overflow  = (cmp_neg & ~cmp_operand_1[31] & cmp_operand_2 [31] ) | ( ~cmp_neg & cmp_operand_1[31] & ~cmp_operand_2[31] );

always_comb begin
    case (instr_opcode)
        7'b1100011 :begin  // B Type 
            case(funct3) 
                BEQ    : br_taken = ~cmp_not_zero;
                BNE    : br_taken = cmp_not_zero; 
                BLT    : br_taken = (cmp_neg ^ cmp_overflow);
                BLTU   : br_taken = cmp_output[32];
                BGE    : br_taken = ~( cmp_neg ^ cmp_overflow); 
                BGEU   : br_taken = ~cmp_output[32];
                default: br_taken = 1'b0;
            endcase
        end
        7'b1101111 | 7'b1100111: br_taken = 1'b1; //JAL and JALR Type  
        default   : br_taken = 1'b0;
    endcase
end


endmodule