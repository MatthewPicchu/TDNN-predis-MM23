module linear(
    input [19:0] x,
    output reg signed [15:0] y
  );

  //4 MSB's are not used as input should never exceed 0xFFFF
  assign y = x[15:0];

endmodule
