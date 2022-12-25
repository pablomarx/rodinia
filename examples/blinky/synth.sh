#!/bin/bash

SUPRA_DIR=/opt/agm/Supra-2019.06.b0

${SUPRA_DIR}/map/bin/yosys -ql blinky.log -p 'synth_agm -top Blinky -vqm Blinky.vqm'  Blinky.v alta-bb.v
${SUPRA_DIR}/bin/af -B --batch 

pushd output/alta_db
for f in alta_lib.v place.tx route.tx ; do
python3 ../../../../supra/agm-decode.py $f > 1
mv 1 $f
done
popd

python3 ../../bitstream/agm-unpack.py output/Blinky.bin > output/Blinky_unpack.txt
python3 ../../bitstream/agm-explain.py --route output/alta_db/route.tx output/Blinky_unpack.txt > output/Blinky_explain.txt
python3 ../../bitstream/agm-explain.py --output fasm --route output/alta_db/route.tx output/Blinky_unpack.txt > output/Blinky.fasm
