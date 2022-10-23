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
    #1
    rst<=1;
    #1
    rst<=0;
end

endmodule