# -*- coding: utf-8 -*-

import serial
import time
import numpy as np
import argparse

from xmlrpc.server import SimpleXMLRPCServer

class ESPDaq(object):

    def __init__(self, dev='/dev/ttyUSB0', speed=115200):

        self.s = serial.Serial(dev, speed, timeout=1)
        self.dev = dev
        self.speed = speed
        self._avg = 100
        self._period = 100
        self._fps = 1
    def close(self):
        self.s.close()
        return None
    def open():
        if self.s.is_open:
            self.s.close()
        self.s.open()
        return None
    def avg(self, val=None):
        if val is None:
            cmd = '?A\n'.encode('ascii')
            self.s.write(cmd)
            b = self.s.readline()
            self._avg = int(b)
            return self._avg
        else:
            if val < 1 or val > 1000:
                val = 1
            val = int(val)
            self._avg = val
            cmd = '.A{}\n'.format(val).encode('ascii')
            self.s.write(cmd)
            return self.s.readline().decode('ascii')
    def period(self, val=None):
        if val is None:
            cmd = '?P\n'.encode('ascii')
            self.s.write(cmd)
            b = self.s.readline()
            self._period = int(b)
            return self._period
        else:
            if val < 10 or val > 1000:
                val = 100
            val = int(val)
            self._period = val
            cmd = '.P{}\n'.format(val).encode('ascii')
            self.s.write(cmd)
            return self.s.readline().decode('ascii')
    def fps(self, val=None):
        if val is None:
            cmd = '?F\n'.encode('ascii')
            self.s.write(cmd)
            b = self.s.readline()
            self._fps = int(b)
            return self._fps
        else:
            if val < 1 or val > 30000:
                val = 1
            val = int(val)
            self._fps = val
            cmd = '.F{}\n'.format(val).encode('ascii')
            self.s.write(cmd)
            return self.s.readline().decode('ascii')
     
    
    def scan_raw(self):
        nframes = self.fps()

        frames = []

        self.s.write(b'*\n')
        time.sleep(0.05)
        head = self.s.readline().decode('ascii')
        nframes = int(self.s.readline().strip())
        for i in range(nframes):
            frames.append(self.s.read(80))

        foot = self.s.readline().decode('ascii')

        return frames, head, foot
    
    def decode_frame(self, frame):
        h = np.frombuffer(frame, np.uint32, 1, 0)[0]
        t = np.frombuffer(frame, np.uint32, 1, 4)[0]
        num = np.frombuffer(frame, np.uint32, 1, 8)[0]
        E = np.frombuffer(frame, np.uint16, 32, 12)
        f = np.frombuffer(frame, np.uint32, 1, 76)[0]
        return E, t, num, h, f
    def scan(self):

        x, h, f = self.scan_raw()

        dados = [self.decode_frame(y) for y in x]
        nfr = len(x)

        E = np.zeros((nfr, 32), np.uint16)

        t0 = dados[0][1]
        if nfr == 1:
            freq = 1000/self._period
        else:
            dt = 0
            for i in range(1,nfr):
                dt = dt + (dados[i][1]-dados[i-1][1])
            dtm  = dt / (nfr-1)
            freq = 1000/dtm
            
        for i in range(nfr):    
            E[i,:] = dados[i][0]
        return E, freq
    def scanbin(self):
        E, f = self.scan()
        
        return E.tobytes(), int(E.shape[0]), int(E.shape[1]), float(f)
    
        
    
        
        
def start_server(ip='localhost', port=9541, comport='/dev/ttyUSB0', baud=115200):
    dev = ESPDaq(comport, baud)
    print("Starting XML-RPC server")
    print("IP: {}, port: {}".format(ip, port))
    server = SimpleXMLRPCServer((ip, port), allow_none=True)
    server.register_instance(dev)
    server.serve_forever()


if __name__ == "__main__":
    print("Creating interface ...")
    parser = argparse.ArgumentParser(description="ESPDaq server")
    parser.add_argument("-i", "--ip", help="IP address of the XML-RPC server", default="localhost")
    parser.add_argument("-p", "--port", help="XML-RPC server port", default=9541, type=int)
    parser.add_argument("-s", "--comport", help="Serial port to be used", default="/dev/ttyUSB0")

    args = parser.parse_args()
    start_server(args.ip, args.port, args.comport)
    
