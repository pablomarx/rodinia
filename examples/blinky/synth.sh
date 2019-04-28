#!/bin/sh

SUPRA_DIR=/opt/agm/Supra-2019.03.b0

${SUPRA_DIR}/map/bin/yosys -ql blinky.log -p 'synth_agm -top Blinky -vqm Blinky.vqm'  Blinky.v prom.v alta-bb.v
${SUPRA_DIR}/bin/af -B --batch 
