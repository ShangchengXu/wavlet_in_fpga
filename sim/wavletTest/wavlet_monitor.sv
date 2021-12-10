class wavlet_monitor extends uvm_monitor;

   virtual wavlet_interface_port vif;
   virtual wavlet_interface_inner vif_i;
   uvm_active_passive_enum is_active = UVM_ACTIVE;
   uvm_analysis_port #(wavlet_transaction)  ap;
   
   `uvm_component_utils(wavlet_monitor)
   function new(string name = "wavlet_monitor", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      int active;
      super.build_phase(phase);
      if(!uvm_config_db#(virtual wavlet_interface_port)::get(this, "", "vif", vif))
         `uvm_fatal("wavlet_monitor", "virtual interface must be set for vif!!!")
      if(!uvm_config_db#(virtual wavlet_interface_inner)::get(this, "", "vif_i", vif_i))
         `uvm_fatal("wavlet_monitor", "virtual interface must be set for vif_i!!!")
      ap = new("ap", this);      
      if(get_config_int("is_active", active)) is_active = uvm_active_passive_enum'(active);
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task collect_one_pkt(wavlet_transaction tr);
endclass

task wavlet_monitor::main_phase(uvm_phase phase);
   wavlet_transaction tr;
   //------------forever------//
   // while(1) begin
   //    tr = new("tr");
   //    collect_one_pkt(tr);
   //    ap.write(tr);
   // end

   //------------repeat-------//
   repeat(1) begin
      tr = new("tr");
      collect_one_pkt(tr);
      ap.write(tr);
   end


endtask

task wavlet_monitor::collect_one_pkt(wavlet_transaction tr);
      if(is_active == UVM_ACTIVE) begin

      end
      else begin

      end

endtask


