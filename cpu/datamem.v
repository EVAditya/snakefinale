module datamem(
    input clk,
    input reset,
    input [7:0] bus_in,
    output [7:0] bus_out,

    input c_memaddr,
    input c_dataread,
    input c_datawrite,

    input up,
    input down,
    input left,
    input right,

    input [7:0] led_col,
    input [7:0] led_row

);

    reg [7:0] datamem [0:255];
    reg [7:0] mar;

    buttons input_buttons(
        .clk(clk),
        .reset(reset),
        .up(up), 
        .down(down),
        .left(left),
        .right(right),
        .out(datamem[255])
    );

    always @(posedge clk) begin
        if (reset) mar <=8'b0;
        else if(c_memaddr) mar <= bus_in; // Load memory address register
        else if(c_datawrite) begin
             datamem[mar] <= bus_in; // Write data to memory
        end
    end
            
    assign bus_out = (c_dataread) ? datamem[mar] : 8'bz; // Assuming bus_in is the address to read from

    reg [2:0] counter;

    always @(posedge clk) begin
        if (reset) counter <= 3'b0;
        else counter <= counter + 1;
        end

    assign led_col = 1<<(counter);
    assign led_row = datamem[counter];

    

    endmodule