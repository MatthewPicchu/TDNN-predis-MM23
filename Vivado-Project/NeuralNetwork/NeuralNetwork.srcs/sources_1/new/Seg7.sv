module Seg7(
    input [15:0] in1,
    input [15:0] in2,
    input topclk,
    output reg [6:0] seg,
    output reg [7:0] an,
    output reg dp
  );
  reg [3:0] seg_in;
  reg [2:0] state;
  reg [16:0] timer;
  assign dp = 1;



  seg7Decode(seg_in, seg);

  always@(posedge topclk)
  begin
    if(timer  == 99_999)
    begin
      timer <= 0;
      case(state)
        0:
        begin
          seg_in <= in1[3:0];
          an <= 8'b11111110;
        end
        1:
        begin
          seg_in <= in1[7:4];
          an <= 8'b11111101;
        end
        2:
        begin
          seg_in <= in1[11:8];
          an <= 8'b11111011;
        end
        3:
        begin
          seg_in <= in1[15:12];
          an <= 8'b11110111;
        end
        4:
        begin
          seg_in <= in2[3:0];
          an <= 8'b11101111;
        end
        5:
        begin
          seg_in <= in2[7:4];
          an <= 8'b11011111;
        end
        6:
        begin
          seg_in <= in2[11:8];
          an <= 8'b10111111;
        end
        7:
        begin
          seg_in <= in2[15:12];
          an <= 8'b01111111;
        end
      endcase
      state <= state+1;
    end
    else
      timer <= timer+1;
  end

endmodule


module seg7Decode(
    input  [3:0]x,
    output reg [6:0]z
  );
  always @*
  case (x)
    4'b0000 :      	//Hexadecimal 0
      z = 7'b1000000;
    4'b0001 :    		//Hexadecimal 1
      z = 7'b1111001;
    4'b0010 :  		// Hexadecimal 2
      z = 7'b0100100;
    4'b0011 : 		// Hexadecimal 3
      z = 7'b0110000;
    4'b0100 :		// Hexadecimal 4
      z = 7'b0011001;
    4'b0101 :		// Hexadecimal 5
      z = 7'b0010010;
    4'b0110 :		// Hexadecimal 6
      z = 7'b0000010;
    4'b0111 :		// Hexadecimal 7
      z = 7'b1111000;
    4'b1000 :     		 //Hexadecimal 8
      z = 7'b0000000;
    4'b1001 :    		//Hexadecimal 9
      z = 7'b0010000;
    4'b1010 :  		// Hexadecimal A
      z = 7'b0001000;
    4'b1011 : 		// Hexadecimal B
      z = 7'b0000011;
    4'b1100 :		// Hexadecimal C
      z = 7'b1000110 ;
    4'b1101 :		// Hexadecimal D
      z = 7'b0100001;
    4'b1110 :		// Hexadecimal E
      z = 7'b0000110;
    4'b1111 :		// Hexadecimal F
      z = 7'b0001110;
  endcase

endmodule
