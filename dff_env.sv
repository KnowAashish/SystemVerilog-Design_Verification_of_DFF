class environment;
  
  generator		gen;
  driver		drv;
  monitor		mon;
  scoreboard	sb;
  
  mailbox #(transaction) gen2drv;
  mailbox #(transaction) gen2sb;
  mailbox #(transaction) mon2sb;
  
  event env_done;
  
  virtual intf vif_env;
  
  function new(virtual intf VIF_ENV);
    gen2drv = new();
    gen2sb 	= new();
    gen 	= new(gen2sb, gen2drv);
    drv 	= new(gen2drv);
    
    mon2sb	= new();
    mon 	= new(mon2sb);
    sb		= new(gen2sb, mon2sb);
    
    // Connect virtual interface
    this.vif_env = VIF_ENV;
    drv.vif_drv  = this.vif_env;
    mon.vif_mon  = this.vif_env;
    
    
    // Connect events
    sb.sbdone  = env_done;
    gen.sbdone = env_done;
    
  endfunction
  
  task pre_test();
    drv.reset();
  endtask
  
  task test();
    
    fork
      gen.run();
      drv.run();
      mon.run();
      sb.run();
    join_any
    
  endtask
  
  task post_test();
    wait(gen.done.triggered);
    $finish;
  endtask
  
  task run();
    //For Debug Purpose
    //$display("at t=%0t, Inside Env-Run Task", $time);
    
    pre_test();
    test();
    post_test();
    
  endtask
  
endclass