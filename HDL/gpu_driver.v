`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: DFX Company
// Engineer: Daniel Gutierrez
// 
// Create Date: 09/07/2023 07:23:05 PM
// Design Name: vga_driver.v
// Module Name: vga_driver
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Outputs VGA signals to VGA port
// 
// 
// Instantiation Template: 
// 
//    vga_driver my_VGA_driver(
//        .clk          (),
//        .pixel_data_o (),
//        .pixel_addr_o (),
//        .hsync_o      (),  
//        .vsync_o      (),
//        .in_disp_o    (),
//        .vgaRed_o     (), 
//        .vgaGreen_o   (), 
//        .vgaBlue_o    ()
//    ); 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module gpu_driver(
    input clk,      // 50MHz
    output Hsync,  
    output Vsync,
    output [3:0] vgaRed, 
    output [3:0] vgaGreen, 
    output [3:0] vgaBlue
    );  

    reg s_clk = 0;
    always @(posedge clk) begin
        s_clk = ~s_clk;
    end 



    GPU my_GPU(
        .clk            (s_clk),              // 50MHz
        .vram_we_i      (0),
        .vram_re_i      (0),
        .vram_data_i    (8'h00),  
        .vram_addr_i    (16'h0000),  
        .vram_data_o    (),
        .hsync_o        (Hsync),         
        .vsync_o        (Vsync),
        .vgaRed_o       (vgaRed), 
        .vgaGreen_o     (vgaGreen), 
        .vgaBlue_o      (vgaBlue)
    );



endmodule
