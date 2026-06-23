`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2026 21:24:34
// Design Name: 
// Module Name: program
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


program aes_program(
    aes_interface.DRIVER  drv_mp,
    aes_interface.MONITOR mon_mp
);

  test t;

  initial begin
    t = new(drv_mp, mon_mp);
    t.run();
  end

endprogram
