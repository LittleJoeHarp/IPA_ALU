module alu (
  input [63:0] A, B,            // 64-bit inputs
  input [5:0] shamt,            // Shift amount for SLL, SRL, SRA
  input [2:0] func3,            // 3-bit function code
  input [6:0] func7,            // 7-bit function code
  output [63:0] Result,         // 64-bit output
  output Comparison             // 1-bit output for SLT/SLTU
);
  // Wires for individual operations
  wire [63:0] add_result, sub_result, sll_result, srl_result, sra_result, xor_result, and_result, or_result;
  wire slt_result, sltu_result;

  // Instantiate individual modules
  add adder (
    .A(A),
    .B(B),
    .select(1'b0), // ADD
    .Result(add_result)
  );

  sub subtractor (
    .A(A),
    .B(B),
    .Result(sub_result)
  );

  sll sll_shifter (
    .A(A),
    .shamt(shamt),
    .Result(sll_result)
  );

  srl srl_shifter (
    .A(A),
    .shamt(shamt),
    .Result(srl_result)
  );

  sra sra_shifter (
    .A(A),
    .shamt(shamt),
    .Result(sra_result)
  );

  xor64 xor_instance (
    .A(A),
    .B(B),
    .Y(xor_result)
  );

  and64 and_instance (
    .A(A),
    .B(B),
    .Y(and_result)
  );

  or64 or_instance (
    .A(A),
    .B(B),
    .Y(or_result)
  );

  slt slt_comp (
    .A(A),
    .B(B),
    .Result(slt_result)
  );

  sltu sltu_comp (
    .A(A),
    .B(B),
    .Result(sltu_result)
  );

  // Control logic for selecting the operation
  reg [63:0] alu_result;        // Intermediate result
  reg alu_comparison;           // Intermediate comparison result

  always @(*) begin
    case (func3)
      3'b000: alu_result = (func7 == 7'b0000000) ? add_result : // ADD
                           (func7 == 7'b0100000) ? sub_result : // SUB
                           64'b0;                               // Default
      3'b001: alu_result = sll_result;                          // SLL
      3'b010: alu_comparison = slt_result;                      // SLT
      3'b011: alu_comparison = sltu_result;                     // SLTU
      3'b100: alu_result = xor_result;                          // XOR
      3'b101: alu_result = (func7 == 7'b0000000) ? srl_result : // SRL
                           (func7 == 7'b0100000) ? sra_result : // SRA
                           64'b0;                               // Default
      3'b110: alu_result = or_result;                           // OR
      3'b111: alu_result = and_result;                          // AND
      default: begin
        alu_result = 64'b0;
        alu_comparison = 1'b0;
      end
    endcase
  end

  // Assign outputs
  assign Result = alu_result;
  assign Comparison = alu_comparison;

endmodule
