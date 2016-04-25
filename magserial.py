# calibrationMatrix = [
#     [], [], [],
#     [], [], [],
#     [], [], []
# ]
#
# calibrationPositions = {
#     'top_left': 0,
#     'top_mid': 1,
#     'top_right': 2,
#
#     'center_left': 3,
#     'center_mid': 4,
#     'center_right': 5,
#
#     'bottom_left': 6,
#     'bottom_mid': 7,
#     'bottom_right': 8
# }

import serial
ser = serial.Serial('/dev/cu.usbmodem1411', 9600)

import socket
TCP_IP = '127.0.0.1'
TCP_PORT = 5204
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect((TCP_IP, TCP_PORT))

import numpy as np
from scipy import interpolate


x = np.array([ 0. ,  0.5,  1. ,  1.5,  2. ,  2.5,  3. ,  3.5,  4. ,  4.5,  5. ])
y = np.array([2222, 1986, 1239,  850,  600,  450,  360,  280,  230,  200,  170])
s = interpolate.InterpolatedUnivariateSpline(y[::-1], x[::-1])

while True:
    magnitude = 0
    theta = 0

    data = ser.readline()

    data = str(data).split(',')

    if len(data) == 3:    
        magnitude = float(data[1])
        theta = float(data[2][:3])

        r = s(magnitude)
        x = r*np.cos(theta*3.14/180)
        y = r*np.sin(theta*3.14/180)
        
        # print('%.2f, %.2f, %.2f, %.2f' %(r, theta, x, y))
        
        sock.send('%.2f,%.2f\n' %(r, theta))
        