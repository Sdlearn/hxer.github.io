---
title: "mysql"
date: 2016-04-09 11:23
---

## basic operation

### create user

[create user][1]

```
Create Users	CREATE USER test1 IDENTIFIED BY ‘pass1′; — priv
Delete Users	DROP USER test1; — priv
```

## basic database



### mysql

#### user

设置了MySQL中数据库用户的部分信息。

* user字段为用户登陆名，可以有相同的名字重复
* password字段为登陆密码哈希，是40位的密文，类似于md5
* host字段设置的是这个用户可以在哪些机器上登陆，localhost表示只能是本机登陆，host可以是数据库ip也可以是数据库服务器的名称，例如“mysqldbserver”之类。
* file_priv字段规定了这个用户是不是可以读取硬盘里面的文件，设置为Y则表示允许，设置为N则表示禁止。


### information_schema

#### USER_PRIVILEGES

The USER_PRIVILEGES table provides information about global privileges. This information comes from the mysql.user grant table.

* privilege_type    FILE--是否有读mysql.user表的权限

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

[1]: http://dev.mysql.com/doc/refman/5.7/en/create-user.html