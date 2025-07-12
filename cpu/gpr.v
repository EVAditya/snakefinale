module gpr(
    input clk,
    input reset,
    input [7:0] bus_in,
    output [7:0] bus_out,

    input [3:0] regaddr, // Comes from instreg
    input c_regwrite,      
    input c_regread       


);
    reg [7:0] gpr [0:15];

    always @(posedge clk) begin
        if (reset) begin
            gpr[0] <= 8'b0;
        end else begin
            if (c_regwrite) begin
                gpr[c_regaddr] <= bus_in; 
            end
        end
    end

    assign bus_out = (c_regread) ? gpr[c_regaddr] : 8'bz; 

endmodule