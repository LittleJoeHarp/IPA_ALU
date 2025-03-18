`timescale 1ns/1ps

module testbench;
  reg [63:0] A, B;
  reg select; // Always 0 for ADD
  wire [63:0] Result;

  // Instantiate the ADD module
  add uut (
    .A(A),
    .B(B),
    .select(1'b0), // Always ADD operation
    .Result(Result)
  );

  initial begin
    $display("Starting ADD Testbench...");
    
    // Test Case 1: 0 + 0 = 0
    A = 64'h0000000000000000;
    B = 64'h0000000000000000;
    #10;
    $display("Test 1: A = %h, B = %h, Sum = %h", A, B, Result);
    
    // Test Case 2: Small numbers
    A = 64'h0000000000000005;
    B = 64'h0000000000000003;
    #10;
    $display("Test 2: A = %h, B = %h, Sum = %h", A, B, Result);

    // Test Case 3: Large numbers
    A = 64'hFFFFFFFFFFFFFFFF; // -1 in 2's complement
    B = 64'h0000000000000001; // 1
    #10;
    $display("Test 3: A = %h, B = %h, Sum = %h", A, B, Result);

    // Test Case 4: Random values
    A = 64'h123456789ABCDEF0;
    B = 64'h0FEDCBA987654321;
    #10;
    $display("Test 4: A = %h, B = %h, Sum = %h", A, B, Result);

    // Test Case 5: Overflow Case (Unsigned)
    A = 64'hFFFFFFFFFFFFFFF0;
    B = 64'h0000000000000010;
    #10;
    $display("Test 5: A = %h, B = %h, Sum = %h", A, B, Result);

    $display("Testbench Completed.");
    $stop;
  end
endmodule
