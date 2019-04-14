#!/bin/sh

SUPRA_DIR=/opt/agm/Supra-2019.03.b0

${SUPRA_DIR}/map/bin/yosys -ql TinyComp.log -p 'synth_agm -top Top -vqm TinyComp.vqm'  TinyComp.v Top.v ram-bb.v ramw.v ramx.v ramz.v
${SUPRA_DIR}/bin/af -B --batch --mode NATIVE -X "set QUARTUS_SDC true" -X "set FITTING timing_more" -X "set FITTER hybrid" -X "set EFFORT highest" -X "set HOLDX default"
