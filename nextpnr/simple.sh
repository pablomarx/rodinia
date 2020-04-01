#!/usr/bin/env bash
set -ex
yosys -p "tcl synth/synth_generic.tcl 4 blinky.json" blinky.v
# --pre-place simple_timing.py
nextpnr-generic --pre-pack simple.py --post-route bitstream.py --json blinky.json --write pnrblinky.json --debug
yosys -p "read_verilog -lib synth/prims.v; read_json pnrblinky.json; dump -o blinky.il; show -format png -prefix blinky"
python3 fasm_pack.py blinky.fasm blinky.asc
python3 ../bitstream/agm-pack.py blinky.asc blinky.bin