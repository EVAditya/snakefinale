module machine(

    input sclk,
    input reset,
    input up,
    input down,
    input left,
    input right,

    output [7:0] led_row,
    output [7:0] led_col
);
    reg clk;
    reg [2:0] clk_div;

    always @(posedge sclk) begin //This is to delay the clock by 8 times.
        clk_div <= clk_div + 1;
        if(clk_div < 4) clk <= 0;
        else clk <= 1;
    end

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

    buttons m_buttons(
        .clk(clk),
        .reset(reset),
        .up(up),
        .down(down),
        .left(left),
        .right(right),
        .bus(bus)
    );

    datamem m_datamem(
        .clk(clk),
        .reset(reset),
        .bus_in(bus),
        .bus_out(bus),
        .c_memaddr(c_memaddr),
        .c_dataread(c_dataread),
        .c_datawrite(c_datawrite),
        .up(up),
        .down(down),
        .left(left),
        .right(right),
        .led_col(led_col),
        .led_row(led_row)
    );

    gpr m_gpr(
        .clk(clk),
        .reset(reset),
        .bus_in(bus),
        .bus_out(bus),
        .regaddr(inst[11:8]),
        .c_regwrite(c_regwrite),
        .c_regread(c_regread)
    );

    lfsr m_lfsr(
        .clk(clk),
        .reset(reset),
        .bus_out(bus),
        .c_lfsr(c_lfsr)
    );



endmodule
