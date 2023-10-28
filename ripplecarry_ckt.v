`timescale 1ns/100ps
module fulladder_ckt(S,C_out,C_in,a,b);
    input  C_in,a,b;
    output C_out,S;
    wire t1,t2,t3;
    xor #4 c1(t1,a,b);
    xor #4 c2(S,t1,C_in);
    and #5 c3(t2,a,b);
    and #5 c4(t3,t1,C_in);
    or  #3 c5(C_out,t3,t2);
endmodule

module ripplecarry_ckt(S,C_out,C_in,A,B);
     input  [3:0]A,B;
     input  C_in;
     output [3:0]S;
     output C_out;
     wire   [2:0]t;     
    fulladder_ckt ckt1(S[0],t[0],C_in,A[0],B[0]);
    fulladder_ckt ckt2(S[1],t[1],t[0],A[1],B[1]);
    fulladder_ckt ckt3(S[2],t[2],t[1],A[2],B[2]);
    fulladder_ckt ckt4(S[3],C_out,t[2],A[3],B[3]);
   // fulladder_ckt ckt5(S[3],S[4],t[2],A[3],B[3]);  
endmodule     

module rippletb;
  reg  [3:0]a,b;
  reg  C_in;
  wire [3:0]S;
  wire  C_Out;     
  ripplecarry_ckt  ckt(S,C_out,C_in,a,b);
      initial begin
       
           $dumpfile("ripplecarry_ckt.vcd");
           $dumpvars(0,rippletb);
           $monitor(S,C_out,C_in,a,b);
         //#5 C_in=1;a=4'b0000;b=4'b0000;
          C_in=1;a=4'b1010;b=4'b0101;
         #65 C_in=0;a=4'b0000;b=4'b0000;
         #5  C_in=0;
      end
   endmodule      
