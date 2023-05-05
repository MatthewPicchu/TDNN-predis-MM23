module TDNN_TOP#(
    parameter SIG_SIZE = 16,
    parameter WEIGHT_SIZE = 16,
    parameter ADDITION_SIZE = 32,
    parameter NUM_INPUTS = 3,
    parameter NUM_SIGS = 2
  )(
    // Slide switch inputs
    input [15:0]sw,
    input topclk,
    output [6:0] seg,
    output [7:0] an,
    output dp
  );
  reg WB_ENABLE;
  wire [15:0] sig_out1, sig_out2;

  TDNN TDNN_DES(.SIG_IN1(sw),
                .SIG_IN2(sw),
                .CLOCK_N(topclk),
                .wb_en(WB_ENABLE),
                .SIG_OUT1(sig_out1),
                .SIG_OUT2(sig_out2));

  Seg7 segOut(.in1(sig_out2),
              .in2(sig_out1),
              .topclk(topclk),
              .seg(seg),
              .an(an),
              .dp(dp));

  initial
    WB_ENABLE = 1;

endmodule
