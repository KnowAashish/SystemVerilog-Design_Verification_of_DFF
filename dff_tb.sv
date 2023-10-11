`include "dff_package.sv"
`include "dff_interface.sv"

//Import the package file inside or outside module doesnt matters

module dff_tb();
  
  import dff_pkg::*;
  
  // Define interface instance
  intf vif_tb();
  
  // Instantiate DUT with interface instance
  dff DUT (vif_tb.clk, vif_tb.resetn, vif_tb.din, vif_tb.dout);
  
  // Generate clock
  always
    #5 vif_tb.clk = !vif_tb.clk;
  
  environment env;
  
  initial begin
    env = new(vif_tb);
    env.gen.no_of_packets = 10;
    env.run();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
