---
title: "HTTP请求格式"
date: 2016-02-25 18:30
---

## http协议请求头格式

> 特别提醒：请求报头后面有一个“回车换行”，平常使用的时候容易忽然这一点造成问题。

```
{method} {path} {http_version}(CRLF)
{header_name}: {header_value}(CRLF)
...more header info(CRLF)
(CRLF)
{content}
```

* 格式中的变量说明

```
method: GET,POST,PUT,DELETE 等等
path: URL路径部分，如：/index.html
version：如：http/1.1
header_name: 如：Host
header_value: 如： www.eertime.com
```

## 常用请求头

* Accept

Accept请求报头域用于指定客户端接受哪些类型的信息。eg：Accept：image/gif，表明客户端希望接受GIF图象格式的资源；Accept：text/html，表明客户端希望接受html文本。

* Accept-Charset

Accept-Charset请求报头域用于指定客户端接受的字符集。eg：Accept-Charset:iso-8859-1,gb2312.如果在请求消息中没有设置这个域，缺省是任何字符集都可以接受。

* Accept-Encoding

Accept-Encoding请求报头域类似于Accept，但是它是用于指定可接受的内容编码。eg：Accept-Encoding:gzip.deflate.如果请求消息中没有设置这个域服务器假定客户端对各种内容编码都可以接受。

* Accept-Language

Accept-Language请求报头域类似于Accept，但是它是用于指定一种自然语言。eg：Accept-Language:zh-cn.如果请求消息中没有设置这个报头域，服务器假定客户端对各种语言都可以接受。

* Authorization

Authorization请求报头域主要用于证明客户端有权查看某个资源。当浏览器访问一个页面时，如果收到服务器的响应代码为401（未授权），可以发送一个包含Authorization请求报头域的请求，要求服务器对其进行验证。

* Connection

HTTP/1.1 applications that do not support persisitent connections MUST include the "close" connection option in every message

* Host（发送请求时，该报头域是必需的）

> HTTP/1.1协议中，客户端必须包含 Host 请求头

Host请求报头域主要用于指定被请求资源的Internet主机和端口号，它通常从HTTP URL中提取出来的，eg：
我们在浏览器中输入：http://www.eertime.com/index.html
浏览器发送的请求消息中，就会包含Host请求报头域，如下：
Host：www.eertime.com
此处使用缺省端口号80，若指定了端口号，则变成：Host：www.eertime.com:指定端口号 

* User-Agent

我们上网登陆论坛的时候，往往会看到一些欢迎信息，其中列出了你的操作系统的名称和版本，你所使用的浏览器的名称和版本，这往往让很多人感到很神奇，实际上，服务器应用程序就是从User-Agent这个请求报头域中获取到这些信息。User-Agent请求报头域允许客户端将它的操作系统、浏览器和其它属性告诉服务器。不过，这个报头域不是必需的，如果我们自己编写一个浏览器，不使用User-Agent请求报头域，那么服务器端就无法得知我们的信息了。

* Demo

```
GET /index.php HTTP/1.1\r\n
Host: www.eertime.com\r\n
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0\r\n
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\n
Accept-Language: zh-CN,zh;q=0.8,en-US;q=0.5,en;q=0.3\r\n
Accept-Encoding: gzip, deflate\r\n
Connection: keep-alive\r\n
Cache-Control: max-age=0\r\n
\r\n
```

