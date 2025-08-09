`timescale 1ns/1ps

module tb_control;

    reg clk;
    reg [3:0] opcode;
    reg flag;

    wire c_ain, c_bin, c_alu, c_aout, c_a, c_b, c_imm;
    wire c_pc_inc, c_pc_load;
    wire c_memaddr, c_dataread, c_datawrite;
    wire c_regwrite, c_regread;
    wire c_lfsr;

    control uut (
        .clk(clk),
        .opcode(opcode),
        .flag(flag),
        .c_ain(c_ain),
        .c_bin(c_bin),
        .c_alu(c_alu),
        .c_aout(c_aout),
        .c_a(c_a),
        .c_b(c_b),
        .c_imm(c_imm),
        .c_pc_inc(c_pc_inc),
        .c_pc_load(c_pc_load),
        .c_memaddr(c_memaddr),
        .c_dataread(c_dataread),
        .c_datawrite(c_datawrite),
        .c_regwrite(c_regwrite),
        .c_regread(c_regread),
        .c_lfsr(c_lfsr)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        $dumpfile("tb_control.vcd"); 
        $dumpvars(0, tb_control);

        flag = 0;

        opcode = 4'b0000; // ADD
        #20;
        opcode = 4'b0001; // SUB
        #20;
        opcode = 4'b0010; // ADDI
        #20;
        opcode = 4'b0011; // ROW
        #20;
        opcode = 4'b0100; // COL
        #20;
        opcode = 4'b0101; // INCL
        #20;
        opcode = 4'b0110; // F
        #20;
        opcode = 4'b0111; // LD
        #20;
        opcode = 4'b1000; // ST
        #20;
        opcode = 4'b1001; // JE
        #20;
        opcode = 4'b1010; // JNE
        #20;
        opcode = 4'b1011; // J
        #20;
        opcode = 4'b1100; // LDI
        #20;
        opcode = 4'b1101; // LFSR
        #20;

        flag = 1;
        opcode = 4'b1001; // JE with flag
        #20;

        $finish;
    end

endmodule
