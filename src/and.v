module bit_and (
  input A, B,    // 1-bit inputs
  output Y       // 1-bit AND output
);
  and (Y, A, B); // AND gate
endmodule

module and64 (  // Renamed module
  input [63:0] A, B,  // 64-bit inputs
  output [63:0] Y     // 64-bit AND output
);
  genvar i;

  // Generate 1-bit AND gates for each bit
  generate
    for (i = 0; i < 64; i = i + 1) begin
      bit_and and_gate (
        .A(A[i]),
        .B(B[i]),
        .Y(Y[i])
      );
    end
  endgenerate
endmodule
