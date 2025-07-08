
#include <svdpi.h>
#include <vpi_user.h>

void force_clk_zero() {
    vpiHandle clk_h = vpi_handle_by_name("testbench.dut.clk", NULL);
    if (!clk_h) {
        vpi_printf("ERROR: Unable to find clk signal\n");
        return;
    }

    s_vpi_value val;
    val.format = vpiIntVal;
    val.value.integer = 0;

    s_vpi_time t;
    t.type = vpiSimTime;
    t.high = 0;
    t.low = 0;

    vpi_put_value(clk_h, &val, &t, vpiForce);
    vpi_printf("FORCED clk = 0\n");
}

void release_clk() {
    vpiHandle clk_h = vpi_handle_by_name("testbench.dut.clk", NULL);
    if (!clk_h) {
        vpi_printf("ERROR: Unable to find clk signal\n");
        return;
    }

    s_vpi_value val;
    val.format = vpiIntVal;
    val.value.integer = 1;

    s_vpi_time t;
    t.type = vpiSimTime;
    t.high = 0;
    t.low = 0;

    vpi_put_value(clk_h, &val, &t, vpiRelease);
    vpi_printf("RELEASED clk control\n");
}
