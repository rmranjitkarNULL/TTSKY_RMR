`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Ryan Ranjitkar
//
// Create Date: 09/06/2026 09:30:44 AM
// Design Name:
// Module Name: synchronizer
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


module synchronizer
#(
    parameter WIDTH = 1,
    parameter DEFAULT_VALUE = 1'b0
) (
    input clk,
    input nRst,
    input [WIDTH-1:0] in,
    output [WIDTH-1:0] out
);
    
    reg [WIDTH-1:0] reg1;
    reg [WIDTH-1:0] reg2;
    always @(posedge clk or negedge nRst)
    begin
        if(!nRst) begin
            reg1 <= DEFAULT_VALUE;
            reg2 <= DEFAULT_VALUE;
        end else begin
            reg1 <= in;
            reg2 <= reg1;
        end
    end

    assign out = reg2;
endmodule