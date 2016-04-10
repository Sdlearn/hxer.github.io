---
title: "mysql"
date: 2016-04-09 11:23
---

## information

* 查看表结构

```
show columns from table_name;

desc table_name;
```

使用MySQL数据库desc 表名时，Key那一栏，可能会有4种值，即 ' '，'PRI'，'UNI'，'MUL'。

如果Key是空的，那么该列值的可以重复，表示该列没有索引，或者是一个非唯一的复合索引的非前导列；

如果Key是PRI，那么该列是主键的组成部分；

如果Key是UNI，那么该列是一个唯一值索引的第一列（前导列），并别不能含有空值（NULL）；

如果Key是MUL，那么该列的值可以重复，该列是一个非唯一索引的前导列（第一列）或者是一个唯一性索引的组成部分但是可以含有空值NULL。

如果对于一个列的定义，同时满足上述4种情况的多种，比如一个列既是PRI，又是UNI，那么"desc 表名"的时候，显示的Key值按照优先级来显示 PRI->UNI->MUL。那么此时，显示PRI

## 导出文本文件

```
SELECT … INTO OUTFILE ‘file_name’
```

SELECT 把被选择的行写入一个文件中。该文件被创建到服务器主机上，因此必须拥有FILE权限。