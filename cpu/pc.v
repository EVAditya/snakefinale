module pc(
    input clk,
    input reset,
    input [7:0] bus_in,
    output reg [7:0] pc,

    input c_pc_inc,
    input c_pc_load
);

    always @(posedge clk) begin
        if (reset)
        pc <= 8'b0;
        else if (c_pc_load)
        pc <= bus_in;
        else if (c_pc_inc)
        pc <= pc + 1;
    end

endmodule