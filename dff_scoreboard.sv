class scoreboard;
  
  transaction xtn_gen;
  transaction xtn_mon;
  
  mailbox #(transaction) sb2gen;
  mailbox #(transaction) sb2mon;
  
  event sbdone;
  
  function new(mailbox #(transaction) SB2GEN, SB2MON);
    //xtn_gen 	= new();
    //xtn_mon 	= new();
    this.sb2gen = SB2GEN;
    this.sb2mon = SB2MON;
  endfunction
  
  	task run();
      //For Debug Purpose
      //$display("at t=%0t, Inside SB-Run Task", $time);
      
      forever begin
        sb2gen.get(xtn_gen);
        sb2mon.get(xtn_mon);
        
        xtn_gen.display("REF");
        xtn_mon.display("SB");
        
        // if din is 0 or 1
        if(xtn_mon.dout == xtn_gen.din)
          $display("at time t=%0t, [SB]: DATA MATCHED", $time);
        
        // if din is 1'bX, design will give dout=0
        else if(xtn_gen.din === 1'bx && xtn_mon.dout == 1'b0)
          $display("at time t=%0t, [SB]: DATA MATCHED", $time);
        
        else
          $display("at time t=%0t, [SB]: DATA MISMATCHED", $time);
        
        $display("----------------------------------------");
        ->sbdone;
      end
      
    endtask

endclass
