#!/bin/sh

../Supra-2019.03.b0/bin/af -B --batch --mode QUARTUS -X "set QUARTUS_SDC true" -X "set FITTING timing_more" -X "set FITTER hybrid" -X "set EFFORT highest" -X "set HOLDX default"
