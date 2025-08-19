`include "uvm_macros.svh"
`include "apb_pkg.sv"
import uvm_pkg::*;
import apb_pkg::*;
class base_test extends uvm_test;

    `uvm_component_utils(base_test)

    /*
    *   Instantiate environment for specific protocol
    *   and interface for that protocol
    * */

   apb_env apb_environment;
   virtual apb_if apb_vif;

   apb_env_config   env_cfg;


    //// config

    function new(string name="base_test", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db #(virtual apb_if)::get(this, "", "apb_vif", apb_vif))
            `uvm_fatal(get_type_name(), "Cannot get interface at base_test")

        uvm_config_db #(virtual apb_if)::set(this, "apb_environment", "vif", apb_vif);

        env_cfg = apb_env_config::type_id::create("env_cfg");
        env_cfg.num_slaves = 1;
        uvm_config_db #(apb_env_config) :: set(this, "apb_environment", "env_cfg", env_cfg);
        apb_environment = apb_env::type_id::create("apb_environment", this);

    endfunction

    function void end_of_elaboration();
        print();
        env_cfg.print();
    endfunction

endclass
