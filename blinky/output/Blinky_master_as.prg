usb_connect
if { [as_device_id] } {
  as_write  ./Blinky_master.bin
  as_verify ./Blinky_master.bin
}
usb_close
