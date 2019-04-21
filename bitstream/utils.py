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
def round_up(a, b):
    return (((a) + ((b)-1)) & ~((b)-1))

def bytes_to_num(bytes):
    num = 0
    for byte in bytes:
        num = (num << 8) | byte
    return num

def bits_invert(bits):
    return [int(not bit) for bit in bits]

def bits_to_string(bits, spacing=0, prefix=False):
    r = bits
    if spacing > 0:
        r = r[:]
        num = 0
        for i in range(spacing, len(bits), spacing):
            r.insert(i + num, '_')
            num += 1
    base = ''
    if prefix:
        base = str(len(bits)) + '\'b'
    return base + ''.join([str(x) for x in r])

def bytes_to_bits(bytes):
    bits = []
    for byte in bytes:
        for i in range(0,8):
            bits.append((byte >> 7) & 1)
            byte = byte << 1
    return bits

def bits_to_bytes(bits):
    bytes = []
    byte = 0
    for i in range(0, len(bits)):
        bit = bits[i]
        byte = (byte << 1) | bit
        if i & 7 == 7:
            bytes.append(byte)
            byte = 0
    if i & 7 != 7:
        bytes.append(byte)
    return bytes