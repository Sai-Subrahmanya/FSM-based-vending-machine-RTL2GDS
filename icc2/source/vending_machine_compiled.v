/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : W-2024.09-SP1
/////////////////////////////////////////////////////////////


module vending_machine ( Clock, rst, in, out, change );
  input [1:0] in;
  output [1:0] change;
  input Clock, rst;
  output out;
  wire   N11, N12, N13, N14, N15, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20, n21, n22;
  wire   [1:0] c_state;

  INVX0_RVT U18 ( .A(in[1]), .Y(n11) );
  NOR2X0_RVT U19 ( .A1(rst), .A2(c_state[1]), .Y(n19) );
  NAND2X0_RVT U20 ( .A1(c_state[0]), .A2(n19), .Y(n14) );
  NAND2X0_RVT U21 ( .A1(in[0]), .A2(n11), .Y(n17) );
  OR2X1_RVT U22 ( .A1(n11), .A2(in[0]), .Y(n18) );
  NAND2X0_RVT U23 ( .A1(n17), .A2(n18), .Y(n13) );
  INVX0_RVT U24 ( .A(rst), .Y(n12) );
  NAND3X0_RVT U25 ( .A1(c_state[1]), .A2(n22), .A3(n12), .Y(n15) );
  OAI22X1_RVT U26 ( .A1(n14), .A2(n13), .A3(n18), .A4(n15), .Y(N14) );
  NOR2X0_RVT U27 ( .A1(n13), .A2(n15), .Y(N15) );
  INVX0_RVT U28 ( .A(n13), .Y(n16) );
  OAI22X1_RVT U29 ( .A1(n16), .A2(n15), .A3(n14), .A4(n18), .Y(N13) );
  INVX0_RVT U30 ( .A(n17), .Y(n20) );
  AND3X1_RVT U31 ( .A1(n19), .A2(n20), .A3(n22), .Y(N11) );
  INVX0_RVT U32 ( .A(n18), .Y(n21) );
  OA221X1_RVT U33 ( .A1(c_state[0]), .A2(n21), .A3(n22), .A4(n20), .A5(n19), 
        .Y(N12) );
  DFFSSRX1_RVT \c_state_reg[0]  ( .D(1'b0), .SETB(1'b0), .RSTB(N11), .CLK(
        Clock), .Q(c_state[0]), .QN(n22) );
  DFFSSRX1_RVT \c_state_reg[1]  ( .D(1'b0), .SETB(1'b0), .RSTB(N12), .CLK(
        Clock), .Q(c_state[1]) );
  DFFSSRX1_RVT \change_reg[1]  ( .D(1'b0), .SETB(1'b0), .RSTB(N15), .CLK(Clock), .Q(change[1]) );
  DFFSSRX1_RVT \change_reg[0]  ( .D(1'b0), .SETB(1'b0), .RSTB(N14), .CLK(Clock), .Q(change[0]) );
  DFFSSRX1_RVT out_reg ( .D(1'b0), .SETB(1'b0), .RSTB(N13), .CLK(Clock), .Q(
        out) );
endmodule

