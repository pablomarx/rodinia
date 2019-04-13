# rodinia
Decoded files from AGM's Supra tool

### Contents
* [bitstream/agm-unpack.py](bitstream/agm-unpack.py): Python script to unpack a SPI bitstream
* [agm-decode.py](agm-decode.py): Python script to decode AGM's encoded files
* [etc](etc): Decoded files from Supra-2019.03.b0
* [blinky](blinky): Sample input that can be synthesized by executing [blinky/input/synth.sh](blinky/input/synth.sh).  And the resulting output of the `af` tool in [blinky/output](blinky/output). Of which [blinky/output/alta_db/route.tx](blinky/output/alta_db/route.tx) seems particularly interesting. 
 
### How the substitution cypher values were retrieved

1. Ran af through gdb in the blinky/input directory.
```
$ gdb /opt/agm/Supra-2019.03.b0/bin/af
GNU gdb (Debian 7.12-6) 7.12.0.20161007-git
Copyright (C) 2016 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from /opt/agm/Supra-2019.03.b0/bin/af...(no debugging symbols found)...done.
(gdb)
```

2. Added breakpoint for `fopen`:

```
(gdb) break fopen
Breakpoint 1 at 0x406610
```

3. Added breakpoint command to print backtrace for fopen calls:
```
(gdb) command 1
Type commands for breakpoint(s) 1, one per line.
End with a line saying just "end".
>p (char *)$rdi
>bt
>c
>end
```
4. Ran the binary. 
```
(gdb) run -B --batch --mode QUARTUS -X "set QUARTUS_SDC true" -X "set FITTING timing_more" -X "set FITTER hybrid" -X "set EFFORT highest" -X "set HOLDX default"
```

5. Observed that calls to fopen of encoded files were coming from the same call sites. 

```
Thread 1 "af" hit Breakpoint 1, _IO_new_fopen (
    filename=0x2748820 "/opt/agm/Supra-2019.03.b0/etc/arch/rodinia/config/alta_io_N4_bram_cfg.csv", mode=0xbcc5fa "r") at iofopen.c:97
97	in iofopen.c
$33 = 0x2748820 "/opt/agm/Supra-2019.03.b0/etc/arch/rodinia/config/alta_io_N4_bram_cfg.csv"
#0  _IO_new_fopen (filename=0x2748820 "/opt/agm/Supra-2019.03.b0/etc/arch/rodinia/config/alta_io_N4_bram_cfg.csv", mode=0xbcc5fa "r")
    at iofopen.c:97
#1  0x0000000000a00db0 in ?? ()
#2  0x0000000000a4d3ba in ?? ()
#3  0x00000000008ba883 in ?? ()
#4  0x00000000008b0d52 in ?? ()

Thread 1 "af" hit Breakpoint 1, _IO_new_fopen (
    filename=0x2789900 "/opt/agm/Supra-2019.03.b0/etc/arch/rodinia/config/alta_io_N4_G1_bram_cfg.csv", mode=0xbcc5fa "r")
    at iofopen.c:97
97	in iofopen.c
$34 = 0x2789900 "/opt/agm/Supra-2019.03.b0/etc/arch/rodinia/config/alta_io_N4_G1_bram_cfg.csv"
#0  _IO_new_fopen (filename=0x2789900 "/opt/agm/Supra-2019.03.b0/etc/arch/rodinia/config/alta_io_N4_G1_bram_cfg.csv", 
    mode=0xbcc5fa "r") at iofopen.c:97
#1  0x0000000000a00db0 in ?? ()
#2  0x0000000000a4d3ba in ?? ()
#3  0x00000000008ba883 in ?? ()
#4  0x00000000008b0d52 in ?? ()

Thread 1 "af" hit Breakpoint 1, _IO_new_fopen (
    filename=0x27ca800 "/opt/agm/Supra-2019.03.b0/etc/arch/rodinia/config/alta_io_S4_bram_cfg.csv", mode=0xbcc5fa "r") at iofopen.c:97
97	in iofopen.c
$35 = 0x27ca800 "/opt/agm/Supra-2019.03.b0/etc/arch/rodinia/config/alta_io_S4_bram_cfg.csv"
#0  _IO_new_fopen (filename=0x27ca800 "/opt/agm/Supra-2019.03.b0/etc/arch/rodinia/config/alta_io_S4_bram_cfg.csv", mode=0xbcc5fa "r")
    at iofopen.c:97
#1  0x0000000000a00db0 in ?? ()
#2  0x0000000000a4d3ba in ?? ()
#3  0x00000000008ba883 in ?? ()
#4  0x00000000008b0d52 in ?? ()
```

6. Re-ran the binary with a breakpoint at `0x00000000008b0d52`:

