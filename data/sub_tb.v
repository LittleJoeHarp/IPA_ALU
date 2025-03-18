`timescale 1ns/1ps

module testbench;
  reg [63:0] A, B;
  wire [63:0] Result;

  // Instantiate the SUB module
  sub uut (
    .A(A),
    .B(B),
    .Result(Result)
  );

  initial begin
    $display("Starting SUB Testbench...");
    
    // Test Case 1: 5 - 3 = 2
    A = 64'h0000000000000005;
    B = 64'h0000000000000003;
    #10;
    $display("Test 1: A = %h, B = %h, Difference = %h", A, B, Result);

    // Test Case 2: 10 - 20 = -10 (2's complement)
    A = 64'h000000000000000A; // 10
    B = 64'h0000000000000014; // 20
    #10;
    $display("Test 2: A = %h, B = %h, Difference = %h", A, B, Result);

    // Test Case 3: 0 - 1 = -1 (all bits 1 in 2's complement)
    A = 64'h0000000000000000;
    B = 64'h0000000000000001;
    #10;
    $display("Test 3: A = %h, B = %h, Difference = %h", A, B, Result);

    // Test Case 4: Large Numbers
    A = 64'h123456789ABCDEF0;
    B = 64'h0FEDCBA987654321;
    #10;
    $display("Test 4: A = %h, B = %h, Difference = %h", A, B, Result);

    // Test Case 5: Overflow Case (Large Negative)
    A = 64'h8000000000000000; // -2^63
    B = 64'h0000000000000001; // 1
    #10;
    $display("Test 5: A = %h, B = %h, Difference = %h", A, B, Result);

    $display("Testbench Completed.");
    $stop;
  end
endmodule
