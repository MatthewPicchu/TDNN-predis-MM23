module SIGMOID_LUT(
    input [19:0] x [9:0],
    output reg signed [15:0] y [9:0]
  );

  reg signed [15:0] lut [(2**20)-1:0];

  initial
  begin
    $readmemh("sfp.mem",lut);
  end

  always@(x[0]) y[0] <= lut[x[0]];
  always@(x[1]) y[1] <= lut[x[1]];
  always@(x[2]) y[2] <= lut[x[2]];
  always@(x[3]) y[3] <= lut[x[3]];
  always@(x[4]) y[4] <= lut[x[4]];
  always@(x[5]) y[5] <= lut[x[5]];
  always@(x[6]) y[6] <= lut[x[6]];
  always@(x[7]) y[7] <= lut[x[7]];
  always@(x[8]) y[8] <= lut[x[8]];
  always@(x[9]) y[9] <= lut[x[9]];

endmodule
