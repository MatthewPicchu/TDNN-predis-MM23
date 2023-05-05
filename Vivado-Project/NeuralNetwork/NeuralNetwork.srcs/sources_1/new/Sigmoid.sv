/*Sigmoid Activation function
    Sigmoid function implemented using a look up table
 
    input: signed fixed point value
    output: sigmoid value for input
 
    sfp.mem holds all sigmoid outputs in increasing 
    order for input values from -1 to 1
*/
module Sigmoid(
    input [19:0] x,
    output reg signed [15:0] y
  );

  reg signed [15:0] lut [(2**20)-1:0];

  initial
  begin
    $readmemh("sfp.mem",lut);
  end

  always@(*)
  begin
    y <= lut[x];
  end
endmodule
