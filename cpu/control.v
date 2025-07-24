module control(
    input clk,
    input reset,

    input [3:0] opcode,

    input flag,


    output reg c_ain, c_bin, c_alu, c_aout; //alu
    output reg c_a, c_b, c_imm; //instreg
    output reg c_pc_inc, c_pc_load; //pc
    output reg c_memaddr, c_dataread, c_datawrite; //datamem
    output reg c_regwrite, c_regread; //gpr
    output reg c_lfsr; //lfsr
);


    reg [2:0] state;
always @(posedge clk) begin
    if(reset) state <= 3'b0;
    else begin
        if(c_pc_inc | c_pc_load) state <= 3'b0;
        else state <= state + 1;
    end
end




always @(*) begin
    case(state)
        3'b000: begin
                    c_ain = 0; c_bin = 0; c_alu = 0; c_aout = 0;
                    c_a = 0; c_b = 0; c_imm = 0;
                    c_pc_inc = 0; c_pc_load = 0;
                    c_memaddr = 0; c_dataread = 0; c_datawrite = 0;
                    c_regwrite = 0; c_regread = 0;
                    c_lfsr = 0;
        end


        3'b001: begin
            case(opcode)
                ADD, SUB, ADDI, ROW, COL, INCL,F: begin
                    c_ain = 1; c_bin = 0; c_alu = 0; c_aout = 0;
                    c_a = 1; c_b = 0; c_imm = 0;
                    c_pc_inc = 0; c_pc_load = 0;
                    c_memaddr = 0; c_dataread = 0; c_datawrite = 0;
                    c_regwrite = 0; c_regread = 1;
                    c_lfsr = 0;
                end

                LD, ST, JE, JNE, JE: begin //do nothing
                    c_ain = 0; c_bin = 0; c_alu = 0; c_aout = 0;
                    c_a = 0; c_b = 0; c_imm = 0;
                    c_pc_inc = 0; c_pc_load = 0;
                    c_memaddr = 0; c_dataread = 0; c_datawrite = 0;
                    c_regwrite = 0; c_regread = 0;
                    c_lfsr = 0;
                end
                LDI: begin
                    c_ain = 0; c_bin = 0; c_alu = 0; c_aout = 0;
                    c_a = 0; c_b = 0; c_imm = 1;
                    c_pc_inc = 0; c_pc_load = 0;
                    c_memaddr = 0; c_dataread = 0; c_datawrite = 0;
                    c_regwrite = 1; c_regread = 0;
                    c_lfsr = 0;
                end
                LFSR: begin
                    c_ain = 0; c_bin = 0; c_alu = 0; c_aout = 0;
                    c_a = 1; c_b = 0; c_imm = 0;
                    c_pc_inc = 0; c_pc_load = 0;
                    c_memaddr = 0; c_dataread = 0; c_datawrite = 0;
                    c_regwrite = 1; c_regread = 0;
                    c_lfsr = 1;
                end
                default: begin
                    c_a = 0; c_b = 0; c_imm = 0;
                    c_pc_inc = 1; c_pc_load = 0;
                    c_memaddr = 0; c_dataread = 0; c_datawrite = 0;
                    c_regwrite = 0; c_regread = 0;
                    c_lfsr = 0;
                end

            endcase
        end


        3'b010: begin
            case(opcode)
                ADD, SUB, ROW, COL, INCL, F: begin
                    c_ain = 0; c_bin = 1; c_alu = 0; c_aout = 0;
                    c_a = 0; c_b = 1; c_imm = 0;
                    c_pc_inc = 0; c_pc_load = 0;
                    c_memaddr = 0; c_dataread = 0; c_datawrite = 0;
                    c_regwrite = 0; c_regread = 1;
                    c_lfsr = 0;
                end
                
                ADDI: begin
                    c_ain = 0; c_bin = 1; c_alu = 0; c_aout = 0;
                    c_a = 0; c_b = 0; c_imm = 1;
                    c_pc_inc = 0; c_pc_load = 0;
                    c_memaddr = 0; c_dataread = 0; c_datawrite = 0;
                    c_regwrite = 0; c_regread = 1;
                    c_lfsr = 0;
                end
                
                LD, ST: begin
                    c_ain = 0; c_bin = 0; c_alu = 0; c_aout = 0;
                    c_a = 0; c_b = 0; c_imm = 1;
                    c_pc_inc = 0; c_pc_load = 0;
                    c_memaddr = 1; c_dataread = 0; c_datawrite = 0;
                    c_regwrite = 0; c_regread = 0;
                    c_lfsr = 0;
                end

                JE, JNE, J: begin
                    c_ain = 0; c_bin = 0; c_alu = 0; c_aout = 0;
                    c_a = 0; c_b = 0; c_imm = 1;
                    c_pc_inc = 0; c_pc_load = ((opcode == J) || ((opcode == JE) & (flag)) || ((opcode == JNE) & (~flag)));
                    c_memaddr = 0; c_dataread = 0; c_datawrite = 0;
                    c_regwrite = 0; c_regread = 0;
                    c_lfsr = 0;
                end

                default : begin
                    c_ain = 0; c_bin = 0; c_alu = 0; c_aout = 0;
                    c_a = 0; c_b = 0; c_imm = 0;
                    c_pc_inc = 1; c_pc_load = 0;
                    c_memaddr = 0; c_dataread = 0; c_datawrite = 0;
                    c_regwrite = 0; c_regread = 0;
                    c_lfsr = 0;
                end
            endcase
        end


        3'b011 : begin
            case(opcode)
                ADD, SUB, ADDI, ROW, COL, INCL, F: begin
                    c_ain = 0; c_bin = 0; c_alu = 1; c_aout = 0;
                    c_a = 0; c_b = 0; c_imm = 0;
                    c_pc_inc = 0; c_pc_load = 0;
                    c_memaddr = 0; c_dataread = 0; c_datawrite = 0;
                    c_regwrite = 1; c_regread = 0;
                    c_lfsr = 0;
                end

                ST:  begin
                    c_ain = 0; c_bin = 0; c_alu = 0; c_aout = 0;
                    c_a = 1; c_b = 0; c_imm = 0;
                    c_pc_inc = 0; c_pc_load = 0;
                    c_memaddr = 0; c_dataread = 0; c_datawrite = 1;
                    c_regwrite = 0; c_regread = 1;
                    c_lfsr = 0;
                end
                LD:  begin
                    c_ain = 0; c_bin = 0; c_alu = 0; c_aout = 0;
                    c_a = 1; c_b = 0; c_imm = 0;
                    c_pc_inc = 0; c_pc_load = 0;
                    c_memaddr = 0; c_dataread = 1; c_datawrite = 0;
                    c_regwrite = 1; c_regread = 0;
                    c_lfsr = 0;
                end
                default : begin //LFSR, LDI, JE, JNE, J
                    c_ain = 0; c_bin = 0; c_alu = 0; c_aout = 0;
                    c_a = 0; c_b = 0; c_imm = 0;
                    c_pc_inc = 1; c_pc_load = 0;
                    c_memaddr = 0; c_dataread = 0; c_datawrite = 0;
                    c_regwrite = 0; c_regread = 0;
                    c_lfsr = 0;
                end
            endcase
        end

        3'b100 : begin
            case(opcode)
                ADD, SUB, ADDI, ROW, COL, INCL, F: begin
                    c_ain = 0; c_bin = 0; c_alu = 0; c_aout = 1;
                    c_a = 1; c_b = 0; c_imm = 0;
                    c_pc_inc = 0; c_pc_load = 0;
                    c_memaddr = 0; c_dataread = 0; c_datawrite = 0;
                    c_regwrite = 1; c_regread = 0;
                    c_lfsr = 0;
                end

                default : begin
                    c_ain = 0; c_bin = 0; c_alu = 0; c_aout = 0;
                    c_a = 0; c_b = 0; c_imm = 0;
                    c_pc_inc = 1; c_pc_load = 0;
                    c_memaddr = 0; c_dataread = 0; c_datawrite = 0;
                    c_regwrite = 0; c_regread = 0;
                    c_lfsr = 0;
                end      
            endcase
        end

        3'b101 : begin
                    c_a = 0; c_b = 0; c_imm = 0;
                    c_pc_inc = 1; c_pc_load = 0;
                    c_memaddr = 0; c_dataread = 0; c_datawrite = 0;
                    c_regwrite = 0; c_regread = 0;
                    c_lfsr = 0;
                end

        default: begin
                    c_a = 0; c_b = 0; c_imm = 0;
                    c_pc_inc = 1; c_pc_load = 0;
                    c_memaddr = 0; c_dataread = 0; c_datawrite = 0;
                    c_regwrite = 0; c_regread = 0;
                    c_lfsr = 0;
                end


    endcase
end
endmodule
