#!/bin/sh

SUPRA_DIR=/opt/agm/Supra-2019.06.b0

${SUPRA_DIR}/map/bin/yosys -ql blinky.log -p 'synth_agm -top Blinky -vqm Blinky.vqm'  Blinky.v alta-bb.v
${SUPRA_DIR}/bin/af -B --batch 

pushd output/alta_db
for f in alta_lib.v place.tx route.tx ; do
python ../../../../supra/agm-decode.py $f > 1
mv 1 $f
done
popd

python ../../bitstream/agm-unpack.py output/Blinky.bin > output/Blinky_unpack.txt
python ../../bitstream/agm-explain.py output/Blinky_unpack.txt output/alta_db/route.tx > output/Blinky_explain.txt
