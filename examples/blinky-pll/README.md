* [Blinky.v](Blinky.v) Input verilog source
* [PLL40.v](prom.v) PLLX instantiation created using Supra's IP tool, modified by hand afterwards
    * `af -B -X "exit [catch {generate_pll {PLL40} -pll_type {PLLX} -input_freq {8} -output_freqs { {40}} -fb_mode {NO_REFERENCE}}]"`
    * PLL clkin needs to be on either pin 13, 15 or 19 (global input clock pins) on AG1KLP48.
