module Mux_PC (
    input logic         PCsrc,              //signal from controller
    input logic  [31:0] PCF,ALUResult,
    output logic [31:0] PC
);
 always_comb 
 begin 
    case (PCsrc)
        1'b0 :   PC = PCF;
        1'b1 :   PC = ALUResult; 
        default: PC = PCF;
    endcase
 end 
endmodule