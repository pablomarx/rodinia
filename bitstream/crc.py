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
import struct
import sys

def crc(bytes):
    csum = 0xffffffff
    for byte in bytes:
        csum = (byte << 24) ^ csum
        i = 0
        while i != 8:
            while csum < 0x7fffffff:
                i += 1
                csum = (csum * 2) & 0xffffffff
                if i == 8:
                    break
            
            if i < 8:
                i += 1
                csum = ((csum * 2) & 0xffffffff) ^ 0x4c11db7
                
    return ~csum & 0xffffffff

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("usage: %s <spi binary>" % sys.argv[0])
        sys.exit(-1)

    with open(sys.argv[1], "rb") as binaryfile:
        data = bytearray(binaryfile.read())
        csum_bytes = data[-4:]
        csum = (csum_bytes[0] << 24) | (csum_bytes[1] << 16) | (csum_bytes[2] << 8) | (csum_bytes[3]);
        print("    file checksum: %s" % hex(csum))
        print("computed checksum: %s" % hex(crc(data[:-4])))
