import serial
import sys

ser = serial.Serial(port='COM3', baudrate=115200, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE, bytesize=serial.EIGHTBITS, timeout=100)
print("Connected on port: " + ser.portstr)
print('\n\n\n')

while True:
    message = ser.readline()
    if message == b'ORIENT1\n':
        sys.stdout.write("Current Orientation: Orientation 1\r")
        sys.stdout.flush()
    if message == b'ORIENT2\n':
        sys.stdout.write("Current Orientation: Orientation 2\r")
        sys.stdout.flush()
    if message == b'NO MAG \n':
        sys.stdout.write("Current Orientation: No Magnet    \r")
        sys.stdout.flush()
