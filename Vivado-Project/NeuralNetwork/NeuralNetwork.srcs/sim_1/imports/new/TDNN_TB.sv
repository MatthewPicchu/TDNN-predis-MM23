module TDNN_TB();
    reg signed [15:0] sig1, sig2;
    reg topclk;
    reg WEIGHTBIAS_EN;
    wire signed [15:0] out1, out2;
    
    //design under test instanstiation
    TDNN DUT(   .SIG_IN1(sig1),
                .SIG_IN2(sig2),
                .CLOCK_N(topclk),
                .SIG_OUT1(out1),
                .SIG_OUT2(out2),
                .wb_en(WEIGHTBIAS_EN)
                );

    //toggle clock every 5 sim cycles
    always #5 topclk = ~topclk;
    
    //dump signals to a dumpfile
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars();
    end
    
    initial begin
        //initialise values of registers
        topclk = 0;
        sig1 = 0;
        sig2 = 0;
        WEIGHTBIAS_EN = 0;
        #10
        //enable in order to set values of Weight & 
        //Bias registers
        WEIGHTBIAS_EN = 1;
        //allow time for weight and bias values to set
        #10
        WEIGHTBIAS_EN = 0;
        #80
        //run through 10 signal inputs
        //to be compared to keras output
        sig1 = 16'hb99a;
        sig2 = 16'he28f;
        #10
        sig1 = 16'h35c3;
        sig2 = 16'h7c28;
        #10
        sig1 = 16'h6e14;
        sig2 = 16'hd47b;
        #10
        sig1 = 16'h8148;
        sig2 = 16'ha000;
        #10
        sig1 = 16'h4f5c;
        sig2 = 16'hf0a3;
        #10
        sig1 = 16'h7eb8;
        sig2 = 16'h6e14;
        #10
        sig1 = 16'hce14;
        sig2 = 16'he51e;
        #10
        sig1 = 16'hae15;
        sig2 = 16'h628f;
        #10
        sig1 = 16'h747a;
        sig2 = 16'hf999;
        #10
        sig1 = 16'h0f5d;
        sig2 = 16'hea3d;
        //wait 30 sim cycles at the end
        //system has 2 clock cycle delay between input and output
        #30
        sig1 = 0;
        sig2 = 0;
        #10
        
        $finish;
    end
    
endmodule
