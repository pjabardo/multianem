import numpy as np
import xmlrpc.client


class ESPDaqClient(object):

    def __init__(self, ip, port):

        self.dev = xmlrpc.client.ServerProxy("http://{}:{}".format(ip, port))


    def avg(self, val=None):
        if val is None:
            return self.dev.avg()
        else:
            return self.dev.avg(val)
        
    def fps(self, val=None):
        if val is None:
            return self.dev.fps()
        else:
            return self.dev.fps(val)
        
    def period(self, val=None):
        if val is None:
            return self.dev.period()
        else:
            return self.dev.period(val)
    
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
    
