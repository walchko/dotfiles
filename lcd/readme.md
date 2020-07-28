# LCD Install

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
