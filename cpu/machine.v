module machine(

    input clk,
    input reset,
    input up,
    input down,
    input left,
    input right,

    output [7:0] led_row,
    output [7:0] led_col
);

    wire [7:0] bus;
    reg [7:0] npc;
    reg [15:0] inst;


    pc m_pc(
        .clk(clk),
        .reset(reset),
        .bus(bus),
        .pc(npc),
        .c_pc_inc(c_pc_inc),
        .c_pc_load(c_pc_load)
    );

    wire flag;
    wire c_ain, c_bin, c_alu, c_aout; 
    wire c_a, c_b, c_imm;
    wire c_pc_inc, c_pc_load;
    wire c_memaddr, c_dataread, c_datawrite; 
    wire c_regwrite, c_regread; 
    wire c_lfsr;

    control m_control(
        .clk(clk),
        .reset(reset),
        .opcode(inst[15:12]),

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

    alu m_alu(
        .clk(clk),
        .reset(reset),
        .opcode(inst[15:12]),
        .a_in(bus),
        .b_in(bus),
        .imm(inst[7:0]),
        .a_out(bus),
        .flag(flag),
        .c_ain(c_ain),
        .c_bin(c_bin),
        .c_alu(c_alu),
        .c_aout(c_aout)
    );

    instreg m_instreg(
        .clk(clk),
        .reset(reset),
        .inst(inst),
        .bus(bus),
        .c_a(c_a),
        .c_b(c_b),
        .c_imm(c_imm),
        .c_opcode(c_opcode),
        .regaddr()
    )

    instmem m_instmem(
        .clk(clk),
        .reset(reset),
        .pc(npc),
        .inst(inst)
    );
endmodule
