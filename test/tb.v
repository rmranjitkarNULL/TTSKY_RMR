`default_nettype none
`timescale 1ns / 1ps

/* This testbench instantiates the module and exposes convenient named wires
   that are driven / checked by the cocotb test.py.
*/
module tb ();

  // Dump the signals to a FST file. You can view it with gtkwave or surfer.
  initial begin
    $dumpfile("tb.fst");
    $dumpvars(0, tb);
    #1;
  end

  // Clock / reset / enable
  reg clk;
  reg rst_n;
  reg ena;

  // Named button inputs driven by the test
  reg p1_btn_left, p1_btn_right, p1_btn_select;
  reg p2_btn_left, p2_btn_right, p2_btn_select;

  // Assemble ui_in from the named buttons (see info.yaml pinout):
  //   ui[2]=P2_LEFT ui[3]=P2_RIGHT ui[4]=P2_SELECT
  //   ui[5]=P1_LEFT ui[6]=P1_RIGHT ui[7]=P1_SELECT
  wire [7:0] ui_in = {p1_btn_select, p1_btn_right, p1_btn_left,
                      p2_btn_select, p2_btn_right, p2_btn_left,
                      2'b00};

  reg  [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

  // Named outputs used by the test (see info.yaml pinout):
  //   uo[0]=HSYNC uo[1]=VSYNC uo[2]=R0 uo[3]=R1 uo[4]=G0 uo[5]=G1 uo[6]=B0 uo[7]=B1
  wire hsync  = uo_out[0];
  wire vsync  = uo_out[1];
  wire vga_r0 = uo_out[2];
  wire vga_r1 = uo_out[3];
  wire vga_g0 = uo_out[4];
  wire vga_g1 = uo_out[5];
  wire vga_b0 = uo_out[6];
  wire vga_b1 = uo_out[7];

  //   uio[1]=HBLANK uio[2]=VBLANK uio[3]=SOUND
  wire hblank = uio_out[1];
  wire vblank = uio_out[2];
  wire sound  = uio_out[3];

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  tt_um_rmranjitkarNULL_pong_top user_project (

      // Include power ports for the Gate Level test:
`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (uo_out),   // Dedicated outputs
      .uio_in (uio_in),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena    (ena),      // enable - goes high when design is selected
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );

endmodule
