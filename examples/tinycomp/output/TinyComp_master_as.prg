usb_connect
if { [as_device_id] } {
  as_write  ./output/TinyComp_master.bin
  as_verify ./output/TinyComp_master.bin
}
usb_close
