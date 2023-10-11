class driver;

  transaction		          xtn_drv;
  mailbox #(transaction) 	gen2drv;
  
  virtual intf vif_drv;
  
  function new(mailbox #(transaction) GEN2DRV);
    xtn_drv		 = new();
    this.gen2drv = GEN2DRV;
  endfunction
  
  task reset();
    
    // For Debug Purpose
    //$display("at t=%0t, Inside DRV-reset Task", $time);
    vif_drv.resetn <= 1'b0;
    //$display("at t=%0t, Reset is set to %0b", $time, vif_drv.resetn);
    repeat(2)
      @(posedge vif_drv.clk);
    //$display("at t=%0t, wait 2 clock cycles", $time);
    vif_drv.resetn <= 1'b1;
    @(posedge vif_drv.clk);
    $display("at time t=%0t, [DRV] : RESET DONE", $time);
  
  endtask
  
  task run();
    
    // For Debug Purpose
    //$display("at t=%0t, Inside DRV-Run Task", $time);
    
    forever begin
      gen2drv.get(xtn_drv);
      vif_drv.din <= xtn_drv.din;
      xtn_drv.display("DRV");		// value of din driven to DUT 
      @(posedge vif_drv.clk);
      vif_drv.din <= 1'b0;
      //vif_drv.din <= 1'bx;
      @(posedge vif_drv.clk);		// Total 2 clk cycles are utilized. Use 2 posedge clk in mon while getting data
    end
    
  endtask
  
endclass
