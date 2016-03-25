---
title: "cmdline"
date: 2016-03-11 14:57
---

## wget

常用命令:

需要下载某个目录下面的所有文件。

```
wget -c -r -np -k -L -p www.xxx.org/pub/path/
```

在下载时。有用到外部域名的图片或连接。如果需要同时下载就要用-H参数。

```
wget -np -nH -r --span-hosts www.xxx.org/pub/path/
```

参数：

```
-c 断点续传
-r 递归下载，下载指定网页某一目录下（包括子目录）的所有文件
-nd 递归下载时不创建一层一层的目录，把所有的文件下载到当前目录
-np 递归下载时不搜索上层目录，如wget -c -r www.xxx.org/pub/path/
没有加参数-np，就会同时下载path的上一级目录pub下的其它文件
-k 将绝对链接转为相对链接，下载整个站点后脱机浏览网页，最好加上这个参数
-L 递归时不进入其它主机，如wget -c -r www.xxx.org/ 
-p 下载网页所需的所有文件，如图片等
-A 指定要下载的文件样式列表，多个样式用逗号分隔
-i 后面跟一个文件，文件内指明要下载的URL
```

## curl 

参数

```
-X/--request [GET|POST|PUT|DELETE|…]  使用指定的http method发出 http request
-H/--header                           设定header
-i/--include                          显示response的header
-d/--data                             设定 http parameters 
-v/--verbose                          显示详细信息
-u/--user                             使用者帐号，密码
-b/--cookie                           cookie
```

* sample

```
# set header
curl -v -i -H "Content-Type: application/json" http://www.example.com/users

# post params
curl -X POST -d "param1=value1&param2=value2"
curl -X POST -d "param1=value1" -d "param2=value2"

# 存cookie
curl -i -X POST -d username=kent -d password=kent123 -c  ~/cookie.txt  http://www.rest.com/auth

# 载入cookie
curl -i --header "Accept:application/json" -X GET -b ~/cookie.txt http://www.rest.com/users/1

# HTTP Basic Authentication
curl -i --user kent:secret http://www.rest.com/api/foo'
```