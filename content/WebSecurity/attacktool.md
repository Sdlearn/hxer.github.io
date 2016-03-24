---
title: "AttackTool"
date: 2016-01-26 18:49
---

[2]: https://github.com/lijiejie/htpwdScan
[3]: http://drops.wooyun.org/tools/1548
[5]: http://www.openwall.com/php_mt_seed/
[6]: https://github.com/pwning/public-writeup/tree/master/hitcon2015/web300-giraffes-coffee
[7]: http://www.gat3way.eu/poc/wtrt/

# Brute Force

## 字典

```
metasploit  /usr/share/metasploit-framework/data/john/wordlists/password.lst
```

## php mt_rand seed crack

tool:

* [php_mt_seed][5]

样例:

[hitcon 2015 web300][6]

mt_rand rainbow:

[mt_rand rainbow][7]

## hydra

* option

```
-R          继续从上一次进度接着破解
-S          采用SSL链接
-s <PORT>   可通过这个参数指定非默认端口
-l <LOGIN>  指定破解的用户，对特定用户破解
-L <FILE>   指定用户名字典
-p <PASS>   指定密码破解，少用，一般是采用密码字典
-P <FILE>   指定密码字典
-e <nsr>     额外可选选项，n (空密碼，即不指定密碼)， s (將帳號同時當成密碼用)，r (將帳號/密碼調換使用)
-C <FILE>   使用冒号分割格式，例如“登录名:密码”来代替-L/-P参数
-M <FILE>   指定目标列表文件一行一条
-o <FILE>   指定结果输出文件
-f          在使用-M参数以后，找到第一对登录名或者密码的时候中止破解
-t <TASKS>  同时运行的线程数，默认为16
-w <TIME>   设置最大超时的时间，单位秒，默认是30s
-v / -V     显示详细过程
-SuvVd46：是多個選項的組合，分別表示：
    S：使用SSL連線
    u：每一組密碼都用帳號輪流測試，而不是每一組帳號用密碼輪流測試。
    v V d U 是訊息的詳細度
    4 6 是 IP address 格式(IPv4 或 IPv6)
server      目标ip
service     指定服务名，支持的服务和协议：telnet ftp pop3[-ntlm] imap[-ntlm] smb smbnt http[s]-{head|get} http-{get|post}-form http-proxy cisco cisco-enable vnc ldap2 ldap3 mssql mysql oracle-listener postgres nntp socks5 rexec rlogin pcnfs snmp rsh cvs svn icq sapr3 ssh2 smtp-auth[-ntlm] pcanywhere teamspeak sip vmauthd firebird ncp afp等等
```

* use

http post form attack

```
hydra -l admin -P pass.lst -o ok.lst -t 1 -f 127.0.0.1 http-post-form “/login.php:name=^USER^&pwd=^PASS^:incorrect:H=Cookie: security=low; PHPSESSID=o7qiqd9fc1d003u9d38k64t0f4”
```

> http-post-form or http-get-form

> incorrect表示错误猜解的返回信息提示，自定义,最好和页面返回的信息一致，不要略写，不然可能产生错报，具体原因待去看源码

**:H= 表示手工设置的Header**

## htpwdScan

[github htpwdScan][2]

* install

```
cd ~/ctf
git clone https://github.com/lijiejie/htpwdScan.git
cd htpwdScan
chmod u+x
sudo ln -s ~/ctf/htpwdScan/htpwdScan.py /usr/local/bin/htpwdscan    #cofirm htpwdScan.py begin with "#!/usr/bin/env python"
htpwdscan -h    # to run
```

* use

先用 -debug 查看 request and response， after confirming, then crack 

htpwdScan.py 默认使用 htpp post method， if use get, use -get

脚本会自动替换\r \n \t等空白字符
  
**http get crack**

```
htpwdscan -f http_get.txt -d username=top_shortlist_name.txt password=10k_most_common_passwd.txt -get -err="Username and/or password incorrect"
```

> http_get.txt -- use brupsuite get http request, save to file

```
GET /dvwa/vulnerabilities/brute/?Login=Login HTTP/1.1
Host: localhost
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:43.0) Gecko/20100101 Firefox/43.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Referer: http://localhost/dvwa/vulnerabilities/brute/
Cookie: security=low; PHPSESSID=ij8gd7u55olpvsd39r0ki35cb1
Connection: close
```

http proxy check

```
htpwdscan -u=http://www.baidu.com -get -proxylist=available.txt -checkproxy -suc="百度一下"

# or check by website that to crack
htpwdscan -f=post.txt -proxylist=proxies.txt -checkproxy -suc="用户名或密码错误" 
```

## burpsuite

[乌云 Brup使用介绍][3]

检测模式

sniper  -- payload 数为1

```
----- username/password -------- sniper {%username%---表示测试变量，也就是字典值}
-----%username%/password
-----username/%password%
```

battering ram -- payload 数为1	
```
------username/password ------- battering ram 测试
------%username%=%password%
```

pitchfork

