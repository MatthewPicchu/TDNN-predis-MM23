module TDNN_TB();
  reg signed [15:0] sig1, sig2;
  reg topclk;
  reg WEIGHTBIAS_EN;
  wire signed [15:0] out1, out2;


  TDNN DUT(   .SIG_IN1(sig1),
              .SIG_IN2(sig2),
              .CLOCK_N(topclk),
              .SIG_OUT1(out1),
              .SIG_OUT2(out2),
              .wb_en(WEIGHTBIAS_EN)
          );

  always #5 topclk = ~topclk;

  initial
  begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end

  initial
  begin
    topclk = 0;
    sig1 = 0;
    sig2 = 0;
    WEIGHTBIAS_EN = 0;
    #10
     WEIGHTBIAS_EN = 1;
    #10
     WEIGHTBIAS_EN = 0;
    #100
     sig1 = 16'h0d29;
    sig2 = 16'hf054;
    #2000
     sig1 = 0;
    sig2 = 0;
    #2000

     $finish;
  end

endmodule
