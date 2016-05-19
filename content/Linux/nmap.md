---
title: "nmap"
date: 2016-05-12 19:39
---

## 参数

```
-sS     TCP SYN 扫描 (又称半开放,或隐身扫描)
-P0     允许你关闭 ICMP pings.
-sV     打开系统版本检测
-O      尝试识别远程操作系统

-A      同时打开操作系统指纹和版本检测
-v      详细输出扫描情况.
```

## 常用命令

```
# 获取远程主机的系统类型及开放端口
nmap -sS -P0 -sV -O <target>
nmap -sS -P0 -A -v <target>

```