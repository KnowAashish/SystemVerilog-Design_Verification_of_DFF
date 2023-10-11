class generator;
  
  transaction 				    xtn_gen;
  mailbox #(transaction) 	gen2sb;
  mailbox #(transaction) 	gen2drv;
  
  event sbdone;		// Next packet would be generated after SB is done comparing with golden ref
  event done;		// Signifies a simulation is completed after TB sends all of the packets
  
  int no_of_packets;// Total no of stimulus packets. Value is set in TB TOP module
  
  function new(mailbox #(transaction) GEN2SB, GEN2DRV);
    xtn_gen	     = new();
    this.gen2sb  = GEN2SB;
    this.gen2drv = GEN2DRV;
  endfunction
  
  task run();
    
    $display("at t=%0t, Inside GEN-Run Task", $time);
    repeat(no_of_packets) begin
      assert(xtn_gen.randomize)
        else $error("at time t=%0t, [GEN]: RANDOMIZATION FAILED", $time);
      //if (!xtn_gen.randomize()) $error("at time t=%0t, [GEN]: RANDOMIZATION FAILED", $time);
     // xtn_gen.din <= 1'bx;
      gen2drv.put(xtn_gen.copy);
      gen2sb.put(xtn_gen.copy);
      xtn_gen.display("GEN");		// Displays random generated data
      @(sbdone);			// Waits until SB compares it with gold (In-Order execution)
    end
    ->done;
    
  endtask
  
endclass
