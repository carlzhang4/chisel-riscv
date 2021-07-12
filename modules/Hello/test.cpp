
#include <verilated.h>          
#include <verilated_vcd_c.h>
#include <cstdio>
#include <iostream>
#include <fstream>
#include "VHello.h"


static VerilatedVcdC* tfp;

static VHello* dut;

int main(int argc, char **argv){
	Verilated::commandArgs(argc, argv);
  	Verilated::traceEverOn(true);

	dut = new VHello;
	tfp = new VerilatedVcdC;
	dut->trace(tfp, 99);
	tfp->open("vlt_dump.vcd");

	dut->reset = 0;
	dut->clock = 0;
	dut->io_in = 0;

	for(int i=0;i<20;i++){
		dut->clock = !dut->clock;
		dut->eval();
		tfp->dump(i*2);
		dut->clock = !dut->clock;

		dut->io_in+=1;

		dut->eval();
		tfp->dump(i*2+1);

	}
	tfp->close();
	delete tfp;
	delete dut;
	return 0;
}