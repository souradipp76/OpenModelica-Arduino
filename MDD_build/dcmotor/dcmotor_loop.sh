#!/bin/bash
clear
mdd_path=($(locate Modelica_DeviceDrivers/Modelica_DeviceDrivers/Resources/Include))
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
	om_path=($(locate /usr/include/omc/c))
	port="/dev/ttyACM$1"
else
	cd /	
	om_path=($(dir /S /P /OpenModelica*/include/omc/c))
	port="COM$1"
fi
b_rate=$2
#echo ${om_path[0]}
omc --simCodeTarget=ExperimentalEmbeddedC runMDD_dcmotor_loop.mos
if [ $? -ne 0 ]; then
	exit 1
fi
avr-gcc -Os -std=c11 -ffunction-sections -fdata-sections -mmcu=atmega328p -DF_CPU=16000000UL -Wl,--gc-sections dcmotor_loop_main.c -o dcmotor_loop -I ${mdd_path[0]} -I ${om_path[0]}
if [ $? -ne 0 ]; then
	exit 1
fi
avr-objcopy -O ihex -R .eeprom dcmotor_loop dcmotor_loop.hex
if [ $? -ne 0 ]; then
	exit 1
fi 
avrdude -F -V -c arduino -p ATMEGA328P -P $port -b $b_rate -U flash:w:dcmotor_loop.hex
if [ $? -ne 0 ]; then
	exit 1
fi