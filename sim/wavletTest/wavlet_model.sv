class wavlet_model extends uvm_component;
   
   uvm_blocking_get_port #(wavlet_transaction)  port;
   uvm_analysis_port #(wavlet_transaction)  ap;

   extern function new(string name, uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern virtual  task main_phase(uvm_phase phase);

   `uvm_component_utils(wavlet_model)
endclass 

function wavlet_model::new(string name, uvm_component parent);
   super.new(name, parent);
endfunction 

function void wavlet_model::build_phase(uvm_phase phase);
   super.build_phase(phase);
   port = new("port", this);
   ap = new("ap", this);
endfunction

task wavlet_model::main_phase(uvm_phase phase);
   wavlet_transaction tr;
   wavlet_transaction old_tr;
   super.main_phase(phase);
   while(1) begin
      port.get(old_tr);
      tr = new("tr");
      ap.write(tr);
   end
endtask