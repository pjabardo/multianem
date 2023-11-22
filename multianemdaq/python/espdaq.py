# -*- coding: utf-8 -*-

import serial
import time
import numpy as np
import threading
import argparse

from xmlrpc.server import SimpleXMLRPCServer



class ESPDaq(object):

    def __init__(self, dev='/dev/ttyUSB0', speed=115200):
        
        self.s = serial.Serial(dev, speed, timeout=100)
        self.dev = dev
        self.speed = speed
        self.avg(100)
        self.period(100)
        self.fps(1)
        self.frames = []
        self.thrd = None
        self.acquiring = False
        self.nread = 0
        self.stopaq = False
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
     
    def stop(self):
        self.stopaq = True
        return
    
    def scan_raw(self):
        self.s.flush()
        nframes = self.fps()

        self.frames = []
        self.nread = 0
        self.s.write(b'*\n')
        time.sleep(0.05)
        self.stopaq = False
        for i in range(nframes):
            self.frames.append(self.s.read(80))
            self.nread += 1
            if self.stopaq:
                self.s.write(b"!")
                time.sleep(0.1)
                self.s.readline() # STOP
                self.s.readline() # i
                time.sleep(1)
                self.s.flush()
                self.s.close()
                self.s = serial.Serial(self.dev, self.speed, timeout=100)
                self.s.flush()
                break
        return self.frames

    def start(self):
        if self.acquiring:
            raise RuntimeError("Illegal operation: System is already acquiring!")
        self.thrd = EspMcpThread(self)
        self.thrd.start()
        self.acquiring = True
    def acquire_raw(self):
        self.scan_raw(self)
        return self.frames
    def read_raw(self):
        if self.thrd is not None:
            self.thrd.join()
            self.thrd = None
            self.acquiring = False
        return self.frames
            
    def isacquiring(self):
        return self.acquiring
    def samplesread(self):
        return self.nread
    
            
    def decode_frame(self, frame):
        h = np.frombuffer(frame, np.uint32, 1, 0)[0]
        t = np.frombuffer(frame, np.uint32, 1, 4)[0]
        num = np.frombuffer(frame, np.uint32, 1, 8)[0]
        E = np.frombuffer(frame, np.uint16, 32, 12)
        f = np.frombuffer(frame, np.uint32, 1, 76)[0]
        return E, t, num, h, f
    def scan(self):

        x = self.scan_raw()

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
    
        
class EspMcpThread(threading.Thread):
    def __init__(self, dev):
        threading.Thread.__init__(self)
        self.dev = dev
        return
    def run(self):
        self.dev.scan_raw()
    
        
        
def start_server(ip='localhost', port=9523, comport='/dev/ttyUSB0', baud=115200):
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
    parser.add_argument("-p", "--port", help="XML-RPC server port", default=9523, type=int)
    parser.add_argument("-s", "--comport", help="Serial port to be used", default="/dev/ttyUSB0")

    args = parser.parse_args()
    start_server(args.ip, args.port, args.comport)
    
