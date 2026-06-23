`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2026 21:11:32
// Design Name: 
// Module Name: aes_transaction
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

class aes_transaction;

  rand bit [127:0] plaintext;
  rand bit [127:0] key;

  bit [127:0] expected_ciphertext;
  bit [127:0] actual_ciphertext;
  
  time start_time;
  time end_time;

  string test_name;

  function void display(input string tag);
    $display("[%s] Test Name : %s", tag, test_name);
    $display("[%s] Plaintext : %032h", tag, plaintext);
    $display("[%s] Key       : %032h", tag, key);
    $display("[%s] Expected  : %032h", tag, expected_ciphertext);
    $display("[%s] Actual    : %032h", tag, actual_ciphertext);
  endfunction

endclass
