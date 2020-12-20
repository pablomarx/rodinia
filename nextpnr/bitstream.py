from write_fasm import *

# Need to tell FASM generator how to write parameters
# (celltype, parameter) -> ParameterConfig
param_map = {
	("GENERIC_SLICE", "K"): ParameterConfig(write=False),
	("GENERIC_SLICE", "INIT"): ParameterConfig(write=True, numeric=True, width=2**4),
	("GENERIC_SLICE", "FF_USED"): ParameterConfig(write=True, numeric=True, width=1),

	("GENERIC_IOB", "INPUT_USED"): ParameterConfig(write=True, numeric=True, width=1),
	("GENERIC_IOB", "OUTPUT_USED"): ParameterConfig(write=True, numeric=True, width=1),
	("GENERIC_IOB", "ENABLE_USED"): ParameterConfig(write=True, numeric=True, width=1),

	("GENERIC_BRAM", "INIT_VAL"): ParameterConfig(write=True, numeric=True, width=4608),
        
    ("GENERIC_PLL", "CLKOUT0_DIV"): ParameterConfig(write=True, numeric=True, width=6),
    ("GENERIC_PLL", "CLKOUT1_DIV"): ParameterConfig(write=True, numeric=True, width=6),
    ("GENERIC_PLL", "CLKOUT2_DIV"): ParameterConfig(write=True, numeric=True, width=6),
    ("GENERIC_PLL", "CLKOUT3_DIV"): ParameterConfig(write=True, numeric=True, width=6),
    ("GENERIC_PLL", "CLKOUT0_DEL"): ParameterConfig(write=True, numeric=True, width=6),
    ("GENERIC_PLL", "CLKOUT1_DEL"): ParameterConfig(write=True, numeric=True, width=6),
    ("GENERIC_PLL", "CLKOUT2_DEL"): ParameterConfig(write=True, numeric=True, width=6),
    ("GENERIC_PLL", "CLKOUT3_DEL"): ParameterConfig(write=True, numeric=True, width=6),
}

with open("nextpnr.fasm", "w") as f:
	write_fasm(ctx, param_map, f)

