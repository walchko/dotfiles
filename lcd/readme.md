![](https://cdn-learn.adafruit.com/assets/assets/000/042/204/small360/raspberry_pi_3527_top_demo_ORIG.jpg?1496265779)

# LCD Install

Adafruit [OLED I2C display](https://www.adafruit.com/product/3527) I use on various Pi's.

## Setup

```
apt install -y python3-pip
```

```
pip3 install -U adafruit-circuitpython-ssd1306 pillow netifaces psutil
```

## Systemd

```
mkdir -p /opt/lcd
cp lcd.py /opt/lcd
```

Copy the file `lcd.service` to `/etc/systemd/system`:

```
[Service]
ExecStart=/opt/lcd/lcd.py
Restart=always
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=oled
User=pi
Group=pi
[Install]
WantedBy=multi-user.target
```
Then set the correct permissions: `chmod 644 /etc/systemd/system/lcd.service`.
Finally, activate it:

```
systemctl daemon-reload
systemctl enable lcd.service
systemctl start lcd.service
```
