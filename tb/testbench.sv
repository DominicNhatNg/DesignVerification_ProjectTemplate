`timescale 1ns/1ps
`include "uvm_macros.svh"
`include "apb_if.sv"

module testbench;

  import uvm_pkg::*;

  logic PCLK;

  // Clock generation
  initial begin
    PCLK = 1'b0;
    forever begin
      #5;
      PCLK = ~PCLK;
    end
  end


  // Instantiate APB interface
  apb_if #(
    .ADDR_WIDTH(32),
    .DATA_WIDTH(8)
  ) apb_if_inst (
  );

  // Instantiate DUT
 // apb_slave_timer #(
 //   .ADDR_WIDTH(32),
 //   .DATA_WIDTH(32),
 //   .DEPTH(16),
 //   .WAIT_CYCLE(1)
 // ) dut (
 //   .PCLK       (apb_if_inst.pclk),
 //   .PRESETn    (apb_if_inst.presetn),
 //   .PSEL       (apb_if_inst.psel),
 //   .PENABLE    (apb_if_inst.penable),
 //   .PWRITE     (apb_if_inst.pwrite),
 //   .PADDR      (apb_if_inst.paddr),
 //   .PWDATA     (apb_if_inst.pwdata),
 //  // .PADDRCHK   (apb_if_inst.),
 //  // .PWDATACHK  (apb_if_inst.PWDATACHK),
 //   .PREADY     (apb_if_inst.pready),
 //   .PSLVERR    (apb_if_inst.pslverr),
 //   .PRDATA     (apb_if_inst.prdata),
 //  // .PRDATACHK  (apb_if_inst.PRDATACHK),
 //   .PSTRB      (apb_if_inst.pstrb)
 // //  .PSTRBCHK   (apb_if_inst.PSTRBCHK),

 //   // Clock connections
 //   .i_clk_phi_2    (1'b0),
 //   .i_clk_phi_8    (),
 //   .i_clk_phi_32   (),
 //   .i_clk_phi_64   (),
 //   .i_clk_phi_1024 (),
 //   .i_clk_phi_8192 (),

 //   // Timer inputs
 //   .i_TMCI0    (),
 //   .i_TMCI1    (),
 //   .i_TMRI_0   (),
 //   .i_TMRI_1   (),

 //   // Timer outputs
 //   .o_TMO_0        (),
 //   .o_TMO_1        (),
 //   .o_CMIA0        (),
 //   .o_CMIB0        (),
 //   .o_OVI0         (),
 //   .o_CMIA1        (),
 //   .o_CMIB1        (),
 //   .o_OVI1         (),
 //   .o_adc_request  ()
 // );

  // UVM test start
  initial begin
    uvm_config_db#(virtual apb_if)::set(null, "uvm_test_top", "apb_vif", apb_if_inst);
    $display("Testbench: Starting UVM test at time %0t", $time);
    run_test();
  end

endmodule

