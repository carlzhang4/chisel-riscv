
#include <verilated.h>          
#include <verilated_vcd_c.h>
#include <cstdio>
#include <iostream>
#include <fstream>
#include "VTop.h"


static VerilatedVcdC* tfp;

static VTop* dut_ptr;

int main(int argc, char **argv){
	Verilated::commandArgs(argc, argv);
  	Verilated::traceEverOn(true);

	dut_ptr = new VTop;
	tfp = new VerilatedVcdC;
	dut_ptr->trace(tfp, 99);
	tfp->open("vlt_dump.vcd");


	dut_ptr->reset = 0;
	dut_ptr->clock = 0;
	dut_ptr->io_test_in = 0;
	for(int i=0;i<10;i++){
		dut_ptr->clock = !dut_ptr->clock;
		dut_ptr->io_test_in++;
		dut_ptr->eval();
		tfp->dump(i);
	}
	tfp->close();
	delete tfp;
	delete dut_ptr;
	return 0;
}