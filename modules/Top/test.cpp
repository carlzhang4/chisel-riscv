
#include <verilated.h>          
#include <verilated_vcd_c.h>
#include <cstdio>
#include <iostream>
#include <fstream>
#include<string>
#include <sstream>

#include "util.h"
#include "VTop.h"

using namespace std;

static VerilatedVcdC* tfp;

static VTop* dut;

int inst_rom[65536];

void write_inst(int num){
	for(int i=0;i<num;i++){
		dut->clock = !dut->clock;
		dut->eval();
	  	tfp->dump(i*2);	
		dut->clock = !dut->clock;
		dut->io_wr_en = 1;
		dut->io_wr_addr++;
		dut->io_wr_data = inst_rom[i];		
	  	dut->eval();
	  	tfp->dump(i*2+1);		  		
	}
	dut->io_wr_en = 0;
}

int main(int argc, char **argv){

	int inst_num = read_inst_txt(inst_rom);
	cout<<inst_num<<" instructions read into rom\n";
	inst_num+=1;
	return 0;

	Verilated::commandArgs(argc, argv);
  	Verilated::traceEverOn(true);

	dut = new VTop;
	tfp = new VerilatedVcdC;
	dut->trace(tfp, 99);
	tfp->open("vlt_dump.vcd");

	dut->reset = 0;
	dut->clock = 0;
	dut->io_start = 0;
	dut->io_wr_en = 0;
	dut->io_wr_addr = -1;
	dut->io_wr_data = 0;
	write_inst(inst_num);
	dut->io_start = 1;
	for(int i=inst_num;i<20;i++){
		dut->clock = !dut->clock;
		dut->eval();
		tfp->dump(i*2);

		dut->clock = !dut->clock;
		dut->eval();
		tfp->dump(i*2+1);
	}
	tfp->close();
	delete tfp;
	delete dut; 
	exit(0);
	return 0;
}