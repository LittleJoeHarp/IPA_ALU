`timescale 1ns/1ps

module testbench;
  reg [63:0] A;
  reg [5:0] shamt;
  wire [63:0] Result;

  // Instantiate the SRL module
  srl uut (
    .A(A),
    .shamt(shamt),
    .Result(Result)
  );

  initial begin
    $display("Starting SRL Testbench...");

    // Test Case 1: No shift
    A = 64'hFF00000000000000;
    shamt = 6'd0;
    #10;
    $display("Test 1: A = %h, shamt = %d, Result = %h", A, shamt, Result);

    // Test Case 2: Shift by 1
    A = 64'hFF00000000000000;
    shamt = 6'd1;
    #10;
    $display("Test 2: A = %h, shamt = %d, Result = %h", A, shamt, Result);

    // Test Case 3: Shift by 8
    A = 64'hFF00000000000000;
    shamt = 6'd8;
    #10;
    $display("Test 3: A = %h, shamt = %d, Result = %h", A, shamt, Result);

    // Test Case 4: Shift by 32
    A = 64'hFF00000000000000;
    shamt = 6'd32;
    #10;
    $display("Test 4: A = %h, shamt = %d, Result = %h", A, shamt, Result);

    // Test Case 5: Shift by 63
    A = 64'h8000000000000000;
    shamt = 6'd63;
    #10;
    $display("Test 5: A = %h, shamt = %d, Result = %h", A, shamt, Result);

    $display("Testbench Completed.");
    $stop;
  end
endmodule
