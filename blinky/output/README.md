* [Blinky.bin](Blinky.bin): Contents suitable for sending to AG1KLP over SPI.
* [Blinky_master.bin](Blinky_master.bin): Contents suitable for a AG1KLP to load from SPI flashrom.  

The only difference between these two files is that `Blinky_master.bin` has a prefix of `FFFF0000 0E000000 00000000 0000`
