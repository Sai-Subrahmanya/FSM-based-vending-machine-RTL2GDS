// IC Compiler II Version W-2024.09-SP1 Verilog Writer
// Library Name: vending_machine_lib
// Block Name: vending_machine
// User Label: 
// Write Command: write_verilog ../results/vending_machine_icc2.v
module vending_machine ( Clock , rst , in , out , change ) ;
input  Clock ;
input  rst ;
input  [1:0] in ;
output out ;
output [1:0] change ;

wire [1:0] c_state ;

INVX0_RVT U18 ( .A ( in[1] ) , .Y ( n11 ) ) ;
NOR2X0_RVT U19 ( .A1 ( rst ) , .A2 ( c_state[1] ) , .Y ( n19 ) ) ;
NAND2X0_RVT U20 ( .A1 ( c_state[0] ) , .A2 ( n19 ) , .Y ( n14 ) ) ;
NAND2X0_RVT U21 ( .A1 ( in[0] ) , .A2 ( n11 ) , .Y ( n17 ) ) ;
OR2X1_RVT U22 ( .A1 ( n11 ) , .A2 ( in[0] ) , .Y ( n18 ) ) ;
NAND2X0_RVT U23 ( .A1 ( n17 ) , .A2 ( n18 ) , .Y ( n13 ) ) ;
INVX0_RVT U24 ( .A ( rst ) , .Y ( n12 ) ) ;
NAND3X0_RVT U25 ( .A1 ( c_state[1] ) , .A2 ( n22 ) , .A3 ( n12 ) , 
    .Y ( n15 ) ) ;
OAI22X1_RVT U26 ( .A1 ( n14 ) , .A2 ( n13 ) , .A3 ( n18 ) , .A4 ( n15 ) , 
    .Y ( N14 ) ) ;
NOR2X0_RVT U27 ( .A1 ( n13 ) , .A2 ( n15 ) , .Y ( N15 ) ) ;
INVX0_RVT U28 ( .A ( n13 ) , .Y ( n16 ) ) ;
OAI22X1_RVT U29 ( .A1 ( n16 ) , .A2 ( n15 ) , .A3 ( n14 ) , .A4 ( n18 ) , 
    .Y ( N13 ) ) ;
INVX0_RVT U30 ( .A ( n17 ) , .Y ( n20 ) ) ;
AND3X1_RVT U31 ( .A1 ( n19 ) , .A2 ( n20 ) , .A3 ( n22 ) , .Y ( N11 ) ) ;
INVX0_RVT U32 ( .A ( n18 ) , .Y ( n21 ) ) ;
OA221X1_RVT U33 ( .A1 ( c_state[0] ) , .A2 ( n21 ) , .A3 ( n22 ) , 
    .A4 ( n20 ) , .A5 ( n19 ) , .Y ( N12 ) ) ;
DFFSSRX1_RVT \c_state_reg[0] ( .D ( 1'b0 ) , .SETB ( 1'b0 ) , .RSTB ( N11 ) , 
    .CLK ( Clock ) , .Q ( c_state[0] ) , .QN ( n22 ) ) ;
DFFSSRX1_RVT \c_state_reg[1] ( .D ( 1'b0 ) , .SETB ( 1'b0 ) , .RSTB ( N12 ) , 
    .CLK ( Clock ) , .Q ( c_state[1] ) ) ;
DFFSSRX1_RVT \change_reg[1] ( .D ( 1'b0 ) , .SETB ( 1'b0 ) , .RSTB ( N15 ) , 
    .CLK ( Clock ) , .Q ( change[1] ) ) ;
DFFSSRX1_RVT \change_reg[0] ( .D ( 1'b0 ) , .SETB ( 1'b0 ) , .RSTB ( N14 ) , 
    .CLK ( Clock ) , .Q ( change[0] ) ) ;
DFFSSRX1_RVT out_reg ( .D ( 1'b0 ) , .SETB ( 1'b0 ) , .RSTB ( N13 ) , 
    .CLK ( Clock ) , .Q ( out ) ) ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x50000y50000 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x60640y50000 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x62160y50000 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x63680y50000 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x65200y50000 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x74320y50000 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x75840y50000 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x77360y50000 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x78880y50000 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x80400y50000 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x95600y50000 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x97120y50000 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x98640y50000 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x100160y50000 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x101680y50000 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x103200y50000 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x50000y66720 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x51520y66720 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x53040y66720 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x115360y66720 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x116880y66720 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x118400y66720 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x119920y66720 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x121440y66720 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x122960y66720 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x124480y66720 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x126000y66720 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x127520y66720 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x129040y66720 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x138160y66720 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x139680y66720 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x141200y66720 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x142720y66720 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x144240y66720 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x145760y66720 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x57600y83440 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x59120y83440 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x60640y83440 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x97120y83440 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x98640y83440 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x100160y83440 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x101680y83440 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x103200y83440 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x50000y100160 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x63680y100160 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x65200y100160 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x66720y100160 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x68240y100160 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x69760y100160 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x89520y100160 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x91040y100160 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x92560y100160 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x57600y116880 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x83440y116880 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x127520y116880 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x129040y116880 () ;
SHFILL1_RVT \xofiller!SHFILL1_RVT!x145760y116880 () ;
endmodule


