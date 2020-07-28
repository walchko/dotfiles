#!/usr/bin/env python3
# MIT License 2018 Kevin J. Walchko

# This is run using the system python, so just use python3
# make sure to install:
# pip install -U Adafruit-SSD1306 pillow netifaces psutil

import netifaces as nf
import psutil as ps
import socket
import time
# import Adafruit_GPIO.SPI as SPI
# import Adafruit_SSD1306
import os

from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw

from board import SCL, SDA
import busio
import adafruit_ssd1306

# start ---
i2c = busio.I2C(SCL, SDA)
# disp = Adafruit_SSD1306.SSD1306_128_32(rst=24)
disp = adafruit_ssd1306.SSD1306_I2C(128, 32, i2c)
# disp.begin()

# Get display width and height.
width = disp.width
height = disp.height

# clear display ----
# disp.clear()
# disp.display()

# setup ---
# Create image buffer.
# Make sure to create image with mode '1' for 1-bit color.
image = Image.new('1', (width, height))

# Get drawing object to draw on image.
draw = ImageDraw.Draw(image)

# Draw a black filled box to clear the image.
draw.rectangle((0,0,width,height), outline=0, fill=0)

# Load default font.
font = ImageFont.load_default()

# https://github.com/sindresorhus/cli-spinners/blob/HEAD/spinners.json
# spin = ['|','/','--','\\','+']
spin = ['.','o','O','0','O','o']
wrap = len(spin)
i = 0
x = 0
top = -2

def getRelease():
    with open("/etc/os-release") as fd:
        d = fd.read()
    m = {}
    # print(d)
    d = d.split('\n')
    for s in d:
        # print(">>", s)
        try:
            k,v = s.split('=')
            # print(k,'\n',v)
            m[k] = v
        except Exception as e:
            # print(e)
            continue
    # print(m)
    return m


try:
    # get release name: buster
    relinfo = getRelease()
    rel = relinfo["VERSION_CODENAME"]
    # get linux kernel version: 4.23
    ver = os.uname().release.split('-')[0]
    ver = '.'.join(ver.split('.')[:2])
    while True:
        draw.rectangle((0,0,width,height), outline=0, fill=0)

        # get interfaces
        ifs = nf.interfaces()
        # ap = False
        # if 'wlan1' in ifs:
        #    addr = nf.ifaddresses('wlan0')[nf.AF_INET][0]['addr']
        #    if addr == '10.10.10.1':
        #        ap = True
        addrs = []
        for ip in ['en0', 'eth0', 'wlan0']:
            if ip in ifs:
                addr = nf.ifaddresses(ip)[nf.AF_INET][0]['addr']
                addrs.append((ip, addr,))

        # print heartbeat, name, release, kernel version
        str = "{} {} {} {}".format(
            spin[i%wrap],
            socket.gethostname().split('.')[0],
            rel,
            ver
        )

        i += 1
        draw.text((x,top), str, font=font, fill=127)

        # get cpu and memory performance
        cpu = ps.cpu_percent()
        mem = ps.virtual_memory().percent
        str = "CPU: {:3.0f}% Mem: {:3.0f}%".format(cpu,mem)
        draw.text((x,top+8), str, font=font, fill=255)

        # get networking for ethernet and wifi
        for cnt, (ip, addr) in enumerate(addrs):
            str = "{}: {}".format(ip, addr)
            draw.text((x,top+8+(cnt+1)*8), str, font=font, fill=255)

        disp.image(image);
        disp.show()
        time.sleep(1)
except KeyboardInterrupt:
    print('bye ...')

# clear display ----
# disp.clear()
# disp.display()
# Draw a black filled box to clear the image.
draw.rectangle((0,0,width,height), outline=0, fill=0)
disp.image(image);
disp.show()
time.sleep(0.1)
