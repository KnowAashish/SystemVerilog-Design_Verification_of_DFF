module dff (input clk,
            input resetn,
            input din,
            output logic dout);
  
  always @(posedge clk) begin
    if(!resetn)
      dout <= 1'b0;
    else
      if(din === 1'bx)
        dout <= 1'b0;
    else
      dout <= din;
  end
endmodule

/*
module dff (intf vif_dut);

	always @(posedge vif_dut.clk) begin
		if(!vif_dut.resetn)
			vif_dut.dout <= 1'b0;
		else
			vif_dut.dout <= vif_dut.din;
	end
endmodule
*/
