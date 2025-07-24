module buttons(
    input clk,
    input reset,

    input up,

    input down,

    input left,

    input right,
    output reg [1:0] out
);

    always @(posedge clk) begin
        if (reset) begin
            out <= 2'b00; // Reset output
        end else begin
            if (up) begin
                out <= 2'b01; // Up pressed
            end else if (down) begin
                out <= 2'b10; // Down pressed
            end else if (left) begin
                out <= 2'b11; // Left pressed
            end else if (right) begin
                out <= 2'b00; // Right pressed or no input
            end
        end
    end

    endmodule