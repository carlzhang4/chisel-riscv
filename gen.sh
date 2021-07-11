#!/bin/bash

#./gen.sh -v -b -m Top -f test.gtkw

SHELL_PATH=$(dirname $(readlink -f "$0"))
MYINFO_FILE=$SHELL_PATH"/myinfo.txt"

ID=`sed '/^ID=/!d;s/.*=//' $MYINFO_FILE`
NAME=`sed '/^Name=/!d;s/.*=//' $MYINFO_FILE`
if [[ ! $ID ]] || [[ ! $NAME ]]; then
    echo "Please fill your information in myinfo.txt!!!"
    exit 1
fi
ID="${ID##*\r}"
NAME="${NAME##*\r}"


MODULE_SRC_FOLDER="modules"
MODULE_NAME="Top"
EMU_FILE="emu"
BUILD_FOLDER="build"

GEN_VERILOG="false"
BUILD="false"
SIMULATE="false"
CHECK_WAVE="false"
V_TOP_FILE="top.v"
CFLAGS=
PARAMETERS=
WAVE_FILE="vlt_dump.vcd"
PACKAGE_NAME="top"


while getopts 'bt:m:a:vf:p:' OPT; do
    case $OPT in
        b) BUILD="true";;
		m) MODULE_NAME="$OPTARG";EXAMPLES_PATH="$OPTARG";SIMULATE="true";CHECK_WAVE="true";;
        t) V_TOP_FILE="$OPTARG";;
		a) PARAMETERS="$OPTARG";;
		v) GEN_VERILOG="true";;
		f) WAVE_FILE="$OPTARG";;
		p) PACKAGE_NAME="$OPTARG";;
    esac
done

SRC_PATH=$SHELL_PATH/$MODULE_SRC_FOLDER/$EXAMPLES_PATH
BUILD_PATH=$SRC_PATH"/build"
echo $SRC_PATH
echo $BUILD_PATH


# generate verilog
if [[ "$GEN_VERILOG" == "true" ]]; then
	cd "chisel"
	sbt "runMain "$PACKAGE_NAME".elaborate"$MODULE_NAME
	cp "Verilog/"$MODULE_NAME".v" ../modules/$MODULE_NAME

fi


# Build project
if [[ "$BUILD" == "true" ]]; then

	cd $SRC_PATH
	CPP_SRC=`find . -maxdepth 1 -name "*.cpp"`
	verilator  --cc --exe -o $EMU_FILE --trace $CFLAGS -Mdir ./$BUILD_FOLDER --build *.v $CPP_SRC
	if [ $? -ne 0 ]; then
        echo "Failed to run verilator!!!"
        exit 1
    fi
	cd $SHELL_PATH
	git add . -A --ignore-errors
	(echo $NAME && echo $ID && hostnamectl && uptime) | git commit -F - -q --author='tracer-oscpu2021 <tracer@oscpu.org>' --no-verify --allow-empty 1>/dev/null 2>&1
    sync
fi

# Simulate
if [[ "$SIMULATE" == "true" ]]; then
    echo "Simulating..."
    cd $BUILD_PATH
    if [[ "$GBD" == "true" ]]; then
        gdb -s $EMU_FILE --args ./$EMU_FILE $PARAMETERS
    else
        ./$EMU_FILE $PARAMETERS
    fi

    if [ $? -ne 0 ]; then
        echo "Failed to simulate!!!"
        exit 1
    fi
    cd $SHELL_PATH
fi

# Check waveform
if [[ "$CHECK_WAVE" == "true" ]]; then
    cd $BUILD_PATH
    gtkwave $WAVE_FILE
    if [ $? -ne 0 ]; then
        echo "Failed to run gtkwave!!!"
        exit 1
    fi
    cd $SHELL_PATH
fi


# cd chisel
# sbt 'runMain top.elaborateTop'
# cp Verilog/Top.v ../examples/Top
# cd ../examples
# cd Top
