# RSPduo dual tuner mode experiments

## PPS Time Synchronization

A collection of tools, programs, and scripts to experiment with the SDRplay RSPduo in dual tuner mode that aim to create a time synchronization to pulse per second. This is designed for use with a raspberry pi, where PPS is fed to GPIO17 (pin 11 on 4B header). The time delta in microseconds will be printed in the filename between the rising PPS edge and the first callback function. When analyzing the IQ data later, you can adjust to (1-timedelta) to obtain the correct PPS start during the next second. This script uses the pigpio.h library to poll the GPIO chipset. 

Currently there are still latency issues. Using a server image of Ubuntu 22.04LTS, nice values of -20 on the sdrplay API, and the script switches to a FIFO scheduler for the data collection and GPIO polling, but there is still maybe 150us of drift.


## dual_tuner_recorder

A simple C program that records to two files the I/Q streams for the A and B channels from an RSPduo in dual tuner mode; sample rate, decimation, IF frequency, IF bandwidth, gains, and center frequency are provided via command line arguments (see below).


To build it run these commands:
```
mkdir build
cd build
cmake ..
make (or ninja)
```


These are the command line options for `dual_tuner_recorder`:

    -s <serial number>
    -r <RSPduo sample rate>
    -d <decimation>
    -i <IF frequency>
    -b <IF bandwidth>
    -g <IF gain reduction> ("AGC" to enable AGC)
    -l <LNA state>
    -D disable post tuner DC offset compensation (default: enabled)
    -I disable post tuner I/Q balance compensation (default: enabled)
    -y tuner DC offset compensation parameters <dcCal,speedUp,trackTime,refeshRateTime> (default: 3,0,1,2048)
    -f <center frequency>
    -x <streaming time (s)> (default: 10s)
    -o <output file> ('%c' will be replaced by the channel id (A or B) and 'SAMPLERATE' will be replaced by the estimated sample rate in kHz)


Here are some usage examples:

- record local NOAA weather radio on 162.55MHz using an RSPduo sample rate of 6MHz and IF=1620kHz:
```
./dual_tuner_recorder -r 6000000 -i 1620 -b 1536 -l 3 -f 162550000 -o noaa-6M-SAMPLERATEk-%c.iq16
```

- record local NOAA weather radio on 162.55MHz using an RSPduo sample rate of 8MHz and IF=2048kHz:
```
./dual_tuner_recorder -r 8000000 -i 2048 -b 1536 -l 3 -f 162550000 -o noaa-8M-SAMPLERATEk-%c.iq16
```



## Copyright
(C) 2024 Lawrence Coleman
(C) 2022 Franco Venturi - Licensed under the GNU GPL V3 

