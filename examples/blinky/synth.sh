#!/bin/sh

SUPRA_DIR=/opt/agm/Supra-2019.06.b0

${SUPRA_DIR}/map/bin/yosys -ql blinky.log -p 'synth_agm -top Blinky -vqm Blinky.vqm'  Blinky.v alta-bb.v
${SUPRA_DIR}/bin/af -B --batch 
