
#include <verilated.h>          
#include <verilated_vcd_c.h>
#include <cstdio>
#include <iostream>
#include <fstream>
#include "VTop.h"


static VerilatedVcdC* tfp;

static VTop* dut;

int main(int argc, char **argv){
	Verilated::commandArgs(argc, argv);
  	Verilated::traceEverOn(true);

	dut = new VTop;
	tfp = new VerilatedVcdC;
	dut->trace(tfp, 99);
	tfp->open("vlt_dump.vcd");

	dut->reset = 0;
	dut->clock = 0;
	dut->io_test_in = 0;
	for(int i=0;i<500;i++){
		dut->clock = !dut->clock;
		dut->io_test_in++;
		dut->eval();
		tfp->dump(i);
	}
	tfp->close();
	delete tfp;
	delete dut;
	return 0;
}