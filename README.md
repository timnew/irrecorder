IR Recorder
==========

A tool helps you to batch record infrared sequence into files. 

## Steps to setup

### Arduino Sensor
1. Download and install arduino IRemote library if you havn't. The library can be found at [http://arcfn.com/2009/08/multi-protocol-infrared-remote-library.html](http://arcfn.com/2009/08/multi-protocol-infrared-remote-library.html)
2. Connect a IR reciver LED to PIN 11
3. Connect the arudino to computer via USB
4. Burn the `sensor` onto an Arduino device. 

### Recorder
1. Install the Ruby 2.0 if you haven't
2. Bundle install all the dependencies
3. Write the keys you want to record into a yaml file
4. `rake commands[keys.yml] port[cu.usbmodem111] output[record.yml]`

For more detail, enter `rake -T` in the shell.