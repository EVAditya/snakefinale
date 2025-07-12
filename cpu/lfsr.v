module lfsr(
    input clk,
    input reset,

    output [7:0] bus_out,
    input c_lfsr,
);

    reg [7:0] lfsr;

    always @(posedge clk) begin
        if (reset) lfsr <= 8'b1; // Non zero seed
        else lfsr <= lfsr ^ 8'b10001110; // Tap
    end

    assign bus_out = (c_lfsr) ? lfsr & 8'b01110111 : 8'bz; // x and y coordinates are padded with a 0 in the end. So I don't need the last bit of each nibble. (PS: Nibble is 4 bits)

    endmodule