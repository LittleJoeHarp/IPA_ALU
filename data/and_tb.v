`timescale 1ns/1ps

module testbench;
  reg [63:0] A, B;
  wire [63:0] Y;

  // Instantiate the 64-bit AND module
  and64 uut (
    .A(A),
    .B(B),
    .Y(Y)
  );

  initial begin
    $display("Starting AND Testbench...");

    // Test Case 1: Simple AND
    A = 64'h0F0F0F0F0F0F0F0F;
    B = 64'hF0F0F0F0F0F0F0F0;
    #10;
    $display("Test 1: A = %h, B = %h, Y = %h", A, B, Y);

    // Test Case 2: A = 0xFF, B = 0x00
    A = 64'h00000000000000FF;
    B = 64'h0000000000000000;
    #10;
    $display("Test 2: A = %h, B = %h, Y = %h", A, B, Y);

    // Test Case 3: A = 0x123456789ABCDEF0, B = 0x0FEDCBA987654321
    A = 64'h123456789ABCDEF0;
    B = 64'h0FEDCBA987654321;
    #10;
    $display("Test 3: A = %h, B = %h, Y = %h", A, B, Y);

    // Test Case 4: A = 0xFFFFFFFFFFFFFFFF, B = 0xFFFFFFFFFFFFFFFF
    A = 64'hFFFFFFFFFFFFFFFF;
    B = 64'hFFFFFFFFFFFFFFFF;
    #10;
    $display("Test 4: A = %h, B = %h, Y = %h", A, B, Y);

    // Test Case 5: A = 0x0, B = 0x0
    A = 64'h0000000000000000;
    B = 64'h0000000000000000;
    #10;
    $display("Test 5: A = %h, B = %h, Y = %h", A, B, Y);

    $display("Testbench Completed.");
    $stop;
  end
endmodule
