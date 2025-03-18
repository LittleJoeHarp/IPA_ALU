module bit_or (
  input A, B,    // 1-bit inputs
  output Y       // 1-bit OR output
);
  or (Y, A, B); // OR gate
endmodule

module or64 (
  input [63:0] A, B,  // 64-bit inputs
  output [63:0] Y     // 64-bit OR output
);
  genvar i;

  // Generate 1-bit OR gates for each bit
  generate
    for (i = 0; i < 64; i = i + 1) begin
      bit_or or_gate (
        .A(A[i]),
        .B(B[i]),
        .Y(Y[i])
      );
    end
  endgenerate
endmodule
