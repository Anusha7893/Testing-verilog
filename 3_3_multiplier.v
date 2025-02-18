`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.02.2025 18:53:15
// Design Name: 
// Module Name: 3_3_multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module multiplier_gate_level(
    input [2:0] a,  // First input (3 bits)
    input [2:0] b,  // Second input (3 bits)
    output [5:0] y  // Output (6 bits)
);
    // Partial products
    wire [8:0] pp;   // 9 partial products
    wire [14:0] c;   // Carries
    wire [7:0] s;    // Intermediate sums

    // Generate partial products
    // First row (b[0])
    and a1(pp[0], a[0], b[0]);  // a0b0
    and a2(pp[1], a[1], b[0]);  // a1b0
    and a3(pp[2], a[2], b[0]);  // a2b0

    // Second row (b[1])
    and a4(pp[3], a[0], b[1]);  // a0b1
    and a5(pp[4], a[1], b[1]);  // a1b1
    and a6(pp[5], a[2], b[1]);  // a2b1

    // Third row (b[2])
    and a7(pp[6], a[0], b[2]);  // a0b2
    and a8(pp[7], a[1], b[2]);  // a1b2
    and a9(pp[8], a[2], b[2]);  // a2b2

    // First bit is direct
    buf b1(y[0], pp[0]);  // y0 = a0b0

    // Second bit using half adder
    xor x1(y[1], pp[1], pp[3]);  // Sum
    and a10(c[0], pp[1], pp[3]); // Carry

    // Third bit - Full adder with carry from previous stage
    xor x2(s[0], pp[2], pp[4]);
    xor x3(s[1], s[0], c[0]);    // Include previous carry
    xor x4(y[2], s[1], pp[6]);
    
    and a11(c[1], pp[2], pp[4]);
    and a12(c[2], s[0], c[0]);
    and a13(c[3], s[1], pp[6]);
    
    or o1(c[4], c[1], c[2]);
    or o2(c[5], c[4], c[3]);

    // Fourth bit
    xor x5(s[2], pp[5], pp[7]);
    xor x6(y[3], s[2], c[5]);
    
    and a14(c[6], pp[5], pp[7]);
    and a15(c[7], s[2], c[5]);
    or o3(c[8], c[6], c[7]);

    // Fifth and sixth bits
    xor x7(y[4], pp[8], c[8]);
    and a16(y[5], pp[8], c[8]);
endmodule