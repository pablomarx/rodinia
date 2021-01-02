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

import sys

class bitstream(object):
    def __init__(self, bytes):
        self.bytes = bytes
        self.offset = 0;
        self.bit = 7

    def __iter__(self):
        return self

    # Python 3 compatibility
    def __next__(self):
        return self.next()

    def next(self):
        if self.offset >= len(self.bytes):
            raise StopIteration()

        cur = (self.bytes[self.offset] >> self.bit) & 1
        self.bit -= 1
        if self.bit < 0:
            self.bit = 7
            self.offset += 1
            
        return cur

class bitslice(object):
    def __init__(self, bytes, bitlen):
        self.bitstream = bitstream(bytes)
        self.bitlen = bitlen

    def __iter__(self):
        return self

    # Python 3 compatibility
    def __next__(self):
        return self.next()

    def next(self):
        if self.bitstream is None:
            raise StopIteration()
        if self.bitlen == 0:
            raise StopIteration()

        cur = 0
        try:
            for _ in range(0, self.bitlen):
                cur = (cur << 1) | self.bitstream.next()
        except StopIteration:
            self.bitstream = None
        return cur

def nibbles_to_bytes(nibbles):
    bytes = bytearray()
    num_nibbles = len(nibbles)
    for i in range(0, num_nibbles, 2):
        nibbleA = nibbles[i]
        if i + 1 >= num_nibbles:
            nibbleB = 0
        else:
            nibbleB = nibbles[i+1]
        bytes.append((nibbleA << 4) | nibbleB)
    return bytes

#
# AF lzw encodes nibbles. 
# lzw output is 6 bits.  
# If the top two bits are clear, then it's a raw nibble.
# Otherwise it's a lzw control.
# 0x10 is CLEAR_CODE
# 0x11 appears in AG16K bitstreams. Unknown purpose.
# The rest are dictionary codes
#
def lzw_decode(bytes, lzw_length=6, variable_width=False):
    if variable_width == False:
        reader = bitslice(bytes, lzw_length)
    else:
        # Read four for the nibble, additional one for control 
        reader = bitslice(bytes, 5)
    
    result = []
    table = []
    prev = [reader.next()]
    result += prev
    
    for cur in reader:
        emitDictWrite = False
        if cur < 16:
            cur = [cur]
        elif cur == 16:
            table = []
            prev = [reader.next()]
            result += prev
            continue
        elif cur == 17:
            raise BaseException("Unexpected code 17")
        else:    
            cur -= 18
            if cur < len(table):
               cur = table[cur]
            else:
                cur = [prev[0]]
                emitDictWrite = True

        val = prev + [cur[0]]
        table.append(val)
        
        if emitDictWrite:
            cur = val
        
        result += cur
        prev = cur

    return nibbles_to_bytes(result)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("usage: %s <spi binary>" % sys.argv[0])
        sys.exit(-1)

    with open(sys.argv[1], "rb") as binaryfile:
        data = bytearray(binaryfile.read())
        print(lzw_decode(data[32:]))
