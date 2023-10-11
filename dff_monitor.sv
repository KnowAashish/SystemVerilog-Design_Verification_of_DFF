class monitor;
  
  transaction				xtn_mon;
  mailbox #(transaction)	mon2sb;
  
  virtual intf vif_mon;
  
  function new(mailbox #(transaction) MON2SB);
    this.mon2sb = MON2SB;
  endfunction
  
  task run();
    
    //For Debug Purpose
    //$display("at t=%0t, Inside MON-Run Task", $time);
    xtn_mon = new();
    forever begin
      repeat(2)
        @(posedge vif_mon.clk);		// DRV took 2 clk to send data
      xtn_mon.dout = vif_mon.dout;	// There is no NB or B operator in OOP. Thus normal equal operator
      mon2sb.put(xtn_mon);
      xtn_mon.display("MON");
    end
    
  endtask
  
endclass