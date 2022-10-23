module ALU (
    input logic  [4:0]  alu_op,
    input logic  [31:0] SrcA,SrcB,
    output logic [31:0] ALUResult
);


 always_comb begin
    case(alu_op)
    
    5'b00000: ALUResult = SrcA + SrcB ;                             //Addition

    5'b00001: ALUResult = SrcA - SrcB ;                             //Subtraction

    5'b00010: ALUResult = SrcA << SrcB[4:0];                        //Shift Left Logical

    5'b00011: ALUResult = ($signed(SrcA) < $signed(SrcB)) ? 1 : 0;  //Set Less than

    5'b00100: ALUResult = (SrcA < SrcB) ? 1 : 0;                    //Set Less than unsigned

    5'b00101: ALUResult = SrcA ^ SrcB;                              //LOgical xor

    5'b00110: ALUResult = SrcA >> SrcB;                             //Shift Right Logical

    5'b00111: ALUResult = SrcA >>> SrcB[4:0];                       //Shift Right Arithmetic

    5'b01000: ALUResult = SrcA | SrcB;                              //Logical Or

    5'b01001: ALUResult = SrcA & SrcB;                              //Logical and

    5'b01010: ALUResult = SrcB;                                      //Load Upper Immediate
  
    default:  ALUResult = SrcA + SrcB;
    endcase

  end
endmodule