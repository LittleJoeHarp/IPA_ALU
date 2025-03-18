module add (
  input [63:0] A, B,
  input select, // 0 for ADD, 1 for a future operation like SUB
  output [63:0] Result
);
  wire [63:0] B_selected;
  
  // MUX selects either B directly (for ADD) or ~B for subtraction (future use)
  genvar i;
  generate
    for (i = 0; i < 64; i = i + 1) begin
      mux2to1 MUX (B[i], ~B[i], select, B_selected[i]);
    end
  endgenerate

  // Ripple carry adder
  wire Cout;
  ripple_carry_adder RCA (A, B_selected, select, Result, Cout);
  
endmodule

module ripple_carry_adder (
  input [63:0] A, B,
  input Cin, // Initial carry-in (should be 0 for addition)
  output [63:0] Sum,
  output Cout // Final carry-out (optional, can be ignored)
);
  wire [63:0] carry; // Internal carry wires
  
  // First full adder (handles LSB)
  full_adder FA0 (A[0], B[0], Cin, Sum[0], carry[0]);

  // Generate full adders for each bit position
  genvar i;
  generate
    for (i = 1; i < 64; i = i + 1) begin
      full_adder FA (A[i], B[i], carry[i-1], Sum[i], carry[i]);
    end
  endgenerate

  assign Cout = carry[63]; // Final carry-out
endmodule

module mux2to1 (
  input A, B, sel,
  output Y
);
  assign Y = sel ? B : A;
endmodule

module full_adder (
  input A, B, Cin,
  output Sum, Cout
);
  wire xor1_out, and1_out, and2_out;
  
  xor (xor1_out, A, B);       // A ⊕ B
  xor (Sum, xor1_out, Cin);   // (A ⊕ B) ⊕ Cin
  and (and1_out, A, B);       // A & B
  and (and2_out, xor1_out, Cin); // (A ⊕ B) & Cin
  or (Cout, and1_out, and2_out); // Carry = (A & B) | ((A ⊕ B) & Cin)
  
endmodule
