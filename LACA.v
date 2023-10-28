`timescale 1ns/100ps
module LACA(S,C_out,C_in,A,B);
  input [3:0]A,B;
  input C_in;
  output [3:0] S;
  output C_out;
  wire G0,G1,G2,G3,P0,P1,P2,P3,C1,C2,C3,t1,t2,t3,t4,t5,t6,t7,t8,t9,u1,u2,u3,u4,u5;
  //1st level
  xor #4 c1(P0,A[0],B[0]);xor #4 c2(P1,A[1],B[1]);xor #4 c3(P2,A[2],B[2]);xor #4 c4(P3,A[3],B[3]);
  and #5 c5(G0,A[0],B[0]);and #5 c6(G1,A[1],B[1]);and #5 c7(G2,A[2],B[2]);and #5 c8(G3,A[3],B[3]);
  //2nd level
  and #5 c9(t1,P0,C_in);and #5 c10(t3,P0,P1,C_in);and #5 c11(t4,P1,G0);
  and #5 c12(t6,P0,P1,P2,C_in);and #5 c13(t7,P2,P1,G0);and #5 c14(t8,P2,G1);and #5 c15(u1,P3,P2,P1,P0,C_in);
  and #5 c16(u2,P3,P2,P1,G0);and #5 c17(u3,P3,P2,G1);and #5 c18(u4,P3,G2);
  //3rd level
  or #3 v1(C1,t1,G0);or #3 v2(C2,t3,t4,G1);or #3 v3(C3,t6,t7,t8,G2);or #3 v4(C_out,u1,u2,u3,u4,G3);
  //4th level
  xor #4 b1(S[0],P0,C_in);xor #4 b2(S[1],P1,C1);xor #4 b3(S[2],P2,C2);xor #4 b4(S[3],P3,C3);  
endmodule

module testb;
  reg  [3:0]A,B;
  reg  C_in;
  wire [3:0]S;  
  wire C_out;
  LACA CKT1(S,C_out,C_in,A,B);
   initial begin
     $dumpfile("LACA.vcd");
     $dumpvars(0,testb);
     $monitor(S,C_out,C_in,A,B);
           C_in=1;A=4'b1010;B=4'b0101;
         #65 C_in=0;A=4'b0000;B=4'b0000;
         #5  C_in=0;
   end
endmodule         
