module TDNN#(
    parameter SIG_SIZE = 16,
    parameter WEIGHT_SIZE = 16,
    parameter ADDITION_SIZE = 20,
    parameter LAYER1_IN_SIZE = 10,
    parameter LAYER2_IN_SIZE = 10,
    parameter NUM_SIGS = 2
  )(
    input signed [SIG_SIZE-1:0] SIG_IN1,
    input signed [SIG_SIZE-1:0] SIG_IN2,
    input signed CLOCK_N,
    input signed wb_en,
    output signed [SIG_SIZE-1:0] SIG_OUT1,
    output signed [SIG_SIZE-1:0] SIG_OUT2
  );
  wire signed [SIG_SIZE-1:0] delay_out_1;
  wire signed [SIG_SIZE-1:0] delay_out_2;
  wire signed [SIG_SIZE-1:0] delay_out_3;
  wire signed [SIG_SIZE-1:0] delay_out_4;
  wire signed [SIG_SIZE-1:0] delay_out_5;
  wire signed [SIG_SIZE-1:0] delay_out_6;
  wire signed [SIG_SIZE-1:0] delay_out_7;
  wire signed [SIG_SIZE-1:0] delay_out_8;

  wire signed [ADDITION_SIZE-1:0] n1_out;
  wire signed [ADDITION_SIZE-1:0] n2_out;
  wire signed [ADDITION_SIZE-1:0] n3_out;
  wire signed [ADDITION_SIZE-1:0] n4_out;
  wire signed [ADDITION_SIZE-1:0] n5_out;
  wire signed [ADDITION_SIZE-1:0] n6_out;
  wire signed [ADDITION_SIZE-1:0] n7_out;
  wire signed [ADDITION_SIZE-1:0] n8_out;
  wire signed [ADDITION_SIZE-1:0] n9_out;
  wire signed [ADDITION_SIZE-1:0] n10_out;
  wire signed [SIG_SIZE-1:0] l1_sigmoid_out [9:0];
  wire signed [SIG_SIZE-1:0] n11_out;
  wire signed [SIG_SIZE-1:0] n12_out;

  reg signed [(WEIGHT_SIZE-1):0] WEIGHTS1 [(10*10)-1:0];
  reg signed [(WEIGHT_SIZE-1):0] WEIGHTS2 [(2*10)-1:0];

  wire signed [WEIGHT_SIZE-1:0] N1W[LAYER1_IN_SIZE-1:0];
  wire signed [WEIGHT_SIZE-1:0] N2W[LAYER1_IN_SIZE-1:0];
  wire signed [WEIGHT_SIZE-1:0] N3W[LAYER1_IN_SIZE-1:0];
  wire signed [WEIGHT_SIZE-1:0] N4W[LAYER1_IN_SIZE-1:0];
  wire signed [WEIGHT_SIZE-1:0] N5W[LAYER1_IN_SIZE-1:0];
  wire signed [WEIGHT_SIZE-1:0] N6W[LAYER1_IN_SIZE-1:0];
  wire signed [WEIGHT_SIZE-1:0] N7W[LAYER1_IN_SIZE-1:0];
  wire signed [WEIGHT_SIZE-1:0] N8W[LAYER1_IN_SIZE-1:0];
  wire signed [WEIGHT_SIZE-1:0] N9W[LAYER1_IN_SIZE-1:0];
  wire signed [WEIGHT_SIZE-1:0] N10W[LAYER1_IN_SIZE-1:0];
  wire signed [WEIGHT_SIZE-1:0] N11W[LAYER2_IN_SIZE-1:0];
  wire signed [WEIGHT_SIZE-1:0] N12W[LAYER2_IN_SIZE-1:0];


  generate
    genvar i;
    for(i=0;i<10;i++)
    begin
      assign N1W[i] = WEIGHTS1[0+i];
      assign N2W[i] = WEIGHTS1[10+i];
      assign N3W[i] = WEIGHTS1[20+i];
      assign N4W[i] = WEIGHTS1[30+i];
      assign N5W[i] = WEIGHTS1[40+i];
      assign N6W[i] = WEIGHTS1[50+i];
      assign N7W[i] = WEIGHTS1[60+i];
      assign N8W[i] = WEIGHTS1[70+i];
      assign N9W[i] = WEIGHTS1[80+i];
      assign N10W[i] = WEIGHTS1[90+i];
      assign N11W[i] = WEIGHTS2[0+i];
      assign N12W[i] = WEIGHTS2[10+i];
    end
  endgenerate

  reg signed [WEIGHT_SIZE-1:0] bias1 [9:0]; //Layer 1 bias
  reg signed [WEIGHT_SIZE-1:0] bias2 [1:0]; //Layer 2 bias

  //Delays for Sig_in_1
  DELAY delay1(SIG_IN1,CLOCK_N,delay_out_1);
  DELAY delay2(delay_out_1,CLOCK_N,delay_out_2);
  DELAY delay3(delay_out_2,CLOCK_N,delay_out_3);
  DELAY delay4(delay_out_3,CLOCK_N,delay_out_4);

  //Delays for Sig_in_2
  DELAY delay5(SIG_IN2,CLOCK_N,delay_out_5);
  DELAY delay6(delay_out_5,CLOCK_N,delay_out_6);
  DELAY delay7(delay_out_6,CLOCK_N,delay_out_7);
  DELAY delay8(delay_out_7,CLOCK_N,delay_out_8);

  //Layer 1
  NEURON #(.NUM_INPUTS(LAYER1_IN_SIZE)) neuron1(
           .NEURON_IN(
             {delay_out_8, delay_out_4, delay_out_7, delay_out_3, delay_out_6,
              delay_out_2, delay_out_5, delay_out_1, SIG_IN2, SIG_IN1}),
           .WEIGHTS_IN(N1W),
           .WB_EN(wb_en),
           .BIAS_IN(bias1[0]),
           .CLOCK_N(CLOCK_N),
           .NEURON_OUT(n1_out));
  NEURON #(.NUM_INPUTS(LAYER1_IN_SIZE)) neuron2(
           .NEURON_IN({delay_out_8, delay_out_4, delay_out_7, delay_out_3, delay_out_6,
                       delay_out_2, delay_out_5, delay_out_1, SIG_IN2, SIG_IN1}),
           .WEIGHTS_IN(N2W),
           .WB_EN(wb_en),
           .BIAS_IN(bias1[1]),
           .CLOCK_N(CLOCK_N),
           .NEURON_OUT(n2_out));
  NEURON #(.NUM_INPUTS(LAYER1_IN_SIZE)) neuron3(
           .NEURON_IN({delay_out_8, delay_out_4, delay_out_7, delay_out_3, delay_out_6,
                       delay_out_2, delay_out_5, delay_out_1, SIG_IN2, SIG_IN1}),
           .WEIGHTS_IN(N3W),
           .WB_EN(wb_en),
           .BIAS_IN(bias1[2]),
           .CLOCK_N(CLOCK_N),
           .NEURON_OUT(n3_out));
  NEURON #(.NUM_INPUTS(LAYER1_IN_SIZE)) neuron4(
           .NEURON_IN({delay_out_8, delay_out_4, delay_out_7, delay_out_3, delay_out_6,
                       delay_out_2, delay_out_5, delay_out_1, SIG_IN2, SIG_IN1}),
           .WEIGHTS_IN(N4W),
           .WB_EN(wb_en),
           .BIAS_IN(bias1[3]),
           .CLOCK_N(CLOCK_N),
           .NEURON_OUT(n4_out));
  NEURON #(.NUM_INPUTS(LAYER1_IN_SIZE)) neuron5(
           .NEURON_IN({delay_out_8, delay_out_4, delay_out_7, delay_out_3, delay_out_6,
                       delay_out_2, delay_out_5, delay_out_1, SIG_IN2, SIG_IN1}),
           .WEIGHTS_IN(N5W),
           .WB_EN(wb_en),
           .BIAS_IN(bias1[4]),
           .CLOCK_N(CLOCK_N),
           .NEURON_OUT(n5_out));
  NEURON #(.NUM_INPUTS(LAYER1_IN_SIZE)) neuron6(
           .NEURON_IN({delay_out_8, delay_out_4, delay_out_7, delay_out_3, delay_out_6,
                       delay_out_2, delay_out_5, delay_out_1, SIG_IN2, SIG_IN1}),
           .WEIGHTS_IN(N6W),
           .WB_EN(wb_en),
           .BIAS_IN(bias1[5]),
           .CLOCK_N(CLOCK_N),
           .NEURON_OUT(n6_out));
  NEURON #(.NUM_INPUTS(LAYER1_IN_SIZE)) neuron7(
           .NEURON_IN({delay_out_8, delay_out_4, delay_out_7, delay_out_3, delay_out_6,
                       delay_out_2, delay_out_5, delay_out_1, SIG_IN2, SIG_IN1}),
           .WEIGHTS_IN(N7W),
           .WB_EN(wb_en),
           .BIAS_IN(bias1[6]),
           .CLOCK_N(CLOCK_N),
           .NEURON_OUT(n7_out));
  NEURON #(.NUM_INPUTS(LAYER1_IN_SIZE)) neuron8(
           .NEURON_IN({delay_out_8, delay_out_4, delay_out_7, delay_out_3, delay_out_6,
                       delay_out_2, delay_out_5, delay_out_1, SIG_IN2, SIG_IN1}),
           .WEIGHTS_IN(N8W),
           .WB_EN(wb_en),
           .BIAS_IN(bias1[7]),
           .CLOCK_N(CLOCK_N),
           .NEURON_OUT(n8_out));
  NEURON #(.NUM_INPUTS(LAYER1_IN_SIZE)) neuron9(
           .NEURON_IN({delay_out_8, delay_out_4, delay_out_7, delay_out_3, delay_out_6,
                       delay_out_2, delay_out_5, delay_out_1, SIG_IN2, SIG_IN1}),
           .WEIGHTS_IN(N9W),
           .WB_EN(wb_en),
           .BIAS_IN(bias1[8]),
           .CLOCK_N(CLOCK_N),
           .NEURON_OUT(n9_out));
  NEURON #(.NUM_INPUTS(LAYER1_IN_SIZE)) neuron10(
           .NEURON_IN({delay_out_8, delay_out_4, delay_out_7, delay_out_3, delay_out_6,
                       delay_out_2, delay_out_5, delay_out_1, SIG_IN2, SIG_IN1}),
           .WEIGHTS_IN(N10W),
           .WB_EN(wb_en),
           .BIAS_IN(bias1[9]),
           .CLOCK_N(CLOCK_N),
           .NEURON_OUT(n10_out));

  //Layer 1 Activation
  SIGMOID_LUT sigAct(.x({n10_out,n9_out,n8_out,n7_out,n6_out,n5_out,n4_out,n3_out,n2_out,n1_out}),
                     .y(l1_sigmoid_out));

  //Layer 2
  NEURON_LIN #(.NUM_INPUTS(LAYER1_IN_SIZE)) neuron11(.NEURON_IN(l1_sigmoid_out),
             .WEIGHTS_IN(N11W),
             .WB_EN(wb_en),
             .BIAS_IN(bias2[0]),
             .CLOCK_N(CLOCK_N),
             .NEURON_OUT(SIG_OUT1));
  NEURON_LIN #(.NUM_INPUTS(LAYER1_IN_SIZE)) neuron12(.NEURON_IN(l1_sigmoid_out),
             .WEIGHTS_IN(N12W),
             .WB_EN(wb_en),
             .BIAS_IN(bias2[1]),
             .CLOCK_N(CLOCK_N),
             .NEURON_OUT(SIG_OUT2));

  initial
  begin
    $readmemh("bias1.mem", bias1);
    $readmemh("weights1.mem", WEIGHTS1);
    $readmemh("bias2.mem", bias2);
    $readmemh("weights2.mem", WEIGHTS2);
  end

endmodule
