#!/usr/bin/python
#
# Copyright 2019 Steve White
#
# Permission is hereby granted, free of charge, to any person obtaining 
# a copy of this software and associated documentation files (the 'Software'), 
# to deal in the Software without restriction, including without limitation 
# the rights to use, copy, modify, merge, publish, distribute, sublicense, 
# and/or sell copies of the Software, and to permit persons to whom the 
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included 
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
# DEALINGS IN THE SOFTWARE.
#

import re

class RouteFile:
    nets_by_name = {}
    nets_by_tile = {}

    def __init__(self, filename):
        tilepat = re.compile('(\w+)\((\d+),(\d+)\):(\w+)')
        with open(filename, "r") as file:
            net = None
            num_paths = 0
            paths = None
            while True:
                line = file.readline().rstrip()
                if line.startswith("Skews"):
                    break
                elif line.startswith(" net :"):
                    net = line.split('"')[1]
                elif line.startswith("  path : "):
                    num_paths = int(line[9:])
                    if num_paths > 0:
                        paths = []
                        self.nets_by_name[net] = paths
                elif net is not None and num_paths > 0:
                    num_paths -= 1
                    path = line.split('"')[1]
                    paths.append(path)
                    
                    comps = tilepat.search(path)
                    data = {'type': comps.group(1), 'x': comps.group(2), 'y': comps.group(3), 'config':comps.group(4)}
            
                    if data['x'] not in self.nets_by_tile:
                        self.nets_by_tile[data['x']] = {}
                
                    x = self.nets_by_tile[data['x']]
                    if data['y'] not in x:
                        x[data['y']] = {}
                
                    y = x[data['y']]
                    if data['config'] not in y:
                        y[data['config']] = net

    def path_for_net(self, net):
        return self.nets_by_name[net]
        
    def nets_for_tile(self, tile_x, tile_y):
        tile_x = str(tile_x)
        tile_y = str(tile_y)

        if tile_x not in self.nets_by_tile:
            return None
            
        x = self.nets_by_tile[tile_x]
        if tile_y not in x:
            return None
    
        return x[tile_y]
        
    def net_for_tile_config(self, tile_x, tile_y, config):
        nets = self.nets_for_tile(tile_x, tile_y)
        if nets is None:
            return None

        if config.startswith("SLICE_LOGIC"):
            config = config[14:]
            if config.startswith("OMUX_") or config.startswith("IMUX_"):
                config = config[0:4] + config[5:]

        if config.startswith("CFG_"):
            config = config[4:]

        # how to map?:
        # iotile alta_ioreg
        # bramtile bufmux
        # logictile bufmux
        if config not in nets:
            matched = False
            for key in nets.keys():
                if key.lower() == config.lower():
                    config = key
                    matched = True
                    break
            if matched is False:
                return None

        return nets[config]
