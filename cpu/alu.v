`include "opcodes.v"

module alu(
    input clk,
    input reset,
    input [2:0] opcode,
    input [7:0] a_in,
    input [7:0] b_in,
    output [7:0] a_out,
    output reg flag,

    input c_ain,
    input c_bin,
    input c_alu,
    input c_aout
);

    reg [7:0] a, b;

    always @(posedge clk) begin
        if (reset) begin
            a <= 8'b0;
            b <= 8'b0;
        end else begin
            if (c_ain) a <= a_in;
            if (c_bin) b <= b_in;

            if(c_alu) begin
                case({1'b0,opcode}) // All ALU opcodes have 0 as the MSB
                    ADD : a <= a + b; 
                    SUB : a <= a - b; 
                    ADDI: a <= a + b; // Add immediate (b is treated as immediate
                    ROW : a <= b[7:4];
                    COL : a <= b[3:0];
                    INCL : a <= a | (1 << b);
                    F : flag <= (a == b);
                endcase
            end
        end
    end

    assign a_out = (c_aout) ? a : 8'bz;

endmodule