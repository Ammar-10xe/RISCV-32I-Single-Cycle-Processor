module PCPlus4 (
  input  logic [31:0] Addr,
  output logic [31:0] PCF
);

  assign PCF = Addr + 4;
  
endmodule
