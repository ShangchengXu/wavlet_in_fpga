class wavlet_driver extends uvm_driver#(wavlet_transaction);

   virtual wavlet_interface_port vif;
   virtual wavlet_interface_inner vif_i;

   `uvm_component_utils(wavlet_driver)
   function new(string name = "wavlet_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual wavlet_interface_port)::get(this, "", "vif", vif))
         `uvm_fatal("wavlet_driver", "virtual interface must be set for vif!!!")
      if(!uvm_config_db#(virtual wavlet_interface_inner)::get(this, "", "vif_i", vif_i))
         `uvm_fatal("wavlet_driver", "virtual interface must be set for vif_i!!!")

   endfunction

   extern task main_phase(uvm_phase phase);
   extern task drive_one_pkt(wavlet_transaction tr,integer fid);
endclass

task wavlet_driver::main_phase(uvm_phase phase);
   integer fid = $fopen("./sinx.txt","r");
   while(~vif.rst_n) begin
      @(posedge vif.clk);
   end
   while(1) begin
      seq_item_port.get_next_item(req);
      @(posedge vif.clk)
      drive_one_pkt(req,fid);
      seq_item_port.item_done();
   end
endtask

task wavlet_driver::drive_one_pkt(wavlet_transaction tr,integer fid);
   // `uvm_info("wavlet_driver", "begin to drive one pkt", UVM_LOW);
   logic [15:0] test_data;
   $fscanf(fid,"%h",test_data);
   vif.data_in <= test_data;

   // `uvm_info("wavlet_driver", "end drive one pkt", UVM_LOW);
endtask


