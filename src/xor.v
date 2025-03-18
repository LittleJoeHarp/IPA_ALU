module bit_xor (
  input A, B,    // 1-bit inputs
  output Y       // 1-bit XOR output
);
  wire not_A, not_B, and1, and2;

  // NOT gates
  not (not_A, A);
  not (not_B, B);

  // AND gates
  and (and1, A, not_B);  // A AND NOT(B)
  and (and2, not_A, B);  // NOT(A) AND B

  // OR gate for final XOR
  or (Y, and1, and2);
endmodule

module xor64 (  // Renamed module to avoid conflict with Verilog's reserved keyword
  input [63:0] A, B,  // 64-bit inputs
  output [63:0] Y     // 64-bit XOR output
);
  genvar i;

  // Generate 1-bit XOR gates for each bit
  generate
    for (i = 0; i < 64; i = i + 1) begin
      bit_xor xor_gate (
        .A(A[i]),
        .B(B[i]),
        .Y(Y[i])
      );
    end
  endgenerate
endmodule
