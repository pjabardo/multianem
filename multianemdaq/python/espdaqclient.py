import numpy as np
import xmlrpc.client


class ESPDaqClient(object):

    def __init__(self, ip, port):

        self.dev = xmlrpc.client.ServerProxy("http://{}:{}".format(ip, port))
        self.dev.avg(100)
        self.dev.period(100)
        self.dev.fps(1)
        

    def avg(self, val=None):
        if val is None:
            self._avg = self.dev.avg()
            return self._avg
        else:
            self.dev.avg(val)
            self._avg = self.dev.avg()
            return self._avg
        
    def fps(self, val=None):
        if val is None:
            self._fps = self.dev.fps()
            return self._fps
        else:
            self.dev.fps(val)
            self._fps = self.dev.fps()
            return self._fps
        
    def period(self, val=None):
        if val is None:
            self._period = self.dev.period()
            return self._period
        else:
            self.dev.period(val)
            self._period = self.dev.period()
            return self._period
    
    def scan_raw(self):
        
        x, h, f = self.dev.scan_raw()
        x = [y.data for y in x]
        return x

    def decode_frame(self, frame):
        h = np.frombuffer(frame, np.uint32, 1, 0)[0]
        t = np.frombuffer(frame, np.uint32, 1, 4)[0]
        num = np.frombuffer(frame, np.uint32, 1, 8)[0]
        E = np.frombuffer(frame, np.uint16, 32, 12)
        f = np.frombuffer(frame, np.uint32, 1, 76)[0]
        return E, t, num, h, f
    def scan(self):

        x= self.scan_raw()

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
    
