module MuxResult (
    input logic  [1:0]  wb_sel, //From controller
    input logic  [31:0] ALUResult,rdata,PCF,
    output logic [31:0] wdata
);

always_comb begin 
    case (wb_sel)
       2'b00 : wdata = PCF;
       2'b01 : wdata = ALUResult;
       2'b10 : wdata = rdata;
    endcase
    end
endmodule

