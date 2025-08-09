`timescale 1ns/1ps
`include "opcodes.v"
`include "alu.v"

module alu_tb;

    reg clk;
    reg reset;
    reg [2:0] opcode;
    reg [7:0] a_in, b_in;
    wire [7:0] a_out;
    wire flag;
    reg c_ain, c_bin, c_alu, c_aout;

    alu uut (
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .a_in(a_in),
        .b_in(b_in),
        .a_out(a_out),
        .flag(flag),
        .c_ain(c_ain),
        .c_bin(c_bin),
        .c_alu(c_alu),
        .c_aout(c_aout)
    );

    always #5 clk = ~clk;

    task load_inputs(input [7:0] ain, input [7:0] bin);
    begin
        c_ain = 1; a_in = ain;
        c_bin = 1; b_in = bin;
        @(posedge clk);
        c_ain = 0;
        c_bin = 0;
    end
    endtask

    task run_op(input [2:0] opc);
    begin
        opcode = opc;
        c_alu = 1;
        @(posedge clk);
        c_alu = 0;
    end
    endtask

    initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);

        // Init
        clk = 0;
        reset = 1;
        c_ain = 0; c_bin = 0; c_alu = 0; c_aout = 1;
        a_in = 0; b_in = 0;
        opcode = 0;

        @(posedge clk);
        reset = 0;

        // Test ADD
        load_inputs(8'd5, 8'd3);
        run_op(`ADD);
        @(posedge clk);
        $display("ADD: a_out = %d, flag = %b", a_out, flag);

        // Test SUB
        load_inputs(8'd9, 8'd4);
        run_op(`SUB);
        @(posedge clk);
        $display("SUB: a_out = %d, flag = %b", a_out, flag);

        // Test ADDI
        load_inputs(8'd2, 8'd7);
        run_op(`ADDI);
        @(posedge clk);
        $display("ADDI: a_out = %d, flag = %b", a_out, flag);

        // Test ROW
        load_inputs(8'd0, 8'hAB);
        run_op(`ROW);
        @(posedge clk);
        $display("ROW: a_out = %d, flag = %b", a_out, flag);

        // Test COL
        load_inputs(8'd0, 8'hAB);
        run_op(`COL);
        @(posedge clk);
        $display("COL: a_out = %d, flag = %b", a_out, flag);

        // Test INCL
        load_inputs(8'b00000001, 8'd3);
        run_op(`INCL);
        @(posedge clk);
        $display("INCL: a_out = %b, flag = %b", a_out, flag);

        // Test F (flag set if equal)
        load_inputs(8'd7, 8'd7);
        run_op(`F);
        @(posedge clk);
        $display("F: a_out = %d, flag = %b", a_out, flag);

        $finish;
    end

endmodule
