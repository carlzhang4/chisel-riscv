

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