module immediate_gen (
  input  logic [31:0] Inst,
  input  logic [2:0]  ImmSrcD,
  output logic [31:0] ImmExtD
);

logic [24:0] Imm;
assign Imm =Inst [31:7];

  always_comb begin
    casex(ImmSrcD)
    // I Type
    3'b000:   ImmExtD = {{20{Imm[24]}}, Imm[24:13]};
    // S Type
    3'b001:   ImmExtD = {{20{Imm[24]}}, Imm[24:18], Imm[4:0]};
    // B Type
    3'b010:   ImmExtD = {{20{Imm[24]}}, Imm[0],  Imm[23:18], Imm[4:1], 1'b0};
    // J Type
    3'b011:   ImmExtD = {{12{Imm[24]}}, Imm[12:5],  Imm[13], Imm[23:14], 1'b0};
    // U Type
    3'b100:   ImmExtD = {Imm[24:5],12'b000000000000};
    default: 	ImmExtD = 32'dx; // undefined
    endcase
  end

endmodule
