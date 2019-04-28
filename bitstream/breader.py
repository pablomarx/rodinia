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
from utils import *

class BinaryReader:
    pos = 0
    data = None
    
    def __init__(self, filename, data=None):
        if filename is not None:
            with open(filename, "rb") as binaryfile:
                self.data = bytearray(binaryfile.read())
        else:
            self.data = data

    def endOfFile(self):
        return (self.pos >= len(self.data))
            
    def reset(self):
        self.pos = 0
        
    def rest(self):
        return self.readN(len(self.data) - self.pos)

    def skip(self, bytes):
        self.pos = self.pos + bytes

    def read32(self):
        return bytes_to_num(self.readN(4))
    
    def read16(self):
        return bytes_to_num(self.readN(2))
    
    def readN(self, n):
        pos = self.pos
        result = self.data[pos:pos+n]
        self.pos = pos + n
        return result
    
    def require32(self, val, mask=0xffffffff):
        word = self.read32()
        if word & mask != val:
            print("Unexpected word at pos %s => %s (expected %s)" % (pos-4, hex(word & mask), hex(val & mask)))
            sys.exit(-1)
        return word