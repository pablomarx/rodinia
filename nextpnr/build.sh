#!/usr/bin/env bash
set -ex

SOURCE=$1
if [ x"" == x"${SOURCE}" ]; then
	SOURCE=blinky
fi

if [ ! -f ${SOURCE}.v ]; then
	echo "Couldn't read ${SOURCE}.v"
else
	OUTDIR=build-${SOURCE}
	if [ ! -d ${OUTDIR} ]; then
		mkdir ${OUTDIR}
	fi
	
	yosys -p "tcl synth/synth_generic.tcl 4 ${OUTDIR}/${SOURCE}.json ${OUTDIR}/${SOURCE}.v" ${SOURCE}.v
	# --pre-place simple_timing.py
	nextpnr-generic --pre-pack simple.py --post-route bitstream.py --json ${OUTDIR}/${SOURCE}.json --write ${OUTDIR}/pnr${SOURCE}.json --debug
	yosys -p "read_verilog -lib synth/prims.v; read_json ${OUTDIR}/pnr${SOURCE}.json; dump -o ${OUTDIR}/${SOURCE}.il; show -format png -prefix ${SOURCE}"
	mv ${SOURCE}.dot ${OUTDIR}
	mv ${SOURCE}.png ${OUTDIR}
	mv nextpnr.fasm ${OUTDIR}/${SOURCE}.fasm
	python3 fasm_pack.py ${OUTDIR}/${SOURCE}.fasm ${OUTDIR}/${SOURCE}.asc
	python3 ../bitstream/agm-pack.py ${OUTDIR}/${SOURCE}.asc ${OUTDIR}/${SOURCE}.bin
	python3 ../bitstream/agm-unpack.py ${OUTDIR}/${SOURCE}.bin > ${OUTDIR}/${SOURCE}-unpack.txt
	python3 ../bitstream/agm-explain.py ${OUTDIR}/${SOURCE}-unpack.txt > ${OUTDIR}/${SOURCE}-explain.txt
fi