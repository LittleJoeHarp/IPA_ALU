module slt (
  input [63:0] A, B,         // 64-bit signed inputs
  output Result              // Single-bit output: 1 if A < B, 0 otherwise
);
  wire [63:0] sub_result;    // Result of A - B
  wire Cout;                 // Ignored carry-out from subtraction

  // Perform subtraction: A - B
sub subtractor (
  .A(A),
  .B(B),
  .Result(sub_result)
);

  // Determine the sign of the result
  assign Result = sub_result[63]; // MSB of subtraction result indicates if A < B
endmodule

