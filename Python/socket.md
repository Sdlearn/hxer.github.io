---
title: "Socket"
date: 2016-01-20 05:30
---

# socket 监听 TCP 端口，获取 password 数据

```python
import socket
import re

host = '0.0.0.0'
port = 8000 

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  #listen TCP port
sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)  
sock.bind((host, port))  
sock.listen(1)  #start listen

while 1:
    conn, addr = sock.accept()
    print("connected by:{}".format(addr))
    data=conn.recv(1024)  

    pattern = r"password.+? "
    pattern = re.compile(pattern)
    match = pattern.findall(data)
    if match:
        for m in match:
            print(m)
    else:
        print('no password match')
```

访问
```
http://127.0.0.1/index.html?password=1000
```

结果
```
connected by:('127.0.0.1', 53678)
password=1000 
```