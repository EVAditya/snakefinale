module instmem(
    input clk,
    input reset,
    input [7:0] pc,
    output reg [15:0] inst,


);

  reg [15:0] instmem [0:255];


  assign inst = instmem[pc];

  initial begin
    $readmemh("instmem.hex", mem);
  end

endmodule