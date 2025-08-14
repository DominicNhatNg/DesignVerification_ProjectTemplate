`include "uvm_macros.svh"

import uvm_pkg::*;
class base_test extends uvm_test;

    `uvm_component_utils(base_test)

    /*
    *   Instantiate environment for specific protocol
    *   and interface for that protocol
    * */

 //  apb_env apb_environment;
   virtual apb_if apb_vif;


    //// config

    function new(string name="base_test", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        apb_environment = apb_env::type_id::create("apb_environment", this);

        if(!uvm_config_db #(virtual apb_if)::get(this, "", "apb_vif", apb_vif))
            `uvm_fatal(get_type_name(), "Cannot get interface at base_test")

        ///// config
    endfunction

    function void end_of_elaboration();
        print();
    endfunction

endclass
