# SystemVerilog-Verification_of_DFF
This repository contains detailed RTL design and TB verification of a D Flip-Flop.

RTL Design:
Resetn  {0  1  1  1}
Din     {X  X  1  0}
Dout    {0  0  1  0}

TB Design:
Package files are created to import in the tb top module.
Interface is created as per the DFF RTL Design.
randc DataIn is used in the transaction to deliver different input on every randomize in generator class.
Driver uses 2 clk cycles to drive a DataIn to the DUT.
Monitor waits for 2 clk cycles before fetching the next DataOut.
Scoreboard checks for all possible input signals combination i.e., Resetn DataIn.
