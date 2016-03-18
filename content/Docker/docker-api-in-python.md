---
title: "docker api in python"
date: 2016-03-17 16:44
---

## docker-py

[Python API 操作][1]
[docker-py api][2]




## install

```
pip install docker-py
```

## Client API

实例化Client class,与Dokcer daemon通信

```
from docker import Client
cli = Client(base_url='unix://var/run/docker.sock')
```

params:

* base_url(str)
* version(str)

参考 ##protocol + hostname + port ## 方式

```
base_url = 'tcp://127.0.0.1:2375'
base_url = 'unix://var/run/docker.sock' 
```

## create_container


## start

params:

* contaner(str): The container to start

```
# 'ubuntu' is a container's name
c.start('ubuntu') 
```

return:

None if success

## stop

params:

* container(str): The container to start
* timeout(int): Timeout in seconds to wait for the container to shop before sending a SIGKILL

```
# 'ubuntu' is a container's name
c.stop('ubuntu') 
```

return:

None if success

## stop




[1]: https://letong.gitbooks.io/docker/content/API/python_api.html
[2]: https://docker-py.readthedocs.org/en/latest/api/
