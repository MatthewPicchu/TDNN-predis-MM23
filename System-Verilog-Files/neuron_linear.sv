module NEURON_LIN #(
    parameter SIG_SIZE = 16,
    parameter WEIGHT_SIZE = 16,
    parameter ADDITION_SIZE = 20,
    parameter NUM_INPUTS = 3
  )(
    input signed [SIG_SIZE-1:0] NEURON_IN[NUM_INPUTS-1:0],
    input signed [WEIGHT_SIZE-1:0] WEIGHTS_IN[NUM_INPUTS-1:0],
    input WB_EN,
    input signed [WEIGHT_SIZE-1:0] BIAS_IN,
    input CLOCK_N,
    output reg signed [SIG_SIZE-1:0] NEURON_OUT
  );
  logic signed [WEIGHT_SIZE-1:0] weights[NUM_INPUTS-1:0];
  logic signed [WEIGHT_SIZE-1:0] bias;
  logic signed [SIG_SIZE*2-1:0] ixw [NUM_INPUTS-1:0];
  logic signed [ADDITION_SIZE-1:0] addition;
  logic sigmoid_flag = 0;
  integer i;

  linear activation(.x(addition),
                    .y(NEURON_OUT));

  initial
  begin
    addition <= 0;
  end

  always @(negedge CLOCK_N)
  begin
    if(WB_EN)
    begin
      for(i = 0; i<NUM_INPUTS;i++)
      begin
        weights[i] <= WEIGHTS_IN[i];
      end
      bias <= BIAS_IN;
    end
    addition = bias;
    //multiply inputs by weights
    //add product to addition register
    for(i=0;i<NUM_INPUTS;i++)
    begin
      ixw[i] <= ((NEURON_IN[i]*weights[i])>>15);
      addition = addition + ixw[i];
      if(ixw[i] > 16'h7fff)
        addition = addition - 20'h10000;
    end
  end

endmodule
