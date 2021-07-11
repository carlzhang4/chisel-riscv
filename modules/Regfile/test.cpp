
#include <verilated.h>          
#include <verilated_vcd_c.h>
#include <cstdio>
#include <iostream>
#include <fstream>
#include "VRegfile.h"


static VerilatedVcdC* tfp;

static VRegfile* dut;

int main(int argc, char **argv){
	Verilated::commandArgs(argc, argv);
  	Verilated::traceEverOn(true);

	dut = new VRegfile;
	tfp = new VerilatedVcdC;
	dut->trace(tfp, 99);
	tfp->open("vlt_dump.vcd");

	dut->reset = 0;
	dut->clock = 0;
	dut->io_w_addr = 0;
	dut->io_w_data = 0;
	dut->io_w_en = 0;
	dut->io_r1_addr = 0;
	dut->io_r1_en = 0;
	dut->io_r2_addr = 0;
	dut->io_r2_en = 0;

	for(int i=0;i<20;i++){
		dut->clock = !dut->clock;
		dut->eval();
		tfp->dump(i);
		dut->clock = !dut->clock;

		dut->io_w_addr+=1;
		dut->io_w_data+=2;
		dut->io_w_en=1;

		dut->eval();
		tfp->dump(i);

	}
	tfp->close();
	delete tfp;
	delete dut;
	return 0;
}