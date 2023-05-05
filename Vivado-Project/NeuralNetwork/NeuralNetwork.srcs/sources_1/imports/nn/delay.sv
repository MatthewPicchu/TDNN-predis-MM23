module DELAY#(
    parameter SIG_SIZE = 16,
    parameter WEIGHT_SIZE = 16,
    parameter ADDITION_SIZE = 32,
    parameter NUM_INPUTS = 3
  )(
    input signed [SIG_SIZE-1:0]INPUT,
    input CLK_N,
    output reg signed [SIG_SIZE-1:0]DELAY_OUTPUT
  );

  reg signed [SIG_SIZE-1:0]TEMP_HOLD;

  always @(negedge CLK_N)
  begin
    DELAY_OUTPUT <= TEMP_HOLD;
    TEMP_HOLD <= INPUT;
  end

  initial
  begin
    DELAY_OUTPUT = 0;
    TEMP_HOLD = 0;
  end

endmodule
