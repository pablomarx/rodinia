from collections import namedtuple
import re

"""
	write:   set to True to enable writing this parameter to FASM

	numeric: set to True to write this parameter as a bit array (width>1) or
	         single bit (width==1) named after the parameter. Otherwise this
	         parameter will be written as `name.value`

	width:   width of numeric parameter (ignored for non-numeric parameters)
	
	alias:   an alternative name for this parameter (parameter name used if alias
	         is None)
"""
ParameterConfig = namedtuple('ParameterConfig', 'write numeric width alias')

# FIXME use defaults= once Python 3.7 is standard
ParameterConfig.__new__.__defaults__ = (False, True, 1, None)

def bel_transform(input):
    match = re.match("^([A-Za-z]*)\(([0-9]*),([0-9]*)\):(.*)$", input)
    assert match is not None
    
    comps = match.groups()
    assert len(comps) is 4
    
    return "%s_Y%sX%s.%s" % (comps[0][0], comps[2], comps[1], comps[3])

def pip_transform(input):
    match = re.match("^(.*):([^ ]*) <=.*$", input)
    assert match is not None
    
    comps = match.groups()
    assert len(comps) is 2
    
    if comps[1][0] is not "I":
        # Probably alta_slice##:[ABCD] or such
        # which is explicitly wired up to the 
        # corresponding IMUX
        return None
        
    return "%s = %s" % (bel_transform(comps[0]), comps[1][1:])

"""
Write a design as FASM

    ctx:      nextpnr context
    paramCfg: map from (celltype, parametername) -> ParameterConfig describing how to write parameters
    f:        output file
"""
def write_fasm(ctx, paramCfg, f):
	for nname, net in sorted(ctx.nets, key=lambda x: str(x[1].name)):
		print("# Net %s" % nname, file=f)
		for wire, pip in sorted(net.wires, key=lambda x: str(x[1])):
			if pip.pip == "":
			    continue
			transformed = pip_transform(pip.pip)
			if transformed is not None:
			    print("%s" % transformed, file=f)
		print("", file=f)
	for cname, cell in sorted(ctx.cells, key=lambda x: str(x[1].name)):
		print("# Cell %s at %s" % (cname, cell.bel), file=f)
		for param, val in sorted(cell.params, key=lambda x: str(x)):
			cfg = paramCfg[(cell.type, param)]
			if not cfg.write:
				continue
			fasm_name = cfg.alias if cfg.alias is not None else param
			bel = bel_transform(cell.bel)
			if cfg.numeric:
				if cfg.width == 1:
					if int(val) != 0:
						print("%s.%s" % (bel, fasm_name), file=f)
				else:
					# Parameters with width >32 are direct binary, otherwise denary
					print("%s.%s[%d:0] = %d'b%s" % (bel, fasm_name, cfg.width-1, cfg.width, val), file=f)
			else:
				print("%s.%s.%s" % (bel, fasm_name, val), file=f)
		print("", file=f)