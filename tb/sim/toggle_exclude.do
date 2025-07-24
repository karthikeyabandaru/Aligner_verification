coverage exclude -src ../../rtl/cfs_rx_ctrl.v -scope merged:/testbench/dut/core/rx_ctrl -feccondrow 75 1
coverage exclude -src ../../rtl/cfs_rx_ctrl.v -scope merged:/testbench/dut/core/rx_ctrl -feccondrow 75 3
coverage exclude -src ../../rtl/cfs_synch_fifo.v -scope merged:/testbench/dut/core/rx_fifo -feccondrow 128 1
coverage exclude -src ../../rtl/cfs_synch_fifo.v -scope merged:/testbench/dut/core/tx_fifo -feccondrow 128 1
coverage exclude -src ../../rtl/cfs_synch_fifo.v -scope merged:/testbench/dut/core/tx_fifo -feccondrow 153 1
coverage exclude -src ../../rtl/cfs_ctrl.v -scope merged:/testbench/dut/core/ctrl -feccondrow 79 3
coverage exclude -src ../../rtl/cfs_ctrl.v -scope merged:/testbench/dut/core/ctrl -feccondrow 88 2 3 4
coverage exclude -src ../../rtl/cfs_ctrl.v -scope merged:/testbench/dut/core/ctrl -feccondrow 105 1 3
coverage exclude -src ../../rtl/cfs_ctrl.v -scope merged:/testbench/dut/core/ctrl -feccondrow 111 3
coverage exclude -src ../../rtl/cfs_ctrl.v -scope merged:/testbench/dut/core/ctrl -feccondrow 145 2 3 4
coverage exclude -src ../../rtl/cfs_ctrl.v -scope merged:/testbench/dut/core/ctrl -feccondrow 195 1
coverage exclude -src ../../rtl/cfs_ctrl.v -scope merged:/testbench/dut/core/ctrl -feccondrow 198 3
coverage exclude -src ../../rtl/cfs_ctrl.v -scope merged:/testbench/dut/core/ctrl -feccondrow 234 2 3 4
coverage exclude -src ../../rtl/cfs_ctrl.v -scope merged:/testbench/dut/core/ctrl -feccondrow 248 1 2
coverage exclude -src ../../rtl/cfs_ctrl.v -scope merged:/testbench/dut/core/ctrl -feccondrow 256 1 2
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 88 -code b
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 145 -code b
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 234 -code b
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 239 -code b
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 245 -code b
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 248 -code b
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 256 -code b
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 261 -code b
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 266 -code b
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 91 -code s
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 148 -code s
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 149 -code s
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 150 -code s
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 151 -code s
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 237 -code s
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 251 -code s
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 252 -code s
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 253 -code s
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 254 -code s
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 255 -code s
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 259 -code s
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 263 -code s
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 269 -code s
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 270 -code s
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 271 -code s
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 272 -code s
coverage exclude -src ../../rtl/cfs_ctrl.v -scope /testbench/dut/core/ctrl -line 274 -code s
coverage exclude -scope /testbench/dut/core/ctrl -togglenode {aligned_bytes_processed[2]}
coverage exclude -scope /testbench/dut -togglenode {prdata[20]} {prdata[21]} {prdata[22]} {prdata[23]} {prdata[24]} {prdata[25]} {prdata[26]} {prdata[27]} {prdata[28]} {prdata[29]}
coverage exclude -scope /testbench/dut -togglenode {prdata[30]} {prdata[31]}
coverage exclude -scope /testbench/dut -togglenode {prdata[12]} {prdata[13]} {prdata[14]} {prdata[15]}
coverage exclude -scope /testbench/dut/core -togglenode {prdata[20]} {prdata[21]} {prdata[22]} {prdata[23]} {prdata[24]} {prdata[25]} {prdata[26]} {prdata[27]} {prdata[28]} {prdata[29]}
coverage exclude -scope /testbench/dut/core -togglenode {prdata[30]} {prdata[31]}
coverage exclude -scope /testbench/dut/core -togglenode {prdata[12]} {prdata[13]} {prdata[14]} {prdata[15]}
coverage exclude -scope /testbench/dut/core/regs -togglenode {addr_aligned[0]} {addr_aligned[1]} {prdata[20]} {prdata[21]} {prdata[22]} {prdata[23]} {prdata[24]} {prdata[25]} {prdata[26]} {prdata[27]}
coverage exclude -scope /testbench/dut/core/regs -togglenode {prdata[28]} {prdata[29]} {prdata[30]} {prdata[31]}
coverage exclude -scope /testbench/dut/core/regs -togglenode {prdata[12]} {prdata[13]} {prdata[14]} {prdata[15]}
coverage exclude -scope /testbench/dut/core/regs -togglenode {status_rd_val[20]} {status_rd_val[21]} {status_rd_val[22]} {status_rd_val[23]} {status_rd_val[24]} {status_rd_val[25]} {status_rd_val[26]} {status_rd_val[27]} {status_rd_val[28]} {status_rd_val[29]} {status_rd_val[30]} {status_rd_val[31]}
coverage exclude -scope /testbench/dut/core/regs -togglenode {status_rd_val[12]} {status_rd_val[13]} {status_rd_val[14]} {status_rd_val[15]}
coverage exclude -scope /testbench/dut/core/regs -togglenode {ctrl_rd_val[20]} {ctrl_rd_val[21]} {ctrl_rd_val[22]} {ctrl_rd_val[23]} {ctrl_rd_val[24]} {ctrl_rd_val[25]} {ctrl_rd_val[26]} {ctrl_rd_val[27]} {ctrl_rd_val[28]} {ctrl_rd_val[29]} {ctrl_rd_val[30]} {ctrl_rd_val[31]}
coverage exclude -scope /testbench/dut/core/regs -togglenode {ctrl_rd_val[10]} {ctrl_rd_val[11]} {ctrl_rd_val[12]} {ctrl_rd_val[13]} {ctrl_rd_val[14]} {ctrl_rd_val[15]} {ctrl_rd_val[16]} {ctrl_rd_val[17]} {ctrl_rd_val[18]} {ctrl_rd_val[19]}
coverage exclude -scope /testbench/dut/core/regs -togglenode {ctrl_rd_val[3]} {ctrl_rd_val[4]} {ctrl_rd_val[5]} {ctrl_rd_val[6]} {ctrl_rd_val[7]}
coverage exclude -scope /testbench/dut/core/regs -togglenode {irq_rd_val[20]} {irq_rd_val[21]} {irq_rd_val[22]} {irq_rd_val[23]} {irq_rd_val[24]} {irq_rd_val[25]} {irq_rd_val[26]} {irq_rd_val[27]} {irq_rd_val[28]} {irq_rd_val[29]} {irq_rd_val[30]} {irq_rd_val[31]}
coverage exclude -scope /testbench/dut/core/regs -togglenode {irq_rd_val[10]} {irq_rd_val[11]} {irq_rd_val[12]} {irq_rd_val[13]} {irq_rd_val[14]} {irq_rd_val[15]} {irq_rd_val[16]} {irq_rd_val[17]} {irq_rd_val[18]} {irq_rd_val[19]}
coverage exclude -scope /testbench/dut/core/regs -togglenode {irq_rd_val[8]} {irq_rd_val[9]} {irq_rd_val[5]} {irq_rd_val[6]} {irq_rd_val[7]}
coverage exclude -scope /testbench/dut/core/regs -togglenode {irqen_rd_val[20]} {irqen_rd_val[21]} {irqen_rd_val[22]} {irqen_rd_val[23]} {irqen_rd_val[24]} {irqen_rd_val[25]} {irqen_rd_val[26]} {irqen_rd_val[27]} {irqen_rd_val[28]} {irqen_rd_val[29]} {irqen_rd_val[30]} {irqen_rd_val[31]}
coverage exclude -scope /testbench/dut/core/regs -togglenode {irqen_rd_val[10]} {irqen_rd_val[11]} {irqen_rd_val[12]} {irqen_rd_val[13]} {irqen_rd_val[14]} {irqen_rd_val[15]} {irqen_rd_val[16]} {irqen_rd_val[17]} {irqen_rd_val[18]} {irqen_rd_val[19]}
coverage exclude -scope /testbench/dut/core/regs -togglenode {irqen_rd_val[8]} {irqen_rd_val[9]} {irqen_rd_val[5]} {irqen_rd_val[6]} {irqen_rd_val[7]}
