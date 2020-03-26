#!/usr/bin/python
#
# Copyright 2019 Steve White
#
# Permission is hereby granted, free of charge, to any person obtaining 
# a copy of this software and associated documentation files (the "Software"), 
# to deal in the Software without restriction, including without limitation 
# the rights to use, copy, modify, merge, publish, distribute, sublicense, 
# and/or sell copies of the Software, and to permit persons to whom the 
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included 
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
# DEALINGS IN THE SOFTWARE.
#
from utils import bytes_to_bits, bits_to_bytes, bytes_to_num
import sys

if len(sys.argv) != 2:
    print("usage: %s <binary>" % sys.argv[0])
    sys.exit(-1)

count = 0
chunk_size = 256
dev_type = 0

print("# ")
print("# Program")
print("# ")
def emit_prefix(wait, other): 
    if dev_type == 0x120010:
        return
    print("sir 10 -tdi 3fc")
    print("runtest -tck 100")
    print("sdr 8 -tdi f0")
    if wait:
        print("sir 10 -tdi 3fd")
        print("runtest -tck 100")
        print("sdr 40 -tdi 00000000a0 -tdo 0000000000 -mask 8000000000 -wait")
    if other:
        print("sir 10 -tdi 3fa")
        print("runtest -tck 100")

def emit_trailer():
    if dev_type == 0x120010:
        print("runtest -sec 0.0002")
    else:
        print("sir 10 -tdi 3f9")
        print("runtest -tck 100")
        print("sir 10 -tdi 3f8")
        print("runtest -tck 100")
    
def emit_body(bit_len, str):
    print("sdr %i \\" % bit_len)
    print("  -tdi  %s \\" % str)
    print("  -tdo  0 \\")
    print("  -mask 0")


with open(sys.argv[1], "rb") as binaryfile:
    data = bytearray(binaryfile.read())
    dev_type = bytes_to_num(data[0:4])
    if dev_type == 0x120010:
        chunk_size = 4
    
    for offset in range(0, len(data), chunk_size):
        chunk = data[offset:offset+chunk_size]
        
        header = [0x02, (count >> 8) & 0xff, count & 0xff, 0x00]
        chunk = bytearray(header) + chunk
        bits = bytes_to_bits(chunk)
        bits.reverse()
        bytes = bits_to_bytes(bits)
        str = "".join(["%02x" % a for a in bytes])
        
        emit_prefix(count>0, True)
        emit_body(len(bits), str)
        emit_trailer()
        count += 1

emit_prefix(True, True)
emit_prefix(True, False)
