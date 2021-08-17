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

files=(
add-longlong-riscv64-mycpu.bin
add-riscv64-mycpu.bin
bit-riscv64-mycpu.bin
bubble-sort-riscv64-mycpu.bin
div-riscv64-mycpu.bin
dummy-riscv64-mycpu.bin
fact-riscv64-mycpu.bin
fib-riscv64-mycpu.bin
goldbach-riscv64-mycpu.bin
hello-str-riscv64-mycpu.bin
if-else-riscv64-mycpu.bin
leap-year-riscv64-mycpu.bin
load-store-riscv64-mycpu.bin
matrix-mul-riscv64-mycpu.bin
max-riscv64-mycpu.bin
min3-riscv64-mycpu.bin
mov-c-riscv64-mycpu.bin
movsx-riscv64-mycpu.bin
mul-longlong-riscv64-mycpu.bin
pascal-riscv64-mycpu.bin
prime-riscv64-mycpu.bin
quick-sort-riscv64-mycpu.bin
recursion-riscv64-mycpu.bin
select-sort-riscv64-mycpu.bin
shift-riscv64-mycpu.bin
shuixianhua-riscv64-mycpu.bin
string-riscv64-mycpu.bin
sub-longlong-riscv64-mycpu.bin
sum-riscv64-mycpu.bin
switch-riscv64-mycpu.bin
to-lower-case-riscv64-mycpu.bin
unalign-riscv64-mycpu.bin
wanshu-riscv64-mycpu.bin
)

num_success=0
num_fail=0
# simulate
if [[ "$SIMULATE" == "true" ]]; then
	cd $CHISEL_HOME	
	cd build
	cp /home/amax/share/riscv/am/am-kernels/tests/cpu-tests/build/*.bin ../difftest/instructions/

	if [[ "$IMG_FILE" == "all" ]];then
		for file in ${files[*]};do
			printf "[%30s] " $file
			LOG_FILE=../log/$file-log.txt
			./emu -b 0 -e 1100 --dump-wave -i ../difftest/instructions/$file &> $LOG_FILE
			if (grep 'HIT GOOD TRAP' $LOG_FILE > /dev/null) then
				echo -e "\033[1;32mPASS!\033[0m"
				((num_success++))
				# rm $LOG_FILE
			else
				((num_fail++))
				echo -e "\033[1;31mFAIL!\033[0m see $LOG_FILE"
			fi
		done
		echo -e "\033[1;32m$num_success successed\033[0m"
		echo -e "\033[1;31m$num_fail failed\033[0m"
	else
		if [[ "$GBD" == "true" ]]; then
			gdb -s $EMU_FILE --args ./$EMU_FILE $PARAMETERS
		else
			./emu -b 0 -e 1100 --dump-wave -i ../difftest/instructions/$IMG_FILE
		fi

		if [ $? -ne 0 ]; then
			echo "Failed to simulate!!!"
			exit 1
		fi
	fi
fi

if [[ "$CHECK_WAVE" == "true" ]]; then
	cd $CHISEL_HOME/build
	gtkwave ../$WAVE_FILE
fi

# filelist=`ls /home/amax/share/riscv/oscpu-framework/chisel/difftest/instructions/`
# for file in $filelist
# do 
#  echo $file
# done
#chisel/difftest 下 make DESIGN_DIR=./ -m "EMU_TRACE=1"
#chisel/difftest/build  ./emu -i inst.bin --dump-wave -b 0


#NEMU
# make clean && make ISA=riscv64

#s -v -b -s add-riscv64-mycpu.bin

# riscv64-linux-gnu-as beq.S  && riscv64-linux-gnu-objdump -S a.out > beq.txt
