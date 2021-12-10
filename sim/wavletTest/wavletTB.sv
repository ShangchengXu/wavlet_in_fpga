`include "uvm_macros.svh"
module wavletTB;
wavlet_interface_port ifo ();
wavlet_interface_inner ifi ();
logic clk;
logic rst_n;
logic rst_p;
wavlet wavlet_inst (
        .clk          (ifo.clk        ) ,//input   
        .rst_n        (ifo.rst_n      ) ,//input   
        .data_in      (ifo.data_in    ) ,//input   [15:0]
        .data_out_hd  (ifo.data_out_hd) ,//output  [20:0]
        .data_out_ld  (ifo.data_out_ld));//output  [20:0]
always #5 clk = ~clk;

initial begin
clk = 0;
rst_n = 0;
rst_p = 1;
#8 rst_n = 1;
#6 rst_p = 0;

end

always@ * begin
ifo.clk <= clk;
ifo.rst_n <= rst_n;

end

initial begin
   run_test();
end

initial begin
   uvm_config_db#(virtual wavlet_interface_port)::set(null, "uvm_test_top.env.i_agt.drv", "vif", ifo);
   uvm_config_db#(virtual wavlet_interface_port)::set(null, "uvm_test_top.env.i_agt.mon", "vif", ifo);
   uvm_config_db#(virtual wavlet_interface_port)::set(null, "uvm_test_top.env.o_agt.mon", "vif", ifo);
   uvm_config_db#(virtual wavlet_interface_inner)::set(null, "uvm_test_top.env.i_agt.drv", "vif_i", ifi);
   uvm_config_db#(virtual wavlet_interface_inner)::set(null, "uvm_test_top.env.i_agt.mon", "vif_i", ifi);
   uvm_config_db#(virtual wavlet_interface_inner)::set(null, "uvm_test_top.env.o_agt.mon", "vif_i", ifi);
end





endmodule
