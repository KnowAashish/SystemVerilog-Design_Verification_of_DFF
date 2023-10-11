class transaction;
  
  // Only Control or Data Signals. Global Signal Stimulus Generation will be in TOP module
  //rand bit din;
  //bit dout;
  randc logic din;	// To send X as a valid input
  logic       dout;
  
  // Deep Copy, so that Env can work with Out-of-Order execution
  function transaction copy();
    copy 	    = new();
    copy.din  = this.din;
    copy.dout = this.dout;
  endfunction
  
  // tag = component's name. eg. GEN, TXN, DRV etc.
  function void display(input string tag);
    $display("at time t=%0t, [%0s]: din=%0b dout=%0b", $time, tag, din, dout);
  endfunction
  
endclass
