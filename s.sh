#!/bin/bash

PROJECT_HOME="/home/amax/share/riscv/oscpu-framework"
CHISEL_HOME=$PROJECT_HOME/chisel

# ID=`sed '/^ID=/!d;s/.*=//' $MYINFO_FILE`
# NAME=`sed '/^Name=/!d;s/.*=//' $MYINFO_FILE`
# ID="${ID##*\r}"
# NAME="${NAME##*\r}"

GEN_VERILOG="false"
BUILD="false"
SIMULATE="false"
CHECK_WAVE="false"
WAVE_FILE="hhj.vcd"
IMG_FILE="inst.txt"

while getopts 'vbs:wf:' OPT; do
    case $OPT in
		v) GEN_VERILOG="true";;
        b) BUILD="true";;
		s) SIMULATE="true";IMG_FILE="$OPTARG";;
		a) PARAMETERS="$OPTARG";;
		w) CHECK_WAVE="true";;
		f) WAVE_FILE="$OPTARG";;
    esac
done

# gen verilog
if [[ "$GEN_VERILOG" == "true" ]]; then
	cd $CHISEL_HOME
	mill -i __.test.runMain top.topMain -td ./build
	if [ $? -ne 0 ]; then
        echo "Failed to gen verilog!!!"
        exit 1
    fi
	cp Verilog/SimTop.v ./difftest/build
fi

# build emu
if [[ "$BUILD" == "true" ]]; then
	cd $CHISEL_HOME
	make -s -C difftest clean emu
	if [ $? -ne 0 ]; then
        echo "Failed to build emu!!!"
        exit 1
    fi

	# cd $PROJECT_HOME
	# git add . -A --ignore-errors
	# (echo "ZhangJie HuangHongjing" && echo "20210230 20210300" && hostnamectl && uptime) | git commit -F - -q --author='tracer-oscpu2021 <tracer@oscpu.org>' --no-verify --allow-empty 1>/dev/null 2>&1
    sync
fi

# simulate
if [[ "$SIMULATE" == "true" ]]; then
    cd $CHISEL_HOME
	cd build
	cp /home/amax/share/riscv/am/am-kernels/tests/cpu-tests/build/*.bin ../difftest/build/
    if [[ "$GBD" == "true" ]]; then
        gdb -s $EMU_FILE --args ./$EMU_FILE $PARAMETERS
    else
        ./emu -b 0 -e 200 --dump-wave -i ../difftest/build/$IMG_FILE
    fi

    if [ $? -ne 0 ]; then
        echo "Failed to simulate!!!"
        exit 1
    fi
fi

if [[ "$CHECK_WAVE" == "true" ]]; then
	cd $CHISEL_HOME/build
	gtkwave ../$WAVE_FILE
fi

#chisel/difftest 下 make DESIGN_DIR=./ -m "EMU_TRACE=1"
#chisel/difftest/build  ./emu -i inst.bin --dump-wave -b 0


#NEMU
# make clean && make ISA=riscv64

#s -v -b -s add-riscv64-mycpu.bin