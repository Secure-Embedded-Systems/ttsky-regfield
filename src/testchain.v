module testchain #(parameter N = 2
		   ) (
		      input wire  clk,
		      input wire  rst_n,
		      input wire  din,
		      output wire dout
		      );
  
   reg [N-1:0] ff;

   always @(posedge clk or negedge rst_n) begin
      if (rst_n == 1'b0)
	ff[0] <= 1'b0;
      else
	ff[0] <= din;
   end
   
   genvar i;
   generate
      for (i = 1; i < N; i = i + 1) begin : inv_pair
	 always @(posedge clk or negedge rst_n) begin
	    if (rst_n == 1'b0)
	      ff[i] <= 1'b0;
	    else
	      ff[i] <= ff[i-1];
         end
      end
   endgenerate

   assign dout = ff[N-1];
   
endmodule
