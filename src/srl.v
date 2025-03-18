module srl(
  input [63:0] A,         // Input data
  input [5:0] shamt,      // Shift amount (5 bits for up to 63 shifts)
  output [63:0] Result    // Shifted output
);
  wire [63:0] stage1, stage2, stage3, stage4, stage5; // Intermediate wires

  // Stage 1: Shift by 1 bit
  genvar i;
  generate
    for (i = 0; i < 64; i = i + 1) begin
      if (i == 63)
        mux2to1 MUX (A[i], 1'b0, shamt[0], stage1[i]); // MSB gets 0
      else
        mux2to1 MUX (A[i], A[i+1], shamt[0], stage1[i]);
    end
  endgenerate

  // Stage 2: Shift by 2 bits
  generate
    for (i = 0; i < 64; i = i + 1) begin
      if (i >= 62)
        mux2to1 MUX (stage1[i], 1'b0, shamt[1], stage2[i]); // Top 2 bits get 0
      else
        mux2to1 MUX (stage1[i], stage1[i+2], shamt[1], stage2[i]);
    end
  endgenerate

  // Stage 3: Shift by 4 bits
  generate
    for (i = 0; i < 64; i = i + 1) begin
      if (i >= 60)
        mux2to1 MUX (stage2[i], 1'b0, shamt[2], stage3[i]); // Top 4 bits get 0
      else
        mux2to1 MUX (stage2[i], stage2[i+4], shamt[2], stage3[i]);
    end
  endgenerate

  // Stage 4: Shift by 8 bits
  generate
    for (i = 0; i < 64; i = i + 1) begin
      if (i >= 56)
        mux2to1 MUX (stage3[i], 1'b0, shamt[3], stage4[i]); // Top 8 bits get 0
      else
        mux2to1 MUX (stage3[i], stage3[i+8], shamt[3], stage4[i]);
    end
  endgenerate

  // Stage 5: Shift by 16 bits
  generate
    for (i = 0; i < 64; i = i + 1) begin
      if (i >= 48)
        mux2to1 MUX (stage4[i], 1'b0, shamt[4], stage5[i]); // Top 16 bits get 0
      else
        mux2to1 MUX (stage4[i], stage4[i+16], shamt[4], stage5[i]);
    end
  endgenerate

  // Final Stage: Shift by 32 bits
  generate
    for (i = 0; i < 64; i = i + 1) begin
      if (i >= 32)
        mux2to1 MUX (stage5[i], 1'b0, shamt[5], Result[i]); // Top 32 bits get 0
      else
        mux2to1 MUX (stage5[i], stage5[i+32], shamt[5], Result[i]);
    end
  endgenerate

endmodule
