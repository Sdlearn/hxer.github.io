---
title: "Note"
date: 2016-01-26 18:49
---


[win10 ubuntu双系统][1]

[1]: http://support.lenovo.com.cn/lenovo/wsi/htmls/detail_20151111145810868.html

## URL shortening

URL shortening，即短地址，把URL变短，服务器通过查询短地址，提供302跳转到目的地址。

长短地址之间映射的方法有很多：MD5抽样，唯一ID+BASE62。

+ 唯一ID+BASE62

Python有现成类库两枚，short_url (不带DB，只有ID<->base62，有生成最小位数参数，DB自选，一般选择NoSQL)，
另一个是shorten (可存储到redis或Memory)。