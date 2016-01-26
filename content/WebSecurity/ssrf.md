---
title: "ssrf"
date: 2016-01-25 16:23
---

## common example

* get image and save

```php
<?php
if (isset($_POST['url'])){
    $content = file_get_contents($_POST['url']);
    $filename = './images/'.rand().'img.jpg';
    file_put_contents($filename, $content);
    $img = "<img src=\"".$filename."\"/>";
}
echo $img;
```

* use curl

```php
if (isset($_POST['link'])){                                                          
    $link = $_POST['link'];                                                          
    $filename = './images/'.rand().'.txt';                                                         
    $curlobj = curl_init($link);                                                                                                                
    $fp = fopen($filename, 'w');                                                     
    curl_setopt($curlobj, CURLOPT_FILE, $fp);   #output                                        
    curl_setopt($curlobj, CURLOPT_HEADER, 0);   #0:不显示响应头信息                                  
    curl_exec($curlobj);                                                             
    curl_close($curlobj);                                                            
    fclose($fp);                                                                     
    $fp = fopen($filename, 'r');                                                     
    $result = fread($fp, filesize($filename));                                       
    fclose($fp);                                                                     
    echo $result;                                                                    
} 
```

可以用来扫端口

* post: link=http:127.0.0.1:22/

output banner:

> SSH-2.0-OpenSSH_7.1p2 Debian-2 Protocol mismatch. 

* post: link=http:127.0.0.1:25/

error port ,output warning

> Warning: fread(): Length parameter must be greater than 0 in /var/www/ssrf.php on line 22

** 危害 **

* 扫描主机，端口

* 访问本地文件，或外网不可达的地址，内网弱口令多

** 防御 **

* 过滤返回信息，验证远程服务器对请求的响应是比较容易的方法。如果web应用是去获取某一种类型的文件。那么在把返回结果展示给用户之前先验证返回的信息是否符合标准。

* 统一错误信息，避免用户可以根据错误信息来判断远端服务器的端口状态。

* 限制请求的端口为http常用的端口，比如，80,443,8080,8090。

* 黑名单内网ip。避免应用被用来获取获取内网数据，攻击内网。

* 禁用不需要的协议。仅仅允许http和https请求。可以防止类似于file:///,gopher://,ftp:// 等引起的问题。