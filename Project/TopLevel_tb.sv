module TopLevel_tb ();
logic clk,rst;

TopLevel TOPLevel (.clk(clk),.rst(rst));

initial begin
    clk<=0;
    forever begin
        #1 clk<=~clk;
    end
end
initial begin
    #5
    rst<=1;
    #5
    rst<=0;
end

endmodule