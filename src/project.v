/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_delaychain (
			 input wire [7:0]  ui_in,   // Dedicated inputs
			 output wire [7:0] uo_out,  // Dedicated outputs
			 input wire [7:0]  uio_in,  // IOs: Input path
			 output wire [7:0] uio_out, // IOs: Output path
			 output wire [7:0] uio_oe,  // IOs: Enable path (active high: 0=input, 1=output)
			 input wire	   ena,	    // always 1 when the design is powered, so you can ignore it
			 input wire	   clk,	    // clock
			 input wire	   rst_n    // reset_n - low to reset
			 );
   
   wire _unused = &{ena, uio+in, 1'b0};

   assign uio_out = 0;
   assign uio_oe  = 0;
   
   genvar i;
   generate
      for (i = 0; i < 8; i = i + 1) begin : thechain
	 testchain #(.N(128)) chain1 (.clk(clk), .rst_n(rst_n), .din(ui_in[i]), .dout(uo_out[i]));
      end
   endgenerate

endmodule