```(gdb) b *0x00000000008b0d52
Breakpoint 1 at 0x8b0d52
```

7. Stopped at the breakpoint, dumped register values:

```
(gdb) info reg
rax            0x1	1
rbx            0x7ffffffcb6c7	140737488139975
rcx            0x60	96
rdx            0xbbee58	12316248
rsi            0xbbeec0	12316352
rdi            0x1e67500	31880448
rbp            0x7ffffffdbac0	0x7ffffffdbac0
rsp            0x7ffffffcb430	0x7ffffffcb430
r8             0x4d	77
r9             0x9	9
r10            0x695f61746c612f67	7592894649432354663
r11            0x6172625f344e5f6f	7021782930062991215
r12            0x7ffffffcb840	140737488140352
r13            0x27316c0	41096896
r14            0x1b9e880	28960896
r15            0x7ffffffcb6c7	140737488139975
rip            0x8b0d52	0x8b0d52
eflags         0x202	[ IF ]
cs             0x33	51
ss             0x2b	43
ds             0x0	0
es             0x0	0
fs             0x0	0
gs             0x0	0
```

8. Printed out contents of RDX and RSI:

```
(gdb) x /96bc $rdx
0xbbee58:	61 '='	114 'r'	99 'c'	123 '{'	48 '0'	37 '%'	36 '$'	44 ','
0xbbee60:	79 'O'	120 'x'	94 '^'	116 't'	51 '3'	112 'p'	60 '<'	82 'R'
0xbbee68:	39 '\''	43 '+'	108 'l'	52 '4'	34 '"'	50 '2'	69 'E'	87 'W'
0xbbee70:	70 'F'	47 '/'	124 '|'	111 'o'	71 'G'	74 'J'	40 '('	121 'y'
0xbbee78:	97 'a'	45 '-'	101 'e'	38 '&'	107 'k'	102 'f'	117 'u'	115 's'
0xbbee80:	46 '.'	9 '\t'	80 'P'	32 ' '	66 'B'	126 '~'	119 'w'	96 '`'
0xbbee88:	75 'K'	62 '>'	54 '6'	93 ']'	58 ':'	35 '#'	81 'Q'	55 '7'
0xbbee90:	65 'A'	67 'C'	49 '1'	57 '9'	86 'V'	103 'g'	104 'h'	72 'H'
0xbbee98:	91 '['	56 '8'	42 '*'	110 'n'	64 '@'	100 'd'	76 'L'	53 '5'
0xbbeea0:	105 'i'	118 'v'	122 'z'	95 '_'	68 'D'	125 '}'	41 ')'	63 '?'
0xbbeea8:	88 'X'	85 'U'	106 'j'	109 'm'	98 'b'	83 'S'	89 'Y'	90 'Z'
0xbbeeb0:	59 ';'	84 'T'	92 '\\'	113 'q'	33 '!'	73 'I'	78 'N'	77 'M'
(gdb) x /96bc $rsi
0xbbeec0:	48 '0'	49 '1'	50 '2'	51 '3'	52 '4'	53 '5'	54 '6'	55 '7'
0xbbeec8:	56 '8'	57 '9'	97 'a'	98 'b'	99 'c'	100 'd'	101 'e'	102 'f'
0xbbeed0:	103 'g'	104 'h'	105 'i'	106 'j'	107 'k'	108 'l'	109 'm'	110 'n'
0xbbeed8:	111 'o'	112 'p'	113 'q'	114 'r'	115 's'	116 't'	117 'u'	118 'v'
0xbbeee0:	119 'w'	120 'x'	121 'y'	122 'z'	65 'A'	66 'B'	67 'C'	68 'D'
0xbbeee8:	69 'E'	70 'F'	71 'G'	72 'H'	73 'I'	74 'J'	75 'K'	76 'L'
0xbbeef0:	77 'M'	78 'N'	79 'O'	80 'P'	81 'Q'	82 'R'	83 'S'	84 'T'
0xbbeef8:	85 'U'	86 'V'	87 'W'	88 'X'	89 'Y'	90 'Z'	33 '!'	34 '"'
0xbbef00:	35 '#'	36 '$'	37 '%'	38 '&'	39 '\''	40 '('	41 ')'	42 '*'
0xbbef08:	43 '+'	44 ','	45 '-'	46 '.'	47 '/'	58 ':'	59 ';'	60 '<'
0xbbef10:	61 '='	62 '>'	63 '?'	64 '@'	91 '['	92 '\\'	93 ']'	94 '^'
0xbbef18:	95 '_'	96 '`'	123 '{'	124 '|'	125 '}'	126 '~'	32 ' '	9 '\t'
```

9. Both contained a number of ascii characters. RSI contained them in a nice order.  Wrote some quick code to see if these were the substitution values and they were. 
