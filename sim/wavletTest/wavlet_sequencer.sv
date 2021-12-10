class wavlet_sequencer extends uvm_sequencer #(wavlet_transaction);
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction 
    `uvm_component_utils(wavlet_sequencer)
endclass
