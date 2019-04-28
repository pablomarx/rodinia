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

class BinaryWriter:
    data = bytearray()
    
    def write8(self, val):
        self.writeBytes([val])
    def write16(self, val):
        self.writeBytes(struct.pack(">H", val))
    def write32(self, val):
        self.writeBytes(struct.pack(">I", val))
    def writeBits(self, bits):
        bytes = []
        byte = 0
        len = 0
        for bit in bits:
            byte = (byte << 1) | bit
            len += 1
            if len == 8:
                bytes.append(byte)
                byte = 0
                len = 0
        if len > 0:
            for _ in range(len, 8):
                byte = (byte << 1)
            bytes.append(byte)
        self.writeBytes(bytes)
            
    def writeBytes(self, bytes):
        self.data += bytearray(bytes)
        
    def getBytes(self):
        return self.data

    def length(self):
        return len(self.data)