

#include <iostream>
#include <fstream>
#include<string>
#include <sstream>

using namespace std;

void split(int idx,int * inst_rom,const string& s,char flag) {
    istringstream iss(s);
    string temp;
	stringstream ss;
	int res;

	getline(iss, temp, flag);
	ss<<hex<<temp;
	ss>>res;
	inst_rom[idx] = res;
}

int read_inst_txt(int *inst_rom){
	ifstream f("../inst.txt");
	string s;
	if(!f.is_open()){
		printf( "Can not open this file!\n" );
		exit(1);
	}
	int idx = 0;
	while(!f.eof()){
		getline(f,s);
		split(idx,inst_rom,s,' ');
		idx++;
	}  
	return idx;
}

void read_inst_bin(int *inst_rom){
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