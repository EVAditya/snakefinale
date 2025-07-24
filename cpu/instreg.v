module instreg(
    input clk,
    input reset,
    input [15:0] inst,
    output [7:0] bus,

    input c_a,
    input c_b,
    input c_imm,
    output [3:0] c_opcode,
    output [3:0] regaddr  //goes to gpr
);

reg [15:0] instreg;

always @(posedge clk) begin
    if(reset)
        instreg <= 16'b0;
    else
    instreg <= inst;
end

assign bus = (c_imm) ? instreg[8:0] : 8'bz;
assign regaddr = (c_a) ? instreg[11:8] :
                 (c_b) ? instreg[7:4] : 4'bz;
assign c_opcode = instreg[15:12];

endmodule