`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2023 12:50:47
// Design Name: 
// Module Name: Neuron5in
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Neuron5in #(
    parameter SIG_SIZE = 16,
    parameter WEIGHT_SIZE = 16,
    parameter ADDITION_SIZE = 32,
    parameter NUM_INPUTS = 3
  )(
    input [SIG_SIZE-1:0] IN1,
    input [SIG_SIZE-1:0] IN2,
    input [SIG_SIZE-1:0] IN3,
    input [SIG_SIZE-1:0] IN4,
    input [SIG_SIZE-1:0] IN5,
    output [SIG_SIZE-1:0] OUT
    );
endmodule
