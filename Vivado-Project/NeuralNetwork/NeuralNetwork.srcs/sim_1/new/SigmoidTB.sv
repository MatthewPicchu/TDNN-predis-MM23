`timescale 1ns / 1ps

module SigmoidTB();
    reg [15:0] in;
    wire signed [15:0] out;
    Sigmoid DUT(
        .x(in),
        .y(out));
        
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars();
        in = 0;
        #10;
        in = 16'hfea8;
        #10
        $finish;
    end
endmodule
