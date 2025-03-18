`timescale 1ns/1ps

module testbench;
  reg [63:0] A, B;
  reg [5:0] shamt;
  reg [2:0] func3;
  reg [6:0] func7;
  wire [63:0] Result;
  wire Comparison;

  alu uut (
    .A(A),
    .B(B),
    .shamt(shamt),
    .func3(func3),
    .func7(func7),
    .Result(Result),
    .Comparison(Comparison)
  );

  initial begin
    $display("Starting ALU Testbench...");

    // Test ADD
    A = 64'h0000000000000005;
    B = 64'h0000000000000003;
    func3 = 3'b000; func7 = 7'b0000000; // ADD
    #10;
    $display("Test ADD -> A = %h, B = %h, Result = %h", A, B, Result);

    // Test SUB
    func3 = 3'b000; func7 = 7'b0100000; // SUB
    #10;
    $display("Test SUB -> A = %h, B = %h, Result = %h", A, B, Result);

    // Test SLL
    shamt = 6'd2;
    func3 = 3'b001; func7 = 7'b0000000; // SLL
    #10;
    $display("Test SLL -> A = %h, shamt = %d, Result = %h", A, shamt, Result);

    // Test SLT
    func3 = 3'b010; func7 = 7'b0000000; // SLT
    #10;
    $display("Test SLT -> A = %h, B = %h, Comparison = %b", A, B, Comparison);

    // Test SLTU
    func3 = 3'b011; func7 = 7'b0000000; // SLTU
    A = 64'hFFFFFFFFFFFFFFFF; B = 64'h0000000000000001;
    #10;
    $display("Test SLTU -> A = %h, B = %h, Comparison = %b", A, B, Comparison);

    // Test XOR
    A = 64'h123456789ABCDEF0; B = 64'hFEDCBA9876543210;
    func3 = 3'b100; func7 = 7'b0000000; // XOR
    #10;
    $display("Test XOR -> A = %h, B = %h, Result = %h", A, B, Result);

    // Test SRL
    A = 64'hF000000000000000; shamt = 6'd4;
    func3 = 3'b101; func7 = 7'b0000000; // SRL
    #10;
    $display("Test SRL -> A = %h, shamt = %d, Result = %h", A, shamt, Result);

    // Test SRA
    func3 = 3'b101; func7 = 7'b0100000; // SRA
    #10;
    $display("Test SRA -> A = %h, shamt = %d, Result = %h", A, shamt, Result);

    // Test OR
    A = 64'h0F0F0F0F0F0F0F0F; B = 64'hF0F0F0F0F0F0F0F0;
    func3 = 3'b110; func7 = 7'b0000000; // OR
    #10;
    $display("Test OR -> A = %h, B = %h, Result = %h", A, B, Result);

    // Test AND
    func3 = 3'b111; func7 = 7'b0000000; // AND
    #10;
    $display("Test AND -> A = %h, B = %h, Result = %h", A, B, Result);

    $display("Testbench Completed.");
    $stop;
  end
endmodule
