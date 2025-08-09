`timescale 1ns/1ps

module pc_tb;

    reg clk;
    reg reset;
    reg [7:0] bus_in;
    reg c_pc_inc;
    reg c_pc_load;
    wire [7:0] pc;

    pc dut (
        .clk(clk),
        .reset(reset),
        .bus_in(bus_in),
        .pc(pc),
        .c_pc_inc(c_pc_inc),
        .c_pc_load(c_pc_load)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        reset = 1;
        c_pc_inc = 0;
        c_pc_load = 0;
        bus_in = 8'd0;

        #12.5;
        reset = 0;

        #10;
        bus_in = 8'hA5;
        c_pc_load = 1;
        #10;
        c_pc_load = 0;

        #10;
        c_pc_inc = 1;
        #50;
        c_pc_inc = 0;

        #10;
        bus_in = 8'h0F;
        c_pc_load = 1;
        #10;
        c_pc_load = 0;

        #10;
        c_pc_inc = 1;
        #30;
        c_pc_inc = 0;

        #20;
        $finish;
    end

    initial begin
        $monitor("At time %0t: reset=%b load=%b inc=%b bus_in=0x%0h => pc=0x%0h",
                 $time, reset, c_pc_load, c_pc_inc, bus_in, pc);
    end

endmodule