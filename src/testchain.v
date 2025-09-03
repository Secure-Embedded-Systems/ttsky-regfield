module testchain #(parameter N = 2
		   ) (
		      input wire  clk,
		      input wire  rst_n,
		      input wire  din,
		      output wire dout
		      );
  
   reg [N-1:0] ff;
   (* keep = "true" *) wire [N-1:0] flip1;
   (* keep = "true" *) wire [N-1:0] flip2;
      
   always @(posedge clk or negedge rst_n) begin
      if (rst_n == 1'b0)
	ff[0] <= 1'b0;
      else
	ff[0] <= flip1[0];
   end
   (* keep = "true" *) cinv inv_gate_0 (.q(flip1[0]), .a(flip2[0]));
   (* keep = "true" *) cinv inv_gate_1 (.q(flip2[0]), .a(din));
   
   genvar i;
   generate
      for (i = 1; i < N; i = i + 1) begin : inv_pair
	 always @(posedge clk or negedge rst_n) begin
	    if (rst_n == 1'b0)
	      ff[i] <= 1'b0;
	    else
	      ff[i] <= flip1[i];
         end
         (* keep = "true" *) cinv inv_gate_2 (.q(flip1[i]), .a(flip2[i]));
         (* keep = "true" *) cinv inv_gate_3 (.q(flip2[i]), .a(ff[i-1]));
      end
   endgenerate

   assign dout = ff[N-1];
   
endmodule
