---
title: "note"
date: 2016-01-22 15:40
---

## `requests proxy` vs `pysocks proxy`

[pysocks](https://github.com/Anorov/PySocks)

### http proxy

pysocks 进行 http 代理时， 使用的是 HTTP CONNECT 方式， 对于不支持 `CONNECT` 方式的代理服务器，比如BurpSuite, 就无效

requests 进行 http 代理，不使用 HTTP CONNECT 方式， 兼容性更好 


## __dict__

__dict__分层存储属性。每一层的__dict__只存储该层新增的属性。子类不需要重复存储父类中的属性。

## install pip

[getpip.py][21]

```
sudo pyton getpip.py
```

## string

* printable string

```python
import string
[in]: string.printable
[out]:
'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~ \t\n\r\x0b\x0c'
```

* hack

request_file
shell
exception
thread
delay
payload

## PEP8 Python 编码规范

一 代码编排

```
1 缩进。4个空格的缩进（编辑器都可以完成此功能），不使用Tap，更不能混合使用Tap和空格。
2 每行最大长度79，换行可以使用反斜杠，最好使用圆括号。换行点要在操作符的后边敲回车。
3 类和top-level函数定义之间空两行；类中的方法定义之间空一行；函数内逻辑无关段落之间空一行；其他地方尽量不要再空行。
```

二 文档编排

```
1 模块内容的顺序：模块说明和docstring—import—globals&constants—其他定义。其中import部分，又按标准、三方和自己编写顺序依次排放，之间空一行。
2 不要在一句import中多个库，比如import os, sys不推荐。
3 如果采用from XX import XX引用库，可以省略‘module.’，都是可能出现命名冲突，这时就要采用import XX。
```

三 空格的使用

总体原则，避免不必要的空格。

```
1 各种右括号前不要加空格。
2 逗号、冒号、分号前不要加空格。
3 操作符左右各加一个空格，不要为了对齐增加空格。
4 函数默认参数使用的赋值符左右省略空格。
```

六 命名规范

总体原则，新编代码必须按下面命名风格进行，现有库的编码尽量保持风格。

```
1 尽量避免使用小写字母‘l’，大写字母‘O’等容易混淆的字母。
2 模块命名尽量短小，使用全部小写的方式，可以使用下划线。
3 包命名尽量短小，使用全部小写的方式，不可以使用下划线。
4 类的命名使用CapWords的方式，模块内部使用的类采用_CapWords的方式。
5 异常命名使用CapWords+Error后缀的方式。
6 全局变量尽量只在模块内有效，类似C语言中的static。实现方法有两种，一是__all__机制;二是前缀一个下划线。
7 函数命名使用全部小写的方式，可以使用下划线。
8 常量命名使用全部大写的方式，可以使用下划线。
9 类的属性（方法和变量）命名使用全部小写的方式，可以使用下划线。
9 类的属性有3种作用域public、non-public和subclass API，可以理解成C++中的public、private、protected，non-public属性前，前缀一条下划线。
11 类的属性若与关键字名字冲突，后缀一下划线，尽量不要使用缩略等其他方式。
12 为避免与子类属性命名冲突，在类的一些属性前，前缀两条下划线。比如：类Foo中声明__a,访问时，只能通过Foo._Foo__a，避免歧义。如果子类也叫Foo，那就无能为力了。
13 类的方法第一个参数必须是self，而静态方法第一个参数必须是cls。
```

## 正则表达式

* 编译标志(flag)

编译标志让你可以修改正则表达式的一些运行方式。在 re 模块中标志可以使用两个名字，一个是全名如 IGNORECASE，一个是缩写，一字母形式如 I。多个标志可以通过按位 OR-ing 它们来指定。如 re.I | re.M 被设置成 I 和 M 标志：

I (IGNORECASE)

使匹配对大小写不敏感；字符类和字符串匹配字母时忽略大小写。

如： [A-Z]也可以匹配小写字母，Spam 可以匹配 "Spam", "spam", 或 "spAM"。

L (LOCALE)

影响 "w, "W, "b, 和 "B，这取决于当前的本地化设置。

locales 是 C 语言库中的一项功能，是用来为需要考虑不同语言的编程提供帮助的。举个例子，如果你正在处理法文文本，你想用 "w+ 来匹配文字，但 "w 只匹配字符类 [A-Za-z]；它并不能匹配 "é" 或 "?"。如果你的系统配置适当且本地化设置为法语，那么内部的 C 函数将告诉程序 "é" 也应该被认为是一个字母。当在编译正则表达式时使用 LOCALE 标志会得到用这些 C 函数来处理 "w 後的编译对象；这会更慢，但也会象你希望的那样可以用 "w+ 来匹配法文文本。

M (MULTILINE)

使用 "^" 只匹配字符串的开始，而 $ 则只匹配字符串的结尾和直接在换行前（如果有的话）的字符串结尾。当本标志指定後， "^" 匹配字符串的开始和字符串中每行的开始。同样的， $ 元字符匹配字符串结尾和字符串中每行的结尾（直接在每个换行之前）。

S (DOTALL)

使 "." 特殊字符完全匹配任何字符，包括换行；没有这个标志， "." 匹配除了换行外的任何字符。

X (VERBOSE)

该标志通过给予你更灵活的格式以便你将正则表达式写得更易于理解。当该标志被指定时，在 RE 字符串中的空白符被忽略，除非该空白符在字符类中或在反斜杠之後；这可以让你更清晰地组织和缩进 RE。它也可以允许你将注释写入 RE，这些注释会被引擎忽略；注释用 "#"号 来标识，不过该符号不能在字符串或反斜杠之後。

## 参考链接

[ Stackoverflow上的Python问题精选][10]

[SQLMAP源码分析Part1:流程篇][20]


[10]: http://pyzh.readthedocs.org/en/latest/python-questions-on-stackoverflow.html
[20]: http://drops.wooyun.org/tips/7301
[21]: https://bootstrap.pypa.io/get-pip.py