```
-----username/password ------- pitchfork 测试
```

cluster bomb

```
-------username/password ---------- cluster bomb 测试
```
## webscarab

## CeWL - Custom Word List generator

# SQL

## sqlmap


sqlmap.py -u url --dbms                 爆数据库
sqlmap.py -u url --dbms "数据库名" --table              爆数据库表
sqlmap.py -u url --dbms "数据库名" --current-db             显示当前连接数据库名
sqlmap.py -u url --dbms "数据库名" --tables  -D "表名"                   列出数据库表中的表名
sqlmap.py -u url --dbms "数据库名" --columns  -T "表名" -D "数据库名"         列出数据库名中的表名内容
sqlmap.py -u url --dbms  "数据库名"  --dump  -C "字段,字段"  -T "表名" -D "数据库表"       获取字段里面的内容

* option

```
-r <filename>
> sqlmap -r login.txt
```


txt文件

    + burpsuite 保存的文件
    
    + 自己构造
    
    ```
    POST /vuln.php HTTP/1.1
    Host: www.target.com
    User-Agent: Mozilla/4.0

    id=1
    ```

* 大量出现 unable to connect ，表明流量被WAF拦截
1 使用tamper 
2
--user-agent "Googlebot (http://www.google.com/)
--user-agent="Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20100101 Firefox/16.0"
3 设置延迟时间或线程数
--threads 线程数
--delay 延迟

# 绕过 waf 的tamper
01. apostrophemask.py        用UTF-8全角字符替换单引号字符

02. apostrophenullencode.py        用非法双字节unicode字符替换单引号字符

03. appendnullbyte.py        在payload末尾添加空字符编码

04. base64encode.py        对给定的payload全部字符使用Base64编码

05. between.py        分别用“NOT BETWEEN 0 AND #”替换大于号“>”，“BETWEEN # AND #”替换等于号“=”

06. bluecoat.py        在SQL语句之后用有效的随机空白符替换空格符，随后用“LIKE”替换等于号“=”

07. chardoubleencode.py        对给定的payload全部字符使用双重URL编码（不处理已经编码的字符）

08. charencode.py        对给定的payload全部字符使用URL编码（不处理已经编码的字符）

09. charunicodeencode.py        对给定的payload的非编码字符使用Unicode URL编码（不处理已经编码的字符）

10. concat2concatws.py        用“CONCAT_WS(MID(CHAR(0), 0, 0), A, B)”替换像“CONCAT(A, B)”的实例

11. equaltolike.py        用“LIKE”运算符替换全部等于号“=”

12. greatest.py        用“GREATEST”函数替换大于号“>”

13. halfversionedmorekeywords.py        在每个关键字之前添加MySQL注释

14. ifnull2ifisnull.py        用“IF(ISNULL(A), B, A)”替换像“IFNULL(A, B)”的实例

15. lowercase.py        用小写值替换每个关键字字符

16. modsecurityversioned.py        用注释包围完整的查询

17. modsecurityzeroversioned.py        用当中带有数字零的注释包围完整的查询

18. multiplespaces.py        在SQL关键字周围添加多个空格

19. nonrecursivereplacement.py        用representations替换预定义SQL关键字，适用于过滤器

20. overlongutf8.py        转换给定的payload当中的所有字符

21. percentage.py        在每个字符之前添加一个百分号

22. randomcase.py        随机转换每个关键字字符的大小写

23. randomcomments.py        向SQL关键字中插入随机注释

24. securesphere.py        添加经过特殊构造的字符串

25. sp_password.py        向payload末尾添加“sp_password” for automatic obfuscation from DBMS logs

26. space2comment.py        用“/**/”替换空格符

27. space2dash.py        用破折号注释符“--”其次是一个随机字符串和一个换行符替换空格符

28. space2hash.py        用磅注释符“#”其次是一个随机字符串和一个换行符替换空格符

29. space2morehash.py        用磅注释符“#”其次是一个随机字符串和一个换行符替换空格符

30. space2mssqlblank.py        用一组有效的备选字符集当中的随机空白符替换空格符

31. space2mssqlhash.py        用磅注释符“#”其次是一个换行符替换空格符

32. space2mysqlblank.py        用一组有效的备选字符集当中的随机空白符替换空格符

33. space2mysqldash.py        用破折号注释符“--”其次是一个换行符替换空格符

34. space2plus.py        用加号“+”替换空格符

35. space2randomblank.py        用一组有效的备选字符集当中的随机空白符替换空格符

36. unionalltounion.py        用“UNION SELECT”替换“UNION ALL SELECT”

37. unmagicquotes.py        用一个多字节组合%bf%27和末尾通用注释一起替换空格符

38. varnish.py        添加一个HTTP头“X-originating-IP”来绕过WAF

39. versionedkeywords.py        用MySQL注释包围每个非函数关键字

40. versionedmorekeywords.py        用MySQL注释包围每个关键字

41. xforwardedfor.py        添加一个伪造的HTTP头“X-Forwarded-For”来绕过WAF