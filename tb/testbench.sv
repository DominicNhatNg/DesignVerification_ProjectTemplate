`timescale 1ns/1ps
`include "common.svh"
`include "uvm_macros.svh"
`include "apb_pkg.sv"
`include "apb_if.sv"

module testbench;

    import uvm_pkg::*;
    import apb_pkg::*;

    logic  PCLK;

    initial begin
        PCLK = 1'b0;
        forever begin
            #5;
            PCLK = ~PCLK;
        end
    end

    apb_if #(.ADDR_WIDTH(32), .DATA_WIDTH(32)) apb_if_inst(.PCLK(PCLK));


    apb_slave_timer #(
        .ADDR_WIDTH(32),
        .DATA_WIDTH(32),
        .DEPTH(16),
        .WAIT_CYCLE(1)
    ) dut (
        .PCLK(PCLK),
        .PRESETn(apb_if_inst.PRESETn),
        .PSEL(apb_if_inst.PSEL),
        .PENABLE(apb_if_inst.PENABLE),
        .PWRITE(apb_if_inst.PWRITE),
        .PADDR(apb_if_inst.PADDR),
        .PWDATA(apb_if_inst.PWDATA),
        .PADDRCHK(apb_if_inst.PADDRCHK),
        .PWDATACHK(apb_if_inst.PWDATACHK),
        .PREADY(apb_if_inst.PREADY),
        .PSLVERR(apb_if_inst.PSLVERR),
        .PRDATA(apb_if_inst.PRDATA),
        .PRDATACHK(apb_if_inst.PRDATACHK),
        .PSTRB(apb_if_inst.PSTRB),
        .PSTRBCHK(apb_if_inst.PSTRBCHK),
        .i_clk_phi_2(PCLK),
        .i_clk_phi_8(),
        .i_clk_phi_32(),
        .i_clk_phi_64(),
        .i_clk_phi_1024(),
        .i_clk_phi_8192(),
        .i_TMCI0(),
        .i_TMCI1(),
        .i_TMRI_0(),
        .i_TMRI_1(),
        .o_TMO_0(),
        .o_TMO_1(),
        .o_CMIA0(),
        .o_CMIB0(),
        .o_OVI0(),
        .o_CMIA1(),
        .o_CMIB1(),
        .o_OVI1(),
        .o_adc_request()
    );

    initial begin
        uvm_config_db #(virtual apb_if)::set(null, "uvm_test_top", "apb_vif", apb_if_inst);
        $display("Testbench: Starting UVM test at time %0t", $time);
        run_test();
    end

endmodule
