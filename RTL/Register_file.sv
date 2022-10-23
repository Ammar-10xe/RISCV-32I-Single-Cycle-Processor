module Register_file (
     input logic         clk,rst,reg_wr,
     input logic  [4:0]  raddr1,raddr2,waddr,
     input logic  [31:0] wdata,
     output logic [31:0] rdata1,rdata2
);
    logic [31:0] register_file[30:0];

//Asynchronous Read 
    always_comb begin
        rdata1 = (|raddr1) ? register_file[raddr1] : '0 ;
        rdata2 = (|raddr2) ? register_file[raddr2] : '0 ;
    end

//Synchronous Write
  integer i;
  always_ff @(negedge clk) begin
    if (reg_wr && (|waddr)) begin
        register_file[waddr] <= wdata;
    end
    else if (rst) begin
      for(i = 1; i <= 32; i = i + 1)
        register_file[i] <= 32'd0;
    end 
  end

endmodule