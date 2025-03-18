module bit_comparator (
  input A, B, higher_priority,
  output less_than
);
  wire A_less_B, A_equal_B, and_result;

  // Logic for A < B
  not (not_A, A);
  and (A_less_B, not_A, B); // (~A & B)

  // Logic for A == B
  xor (xor_result, A, B);
  not (A_equal_B, xor_result); // ~(A ^ B)

  // Combine A == B with higher priority
  and (and_result, A_equal_B, higher_priority); // (A == B) & higher_priority

  // Final result: (A < B) | ((A == B) & higher_priority)
  or (less_than, A_less_B, and_result);
endmodule

module sltu (
  input [63:0] A, B,        // Unsigned 64-bit inputs
  output Result             // Single-bit output: 1 if A < B, 0 otherwise
);
  wire [63:0] less_than;    // Intermediate less-than signals for each bit

  // Generate bit comparators
  genvar i;
  generate
    for (i = 63; i >= 0; i = i - 1) begin
      if (i == 63) begin
        // MSB: No higher-priority result to propagate
        bit_comparator comp (
          .A(A[i]),
          .B(B[i]),
          .higher_priority(1'b0), // No higher-priority result for MSB
          .less_than(less_than[i])
        );
      end else begin
        // Other bits: Propagate from higher-priority bits
        bit_comparator comp (
          .A(A[i]),
          .B(B[i]),
          .higher_priority(less_than[i + 1]), // Result from the higher-priority bit
          .less_than(less_than[i])
        );
      end
    end
  endgenerate

  // The final result comes from the LSB
  buf (Result, less_than[0]);
endmodule
