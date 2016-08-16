---
title: "Log"
date: 2016-02-25 00:25
---

# logging

* logging.getLogger([name])

返回一个logger实例，如果没有指定name，返回root logger。

> 只要name相同，返回的logger实例都是同一个而且只有一个，即name和logger实例是一一对应的。这意味着，无需把logger实例在各个模块中传递。只要知道name，就能得到同一个logger实例

* Logger.setLevel(lv)

设置logger的level， level有以下几个级别：

NOTSET < DEBUG < INFO < WARNING < ERROR < CRITICAL

常用示例：

```
import logging

logging.basicConfig(level=logging.INFO, format='%(message)s')
log = logging.getLogger(__name__)

logging.basicConfig(filename="xx.log",
    level=logging.DEBUG,
    format='%(asctime)s|%(filename)s|%(funcName)s|line:%(lineno)d%(levelname)s %(message)s',
    datefmt='%Y-%m-%d %H:%M'
)
```