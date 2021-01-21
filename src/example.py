import pyotherside
import time
import threading

def slow_function():
    for i in range(100):
        pyotherside.send('progress', i)
        time.sleep(0.2)
    pyotherside.send('finished')

class Downloader:
    def __init__(self):
        self.bgthread = threading.Thread()

    def download(self):
        if self.bgthread.is_alive():
            return
        self.bgthread = threading.Thread(target=slow_function)
        self.bgthread.start()

downloader = Downloader()