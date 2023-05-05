module TB();
  parameter SIG_SIZE = 16;
  parameter WEIGHT_SIZE = 16;
  parameter ADDITION_SIZE = 21;
  parameter LAYER1_IN_SIZE = 10;
  parameter NUM_INPUTS = 10;
  reg wb_en;
  reg signed [WEIGHT_SIZE-1:0] weights [9:0];
  reg signed [WEIGHT_SIZE-1:0] bias;
  reg clk_n;
  wire signed [SIG_SIZE-1:0] y;
  
  reg signed [15:0] sig1,sig2,sig3,sig4,sig5,sig6,sig7,sig8,sig9,sig10;
  

NEURON_LIN #(.NUM_INPUTS(LAYER1_IN_SIZE)) DUT(.NEURON_IN({sig1,sig2,sig3,sig4,sig5,sig6,sig7,sig8,sig9,sig10}),
         .WEIGHTS_IN(weights),
         .WB_EN(wb_en),
         .BIAS_IN(bias),
         .CLOCK_N(clk_n),
         .NEURON_OUT(y));

  initial
  begin
    $dumpfile("test.vcd");
    $dumpvars(1);
    weights[0] = 16'h7FFF;
    weights[1] = 16'h7FFF;
    weights[2] = 16'h7FFF;
    weights[3] = 16'h7FFF;
    weights[4] = 16'h7FFF;
    weights[5] = 16'h7FFF;
    weights[6] = 16'h7FFF;
    weights[7] = 16'h7FFF;
    weights[8] = 16'h7FFF;
    weights[9] = 16'h7FFF;
    
    clk_n = 0;
    bias = 16'h7FFF;
    wb_en = 1;
    sig1 = 0;
    sig2 = 0;
    sig3 = 0;
    sig4 = 0;
    sig5 = 0;
    sig6 = 0;
    sig7 = 0;
    sig8 = 0;
    sig9 = 0;
    sig10 = 0;

    #50;
    wb_en = 0;
    
    sig1 = 16'h7FFF;
    sig2 = 16'h7FFF;
    sig3 = 16'h7FFF;
    sig4 = 16'h7FFF;
    sig5 = 16'h7FFF;
    sig6 = 16'h7FFF;
    sig7 = 16'h7FFF;
    sig8 = 16'h7FFF;
    sig9 = 16'h7FFF;
    sig10 = 16'h7FFF;
    
    #200

    $finish;
  end

  always #5
  begin
    clk_n <= ~clk_n;
  end

endmodule
