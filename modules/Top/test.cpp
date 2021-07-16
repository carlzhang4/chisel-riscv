
#include <verilated.h>          
#include <verilated_vcd_c.h>
#include <cstdio>
#include <iostream>
#include <fstream>
#include<string>
#include <sstream>

#include "VTop.h"

using namespace std;

static VerilatedVcdC* tfp;

static VTop* dut;



int inst_rom[65536];

void split(int idx,const string& s,char flag) {
    istringstream iss(s);
    string temp;
    float label;

	getline(iss, temp, flag);
	cout<<temp;
	int res = stoi(temp);
	cout<<res<<endl;
}

void read_inst_txt(){
	ifstream f("../inst.txt");
	string s;
	if(!f.is_open()){
		printf( "Can not open this file!\n" );
		exit(1);
	}
	int idx = 0;
	while(!f.eof()){
		getline(f,s);
		split(idx,s,' ');
	}
	 
        
}
void read_inst_bin(){
  FILE *fp = fopen("../inst.bin", "rb");
  if( fp == NULL ) {
		printf( "Can not open this file!\n" );
		exit(1);
  }
  
  fseek(fp, 0, SEEK_END);
  size_t size = ftell(fp);
  fseek(fp, 0, SEEK_SET);
  size = fread(inst_rom, size, 1, fp);
  fclose(fp);
}

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

	read_inst_txt();
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
	int inst_num = 4;
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