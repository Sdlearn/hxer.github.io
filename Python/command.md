---
title: "命令执行"
date: 2016-06-27 14:51
---

## 0x01 os

### os.system()

> 不返回shell命令的输出

```
In [28]: os.system('ls')
tmp
Out[28]: 0
```

### os.popen()

> 返回输出结果

```
>>>tmp = os.popen('ls *.sh').readlines()  
>>>tmp  
['install_zabbix.sh\n', 'manage_deploy.sh\n', 'mysql_setup.sh\n', 'python_manage_deploy.sh\n', 'setup.sh\n'] 
```

## 0x02 commands

可以很方便的取得命令的输出（包括标准和错误输出）和执行状态位

### commands.getstatusoutput(cmd)   

返回（status,output)

```
import commands
a,b = commands.getstatusoutput('ls')
a是退出状态
b是输出的结果。
>>> import commands
>>> a,b = commands.getstatusoutput('ls')
>>> print a
0
>>> print b
anaconda-ks.cfg
install.log
install.log.syslog
```

### commands.getoutput(cmd)        

只返回输出结果

## 0x03 subprocess

可以创建新的进程，可以与新建进程的输入/输出/错误管道连通，并可以获得新建进程执行的返回状态. `使用subprocess模块的目的是替代os.system()、os.popen*()、commands.*等旧的函数或模块。`

注意： 当执行命令的参数或者返回中包含了中文文字，那么建议使用subprocess，如果使用os.popen则会出现错误

### subprocess.call(command, shell=True)

> 直接打印出结果, 如果command不是一个可执行文件，shell=True是不可省略的

### subprocess.Popen(command, shell=True) 

> 如果command不是一个可执行文件，shell=True是不可省略的

`subprocess.Popen(command, stdout=subprocess.PIPE, shell=True)` 这样可以输出结果
 
``` 
import subprocess  
p = subprocess.Popen('ls *.sh', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)  
print p.stdout.readlines()  
for line in p.stdout.readlines():  
    print line,  
retval = p.wait()  
```






