module sub (
  input [63:0] A, B,
  output [63:0] Result
);
  wire [63:0] B_inverted;
  
  // Invert B for 2's complement
  genvar i;
  generate
    for (i = 0; i < 64; i = i + 1) begin
      not (B_inverted[i], B[i]); // NOT B
    end
  endgenerate

  // Use the ripple carry adder with Cin = 1
  wire Cout;
  ripple_carry_adder RCA (A, B_inverted, 1'b1, Result, Cout);
  
endmodule
