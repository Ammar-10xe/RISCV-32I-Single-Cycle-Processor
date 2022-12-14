module controller (
    input  logic        br_taken,
    input  logic [31:0] Inst,
    output logic        PCsrc,reg_wr,sel_A,sel_B,
    output logic [1:0]  wb_sel,
    output logic [2:0]  ImmSrcD,funct3,
    output logic [4:0]  alu_op,
    output logic [6:0]  instr_opcode
);

logic       Btype;
logic [6:0] funct7;

parameter [4:0] ADD  = 5'b00000;
parameter [4:0] SUB  = 5'b00001;
parameter [4:0] SLL  = 5'b00010;
parameter [4:0] SLT  = 5'b00011;
parameter [4:0] SLTU = 5'b00100;
parameter [4:0] XOR  = 5'b00101;
parameter [4:0] SRL  = 5'b00110;
parameter [4:0] SRA  = 5'b00111;
parameter [4:0] OR   = 5'b01000;
parameter [4:0] AND  = 5'b01001;
parameter [4:0] LUI  = 5'b01010;

assign instr_opcode = Inst[6:0];
assign funct7       = Inst[31:25];
assign funct3       = Inst[14:12];

always_comb
begin
    
    case(instr_opcode)

        7'b0110011: //R-Type
        begin 
            reg_wr   = 1'b1;
            sel_A    = 1'b1;
            sel_B    = 1'b0;
            wb_sel   = 2'b01;
            Btype    = 1'b0;
            ImmSrcD  = 3'bxxx;

            case (funct3)
                3'b000: begin
                    case (funct7) 
                        7'b0000000 : alu_op = ADD; 
                        7'b0100000 : alu_op = SUB; 
                    endcase
                    end
                3'b001: alu_op = SLL;
                3'b010: alu_op = SLT;
                3'b011: alu_op = SLTU;
                3'b100: alu_op = XOR;
                3'b101: begin
                    case (funct7)
                        7'b0000000 : alu_op = SRL;
                        7'b0100000 : alu_op = SRA; 
                    endcase          
                    end
                3'b110: alu_op = OR;
                3'b111: alu_op = AND;   
            endcase
            end

        7'b0010011: begin // I-Type Without load 
        reg_wr   = 1'b1;
        sel_A    = 1'b1;
        sel_B    = 1'b1;
        wb_sel   = 2'b01;
        Btype    = 1'b0;
        ImmSrcD  = 3'b000;
        case (funct3)
            3'b000: alu_op = ADD;
            3'b001: alu_op = SLL;
            3'b010: alu_op = SLT;
            3'b011: alu_op = SLTU;
            3'b100: alu_op = XOR;
            3'b101: begin
                    case (funct7)
                        7'b0000000: alu_op = SRL;
                        7'b0100000: alu_op = SRA; 
                    endcase
                    end
            3'b110: alu_op = OR;
            3'b111: alu_op = AND; 
        endcase
        end

        7'b0000011: begin //Load I-Type
            reg_wr  = 1'b1;
            sel_A   = 1'b1;
            sel_B   = 1'b1;
            wb_sel  = 2'b10;
            Btype    = 1'b0;
            ImmSrcD = 3'b000;
            alu_op  = ADD;
            end

        7'b0100011: begin //S-Type
            reg_wr  = 1'b0;
            sel_A   = 1'b1;
            sel_B   = 1'b1;
            wb_sel  = 2'bx;
            Btype   = 1'b0;
            ImmSrcD = 3'b001;
            alu_op  = ADD;
        end
        
        7'b0110111: begin //U-Type LUI
            reg_wr  = 1'b1;
            sel_B   = 1'b1;
            sel_A   = 1'bx;
            wb_sel  = 2'b01;
            Btype   = 1'b0;
            ImmSrcD = 3'b100;
            alu_op  = LUI;
        end

        7'b0010111: begin //U-Type AUIPC
            reg_wr  = 1'b1;
            sel_B   = 1'b1;
            sel_A   = 1'b0; 
            wb_sel  = 2'b01;
            Btype   = 1'b0;
            ImmSrcD = 3'b100;
            alu_op  = ADD;
            
        end

        7'b1100011: begin //B type 
            Btype   = 1'b1;
            reg_wr  = 1'b0;
            sel_A   = 1'b0; 
            sel_B   = 1'b1; 
            wb_sel  = 2'bx;
            ImmSrcD = 3'b010;
            alu_op  = ADD;
        end

        7'b1101111: begin //JAL  
            Btype   = 1'b1;
            reg_wr  = 1'b1;
            sel_A   = 1'b0; 
            sel_B   = 1'b1; 
            wb_sel  = 2'b00;
            ImmSrcD = 3'b011;
            alu_op  = ADD;
            end

        7'b1100111: begin //JALR 
            Btype   = 1'b1;
            reg_wr  = 1'b1;
            sel_A   = 1'b1; 
            sel_B   = 1'b1; 
            wb_sel  = 2'b00;
            ImmSrcD = 3'b000;
            alu_op  = ADD;
        end

        default: begin
        end

    endcase
    PCsrc = Btype && br_taken;
end
    
endmodule