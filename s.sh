#!/bin/bash

GEN_VERILOG="false"
BUILD="false"
SIMULATE="false"
CHECK_WAVE="false"
WAVE_FILE="hhj_666.vcd"

while getopts 'vbswf:' OPT; do
    case $OPT in
		v) GEN_VERILOG="true";;
        b) BUILD="true";;
		s) SIMULATE="true";;
		a) PARAMETERS="$OPTARG";;
		w) CHECK_WAVE="true";;
		f) WAVE_FILE="$OPTARG";;
    esac
done

# gen verilog
if [[ "$GEN_VERILOG" == "true" ]]; then
	cd "chisel"
	mill -i __.test.runMain top.topMain -td ./build
	cp Verilog/SimTop.v ./difftest/build
fi

# build emu
if [[ "$BUILD" == "true" ]]; then
	cd /home/amax/share/riscv/oscpu-framework/chisel
	make -C difftest clean emu

	cd /home/amax/share/riscv/oscpu-framework
	git add . -A --ignore-errors
	(echo $NAME && echo $ID && hostnamectl && uptime) | git commit -F - -q --author='tracer-oscpu2021 <tracer@oscpu.org>' --no-verify --allow-empty 1>/dev/null 2>&1
    sync
fi

# simulate
if [[ "$SIMULATE" == "true" ]]; then
    cd /home/amax/share/riscv/oscpu-framework/chisel
    if [[ "$GBD" == "true" ]]; then
        gdb -s $EMU_FILE --args ./$EMU_FILE $PARAMETERS
    else
        ./build/emu -b 0 -e 30 --dump-wave -i ./difftest/build/inst.txt
    fi

    if [ $? -ne 0 ]; then
        echo "Failed to simulate!!!"
        exit 1
    fi
    cd $SHELL_PATH
fi

if [[ "$CHECK_WARE" == "true" ]]; then
	gtkwave $WAVE_FILE
fi