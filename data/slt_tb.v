`timescale 1ns/1ps

module testbench;
  reg [63:0] A, B;
  wire Result;

  // Instantiate the SLT module
  slt uut (
    .A(A),
    .B(B),
    .Result(Result)
  );

  initial begin
    $display("Starting SLT Testbench...");

    // Test Case 1: A = 5, B = 10 (A < B)
    A = 64'h0000000000000005;
    B = 64'h000000000000000A;
    #10;
    $display("Test 1: A = %h, B = %h, Result = %b", A, B, Result);

    // Test Case 2: A = -10, B = -5 (A < B)
    A = 64'hFFFFFFFFFFFFFFF6; // -10 in 2's complement
    B = 64'hFFFFFFFFFFFFFFFB; // -5 in 2's complement
    #10;
    $display("Test 2: A = %h, B = %h, Result = %b", A, B, Result);

    // Test Case 3: A = 10, B = 5 (A > B)
    A = 64'h000000000000000A;
    B = 64'h0000000000000005;
    #10;
    $display("Test 3: A = %h, B = %h, Result = %b", A, B, Result);

    // Test Case 4: A = -1, B = 0 (A < B)
    A = 64'hFFFFFFFFFFFFFFFF; // -1 in 2's complement
    B = 64'h0000000000000000; // 0
    #10;
    $display("Test 4: A = %h, B = %h, Result = %b", A, B, Result);

    // Test Case 5: A = 0, B = 0 (A == B)
    A = 64'h0000000000000000;
    B = 64'h0000000000000000;
    #10;
    $display("Test 5: A = %h, B = %h, Result = %b", A, B, Result);

    $display("Testbench Completed.");
    $stop;
  end
endmodule
