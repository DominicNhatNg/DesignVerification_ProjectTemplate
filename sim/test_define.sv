
module test_define;
    initial begin
        `ifndef TEST
            $error("not define");
        `else
            $info("Tested");
        `endif
    end

endmodule
