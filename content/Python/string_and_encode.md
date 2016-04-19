---
title: "string and encode"
date: 2016-01-28 11:18
---

默认 python2.7.11

二进制：    ‘0b’ 开头
八进制：    ‘0o’ 开头
十六进制：  ‘0x’ 开头

* 整数 <==> 字符串

```
hex()       hex(number) -> string       
> hex(10) ==> '0xa'

int()       int(x, base=10) -> int or long
> int('0b100', 0) ==> 4
> int('0b100', 2) ==> 4
> int('0x10', 16) ==> 16
> int('10', 16)   ==> 16

bin()       bin(number) -> string
> bin(4) ==> '0b100'

"{0:b}".format(4) ==> '100'
```

* 整数 <==> 字节串

short:2字节， long：4字节

```
import struct

struct.unpack('<HH', bytes(b'\x01\x00\x00\x00')) ==> (1,0)
struct.unpack('<L', bytes(b'\x01\x00\x00\x00'))  ==> (1,)

struct.pack('<HH', 1,2)    ==> '\x01\x00\x02\x00'
struct.pack('<LL', 1,2)    ==> '\x01\x00\x00\x00\x02\x00\x00\x00'
```
* 16进制串 <==> 字符串

```
'abc'.encode('hex')     ==> '616263'
binascii.b2a_hex('abc') ==> '616263'
binascii.hexlify('abc') ==> '616263'

'616263'.decode('hex')      ==> 'abc'
binascii.a2b_hex('616263')  ==> 'abc'
binascii.unhexlify('616263')==> 'abc'
```

* 字符串 <==> 字节串

```

```

* unicode
    
\\u 后面是十六进制的Unicode码

    + prefix u
    
    u‘中文’ ==> u'\u4e2d\u6587'
    
    + unicode 强制转换
    
    要求 python文件中指定了对应的编码类型；并且对应的python文件的确是以该编码方式保存的

```
# -*- coding: utf-8 -*-

import sys

reload(sys)
sys.setdefaultencoding("utf-8")

s = unicode('中文')

>>> u'\u4e2d\u6587'
```

* unicode <==> string

unicode ==> string : encode

string  ==> unicode: decode


## base64

* characters set

```
ABCDEFGHIJKLMNOP
QRSTUVWXYZabcdef
ghijklmnopqrstuv
wxyz0123456789+/
```

******

# python3


字符串转字节串:

```
字符串编码为字节码: '12abc'.encode('ascii')  ==>  b'12abc'
数字或字符数组: bytes([1,2, ord('1'),ord('2')])  ==>  b'\x01\x0212'
16进制字符串: bytes().fromhex('010210')  ==>  b'\x01\x02\x10'
16进制字符串: bytes(map(ord, '\x01\x02\x31\x32'))  ==>  b'\x01\x0212'
16进制数组: bytes([0x01,0x02,0x31,0x32])  ==>  b'\x01\x0212'
```

字节串转字符串:

```
字节码解码为字符串: bytes(b'\x31\x32\x61\x62').decode('ascii')  ==>  12ab
字节串转16进制表示,夹带ascii: str(bytes(b'\x01\x0212'))[2:-1]  ==>  \x01\x0212
字节串转16进制表示,固定两个字符表示: str(binascii.b2a_hex(b'\x01\x0212'))[2:-1]  ==>  01023132
字节串转16进制数组: [hex(x) for x in bytes(b'\x01\x0212')]  ==>  ['0x1', '0x2', '0x31', '0x32']
```