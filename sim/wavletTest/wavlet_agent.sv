class wavlet_agent extends uvm_agent ;
   wavlet_sequencer  sqr;
   wavlet_driver     drv;
   wavlet_monitor    mon;
   
   uvm_analysis_port #(wavlet_transaction)  ap;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);

   `uvm_component_utils(wavlet_agent)
endclass 


function void wavlet_agent::build_phase(uvm_phase phase);
   super.build_phase(phase);
   if (is_active == UVM_ACTIVE) begin
      sqr = wavlet_sequencer::type_id::create("sqr", this);
      drv = wavlet_driver::type_id::create("drv", this);
   end
   mon = wavlet_monitor::type_id::create("mon", this);
   mon.is_active = is_active;
endfunction 

function void wavlet_agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   if (is_active == UVM_ACTIVE) begin
      drv.seq_item_port.connect(sqr.seq_item_export);
   end
   ap = mon.ap;
endfunction

