
* 设置 mysql 新密码

1. 用空密码方式使用root用户登录 MySQL

```
mysql -u root
```
 
2. 修改root用户的密码；

```
mysql> update mysql.user set password=PASSWORD（'<new password>'） where User='root'；
mysql> flush privileges；
mysql> quit
```