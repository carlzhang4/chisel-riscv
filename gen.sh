#!/bin/bash

cd chisel
sbt 'runMain top.elaborateTop'
cp Verilog/Top.v ../examples/Top
cd ../examples
cd Top
