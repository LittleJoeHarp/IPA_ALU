`timescale 1ns/1ps

module testbench;
  reg [63:0] A, B;
  wire Result;

  // Instantiate the SLTU module
  sltu uut (
    .A(A),
    .B(B),
    .Result(Result)
  );

  initial begin
    $display("Starting SLTU Testbench...");

    // Test Case 1: A = 5, B = 10 (A < B)
    A = 64'h0000000000000005;
    B = 64'h000000000000000A;
    #10;
    $display("Test 1: A = %h, B = %h, Result = %b", A, B, Result);

    // Test Case 2: A = 15, B = 5 (A > B)
    A = 64'h000000000000000F;
    B = 64'h0000000000000005;
    #10;
    $display("Test 2: A = %h, B = %h, Result = %b", A, B, Result);

    // Test Case 3: A = 0, B = 1 (A < B)
    A = 64'h0000000000000000;
    B = 64'h0000000000000001;
    #10;
    $display("Test 3: A = %h, B = %h, Result = %b", A, B, Result);

    // Test Case 4: Large unsigned numbers
    A = 64'h7FFFFFFFFFFFFFFF;
    B = 64'h8000000000000000;
    #10;
    $display("Test 4: A = %h, B = %h, Result = %b", A, B, Result);

    // Test Case 5: Equal values (A == B)
    A = 64'hFFFFFFFFFFFFFFFF;
    B = 64'hFFFFFFFFFFFFFFFF;
    #10;
    $display("Test 5: A = %h, B = %h, Result = %b", A, B, Result);

    $display("Testbench Completed.");
    $stop;
  end
endmodule
