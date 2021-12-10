class wavlet_transaction extends uvm_sequence_item;
rand bit variable_for_test;
rand bit [15:0] data_in;



constraint con{
variable_for_test == 0;

}
`uvm_object_utils_begin(wavlet_transaction)


`uvm_object_utils_end
function new(string name = "wavlet_transaction");
super.new();
endfunction

endclass
